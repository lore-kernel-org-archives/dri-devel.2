Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF61CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637A910E13C;
	Fri, 26 Jun 2026 10:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VYN3ySkt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990A010E0EB
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 10:16:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62C4543DAC
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 10:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171571F00A3A;
 Fri, 26 Jun 2026 10:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782469007;
 bh=zzRFgl3qWviVcQ4gMTiQ7SFVxIWFQZvCw6YxIyneqR0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VYN3ySktZT4TZJo1umBdytPP8GKvgrIfKRlmu3KOcKaBS96pcG7QlaPkfXsx5ExJ4
 fsyc0yHf6+eN4+XQzOKlfYbx/iceR17KvUF7fIk6HMcAR+CM0uGPrmDwK5YWQvw613
 w37lJsUDi+h5uEYzvhCsFU9Kt/iXQBuG6CjfvWrEKVBIdFqqfZVINy5kUd+B22upyH
 Bjwd60D/1DAF1cNljjjlk3kBgH138ucOpuw5o81sArlU6yv112841Q5w9zrT6LRdkc
 AlQYIYTph7HjNZO4Gt71YB6gAuaRuOMCnaiTNt8+tiyN2NpI9Eypp3ySZQ2u0u8U9w
 PjjdiqiFLbsVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: dma-fence: Fix potential NULL pointer dereference
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626100442.2202221-2-phasta@kernel.org>
References: <20260626100442.2202221-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 10:16:46 +0000
Message-Id: <20260626101647.171571F00A3A@smtp.kernel.org>
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
- [High] TOCTOU race condition in DRM CRTC fence operations triggers a kern=
el panic via BUG_ON.
--

commit 00a837e98e1d45bf6a3df4ddad52336211392885
Author: Philipp Stanner <phasta@kernel.org>

dma-buf: dma-fence: Fix potential NULL pointer dereference

This commit adds memory barriers to the fence signaling and name retrieval
functions. It ensures that the signaled bit is set before the ops pointer
is cleared, and that readers correctly order the ops pointer load before
checking the signaled bit to safely handle decoupled fences.

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index c7ea1e75d38a2..2e80b01499de8 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c

[ ... ]

> @@ -1170,6 +1182,12 @@ const char __rcu *dma_fence_driver_name(struct dma=
_fence *fence)
> =20
>  	/* RCU protection is required for safe access to returned string */
>  	ops =3D rcu_dereference(fence->ops);
> +	/*
> +	 * Fully order the dereference above with the flag check. Otherwise,
> +	 * ops could be dereferenced as a NULL pointer. The barrier's
> +	 * counterpart is in dma_fence_signal_timestamp_locked().
> +	 */
> +	smp_rmb();
>  	if (!dma_fence_test_signaled_flag(fence))
>  		return (const char __rcu *)ops->get_driver_name(fence);

[Severity: High]
This is a pre-existing issue, but can this lead to a kernel panic during
concurrent fence signaling?

If a concurrent thread signals the fence after the flag is checked here,
the ops pointer can be set to NULL. When the callback resolves to
drm_crtc_fence_get_driver_name() in the drm crtc code, it calls
fence_to_crtc(), which re-reads the ops pointer:

drivers/gpu/drm/drm_crtc.c:fence_to_crtc() {
        BUG_ON(rcu_access_pointer(fence->ops) !=3D &drm_crtc_fence_ops);
        return container_of(fence->extern_lock, struct drm_crtc, fence_lock=
);
}

Since the decoupling mechanism can set the ops pointer to NULL, won't this
BUG_ON trigger and crash the system? Do the fence callbacks need to be
updated to avoid re-reading the ops pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626100442.2202=
221-2-phasta@kernel.org?part=3D1
