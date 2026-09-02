Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F986C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6781A10F345;
	Wed,  2 Sep 2026 20:30:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BI2R8Qnk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1813D10F345
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:30:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29F0E601EF;
 Wed,  2 Sep 2026 20:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A074F1F000E9;
 Wed,  2 Sep 2026 20:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788381039;
 bh=Vd9tH7nfyxg6BAOdiVty6oORXGVIRARXo34srHvcNjA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BI2R8QnkReJ1jNpzWmgYA3GFCqSsa10ol6mit7xbn3lkNHYGx4Fc4VKll6IRWN470
 69yM0jREO0zjifxD4Vb5Bx6bdTwO0tXp23oG/N9iOrWydwOg6FTBQDaKPs/J+s9YGn
 2rFGehA02KE/WnNV+MhC+C6jdsWNTMxCYi7D+UOGQtsiW1qyLqBjajpWrlmvvbug0U
 JnXoLj0HMi40XIEH+ZpaXLhq3OSqLEbNhOHp5leUAXe8ziNKoaYVAI2dN+y7nDS6Em
 JcbOojOe9fMlD3gs3Imyn1d8qS09ELVIEe+IF2JiuN1xMPhbCXa7BC43moIFrANfma
 Wn9Xv5+t8As2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/11] drm: logicvc: Use
 devm_of_reserved_mem_device_init()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260902201640.2024648-2-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
 <20260902201640.2024648-2-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:30:38 +0000
Message-Id: <20260902203039.A074F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of layer structures (containing drm_plane) during d=
river cleanup due to incorrect devm vs. drmm initialization order.
- [High] Concurrent probe overwrites shared static global regmap_config, ca=
using a data race.
--

commit 3a0c473b709e63281231182c727f9e5d25ce8b6f
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

drm: logicvc: Use devm_of_reserved_mem_device_init()

Switch to devm_of_reserved_mem_device_init() so the reserved memory region
is released automatically on probe failure or device unbind. Replace manual
cleanup labels with error_early.

> diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logi=
cvc/logicvc_drm.c
> index bbebf4fc7f51a..d6dbe52ff0a99 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_drm.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
[ ... ]
> @@ -327,14 +327,14 @@ static int logicvc_drm_probe(struct platform_device=
 *pdev)
[ ... ]
>  		base =3D devm_ioremap_resource(dev, &res);
>  		if (IS_ERR(base)) {
>  			dev_err(dev, "Failed to map I/O base\n");
>  			ret =3D PTR_ERR(base);
> -			goto error_reserved_mem;
> +			goto error_early;
>  		}
> =20
>  		logicvc_drm_regmap_config.max_register =3D resource_size(&res) -

[Severity: High]
This isn't a bug introduced by this patch, but does this concurrent probe=20
overwrite the shared static global logicvc_drm_regmap_config?

Modifying a static global structure without locking can cause a data race i=
f=20
multiple devices probe concurrently (e.g., if multiple IP cores are defined=
=20
in the device tree).=20

Depending on the race window, one device instance might be initialized with=
=20
the max_register value of another instance, leading to either restricted MM=
IO=20
access or out-of-bounds MMIO access.

> @@ -345,21 +345,21 @@ static int logicvc_drm_probe(struct platform_device=
 *pdev)
[ ... ]
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		ret =3D -ENODEV;
> -		goto error_reserved_mem;
> +		goto error_early;
>  	}
> =20
>  	logicvc =3D devm_drm_dev_alloc(dev, &logicvc_drm_driver,
>  				     struct logicvc_drm, drm_dev);

[Severity: High]
This is a pre-existing issue, but can this devm_drm_dev_alloc() call lead t=
o=20
a use-after-free of layer structures during driver cleanup?

This call establishes the point in the devres stack where drm_dev_put() wil=
l=20
execute. Because logicvc_layer_init() allocates layer structures with=20
devm_kzalloc() after devm_drm_dev_alloc() executes:

drivers/gpu/drm/logicvc/logicvc_layer.c:logicvc_layer_init() {
    ...
    layer =3D devm_kzalloc(dev, sizeof(*layer), GFP_KERNEL);
    ...
}

devres will execute in LIFO order on unbind. This means devm_kfree() frees=
=20
the layer memory before the DRM device's devres action calls drm_dev_put().

When the DRM device is finally destroyed, drmm actions execute (including=20
drm_mode_config_cleanup()), which iterates over registered planes and calls=
=20
their destroy hook (drm_plane_cleanup). Since the plane is embedded in the=
=20
already-freed layer struct, this causes a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902201640.2024=
648-1-mukesh.ojha@oss.qualcomm.com?part=3D1
