Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BEDC5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F9C10E028;
	Tue, 18 Aug 2026 11:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D3uaNTsZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AECE910E028
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 11:40:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 02E87601DE;
 Tue, 18 Aug 2026 11:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8306A1F000E9;
 Tue, 18 Aug 2026 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787053212;
 bh=ZYuPmKrdp0nGtkJjKCXFcO2AvDPayHncl7UZINcYT/E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D3uaNTsZt4CPkRnIKQ1dtiyfQSiHXxaRadbR7aaWZShDPy0GVwwk2y41b7YcK5JF9
 dJ+NN5T5THaqVjTaM1k6rLZLv10SyVJFj+FWLov25HXFx2SydRZe2CwEQUDB2QPoL8
 f2IqVlZVa85b3bcvF+/EvgRw9WaAiVGT8NIO/8EK6K+7BZLj0KKrBxIBhvlnWHiqij
 RHQXaXWbHS7EHeL2x1eA+TIeBLfcTZdzIE36wgW3EstXVlZL1rnc07fTn50RP+CZHA
 3mNMIu6HpTf1Ly0pJ5VpoOJsAs3EEw1OaCURoFL1o3P39pTRe8etZ/PoT1MXwVI0Yu
 8TDk7yVghlfVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: Fix possible memory allocation failure
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818113256.27848-1-triet.hoang.dev@gmail.com>
References: <20260818113256.27848-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 11:40:12 +0000
Message-Id: <20260818114012.8306A1F000E9@smtp.kernel.org>
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
- [High] Adding __GFP_NOFAIL to a GFP_ATOMIC allocation is invalid and trig=
gers a kernel warning

Pre-existing issues:
- [High] NULL pointer dereference remains unfixed and slab allocation in pa=
nic handler is fundamentally unsafe
--

--- Patch [1]: [PATCH] drm/virtio: Fix possible memory allocation failure -=
--
commit 2b29d148bc8be5eb73791a39e29cb1b504f8f37b
Author: Triet Hoang <triet.hoang.dev@gmail.com>

drm/virtio: Fix possible memory allocation failure

This patch attempts to fix a possible NULL pointer dereference in
virtio_gpu_panic_get_vbuf() by adding the __GFP_NOFAIL flag to the
kmem_cache_zalloc() call instead of checking the return value.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index 905b1f42cd983..be051ac4bd78c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -93,7 +93,7 @@ virtio_gpu_panic_get_vbuf(struct virtio_gpu_device *vgd=
ev, int size)
>  {
>  	struct virtio_gpu_vbuffer *vbuf;
> =20
> -	vbuf =3D kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC);
> +	vbuf =3D kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC | __GFP_NOFAIL);

[Severity: High]
Does this combination of flags work as intended? The page allocator explici=
tly
prohibits combining __GFP_NOFAIL with non-blocking flags like GFP_ATOMIC.

The allocator's slow path checks for !can_direct_reclaim (which is true for
GFP_ATOMIC), emits a WARN_ON_ONCE_GFP, and jumps to the failure path. This
returns NULL anyway, failing to guarantee allocation success while introduc=
ing
a new warning during a system panic.

> =20
>  	vbuf->buf =3D (void *)vbuf + sizeof(*vbuf);

[Severity: High]
This isn't a bug introduced by this patch, but since the allocator ignores
__GFP_NOFAIL for atomic allocations, can kmem_cache_zalloc() still return N=
ULL
here?

If it does, this will dereference NULL and cause a double fault, breaking
the panic handler.

Additionally, is it safe to call kmem_cache_zalloc() during a kernel panic?
If a stopped CPU was holding a slab lock, wouldn't the panicking CPU spin
forever attempting to acquire it, resulting in a hard system hang?

>  	vbuf->size =3D size;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818113256.2784=
8-1-triet.hoang.dev@gmail.com?part=3D1
