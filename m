Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEF2FCD0C3
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE58210E069;
	Wed, 18 Mar 2026 06:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="HJ1MLDis";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010063.outbound.protection.outlook.com [52.101.229.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B252810E069
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 06:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KppTi7QMgvdyIs/SrZtof/0a3pcm0Q3nmo29Y1FeZHSrQYkiFfNR+TcowAhpsROrHuQBZtXa8CpGFdslX58WGNIMbj3CdxAQ6DsiK6HVyG5vmPT4sg/IjG0i/Z3OgZLsrDtewd/5rppseNH+RtbdWcqRBFpRkQmUAczooYIfxchInWpkUs8H5zOpsmhKS23hDOvDSLy4GoXquACcsCUvmT7BE2Y8J8uuWSB7KPQEUOOINONLPbeZvD6vpwbLiu+GIWf0IabgSYwB4C6HNe6TWJJsLcLj12kaSCnloeb25qagQXtqNZdpYHP6IHUP9/yESM6pMYdXtEFYS7FQ7d7VHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyseG79BuKXfcNiFB5ByqLTqasjzGkwzTTlnNIKEd3U=;
 b=xULgDmPn/oqkQ1/oklUxo/LUuWT4W41S3KDYLpvkUE/zdqxG3GbEn35f/10Kc4rYzVryO+9RYoPrc3bqxNnCunpckY8un8N/PEFPqPB2jenymIct7H6H5oPbExQjesMMUR9MTGc0D1n/7w/AsnkfyjMP/QrjHHQFPybc+P2RzBZ74mrXCGt88DxPeZLafKR2txO8H0GHpRukvRqa1yX2Ggo45wuBqqBuJwNn8BEoJ8/5z6WU/zZ3djQm2g8ZHANb8Sdd5q4+m0jOBgX+tu1/N0cimtK9kjL8t9uXoLHjnIO8BPC5G5l/Zn/YIJ7+3ilwpAiCMyvys/NJVcjVvSPTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyseG79BuKXfcNiFB5ByqLTqasjzGkwzTTlnNIKEd3U=;
 b=HJ1MLDishWQb1i25sZApbSdEy+la7H+zlknyvbisGEQrDZKMomloLuQBrL5Li+0bMMQxVOe56Ep1vNt76uJR9D7r897F2QaEj/xZPz+trsV1f1rWyVmtKcY9AcWeH0j4Gfy1pHTRvGlCiBSDhdocHfqPySOXIApOO0Ow3E/wJGk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB10102.jpnprd01.prod.outlook.com (2603:1096:400:1ee::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:57:47 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:57:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: laurent.pinchart <laurent.pinchart@ideasonboard.com>
CC: biju.das.au <biju.das.au@gmail.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert
 Foss <rfoss@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Tommaso Merciai
 <tommaso.merciai.xr@bp.renesas.com>, Andy Yan <andy.yan@rock-chips.com>,
 Douglas Anderson <dianders@chromium.org>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Jesse Van Gavere <jesseevg@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] drm/bridge: adv7511: Clear HPD IRQ before powering on
 device during resume()
Thread-Topic: [PATCH] drm/bridge: adv7511: Clear HPD IRQ before powering on
 device during resume()
Thread-Index: AQHccNTTduZlWQWrnEiAvemqifSjf7WxuWcAgAA85YCAAfPyAIAAe5TA
Date: Wed, 18 Mar 2026 06:57:42 +0000
Message-ID: <TY3PR01MB11346985D2509C34639B4560B864EA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251219104659.114032-1-biju.das.jz@bp.renesas.com>
 <20260316140232.GB31616@killaraus.ideasonboard.com>
 <TYCPR01MB113325ADBA0ACD1872BD4959B8640A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <20260317232952.GD408929@killaraus.ideasonboard.com>
In-Reply-To: <20260317232952.GD408929@killaraus.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB10102:EE_
x-ms-office365-filtering-correlation-id: 6b6ffbbe-0002-4237-48ef-08de84bba6c9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: yEJtDJkGsYvYxkfN53fEgLjTqx1YUYOLbUoSkx+9wh5e56jRtwdK7sOSmpbvYJeu5SR9PWFXEldcYNmSX8sfp+wqNmxqBJLuRVsOl+8jkdd0Id1YW3jz7x/rEp51Ap/TnQ27YDFdzJ+wLbRV8NIIAdOMysB4BVoYd04blMcx+UOPYvwM+kKkuW3/OrqHv8jB7eY7DRVpNo8KQnKrG4e4x2FUvgdNlNhxOMYNVSBahZZAPTKH/g/D1L3wMjTCoQcPigUvEv4eLf+B8wRX7QOTfCMz+nfWwrrJDhyoeKRx4lRkKxrnQgHdFA3V3UnPuLC7gb0lvHBpRRAjsih1CLjXHQ83Ny1mhW9rXJU8jXVxERF2b6M4CO7IfPNiDw5ohOmNh4j2MTdc77pIhMem8ZccqK+wwhQuK4WjbhEPQbMJwf6OS+Def42b+2gbAv9mEqcUxo7r/BHbTzeeWyTrvwatyJwkrSfeQuma/CdcQjBDhLPZodImL+FrM/blzl/Qj8hjGN1H/msz5BrUoHRC6OYcBJC9d3iOZUvfaMuP/OtrrZp6vCnbUmTbTp8dfGi1dcWL862qzlH+XQILDyYKtnr/yxzYGa75aeCN2zxcCminhtEi57arm/v0tZnJA0MAAIq2BM256W9OwSy4+SOEk3h4gxke/IOPx/uaV87WVXHct9XEO9OeeEvBMwB+tQ+mtqCviijYBbuQvHNHEPSuO55tOjtOWxINkTUwt/pxbVbkQ6TsOcQEad/+lb/d4jvVDdPU03dJ+fMP0BqelSCn3U5jBH5vQPzUvRjmcYisterlUYw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3R6b29kb1U5SzRLOWJIRER3K0hCMU5KREJwWFZNME1LRy9ZZnlIWEo1Ykwy?=
 =?utf-8?B?RlhhVUY2V0htTXNud1pGeUVRa0VGS1lLSEZtWXlROUdUS0ZEK2g3UjJuRkNa?=
 =?utf-8?B?Zk5ld2ZoTzhxcGpNM1NuMTN4dFNXRzQ1UFFMazcxbk1RMDVxKzd0RUtxRmsy?=
 =?utf-8?B?VDI4V3d5ZVowRFlPa1Q4aUVFeThaWk9qeGJVRUpwZm0zUEUxVUpOUENFR2ZT?=
 =?utf-8?B?NjhwRnNBeEJLMzBSMTRSZDlUMzZxa1V2QmtlNnFjcXRlWG9PK1p4ZkVRcWtI?=
 =?utf-8?B?UkZpR0xtVzhHczZLWUgxeU82NUNIMzBUcG5UZzZGQjh1bExTY2t4VVR0RGY1?=
 =?utf-8?B?YmVzNVZZbHU3LzdGbStIV1U4eTcvUzJ4Q1F4OHc2U1RXanc3Tm11TUh5R2pX?=
 =?utf-8?B?Q1YwV2k5OUc3a04yc1J4UHdDM3hWWmkyN0N2R3RJRm45OUxMSWhSWnRndnh2?=
 =?utf-8?B?YTZhTEJFdU5PRHJUQ3RReHE5TTNQTGNYUHQrWnVPQnorcEZTT2xRMkViVm0z?=
 =?utf-8?B?WERGQnNneUxYQXo0VkJrWVh5Z1UzVHdIdUw5NUkxVlNwNTY2TXdhV0d5RjVY?=
 =?utf-8?B?Q2ZCK1FiNSsyUjBGYVdSYVN6Y1RJNVVsdi9OdFM4UkdrdkcwQm9iZWZJSWd0?=
 =?utf-8?B?K3R6K0VqQjdJcDUrSS9uVEJmMlBwNTVpb3FYRWt0dVByUUJ4WHE5QUNBdlFL?=
 =?utf-8?B?UUJ4L3pvMStSYm91c0YwbnVzZW1UdDY4cEFmbkUvTzY5WFpGaGhjV1M1bk9z?=
 =?utf-8?B?aFZJcENXVmV6NG1FaFhPSVRvTWVIaTI4RG1zMmlSbWdWZDF1enFiQXFXWUM3?=
 =?utf-8?B?NWk0MTlaNDJvNEtQVGdOMUd3RUpIRGlFZ3BmaWNVTkJ1blVNK2hwZGZaNWp5?=
 =?utf-8?B?UXAyRk8vZGNFZFY2am81ZjQ1RFVRaVBwRGhoeFhZd1prV0lScEgvTC9qckg4?=
 =?utf-8?B?T2RqUzRJL2VvczkxNmprclZGcnRXdkYreWlRSUo0NlNBWElOMWZiblNSdUdG?=
 =?utf-8?B?VEpMMEkwNUE5YnV3TWNHR1pWcnRIVVhoYS9wd1c2RGMwc1RqNmdaWUFGcC9R?=
 =?utf-8?B?ellXZE1tblNGKzN1c0h5YlBUWW00bjk4aXJTTCszSHVsdllkbTZYQlE0SjJs?=
 =?utf-8?B?Wlh0bW5xZC9EV0hZdHkzcEZYUWpPaDM0dEs2ajU4VkJEeVlzblRpOWs3aS9U?=
 =?utf-8?B?MmRXaURlcVNabVRvbjdpUlpzTVJrYVhoZjZsWVltUHZmM0lScjFFMk02RDFR?=
 =?utf-8?B?cmJZQ0V4a0NZdXczRHpNZCtxWmNNYlVpOW5NSW5ibUlUKy9tVGl1aHIxU1My?=
 =?utf-8?B?MkxrNHhQTXVlZkJZSi9SVDRSL3JGZG1iTDFCamZoMDhBS3hiK0E5YlUrZU9Z?=
 =?utf-8?B?dkpmblN2blpZZlNSdGlzRit4RnMxV0xCWmhJd05jc1ZwUGk1SWs0Vng1eG5l?=
 =?utf-8?B?RXhDTXR3c3ZmaFByZnZHY2RTei9HM2wwR1lRVW85Tk9DbnB3bzRNMGUyQmNw?=
 =?utf-8?B?Z2J3UHF1NXgzRmJzOGNnMmlsTS9sRmJsb0F4NityZ0d1TW5WT0EwVGRjNHE3?=
 =?utf-8?B?OWJkRFI2TUtBRVNkM3JIakcwVVNzV2JmcEZlMk42S1h2MDZXSUJYZVVOQXYz?=
 =?utf-8?B?S21jd0tUREVRZXVIdGtiRHk0SFRmbGxkN2lYMXJpYk5YU0cwNlUxS3JPRy9X?=
 =?utf-8?B?MVROdWpZY3k5V1hIQkpPUTFTQnFiWVNvTnd2NE1ONGovQVJoMUdQY0VZUm45?=
 =?utf-8?B?UGtYUUdwSmNYVTRBTzA2ZllVWWJxZ0tINGl6YkQzWU1CTHlDRFAraVViRHZP?=
 =?utf-8?B?SEx0d2xPR3VSVm4rVVZ3NXdpaGphN2QycU1VQUNWZUczT2FtcnZRZXB4NnEx?=
 =?utf-8?B?aWtDYkxnejN5WHNiU2dYbnBEYmVtQlRpbGdVd2NJeUtWSGM5SXdBakhFSUR6?=
 =?utf-8?B?NDdndjJmN0ZYS3R3cWplVFJTMURaZWMxNm9LWmM0S0VGT2hYYkN2cEVnWVhk?=
 =?utf-8?B?dW81YU5WUHZhMEwyRVlZQVBldndhNlROWE8vdDhnakJVTzAzQXhpWmRaZlBU?=
 =?utf-8?B?R1duZTJXclVCY3ZuU0FpUTI2M3BrUUEvaUIvckJSWnFVSWFGMVR6LzRpQTJ2?=
 =?utf-8?B?elQvUGlOS3lRRWpEL0h5aG1JeTJ3cnJNOXFPWkVNMTlKdjd5WkxXMFpZOVVw?=
 =?utf-8?B?dFNsYnZXNlBidHphbkFQWDlRYmp6WUFXL0NnWXh5MVR4Q3duSG1SNWhFNDU2?=
 =?utf-8?B?Z1A2RUw4R28rekt4cnNhVlB2eXlFbkhtRVFydWZTR2dsTUJTOU43VksxdHJW?=
 =?utf-8?B?bGlybFR4MitwZS9WLzZlcHM1T2czd3JONSsxS2ZXOU5SUkVEdDNRdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6ffbbe-0002-4237-48ef-08de84bba6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 06:57:42.4494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/KicUPEAqHmFwdAs0YV1vCFG+uhxeYbUCOWmTt8/iblIcm1/dysfUfdyeSURTAXxXFbnMKWZXGPY4g8Ek33iA7hszAysAHoWYgD1uKYUfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10102
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

SGkgTGF1cmVudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXVy
ZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+DQo+IFNlbnQ6
IDE3IE1hcmNoIDIwMjYgMjM6MzANCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2JyaWRnZTog
YWR2NzUxMTogQ2xlYXIgSFBEIElSUSBiZWZvcmUgcG93ZXJpbmcgb24gZGV2aWNlIGR1cmluZyBy
ZXN1bWUoKQ0KPiANCj4gT24gTW9uLCBNYXIgMTYsIDIwMjYgYXQgMDU6NTk6NTdQTSArMDAwMCwg
QmlqdSBEYXMgd3JvdGU6DQo+ID4gT24gMTYgTWFyY2ggMjAyNiAxNDowMywgTGF1cmVudCBQaW5j
aGFydCB3cm90ZToNCj4gPiA+IE9uIEZyaSwgRGVjIDE5LCAyMDI1IGF0IDEwOjQ2OjUzQU0gKzAw
MDAsIEJpanUgd3JvdGU6DQo+ID4gPiA+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gT24gUlovRzNFIFNNQVJDIEVWSyB1c2luZyBQ
U0NJLCBzMnJhbSBwb3dlcnMgZG93biB0aGUgU29DLiBUZXN0aW5nDQo+ID4gPiA+IEFEVjc1MzUg
SVJRIGNvbmZpZ3VyZWQgYXMgZWRnZS10cmlnZ2VyZWQgaW50ZXJydXB0IG9uIFJaL0czRSBTTUFS
Qw0KPiA+ID4gPiBFVksgc2hvd3MgdGhhdCBpdCBpcyBtaXNzaW5nIEhQRCBJUlEgZHVyaW5nIHN5
c3RlbSByZXN1bWUsIGFzIHRoZQ0KPiA+ID4gPiBzdGF0dXMgY2hhbmdlIG9jY3VycyBiZWZvcmUg
dGhlIElSUS9waW5jb250cm9sIHJlc3VtZS4gT25jZSB0aGUNCj4gPiA+ID4gc3RhdHVzIGJpdCBp
cyBzZXQsIHRoZXJlIHdvbid0IGJlIGFueSBmdXJ0aGVyIElSUSB1bmxlc3MgdGhlIHN0YXR1cyBi
aXQgaXMgY2xlYXJlZC4NCj4gPiA+ID4NCj4gPiA+ID4gQ2xlYXIgYW55IHBlbmRpbmcgSFBEIElS
UXMgYmVmb3JlIHBvd2VyaW5nIG9uIHRoZSBBRFY3NTM1IGRldmljZQ0KPiA+ID4gPiB0byBkZWxp
dmVyIEhQRCBpbnRlcnJ1cHRzIGFmdGVyIHJlc3VtZSgpLg0KPiA+ID4NCj4gPiA+IFRoaXMgaXNz
dWUgZG9lc24ndCBzZWVtIHRvIGJlIHNwZWNpZmljIHRvIHRoZSBBRFY3NTExLiBBbnkgZGV2aWNl
DQo+ID4gPiB0aGF0IHVzZXMgYW4gZWRnZS10cmlnZ2VyZWQgaW50ZXJydXB0IGNvdWxkIHN1ZmZl
ciBmcm9tIHRoZSBzYW1lIHByb2JsZW0uDQo+ID4gPiBJbXBsZW1lbnRpbmcgYSB3b3JrIGFyb3Vu
ZCBpbiB0aGUgZHJpdmVyIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHNvbHV0aW9uIHRoYXQgd291bGQg
c2NhbGUuDQo+ID4NCj4gPiBJIGRvbid0IHNlZSBhbnkgYnJpZGdlIGRldmljZSBpcyBjb21wbGFp
bmluZyBhYm91dCBzaW1pbGFyIGlzc3VlcyBpbiBMaW51eCBrZXJuZWwuDQo+IA0KPiBUaGlzIGlz
IGV4YWN0bHkgd2h5IHRoaXMgcGF0Y2ggY29uY2VybnMgbWUuIFRoZSBpc3N1ZSBkb2Vzbid0IHNl
ZW0gdG8gYmUgc3BlY2lmaWMgdG8gdGhlIEFEVjc1MTEsIHlldA0KPiBubyBvdGhlciBicmlkZ2Ug
ZHJpdmVyIGltcGxlbWVudHMgYW55dGhpbmcgc2ltaWxhci4gSXQgc2VlbXMgdG8gaW5kaWNhdGUg
c29tZXRoaW5nIGVsc2UgaXMgd3JvbmcuDQo+IA0KPiBJIHVuZGVyc3RhbmQgYW5kIGFncmVlIHdp
dGggdGhlIGFuYWx5c2lzIG9mIHRoZSBpc3N1ZSAoYWx0aG91Z2ggSSBmaW5kIGl0IHdlaXJkIHRo
YXQgdGhlIGludGVycnVwdA0KPiBjb250cm9sbGVyIG9yIHBpbiBjb250cm9sbGVyIHdvdWxkIGJl
IHJlc3VtZWQgYWZ0ZXIgdGhlIEFEVjc1MTEpLCBidXQgYW55IGRldmljZSB3aXRoIGFuIGVkZ2Ut
DQo+IHRyaWdnZXJlZCBpbnRlcnJ1cHQgc2hvdWxkIHRoZW4gc3VmZmVyIGZyb20gdGhlIHNhbWUg
cHJvYmxlbS4gVGhpcyBtZWFucyBpdCBzaG91bGRuJ3QgYmUgaGFuZGxlZCBhdA0KPiBpbmRpdmlk
dWFsIGRyaXZlcnMgbGV2ZWwsIHVubGVzcyB0aGVyZSdzIHNvbWV0aGluZyBJJ20gbWlzc2luZyB0
aGF0IG1ha2VzIHRoZSBwcm9ibGVtIHZlcnkgc3BlY2lmaWMgdG8NCj4gdGhlIEFEVjc1MTEuIE90
aGVyd2lzZSwgYSBtb3JlIGdlbmVyaWMgc29sdXRpb24gaXMgbmVlZGVkLg0KDQpBRFY3NTM1IGlz
IHNwZWNpYWwgZGV2aWNlLCBoYXJkd2FyZSByZXNldCBhdXRvbWF0aWNhbGx5IHNldCB0aGUgc3Rh
dHVzIGJpdCwgaWYgYSBjb25uZWN0b3IgaXMNCmNvbm5lY3RlZCB3aXRob3V0IHNvZnR3YXJlIGlz
IHR1cm5pbmcgcG93ZXIgb24gdW5saWtlIG90aGVyIGRldmljZXMuDQoNCkRvIHlvdSBrbm93IGFu
eSBvdGhlciBicmlkZ2UgZGV2aWNlIHNob3dzIHRoaXMgaXNzdWU/IGkuZS4sIHdpdGhvdXQgc29m
dHdhcmUgdHVybmluZyB0aGUgcG93ZXIgb24sDQpicmlkZ2UgZGV2aWNlIHNldHMgdGhlIHN0YXR1
cyBiaXQgZHVyaW5nIHBvd2VyIG9uIHJlc2V0Pz8NCg0KQ2hlZXJzLA0KQmlqdQ0K
