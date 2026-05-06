Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B61CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 20:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF7910E56D;
	Wed,  6 May 2026 20:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rbLUgKWn";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94EA110E56D
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 20:08:29 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF7A063D;
 Wed,  6 May 2026 22:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778098105;
 bh=tRKQs92pxOQZrOxm0RULdGhIjq+BMn75AXREg8GQbBs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rbLUgKWnqgb6d+kkmtRa0/EWv2PH7VPZh7cQsnl+Ye8YP43TUcZXMvRJ43U+NbJnp
 3qFBwDPHCBZtXzdThjNxE353G3lv38ESWulKLx0BSHlosMqgffVjnEdTsk9ZJDwhUv
 vQg2sG4LWo8ZWPTvFLumzwQwiJ23AJkUEJNuClOk=
Date: Wed, 6 May 2026 23:08:26 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 2/4] drm: renesas: rz-du: Make DU reset control optional
 for RZ/T2H support
Message-ID: <20260506200826.GB1652535@killaraus.ideasonboard.com>
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260429170012.366537-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429170012.366537-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Apr 29, 2026 at 06:00:10PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Update the DU CRTC initialisation to request the reset control using
> devm_reset_control_get_optional_shared(). On RZ/T2H SoCs the DU block does
> not expose a reset line, and treating the reset as mandatory prevents the
> driver from probing on those platforms.

This assume a device tree compliant with the bindings. In case of a
non-compliant device tree on platforms other than RZ/T2H, the driver may
silently fail to work as it won't complain about the lack of reset. I
think that's acceptable, as the reset should be specified in the SoC's
.dtsi. If if was the responsibility of board DT authors I would be a bit
more concerned.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> index 18e2b981b691..2b772a11c7ee 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> @@ -380,7 +380,7 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
>  	struct drm_plane *primary;
>  	int ret;
>  
> -	rcrtc->rstc = devm_reset_control_get_shared(rcdu->dev, NULL);
> +	rcrtc->rstc = devm_reset_control_get_optional_shared(rcdu->dev, NULL);
>  	if (IS_ERR(rcrtc->rstc)) {
>  		dev_err(rcdu->dev, "can't get cpg reset\n");
>  		return PTR_ERR(rcrtc->rstc);

-- 
Regards,

Laurent Pinchart
