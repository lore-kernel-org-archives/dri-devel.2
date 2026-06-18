Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2CFCD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9017910F2D7;
	Thu, 18 Jun 2026 12:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ad83kTo0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06ED310F292
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:11:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34AAC6012A;
 Thu, 18 Jun 2026 12:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91FB1F000E9;
 Thu, 18 Jun 2026 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781784686;
 bh=6vqc8lPBpSXYHV+g9U7LQTi8DTtsuznqEFWTgrh7bUk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ad83kTo0Qa+HLcpjlSpG0BQ0AUzvjwBTlMfxqLWYjIin/oMK47itxdIp6Y6mzlCYv
 cnnS0kaEYDVyLUo3xPeyeEYDrBN91S9uzkdONKcbuqIMugJNBbadcJverC4BMuilBl
 qivebyOTYCXF2LUcEilgfUzsGenT6QLKQkc0vg3z6JskI2BXgZOgmGgr98C2lf9nxS
 pBWZaahPm5qiZUD5Ut72VY0Ag2zGmumSuT/xNNqwd7FDXzrkGg1Gabkz52Ah1NbWE8
 FHfQRjKk4DGsnobV3i0By+/HZ5n9h6xtagaL5FWyOTN8kVs9jY8pvY3xIH/k5/dZ/L
 kUJaFazG+vJyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-fence: use correct callback in
 dma_fence_timeline_name()
To: =?utf-8?b?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618-linux-drm_crtc_fix-v1-1-801f29c9853d@linaro.org>
References: <20260618-linux-drm_crtc_fix-v1-1-801f29c9853d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 12:11:26 +0000
Message-Id: <20260618121126.B91FB1F000E9@smtp.kernel.org>
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
- [High] Missing NULL check for `ops` after `rcu_dereference()` allows a po=
tential NULL pointer dereference on weakly-ordered CPUs if the fence is con=
currently signaled.
--

commit 0888eeb31d9224a94ad809f7df8b6fc25b78b27a
Author: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

dma-fence: use correct callback in dma_fence_timeline_name()

dma_fence_timeline_name() is a wrapper around
dma_fence_ops::get_timeline_name(). Since the blamed commit below, it
calls an incorrect callback.

Update it to restore functionality by calling the intended callback.

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index b3bfa6943a8e1..5292d714419b1 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1202,7 +1202,7 @@ const char __rcu *dma_fence_timeline_name(struct dm=
a_fence *fence)
>  	/* RCU protection is required for safe access to returned string */
>  	ops =3D rcu_dereference(fence->ops);
>  	if (!dma_fence_test_signaled_flag(fence))
> -		return (const char __rcu *)ops->get_driver_name(fence);
> +		return (const char __rcu *)ops->get_timeline_name(fence);

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing NULL
check for ops here?

Because rcu_dereference() does not provide a read memory barrier against
independent loads, can weakly-ordered CPUs (like ARM64) execute the load of
fence->flags in dma_fence_test_signaled_flag() before the load of fence->op=
s?

If a concurrent writer in dma_fence_signal_timestamp_locked() sets the
signaled bit and then sets fence->ops to NULL, it seems a reader could
observe fence->flags as unsignaled (0) and then subsequently load fence->ops
as NULL.

This could cause the reader to take the true path of the if statement and
dereference a NULL ops pointer:

Reader thread in dma_fence_timeline_name():
    ops =3D rcu_dereference(fence->ops);        // delayed load, gets NULL
    if (!dma_fence_test_signaled_flag(fence)) // loaded early, gets 0
        ops->get_timeline_name(fence);        // oops: ops is NULL

Concurrent writer thread:
dma_fence_signal_timestamp_locked()
    test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
    RCU_INIT_POINTER(fence->ops, NULL);

Since this code path is reachable from userspace via the SYNC_IOC_FILE_INFO
ioctl in sync_file.c, could this allow a local denial of service?

Note that the adjacent dma_fence_driver_name() function seems to suffer from
the exact same pre-existing issue.

>  	else
>  		return (const char __rcu *)"signaled-timeline";
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-linux-drm_=
crtc_fix-v1-1-801f29c9853d@linaro.org?part=3D1
