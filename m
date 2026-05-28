Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC5BCD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 20:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60FE910E6F8;
	Thu, 28 May 2026 20:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qVLgvU36";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C1710E6F8;
 Thu, 28 May 2026 20:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+qCzHtE3WmFia1UU/XDUKV68yAqWVcy6Ktr2l3/KclCmK6xkhf5c4kHuOPpOHamoTdLaxVtsnFZbuOYpI3BGlNq4XaKxl6MREu1Rrkz1CM7/lsMC5OgGaVggVtqVlqm6PiqjAyQxYZT5Km2qC3c0jcWScB5l7/GYPKMEbFW18TInkoEF4BtxCi4CCwMk1VNlpVBA8TErsjRkftIWciZtdi1xDB/2s7aB4p14P1kv7X4J5xr9C0y2ISIJYrvg4gGzZx+i1Qy3QtsqLubzydNfczwSdLXDNQh8tIFaWIzfGi+7fVWeLwnE6Sn1Vuw29LRfRMDwDyJQyIcEzzdxVlPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qnigv68t54Q4ZZEZg0k1/SiECyVW0DJ5cKdPPszhDUI=;
 b=ttIXxCy94IJavw31imgODEXZ2Cs2gmVfSUBr6DTXeqc/imvzmRBgE3f6H5olSkF+SWtQvF4YZl6TjlXYvTJqi+ZQWwqYtCK/oXSZ7AHp9NCcsm2w3LCV4jaNXQH0Ei54FLvrPwOD63FFIa7UiNv465saydnaxColuUFiK1Hc6xslgLH2+dne96xZ1UjsG5vxOFxg46VINLljIzVmlPvhEQ8+p6kBD6oHKsPxhD3oTGZ+cgPM7T4eF9sh1JFqLuxMv8mE4AlBiCTJfJpPHOFXRcI2nxPrG58UEzskkI4JJT1qvBtpOQc3CTLvIHIJ+ONGchA04Zh9BTKinXIxhpB+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qnigv68t54Q4ZZEZg0k1/SiECyVW0DJ5cKdPPszhDUI=;
 b=qVLgvU36B/op1l0zO9zn0IFuljMVYyGlZldhPj058jW49eXjjqHXB8U/P4L2vtK+EzcykZwlcj4JuOPgN6RILJRnEeaLGG6ORngVwxwpiPVijFtcBfUMsACob2Vu03YF5XUAnLoItfdq5+29T30kT6ZkoAQOra5PuVvMtUyo0ZOieawfZG8QlM6UCpI6TQbgHJNdMb79Hc+iLgPX6BT9km48o2EmXNEvBw8YhfcV5wDuKbacFvRTN3hQvhp0JPv71SeefZi3HeFZ5m5KMoLNZMlKlLMwkCEHgZKcTVML9Vn1EB8TX5Pj0I6AyMy1PenLuqLI8yLMjC4FMft1dAwDTQ==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 20:23:15 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 20:23:15 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "dakr@kernel.org" <dakr@kernel.org>, "lyude@redhat.com" <lyude@redhat.com>
CC: "rongqianfeng@vivo.com" <rongqianfeng@vivo.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "kees@kernel.org" <kees@kernel.org>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, Zhi Wang <zhiw@nvidia.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "airlied@redhat.com" <airlied@redhat.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage
Thread-Topic: [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage
Thread-Index: AQHc7thCBhH78Qg9RU6Y0eu2TyD86bYj1zYAgAAKuAA=
Date: Thu, 28 May 2026 20:23:15 +0000
Message-ID: <4f4b7a4a89a253e515b009ccfa7ddfd21853b64d.camel@nvidia.com>
References: <20260528192847.4077458-1-lyude@redhat.com>
 <DIUKG7F2VAC7.17L4VHNNI7YL2@kernel.org>
In-Reply-To: <DIUKG7F2VAC7.17L4VHNNI7YL2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|CH3PR12MB7619:EE_
x-ms-office365-filtering-correlation-id: 51883db6-6f25-4d01-96d8-08debcf6f2eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: aLeoSmcRY7Jh+zFSY55aYjgWs6GUDylNCi7NoGfabe4cVYLJeKpeTtLGjAqKOiT7YQQUw/ziEFAueTr9Sv8RaUaRM4TWNRnipdGzg50eLFRshfC3Gwct9nGE0Ztht52IRXL3TdtrFmkKSCB37eJR6Bm41oMUXLuhYf1Dw3swU9Iz78HNid0VD73nwJGGxRi9sv3Dpj570yZKADoj3Dqg27YO5CAvUtG0kBEgKVpLKeDxlEW1dL28ZlbZJSonMWCG4x4CWj1GcEjHssOD5cJvni79n7oyQRcUUPC2I74xwGW6gXkrXnalPeg/UVuUFkv9X53lllq2jLXbYl9HL6WGslJz5Fb4n2eXnaTXdfM0wzbrntmURBjmmJ+OnWD1Ikw4CNMYtzQFJpasdGDSrhmK4KEF1kGaoUfyDFRry/G5ak+f50CCttOZkVYLMyLr2puWHJgbwD8e9yVJ78BrzpTSY2cYIkRl3L7yRPOQ+8UW/dxMUJRSDt6crdq+dPukxlm6ozXQ98qk7SOHwbSBHcv+kZjHH+ITnTV6QT9vLHbUWnxFgeqQkzZhXZcRtNcc+p/sQRlM5z3btwAPhX4QPCkG8iWrZS7hSZU2ghHEEiYk1X+c7gRrNlSsAuNIGsUQo9unSvW2lC71RbiGDnolAAQWoM8c16dHQeDulWNZpypJdzxxMgPA3+VnvnswTFQhnrF4XOMijrdUt6fIHoGTghqa4Esqhbfh0fcidSKpwr+zStbjqJiRpVeBxcD3yfQa486j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHp5clFIaWZkU1AyaWhVMysvTWM1aTluZFRFdzhGVWw4TzhYNVRjTzN6d0Z3?=
 =?utf-8?B?Vk83U0ZKT1hvK2hkbk5OY0Y3V0twQmEzb051NXk2M1cvNWdKbSsrOFhISmFI?=
 =?utf-8?B?RzZ4SDRTZ0oxNmxiek9OSGhMc1ZyUmN6bXAwcEdkQW5zVkNDTHBRR0Y4emoy?=
 =?utf-8?B?MjUvWUtlTS9sb3EzazBtSmhNeEdWU1BpL1FDMFZmbURIQ3JUQ1c0SEVwTmt2?=
 =?utf-8?B?YVNoV3AwTGZtekRraGVrRUNYcHRIeW9QUHZrOUtnZ3ZpTTZpU0krcFArOXFh?=
 =?utf-8?B?bHFsM3VQS2wwUG5lMVhjTER0VWhsNFhoTHA5Tkw2OVkxS29CZE14MUNVSHkw?=
 =?utf-8?B?cjFkME9Cb3lnYWRwOE5yOEJOWnAyb25KZWxGRW5uM0YvTjBTWXdGQk5VaXRQ?=
 =?utf-8?B?alVaOW05eVp5RTZsZmhpRnpqZk52d2p1ZjNjM1pmeXA5b1hLTnl5azNxSzIy?=
 =?utf-8?B?UkgzUE5tTkJJTFV6K2d3VDJYSmRvT2hvZ1dDa0t3b2pBZlF1N2JWWDZBRitk?=
 =?utf-8?B?Y3lIT3k2SDMwdzQydmNHWjl1eXNZVU85dDhGVDdXanZwemxCMTJXVlh2Z0tt?=
 =?utf-8?B?a3FYY2p2aDZ2S0ZIcG9tYUo0QnBZMTNyanJ2YkZ5QnJQNitWYklVNnVPdHhp?=
 =?utf-8?B?K0RabkxKVlBxcUpkcVJ5WDlVZ2R6T2FkcTVxaUxtN2tHM2IzdkdOK2s5b1VD?=
 =?utf-8?B?K0ZNdzROWXE3TlNsV01zcmhlRlQrU1RCRHBrRGR1R3lRZUE0MFZvbFBQQUVq?=
 =?utf-8?B?Z2x0OGRwV3lMYXhXUm1DMk1CeWM3L2VGN05WZHY0MlNwRnhWaTlBRnJqRFhD?=
 =?utf-8?B?bnRsMUQwNGxOblNlaDJGbm93d1JDM09lUExaaDdvc1VaSmt5N25EWUVLT1A1?=
 =?utf-8?B?cGwxYzc5OU1jc28yUGIvaXRtQVZqdm5lS0lhUURzTWo3Y2pDQVh4eU5kenJU?=
 =?utf-8?B?ZGZVN3NHd2IwNGczT3c4VHVYMGhBOTRUdDVnZG4rcFp1bEFBTzhibFREc2FM?=
 =?utf-8?B?K3RJTlowZk9vOHA2WVRWV2JCaDFodHBvV1graElXNkEyOVJyM0VEMU5uU0Jz?=
 =?utf-8?B?SkhwdjBFNDBWbE04TkhEcjdUS0FBOUlPL1MwS09xcEdBWE0vRG8xeXpNU2Ja?=
 =?utf-8?B?QXVuelpwM3huYVdiTDRZcmpLczZVUzlrQmRBM0M4NkUreDM4RXRueS9WaXcr?=
 =?utf-8?B?QUk4Y3FEVllSdFZ5d3l1V1NseWdKYnB6WjFxN0htaC9sRmVTSTBzZ25FaXIy?=
 =?utf-8?B?dU5xWDJOVTUxazV3NDU4dndwaEpKdmN4MWsxR0I0VC9QNXhnVkZVa1RWUXU4?=
 =?utf-8?B?dEhidVpabStFR09ZVUFabHU1MjZIMEw3czg4ajM2S1RsS2dhajhNcXhtVlkv?=
 =?utf-8?B?L2haSUNVSzhHUW1FaHVRQk9Lejk0ZWlOOTFyR1JjejFBbHZSZjAvTUErOHdF?=
 =?utf-8?B?Zmh1U2hpc0hCSlBWaURaSWhsMFlRQWxrQ2w1MjNBSFpoWGFoM1JhREhhNlpO?=
 =?utf-8?B?RmxHWExLR2RhZksxQmozUnhqcjBTSEpKNDkybW1xNVl6MlZsajV2SGlVU281?=
 =?utf-8?B?Q1FJVWZxaWk5Q0lSdTgwUnMwR2ZSYW15TEdWOXFsQmw5WkJocDlQL2tENEZH?=
 =?utf-8?B?THBuamlaWGljVzdvOHpybENlcnlMTzFaMDFkblU0aWd2THd5RDZ6cW5xRnUv?=
 =?utf-8?B?TXdBemlwd1AxTThmQUdyNmhJUlhMTmhFU2JSZkJqOWhTZjU1VWZBU1Y4bi9x?=
 =?utf-8?B?cVR1dWV5eHM2bkFoRnVZMEg0NFhLSG93NVd2d0w5ajQxTVdPd1V4OGZ0bjY3?=
 =?utf-8?B?SFBZQkRxQ09YWEpVb0FoVHBtamxQYWJrcENpVVF0Wkh2U0lmS3ZlRjhoUEhG?=
 =?utf-8?B?YXpxQjY4MkRGSDk0SkJJWnRVK0pleGxybGw5M3pJQVlyb3IwVzVYTnFqdlo4?=
 =?utf-8?B?R1dUMHdDRGduMFIrWEx1UHBGL2hhZitnZXZVTEoxNVpqTHFqYXVkS1JNdlZ6?=
 =?utf-8?B?WWV1T083T2c4WlU5ZWQxUkVFSnMzYlc1NzlSRnB4LzBZSGNSQzNKSTN1cEZU?=
 =?utf-8?B?bDZaZWoyQlNrTk8xZk5lbEJUV2pBRjVJTTh2VUVOZlJkMjFyRkJDZ0xBWHBx?=
 =?utf-8?B?eVVPNGU2RGI4K1dES01ZUDNQOTFPc2xlUm5SaWtKR0RyUzcvY1VBL1NKU2ln?=
 =?utf-8?B?TVVHdWVDT1dHMFpORVBGR1N2b0dpVXVUMHBGSHZyS0lxWUlSK0FmMUVxMFR4?=
 =?utf-8?B?MWEzQnF3d0dNLzlDbnp3RnlJWW9Qb1BvbmE0RCtsbDlMK1dvbUhHNDMrN3Jk?=
 =?utf-8?B?VlAyeXFzYzh5bW1XMVF2SXJ1aTVrV0piKzBsbytWUytMOG1oaVlVZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71E07D37D741724B8CD950474D865309@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51883db6-6f25-4d01-96d8-08debcf6f2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 20:23:15.6162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FW7qNUECwoydAzPylj4Vs3jrwdNzAhiCd0WOqcUZ06hsYxWXuzWMm5GyQbgir0Fs8/bX9GVLBDObyuooDsaNmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
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

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDIxOjQ0ICswMjAwLCBEYW5pbG8gS3J1bW1yaWNoIHdyb3Rl
Og0KPiANCj4gQFRpbXVyOiBJIGRvIHRoaW5rIGNsZWFuaW5nIHRoaXMgdXAgaXMgdGhlIHJpZ2h0
IGNhbGwgaW4gZ2VuZXJhbCB0aG91Z2gsIGFuZCBJDQo+IGFsc28gZG9uJ3QgdGhpbmsgdGhhdCB0
aGUgd2hvbGUgZHJpdmVyIG5lY2Vzc2FyaWx5IG5lZWRzIHRvIGJlIGNvbnNpc3RlbnQgb24NCj4g
d2hldGhlciBJU19FUlJfT1JfTlVMTCgpIG9yIElTX0VSUigpIGlzIHVzZWQgLS0gaXQgZGVwZW5k
cyBvbiB0aGUgY29udGV4dA0KPiAoYWx0aG91Z2ggSSB1c3VhbGx5IHByZWZlciBub3QgdG8gbWl4
IHVwIE5VTEwgYW5kIEVSUiBzZW1hbnRpY3MgaW4gdGhlIGZpcnN0DQo+IHBsYWNlKS4NCj4gDQo+
IEl0IHNob3VsZCBob3dldmVyIGJlIGNvbnNpc3RlbnQgaW4gdGVybXMgb2Ygd2hhdCBmdW5jdGlv
bnMgY2FuIGFjdHVhbGx5IHJldHVybi4NCj4gDQo+IAlyZXQgPSBmb28oKTsNCj4gCWlmIChJU19F
UlJfT1JfTlVMTChyZXQpKQ0KPiAJCXJldHVybiByZXQ7DQo+IA0KPiBJZiBmb28oKSBjYW4gbmV2
ZXIgcmV0dXJuIE5VTEwsIHRoZSBhYm92ZSBpcyBtaXNsZWFkaW5nLCBhcyBpdCBwdXRzIGFuDQo+
IG9ibGlnYXRpb24gb24gdGhlIGNhbGxlciB0byBzb21laG93IGhhbmRsZSB0aGUgTlVMTCBjYXNl
IGFuZCBjb21lIHVwIHdpdGggYW4NCj4gYWN0dWFsIGVycm9yIGNvZGUgZm9yIGl0Lg0KDQpTdXJl
LCBJIGdldCB0aGF0LiAgTXkgcG9pbnQgaXMgdGhhdCBpdCdzIG9mdGVuIG5vdCBjbGVhciB3aGV0
aGVyIGZvbygpIGFjdHVhbGx5IGNhbiBuZXZlciByZXR1cm4NCk5VTEwuICANCg0KSXQncyBiZWVu
IGEgd2hpbGUgc2luY2UgSSd2ZSBkdWcgdGhyb3VnaCB0aGUgUlBDIGNhbGwgY2hhaW5zIGluIE5v
dXZlYXUsIHNvIG15IG1lbW9yeSBpcyBhIGxpdHRsZQ0KaGF6eSBoZXJlLiAgSSBkbyByZW1lbWJl
ciBub3RpY2luZyB0aGF0IE5vdXZlYXUgZnJlcXVlbnRseSBoYXMgc2l0dWF0aW9ucyB3aGVyZSBm
b28oKSBjYWxsIGJhcjEoKQ0KYW5kIGJhcjIoKSwgd2hlcmUgYmFyMSgpIGNhbiByZXR1cm4gTlVM
TCBidXQgYmFyMigpIGNhbid0LiAgU28gdGhlIHF1ZXN0aW9uIGlzIG5vdCB3aGV0aGVyIGZvbygp
IGNhbg0KcmV0dXJuIE5VTEwsIGl0J3Mgd2hldGhlciBiYXIxKCkgc2hvdWxkIG5vdCByZXR1cm4g
TlVMTCwgb3Igd2hldGhlciBiYXIyKCkgc2hvdWxkLg0KDQo+IFNvLCBJIHRoaW5rIGl0IGlzIHRo
ZSByaWdodCBjYWxsIHRvIGFsaWduIHRoYXQgdG8gd2hhdCBmdW5jdGlvbnMgY2FuIGFjdHVhbGx5
DQo+IHJldHVybiwgYnV0IHdoaWxlIGRvaW5nIHRoaXMsIHRoZSBjb250cmFjdCBzaG91bGQgYmUg
cHJvcGVybHkgZG9jdW1lbnRlZCwgc3VjaA0KPiB0aGF0IHN1YnNlcXVlbnQgY2hhbmdlcyBjYW4g
YmUgcHJvcGVybHkgdmFsaWRhdGVkLg0KDQoiUHJvcGVybHkgZG9jdW1lbnRlZCIgYW5kICJOb3V2
ZWF1IiBhcmUgbm90IHR3byB0aGluZ3MgdGhhdCBnbyB0b2dldGhlci4gIA0K
