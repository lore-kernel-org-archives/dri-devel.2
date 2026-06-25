Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEF0CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B15F10E1BB;
	Thu, 25 Jun 2026 07:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lZstRaT0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DBD10E1BB
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:50:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAC55417F8;
 Thu, 25 Jun 2026 07:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCFE1F000E9;
 Thu, 25 Jun 2026 07:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782373833;
 bh=+FItSwNvjJ1rX3xNFeHp42khSzET//DHy71hqSMC//A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lZstRaT03Fg0t7JZByRVpEpf8JSSYEBNlBzKVm9n/ZbQjZJEfR8sxj1udkb400QWs
 +m8+ECrT1cfzzu7tqCfO2ZQVczgbW00f9i0/CNZlVJc6gr/KQeBZf1RAK1KolGjQFR
 s1z+JgW+ICgbB37MtBmnZ0fo7I5Q+M1fYntLfpydw1U7omvRvVb78oOfb51gbhFIbi
 QuFkZSP3Qr+5ImCwL3Hy0J3yJGO5BLqrZyZjt0L8q+MYZrsLMKsLEhcPeUAu7CE/d3
 /dEXSlJl+nN0beAKrrD3qxYhDUrpJY/HUF9As2C3/CalspNtXe0x0jDF4XqXVl++KG
 zQHLBnC2hztCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/14] drm/panthor: Fix panthor_pwr_unplug()
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-signal-from-irq-v4-1-3d2908912afa@collabora.com>
References: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
 <20260625-panthor-signal-from-irq-v4-1-3d2908912afa@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 07:50:33 +0000
Message-Id: <20260625075033.9DCFE1F000E9@smtp.kernel.org>
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
- [High] The `panthor_irq_default_raw_handler` unconditionally reads the `I=
NT_STAT` IOMEM register before checking if the device is active. Since the =
interrupt is registered with the `IRQF_SHARED` flag, this handler can be in=
voked at any time if another device on the same interrupt line fires. If th=
is occurs while the Panthor device is runtime suspended (and its hardware c=
locks are disabled via `panthor_device_suspend`), the IOMEM read will cause=
 an asynchronous bus fault, hanging or crashing the system. The PM state (`=
pirq->state`) must be checked before accessing hardware registers.
--

commit f37bcb93cfbc592cfb8d4142d7fa1a6ef73e4591
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Fix panthor_pwr_unplug()

The commit prevents a hang when accessing the IOMEM region while clocks are
disabled by conditionally calling panthor_pwr_irq_suspend() only if the
device is not suspended.

> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/pant=
hor/panthor_pwr.c
> index 7c7f424a1436d..090362bd700b1 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -453,7 +453,8 @@ void panthor_pwr_unplug(struct panthor_device *ptdev)
>  		return;
> =20
>  	/* Make sure the IRQ handler is not running after that point. */
> -	panthor_pwr_irq_suspend(&ptdev->pwr->irq);
> +	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> +		panthor_pwr_irq_suspend(&ptdev->pwr->irq);

[Severity: High]
This is a pre-existing issue, but since the commit message mentions that
accessing IOMEM while clocks are disabled causes a hang, does
panthor_irq_default_raw_handler() suffer from a similar issue?

Because panthor_irq_request() registers the interrupt with IRQF_SHARED:

	return devm_request_threaded_irq(ptdev->base.dev, irq,
					 panthor_irq_default_raw_handler,
					 threaded_handler,
					 IRQF_SHARED, full_name, pirq);

The raw handler can be invoked at any time if another device on the same
shared interrupt line fires. However, panthor_irq_default_raw_handler()
unconditionally reads the INT_STAT IOMEM register before checking the PM
state:

	if (!gpu_read(pirq->iomem, INT_STAT))
		return IRQ_NONE;

	guard(spinlock_irqsave)(&pirq->lock);
	if (pirq->state !=3D PANTHOR_IRQ_STATE_ACTIVE)
		return IRQ_NONE;

If the shared interrupt fires while the Panthor GPU is in runtime suspend
(and its hardware clocks are disabled), could this unconditional gpu_read()
cause an asynchronous bus fault and hang the system?

> =20
>  	/* Wake-up all waiters. */
>  	spin_lock_irqsave(&ptdev->pwr->reqs_lock, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-si=
gnal-from-irq-v4-0-3d2908912afa@collabora.com?part=3D1
