Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF26C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 021E210E204;
	Mon,  7 Sep 2026 11:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CNRfp34S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E4210E204
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:28:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A682F40BE1;
 Mon,  7 Sep 2026 11:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D52E1F00A3A;
 Mon,  7 Sep 2026 11:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788780480;
 bh=u3IMTCbQofqndYlXdEmPeP8Ke/QRZ5CHaoByVVM/6pc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CNRfp34Sd415W91G7afdOhhjSmvo/9ENnJgReETDDBvKbO6S1tjok+Xf1MS7GeIDd
 cetWo70ok9ZjN2t1yJ3ziI+s1+RTErxaEmir/C4Av5HIxezMizr1ObTicz+OXvZ4oG
 RQJYr6HM6s7kFPOckWlsY+fooZ27AVcUtrvn4SC19zV+43gSnOb3U0yzjWwA6rNwKZ
 4DTLT4N4prH0mA3NJPqCasGf1g0MR5nTnMIkBqmKlrN+7s1jsiDZtBEJQw7FwDIhbQ
 bAAafu7O80jMItRmRT0E2jf+Eh+Xq/7juz/V29TnGM5ZDqD2agnyDvmfPY0txr+hgI
 Vvfw74GNRfjZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/bridge: cdns-dsi: Fix stop-state at enable time
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-cdns-dsi-fixes-v2-2-96d9b116e9bc@ideasonboard.com>
References: <20260907-cdns-dsi-fixes-v2-0-96d9b116e9bc@ideasonboard.com>
 <20260907-cdns-dsi-fixes-v2-2-96d9b116e9bc@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:27:59 +0000
Message-Id: <20260907112800.5D52E1F00A3A@smtp.kernel.org>
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
- [High] The patch introduces a sleeping delay (`usleep_range`) in an atomi=
c context path, violating DRM display driver guidelines.

Pre-existing issues:
- [High] Pre-existing use of a sleeping poll macro (`readl_poll_timeout`) i=
n an atomic context path.
--

commit 831dd94ae2ea6c134a442329e348bfa99f691859
Author: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

drm/bridge: cdns-dsi: Fix stop-state at enable time

This patch addresses an initialization failure with the Xilinx D-PHY RX by
ensuring the clock and data lanes are kept in a stop-state during the D-PHY
power up and init sequence. It adds FORCE_STOP flags and a delay to allow
the stop-state to take effect.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu=
/drm/bridge/cadence/cdns-dsi-core.c
> index 4b7a3bf582551..b9c87f13177af 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
[ ... ]
> @@ -661,6 +668,13 @@ static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
>  	writel(DPHY_CMN_PSO | DPHY_ALL_D_PDN | DPHY_C_PDN | DPHY_CMN_PDN |
>  	       DPHY_D_RSTB(output->dev->lanes) | DPHY_C_RSTB,
>  	       dsi->regs + MCTL_DPHY_CFG0);
> +
> +	/* Keep stop state for at least 100 us */
> +	usleep_range(100, 200);

[Severity: High]
Is it safe to introduce a sleeping delay in an atomic context path here?

Looking at the call chain:
drm_atomic_helper_commit_tail()
  drm_atomic_helper_commit_modeset_enables()
    cdns_dsi_bridge_atomic_pre_enable()
      cdns_dsi_hs_init()

The DRM guide specifies drm_atomic_helper_commit_tail() as an atomic
context path where sleeping is forbidden. Introducing usleep_range() here
might lead to kernel warnings, system instability, or regressions during a
non-blocking modeset request.

[Severity: High]
This is a pre-existing issue, but are the readl_poll_timeout() calls in this
path also sleeping in an atomic context?

For example, earlier in cdns_dsi_hs_init():

cdns_dsi_hs_init() {
    ...
    WARN_ON_ONCE(readl_poll_timeout(dsi->regs + MCTL_MAIN_STS, status,
                                    status & PLL_LOCKED, 100, 100));
    ...
}

There is also a similar call in cdns_dsi_bridge_atomic_pre_enable():

cdns_dsi_bridge_atomic_pre_enable() {
    ...
    if (readl_poll_timeout(dsi->regs + MCTL_MAIN_STS, status,
                           (tmp =3D=3D (status & tmp)), 100, 500000))
    ...
}

Since readl_poll_timeout() internally calls usleep_range(), could these
similarly cause regressions in the atomic commit path?

> +
> +	val &=3D ~(DATA_FORCE_STOP | CLK_FORCE_STOP);
> +	writel(val, dsi->regs + MCTL_MAIN_EN);
> +
>  	dsi->phy_initialized =3D true;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-cdns-dsi-f=
ixes-v2-0-96d9b116e9bc@ideasonboard.com?part=3D2
