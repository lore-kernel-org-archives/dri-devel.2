Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78328C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D126910E19E;
	Wed,  8 Jul 2026 17:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vO1L5soQ";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011012.outbound.protection.outlook.com [52.101.125.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A415710E19E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl3QDMy++HrYBwoUIsQ69K1WAvkM4ST6X0PzE86US+TIALdej9b4Ug5uJehsWbxzgOZlllGoV5sxOxbdnSh6puyTarZaXZHxMWEjlJgPupo+Y44mSr4ZDVcfwpdCrkgOKW7j/0MyajRpKoqNiTIAZDUiYpFOt4SYzVoo4SKiEbEH9B0ahURMQZ+ASxxcpk9zwir9LvYBThtcuV7Ln+7/ksi/z7smBus/IPIYGrU/6Lt10V5P3h8Jyj3cmlWvGvY5IAmvLJ/smKOMRFipeKzMfo23je7sxRaX2fqZPnX0v1C9zD5y7wvPv2YiUxnL/w/R8GyB+3uOKdLaucQSd8Lp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfFreIk4zgQBJ3av4qWBANRCHpKhdxFEXueQqc3m0Rg=;
 b=qbHVRWdpnGTLvtuU8XZ5v3cLHTcXszTyHPnIBTrPMZYO8SnXpidOjBdAKcg4E/8chSqjzW+f1D1mLveUQSmqFZkAdqMNsiUOEUyzLiEmNiTXMzIFV+37sOhxr/1fmGsiL11L2HNtXFE3Ddb3wztPF8yS7Vj5IigfZTTej6uNp+/rbcQKAErUKvI2VZQ9b5ktDDd3P9Vc74Ue0EsMpmUc79SMKFwbD/W86YRHEuKPRxH4HQ76zeykdTgaNHX5eU7I2i2yH7hXQv7IcZ4d5oPhTjXooXMOiuc3e7+zAwSq+rGerzi+y3VoXpGMAE+zKP26YzGPTnbuJUfYBYMWljJRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfFreIk4zgQBJ3av4qWBANRCHpKhdxFEXueQqc3m0Rg=;
 b=vO1L5soQ3W09NWFtj1kGUDqEvER9jPxunDiKbRNotq8zWWj91k31+lMYs6rbYA4uDjnrLbgb87VvRVEXXtgUEMmIrISs14ujmuy1YTSEn7kaDmHPypHQOR0XE41AbOubFMJAwahrCzv7mo0tKg5tyF+fTwv/9FosqkVmHEdgdpY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB8411.jpnprd01.prod.outlook.com (2603:1096:400:176::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 17:16:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 17:16:50 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, biju.das.au
 <biju.das.au@gmail.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Geert Uytterhoeven
 <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 08/16] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Thread-Topic: [PATCH 08/16] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Thread-Index: AQHdC5hZh2JHiRrE40a4vvKhQ5Hh1bZj35mAgAADNdA=
Date: Wed, 8 Jul 2026 17:16:50 +0000
Message-ID: <TY3PR01MB11346F468A49EBE0D37463F6086FF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
 <20260704093433.273672-9-biju.das.jz@bp.renesas.com>
 <ak6CXxb3Rs3PB4Yl@tom-desktop>
In-Reply-To: <ak6CXxb3Rs3PB4Yl@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB8411:EE_
x-ms-office365-filtering-correlation-id: b074a4f2-11da-49ad-8b35-08dedd14b2d8
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006|3023799007;
x-microsoft-antispam-message-info: 5UWlRSiLzO13ai1vhHymKZiWKWF69zHM1fvaG9y58A1WST1aVHC8B2XNH0lAfwAHWoIpoEdsHti72ix9EaxjjMMyhAJn+HJSquQDw7x8sPS6LVc1tAXOfjc/Uz2vCS/uxq4V8wljzNLgCT0HCdm4JERhOWH9y8htQVP79N/iLTi8TC03Bbzem5/8h4oauH82VjfcG/D/qzv/hhJ2Gf5gkrF0CI0H+ju6dqz0Fj64Jc2NemLLzOExSxQrH9rmUdozGgnMkTGXDv5ZKUlg+enl0726tclqDRZgHW/SRr0O2ND6nK9w0qqrvXASZybqEqEVCvtcL/dpLhV0TcAKkTXX9m3Qcp6Zs7AJuXRRQvovdzEEgZ8m/b7/CKeNM4VoU1dFQgCw6GFAoRK+tjW7D9UguYXe4E4yliTv+JLRAdKTsBuuvd55PNZzsSLVn9x9B+9gP1NR5HB29CRLrF8LhstKvY6TW8Oplo6k98hdfj73Svu+1bD1ThkMO+xhX8kffCJytJF7eRjmFmidHax0ofSeSZQzc67ZIWLzOqZpswxsXrLWXAO+qorljsMitP8RwRmgY954GSKZqN4ALof3yiUZVXyR4/znW8DCVfcsSRPqHlfMpwUpPayCYMzLz3UFlLtMHfPDXlrMq0113QRwzkLBrsYy3fZJtxtmrPjFXg46K7ctxedb/dMKQSlpxsfzFk7xTb5GamT4BzJmiAqXFSsYHxxaLuyeaCGiIOn+6TbfL64=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aqoU4d6g/xjc6dS1v2o4IiExylbCfzL7jxBD5cIsh0lEciOIR16YuOVn/u0H?=
 =?us-ascii?Q?0LV+J3GpMAV1qt4Krs5XulFgaoFHD4xFspBdMw/nFn6ghQC4ks0OJyuIVJSs?=
 =?us-ascii?Q?eiJsBOU+kXo1sOFa26KzAoinYkfELdwrYy835bt34THCeMeiMZ8ULJNdABb1?=
 =?us-ascii?Q?k/dJWN9USapibW4zVXDPhusWOMYzLvc0vevYklQVRlsXL5SCks0XN0TuCGBZ?=
 =?us-ascii?Q?jz2MfG0r4/ydaoFIhA7j7Y7rUz7PbIb9nkTiG0Zy5PlXORDtVRr8DbeDfWM4?=
 =?us-ascii?Q?lwLyuwhF43gKOrV/eBbOPRCpHyXzbRvCoPfWvdwNKHyYpIaKZyuDjRN8fmLJ?=
 =?us-ascii?Q?mQR3do4W6enbYcqrfSBRuJy74gpiXrn1+9XQPRNvO2Oh9uEcg1rgaSCzPcdo?=
 =?us-ascii?Q?q/GQhueWloLy2r45odjRb1TIVo4E0NFTrFjoDq9f5GvBLpcZlLuMBFZvX1Z8?=
 =?us-ascii?Q?Wb9qHwCgfHP7UAhQu6hQBIp6DXa2sld7ztN9BEkp+8LwSh2jHYMIwbTTtXNZ?=
 =?us-ascii?Q?Kb8V1JCeUGsh6WT9J8QKDqsbC61/t/8+2Q8Iy2KNQEMtmWzkTADN9WwvYVow?=
 =?us-ascii?Q?p5iFF8Ro7IH4C6hUSsudDmbnmoQPGLEZLiT1r/T3P9yq8wLsyPCVi8ILImBB?=
 =?us-ascii?Q?ACBqK/mHyFdBBUUNNaNagnpDUo7UTg4kTn/iFGwDGW1liYbpIk0WVj83/nh6?=
 =?us-ascii?Q?Dbu6nRvIsij+gY1GNFM+51QAXU02PjMo1VPzXW0snGMIudKyisP1S89CRQtZ?=
 =?us-ascii?Q?qcLit+iIe9V3Ou7dJOnLeSD2w7qYNddFXsats587BvEDCT9jK6a5BjkBmwWX?=
 =?us-ascii?Q?T3KzMR2BWw6qZn7GXFNCA//fj098TlN67xxNrIEAJIZo5eZaMEiVQ0WdsVM8?=
 =?us-ascii?Q?2e/XpmZc9NwET9U/7BxS6tJeS1vysq7GGdzGQ3aYqkgyF4hHbHrdl47qHYtQ?=
 =?us-ascii?Q?tf12Xdbw3iDhjwYi+tM3iC6SzWInuMcdWWoohaMjS5hqjidIpI1U84Dhg6t3?=
 =?us-ascii?Q?hemkVEM3ZscWxTdcZQVXvazkqLyFWv8E7sYQUW/+eTQ7NKVG3/xGnbexbQbt?=
 =?us-ascii?Q?weg1LBfgcf5xR8yExxsMN4WfaKZbSiSyz3Gno7VwK41TbkOpT2uA9cZtXEk3?=
 =?us-ascii?Q?U4xht2Ppr0NL1H4/cKMHhXAnzpJihDH9Ht74iB/L8ME41g0JKGVasxg07YAo?=
 =?us-ascii?Q?vtByKfErPSfEKzbhbkX5wo6lBsXrCma5+q4uBQ/0PaVGnFl21gPxt46Kg7Gp?=
 =?us-ascii?Q?H/0zBOFY9v1xkCjXsbmB0cd8wpywtvD91RRnOSQFcnJmB38SCBaf748uCxx2?=
 =?us-ascii?Q?90+Q8Z6TcRg6eQxlHZIAjrMb5ahS4g80tTFYbIFWC/LXFNfcASZ4x/MTpI4W?=
 =?us-ascii?Q?1Sr4pzgTpGm1h+K5BONGy7zYnpOGR5DBKL4SxKYBhhNxBB4rN3WkF+Kt+YOj?=
 =?us-ascii?Q?rGqEkt4kuIaobwSUQjEfaJmVdGBFTSY9D9qJM8DXWzS0mJBDnJDMUAvc9YIe?=
 =?us-ascii?Q?EtknxfW06/65j9igU1Oubq/v7NADHb8J3zQm7b6HpFJQ3s218Nis9/3WrwVb?=
 =?us-ascii?Q?3U+HPtVv/QIvBHmZJRjuRSDZz3Yl2b4DTJrd/mXTovQkd6pbC4FrCFUFNm+l?=
 =?us-ascii?Q?cvYBf5C9tfYMspOQJ9wvYt3dCCZWnhUf0wYjDrAMSro7QXid5RkBIlSKX8rm?=
 =?us-ascii?Q?L0eTnPfIlJtGSLuePoaewx4CyE72evNt1bjaFqqMPKduWZkVp+frKTibHzkh?=
 =?us-ascii?Q?z3hU4gCvhw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b074a4f2-11da-49ad-8b35-08dedd14b2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 17:16:50.2503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ei3mUfRyI5/24ut2HMi3xxQh2Nmpt2jT4HHw+RYmYpz72P45qXDR9rVV1Tu7nLNmdb6kpWPg3JssfIcGOvvq5jvWnQixwaHLWBGciQ7AxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8411
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

Hi Tommaso,

Thanks for the feedback.

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 08 July 2026 18:01
> Subject: Re: [PATCH 08/16] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU=
 support
>=20
> Hi Biju,
> Thanks for your patch.
>=20
> On Sat, Jul 04, 2026 at 10:34:18AM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Add Display Unit support for the Renesas RZ/G3L SoC (R9A08G046). It is
> > similar to the one found on RZ/G2L, but has LVDS support.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 22
> > ++++++++++++++++++-  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |
> > 4 ++++  .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  4 ++++
> > .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.h  |  1 +
> >  4 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > index 3d13f61d3c97..a8d841421a0b 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > @@ -55,6 +55,24 @@ static const struct rzg2l_du_device_info rzg2l_du_r9=
a07g044_info =3D {
> >  	.mode_clock_max =3D 83500,
> >  };
> >
> > +static const struct rzg2l_du_device_info rzg2l_du_r9a08g046_info =3D {
> > +	.channels_mask =3D BIT(0),
> > +	.routes =3D {
> > +		[RZG2L_DU_OUTPUT_DSI0] =3D {
> > +			.possible_outputs =3D BIT(0),
> > +			.port =3D 0,
> > +		},
> > +		[RZG2L_DU_OUTPUT_DPAD0] =3D {
> > +			.possible_outputs =3D BIT(0),
> > +			.port =3D 1,
> > +		},
> > +		[RZG2L_DU_OUTPUT_LVDS0] =3D {
> > +			.possible_outputs =3D BIT(0),
> > +			.port =3D 2,
> > +		},
> > +	},
> > +};
> > +
> >  static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info =3D {
> >  	.channels_mask =3D BIT(0),
> >  	.routes =3D {
> > @@ -81,6 +99,7 @@ static const struct rzg2l_du_device_info
> > rzg2l_du_r9a09g077_info =3D {  static const struct of_device_id rzg2l_d=
u_of_table[] =3D {
> >  	{ .compatible =3D "renesas,r9a07g043u-du", .data =3D &rzg2l_du_r9a07g=
043u_info },
> >  	{ .compatible =3D "renesas,r9a07g044-du", .data =3D
> > &rzg2l_du_r9a07g044_info },
> > +	{ .compatible =3D "renesas,r9a08g046-du", .data =3D
> > +&rzg2l_du_r9a08g046_info },
> >  	{ .compatible =3D "renesas,r9a09g057-du", .data =3D &rzg2l_du_r9a09g0=
57_info },
> >  	{ .compatible =3D "renesas,r9a09g077-du", .data =3D &rzg2l_du_r9a09g0=
77_info },
> >  	{ /* sentinel */ }
> > @@ -92,7 +111,8 @@ const char *rzg2l_du_output_name(enum
> > rzg2l_du_output output)  {
> >  	static const char * const names[] =3D {
> >  		[RZG2L_DU_OUTPUT_DSI0] =3D "DSI0",
> > -		[RZG2L_DU_OUTPUT_DPAD0] =3D "DPAD0"
> > +		[RZG2L_DU_OUTPUT_DPAD0] =3D "DPAD0",
> > +		[RZG2L_DU_OUTPUT_LVDS0] =3D "LVDS0"
> >  	};
> >
> >  	if (output >=3D ARRAY_SIZE(names))
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > index baf076d69cda..0b86c5a01210 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > @@ -21,10 +21,12 @@ struct device;
> >  struct drm_property;
> >
> >  #define RZG2L_DU_FEATURE_DPIO_OE	BIT(0)	/* Has DPIO output enable cont=
rol */
> > +#define RZG2L_DU_FEATURE_SMUX2_DSI_CLK	BIT(1)	/* Per output mux */
>=20
> This is not needed, we decide to move setting clock duty cycle handling i=
nto encoder driver.

Agreed.

>=20
> >
> >  enum rzg2l_du_output {
> >  	RZG2L_DU_OUTPUT_DSI0,
> >  	RZG2L_DU_OUTPUT_DPAD0,
> > +	RZG2L_DU_OUTPUT_LVDS0,
> >  	RZG2L_DU_OUTPUT_MAX,
> >  };
> >
> > @@ -61,6 +63,7 @@ struct rzg2l_du_device_info {
> >  #define RZG2L_DU_MAX_CRTCS		1
> >  #define RZG2L_DU_MAX_VSPS		1
> >  #define RZG2L_DU_MAX_DSI		1
> > +#define RZG2L_DU_MAX_LVDS		1
>=20
> This is not used, please remove.
>=20
> >
> >  struct rzg2l_du_device {
> >  	struct device *dev;
> > @@ -74,6 +77,7 @@ struct rzg2l_du_device {
> >  	unsigned int num_crtcs;
> >
> >  	struct rzg2l_du_vsp vsps[RZG2L_DU_MAX_VSPS];
> > +	struct drm_bridge *lvds[RZG2L_DU_MAX_LVDS];
>=20
> Same here.

Ok.

>=20
> >  };
> >
> >  static inline struct rzg2l_du_device *to_rzg2l_du_device(struct
> > drm_device *dev) diff --git
> > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > index f50d166b764f..7315d437c2ea 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> > @@ -105,6 +105,9 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *=
rcdu,
> >  			return -EPROBE_DEFER;
> >  	}
> >
> > +	if (output =3D=3D RZG2L_DU_OUTPUT_LVDS0)
> > +		rcdu->lvds[output - RZG2L_DU_OUTPUT_LVDS0] =3D bridge;
> > +
>=20
> Same here.
>=20
> >  	dev_dbg(rcdu->dev, "initializing encoder %pOF for output %s\n",
> >  		enc_node, rzg2l_du_output_name(output));
> >
> > @@ -115,6 +118,7 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *=
rcdu,
> >  		return PTR_ERR(renc);
> >
> >  	renc->output =3D output;
> > +	renc->rcdu =3D rcdu;
>=20
> Same.
>=20
> >  	drm_encoder_helper_add(&renc->base, &rzg2l_du_encoder_helper_funcs);
> >
> >  	/* Attach the bridge to the encoder. */ diff --git
> > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> > b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> > index 3e430c1f6132..8b048ca508be 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> > @@ -17,6 +17,7 @@ struct rzg2l_du_device;
> >
> >  struct rzg2l_du_encoder {
> >  	struct drm_encoder base;
> > +	struct rzg2l_du_device *rcdu;
>=20
> Same.

Will fix this in next version.

Cheers,
Biju
