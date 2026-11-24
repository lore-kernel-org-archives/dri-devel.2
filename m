Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF56606A682
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=U8kHUrXP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4368F10EF6D;
	Tue, 24 Nov 2026 07:47:18 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010001.outbound.protection.outlook.com [52.101.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C9510EF6D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPaU10oUNR5Q7lsKA12mdJ29aBaBuCbdX470Q5pOAmwO5eY4Uza737wUuO+zdUhLiqwZt6CrjOE0b0Qp5wmY5m0oM1TzzwEnDs3VzCtU376pmIgKRjg6YrVo3papOvLbLFMn/oLmowOSKxiYSDU1L/dB3pgTBZP7k9PBYShAkyOsBVePz62cS11Chk2qteDzWR1v4+qllNRS54QKGpJtwTtRK2h/lRFh6+V5qMBvqKGtuof+8+qUhZmBxBEpRugi7UPQCnywFBYClcfNnSfpP2483lMEMWHi9MSUrVuPUZJiqpJWsS66QzV6l7gDw1TWdkzqN6dKPlXr9+ZWQNCERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAZ3EDfqmZOOsma7ABx7H48IzHkIlupUAYw1Xj/yGJw=;
 b=BtkCj+bHhftO5QcsHyym3/jmzk4O/JWEWkI5hfaZcmsKjRyClIgJL0R/h1xkCIGL8zdSS5jgxnz7EEQpUOFzBdSqBxMHikX1McO10St66M08K6ylj2HMTtqMbavDpla6nuz4LeV25VS8pdVNx0LUqisnmb7YEaA+WlHC4VVy2wczPqJlP88aCoyJnSwVqiRVfCeHZPPIyPA9pWec6VsRUYiO4cNhangxk1CVat8Fhf3a3yBSCl8wWB/JlKK0Cic6vqrc7B+khzHg7PgdLBXZ1s58tYuA610eDLbtC7VoCzq6Wy0aQqoNDkNZ+utDeKU2GsOiH5JwXN10ReP8lulc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAZ3EDfqmZOOsma7ABx7H48IzHkIlupUAYw1Xj/yGJw=;
 b=U8kHUrXPa79GE/j8kCEYlUyw9yyoRiDO6dmGmXam7ja2bCfE7iRd9SJUaY4aTw16Zi8n6To2OziWuDOotdP+8HMe7QdhmuOODNqG9mRYTlZEAEW85v6t3PTrY2OXGJjeDBN0+q2jtH+yjPJd9VbX2FnEFKcZqLEfP/8taXcA2bI=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYRPR01MB16252.jpnprd01.prod.outlook.com (2603:1096:405:2ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 07:47:07 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 07:47:04 +0000
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
Subject: RE: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Thread-Topic: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Thread-Index: AQHdc2mQXc9YOQBvg02jmZuHcmeGVrc781HA
Date: Tue, 24 Nov 2026 07:47:04 +0000
Message-ID: <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYRPR01MB16252:EE_
x-ms-office365-filtering-correlation-id: eddb2cec-9559-4692-ceab-08df49ff2205
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003|261102123227099003|261028144727099003|261009223027099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261026121527099003|38070700021|10067099003;
x-microsoft-antispam-message-info: eIh0ADDnvS1ibAZmR3GqoAEDOnTe2E+xW5BXYZHRXTq0VqNITDfIg1Q4Q8WQD3j1fa0eetVbjQJYL/IybiPr+LVfD+XdMVR+rU0G9cvtzq23gNeL635P0nmGpLPS4K6EXSIcuuqgySJal1PRH3JtqJ8oLNx9+1kLrJvDI7SfOaTQAzomYgzFVTWIik5SeY23idSj8KS5n5Zg6Y1PPTrsCoaKGMDimI2Vl28klFsQQyoMGwFF95mswuxhjBTAnZpG4LiPj62pn8hfhcwgTKvJlyWqQMdGf5nTSD8RVjkZw9n3H1ovMfOC6kLA3TKfhey8/6wkjRAPGAjYarcpTtmLp0c+8Ik5ikRoEkXAuCJKMSYf4GnuoQOvWYrbSGkG6vY0L9eluLsnJtJyYT4O9ypRLLG/Sd6F3YX3GGtMMDZkA+XvbEXfv7ObYnQgHOebFISGn5PRtOouUHDRNhFb/qO+aJuYNMVjtrHNlXQxyoMyaQflV/4WeQNxjMjAoahM4JJ0UgP3mQhfq1y21mtQ4LnaodQ2L0eyZ+PteiLJJLBHlPEBChUM27KycpoO7xS0GvIvTsPLjc2h0Cd6VwPxRUPb6bTiuiBT87TcSA7XeJK5E4QciAMqqII5jHjWl6hKRLs5h5cHYGzIPuT1PN/8w/+gl0UFUrQjKqYO6IQcybbg/EnAYbY7KFlqT2GUf+88T3vtsYwCeqkII43YdjgqzjrNE8LJRsGranonqINLFgcdsHU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003)(261102123227099003)(261028144727099003)(261009223027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026121527099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NSnriT/5lzwdixhxANuSKJ6z5Leu0QhrKQjyi+KfG/PYD3nin6VTgT/8Ie?=
 =?iso-8859-1?Q?LtKwepzRsee2AW3h7SA/iwQPrLLAcgt5YN/iwt1K7O+RjAjCAbTJJuroZv?=
 =?iso-8859-1?Q?TDTTNCZl7IvNnh286/9Q7nq1JoFrC22+eZ3s9iw5dL+XW1hUAU03iI0OmN?=
 =?iso-8859-1?Q?0dt2rvKcm7Re4tJOs0yUVpQpUycxp1lRJdNrzZOTy8eh8sG4qB/CE3unW0?=
 =?iso-8859-1?Q?Iz87s8u5IM1Z8JzYpzxNivKYImBCWlOu8IDULQkSDDS2R/ESyuzJcteBis?=
 =?iso-8859-1?Q?r4jAVThhRSkMJ6nM/xHHKH4ji+k/DzqZ/cSBVSLl1CES5LWS7+LUDGl366?=
 =?iso-8859-1?Q?RLXTTn6KAz6C6hFuXsVgE0qkjFbo4J1MyjTevGXslynC3Bply2edIlGlBC?=
 =?iso-8859-1?Q?+fhSWp68YK7shiGIHkVBhfJ4JMegLa/Oj+kgbkWrwwUqYwdUPJCQsTfPPA?=
 =?iso-8859-1?Q?SXKDlErza7QwqHfO9eEGF4N9PlvSJDfOGOqx1SzVVbbSwv+vlzrSNOESzd?=
 =?iso-8859-1?Q?CDcS8hvze7GibDu52ygrejP1V6szbloER+B6pqsT20iGTW5Y+2Mx8Y1XBZ?=
 =?iso-8859-1?Q?V9uqhuGgNHQVnb9mQSV3+tb+/vKUG9GeMB52pqqFaZSaiD9ScOYyvk2E/c?=
 =?iso-8859-1?Q?FJKW6Le8iLA+3bhdjggBBm1ShLCOcilKB82PzksX6iqyKWo6/867u4z1Pk?=
 =?iso-8859-1?Q?E18UPqctGQuEzdqkc36C+gujqUj3lniVJp+CDf6pIrzYt/x0cDBLGTo7Rv?=
 =?iso-8859-1?Q?vBSPsx5mN6z+0WENJ96hP+ahTSxVKmuS40QgCfThDQ5hBev2zJ3RNT7Tqc?=
 =?iso-8859-1?Q?6q4/hTSIN4HpuNM+UwaTuDL5H7HSK2VkW37Vc8hG1o1AMrG2eR6kasTIkv?=
 =?iso-8859-1?Q?aBdVxcvpYZx6iUr8EL4MHoI26xd0tr3sVvrAzfwG3J+ogvEnlHqsf1dKAq?=
 =?iso-8859-1?Q?FuCBjkZ+Ya5dfOsT7oXQIvu5O7sDFQWe9f7n6tpNDlelnTytJrJ5XHVYKv?=
 =?iso-8859-1?Q?AC3XhDgfqf1Xa7sARE3rc5BzerVEn5hZ41vxJfmzctvmJto2gIXt8iWOoM?=
 =?iso-8859-1?Q?MCYFeKWobbxUv8XDnoxd/b0rtkbiJL0XXrAa0eyXHZpyifssLAcl1LKYLy?=
 =?iso-8859-1?Q?2HnV6/Z3guKW1N0xjm3B+qRrDl+xhCtC/Mjua+9ROGbho6E5iTE6RmNE6n?=
 =?iso-8859-1?Q?UQ4/+prqx3EdCDHV7aEV2fT8hC8FgMhVFV1JHQsxY77MifQJLZo7LLBysA?=
 =?iso-8859-1?Q?JRZuPloC15BOFCxEH/BM2tBHWsaUOJCYHtRPHueBZ+hnG9PcK/J5uwkT2T?=
 =?iso-8859-1?Q?/z68h3cmpMDOnMaOfbef8OJc++50OxczlOa8n2eCXqvdxnyNPDhxtLdDOP?=
 =?iso-8859-1?Q?CxcgOx4wDeC+80SX6NcQDf4HsQS6oa2Jc2sbm5znGldeM0pGUY5KdWRZHD?=
 =?iso-8859-1?Q?9+0AmIJyYwmZyQvLVEdkPaOL0rJrkTQQWZsWKQ3SKkmWBBpB+DQhyO9I+g?=
 =?iso-8859-1?Q?aP2DJ4nu8eq4wzx8Ls2r9kixjSYICtXLU1sG4LBu6/Y3ZJqDAQLwl+V2Eq?=
 =?iso-8859-1?Q?JyDNQxptckZVF7kZjZjy6lYuMvFuqC+WovnnBg/n/K/fmYl2xxYnI9q+a6?=
 =?iso-8859-1?Q?KJk5lzRxf+8/iuNjP9IiQItV0ytJ7XD46rafwQ1NfZWNl3JB9OqmaO/3H1?=
 =?iso-8859-1?Q?1iWA8SP0pmn/4EuOVGMW6PhTvb3Aw3hKZnpD1KTNdRpjr/ac2kH+Se4lt9?=
 =?iso-8859-1?Q?IUt3tPDWJkgWGXrxlKjIXojb8zAXYWtDmLtr6GtpOkHZFMiS2/Q+pqwXr8?=
 =?iso-8859-1?Q?BDHHah5xvg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddb2cec-9559-4692-ceab-08df49ff2205
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 07:47:04.5967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dI7Zq+L2zsx5w1L58yNk0lSVpNflSwh7T0lEZl8EbidktGm5jKUqkMTuDKrYmLPXK1N1kkE1vwoy3cKv0qZlwS7uOQFz3qfn8EvP2JLWLG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16252
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
> Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU instan=
ces in one DRM device
>=20
> RZ/G3E has two DU instances that share a single DRM device.
>=20
> Add an RZG2L_DU_FEATURE_COMPONENT flag and use the component framework fo=
r it. The first available DU
> instance is the master and creates the DRM device, the other one binds to=
 it as a component.
>=20
> If only one DU instance is available, it creates the DRM device directly =
at probe time, as on SoCs
> without the flag.
>=20
> Set the index of each instance to the number of CRTCs already created.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v9->v10:
>  - New patch.
>=20
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 ++++++++++++++++++-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
>  2 files changed, 115 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_drv.c
> index 93d59e2cf8a4..873586f2ef28 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -7,6 +7,7 @@
>   * Based on rcar_du_drv.c
>   */
>=20
> +#include <linux/component.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -14,10 +15,12 @@
>=20
>  #include <drm/clients/drm_client_setup.h>  #include <drm/drm_atomic_help=
er.h>
> +#include <drm/drm_crtc.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_managed.h>
> +#include <drm/drm_of.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>=20
> @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct rzg2l_du_dev=
ice *du,
>  				  struct drm_device *ddev)
>  {
>  	struct rzg2l_du_device *rcdu;
> +	int ret;
>=20
>  	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
>  	if (!rcdu)
> @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct rzg2l_du_de=
vice *du,
>  	rcdu->mmio =3D du->mmio;
>  	rcdu->ddev =3D ddev;
>=20
> -	return rzg2l_du_modeset_init_du(rcdu);
> +	rcdu->index =3D ddev->mode_config.num_crtc;
> +
> +	ret =3D rzg2l_du_modeset_init_du(rcdu);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) !=3D rcdu->index))
> +		return -EINVAL;
> +
> +	return 0;
>  }
>=20
> +static int rzg2l_du_instance_bind(struct device *dev, struct device *mas=
ter,
> +				  void *data)
> +{
> +	return rzg2l_du_instance_init(dev_get_drvdata(dev), data); }
> +
> +static const struct component_ops rzg2l_du_instance_ops =3D {
> +	.bind =3D rzg2l_du_instance_bind,
> +};
> +
>  /* ---------------------------------------------------------------------=
--------
>   * DRM device
>   */
> @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
>  	struct drm_device ddev;
>  };
>=20
> -static int rzg2l_du_drm_init(struct device *dev)
> +static int rzg2l_du_drm_init(struct device *dev, bool has_components)
>  {
>  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev);
>  	struct rzg2l_du_drm *rzgdrm;
> @@ -213,6 +236,12 @@ static int rzg2l_du_drm_init(struct device *dev)
>  	if (ret < 0)
>  		goto error;
>=20
> +	if (has_components) {
> +		ret =3D component_bind_all(dev, ddev);
> +		if (ret < 0)
> +			goto error;
> +	}
> +
>  	ret =3D rzg2l_du_modeset_init_finish(ddev);
>  	if (ret < 0)
>  		goto error_fini;
> @@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct device *dev)
>=20
>  error_fini:
>  	drm_kms_helper_poll_fini(ddev);
> +	if (has_components)
> +		component_unbind_all(dev, ddev);
>  error:
>  	/*
>  	 * Don't use dev_err_probe(), as it would overwrite the probe deferral =
@@ -246,7 +277,7 @@
> static int rzg2l_du_drm_init(struct device *dev)
>  	return ret;
>  }
>=20
> -static void rzg2l_du_drm_fini(struct device *dev)
> +static void rzg2l_du_drm_fini(struct device *dev, bool has_components)
>  {
>  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev);
>  	struct drm_device *ddev =3D du->ddev;
> @@ -254,6 +285,83 @@ static void rzg2l_du_drm_fini(struct device *dev)
>  	drm_dev_unregister(ddev);
>  	drm_atomic_helper_shutdown(ddev);
>  	drm_kms_helper_poll_fini(ddev);
> +
> +	if (has_components)
> +		component_unbind_all(dev, ddev);
> +
> +	du->ddev =3D NULL;
> +}
> +
> +/*
> +-----------------------------------------------------------------------
> +------
> + * Component master
> + */
> +
> +static int rzg2l_du_master_bind(struct device *dev) {
> +	return rzg2l_du_drm_init(dev, true);
> +}
> +
> +static void rzg2l_du_master_unbind(struct device *dev) {
> +	rzg2l_du_drm_fini(dev, true);
> +}
> +
> +static const struct component_master_ops rzg2l_du_master_ops =3D {
> +	.bind =3D rzg2l_du_master_bind,
> +	.unbind =3D rzg2l_du_master_unbind,
> +};
> +
> +static int rzg2l_du_instance_probe(struct rzg2l_du_device *du) {
> +	struct component_match *match =3D NULL;
> +	const struct of_device_id *of_id;
> +	struct device *dev =3D du->dev;
> +
> +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> +		return rzg2l_du_drm_init(dev, false);
> +
> +	for_each_available_child_of_node_scoped(dev->of_node->parent, np) {
> +		of_id =3D of_match_node(dev->driver->of_match_table, np);
> +		if (!of_id || of_id->data !=3D du->info)
> +			continue;
> +
> +		/* The first available DU instance is the component master. */
> +		if (!du->is_master) {
> +			if (np !=3D dev->of_node)
> +				return component_add(dev, &rzg2l_du_instance_ops);
> +
> +			du->is_master =3D true;
> +			continue;
> +		}
> +
> +		drm_of_component_match_add(dev, &match, component_compare_of, np);


The master=A0is chosen purely by DT order. If the first available DU never =
probes,
the second never gets a DRM device. How do you handle this case?

Deferral from master_bind=A0also only works via the component_add/
component_master_add_with_match=A0return path,

Have you tested with a late-probing DSI or LVDS bridge?

Have you tested component bind/unbind/rebind of both master and slave?

Have you tested PM and shutdown on the second DU?                          =
                                                                           =
                         =20
     du->ddev=A0is only set on the master's platform data. The slave's PM s=
uspend/resume and=20
     shutdown therefore call the helpers with NULL

> +	}
> +
> +	if (IS_ERR(match))
> +		return PTR_ERR(match);

Why this error path cannot be inside loop?

Cheers,
Biju

> +
> +	if (!match)
> +		return rzg2l_du_drm_init(dev, false);
> +
> +	return component_master_add_with_match(dev, &rzg2l_du_master_ops,
> +match); }
> +
> +static void rzg2l_du_instance_remove(struct rzg2l_du_device *du) {
> +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT)) {
> +		rzg2l_du_drm_fini(du->dev, false);
> +		return;
> +	}
> +
> +	if (!du->is_master) {
> +		component_del(du->dev, &rzg2l_du_instance_ops);
> +		return;
> +	}
> +
> +	component_master_del(du->dev, &rzg2l_du_master_ops);
> +
> +	if (du->ddev)
> +		rzg2l_du_drm_fini(du->dev, false);
>  }
>=20
>  /* ---------------------------------------------------------------------=
--------
> @@ -262,7 +370,7 @@ static void rzg2l_du_drm_fini(struct device *dev)
>=20
>  static void rzg2l_du_remove(struct platform_device *pdev)  {
> -	rzg2l_du_drm_fini(&pdev->dev);
> +	rzg2l_du_instance_remove(platform_get_drvdata(pdev));
>  }
>=20
>  static void rzg2l_du_shutdown(struct platform_device *pdev) @@ -304,7 +4=
12,7 @@ static int
> rzg2l_du_probe(struct platform_device *pdev)
>  	rcdu->info =3D info;
>  	rcdu->mmio =3D mmio;
>=20
> -	return rzg2l_du_drm_init(&pdev->dev);
> +	return rzg2l_du_instance_probe(rcdu);
>  }
>=20
>  static struct platform_driver rzg2l_du_platform_driver =3D { diff --git =
a/drivers/gpu/drm/renesas/rz-
> du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> index 2952c9d7348b..4c2e12206d83 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> @@ -21,6 +21,7 @@ struct device;
>  struct drm_property;
>=20
>  #define RZG2L_DU_FEATURE_DPIO_OE	BIT(0)	/* Has DPIO output enable contro=
l */
> +#define RZG2L_DU_FEATURE_COMPONENT	BIT(1)	/* Has several DU instances in=
 one DRM device */
>=20
>  enum rzg2l_du_output {
>  	RZG2L_DU_OUTPUT_DSI0,
> @@ -71,6 +72,7 @@ struct rzg2l_du_device {
>=20
>  	struct drm_device *ddev;
>  	unsigned int index;
> +	bool is_master;
>=20
>  	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
>  	unsigned int num_crtcs;
> --
> 2.54.0

