Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37005606A321
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDgMDwN8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4AA10E4CE;
	Sun,  8 Nov 2026 19:18:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0CDF10E43C;
 Sun,  8 Nov 2026 19:18:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AFE216185A;
 Sun,  8 Nov 2026 19:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379001F0089F;
 Sun,  8 Nov 2026 19:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794165501;
 bh=fD6JOR4VK01nqY7C+68D4+Wr2mhlF9Kmy12+kStMzCE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EDgMDwN8+sAi4rE/XloRdtp0SmsqsY8kxd2iuW67whFCtoBl59MU4WTtTzlCa0qez
 oIt8WOsNMBSPKdBJFd8XrOqLeQfjnYar+nCV2TqcVaBpB14rMTy5yw6BtcXk6mzNaa
 FKfRAKsK9qRMi5Q7O8NkYSlSUkrjmKpUtMUmFDmaLQQ4X8vf86Ri8jzoNvoAPqlDMa
 8gjOhYcie/xsjOZV5vfVBQ5Rh7fVupIUG9qAKSwRVYKWhOZMp+jQDlq+FgcxkBxhjY
 7BBC19fn+SrepTVexntyFF6Mr2y0/JU15RKH25OjAn9EsPDjH7cYxRWCMqVLE++IwC
 FMjnlOYQOL21g==
Message-ID: <sashiko-outbox-203930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/fbdev: Preserve visible size when reusing BIOS fb
To: "Zheyu Shen" <arsdragonfly@gmail.com>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <e1823bda-ff83-4e9e-8e81-b2d0ea5c05ac@gmail.com>
References: <e1823bda-ff83-4e9e-8e81-b2d0ea5c05ac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:18:20 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] drm/i915/fbdev: framebuffer leak on error in
  intel_fbdev_driver_fbdev_probe() [1]
--

commit 89c135a5c0c574b132cf58f5439280c84473a688
Author: Zheyu Shen <arsdragonfly@gmail.com>

drm/i915/fbdev: Preserve visible size when reusing BIOS fb

This commit stops intel_fbdev_driver_fbdev_probe() from overwriting the
requested fb_width and fb_height with the BIOS framebuffer's dimensions
when reusing a preallocated BIOS framebuffer.

> diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm=
/i915/display/intel_fbdev.c
> index 219ee17de3f68..5c043172a35c7 100644
> --- a/drivers/gpu/drm/i915/display/intel_fbdev.c
> +++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
> @@ -324,8 +324,6 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_help=
er *helper,
>  	} else {
>  		drm_dbg_kms(display->drm, "re-using BIOS fb\n");
>  		prealloc =3D true;
> -		sizes->fb_width =3D fb->base.width;
> -		sizes->fb_height =3D fb->base.height;
>  	}
> =20
>  	obj =3D intel_fb_bo(&fb->base);

[Severity: Medium]
This problem wasn't introduced by this patch, but does
intel_fbdev_driver_fbdev_probe() leak &fb->base [1] if pinning or
filling the fbdev info fails right after this block?

drivers/gpu/drm/i915/display/intel_fbdev.c:intel_fbdev_driver_fbdev_probe()=
 {
	...
	ifbdev->fb =3D NULL;
	...
	ret =3D intel_parent_fb_pin_ggtt_pin(display, obj, &pin_params,
					   &vma, &offset, NULL);
	if (ret)
		goto out_unlock;

	helper->funcs =3D &intel_fb_helper_funcs;
	helper->fb =3D &fb->base;

	info->fbops =3D &intelfb_ops;

	ret =3D intel_bo_fbdev_fill_info(obj, info, vma);
	if (ret)
		goto out_unpin;
	...
out_unpin:
	intel_parent_fb_pin_ggtt_unpin(display, vma, -1);
out_unlock:
	intel_display_rpm_put(display, wakeref);

	return ret;
}

ifbdev->fb is cleared at the start of the function, so the local fb holds
the only reference to the reused BIOS framebuffer (or the newly allocated
one).  If intel_parent_fb_pin_ggtt_pin() or intel_bo_fbdev_fill_info()
fails, drm_fb_helper_single_fb_probe() aborts before
register_framebuffer(), so intelfb_ops.fb_destroy is never called and the
drm_framebuffer and its backing GEM object are leaked, triggering a
WARN_ON(!list_empty(&dev->mode_config.fb_list)) in
drm_mode_config_cleanup() on driver teardown.

[1] https://sashiko.dev/#/bug/linux-c63f5649-e8ad-40e0-abcd-b5a3b7668026

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/e1823bda-ff83-4e9e-=
8e81-b2d0ea5c05ac@gmail.com?part=3D1
