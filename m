Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D99CD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 09:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D9710E9B7;
	Sun,  7 Jun 2026 09:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XyDyyFe7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8C310E9B7
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 09:11:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B3C36001D;
 Sun,  7 Jun 2026 09:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5711F00893;
 Sun,  7 Jun 2026 09:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780823500;
 bh=YrSgIj4Fu40JCX6Zn6JwmmP841Ewi40eAMatauAxoPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XyDyyFe7MKK5xIuSGqHKuoffF396jy76+uCNzye51N0+rEFS2i3hc8y/ncEAdzW1Z
 h63+Wlrm//FMuBpCZWmVumLfsNzc7+GMWS2deELhOrBV6hkpd7XCtfV/jokIYTMGqP
 ujgrsOR9IRfRuRO/CLkDl1+zh+KGIn9/51uZ5xz8JU94VTzEAvh/qMKDzZFGDb/p/4
 bcS+cpvnJ/pN6o9g9263bl8BhJ/AI0l7DKwWV9SGLXilxJ6vDZ6/A5vZNHcEU667aF
 H9Zpr67Mzb7V+ohwD10THEUJ9WeZoTb0A2ZEWyx4cHUsgW86pQqlRpnjDpmslyP+/P
 XRgAWNdrFP3CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: fix dma_fence refcount leak on error in
 virtio_gpu_dma_fence_wait()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260607090303.92423-1-vulab@iscas.ac.cn>
References: <20260607090303.92423-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 09:11:39 +0000
Message-Id: <20260607091140.1D5711F00893@smtp.kernel.org>
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
- [High] Pre-existing memory leak of dma_fence objects in amdgpu_userq_wait=
_return_fence_info() and incorrect commit message claim.
--

commit 6bf96bb80013304553369c4d2d1884cc3193c908
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/virtio: fix dma_fence refcount leak on error in virtio_gpu_dma_fence_wa=
it()

This commit fixes a dma_fence reference count leak in the virtio DRM driver.
It adds a dma_fence_put() before returning early from a
dma_fence_unwrap_for_each() loop in virtio_gpu_dma_fence_wait().

Cc: stable@vger.kernel.org
Fixes: eba57fb5498f ("drm/virtio: Wait for each dma-fence of in-fence array=
 individually")

> dma_fence_unwrap_for_each() internally calls dma_fence_unwrap_first()
> which does cursor->chain =3D dma_fence_get(head), taking an extra
> reference. On normal loop completion, dma_fence_unwrap_next()
> releases this via dma_fence_chain_walk() -> dma_fence_put().
>=20
> When virtio_gpu_do_fence_wait() fails and the function returns early
> from inside the loop, the cursor->chain reference is never released.
> This is the only caller in the entire kernel that does an early return
> inside dma_fence_unwrap_for_each.

[Severity: High]
This isn't a bug introduced by this patch, but is this statement in the
commit message accurate?

Looking at amdgpu_userq_wait_return_fence_info() in
drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c, there appears to be another
instance of an early return from dma_fence_unwrap_for_each() without
releasing the internal iterator reference:

amdgpu_userq_wait_return_fence_info() {
    ...
    dma_fence_unwrap_for_each(f, &iter, fence) {
        r =3D amdgpu_userq_wait_add_fence(wait_info, fences, &num_fences, f=
);
        if (r) {
            dma_fence_put(fence);
            goto free_fences;
        }
    }
    ...
}

If amdgpu_userq_wait_add_fence() fails (for example, returning -ERESTARTSYS
due to a signal), it exits early via the free_fences label. Does this path
also leak the iter.chain reference similar to the virtio bug being fixed
here?

Since userspace might be able to trigger this intentionally (e.g., by
providing a mismatching num_fences and sending a signal to interrupt the
wait), should the commit message be updated, and the AMD bug addressed as
well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607090303.9242=
3-1-vulab@iscas.ac.cn?part=3D1
