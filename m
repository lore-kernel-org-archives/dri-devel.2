Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA77CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A7B10EAE2;
	Fri, 12 Jun 2026 17:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EISqL4Dk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F2A10EAA4
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 17:01:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1DCB260008;
 Fri, 12 Jun 2026 17:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED001F000E9;
 Fri, 12 Jun 2026 17:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781283689;
 bh=Sck3LThsSIr+171jgbzLZAZgH1+y4HbpYmn7nUQN93s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EISqL4DkFdbPyWRxx2GpCQvcfpqEFVsxr1IW6Pf3ousb+rw6kp2lnuY5XWaWpOLJv
 iEU86tfAr+YmA71+28ahOwMjeHUeIn6faRaH+yUYddSPn7YOPJTnlTPveIOjO4jci4
 zvMWP9LRG0RZB6M0e6+yTAEtWrKY6zBP+VTE8teQKELd95ibazDgnlR6dN+m2oZmEv
 IZ/tREWFoCXlgUmH3i9gHVYwO7twFDxtenX56NdRVmLbhk7TsjWo62leHVCu5r00HO
 LqK8e0O5jMSqEFJzk40xpU9ys7qPZiMP1UjlZgQXBW/KHRM1VHAS4qaa39+vbiiIKE
 5RrNaSzU36FDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau: Simplify nouveau_cli_work
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
References: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 17:01:28 +0000
Message-Id: <20260612170129.AED001F000E9@smtp.kernel.org>
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
- [Critical] The patch introduces a use-after-free vulnerability by reading=
 `work->fence` after calling `work->func(work)`, which frees the `work` str=
ucture.
--

commit 5f500d0384ad49806cf724c1cd7f76a580d6bc42
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/nouveau: Simplify nouveau_cli_work

This patch simplifies the nouveau_cli_work function by removing the
nouveau_cli_work_ready wrapper. As part of this cleanup, the
dma_fence_put() call is moved to execute after the work callback
has been invoked.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index e16f59b00f6fa..a3e38a30fbdab 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -176,9 +160,10 @@ nouveau_cli_work(struct work_struct *w)
>  	struct nouveau_cli_work *work, *wtmp;
>  	mutex_lock(&cli->lock);
>  	list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
> -		if (!work->fence || nouveau_cli_work_ready(work->fence)) {
> +		if (!work->fence || dma_fence_is_signaled(work->fence)) {
>  			list_del(&work->head);
>  			work->func(work);
> +			dma_fence_put(work->fence);

[Severity: Critical]
Does moving dma_fence_put() after work->func() introduce a use-after-free
here?

Looking at the callback implementation in nouveau_gem_object_delete_work()
(in drivers/gpu/drm/nouveau/nouveau_gem.c), the work structure is freed:

nouveau_gem_object_delete_work(...)
{
	...
	nouveau_gem_object_delete(work->vma);
	kfree(work);
}

If the callback frees the work structure, accessing work->fence immediately
afterwards in dma_fence_put() would read from freed memory.

>  		}
>  	}
>  	mutex_unlock(&cli->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612165409.5444=
7-1-tvrtko.ursulin@igalia.com?part=3D1
