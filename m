Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF334606A327
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4rDRI/f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3147D10FA35;
	Wed, 11 Nov 2026 09:31:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A3FA10FA19
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:31:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6AA216182C;
 Wed, 11 Nov 2026 09:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D151F00A06;
 Wed, 11 Nov 2026 09:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794389470;
 bh=3AgO7XPSpjRTP9NmHs0yfYc5+nB1Tmy9MJPmu3vfD8M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L4rDRI/fWWqVwCThg4/xbD1N7/ofsy+Jf2Z604cMa+tbYZkENSHZ24i4fub8aunpc
 mqatzY/Vjd+lU0CJ4eL/Y5T83+brkpmgSn/d+vAgrijOsInv+GJPhIPMJwav9HfXZB
 0rryxXZrXeRzvTGMNWqPN6AKCziC9xNR3CB9f7cGGrZ/gzFHNr7ovoRp0jD7a1h1G4
 eYnRclNVxqj6srytHtzqIuh553xgDDBCJA9/CVRqLDdeLHXR3QwHspKrGfPkJRTJg9
 6pwypKx6xRInq1BLRN4qkxLm1I3S2xUsEHuBdlAwy65qBoaLfrjSHpTSGRSydlbkUG
 5sIGRaxgWHJKg==
Message-ID: <sashiko-outbox-208700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/meson: fix NULL pointer dereference in
 meson_drv_bind_master()
To: "Rand Deeb" <rand.sec96@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20261111091657.598-1-rand.sec96@gmail.com>
References: <20261111091657.598-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 09:31:09 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/meson: missing drm_kms_helper_poll_fini() on error in
  meson_drv_bind_master() [1]
--

commit 79a6a19243f321e0c18a04ea82e4aefcdcacddf4
Author: Rand Deeb <rand.sec96@gmail.com>

drm/meson: fix NULL pointer dereference in meson_drv_bind_master()

This commit avoids jumping to free_drm when allocating priv fails in
meson_drv_bind_master(), directly putting the drm device and returning -ENO=
MEM
so encoder removal helpers are not called with a NULL priv.

> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/me=
son_drv.c
> index 38bf2811d068d..a9b707062b4f6 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -204,8 +204,8 @@ static int meson_drv_bind_master(struct device *dev, =
bool has_components)
> =20
>  	priv =3D devm_kzalloc_obj(dev, *priv);
>  	if (!priv) {
> -		ret =3D -ENOMEM;
> -		goto free_drm;
> +		drm_dev_put(drm);
> +		return -ENOMEM;
>  	}
>  	drm->dev_private =3D priv;
>  	priv->drm =3D drm;

[Severity: Critical]
This problem wasn't introduced by this patch, but can a failure in
drm_dev_register() cause a use-after-free on
drm->mode_config.output_poll_work [1]?

drivers/gpu/drm/meson/meson_drv.c:meson_drv_bind_master() {
    ...
	drm_kms_helper_poll_init(drm);

	platform_set_drvdata(pdev, priv);

	ret =3D drm_dev_register(drm, 0);
	if (ret)
		goto uninstall_irq;
    ...
uninstall_irq:
	free_irq(priv->vsync_irq, drm);
}

When drm_dev_register() fails, jumping to uninstall_irq reaches
drm_dev_put() without calling drm_kms_helper_poll_fini(), leaving
output_poll_work active after the drm_device is freed.

[1] https://sashiko.dev/#/bug/linux-e1c69353-dace-476d-bef2-4ab1c205215c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111091657.598-=
1-rand.sec96@gmail.com?part=3D1
