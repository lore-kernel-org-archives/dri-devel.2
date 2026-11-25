Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC811606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aH/AGNF+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4521010FD99;
	Wed, 25 Nov 2026 18:03:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED4910FD99
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:03:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 114694078E;
 Wed, 25 Nov 2026 18:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0CB1F000C6;
 Wed, 25 Nov 2026 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795629815;
 bh=/nAs+9oe/ZAPQ2IOcnzz3tcX+2G1AUK0PK5PTZPJeEo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=aH/AGNF+ur4rKHL8DqiuAmofnVZQ3pdiVwOvA5yFi6ifXRUI5bZTmKtvYf81rrY/9
 iyYpbZYu6xj3hSlAA97NuRTPmLarTEsOcD2pMfxc4HAgx96IjHDgUpqXArIunsRove
 yYZKpFrHmRnrZcxroG6ic0BfZlQlMml5HWkztOeC7wJd9oBq77TH+iLIdjQyDQ/9C7
 kX3KETJPUB0J7+N6pfPObYKeMSON/AFUnYMsqMW2P1RKHzbgMs8irxpPNQMx1YFXp2
 2YoS4bR0yBTsl0z2QMuCejtvTqQo8ssTzSfx9o80Kh+B+qrKLo4zU5oeV9YevrzxbH
 pKbHeewLKrs6A==
Message-ID: <sashiko-outbox-233897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261124180137.616249-5-zachary.mckevitt@oss.qualcomm.com>
References: <20261124180137.616249-1-zachary.mckevitt@oss.qualcomm.com>
 <20261124180137.616249-5-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:03:35 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] accel/qaic: Kconfig depends on default-n DRM_RAS despite
  stubbed API
- [Low] accel/qaic: ignored qaic_telemetry_register() failure in
  qaic_init()
--

commit 8ce3ab45dd93c62906cce075f4239c57f0d04fc1
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

accel/qaic: Add callbacks for DRM RAS netlink telemetry

This commit adds MHI telemetry channel support for QAIC devices and
registers a DRM RAS telemetry node to expose device telemetry fields over
netlink.

> diff --git a/drivers/accel/qaic/Kconfig b/drivers/accel/qaic/Kconfig
> index 116e42d152ca8..6a07db0c402e7 100644
> --- a/drivers/accel/qaic/Kconfig
> +++ b/drivers/accel/qaic/Kconfig
> @@ -8,6 +8,7 @@ config DRM_ACCEL_QAIC
>  	depends on DRM_ACCEL
>  	depends on PCI && HAS_IOMEM
>  	depends on MHI_BUS
> +	depends on DRM_RAS
>  	select CRC32
>  	select WANT_DEV_COREDUMP
>  	help

[Severity: Medium]
Does DRM_ACCEL_QAIC need to depend on DRM_RAS?

DRM_RAS defaults to n (and depends on NET), so adding this dependency
causes existing configs with CONFIG_DRM_ACCEL_QAIC enabled to silently
drop the driver during olddefconfig unless CONFIG_DRM_RAS is also enabled.
Since include/drm/drm_ras.h provides no-op stubs for
drm_ras_node_register() and drm_ras_node_unregister() when CONFIG_DRM_RAS
is disabled, qaic_telemetry.c can build without this dependency.

[ ... ]

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 90c0d31e414ae..6d185151a0a69 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
[ ... ]
> @@ -854,12 +863,17 @@ static int __init qaic_init(void)
>  	ret =3D qaic_ras_register();
>  	if (ret)
>  		pr_debug("qaic: qaic_ras_register failed %d\n", ret);
> +
>  	ret =3D qaic_ssr_register();
>  	if (ret) {
>  		pr_debug("qaic: qaic_ssr_register failed %d\n", ret);
>  		goto free_bootlog;
>  	}
> =20
> +	ret =3D qaic_telemetry_register();
> +	if (ret)
> +		pr_debug("qaic: qaic_telemetry_register failed %d\n", ret);
> +
>  	return 0;
> =20
>  free_bootlog:
> @@ -889,6 +903,7 @@ static void __exit qaic_exit(void)
>  	 * reinitializing the link_up state after the cleanup is done.
>  	 */
>  	link_up =3D true;
> +	qaic_telemetry_unregister();
>  	qaic_ssr_unregister();
>  	qaic_ras_unregister();
>  	qaic_bootlog_unregister();

[Severity: Low]
If qaic_telemetry_register() fails in qaic_init(), module load still
succeeds and leaves qaic_telemetry_mhi_driver unregistered.  On module
unload, qaic_exit() unconditionally calls qaic_telemetry_unregister() ->
mhi_driver_unregister() -> driver_unregister(), which hits
WARN(1, "Unexpected driver unregister!\n") because drv->p is NULL.  Should
qaic_init() unwind and return the error when qaic_telemetry_register()
fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124180137.6162=
49-1-zachary.mckevitt@oss.qualcomm.com?part=3D4
