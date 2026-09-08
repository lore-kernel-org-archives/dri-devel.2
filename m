Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A72C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C1610EC9E;
	Tue,  8 Sep 2026 15:38:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FBA10EC9E
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:38:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 332874013E;
 Tue,  8 Sep 2026 15:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A621F00A3A;
 Tue,  8 Sep 2026 15:38:38 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] drm/msm: serialise framebuffer pin state
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-fd-kms-fix-smmu-v2-1-9391815742a8@oss.qualcomm.com>
References: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
 <20260908-fd-kms-fix-smmu-v2-1-9391815742a8@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:38:08 +0000
Message-Id: <20260908153839.00A621F00A3A@smtp.kernel.org>
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
- [High] Initialization order vulnerability: mutex and refcount initialized=
 after object is globally visible.
--

commit 43edb96a02a3e020c9ba63b15f602a74d5eb759f
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: serialise framebuffer pin state

This commit introduces a mutex to serialize framebuffer pin states,=20
resolving an issue where parallel prepare and cleanup callbacks could=20
leave a plane programmed with a NULL base address.

> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c

[ ... ]

> @@ -206,6 +227,7 @@ msm_framebuffer_init(struct drm_device *dev, const st=
ruct drm_format_info *info,
>  	}
> =20
>  	refcount_set(&msm_fb->dirtyfb, 1);
> +	mutex_init(&msm_fb->lock);

[Severity: High]
Since drm_framebuffer_init() is called just before this block and registers
the object in the DRM core IDR, the framebuffer becomes immediately visible
to userspace.

If userspace guesses the assigned framebuffer ID and concurrently issues an
atomic commit ioctl, could msm_framebuffer_prepare() execute and call
mutex_lock(&msm_fb->lock) before mutex_init() finishes here?

Could this race lead to memory corruption or deadlocks by clobbering the
mutex state? Would it be safer to move the mutex initialization to before
the drm_framebuffer_init() call?

> =20
>  	drm_dbg_state(dev, "create: FB ID: %d (%p)\n", fb->base.id, fb);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-fd-kms-fix=
-smmu-v2-0-9391815742a8@oss.qualcomm.com?part=3D1
