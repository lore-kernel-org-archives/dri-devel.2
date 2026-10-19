Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE85CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6E110E4D6;
	Mon, 19 Oct 2026 10:36:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C7D10E4D6
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:36:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87227600CB;
 Mon, 19 Oct 2026 10:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F6E1F000C4;
 Mon, 19 Oct 2026 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792406170;
 bh=PI9AeKxwP0CwhGbVllNbx6krpwtM2PRvUhXT8Vzgt5M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NGb2tfKGnDil3eYBe7ZpO4AmaGnOXX2vMjzwldNag7D3T1wlMkCSK0DcZxZh8Jdhr
 eVdf4ajMa9vNotnWujq1qzu4sh2zKR1AvtODC0Wu3TSLnPbGen1OIiyGlxBm7KxNHR
 vkmymdGjq+Mx0ZxBsSiDSX2cS7VUElLVg2yY9YJp2xn3GA66s/RukJ5KsdqDwAgK6Y
 vZl+0d1jUDyyr1f5arLLUZ+zwGhyYuEBV2TAPCP9P/NKZceWY5mpEeB0iBykBBcxrl
 D1iwOseVSHRH6QZX4xYxA1ivwthJsx0FgeBBxFFYxdiKiy1CRW+J+r/osTUqFwG66O
 Xu/ruwb0r72ag==
Message-ID: <sashiko-outbox-177001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6q-apalis: Add VGA overlay
To: "Leonardo Costa" <leoreis.costa@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261019-v2-apalis-imx6-enable-vga-v2-3-ef6a3a780472@toradex.com>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-3-ef6a3a780472@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:36:09 +0000
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
- [High] ARM: dts: imx6q-apalis: VGA data-enable-active ignored by simple-b=
ridge
--

commit a66c8dd73182954ba43ed81cada90ae73edf93a0
Author: Leonardo Costa <leonardo.costa@toradex.com>

ARM: dts: imx6q-apalis: Add VGA overlay

This commit adds a device tree overlay for the VGA output on the Apalis
Evaluation Board, connecting the parallel RGB display interface to a
non-programmable video DAC and VGA connector with an active-low data-enable
signal, and wires up composite DTB targets in the Makefile.

> diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso b/arch/=
arm/boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso
> new file mode 100644
> index 0000000000000..991c2b7c27773
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso
> @@ -0,0 +1,80 @@

[ ... ]

> +	vga-encoder {
> +		compatible =3D "dumb-vga-dac";
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@0 {
> +				reg =3D <0>;
> +
> +				vga_enc_in: endpoint {
> +					data-enable-active =3D <0>;
> +					remote-endpoint =3D <&vga_display_out>;
> +				};
> +			};

[Severity: High]
Does data-enable-active =3D <0> on vga_enc_in actually reach the IPUv3
CRTC?

In simple_bridge_probe() in drivers/gpu/drm/bridge/simple-bridge.c, the
data-enable-active property is parsed into timings->input_bus_flags:

	if (de_present && !sbridge->bridge.timings) {
		struct drm_bridge_timings *timings;

		timings =3D devm_kzalloc(&pdev->dev, sizeof(*timings), GFP_KERNEL);
		if (!timings)
			return -ENOMEM;

		timings->input_bus_flags =3D de ? DRM_BUS_FLAG_DE_HIGH :
						DRM_BUS_FLAG_DE_LOW;
		sbridge->bridge.timings =3D timings;
	}

However, simple_bridge_bridge_funcs registers atomic bridge state
callbacks without an .atomic_check callback:

static const struct drm_bridge_funcs simple_bridge_bridge_funcs =3D {
	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
	.attach		=3D simple_bridge_attach,
	.atomic_enable =3D simple_bridge_enable,
	.atomic_disable =3D simple_bridge_disable,
};

During drm_atomic_bridge_chain_check() ->
drm_atomic_bridge_propagate_bus_flags(), sbridge's
bridge_state->input_bus_cfg.flags is overwritten with the downstream
display-connector bridge's input_bus_cfg.flags (which is 0), and
sbridge->bridge.timings->input_bus_flags is never copied into
bridge_state->input_bus_cfg.flags.

Then, upstream in imx_pd_bridge_atomic_check() in
drivers/gpu/drm/imx/ipuv3/parallel-display.c:

	if (next_bridge)
		next_bridge_state =3D drm_atomic_get_new_bridge_state(crtc_state->state,
								    next_bridge);

	if (next_bridge_state)
		bus_flags =3D next_bridge_state->input_bus_cfg.flags;
	else
		bus_flags =3D di->bus_flags;

Because next_bridge_state is non-NULL, bus_flags is read as 0 from
next_bridge_state->input_bus_cfg.flags without consulting
next_bridge->timings->input_bus_flags.

When ipu_crtc_mode_set_nofb() -> ipu_di_init_sync_panel() runs,
sig_cfg.enable_pol =3D !(imx_crtc_state->bus_flags & DRM_BUS_FLAG_DE_LOW)
evaluates to 1, driving the data-enable pin active-high instead of
active-low and gating off the VGA DAC output during active video.

Should simple-bridge implement .atomic_check to populate
bridge_state->input_bus_cfg.flags from bridge->timings->input_bus_flags
 so the active-low polarity is propagated to imx-parallel-display?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-v2-apalis-=
imx6-enable-vga-v2-0-ef6a3a780472@toradex.com?part=3D3
