Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131BCC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42DAA10E20E;
	Wed,  5 Aug 2026 16:31:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fQAdgoXV";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011059.outbound.protection.outlook.com [52.101.125.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F313410E20E
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3iu1xA9GGzgG8bKRp2BHhg7w0bQlY1FSzTvPDiJd+qoVuQJEPrRjP8gYFymmqR0mC7GuxtV55UreSI7hcdvjiOpnT566QmqN8na1Qw12N4DjvodV/7LhtiU+SgVNOZ4fv7xB+B+qcn8uaSvtF5bJZY07gFgWnSuQOKxQ2a4sptooy3wH696w4C7lA8QZoL59x9xCL9eulLA58+t4HC+6hiVH7tk6SrYvYGxR5dL06fBqlulh9l+0VhJWSU14QOu+hKeX1/xmLO23WTbj7bmtFRQgjNYLA2jdHjw6EL5U6kIYfEhR22pmHDlda4lF69V87kjTJxZPMRsS5jjyzbtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrFBRk3enj4Ks4ulj0tTV07zJssKMbngfAmUC5zbG4o=;
 b=halAAGPttckodorwN4Ov+ZWY7C76CYjp4RrdJEdQ1QUHI7vXRw/le8l7HYMY/48wGBxOsMfll1BQqC9RjKJowXmlSTB+Yajf9Bgzi8OSeaqOb3ZXPZgBHlt3qes87qMwmAbckXLuw7OSN8Ip76Dm3c1Drqb66uwEbi0tV4BYdjalUK3KK3Hg0IpDFdFefkRP0YohR2NegiWeLOX5owJbXn5ozp0YOR7T6pKSyJbl3H8pifMOtKAlczJ0KAUJlQlsClaK8ozdEeG0CDFWNFOxl3slcA/w9zJ1iEsqZNlY5XPwdwObhVFMUuPdKqAKf3PEOo1b9Owwfx8/q/bnkrIDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrFBRk3enj4Ks4ulj0tTV07zJssKMbngfAmUC5zbG4o=;
 b=fQAdgoXV7qwSF0fGtisRa0QObRTi8GuZUJXJYEaFxyv7ul1s7IEjBSpG6GIfexebaBr81upx2OVRLzmRGq7iVJRAmzRwh+YZG/FD3it1qrsRMUMS/SMugy7fub9JeCq9G5Q2K3U4eOH73TsoQWJD4Y0HI/rMZu0a7Mr3Ra8xU28=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12222.jpnprd01.prod.outlook.com (2603:1096:405:fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:31:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 16:31:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, "biju.das.au"
 <biju.das.au@gmail.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 04/16] drm: renesas: rzg2l_mipi_dsi: Move global
 timings into hardware info struct
Thread-Topic: [PATCH v2 04/16] drm: renesas: rzg2l_mipi_dsi: Move global
 timings into hardware info struct
Thread-Index: AQHdH1mLJKf0Z0NDr0GajVkKBalI+raPn7UAgAAQ2SA=
Date: Wed, 5 Aug 2026 16:31:28 +0000
Message-ID: <TY3PR01MB11346A058699BA02106191D9386D32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-5-biju.das.jz@bp.renesas.com>
 <anNW2IVJilS11XuE@tom-desktop>
In-Reply-To: <anNW2IVJilS11XuE@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12222:EE_
x-ms-office365-filtering-correlation-id: 5f204a8b-1ec1-41d5-7839-08def30f004e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: FEM3M40EZDdBY0uY23y/SNYy5Zg8+jXZHq0BN0awRu+1HiL1jvsd2H5Sto+qgvQvO5ryvAOgQo5xNBPonHSmKMHO980E4jsXkjAXwMxH42otcMWEhhaNHfdzmVbWtOLl3V77SY3w/2QiOOnXlEW9q53ZlYHQ+l0S3XYCRgmgddVCeE2QeCL5eBQxIbERhgYp7xzHOR8/Ox1L0diquvBNqLeHMcN11xdwjre3ygzCmO3ttnySnK6M4jt873KWTwdoYxOIcdOhmWks0X3hUCEpT3JEeOoH8Lghx3wYtpikNM/u4rQuGJwYqtyGoG8mQ6dB10UZ51FJwFxAYEXHUc+33A49qA/O8K/IHMgU3pZDjOLd03s8HEsuxFXri4+Z0hz3m1AELCXdiuHn5aX1UL486QNE23c60hNv+N/6nvmS7q8jcnEFqD8A5hxce6AvcQc1XZLHVyTmrFWMKV08lsBz8z+YS8aTV3jg6XXLe6AObAIhdv8Wd7/Q9/Ni5pZROsjR/aORCCDcb1xJhueB6jVL8BnBVkaNQXfJWbLo6v39HfBpD7sx/4bLaJUljZGQ5pfrYMyb+iIkr6Cy5KlzKK9VRGVJjodTx90g0AdvmleUhHN8jVhTcm43fIq/XeNJLWzVe4skOUwkAfVBntLIfCe6Qd16dm9qI7sv1LClJcWvojTWKHpejITvce8y3V9BIhCyA1yeF8toYkwYVN64e7t6oesCdstijqaQH0cO9/VHGAU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oxmo1nyYLTICBac3kHtvLtK+tIn0tVhxQM84Gat6p77BLUieccIZ9a/6Lp0T?=
 =?us-ascii?Q?0lgt8HnO6WhvjPyk9X5wKbG4JcNkGMoafSM7LZd0veVkR7ZnkRoId8UQBaLA?=
 =?us-ascii?Q?8xaug2diBrsKU75Trvlmzk6MrBifmOkfD8bEo71EUraApXwhPLvW2Ig3Gyn2?=
 =?us-ascii?Q?Dfzy2FU/j4NJIQeVADxiC9w/nVWFUelqyF38fNvxGWJdVQuAu70FPWVOLCIP?=
 =?us-ascii?Q?1hseYqZpNHjVgzxh53moaPhjlhjT0wJUcdZGbk+fPHnv6Jh54k1dKNZZjAB0?=
 =?us-ascii?Q?baeZfOkp1fJUGCp1Mro9JPvONJfh7opD6HEZ/d2zqaFPWyzbZN2e4kqEB7XA?=
 =?us-ascii?Q?cWR2G8KkXN8FCbP5zEiFGouNaOkzmJTqL0NG4GPGRjrxy1D7910kC/gXi49N?=
 =?us-ascii?Q?uNWEgdCUjjaZdYrCPL1vzhntKGY7zo7z4DyefA54rKTHGfc2PhzQpLLcr1ye?=
 =?us-ascii?Q?PXG2zmO2P1aBBDqgj/7CR2cFt5B9TLLsceZdeAgXJCTyvJ2U52xBe/1tnEr7?=
 =?us-ascii?Q?gz/kMbxDgO7mw0m61GCfTqQqPJbUai2mS0c4jqRRExkkJtYSG0SKuRikv7OU?=
 =?us-ascii?Q?4mpP9GCDvxHUFdOycmkPdHHGomOtWnopjQSydWK/ZE4MPFSMdGtDMdlomd/x?=
 =?us-ascii?Q?nG5bi+DvsrrWsShwJ0q8OAPRa0+5uPo1AWD4V7cIBCmUY2hF+Em1mw1Xlc2m?=
 =?us-ascii?Q?HSU4oHzTi+BoknvE/pWBghqlPUEhmdTn7jH4zcaJuGi5wSu5RhZMxbZ8gPRM?=
 =?us-ascii?Q?7mp6hhB+D69BvOQj50Eqr/lR0SYkPZwCWnwafhSn1/wUiO5VNr6aVTBz5Tk/?=
 =?us-ascii?Q?sfp7SiweiS7V39r1GM4EgHD76385IefKPsTEVTdR22CqrEvSgNEXp6+9Jggy?=
 =?us-ascii?Q?cSf1jcBGt4ZgP/XQtqWL9nuVOzkh0dR7jwRJsGM9UMfhjUBOe/LmL+hhGRJ4?=
 =?us-ascii?Q?nZ1B1chhVAvyPcNkGzseIHiPtIqbFxnQx+PzsSYGRapdlmAop8LUz9N3eoJB?=
 =?us-ascii?Q?fOBAMFe//zJEsY9SSwNbGtDQplxPvVkK1ddBPBF8InYaa3hqQ6aep+iAvifr?=
 =?us-ascii?Q?kjkVmDCmj8J6Aw+sSKYvedcs5Q+9NAHp3G0TOY5xaftIg9iBqmJs2zQj9aGR?=
 =?us-ascii?Q?i1cp+hBJVeLo9CcWS8N4AEF40ftnqqGPs6ceNxmnaYLzdV4hoZ9FbaCOXmC7?=
 =?us-ascii?Q?tmlP4WKBAhtwvwSqFJRhWk482gx/WXcqEm1Io4IwA/Mx2nTL/AOria+/w+tT?=
 =?us-ascii?Q?EQ0Frs9ktPUPUjDg/Ij3sWhNFqDbWZIA3w5UrEJSULgzedU7QwY8LbDFQEJt?=
 =?us-ascii?Q?b2X3i947AewrM6Zub0jGpIDz65L2lzu9tDspEEMLDcI8fKX6LkzGFOvMPd/9?=
 =?us-ascii?Q?/2VRg8nwXYi22RC57sLbrDtQsOkLN/V4I/opf//OXmDH+CMU7+UhsIlw/54w?=
 =?us-ascii?Q?4fZrm6sOUqQ5OHZpufr6UZYBCb3dEM+WCuf981q5l6ihx9J8fHX9oKIeGQZ1?=
 =?us-ascii?Q?WNZSXVmEdfPTVqdqPLZoNhENfkJGxKXKYmFATPJUOO2Hf6qmYbz83dyqjc4G?=
 =?us-ascii?Q?sfuFhEquq9ZPjf/7QeAKoBgiiaubdEoW4vkWSsxE05clowNDeLQj9TPkAW5l?=
 =?us-ascii?Q?klU559RCI/pALWWe5iokwwhVvLpxHO4KsoZ2No2tifT8dTWwq8+WnopAevu8?=
 =?us-ascii?Q?VBcnl/6vXKHsNZApwMH7t3lSM7QFJrzX4evxJfTZX9hg/rIyu8NKetRe6g6Z?=
 =?us-ascii?Q?cJnEC7vEng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f204a8b-1ec1-41d5-7839-08def30f004e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 16:31:28.8103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iD95ACqnMFKvdxD9eGs0RuaufGGPoML3CO8K3OiLVQOgy4fuOwUyN5lVtJRs70zMlv6sIpHST4zQum2lumJX/O1jdoXt6Q3s1RQmjYv34U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12222
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

Hi Tommaso Merciai,

Thanks for the feedback.

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 05 August 2026 16:29
> Subject: Re: [PATCH v2 04/16] drm: renesas: rzg2l_mipi_dsi: Move global t=
imings into hardware info struct
>=20
> Hi Biju,
> Thanks for your patch.
>=20
> On Wed, Jul 29, 2026 at 01:54:56PM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Move rzg2l_mipi_dsi_global_timings and its array size out of the
> > hardcoded ARRAY_SIZE reference in rzg2l_mipi_dsi_dphy_init() and into
> > the struct rzg2l_mipi_dsi_hw_info. This allows future hardware
> > variants to supply their own timing tables rather than sharing a
> > single global array, making the driver more extensible without code dup=
lication.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * No change.
> > ---
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > index 1538eeece2b5..180384c10264 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > @@ -54,6 +54,8 @@ struct rzg2l_mipi_dsi_hw_info {
> >  		const u8 *table;
> >  		const u8 table_size;
> >  	} cpg_plldsi;
> > +	const struct rzg2l_mipi_dsi_timings *dsi_global_timings;
> > +	unsigned int num_dsi_global_timings;
> >  	u32 phy_reg_offset;
> >  	u32 link_reg_offset;
> >  	u32 dphyctrl0_init_val;
> > @@ -488,8 +490,8 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mi=
pi_dsi *dsi,
> >  	u32 dphytim3;
> >
> >  	/* All DSI global operation timings are set with recommended setting =
*/
> > -	for (i =3D 0; i < ARRAY_SIZE(rzg2l_mipi_dsi_global_timings); ++i) {
> > -		dphy_timings =3D &rzg2l_mipi_dsi_global_timings[i];
> > +	for (i =3D 0; i < dsi->info->num_dsi_global_timings; ++i) {
> > +		dphy_timings =3D &dsi->info->dsi_global_timings[i];
> >  		if (hsfreq <=3D dphy_timings->hsfreq_max)
> >  			break;
> >  	}
> > @@ -1519,6 +1521,8 @@ static const struct rzg2l_mipi_dsi_hw_info rzv2h_=
mipi_dsi_info =3D {
> >  	.cpg_plldsi.limits =3D rzv2h_plldsi_limits,
> >  	.cpg_plldsi.table =3D rzv2h_cpg_div_table,
> >  	.cpg_plldsi.table_size =3D ARRAY_SIZE(rzv2h_cpg_div_table),
>=20
> > +	.dsi_global_timings =3D rzg2l_mipi_dsi_global_timings,
> > +	.num_dsi_global_timings =3D ARRAY_SIZE(rzg2l_mipi_dsi_global_timings)=
,
>=20
> Are we sure that rzv2h use these new entries:

Good catch. Will remove these entries for RZ/V2H as it uses different phy_i=
nit that uses
It's own parameter.

Cheers,
Biju
