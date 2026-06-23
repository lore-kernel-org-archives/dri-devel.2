Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A899CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968AE10E35D;
	Tue, 23 Jun 2026 14:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CY93Pd+E";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA48A10E35D
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 14:07:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EAD5960120;
 Tue, 23 Jun 2026 14:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833831F000E9;
 Tue, 23 Jun 2026 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782223660;
 bh=Os6M/AyNj4IRnS3nnRNE0WjUqOxJ0IOCEWhx43YeJY0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CY93Pd+ElLyTNkvfKP6nJB24DVjs5egvM6rPis7BDMxI/rmbXDFwmvPnCe1WtUGea
 ZT3uPmj4505FoKa067uo5YAgZwXzdmcJGh9QfPL6qBezE0uwZfhp3rOlLdZ+9RF+JF
 PQetfkHvausJN6ktYE/hagaUFjTEIa3ZFq4aZtcBtiemQG250S367ESh8tZvyUFu0M
 Lo2uo3gIlkuwgQgTSbVSCvzaTL4wnAd8AmQ/wofwcTt9T6TCeNSg6Zh4XthIldvjiV
 Njji4jUbuSIWa+R1V4nd7gKglqav0FpHTti5ePxIV9OfLH66CYizV9StjrNuDL0mG8
 zu/uQoGYOGQdA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/bridge: cdns-dsi: stop pre-enable after PHY
 wait failures
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623140100.67140-1-pengpeng@iscas.ac.cn>
References: <20260623140100.67140-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 14:07:40 +0000
Message-Id: <20260623140740.833831F000E9@smtp.kernel.org>
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
- [High] Unwinding bridge state in the void `atomic_pre_enable` hook causes=
 double-teardown, refcount underflows, and hardware bus faults when `atomic=
_post_disable` is subsequently called.
--

commit 3c593ba1dfe027bb80fc1bd679e6432049f077ff
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/bridge: cdns-dsi: stop pre-enable after PHY wait failures

This commit adds error handling to the PHY initialization and link training
waits in the cdns-dsi driver. If a timeout occurs during bridge pre-enable,
it unwinds the hardware state and puts the PM runtime reference.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu=
/drm/bridge/cadence/cdns-dsi-core.c
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -886,6 +918,19 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct=
 drm_bridge *bridge,
[ ... ]
>  	tmp =3D readl(dsi->regs + MCTL_MAIN_EN) | IF_EN(input->id);
>  	writel(tmp, dsi->regs + MCTL_MAIN_EN);
> +
> +	return;
> +
> +err_disable:
> +	if (dsi->phy_initialized) {
> +		dsi->phy_initialized =3D false;
> +		phy_power_off(dsi->dphy);
> +		phy_exit(dsi->dphy);
> +	}
> +	dsi->link_initialized =3D false;
> +	if (dsi->platform_ops && dsi->platform_ops->disable)
> +		dsi->platform_ops->disable(dsi);
> +	pm_runtime_put(dsi->base.dev);
>  }

[Severity: High]
Will this error path cause a double teardown and hardware bus faults during
disable?

Because cdns_dsi_bridge_atomic_pre_enable() returns void, the DRM core is
unaware of the failure and will continue as if the bridge is enabled. Later,
when the display pipeline is disabled, the DRM core will unconditionally ca=
ll
cdns_dsi_bridge_atomic_post_disable().

cdns_dsi_bridge_atomic_post_disable() blindly reads and writes MMIO registe=
rs
and tears down resources again:

cdns_dsi_bridge_atomic_post_disable() {
    ...
    val =3D readl(dsi->regs + MCTL_MAIN_DATA_CTL);
    ...
    phy_power_off(dsi->dphy);
    phy_exit(dsi->dphy);
   =20
    pm_runtime_put(dsi->base.dev);
}

Since err_disable already dropped the PM runtime reference and powered off
the PHY, these register accesses will happen on a suspended device. This
can lead to a hardware bus fault or kernel panic.

Additionally, the subsequent PHY and PM teardown calls in post_disable will
lead to double-frees and refcount underflows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623140100.6714=
0-1-pengpeng@iscas.ac.cn?part=3D1
