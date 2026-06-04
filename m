Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048ACCD6E55
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB591125C8;
	Thu,  4 Jun 2026 02:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K6zjB66G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EDC91125C8
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 02:59:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEE32601DD;
 Thu,  4 Jun 2026 02:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A59B1F00893;
 Thu,  4 Jun 2026 02:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780541962;
 bh=z5EpXPsUfA7USs3S6A1sRRCfb4ZitSEaJC6lq2MG+IM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K6zjB66GdfO930gPRYrWSK6Bl8Lr698Apokdz3CJ9FvgJncqMyxrIl8tLmVLiLsLC
 dXI69YdP2hLfNFYOnW5ZpP7raicSm4spbYTDOy8hIRQHV07xu8TGd3fN3eOJ0CU4Ow
 47dJvCSWFPXfRbQRyFQZKvsVXzXeqilHsVapvntcjIdGGMFnn+DfAGY4cV4tfGtX27
 GhDUEWY9uZOH/ee8CBF9Mkctv4G8ycpFeUG/Rl0J58SYhYrbsvCGZPpNXUSfUW4DNg
 cJ3xkdeu89JqrdTiJOTGRA2mOXykQV6TE8ZkbKiVmUYV5jCiVjTQZdBPJ8loFY3C7J
 e7wfVR53kB8Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/14] drm/v3d: Reject invalid out_sync handles in
 submit ioctls
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-13-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-13-d7114bba55a0@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:59:22 +0000
Message-Id: <20260604025922.7A59B1F00893@smtp.kernel.org>
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
- [High] Resource leak (memory and drm_syncobj references) when parsing cha=
ined user-space extensions.
--

commit 42106e7ee90a922dbfb05df35206e0f77fc80751
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Move out_sync syncobj lookup to submission

The commit moves the out_sync sync object lookup to the submission phase,
failing with -ENOENT if userspace passes a non-zero handle that doesn't
refer to a valid syncobj. It also consolidates the cleanup routines on
error paths for both single-sync and multi-sync implementations.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 2beb99a25104..dc27770d85fd 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
[ ... ]
> @@ -1032,6 +1034,12 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *=
data,
>  		}
>  	}
> =20

[Severity: High]
This isn't a bug introduced by this patch, but can the direct returns when
parsing extensions cause a resource leak?

In v3d_submit_cl_ioctl(), if userspace provides a valid
DRM_V3D_EXT_ID_MULTI_SYNC extension followed by an invalid one (e.g., an
unknown ID), v3d_get_extensions() will successfully allocate se.out_syncs
and acquire drm_syncobj references for the first extension, but then fail
on the second extension and return an error code.

Because the code directly returns here instead of jumping to a cleanup labe=
l,
it bypasses v3d_submit_put_post_deps(), leaking both the memory and the
drm_syncobj references.

Could this be triggered repeatedly by userspace chaining a valid multi-sync
extension with an invalid one, potentially exhausting kernel memory and file
descriptors?

> +	if (args->out_sync && !(se.flags & DRM_V3D_EXT_ID_MULTI_SYNC)) {
> +		sync_out =3D drm_syncobj_find(file_priv, args->out_sync);
> +		if (!sync_out)
> +			return -ENOENT;
> +	}
> +
>  	if (args->bcl_start !=3D args->bcl_end) {
>  		bin =3D (struct v3d_bin_job *) v3d_submit_add_job(&submit, V3D_BIN);
>  		if (IS_ERR(bin)) {
[ ... ]
> @@ -1137,6 +1146,12 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void =
*data,
>  		}
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but the same resource leak when
v3d_get_extensions() fails appears here in v3d_submit_tfu_ioctl() as well.

> +	if (args->out_sync && !(se.flags & DRM_V3D_EXT_ID_MULTI_SYNC)) {
> +		sync_out =3D drm_syncobj_find(file_priv, args->out_sync);
> +		if (!sync_out)
> +			return -ENOENT;
> +	}
> +
>  	job =3D (struct v3d_tfu_job *) v3d_submit_add_job(&submit, V3D_TFU);
>  	if (IS_ERR(job)) {
>  		ret =3D PTR_ERR(job);
[ ... ]
> @@ -1234,6 +1250,12 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void =
*data,
>  		}
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but the same resource leak when
v3d_get_extensions() fails also appears here in v3d_submit_csd_ioctl().

> +	if (args->out_sync && !(se.flags & DRM_V3D_EXT_ID_MULTI_SYNC)) {
> +		sync_out =3D drm_syncobj_find(file_priv, args->out_sync);
> +		if (!sync_out)
> +			return -ENOENT;
> +	}
> +
>  	ret =3D v3d_setup_csd_jobs_and_bos(&submit, args, &se);
>  	if (ret)
>  		goto fail;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-v3d-sched-=
misc-fixes-v3-0-d7114bba55a0@igalia.com?part=3D13
