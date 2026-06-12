Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0109FCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E57B10F5E3;
	Fri, 12 Jun 2026 17:33:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TUt+o4EC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECF510F5E3
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 17:33:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59E8444023;
 Fri, 12 Jun 2026 17:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194231F000E9;
 Fri, 12 Jun 2026 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781285631;
 bh=Qt7E2GmDIq0hWhiUIVxdtwvvVDD7jzeEtqy6KcNj1ZU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TUt+o4ECJHFtuEnAuAp0PcZXT6JtgygyQriylSjiQUqeA2p5Zee6vQD7blG8/zjWt
 aXcWsyMHPSlazl2IpbZyWFase3zxswvdcZgjf4qIsm8J+e406EIlfsndoi3dFZ2Agy
 YxhqXm1yAIpslCFoVk2hoDTFdaVd2yPECxCBMuArBUW1Jgksrqp9gP7MRvvXfxx3Ba
 5OLizt+t3cqGFfiJY/Ieq2J04jxIVSNV5zgqrO1f5GRRq7dxTxvpACZZSw2JaX+stB
 ZQzJ+FWXxPtlS7SrSbGf9dzyUPPkmu+25R6wD77Wto63A7cesmmSQqXBKaDhJlZqUl
 X2MDcVDHz5M6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/nouveau: Simplify nouveau_cli_work
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612172227.54893-1-tvrtko.ursulin@igalia.com>
References: <20260612172227.54893-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 17:33:50 +0000
Message-Id: <20260612173351.194231F000E9@smtp.kernel.org>
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
- [Critical] Replacing the locked fence check (`nouveau_cli_work_ready`) wi=
th the lockless `dma_fence_is_signaled()` removes critical synchronization =
with `dma_fence_signal()`, introducing a race condition that leads to a Use=
-After-Free of `struct nouveau_cli_work`.
--

commit f14e589461298a55cf7c0a8d50dd778a913dd4fb
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/nouveau: Simplify nouveau_cli_work

This commit simplifies nouveau_cli_work by removing the
nouveau_cli_work_ready helper and replacing it with a direct call to
dma_fence_is_signaled. It also changes the fence reference release to happen
after the work callback is invoked.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index e16f59b00f6fa..a6432eede6137 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -176,9 +160,12 @@ nouveau_cli_work(struct work_struct *w)
>  	struct nouveau_cli_work *work, *wtmp;
>  	mutex_lock(&cli->lock);
>  	list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
> -		if (!work->fence || nouveau_cli_work_ready(work->fence)) {
> +		struct dma_fence *fence =3D work->fence;
> +
> +		if (!fence || dma_fence_is_signaled(fence)) {

[Severity: Critical]
Can this lockless check introduce a race condition leading to a
use-after-free of the work structure?

The original nouveau_cli_work_ready() acquired the fence spinlock before
checking if the fence was signaled, synchronizing with dma_fence_signal().

By using the lockless dma_fence_is_signaled(), this code can observe the
signaled bit while dma_fence_signal() is still iterating over its local
callback list.

If work->func(work) then deallocates the work structure (for instance, via
kfree in nouveau_gem_object_delete_work()), could the signaling CPU
subsequently trigger a use-after-free when it invokes the callback
(nouveau_cli_work_fence)?

>  			list_del(&work->head);
>  			work->func(work);
> +			dma_fence_put(fence);
>  		}
>  	}
>  	mutex_unlock(&cli->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612172227.5489=
3-1-tvrtko.ursulin@igalia.com?part=3D1
