Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FDCCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 00:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC64010E139;
	Mon, 15 Jun 2026 00:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VN22ZDVY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAEE10E139
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 00:17:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7FE984088A;
 Mon, 15 Jun 2026 00:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C39A1F000E9;
 Mon, 15 Jun 2026 00:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781482640;
 bh=TeleR8b6oZ63JIpS+Q77i0lyZ3TTh1J6938G8aEtEKE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VN22ZDVYcSvPC9MLeTRhxVlJlrRIef5mqIgcl2/tPd7FX1WUwJlF5/Y0uGAYueeVZ
 N51QtimnYvGn4zaJ6v6JxfObGVIC45Z0yas2wDiYdqYcZnFH9lrwVrDB+2uNh9pUdr
 Yu85pWbBM4VKC5ept52U3g6s6f22ur8ZMOPNNVNseiAICOt3zPxsz6SNVP+ZfrKkr6
 Aq524M9JSjU4Et/utX5CIhxLvR/AeqgrmjYUB4l3xUCSKHrqq1d0qzqK6Tn9n3OnT4
 IoC4gHl2Df6AFjfFDRMr7HRfHsy2xrnARjjj/fPRxP+E10/3cNs17N4RYkSYb52+i4
 M9rhrbRk8f1Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] Revert "dt-bindings: display: panel:
 panel-simple: Add lg,sw49410 compatible"
To: "Paul Sajna" <sajattack@postmarketos.org>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260614-judyln-panel-v3-4-07f4134441bd@postmarketos.org>
References: <20260614-judyln-panel-v3-4-07f4134441bd@postmarketos.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:17:19 +0000
Message-Id: <20260615001720.1C39A1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing drm_panel_remove() on the mipi_dsi_attach() error path in =
probe causes a Use-After-Free.
- [High] Panel reset is erroneously asserted before sending DSI sleep comma=
nds in the unprepare sequence.
--

commit 591497f012912dfaa02eb5ec6c5c1e0d8e61f126
Author: Paul Sajna <sajattack@postmarketos.org>

Revert "dt-bindings: display: panel: panel-simple: Add lg,sw49410 compatibl=
e"

This reverts commit a74c2e55ab66519ffa2069ac9ae83cd937bff4c4. The panel
isn't actually panel-simple-compatible.

> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple=
.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 3e41ed0ef5d51..1abdc8698a865 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -200,8 +200,6 @@ properties:
>        - lemaker,bl035-rgb-002
>          # LG 7" (800x480 pixels) TFT LCD panel
>        - lg,lb070wv8
> -        # LG 6.1" (1440x3120) IPS LCD panel
> -      - lg,sw49410

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the sw49410
panel driver code, I noticed a missing drm_panel_remove() on the
mipi_dsi_attach() error path in probe which causes a use-after-free:

drivers/gpu/drm/panel/panel-lg-sw49410.c:sw49410_panel_probe() {
	drm_panel_add(&ctx->panel);

	/* This panel only supports DSC; unconditionally enable it */
	dsi->dsc =3D &ctx->dsc;
...
	return mipi_dsi_attach(dsi);
}

If mipi_dsi_attach() fails, the function returns an error without calling
drm_panel_remove(). Because ctx was allocated with devm_drm_panel_alloc(),
the kernel devres mechanism will free ctx upon probe failure.

This leaves a dangling pointer in the global panel_list. Any subsequent
operations iterating over panel_list (such as another driver calling
drm_panel_get()) will dereference the freed memory, causing a
use-after-free kernel panic.

Could we add a call to drm_panel_remove() to the error path here?

[Severity: High]
This is a pre-existing issue, but the panel reset is erroneously asserted
before sending DSI sleep commands in the unprepare sequence:

drivers/gpu/drm/panel/panel-lg-sw49410.c:sw49410_panel_unprepare() {
	gpiod_set_value(ctx->reset_gpio, 1);
	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };

	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
}

The reset GPIO is asserted (gpiod_set_value(ctx->reset_gpio, 1)) before
executing the MIPI DCS sleep commands.

Attempting to send MIPI DCS commands to a panel that is held in hardware
reset will cause the DSI host to fail to communicate, resulting in severe
command timeouts and error logs. The unprepare sequence is functionally
broken because the panel cannot gracefully enter sleep mode.

Should the panel reset be delayed until after the DSI sleep commands are
sent?

>          # Logic Technologies LT161010-2NHC 7" WVGA TFT Cap Touch Module
>        - logictechno,lt161010-2nhc

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-judyln-pan=
el-v3-0-07f4134441bd@postmarketos.org?part=3D4
