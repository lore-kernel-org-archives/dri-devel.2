Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EABCD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60ABF10E1F9;
	Mon, 15 Jun 2026 06:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ERyZn/Mo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4F310E1F9
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:43:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A4DF44041;
 Mon, 15 Jun 2026 06:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A001F000E9;
 Mon, 15 Jun 2026 06:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781505785;
 bh=0w6I8VMmN9Q/iegzq4Rf7GsdRGX6rTdWBQ5+OmKoUKQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ERyZn/MomrjgXh5c/kcHssJh1b3r3UCI8JpNcsYRhZyUtDo6bUbF1evYfIk6NhTTC
 VD0fQw8XM6csS4Fu+n5fqb8QqwkcCXd8/n2gHpKrx/ROjWntULG6I+XNMrmOfDWokb
 JsjZFyXBJvb6QokG/IpJgcNztB32dm4UiABSQ0BBTkaeG1fVgxMCSln+me3+p8TOih
 emD9vvtmD9sm0/PmQ7VlCtgn/8+bInLHJsQqrZa7wxZ5R+SiI1rFvwOEao3d75HL4F
 kQGkmGcEIkjK0XAs/nFqmz7oLgV/ZHL/GbnGsSpnQmnUdHa/tXOBVTkKvlW0DciyG8
 tavHAzlY9X7rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] arm64: dts: renesas: sparrow-hawk: Enable
 DisplayPort by adding DSC
To: "Tomi Valkeinen" <tomi.valkeinen+renesas@ideasonboard.com>
Cc: wsa+renesas@sang-engineering.com, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260615-rcar-du-dsc-v4-6-93096a1b56a3@ideasonboard.com>
References: <20260615-rcar-du-dsc-v4-6-93096a1b56a3@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:43:04 +0000
Message-Id: <20260615064304.D9A001F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Incorrect PM Runtime error handling and improper use of `WARN_ON`.
- [High] DRM bridge registration occurs before PM runtime is enabled.
- [High] Blind dereference of an unvalidated bridge pointer when skipping t=
he DSC block.
- [High] Hardcoding the DSC bridge in the SoC `.dtsi` breaks the display fo=
r boards that disable the DSC.
- [Low] Call to a non-existent function `of_drm_get_bridge_by_endpoint`.
--

commit 9f241229b3364b6a9d83e1e7ed9e9076efdd0876
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

arm64: dts: renesas: sparrow-hawk: Enable DisplayPort by adding DSC

This commit enables the DisplayPort output on the sparrowhawk board by
activating the newly defined DSC block in the SoC device tree. It completes
the DSC series by wiring up the components for this specific board.

> diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/=
dts/renesas/r8a779g0.dtsi
> index 82a7278836e57..123baaea8db45 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> @@ -2298,6 +2298,35 @@ du_out_dsi0: endpoint {
>  				port@1 {
>  					reg =3D <1>;
>  					du_out_dsi1: endpoint {
> +						remote-endpoint =3D <&dsc_in_dsi1>;

[Severity: High]
Will hardcoding the remote-endpoint to the DSC bridge break the display for
boards that disable the DSC?

Because the DSC node is marked status =3D "disabled" by default below, the =
DRM
OF helpers will return -ENODEV when the DU driver traverses this graph. This
would cause the DU probe to return -EPROBE_DEFER or -ENODEV indefinitely,
breaking the display pipeline for all boards based on this SoC that do not
explicitly enable the DSC.

> +					};
> +				};
> +			};
> +		};
> +
> +		dsc: bridge@feb8d000 {
[ ... ]
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c b/drivers/gpu/drm=
/renesas/rcar-du/rcar_dsc.c
> new file mode 100644
> index 0000000000000..5a2ff31491360
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
[ ... ]
> +static void rcar_dsc_atomic_enable(struct drm_bridge *bridge,
> +				   struct drm_atomic_commit *commit)
> +{
> +	struct rcar_dsc *dsc =3D bridge_to_rcar_dsc(bridge);
> +
> +	WARN_ON(pm_runtime_get_sync(dsc->dev));

[Severity: High]
Is it safe to wrap pm_runtime_get_sync() directly in a WARN_ON()?

If the device is already active, pm_runtime_get_sync() returns 1, which will
falsely trigger a warning and stack trace here on valid hot paths. If the
function returns a negative error code, the warning is printed but the
PM usage counter is not decremented, leaking the PM reference and attempting
to configure an unpowered device.

> +}
[ ... ]
> +static int rcar_dsc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct rcar_dsc *dsc;
> +	int ret;
> +
> +	dsc =3D devm_drm_bridge_alloc(dev, struct rcar_dsc, bridge,
> +				    &rcar_dsc_bridge_ops);
> +	if (IS_ERR(dsc))
> +		return PTR_ERR(dsc);
> +
> +	platform_set_drvdata(pdev, dsc);
> +
> +	dsc->dev =3D &pdev->dev;
> +
> +	dsc->bridge.next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node,
> +								1, 0);

[Severity: Low]
Could you clarify if the function of_drm_get_bridge_by_endpoint() exists in
the kernel tree?

It appears the correct API might be devm_drm_of_get_bridge() or
drm_of_find_panel_or_bridge(). Using a non-existent function will cause an
immediate build failure due to -Werror=3Dimplicit-function-declaration.

> +	if (IS_ERR(dsc->bridge.next_bridge))
> +		return PTR_ERR(dsc->bridge.next_bridge);
> +
> +	dsc->bridge.of_node =3D dev->of_node;
> +
> +	ret =3D devm_drm_bridge_add(dev, &dsc->bridge);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(&pdev->dev);

[Severity: High]
Can registering the DRM bridge before enabling PM runtime introduce a race
condition?

Calling devm_drm_bridge_add() exposes the bridge globally to other drivers
like the DU driver while its PM runtime is still disabled. If another driver
attaches and enables the bridge during this window, pm_runtime_get_sync() w=
ill
fail with -EACCES.

> +
> +	return 0;
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu=
/drm/renesas/rcar-du/rcar_du_crtc.c
> index 1a246ebbfc613..5679983fc4d1a 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> @@ -754,6 +754,15 @@ static void rcar_du_crtc_atomic_enable(struct drm_cr=
tc *crtc,
>  	     (BIT(RCAR_DU_OUTPUT_DSI0) | BIT(RCAR_DU_OUTPUT_DSI1)))) {
>  		struct drm_bridge *bridge =3D rcdu->dsi[rcrtc->index];
> =20
> +		/*
> +		 * When we have a DSC block between the DU and the DSI,
> +		 * the "bridge" points to the DSC. Detect the DSC by looking
> +		 * at the bridge type, and skip the DSC if the bridge is not
> +		 * the DSI bridge.
> +		 */
> +		if (bridge->type !=3D DRM_MODE_CONNECTOR_DSI)
> +			bridge =3D bridge->next_bridge;
> +
>  		rcar_mipi_dsi_pclk_enable(bridge, state);

[Severity: High]
What prevents a blind dereference of bridge->next_bridge from causing an
invalid pointer computation here?

If next_bridge is NULL (e.g., due to a disconnected or missing OF graph nod=
e)
or is not a MIPI DSI bridge, passing it into rcar_mipi_dsi_pclk_enable() wi=
ll
cause bridge_to_rcar_mipi_dsi() to compute an invalid pointer via
container_of. This regression could result in memory corruption or an
immediate system crash.

>  	}
> =20
> @@ -796,6 +805,15 @@ static void rcar_du_crtc_atomic_disable(struct drm_c=
rtc *crtc,
>  	     (BIT(RCAR_DU_OUTPUT_DSI0) | BIT(RCAR_DU_OUTPUT_DSI1)))) {
>  		struct drm_bridge *bridge =3D rcdu->dsi[rcrtc->index];
> =20
> +		/*
> +		 * When we have a DSC block between the DU and the DSI,
> +		 * the "bridge" points to the DSC. Detect the DSC by looking
> +		 * at the bridge type, and skip the DSC if the bridge is not
> +		 * the DSI bridge.
> +		 */
> +		if (bridge->type !=3D DRM_MODE_CONNECTOR_DSI)
> +			bridge =3D bridge->next_bridge;
> +
>  		/*
>  		 * Disable the DSI clock output, see
>  		 * rcar_du_crtc_atomic_enable().

[Severity: High]
Similarly to the enable path, is this unchecked dereference of
bridge->next_bridge safe in the disable path?

If next_bridge is NULL or not a MIPI DSI bridge, it will be passed to
rcar_mipi_dsi_pclk_disable() where bridge_to_rcar_mipi_dsi() will compute an
invalid pointer, leading to a similar regression where memory is corrupted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-rcar-du-ds=
c-v4-0-93096a1b56a3@ideasonboard.com?part=3D6
