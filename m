Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B1CC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFBF10E0BB;
	Wed, 19 Aug 2026 08:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=analogixsemi.com header.i=@analogixsemi.com header.b="eRtGs1QY";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11021139.outbound.protection.outlook.com
 [40.93.194.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B5010E0BB
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbpW/bcrEQbUU5b2uZiIrNrxvaOICRnv6jz0F9UWAxDznE6LrJO/vwPVqtG2M4Mf41BtWZkuSL+TaS4yDrc2KhK3JQffIaibXWlEdypBYuRzD4ZV/npnd7ifESpcnZEyCsPuH3bh8zTW2Aeua1MUhpv1N3bWPbqzotFBKpbtFSBRJSZZlMQsTDGm0D4LgQaPzPIzvPQwWHs2Mt8qCKzGcWAPQtKpdcGqOxdX5A0sMsiAo+vEWOtxx5WAO6jjAjv13JAZLLQXtb1wIICJk6DekYVtg3N/KhRjczRloppMm7FOJUGXFrn6wmKPMQIhmWg3wZekTylpPhV4Z8SOGgDC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3cjIWFhRqhNv2oQqQ3vof3gDAykTLkB6tkfUALILcQ=;
 b=plEdU3M5A5z8ht+ZJrLsPOo2pNKqF/L810I8tgHIseSc1wA+UAdnEq5Ju1iJRLdAVm1ErwntlEWVgFkgUUsRVSUj6AOmGNVzUzFCJPrJ9LZYqCijEYU0aDKwrgyFQWtO4YKRfOYTN7+MG0jN0AEAEsB4W9a2ycbcayx7sEXDm5VDi7Pg3JD2iS7RnmKFKhZQXa35VFKWhlqpXvhW5kByN3ivQvo+iQ5YOTSNqhyTwy4nT/aj0u0lT/tiH2F2ibPufXsOA19IgSSwV6gi/cizlFbeDIQl4lIKE/lJSl0OQPnaZ0+xTvd6a+2xyGLV4q64KmVD5AIZhRNH0F0kVf/YPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3cjIWFhRqhNv2oQqQ3vof3gDAykTLkB6tkfUALILcQ=;
 b=eRtGs1QYUmSonj2w2JGAOQWYP8cXVcJoPIJFTDIKSnXZU+s9Fhg5XDjFSQxKrq/Cv+Oa5K0yuorkSEc++I5efhjJYBAP4N3v90d0jjqZsfQUhiRUyLhRlQxq82e1aHsu4nNzc+YNgd6xYIwe2TCVhxYCrNPOdD0tXo44vEoHfjk=
Received: from DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15)
 by SA6PR04MB9543.namprd04.prod.outlook.com (2603:10b6:806:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 08:13:53 +0000
Received: from DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c]) by DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 08:13:53 +0000
From: Xin Ji <xji@analogixsemi.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm: anx7625: add I2S input stream right justified
 control
Thread-Topic: [PATCH 2/2] drm: anx7625: add I2S input stream right justified
 control
Thread-Index: AQHdLrY8i5EqSLZiNEitGDPLpHyjNLajEPIAgAH2vGA=
Date: Wed, 19 Aug 2026 08:13:53 +0000
Message-ID: <DM6PR04MB6970BF4593FB68F74879845FC7A52@DM6PR04MB6970.namprd04.prod.outlook.com>
References: <20260818020559.961335-1-xji@analogixsemi.com>
 <20260818020559.961335-2-xji@analogixsemi.com>
 <20260818021341.612481F000E9@smtp.kernel.org>
In-Reply-To: <20260818021341.612481F000E9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6970:EE_|SA6PR04MB9543:EE_
x-ms-office365-filtering-correlation-id: 665755e6-b63a-410b-4d03-08defdc9cef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: aMZm9s7ilmjAt/fk3Ee0RT8DEpEt4kkavt/BANUueTorC1k5Z6sKX1i8YmBZ39VnCi+c75E63bJFnTBHQ+AqMPYmY+RdvIgy+Lqg2ajIWgISjtejqArm8btMJUjku8G3TKtkRBJrhwxjfPGPWFbGIU/Ta5jbXdp3+7EJab7HtpTbM/SlRr4kzSSu1b7CiF0JXLDL4a0VhxLPTzB9HKnPtclYl1uYJUebaN8Iz286bogI4TMblj+AYvrRYzBRJJfTFgYyQjJyycaj33YqqS5i+fAae0MYL/iGQq8Mtt0cd/+1bTkJ4DOQAp6VMKh4ynidabpmPeJUj1hjJkZ8RpTomqVw5Wv/DxJgKoFWXPspfhASUKW237wHxkUN6ygmp45/jlbZcMpnCX5LcDIYCqQjm/9t2rlNzR+PvdYUrzG6k/aV/ETqb25QFH8c8Th3cW+XF01bScxMo2eC31lthyMVykzZes/Ud5u1KgkMYv3DyMHdxH6AeV1w0kRWkZNdpGuMyFfP7jfzsia4Oydl6I1eHNMKOTkHrFLMB95/qgzG6jUQ3rfP8cZ1UM7he9lvGSp4uFJFO+M2m//zSt53Do4rQ+fKgjy7YnD4ftgMorn/laZrO7tmFObH5/h2aUa01J9ghr2hK9xyokgrkFWOQZZ69NH8OV67hEsSs+SurFxKczA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DM6PR04MB6970.namprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UllEMlVWempBSGNDK2s3aWVNVWFlUzIrQ3JVZjJCMG1BSW83R0FvMjVzampO?=
 =?utf-8?B?Q2NuZmF4SU9FSFZuZE56cWxzUGx1SnRFa3FxNHNTUm5iYkNQcFc2Y1hrc1h1?=
 =?utf-8?B?S3VVUURVeDU4dFRjd1JTQWo5cFA3M01ndUdwNUdVQURnak42VU9iNVFPTU1x?=
 =?utf-8?B?SjhOZHYwYmxGQ1RneTROMVkwWGc2K0ZhYkpZQVkwZG0zeXFkN3VTL1ViL0FE?=
 =?utf-8?B?eWtoS3N1SmpKV0dCM2pRN21zVUNpSitlSzlxMGo0di9qMVd3cENkeUlsNEl2?=
 =?utf-8?B?Tk1HM3NLbHdvSk43aW1sYmh1UlZHNjROU1Zhc00vajNpRHdsU1UzOFdNcGhk?=
 =?utf-8?B?NkJpVzNSMDUxKzlPakM0TjF3WGk4VXc5d3IrSSt1MjJIMFpLdzJ2NUxUbjFJ?=
 =?utf-8?B?QlZ1RytzZGZJczQxdVVXVFY0cW4zdHhScGVZbzdTUElIR1RmTFNqMlJvVmdJ?=
 =?utf-8?B?MVpoekdiTytyTE52MkpZenozaWRwalZTRlZDR2NYaXFwTUd5TWlTNkw4UWdk?=
 =?utf-8?B?VWVURXZaaWRDNjh2ZUF2YzNzR09vOEVjWVJKV3M5dXV3cGxrVEQzTkplMmVs?=
 =?utf-8?B?bVd2MW9ueEVzcDBKNUh5eU1Md2V5dlJZOVRBWlhYSDJUM0p5emx4VjZRc2xO?=
 =?utf-8?B?T3oyNEZUcGEwZmt5dDFUN0VaNnpTUWY4MlZSZWVQV1krSW1UR1BsNUdsVXo0?=
 =?utf-8?B?b3FKSGx4NEh0eTQrYUJOdTliaXp0dFFEZ3I1QjlIVCt0MTI0UGJDYTM1S1FP?=
 =?utf-8?B?WDhYdGlBWWt0b1pJcjdSSnFxc0FnNG4xL1hLbld1a04waVNxQ0o4YmorY3VZ?=
 =?utf-8?B?UjBMbVRRUCswRlR6Qm5pT0NMSEMvY0hyT3BPemRCVUhteS9QVTJIenNVdlY3?=
 =?utf-8?B?RWx1NlBacXBRcW5FMTdVdmZBYmtKbzYzTWt5MmJWY2ZiOWVZWFRFRE9YK1Nq?=
 =?utf-8?B?cVJsT0ZML0VJZEdEWVMwdkVlY0pnMkdmZzJRYWtiOVFlcC9YVCtRaEpKYUZW?=
 =?utf-8?B?ZW9NUHNNVmQ3OUVHOWdPZ1A4bi9QVTJVYWd2bm1ha3RxdHRmTE83ZVlwcFBi?=
 =?utf-8?B?QXFPSm9Uejl6UHArdjVQc2Y2MW9pQitYRDBnbE1CVnJFVVU5dVdQRDJKQ0dJ?=
 =?utf-8?B?WGozZnhwQXJ5NXUvN2VZblpYaGt1Z2F1TDA0TFR2bURFU0hDeHBlVzNydzBX?=
 =?utf-8?B?bUZ5Vko2OHp3RnhVaXdYS0xXRnZRUGFxcnN3MzJOcG1hK0kxYTJBVEcxbDRi?=
 =?utf-8?B?T0x6Z3VocDdLOTRNQjFzL3lhaVNWZ20zckQ5bEZkejJjSllMUkJ4S0NCbUlv?=
 =?utf-8?B?S0FyWVJEUEJ0VVBBM0g1bmRTYjRBbHUrUStJbnR0SVpZd0o1d2VYVTJMdzM1?=
 =?utf-8?B?TGdzRVV3Z1ZPZm9RNmtOZEc2bG5PaXVRN1lmYkdhNy9Ma1ZWRC96RVhlQndJ?=
 =?utf-8?B?RWhqSitQTDBpWGtVTStiNlNXUHUvaUF1a0NMbVRMMmhBTzF1ekhHV3JEazll?=
 =?utf-8?B?VDZORS9jbDEwM3dVY3A3RW55eWxENGFzMU9jN1AwNHUxZjVOcDVYb2l2YW94?=
 =?utf-8?B?UmkrMFBFUWlpd3BMekdra1NNV21SdU5Hay9IdEZMOTRRS3lCKzIxTkh5SnY5?=
 =?utf-8?B?SkVrSzFFRUxZaGU5cFJuVDdmemFTazVIWGwxZkwrOUxHYVJrQk1HaEJsOGdP?=
 =?utf-8?B?NXdvcTBWQmE3SEtLZ2J0a0pDYTdiUnQ5MWdpb1VRai9JM0pibHcrQTBIandJ?=
 =?utf-8?B?TzAwczYxU29DZldKVnVUR0ZwcXFQeDc4di9LQW9GbDd2aExndmE5SG8waUdp?=
 =?utf-8?B?cVp0SGJ5UjlHc3R2T2owRnEzbkVHenBPOHpTRmlmOUs4KzF2SWl5czhaTUgw?=
 =?utf-8?B?MmV0cTc0VUxVeXlYa3FrS0hhbDlaWE9QcXZlTUx0ZUpYU3VVY1hEQjNuemh1?=
 =?utf-8?B?TExIQ0xSb1IxMCtFRFROVGFodVRGcmVKdW9HbzVWMFlDK1RTMUs4eEJBVXd3?=
 =?utf-8?B?S0VsSVdWc3RUM0lQRG9QcU12UUNUbW80WjhyNGsyalpsNUdCN2VMMmZJbUxC?=
 =?utf-8?B?MkQ4dTlNWFlEMGtsM3dxRmZjOHhHZktrSkVDWXIza1BPa2NPNkxWSk1OSVd5?=
 =?utf-8?B?b2JaSUFMWkZaK2pkSENaV1hsRXpreCs1NUJYVG41ZUF6bWQ1bVptbFFhU3Vz?=
 =?utf-8?B?V2RaZkJyN01OMmlZMVJGRmw1NzhIa3dpaWxlS2M2cXBZMTJaK292TzIxanFY?=
 =?utf-8?B?dDd0RzhRbVBwNXJzQ2pBVnZtSDhOZmRGQlpxdm40SHFrQVIvNVZCNTI4cldO?=
 =?utf-8?B?Sjk4OUFhUVpRYlFieHZoN2p3NzhLZFowWHd4ZTdjTU5QVnZFQmU3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6970.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665755e6-b63a-410b-4d03-08defdc9cef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 08:13:53.5145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeyDOUb/jD7/WdYG92Nn/Rd0cm0/r5AbZuGfZRXUhBBaSfEwf34uGjvQnLNgHpCUnskqKV5RAOvc3z0TpkMRXA==
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

SGkgc2FoaWtvLCB0aGFua3MgZm9yIHRoZSByZXZpZXcsIE9LLCBJJ2xsIHRyeSB0byB1c2UgZm10
IEhETUlfUklHSFRfSi4NCg0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEg
U2FzaGlrbyBBSSByZXZpZXcgZm91bmQgMyBwb3RlbnRpYWwgaXNzdWUocykNCj4gdG8gY29uc2lk
ZXI6DQo+IA0KPiBOZXcgaXNzdWVzOg0KPiAtIFtNZWRpdW1dIEJ5cGFzc2luZyBzdGFuZGFyZCBB
TFNBIEhETUkgY29kZWMgREFJIGZvcm1hdCBuZWdvdGlhdGlvbi4NCj4gLSBbTWVkaXVtXSBSSUdI
VF9KVVNUSUZZX0NUUkwgYml0IGlzIGNvbmRpdGlvbmFsbHkgc2V0IGJ1dCBuZXZlciBjbGVhcmVk
Lg0KPiANCj4gUHJlLWV4aXN0aW5nIGlzc3VlczoNCj4gLSBbSGlnaF0gVXNlLUFmdGVyLUZyZWUg
ZHVlIHRvIGludGVycnVwdCBmaXJpbmcgYWZ0ZXIgd29ya3F1ZXVlIGRlc3RydWN0aW9uLg0KPiAt
LQ0KPiANCj4gLS0tIFBhdGNoIFsyXTogW1BBVENIIDIvMl0gZHJtOiBhbng3NjI1OiBhZGQgSTJT
IGlucHV0IHN0cmVhbSByaWdodCBqdXN0aWZpZWQNCj4gY29udHJvbCAtLS0gY29tbWl0IGU3ODE4
NmIwMTVmNjY4OTk4OTAzZTI5MzcyOWVhNzFjNWJlYmZiZDgNCj4gQXV0aG9yOiBYaW4gSmkgPHhq
aUBhbmFsb2dpeHNlbWkuY29tPg0KPiANCj4gZHJtOiBhbng3NjI1OiBhZGQgSTJTIGlucHV0IHN0
cmVhbSByaWdodCBqdXN0aWZpZWQgY29udHJvbA0KPiANCj4gVGhlIGRlZmF1bHQgYXVkaW8gZGF0
YSBzdHJlYW0gaXMgbGVmdCBqdXN0aWZ5LiBXaGVuIHRoZSBwcm9wZXJ0eQ0KPiAiYW5hbG9naXgs
YXVkaW8tcmlnaHQtanVzdGlmeS1lbmFibGUiIGlzIGRldGVjdGVkLCB0aGUgY29kZSBlbmFibGVz
IHJpZ2h0DQo+IGp1c3RpZnkuDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YnJpZGdlL2FuYWxvZ2l4L2FueDc2MjUuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9h
bmFsb2dpeC9hbng3NjI1LmMNCj4gPiBpbmRleCBmZmZjZDYxNTRjNzEwLi5kMDBhYTZlYTcyNzNk
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW54NzYy
NS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hbmFsb2dpeC9hbng3NjI1LmMN
Cj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4gQEAgLTIwODMsNiArMjA4NiwxMiBAQCBzdGF0aWMgaW50
IGFueDc2MjVfYXVkaW9faHdfcGFyYW1zKHN0cnVjdA0KPiBkZXZpY2UgKmRldiwgdm9pZCAqZGF0
YSwNCj4gPiAgICAgICAgICAgICAgIHJldCB8PSBhbng3NjI1X3dyaXRlX2FuZChjdHgsIGN0eC0+
aTJjLnR4X3AyX2NsaWVudCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBVURJ
T19DSEFOTkVMX1NUQVRVU182LCB+QVVESU9fTEFZT1VUKTsNCj4gPg0KPiA+ICsgICAgIC8qIFJp
Z2h0IGp1c3RpZmllZCAqLw0KPiA+ICsgICAgIGlmIChjdHgtPnBkYXRhLmF1ZGlvX3JpZ2h0X2p1
c3RpZnkpDQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gSW5zdGVhZCBvZiBieXBhc3Npbmcg
c3RhbmRhcmQgQUxTQSBIRE1JIGNvZGVjIERBSSBmb3JtYXQgbmVnb3RpYXRpb24sDQo+IHNob3Vs
ZCB0aGlzIGNvZGUgY2hlY2sgdGhlIHN0YW5kYXJkIGZtdC0+Zm10IHBhcmFtZXRlciBmb3IgSERN
SV9SSUdIVF9KPw0KPiANCj4gV2hlbiB0aGUgZHJpdmVyIHJlY2VpdmVzIEhETUlfUklHSFRfSiB2
aWEgaGRtaV9jb2RlY19kYWlmbXQtPmZtdCBhdCB0aGUNCj4gc3RhcnQgb2YgYW54NzYyNV9hdWRp
b19od19wYXJhbXMoKSwgaXQgcmVqZWN0cyBpdCB3aXRoIC1FSU5WQUwuIFJlbHlpbmcgb24gYQ0K
PiBjdXN0b20gc3RhdGljIERUIHByb3BlcnR5IGJyZWFrcyBjb21wYXRpYmlsaXR5IHdpdGggZ2Vu
ZXJpYyBBTFNBIHNvdW5kIGNhcmRzDQo+IHRoYXQgZHluYW1pY2FsbHkgbmVnb3RpYXRlIHRoZSBE
QUkgZm9ybWF0Lg0KPiANCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IElzIHRoZXJlIGEgbWlzc2lu
ZyBjbGVhciBvcGVyYXRpb24gZm9yIHRoaXMgYml0Pw0KPiANCj4gSWYgYSBib290bG9hZGVyIG9y
IHByZXZpb3VzIGtlcm5lbCBleGVjdXRpb24gbGVmdCB0aGUgUklHSFRfSlVTVElGWV9DVFJMIGJp
dA0KPiBzZXQsIGFuZCBjdHgtPnBkYXRhLmF1ZGlvX3JpZ2h0X2p1c3RpZnkgaXMgZmFsc2UsIHRo
ZSBoYXJkd2FyZSB3aWxsIHJlbWFpbiBpbg0KPiByaWdodC1qdXN0aWZpZWQgbW9kZSBldmVuIHdo
ZW4gc3RhbmRhcmQgSTJTIGlzIGV4cGVjdGVkLiBTaG91bGQgdGhlcmUgYmUgYW4NCj4gYW54NzYy
NV93cml0ZV9hbmQoKSB0byBjbGVhciB0aGUgYml0IG9uIHRoZSBmYWxzZSBwYXRoPw0KPiANCj4g
PiArICAgICAgICAgICAgIHJldCB8PSBhbng3NjI1X3dyaXRlX29yKGN0eCwgY3R4LT5pMmMudHhf
cDJfY2xpZW50LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVVE
SU9fQ09OVFJPTF9SRUdJU1RFUiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFJJR0hUX0pVU1RJRllfQ1RSTCk7DQo+ID4gKw0KPiA+ICAgICAgIC8qIEZTICovDQo+
ID4gICAgICAgc3dpdGNoIChwYXJhbXMtPnNhbXBsZV9yYXRlKSB7DQo+ID4gICAgICAgY2FzZSAz
MjAwMDoNCj4gDQo+IFsgLi4uIF0NCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gVGhpcyBpc24n
dCBhIGJ1ZyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCBkb2VzIHRoZSBkcml2ZXIgaGF2
ZSBhIHVzZS1hZnRlci0NCj4gZnJlZSB2dWxuZXJhYmlsaXR5IGR1cmluZyB1bmJpbmQ/DQo+IA0K
PiBJbiBhbng3NjI1X2kyY19yZW1vdmUoKSwgdGhlIHdvcmtxdWV1ZSBpcyBkZXN0cm95ZWQgYmVm
b3JlIHRoZSBpbnRlcnJ1cHQgaXMNCj4gZGlzYWJsZWQ6DQo+IA0KPiAgICAgICAgIGlmIChwbGF0
Zm9ybS0+cGRhdGEuaW50cF9pcnEpDQo+ICAgICAgICAgICAgICAgICBkZXN0cm95X3dvcmtxdWV1
ZShwbGF0Zm9ybS0+d29ya3F1ZXVlKTsNCj4gDQo+IEJlY2F1c2UgdGhlIGRyaXZlciB1c2VzIGRl
dm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoKSwgdGhlIGludGVycnVwdCBpcyBvbmx5DQo+IGZyZWVk
IGFmdGVyIHJlbW92ZSgpIHJldHVybnMuIElmIGFuIGludGVycnVwdCAobGlrZSBIb3QgUGx1ZyBE
ZXRlY3QpIGZpcmVzIGFmdGVyDQo+IGRlc3Ryb3lfd29ya3F1ZXVlKCksIHRoZSBJU1IgYW54NzYy
NV9pbnRyX2hwZF9pc3IoKSB3aWxsIGF0dGVtcHQgdG8gdXNlIGl0Og0KPiANCj4gICAgICAgICBx
dWV1ZV93b3JrKGN0eC0+d29ya3F1ZXVlLCAmY3R4LT53b3JrKTsNCj4gDQo+IFNob3VsZCBkaXNh
YmxlX2lycSgpIGJlIGNhbGxlZCBiZWZvcmUgZGVzdHJveWluZyB0aGUgd29ya3F1ZXVlIHRvIHBy
ZXZlbnQNCj4gdGhlIElTUiBmcm9tIGRlcmVmZXJlbmNpbmcgdGhlIGZyZWVkIHdvcmtxdWV1ZSBw
b2ludGVyPw0KPiANCj4gLS0NCj4gU2FzaGlrbyBBSSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtv
LmRldi8jL3BhdGNoc2V0LzIwMjYwODE4MDIwNTU5Ljk2MTMzNS0NCj4gMS14amlAYW5hbG9naXhz
ZW1pLmNvbT9wYXJ0PTINCg==
