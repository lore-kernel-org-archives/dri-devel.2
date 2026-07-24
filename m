Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620D8C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4DF10E079;
	Fri, 24 Jul 2026 16:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZpcMKW1C";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12EB10E079
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 16:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fV7yAqwmimjkpAGJLMef0h2bs+S//IQOOJyd9BXCir6ifE6XQ5GwaTmRFEIQKJfEH3o2Ih4xpW9bCzRtZC/1vF+v4FPwzc2z8WF36wsMMnl9Oso/pppCgeJoaF7yGy4+ocvJxD4qk0MfxLWV8QaUEckZgD4XbVurVYHs0PIsYtIut2HgfjorniCVcP4m+jDGFrliEvJRAN/J+O38Czs7iCSAU9gwO8t7CmSPmJ7k7fySrV0hOXD4cV4oCKSkhlf1K7Mp2gKKMSFahvXgJnyVsG/dETGN0zzQanQT79AFKtahfWSRKIY5J/k3Av2H2vpnUAj6WLG+dbuFE4I2pIPO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjYTbG9u4kok0KqNn/3hmSAyRrhfSN9NeQqTC3vPdKc=;
 b=MmBabEunmDFYvMCJHNK8lj0E2hs28d7T1WUY/0HP1oLDWCyAQiw/b2uvIKd81yc7GHD8vHIeHrqNGy3iEBKObC/tBmsA6qdh2sYLoOw2p/7OxXSMU3qmfu/uN+abCTrEJY2oLgXDaOl4EJxf/tVHmlOm3eytBiD4OLiYyx6z6v1jPXweVGeV0+UZ7AjpQRzuCPQhJTv4Ku2lYqzow9b9mYUzIFVJeyd2FPohg2UizPoyfNddrsvg1+KPDaipPfe+1nVxj0rg4bBuSS2KBxH+qHDVEmTOtE0ZRAVP+Z+C15xBWc/T5L4zpqd18NuHIT6LHO0NgBVc+QsM0zCObKrr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjYTbG9u4kok0KqNn/3hmSAyRrhfSN9NeQqTC3vPdKc=;
 b=ZpcMKW1CqyXznhNYRudUTLZnL/1mMJC1SI1m47bXbO2Mt/5cbn4VtcVTz04bnXZPGk3C0iNTtd/LGjaSa/TkFBua5+o1wDpcQzjXebuf1LR2wXTjbl6pZv2i7ksWRTua8ZzLQMAqGElYdU94AI+G7J8XFK2+d14ySOkVP6FHujVRPEiFIYwYykbxwjVm536paFqNHydDpHow3fFdu5MHeN8NGBHiYYs+RJgLvIuSH4F0xn/hJ9Yj2/uABrzNAydeI4GKwwEDrwewM1aTU19o/iVG2AYhBR8neMgeOqtBk+i9G2ace7AbdGj33j/7slvdzNxxIOkdYCBqytK1/U7T0w==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 16:52:15 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 16:52:15 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "simona@ffwll.ch" <simona@ffwll.ch>, "gary@garyguo.net"
 <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 "lossin@kernel.org" <lossin@kernel.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "dakr@kernel.org" <dakr@kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>, Alexandre Courbot
 <acourbot@nvidia.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Alistair Popple <apopple@nvidia.com>, "nova-gpu@lists.linux.dev"
 <nova-gpu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] gpu: nova-core: correct FRTS vidmem offset
 calculation
Thread-Topic: [PATCH v3 1/5] gpu: nova-core: correct FRTS vidmem offset
 calculation
Thread-Index: AQHdGzmS46K3B28x+ke5pswechm9frZ84xoA
Date: Fri, 24 Jul 2026 16:52:15 +0000
Message-ID: <ae14f443778ebcee56e89a72441f3252fc020b96.camel@nvidia.com>
References: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
 <20260724-blackwell-fixes-v3-1-01aa6a54e3fd@nvidia.com>
In-Reply-To: <20260724-blackwell-fixes-v3-1-01aa6a54e3fd@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|PH8PR12MB7421:EE_
x-ms-office365-filtering-correlation-id: 30b9c0c5-9dfb-4de6-53df-08dee9a3ea91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|38070700021|10067099003|11063799006|3023799007|4143699003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: gLBhe6tNonWYtp+YG2s28RoyTVQGxscSRKiGX2CnQWMFVZKxZDYhfy5VgfmEuCpqYQbN8mIAgjvWm+mjSvhWvWSd6V2C3v2bXHMAw8BKPzyhTL/uIPYL+cdRV2B8ycVwrTY6Ofi54cjWCtXKV1o57pa2uPqGQDUz82P4eksNoSLXQRlUcNP8D1M++MkA7IiKRRwygYCr+o0g6V6C0np78gym1ZiWz0njJgGOsQPdNeH2N6QQNjij51ZGVg8SaYUm/z9k5ji8VAk3CFU8GvbnewoD2KYs0abx82TKEvkND/bfRUbFU59tMLqjQxH4Rk4JlqhFtMdYJAGCmA8Ckt2M/tXi/i9DHvYgxa+FQsR4EB4B92B15N5wUPotgyV6wLrGOAMy2qqkdFUwJkldD/WTYNe4BypCZlwQsWWDf2mygiYAruFe/Q0megAdOwJm6RQxTzA+aVFXFPRw8i2svmzaObuCppQ8VrCU2cVd2feoi1YlH8LJOmNUz+yfIX5yJ4NdYPFbPhlcvdhxlJRd7Z04J8rRV2cXuF/pUe7A3iJr5aUbXBCIwrnTEm+EwMrsZwgqd+g1nj2pjIToQzyZKA0S7SOc78josGJf3mVNRvsnho5HQRHmW1/Q09xF6+Kxk8C4r2W+V1MseuMu2ql/2zVqjqPo8k4T7JZyJOyPdOY1HVND6Kyy6BYqKfMM2TTQ0Myqa3TIZthbm74nRsaAu8aLYWtlcBYMjp+J3JQJ8aTVEEk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(38070700021)(10067099003)(11063799006)(3023799007)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clU2cGFFK2xtWlYvVlNXOFRXdVRPMkoxWHJRMnowTXFRUTJwOTd3YXh5bFpU?=
 =?utf-8?B?cHkyMS9LNElCbGg5VklYR1h1TDJBanMxQWc1aVd2YVQ4NkZ3NGVKMTA4T2k3?=
 =?utf-8?B?Q2lsUWNaWVlkTVFWMTJDbG5WOGlkYkpTQUZ6cCtUU01Sc2lwVWVKWU8rM0lS?=
 =?utf-8?B?SjRtbzYvUndRaGpFaDB4bzM2YUhnZ1dVYXpNYWlYNStUN3JUOFlKSWllSERw?=
 =?utf-8?B?MEp5bWgzL25abVRCNUlwREFzU0l6MkwzSjd4UFRHYnA5SnNOUlU1MVBEMk9x?=
 =?utf-8?B?TWhxTWJndEVNQ3hldENVYTAwdHFmcUFnNHhpc29ESUhlWktKU3NScVh5UUNk?=
 =?utf-8?B?N01GNlBUWHo3M01SYUdCckxKYi9RVXQ0aW9qOW0zZ0lvNlQxUnMyVnliZTV2?=
 =?utf-8?B?S1RoWnNsbjJ3NzRXZCtrMnUyeGFvSGJGV0Q0T201UEZSQTB4VlRSZTRTcE1F?=
 =?utf-8?B?eFdqenVQaVNEaS82WnpsTTNFNzdabTZxbGxKTmNPSlNKVnZwc2kzUjFEc0VK?=
 =?utf-8?B?eUwyTU0yaGt4bmFuaFE5YmpsMDNFbzY4YXdKci9iVE9lczZkNHY2cWI0OVAy?=
 =?utf-8?B?U2h1NDd2cm40OTZncU9aSnNwOExJRjlDTG1Ha2FuN1ZqQzRsTjArQVZpREJ1?=
 =?utf-8?B?YjBpalpSRVRYcmM4QkxMSDhvZGd6TS9wL3p1U1l4Qm9xSHpWeVZJZ0pjTEkx?=
 =?utf-8?B?SmVtdWNGcVF1TnVSdmViV1dQQm9WN3B0SHh4cjFVU2p4dGZxOFZOalgzQS9K?=
 =?utf-8?B?WmlhZUdRQlBWVTdoVWFaSGlmanBmN3BaQ2xpeWVFRzI3ZEtFWFFNODBSQ1Nr?=
 =?utf-8?B?QVZHMlBHOTZYbytSK1RpVUtvN2hhZXpOVHFIdUR4T3JXU0QrMFZOUW1VWkls?=
 =?utf-8?B?VTJid2UwQ3JHTXZEUmh2eURQa2NwYmptMlZKZ3NxRDhMVTloRngyMVRWWUow?=
 =?utf-8?B?VzBXeGhJalZOVFp4aC9yWjV5S2JTeTJRcW9SNGh2VnFmcTNOVEZoa3VIL1BU?=
 =?utf-8?B?R2toRXl2TmdyS1JJOG1WamFJL2R0VHFLb3g0SEdNMVQzM29vNlFveHVXcmNT?=
 =?utf-8?B?cmovWTZQVDhkRXNibWphV3ViUXlnV1docTVwRmE1MDNwMkhodWJicWFuS0Q2?=
 =?utf-8?B?ZUlqdUtKV25vM1M4ajdEeXdJUjZWNWhTV08xZ2JKR2I1ZVIza1FBSXU2YktJ?=
 =?utf-8?B?anluR3RJb0VLU2ZxaGxQNHNnb2RLNGw3b0RvbitacnllbUY4dmN4UG5QK0pR?=
 =?utf-8?B?eEpXaUpaVnFHYjBIazQyUTJsN3ZYK2ZGYkNHTUhzYWhUYXBiVXVoVlFMWEJz?=
 =?utf-8?B?L0Y0YWlTUUFtQmpJYmZuTGp0dEkxMGhOd3h3MThueVdZU0NzcENBMjdWZUkv?=
 =?utf-8?B?OFN6Zy95TXZSVEdhRVk3eXBvdTBPcm1NOUJIeHBMR0FpaTRoeVNRR2dvMGZZ?=
 =?utf-8?B?YTBKUXMrNDhkczdSaE5oM216SzVMUXpyb1Jvb3YvSzl1Q3NuOFVrbVR3cDEr?=
 =?utf-8?B?aEpidVVoVURESmEwdDdVVmZqZ0F5ZUZoWTA3UzkvcmpFZzJsSUtNMXBkWERr?=
 =?utf-8?B?STZYS09rRUFrWkN0SEtZcnN6RnM4SHR3UzAxb2tyVlM1d1J0bUlTZUlOWm5E?=
 =?utf-8?B?QVF3alFmalg2UmkxRUZNSWhzUVQ0c3ZjRnJCUS9KMzlTNlBjZUgyRUsyZlhU?=
 =?utf-8?B?OTM3MUgwY3UwaXU2blg0S2puU1NxODZvVlhJWG1ZV1FHUFRqZ0VlUGs0Wis0?=
 =?utf-8?B?Nm9kbk9SWCtjSk9jaEZ6clJyS1BjUUNVdElZL1dvRFJzY2dSOXhDTG04cDFj?=
 =?utf-8?B?R1VIU0JLdWx0QlFyK21YWVpVSnNwODVKNm1lNDFxK0pGVnFYZjJyd0p3SG5S?=
 =?utf-8?B?K29Sc2RaM2w4alBnV0RDbEh4akt1ampKb1BEcGRPaTZrMmI4WjVDRWp1Mlcz?=
 =?utf-8?B?bnVSYTVCZmFzQzFMUTQ3UWMrTmIzdzNoMUJhV3lQUVJZcXZBU1ZzMStFOHU4?=
 =?utf-8?B?VXNYMWxFVFdVWS9Da2xoY0QwWG5WOHVnU2xNeEdqWDIwTENrMVN3Nk0vYVo1?=
 =?utf-8?B?KzdpekhXM2ErOGd1MEtQWW9RT2d2eC9zNjFLMUFlbDNIRTdxNEdCSVQveFhM?=
 =?utf-8?B?NlNMWCtGSy9sSzRPcjYwank4MnhjRWtwd2JYNi9HSjJEc0VSTTlIalhXMm5q?=
 =?utf-8?B?RHUya0Q4OUhKUjRpOTgyTmcyaTlZRDdmSE9PZDNzeHVmVW1rNUlaM21zUlVX?=
 =?utf-8?B?RmpGLzhnOTBhZ3UvR013aUpTSTVYb1p4enBWblpoUXAyTFdWOWd0VHdLT3ZB?=
 =?utf-8?B?ejcrZ25pMElnbUIvVjMwRllwdUpzN2NJdmIrS1hUdzQ2em5IV2lmdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89A3BDDD5E16DC498EE39999D5F23FCC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b9c0c5-9dfb-4de6-53df-08dee9a3ea91
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 16:52:15.7464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTA1TNYZHxwvoJ0g0GtwOuYcVrVEY4pczaRUxUhKAli5Lo2OvGW8zJCP1n10Z6VSGouBnJTY58BYabL0+PJWyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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

T24gRnJpLCAyMDI2LTA3LTI0IGF0IDE1OjU2ICswOTAwLCBFbGlvdCBDb3VydG5leSB3cm90ZToN
Cj4gKysrIGIvZHJpdmVycy9ncHUvbm92YS1jb3JlL2ZzcC9oYWwucnMNCj4gQEAgLTE5LDYgKzE5
LDEwIEBAIHB1YihzdXBlcikgdHJhaXQgRnNwSGFsIHsNCj4gwqANCj4gwqDCoMKgwqAgLy8vIFJl
dHVybnMgdGhlIEZTUCBDaGFpbiBvZiBUcnVzdCBwcm90b2NvbCB2ZXJzaW9uIHRoaXMgY2hpcHNl
dCBhZHZlcnRpc2VzLg0KPiDCoMKgwqDCoCBmbiBjb3RfdmVyc2lvbigmc2VsZikgLT4gdTE2Ow0K
PiArDQo+ICvCoMKgwqAgLy8gVE9ETzogY29uc2lkZXIgbW92aW5nIHRoaXMgaW50byB0aGUgVExW
IGZpcm13YXJlIG1ldGFkYXRhIHdoZW4gcmVhZHkNCj4gK8KgwqDCoCAvLy8gUmV0dXJucyB0aGUg
c2l6ZSByZXNlcnZlZCBhdCB0aGUgZW5kIG9mIHRoZSBmcmFtZWJ1ZmZlciwgaW4gYnl0ZXMuDQo+
ICvCoMKgwqAgZm4gZmJfZW5kX3Jlc2VydmVkX3NpemUoJnNlbGYpIC0+IHUzMjsNCg0KRG8geW91
IGtub3cgd2hlcmUgaW4gT3BlblJNIHRoaXMgdmFsdWUgaXMgZW5jb2RlZD8NCg0KVGhlcmUgYXJl
IHF1aXRlIGEgZmV3IHBsYWNlcyBpbiB0aGUgY29kZSwgZXNwZWNpYWxseSBmb3IgR0ExMDAgc3R1
ZmYsIHRoYXQgYXJlIGFyYml0cmFyeSBhbmQgR1BVLQ0Kc3BlY2lmaWMuICBXaXRob3V0IGEgbWVh
bnMgdG8gc2NyYXBlIHRoYXQgZGF0YSBmcm9tIHRoZSBPcGVuUk0gc291cmNlLCBpdCB3aWxsIGJl
IGltcG9zc2libGUgZm9yIHRoZQ0Kc2NyaXB0IHRvIG9idGFpbiB0aGUgdmFsdWVzLg0K
