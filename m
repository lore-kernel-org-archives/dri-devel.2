Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6095BFED9E3
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE36910E221;
	Tue, 17 Mar 2026 15:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KMrmTfcj";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010039.outbound.protection.outlook.com [52.101.228.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F8E10E221
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgayVYcxWggl3LK99UuEqv0djqPmsPrNfz+KXZUKUikZo5jMJRy//Tv8MgEmnNfnv31wliJQ8SvSwft9zvKTZm7S2NW2jXmK97GnqG2G1r7E6WK98fhx6e7men2enkEpZDOQFmFi2CSD2u7YYaiL47Z0TZ6bFRiTXWlqpiA7xNIEJHpWuyFiVzkO4rZy7vPS/7xdExmfrquB64JDYOdzFyglbMn6Vn/t0n+Rsr5NW63JvsJYNaiXDw29+WY8Kc+Ig/NVJLyXPHH/8x2cRBMKGrHKLIII8eWsWgzZdEP0uZoU0ieOSEZPAoIXHLpK3ltm5eR517WSjn1Yp9QzMwH33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oMDoTZ85S0xZFvWf4KuoQU0Zceq62L65srmrNvBdnc=;
 b=uINbi8FPWnfcj8z4ylIrHuDzwlXVr08JuQWcKuCr272srkpqTmIsmW88G0x8r9kHx4U4rgFp+Bvm0dSMlqGwpo4l3oaA5SGj/IXb0X7WMLBXNtZOX3gGxjit7YUhPY5tI5V+4FNoiOyY4XYMw4pkqb0xkiMeOWcob50lcRqqtBkxxE5YcjhbKAlZoKvQVAZqAIQBT62h15aHCqLkiUPceX729G7YTsUjL8O2IR57RtHOUs29TgQx1FRW7yCC3tXRfjc8UkmzWh8Ah8GAVZJYbZmykzK0lWZYNlhYee/1Ux1Tmd3ilcf262T+XTty1zyG5SVFYnbhdHL31mD0v+QlmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oMDoTZ85S0xZFvWf4KuoQU0Zceq62L65srmrNvBdnc=;
 b=KMrmTfcjBF9teBfXhXLJLhhxnWNRdztBLxcb1SAoxd38LPiqLNVRHBSXlSAS00k6fjlqHSzGBhG60iU7fOgqA0AOGWoOfqiFjGlLCrIiZbWpeMeXyptha15XGcS99J5ZCh4ISIUTPkfcGO2R2SNtBJSoytRCHSgVmnshr86jeXo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB14025.jpnprd01.prod.outlook.com (2603:1096:604:364::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 15:15:14 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 15:15:19 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Hugo Villeneuve <hugo@hugovil.com>, biju.das.au <biju.das.au@gmail.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Chris Brandt
 <Chris.Brandt@renesas.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 1/2] drm: renesas: rzg2l_mipi_dsi: Use fsleep() for 1ms
 delay in D-PHY init
Thread-Topic: [PATCH 1/2] drm: renesas: rzg2l_mipi_dsi: Use fsleep() for 1ms
 delay in D-PHY init
Thread-Index: AQHctgqoRUPN3p2KdE6QwNezekwI17Wy0f2AgAADXpA=
Date: Tue, 17 Mar 2026 15:15:19 +0000
Message-ID: <TY3PR01MB11346ADD2951C7D92ABAB4F9A8641A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260317123610.329630-1-biju.das.jz@bp.renesas.com>
 <20260317123610.329630-2-biju.das.jz@bp.renesas.com>
 <20260317110213.74bbbd19cc81d0918a627fe7@hugovil.com>
In-Reply-To: <20260317110213.74bbbd19cc81d0918a627fe7@hugovil.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB14025:EE_
x-ms-office365-filtering-correlation-id: 35350bc6-340b-4a69-2687-08de8438007e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: QXPRAYIcwFBpTv9dEd8FgrHDlqXO9rAcKMlAuFfWJdXnZ9092HGchiJJHL+GieYAfCBno48oldVwkWs+LzvdXE25hlcmcI4TGwEHx4MuPs73pXHMD+LHfdDjw+VCi6Hg1/moDBBprGBvdX/Fc2mONd1xRm9ZSNTSU3bZWw0IPBiXVpr+2/g0d3dTmM2ZE73Q/1aJAhMgsYnDTKdbDOXVWjQO0GK5nvO9qk8WXteUqOek2POX3xDOaLVdtTemcRMxFOKHz40KD9v1PLqmySpNKQf3H9EMBoRfpvfjMbunlqwDL7gR7n4kCJRh6ad5PrLi/ZGNMR+f5YLFu5LiGDZsxSDkGZxOs2dOn86r3+yntddH66c1Xx0ilhwwmtHw/0xJ7ImYgkUwAov/86bvNqMHWYiARHwfWiqGthrG4fjVwM5ZaH1pYCwOunSYV+GCtb804JylPTOhn0vK2Okev3QXGB+VsJ7uy97Sq0V/D5PqYJATDfGe+6V6MxzfWA4PKKog4qSoedqOrkyTzD85HePJ6xglg/TkmG7Ymv0n8eI53Nhd19Ek4lw0ur0APbkI5hh2Ix64ONmnEfI+aFrnhuUsBEXwnAnsAxbqc8sSanMTrDdVMjCr7dum00/w33V/4+VcRySRqCqHj1bpPQZrg2SGgDKVwxwwTXchA3proirolwaoRw9Vc+Nfi18Xh0yvH9whWV2tR2q6a2iHpsLCGnJYgmpZHe4JuXFOHm3MjfmJiGKWea5pTsnTQ5kbsONqEIXl2IB/hew4zIlYDRURbb9GROuTIn793vEnpW8FGs/IFCg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nlhaNc1D7P/HBluzvk0UbD5CN/x6bsXwhoL2dXkvouReouWAg1mmbjvllG4u?=
 =?us-ascii?Q?+LE6CQWSlhAmd14lb0DOg/zguDWmj6M6xGhKV0blkhklN68/EhCwyC6zZL+7?=
 =?us-ascii?Q?Fhg1O+Zh3X9OwQoyjBhVKSj+XqDwzT33G5p24NYAkn2O8DfnuMe1wGJilHTp?=
 =?us-ascii?Q?Qm5DQoQ+w0A/CwPEeQ7LexZZPpu7w0Hi5TvC2QA1c+VCp8m1LP2sQqp0MUmy?=
 =?us-ascii?Q?RvFFXKAF6nvGxWtsgwpio2kh/7lZ0p+FxEfc3lcZ8ly2OBcbZZjiY96QahTL?=
 =?us-ascii?Q?DYEDUZroCa8r7JHac217kXWE28Y/zKz64TIZem7eLpaaWO2zITx+G6Lo+M+5?=
 =?us-ascii?Q?AbFntG4UWzNUMD7gmujO6tWycGtw6f1+fEffvvaB9q0x9f66JPH94Omc0tMO?=
 =?us-ascii?Q?cmD/9r9f/tNawlwQ3ZtogmldlAON4Ac8Xn/9h85gqR9MXUJavF9iKLzCQAyK?=
 =?us-ascii?Q?GcewCZsfd+8MIX5vfLn8nZ7BQ3XXWhs5pz2xxDuP88w613shuoZH0iZ1MhuS?=
 =?us-ascii?Q?YvThAvEEajxzeITz0+m5GuUqjqJfjAfrMkY7+yGFGGWVA7SCymct2cQn3yuD?=
 =?us-ascii?Q?opw8Hz9TpoHUNTmIrZnldm9Qedo1y7CvAWcPPrWmTiJyjB4nyecn1IN7siSW?=
 =?us-ascii?Q?52eL9TzlOD9DJgNZ93pn+gP4DNZg0d2NOgKBdFLNkUWrhkDuv0F3auyVey2i?=
 =?us-ascii?Q?116+wpLXBqbiZDBT2OPUolbKGko+u8NeuJNyYu80uY1GXWG8OMDKDQJRPH5T?=
 =?us-ascii?Q?uhlJqrx+gOkoahDCnXirpJiwSe9hTHGS40JGotTiV9HvwaeR90pcBPUmYesi?=
 =?us-ascii?Q?m4rQKpuggzEZjValj8Fi4Ux+8vWFjxKzloVpDACKSJAJOxHg5+yGiM7BxRqo?=
 =?us-ascii?Q?EK7+zK6RT5YCBVb9eAtvj5mumGq86cJNELw4yW6ETH7dYCH0FmRCJV6cprkv?=
 =?us-ascii?Q?0wf/VFfz22a1X9EgGYhlJbv413P869AqSTBEuMRBUnZsiSB5gvClkKbksVFx?=
 =?us-ascii?Q?Y5lDJRxuHzjsFJvIrBFXLytypzyArrQgtmBAenTBnSIWL6vGNFIKh/m7y5Df?=
 =?us-ascii?Q?J7kG1ju1jNhiX8YJUBTGizsEhRnPPGbdJwoGkgU1sVxAKqv//tFpTjwOINj2?=
 =?us-ascii?Q?Fw7oPnDne/9oeaMtZl6J8gXhH95bpuQRsGPtTUTgYxxjw/8YESsheGZgEnM1?=
 =?us-ascii?Q?edXJjNeJ3OcqQFUpyxNpNz8V2kx09z+E/e86UEZrHJwDPFpOy4BAn9H4Nr25?=
 =?us-ascii?Q?xMgbuEW2LhR+33OzLmteriE45CQN6SbtES69L2JQ69InOWNmQgBkHi+tO/as?=
 =?us-ascii?Q?6OUsKcCAsDQDxeZLSHgRjgXprHIZYbLyvgX/VUIIZ2mDYWM68fC5pz9nca1g?=
 =?us-ascii?Q?J14Ir0DbBnU9fnIKEg+o1IY7cjM3TSz6kN9iTJU6h8CK8nmjb8BAObSE3VDs?=
 =?us-ascii?Q?glHIJTlZCoqTV5lZ9K4lVE08SDBAp6H4h3mUuqM2gdv6QvPjyvjUP+HPjEBn?=
 =?us-ascii?Q?U7gkKSJpnxOY45bWo28DHmDKreCyZ9ARCfPscAbqiD/HICQF2Pkh6e65HlML?=
 =?us-ascii?Q?M9kzxHtnlx6NUx/FniJTn8A+CDmHNpfX0DP9bMnB7rkzIUAZhsHM1dH+Ie9+?=
 =?us-ascii?Q?yDBPBqX1FmrgUULFTCQTfdQuKJ4WIr1dMH4SoAP3h3LHT3xd4hYiEHr63gP9?=
 =?us-ascii?Q?31Xzexm5gjimXUDYv6pzY4d1cn3aWL4LYVyJCQqrFqBACsFcNMkTQIynyJlQ?=
 =?us-ascii?Q?NU+B1w1eSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35350bc6-340b-4a69-2687-08de8438007e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 15:15:19.4226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MriKRg6PN1cj90ecnSwdBar4htHu4icDLy96jpElLw0SKGAtqc+lxBvz9WvtEhbJW/RjGI+7EAAOPCrLGXOMfyaxwdMW/brZVnpDEgF/JcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14025
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

Hi Hugo,

> -----Original Message-----
> From: Hugo Villeneuve <hugo@hugovil.com>
> Sent: 17 March 2026 15:02
> Subject: Re: [PATCH 1/2] drm: renesas: rzg2l_mipi_dsi: Use fsleep() for 1=
ms delay in D-PHY init
>=20
> Hi Biju,
>=20
> On Tue, 17 Mar 2026 12:36:00 +0000
> Biju <biju.das.au@gmail.com> wrote:
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Replace udelay(1) with fsleep(1000) in rzg2l_mipi_dsi_dphy_init() to
> > follow the power-on sequence described in Figure 34.5 of section
> > "34.4.2.1 Reset" of the RZ/G2L hardware manual Rev.1.50 May 2025.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Seems to me like this should be backported to stable branches (missing Fi=
xes / Cc: stable tags)?

Agreed, will add fixes/stable tags.

Cheers,
Biju

>=20
>=20
> > ---
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > index a87a301326c7..e53b48e4de56 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > @@ -528,7 +528,7 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mi=
pi_dsi *dsi,
> >  	if (ret < 0)
> >  		return ret;
> >
> > -	udelay(1);
> > +	fsleep(1000);
> >
> >  	return 0;
> >  }
> > --
> > 2.43.0
> >
> >
>=20
>=20
> --
> Hugo Villeneuve <hugo@hugovil.com>
