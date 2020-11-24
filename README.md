![Swift Logo](https://raw.githubusercontent.com/ARISENIO/arisen-swift/master/img/swift-logo.png)
# Arisen SDK For Swift
Arisen's Swift SDK is an API for integrating with Arisen-based blockchains using the Arisen RPC API. For a high-level introduction to our Swift and Java SDKs, please refer to our official release notes [here](https://medium.com/arisencoin/native-sdks-for-swift-and-java). To date, Arisen's Swift SDK has only been tested on iOS. Although, we hope for the core library to run anywhere that Swift runs, by expanding Arisen's Swift SDK to be compatible with other targets (macOS, watchOS and tvOS) as this library matures.

***All product and company names are trademarks or registered trademarks of their respective holders. Use of them does not imply any affiliation with or endorsement by them.***

## Table Of Contents
[Installation](#installation)
[Basic Usage](#basic-usage)
[iOS Example App](#ios-example-app)
[Documentation](#documentation)
[Provider Protocol Architecture](#provider-protocol-architecture)
[Using The Default RPC Provider](#using-the-default-rpc-provider)
[Want to help?](#want-to-help)
[License](#license)
[Legal](#legal)

## Installation
### Prerequisites
- Xcode 10 or higher
- CocoaPods 1.5.3 or higher
- For iOS, iOS 11+*

** *Note: ABIRSN Serialization Provider requires iOS 12+ at the moment **

### Instructions
To use Arisen's Swift SDK in your app, add the following pods to your Podfile:

```
use_frameworks!
target "Your Target" do
   pod "ArisenSwift", "~> 0.1.3" #pod for this library
   # Providers For Arisen's Swift SDK
   pod "ArisenSwiftAbirsnSerializationProvider", "~> 0.1.3"
   pod "ArisenSwiftSoftkeySignatureProvider", "~> 0.1.3"
end
```

Then run ```pod install``` and you're all set for the [Basic Usage](#basic-usage) example.

## Basic Usage
### Working With Transactions
Transactions are instantiated as an ```ArisenTransaction``` and must then be configured with a number of providers prior to use. (See [Provider Protocol Architecture](#provider-protocol-architecture) below for more information about providers).

```
import ArisenSwift
import ArisenSwiftAbirsnSerializationProvider
import ArisenSwiftSoftkeySignatureProvider
```

Then, inside a ```do...catch``` or throwing function, do the following:

```
let transaction = ArisenTransaction()
transaction.rpcProvider = ArisenRpcProvider(endpoint: URL(string: "http://localhost"))
transaction.serializationProvider = ArisenAbirsnSerializationProvider()
transaction.signatureProvider = try ArisenSoftkeySignatureProvider(privateKey: "key"))

let action = try ArisenTransaction.Action(
     account: ArisenName("arisen.token"),
     name: ArisenName("transfer"),
     authorization: [ArisenTransaction.Action.Authorization(
            actor: ArisenName("useraaaaaa"),
            permission: ArisenName("active"))
     ],
     data: Transfer(
            from: ArisenName("useraaaaaa"),
            to: ArisenName("useraaaaab"),
            quantity: "42.0000 RIX",
            memo: "")
)

transaction.add(action: action)

transaction.signAndBroadcast { (result) in
      switch result {
      case .failure (let error):
            // Handle error.
      case .success: 
            // Handle success.

      }
}
```

### Arisen Transaction Factory
Alternatively, to avoid having to set the providers on every transaction, you can use the ```ArisenTransactionFactory``` convenience class, as follows:

```
let rpcProvider = ArisenRpcProvider(endpoint: URL(string: "http://localhost:12516"))
let signatureProvider = try ArisenSoftkeySignatureProvider(privateKeys: ["your-RSN-private-key"])
let serializationProvider = ArisenAbirsnSerializationProvider()

let myTestnet = ArisenTransactionFactory(rpcProvider: rpcProvider, signatureProvider: signatureProvider)

let transaction = myTestnet.newTransaction()
// add actions, sign and broadcast

let anotherTransaction = myTestnet.newTransaction()
// add actions, sign and broadcast
...
```

### Usage With PromiseKit
Most ```ArisenTransaction``` and RPC endpoint methods will return Promises if you ask them. Simply call the method with ```.promise``` as the first parameter and drop the callback. For example:

```
firstly {
     transaction.signAndBroadcast(.promise)
}.done { _ in
      // Handle success.
}.catch { error in
     // Handle error.
}
```

### Key Management and Signing Utilities
Utilities for key generation and management and other signing functionality can be found in the Arisen SDK for Swift: Vault library.

## iOS Example App
If you'd like to see Arisen's Swift SDK in action, check out our open source [iOS Example App](https://github.com/arisenio/arisen-swift-ios-example-app), which is a working application for fetching an Arisen account's RSN balance and pushes a transfer action.

## Documentation
Please refer to the official documentation for Arisen's Swift SDK, [here](https://swift.arisen.network) or by cloning this repository and opening the ```docs/index.html``` file in our browser. All of this documentation is automatically generated.

## Provider Protocol Architecture
The core Arisen Swift SDK library uses a provider-protocol-driven architecture to provide maximum flexibility in a variety of environments and use cases. ```ArisenTransaction``` leverages those providers to prepare and process transactions. Arisen's Swift SDK exposes four protocols. Developers make the ultimate choice on which conforming implementations to use. 

### Signature Provider Protocol 
The Signature Provider abstraction is arguably the most useful of all the providers. It is responsible for a) finding out what keys are available for signing and b) requesting and obtaining transaction signatures with a subset of the available keys.  By simply switching out the signature provider on a transaction, signature requests can be routed any number of ways. Need a signature from keys in a platform's Keychain or Secure Enclave? Configure ```ArisenTransaction``` with the Arisen's Swift SDK Vault Signature Provider (https://github.com/arisenio/arisen-swift-vault) . Need signatures from a wallet on a user's device? A signature provider can do that too. Arisen's Swift SDK ***does not include***  a signature provider implementation; one must be installed separately. All signature providers must conform to the ```ArisenSignatureProviderProtocol```.

Please consider one of the following Signature providers:

- ```Vault Signature Provider``` - Signature provider implementation for signing transactions using keys stored in the Keychain or the device's Secure Enclave.
- ```Softkey Signature Provider``` - Example signature provider for signing transactions using K1 keys in memory (https://github.com/arisenio/arisen-swift-softkey-signature-provider). ***This signature provider stores keys in memory and is therefore not secure. It should only be used for development purposes. In production, we strongly recommend using a signature provider that interfaces with a secure vault, authenticator or wallet.***
- ```PeepsID iOS Authenticator``` - Native iOS Apps using the signature provider are able to integrate with the [PeepsID iOS Authenticator App](https://github.com/peepsx/peepsid-ios), allowing their users to sign in and approve transactions via the authenticator application.

### RPC Provider Protocol
The RPC Provider is responsible for all RPC calls to aOS (ArisenOS), as well as general network handling (Reachability, retry logic , etc.). While Arisen's Swift SDK includes an RPC Provider Implementation, it must still be set explicitly when creating an ```ArisenTransaction```, as it must be instantiated with an endpoint. (The default implementation suffices for most use cases.)

Please consider the following RPC providers:
- ```ArisenRpcSignatureProtocol``` - All RPC providers must conform to this protocol (https://swift.arisen.network/Protocols/ArisenSignatureProviderProtocol.html).
- ```ArisenRpcProvider``` - Default Implementation - Default RPC provider implementation included in Arisen's Swift SDK (https://swift.arisen.network/Classes/ArisenRpcProvider.html).
- ```[aOS RPC Reference Documentation](https://docs.arisen.network/docs/aos-rpc-api-reference)``` - aOS RPC Reference.

### Serialization Provider Protocol
The Serialization Provider is responsible for ABI-driven transaction and action serialization and deserialization between JSON and binary data representations. These implementations often contain platform-sensitive C++ code and larger dependencies. For those reasons, Arisen's Swift SDK ***does not include*** a serialization provider implementation; one must be installed separately.

Please consider the following Serialization providers:
- ```ArisenSerializationProviderProtocol``` - All serialization providers must conform to this protocol (https://swift.arisen.network/Protocols/ArisenSerializationProviderProtocol.html).
- ```ABIRSN Serialization Provider Implementation``` - Serialization/deserialization using ABIRSN. Currently supports iOS 12+ (https://swift.arisen.network/Protocols/ArisenAbiProviderProtocol.html).

### ABI Provider Protocol 
The ABI Provider is responsible for fetching an caching ABIs for use during serialization and deserialization. If none is explicitly set on the ```ArisenTransaction```, the default ```ArisenAbiProvider``` will be used. (The default implementation suffices for most use cases.).

Please consider the following ABI providers"
- ```ArisenAbiProviderProtocol``` - All ABI providers must conform to this protocol (https://swift.arisen.network/Protocols/ArisenAbiProviderProtocol.html).
- ```ArisenAbiProvider``` - Default implementation - Default ABI provider implementation in Arisen's Swift SDK (https://swift.arisen.network/Classes/ArisenAbiProvider.html).

## Using The Default RPC Provider
Arisen's Swift SDK includes a default RPC Provider implementation (```ArisenRpcProvider```) for communicating with Arisen nodes using the [Arisen RPC API](https://api.arisen.network). Alternate RPC providers can be used assuming they conform to the minimal ```ArisenRpcProviderProtocol```. The core Arisen Swift SDK library depends only on the five RPC endpoints set forth in that Protocol. Other endpoints, however, are exposed in the default ```ArisenRpcProvider```.

Calls can be made to any of the available endpoints as follows:

```
rpcProvider.getInfo { (infoResponse) in
       switch infoResponse {
       case .failure (let error):
             // handle the error
        }
       case .success (let info) {
             // do stuff with the info
             print(info.chainId)
       }
}
```

Attempts are made to marshal the responses into convenient Swift structs. More deeply nested response properties may be presented as a dictionary. Each response struct will also contain a ```_rawResponse``` property. In the event the returned struct is missing a property you were expecting from the response, inspect the ```_rawResponse```. You will likely find it there. Response structs for the alpha release are incomplete. Some responses will only return the ```_rawResponse```. We aim to continue improving response marshalling. And we invite you to [help us improve](CONTRIBUTE.md) responses too. 

## Want to help?
If you're interested in contributing to Arisen's Swift SDK, here are some [Contributing Guidelines](CONTRIBUTE.md) and our [Code of Conduct](CODE-OF-CONDUCT.md). 

## License
[MIT](LICENSE.md)

(C) 2019 Block.One
(C) 2020 Arisen Foundation
(C) 2020 PeepsLabs

The original Swift SDK for Arisen, was developed by ```blockone-devops``` and has since been adopted by the Arisen Foundation, as well as the Arisen community. Arisen Foundation has no affiliation, whatsoever to Block.One.

## Legal
See LICENSE for copyright and license terms. The Arisen Foundation and PeepsLabs makes their contribution on a voluntary basis, as a member of the Arisen community and is not responsible for ensuring the overall performance of the software or any related applications. We make no representation, warranty, guarantee or undertaking in respect of the software or any related documentation, whether expressed or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no even shall we be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or documentation or the use or other dealings in the software or documentation. Any test results or performance figures are indicative and will not reflect performance under all conditions. Any reference to any third part or third-party product, service or other resource is not an endorsement or recommendation by Arisen Foundation or Satoshi Las. We are not responsible, and disclaim any and all responsibility and liability, for your use of or reliance on any of these resources. Third-party resources may be updated, changed, or terminated at any time, so the information here may be out of date or inaccurate.  Any person using or offering this software in connection with providing software, goods or services to third parties shall advise such third parties of these license terms, disclaimers and exclusions of liability.
