Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330D6106FD98
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9492310E0CA;
	Fri, 13 Mar 2026 07:56:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="GmR6STl5";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010049.outbound.protection.outlook.com [52.101.229.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3067A10E0CA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjZyveNjVuz1JQEf6DSGLKdTYsI8Sjqw00ZvKevo8f7WvZtvEjVeHwTrACz1IZi04ak8phbJM6qowdv8D4XvfxAlmJWSthRjzIFYw66sQhp64EnTHRU0Ev0Hb6+yX0T0Ms4Gfkj5PZxByDP8uGl2mUZvwgStzp/G11WKXdOvqy/Au2WjWblp8yh/XG58UB8echQJTWpt2PRb/fVC1w26aPjRWLP08tc+A3pEmycn1E+0Ml7AOdpT8TpDorbYexyk6DjCZDmT3dqAT/jdm3qnSnnW8YykeN3P4N0Bo6svxHuda0ffg03O9Vm9XG8ynFPw3jaR0cDPNncnlpTBWp0OWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOXwTEUYnIn1CGs+iIey+83Gn6pLyx6WOgUDDxBsFBU=;
 b=sj1pZau5fOgF4nDKXYgsUSdW+iSLFA9CNFK9ipV7QQPWTMO7HIxBJESC/9BJ+mDHGkp8O462jOKfatQg0VYQK5qNT4ajfhg1mws30sC2Tb5gXWIMQZhnlK9xo4UhQtcrHEH1zVxYA9J8F+6DC56/O0v4lMcgnx4K7fIlqOZ90ok0TBe+J1zrFJl8CFr7JyknWC62zmHYcEfwotIp23k3+EvXWLxApMGMMd/9OsHwRrFoMRVwibwOH2MazlbApUJaTAlNa5bccMY+xZi/NZ3yjFyTaFXeKiqr3Vgy5VCT9+ot583M4oKYNj4HnoDf4gZ67B9f/fTQecLKbWo0Nr6lhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOXwTEUYnIn1CGs+iIey+83Gn6pLyx6WOgUDDxBsFBU=;
 b=GmR6STl5J28WNwGNssL1F/vNQQ9BqNb7cFAqaf8+wpS/5OL/Zbyq9vsDoV/4fKdrL3A08WBuqGx3M59KqTnGu/CveB0abVZ4qtVfGa4TN7K4g3AJKM8xZ907GW+E/Nb5kTe2QWHfJUiwWWOl6BO0kyK4fQmDdpXixOzEwawBVr8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10128.jpnprd01.prod.outlook.com (2603:1096:400:1e4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 07:55:58 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 07:55:54 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] drm: renesas: rz-du: mipi_dsi: Convert to FIELD_MODIFY()
Thread-Topic: [PATCH] drm: renesas: rz-du: mipi_dsi: Convert to FIELD_MODIFY()
Thread-Index: AQHcrIizZEg6kWXm70WOPq6jFSwKM7WsJBqA
Date: Fri, 13 Mar 2026 07:55:54 +0000
Message-ID: <TY3PR01MB11346901971FD325EF4EE3A528645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <da7709d50894d422442401e6e3ff4c4715a33fa5.1772705564.git.geert+renesas@glider.be>
In-Reply-To: <da7709d50894d422442401e6e3ff4c4715a33fa5.1772705564.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10128:EE_
x-ms-office365-filtering-correlation-id: c015b730-9325-4e57-b596-08de80d5f3fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: I/8lMzFLF3nLvibxjsFRCIh23V2IP+skl9RcyiJ/nKj0kpC/+F+cPGC95lTD1a2Ek0njmimbpk2ZQVWFMqa9dSOYO8V305n4JT+5SdVDGqeiKpPeGIe7lBXG7XHWmM0yx8brwDG5u72uarWg8PKplLOey5F2ht/XAZdi/VPGLiq0I4F1KKPGlNF1rEtoqcw6pC0iPsoaIAdpvgE6OQ2v5UdVpXaYlf9A9WJa6LB6jFHSis0qhvsvL59CchoAzIEOxm/d7LWsXqfjt8WA2G+VN4XdYGwl4cqBZDz1bLfMdmldOgP1dOn9rH6s9n1+Rl+gLcyjcaK9NVla583fJyMepT9O/MOoOxQ+Xte4t4K5dCLLNxqvHjaeWhTR0RNVyZvEqyxkdFCzzaroEBQ3Jqri827108UJc1102jXpxDI5PlS+OAOO3rLMRt/NaTcXCMFfLL+Q3IxqV87octV4/Kz1djX/y1IVjR6zceEPuLavBe74ydxWsN12UcJJJuzUptkI7ebBAhDoAKgYrtzI84enFGZCrVC+o/CqdfLo0x17aLG8CyW5uxgOTyCHH7Unk9uyQMJNhA7duFW8lPJNfGC/zVh8DZwC12fGIxPs/uXLsM2PvO60O8tAWk5O5M/gZ7a7YexKBg2t8Zp1jCqkjvcCzjI8jfXh3j/UcBYBhAr0sQAnYweqA96P9FpQ48vH82jOIBjE/D3MrI0pakB3M7s1RtR9ZCb9NecR3aplR5dnpyXFWgng3TWZlRoamqEqCJk5tDXm5lXCIEC3bIdBokRxDYWrpWBDLdJeShJl1vH2/qg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QEPZImm1ZTe35nmNS/DVT6X3yW3U32JyJ4Z6Ir/Ij3KLSNDc8DiYzFzaDYF0?=
 =?us-ascii?Q?ZP79EbbizRoPabCfRJuL4ycL7h5in2GJfY5sTL63Xqp3UDjoW5wjR3mYYdTg?=
 =?us-ascii?Q?AdLjgSCvcpQvyYUdojY+qhFEhc1r47/7b+/N5T6YGBio/ZeKlaRsUrKTQvhJ?=
 =?us-ascii?Q?EqZ568NdoaXMwRdy02GMEj2/4DE7GrdYqd2jA1JVKda1KBCHVhnx5HEr8cul?=
 =?us-ascii?Q?4zk9xdJXa9T4udWFl1khmEypT2nBqlR329WL4bX8YMEIJpj+ppDc9Y0u8cb1?=
 =?us-ascii?Q?gg7psQR0rcdXn0fxVoPDRv0q57lKHNN96TdtKd84TuthH/VI8JD1lRj1LGIi?=
 =?us-ascii?Q?eymIY67kE2KFYZqGliYH9mgY112GDEYdVQYiGh06hepPJBmZo86OUy6Fr2CZ?=
 =?us-ascii?Q?/0clDfc1AUajBv0lUUUopwECnFAVkI3ujRHrRogAwZyPu1zgoAfivgTB8vhL?=
 =?us-ascii?Q?ud3a2a76/xX1+DzXV7pgImmh7bsrvrUODZrfYlBWIrqPSwxo7X1tGq4OweZr?=
 =?us-ascii?Q?8ds70LRcPiBnRrc8A2rLhMJKvLUUXlOuYmmlvX+ZJzDO0HIX4g08pu+11SAz?=
 =?us-ascii?Q?+wXiSvmLOUDDCyg782d3SL3KWikmz2dQafXd/dQHHafVZKOq6Z+6MWJ3zUC0?=
 =?us-ascii?Q?36jqxpxhYzKrOCmbHZOYkAWqNfkRsWmM/0mog6nWNZveLe27fMC42Yg/Ofvk?=
 =?us-ascii?Q?O2R58D+hZWp8L+xJWBEI3zIy/09RnClupK7Cbpnej+6jgCXiwPSlBsA+pOeR?=
 =?us-ascii?Q?UUezWfRIsBPr5DOFY+C/Zt9gF21QpuE59yrSwBiQ2b7S9xjVVm458w/Q4iCW?=
 =?us-ascii?Q?atXi941FpniJub7+fCd8Fx8Cf6zDGt3dLpyTmEJeCjty2MMPpwONNetWwE9R?=
 =?us-ascii?Q?v1VIu97hDDfSGX2ZR7QezMdLwWTMJh1dLo7391+Z2CXt8wVGJiPNfovFy0aD?=
 =?us-ascii?Q?gdtovC8llgLoBoIb2dgQamWwV91JoacZcojAxf3pZYOBMpRGZ1Zr/UJpLs/B?=
 =?us-ascii?Q?ubriAOtqQ5BW2QDmU6SF4bhsUGCbmPigsa7dQuXWVI8gG1HcPvWdORDOYHfK?=
 =?us-ascii?Q?g3DjvC7v9IpTkKQ1CT5D6ifR+Bed+y0jtuJE3U9CholVOl7ynigXaouxrc7P?=
 =?us-ascii?Q?CmYBIIEzMk0EiXpuSNT9qvU3f+kZzLm9Eejhaq0U3xHupQGLTZyQkFCQ4x7/?=
 =?us-ascii?Q?g71ugCNIRKG572VxgjXPLlFYyT7uP6DeA2OX5cp6MPApV42gl6oYeHvF2ouj?=
 =?us-ascii?Q?b8I2I2MCFIkaRSEgjotU4OUTJsJesT1ceDcc1yKZoEXlPUkH38a6VJlantfm?=
 =?us-ascii?Q?OnKjPc8sCNJHonh2b7+APOPTB7XZ52pQbUhH79FqoYf/6x/1/eqqtC3GXmkW?=
 =?us-ascii?Q?jIVMVuUOKhHVxoXEDLZeRAFkuk7eL4FwDXwf05nmY4SKpMRSQIP3Uqlt2xsH?=
 =?us-ascii?Q?xFFjOrpu/RGtTw7WEsq2ED9LDz08Vzuynp8ltVCjqbdEANN1K19/x9Wbc+Bp?=
 =?us-ascii?Q?l+FJ7i4u9OGHVbDDbAPK7uWkRjC+ikjxO6jfTVUGlTM/HDf66fzCYpA6y+du?=
 =?us-ascii?Q?GUQfpPgjkCOOXoZFPivO9AysQCgeriCA5VrzEZqGmvG9JvS4y0uOjqUbC938?=
 =?us-ascii?Q?FIaLWbZWGYVD/eKbvIsOBNPA7ytAKV/5YMwpOt4OCJKJVnzm2O3zT0r76oyK?=
 =?us-ascii?Q?Bvbcw/OKMZgWT1TuKCePzbV9ipYEJMgaQyxe0f/BZbZyJAhPUzxEC3d3XZFn?=
 =?us-ascii?Q?tAuQGfjk8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c015b730-9325-4e57-b596-08de80d5f3fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 07:55:54.2816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENfaBJ3o15ccy+NXBOQgFTTHM92pn8eUnWQf88tt5CSD7GZ/iAd2MZ8WXpq9XWFB68Hm/YBDWCIbeIrLIUo6Z8Mf3M9vC2ySRmCFyX3YZPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10128
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

Hi,

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 05 March 2026 10:13
> Subject: [PATCH] drm: renesas: rz-du: mipi_dsi: Convert to FIELD_MODIFY()
>=20
> Use the FIELD_MODIFY() helper instead of open-coding the same operation.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied to drm-misc-next.

Cheers,
Biju

> ---
> No changes in generated code.
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu=
/drm/renesas/rz-
> du/rzg2l_mipi_dsi.c
> index 29f2b7d24fe59717..a87a301326c7aa43 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -808,8 +808,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_d=
si *dsi,
>  	 * commands payload not being saved to memory.
>  	 */
>  	dsisetr =3D rzg2l_mipi_dsi_link_read(dsi, DSISETR);
> -	dsisetr &=3D ~DSISETR_MRPSZ;
> -	dsisetr |=3D FIELD_PREP(DSISETR_MRPSZ, RZG2L_DCS_BUF_SIZE);
> +	FIELD_MODIFY(DSISETR_MRPSZ, &dsisetr, RZG2L_DCS_BUF_SIZE);
>  	rzg2l_mipi_dsi_link_write(dsi, DSISETR, dsisetr);
>=20
>  	return 0;
> --
> 2.43.0

