Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BE9CDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE3510F2DF;
	Thu, 25 Jun 2026 14:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gkuKsOAt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0188610F2DF
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:27:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D4D0600FC;
 Thu, 25 Jun 2026 14:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80771F000E9;
 Thu, 25 Jun 2026 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782397663;
 bh=tDLyF2AZugFcMLVfqH8vZoRnFWEgEFJcUXOB9lzWuwo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gkuKsOAtv5jaiCV0vNaA1+hgqHUdE8X+AItpNC8GST2IeNC506m4pyyRWKf3aqqSB
 kOLcJAefjoG+R7raNy0RCAk6RKuEp/0dtSJvzmwyYt52oTsPmtcCvJIr3uEwihoB0o
 W3lj15DbScZAencn9WARU8v9aGyRH0NDUrb44Z0y2bcwlGa4OzyqWosSPNsald2x2R
 sqYt0o7G/rJHnST7PjP8a02iN2x38oyuTq9//DypFFpKbufUGjZS3ngPKs55niaalj
 ktU0AUzBZ0C2DWZ4mPL/rn5UX9iJQHTYYDFRqJq+FFzTMghdkWgVjVFVA7et/vfaTB
 rDo15VIQUmP3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-fence: Fix dma_fence_timeline_name() to call
 get_timeline_name()
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625141227.38931-1-shoubaineng@gmail.com>
References: <20260625141227.38931-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 14:27:42 +0000
Message-Id: <20260625142742.C80771F000E9@smtp.kernel.org>
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
- [Critical] Potential NULL pointer dereference in `dma_fence_timeline_name=
()` and `dma_fence_driver_name()` due to a missing `ops` NULL check when th=
e fence is concurrently signaled without a read memory barrier.
--

commit 118120d707b8593d71c08a5c22b1149fdc6d4229
Author: Baineng Shou <shoubaineng@gmail.com>

dma-fence: Fix dma_fence_timeline_name() to call get_timeline_name()

This patch fixes a copy-paste error where dma_fence_timeline_name()
incorrectly invoked get_driver_name() instead of get_timeline_name().

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

[Severity: Critical]
This is a pre-existing issue, but is it possible for ops to be NULL here
due to memory reordering?

If dma_fence_signal_timestamp_locked() runs concurrently, it sets
DMA_FENCE_FLAG_SIGNALED_BIT (which includes a full memory barrier via
test_and_set_bit()) and then sets fence->ops =3D NULL via RCU_INIT_POINTER(=
).

Since rcu_dereference() and test_bit() inside dma_fence_test_signaled_flag()
are independent memory loads without an intervening read memory barrier,
could a reader on weakly-ordered architectures experience reordering?

Reader CPU:
  1. Loads fence->flags -> 0 (sees not signaled)
  2. Loads fence->ops -> NULL (sees new value)
  3. !dma_fence_test_signaled_flag(fence) evaluates to true
  4. ops->get_timeline_name(fence) dereferences NULL

Would adding a NULL check for ops, or an smp_rmb() between the reads,
be necessary to prevent a potential kernel panic if this is reachable via
concurrent ioctls like SYNC_IOC_FILE_INFO?

Does dma_fence_driver_name() also share this same structural vulnerability
when dereferencing ops->get_driver_name?

>  	else
>  		return (const char __rcu *)"signaled-timeline";
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625141227.3893=
1-1-shoubaineng@gmail.com?part=3D1
