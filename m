Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67039C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B63A610E078;
	Wed, 19 Aug 2026 08:17:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=analogixsemi.com header.i=@analogixsemi.com header.b="SSM2gIIU";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11022077.outbound.protection.outlook.com [40.107.209.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461FA10E078
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4A1qvVmk+poXYE74uzv0vKA2A2OmxXMYsJxUXcBkJqRWdk88plYGAu7YHgctelDJ/IlRhv2KuHZUCDqR7Go315HDdq1NEV17JxkcsUr237VTTRdid+taZGlDBpbaHjgxnIGuxW0NC09BElhvrnfwJ5fji4vkg4OHsBLqjpSRQXaxwQUYaV3L3ne0vDPagYSjL5DLYQ8pwhvo3a4HqMOc551K3ymLQl6C7o6o1lqfA5wGxFx1YbmH5GfHIH48RN+hPNAsm7CAoGZE9w4xmqB+VK/JS+rQCvr7TMofRsNI8XLr0WejNC6uo57ov/uPOwfNS3B8S7mVwVm29Ti1SMqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J44ZV49BDcUD7duP2Bc2bPI5S0Wq+Xkp2dzfrtm1TvQ=;
 b=GCBXALG5rkcLPrQe4aB36ure8PuRB6UJLx+FBCQ8DFrbO2n6ECpKIqbHCW9JSibzNtupPMZTYRii+rzZ7iKej7XHMpsoeWlhAk1eCdPXGNp/q5yDds40chRLTHF5s7OZn6TkaWm6obiwyaD8LWbvr7uexOtXHz0G4hVVuFYr9U/P0v/uzeVoAC4Pt6jVrFb9g1ED7lygrS81VpV1MA+LZfiNNDIpn6vls5qJAipWE0PqraDwXQl38Haw1wQ5DZcqyluBI1+TsUKJKHbUM1tUdgleVodPFtLTUCwRb6zZUS7m09pK2z3PAVQbqFQhvEjLNMzGmSr4qRINSbUlLDjGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J44ZV49BDcUD7duP2Bc2bPI5S0Wq+Xkp2dzfrtm1TvQ=;
 b=SSM2gIIUipQQCFmb4Urs12/uBXLHWOS1TTiI8Y2lVczslu9tEyEjC6fvZdnULCXHKSzuBLbeoK3vqomxocv6XPh9xRKxzz08KdNpwVsMr0onxR7tEgzKtzut0NqTSuRG4QyGAZHVaG547X4m8CTFdN3yiWpR7n6dbRKMNAt2fTg=
Received: from DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15)
 by EAYPR04MB10164.namprd04.prod.outlook.com (2603:10b6:303:2cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 08:17:51 +0000
Received: from DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c]) by DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 08:17:51 +0000
From: Xin Ji <xji@analogixsemi.com>
To: Chen-Yu Tsai <wenst@chromium.org>
CC: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "r.mereu@arduino.cc" <r.mereu@arduino.cc>,
 Bernie Liang <bliang@analogixsemi.com>, Jason Huang
 <jhuang@analogixsemi.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] drm: anx7625: add I2S input stream right justified
 control
Thread-Topic: [PATCH 2/2] drm: anx7625: add I2S input stream right justified
 control
Thread-Index: AQHdLrY8i5EqSLZiNEitGDPLpHyjNLajgx4AgAGFO2A=
Date: Wed, 19 Aug 2026 08:17:51 +0000
Message-ID: <DM6PR04MB6970CD5B4120D642CF043F57C7A52@DM6PR04MB6970.namprd04.prod.outlook.com>
References: <20260818020559.961335-1-xji@analogixsemi.com>
 <20260818020559.961335-2-xji@analogixsemi.com>
 <CAGXv+5H8_-vFh3KJTsjkkOfoUAAQ02BC0Jszb9rk6vDfnPHEVw@mail.gmail.com>
In-Reply-To: <CAGXv+5H8_-vFh3KJTsjkkOfoUAAQ02BC0Jszb9rk6vDfnPHEVw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6970:EE_|EAYPR04MB10164:EE_
x-ms-office365-filtering-correlation-id: 8792ca13-f6d0-4062-2093-08defdca5ce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 86WekrtNlynTlSAYkfNLhDbahbu7zlyHyqzPWCTZDQblx49ysliXRXvJngc9Gf95Dy4Mws5wSySQxS7diWXY75VMxq1NXtZbzaj6dkere/mCqe7JzldSCiWzocTj/6WDh2PAP4myMn0YfarLNgM0zMbJPGe+sPVPrh1BVgO74RVI+o1RG7ol7wX6gZ3r09L3Ed706AnNIDjvxVE2NmWXsP2TqRcPSKq+eGfOSElRWufnwjXb+wrBElS5bsp5egInLiINsp1vJjZa1QLWAyB5f5hn5I41fpvd//FEDXhWFcgNqdNPRAtUc2E9P0cmaqOJCNzcvF3JcKQ02MP9FvdNcjcOL751L6agR4F7yrBQ8HZNZOURh2kHDq2cPXCp8zWgnDGhns2XGxUeIVz0RdaIMvdVBJebzi0MO88uxHSRADQNHOCATIdDSOgMmsYBnix8V8NPr7L+6L4vfQi18P8sBQ2OpjNAqODzLJGFw+l5T9/Zh2jbzvxtcOsJusJAHmk49MGx79xDMLsH2rlbmh67G24rrhn6XvlV8yf7CG+n9w6IuCL3ffhypMjn3lT4XAE40TZvExK4JHWGpRXmpLUAsZwdjVUsHdmeDJShIFQ2DApq+iyvxG+UalAEsjYwxQkwoz3V//sofdpAQ8+UKkT+eRnX2f0vjTuvfSpXO0iXXEhLxBSm+MWIix9NQs96vBUY4AQZJZEmbX1lcl2wCE5YyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DM6PR04MB6970.namprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d00yUTZTM29YdGNncG9YL2diZitIYzZNUEp1YnQ3dXU4Q1M0ajVXZnN2aEJo?=
 =?utf-8?B?U2xrSFM3S0NHTThiaXV1Q0FOL0ZXcFRGVWRNbVY4Zlg5bGIrVWhTVU9tNmtX?=
 =?utf-8?B?SlZtZ2dYZnFwc1NDUkRpai8zVytRRVVJTUZkLzB5VzQxTmlYR0ZxSS83MGhz?=
 =?utf-8?B?UGtMWGIvUncvWjREZk1pcTMzNk0zSzdpRVZmeHp1TDZhRVRseUVaditjUFU3?=
 =?utf-8?B?NWhnQTZmZVlPaFl2OUVVbWRHUUl5dHNEU2dVekhDd0pXMWVxRVIrcjgrNmNY?=
 =?utf-8?B?TzkxelpGNDhPOVhQeGt1WktiWXRwR0pSRzl6T2JERE55VlBhdm9udXE1Mlkw?=
 =?utf-8?B?MFNENVFIZXFDa1dENlB1aklIejNla1liK1NBT0d0RWVFVFpRZXV5a1QvTDJv?=
 =?utf-8?B?bVlqTmJoSm5sUm5ERDVnNFFyRk14eWhVQUtPaElSc0RHRVo4RUl3ZWM0N216?=
 =?utf-8?B?OGxLUzBDbnB1dWVkZy81YWg0NGhFb0Rnc3NnZk5nTkhmOU9SWFRsOWlhQlJB?=
 =?utf-8?B?VWNYM20zdVUycjh2SmY1ZzRZdlFySHFNZ2srdWlKVGZ1ajhlZWdlVkZBbWs5?=
 =?utf-8?B?MEIrcVk2bmZPM1plT1NxbmdYNWJDTlp3N05neVNTR3hmRWJCSnZVZkUxZC9S?=
 =?utf-8?B?Njc0RE5mQ2hSeTY3TXJtamppaXBUU21DQTIwVGUxbFZzSWhTS1J4cFh0Ui9C?=
 =?utf-8?B?TzhoamRCeGhrb0hsSUJxcWxhbllOM01lQi9Ob3NOZy95VWh0SWZ6QXZTdTNj?=
 =?utf-8?B?UXN5WTJ0RmozamRTSXNBdVdmdStBYTdmdlhDVjFreVoxaFFyVjVaNUNuRjJh?=
 =?utf-8?B?TzAvYWt3a2hJdTVZWG1WaDlRRFp3bFhLNGpiUTBKWGUrUmU2cGNJN3J0Y1RS?=
 =?utf-8?B?bGZQK2FqM005WG1VcWRMSjN4UFQ1MFh3REVLR3I0MnArdWNFUHV4RFcwQlZ6?=
 =?utf-8?B?TmtiaWVGa1N6S2owNENGSWdxbjlYUFppSFRaRUdjWVRtbXJFR0x4NklHMmlB?=
 =?utf-8?B?N25McnQxcC8ya21rTDdLd0MxMEROWlZDVEowcE9qSVNkZmxrOUNhZFdUYVQ2?=
 =?utf-8?B?Zk4rd3piaVFlM1E4dk41T0VDa3FaZmh4Vk9PK2dnR2ZxNGxQejJYV2tuMGVZ?=
 =?utf-8?B?NnhTQW5YaC9Qc0E1TWJhU0ZrZEREZkN4cUxjU01FSXNkRDU2VERqYmFxdTkz?=
 =?utf-8?B?eTg2V3hTcVNPdXhNZ0NBdjU5bVRSTHJYY2lRdkQxQThOdkt6ZERxSExaVk0z?=
 =?utf-8?B?SHZiT3RseVpyUHIrS2N6WFlMNzUzdU1QMC9Cb2QxTVBIcTJ5TXVML0ExcHNM?=
 =?utf-8?B?aXpJSm5nOHdxcWl0L3R0bFZsbXNNUWVBSGc5QlRCcThZQXozejdTVGwvdk5r?=
 =?utf-8?B?K2IxOEpMdXIvbFZwbjY5L2pIdERpMXlRWFhralczZmdTcnZ3S1RyUXFMbzBE?=
 =?utf-8?B?Y21qL0tzaWplK2NvMS8vM0p2WGVUTThQaG1LVWRLV3FKY1RaZVdjdTc0NzVG?=
 =?utf-8?B?d0VBQ3N3YXpjMjY2SDFoTUNBekZPcTM2RWpESVNtNFl0K1FCWlVQYi9hbCtn?=
 =?utf-8?B?UTFEUGVTWlpJSkVVczhhYmwwc1ZLV2xkSlk5eU1zZFZZOWszS1BOTmtRUHlw?=
 =?utf-8?B?UVVyREhndXIwcEQ4MW5OcVBtUFZsek1aZEE2dHFUallQemxGQnZUYVRxVVRE?=
 =?utf-8?B?dCtkVFlUNWowU2NZeU9ZR0dKcGJ1NGQ5RUViV2ZuMGdQOTk1ZzF6UUkxMnZj?=
 =?utf-8?B?Zi85NHFVcXRMWEtFRG9IL0hQd21PbkdMZ1FrazVienJCUXlNNjhrd2F6YWRL?=
 =?utf-8?B?TXJPRHJ6WGw0ZnpqbDVMemdoZTEvSW9lL3VXTUdWSWdEM21kQ0owSllCSjJM?=
 =?utf-8?B?RmhEcFg5aytvMjdTY0NENjJSWEJyTXNLWlFDYzh6TXIrUlRMaU8yMFFQaHlS?=
 =?utf-8?B?Sng0b0hjMHZFaW4zM3dYL2RRc2NnUkdOUEVJNFVsOGd3UlR5bXBjTUxDRURy?=
 =?utf-8?B?YWZhbEhIMDVFaStJSmY5WTJ5OTF3ZWpaQkJrR3dPajdmNElmMjgxQmQ5M1Rz?=
 =?utf-8?B?ZC84SEZ5OFUxbFZrZWFvS1lUUG9hYmIxcW9qRjFRTHBvU1RkSEttc1grUGU0?=
 =?utf-8?B?dCtQbzJnakVRaW11TGJ0a0JjRGVrT3NmbDNpbTJZSTZhVXA5VVBiMWwwT1hX?=
 =?utf-8?B?eExkSElkbE53cTBhR2gwWDJMc3dWclE4eXNYTDJ6TEFaNVlGRmx2ZEQ3NFY0?=
 =?utf-8?B?NkhjNWRza1MzT1ArcEd3ZXdHd2lNVGVYMWtBQzBDMHhFbGE3RFJHeEplTTA0?=
 =?utf-8?B?UkNzbW1UKzFuem5kT1I2T2FXZ0N4cmZUMlVoV08wN2dMVUEwakhqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6970.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8792ca13-f6d0-4062-2093-08defdca5ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 08:17:51.6142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MR3KIcTC5vdCLYScSsoRDdvtE7oxSOzfC0eMqdzJbIZenNL8rj+o50zKgeYCVj9xGylJcrk1GVAFexUkM6W0vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR04MB10164
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

PiA+DQo+ID4gVGhlIGRlZmF1bHQgYXVkaW8gZGF0YSBzdHJlYW0gaXMgbGVmdCBqdXN0aWZ5LiBX
aGVuIHRoZSBwcm9wZXJ0eQ0KPiA+ICJhbmFsb2dpeCxhdWRpby1yaWdodC1qdXN0aWZ5LWVuYWJs
ZSIgaXMgZGV0ZWN0ZWQsIHRoZSBjb2RlIGVuYWJsZXMNCj4gPiByaWdodCBqdXN0aWZ5Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogWGluIEppIDx4amlAYW5hbG9naXhzZW1pLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hbmFsb2dpeC9hbng3NjI1LmMgfCA5ICsr
KysrKysrKw0KPiA+IGRyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW54NzYyNS5oIHwg
MyArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hbmFsb2dpeC9hbng3NjI1LmMNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW54NzYyNS5jDQo+ID4gaW5kZXgg
YzNhZjg4ZTE0ZjhiLi5mNGJjZTAwMDA2NzYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2JyaWRnZS9hbmFsb2dpeC9hbng3NjI1LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YnJpZGdlL2FuYWxvZ2l4L2FueDc2MjUuYw0KPiA+IEBAIC0xODgzLDYgKzE4ODMsOSBAQCBzdGF0
aWMgaW50IGFueDc2MjVfcGFyc2VfZHQoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICAgICAgICAg
aWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgImFuYWxvZ2l4LGF1ZGlvLWVuYWJsZSIpKQ0K
PiA+ICAgICAgICAgICAgICAgICBwZGF0YS0+YXVkaW9fZW4gPSAxOw0KPiA+DQo+ID4gKyAgICAg
ICBpZiAob2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAiYW5hbG9naXgsYXVkaW8tcmlnaHQtanVz
dGlmeS1lbmFibGUiKSkNCj4gPiArICAgICAgICAgICAgICAgcGRhdGEtPmF1ZGlvX3JpZ2h0X2p1
c3RpZnkgPSAxOw0KPiA+ICsNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4g
PiBAQCAtMjA4Myw2ICsyMDg2LDEyIEBAIHN0YXRpYyBpbnQgYW54NzYyNV9hdWRpb19od19wYXJh
bXMoc3RydWN0DQo+IGRldmljZSAqZGV2LCB2b2lkICpkYXRhLA0KPiA+ICAgICAgICAgICAgICAg
ICByZXQgfD0gYW54NzYyNV93cml0ZV9hbmQoY3R4LCBjdHgtPmkyYy50eF9wMl9jbGllbnQsDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBVURJT19DSEFOTkVMX1NUQVRVU182
LA0KPiA+IH5BVURJT19MQVlPVVQpOw0KPiA+DQo+ID4gKyAgICAgICAvKiBSaWdodCBqdXN0aWZp
ZWQgKi8NCj4gPiArICAgICAgIGlmIChjdHgtPnBkYXRhLmF1ZGlvX3JpZ2h0X2p1c3RpZnkpDQo+
IA0KPiBBcyBTYXNoaWtvIGFscmVhZHkgbWVudGlvbmVkLCB0aGlzIHNob3VsZCBjaGVjayBhZ2Fp
bnN0IHRoZSBmb3JtYXQgKGZtdC0+Zm10DQo+IGhlcmUpLg0KPiANCj4gSXMgdGhlIHJpZ2h0IGp1
c3RpZmllZCBmb3JtYXQgeW91IHdhbnQgdG8gc3VwcG9ydCBmb3IgSTJTIG9yIFRETSBvciBib3Ro
Pw0KPiBGb3IgSTJTIHlvdSBjYW4gY2hlY2sgaWYgZm9ybWF0ID09IEhETUlfUklHSFRfSi4gVGhl
cmUgaXMgbm8gcmlnaHQganVzdGlmaWVkDQo+IGZvcm1hdCBmb3IgVERNIGluIExpbnV4LCBzbyB5
b3Ugd291bGQgbmVlZCB0byBhZGQgdGhhdCB0byBBU29DLg0KDQpIaSBDaGVuWXUsIHRoYW5rcyBm
b3IgdGhlIHJldmlldywgcmlnaHQganVzdGlmaWVkIGZvcm1hdCB1c2VkIGZvciBJMlMgb25seSwg
YW5kIEknbGwgdHJ5IHRvIHVzZQ0KSERNSV9SSUdIVF9KIGFuZCB1cGRhdGUgcGF0Y2ggbGF0ZXIu
IFRoYW5rcyENCg0KPiANCj4gQ2hlbll1DQo+IA0KPiANCj4gPiArICAgICAgICAgICAgICAgcmV0
IHw9IGFueDc2MjVfd3JpdGVfb3IoY3R4LCBjdHgtPmkyYy50eF9wMl9jbGllbnQsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFVRElPX0NPTlRST0xfUkVHSVNU
RVIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJJR0hUX0pV
U1RJRllfQ1RSTCk7DQo+ID4gKw0KPiA+ICAgICAgICAgLyogRlMgKi8NCj4gPiAgICAgICAgIHN3
aXRjaCAocGFyYW1zLT5zYW1wbGVfcmF0ZSkgew0KPiA+ICAgICAgICAgY2FzZSAzMjAwMDoNCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hbmFsb2dpeC9hbng3NjI1LmgN
Cj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW54NzYyNS5oDQo+ID4gaW5k
ZXggOTU3ZDIzNGVjMDdjLi45ZGQ5OTcwZDIxNzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2JyaWRnZS9hbmFsb2dpeC9hbng3NjI1LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYnJpZGdlL2FuYWxvZ2l4L2FueDc2MjUuaA0KPiA+IEBAIC0xNTQsNiArMTU0LDggQEANCj4g
PiAgI2RlZmluZSBIUERfVElNRSAgICAgICAgICAgICAgIDU0MDAwDQo+ID4NCj4gPiAgI2RlZmlu
ZSBBVURJT19DT05UUk9MX1JFR0lTVEVSIDB4ZTYNCj4gPiArI2RlZmluZSBSSUdIVF9KVVNUSUZZ
X0NUUkwgICAgIEJJVCgwKQ0KPiA+ICsNCj4gPiAgI2RlZmluZSBURE1fVElNSU5HX01PREUgMHgw
OA0KPiA+DQo+ID4gICNkZWZpbmUgSTJDX0FERFJfNzJfRFBUWCAgICAgICAgICAgICAgMHg3Mg0K
PiA+IEBAIC00NDQsNiArNDQ2LDcgQEAgc3RydWN0IGFueDc2MjVfcGxhdGZvcm1fZGF0YSB7DQo+
ID4gICAgICAgICBpbnQgaXNfZHBpOw0KPiA+ICAgICAgICAgaW50IG1pcGlfbGFuZXM7DQo+ID4g
ICAgICAgICBpbnQgYXVkaW9fZW47DQo+ID4gKyAgICAgICBpbnQgYXVkaW9fcmlnaHRfanVzdGlm
eTsNCj4gPiAgICAgICAgIGludCBkcF9sYW5lMF9zd2luZ19yZWdfY250Ow0KPiA+ICAgICAgICAg
dTggbGFuZTBfcmVnX2RhdGFbRFBfVFhfU1dJTkdfUkVHX0NOVF07DQo+ID4gICAgICAgICBpbnQg
ZHBfbGFuZTFfc3dpbmdfcmVnX2NudDsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
