Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA4FC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5B610E31A;
	Thu,  6 Aug 2026 09:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nP0/dFVl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E763010E31A
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:43:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 981D740F0B;
 Thu,  6 Aug 2026 09:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5196F1F00A3A;
 Thu,  6 Aug 2026 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786009384;
 bh=oCA6bDPGnEPsy6PAS4c8zUpU0vkodwIItQFTnQ0Bo6o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nP0/dFVl81M0SqE21E7VFOfb9mmGX4e0HwVV4KOISMjhW1tjmEQMv3yNd+6jVIz7L
 NAs3Isi5/17NBp1ynLidwEZRxIBHzCon37/Ot5m0dN/h9vMocMRF86zihmo/Bts7HW
 qy8Q6hEgbIpK+pR04PgAtpPTrBWpn2wvc4FMsWqKAhL1QpyPQyo7R5cEtlx7H5lx8I
 lcVkTiEtHYqZ8KlLrVwqtLRB2/8c46wVNZ9XSELmic8b/cnpTbADBu7Uin5xvHF4jd
 A7us1zPziTymAKZdBN6JffhS282zHD8MgCDVEkbJ5BeN7MvhXKZZLCEC6T5msS4elt
 n1xT0DmpflKrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: reset dev->registered on drm_dev_register() error
 path
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806093315.594335-1-oushixiong1025@163.com>
References: <20260806093315.594335-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:43:03 +0000
Message-Id: <20260806094304.5196F1F00A3A@smtp.kernel.org>
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
- [High] Userspace can open the DRM minor device before probe completes, le=
ading to UAF if probe fails.
--

--- Patch [1]: [PATCH] drm: reset dev->registered on drm_dev_register() err=
or path ---
commit 4863f2824dd190d908ed2dadca48efc26b615e3b
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm: reset dev->registered on drm_dev_register() error path
   =20
This commit ensures dev->registered is reset to false on the error path
in drm_dev_register(). This prevents a spurious WARN_ON during teardown
of drmm-managed resources after a failed probe.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 1ff0bf7cba6aa..4497af8c9d1c6 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -1120,6 +1120,7 @@ int drm_dev_register(struct drm_device *dev, unsign=
ed long flags)
>  	if (dev->driver->unload)
>  		dev->driver->unload(dev);
>  err_minors:
> +	dev->registered =3D false;

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the error
path here, can userspace open the DRM minor device before probe completes a=
nd
trigger a use-after-free if probe fails?

In drm_dev_register(), the device node is exposed to userspace early:

drm_dev_register() {
    ...
    ret =3D drm_minor_register(dev, DRM_MINOR_PRIMARY);
    ...
}

If a subsequent step fails (like drm_modeset_register_all), we unwind here,
but what happens if userspace already opened the device?

The drm_device refcount prevents the structure from being freed, but the
driver probe returns an error, triggering devres cleanup of MMIO and
driver-private data.

Because the DRM core doesn't set dev->unplugged =3D true on this path, and=
=20
drm_ioctl() doesn't check dev->registered:

drm_ioctl() {
    if (drm_dev_is_unplugged(dev))
        return -ENODEV;
    ...
}

Does this allow userspace to continue issuing ioctls to the torn-down=20
hardware?

>  	remove_compat_control_link(dev);
>  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
>  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806093315.5943=
35-1-oushixiong1025@163.com?part=3D1
