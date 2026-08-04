Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BACC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D577510E8F2;
	Tue,  4 Aug 2026 08:33:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gPKbM8En";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D7610E8F2
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:33:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD145600AA;
 Tue,  4 Aug 2026 08:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18E31F000E9;
 Tue,  4 Aug 2026 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785832381;
 bh=UoPwtukJx8129GRH5VGodMVi4wnoaiwSOisNKjH9C74=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gPKbM8EnrxTsz5zDUCnphmvq0rtjfoUIHFYOdlEu24h/LtwpmIEIqPEDTD1/1UujY
 CYZozNR7Qtj9MjYJyGh+g6604Whq9aEHIpjGwT3X2zaKP41OmkYzt7Vzcw/O8HmNMa
 aZkdr5SOaA1Xo/cjeMMm5ImUXYrzBIiM3eZhjiCUUlegIlPtnh7GuIrWxV94a/MYAI
 622hGQ4dQQt8bsUys2amm9D+eMoX5aQTtMaWWVwEilMWBKd/mZ5R/8EAjRCEjc0Gnr
 TYchxcmWLCeSmN0F/Gfo8Ue0SebWKsKIEPeVp2wE2CKcODTY/UmtcT3JIdCEfarDHG
 MBRr8E3MDogjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] drm/bridge: analogix_dp: Use platform-specific
 HPD detection scheme
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260804081717.741404-8-damon.ding@rock-chips.com>
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
 <20260804081717.741404-8-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:32:59 +0000
Message-Id: <20260804083300.D18E31F000E9@smtp.kernel.org>
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
- [High] The 2ms HPD deglitch filter (0xbb80) on Rockchip platforms complet=
ely filters out valid DP short pulses, breaking link loss detection and PSR.

Pre-existing issues:
- [High] The threaded IRQ handler ignores DP_IRQ_TYPE_IRQ_HPD (short pulses=
), preventing drm_helper_hpd_irq_event() from processing link loss or PSR e=
vents.
--

--- Patch [7]: [PATCH v2 07/10] drm/bridge: analogix_dp: Use platform-speci=
fic HPD detection scheme ---
commit 9400555d3cb8cd686c3464c5b0945a71464ab506
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Use platform-specific HPD detection scheme

Hotplug detection can be implemented either via HOTPLUG_CHG interrupt, or t=
he
combination of PLUG and HPD_LOST interrupts. This patch configures HPD
deglitch to 2ms and uses HOTPLUG_CHG for hotplug detection on Rockchip
platforms.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 608d8d098329c..2399febb539e7 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -721,13 +721,18 @@ static irqreturn_t analogix_dp_irq_thread(int irq, =
void *arg)
>  {
>  	struct analogix_dp_device *dp =3D arg;
>  	u32 irq_type;
> +	bool hpd_detected;
> =20
>  	irq_type =3D analogix_dp_get_irq_type(dp);
>  	if (irq_type)
>  		analogix_dp_clear_hotplug_interrupts(dp, irq_type);
> =20
> -	if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN ||
> -	    irq_type & DP_IRQ_TYPE_HP_CABLE_OUT) {
> +	if (!dp->hpd_gpiod && analogix_dp_is_rockchip(dp->plat_data->dev_type))
> +		hpd_detected =3D irq_type & DP_IRQ_TYPE_HP_CHANGE;
> +	else
> +		hpd_detected =3D (irq_type & DP_IRQ_TYPE_HP_CABLE_IN) ||
> +			       (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT);
> +

[Severity: High]
This is a pre-existing issue, but does the calculation of hpd_detected in
analogix_dp_irq_thread() miss DP_IRQ_TYPE_IRQ_HPD?

It appears that short pulse interrupts (DP_IRQ_TYPE_IRQ_HPD) are ignored in
this threaded IRQ handler and never propagated to the DRM core via
drm_helper_hpd_irq_event(). This could cause link loss events to go unhandl=
ed
until a physical cable replug.

> +	if (hpd_detected) {
>  		dev_dbg(dp->dev, "Detected cable status changed!\n");
>  		if (dp->drm_dev)
>  			drm_helper_hpd_irq_event(dp->drm_dev);
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 42463e18f392c..fa8e2f104d6c5 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -149,8 +149,13 @@ void analogix_dp_reset(struct analogix_dp_device *dp)
>  	writel(0x0, dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
>  	writel(0x0, dp->reg_base + ANALOGIX_DP_HDCP_CTL);
> =20
> -	writel(0x5e, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_L);
> -	writel(0x1a, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_H);
> +	if (analogix_dp_is_rockchip(dp->plat_data->dev_type)) {
> +		writel(0x80, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_L);
> +		writel(0xbb, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_H);

[Severity: High]
Will configuring the HPD deglitch filter to 2ms (0xbb80) completely filter
out valid DP short pulses?

The DP specification requires short pulses to be between 0.5ms and 1.0ms. It
seems a 2.0ms filter will unconditionally drop them before they can trigger
an interrupt, potentially breaking link loss recovery and PSR sink events on
Rockchip platforms.

> +	} else {
> +		writel(0x5e, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_L);
> +		writel(0x1a, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_H);
> +	}
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804081717.7414=
04-1-damon.ding@rock-chips.com?part=3D7
