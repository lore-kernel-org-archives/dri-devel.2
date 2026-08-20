Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB748C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8E610EF4E;
	Thu, 20 Aug 2026 08:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Am7pXYFn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991EC10EF4E
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:39:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 422BA40710;
 Thu, 20 Aug 2026 08:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0625E1F000E9;
 Thu, 20 Aug 2026 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787215195;
 bh=Pn/LI2zmLAhu4Mgvgf0BbEGRHZcXKFGGXj6sq0tIwuA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Am7pXYFnnF3oM6pSg8FESf3bNJDMY0fQLsdJs7RzBpF+wkHsAjb5+BenPyHn3OOrB
 L9Ma2R1wTbgTv226aMDZIvE4A2/4rWchX7cMXXi23AOIUXDRW2ANSfLwc4vBDc0+ov
 WWERpWq7d4zNJIQDhKNZ6WcBVA3p/s08rzoinJK8we+utsL22cXACEHmtjaTV4Ku2L
 ZrjWbIymkKhOfGkFchXWl7EUYzeFdM4fkQW0EY8af3/yRLoxWX91Ji1RlQunKkFljl
 BaKhb/jYZhT1puCXwc2DT/rhojKYL5y2ovLjNZ5JpmlpIdcrSr8xugsncEFnMHnl33
 FNfBnND3ZEL1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/vkms: Cache composer line buffers in vkms_output
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820083123.544655-1-oushixiong1025@163.com>
References: <20260820083123.544655-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 08:39:54 +0000
Message-Id: <20260820083955.0625E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The device teardown path frees the composer line buffers before th=
e composer workqueue is flushed, leading to a Use-After-Free (UAF).
- [High] A double-free vulnerability exists if the allocation for the stage=
 buffer fails during reallocation, leaving a dangling pointer.

Pre-existing issues:
- [High] Preexisting Use-After-Free of `vkms_crtc_state` when destroying th=
e CRTC state while a composer worker is pending.
--

--- Patch [1]: [PATCH 1/2] drm/vkms: Cache composer line buffers in vkms_ou=
tput ---
commit 169a243140521e33c116ce0ae779021e7e4e4b76
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/vkms: Cache composer line buffers in vkms_output

compose_active_planes() kvmalloc/kvfree two line buffers every vblank
frame, but their size depends only on hdisplay which changes only on
modeset.  Cache them in vkms_output and reallocate only when the width
changes, avoiding repeated alloc/free overhead.

Register a drmm action to free the buffers when the device is released.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 83d217085ad09..f3fb203946e83 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
[ ... ]
> @@ -565,27 +565,35 @@ static int compose_active_planes(struct vkms_writeb=
ack_job *active_wb,
>  	stage_buffer.n_pixels =3D line_width;
>  	output_buffer.n_pixels =3D line_width;
> =20
> -	stage_buffer.pixels =3D kvmalloc(line_width * pixel_size, GFP_KERNEL);
> -	if (!stage_buffer.pixels) {
> -		DRM_ERROR("Cannot allocate memory for the output line buffer");
> -		return -ENOMEM;
> -	}
> +	if (out->composer_buffer_width !=3D line_width) {
> +		kvfree(out->composer_stage_buffer);
> +		kvfree(out->composer_output_buffer);
> +		out->composer_buffer_width =3D 0;
> +
> +		out->composer_stage_buffer =3D kvmalloc(line_width * pixel_size, GFP_K=
ERNEL);
> +		if (!out->composer_stage_buffer) {
> +			DRM_ERROR("Cannot allocate memory for the output line buffer");
> +			return -ENOMEM;
> +		}

[Severity: High]
If this kvmalloc() fails, does it leave out->composer_output_buffer pointing
to freed memory?

When the line width changes, both buffers are freed. If the allocation for =
the
stage buffer fails, the function returns -ENOMEM without clearing
out->composer_output_buffer.

Later, during device teardown, vkms_composer_buffers_release() will call
kvfree() on out->composer_output_buffer again. Could this lead to a
double-free?

> +
> +		out->composer_output_buffer =3D kvmalloc(line_width * pixel_size, GFP_=
KERNEL);
> +		if (!out->composer_output_buffer) {
> +			DRM_ERROR("Cannot allocate memory for intermediate line buffer");
> +			kvfree(out->composer_stage_buffer);
> +			out->composer_stage_buffer =3D NULL;
> +			return -ENOMEM;
> +		}
[ ... ]
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms=
_crtc.c
> index 079abfba427d0..6e03c9a1fbd82 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
[ ... ]
> @@ -237,5 +245,9 @@ struct vkms_output *vkms_crtc_init(struct drm_device =
*dev, struct drm_plane *pri
>  	if (IS_ERR(vkms_out->composer_workq))
>  		return ERR_CAST(vkms_out->composer_workq);
> =20
> +	ret =3D drmm_add_action_or_reset(dev, vkms_composer_buffers_release, vk=
ms_out);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	return vkms_out;
>  }

[Severity: High]
Does this setup create a use-after-free during device teardown?

The DRM managed resource API executes release actions in LIFO order. Here, =
the
workqueue is allocated first (which registers its destruction/flush action),
and then the buffer release action is registered.

During teardown, the buffers will be freed first. Then the workqueue is
destroyed, which flushes any pending vkms_composer_worker items. If a worker
is pending and executes compose_active_planes(), won't it access the already
freed buffer memory?


[Severity: High]
This is a pre-existing issue, but I noticed another potential use-after-free
in vkms_atomic_crtc_destroy_state().

When the CRTC state is destroyed, it issues a warning if the composer work =
is
pending:

    WARN_ON(work_pending(&vkms_state->composer_work));
    kfree(vkms_state->active_planes);
    kfree(vkms_state);

Since it doesn't synchronize or cancel the work (e.g., using
cancel_work_sync()), if the worker executes after this point, won't it
access the freed vkms_state and its planes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820083123.5446=
55-1-oushixiong1025@163.com?part=3D1
