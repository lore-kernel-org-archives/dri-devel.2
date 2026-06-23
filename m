Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B043CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5B510EC92;
	Tue, 23 Jun 2026 20:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VIEQ9xIr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B9010EC92
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:31:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81E0560018;
 Tue, 23 Jun 2026 20:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E501C1F000E9;
 Tue, 23 Jun 2026 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782246668;
 bh=zLaOMqWS9s4Cwm1aIhcOWT9tvSf9obMJ/rtRgqa9fnU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VIEQ9xIrvFfsTVRGkJIznKOny75dShhJLKC6jejBCFchv5nUu72wxjQXJx4d8xj9N
 72oPJ9oW59I2bgalr+8jBdNpFeDMC+996RyUYWrV5Cjm0Ws89Uiup1V67Gdb0IR9c6
 PTv8ptF1CB4NeUP1mMURGZHLAQg0HZsXCsO0FvSodj7aAavJd5g17dAgnJkypubreU
 3ba22JkHJXMI5R39z0YygNP3L9vWbr2L6cZ/8N+BYD9xoFoW+GJDuaoOE9ApRf5XgL
 MpoUvuW6Ng2cGig4HMclaJWoq6kXIx4s7wYA6/6QZscOWgtjTPXMf09ndV6Xv1Fn1n
 33XL+PEJQzvVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] drm/bridge: synopsys: dw-dp: Add Runtime PM
 support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-7-dc61e6352508@collabora.com>
References: <20260612-synopsys-dw-dp-improvements-v3-7-dc61e6352508@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:31:07 +0000
Message-Id: <20260623203107.E501C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Unchecked return value of clk_prepare_enable() in runtime resume.
- [High] Unchecked return value of pm_runtime_get_sync() during atomic enab=
le.
- [High] Interrupt handler accesses hardware registers while device may be =
suspended.

Pre-existing issues:
- [High] Memory/refcount leak of the next_bridge acquired via of_drm_get_br=
idge_by_endpoint().
- [High] PHY power_count underflow causing permanent PHY failure after earl=
y return in atomic_enable.
- [High] Uninitialized stack memory copied to buffer in dw_dp_aux_read_data=
().
--

commit 25b9778935f0029deadc6a4ac4d19728b07017ee
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: drm/bridge: synopsys: dw-dp: Add Runtime PM support

The patch adds runtime PM stubs to the Synopsys DesignWare DisplayPort brid=
ge
driver and hooks them up to various hardware access paths.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 7fa38145e35ce..7f4f36c614844 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1465,6 +1465,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux=
 *aux,
>  	if (WARN_ON(msg->size > 16))
>  		return -E2BIG;
> =20
> +	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> +

[Severity: High]
This is a pre-existing issue, but I noticed a potential information leak in
dw_dp_aux_read_data() which is called during these transfers:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_aux_read_data() {
	...
	u32 value;

	regmap_read(dp->regmap, DW_DP_AUX_DATA0 + i * 4, &value);

	for (j =3D 0; j < num; j++)
		buffer[i * 4 + j] =3D value >> (j * 8);
	...
}

If regmap_read() fails, the local variable "value" remains uninitialized.
Could this copy uninitialized kernel stack memory into the buffer, which is
then returned to userspace via the DRM DP AUX chardev?

>  	switch (msg->request & ~DP_AUX_I2C_MOT) {
>  	case DP_AUX_NATIVE_WRITE:
>  	case DP_AUX_I2C_WRITE:

[ ... ]

> @@ -1655,6 +1657,8 @@ static void dw_dp_bridge_atomic_enable(struct drm_b=
ridge *bridge,
>  	struct drm_connector_state *conn_state;
>  	int ret;
> =20
> +	pm_runtime_get_sync(dp->dev);
> +

[Severity: High]
Does this code need to check the return value of pm_runtime_get_sync()?

If the device fails to resume (for example, if the clocks fail to enable),
the driver will continue with hardware initialization routines like
dw_dp_link_enable().  Can this lead to a crash by accessing a suspended
device?

>  	connector =3D drm_atomic_get_new_connector_for_encoder(state, bridge->e=
ncoder);
>  	if (!connector) {
>  		dev_err(dp->dev, "failed to get connector\n");
>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but does returning early here cause a
phy->power_count underflow later?

If we return early because connector is NULL, or if dw_dp_link_enable() fai=
ls,
we skip powering on the PHY.  However, because atomic_enable returns void,
the DRM framework will still consider the bridge enabled and later call
dw_dp_bridge_atomic_disable(), which unconditionally executes:

	phy_power_off(dp->phy);

Could this drop the PHY's power_count below zero and permanently prevent it
from powering on during subsequent modesets?

[ ... ]

> @@ -2153,6 +2160,26 @@ void dw_dp_unbind(struct dw_dp *dp)
>  }
>  EXPORT_SYMBOL_GPL(dw_dp_unbind);
> =20
> +int dw_dp_runtime_suspend(struct dw_dp *dp)
> +{
> +	clk_disable_unprepare(dp->aux_clk);
> +	clk_disable_unprepare(dp->apb_clk);
> +
> +	return 0;
> +}

[Severity: High]
Is it safe to leave the IRQ enabled while the device is suspended?

If a spurious interrupt or a hot-plug event fires while the device is in
the RPM_SUSPENDED state, dw_dp_irq() will execute and unconditionally call:

	regmap_read(dp->regmap, DW_DP_GENERAL_INTERRUPT, &value);

Since the APB clock is disabled here, might this MMIO read hang the bus
and cause a kernel panic?

> +EXPORT_SYMBOL_GPL(dw_dp_runtime_suspend);
> +
> +int dw_dp_runtime_resume(struct dw_dp *dp)
> +{
> +	clk_prepare_enable(dp->apb_clk);
> +	clk_prepare_enable(dp->aux_clk);
> +

[Severity: High]
Should the return values of clk_prepare_enable() be checked?

If the clocks fail to enable, the function proceeds to call dw_dp_init_hw()
which accesses hardware registers via regmap.  Could this lead to a bus fau=
lt?

> +	dw_dp_init_hw(dp);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_runtime_resume);


There is also one additional pre-existing issue in a part of the file not
modified by this patch:

[Severity: High]
This is a pre-existing issue, but I noticed a potential leak in dw_dp_bind(=
):

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bind() {
	...
	next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
	if (IS_ERR(next_bridge)) {
	...
	ret =3D drm_bridge_attach(encoder, next_bridge, bridge,
				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
	...
}

Does this code leak the reference count for next_bridge?

of_drm_get_bridge_by_endpoint() returns a bridge with an incremented refcou=
nt,
and drm_bridge_attach() takes its own reference.  Should there be a call to
drm_bridge_put() to drop the initial reference so the next bridge module can
be unloaded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-synopsys-d=
w-dp-improvements-v3-0-dc61e6352508@collabora.com?part=3D7
