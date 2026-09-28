Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AFDCA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D841F10E104;
	Mon, 28 Sep 2026 16:33:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lghgg9wi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4121810E92C
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:33:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84AC560052
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8B71F00893;
 Mon, 28 Sep 2026 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790613181;
 bh=mMbGe7JCcoDMf9APuGlI4UqfkJhA2AXIvNUya5gTFB8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lghgg9wiqti3eWcWqEvwetzC26Qym4mHDk/ha6JaAhfgbfC8fuIi3MmmItNG8ROwB
 IzlPdR/Ch+YcvSSAXfRlW1+OQrYTC/+5g+aReidGVf8TYXMJ+zF9ncwcCMCe4ZPBFC
 x56HCwln00ZXLS4ZvmnIJhGGDVD07x1zlMkBhDAQHowLqQidLJKG1wO4EY18+n72qm
 nJ8wHswYIoBPToc5r2bLAs+YR7jeFMAqllb3jEfO1aXoYCtpJCAiUxf/kHj7k4frRg
 JuHTTcPOWytlRJp9mxytN8YkkO8mGUd3Dl/voGtWeTSG2VTJ17k7by46wTCOMKLw4q
 7rfRRvrKOlqzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] drm/panel: dsi-bpf: Add Raspberry Pi 5-inch panel
 BPF program
To: "Maxime Ripard" <mripard@kernel.org>
Cc: robh@kernel.org, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-5-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-5-5244926aace4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:33:00 +0000
Message-Id: <20260928163300.DF8B71F00893@smtp.kernel.org>
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
- [Medium] drm/panel: resource leak and unbalanced regulator disable on err=
or path
- [Medium] drm/panel: DCS write errors are ignored during initialization se=
quence
- [Medium] drm/panel: commit message and file content mismatch (5-inch vs 7=
-inch panel)
--

commit 6f19328aa9181fa01e0009c188e0a4fe6e32ccb1
Author: Maxime Ripard <mripard@kernel.org>

drm/panel: dsi-bpf: Add Raspberry Pi 5-inch panel BPF program
   =20
This commit translates the initialization sequence for the Raspberry Pi
5-inch MIPI-DSI panel into a BPF program.

> drm/panel: dsi-bpf: Add Raspberry Pi 5-inch panel BPF program
>=20
> Translate the raspberrypi,dsi-5inch initialization sequence from
> drivers/gpu/drm/panel/panel-ilitek-ili9881c.c into a BPF program.

[Severity: Medium]
Is there a mismatch between the commit message and the contents of this
patch? The commit message states it adds the "5-inch panel" and translates
the "raspberrypi,dsi-5inch" initialization sequence. However, the patch
actually adds a file named Raspberrypi__dsi-7inch.bpf.c containing the
7-inch initialization sequence, and uses the "raspberrypi,dsi-7inch"
compatible string.

> diff --git a/drivers/gpu/drm/panel/bpf/progs/Raspberrypi__dsi-7inch.bpf.c=
 b/drivers/gpu/drm/panel/bpf/progs/Raspberrypi__dsi-7inch.bpf.c
> new file mode 100644
> index 0000000000000..2055828de2f40
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/bpf/progs/Raspberrypi__dsi-7inch.bpf.c
> @@ -0,0 +1,271 @@
[ ... ]
> +#define PAGE(p) do {						\
> +	const __u8 _d[] =3D { 0x98, 0x81, (p) };			\
> +	panel_bpf_mipi_dsi_dcs_write(pctx, 0xff, _d, sizeof(_d));\
> +} while (0)
> +
> +#define CMD(c, d) panel_bpf_mipi_dsi_dcs_write_byte(pctx, (c), (d))

[Severity: Medium]
Do these macros ignore DCS write errors during the initialization sequence?
By discarding the return value of panel_bpf_mipi_dsi_dcs_write() and
panel_bpf_mipi_dsi_dcs_write_byte(), a failure (such as a DSI bus timeout)
will not abort the program. It will blindly continue sending over 150
commands to a potentially broken panel, sequentially timing out on each
command, which causes a massive initialization delay and falsely reports
a successful panel initialization.

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

[Severity: Medium]
Does this error path leak the previously enabled IOVCC regulator?
If panel_bpf_mipi_dsi_regulator_enable_and_wait() for VCC fails here, or if
subsequent operations like exit_sleep_mode() fail, panel_prepare() returns
an error without disabling the already-enabled IOVCC regulator or reverting
the GPIO state.

[ ... ]
> +SEC(PANEL_BPF_MIPI_DSI_UNPREPARE)
> +int BPF_PROG(panel_unprepare, struct panel_bpf_mipi_dsi_ctx *pctx)
> +{
> +	panel_bpf_mipi_dsi_set_display_off(pctx);
> +	panel_bpf_mipi_dsi_enter_sleep_mode(pctx);
> +
> +	panel_bpf_mipi_dsi_regulator_disable(pctx, PANEL_BPF_MIPI_DSI_SUPPLY_VC=
C);
> +	panel_bpf_mipi_dsi_regulator_disable(pctx, PANEL_BPF_MIPI_DSI_SUPPLY_IO=
VCC);

[Severity: Medium]
Does this unconditionally disable regulators, even on error paths?
When the DRM core tears down the pipeline following an error in
panel_prepare(), it unconditionally calls panel_unprepare(). Attempting
to disable a regulator that failed to enable (e.g., VCC) will trigger
a kernel warning for an unbalanced disable.

> +	panel_bpf_mipi_dsi_gpio_enable(pctx, PANEL_BPF_MIPI_DSI_GPIO_RESET);
> +
> +	return 0;
> +}
> +
> +PANEL_BPF_MIPI_DSI_OPS(raspberrypi_dsi_7inch) =3D {
> +	.panel_id		=3D "/soc/dsi@7e700000/panel@0",
> +	.compatible		=3D "raspberrypi,dsi-7inch",

[Severity: Medium]
Does this code explicitly configure the 7-inch panel? As mentioned in the
commit message comment, this directly contradicts the claim of adding the
5-inch panel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-drm-mipi-d=
si-panel-ebpf-v1-0-5244926aace4@kernel.org?part=3D5
