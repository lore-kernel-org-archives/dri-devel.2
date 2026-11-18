Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA6606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=S3wZFVsi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F93710E727;
	Wed, 18 Nov 2026 11:17:44 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011020.outbound.protection.outlook.com [52.101.125.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4865010E727
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS9CrF569OXJPPqeqwAZPYVV04bIaX8AKrw67h1TSDHJJn46g2aVywkoGH6lpcLSpKJ5ALzgAgKxRpWmFAfxWZ+6is75KN84OLue3TguWlivtGlzZXA/5WYChmKnH26gnmX5fK5C3za1KQOYNwDxN5ZLzQXZ0qysqBXwOMeftNZmDtMzrsjGCwgG7na0XDx1eHn5oegdX9XAWsTdtUpPZUo+yu1JwYGyU5Q3wr6dRWZQMFwcGobhMFGIHCdQqXUmGiQLluit7qN/JnOS/1fFtM5rqyjck6ZIWrqyj4K3OktjPcNZ4Z+Ph0hn5wKXJ/DOJjQ5Qe0TuLmL5pj8iLd0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNfT7XloxtW3NKMlGw2tfZN0xflkyOM37rLpttlfNgw=;
 b=Njg5oLcmPeR/bizo05trKEhxQjl81Qf9ji7EcGJOuePgp8pGnjxeuMW0F+LWi1OFhGwBv4NbJ5AhQOnWF77MdxENqLLEP2s8gFgJUK494ULKWN12pprH5KNLUcaSQjWTon2Tw7RAmNvw83RPB2uqmPfyG71Ugo5eGB8iU88zcwE1eaBddl1dRJvtVBUgf7SSJczquCBi202ReKzY9mKCB+SSWpNhzgzE5L7+QVIQDAa1AtPOZazjBUu2rJkgiFpy61eazP0acYv0zv0CuWbfS6FNu6hJ4eCPb9W3gGDktd4bDI7IVnxgJMvJGTdWnDnTd7ehOJxAbWUj6gMRRdnQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNfT7XloxtW3NKMlGw2tfZN0xflkyOM37rLpttlfNgw=;
 b=S3wZFVsi4g77w3qaMGG0NgVdp6DYVzYq/tvh4yJ9E8KuiChfuC4H8Y9b4X6fBrTZx8xclldIZfTVuo+6SFMSCyT7gNYBeC/9usMDnKTTvOqw0awSnVNTXzMnoOW8IQ7beml1y6Pz/nqa8ynH9xsuwFFd9o5Gldao1b6dcJLq9NI=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OSCPR01MB14329.jpnprd01.prod.outlook.com (2603:1096:604:3a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:17:35 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:17:34 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tommaso
 Merciai <tomm.merciai@gmail.com>
Subject: RE: [PATCH] drm: renesas: rz-du: Add suspend/resume support
Thread-Topic: [PATCH] drm: renesas: rz-du: Add suspend/resume support
Thread-Index: AQHdcn9jGtAl/8lyWUeAzooLZoTu0bczt6pg
Date: Wed, 18 Nov 2026 11:17:34 +0000
Message-ID: <TYYPR01MB6603741389AFAC2EABB42480867A2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com>
In-Reply-To: <20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OSCPR01MB14329:EE_
x-ms-office365-filtering-correlation-id: 4f89ab6c-0180-4c1c-34f4-08df45658bbf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|261009223027099003|11063799006|56012099006|261026121527099003|261028144727099003|10067099003|261026140227099003|261022105027099003|261021121427099003|38070700021|261102123227099003|261022075727099003;
x-microsoft-antispam-message-info: 1S9CaoJWUOeYQ0QgQGotVWG21Rtl0AZW/Pdg9s/jsb3Y+XalI9mKIlFvWnplehmEvvYwUniFo8PeCHaDybdaRFY0NoZR9k9hh72ktmL60rzAd0DVUbW12pO2DJXOldZ6sy+DArxWnn8i6Ob1LHEhDVVJkCNBPIN5JDq5JxZyoUOSgrfghhD/jhDc8OHhXOxbGwyIQ17j6RgQHSVT1N0uKuf/YoJEN8VV5RnilWdWvFqPE8jMn1uhm3XWxhFEBYFyE7D+tbmwz1bPbNatIgRrlifZJBznsuMEYaIsJdVvN83vesyeEvVqabU063g0s9XMKH32U2qzN4OWbFsxXhi/+QQATjEthWqXbcsndK/eJItLnK0b8RGjlEBF5JSX8x17hNzgrolWjxpsRLhoGOozIFObAwqMkGnDRAXgWR9eCxSvrNk1mfHhVyxk6NVw56Pw/5M6Ex2RAvUJrcTEtJm13IUp5DKFTvTjIov8S8KMernl4GPRH1x/0PlHSE2Wubv0JDw0Ln658xnMH7z0BqfDMXkIz4xuM4zT6jFXpnVca4lFohBS/LfCPyVLvmpdZaH86jWxuiw2NgZcLU4Kv0n7e3ZIIOfifX7eEYAJzwwnTIhqur0iCjafB3WUD1Nj6SxziiNV+OMZ6y3stWptg2y1bgagkOqUiZcGd83E//xU/k3jAL+/5kRMWdmRHIS9umUlU2crou17PK0IovIQ4kXUDPxhymuFerYpP0a1/MUhksI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261026121527099003)(261028144727099003)(10067099003)(261026140227099003)(261022105027099003)(261021121427099003)(38070700021)(261102123227099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THhZc0JzQURrM3Y3WDNQaVQ1SDczMm11SUxsS1VwWEpPMTJMRjhUcVBldW80?=
 =?utf-8?B?d0VGdTIxK0l5TWZGVUpLM3pDek1EcEJScjlJY0ozSTFYNThjWHBjNy9MaVBK?=
 =?utf-8?B?T0x6WTJJNjR2VkU4QjIyWUJUTnFkSGhLSCtxOVV0dWlCb2ZNV29rRWJ4aHBM?=
 =?utf-8?B?czducEM2Y0RvVnhtYWp2U01ESm1rQ3ExbmMwbmJqL3doNzgxbUJKakIyMmsv?=
 =?utf-8?B?WGdENWZRSStUeHVyTHlabnBmSFQzckxFdldGTkg2dFhoeHg4WXRBQWZTVVJC?=
 =?utf-8?B?VitoUzg0SVBWcS92NUhCbERXMmxVeDQyNkgyZDZsQTRHY3gybXJSNlB2akQ1?=
 =?utf-8?B?eXA4OTBsVUFJNXFQelkxWWxEMU9pK29vM0ZKWlhXRVZxNm54WVpHL1JYQVlV?=
 =?utf-8?B?eXAvZjVEK1ZIYVVCZjBJUHZ4K0lhSzRRaFZHVG5WRExIZTRraEVUMUxVL0Y1?=
 =?utf-8?B?NUNOOHVQM1RYYVhyZ2JlMEFGMzA5QUkrZ1dVT1FyUFJFa1h4Q2szamtKbHFY?=
 =?utf-8?B?TjZCWmVlWjdmUmszd3JWVHRzWUtpZVpXR2VGYWRvSE5IR2pQZzdaQnlFQTR1?=
 =?utf-8?B?N2hVVGxpRnlma0d6enJSUkszOEZQSnYrNTEyMHJxZTJHeE01bWtXTFJGSTBv?=
 =?utf-8?B?cXhZS05sNEZqNTFlajVUaU9yTFlkaVB5R1hvYzA0NGVCdUorWEtjaGtHZU1X?=
 =?utf-8?B?a0t1TFNTdmJJeTh2K0E2UkM4RklpcENQeWNRSSs5c2FieU1LcU4zZXdieW9L?=
 =?utf-8?B?bnF6akQrQ2VlUWd1NmhZakp2VEVGTjAzOWR5U3RxcHNJYW1MU3BRcHYybldr?=
 =?utf-8?B?S3VzcGl3dngxaHBNenJOdmYvckxXdzdpU2pnVWh0M3JqbnNCZXE0bjJyUUQw?=
 =?utf-8?B?QmF1dW1tVjVmYVRoQk4yVFRoeS9LNkZmeVJtOHErQmNPanpPYjIvUFE0MmRj?=
 =?utf-8?B?QlhqQ0JvZ1dBVXFkM2pLNzFGWGpjV0UzVzB2eWNrdUx4Vkp3Ynl4cXBTVjZG?=
 =?utf-8?B?RWphUFZ5bUR0S21MNW0weGs2TDh1TXl6WER5ZGNJdnhIaEpIa1VJSE9ZUzJa?=
 =?utf-8?B?dUdYalZYcG9hZUROY2lwZlRtV01PSk1OZWRtWk5JQkVmVHkxVDdCZ0hYNWNB?=
 =?utf-8?B?bmdxbGVkQmJlMStDU0R1Mjh5Q2J5bEd6SnAwaVNLY1BYUDJWOHE1SzNjL2tJ?=
 =?utf-8?B?RnNNb3FwcEhzQWtzRXhDamZ5ZkRvRkFtQ016VWFoNGk3U29BVDMvWW12QTJK?=
 =?utf-8?B?Z0g3T0laM0JQYWRsSW40RHlDelE5NVM3VHBqYmRlaDZOQW5ZL0R2anlHWW5x?=
 =?utf-8?B?U2dpcFZOdUprZEhsdno0cG55RytRRzRKS0VWekNPSzVWQ1o4aWtmR0t0dHpY?=
 =?utf-8?B?QWhQTnNTTktoU1NINU51UHpzeGhkTUZjVFJUc2RQV0JENDBhVzB3dkNKSHVY?=
 =?utf-8?B?bFUycXFMelF4VVh3eHFkSUVyRzRrNk9rMm5ocElYR3pRNlFrUStJN29tRnhr?=
 =?utf-8?B?M0lGcDYrN1Q5TE0vQzk1by9ZczZ0SUFYK2QxNTV3MkQxa0NaS1REMHFiS29C?=
 =?utf-8?B?UDc0ZlNiUldibUhiZG9DZmFKS1gzd0UzQUNKSm0xancwak1yUVY1U1pHM3RU?=
 =?utf-8?B?VVE5dUNVZi9VS1dPNDh3eFpaNlNWY3gvZmFqTjFaLzJoeEg1SDBuQ1BvdEFj?=
 =?utf-8?B?c3NpUWtTNWhhdGEya3dldnBJVEZVVDdGanpkL2RVek9KWnc0MEhWUWdXS295?=
 =?utf-8?B?WEl0V2ZmeUpVL0xRZmJLVnljenZ2aFJrUHRCakxOTldsM1NabUMvczJvdmZR?=
 =?utf-8?B?VGx4OE1mVDlYc1dzWEZaTTVyd29iY2xMOFBWbjhhWWtUQnR0THlEQnlITW93?=
 =?utf-8?B?dnJDZkIwc1gyT2JHWU5wTWFDMXZCcmZ1SkE4MS95Q3U4SW5scXZzaGNpTTVh?=
 =?utf-8?B?L3RXMitJdFFMV2RIYm1uWGMrVkpOR09KR2hYa3JrZXd1Yk5DWmRGVE9SblJL?=
 =?utf-8?B?YmlFMUR2YlFVUWtIMHE4LzA4SURYcE9TTzFhYWNoVTFyYndLUTNoalJmcTQ5?=
 =?utf-8?B?bklvSHVNbDJsT0M3QU1TYzVFOFByL1M3ckoyOEx4eVBPeEFuOU1KSG1jb3Jt?=
 =?utf-8?B?YTVPSGZmSTNuSGZ6T3BFK21NTmlhSzhkMjlqd2ZTdlZEVG5INVFUOHBvcElQ?=
 =?utf-8?B?RHFVWExtMGRrNEFNbElRL252QlJYN0FDZDl3OHhlczZHeVMwL0dWL295dzNS?=
 =?utf-8?B?U3JTQVlHMDR3L2dRMWgzZjE4L0pNOFd5SHJFQVc3d1FYS2ZWb2M0UElRWktr?=
 =?utf-8?B?OGpGVUQ4Wm85TjQrdUE2Y1J1K01mQlZLREczVUM2aUJYdWtzSGhzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f89ab6c-0180-4c1c-34f4-08df45658bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 11:17:34.8270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCfkWT2H084/ZxosNt41scj+WQBbcy+jMsBSGFEqMFQEG/L1JUqUXSAmiztlAz5AFoUDUfPGZWgg60bgpBZq4kntLo6qHckBRdCH0mtsu9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14329
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tbWFzbyBNZXJjaWFp
IDx0b21tYXNvLm1lcmNpYWkueHJAYnAucmVuZXNhcy5jb20+DQo+IFNlbnQ6IDEyIE5vdmVtYmVy
IDIwMjYgMDg6MjUNCj4gU3ViamVjdDogW1BBVENIXSBkcm06IHJlbmVzYXM6IHJ6LWR1OiBBZGQg
c3VzcGVuZC9yZXN1bWUgc3VwcG9ydA0KPiANCj4gQWRkIHN1c3BlbmQvcmVzdW1lIHN1cHBvcnQg
dG8gdGhlIFJaL0cyTCBEVSBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUb21tYXNvIE1l
cmNpYWkgPHRvbW1hc28ubWVyY2lhaS54ckBicC5yZW5lc2FzLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCg0KQ2hlZXJzLA0KQmlqdQ0K
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMvcnotZHUvcnpnMmxfZHVfZHJ2LmMg
fCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yZW5lc2FzL3J6LWR1
L3J6ZzJsX2R1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMvcnotDQo+IGR1L3J6ZzJs
X2R1X2Rydi5jDQo+IGluZGV4IDZjMmRjODZhYmM3ZC4uYzdkNzFkZDkxOThlIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV9kcnYuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV9kcnYuYw0KPiBAQCAtMTQw
LDYgKzE0MCwyNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9kcml2ZXIgcnpnMmxfZHVfZHJp
dmVyID0gew0KPiAgCS5taW5vcgkJCT0gMCwNCj4gIH07DQo+IA0KPiArLyoNCj4gKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICstLS0tLS0NCj4gKyAqIFBvd2VyIG1hbmFnZW1lbnQNCj4gKyAqLw0KPiArDQo+
ICtzdGF0aWMgaW50IHJ6ZzJsX2R1X3BtX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+
ICsJc3RydWN0IHJ6ZzJsX2R1X2RldmljZSAqcmNkdSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
PiArDQo+ICsJcmV0dXJuIGRybV9tb2RlX2NvbmZpZ19oZWxwZXJfc3VzcGVuZCgmcmNkdS0+ZGRl
dik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgcnpnMmxfZHVfcG1fcmVzdW1lKHN0cnVjdCBk
ZXZpY2UgKmRldikgew0KPiArCXN0cnVjdCByemcybF9kdV9kZXZpY2UgKnJjZHUgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArCXJldHVybiBkcm1fbW9kZV9jb25maWdfaGVscGVyX3Jl
c3VtZSgmcmNkdS0+ZGRldik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBERUZJTkVfU0lNUExFX0RF
Vl9QTV9PUFMocnpnMmxfZHVfcG1fb3BzLA0KPiArCQkJCXJ6ZzJsX2R1X3BtX3N1c3BlbmQsIHJ6
ZzJsX2R1X3BtX3Jlc3VtZSk7DQo+ICsNCj4gIC8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAg
KiBQbGF0Zm9ybSBkcml2ZXINCj4gICAqLw0KPiBAQCAtMjI3LDYgKzI0OCw3IEBAIHN0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHJ6ZzJsX2R1X3BsYXRmb3JtX2RyaXZlciA9IHsNCj4gIAku
cmVtb3ZlCQk9IHJ6ZzJsX2R1X3JlbW92ZSwNCj4gIAkuc2h1dGRvd24JPSByemcybF9kdV9zaHV0
ZG93biwNCj4gIAkuZHJpdmVyCQk9IHsNCj4gKwkJLnBtCT0gcG1fc2xlZXBfcHRyKCZyemcybF9k
dV9wbV9vcHMpLA0KPiAgCQkubmFtZQk9ICJyemcybC1kdSIsDQo+ICAJCS5vZl9tYXRjaF90YWJs
ZSA9IHJ6ZzJsX2R1X29mX3RhYmxlLA0KPiAgCX0sDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6
IDYzMDA1OWE1YTYzMjM3N2I5YjdiNDg3YmFjY2RlOTJiN2FlMWRkNDcNCj4gY2hhbmdlLWlkOiAy
MDI2MTExMi1iNC10bS1wbS1kdS1lZGMwNzljNTlhOWYNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
LS0NCj4gVG9tbWFzbyBNZXJjaWFpIDx0b21tYXNvLm1lcmNpYWkueHJAYnAucmVuZXNhcy5jb20+
DQoNCg==
