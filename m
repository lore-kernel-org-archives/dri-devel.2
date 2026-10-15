Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046FBCC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62BB810E236;
	Thu, 15 Oct 2026 03:26:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066AF10E236
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:26:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0CCBB6020C;
 Thu, 15 Oct 2026 03:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C731F000C4;
 Thu, 15 Oct 2026 03:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792034810;
 bh=qcdbk2H9mFDVss+Yo1ikZvPlkWBnZ3s9Y+NIKQuocS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n5ZnMslb3CBvqymt9AxzgPLnjx1S3spYJ+EATvrs8VB3EGOi7ntnX1wGrw8DA13Zq
 M5u4GmEku1MiI1tGAJ8ZxDuL6C4y4HsAkiMlumrtdMFNzyA/a4f1oayaJoiK+j42w+
 /lzbL0OC/OhMnMy+jnpo4BqKcOetfQziE4FGizl7FxQn+gMvfHV58dUhBnDfpnES4R
 h+IspReTvSubxc7azNzNmNGGgThXogCP6G255a6FLmxhNSOvNje4Qb6YOMOqL19ZDO
 CIQLW9ef7fYOcpjKTz2KSuO6A0AtMgj+Ny9d8y7tSls9+fTIkLXPBtLwp0Npp3vydv
 PlFtvWKJnkXdg==
Message-ID: <sashiko-outbox-172196@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/logicvc: keep the IRQ within the display resource
 lifetime
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <179203400409.2736079.4502160101423826217.G31.logicvc-irq@gmail.com>
References: <179203400409.2736079.4502160101423826217.G31.logicvc-irq@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:26:50 +0000
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
- [Critical] drm/logicvc: UAF of drm_plane during probe failure or unbind
--

commit 81e314862f436f8aee3b4c3a043bbab040bd125b
Author: Myeonghun Pak <mhun512@gmail.com>

drm/logicvc: keep the IRQ within the display resource lifetime

The interrupt handler accesses the CRTC and the register map. Its
device-managed release currently happens after remove has unprepared
the clocks, and the CRTC is allocated after the interrupt is requested.
Consequently a running handler can outlive the resources it uses, both
on removal and when probe unwinds.

Request the interrupt after initializing the display objects, and
release it explicitly before tearing down the mode state and clocks.
Keep it available through drm_atomic_helper_shutdown(), which may need
vblank completion. Also release it on drm_dev_register() failure before
unwinding the display resources.

> diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logi=
cvc/logicvc_drm.c
> index bbebf4fc7f51a..cf60bbb9800c5 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_drm.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
[ ... ]
> @@ -434,16 +428,26 @@ static int logicvc_drm_probe(struct platform_device=
 *pdev)
>  		goto error_clocks;
>  	}
> =20
> +	ret =3D devm_request_irq(dev, irq, logicvc_drm_irq_handler, 0,
> +			       dev_name(dev), logicvc);
> +	if (ret) {
> +		drm_err(drm_dev, "Failed to request IRQ\n");
> +		goto error_mode;
> +	}
> +

[Severity: Critical]
Does this error path (and other probe failures or device unbinds) trigger a
use-after-free of the drm_plane structures?

During probe failure unwinding or device unbind, devres will automatically
free the layer memory (which contains the drm_plane) because it was allocat=
ed
with devm_kzalloc().=20

However, neither devres nor logicvc_layer_fini() calls drm_plane_cleanup()
before the memory is freed:

drivers/gpu/drm/logicvc/logicvc_layer.c:logicvc_layer_fini() {
	struct device *dev =3D logicvc->drm_dev.dev;

	list_del(&layer->list);
	devm_kfree(dev, layer);
}

Because the plane is still linked in the DRM core plane list, the later call
to drm_mode_config_cleanup() traverses the list and dereferences the already
freed memory:

drivers/gpu/drm/drm_mode_config.c:drm_mode_config_cleanup() {
	...
	list_for_each_entry_safe(plane, plt, &dev->mode_config.plane_list, head) {
		plane->funcs->destroy(plane);
	}
	...
}

Should logicvc_layer_fini() call drm_plane_cleanup() before explicitly free=
ing
the layer structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179203400409.273607=
9.4502160101423826217.G31.logicvc-irq@gmail.com?part=3D1
