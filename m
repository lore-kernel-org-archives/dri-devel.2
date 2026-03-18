Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480BC103E16D
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF5610E75A;
	Wed, 18 Mar 2026 12:25:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="HFeKZjHX";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB6D10E75A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 12:25:40 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-48553fdd03dso39738715e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773836739; x=1774441539;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=UlJezP5+/1fujrnKlE3SL7R1CpkwMMIibiFc+CCvrMk=;
 b=HFeKZjHXmdpTkBIv88f8XcB3xG70niqBXfLrOLupuHHEwDu3bXm3HUi+uL5k+H20kC
 r9FTrihbw8JGLuBFnDBWsLWtb5uGIWFDleDSEXv3UD7mxd9D6pIurSR33oafvDtIR32i
 rDN/IYZDGeOxagEbcufc/jSZcTfsRgb6NEFEi+OOHZ8ogrKOmOHV/2GNm1Gp3EsQuD4Y
 PIAVoA5FfvkcIX7PIq0fOOM40GE10YbZNnEP7x1mAz8eSe47Fvrg0lEYiGdBzmLQ1WsU
 ETw9a5oH5mZbP+ejkV5xNbqiV6z7YhyGk336DI+Lw7U0N14jdLD9fpjHkb2IloV8uBjL
 z61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773836739; x=1774441539;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UlJezP5+/1fujrnKlE3SL7R1CpkwMMIibiFc+CCvrMk=;
 b=C9qEvLqs0/ofJeSZAHHDkMi/oHqgxhwT/N1bWpsT2APP6YmXRO/Jed74/cTiSoImPv
 UsPs9px69jkCuJ4iI8NroezKeOQOi8q0LDCykV+4ZaKZNv+SCCxdjnQNqzLI0W7LN0iZ
 uwXlvIyqlThbQFE8xAiKE51HiGe7EzO9bOqSZKRtda3HmkeMsniOl5NVD0S9c3G55mO8
 tvClmGfaUwbZZPpLEA5v3f21fFeVagtzR5ZK6kA/R5ysCw51KFKzxfFxedBVFgaR2A6s
 rZ39FFGz50wr602Qgp0Fs0CILBhdmWE+5Hgta+Hmv9cO4nv6oP1BCDZorXQ6+ZSt2312
 cemw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAzMe/XLsgnQoyldmy1dv2pqeRrdhYZ3tbwn6EWe2as247rtSbDS9sWU/12zS/ghBX9r3bOP0nOpg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhHfu6bpYM6ZKM/w10I22WoSCs/LCEvUCKx5+tDDoq6FwcP5p0
 UMKKo44aKEmHl5g9aPSDKfRaPfdUWcZUi58XgBgyISQaZNgqIxYiUc7FgWER2VQ2nQJUteb92w6
 f3qU30VaqPDckHNJogA==
X-Received: from wmfu16.prod.google.com ([2002:a05:600c:1390:b0:483:7f25:eadd])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6d97:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-486f4460736mr35691675e9.15.1773836738625; 
 Wed, 18 Mar 2026 05:25:38 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:25:36 +0000
In-Reply-To: <20260317144825.2318-1-christian.koenig@amd.com>
Mime-Version: 1.0
References: <20260317144825.2318-1-christian.koenig@amd.com>
Message-ID: <abqZwCJhPFeu7hAy@google.com>
Subject: Re: [PATCH] dma-buf/dma_fence: be more defensive in dma_fence_release
From: Alice Ryhl <aliceryhl@google.com>
To: "Christian =?utf-8?B?S8O2bmln?=" <ckoenig.leichtzumerken@gmail.com>
Cc: phasta@mailbox.org, boris.brezillon@collabora.com, gary@garyguo.net, 
 lossin@kernel.org, daniel.almeida@collabora.com, joelagnelf@nvidia.com, 
 sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2026 at 03:48:25PM +0100, Christian K=C3=B6nig wrote:
> In case of a refcounting bug dma_fence_release() can be called before the
> fence was even signaled.
>=20
> Previously the dma_fence framework then force signaled the fence to make
> sure to unblock waiters, but that can potentially lead to random memory
> corruption when the DMA operation continues. So be more defensive here an=
d
> pick the lesser evil.
>=20
> Instead of force signaling the fence set an error code on the fence,
> re-initialize the refcount to something large and taint the kernel.
>=20
> This will leak memory and eventually can cause a deadlock when the fence
> is never signaled, but at least we won't run into an use after free or
> random memory corruption.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/dma-buf/dma-fence.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 1826ba73094c..8bf07685a053 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -593,14 +593,24 @@ void dma_fence_release(struct kref *kref)
>  		/*
>  		 * Failed to signal before release, likely a refcounting issue.
>  		 *
> -		 * This should never happen, but if it does make sure that we
> -		 * don't leave chains dangling. We set the error flag first
> -		 * so that the callbacks know this signal is due to an error.
> +		 * This should never happen, but if try to be defensive and take
> +		 * the lesser evil. Initialize the refcount to something large,
> +		 * but not so large that it can overflow.
> +		 *
> +		 * That will leak memory and could deadlock if the fence never
> +		 * signals, but at least it doesn't cause an use after free or
> +		 * random memory corruption.
> +		 *
> +		 * Also taint the kernel to note that it is rather unreliable to
> +		 * continue.
>  		 */
>  		dma_fence_lock_irqsave(fence, flags);
>  		fence->error =3D -EDEADLK;
> -		dma_fence_signal_locked(fence);
> +		refcount_set(&fence->refcount.refcount, INT_MAX);

It's much better to leave the refcount with a value of zero here. That
way, when the refcount is decremented next time, the usual underflow
detection checks will trigger.

You can still skip the kfree() to avoid use-after-free.

Alice
