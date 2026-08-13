Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8856C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 23:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4FC910E09B;
	Thu, 13 Aug 2026 23:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jc/DoWY/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C43A10E09B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 23:30:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B72FA43CFE;
 Thu, 13 Aug 2026 23:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FB71F000E9;
 Thu, 13 Aug 2026 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786663834;
 bh=2p/tvAmkE331J7bGXirjEiV5xOjnbanukneGZ5STwOE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jc/DoWY/4e9CdlXRRo+2GnK2NDuulA0G+hEIx3eUg1x1opz5tHFSLTLqbHAts028J
 +bdW95sSCAyeueRsMSMdUzfKN0rLziDieMb+riTXmUn2nq5bgZ/bl2IlIhy0WmLx0f
 /uPV7z108coZctgCVzTzgYpAb/p21Pz1FLOpPnh7SCL4wdziu44iIq+7z3+J6jQhIh
 ADXuD6Q4rQptf6x9gtCqCkUQWlGwx+lr5ui2uQ0NOJRGbNOCBvihU2SZj6RjY88CkV
 9PWSCh4laT2oIa+GKtHdb+3KTYlCblgtXf47FGhjmKWMZajCuEZ0BV069KyQcXaFTF
 UXt7/yDcmByzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/11] drm/mxsfb/lcdif: use dev_err_probe()
 consistently in lcdif_attach_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: Frank.Li@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, imx@lists.linux.dev,
 conor+dt@kernel.org
In-Reply-To: <20260402-drm-lcdif-dbanc-v3-3-27cd247a0847@bootlin.com>
References: <20260402-drm-lcdif-dbanc-v3-3-27cd247a0847@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:30:33 +0000
Message-Id: <20260813233034.35FB71F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Allocating the DRM encoder with devm_kzalloc() causes a use-after-=
free on device unbind if userspace holds a DRM file descriptor open.
--

--- Patch [3]: [PATCH v3 03/11] drm/mxsfb/lcdif: use dev_err_probe() consis=
tently in lcdif_attach_bridge ---
commit acad1a96fd5b86c6ee99f36bf8b226bbe0b10059
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/mxsfb/lcdif: use dev_err_probe() consistently in lcdif_attach_bridge

This commit updates error paths in lcdif_attach_bridge() to consistently use
dev_err_probe() instead of dev_err(), simplifying the code and improving
error reporting.

> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lc=
dif_drv.c
> index 8da8a265c05c8..1c76709c4d94d 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
[ ... ]
> @@ -75,20 +73,18 @@ static int lcdif_attach_bridge(struct lcdif_drm_priva=
te *lcdif)
>  					     of_ep.id);
> =20
>  		encoder =3D devm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but could this devm_kzalloc() cause a
use-after-free on device unbind?

The DRM device is initialized with drmm_mode_config_init(), which ties
drm_mode_config_cleanup() to the drm_device lifetime. If userspace holds a =
DRM
file descriptor open during driver unbind, devres will free the encoder mem=
ory
tied to the physical device.

Later, when the last DRM file descriptor is closed, drm_mode_config_cleanup=
()
will iterate over the mode config's encoder list and access the already fre=
ed
encoder to call encoder->funcs->destroy(), leading to a use-after-free.

> -		if (!encoder) {
> -			dev_err(dev, "Failed to allocate encoder for endpoint%u\n",
> -				of_ep.id);
> -			return -ENOMEM;
> -		}
> +		if (!encoder)
> +			return dev_err_probe(dev, -ENOMEM,
> +					     "Failed to allocate encoder for endpoint%u\n",
> +					     of_ep.id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260402-drm-lcdif-=
dbanc-v3-0-27cd247a0847@bootlin.com?part=3D3
