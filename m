Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E435C55174
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E517510F076;
	Thu,  6 Aug 2026 01:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lQ0gAkXi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93E810F076
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 01:07:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 17AB460A63;
 Thu,  6 Aug 2026 01:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733A41F00ACF;
 Thu,  6 Aug 2026 01:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785978444;
 bh=UZh6Vl+SDWun7kQdsYP+XH2G2x68xAvslP4Y7UyzRt4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lQ0gAkXichqB49LXb76/jCC7rFU7h3D0zDHhtcyg5DSigOGgOGnS1rgFEwixzwPKS
 oZPKkf/Tkk5NBl9o2A2yghOY5cwEcHGkh72aVS2bg9Z6sBONKyeytZQTb6Ta/pqF8y
 26P34tqz2P1SlfpWkYaLt43DSE/QDmPhkRuId8jMJBFoH+Y0dLvNj9685bPOofkefJ
 ks1DVEJsf9+whqJ6hlbU79gWzJp07rVP26JboTtJsBkSCGKyfBb7KYoG3hMHInawn8
 p5kCxmI/8pIIgIbGPpztdUBKjAAOUvLjBhJ3u3v/ZbQxJLMp6hTRk6dvsDb0hzSw6Y
 54HG5QIFg3VCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/21] drm/bridge: synopsys: dw-dp: Add Runtime PM
 support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-14-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v10-14-d84a26c303d6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 01:07:23 +0000
Message-Id: <20260806010724.733A41F00ACF@smtp.kernel.org>
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
- [High] Using asynchronous pm_runtime_put_autosuspend() during teardown pa=
ths leaves hardware in an active power state.
- [High] Calling sleeping functions from within the bridge atomic enable an=
d disable callbacks violates atomic context restrictions.
- [Medium] Calling `phy_init()` while the APB and AUX clocks are disabled m=
ay cause hardware faults.
--

--- Patch [14]: [PATCH v10 14/21] drm/bridge: synopsys: dw-dp: Add Runtime =
PM support ---
commit c4724f477a725eaa23bb5ef5b62b3fe8b8f02e8a
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add Runtime PM support
   =20
Add runtime PM stubs to the Synopsys DesignWare DisplayPort bridge
driver. Support is not enabled automatically and must be hooked up
in the platform specific glue code.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 847c2aa95e27c..545dddce69e7b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
[ ... ]
> @@ -1681,6 +1689,13 @@ static void dw_dp_bridge_atomic_enable(struct drm_=
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

[Severity: High]
Does this introduce a sleeping function into an atomic context?

During a non-blocking atomic commit, the DRM core invokes
dw_dp_bridge_atomic_enable(). This callback executes in an atomic context
where sleeping is forbidden. However, pm_runtime_get_active()
synchronously resumes the device, invoking dw_dp_runtime_resume(), which
subsequently calls msleep(110).

This isn't a bug introduced by this patch, but there are pre-existing
sleeping operations in these paths, including a mutex lock
(scoped_guard(mutex, &dp->audio_lock)) and usleep_range() inside
dw_dp_reset(), which may also need attention to avoid kernel warnings.

[ ... ]
> @@ -1940,6 +1972,9 @@ static int dw_dp_bridge_attach(struct drm_bridge *b=
ridge,
>  err_disable_irq:
>  	disable_irq(dp->irq);
>  	cancel_work_sync(&dp->hpd_work);
> +
> +	pm_runtime_put_autosuspend(dp->dev);
> +
>  	return ret;
>  }

[Severity: High]
Will this async put leave the hardware in an active power state?

This async put is used in the attach error cleanup path, which will also be
immediately followed by driver unbind and PM disable. The delayed suspend
is scheduled right before the device is unregistered.=20

Because device removal immediately follows, the devres cleanup executes
pm_runtime_disable(), which cancels the pending async suspend work. This
aborts the power-down sequence and leaves the apb_clk and aux_clk enabled.
Should pm_runtime_put_sync() be used here instead?

[ ... ]
> @@ -1951,6 +1986,8 @@ static void dw_dp_bridge_detach(struct drm_bridge *=
bridge)
>  	drm_dp_aux_unregister(&dp->aux);
>  	disable_irq(dp->irq);
>  	cancel_work_sync(&dp->hpd_work);
> +	if (!dp->usbc_mode)
> +		pm_runtime_put_autosuspend(dp->dev);
>  }

[Severity: High]
Similar to the error path in dw_dp_bridge_attach(), does this need to be a
synchronous put? pm_runtime_put_sync() ensures the idle/suspend completes
before the subsequent device deletion.

[ ... ]
> @@ -2209,31 +2283,57 @@ struct dw_dp *dw_dp_probe(struct platform_device =
*pdev, const struct dw_dp_plat_
[ ... ]
> +	if (dp->plat_data.autosuspend_delay > 0) {
> +		pm_runtime_use_autosuspend(dev);
> +		pm_runtime_set_autosuspend_delay(dev, dp->plat_data.autosuspend_delay);
> +		ret =3D devm_pm_runtime_enable(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!pm_runtime_enabled(dev)) {
> +		dw_dp_runtime_resume(dp);
> +
> +		ret =3D devm_add_action_or_reset(dev, dw_dp_manual_suspend, dp);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	ret =3D phy_init(dp->phy);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "phy init failed\n");
> -		return ERR_PTR(ret);
> +		return ret;
>  	}

[Severity: Medium]
Can calling phy_init() while the APB and AUX clocks are disabled cause
hardware faults?

If PM runtime is active (which is the default if autosuspend_delay > 0),
the apb_clk and aux_clk remain disabled until the device is explicitly
resumed. However, phy_init() is still called unconditionally at the end of
probe. If the generic PHY driver accesses internal registers that rely on
the display controller's APB bus clock, the unclocked access might hang the
system.

[ ... ]
> +int dw_dp_runtime_resume(struct dw_dp *dp)
> +{
[ ... ]
> +	/*
> +	 * HPD_HOT_PLUG bit is asserted only after the sink holds HPD
> +	 * high for at least 100ms.
> +	 */
> +	msleep(110);
> +
> +	return 0;
> +}

[Severity: High]
As mentioned earlier, does this msleep(110) introduce a sleep into atomic
context when reached from dw_dp_bridge_atomic_enable() via
pm_runtime_get_active()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v10-0-d84a26c303d6@collabora.com?part=3D14
