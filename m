Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC2BC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176EE10E313;
	Tue, 21 Jul 2026 08:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OcTJdY0t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AF810E313
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:43:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 049AD4322F;
 Tue, 21 Jul 2026 08:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06541F00A3A;
 Tue, 21 Jul 2026 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784623437;
 bh=VzCdjtx8altAk5e7BQbTItUKnprqOHMnuj84DFtaUXQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OcTJdY0tSgwBPShcmwYT5VRGX6Ij5BPbxn0FabKbiaeKqHr7IpH+Xf/cXlMskBqOq
 z7xZ8gVZ8CpMRf0ZDg+kV1IHs5XZK15jXsd31IUrdr2VEQkPPPq/UW0tu6L+YxXauu
 1l7p3d8jPz2UQ+KkP3ZTNU33KH43KfgZEN9Dba2rz0pPXjYjERssUPoOBzTsoNCcM2
 T47KSbkm6elX5oXarPYHn+3c9kY1jMS3co5FyzGC9SqbNz0vLKsj7svUnFx5G8QAee
 3Hbw9RptBu2mKAvGubBROwPya5tL7+oxmD/lSHYCNKxtePiVGXGTqGRy0yy/4H/8wU
 oSM+nIuLnesLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
To: =?utf-8?b?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
 <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:43:57 +0000
Message-Id: <20260721084357.B06541F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] The patch fails to address a critical use-after-free of `crtc->fen=
ce_lock` because `synchronize_rcu()` does not protect external spinlocks.
- [High] The synchronize_rcu() fix violates the RCU-001 'Remove Before Recl=
aim' rule, failing to prevent UAF of the CRTC when new readers query the fe=
nce.
--

--- Patch [1]: [PATCH v3 1/2] drm/drm_crtc: ensure dma_fence_ops remain val=
id during device unbind ---
commit 31b9417fd75463986e2e186faa6c672078a471fd
Author: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind
   =20
This commit adds a synchronize_rcu() call to drm_crtc_cleanup() before remo=
ving
the CRTC from the DRM mode setting core. This is intended to wait for an RCU
grace period to ensure that dma_fence_ops can safely dereference crtc->dev
if userspace queries a sync_file concurrently with device hot-unplug.

Link: https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix2-v1-1-c03e=
77b36f34@linaro.org?part=3D1

> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 63ead8ba67564..e8e80c9368529 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -493,14 +493,23 @@ EXPORT_SYMBOL(__drmm_crtc_alloc_with_planes);
[ ... ]
>  void drm_crtc_cleanup(struct drm_crtc *crtc)
>  {
>  	struct drm_device *dev =3D crtc->dev;
> =20
> +	/* Ensure our dma_fence_ops remain valid for an RCU grace period after
> +	 * the fence is signaled. This is necessary because our dma_fence_ops
> +	 * dereference crtc->dev.
> +	 */
> +	synchronize_rcu();

[Severity: High]
This is a pre-existing issue, but does this actually protect the
crtc->fence_lock?

In drm_crtc_create_fence(), the dma_fence is initialized with a pointer to
the CRTC's embedded spinlock:

drivers/gpu/drm/drm_crtc.c:drm_crtc_create_fence() {
    ...
    dma_fence_init(fence, &drm_crtc_fence_ops, &crtc->fence_lock,
                   crtc->fence_context, ++crtc->fence_seqno);
    ...
}

Because the dma_fence does not hold a reference to the CRTC, the fence can
outlive the CRTC.

The synchronize_rcu() call added here provides no protection for the direct
spinlock acquisition in the dma_fence API.

If userspace calls ioctl(SYNC_IOC_FILE_INFO) after the CRTC is freed, the
kernel calls dma_fence_get_status(), which executes spin_lock_irqsave() on =
the
fence's external lock (pointing to the freed crtc->fence_lock).

Can this still lead to a use-after-free of the crtc->fence_lock?


[Severity: High]
This isn't a bug introduced by this patch, but does calling synchronize_rcu=
()
here violate the RCU "Remove Before Reclaim" rule?

Because the fence is exposed to userspace via sync_file, it is not removed
from RCU-accessible paths before synchronize_rcu() is called.

synchronize_rcu() only waits for existing readers.

New userspace calls to ioctl(SYNC_IOC_FILE_INFO) after the CRTC is destroyed
will start a new rcu_read_lock(), call ops->get_driver_name(), cast the
fence to the freed CRTC, and dereference crtc->dev.

Does this leave the CRTC structure vulnerable to a use-after-free when new
readers query the fence?

> +
>  	/* Note that the crtc_list is considered to be static; should we
>  	 * remove the drm_crtc at runtime we would have to decrement all
>  	 * the indices on the drm_crtc after us in the crtc_list.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-linux-drm_=
crtc_fix2-v3-0-afa8c71506e6@linaro.org?part=3D1
