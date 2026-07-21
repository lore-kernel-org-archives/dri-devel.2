Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAC9C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 771B510E3AB;
	Tue, 21 Jul 2026 18:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y3kROm6w";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5AC10E3AB
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:23:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69180416CA;
 Tue, 21 Jul 2026 18:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086261F00A3A;
 Tue, 21 Jul 2026 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784658202;
 bh=9JKfmergHW/lvMkZbMMBYa3kDN/4QhU9CpglMry68BA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y3kROm6wQqQvqJYcy485fB3XY11b8zJHNDasHA/aW8JYj4GiVX6FVmsgskAdOhc/4
 3G/abWzjGoqmPxKhtlGXYjmuKh3ldVPHwH56BcEDdOscf8PHW2enzFi+pmzAwa3+uT
 8prXYJSf0+50nJ2oLutak6NbBnTC4TgH9WYgtgrzgX2EGb89OY+VRiSKKrhN5pPJfD
 IvCaZOEAYYQdJ5QFGehVEZVVRBIMbYcRZkx/jOWdWProvrswNkarsaNlszBR6J3pUT
 R8X6n37SSAbDcTRt/rPLgPGchDvL9XBPY5V1AscXh8MBIXCwsN7sctymk3mBecGiZS
 CfRWoS4Wh5RFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/10] drm/rockchip: dw_dp: Add runtime PM support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260721-synopsys-dw-dp-improvements-v4-8-f0f4a4ede712@collabora.com>
References: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
 <20260721-synopsys-dw-dp-improvements-v4-8-f0f4a4ede712@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 18:23:21 +0000
Message-Id: <20260721182322.086261F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Critical] Threaded IRQ handler accesses unclocked hardware registers if =
triggered while runtime suspended.
- [High] Double disable of devm-managed clocks due to uncoordinated runtime=
 PM suspend.
- [Medium] Incorrect runtime PM teardown sequence prevents asynchronous sus=
pends.
- [Medium] Missing idle trigger leaves the device fully powered on after in=
itialization.
- [Medium] Calling dw_dp_bind() before pm_runtime_enable() causes -EACCES e=
rrors from the PM core.

Pre-existing issues:
- [High] Inverted logic for runtime PM reference management causes usage co=
unt leaks and underflows.
- [High] Missing runtime PM reference drop on the bind error path.
--

--- Patch [8]: [PATCH v4 08/10] drm/rockchip: dw_dp: Add runtime PM support=
 ---
commit 73aba26d330e327d28e953d044baf166117572f7
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Add runtime PM support

This patch adds support for runtime PM to the Rockchip RK3576/3588 Synopsys
DesignWare DisplayPort driver.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index 0ecbad24dd4e8..d7e1704fd9806 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
[ ... ]
> @@ -169,14 +174,25 @@ static int dw_dp_rockchip_bind(struct device *dev, =
struct device *master, void *
>  	if (ret)
>  		return ret;
> =20
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);

[Severity: Medium]
Because dw_dp_bind() is called immediately before this block, does it
cause -EACCES errors from the PM core?

Inside dw_dp_bind(), the core driver calls pm_runtime_get_sync(dp->dev).
Since runtime PM is not yet enabled for the device at that point, the PM
core will return -EACCES.

[Severity: High]
This is a pre-existing issue, but does dw_dp_bind() leak a runtime PM
reference on its error path?

In drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bind():

    if (!dp->usbc_mode)
        pm_runtime_get_sync(dp->dev);

    ...

    ret =3D phy_init(dp->phy);
    if (ret) {
        dev_err_probe(dev, ret, "phy init failed\n");
        goto put_next_bridge;
    }

If phy_init() fails, the function jumps to put_next_bridge and returns
without dropping the reference acquired earlier, permanently preventing
the device from suspending.

[Severity: Medium]
Does this initialization sequence miss an idle trigger?

The driver calls pm_runtime_set_active() and pm_runtime_enable(), but does
not queue an idle check. The runtime PM core does not automatically queue
one on enable, which might leave the device fully powered on until the
first display modeset cycle. Could a manual call to pm_request_idle() be
needed to start the autosuspend timer?

>  	connector =3D drm_bridge_connector_init(drm_dev, encoder);
>  	if (IS_ERR(connector)) {
> -		dw_dp_unbind(dp->base);
> -		return dev_err_probe(dev, PTR_ERR(connector),
> -				     "Failed to init bridge connector\n");
> +		ret =3D PTR_ERR(connector);
> +		dev_err_probe(dev, ret, "Failed to init bridge connector\n");
> +		goto error;
>  	}
> =20
>  	return 0;
> +
> +error:
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
> +	dw_dp_unbind(dp->base);
> +	return ret;
>  }
> =20
>  static void dw_dp_rockchip_unbind(struct device *dev, struct device *mas=
ter,
> @@ -184,6 +200,8 @@ static void dw_dp_rockchip_unbind(struct device *dev,=
 struct device *master,
>  {
>  	struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
> =20
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
>  	dw_dp_unbind(dp->base);
>  }

[Severity: Medium]
Does disabling runtime PM before calling dw_dp_unbind() prevent
asynchronous suspends?

By calling pm_runtime_disable() first, when dw_dp_unbind() subsequently
calls pm_runtime_put_autosuspend(), the asynchronous idle request is
rejected because runtime PM is already disabled. This leaves the device
permanently in the RPM_ACTIVE state and the hardware remains powered on
after the driver is unbound.

[Severity: High]
Could this teardown sequence result in a double disable of devm-managed
clocks?

The driver acquires clocks using devm_clk_get_enabled() during probe,
which registers a devres action to automatically disable them on removal.

However, dw_dp_runtime_suspend() manually calls clk_disable_unprepare().
If the device is already in the RPM_SUSPENDED state when unbound,
pm_runtime_disable() leaves it suspended. When devres subsequently
attempts to disable the already-disabled clocks, it will cause an
underflow.

[Severity: High]
This is a pre-existing issue, but is the logic for dropping the runtime
PM reference inverted in dw_dp_unbind()?

In drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bind():

    if (!dp->usbc_mode) {
        pm_runtime_get_sync(dp->dev);
    }

But in dw_dp_unbind():

    if (dp->usbc_mode)
        pm_runtime_put_autosuspend(dp->dev);

This means standard DP (usbc_mode =3D false) leaks the reference it
acquired, while USB-C DP (usbc_mode =3D true) attempts to drop a reference
it never acquired, causing usage count leaks and underflows.

[ ... ]
> @@ -254,6 +272,34 @@ static void dw_dp_rockchip_remove(struct platform_de=
vice *pdev)
>  	component_del(&pdev->dev, &dw_dp_rockchip_component_ops);
>  }
> =20
> +static int dw_dp_rockchip_runtime_suspend(struct device *dev)
> +{
> +	struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
> +
> +	return dw_dp_runtime_suspend(dp->base);
> +}

[Severity: Critical]
Does leaving the IRQ enabled during runtime suspend risk a kernel panic?

This patch introduces runtime PM support, which can now trigger an issue
in the bridge driver. dw_dp_runtime_suspend() disables the apb_clk.
However, the driver leaves dp->irq enabled.

If a spurious interrupt or HPD event fires while the device is in the
RPM_SUSPENDED state, dw_dp_irq() will directly read
DW_DP_GENERAL_INTERRUPT via regmap:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_irq() {
    ...
    regmap_read(dp->regmap, DW_DP_GENERAL_INTERRUPT, &value);
}

Accessing these unclocked hardware registers without first checking the
runtime PM status (e.g., using pm_runtime_get_if_active()) will cause a
synchronous external abort or data abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-synopsys-d=
w-dp-improvements-v4-0-f0f4a4ede712@collabora.com?part=3D8
