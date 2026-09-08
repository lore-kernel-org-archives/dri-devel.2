Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50E7C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C545910E866;
	Tue,  8 Sep 2026 08:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XBPz/dWi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E14A10E81A;
 Tue,  8 Sep 2026 08:58:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1787160A9F;
 Tue,  8 Sep 2026 08:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0001F01559;
 Tue,  8 Sep 2026 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788857889;
 bh=Qwy1idKe0eVkDGrI8c810u4x2qkQ6NPxoVFoHtRcEE4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XBPz/dWiQcZZhHZEgKHYx9H3kRbZZsmmrXVfxzF0gqeHcd2k6CzK2vpflrTaRbmD2
 hTg8hO01qWcteHP5+sKgI4GojnWwjTb1AesSYmI3Ib6tYHW978nxo/0Epr3Yh+iIF4
 uitxRYiLAWWyr82Y8x88mOKR6cn9Q+ClNBg1Q9Sj9nPHyKRLDWwt7ip+HlAhzyJ58V
 4b9hh8Npz0pMaNK3SnjefV3GBAVJTyA0RRmcddZKutIrRDne1fwkc934pVxIRULYSQ
 T+NwIXee5BY6aZMDji0IRgpQvmVRukGdWmPYjt75xyp7tioJX5reu8xOCs+OlxGRR4
 Mw3s38PWN7Dmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] drm: Add drm_user_fence helper
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260908084627.352535-3-srinivasan.shanmugam@amd.com>
References: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
 <20260908084627.352535-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 08:58:09 +0000
Message-Id: <20260908085809.8F0001F01559@smtp.kernel.org>
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
- [Low] Unconditional use of mmput_async() breaks compilation and linking o=
n NOMMU configurations.
--

commit 890c55fa04660dfbfe7364ac5c78b52162fca15b
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm: Add drm_user_fence helper

This commit introduces a common DRM user fence helper providing a
kref-managed, MM-borrowing dma-fence-callback-to-workqueue pattern.
It is used by drivers that must access userspace memory from a kthread
context when a GPU fence signals.

> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 8895ca0476d89..3557e6a8d31c9 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -69,6 +69,7 @@ drm-y :=3D \
>  	drm_syncobj.o \
>  	drm_sysfs.o \
>  	drm_trace_points.o \
> +	drm_user_fence.o \
>  	drm_vblank.o \

[ ... ]

> diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_=
fence.c
> new file mode 100644
> index 0000000000000..f7882208a8b73
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_user_fence.c

[ ... ]

> +static void drm_user_fence_do_work(struct drm_work_fence *wfence)
> +{
> +	struct drm_user_fence *ufence =3D
> +		container_of(wfence, struct drm_user_fence, base);
> +	struct mm_struct *mm =3D NULL;
> +
> +	if (mmget_not_zero(ufence->mm)) {
> +		mm =3D ufence->mm;
> +		kthread_use_mm(mm);
> +	}
> +
> +	ufence->ops->writeback(ufence, !!mm);
> +
> +	if (mm) {
> +		kthread_unuse_mm(mm);
> +		mmput_async(mm);	/* requires CONFIG_MMU =E2=80=94 GPU requires MMU */

[Severity: Low]
Does this unconditional call to mmput_async() break the build on systems
without CONFIG_MMU?

While the comment notes that the GPU requires an MMU, the drm_user_fence.o
file is added unconditionally to the core DRM build in
drivers/gpu/drm/Makefile. If the kernel is built with CONFIG_DRM enabled
but CONFIG_MMU disabled, this will result in an implicit function
declaration and an undefined reference to mmput_async() during linking.

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908084627.3525=
35-1-srinivasan.shanmugam@amd.com?part=3D2
