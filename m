Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D74FC55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2C310E65D;
	Thu, 30 Jul 2026 03:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TuD5e4B6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B6410E647
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:41:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28606600AA;
 Thu, 30 Jul 2026 03:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF9A1F000E9;
 Thu, 30 Jul 2026 03:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785382903;
 bh=3fvoAEDOmmFAzFnIzJiU1mW0E51KEBJ+QFHv2G7nzeI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TuD5e4B6R1akWOoAOb+lUQ5I57wYpz1NbyGlSDr8awvodpyZz/viQcVzgps9gfCDu
 DrsFojDjDPkVKtA/5wtJdQCB3F/yS35vJ081Q5b01NjjQhGeBqHe1QPdisBZh/vWwh
 7IopzwpgdQPBKraDNRqPbNLzL6v20qRYyoruvzrAi4uHg9wK6KB6mXzLsjeQshcPE6
 TdAXx5M79BB8+YbipynpgEUsSTuXVkhzPtIr58Nw1Xz8WlQ5lS2uEKLeRElkY+TeER
 1AQZwso7L8f9mT8vOLFZHh6nLdJdznVS8eb1YbO2DouXk39CUR7GdAf7L878pxMt9n
 KT/rppQSBGJMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/7] drm/bridge: analogix_dp: Extend mute/unmute HPD
 interrupts to accept irq bitmask
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260730032744.381566-4-damon.ding@rock-chips.com>
References: <20260730032744.381566-1-damon.ding@rock-chips.com>
 <20260730032744.381566-4-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:41:43 +0000
Message-Id: <20260730034143.8FF9A1F000E9@smtp.kernel.org>
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
- [High] Selective unmasking combined with unconditional status clearing pe=
rmanently masks concurrently triggered hotplug interrupts, causing lost eve=
nts.
- [High] Accessing DP controller mask registers in mute/unmute functions wh=
en using GPIO HPD causes a bus hang during runtime suspend.
--

--- Patch [3]: [PATCH v1 3/7] drm/bridge: analogix_dp: Extend mute/unmute H=
PD interrupts to accept irq bitmask ---
commit 09d81009e86378eb20f782e0e10f313daaa0f8d2
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Extend mute/unmute HPD interrupts to accept irq bi=
tmask

This commit updates the global HPD interrupt mute/unmute routines to accept
an IRQ bitmask parameter. It passes the bitmask from the hardirq and thread
handlers to selectively mask/unmask flags triggered by the current IRQ even=
t,
preparing for subsequent accurate HPD event handling.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index ccb8a374b40b7..a3dc5eac91b8f 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
[ ... ]
> @@ -734,7 +734,7 @@ static irqreturn_t analogix_dp_irq_thread(int irq, vo=
id *arg)
> =20
>  	if (irq_type) {
>  		analogix_dp_clear_hotplug_interrupts(dp);
> -		analogix_dp_unmute_hpd_interrupt(dp);
> +		analogix_dp_unmute_hpd_interrupt(dp, irq_type);

[Severity: High]
Could this selective unmasking combined with the unconditional status clear=
ing
permanently mask concurrently triggered hotplug interrupts?

Since analogix_dp_irq_thread() samples irq_type earlier via
analogix_dp_get_irq_type(), what happens if a new native hotplug interrupt
(like HOTPLUG_CHG) fires immediately after that read?

The hardirq would preempt the thread, read the updated status, and mask the
new interrupt. When the thread resumes, analogix_dp_clear_hotplug_interrupt=
s()
unconditionally clears all hotplug status bits:

	reg =3D HOTPLUG_CHG | HPD_LOST | PLUG;
	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_4);

destroying the new interrupt's status. Then, this selective
analogix_dp_unmute_hpd_interrupt() call uses the stale irq_type snapshot th=
at
lacks the new interrupt, leaving the newly triggered interrupt permanently
masked in ANALOGIX_DP_COMMON_INT_MASK_4 and lost until a driver reload.

>  	}
> =20
>  	return IRQ_HANDLED;
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index f4f859cb29366..42c1da160ad02 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
[ ... ]
> -void analogix_dp_mute_hpd_interrupt(struct analogix_dp_device *dp)
> +void analogix_dp_mute_hpd_interrupt(struct analogix_dp_device *dp, u32 i=
rq_type)
>  {
> -	u32 reg;
> +	u32 reg, mask =3D 0;
> =20
> -	/* 0: mask, 1: unmask */
> -	reg =3D readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
> -	reg &=3D ~COMMON_INT_MASK_4;
> -	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
> +	if (!irq_type)
> +		return;
> =20
> -	reg =3D readl(dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
> -	reg &=3D ~INT_STA_MASK;
> -	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
> +	if (irq_type & COMMON_INT_4_HPD_IRQ) {
> +		/* 0: mask, 1: unmask */
> +		reg =3D readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);

[Severity: High]
Does this code perform an unprotected MMIO read on the DP controller when
using a GPIO for HPD?

If dp->hpd_gpiod is active, the DP controller might be in runtime suspend
(with power/clocks off) while the GPIO HPD IRQ remains enabled. A cable plug
would trigger the GPIO interrupt, and the call to
analogix_dp_mute_hpd_interrupt() in analogix_dp_hardirq() will attempt to
read the DP controller's mask registers here, potentially causing a bus han=
g.

> +		if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN)
> +			mask |=3D PLUG;
> +		if (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT)
> +			mask |=3D HPD_LOST;
> +		if (irq_type & DP_IRQ_TYPE_HP_CHANGE)
> +			mask |=3D HOTPLUG_CHG;
> +		reg &=3D ~mask;
> +		writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730032744.3815=
66-1-damon.ding@rock-chips.com?part=3D3
