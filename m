Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B814CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A008010F66C;
	Mon,  8 Jun 2026 16:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HkSh2iyz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 712E810F66E
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:00:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51E3A41A1F
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC91C1F00893;
 Mon,  8 Jun 2026 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780934405;
 bh=S6StLvVzihFSKl6qSW+5rz+3FxzQcH+hyriKypXWyiI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HkSh2iyzy4H6D2HllD+kpW9vokMdR9/oSZ0W1aahgtUqUMtYkClWuHhvlKC3HZbsA
 PVw6YYvTIddbFckJO9KIkvpdoZmRfG+9fTTRKl1+5fwi2Rff29FAqv+7GVDbk+w6va
 wzTRfGwyzfhS8M6UBen0R/PkGp04mCiKN+C8uCcmazcuEwd43e457fHjn9oWQwhn85
 jWqLS1RBKeO5rwIynzECLAs8IOKgz5jgwM9hXZD7sECN3TOvc6oQTQEch8fQNJT0mS
 /UJqrAAgsyrS5nQF64Qe4oVyUI9fxrLwhrn3P97B6kTIneRvW7qBMquLhiM/vwzPk9
 tKAtWU6n/N7uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/78] drm/bridge: imx8qxp-pxl2dpi: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-19-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-19-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:00:04 +0000
Message-Id: <20260608160004.EC91C1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Global device state corruption in atomic_check.
--

commit e8d715f17c3f8417137a6f4c52d8a5d876a47307
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: imx8qxp-pxl2dpi: Switch to atomic_create_state

This commit replaces the deprecated atomic_reset callback and its helper
with the atomic_create_state callback and its counterpart.

> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/d=
rm/bridge/imx/imx8qxp-pxl2dpi.c
> index 87305d3e0c398..2fc9831f7e611 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> @@ -210,7 +210,7 @@ imx8qxp_pxl2dpi_bridge_atomic_get_output_bus_fmts(str=
uct drm_bridge *bridge,
>  static const struct drm_bridge_funcs imx8qxp_pxl2dpi_bridge_funcs =3D {
>  	.atomic_duplicate_state	=3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state	=3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset		=3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state		=3D drm_atomic_helper_bridge_create_state,
>  	.attach			=3D imx8qxp_pxl2dpi_bridge_attach,
>  	.destroy		=3D imx8qxp_pxl2dpi_bridge_destroy,
>  	.atomic_check		=3D imx8qxp_pxl2dpi_bridge_atomic_check,

[Severity: High]
This isn't a bug introduced by this patch, but does
imx8qxp_pxl2dpi_bridge_atomic_check() mutate global device state during the
atomic check phase?

In the DRM atomic framework, atomic_check can be executed for test-only
commits (DRM_MODE_ATOMIC_TEST_ONLY), which never proceed to the hardware
commit phase.

Looking at imx8qxp_pxl2dpi_bridge_atomic_check() in
drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c:

    p2d->in_bus_format =3D bridge_state->input_bus_cfg.format;
    p2d->out_bus_format =3D bridge_state->output_bus_cfg.format;

For non-blocking commits, the commit tail executes in a background worker
without holding modeset locks. It then calls mode_set where this state is r=
ead:

drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c:imx8qxp_pxl2dpi_bridge_mode_se=
t() {
    ...
    switch (p2d->out_bus_format) {
    ...
}

Can a concurrent test-only commit overwrite this global state while an
ongoing non-blocking commit is reading it, leading to the display hardware
being misconfigured with test-only bus formats?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D19
