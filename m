Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5603C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB4610F5AF;
	Thu,  3 Sep 2026 13:35:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nazLkow/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF96010F5DF
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:35:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B37176053A;
 Thu,  3 Sep 2026 13:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494BB1F00A3A;
 Thu,  3 Sep 2026 13:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788442534;
 bh=lhZk53bwlEULNSX+vGLyl0b5Dp5TXdrc70qqhDU90UY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nazLkow/qniPmF4HqqKoGnzZIcvrs8ghGHS8u6AwoAJBDX2SXCXcP7kNvtmVv4jOt
 iu5tEgazujuz+m6ifKNhZPFOPTrWmOUJRTRlmd5toRhxMaftFXW7ehwyZZPX6uAx//
 1vI3VuL37/VlK50EILwbZG+54p4UHH966wtAWK3srbN+ez3HeYjp7i+7oCRA/jsqug
 7yRvqBmnRO9Z3i2Ml5HnigLnldYbWRQbtNnYrVXu3aumDuu/nMDzu9e9iwAB6HJnJS
 40R5sABMVs1U5L8+b2tIq4bB1mnZZXK0J+x4rTTIzpKOwkv5WrTt658a/U8TqSvON0
 rgiPXYyRutnww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/msm: fix framebuffer pin refcount leak on
 prepare failure
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903-fd-kms-fix-smmu-v1-1-608d02491666@oss.qualcomm.com>
References: <20260903-fd-kms-fix-smmu-v1-0-608d02491666@oss.qualcomm.com>
 <20260903-fd-kms-fix-smmu-v1-1-608d02491666@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:35:33 +0000
Message-Id: <20260903133534.494BB1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unwinding a failed framebuffer prepare while a concurrent prepare =
exists causes a double-unpin and refcount underflow.

Pre-existing issues:
- [High] Concurrent `msm_framebuffer_prepare` calls for the same framebuffe=
r can race due to lockless `prepare_count`, leading to uninitialized `iova`=
 access and IOMMU faults.
--

commit 4b106914920d42508f14e872754ef791f46ae379
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: fix framebuffer pin refcount leak on prepare failure

This commit addresses a resource leak in msm_framebuffer_prepare() by
unwinding successfully pinned planes and releasing the vma reference when
a subsequent plane fails to pin.

[Severity: High]
This is a pre-existing issue, but can concurrent msm_framebuffer_prepare()
calls for the same framebuffer race due to the lockless prepare_count check?

Looking at msm_framebuffer_prepare() in drivers/gpu/drm/msm/msm_fb.c:

	if (atomic_inc_return(&msm_fb->prepare_count) > 1)
		return 0;

If userspace issues concurrent atomic commits for different CRTCs sharing t=
he
same framebuffer, Thread A could increment prepare_count to 1 and start
pinning planes. Thread B could concurrently increment prepare_count to 2, h=
it
this lockless fast-path, and return success immediately before Thread A has
finished populating the iova array.

Thread B's commit might then proceed to scanout using uninitialized memory
addresses (zeros) for DMA, which could cause an IOMMU unhandled context fau=
lt.

Could msm_framebuffer_cleanup() also race in a similar way?

	if (atomic_dec_return(&msm_fb->prepare_count))
		return;

	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));

This lockless memset could race with a concurrent prepare_fb from Thread A,
overwriting a newly pinned IOVA with zero.

> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> index 60c108d35d2a1..934337202afd4 100644
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c
> @@ -89,11 +89,27 @@ int msm_framebuffer_prepare(struct drm_framebuffer *f=
b, bool needs_dirtyfb)
[ ... ]
>  	return 0;
> +
> +unwind:
> +	while (i--) {
> +		msm_gem_unpin_iova(fb->obj[i], vm);
> +		msm_gem_vma_put(fb->obj[i]);
> +	}
> +
> +	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
> +
> +	atomic_dec(&msm_fb->prepare_count);

[Severity: High]
Does this unwind path create a double-unpin if there is a concurrent
prepare that succeeded via the fast-path?

If Thread A and B enter msm_framebuffer_prepare() concurrently, Thread A
increments prepare_count to 1 and begins pinning. Thread B increments it
to 2 and returns success.

If Thread A encounters an error, it enters this newly added unwind block,
unpins the planes it successfully pinned, and decrements prepare_count from
2 to 1.

When Thread B's commit succeeds and later calls msm_framebuffer_cleanup(),
it will decrement prepare_count from 1 to 0. Since it reaches 0, Thread B
will unconditionally unpin all planes:

drivers/gpu/drm/msm/msm_fb.c:msm_framebuffer_cleanup() {
    ...
	if (atomic_dec_return(&msm_fb->prepare_count))
		return;

	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));

	if (crtc && msm_crtc_queue_fb_unpin(crtc, fb))
		return;

	for (i =3D 0; i < n; i++) {
		msm_gem_unpin_iova(fb->obj[i], vm);
		msm_gem_vma_put(fb->obj[i]);
	}
}

Because Thread A already unpinned the planes it originally pinned, Thread
B's cleanup would result in a double-unpin, causing vma_ref and pin_count
underflows, and potentially a use-after-free of GEM memory.

> +	if (needs_dirtyfb)
> +		refcount_dec(&msm_fb->dirtyfb);
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-fd-kms-fix=
-smmu-v1-0-608d02491666@oss.qualcomm.com?part=3D1
