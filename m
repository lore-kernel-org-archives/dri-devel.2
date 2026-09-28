Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5BCCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BFD10E921;
	Mon, 28 Sep 2026 16:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BeO/4MUw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3639710E92C
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:34:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FDB643B60
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F991F000FF;
 Mon, 28 Sep 2026 16:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790613289;
 bh=snDNqTDL/oJXYMFuA2WlII1ivNZydYy4O+2TE42Tyv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BeO/4MUwCYHjJ4EKTMCWBOUW/UK8A/Z5OL4LitXL2Kf2zC8PWGB1unQyhzwLaLks7
 M0TrF5iDdUvgcbMDUBdhTs0d9tiz9Vou4VXrjpTQdPi56Y0TRrUZb94v7DbcL6iUtH
 c/R4ALp8Qv3SvzJ+oaGYIDdCl0/xJl5xZ9mDvD8A3/bTuvgHSaZCGltR2g2UbdUVPM
 e60uOcJL90g1bmvio2V2mg1SdEOFiJiHLCooa1s+cWFPHGKQzr9yoLXfnE/cbbGEQi
 IkES5XIhLc/ykWIGUuyl9RJoyBJXGPbh82PFP53NWsTPyQ0FHwmToJIxLrgdrkKcvA
 LqEvUAP4oyymQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] drm/panel: dsi-bpf: Add Raspberry Pi 7-inch panel
 BPF program
To: "Maxime Ripard" <mripard@kernel.org>
Cc: bpf@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-4-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-4-5244926aace4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:34:48 +0000
Message-Id: <20260928163448.C2F991F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] drm/panel: panel_prepare aborts prematurely due to positive re=
turn check
- [High] drm/panel: IOVCC regulator leaked in panel_prepare error path
- [Medium] drm/panel: commit message and implementation mismatch
- [Medium] drm/panel: DCS write errors silently ignored by PAGE/CMD macros
--

commit 2f8c8459c9b015745342c7329f8ef342082a4f1a
Author: Maxime Ripard <mripard@kernel.org>
drm/panel: dsi-bpf: Add Raspberry Pi 7-inch panel BPF program

This commit introduces a BPF program for initializing a Raspberry Pi MIPI-D=
SI
panel. The patch translates a C-based DCS sequence into BPF macros.

> drm/panel: dsi-bpf: Add Raspberry Pi 7-inch panel BPF program
>
> Translate the raspberrypi,dsi-7inch initialization sequence from
> drivers/gpu/drm/panel/panel-ilitek-ili9881c.c into a BPF program.

[Severity: Medium]
The commit message explicitly claims to add the "Raspberry Pi 7-inch panel
BPF program" and translates the 7-inch sequence. However, as seen in the
code below, it implements the 5-inch variant. Should the commit message be
updated to match the implemented code?

> diff --git a/drivers/gpu/drm/panel/bpf/progs/Raspberrypi__dsi-5inch.bpf.c=
 b/drivers/gpu/drm/panel/bpf/progs/Raspberrypi__dsi-5inch.bpf.c
> new file mode 100644
> index 0000000000000..1f9ff7f2fd3ce
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/bpf/progs/Raspberrypi__dsi-5inch.bpf.c
> @@ -0,0 +1,266 @@

[ ... ]

> +#define PAGE(p) do {						\
> +	const __u8 _d[] =3D { 0x98, 0x81, (p) };			\
> +	panel_bpf_mipi_dsi_dcs_write(pctx, 0xff, _d, sizeof(_d));\
> +} while (0)
> +
> +#define CMD(c, d) panel_bpf_mipi_dsi_dcs_write_byte(pctx, (c), (d))

[Severity: Medium]
Do these macros need to check the return value of panel_bpf_mipi_dsi_dcs_wr=
ite()
and panel_bpf_mipi_dsi_dcs_write_byte()?=20

By dropping the error codes, if a DSI transmission fails during the command
sequence, it seems the BPF program will continue blindly instead of aborting
the initialization.

[ ... ]

> +SEC(PANEL_BPF_MIPI_DSI_PREPARE)
> +int BPF_PROG(panel_prepare, struct panel_bpf_mipi_dsi_ctx *pctx)
> +{
> +	int ret;
> +
> +	ret =3D panel_bpf_mipi_dsi_regulator_enable_and_wait(pctx, PANEL_BPF_MI=
PI_DSI_SUPPLY_IOVCC, 5);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D panel_bpf_mipi_dsi_regulator_enable_and_wait(pctx, PANEL_BPF_MI=
PI_DSI_SUPPLY_VCC, 5);
> +	if (ret)
> +		return ret;

[Severity: High]
If enabling the VCC regulator fails here, does this code leak the previously
enabled IOVCC regulator's enable count? It looks like we return immediately
without calling panel_bpf_mipi_dsi_regulator_disable() to disable IOVCC.

[ ... ]

> +	/* set_tear_on with VBLANK mode (0x00) */
> +	CMD(0x35, 0x00);
> +
> +	ret =3D panel_bpf_mipi_dsi_exit_sleep_mode(pctx);
> +	if (ret)
> +		return ret;

[Severity: Critical]
Does panel_bpf_mipi_dsi_exit_sleep_mode() return a positive number of bytes=
 on
success?=20

Since it calls panel_bpf_mipi_dsi_dcs_write_and_wait(), which forwards the
underlying mipi_dsi_dcs_write() result, a successful write would make ret >=
 0.
This check would then evaluate to true on a successful transmission, causing
panel_prepare() to abort prematurely before enabling the display.

[ ... ]

> +PANEL_BPF_MIPI_DSI_OPS(raspberrypi_dsi_5inch) =3D {
> +	.panel_id		=3D "/soc/dsi@7e700000/panel@0",
> +	.compatible		=3D "raspberrypi,dsi-5inch",

[Severity: Medium]
This isn't a code regression, but this compatible string and struct name bi=
nd
the program strictly to the 5-inch panel, which contradicts the stated purp=
ose
in the commit message.

> +	.format			=3D MIPI_DSI_FMT_RGB888,
> +	.lanes			=3D 2,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-drm-mipi-d=
si-panel-ebpf-v1-0-5244926aace4@kernel.org?part=3D4
