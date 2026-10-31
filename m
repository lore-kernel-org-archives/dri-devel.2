Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C7606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8b3M8Az
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC6910E09A;
	Sat, 31 Oct 2026 23:18:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20CE910E09A
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 23:18:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAADC42AED;
 Sat, 31 Oct 2026 23:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1D91F000C1;
 Sat, 31 Oct 2026 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793488722;
 bh=VZ6McD+kEVWLGGaG8Se7D2c8sljMtFQpOMHcBFYO0nY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=I8b3M8Azmz6wzkUshoi47VsGyxdU8stTHlOeWMyvYi+OPFMkNsZF5NlSvDOx68qmC
 pSqEUKsFcnVsTv0cqEP60eOAh4rq09rU39Onk/LVshNkuFhbOZQMFwOsYNbSmffVuN
 X5WLVDSeKQU1YsNfHF4zsPwD0WuN8sJ9Y43T4tGWn+W8ox6j44xtr9/v18Dm3yc01J
 K58oRuGckk68oufYvaTt8IuGYnCDViK69KnkKenLTaPNNN3vYGNt+b+VYQS/uPH+hw
 l22Kyu5zTZBFOhRpjynAWtF9PjHNl6EKzQqCbT3ShCig37bT3jjrdf+AMVuv2zkgRh
 Z9+PeYpJyxbSw==
Message-ID: <sashiko-outbox-192219@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/vkms: Use drm_dev_unplug() for ConfigFS device
 removal
To: "Sebastian Wick" <sebastian.wick@redhat.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261031225901.3200167-2-sebastian.wick@redhat.com>
References: <20261031225901.3200167-1-sebastian.wick@redhat.com>
 <20261031225901.3200167-2-sebastian.wick@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 23:18:42 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/vkms: broken CRC debugfs unplug handling in vkms_destroy()
--

commit 58c6203197ea5aa86a82e01783503c18d44dd2a1
Author: Sebastian Wick <sebastian.wick@redhat.com>

drm/vkms: Use drm_dev_unplug() for ConfigFS device removal

This commit switches vkms_destroy() from drm_dev_unregister() to
drm_dev_unplug() so that ioctls on open file descriptors are rejected with
-ENODEV and in-flight operations guarded by drm_dev_enter()/drm_dev_exit()
complete before ConfigFS device removal proceeds.

> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_=
drv.c
> index 5a640b531d88f..716f9c966c211 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -259,7 +259,7 @@ void vkms_destroy(struct vkms_config *config)
> =20
>  	fdev =3D config->dev->faux_dev;
> =20
> -	drm_dev_unregister(&config->dev->drm);
> +	drm_dev_unplug(&config->dev->drm);
>  	drm_atomic_helper_shutdown(&config->dev->drm);
>  	devres_release_group(&fdev->dev, NULL);

[Severity: High]
How does this interact with an open CRTC CRC debugfs file descriptor
(/sys/kernel/debug/dri/<N>/crtc-<M>/crc/data) when the VKMS device is
disabled via ConfigFS?

In drivers/gpu/drm/vkms/vkms_composer.c, vkms_set_crc_source() guards the
callback with drm_dev_enter():

drivers/gpu/drm/vkms/vkms_composer.c:vkms_set_crc_source() {
	...
	if (!drm_dev_enter(crtc->dev, &idx))
		return -ENODEV;

	ret =3D vkms_crc_parse_source(src_name, &enabled);

	vkms_set_composer(out, enabled);

	drm_dev_exit(idx);
	return ret;
}

When the crc/data file descriptor is closed, full_proxy_release() invokes
crtc_crc_release() in drivers/gpu/drm/drm_debugfs_crc.c, which calls
crtc->funcs->set_crc_source(crtc, NULL).

Two issues seem possible here:

1. Unlike /dev/dri/card<N> file descriptors, opening crc/data via
crtc_crc_open() does not acquire a drm_dev_get() reference on crtc->dev,
and debugfs_remove_recursive() during drm_dev_unregister() does not wait
for open file descriptors to close.

In vkms_destroy(), drm_dev_unplug() runs synchronize_srcu() before
devres_release_group(&fdev->dev, NULL) drops the devm reference via
devm_drm_dev_init_release() -> drm_dev_put(). If no /dev/dri/card<N> fd is
open (or after it is closed first, such as during process exit when card<N>
has a lower fd number than crc/data), drm_dev_release() frees struct
vkms_output (embedding struct drm_crtc) and struct vkms_device (embedding
struct drm_device). When the crc/data fd is subsequently closed, wouldn't
crtc_crc_release() and drm_dev_enter(crtc->dev, &idx) in
vkms_set_crc_source() dereference the freed struct drm_crtc and
crtc->dev?

2. Conversely, if struct drm_device is still kept alive by an open
/dev/dri/card<N> fd when crc/data is closed after drm_dev_unplug() sets
dev->unplugged =3D true, drm_dev_enter(crtc->dev, &idx) in
vkms_set_crc_source(crtc, NULL) will return false and exit early with
-ENODEV. Doesn't that skip vkms_set_composer(out, false), leaving
out->composer_enabled set to true and leaking the vblank reference from
drm_crtc_vblank_put(&out->crtc)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031225901.3200=
167-1-sebastian.wick@redhat.com?part=3D2
