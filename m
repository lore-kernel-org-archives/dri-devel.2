Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9FBC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B39B10E09E;
	Wed, 19 Aug 2026 08:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=analogixsemi.com header.i=@analogixsemi.com header.b="IsMPBpbu";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11020088.outbound.protection.outlook.com [52.101.85.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C8A10E09E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J80gz/OlcYrvqR/F2LW8XB20pxrU9puodi3UYU/wVx10Zt9hq0PwI0wpZ0nZdaUDQub8XMzYmAE/Cm3gjN9ZV2C1DBkXD7QYxBP8uGAliSr566qEGjlhe9bRG7m7wUoP+Vyl8cHkx9IUeWAF/OYPsOZNFDVc+Fc464Np611T2xqQHNX3SsVFL60vJ5t3TFzwCqtGQGdpCadp23gbHqsLVq8DVPZCLUESlxjHimaeUyStFvquQMog97kDndl6RAF9SUmXBcqOIacS7dDTkKtnXsFyXTTYh1jHqCgufmGLQaUa3F4qm0h1TWDFOAcE3yXQmGxgWNOXIhVnA7CwPzcgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9u1HiqM3ghBkJDRXP0enlz5fZlWNqxp4a+hHkIMtqY=;
 b=AQA+tNICpRg7c2zWknowODpFfLNj1qhxEh2Opau4sK9Efux+LxEHapU/2Q2Ooi1uWx4tGgiZ+hCbooZnyetFpo/H/k8pTUhqdC1gqk9bb2Gj1RoXNyXEP7oX3F/EEKW8mIUb34iH89fB3UBRXcSAKxzfyUO+B1BM1OYQ6k9+lt0Ve9uvk+8QVpreUgqXe1QzZKOpP1Nf/iogCutd9z9xF4NPpC4wMh8CVa3BGj4Ng4tmyOI13lBz90tBhSdJ2dxqbXDM+mURTfpRQ+3CswyVUHde2qkl69ZPFf7NGXCX2kFIRUGjQaKAfHhGLP1/00+EXKFvhRS3o2JB9eSPxfCY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9u1HiqM3ghBkJDRXP0enlz5fZlWNqxp4a+hHkIMtqY=;
 b=IsMPBpbuP0WqymA+HDTa5t77Lod/9XbMg/B0ZSwQ9DwYrgT5q4nc460h10xPNON2BSGameWeNrU2Hgiqty/lcDIcH0MYsPUzAIDqpQRz3qF4lr76GRmPp0cuj4Za206EwqCuvw2+07qPzFYD5veqCRaTBRhiW8KeVtZ0TZKD7uk=
Received: from DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15)
 by SA6PR04MB9543.namprd04.prod.outlook.com (2603:10b6:806:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 08:12:49 +0000
Received: from DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c]) by DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 08:12:48 +0000
From: Xin Ji <xji@analogixsemi.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add right justify
 property
Thread-Topic: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add right justify
 property
Thread-Index: AQHdLrYssVSLx0E5+U6dyVM75xkZp7ajEJGAgAH2zjA=
Date: Wed, 19 Aug 2026 08:12:48 +0000
Message-ID: <DM6PR04MB69700C246B6CF8ED6EBF16DFC7A52@DM6PR04MB6970.namprd04.prod.outlook.com>
References: <20260818020559.961335-1-xji@analogixsemi.com>
 <20260818021219.DCA4A1F000E9@smtp.kernel.org>
In-Reply-To: <20260818021219.DCA4A1F000E9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6970:EE_|SA6PR04MB9543:EE_
x-ms-office365-filtering-correlation-id: 78706bfa-b3f0-47d5-7f4e-08defdc9a81f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: zOgHJf3S9hCbj+JQxap24RBUXKH9L0LLAfqOive0nEm2fzyRVXUs+ryNTQ0oqPuZXz3I2Bt3RMMzEpiBBap1ztcx9ujc7tgq+InSvtJmmpSnP2hcwtnup8C6slqsy/HkUjaOXHkFOs0uylYLz74TwF16rIw948dIWWWtPxV0v7swtfCloyhvD3BzspTA+5tuUKjb9LOBLj4O6n3XrKxiCYYPch6YjHXSI1fsLFTDYtOVGM1zcG0dUeCMo439ikU4e7jBOrDbX0YU/GGpPPwhBcX0/JoVkOHLrulFSWTV4F8FdMMQduldkGiNoAL1nr/D8DRW6MN+uWOMBr2LGA699fryePG0knN3HCo4nqDIZJhPddmSQPQ2LJhaL2rVypW4cUNqJ/9SKcUypCKChXzMSpRSsoAncAHKnH64Ci98LGqeYAOYOxla3kMd+Mx61ceU2SGswRajP9uEHXCYwZg4UlY8Q+Uu/mkaeog1IOB/rp7oFXxdfaLWGitvo7hXbSQKFxeuZ1TTh9rjpoM+TwtMTokPdhZyhCCs//FvX7+rQDfZP5gearHxOt9M9dkGK0d2c7JeKnEv9v4dmPLCeYdxsG3oXCFAyLPBwQgkqclpNp9/rX7/VJBTNYxRzqRVUwgNTPmCD96ZIAyCvw9GXn7gUwcg4UDI2ETmmJK6i5FzeX8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DM6PR04MB6970.namprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnRSUjAzQTR6eFU1VEhlZmROUzVKMTBOQVBaUXNRVFRkSkhXd2JXK2NGZUx4?=
 =?utf-8?B?OWx5Uy9FSmdCUU5XM3c0MW02VkwxQTJCb2tLVmZSL0lTR2IxOTgrbVg2dXkv?=
 =?utf-8?B?enFwZ043TVJJZWNob1dabVRjdmlqTC9XeXRKTmRPcjJZeVQxZlRkRnJidDdU?=
 =?utf-8?B?ZWJkS0ZadkN2NnI1eUNhK20zc3FRUHZDYXlqTEpHd1JoZW1heDU3dU5zbVMv?=
 =?utf-8?B?MC91VitDWE1vR1llRFIvMzZlaDA2TzIzNE1YT3hQb2t1dVZNSGUwRjZyd1VR?=
 =?utf-8?B?QkN5ZlIzL0JlckhjQkk5aE1JNlk4VUNFNVVaTlhDdmtLQ2JIa1g5V0pIazlC?=
 =?utf-8?B?NS9OMStvNk5Pd2MrbVRBY3NhbVZ0YjRiR3Q3V1RTTUJEaFlmTkU1aXkxUDFv?=
 =?utf-8?B?WTJMakcvbjVBZkhSS2ozS1piZ3RkNUtCakx0Q3BiS2g5U0xjcGF1RXJlYXh6?=
 =?utf-8?B?RG5qSUYyMDFvK0pWdUV6Umc0bk51Y0loOVpXZXBkQWt3VTRYNmVSUTR5UFJS?=
 =?utf-8?B?dEVraWNGbUFwSDhmVXpjQzVWVUVhakNlOFVxOFFUOTNJQlByQXpNYUt0QkZi?=
 =?utf-8?B?ODZaT1JhRnhqdjVSZ0tUU3VRRUo5NXA4TEVqYWNjeUFOVkViYytXQzVJenhT?=
 =?utf-8?B?TGVnN2ovS2F2QVU0Q3llblkxT0w3WXdhY3FOam0xRUJQZXYwcnNWVndLK1Qy?=
 =?utf-8?B?NlNYcEFEZElsV1NSbTcza3RueHRNa1o4ZXM3dHY3b21JbHUxY3p3UDI1eW4w?=
 =?utf-8?B?RmdhMEtwZWV3QXVXNmJ3NHFMcGxXMzRIME5PalNGUStwMmRZKzh1MjhVOEJv?=
 =?utf-8?B?TStRWmwwU0RVOEJ3RVRHNzNuaitjdXJlYjkvR1pnb0xpRDE3L2FWeWtHVTBn?=
 =?utf-8?B?Wm1Vb0ZQRFFlK2tXa25wTFZZYk9pbExVRElPV3B1OUZCR3lnZm5UK2RYcUs3?=
 =?utf-8?B?ejhZcjl1eGVFZG9jSmxNcW9BdUppcFRSYUYxTTZ4TmhlYlZVRkp4YUpncjFu?=
 =?utf-8?B?MmcwNkRYVE1WL3RLRU5vYzVldDQ1Wk11aWVBZVVKYUdJaDR2UXZLd0NCWlpP?=
 =?utf-8?B?emkrQkRUSVpCQk5JU0NybHFqR3AvNnFEZ0hRSFNEZVp3RmVLOVl4Zjlselk4?=
 =?utf-8?B?NWNyNHBOajVKR21mbjRmckZ4MUszUzZucXNHdEhnNElpUzE1UjVjaWEwMFBU?=
 =?utf-8?B?ZlE1TStyRnQwL3hXMnpvV2xWUDlBZFpLV2x0dDF1dlpkSEZQTjJweVhSaE1M?=
 =?utf-8?B?UWlVWTMrZkRoSTl6cUsrOUNqVnhpcnRDQ3dIMmRBWGs0TW9URUlDNG4wNkRj?=
 =?utf-8?B?NTd1ekNyaFpOWCtnS2RPblhIU3hpSTBCRkRNTFhzcm9LczlZdDVRVUEzV25O?=
 =?utf-8?B?amxZdTl5OHp0d2hNS2tPSUlZNUJ1R0dNYUNCRFNTYUgrSjkzRjdCTjlTWUh5?=
 =?utf-8?B?T0lqQ1haWjhvcU9KMnFWZjBDRW00cldzQWRoMFZnV1NLVk4wM1VPcFRadGR4?=
 =?utf-8?B?ZFpVYm04am95dU5ydFEvTGJoQktab0dacEQzVTZpcHcxRlBVaUoyYXVmSGtx?=
 =?utf-8?B?N2ZVYzFrS3NTdUtESHFNMlZmNjR4SDkzOHIrOXhVeGxVNFJzMmhRK05HcjBr?=
 =?utf-8?B?OXA4ZTVsbUw4djBNY1NVWWM5aEx3YjhmdkptaVBSQjFpdHVmQitoVEluVnU5?=
 =?utf-8?B?a1JnR282eWpHVWtEYXlIcDJ3dUNKRElVZW0zWlAwQUhVSVVqK0xHOW9iaThH?=
 =?utf-8?B?dTlnTFJ1TXR1cUhkSHBpSVRLZXBsemZ4dUd5VFBzeVJCRXRmdU1vUVUxeE1D?=
 =?utf-8?B?QXdnaUR5SnRqUGcwTFRFckRoRnlkOEhjUytmZXZhdGhtQ2xRdjFORnArNXpr?=
 =?utf-8?B?b1J3ZXlIUk1Vc2ZhekhkY2Npa2VpYjFtR2MzVGxIa1hUV3dmWGg5MnhsMmJX?=
 =?utf-8?B?aUJOUzNVU0dOUXY0Y1NGQkI5cytMM0xBRnE2WmxYRUFvK2FiSXp6Y2libmpa?=
 =?utf-8?B?ZUtoZlVNUjdLZ1NjTU9aVGtFMVRzcmdGZzk0aFlxY3V3VGQ1VkVkMFp5Yk5a?=
 =?utf-8?B?emVKYnhTTVN3clJhdzhpcSs1aWdzT1JNMkxxVy84UmNhVVdvU0JNUUgwZ3g4?=
 =?utf-8?B?dW8rd3FySFBFTEw4RHU1T3ZFVkhYTEVHKzBiRHBZcWFqblR1Ynh1WVkwc2Zx?=
 =?utf-8?B?MGZUL3Q1RHNpRzdyemxpQmFXdEpWQ1c5aXFxNkloRjRZOFViUFhQWGFJWXYv?=
 =?utf-8?B?T1VHRnJRNDJMMlNjSmJ6eW1lcXJWbklUcWgwWTFHOHIvVlkzTjlhNFZlKzV3?=
 =?utf-8?B?Y3A2a2dZd3NIODQ2K0xSU2lTUUJUWkR4NUprSGZ6aVd1TEsyQVF2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6970.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78706bfa-b3f0-47d5-7f4e-08defdc9a81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 08:12:48.3856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+tEQtCyXvUIKCVQhupYWfRT9GG2Zo+iayX/NfnEpVoMzU4acW0Gjy9kQo5PWsMrWl2XAia4b5ZDRmTD0LC0lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9543
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

T0ssIEknbGwgdHJ5IHRvIHVzZSBmbXQgSERNSV9SSUdIVF9KDQoNCj4gDQo+IFRoYW5rIHlvdSBm
b3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50aWFs
IGlzc3VlKHMpDQo+IHRvIGNvbnNpZGVyOg0KPiAtIFtNZWRpdW1dIEFkZGluZyBhIHZlbmRvci1z
cGVjaWZpYyBEVCBwcm9wZXJ0eSBmb3IgYXVkaW8gaW50ZXJmYWNlIGZvcm1hdA0KPiBieXBhc3Nl
cyBzdGFuZGFyZCBBU29DIERBSSBmb3JtYXQgbmVnb3RpYXRpb24uDQo+IC0tDQo+IA0KPiAtLS0g
UGF0Y2ggWzFdOiBbUEFUQ0ggMS8yXSBkdC1iaW5kaW5nczogZHJtL2JyaWRnZTogYW54NzYyNTog
QWRkIHJpZ2h0IGp1c3RpZnkNCj4gcHJvcGVydHkgLS0tIFBsZWFzZSBub3RlIHRoYXQgZHVlIHRv
IHJlY2l0YXRpb24gcmVzdHJpY3Rpb25zLCBJIGNhbm5vdCBxdW90ZSB0aGUNCj4gb3JpZ2luYWwg
cGF0Y2ggY29kZSBkaXJlY3RseS4gVGhlIHJldmlldyBiZWxvdyBpcyBwcm92aWRlZCBhcyBhIGZy
ZWUtZm9ybQ0KPiBzdW1tYXJ5IG9mIHRoZSBmaW5kaW5ncy4NCj4gDQo+IGNvbW1pdCBjN2Y3NWY0
Yjc4NTQ3MGJhNDViNDIxMzI0MjY2MjczZjUxNDJkYTBiDQo+IEF1dGhvcjogWGluIEppIDx4amlA
YW5hbG9naXhzZW1pLmNvbT4NCj4gDQo+IGR0LWJpbmRpbmdzOiBkcm0vYnJpZGdlOiBhbng3NjI1
OiBBZGQgcmlnaHQganVzdGlmeSBwcm9wZXJ0eQ0KPiANCj4gVGhpcyBjb21taXQgYWRkcyBhIG5l
dyBib29sZWFuIHByb3BlcnR5IHRvIHRoZSBhbmFsb2dpeCxhbng3NjI1IGRldmljZQ0KPiB0cmVl
IGJpbmRpbmdzLiBUaGUgcHJvcGVydHkgY29udHJvbHMgd2hldGhlciB0aGUgZHJpdmVyIGVuYWJs
ZXMgdGhlIGF1ZGlvDQo+IHJpZ2h0IGp1c3RpZnkgZnVuY3Rpb24gZm9yIHRoZSBkYXRhIHN0cmVh
bS4NCj4gDQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBEb2VzIGFkZGluZyBhIHZlbmRvci1zcGVj
aWZpYyBkZXZpY2V0cmVlIHByb3BlcnR5IGZvciB0aGUgYXVkaW8gaW50ZXJmYWNlDQo+IGZvcm1h
dCBieXBhc3MgdGhlIHN0YW5kYXJkIEFTb0MgREFJIGZvcm1hdCBuZWdvdGlhdGlvbj8NCj4gDQo+
IFRoZSBzdGFuZGFyZCBoZG1pLWNvZGVjIGZyYW1ld29yayBhbHJlYWR5IHN1cHBvcnRzIHJpZ2h0
IGp1c3RpZmllZCBmb3JtYXRzDQo+IHVzaW5nIHRoZSBleGlzdGluZyBEQUkgZm9ybWF0IHN0cnVj
dHVyZXMsIHdoaWNoIGFyZSBub3JtYWxseSBwYXNzZWQNCj4gZHluYW1pY2FsbHkgdG8gdGhlIGRy
aXZlcidzIGh3X3BhcmFtcyBjYWxsYmFjayBiYXNlZCBvbiBzdGFuZGFyZCBzb3VuZA0KPiBjYXJk
IHByb3BlcnRpZXMuDQo+IA0KPiBDcmVhdGluZyBhIGN1c3RvbSBwcm9wZXJ0eSBsaWtlIGFuYWxv
Z2l4LGF1ZGlvLXJpZ2h0LWp1c3RpZnktZW5hYmxlIGhhcmRjb2Rlcw0KPiB0aGlzIGNvbmZpZ3Vy
YXRpb24gc3RhdGljYWxseSBpbiB0aGUgZGV2aWNldHJlZSwgd2hpY2ggY3JlYXRlcyBhIHBlcm1h
bmVudCBBQkkuDQo+IFNob3VsZCB0aGlzIGRyaXZlciBpbnN0ZWFkIHJlbHkgb24gdGhlIHN0YW5k
YXJkIGhkbWktY29kZWMgQVBJIHRvIGhhbmRsZSB0aGUNCj4gREFJIGZvcm1hdCBuZWdvdGlhdGlv
biByYXRoZXIgdGhhbiBpbnRyb2R1Y2luZyBhIGN1c3RvbSB2ZW5kb3IgcHJvcGVydHk/DQo+IA0K
PiAtLQ0KPiBTYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hz
ZXQvMjAyNjA4MTgwMjA1NTkuOTYxMzM1LQ0KPiAxLXhqaUBhbmFsb2dpeHNlbWkuY29tP3BhcnQ9
MQ0K
