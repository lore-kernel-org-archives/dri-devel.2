Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF5A1094478
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C25710E1C8;
	Sat, 21 Mar 2026 14:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="XMLHv/zn";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011011.outbound.protection.outlook.com [52.101.125.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB2A10E1C8
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 14:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKYSNuIp6LJnvPDdvkRkCNcygVEWorUfLZEI4lqzgR3bZoM1tfpdH2iDeuVM72Bc/FNAlb3mLyN2RZZn/AGGag3nFMvWipI1iuH5ll2IlYDQamBa5tV/hOYM/l5JUz2av7XhJ92+olFWpEmrz0TUEoXSoGBMuzK8QvQvt+aCwr28jF9cHOxUDrPdXyazh5ueyUmgmQ323J55jIqu0HMS9g0Sb235d9WUulBFzW1p7Jkz0AYaLBMLIOq3bnAg6qFvnObIwHLobICU4/vsZMMk6kqQGrUIEdXz4uCmpKq1ZC5ylMGDDSd8d4OkC10ENWAi7D14iGiEqU6/4eNnEYfLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41tTk0a8P/ViiuRikc+C+Uqazh96hf5oHmWFpKUvKc4=;
 b=PygZd0QLkuXBApg6Pvyu7S+TBVwHo3pbQsNpE+ckV+FmBljXMKpasRhP4ZgeMB2q9GepNLZx9WBGyJvrDVX1EM4HPV5cysigpXBrit1XXswsuLYY0AKulZaDKrWQft+NxJkmZkdcGE/eIxI2pE7n4DMSAbnh4LGjVgsjN7yiRLCGaG+HePWr/EWBof7lMARzN4kDWa/F9hyjr9w6SruiHfi5MD+VDSSqfC5s2Acrq5bcwQntG/5T4dy34GIRFTBVjXrzZ5WL3eF0Pk6YZQglCiBl3tJdkhoU82HwNpTEGKeY+r8cRp1W+A8cVauh8RU6SmD/3H1Ok0iGKjnCCICF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41tTk0a8P/ViiuRikc+C+Uqazh96hf5oHmWFpKUvKc4=;
 b=XMLHv/zngub0hcSFYiyJy8FsDJkcP0+JPJPENkMbVf60IZzleXZKpuX7TNQEyBOsuX+OWC4gMWDnJQNwGQwiJa/4907ueyA8iwmeRmlzlhq9U7BDdceGjHcO9I7YPABHI4S2wjuZ9cbsGctAqts9Ftx3FTMsvt4bUyb6sJj50lM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSAPR01MB7199.jpnprd01.prod.outlook.com (2603:1096:604:144::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 14:15:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9723.022; Sat, 21 Mar 2026
 14:16:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
CC: Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring
 <robh@kernel.org>, Steven Price <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] drm/panfrost: Drop redundant optional clock checks
 in runtime PM
Thread-Topic: [PATCH v2 2/4] drm/panfrost: Drop redundant optional clock
 checks in runtime PM
Thread-Index: AQHcuIh8hfFALj8wyUqqAbYPOoEkkbW37WqAgAADFaCAAReyAA==
Date: Sat, 21 Mar 2026 14:16:12 +0000
Message-ID: <TY3PR01MB11346DD20F7E2AB23A54A274B864DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
 <20260320164158.487406-3-biju.das.jz@bp.renesas.com>
 <ab25E0kTBA4EjZ3Y@sobremesa>
 <TY3PR01MB11346F3DF5ACB55B5FE8DC96F864CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346F3DF5ACB55B5FE8DC96F864CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSAPR01MB7199:EE_
x-ms-office365-filtering-correlation-id: b153e587-3e16-4dc7-b4c1-08de8754680a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Aterb26fRQuv/hWxKnqEwsgLrdKNK4GVKh/hdlOTRW5188fxRJztHBCgmX6e8ZtAL9heNK6blTSezO2GgdNA8/Rny5ZI+BLDfZQnXa08NUhJp9irUPoTjjfUrPuZYFnNwYfNhrJKZ0o9v4do/jSjjTfVF1Bekidj+vVVvJcbdt727ey1wpdMo4Stbl+TRYh3rortz16A4Sdn24E0K2wHPu4CzBwpyFsFbzBAmqdCbmksrPNLpBc7srBurUMr266AvzJxMLE4rOa07KZVMV2/3YZ6atuvitoZCVgnUkETyIuHh3lKyz+glgZFZTvsOF9zLa9magtRF9sDyKiyhMmFsBj/W98rp7RCNIjMr7WeWKHrLT0LDjbyK9RGv02chURtCD8YOSBkzDD4Vh9VVnCJnBNINORbMVh9NPaJmB7CHGUtpryQ13GGFhaAsRESRmimU9XcbXYxwgAPyU7SlaGmpq/F97SMU/t2+C/5wYztAAFm++SF0H6QOg8ifM6d4wps/r2NWPzY1S7gtgWN0/ZvyyiL4ePLpZddOA0QXWRewoR9EXTeBNq6FMGQpILNCFG/uoCk1bLAZyyPDAK0xO1Gkl/gD+VFVrPDCKr5caETtfrYR8OgJzJxtjZBjKx1m5ij9ofdkGU8ipz36oa06RQEywKecHA0F0CBpLkny/+GmLYTr3TTvNzgJ42TZNcjs+5gs5w4Cun6WDvjIm12K0d1pYaUeUH7COUN2Ni/mjflP4jzKSVRUvOFcO+AoyHqzWvo96P/ErHZTR+y9eJUWIJP7hJ5vk6WbvMl2B5QZ7zgKag=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHVLVkV4V3lPYktKdGVWTkp4bEpnZE5RRkw5dmpTWWhUMmNPS0dzc2VjWHk1?=
 =?utf-8?B?V2FONU9nTXdFTHFhdTlYTmw0bHhKbFlpM0czRWFsSFh4L2UyeEZZLzNJZVVU?=
 =?utf-8?B?L2tkUFJDQ1lUR2xsTlYzZkgxOHUxTkhZUTR2LzExMXhlZVNsekJQUWpQZ29q?=
 =?utf-8?B?M0FCTkNqSEpFdGFCN1Yrc2xjaHRFd290OFFzMkVGeitPdFNnU2IxVk9pUERW?=
 =?utf-8?B?UmZzcHdaMXA5eHE0MzhXeFY1MDY3eWZEdmx5QVY2OVg0R2xuTDMxUzkxTlVp?=
 =?utf-8?B?Q1Z4bmRVOC9CV3Z1LzdYWVR1aU1GMmFyVjM2MVFGTVNGV1lGeUM1UXpxU2xt?=
 =?utf-8?B?aHNVZVJKTjlqd3Z5UHNFY0dRRjY4dkNtVHJqMUFBSzJkbTNSRDNiWFIwaldl?=
 =?utf-8?B?RWVFaldaL3RQb1NDSHVrdHdVdWFsV0lhbDZNcnQ0RlJlb0lKdGdTTElJTmlS?=
 =?utf-8?B?cmVudHZsVTJxS0Mrb2hBV29JUGs1NEtCc1N5ZnJxZmloQVdjU3dObnVUdHI1?=
 =?utf-8?B?amVSUUwvYUQvQW94MURyR2FkUkNISzhPc3B4ckNjMENodDBsaDV6V0w2UHhU?=
 =?utf-8?B?UmxDcXdiTEtWNVBhbzNpREdycHB1Q0tKUTg5Q3A4TzhCY2UzWHFjWThISjRq?=
 =?utf-8?B?ZC9XWm5SRXFNVnR3My8vM2gxdUR3MXVJVk9RZ1ZzYThkY0lOeUVHVnNiWUow?=
 =?utf-8?B?Y0tMQzdiQmI1enZVWjRGa292K3NTQnk4UmNra3FQdHdWeHZiRHlpakpDNklJ?=
 =?utf-8?B?aDBJN1ZnWUhjU0UzaXVBQlY2dGI1VVZTMjNFOU1VaCtSMlg1WmhhR1p0ZGFW?=
 =?utf-8?B?YWRBVk1SR1VhU2dybnp0RCt6VFNNa0JoZ1FzZ1VKNXhyNEcwd0hVNmlCUS90?=
 =?utf-8?B?NGhoM3ExaHZ4MTEwTjBuVWYzWU4xOW1uRnUrVWpvbUFlV0E0b2RuMjVTUG5Q?=
 =?utf-8?B?bGxYNDdBcGpJcmt0OVA0KzJCc3lKbTl6Q01ESXBiWS90M2hOeGgzODJWbTJw?=
 =?utf-8?B?MWdpbTBDdDd2OGNLSXlqNERMNitwNzY5ZmxSY2FJNVRZVTZWb0JKWGJwTWFj?=
 =?utf-8?B?UWpsUnJ6SmI2RnFqbHl6bWlWWEJFaFlyS2x5OTdzV1dic3dVYWpWTUJMY0Za?=
 =?utf-8?B?RWxUUGFNUlhZZEQ5WkFyWEYrb2xQWVRWUG1WUXdUbTFHY1F1NS9yMWVwTjBP?=
 =?utf-8?B?UUZCdWQzMjdXeENHQStVMjFhM1NXVDRUeHJtV0JjOVgvZUNUVjBoTTNsSlg3?=
 =?utf-8?B?M2ZUZW1vaEt1UEx4Rkw4VDdtYU9ROWhwcjZEMXFCTXZjL1BKTHIzajJEb1dh?=
 =?utf-8?B?TUllUVZOdEl1YlpYQjVPUFMxVXd2K3I0ZzFVYTJjNlFxVE1WdnNOWGduNXJh?=
 =?utf-8?B?K2VPeHBXNU1kNlR1ZU9jMGoxeTdJWEtOTWp6NVJERzFwZlhLV29UdjlRbmcz?=
 =?utf-8?B?YTNFK3VXYWVBTGNQYTJrZEdXQ2NYMkRiVVdJZXZTb2FEUUg5blc4Z0YrZDZT?=
 =?utf-8?B?MW1zME9PZnlFaWV3QjdoanZ1NEJ6RU5ESGdBcVpUVGo1am9rcGVUb25mZ0FD?=
 =?utf-8?B?SkpGQzdFOWlHZGgzLytESmlFamRKc3ZYanBycnNtblVJaytFT0NlOHhPVUdN?=
 =?utf-8?B?VU8vcCtKaWZJYmY2cUNSY1p1dVJzSFVmdm9kanBhbG5CbFJYbHJRcmZUQjhk?=
 =?utf-8?B?YjNXSjIrdy9Uekp0cmhrazlMcEZ1eG1VbGF1d0tiNGMwYzg5V1A0TGJTTlZV?=
 =?utf-8?B?NHdpak9SR0lCb0hwbW5LbVUvSTRlc0ZtYkVDUXkwakpUaVNXSm9WQ01mY2RT?=
 =?utf-8?B?ZFZFUFZhSjhwcnNzUStmL1QwZDI2SWtrYkdCeUFRcFIrcjgwSjhzY2xCUlhO?=
 =?utf-8?B?SWNZMUdYcU1ZQVRYQ2krVjZ2SDF2N25DSFAxZk9yU3Jja2RzRVdxNGVKQnhi?=
 =?utf-8?B?bDZCWXo2S1kyMm5oUTN4dWl1a21pM2p5Q1JCbThrTytkUzFKSXV2ZnB2VVV2?=
 =?utf-8?B?bkJtZWxnVVlUbFJyVVBWc0RFTThTQkJSTXRsVzFHaC9IVWZPYmxobEV6NHJL?=
 =?utf-8?B?Zm9MaHdvejlMcmQ2MzM2V2JrcnNZMTJ0dzRwOHFvVm1kTWFpWVl2cXN0WEJi?=
 =?utf-8?B?ZjNKdWU1M2Z2bDJ2dUViNGdTTEN2NTNiQnRobjEwRFFtRmNackJUN2F5RGJ1?=
 =?utf-8?B?bDVJVFE2Nk1EQmtlZE5HaUt6a3RERW1tem10WjF5QjdwYVpBZytuTE1DYVVl?=
 =?utf-8?B?REV1bTBwYTNYUWt4SjdMV1hQU0FYR29ySnlNN1hlRmFSU2cvYm1qa2I0S1Fm?=
 =?utf-8?B?c2lKaWVQZWg4R0x4MkRGNkJNOUhBenl5clFlWHVHWWx6MktmamN2QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b153e587-3e16-4dc7-b4c1-08de8754680a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2026 14:16:12.5404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3aYY7OyKRlVUDMSqLc8R2IQD0WstpP2aMZHaN6BzZDq103RtNxMbUgSscfx+lIYldcW5Ou7pdl7Cx2nQ3U0j0ztBVZanMCtrTOu4BuXJQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7199
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

SGkgQWRyacOhbiBMYXJ1bWJlLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBkcmktZGV2ZWwgPGRyaS1kZXZlbC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEJpanUgRGFzDQo+IFNlbnQ6
IDIwIE1hcmNoIDIwMjYgMjE6MzINCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MiAyLzRdIGRybS9w
YW5mcm9zdDogRHJvcCByZWR1bmRhbnQgb3B0aW9uYWwgY2xvY2sgY2hlY2tzIGluIHJ1bnRpbWUg
UE0NCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IGRyaS1kZXZlbCA8ZHJpLWRldmVsLWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBC
ZWhhbGYgT2YNCj4gPiBBZHJpw6FuIExhcnVtYmUNCj4gPiBTZW50OiAyMCBNYXJjaCAyMDI2IDIx
OjIwDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzRdIGRybS9wYW5mcm9zdDogRHJvcCBy
ZWR1bmRhbnQgb3B0aW9uYWwNCj4gPiBjbG9jayBjaGVja3MgaW4gcnVudGltZSBQTQ0KPiA+DQo+
ID4gSGkgQmlqdSwNCj4gPg0KPiA+IE9uIDIwLjAzLjIwMjYgMTY6NDEsIEJpanUgd3JvdGU6DQo+
ID4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPg0K
PiA+ID4gVGhlIGNsa19lbmFibGUoKSBhbmQgY2xrX2Rpc2FibGUoKSBBUElzIGFscmVhZHkgaGFu
ZGxlIE5VTEwgY2xvY2sNCj4gPiA+IHBvaW50ZXJzIGdyYWNlZnVsbHkg4oCUIGNsa19lbmFibGUo
KSByZXR1cm5zIDAgYW5kIGNsa19kaXNhYmxlKCkNCj4gPiA+IHJldHVybnMgaW1tZWRpYXRlbHkg
d2hlbiBwYXNzZWQgYSBOVUxMIG9yIG9wdGlvbmFsIGNsb2NrLiBUaGUNCj4gPiA+IGV4cGxpY2l0
IGlmDQo+ID4gPiAocGZkZXYtPmJ1c19jbG9jaykgZ3VhcmRzIGFyb3VuZCB0aGVzZSBjYWxscyBp
biB0aGUgcnVudGltZQ0KPiA+ID4gc3VzcGVuZC9yZXN1bWUgcGF0aHMgYXJlIHRoZXJlZm9yZSB1
bm5lY2Vzc2FyeS4gUmVtb3ZlIHRoZW0gdG8gc2ltcGxpZnkgdGhlIGNvZGUuDQo+ID4gPg0KPiA+
ID4gUmV2aWV3ZWQtYnk6IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5jb20+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+IHYxLT52MjoNCj4gPiA+ICAqIENvbGxlY3RlZCB0YWcNCj4gPiA+IC0t
LQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuYyB8IDEy
ICsrKystLS0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9w
YW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vcGFuZnJv
c3QvcGFuZnJvc3RfZGV2aWNlLmMNCj4gPiA+IGluZGV4IGRlZGMxM2U1NjYzMS4uMDFlNzAyYTBi
MmYwIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0
X2RldmljZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3Rf
ZGV2aWNlLmMNCj4gPiA+IEBAIC00MjksMTEgKzQyOSw5IEBAIHN0YXRpYyBpbnQgcGFuZnJvc3Rf
ZGV2aWNlX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiA+ICAJCWlmIChy
ZXQpDQo+ID4gPiAgCQkJZ290byBlcnJfY2xrOw0KPiA+ID4NCj4gPiA+IC0JCWlmIChwZmRldi0+
YnVzX2Nsb2NrKSB7DQo+ID4gPiAtCQkJcmV0ID0gY2xrX2VuYWJsZShwZmRldi0+YnVzX2Nsb2Nr
KTsNCj4gPiA+IC0JCQlpZiAocmV0KQ0KPiA+ID4gLQkJCQlnb3RvIGVycl9idXNfY2xrOw0KPiA+
ID4gLQkJfQ0KPiA+ID4gKwkJcmV0ID0gY2xrX2VuYWJsZShwZmRldi0+YnVzX2Nsb2NrKTsNCj4g
PiA+ICsJCWlmIChyZXQpDQo+ID4gPiArCQkJZ290byBlcnJfYnVzX2NsazsNCj4gPiA+ICAJfQ0K
PiA+DQo+ID4gSXQgc2VlbXMgY2xrX3ByZXBhcmVfZW5hYmxlKCkgY2FuIGFsc28gZGVhbCB3aXRo
IE5VTEwgY2xvY2sgZGV2aWNlDQo+ID4gcG9pbnRlcnMgZ3JhY2VmdWxseSwgc28gbWF5YmUgeW91
IGNvdWxkIGFsc28gZG8gYXdheSB3aXRoIHBvaW50ZXIgY2hlY2tzIGluIHBhbmZyb3N0X2Nsa19p
bml0Pw0KPiANCj4gVGhpcyBpcyB0aGUgb25seSBjaGVjayBhbmQgbm8gbmVlZCB0byBwcmludCBy
YXRlIGZvciBvcHRpb25hbCBjbGsuIFRoYXQgaXMgdGhlIHJlYXNvbiBJIGhhdmUgbm90DQo+IHRv
dWNoZWQgdGhpcy4NCj4gDQo+IAlpZiAocGZkZXYtPmJ1c19jbG9jaykgew0KPiAJCXJhdGUgPSBj
bGtfZ2V0X3JhdGUocGZkZXYtPmJ1c19jbG9jayk7DQo+IAkJZGV2X2luZm8ocGZkZXYtPmJhc2Uu
ZGV2LCAiYnVzX2Nsb2NrIHJhdGUgPSAlbHVcbiIsIHJhdGUpOw0KPiANCj4gCQllcnIgPSBjbGtf
cHJlcGFyZV9lbmFibGUocGZkZXYtPmJ1c19jbG9jayk7DQo+IAkJaWYgKGVycikNCj4gCQkJZ290
byBkaXNhYmxlX2Nsb2NrOw0KPiAJfQ0KDQpUaGUgYWJvdmUgYmxvY2sgaXMgZ29vZCBmb3Igb3B0
aW9uYWwgY2xvY2suDQoNCk90aGVyd2lzZSwgdGhlcmUgd2lsbCBiZSAyIGNoZWNrcyBmb3Igb3B0
aW9uYWwgY2xrLg0KDQpPbmUgaGVyZToNCg0KaWYgKHBmZGV2LT5idXNfY2xvY2spIHsNCglyYXRl
ID0gY2xrX2dldF9yYXRlKHBmZGV2LT5idXNfY2xvY2spOw0KCWRldl9pbmZvKHBmZGV2LT5iYXNl
LmRldiwgImJ1c19jbG9jayByYXRlID0gJWx1XG4iLCByYXRlKTsNCn0NCg0KYW5kIG9uZSBpbnNp
ZGUgdGhlIGNsa19wcmVwYXJlX2VuYWJsZSgpOiANCg0KZXJyID0gY2xrX3ByZXBhcmVfZW5hYmxl
KHBmZGV2LT5idXNfY2xvY2spOw0KDQpQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4N
Cg0KQ2hlZXJzLA0KQmlqdQ0KDQo+IA0KPiBDaGVlcnMsDQo+IEJpanUNCj4gPg0KPiA+IE90aGVy
IHRoYW4gdGhhdCwNCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBBZHJpw6FuIExhcnVtYmUgPGFkcmlh
bi5sYXJ1bWJlQGNvbGxhYm9yYS5jb20+DQo+ID4NCj4gPiA+ICAJcGFuZnJvc3RfZGV2aWNlX3Jl
c2V0KHBmZGV2LCB0cnVlKTsgQEAgLTQ2NCw5ICs0NjIsNyBAQCBzdGF0aWMgaW50DQo+ID4gPiBw
YW5mcm9zdF9kZXZpY2VfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiA+
ICAJcGFuZnJvc3RfZ3B1X3Bvd2VyX29mZihwZmRldik7DQo+ID4gPg0KPiA+ID4gIAlpZiAocGZk
ZXYtPmNvbXAtPnBtX2ZlYXR1cmVzICYgQklUKEdQVV9QTV9SVCkpIHsNCj4gPiA+IC0JCWlmIChw
ZmRldi0+YnVzX2Nsb2NrKQ0KPiA+ID4gLQkJCWNsa19kaXNhYmxlKHBmZGV2LT5idXNfY2xvY2sp
Ow0KPiA+ID4gLQ0KPiA+ID4gKwkJY2xrX2Rpc2FibGUocGZkZXYtPmJ1c19jbG9jayk7DQo+ID4g
PiAgCQljbGtfZGlzYWJsZShwZmRldi0+Y2xvY2spOw0KPiA+ID4gIAkJcmVzZXRfY29udHJvbF9h
c3NlcnQocGZkZXYtPnJzdGMpOw0KPiA+ID4gIAl9DQo+ID4gPiAtLQ0KPiA+ID4gMi40My4wDQo+
ID4NCj4gPg0KPiA+IEFkcmlhbiBMYXJ1bWJlDQo=
