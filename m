Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3645FC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7BF10E0D6;
	Thu, 30 Jul 2026 03:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SvDqZETY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDCB10E0D6
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:39:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB94F43342;
 Thu, 30 Jul 2026 03:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E591F000E9;
 Thu, 30 Jul 2026 03:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785382790;
 bh=/8is5YmLPHrNpU2nX66cBOZpu8d2qYyVEQuo44Phyok=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SvDqZETYY2df3WqILiKpqrPELFRB2arHviCAW3he0mLa7UnvNXjCBilhCyqCUtdJ7
 2ygtOVmuprB60OZWSfps2aUGJ0wNkZWkksMTdaBytobSgaLCAK8/WSLsN4MY6Bexqr
 f9RDLfTOsW3bMrfSuvzI4TSuaFuTMJciGvzsh3gPtIk6NsA0uefHrPmt0/tiScIX8R
 quq3VEL44fwq/u1o7zJdpiiRbq/f4nLeJQxsc3Gk7vyyG0GEHf/wR8ajHD97pKW+LH
 CNNeTbOHDWGZcwiyasebs0CT7lJ/YmXHN01nmTURpzxQEqtTbTG9ikMand6rVasvvP
 utygsmc+9hWeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/7] drm/bridge: analogix_dp: Manage pm runtime and
 IRQ for native HPD pin detection
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260730032744.381566-2-damon.ding@rock-chips.com>
References: <20260730032744.381566-1-damon.ding@rock-chips.com>
 <20260730032744.381566-2-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:39:50 +0000
Message-Id: <20260730033950.86E591F000E9@smtp.kernel.org>
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
- [High] The HPD IRQ handler unconditionally accesses unclocked DP controll=
er registers during runtime suspend on GPIO HPD and non-Rockchip configurat=
ions, causing a synchronous external abort (system crash).
--

--- Patch [1]: [PATCH v1 1/7] drm/bridge: analogix_dp: Manage pm runtime an=
d IRQ for native HPD pin detection ---
commit 0b74430c48be5d81c8cb19f2cd5f520d6c7a696a
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Manage pm runtime and IRQ for native HPD pin detec=
tion

This commit moves enable_irq() and disable_irq() from bridge enable/disable
handlers to analogix_dp_bind() and analogix_dp_unbind() to keep HPD detecti=
on
active. It also acquires a runtime PM reference exclusively for Rockchip
native HPD pin configurations to ensure the controller remains powered.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 30c0c0b41d5aa..1c98f92e001d8 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

[ ... ]

> @@ -1508,6 +1511,14 @@ int analogix_dp_bind(struct analogix_dp_device *dp=
, struct drm_device *drm_dev)
>  		goto err_unregister_aux;
>  	}
> =20
> +	if (analogix_dp_require_pm_for_hpd_irq(dp)) {
> +		ret =3D pm_runtime_resume_and_get(dp->dev);
> +		if (ret)
> +			goto err_unregister_aux;
> +	}
> +
> +	enable_irq(dp->irq);
> +

[Severity: High]
Since pm_runtime_resume_and_get() is only called for Rockchip native HPD,
other configurations (like GPIO HPD or Exynos) can enter runtime suspend
while the IRQ remains enabled here.

If the HPD interrupt fires (e.g. via an active GPIO pin) while the device is
in runtime suspend, will this cause a crash?

The hardirq handler executes and performs unconditional MMIO accesses to the
unclocked DP controller:

analogix_dp_hardirq()
  analogix_dp_mute_hpd_interrupt()
    readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);

Accessing memory-mapped registers of a clock-gated peripheral typically
causes a synchronous external abort.

>  	return 0;
> =20
>  err_unregister_aux:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730032744.3815=
66-1-damon.ding@rock-chips.com?part=3D1
