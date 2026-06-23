Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DE6CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4899C10E4B5;
	Tue, 23 Jun 2026 15:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gbtlA49Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D6910E4B5
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 15:48:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE97660209
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 15:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A6C1F00A3A;
 Tue, 23 Jun 2026 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782229688;
 bh=tLuaBkEKBpkQMguFB1R9MS4v78MwAGK4IAlBylyr/6U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gbtlA49Yrnxbaa4LsBqoVpGg/SzzRvpiCsPcdfwhUPQxIcrK1VEOUBOFS+AiC4N2X
 wA0Cx942RTjQVtYH9kj/KBq0kXTiIWy6iSdDJdYmqF+NWNi1RZK4b4vIU6ClNM9K9n
 POY8zMCwyT9DzJlqoV4XB0qOtiEX2qGW/SrNABuCPJaHt3T4YKPbM+yYSDKDvLCz2f
 8HLwIkO7E2eqGni1mKoIc4w7WVgaVnuKSo6ArZXU3PF3honIz8G3J70s2YCSj7h43s
 nhH13UEt8ScvRiEiA9VpWqbyRPLUIbqGZ1/w4/0uqbrWaw7o6UgZf8/Vowe7AqTPuR
 tLiNGMlAqTqfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf/dma-fence: Set better string for
 dma_fence_driver_name()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623133457.1029880-2-phasta@kernel.org>
References: <20260623133457.1029880-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 15:48:07 +0000
Message-Id: <20260623154807.C0A6C1F00A3A@smtp.kernel.org>
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
- [Critical] ABI breakage in UAPI `sync_fence_info` and severe string trunc=
ation.

Pre-existing issues:
- [Critical] Potential NULL pointer dereference due to unordered reads of `=
fence->ops` and `fence->flags`.
--

commit 2d4e0eac87d76c56e73514e9ac37b9db142b0e4f
Author: Philipp Stanner <phasta@kernel.org>

dma-buf/dma-fence: Set better string for dma_fence_driver_name()

Rename the "detached-driver" string returned by dma_fence_driver_name()
to something more descriptive for signaled fences.

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index b3bfa6943a8e1..4a326d2ba7d19 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1171,7 +1171,7 @@ const char __rcu *dma_fence_driver_name(struct dma_=
fence *fence)
>  	if (!dma_fence_test_signaled_flag(fence))
>  		return (const char __rcu *)ops->get_driver_name(fence);

[Severity: Critical]
This is a pre-existing issue, but could this cause a NULL pointer dereferen=
ce?

In dma_fence_driver_name(), fence->ops and fence->flags are read
independently without an smp_rmb() memory barrier. If the CPU reads
fence->flags as unsignaled first, and concurrently another CPU signals the
fence, dma_fence_signal_timestamp_locked() can set fence->flags to signaled
and then set fence->ops to NULL (for fences lacking .release and .wait ops,
such as virtgpu_fence or v3d_fence).

The reader CPU might then read fence->ops as NULL, take the if branch (using
the cached flags=3D0), and crash on ops->get_driver_name(fence).

>  	else
> -		return (const char __rcu *)"detached-driver";
> +		return (const char __rcu *)"driver-whose-fence-is-signaled";

[Severity: Critical]
Does this break the userspace ABI and cause string truncation?

The driver_name field in struct sync_fence_info is exposed to userspace via
the SYNC_IOC_FILE_INFO ioctl. Changing this string from "detached-driver" to
"driver-whose-fence-is-signaled" breaks userspace tools that rely on the
established string to identify decoupled fences.

Also, this formats the UAPI sync_file name into a 32-byte buffer in
sync_file_get_name():

drivers/dma-buf/sync_file.c:sync_file_get_name() {
    ...
	snprintf(buf, len, "%s-%s%llu-%lld",
			 rcu_dereference(driver),
			 rcu_dereference(timeline),
			 fence->context,
			 fence->seqno);
    ...
}

The new 30-character driver name consumes almost the entire 32-byte buffer,
which truncates the timeline name and all subsequent fence metadata.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623133457.1029=
880-2-phasta@kernel.org?part=3D1
