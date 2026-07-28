Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674CDC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C402F10E35D;
	Tue, 28 Jul 2026 19:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a17YPGc2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560E410E35D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 19:58:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EA4B641494;
 Tue, 28 Jul 2026 19:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9431F000E9;
 Tue, 28 Jul 2026 19:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785268732;
 bh=vXe274rOutSkaybKnxWKfkpNu58tVP13XdupURSxxQA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a17YPGc2KhmVOtBWXdilEG9G0iPu2DUx3aZv4l3sR3XcHajfefi/XuKZ8Ig5zT//5
 JTOy10jaUur8v8FTeeLqpyI7/SQPUt7anHfQhvr07zfvfiom2Qx47BLpLnJVr+8h4o
 JkuAKbKIWxNZrhwGX4PIYB0K5BY/oj6m7HpWce8tOrWYsrQygimu7p3sH4iePMFai4
 5tFMISWIZYseDjqQ8thEsOkkLwY/Rz/5PUJzYaFOul8gQEpK3LiuFQMkgs4PFhyjxn
 Tq4z14Ed1zhzWasYS7sAcSydDB4VD3hnWMq2Vzr3XcCr7bnVcrYWJz40+d4ErVuD8A
 2JBmAeWwR4plw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/18] drm/bridge: synopsys: dw-dp: Add Runtime PM
 support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-12-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
 <20260728-synopsys-dw-dp-improvements-v7-12-b7640fa8cf48@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 19:58:52 +0000
Message-Id: <20260728195852.7E9431F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Incorrect teardown order in dw_dp_unbind() allows AUX transfer=
s to cause a kernel panic or hang.
- [High] Calling a sleeping function (msleep) from a runtime PM resume call=
back that is reachable from an atomic commit path.

Pre-existing issues:
- [High] Unbalanced phy_power_off() in dw_dp_bridge_atomic_disable() corrup=
ts the PHY power count when atomic_enable() fails early.
--

--- Patch [12]: [PATCH v7 12/18] drm/bridge: synopsys: dw-dp: Add Runtime P=
M support ---
commit 6fa63f17bf7f03d90ce981c3f9cd86d3e8761c32
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add Runtime PM support

This commit adds runtime PM support to the Synopsys DesignWare DisplayPort
bridge driver. The support is not enabled automatically and must be hooked
up in the vendor specific glue code.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index d4f75b7f85d0a..8b650f904575d 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1664,6 +1672,13 @@ static void dw_dp_bridge_atomic_enable(struct drm_=
bridge *bridge,
>  	struct drm_connector_state *conn_state;
>  	int ret;
> =20
> +	ret =3D pm_runtime_get_active(dp->dev, RPM_TRANSPARENT);
> +	if (ret) {
> +		dev_err(dp->dev, "runtime PM failure\n");
> +		return;
> +	}
> +	dp->pm_active =3D true;
> +
>  	connector =3D drm_atomic_get_new_connector_for_encoder(state, bridge->e=
ncoder);
>  	if (!connector) {
>  		dev_err(dp->dev, "failed to get connector\n");
>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but does this early return cause an unbalanced
phy_power_off() later?

If dw_dp_bridge_atomic_enable() returns early here, it skips a successful
phy_power_on(). However, the subsequent dw_dp_bridge_atomic_disable()
unconditionally calls dw_dp_link_disable(), which executes phy_power_off().

Would calling phy_power_off() without a preceding successful phy_power_on()
decrease the PHY power count below 0 and permanently prevent the PHY from
being powered on again?

[ ... ]

> @@ -2090,9 +2146,22 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
> =20
>  void dw_dp_unbind(struct dw_dp *dp)
>  {
> +	if (dp->usbc_mode)
> +		pm_runtime_get_sync(dp->dev);
> +
> +	dp->drm_bound =3D false;
>  	disable_irq(dp->irq);
> +
>  	cancel_work_sync(&dp->hpd_work);
>  	phy_exit(dp->phy);
> +
> +	/* Last PM runtime suspend must be done with drm_bound =3D false */
> +	pm_runtime_put_sync(dp->dev);
> +
> +	/* suspend once if runtime PM is disabled */
> +	if (!pm_runtime_enabled(dp->dev))
> +		dw_dp_runtime_suspend(dp);
> +
>  	drm_bridge_put(dp->next_bridge);
>  	drm_dp_aux_unregister(&dp->aux);
>  }

[Severity: Critical]
Does this teardown order in dw_dp_unbind() introduce a race condition with
concurrent AUX transfers?

Because drm_dp_aux_unregister() is called at the very end, the AUX interface
remains active while the underlying hardware is shut down.

If a concurrent dw_dp_aux_transfer() occurs from userspace while runtime PM
is disabled, dw_dp_unbind() will manually call dw_dp_runtime_suspend()
disabling the APB clock. The AUX transfer will succeed its PM guard and
its subsequent regmap_write() will access unclocked hardware, triggering a
synchronous bus abort.

[ ... ]

> @@ -2202,6 +2271,47 @@ struct dw_dp *dw_dp_probe(struct platform_device *=
pdev, const struct dw_dp_plat_
>  }
>  EXPORT_SYMBOL_GPL(dw_dp_probe);
> =20
> +int dw_dp_runtime_suspend(struct dw_dp *dp)
> +{
> +	if (dp->drm_bound)
> +		disable_irq(dp->irq);
> +
> +	clk_disable_unprepare(dp->aux_clk);
> +	clk_disable_unprepare(dp->apb_clk);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_runtime_suspend);
> +
> +int dw_dp_runtime_resume(struct dw_dp *dp)
> +{
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(dp->apb_clk);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(dp->aux_clk);
> +	if (ret) {
> +		clk_disable_unprepare(dp->apb_clk);
> +		return ret;
> +	}
> +
> +	dw_dp_init_hw(dp);
> +
> +	/*
> +	 * HPD_HOT_PLUG bit is asserted only after the sink holds HPD
> +	 * high for at least 100ms.
> +	 */
> +	msleep(110);
> +
> +	if (dp->drm_bound)
> +		enable_irq(dp->irq);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_runtime_resume);

[Severity: High]
Does this introduce a sleeping delay in an atomic commit path?

The drm_atomic_helper_commit_tail() path is an atomic context in DRM display
drivers. During a commit, it calls dw_dp_bridge_atomic_enable(), which now
makes a synchronous pm_runtime_get_active() call.

That will invoke this dw_dp_runtime_resume() callback which executes
msleep(110). Calling a sleeping function from an atomic commit path violates
DRM subsystem requirements and can cause system instability and warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-synopsys-d=
w-dp-improvements-v7-0-b7640fa8cf48@collabora.com?part=3D12
