Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52E606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=b12LFXfu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE34C10E569;
	Mon, 23 Nov 2026 16:59:45 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011046.outbound.protection.outlook.com [40.107.74.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D54310E569
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruaYx0uZw90yoEioqGgCh+XshihusHh5jJ6m9TzHft6/OD+6vc9+y0qpL2MVha7eD0VtuDrMcw6EOVPPibdR/XxGRfU1fWYD/MAq5TtO6yMJn8cN02empng62ycn/xLc+BOQaF9RzvXF9rIbkGh3dREsu0qhWKz1vYI3jRKi22zZH8Owm0OF21kpgqxLAI+w94hDl3fKbJPSY9taLtwAhpornL6/pzWCjP+QreKY+Z+3AC0r9ZCGEaqs4UXqM1u2gDfPxqrgw49WH2kMKZ0nOe1dYnzRvljE+/eXJuKjCHe5CMh5sw9ZbAqMtWtNxIUqqwvbiM7SNnyZPXIaYulnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPklTW9BYDvult6I4iOXJLiL7Tir/wknVHxA2gA9Y2E=;
 b=M6NpzL44xIBlPUYzbRoGfjGtz4m8s1COITiwjyysYxFePTULgvjNvsWr/jaNRGOqDRe+3/N8EgkpOuTpMn8igwA9zJ3s3Dx8ACl6Wtr2zBhH5VPQ/ROZoRx4/nMSEvHvXwNu8Utcl3JFtwL0tmJs/24Elo8KWDIQbb715kqmGwatS0OMdgrQw/oPpbs4K8j9IQBQeaYBlOd6ulsCpuIz2qFMGHxd4aTq8AH1eQe0r5y3zUT2ffjawbi019Iqfw8YIksZI1iW6td/UCjic1ezTxCaT2tJv9LnNI7a4I+m/2eixboT0/UeFU3PLCxC1LwiRDvBLgsH3wHNUyF8Wnc1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPklTW9BYDvult6I4iOXJLiL7Tir/wknVHxA2gA9Y2E=;
 b=b12LFXfuT2DIvibTU5ci5P24KEh4ltU+ET0za/JJ6PvYXfRPRmVbBg09CEX+TZHo2658Vqo1bskOvQMHSX7Eptc60lpAc0fiseYRz9ZKJOQAihb+2mJV6zhOBGIUODYWWgXyx61Dj6z6bnUHx3Ye9FsrrnASDOjKDV4zC2oDz1s=
Received: from OS3PR01MB6596.jpnprd01.prod.outlook.com (2603:1096:604:10a::8)
 by OS7PR01MB18228.jpnprd01.prod.outlook.com (2603:1096:604:4c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:59:35 +0000
Received: from OS3PR01MB6596.jpnprd01.prod.outlook.com
 ([fe80::58ce:825e:c38b:ec98]) by OS3PR01MB6596.jpnprd01.prod.outlook.com
 ([fe80::58ce:825e:c38b:ec98%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:59:32 +0000
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
Subject: RE: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance
 from the DRM device
Thread-Topic: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance
 from the DRM device
Thread-Index: AQHdc2mHvfvfxGybKU23d8MzJCmRZbc78H6g
Date: Mon, 23 Nov 2026 16:59:32 +0000
Message-ID: <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6596:EE_|OS7PR01MB18228:EE_
x-ms-office365-filtering-correlation-id: c0005640-a679-4092-69ff-08df49832546
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|10067099003|261009223027099003|4143699003|56012099006|11063799006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info: YBZZun9XKtrBeFgOWxW9A6NjOh8qhj/FCdnSbzaTqAdNcdkFJ3egjoIkQTVtSjVkUZqu7Ea2oohjvh5dOUZ1CCXawcmmkYCr0K8rSdg1sx3G1QOwe6jbLZqxOUVvaktEky/y7LVt7rGUGfwATZKAOvR1XJVrReTXH2TQdoW0pRpi8m0oAZOETZ8EISnXdjegmaUlFnIoyHM8XM5BxYoP9aZRPjheSUqrQ8c519i29nFiiOrOTO9bMxINk2/rFC4E7sq4FoL/fcCIN0SAvRS2s3ulco5q6sH4fblCXyrtiWUWVvaPhsVsI2hth9dw60Yu17uuvXgOZgYlvavHObWlRi0AufBNFXPszGvhn0NZSGkxUisQgMgW3DeQpS5o2DBHRkTSfFSb0JNr9KT2O27nNbYmnMM0+Zqdxr6RP2+rcgCsqRzIu7vzcrf1SFOwky8K3n7SketnnGMJb08HufKCFAjJUmev050GWaPong2MGT1ac/idHrSMKQx5wM8q/bvxq2wtEBKrmqW9k9mnSe08slmbpMYKUAAYqsA3aUyq3PQiuDcUbpQ6JqJT8isDe9oOtdqKxD/ENC7hwIiMde2BzeDIPIobxHTQmrTIvpGxmXgEDcM/DYIBBKHhRqFjZzUCaPiHzxd3Ak2T26vJGYCfBr1buWVKdDgRoUN1INKN2jme9bhtlcXvEZLNIg//mfGY6ud4elqupj4yTZk9tQB9ZdtCFfdr++fTQ3EAh/irmIU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6596.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?THJbhj0W1Rq5aFmmHgnOMTd0yqJ4PDEpnzl7nxboslLf68HlYtQhNW0IP/vm?=
 =?us-ascii?Q?hardbq7AD56QhJAa8gQqbGE+YXFoGqOkRctsE/oLM6bGT79NHNnCd6C7Cu5e?=
 =?us-ascii?Q?Onro1yUO+obIbsXGSLPPrujfsfcJk7smdXoo9ex6iJHkv4prwIzpzP/8SzO4?=
 =?us-ascii?Q?5Ic31wWjwbSvRFgvfc8F0mgzLRWCXdNiJ2+jfzAmvgf9ZFPBy8UeZNn71fXG?=
 =?us-ascii?Q?zOAFzZtinPXT64/VJ75FLsYxI08W6xqDo+UYsQvrGDeGXmU8HT7FjxVA36eN?=
 =?us-ascii?Q?Bv8ri9eOmndhEWbFCzm95/u9nk9MOMhuHLwahRX18IsIsCv5ai7GB2hgnTB2?=
 =?us-ascii?Q?BoZawofdCM4pddFl+tAY9rGkSF1y+ddt5sh9rbnovRDPtXsiVIuOcfRSIAKs?=
 =?us-ascii?Q?kV7brID1NVqsdNQ3BxFtcpkdHtg+W8tJG9efR4KLLbiFr+vosjLqSpS1WC6b?=
 =?us-ascii?Q?QATBgh5v2i/NPFNntt8Trb+fM7y/gxIefhq9RDDs4X7E739Mlp6y0SSWHDv6?=
 =?us-ascii?Q?znwGLZ5Mvqj21Q37/HvQ7l+OOAY1SZ+whH2+1bO9M44J6pAs+N9nLcKxiQF2?=
 =?us-ascii?Q?mJUsHfVLp97gL21SblxGjqXagpJ46etfV3seaP7UuKdSt+mtOjFs173VEOLR?=
 =?us-ascii?Q?VAvU/hE7dTH7Qwck/xEq6YSTEme7SXcKhXlLQqjZOgmUivqlM5R1rukvL6IU?=
 =?us-ascii?Q?eZhB9/qKrs31if3PQHqgyEOothH0/6ZkUHzdrNCTXz4vwCNHLI8oaNAmZ0+6?=
 =?us-ascii?Q?pMg+o8eSU0M07rK/Itd3pUjB252uXY8zlD55507Gam+zCa1xwOnhEed/juWy?=
 =?us-ascii?Q?HUzkOHuv63e/1WHYBCHzFThGtN/aGJVqq9O6OGaoFfZCdXdMz0ERV3ggJ4Rc?=
 =?us-ascii?Q?7OIX2XwJmNq+ZXUV6SA7VzgZ7qLjPbzIXDEUyrXHvFwu6/Nlb2qu7Qol06SN?=
 =?us-ascii?Q?/cSmwLjOtDGlguDXjv0xYpZKkL11100Gf/jM0pI4WTB/29TwwrYCbFNP86D/?=
 =?us-ascii?Q?zggpqgt6JMKmhGNDXhXPlN09OdBTbxRq0xop2CHHJkBZg+wxnlGqormYGihC?=
 =?us-ascii?Q?X39Hbqum0z9BQxc/CFjOVnroBSco4mHGDpP/D8jHZko0zQl2vsWwmsNDj3fQ?=
 =?us-ascii?Q?SfxV+oIj32moa+zYtFoACIaMtZCqRarMbiFNLzCUl4pq6QQA+Qdwz2SBeSpP?=
 =?us-ascii?Q?jO/P4L87+jg/Ve9DMc2YPR0VHwJ2AisMpGwpRzsgPC0RdgRG9W9/OMccPk91?=
 =?us-ascii?Q?j8NyEAIlP26bHhZtfFJ1Z0iZdfK+nOxIt0uI8gLv6uKAhvcshK5EyKN5QMDE?=
 =?us-ascii?Q?99Zd9xkp9eaogXjSinj46IFT9dT+1qbfFiHpkzC6FoWHl5Z/QaHL5Iwh4hn3?=
 =?us-ascii?Q?lSSTVlEETNlQRFgUR6VBFBLNLSSMbHpNRKC5jUZyCOLgeYg4/vYFTAdje6Ho?=
 =?us-ascii?Q?V4yFh27Y5v8lpFPq1qDrveopiPtDG/AcaP1sSQNt/wCW/hDOExOGjMnbbpmK?=
 =?us-ascii?Q?qJ07tNApdjO+H8GswqnAHSNITp7BjGnhYXrNSXwrIq7UGb4snG4RP/1iH14k?=
 =?us-ascii?Q?2ZtWilxKxIw/eOlt6y54mB4HJtTOl+Q1ZeKrUeOOgR9v1zXAbTs07D6HMJYQ?=
 =?us-ascii?Q?VfZfgcVdGQ42WLPc80XFBDTvD99502fg1aoAlh/zHzeMpWwiuZZwS79eedAT?=
 =?us-ascii?Q?6TaoWWOgSvhx1XTZ3yC96d2b84QxgbPVGVNdlsklMMs8RONT/ZKibgitDf7u?=
 =?us-ascii?Q?Cq/jUE3EIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6596.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0005640-a679-4092-69ff-08df49832546
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 16:59:32.4659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oVYAoRTvyQXc73GAWch2/P7i7qQYc0edxXJZkg3vQVaWusWmbxl4J00iam8XDbF41GAov9ASgLJ6E3DNqRkR6E/LFcQ6IZQc3D4+xp1DBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18228
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
> Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance =
from the DRM device
>=20
> On RZ/G3E two DU instances share a DRM device, which can only be created =
once both instances have been
> probed.
>=20
> Split the DU device structure: keep the match data and the registers in a=
 structure allocated with the
> platform device, and allocate the KMS objects with the DRM device in a ne=
w rzg2l_du_instance_init()
> helper, as they are released with it.
>=20
> No functional change intended.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v9->v10:
>  - New patch.
>=20
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61 ++++++++++++++------
>  1 file changed, 44 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_drv.c
> index d3cccbdf9012..d102876c07e1 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -162,6 +162,27 @@ static int rzg2l_du_pm_resume(struct device *dev)  s=
tatic
> DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
>  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
>=20
> +/*
> +-----------------------------------------------------------------------
> +------
> + * DU instance
> + */
> +
> +static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> +				  struct drm_device *ddev)
> +{
> +	struct rzg2l_du_device *rcdu;
> +
> +	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> +	if (!rcdu)
> +		return -ENOMEM;

Why there is duplicate allocation of rcdu? One in probe() and here

Cheers,
Biju

> +
> +	rcdu->dev =3D du->dev;
> +	rcdu->info =3D du->info;
> +	rcdu->mmio =3D du->mmio;
> +	rcdu->ddev =3D ddev;
> +
> +	return rzg2l_du_modeset_init_du(rcdu); }
> +
>  /* ---------------------------------------------------------------------=
--------
>   * Platform driver
>   */
> @@ -190,44 +211,48 @@ static void rzg2l_du_shutdown(struct platform_devic=
e *pdev)
>=20
>  static int rzg2l_du_probe(struct platform_device *pdev)  {
> +	const struct rzg2l_du_device_info *info;
>  	struct rzg2l_du_device *rcdu;
>  	struct rzg2l_du_drm *rzgdrm;
> +	void __iomem *mmio;
>  	int ret;
>=20
>  	if (drm_firmware_drivers_only())
>  		return -ENODEV;
>=20
> -	/* Allocate and initialize the RZ/G2L device structure. */
> -	rzgdrm =3D devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
> -				    struct rzg2l_du_drm, ddev);
> -	if (IS_ERR(rzgdrm))
> -		return PTR_ERR(rzgdrm);
> +	info =3D of_device_get_match_data(&pdev->dev);
> +
> +	/* I/O resources */
> +	mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio))
> +		return PTR_ERR(mmio);
> +
> +	ret =3D dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;
>=20
> -	rcdu =3D drmm_kzalloc(&rzgdrm->ddev, sizeof(*rcdu), GFP_KERNEL);
> +	/* Allocate and initialize the RZ/G2L device structure. */
> +	rcdu =3D devm_kzalloc(&pdev->dev, sizeof(*rcdu), GFP_KERNEL);
>  	if (!rcdu)
>  		return -ENOMEM;
>=20
>  	platform_set_drvdata(pdev, rcdu);
>=20
>  	rcdu->dev =3D &pdev->dev;
> -	rcdu->info =3D of_device_get_match_data(rcdu->dev);
> -	rcdu->ddev =3D &rzgdrm->ddev;
> -
> -	/* I/O resources */
> -	rcdu->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(rcdu->mmio))
> -		return PTR_ERR(rcdu->mmio);
> +	rcdu->info =3D info;
> +	rcdu->mmio =3D mmio;
>=20
> -	ret =3D dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		return ret;
> +	rzgdrm =3D devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
> +				    struct rzg2l_du_drm, ddev);
> +	if (IS_ERR(rzgdrm))
> +		return PTR_ERR(rzgdrm);
>=20
>  	/* DRM/KMS objects */
>  	ret =3D rzg2l_du_modeset_init_drm(&rzgdrm->ddev);
>  	if (ret < 0)
>  		goto error;
>=20
> -	ret =3D rzg2l_du_modeset_init_du(rcdu);
> +	ret =3D rzg2l_du_instance_init(rcdu, &rzgdrm->ddev);
>  	if (ret < 0)
>  		goto error;
>=20
> @@ -243,6 +268,8 @@ static int rzg2l_du_probe(struct platform_device *pde=
v)
>  	if (ret)
>  		goto error_fini;
>=20
> +	rcdu->ddev =3D &rzgdrm->ddev;
> +
>  	drm_info(&rzgdrm->ddev, "Device %s probed\n", dev_name(&pdev->dev));
>=20
>  	drm_client_setup(&rzgdrm->ddev, NULL);
> --
> 2.54.0

