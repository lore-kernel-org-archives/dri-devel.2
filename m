Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55530CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 06:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B804B10E037;
	Wed, 24 Jun 2026 06:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J2QVeN0l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542E610E037
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 06:14:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13B1E4440A;
 Wed, 24 Jun 2026 06:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78D01F000E9;
 Wed, 24 Jun 2026 06:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782281655;
 bh=0kdZ1zeEm5/+konHpIUVa1blOVOPTdOpHRGrPv/LQMU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J2QVeN0l5tKriirEYtLh4hd6fUIneHn/EwQRMn7kGccByPlTFy8rt6fQ0uRp4Qjcz
 RciV6cqJpE5uSnxDDWTThTJeUE96/UDM07C6+7aGfvot4WOkWcHzlH4tbjnu2nVpyq
 NOk8TjLbdLfTvp8zdhoqrJKSmdX5XlXm/8ahqU+lHlNSu1/ZxrJEbwQO+DAo4aJgCj
 C2hbrQ04ZG2rD5ZAP2kGGfF9hK+W6R+n82xXyACtshS7oXD5PUw9RrRvRJvUxdJwSB
 wpe5qIaTBT5K62YlOBTbaQUq783n4c+FYgLkm7IxZcnWHKpZgZmQ10Lmy+s3v+oygy
 fCjEfS0ujLC0g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/bridge: cdns-dsi: Propagate resume reset and
 clock failures
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624055906.53195-1-pengpeng@iscas.ac.cn>
References: <20260624055906.53195-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 06:14:14 +0000
Message-Id: <20260624061414.C78D01F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Error returned by `cdns_dsi_resume` exposes unprotected register a=
ccess and PHY teardown in `atomic_post_disable`, leading to a bus hang.
- [High] Hardware registers are accessed in `probe` before deasserting the =
device reset.
--

commit 4c1e6021cc122efbeb34743b0b51f25a1dc5f221
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/bridge: cdns-dsi: Propagate resume reset and clock failures

cdns_dsi_resume() ignores reset_control_deassert() and
clk_prepare_enable() failures for resources that probe treats as
required.  The host can then appear resumed even though the DSI reset or
clock transitions failed.

Propagate resume failures and unwind transitions that already succeeded.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu=
/drm/bridge/cadence/cdns-dsi-core.c
> index 0dd85e26248cc..0cbb8528350c4 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -1233,12 +1233,27 @@ static const struct mipi_dsi_host_ops cdns_dsi_op=
s =3D {
>  static int __maybe_unused cdns_dsi_resume(struct device *dev)
>  {
>  	struct cdns_dsi *dsi =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D reset_control_deassert(dsi->dsi_p_rst);

[Severity: High]
This is a pre-existing issue, but I noticed hardware registers might be
accessed in probe before deasserting the device reset:

In cdns_dsi_drm_probe():
    ...
	val =3D readl(dsi->regs + ID_REG);
    ...

If the bootloader or previous boot stage leaves the reset line asserted,
could attempting to read the APB register stall the bus and cause an extern=
al
abort, or return invalid data causing probe to fail?

> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(dsi->dsi_p_clk);
> +	if (ret)
> +		goto err_assert_reset;
> =20
> -	reset_control_deassert(dsi->dsi_p_rst);
> -	clk_prepare_enable(dsi->dsi_p_clk);
> -	clk_prepare_enable(dsi->dsi_sys_clk);
> +	ret =3D clk_prepare_enable(dsi->dsi_sys_clk);
> +	if (ret)
> +		goto err_disable_p_clk;
> =20
>  	return 0;
> +
> +err_disable_p_clk:
> +	clk_disable_unprepare(dsi->dsi_p_clk);
> +err_assert_reset:
> +	reset_control_assert(dsi->dsi_p_rst);
> +	return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does propagating this error
expose unprotected register access during teardown?

If cdns_dsi_resume() returns an error, pm_runtime_get_sync() in
cdns_dsi_bridge_atomic_pre_enable() will fail and return early:

In cdns_dsi_bridge_atomic_pre_enable():
    ...
	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
		return;
    ...

However, because atomic_pre_enable() returns void, the DRM core still
considers the bridge enabled. Later, during display pipeline teardown,
cdns_dsi_bridge_atomic_post_disable() is called. Will it unconditionally re=
ad
MCTL_MAIN_DATA_CTL with clocks disabled, causing a bus hang?

In cdns_dsi_bridge_atomic_post_disable():
    ...
	val =3D readl(dsi->regs + MCTL_MAIN_DATA_CTL);
    ...

Additionally, does it blindly call phy_power_off() and phy_exit() even thou=
gh
the PHY was never initialized, causing kernel warnings?

In cdns_dsi_bridge_atomic_post_disable():
    ...
	phy_power_off(dsi->dphy);
	phy_exit(dsi->dphy);
    ...

>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624055906.5319=
5-1-pengpeng@iscas.ac.cn?part=3D1
