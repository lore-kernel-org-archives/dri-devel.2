Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFE5CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F37F10EB99;
	Thu, 15 Oct 2026 08:58:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6476110EB99
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7E786020C;
 Thu, 15 Oct 2026 08:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A971F000C5;
 Thu, 15 Oct 2026 08:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792054716;
 bh=6ScGbKzoQk6kt031p4ergyEXmem4bbvoSzyBwTHYZBs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NTcx0IbGHb87TdJvz9+Q38zXRgQMQbcx/IGbeVjNYdDl9R5M/yTVT0eUuDfwKlP/P
 PU+KRt/TsmtlUSBCuBv38pWzVswXlACqJvR2JT62KLUFIJhq0QASWTMRKXrmUv2f7g
 lAcS12NOi9bJAFspQ8Vbg1GnWxO/DG0auMtBcEn7GD+9wChwIVJjBhAex4wnTSZ7Y5
 fWk6lOZ8FYR95ZNJ4mSflrZMWDYl2yNpsIbD7BiNnjR4DR+hDGwf3HrIckhlqV79vD
 M4jBrUKTN0xrIaG8ci09Yi/0rsA4lkXE2av3kheNwH9xZ82Rk6ZWxpYVnLMZlP9cV6
 Sdr44savxrSeg==
Message-ID: <sashiko-outbox-172528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] drm/panel: add Novatek NT36850 panel driver
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261015-sdm845-hdk-v4-2-b532b9f4029c@oss.qualcomm.com>
References: <20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com>
 <20261015-sdm845-hdk-v4-2-b532b9f4029c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 08:58:35 +0000
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
- [Medium] drm/panel: nt36850: variable shadowing in nt36850_disable() mask=
s DCS errors
- [Medium] drm/panel: nt36850: unconditional dereference of dsi1 in nt36850=
_disable() breaks single-DSI
--

commit 08efb97fa82649f7024ae6605a2b0d90177ccd63
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/panel: add Novatek NT36850 panel driver
   =20
Add support for the Truly WQHD dual-DSI command mode panel built around
the Novatek NT36850, found on the display card for the Qualcomm SDM845
and SM8150 HDK.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36850.c b/drivers/gpu/=
drm/panel/panel-novatek-nt36850.c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36850.c
> @@ -0,0 +1,351 @@
> [ ... ]
> +static int nt36850_disable(struct drm_panel *panel)
> +{
> +	struct panel_info *pinfo =3D to_panel_info(panel);
> +	struct mipi_dsi_device *dsi0 =3D pinfo->dsi[0];
> +	struct mipi_dsi_device *dsi1 =3D pinfo->dsi[1];
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D NULL };
> +
> +	dsi0->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +	dsi1->mode_flags &=3D ~MIPI_DSI_MODE_LPM;

[Severity: Medium]
Does this code introduce a regression by unconditionally dereferencing
a NULL pointer if a single-DSI panel is supported in the future?

The dynamic nt36850_num_dsi_hosts check later in this function implies
it is intended to support single-DSI setups, but dsi1 is used directly
here without verification.

> +
> +	for (int i =3D 0; i < nt36850_num_dsi_hosts(pinfo); i++) {
> +		struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D pinfo->dsi[i]};
> +
> +		mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	}

[Severity: Medium]
Is it a regression that the inner dsi_ctx shadows the function-scoped
dsi_ctx?

By declaring a new dsi_ctx inside the loop, the error state from
mipi_dsi_dcs_set_display_off_multi gets instantly discarded when the
block ends, rather than accumulating.

> +	mipi_dsi_msleep(&dsi_ctx, 120);

[Severity: Medium]
Because the inner dsi_ctx shadowed the outer one, does this blindly
execute the delay using the unmodified outer context, even if the display
off sequence commands failed?

> +
> +	for (int i =3D 0; i < nt36850_num_dsi_hosts(pinfo); i++) {
> +		struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D pinfo->dsi[i]};
> +
> +		mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	}
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	dsi0->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +	dsi1->mode_flags |=3D MIPI_DSI_MODE_LPM;

[Severity: Medium]
Could this result in another NULL pointer dereference regression for
single-DSI panels here when restoring the mode flags?

> +
> +	return dsi_ctx.accum_err;
> +}

[Severity: Medium]
Since the function-level dsi_ctx remains unmodified throughout, will
this always return 0 and mask any hardware failures that occurred during
the disable sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-sdm845-hdk=
-v4-0-b532b9f4029c@oss.qualcomm.com?part=3D2
