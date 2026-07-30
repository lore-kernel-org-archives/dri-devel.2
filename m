Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126B1C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6732A10E647;
	Thu, 30 Jul 2026 03:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D9+Tcu2R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41BB10E647
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:41:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2833D600AB;
 Thu, 30 Jul 2026 03:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873BB1F00A3A;
 Thu, 30 Jul 2026 03:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785382904;
 bh=FvDG4VhQ+UNwj9URYW40nqtyNfvDXfddZgL/DSFcnDQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D9+Tcu2RBd//4ikKOXngrbcmhQXkov5X//m5nvSR4W0dVYtZsdhKKO5tilf9AHkQt
 etQ5ADfsGSBqewlpsIC8u1TBu5SaNmrKH2OTSGvd04B748uY3CPkJGw9Fxzs9sMgrJ
 qz3qu2pLCAV7s9T/Uck7c6Vyvtn9+q8/+5ik1LSuWp7pgcBn2P2OsKuzG+XcGyzZXF
 EXfzKQCILSnV4dP2NzsPSF1ADWZo4UxJ+EVj40B+/TbX740T3Ww9x3givXoMwya2+Y
 zTq79x64MK3By7uDd/NvpfruTWRHsQVWouJOhK/FjP8PBq9SS54bynV8bplPQYx6Qm
 wGa/cyU4weodg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/7] drm/bridge: analogix_dp: Use platform-specific
 HPD detection scheme
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260730032744.381566-7-damon.ding@rock-chips.com>
References: <20260730032744.381566-1-damon.ding@rock-chips.com>
 <20260730032744.381566-7-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:41:44 +0000
Message-Id: <20260730034144.873BB1F00A3A@smtp.kernel.org>
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
- [High] DisplayPort short HPD pulses are completely filtered out by the 2m=
s hardware deglitch filter, breaking link loss detection and PSR.
- [High] Hotplug interrupt unmasking logic unintentionally re-enables PLUG =
and HPD_LOST interrupts on Rockchip platforms, defeating the patch's purpos=
e.
--

--- Patch [6]: [PATCH v1 6/7] drm/bridge: analogix_dp: Use platform-specifi=
c HPD detection scheme ---
commit af35433f355c1427bbfdea612a689613337f11ab
Author: Damon Ding <damon.ding@rock-chips.com>
Date:   Thu Jul 30 03:27:43 2026 +0000

    drm/bridge: analogix_dp: Use platform-specific HPD detection scheme
   =20
This commit configures the HPD deglitch filter to 2ms on Rockchip platforms=
=20
and updates the interrupt handling to rely exclusively on the HOTPLUG_CHG=20
interrupt instead of the PLUG and HPD_LOST combination. The threaded IRQ=20
handler is also adjusted to evaluate platform-specific interrupt flags.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 9f6ecaa1aeb5e..b7aa10daae2f2 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -723,10 +723,15 @@ static irqreturn_t analogix_dp_irq_thread(int irq, =
void *arg)
>  {
>  	struct analogix_dp_device *dp =3D arg;
>  	u32 irq_type;
> +	bool hpd_detected;
> =20
>  	irq_type =3D analogix_dp_get_irq_type(dp);
> -	if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN ||
> -	    irq_type & DP_IRQ_TYPE_HP_CABLE_OUT) {
> +	if (!dp->hpd_gpiod && analogix_dp_is_rockchip(dp->plat_data->dev_type))
> +		hpd_detected =3D irq_type & DP_IRQ_TYPE_HP_CHANGE;
> +	else
> +		hpd_detected =3D (irq_type & DP_IRQ_TYPE_HP_CABLE_IN) ||
> +			       (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT);
> +	if (hpd_detected) {

[Severity: High]
Could this logic inadvertently re-enable the PLUG and HPD_LOST interrupts
that were intentionally masked during initialization?

When analogix_dp_get_irq_type() is called, it reads the raw interrupt
status register without checking against the active mask:

analogix_dp_get_irq_type() {
    ...
    reg =3D readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_4);
    if (reg & PLUG)
        irq_type |=3D DP_IRQ_TYPE_HP_CABLE_IN;
    if (reg & HPD_LOST)
        irq_type |=3D DP_IRQ_TYPE_HP_CABLE_OUT;
    ...
}

If the hardware continues to set the PLUG and HPD_LOST status bits on cable
events even while they are masked, analogix_dp_get_irq_type() will still
return them in irq_type.

Later in analogix_dp_irq_thread(), this irq_type mask is passed to
analogix_dp_unmute_hpd_interrupt():

    if (!dp->hpd_gpiod && irq_type) {
        analogix_dp_clear_hotplug_interrupts(dp, irq_type);
        analogix_dp_unmute_hpd_interrupt(dp, irq_type);
    }

Would passing the unintentionally detected PLUG and HPD_LOST bits into
analogix_dp_unmute_hpd_interrupt() permanently unmask those interrupts,
defeating the platform-specific interrupt scheme on the very first event?

Additionally, because DP_IRQ_TYPE_IRQ_HPD is no longer included in the
hpd_detected calculation for Rockchip, will this prevent
drm_helper_hpd_irq_event() from being called to process link retraining
and Panel Self Refresh (PSR) events?

>  		dev_dbg(dp->dev, "Detected cable status changed!\n");
>  		if (dp->drm_dev)
>  			drm_helper_hpd_irq_event(dp->drm_dev);
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 42463e18f392c..981ce3810e90d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
[ ... ]
> @@ -177,7 +177,21 @@ void analogix_dp_config_interrupt(struct analogix_dp=
_device *dp)
>  	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_2);
>  	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_3);
> =20
> -	analogix_dp_unmute_hpd_interrupt(dp, HPD_IRQ);
> +	if (analogix_dp_is_rockchip(dp->plat_data->dev_type)) {
> +		/*
> +		 * Either HOTPLUG_CHG interrupt or PLUG + HPD_LOST interrupt
> +		 * pair can be used to implement hotplug detection.
> +		 *
> +		 * On Rockchip platforms, configuring HPD deglitch to 2ms and
> +		 * using HOTPLUG_CHG interrupt for hotplug detection is proven
> +		 * as a better solution via engineering verification.
> +		 */
> +		writel(0x80, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_L);
> +		writel(0xbb, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_H);

[Severity: High]
Does configuring the deglitch filter to 2ms risk filtering out valid=20
DisplayPort short HPD pulses?

The DP specification defines short HPD pulses (which are used for sink
events like PSR and link retraining) as a low pulse lasting between 0.5ms
and 1.0ms.

Because the new 2ms filter configuration exceeds the maximum short pulse
duration of 1.0ms, will the hardware treat all valid DP short pulses as
noise and silently drop them before they can trigger an interrupt?

> +		analogix_dp_unmute_hpd_interrupt(dp, DP_IRQ_TYPE_HP_CHANGE);
> +	} else {
> +		analogix_dp_unmute_hpd_interrupt(dp, HPD_IRQ);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730032744.3815=
66-1-damon.ding@rock-chips.com?part=3D6
