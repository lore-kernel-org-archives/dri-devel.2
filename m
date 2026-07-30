Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2A6C55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B8510E109;
	Thu, 30 Jul 2026 15:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qTT0C3vY";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021078.outbound.protection.outlook.com [52.101.65.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F0810E109
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 15:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFn18VQvJXggk5+AP3sjapa+r1LmEzp7B7c+wCDk8Ln2tmdQGnjSOWd0+ouEghPAxXZmGuc9++uH9BjtF8feLxB2PaJhBemgC5dBe0fs6l0snQbBzX0kbyjmEbYTFfqkhNFPiK1liIDW4CSX5hqM7kiyLztQYvRsgbopRqlxQCUwwncqqf9nlZpTTYPYI3RswqGxmE9FOsm3XhchS485sGBOsixE77T+yp+RYvOCbVanL9funU0MF1jh//l+NiN2k2svfEw7SUSeqs3UAiI3x3gGedZkRzE725fSCxhigXr05v4M7TKLz39NsB9UZFMtgNjnMm31UdSeHxI3W2UWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmh513wWebZn59aChzmWA0NP3wvrAsEtYFUmvKZHJ/I=;
 b=dteqUCw+wNPld4lp05LNQhEzwYIUunPkQuzBpQrrRy4BKxetJyl/dXHNeGRfFAWvWUQP1rclcMAZ/H1LpFbh7yBDcz0vftQwJYZ6Qk+np2DZGXA9EmbKLT2UwieeOTwTPliu8uNWfRE+kc6XWzYLliE23iDVE+4x9MdgUsxiyYbS2EEHCxe2iilwtF9CNvuhPWO0IxNeLSOjPSSwfrp2FQiwWKhphk/MZEY0I37n6NxS8krmje4tJKahqpNAOU/5KsIxN/Xt7uhNLtcUQPiqw3SzUcNjwNW6oMY/M1Heia/u3deFnSg8+dwTramV5y0DfWaOboXEX5oW+y0ws/Kw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmh513wWebZn59aChzmWA0NP3wvrAsEtYFUmvKZHJ/I=;
 b=qTT0C3vYECgYFeueFF1tuuAyKWFc5Cl5WxJiqQ7JHB6jn87HmwYE1OzpbNQrjWsnnv+hpcY78XLWAIPY8smEmDHKwOX05CIK/7mx8qZGFlaC2Sw/9GlIbdoOWosxe6e/264iMo1tncL39FhxdAgnuSpb59k1puVX52MsiEO7H0+xP+RMaZBp0oIIVZkBy1na+YRYbicZ+flCw+ZqPhI/KtPD27EpeqPZVEAIaBJ7UveYYE7oIIT4VsmZiqhlzm+KcH1LO+5d6ANdg6XA2WVnK/IO5o+zlj9Aij2lA1VxIU0MCFjnle4oGJRXsF/O1znBRJR5RAH44Q0sOvJ6fR+YMw==
Received: from AS5P195MB3381.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:753::12)
 by VI0P195MB2872.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2b7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 15:58:52 +0000
Received: from AS5P195MB3381.EURP195.PROD.OUTLOOK.COM
 ([fe80::9db1:9521:64ef:f6e8]) by AS5P195MB3381.EURP195.PROD.OUTLOOK.COM
 ([fe80::9db1:9521:64ef:f6e8%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 15:58:52 +0000
From: Dominik Haller <d.haller@phytec.de>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "y-d@ti.com" <y-d@ti.com>
Subject: Re:  Re: [PATCH v5 0/2] Add no-hpd property to the cadence bridge
Thread-Topic: Re: [PATCH v5 0/2] Add no-hpd property to the cadence bridge
Thread-Index: AQHdHpE/id4xDEumdEiuUX9RDy0JY7aDhlaAgACjxoCAAhFjAA==
Date: Thu, 30 Jul 2026 15:58:52 +0000
Message-ID: <932da41ee77340b54c7a02d0318698b9e201fafd.camel@phytec.de>
References: <20260728125336.776116-1-y-d@ti.com>
 <074a97451488f0e6d41afe968e9248399dffa88e.camel@phytec.de>
 <ce9bb75b-bba9-49c4-87d9-28b499aa6fb0@ti.com>
In-Reply-To: <ce9bb75b-bba9-49c4-87d9-28b499aa6fb0@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5P195MB3381:EE_|VI0P195MB2872:EE_
x-ms-office365-filtering-correlation-id: 5cbcc122-2318-4d16-5d98-08deee5373ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|23010399003|366016|4143699003|6133799003|11063799006|4133799003|38070700021|56012099006|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: 0ZBfTNEsM7s6nz0ePqb2pklH/0dcj4qGV6KAyXY6bfX1eiR84NKh88Fx8eYEFfk11MokBZZRrMcwSq0ek4f9aJW1K9AK/wQvX2SJeIbfIEXfCCPdlr4bF+K3FpeKkiEUACfE3IiqHK461XYvhD9fP8GxirIZ0Uyw6LKtZaX5LqWm4838gQTTX/r/JufMbzbJNmQoAyfDVT1wIjT8Iqp/RYaYCPTgwrT3xRDkbVw4JDpOdyzOf78ZYt0tQmawkIVcfNoeLEhaZM1lXQ0+p3U9gFGT3dWsRE5EK98uAS5zaCWrm6CP2Piwte/OgSX1odXmygB7NPl35aAmaQqtNAPoZxoZGEGjYiqi52Bq8lvOtIhFYOsSC9OKZ8YW+3NxH2TFB7+qh9w9BtaZyBZ3YwU/GG1ShIIbVlngDu6VAmuqDDYULp8iELPuh7WJGR5i/s/h8w5E/WA7QTRtIyPb6WyJ+fw5EW5dYu7yexVCBhaln9VcnFAfpftRdcF8FXtTIld+kFsF90E6W4eg5EJbzQemdiD438ubQ6lAKUy+RFb4trwM2qeyAT3/y685nUOuT8q8va9QcgpGLe1Hq8ZSZ6qhyAgf3ht+VoApFsO8OJQctafYryBiYbtoxGrLSBz3k4V6xdtGHiO+INNT3NqRdQMv0dvIvN4eW/8BgLoPRtdr5LM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5P195MB3381.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(4143699003)(6133799003)(11063799006)(4133799003)(38070700021)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG90ak5EOHAwQmdsZ2xDWUhBaHAyblVVNUZxUUFaT2orUDdnQ0FkVHl0K1h5?=
 =?utf-8?B?eVJUV0p2aytTNC9mcmprOEg2SXI0Y3h5bGNNV2htMlR6NDhiakRhVC84bTBn?=
 =?utf-8?B?QlJFcThjWUQxMHVObnJXNjNrOHRuV292cUp6VHBGK3JYSjltSWpKdjF5QWFZ?=
 =?utf-8?B?eEdaR3BMOTI5cVFXelpScWJ5MDB2eHc3UXdEQ0NuOEYwY2tBQU5LSS9aSkU0?=
 =?utf-8?B?YUJRNkJJRU5qL0d5c0t3Qm9OYi9TbkdxRlhReXhDdDVmT2RldDVnNkY1cDJE?=
 =?utf-8?B?c3A5QVUwV0FqRWZRVXV1Qlc0aUVRV01rb2hnNnF3VThqdlhtb3pKTjFMNmZ0?=
 =?utf-8?B?RHdvdjRKZWJCWUxFSVRGVHlkekFsUGZqUzZBRDB4ZStwUGhmc2pFbXJ1TEhP?=
 =?utf-8?B?TUF2RHpEZncwdFhVUmQ1enpMamVUdGRFQ21zVm1lcnlEaVlhc3F0dlY5aUxk?=
 =?utf-8?B?UlZSYVpZWllsVEN3WVZqZy9GR3NBZU9oTzN4NkZVc0F3WUpzY2w3dkZrWXE4?=
 =?utf-8?B?V280clZVZklZc1B1Q0dkOW92U1Yvb3pRTXB6cmRKRVpLWThYQTZMNTFiZUww?=
 =?utf-8?B?OUVjZTQzRnI4YnhtaWpXM0pCTmI4SXZLZlhHcHZ1d2twWkRoNm4yOXJILy8y?=
 =?utf-8?B?cXZyZ0d1Y1hZcnJib0JsMHBkWEZEWmtKamNxNnBxQkRVUk5xWkpHVi9mKzRs?=
 =?utf-8?B?dXBsaXdQYVUwWGVCNFJIY0IyK0l3YXNBQU9Rbm9xdXhzRVZsU2pnZEovSDZY?=
 =?utf-8?B?N29tR2oyamtVRXBvd004c3BjSVJqekFkNDY5NDI2R3pLVTIyTHNBV1M0b3BF?=
 =?utf-8?B?a0hvSHk1TExZU1pGUUNOanppY2crenBlMUNHaTg3SlBHTGZ1T0REVXdqMTFq?=
 =?utf-8?B?OWdtYTRNNGpvTDNUZDdSSXpDZHBNdG8rUTREb1V0TW1ocmJwVStWTDdQKzVs?=
 =?utf-8?B?cW1yaHhFWEFhV2d1VEwxQzl5WWJmdnlWR2VPd3Fxc0E4cTNlUGg4WG4ydHpJ?=
 =?utf-8?B?TjJUVDE4L0wwUzNQbnNDR2NyUGZRZWgvUkh4N3k3ZEFsZGdVcXlSTU5XcFRu?=
 =?utf-8?B?b1llYmFkTzhNMGRTa3J4ajA5aTZLM3ZicHJpV0dqaGlDNWZkOEJ2Ty91Uk1E?=
 =?utf-8?B?SHdZTkpXT3djdUExZ05UakhIL1JWL1kyYTh6eUhmMWNLTElTRDBMZThGV3ZO?=
 =?utf-8?B?SzRQTVpoQlFZcGNCUm5uWWk4aUlGYmgwTy9mbjBJQ1o1TTZ5UHdLazF6Z2Zh?=
 =?utf-8?B?ZXNCcmxXVzk3dCtPN251Vy9GSzgvdWZGV0liRWVEcVlwcCt6dkk2bHhvZ2Yw?=
 =?utf-8?B?cEtuOEo4Qk5JT2xPNnRKUjN5VXdzbi94alZYbFpjTnlkN0lnZWtFU05VbkRp?=
 =?utf-8?B?V1FXak9JSk1idXZGS1BKTVNXYW9DZldmck5CNWt6OGozT2NqVVdrQW91RFZU?=
 =?utf-8?B?SGNDdEhYQ0l2QjZUdkRUT2taYWxZR2JoV3FMazM4N0pJTnZvMzl3aklsTVV4?=
 =?utf-8?B?RDFvbEdJb2djYnIwMjlOMmJMVjFrdkFRTmxjQkRteGx4N2NHa0crQmI3Ty9R?=
 =?utf-8?B?RVpoMWNkWHZNVHo1aERya1lpSjMyM0JkS1NzMElEb1U5MWFYdG5talhzK1pX?=
 =?utf-8?B?d3J5U2JacnpWekZZNmRkakN2dXo5dW82NnhlUVdHUWcvVUtUQlZmNWl6L3dW?=
 =?utf-8?B?Q09oQXIxSEV5RkY3bGRMUHZUUWUzczM4SVdoRDFlOEU5ditqcjAwb2NDeXFO?=
 =?utf-8?B?MnFaUit0YkJQcTZZQm4wZUd3UG5ScjFFbkpGUjN2S3R1K01xUkxQYUJRNnRm?=
 =?utf-8?B?U1M2WTJkRDBtTkFrVG44ajFXMGtuaGNWQmd4bEVYTE9BOTM4a29oYW1rVW43?=
 =?utf-8?B?Kzc2bTF6Q2F6Q0l5NERNM3hGU0VZandocEdMR29EZmZWNi9aUnE0d2RjQXpn?=
 =?utf-8?B?aTNaeDFDQlMyOVNuZDJzcTlTZjNkOEY4T25YWGh1bncwYy81Q3RtZzB2OWl0?=
 =?utf-8?B?YjJKdkFLVGtxV2pFZ091cThLcWgrc1RqSXpOb3ZmbUI4OGMzOU4zSHpVcGxU?=
 =?utf-8?B?c0d3a2krajU4emRqbCtoOHJlZiswU2t2c3BMcXVMY0dUR2RGNmFSV05RdFBY?=
 =?utf-8?B?c0dmVFVlQU5FKzdCM2diemJ6T2RuNFZZc2pLTUREM1ZLRGVJbkRQdEdNQXdP?=
 =?utf-8?B?REZqQjlCR1NPWXJzV0ZQa0xndURNZjZFYkRrak02UlYxK0xKdzE3L2IvQUZT?=
 =?utf-8?B?azJHMmdSRHRyMW9OKzhNdjVNMVZYeVd2cndHTW1SaFFGbGNudXZSZG50d3FC?=
 =?utf-8?B?MlpBUDVtYXlMUS90a2lEOFF3d3B5ZGsxQ0w1MnFSRTcwREgzSHUvdjltVEFZ?=
 =?utf-8?Q?bQBdRb/Qrw92raP2q1/zB/H2/spQYckhrpQyH5FqT+rGC?=
x-ms-exchange-antispam-messagedata-1: P1GsW62EbXMxCg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9309FC3D72CE7B47ABCD6D19E9A3E869@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5P195MB3381.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbcc122-2318-4d16-5d98-08deee5373ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 15:58:52.7550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDG4nlAkGkakG4FUKtSNKriVxZGPosXiKZZ49BDr6YOxwI0ktn0F9BLr+vIwLu0n0hSNG/HMKCt7lvqgUyatTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2872
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

T24gTWksIDIwMjYtMDctMjkgYXQgMTM6NTQgKzA1MzAsIFlhc2hhcyBEIHdyb3RlOg0KPg0KPg0K
PiBPbiAyOS8wNy8yNiAwNDowNywgRG9taW5payBIYWxsZXIgd3JvdGU6DQo+ID4gT24gRGksIDIw
MjYtMDctMjggYXQgMTg64oCKMjMgKzA1MzAsIFlhc2hhcyBEIHdyb3RlOiA+IFRoaXMgc2VyaWVz
DQo+ID4gYWRkcw0KPiA+ICduby1ocGQnIGRldmljZSB0cmVlIHByb3BlcnR5IHN1cHBvcnQgdG8g
dGhlIENhZGVuY2UgPiBNSERQODU0Ng0KPiA+IGJyaWRnZQ0KPiA+IGRyaXZlciBmb3IgYm9hcmRz
IHdoZXJlIHRoZSBIUEQgbGluZSBjYW5ub3QgYmUgdXNlZCA+IGZvciA+IGhvdHBsdWcNCj4gPiBk
ZXRlY3Rpb24uID4gPg0KPiA+DQo+ID4NCj4gPiBPbiBEaSwgMjAyNi0wNy0yOCBhdCAxODoyMyAr
MDUzMCwgWWFzaGFzIEQgd3JvdGU6DQo+ID4gPiBUaGlzIHNlcmllcyBhZGRzICduby1ocGQnIGRl
dmljZSB0cmVlIHByb3BlcnR5IHN1cHBvcnQgdG8gdGhlDQo+ID4gPiBDYWRlbmNlDQo+ID4gPiBN
SERQODU0NiBicmlkZ2UgZHJpdmVyIGZvciBib2FyZHMgd2hlcmUgdGhlIEhQRCBsaW5lIGNhbm5v
dCBiZQ0KPiA+ID4gdXNlZA0KPiA+ID4gZm9yDQo+ID4gPiBob3RwbHVnIGRldGVjdGlvbi4NCj4g
PiA+DQo+ID4gPiBPbiBUSSBKNzIxUzIgRVZNcywgdGhlIEhQRCBzaWduYWwgaXMgcm91dGVkIHRv
IFNvQyBwaW4gQUEyNA0KPiA+ID4gKE1DQVNQMV9BQ0xLWC9EUDBfSFBEKS4gVGhpcyBwaW4gaXMg
bXV4ZWQgd2l0aCB0aGUgTWNBU1AxIGF1ZGlvDQo+ID4gPiBiaXQNCj4gPiA+IGNsb2NrOyBzZWxl
Y3RpbmcgRFAwX0hQRCBicmVha3MgYXVkaW8uIFRoZXJlIGlzIG5vIGFsdGVybmF0aXZlDQo+ID4g
PiBwaW4NCj4gPiA+IGNhcnJ5aW5nIHRoZSBIUEQgc2lnbmFsIHdoaWNoIG1ha2VzIGl0IGltcG9z
c2libGUgdG8gdXNlIEhQRA0KPiA+ID4gd2l0aG91dCBsb29zaW5nIHRoZSBhdWRpbyBjYXBhYmls
aXRpZXMuDQo+ID4gSGkgWWFzaGFzLA0KPiA+DQo+ID4gdGhpcyBkZXNjcmlwdGlvbiBpcyBub3Qg
Y29ycmVjdC4gT24gdGhlIEo3MjFTMiBFVk0gdGhlIHBpbiBBQTI0DQo+ID4gTUNBU1AxX0FDTEtY
IGlzIG5vdCB1c2VkIGZvciBhdWRpby4NCj4gPiBUaGUgcGluIGlzIGp1c3QgZmxvYXRpbmcgdW5s
ZXNzIHRoaXMgIkdFU0kiLWJvYXJkIHdpdGggYW4NCj4gPiBhZGRpdGlvbmFsDQo+ID4gZXRoZXJu
ZXQgaW50ZXJmYWNlIGlzIGNvbm5lY3QuIEFBMjQgaXMgdXNlZCBhcyBhcw0KPiA+IE1DQVNQMV9B
Q0xLWC5SR01JSTFfUkQwIGluIHRoaXMgY2FzZS4NCj4gPiBTZWUgYXJjaC9hcm02NC9ib290L2R0
cy90aS9rMy1qNzIxczItZXZtLWdlc2ktZXhwLWJvYXJkLmR0c28NCj4gPg0KPiA+IEFsc28gdGhl
IEFBMjQgcGluIG5lZWRzIHRvIGJlIGNvbmZpZ3VyZWQgYXMgSFBEIHBpbiAobXV4bW9kZSAzKQ0K
PiA+IG90aGVyd2lzZSB0aGUgbWhkcCBmaXJtd2FyZSB3aWxsIG5vdCB0dXJuIG9uIHRoZSBicmlk
Z2UuDQo+ID4NCj4gPiBEb21pbmlrDQo+ID4NCj4gPg0KPg0KPiBIaSBEb21pbmlrLA0KPg0KPiBZ
b3UgYXJlIGNvcnJlY3QsIEkgYXBvbG9naXNlIGZvciB0aGUgZXJyb3IuIFRoZSBTb0MgUEFEIG11
eCBjb25mbGljdA0KPiBvbiBBQTI0IGlzIHdpdGggUkdNSUkxX1JEMCAoR0VTSSBldGhlcm5ldCBl
eHBhbnNpb24gYm9hcmQpLCBub3QNCj4gTUNBU1AxDQo+IGF1ZGlvLiBJIHdpbGwgZml4IHRoZSBj
b21taXQgbWVzc2FnZS4NCj4NCj4gVGhlIGZ1bGwgcGljdHVyZSBvbiBKNzIxUzJYLVBNMS1TT00g
cmV2IEUyOg0KPg0KPiAtIFRoZSBIUEQgcmVzaXN0b3IgaXMgRE5JIGZyb20gZmFjdG9yeSwgc28g
QUEyNCBpcyBub3QgcGh5c2ljYWxseQ0KPiAgICBjb25uZWN0ZWQgdG8gdGhlIERQIGNvbm5lY3Rv
ciBIUEQgbGluZSBieSBkZWZhdWx0LiBIb3dldmVyIEFBMjQNCj4gbXVzdA0KPiAgICBzdGlsbCBi
ZSBjb25maWd1cmVkIGluIERQMF9IUEQgbXV4IG1vZGUgKG1vZGUgMykgZm9yIHRoZSBNSERQDQo+
IGZpcm13YXJlDQo+ICAgIHRvIG9wZXJhdGUgYXQgYWxsIOKAlCBjb25maWd1cmluZyBpdCBpbiBh
bnkgb3RoZXIgbW9kZSBwcmV2ZW50cyB0aGUNCj4gYnJpZGdlIGZyb20gbG9hZGluZy4NCj4NCj4g
LSBXaGVuIHdlIHBoeXNpY2FsbHkgY29ubmVjdGVkIEhQRCBieSBwb3B1bGF0aW5nIHRoZSByZXNp
c3RvciwgdGhlIEUyDQo+ICAgIGJvYXJkIGZhaWxlZCB0byBib290IHdpdGggYSBtb25pdG9yIGF0
dGFjaGVkLiBUaGUgSFBEIGxpbmUgbGVha3MNCj4gdm9sdGFnZQ0KPiAgICBmcm9tIHRoZSBtb25p
dG9yIGludG8gdGhlIFNvQyB3aGlsZSBwb3dlcmVkIG9mZiwgY2F1c2luZyBhIFBNSUMNCj4gZXJy
b3IuDQo+ICAgIFRoaXMgd2FzIGZpeGVkIGluIHJldiBFMysgd2l0aCBhbiBIUEQgYnVmZmVyLiBP
dXIgYm9hcmRzIGFyZSByZXYNCj4gRTIuDQo+DQo+IFRoZSBhdWRpbyBjb25mbGljdCBpbiBlYXJs
aWVyIG1lc3NhZ2UgdmVyc2lvbnMgd2FzIG91ciBtaXN0YWtlLiBJdA0KPiBjYW1lIGZyb20gaW52
ZXN0aWdhdGluZyB3aGV0aGVyIGFuIGFsdGVybmF0aXZlIHJvdXRpbmcgcGF0aCB0aHJvdWdoIGEN
Cj4gYm9hcmQtbGV2ZWwgc2lnbmFsIE1VWCBjaGlwIChNVVgxL01VWDIpIG9uIHRoZSBTT00gY291
bGQgZXhwb3NlIGENCj4gR1BJTw0KPiBmb3IgSFBEIOKAlCBjaGFuZ2luZyB0aGF0IE1VWCdzIHBv
cnQgc2VsZWN0aW9uIHdvdWxkIGhhdmUgYWZmZWN0ZWQNCj4gYXVkaW8uDQo+IFRoYXQgaXMgdW5y
ZWxhdGVkIHRvIHRoZSBTb0MgUEFEIG11eCBhbmQgc2hvdWxkIG5vdCBoYXZlIGJlZW4NCj4gbWVu
dGlvbmVkLg0KPg0KPiBJIHdpbGwgZml4IHRoZSBtZXNzYWdlIGFuZCBzZW5kIGEgbmV3IHZlcnNp
b24uDQpIaSBZYXNoYXMsDQoNCnBsZWFzZSBhbHNvIHVwZGF0ZSB0aGUgY29tbWl0IGRlc2NyaXB0
aW9uIG9mIHRoZSBhY3R1YWwgcGF0Y2ggMi8yIGFzIGl0DQppbXBsaWVzIGF0IHRoZSBtb21lbnQg
dGhhdCB5b3UgY2FuIHVzZSB0aGUgQUEyNCBwaW4gZm9yIG90aGVyIGZ1bmN0aW9ucw0Kd2hpbGUg
dXNpbmcgdGhlIGRpc3BsYXkgcG9ydC4NCg0KVGhhbmtzDQoNCkRvbWluaWsNCj4NCj4gVGhhbmtz
LA0KPiBZYXNoYXMgRA0KPg0KPiA+ID4gV2hlbiAnbm8taHBkJyBpcyBzZXQsIERSTV9CUklER0Vf
T1BfSFBEIGlzIG9taXR0ZWQgc28gdGhlDQo+ID4gPiBmcmFtZXdvcmsNCj4gPiA+IGZhbGxzIGJh
Y2sgdG8gcG9sbGluZyAuZGV0ZWN0KCkgZXZlcnkgfjEwIHNlY29uZHMuIE1vbml0b3INCj4gPiA+
IHByZXNlbmNlDQo+ID4gPiBpcw0KPiA+ID4gZGV0ZXJtaW5lZCB2aWEgQVVYIERQQ0QgcmVhZHMg
aW5zdGVhZCBvZiBmaXJtd2FyZSBIUEQgc3RhdHVzDQo+ID4gPiByZWdpc3RlcnMuDQo+ID4gPiBU
aGUgLmRldGVjdCgpIGNhbGxiYWNrIGRyaXZlcyBjZG5zX21oZHBfdXBkYXRlX2xpbmtfc3RhdHVz
KCkgb24NCj4gPiA+IGVhY2gNCj4gPiA+IHBvbGwgdG8ga2VlcCBtaGRwLT5wbHVnZ2VkIGN1cnJl
bnQuIEF0IGF0dGFjaCB0aW1lLCB0aGUgZHJpdmVyDQo+ID4gPiB3YWl0cw0KPiA+ID4gZm9yIGZp
cm13YXJlIHRvIGJlIHJlYWR5IGJlZm9yZSBwZXJmb3JtaW5nIHRoZSBpbml0aWFsIEFVWCBwb2xs
DQo+ID4gPiBzaW5jZQ0KPiA+ID4gbm8gaW50ZXJydXB0IHdpbGwgdHJpZ2dlciBpdC4NCj4gPiA+
DQo+ID4gPiBDaGFuZ2VzIHNpbmNlIHY0Og0KPiA+ID4gLSBDb3JyZWN0ZWQgdGhlIGR0LWJpbmRp
bmcgU3ViamVjdA0KPiA+ID4NCj4gPiA+IExpbmsgdG8gdjQ6DQo+ID4gPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvDQo+ID4gPg0KPiA+IGFsbC8y
MDI2MDYzMDEwMjYxMC4xODQ5OTAyLTEteS1kQHRpLmNvbS9fXzshIUczdkshDQo+ID4gWEtldFNK
aFRKelN6bk1UQmVvd3c2M2J2WFNQRDN4cldzdFJyZjRINkFobnJNNUlqSXZORmE5dUhWVldFWVBF
b2UwRw0KPiA+IE5yWlhHYjhJRiQNCj4gPiA8aHR0cHM6Ly9ldXIwMi5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGDQo+ID4gdXJsZGVmZW5zZS5jb20l
MkZ2MyUyRl9faHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZhbGwlMkYyMDI2MA0KPiA+
IDYzMDEwMjYxMC4xODQ5OTAyLTEteS0NCj4gPiBkJTQwdGkuY29tJTJGX18lM0IhIUczdkshWEtl
dFNKaFRKelN6bk1UQmVvd3c2M2J2WFNQRDN4cldzdFJyZjRINkFoDQo+ID4gbnJNNUlqSXZORmE5
dUhWVldFWVBFb2UwR05yWlhHYjhJRiUyNCZkYXRhPTA1JTdDMDIlN0NkLmhhbGxlciU0MHBoeQ0K
PiA+IHRlYy5kZSU3Q2UxZTUzMTgyMjY4YTRkZjgxZDE5MDhkZWVkNGFkYTRiJTdDZTYwOTE1N2M4
MGUyNDQ2ZDliZTM5YzkNCj4gPiA5YzIzOTlkMjklN0MwJTdDMCU3QzYzOTIwOTEwMjkwOTc1NjY3
OCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGDQo+ID4gYlhCMGVVMWhjR2tpT25SeWRXVXNJ
bFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRg0KPiA+IHBiQ0lz
SWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9MlRIM2R4JTJGaXJuRUtVY0hGdTl2
T3olMkYNCj4gPiBaVDlKU3lmY3lNcCUyQkRqUVBEVUMlMkYwJTNEJnJlc2VydmVkPTA+DQo+ID4g
Pg0KPiA+ID4gUmFodWwgVCBSICgyKToNCj4gPiA+ICAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IGJy
aWRnZTogY2RucyxtaGRwODU0NjogQWRkIG5vLWhwZA0KPiA+ID4gcHJvcGVydHkgdG8NCj4gPiA+
ICAgICB0aGUgY2FkZW5jZSBicmlkZ2UNCj4gPiA+ICAgZHJtOiBicmlkZ2U6IGNkbnMtbWhkcDg1
NDY6IEFkZCBuby1ocGQgcHJvcGVydHkNCj4gPiA+DQo+ID4gPiAgLi4uL2Rpc3BsYXkvYnJpZGdl
L2NkbnMsbWhkcDg1NDYueWFtbCAgICAgICAgIHwgMTcgKysrKysrDQo+ID4gPiAgLi4uL2RybS9i
cmlkZ2UvY2FkZW5jZS9jZG5zLW1oZHA4NTQ2LWNvcmUuYyAgIHwgNTgNCj4gPiA+ICsrKysrKysr
KysrKysrKystDQo+ID4gPiAtLQ0KPiA+ID4gIC4uLi9kcm0vYnJpZGdlL2NhZGVuY2UvY2Rucy1t
aGRwODU0Ni1jb3JlLmggICB8ICAxICsNCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDY5IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+DQo+DQoNCg==
