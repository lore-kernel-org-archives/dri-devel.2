Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5503D606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=qicsT79G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9826610EF95;
	Mon, 23 Nov 2026 16:31:42 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011014.outbound.protection.outlook.com [52.101.125.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FAC110EF95
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5ZMXVk67PnUXq0KBHO9Y1Fo7quvgro5JSaHSPDZMYW3oGcueg+NzzldBLSMAYI9oNrpCD+cvR7OZFEglRz46KhgxkbGV0XWqH0mJt1UD5kdO9fJ6+wjFDmR5BeWff4B3waTz99iQi4FO7KTC4Nc42dqKWN63CUBjhcikzGnFbgXJblFxdU2abGJYZQJ+57Fdhz+l9l+qUZEVAvZE20KUDQwPUrwSvnkYt/kaiakPjGxXIOSOwLxcU6atGJmFNRda33lY8e+19ljLSQhpfsdTS+6xI/sufhng8KYr5F/8gJOixdZM0bLnzPxy4x31gTZ7GkidF01IT1jf/VzgTpwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljpBOZmMrgJRDzWB8vt+5z/hQx1Kx9YHJDG2a7S+tLg=;
 b=Xcv0YS+Wtcdm/7Dko/iyOTK8943pUm0VviFuhVlA5b9cu3H8kS1msIzRYhlZJN2z2tHY4nBSsQxgi5ZbXX2HEin/GQtxfvKC8iWq1/TC/iMy7a402zCvsP/q6iMQfxVwlCS3RwqskJIxbzIszoHR07KR+b1BcoDq9gEedlZEie5ijw9a/cQ0n15Cr/vETcdtdYYhk8QE9mMfm/B4voTkGZKyr7ywGb/tmmib003AEFPdE5loDNdIB1dA8v345sHotpRjQVFfsgl/j7gNtMQidwHem29CTH9AYvhfSk0CRYZQFGV02VlL78OK/QI0SwOvvOoqVD4hRjdb3WP0s9lXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljpBOZmMrgJRDzWB8vt+5z/hQx1Kx9YHJDG2a7S+tLg=;
 b=qicsT79GraOEP4h/WCj1kdFfc+OpIbJNBpr82HRcKiDX/h9ur+MlGYtG0lU91diBgScF2VWEVBgPqi4j8tYyIhzKIWa1DxWC7f8zbs9Ow0BM8eNTpkVTnNeRPaBVbv5VcBrSPhjDfq8LTRamhkLZgI67p86uktf7ZL+uAPNI1ac=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OS7PR01MB14820.jpnprd01.prod.outlook.com (2603:1096:604:398::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:31:31 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:31:31 +0000
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
Subject: RE: [PATCH v10 05/12] drm: renesas: rz-du: Split the mode setting
 initialization
Thread-Topic: [PATCH v10 05/12] drm: renesas: rz-du: Split the mode setting
 initialization
Thread-Index: AQHdc2l6ERobPQXDk06KqqtExGqdVrc76FYg
Date: Mon, 23 Nov 2026 16:31:31 +0000
Message-ID: <TYYPR01MB6603A78B72F221AAC959AC9286452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <8aa3956e7c5934ee8a44c9db718955e12ceef4c2.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <8aa3956e7c5934ee8a44c9db718955e12ceef4c2.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OS7PR01MB14820:EE_
x-ms-office365-filtering-correlation-id: 070ad992-6cce-46e2-aa33-08df497f3b62
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006|5023799004|261009223027099003|4143699003|261028144727099003|261026140227099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|261009221227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: h71aWoYOCq0LrU6LUNuhcaHzdB0+w9TKHhMlJvJ/ZgW9ovLHIFS4RMGV+mzatkvE4wtyd2/fsUYL7ut3pTM2FuNFbgj8UlufHAyk3NvHR3028GzdgExBhEtuAKMaM6hophGz27VPmmNpJ/MsFEKqoZ3KgvTMRSA80xvpwWc1OBP/R204VpXbHHAy9xs7M8crW8PTAhBBqGGsIGeUONGhEcMmN0Y6vTllXpRwDFHppqX5yINiyqgoHzo14lNSeHvtIt23+dew6rL1ch7/qTKSZJY2I0Y5BJehaB6dsRiywglMCtdGe/8K8M0CEaoE51bqnqmqj5gPLgbTHq0vUesPUJQ8+EF95gLneefBY75spAC1/k8xryS4Cj70S7Iq5cKdmnmpeC2lxEGzjpTvmCP03ash6PDNcD+BhXjjd9LZoNwymG+9RjPL+x1pyU39V/Q65ABhNhdwT7Br2AWJ4zgm7DerK9vzN/EnwGA720+s9GEJYsB8PxVeriCbGnY79fG/+cLrV1MGvNzjqaUO4G+X/tY1xQrgZT8AghXeEwG1zCv2aEJMf1GNaa+r680NOY0KrgpuNc3fUEQtKCdlbBiYvdt+aqeyJs1zjWIcoWi1vMNeDXHVeuG0VnQzaQYK3CP3oLDRbzpt4cbcfVF3pjdHJ2TlIu4fmL8OYh63UL+kyMLWzfkoGsYvpDFOp0RzjSxsSXUm/MLn5ou9MYu8raseAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006)(5023799004)(261009223027099003)(4143699003)(261028144727099003)(261026140227099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(261009221227099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vXITPuzfd0dU0RhOGjCHeOiVUwWQkv4lUQsPd4Dhz0aYfzDeF6GqWyH1ZThm?=
 =?us-ascii?Q?Fok6Snza74WyBDDDd6RhP0Qsja0F0nu+x/pU3uJ1gPHMShW5pMAyJtwvhaUD?=
 =?us-ascii?Q?l/LbQHycI+NOfg63UjLGwguV0sQWMqXseDXoo1vkwvIs8BL0Uh5qm8mMhZvN?=
 =?us-ascii?Q?eu55d4eu+Bcc5GC3vulnPKwvI5y81MUd84f7ZqEY9Fsi71XstccA2TSoBYne?=
 =?us-ascii?Q?KuLbcXDrWZZfXA3XhskVWHQougT8E5C3xG9f8l+YBeqnJpoWCtJ9ZYNsl0Ee?=
 =?us-ascii?Q?lp7B7K7/dO+oxUInehJ+OvDVi/4PH/6e+i6+nXxN6iqPbUzAJLwdan7rYAB2?=
 =?us-ascii?Q?pib3TdB4axQANb+7Ts4etB89FA+kuD1V0A0vyTvngnZvUGZYFlfZ3mkgS9ll?=
 =?us-ascii?Q?x6d/W/ERbR8j3pDEUsgUyPDtc5fZlqTwDN+ZOJmZweXKMxQiP1BJ4M7FLyB4?=
 =?us-ascii?Q?ksKfEBN3bKsrS8MTfRNNkVdQ6+xqI1i7UNUUTZvXfu4rY9D9ljrQKRAwMMb6?=
 =?us-ascii?Q?0Mv+asprDyhNg9XGGVQCk6FJ7KEJm3mP4xhbjCLZUvDEkj/sWcMhtua1EO0k?=
 =?us-ascii?Q?xe/Q7SAzBWNRNsIBhIsDBTujlfjHaklKEwi+Ua+6cK77SRjXcYU+M8AvYLS0?=
 =?us-ascii?Q?wF6MKcOYXf2oB1TXoEIt4eR+K15IjbBPDsTG26rpkCHeb5i+nU8XnMeG18y7?=
 =?us-ascii?Q?c2YU4hWEy8YELrH+mP4AyS4RUl6fbo3Aubr/1EJLTvycl72Xrn3AUf5Vmhyu?=
 =?us-ascii?Q?RIEWTZQZkQGJ098BEghRMA2bbDVDU/NCuOJlQdc7UVGo2BnGT4+9hU79czGK?=
 =?us-ascii?Q?4oQNfjh2yc9k3KqXthBhzIxGwOEV6Y9vxp/n/Mh6zRqfQH/QQDwVXcthgyIO?=
 =?us-ascii?Q?B85wyI21V+II8XBmSsPVDierJm9RLaufsPzLif3+gwsWkHiY5hZw9ULZRLQY?=
 =?us-ascii?Q?/zjsQUEXaYGXIRLmKUeVY4sR3X2AJKREPYwOX33p12wBE4HmgTwNEPsFr+Xa?=
 =?us-ascii?Q?Kj11HOrt/JNrL3o6W7z8sFQ8GG3TqUpjVZHfMUbl0vgGjnehJQFLlHALHIVD?=
 =?us-ascii?Q?6CVLAyZVhTcAsn6lJexxyTHjqKPufuCGEzVHNgaHssR00BefubM/qigwe81a?=
 =?us-ascii?Q?g6pi5cKSEFeIdW+V5IGTqMoYTjFKG+3ZSh+zw2Tv2TqIfUUWy920eaMrsLh8?=
 =?us-ascii?Q?3nZj1h90cg0//pwAUCpmRFXP+oa8FrdqlcfrXEx1j8cWSANMEZq3cBdmeFwF?=
 =?us-ascii?Q?dRI2x3El+kI2/YVUtOqiCQANofE8NpLNAogflLvuJitCO16bv/6/k/u2ghRp?=
 =?us-ascii?Q?BFCRzJkkOKRoNqFL39V1KPz4GnWSYYU0a+6GIe3PG1e+V9LRkrQhCISaAfHj?=
 =?us-ascii?Q?jA59R57B1C1sF3c1M3KVYQbDUVLe+NfuFPUvxxh54pwOcbE6b6R1Zsyi8aob?=
 =?us-ascii?Q?UXRtlagUd8ofzDt9Ekue+7+pYJpFE22fUBcBparS81wy9tx1SfGf4Mn2Gwtw?=
 =?us-ascii?Q?ywKNZFm0u833B38pQLeg7e3TCp4wL3Gw6m74OR6a123cJ/dg54zeaTpGDiP8?=
 =?us-ascii?Q?+Fd4c0bpf9JgXjlKJ8KqtHuIDXwUS4jIpzRd1/m9yrgXt/RORcTN3qU9C6xY?=
 =?us-ascii?Q?MWWbS4g8MORuEFmKR8XyquI8zXr7tETy0elWxAgGbTGnfj9SEG1VATe/fGiN?=
 =?us-ascii?Q?3eCasA75a4dj7p+HUqdD53dfJR/eQ2hcH+GKs2G1DJ0ZsAuJq+MLSx2oqu3H?=
 =?us-ascii?Q?OLVuK0234A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070ad992-6cce-46e2-aa33-08df497f3b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 16:31:31.5440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EB6WUs9X2ugNXJqY0lY8JeIQOB+7uF4t5guofA0aBiXEyamwHolybu+onONts8cPn6KMDfqiNEQ6HVF0rxfLzBdFbxQXtfyDj8xbLuKuWm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14820
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
> Subject: [PATCH v10 05/12] drm: renesas: rz-du: Split the mode setting in=
itialization
>=20
> rzg2l_du_modeset_init() initializes the mode configuration of the DRM dev=
ice and creates the KMS
> objects of the DU instance. On RZ/G3E two instances share a DRM device, s=
o the mode configuration is
> initialized once while each instance creates its own KMS objects.
>=20
> In preparation for supporting RZ/G3E SoC, split them into rzg2l_du_modese=
t_init_drm(),
> rzg2l_du_modeset_init_du() and rzg2l_du_modeset_init_finish(), the latter=
 completing the DRM device
> once all instances have created their KMS objects, and call them from the=
 probe function.
> As it is no longer tied to an instance, take from the DRM device and the =
encoders what used to be
> taken from the instance.
>=20
> No functional change intended.

There is a change in code flow drm_vblank_init() is called after CRTC's cre=
ated now.

>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v9->v10:
>  - Dropped rzg2l_du_modeset_init(), call the helpers from probe.
>  - Updated commit body accordingly.
>=20
> v8->v9:
>  - New patch.
>=20
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 32 ++++++++++------  driv=
ers/gpu/drm/renesas/rz-
> du/rzg2l_du_kms.c | 39 +++++++++++++-------  drivers/gpu/drm/renesas/rz-d=
u/rzg2l_du_kms.h |  4 +-
>  3 files changed, 49 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_drv.c
> index 57197356143f..d3cccbdf9012 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -223,17 +223,17 @@ static int rzg2l_du_probe(struct platform_device *p=
dev)
>  		return ret;
>=20
>  	/* DRM/KMS objects */
> -	ret =3D rzg2l_du_modeset_init(rcdu);
> -	if (ret < 0) {
> -		/*
> -		 * Don't use dev_err_probe(), as it would overwrite the probe
> -		 * deferral reason recorded in rzg2l_du_modeset_init().
> -		 */
> -		if (ret !=3D -EPROBE_DEFER)
> -			dev_err(&pdev->dev,
> -				"failed to initialize DRM/KMS (%d)\n", ret);
> +	ret =3D rzg2l_du_modeset_init_drm(&rzgdrm->ddev);
> +	if (ret < 0)
>  		goto error;
> -	}
> +
> +	ret =3D rzg2l_du_modeset_init_du(rcdu);
> +	if (ret < 0)
> +		goto error;
> +
> +	ret =3D rzg2l_du_modeset_init_finish(&rzgdrm->ddev);
> +	if (ret < 0)
> +		goto error_fini;
>=20
>  	/*
>  	 * Register the DRM device with the core and the connectors with @@ -24=
1,7 +241,7 @@ static int
> rzg2l_du_probe(struct platform_device *pdev)
>  	 */
>  	ret =3D drm_dev_register(&rzgdrm->ddev, 0);
>  	if (ret)
> -		goto error;
> +		goto error_fini;
>=20
>  	drm_info(&rzgdrm->ddev, "Device %s probed\n", dev_name(&pdev->dev));
>=20
> @@ -249,8 +249,16 @@ static int rzg2l_du_probe(struct platform_device *pd=
ev)
>=20
>  	return 0;
>=20
> -error:
> +error_fini:
>  	drm_kms_helper_poll_fini(&rzgdrm->ddev);
> +error:
> +	/*
> +	 * Don't use dev_err_probe(), as it would overwrite the probe deferral
> +	 * reason recorded while initializing the DRM/KMS objects.
> +	 */
> +	if (ret !=3D -EPROBE_DEFER)
> +		dev_err(&pdev->dev, "failed to initialize DRM/KMS (%d)\n", ret);
> +
>  	return ret;
>  }
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_kms.c
> index 6eb1865f43b4..73cb3199f90f 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> @@ -400,11 +400,8 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device=
 *rcdu)
>  	return ret;
>  }
>=20
> -int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
> +int rzg2l_du_modeset_init_drm(struct drm_device *dev)
>  {
> -	struct drm_device *dev =3D rcdu->ddev;
> -	struct drm_encoder *encoder;
> -	unsigned int num_encoders;
>  	int ret;
>=20
>  	ret =3D drmm_mode_config_init(dev);
> @@ -424,15 +421,14 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *r=
cdu)
>  	dev->mode_config.max_width =3D 1920;
>  	dev->mode_config.max_height =3D 1920;
>=20
> -	rcdu->num_crtcs =3D hweight8(rcdu->info->channels_mask);
> +	return 0;
> +}
>=20
> -	/*
> -	 * Initialize vertical blanking interrupts handling. Start with vblank
> -	 * disabled for all CRTCs.
> -	 */
> -	ret =3D drm_vblank_init(dev, rcdu->num_crtcs);
> -	if (ret < 0)
> -		return ret;
> +int rzg2l_du_modeset_init_du(struct rzg2l_du_device *rcdu) {
> +	int ret;
> +
> +	rcdu->num_crtcs =3D hweight8(rcdu->info->channels_mask);
>=20
>  	/* Initialize the compositors. */
>  	ret =3D rzg2l_du_vsps_init(rcdu);
> @@ -455,6 +451,23 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rc=
du)
>  		return -EINVAL;
>  	}
>=20
> +	return 0;
> +}
> +
> +int rzg2l_du_modeset_init_finish(struct drm_device *dev) {
> +	struct drm_encoder *encoder;
> +	unsigned int num_encoders;
> +	int ret;
> +
> +	/*
> +	 * Initialize vertical blanking interrupts handling. Start with vblank
> +	 * disabled for all CRTCs.
> +	 */
> +	ret =3D drm_vblank_init(dev, dev->mode_config.num_crtc);
> +	if (ret < 0)
> +		return ret;
> +
>  	num_encoders =3D dev->mode_config.num_encoder;
>=20
>  	/*
> @@ -465,7 +478,7 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcd=
u)
>  	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
>  		struct rzg2l_du_encoder *renc =3D to_rzg2l_encoder(encoder);

		struct rzg2l_du_device *rcdu =3D renc->rcdu;

Cheers,
Biju

>  		const struct rzg2l_du_output_routing *route =3D
> -			&rcdu->info->routes[renc->output];
> +			&renc->dev->info->routes[renc->output];
>=20
>  		encoder->possible_crtcs =3D route->possible_outputs;
>  		encoder->possible_clones =3D (1 << num_encoders) - 1; diff --git
> a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h b/drivers/gpu/drm/renesas/=
rz-du/rzg2l_du_kms.h
> index e2c599f115c6..98627a6de4c4 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
> @@ -29,7 +29,9 @@ struct rzg2l_du_format_info {
>=20
>  const struct rzg2l_du_format_info *rzg2l_du_format_info(u32 fourcc);
>=20
> -int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu);
> +int rzg2l_du_modeset_init_drm(struct drm_device *dev); int
> +rzg2l_du_modeset_init_du(struct rzg2l_du_device *rcdu); int
> +rzg2l_du_modeset_init_finish(struct drm_device *dev);
>=20
>  int rzg2l_du_dumb_create(struct drm_file *file, struct drm_device *dev,
>  			 struct drm_mode_create_dumb *args);
> --
> 2.54.0

