Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2200FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C0610F0A4;
	Wed,  1 Jul 2026 18:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="acuAVfns";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6387410F0A4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcGYz1dPq4TqLYXmZqrqfhBX3xMxRazsOX5vVuH377tIxLWSgKHa+r4JpoypIJ+bsFLwpu1A6UdinzvJ4P30WiNQQRujnwZPZfTMt8qFH+0G18bvXURsjRibfubnDl9Yv0wAS5M7xNbFSb6QmHfrp6bUEw4AVAiTJpebXKl3LqPPLGgDqw3WOcsEQbBm2nu7Y23U+gw9gS6rrgP73suajBbDEUhdE8U1bDryDomjp107zWBIOdJ5PkPWqNC/5trvrzOCANwqkXsnfbpYfj+rkZHE0P3KBDo6ThjZ1HfKJ/T6TKigQ0jlA6M7X3py3L6qGhoovp3M684E3ssM5CZJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qZAH2ui98IawntXTYcy+1QKhj4CCsKpKDSnj24440g=;
 b=QFxDC1ZDeDzvi5zO2BURE0KlU0o/pLyBHDNBsz0dkDkhmfzHHrP2m3SV8qb+7zPoVjSI90jQXsRHPYjsxo1zQlHh3e1bPvuWS8vkZT+Yb6HwUOFl6rYmQ3HjFSZMGJWWupKFnI1QDxZrbTe0nhrYevn5ueMVOUfmzylCLhtJSdi5TysxULKBK+M7BvxTZ2AOi5D/bicKiH0vsqpm26E5roBfQedSm6ro+sUDizwR+/ESUOkNVPKarIpNQhW0lfm8yiN1aPS8EF5isoa5Y5jnjOdhA+EpIMkMABI51KfsHiAaglH2Z1B+0nxoJtAf2l5dKYE0yQuKVKLz+x18dK6ngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qZAH2ui98IawntXTYcy+1QKhj4CCsKpKDSnj24440g=;
 b=acuAVfnshWiOG2Mq040ya8my2fOhQpXY9g+oQydzIUccUT/siI02u9ICtAKGNHLEdXp8V5sgsVlMMl5ZgsQKvGOr+yI7s4KnmCFCncPZCV9PPbRQbtg+iZA/itXTTMvNXOfefKtAUBbIUkWvZc8dDJoFEWZXH1RHRJtb/mBhI5sAuswO4tBR1JPTt6oLXMRUU1D3yDCJLIcYo2oDwEENV+iRbQ8bK92XKnX8n1e925+vK7fPtgatbneGBZ8BDqAuZkW8rMua+5OzCEGZYNWWDXfNCjXgvoC7pEfr/k0zE1Dw0xbGE4k3kN9ld0DMf6ebR7ssUOHvoZCzbFLPi0G50g==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 18:39:43 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 18:39:43 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, "lossin@kernel.org"
 <lossin@kernel.org>, "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
 "ojeda@kernel.org" <ojeda@kernel.org>, Zhi Wang <zhiw@nvidia.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "tmgross@umich.edu" <tmgross@umich.edu>, 
 "boqun@kernel.org" <boqun@kernel.org>, "daniel.almeida@collabora.com"
 <daniel.almeida@collabora.com>, John Hubbard <jhubbard@nvidia.com>,
 "work@onurozkan.dev" <work@onurozkan.dev>, "bjorn3_gh@protonmail.com"
 <bjorn3_gh@protonmail.com>, "tamird@kernel.org" <tamird@kernel.org>, Eliot
 Courtney <ecourtney@nvidia.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>, "gary@garyguo.net"
 <gary@garyguo.net>, "dakr@kernel.org" <dakr@kernel.org>, Alistair Popple
 <apopple@nvidia.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova: fix rust-analyzer generation
Thread-Topic: [PATCH] gpu: nova: fix rust-analyzer generation
Thread-Index: AQHdCSSXS/VQQcrMY0OMvBcXjlvhZrZY/6oA
Date: Wed, 1 Jul 2026 18:39:43 +0000
Message-ID: <433402bc0b73dd9bbe77496703c8e98f7525af45.camel@nvidia.com>
References: <20260701-nova-rust-analyzer-v1-1-5209f486f10d@nvidia.com>
In-Reply-To: <20260701-nova-rust-analyzer-v1-1-5209f486f10d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|BL1PR12MB5850:EE_
x-ms-office365-filtering-correlation-id: 4348a7fc-8e90-48bb-5eff-08ded7a01e19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|366016|38070700021|921020|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: Ec91ZdjMx5fnT2fQKEnQLtr2NQ7drItZ603HQYHDyx8hIRJIKrp2SWtHDpOeiapjr1rc9smHNiBMWgwdcr8wDk7UqvrqD2MeBFtlObQXl+m/7g9cmVgjN2wTT9kfotSUhhqX9hvzJOcyA+y4Gbm2LtodNC0Nj299r4waTSNtVRKtjTl73mUE1P6f9xn3kMp51DyhJLBBQLIX2P7zNPBZ/mAFBT8EwXeu+YH+KSDyIBx0lS42Jnpy5SaSAL3iOTo5nuGVkyjyWtmG2cX/Q+fTisFYP56yAe/zwYdv5LnrKBWDyQagZXAmnuFTnMx16Gc4yYqWUCaPfysFRAw2fVaPfAHu/ifa9H+MmCyqqzjVhstTTI+y3wvzKannFghql9cM4JFQL9YV1AXWypMRbnZUB04EDjQ/aGdypFaN9zHJC+Xz04QpaWdHixsanwkM6V1ySpSObg7Xz4nehJJGArs9Gi84TlvuoZS+BZKWssmREl++Lw5kVgJcxuNPWGfDxAuhrwyVaeiJM02r9K8bsXN3eWDQggr4ezrmU00aDLi/pq3/Dqb30Pxe55/y0ADHKDkNzR/4CfkIqKYPenk/R2m6xKm7IOItjEnzlwMkDn9c9CoHY7597KCir2wjLjwHh2TlgjbtV/GWbbjep1oX1C/37kTBZ2bL0rRxQFluyMX1klXPx2Hij6YTQpwxbLbn/zJKRJZxTTKzxeL1AfJ9kfM1NlWK9UNhnfanGsXrZwNKxyiz41f8lxbTA6lLCfESnRQn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(38070700021)(921020)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEJ5Zk04KzdQQTZBQURQYXZkMWxMZlQyT0htaG11MS9RVmxuai9sb3VMcTN2?=
 =?utf-8?B?cFRuQWw2RHFLTlFEdXprVFlxSURONnJuamNRMkh4a3dRbVEyNG8xcDBsZlMx?=
 =?utf-8?B?SDNzV1l4Q3VaMmpQR1RrK3cwODM5NzhhQ2wzcXh0WGZMNFpHZmRmd1JVNmpY?=
 =?utf-8?B?NTZIVUUwMTlqdW5McnhKckpxL044Rm5WU0VDRVQ0VFFRdHZra1FBMUZwRXJ6?=
 =?utf-8?B?Qko0K2dXb0VuNlFPSDJjd3orazJyc3JPQmxFVmgrVnVBQzRWc2hOK0hOQjNY?=
 =?utf-8?B?RTVQdkFwajhHSlFPcW00Sng1VUZ1aEk1aEdvUy9uK1ROYy9ZN1FxV0Q2RlIx?=
 =?utf-8?B?bklMTUJJakZ1a0s1OHNjSFhTdURybFI0UklheGxUcEhKemd1eUtUclBWdCtH?=
 =?utf-8?B?alFCWEMzbjBDdWZITm1oZmlSanBWaGN6N0dUMTRrM29EWVlTSkFRcitsYlFh?=
 =?utf-8?B?c0tRVG5JcEJiMmVwdXgrVERmT0FMckZkYThXNDFldHhVMmRnbzVnUzhJY2Uw?=
 =?utf-8?B?VzhnS0RsdURLRzdjWFZBaWRGMWlXaGxYTzJ6T3lYWlEza2NKQURFNkNXcjJr?=
 =?utf-8?B?eFRnVC95RkVnVndKeE1ncGZDQk1Bbnd5OWpEaHlVcUtJVmxHdjdsMDZTWkVB?=
 =?utf-8?B?bG1nUmtiRUx2MUFnMFBqUjdwb0dxS0FtMjFhTHkvTkE5RzFGWUJHZTBhNnNN?=
 =?utf-8?B?elo0R0dobFdFU0t3RnU5ODZmYnVDNUhUdWN2SFp5d0pNM0k0LzJGWG82NU9V?=
 =?utf-8?B?b2hhNlI1VjNTQWNEZTFEY25mK3hjQURzdVdvZS9LRE1JeENWdThSMWZWUnRP?=
 =?utf-8?B?QWhlamQxWEYvVW5Bd3lMaUZLbjBEb2hjVXpXRzluV1VTRWZ6S0M3bmIvQVda?=
 =?utf-8?B?YXJoVldSUHMzUEpDMm9nZ29FUmdGZ3E2SVdKSWdWTlIyZUplV1RwN21sZXRF?=
 =?utf-8?B?VDFVWHBFbzVDc3NmT1BLNnpEcFR4RUp2eWg2aGVHOVp1Q1hQQlVyY3FSRUZU?=
 =?utf-8?B?TXJUTlk5WFVJanp3ZWs2L2FNUHlYMGJpdUJkczFhUVlOeGdaQm1TR2xTbFhz?=
 =?utf-8?B?Ym9zQTVVR0tjb1ljbC9BLzRGeXdtdlB5U3V5VkhHNzNSejFmd1c3QlRXcmlm?=
 =?utf-8?B?T3U3NkVkNGJhSUdWQ2VIckpyNnMvMy81SFpFUXRIK1U0d2x5WHB4dDlYVHB3?=
 =?utf-8?B?U09mMDY5UmFvYWpoS1FzYmNLb1pxWVdyclpWN1BjZ2VqdFFRajNtUE9FTjRm?=
 =?utf-8?B?aGpua0pFRmg4RUh2R01ScnJuOXBoTU5PcXEvNWoyQk1oK3Q5VWxRdlI3Uytv?=
 =?utf-8?B?MFprdGdZWEV2cytuOFNQbFErL0QxQmhpY1BLV2NFMHdCMmpVYm9tRkVqaHZw?=
 =?utf-8?B?S2drM0ZJekVMMmdYVDFmdGlzNHdSYk1CcjZvL0ZhWkp5RjBGWlFwNldOWlhN?=
 =?utf-8?B?NHovN3cybCtwSHJLRkUyUzlwdkU2Qm0zeDNjcS9FcUlUVkVmNkFUbGsrcm0x?=
 =?utf-8?B?OVFLZFYraXNoRFlXUzk2WjJnekZHUnNjZ0szK0dhNUt4RG9FeXc3cis4YUFw?=
 =?utf-8?B?RloyYTlZd0V0RXlvcnJMeFN2YktWazl3bTFoV0dvNFkrYTdkYmZKd0o5d3hQ?=
 =?utf-8?B?eWRkTWdBcGJ6UUtjV3NXb0Q5QUpFRXFwT0tsODFCYVZOOEE0QmlCYmdyWGtM?=
 =?utf-8?B?L0RjYk1tMWZEQXZxa21iWnZqL2pqSmtVRi9TbnNqTGNUd0JyOGNDYUZaNVN6?=
 =?utf-8?B?VDRwbkFaSXZiOWs3d0dDVW9xNFJYY256VVE2a0oveHpPRDVEYjU2TTVmOUVn?=
 =?utf-8?B?aG5XbDV6MG44b2wyeG1mTExvZzkzdk1BaFhKdi9rcTNEeDJnRkVFMzc0OU1J?=
 =?utf-8?B?ZW4rd3U5VFdxWTdhOEhJaW5mNjBKSjNRSE1yNW00bHA2SUNNZEtHT3pvVFNK?=
 =?utf-8?B?dm1mZGZqRTY4eFpNejc3VDNablRFTE9CU2lXVG1JeVpHNThJYkZZVkxYN0lh?=
 =?utf-8?B?UTU3Qnh6TGd0Y3dHQUhqQzBsYjRsdGw1Tk5GOUdVQ2lJOUs1RkZjSW9QeGFa?=
 =?utf-8?B?ZlFLYXh5R0dSYnlBWDM5MENsWHdDcnhyWXlzNnJoVlNDQkZSRGgxM2xibkZH?=
 =?utf-8?B?cHZINUwyTlJvVE9hN1RQOXZnQi9sOXBKTUhQblR2TjhsVUdLMmhpdU90bHRB?=
 =?utf-8?B?cGdDVTRFRWdFZnpEakR3cEl1OXpBcVpzUEY4Y3ZDdkc2ejFaTE1DU3FxUTJ6?=
 =?utf-8?B?a2x3clZDRDdHazdoOHltMytRcXU3N1pybW43cUhPZm1mbDQwcTcxeUxYWWtE?=
 =?utf-8?B?eDdTME1iL0Q5bm1QdFZWQ3ZxRzFnMkVlUFNHS0RpS0hqK3ZHSU9pZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B806EB703B67F40BB276D3A019C779A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4348a7fc-8e90-48bb-5eff-08ded7a01e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 18:39:43.1348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tX4liuefQCr2n18k9m+3mBxiYS5RDuO7ZJ+BXy0h8XMFUYKPPie2SsdTCrIpsjCqE/sbgBaNzyhKJUDXpclHvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
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

T24gV2VkLCAyMDI2LTA3LTAxIGF0IDE1OjQwICswOTAwLCBBbGV4YW5kcmUgQ291cmJvdCB3cm90
ZToNCj4gVGhlIHJ1c3QtYW5hbHl6ZXIgZ2VuZXJhdG9yIHNjcmlwdCByZWNvZ25pemVzIGEgY3Jh
dGUgd2hlbiBpdHMNCj4gY29ycmVzcG9uZGluZyBgLm9gIGFwcGVhcnMgaW4gdGhlIFJ1c3Qgc291
cmNlIGZpbGUncyBpbW1lZGlhdGUgYE1ha2VmaWxlYA0KPiBvciBgS2J1aWxkYCBmaWxlLg0KPiAN
Cj4gQ29tbWl0IGNhNTI0ZTI3M2M0MyAoImdwdTogYnVpbGQgbm92YS1jb3JlIGFuZCBub3ZhLWRy
bSBmcm9tDQo+IGRyaXZlcnMvZ3B1L01ha2VmaWxlIikgbW92ZXMgdGhlIGJ1aWxkIHJ1bGVzIGZv
ciBgbm92YS1jb3JlYCBhbmQNCj4gYG5vdmEtZHJtYCBpbnRvIGBkcml2ZXJzL2dwdS9NYWtlZmls
ZWAsIHdoaWNoIHJlc3VsdHMgaW4gdGhlIGdlbmVyYXRvcg0KPiBzY3JpcHQgaWdub3JpbmcgdGhl
c2UgY3JhdGVzLg0KPiANCj4gRml4IHRoaXMgYnkgbmFtaW5nIHRoZSBjcmF0ZXMnIG1vZHVsZSBh
cyBhIGNvbW1lbnQgaW4gdGhlaXIgcmVzcGVjdGl2ZQ0KPiBgTWFrZWZpbGVgOyB0aGlzIGlzIGVu
b3VnaCBmb3IgdGhlIHNjcmlwdCB0byBwaWNrIHRoZW0gdXAgYW5kIHJlc3RvcmUNCj4gYHJ1c3Qt
YW5hbHl6ZXJgIGZ1bmN0aW9uYWxpdHkgb24gdGhlbS4NCj4gDQo+IEZpeGVzOiBjYTUyNGUyNzNj
NDMgKCJncHU6IGJ1aWxkIG5vdmEtY29yZSBhbmQgbm92YS1kcm0gZnJvbSBkcml2ZXJzL2dwdS9N
YWtlZmlsZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRyZSBDb3VyYm90IDxhY291cmJvdEBu
dmlkaWEuY29tPg0KDQpUZXN0ZWQtYnk6IFRpbXVyIFRhYmkgPHR0YWJpQG52aWRpYS5jb20+DQoN
ClRoYW5rcyBmb3IgZml4aW5nIHRoaXMgYnVnIHNvIHF1aWNrbHkuICBJdCB3YXMgZHJpdmluZyBt
ZSBjcmF6eS4NCg==
