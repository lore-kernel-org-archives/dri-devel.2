Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3745C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 02:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D70CB10ED50;
	Thu, 30 Jul 2026 02:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D/yqZ/Lj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD0210ED50
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 02:16:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E000E4138A;
 Thu, 30 Jul 2026 02:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F681F00A3A;
 Thu, 30 Jul 2026 02:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785377773;
 bh=m3Xjp692yeyGa0ROMiJisI9ETepbyGiMChAPRmCpdg4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D/yqZ/LjRzZY/ZBmq7/g8Lls+XOQIBiZilh3+K9i+qwsBxvvFbej7gRBbDfFhRiL3
 Cv8pdAQ1dMfXpqxuBNg1Hr4B7oC1ZWTIhnVUBOz6ucir0AqcC+dsJduCd9pDJwtzDb
 ggsDatX8lwM+5aLOadKxxDD8f9ipxxKggs7bU9F1U17dCwbDOAh/5Lp8FIfqdtrJjr
 hrUX+Dt8qkZn3oaZFKD2RPlBt46uvJ/dFe7JJc50CC4OtbiEvNLigreqIVfTQW6oS6
 ZyGwo2KLJNKXaDzsUf/zD9E+S++kY3zbw7m9GxJuRAYyQ4LY022bBybZfNubYbZksz
 rrmXZppVV4g5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/radeon: restore hardware polling in
 fence_is_signaled to fix performance regression
To: 2564278112@qq.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <tencent_38CA3044B54F14EC7314032134C531AFA807@qq.com>
References: <tencent_38CA3044B54F14EC7314032134C531AFA807@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 02:16:13 +0000
Message-Id: <20260730021613.98F681F00A3A@smtp.kernel.org>
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
- [Critical] Direct unsigned comparison of a 32-bit hardware sequence count=
er against a truncated 64-bit sequence number fails at 32-bit wrap-around b=
oundaries, causing premature fence signaling and memory corruption.
--

--- Patch [1]: [PATCH v2] drm/radeon: restore hardware polling in fence_is_=
signaled to fix performance regression ---
commit 1154eb9bc56012c6d795124dbbebce0cebc1b1fd
Author: Wang Jiang <jiangwang@kylinos.cn>

drm/radeon: restore hardware polling in fence_is_signaled to fix performanc=
e regression

This commit restores hardware polling in radeon_fence_is_signaled() by read=
ing
the hardware fence counter directly. It avoids updating last_seq and calling
wake_up_all(), relying on the interrupt handler for those actions, which
prevents the deadlock that led to the earlier removal of the hardware status
check.

> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/rade=
on/radeon_fence.c
> index 02a40e4750c7d..047ec5a1d194b 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -360,6 +360,18 @@ static bool radeon_fence_is_signaled(struct dma_fenc=
e *f)
>  	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D seq)
>  		return true;
> =20
> +	/*
> +	* Poll hardware directly without updating last_seq.
> +	* This allows immediate detection of signaled fences (performance)
> +	* while leaving last_seq update and wake_up_all() to the interrupt
> +	* handler, avoiding:
> +	* 1. Deadlock from calling wake_up_all() with fence lock held
> +	* 2. Wake event stealing by advancing last_seq without waking waiters
> +	* 3. rw_semaphore usage in atomic/irq context (unsafe on PREEMPT_RT)
> +	*/
> +	if (radeon_fence_read(rdev, ring) >=3D (u32)seq)
> +			return true;

[Severity: Critical]
Will this comparison evaluate incorrectly during a 32-bit wrap-around?

In radeon_fence_is_signaled(), seq is a 64-bit value. If a userspace
application submits enough work to cross a 32-bit boundary, seq could reach=
 a
value like 0x100000005, which truncates to 5 when cast to u32.

If the hardware counter from radeon_fence_read() has not yet wrapped and
returns a value like 0xFFFFFFFA, the direct unsigned comparison evaluates
0xFFFFFFFA >=3D 5 as true.

Could this falsely signal that the fence is complete, leading to a
use-after-free regression if the CPU frees or reuses memory buffers while t=
he
GPU is still actively accessing them?

> +
>  	return false;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_38CA3044B54=
F14EC7314032134C531AFA807@qq.com?part=3D1
