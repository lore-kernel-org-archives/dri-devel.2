Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF38CC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC1A10E195;
	Mon,  6 Jul 2026 17:35:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQ6nAQyh";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C118210E195
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 17:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOhHkNOVvz5M45k77bxLNC3leTgUBqrRjcdt0i6bxmq1w+IEGEZjzGv1Bgk9pA6BZzpVZKmKdLfnRd2cazY2JPQjOZetMOsCrBPUh5LmzdSQNXjnHyKpF6R18JxoxDA0KecIrrAx/qwJSpTxHCyPzA/Xy1Qsbn0glbl860pg8fCfEUA6Lv8sS+FDMN3prNewsTp6C+0wGe6XO+a8RiErQCGW5in7aKWYPN/9Uajey0+Ne9D4QmB5hzGn7Za/zdPL2npui8PgAD59ddro6CoeWGIgU8GH12kOLWh9UECvEfhOKprj9ZG7A6BdbsGx5DQxoHBkKiEwAxq7uYi2L6ZBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNr0aR9svGiVH2boen29jtHLgUtDFcSfRS86N391jiM=;
 b=Q+sBrRpzvWTobWeUr5O32C+j13/q5CRGuBMI7G2XdKXqNuOCY+p29yfrYYmq7xRRmc8xwHkEQMdN1TAgtbZIH4MqkZOoL5MzZP6LqcXeTlSF/SgqPo3LFs17krFMBT0hoLJueez4bEmY4yE09yA7f3EXcdtvR/+Mk8Fh3i8FK4SAduzyx/ED7GAcbgatT3e1jXCrG27yrLO447ry32WnhSjf/ob1cW5S+lvsz0UqVxfHICshy0HUmFRgDkvOBvWfVbsVTzd8e3aKZ084VmFXFSAox3EYRsFe9ar03BNy7XqDNxJ8OWIwbhCm8vYB57rRHU9Mo+wsyoE6HvxiD6Yibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNr0aR9svGiVH2boen29jtHLgUtDFcSfRS86N391jiM=;
 b=lQ6nAQyhbTp6SBBm+ClsqzW+K7i5FpFBUIU6k39DnIFpbvhCZ4jzYMZ/RVeXG5O+NoSJwU6oQ2eqgLwK9my2PnDxV51yv4BB2BkIl8NeK7HaXiEUAVr/HIT6ob6pB8LzmJPNC8dNxr+tFtWNrEq+Adic7srdWGTNdmmxtFdqL3Rj5BpckgfBrkMwWdb/eprnzdjTeRFTtI+QRR9Z0Eqk0agzoHbmGqjYIJs83xOL+yCYzDXFxinYlsH3dYXP3XSAaoXJ+0OSM8BjBmH7Bp1TLJMVHE/ANbQx5PvcR6OsBHj3/5PKYiIJzJON+anzCBvox7ATaBdF4eyzilCHGSmrXQ==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 17:35:37 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 17:35:35 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>, "nova-gpu@lists.linux.dev"
 <nova-gpu@lists.linux.dev>
CC: John Hubbard <jhubbard@nvidia.com>, "gary@garyguo.net" <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, "lossin@kernel.org"
 <lossin@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dakr@kernel.org" <dakr@kernel.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "aliceryhl@google.com"
 <aliceryhl@google.com>, Alexandre Courbot <acourbot@nvidia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] drm: nova: Add GETPARAM parameter to read the GPU
 chipset
Thread-Topic: [PATCH 3/4] drm: nova: Add GETPARAM parameter to read the GPU
 chipset
Thread-Index: AQHdDQk72tJo8t7eAESFa5xrPAgrl7ZgwaAA
Date: Mon, 6 Jul 2026 17:35:35 +0000
Message-ID: <59948bff927bd4ad3af5fbe68d5d5e7565c5f729.camel@nvidia.com>
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-4-apopple@nvidia.com>
In-Reply-To: <20260706053413.154135-4-apopple@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|MW4PR12MB7285:EE_
x-ms-office365-filtering-correlation-id: 628c0e6b-70b4-4dd2-a811-08dedb84fc88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: +yvt/MJCanB7Gn56TGAmo33fIIMAVyb1FXUQZ0rTwMkiESzItJSSXBXcnFfOiiVusj9CM+DFA17yu/c+HZjAdeqJdmFi0US2bHTtnumEYoG7r7q94RSweKMr7sL/i0vOtzoKtAQgN/mjY6aWaVTdxbVHJw0Kt76zY8FcO9OvxO3IHs3rIbQGB9kRB1hhOQ2NjWcXyaLTU4wq12IMPrsYMXuOvQFFj7y4RSPLrwfdcZ73vFgipJCPIYnAaavNtNbL1/FHb8DauAO0GKAPGsC8p+h7iGhWTVtKx/Lg6Pc+VnbwbZQrCjRMtC7ASCpuzEpWNNv6Lgd3J9B3hevi5le6mSZ2ui38Mhei9MEH8ajrQ6qpS/drzaOsVueU+6yJ21skJ2IMJMStKFiW7l8yquSKSRoQl1ZOmnvSPIYc7uR3TVmegiLB0TkA/RXV8NS2Nd+6MZFn6bq8GtQACvlNQVd72gRsFd8tyH7ynCVjqsNDF6M+kVKQBoV/NFUU+4BCwKWGmCVdtffA4/t96kNI5G9K6gF9FeDbQcwVih5SBH/RWwtEt2B2euJZBoss92mm3Yv+3gEJaSC4WJhCZ2uZrhZ0qRA6uZRQeNnnwhlFOXBPcqOvXtz+ckXbrHTnh2GME2Xb8LgfPWSgrxF1r+pcieXXvygleJIEugzntb9p6czKvA2KWOYkt46LF2mCD1VK5UwwhqEzg61ZyMbpvE/zSJSPJPpjYoDTpU3l2V7ulgrgIg0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elpLMGNRaE1rTXBhWEFCcFJaMjRSZG1oSEdRQUJLSTYvaEJsdXp2NG9LVnpn?=
 =?utf-8?B?NDYwcmVUcFRWZGNCTmdPS3dEYzVLVm01cGZLeUUxVUY3aVJrSTFWTnY0Zyta?=
 =?utf-8?B?MkZHa2JBa0VGTCtXTXdJN3lEZ2NvODFkQXNFM1dvL0FLZVpvYVpGOGl3bWJM?=
 =?utf-8?B?ZEF5Mk1WN0VpV0k0YkdIYVlIdWJFSlovSlovYURueVFwcXZCTThRZTdMTlVt?=
 =?utf-8?B?TkJkenRLRmQzOFR0L3p6Zk5IcXBIa0dDNG5BU1lXZVNsYnExMjVDQjdQQWVR?=
 =?utf-8?B?d2xtYlhjQjBCL1E1YnI2MS9WUUYzM0gzV21Nejhlb0Ezajg0NHd1ajh0LzY2?=
 =?utf-8?B?MFVDTVBEQ3J1cE45bU1iWFA0dXZvWkVQWVg3bnlnQUZEZGhBVlVHbkxZSk8x?=
 =?utf-8?B?Y0ZjZkFvZ1kyRWNuUlNQY25TUllEWnU5eGV1YmRvQ3pjOEg3OHRtNlJsV3N1?=
 =?utf-8?B?aks0M1JFZExFd2l4M3JPdDVSMUpSV0orSG96aVIzcWgydHQwNXBQUzB2a0h0?=
 =?utf-8?B?NGQ0ZEV0SzFYYkFmU1orRmtMTHdZNHdIVzViV0JyM1MvblRRU2dBRDRpMVVj?=
 =?utf-8?B?ZDlFZkFQaVFsVVhJMTB4NGNIVlFxNm1KM1NLR1BxUThzM2FoUVdyRUN6WlBH?=
 =?utf-8?B?azRXbzZ1Z2twTlRFQzZ6NEY2NFk3SHkwR2g3WEV4MEw2WDRsSVNCMlpBcUR4?=
 =?utf-8?B?d0dWUU5CREV3Zm1BVW5uNnpkdEJhN1FCZy9KQ1pMM2hZZ3pTR0dQUHFmWEtU?=
 =?utf-8?B?c1BTamdWbURHSG1mcGFGQmJuYm5sT0hGdkM1QVk4ZzNJanlDb243bjl5ZjVL?=
 =?utf-8?B?L3g5L09BcUgwVTl5MUxIZjN0QjB0MDdQYlpUUW13SkdRN2U3WnZ6QlM2cDEz?=
 =?utf-8?B?eHpraWt1UndDbDlqOEFXSUQ1NHlqMm9kVVVUY3Zha2JpcWtCb0JlYUV1eEc1?=
 =?utf-8?B?bWpmaTlEclcyR3ZhbmY1R0tZRG1ncDJEWFJXaTZxQlJrYlVYdmRYdGZSajNU?=
 =?utf-8?B?T1ZOZDNGVXJzNG04K3JYRSsraUROd1kvd3hkclRMRUpydE4vNHQ4bDZ3a2hR?=
 =?utf-8?B?NWxjdTZoem8vOWY2cXpFRklPMTQwVWdNZXRZdDlzUldaam9henNJQ1VZYi8y?=
 =?utf-8?B?U1RYTFlyU2ZUMVpmRkQwTTdvT0E0N1RUOXZyUEd3K0hqUVI1UUFIQVpjcndz?=
 =?utf-8?B?NExLUmlDbVlYK0JRbHhSa0ljQUlNYkVkQVYxTk40bjhaTnh5UVFRV1g5YWNF?=
 =?utf-8?B?bXQybXpERWNsMm1qS1hiclRkeDBOM01aMzE1Nkc4VE5aWGp3T1YzdDh3VndI?=
 =?utf-8?B?Y0x0UDQza0p2Nk9uRWV4dmY5M3JMZG5LV1AvYjlFT2todmpVcmllOG9ZNDBD?=
 =?utf-8?B?RmJnQVg0S1JTRlFGVHBqcFE4WnNNU1dCc05xNGhNanFkNTBRMkhCa2gwdDNn?=
 =?utf-8?B?ckE4NDk1cjJTZmhnNXp2UHU0SDNGTkUwaTRiZGdlazRxSWFyVFd2MXBoQ0Fz?=
 =?utf-8?B?Y0ZucjZxYjd4SUVuY0xWU0hiT29HYS9HOVkyWTcxbjBKMEZrLzNWQzRoOHR6?=
 =?utf-8?B?YzlPRDdtMlNtM0JhWlNKcFZ6ekd0azV5ZU1yd3BYRkFxZFBMdFNGL1dJajlC?=
 =?utf-8?B?OEhkbUhHMUxkeXVma1B5MFYvYTFwYTdVendHS2NHaWJ0WTNGTFVWUGpiLzEx?=
 =?utf-8?B?cEpHQTdsRnRhNWpOUCtReTZJZzhlNGplVEVlOTBjbWp2cGwranN2RXIyajhl?=
 =?utf-8?B?WGdBZ0QvZ3loUnIrL292TDNtZzJ2OWgzbFFmUllpckdRTExmTkFIUlJDQkNN?=
 =?utf-8?B?eGJQN0ZaNE5HMXM0TGQxM0tiNkMrUzJsVzJHMEt4Z1p6aExVSTMrTCtzTjZ1?=
 =?utf-8?B?c0xRTkdTbVhhT2J4S2N1MjF4RytLQ0t1LzRBTG9mREVFc1FYYVRGdFB4MWdO?=
 =?utf-8?B?cnFqWERsWUI2NWxoR1JLMEluSWV4TVZaR3J1cXZ4QTNyc2swaDdRd041V2Qv?=
 =?utf-8?B?eGxza0F0OXpzT0RHaVd3TEhSMU1vOEFVaU5lWXl2ZkZTMXRXeUt4WmJ2L21J?=
 =?utf-8?B?REJCT2RsWDJYUVhQbHV0eDBhTHEvT25NY2dJTHgzbmJWeDZsQTdNSDYyeHN0?=
 =?utf-8?B?U1gvN3EwenRudkpMMG83a0x6MkRXZkFtYVIzS0dSRXFTWjdxUkwxNExxMnFi?=
 =?utf-8?B?ZFVVM21MZnRjZ2U2bUJRWmx0ekFZTlBwZVg1RlQzc215ck41K0RFeTZ6U09J?=
 =?utf-8?B?bWpBZE8wRkVTWHhTTGFZTmlpWERXaS9BeVdHM05iQkdmRjg4R3lGaWluWGpV?=
 =?utf-8?B?OHhtdm50dlBabldocFpNZlByeEpET0VkTERvNXVBc1pPdXpKSlV5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E72B86938829614BAD5814F09C0948D7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628c0e6b-70b4-4dd2-a811-08dedb84fc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 17:35:35.1310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+MFxv9jBRv4CdPQtulRhUuGYAOb/AtEbrmX6OmhO3Fvh0ePYHAEGZXCDIl/cPVsYEBG79U1Q8IKdRJd6vbBuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDE1OjM0ICsxMDAwLCBBbGlzdGFpciBQb3BwbGUgd3JvdGU6
DQo+IEBAIC0zOCw2ICszOCw3IEBAIHB1YihjcmF0ZSkgZm4gZ2V0X3BhcmFtKA0KPiDCoA0KPiDC
oMKgwqDCoMKgwqDCoMKgIGxldCB2YWx1ZSA9IG1hdGNoIGdldHBhcmFtLnBhcmFtIGFzIHUzMiB7
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1YXBpOjpOT1ZBX0dFVFBBUkFNX1ZSQU1fQkFS
X1NJWkUgPT4gcGRldi5yZXNvdXJjZV9sZW4oMSk/LA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1YXBpOjpOT1ZBX0dFVFBBUkFNX0dQVV9DSElQU0VUID0+IHJlZ19kYXRhLmFwaS5jaGlwc2V0
KCkgYXMgdTY0LA0KDQpDYW4gd2UgYXNzaWduIHRoZXNlIElPQ3RsIHZhbHVlcyB0byBtYXRjaCBO
b3V2ZWF1IGFzIG11Y2ggYXMgcG9zc2libGU/ICBJIHRoaW5rIGl0IHdvdWxkIG1ha2UNCmV2ZXJ5
b25lJ3MgbGlmZSBlYXNpZXIgaWYgd2UgY291bGQgdXNlIHRoZSBzYW1lIHVzZXItc3BhY2UgdG9v
bHMvbGlicmFyaWVzIGZvciBOb3ZhIHRoYXQgd2UgZG8gZm9yDQpOb3V2ZWF1Lg0KDQojZGVmaW5l
IERSTV9OT1VWRUFVX0dFVFBBUkFNICAgICAgICAgICAweDAwDQojZGVmaW5lIERSTV9OT1VWRUFV
X1NFVFBBUkFNICAgICAgICAgICAweDAxIC8qIGRlcHJlY2F0ZWQgKi8NCiNkZWZpbmUgRFJNX05P
VVZFQVVfQ0hBTk5FTF9BTExPQyAgICAgIDB4MDINCiNkZWZpbmUgRFJNX05PVVZFQVVfQ0hBTk5F
TF9GUkVFICAgICAgIDB4MDMNCiNkZWZpbmUgRFJNX05PVVZFQVVfR1JPQkpfQUxMT0MgICAgICAg
IDB4MDQgLyogZGVwcmVjYXRlZCAqLw0KI2RlZmluZSBEUk1fTk9VVkVBVV9OT1RJRklFUk9CSl9B
TExPQyAgMHgwNSAvKiBkZXByZWNhdGVkICovDQojZGVmaW5lIERSTV9OT1VWRUFVX0dQVU9CSl9G
UkVFICAgICAgICAweDA2IC8qIGRlcHJlY2F0ZWQgKi8NCiNkZWZpbmUgRFJNX05PVVZFQVVfTlZJ
RiAgICAgICAgICAgICAgIDB4MDcNCiNkZWZpbmUgRFJNX05PVVZFQVVfU1ZNX0lOSVQgICAgICAg
ICAgIDB4MDgNCiNkZWZpbmUgRFJNX05PVVZFQVVfU1ZNX0JJTkQgICAgICAgICAgIDB4MDkNCiNk
ZWZpbmUgRFJNX05PVVZFQVVfVk1fSU5JVCAgICAgICAgICAgIDB4MTANCiNkZWZpbmUgRFJNX05P
VVZFQVVfVk1fQklORCAgICAgICAgICAgIDB4MTENCiNkZWZpbmUgRFJNX05PVVZFQVVfRVhFQyAg
ICAgICAgICAgICAgIDB4MTINCiNkZWZpbmUgRFJNX05PVVZFQVVfR0VUX1pDVUxMX0lORk8gICAg
IDB4MTMNCiNkZWZpbmUgRFJNX05PVVZFQVVfR0VNX05FVyAgICAgICAgICAgIDB4NDANCiNkZWZp
bmUgRFJNX05PVVZFQVVfR0VNX1BVU0hCVUYgICAgICAgIDB4NDENCiNkZWZpbmUgRFJNX05PVVZF
QVVfR0VNX0NQVV9QUkVQICAgICAgIDB4NDINCiNkZWZpbmUgRFJNX05PVVZFQVVfR0VNX0NQVV9G
SU5JICAgICAgIDB4NDMNCiNkZWZpbmUgRFJNX05PVVZFQVVfR0VNX0lORk8gICAgICAgICAgIDB4
NDQNCg0KDQojZGVmaW5lIE5PVVZFQVVfR0VUUEFSQU1fUENJX1ZFTkRPUiAgICAgIDMNCiNkZWZp
bmUgTk9VVkVBVV9HRVRQQVJBTV9QQ0lfREVWSUNFICAgICAgNA0KI2RlZmluZSBOT1VWRUFVX0dF
VFBBUkFNX0JVU19UWVBFICAgICAgICA1DQojZGVmaW5lIE5PVVZFQVVfR0VUUEFSQU1fRkJfU0la
RSAgICAgICAgIDgNCiNkZWZpbmUgTk9VVkVBVV9HRVRQQVJBTV9BR1BfU0laRSAgICAgICAgOQ0K
I2RlZmluZSBOT1VWRUFVX0dFVFBBUkFNX0NISVBTRVRfSUQgICAgICAxMQ0KI2RlZmluZSBOT1VW
RUFVX0dFVFBBUkFNX1ZNX1ZSQU1fQkFTRSAgICAxMg0KI2RlZmluZSBOT1VWRUFVX0dFVFBBUkFN
X0dSQVBIX1VOSVRTICAgICAxMw0KI2RlZmluZSBOT1VWRUFVX0dFVFBBUkFNX1BUSU1FUl9USU1F
ICAgICAxNA0KI2RlZmluZSBOT1VWRUFVX0dFVFBBUkFNX0hBU19CT19VU0FHRSAgICAxNQ0KI2Rl
ZmluZSBOT1VWRUFVX0dFVFBBUkFNX0hBU19QQUdFRkxJUCAgICAxNg0KDQojZGVmaW5lIE5PVVZF
QVVfR0VUUEFSQU1fRVhFQ19QVVNIX01BWCAgIDE3DQojZGVmaW5lIE5PVVZFQVVfR0VUUEFSQU1f
VlJBTV9CQVJfU0laRSAxOA0KI2RlZmluZSBOT1VWRUFVX0dFVFBBUkFNX1ZSQU1fVVNFRCAxOQ0K
I2RlZmluZSBOT1VWRUFVX0dFVFBBUkFNX0hBU19WTUFfVElMRU1PREUgMjANCg==
