Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B2DC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99BA10E070;
	Fri, 24 Jul 2026 18:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hBWkFlpu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9331710E070
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:24:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23A7C407F4;
 Fri, 24 Jul 2026 18:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68671F000E9;
 Fri, 24 Jul 2026 18:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784917451;
 bh=g9+QYbvXJnUumwUdYc/n2S69RPFeeHQ6XYmOLdaj7AI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hBWkFlpu2QAvl/gXT6SGCb6Jnmm13QnKHXbeX7YIlYAcceWbQN6moDzSKC0BhsmNQ
 UNu9mhC+dh7UYaR+P3oH7WTkc1vrPTcqSaCjieC+m5LBAoxy2NlBO2ewAQpM8EHB6v
 Z0iJxzMup/m4mOUM2JtR+zWFlGfrKO0ev3jaV7XEkI13lkyXlxfvDMhI+TpMt36szJ
 uJCeyTszes5xP9tO67pmLJ9TfQfzbD4irZnrYprK96NbbX53kA7j4x6m9/ruWFVSea
 TLVsurZI8yZ8pyhcnENOIswG1BaHDUSZK33OwW8vdeI13zwgs9zpZyBNG71Y+OvZzk
 /LXmrVMERZKNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/16] drm/bridge: synopsys: dw-dp: Add Runtime PM
 support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v6-11-041d99a19c4e@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v6-11-041d99a19c4e@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:24:09 +0000
Message-Id: <20260724182410.B68671F000E9@smtp.kernel.org>
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
- [High] Using `guard(pm_runtime_noresume)` in the interrupt handler allows=
 hardware access on a suspended device.
- [High] Unhandled failure of PM resume in `dw_dp_bridge_atomic_enable()` c=
auses unbalanced PM operations and unclocked register accesses during teard=
own.

Pre-existing issues:
- [High] `drm_dp_aux_unregister()` is called too late in `dw_dp_unbind()`, =
allowing userspace to trigger AUX transfers on torn-down hardware.
--

--- Patch [11]: [PATCH v6 11/16] drm/bridge: synopsys: dw-dp: Add Runtime P=
M support ---
commit fb3ecb0112d9fff7c3a992e9273e0b7eaa8b8174
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

    drm/bridge: synopsys: dw-dp: Add Runtime PM support
   =20
    Add runtime PM stubs to the Synopsys DesignWare DisplayPort bridge
    driver. Support is not enabled automatically and must be hooked up
    in the vendor specific glue code.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1659,6 +1665,12 @@ static void dw_dp_bridge_atomic_enable(struct drm_=
bridge *bridge,
>  	struct drm_connector_state *conn_state;
>  	int ret;
> =20
> +	ret =3D pm_runtime_get_active(dp->dev, RPM_TRANSPARENT);
> +	if (ret) {
> +		dev_err(dp->dev, "runtime PM failure\n");
> +		return;
> +	}
> +

[Severity: High]
If acquiring the PM reference fails here, we log an error and return
early, but does the DRM core proceed as if the bridge is enabled?

Later, when tearing down the display pipeline,
dw_dp_bridge_atomic_disable() is called unconditionally. It executes
dw_dp_reset() (which accesses hardware registers) and
pm_runtime_put_autosuspend() (which drops a reference that was never
acquired). Could this lead to unclocked register accesses causing a bus
fault, and a PM usage counter underflow?

>  	connector =3D drm_atomic_get_new_connector_for_encoder(state, bridge->e=
ncoder);
>  	if (!connector) {
>  		dev_err(dp->dev, "failed to get connector\n");

[ ... ]

> @@ -1966,6 +1988,9 @@ static irqreturn_t dw_dp_irq(int irq, void *data)
>  	struct dw_dp *dp =3D data;
>  	u32 value;
> =20
> +	/* interrupt can only trigger for running device */
> +	guard(pm_runtime_noresume)(dp->dev);
> +
>  	regmap_read(dp->regmap, DW_DP_GENERAL_INTERRUPT, &value);

[Severity: High]
Does using guard(pm_runtime_noresume) allow hardware access on a suspended
device?

Since dw_dp_runtime_suspend() disables clocks but does not disable the
IRQ, a shared interrupt or a glitch on the IRQ line while the device is
in runtime suspend could cause this handler to execute and read
DW_DP_GENERAL_INTERRUPT while clocks are off.

Should this use pm_runtime_get_if_active() instead to avoid a bus fault?

>  	if (!value)
>  		return IRQ_NONE;

[ ... ]

> @@ -2101,6 +2152,11 @@ void dw_dp_unbind(struct dw_dp *dp)
>  	disable_irq(dp->irq);
>  	cancel_work_sync(&dp->hpd_work);
>  	phy_exit(dp->phy);
> +	if (!dp->usbc_mode)
> +		pm_runtime_put_sync(dp->dev);
> +	/* suspend once if runtime PM is disabled */
> +	if (!pm_runtime_enabled(dp->dev))
> +		dw_dp_runtime_suspend(dp);
>  	drm_bridge_put(dp->next_bridge);
>  	drm_dp_aux_unregister(&dp->aux);

[Severity: High]
This is a pre-existing issue, but is drm_dp_aux_unregister() called too
late here?

During device unbind, phy_exit() and disable_irq() are called before
drm_dp_aux_unregister(). Because the AUX device is still registered and
accessible to userspace, a userspace process could initiate an AUX
transfer that calls dw_dp_aux_transfer() while the PHY is uninitialized
and the IRQ is disabled, potentially causing a hardware fault or timeout.

>  	drm_bridge_remove(&dp->bridge);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v6-0-041d99a19c4e@collabora.com?part=3D11
