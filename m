Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6B4C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4C110E208;
	Wed,  5 Aug 2026 16:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="g3QGBOyQ";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011015.outbound.protection.outlook.com [40.107.74.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369E910E208
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONLOijTqgSXCkzYkvGVAInvxHo0FQjGfQFJPK2fp0LSBUSTqdxugtAaNiBnx6aajSfQzjmknR4rSLPfhZrlq42XkX6ZT9fJqwpeP8++GLu5bpmrZy87jJN26tQDa1LRE9I6Di0SOcQuqQTakluCEp9xlGE26EVF/6A43ZZUUgcKGTFNV3Ss6v338yMiM0wwr08BF6ImQH4LQnnqfBTPVR3QNqLYpvguKegPfGO0HCpCDO1HRu9gI7T9SMKVjWCPY8+cLdAnkBTr2OmRf//82j4Dwf0VcstPuaUMbDOg6toWpwsCTghzNEuV7lRI5gyCs/cW9gEJA/o2TXroXZD5BYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkCgt///3KK9u//j5I96iW6GDlF1A7Px1fmp22noMA8=;
 b=Fvfg9frohrveu/4qzL6x6npqVEnHrT6wPbwQbW+55Wzof2bSt5nGPU2idG7leabuZke3l9czqxQor3PClrnpMmaAiRsa9QZIMYKEU0q8JUYsyQ5wptI0IHgJ+TOo/dxy99xosEHIo0hekpNebNobX5sbJKy502FqwTrgmpa785feaoXg2uipxqK7idRGc3v6L0cyfHJ56lsLn1tI/ad3nldo3z4YucPl8iJm6zO34QqaA34qEzUKGn0nQ/JwXZnnvdwY4nITIra4+FYWxV+o4Xf2MXoLmiyrKfZPJDeXnqJELG+qSnUy5ZXjc4GvF/3n/5IlqtT2Xxd5jiC4Dd7Edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkCgt///3KK9u//j5I96iW6GDlF1A7Px1fmp22noMA8=;
 b=g3QGBOyQxbIIVp/XEZpB6sOQpu55n2yfxkMAX39qtEf6Ws7tfGouJ3eSKsIykOiD7KzinSb3RaC/5ZFyp57ZTVp9UnH5Y2AdGiW4FJElddM7pIHchSOhmXtHihdQ/fBCxViubfwmJNM4OdylNcYZfMSNEz1n2n0WcTxr6yqrIGU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB16100.jpnprd01.prod.outlook.com (2603:1096:405:2a4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:19:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 16:19:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, "biju.das.au"
 <biju.das.au@gmail.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Geert Uytterhoeven
 <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 08/16] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Thread-Topic: [PATCH v2 08/16] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Thread-Index: AQHdH1mPlQFQ+O88qEu9qREAEUHvxraPlhSAgAACKgA=
Date: Wed, 5 Aug 2026 16:19:43 +0000
Message-ID: <TY3PR01MB11346D8B084EBC344C1B4663C86D32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-9-biju.das.jz@bp.renesas.com>
 <anNOxTRIUKtjyKKs@tom-desktop>
In-Reply-To: <anNOxTRIUKtjyKKs@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB16100:EE_
x-ms-office365-filtering-correlation-id: e9d26af5-e633-4fd9-6616-08def30d5c32
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|10067099003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: uLdDEmC+LWAiJvIhxJx/XC1frYCk1mXzLmuLV5J6XT3K+xmubTZ7fFeQYB01XBsCbJCOGAi7PQUVEPLEM8vLNIHZXm8dNqDFUwrm8S/NW04glN35S9OL2UlTbpEmanERZNkcORdwSrX99/IcrNbz5VsvK2Abj1P+eawpWgK7hH3Z2KWxSiGdBUq3UgVHMh3RDR0fFwrKQFg7JSAKly+2z2Yng2gh2UB/ihjEsh1Ms99m+scQ2huqkq6bDbqzvVypw6ztTxSaHQE8x/dReKodlHe90Vmt1O1joTQ3o466GGnNBevkbdlMh3Fk+3/l0ahviDbsA0kpRj0SXpjBYPBQ/l2u83BcLVZrd4UUVJkJR4FX5PjMQjvrLzTBiRct42FUUr5KThG9oPNmK34VB8qVsNE+9c/96HkyMFrgNseLHA6/vXW/ob6skekerYzjfm1xWNsTi2Z3FAm3cwF99ckT0zI6xbaQzOSp9Dc0xdyCGwejPwKNThDsR+7fb+UyQthn4AG4/jKGWxstuFYPfoIsC23NzbaosaxCAXoj58SAOUPS2vwSAyDZcZULYhUn3dVxWlZ+9CBfb4QgxEvcEg9tydSluLaPgv92UCzuqKzCE8fV/oaa7IXD9IaehbtgQ/Mb4RmoVAwR8XzsjD3P5SQhxGro4ppjRZw//A2xmOOBe21KuYXYHubvd7SG1ucAWtbM9bY/2ddh+y7h2H7U0bIt0unFGrBVSkoo+baf9m0QeU0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TKYfE9ZKbubNf1IclUfQ1iAHnXYesLzhBGwSfM4/F+yb/e1IXu410GN8p1Mt?=
 =?us-ascii?Q?PccdTVwTvyXbiH+EjONlGPNZ1lNXlB1Cb4fJsWvVXPEk/rqybGKigJ3XGvZ7?=
 =?us-ascii?Q?Gofz1UV/T4wGvbR8YajqTNcrQAuPdLlaApeOvFDDlK6J8lJCJOGg3z+9NaCa?=
 =?us-ascii?Q?U/M0UXToWMNBqbMZ+GrBbOJ8AtUAVfCNtvj64XDCSgKosEGzztp2k/XCUICo?=
 =?us-ascii?Q?Hg6a0+rTOGNy8PeV5ziqrUzpDDlj6PX6IhkWTwJDiHxdb6ajtOKGVlAJZWvs?=
 =?us-ascii?Q?RX/7rBWQ/77rCCQCnvqbK2A4DNyfu7tRyUTlsi06+Av+/FZJfTsVLoHbqn4Y?=
 =?us-ascii?Q?A0ieBoflTtMCx3dndlC3JmqFmPE/I9olBYOSBvVMAB3ifDgINx3Z2t0RKYHr?=
 =?us-ascii?Q?MSmPVfUHhD+nXT1rATuKcImiRvKZjHNvOmXqj+Z6SoOtF+DGYWw6YiwAcY2K?=
 =?us-ascii?Q?mALMNpK10Ksf0MC+JUz83ZV1o2/AarjVSTs+HDSZh5+UCzLsLeTjxmefjFGX?=
 =?us-ascii?Q?4YNqTNC+NaAnAZL+B7y++QxVG4H50082OLyZa67PM7hh6ZyAhHRYrkh3doCP?=
 =?us-ascii?Q?aMln+X1szLbmtl0a7efVia6p6E0jNu9K4sqhcWvLiBcNhuhTm7BsGbGmRbd/?=
 =?us-ascii?Q?de2LgV4wDzBStBeEZPq8blYhcP7p50EeTM+94owYP3R5Z1xiCdHPEyTli+vq?=
 =?us-ascii?Q?M3MWRbRKOCutA7epCp0sDyscR+V05x+bxBW6ZZlXPRRtkie8e+qjBbtpA3K6?=
 =?us-ascii?Q?u3qemLEFhM7ZyKCP6tw0K/lVySpTzYdVz57PI0VAHh0V/lvo++1Jd1HRfqFf?=
 =?us-ascii?Q?VSuHw/jpTi8ZHu7aPbJWgp6THlbIidZ8A+p/Z8dH+ZvcN9dP10B6bfVfqNRn?=
 =?us-ascii?Q?gC1A2zKm58S2E4ksTppAjXs9IhqGppDBmMe+FxPLHdHEp+DiGJpBUeszP70p?=
 =?us-ascii?Q?aO2nQEiIlUDjQoLNzkIqikil7LHwMQdQABN4fqsHxXjLZnzUqWYT04CfEo7M?=
 =?us-ascii?Q?AvVv9VG3YJ19Chsp0xoNcu0Yqs9VjMckvtgUQ3cpMfsMIg6nqBHZTu3LJrqY?=
 =?us-ascii?Q?uA3PxICO6XInTfv1fya+fjNv9QFbQ2noVq1iJ4B02NWl/FtNDUa9DKuGqLRS?=
 =?us-ascii?Q?Sd/ScpPIr9YfaxoeY43gpd5lJSeXmeGp5oQsp4U7SBBGNcHsN+TwKNRedKq5?=
 =?us-ascii?Q?wqvOkK424Bdoi4G8r0zomuUNartIAxFYdAZM9fOI9b+XxNto1krEw64ZwhHG?=
 =?us-ascii?Q?RQu9XdN8uzJ/i/ivBzXrykbo2xWf3n/pTfJL0iJKtxqWU2ltW/hw+6j/fPHY?=
 =?us-ascii?Q?6vas8H7SqDppEmeCkI0unSr7QNoXa3cKOtVXGfo+ChbmTfANd9663RLvBdiu?=
 =?us-ascii?Q?UFiFuyCFPzZwLaJrHC/2zFgBxKqb5s8uhk7RSxrUu/3ouuM1PS/h30/OFDi6?=
 =?us-ascii?Q?hkOy1ZhAgglVBnZvlmSUsL5zIeHrGAGmvmNuuEPyU6sCPvmpaG1/dANzmfqC?=
 =?us-ascii?Q?SPYd6oZowfTwMYKYcFMRcbUaiiiV+ECQ/huPgQyrnZnBsL0Recn28VGGbwfW?=
 =?us-ascii?Q?g30jNEaZroNVpZfKKldmn0Se9u4RADL13S7t10uJXKQ9qMAsTalH73Vl0Pzh?=
 =?us-ascii?Q?FJaRclpJtKKJHXSv77T56TuoeXJPdMA1payAtjoPBJBsCe8KpxDtxYAuYg7+?=
 =?us-ascii?Q?Ygp/UORoYk3vsCQj9ywCph3uCAW+aXjBCLEVtHym/5tEMHDGkof441zsn7V8?=
 =?us-ascii?Q?8xiDqWdmDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d26af5-e633-4fd9-6616-08def30d5c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 16:19:44.0084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcsyQFYwuOsPQXzwliqag4XH+aRz4vQU21d0fZyMm+jRPwCh137kiyvIeDBYsIZUhvjjGCrP0TvIKFTLzANafkbd3pgnJvfsJWnFYfsUdd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16100
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

Hi Tommaso Merci,

Thanks for the feedback.

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 05 August 2026 15:55
> Subject: Re: [PATCH v2 08/16] drm: renesas: rz-du: Add RZ/G3L (R9A08G046)=
 DU support
>=20
> Hi Biju,
> Thanks for your patch.
>=20
> On Wed, Jul 29, 2026 at 01:55:00PM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Add Display Unit support for the Renesas RZ/G3L SoC (R9A08G046). It is
> > similar to the one found on RZ/G2L, but has LVDS support.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * Dropped the macro RZG2L_DU_FEATURE_SMUX2_DSI_CLK and RZG2L_DU_MAX_LV=
DS.
> >  * Dropped the variable rcdu from struct rzg2l_du_encoder.
> >  * Dropped the variable lvds from struct rzg2l_du_device.
> > ---
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 22
> > +++++++++++++++++++-  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |
> > 1 +
> >  2 files changed, 22 insertions(+), 1 deletion(-)
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
>=20
> rzg2l_du_r9a08g046_info declares RZG2L_DU_OUTPUT_DPAD0 route but we are n=
ot specifying
> mode_clock_min/mode_clock_max so
> rzg2l_du_encoder_mode_valid() returns MODE_CLOCK_HIGH for every mode on t=
he
> RZG2L_DU_OUTPUT_DPAD0 output.
>=20
> Please correct me if I'm wrong.

I just added the definitions based on the ports mentioned in the bindings.

I haven't tested DPI mode, that is the reason for not adding mode_clock_min=
/mode_clock_max here.

Cheers,
Biju


