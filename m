Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93891606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=XhVYK8Eg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD25810E4BE;
	Mon, 23 Nov 2026 16:16:59 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010071.outbound.protection.outlook.com [52.101.228.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578DF10E4BE
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0eNF7kVvEhWTE4J0If6OLOp8c/6bOey+2Ch/qATA7FNMsVYMMUb2gp7tm0m0dO0JR3ohnn6DcYvtR+MYqDU91BLAXTrKFjyPq2tk74dg6i0d7Nzok62sencaXYfRrEsfbZDj4/UFaM1lPlSWsKgsRflmxeENq1GqSvC3f+uVtofwCuZ1AhHIXTeUMJL+f9dr7MOgUXrAHDSjQE528nS43RMHneKAWxEdPtcaIsAe8iSPus1DqbNvRBi5W97Ef7/vAfZGvMAjpxemGgfSFzPsfAI68KLqJFHl92OwH8wt2z0qoizn+GNls7cwwVTquluhQom7loaFCPb8J5URbtNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H43if5ZJq7nJEbgDSn8oblDoK0fvIVVhHkm5OuSMzEI=;
 b=sqfk/60YJS5U/NgGpxFnHoXWuwizjf2tHB6hT6brmGNXy71vP8w+nXdfSKXX5ILG+gbCY3MZcvJL5Y9MAERuOK6rOiIcz0uCDs9CfMpxBg2LuVzvvpUHF0R12+PFEWuGki88qAi1/iV7FDhL4L99yMApVzZBqUURntCsCu66rbuAAWEBlj/O4r4EUKwgoDRDrlX8tNVNdBZcQ/z/fvDTN65EIk/ta/1/WKTJgn1+Y5e5j/6fnRsphezGAK29pt4NfreaR55VIfNlSMNcGwd5Dc7xp6fSLbLsTswfPmQW+FC7OGlCYKIBlYT/gacW8ckdI+I4v2rQ0vucsd1pElnSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H43if5ZJq7nJEbgDSn8oblDoK0fvIVVhHkm5OuSMzEI=;
 b=XhVYK8Egu7ZfFhfUbpfMIOKnV2REw5eqw+6HYdIeggTmBLDqQ1bWkDxhV6QvyTu6m3JRBMpCk+V5HZwcP6H1grZhfBAsX332zRT4++xjSFF99A1lNKR4N6Rlctep0YbBdsN2cwQWu4zdaVJx+q/vwPPT3orP13PSb+ktz3g7FBQ=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY3PR01MB10371.jpnprd01.prod.outlook.com (2603:1096:400:253::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:16:50 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:16:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Tommaso Merciai
 <tomm.merciai@gmail.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 04/12] drm: renesas: rz-du: Count all registered
 encoders for the possible clones
Thread-Topic: [PATCH v10 04/12] drm: renesas: rz-du: Count all registered
 encoders for the possible clones
Thread-Index: AQHdc2l2PpgSPwCMQU24gGwjyRcQzbc75O3w
Date: Mon, 23 Nov 2026 16:16:49 +0000
Message-ID: <TYYPR01MB6603A9BA2A0D853AB6F97BF286452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <a1d01f35c0e15947936e69ff0a642a2458ca2e67.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <a1d01f35c0e15947936e69ff0a642a2458ca2e67.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY3PR01MB10371:EE_
x-ms-office365-filtering-correlation-id: e2b10d2e-5342-408c-ab73-08df497d2dda
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|10067099003|261009223027099003|4143699003|11063799006|56012099006|5023799004|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|261026140227099003|261102123227099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: OrbV+3xHH3Doh8f5LI+DIe6tiiGxU/i9qEvc9sAh2roY/oB/Oza8R80YiqOt7HmgFBYe/GhUt3X8W+IVWuoPPoZkF1aQzn9z+Bg3Q8mQSDw/QX/RyL+qRn7rJrLDzDVVDJWtN4hVO/970INWjOS0gEpSVtYt47DJM7bzQ9udZNqWlLTBCRpNXcFhVLPlU67ds63HbEhNTiuJ1C/TJhK5NulHNsFfp1NO4DejUuEnsjegJzIsDvF6FoV0OlPrS7wxbKnBUUPL7ctnhYK4iJncfQQup4m5fdMdJhOAiYgkzmn59lgBoGxMbw/Cn3F3m2s9sMga6RW+cEBOu6cGoWXdYpa740E1WXOfsAF/n3rO+xp4apGE7e9bASk+ORVVc6XgkOAfMjykWn+wSM6nHHHlxnGz1nxKqA5K1Ya2TPguYixLvRTl2ozohsmDwHjpxZDGih1ULmD2qtZBC5ShlDfs6yrKL7MTFhtH7xAq2go3K0UbmIaSs2By7sVowsOAIW9n3Psl55lokcmMqgmX3NZZOwsVMeX3/brSSYniZJNfamhmXyJYr4LVA1OhhcdQHg/9HJzxhxlB0ji7Ub2I9cldqntK3VRq/mDA0cgypBbtXi6kjCZ6hNPZi/E1P6SmS7o2FhHi+yc+ywh7qeGin0ltaYXI31J1Y2k2h4kahCBVf3AHdT7ohTIBNSZNTGf+H0FiuNH0prdVER4E24p+Tn16oGeuNrchw9cieniHeEmwUXA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(5023799004)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261102123227099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zrXxq/I37sJP8JYXNN6jqY7u9jKvMQODfkUspc6jZmXsarpWxFW0oteqfzOP?=
 =?us-ascii?Q?v74+YZlD5oyY4QrOZcXWbLgCyfv65KzDDFkLvwDEdX8Aw/qsTl3cuKgngud4?=
 =?us-ascii?Q?UimGlxpXeML3jshOo2x1EjFrc68REXH7QLXkaSw8zh41P+4/fHAp1UnneucS?=
 =?us-ascii?Q?InHUDlWDZUO6gbZlLt/MK0e90DKIfVX4SLU9OYaf5S+4M0C6tDXE3NOsrI8o?=
 =?us-ascii?Q?EBUTEDRaJooOCeUgHy8QnrSiyifHqsE0VUQ6LLlkoVv9tZXbjMCEy2u9tSGR?=
 =?us-ascii?Q?1ujVfq+JcMpNTKnpbG7Qeb5qyihP1zKQwM/GTqW60O8wQEOz+9ntb+PdY1Li?=
 =?us-ascii?Q?muwydaGAcJIyppe1HtxtjONLZ0vtZQN02uNlfDq9pS8t1cdcsIEiqOjmaJ+J?=
 =?us-ascii?Q?0AhQE9lhILX3th1vZxQvP8yh/72b7w67Gw9B1GuCJp3+ZmCE8U7gzzj9jVCp?=
 =?us-ascii?Q?jDUI10W2QBhOqcsWhrMn2HoIEJhkfc7ZGio+2rytsd/zPDmlNnkW1AXQ8zQT?=
 =?us-ascii?Q?Ve+9CR9b2IfbBUM5yJEni26ayGeFR/wNS9WzFkMBmY79dZyC2bykqs47PPzB?=
 =?us-ascii?Q?dxPRkiJcTNE2pE4k7E9mpJ9vp8mCwwDTocf2GMWS9NEvv6x682TIY4Hk6eF6?=
 =?us-ascii?Q?7AfDr3kumz3W7YbulsINGrri+2Yt/zi6z0hM+D/7tYKx2iUf54gLwh6hQfJg?=
 =?us-ascii?Q?PmUru0dCjfdpQLdjmyfXWXgh3PTmJ1T2LBvoSD9ynXfq/8RfAAnp0tkgUccU?=
 =?us-ascii?Q?bBZl35Xe4xm0pr1IeYCMbdornIIMTBjzAwFrCz3Vr3/wgrR/H9kfQITAa7DW?=
 =?us-ascii?Q?4iIY7dyexII8jx/FVhxPHA8dub7vBnQoo0M+A2MKyOTn1W77Q7XddVtAeGww?=
 =?us-ascii?Q?yhq8MyVDt229+oLfqRvo6ZR8O+zwp77tUv5ID3CN53MxwyvA5YDmLdRe5AwI?=
 =?us-ascii?Q?0Hh3fgCsAV7NP1PQBiVGhPsEkW9yNLbJEyyvtWHZwej8xAw34N4RPFlmn8FK?=
 =?us-ascii?Q?5i0/bmuxBNa3M0l/Zk8I59Bdgv5BamUeEQ9kFmpeRaJ1w1jh7p7OfWaFlkZj?=
 =?us-ascii?Q?xVYNGgRPVHY2uLTPk0uLXBXdhUFDyIrAOLJz/ti5/Iw4XWSyPcblUCgslQqq?=
 =?us-ascii?Q?aMscZADSrdL0A3n66NMmN5OnB+Q9Wgw4jb3pjffFBQ4j2tpTmYUY2lRXGTzf?=
 =?us-ascii?Q?AtdAzSgN6g+Zjbj8es1orGqkbA8oE/cTjzcUT7RqQywkgD7vvZNkZyYlk8eN?=
 =?us-ascii?Q?wTujmfmqDg6CGWUyceodi4rFUMXxfA/1wfszYXWkqeJUWJ6kRyAIRM3R3wn0?=
 =?us-ascii?Q?Jou3B0BAdEyvMWWFS5yqTEAeFHzcxwM2sUYmUd3X047GWBIHATUPN2fs+nxS?=
 =?us-ascii?Q?dc1EgVnEtUmNYUnLsibkFD8uSpnffDKtK0du+4KCOm/YXKF6amgIMCZTmJiS?=
 =?us-ascii?Q?71ot7mj9/UDP6xuZdzvTQO54cH3SnhmfJTI2BJlFQJF1HSx2/QxdnshLerVU?=
 =?us-ascii?Q?QStImvkOqlX6iwaRw7maMRzplrZezj/L2TW6BMzjaHGsKo311vpZEC8S634F?=
 =?us-ascii?Q?RreXS+lj1/Yz5dXnqTEbM2+XUrjMEgAstfckOa2llNhHDD5RJLvpBnx5tB2q?=
 =?us-ascii?Q?ocrMZ/c2rDuVGwZrI3ENfOSApjaN/liswaxwp2oQN0ueIeuW3Alx2io5B5R3?=
 =?us-ascii?Q?GoFtSENuxJuJxmXdtkK959+cXz5DAiO9AIALPcTEXz/lx5lxZ8EOAgUGcJCo?=
 =?us-ascii?Q?dSwhH79niQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b10d2e-5342-408c-ab73-08df497d2dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 16:16:49.8431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwA7CZOaec5C9CSqaYpUcj+y/jrvTet3LaGyl0rJcQ04/MVwHnwXM5godPzy8H5EYjXxOauEz/djvK+D85i7rLRtKwwKyVjyXzMF2DI7OhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10371
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

Hi Tommaso,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 13 November 2026 12:20
> Subject: [PATCH v10 04/12] drm: renesas: rz-du: Count all registered enco=
ders for the possible clones
>=20
> rzg2l_du_modeset_init() sets the possible clones of every encoder registe=
red with the DRM device, but
> builds the mask from the number of outputs that rzg2l_du_encoders_init() =
initialized successfully. An
> output whose bridge fails to attach after its encoder has been allocated =
is skipped and not counted,
> while its encoder stays registered. The mask then misses the bit of the l=
ast encoders, and
> drm_mode_config_validate() warns about bogus possible clones.
>=20
> Build the mask from the number of registered encoders instead.

Looks this is a fix. Can you please move this patch at the starting and add=
=20
Fixes tag.

Cheers,
Biju

>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v9->v10:
>  - No changes.
>=20
> v8->v9:
>  - New patch.
>=20
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_kms.c
> index 13d14ecacba9..6eb1865f43b4 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> @@ -455,7 +455,7 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcd=
u)
>  		return -EINVAL;
>  	}
>=20
> -	num_encoders =3D ret;
> +	num_encoders =3D dev->mode_config.num_encoder;
>=20
>  	/*
>  	 * Set the possible CRTCs and possible clones. There's always at least
> --
> 2.54.0

