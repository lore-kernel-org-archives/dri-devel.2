Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F114CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93BAA10E2EA;
	Thu, 25 Jun 2026 07:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OApV5S20";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6157D10E2EA
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:55:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D2CF60217;
 Thu, 25 Jun 2026 07:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F78D1F000E9;
 Thu, 25 Jun 2026 07:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782374101;
 bh=IsOdfGjEiKYpCqseWSIZJ8PnIMuZrIsYN/NBNIU13fQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OApV5S20fFX5lH0aFUpcMTaiaLG3jpBCmlHKwdxasWgwXQBI/I8dZZXDn0oBYRdA4
 1HLRjnkPusWF0wFJ56OtsPFZZVH1C+oJC90/E8CoBXPT4iqMDcDUWrOzwWZPFZA/b9
 xnzjLpAT2OWVfwBuc6jydgieT1Xk7xbxXp9spZwTT5hBki2eyicmW3JbMqe5UKNB82
 QJpKdLJbGjX7dM55S4AsR0zo38bWNqPcp6KVaf8+YKAeShuaW/2Uf+zdiGRPXtv6CY
 quLu5+YYzyTxrA5sp8u9cNVmbqt62AzGcL9oQjbxtR3efUd5ygcO1ED0tgS823eiZP
 xbVPsGY77V/ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/14] drm/panthor: Keep interrupts masked until they
 are needed
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-signal-from-irq-v4-5-3d2908912afa@collabora.com>
References: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
 <20260625-panthor-signal-from-irq-v4-5-3d2908912afa@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 07:55:00 +0000
Message-Id: <20260625075501.3F78D1F000E9@smtp.kernel.org>
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
- [Medium] The IRQ wrapper state is not initialized to `PANTHOR_IRQ_STATE_S=
USPENDED`, leaving it in the default `ACTIVE` state. This causes `enable_ev=
ents()` to unmask interrupts prematurely before `resume()` can clear stale =
ones.
--

commit 754138730784c4ebe35e99c7164a0f3365436bba
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Keep interrupts masked until they are needed

This commit updates the interrupt initialization flow so that Mali
interrupts are not unmasked immediately upon request. It delegates
the responsibility to the callers, requiring them to explicitly invoke
the enable events and resume functions when they are ready to handle
interrupts.

Closes: https://sashiko.dev/#/patchset/20260623-panthor-signal-from-irq-v3-=
0-2ece396f8ee0@collabora.com?part=3D3

> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index 4e4607bca7ccd..6c07e7366a331 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -584,14 +584,14 @@ static inline void panthor_ ## __name ## _irq_resum=
e(struct panthor_irq *pirq)
>  												\
>  static int panthor_request_ ## __name ## _irq(struct panthor_device *ptd=
ev,			\
>  					      struct panthor_irq *pirq,				\
> -					      int irq, u32 mask, void __iomem *iomem)		\
> +					      int irq, void __iomem *iomem)			\
>  {												\
>  	pirq->ptdev =3D ptdev;									\
>  	pirq->irq =3D irq;									\
> -	pirq->mask =3D mask;									\
> +	pirq->mask =3D 0;										\
>  	pirq->iomem =3D iomem;									\
>  	spin_lock_init(&pirq->mask_lock);							\
> -	panthor_ ## __name ## _irq_resume(pirq);						\
> +	gpu_write(pirq->iomem, INT_MASK, 0);							\

[Severity: Medium]
Should pirq->state be explicitly initialized to PANTHOR_IRQ_STATE_SUSPENDED
here?

Since struct panthor_irq instances are zero-initialized (e.g. via
drmm_kzalloc), pirq->state defaults to 0, which corresponds to
PANTHOR_IRQ_STATE_ACTIVE.

>  												\
>  	return devm_request_threaded_irq(ptdev->base.dev, irq,					\
>  					 panthor_ ## __name ## _irq_raw_handler,		\

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pant=
hor/panthor_gpu.c
> index e52c5675981f5..c013d6bf9a599 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -170,11 +170,12 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  		return irq;
> =20
>  	ret =3D panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
> -				      GPU_INTERRUPTS_MASK,
>  				      ptdev->iomem + GPU_INT_BASE);
>  	if (ret)
>  		return ret;
> =20
> +	panthor_gpu_irq_enable_events(&ptdev->gpu->irq, GPU_INTERRUPTS_MASK);
> +	panthor_gpu_irq_resume(&ptdev->gpu->irq);

[Severity: Medium]
Could this sequence prematurely unmask interrupts before they are cleared?

Because the IRQ state defaults to ACTIVE without the immediate resume call
that was removed above, calling panthor_gpu_irq_enable_events() will
immediately write the unmasked values to the INT_MASK register:

panthor_device.h:panthor_irq_enable_events() {
    ...
    if (pirq->state =3D=3D PANTHOR_IRQ_STATE_ACTIVE)
        gpu_write(pirq->iomem, INT_MASK, pirq->mask);
}

This happens before panthor_gpu_irq_resume() can execute its own gpu_write()
to INT_CLEAR. As a result, stale interrupts could fire immediately during
the enable_events() step and be processed by the handler.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-si=
gnal-from-irq-v4-0-3d2908912afa@collabora.com?part=3D5
