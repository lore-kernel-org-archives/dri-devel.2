Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87470CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FE210EAD6;
	Fri, 12 Jun 2026 17:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WR2uZbkx";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80DD10EAD6
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 17:14:36 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gcR2d6zdDz9ss3;
 Fri, 12 Jun 2026 19:14:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781284474; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ruCg0zsQ+pCKVkr4bRPKkDiLDN0obctnod88Z+YlYn8=;
 b=WR2uZbkxFXNTQ5s9l1pPa8qMlCDVVg94t1se20DO12nqG0/HRu6L0UTxIx2EwJM0Bg6oyv
 BqZXRpuLOZDP5zxD6KSfapjMpRYhMuMKVI+SrmB+BM5+lB0GUccUzccsad/mTRIJl8rwMr
 Z9WQKQp+kRDc7OgdK1C5tnufIQu3U8rBbxcvKh8JMr3V/i1U2PwTK2h1hI8ALJvVxyVrds
 wbUt4L94hA2V+LcXsK5d7Lv3aWcXlu5bsuXWR/zpHllqeNcoA49rFzZdnidMsPMCDRIIUt
 mwgiy+6WOlwX+GrG7t4hEXo/HSKBRowx+X4VIZSUJrgB69zYutdApCbcbG+Wgg==
Message-ID: <6f929f2e1c55f7945b41593eea44f28d3b93abf7.camel@mailbox.org>
Subject: Re: [PATCH] drm/nouveau: Simplify nouveau_cli_work
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Philipp Stanner <phasta@kernel.org>, Lyude Paul
 <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 nouveau@lists.freedesktop.org
Date: Fri, 12 Jun 2026 19:14:30 +0200
In-Reply-To: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
References: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: ad8d6e7c345bf1c729e
X-MBO-RS-META: bi8rza9rr5zqmq43ai6k75juckspsmkf
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, 2026-06-12 at 17:54 +0100, Tvrtko Ursulin wrote:
> I don't claim this fixes anything but the code certainly was a bit
> roundabout and this at least cleans it up.
>=20
> The only semantic difference is releasing the fence reference after
> the work callback is called. Which kind of make sense anyway.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: nouveau@lists.freedesktop.org
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drm.c | 19 ++-----------------
> =C2=A01 file changed, 2 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 42a81166f3a9..7de174537fc7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -153,22 +153,6 @@ nouveau_name(struct drm_device *dev)
> =C2=A0		return nouveau_platform_name(to_platform_device(dev->dev));
> =C2=A0}
> =C2=A0
> -static inline bool
> -nouveau_cli_work_ready(struct dma_fence *fence)
> -{
> -	unsigned long flags;
> -	bool ret =3D true;
> -
> -	dma_fence_lock_irqsave(fence, flags);
> -	if (!dma_fence_is_signaled_locked(fence))
> -		ret =3D false;
> -	dma_fence_unlock_irqrestore(fence, flags);
> -
> -	if (ret =3D=3D true)
> -		dma_fence_put(fence);
> -	return ret;
> -}
> -
> =C2=A0static void
> =C2=A0nouveau_cli_work(struct work_struct *w)
> =C2=A0{
> @@ -176,9 +160,10 @@ nouveau_cli_work(struct work_struct *w)
> =C2=A0	struct nouveau_cli_work *work, *wtmp;
> =C2=A0	mutex_lock(&cli->lock);
> =C2=A0	list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
> -		if (!work->fence || nouveau_cli_work_ready(work->fence)) {
> +		if (!work->fence || dma_fence_is_signaled(work->fence)) {
> =C2=A0			list_del(&work->head);
> =C2=A0			work->func(work);
> +			dma_fence_put(work->fence);

Dave had addressed a UAF with that patch.

So if this would fix it, then the claim would be that work->func(work)
was the user of that fence, and not some other party elsewhere.

I don't know whether that's the case.


P.

> =C2=A0		}
> =C2=A0	}
> =C2=A0	mutex_unlock(&cli->lock);
