Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A40CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 23:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0D910E213;
	Wed, 13 May 2026 23:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jE3nXNqi";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8DC10E213
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 23:02:11 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 82B431254;
 Thu, 14 May 2026 01:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778713321;
 bh=SHh2aALu1pl+Vmo9IUEZBoKhnQcX+ERSQJCsG5eFRCY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jE3nXNqiVNqQbeutRQwWOxeZdyD81bjETBDtL2BpX87UEdv3f1z0XUXICMHnntdbg
 pCDmiHJnsfkpQQr4F/tcCTmTdr5Kx4RtnH1KqjLAYKnmb0B5/Xx7eDQLCtDCk/W1Tt
 37bmPQhugTzx/HRfhzhtE1n9SzJcU4N9Q6mtWkV8=
Date: Thu, 14 May 2026 02:02:08 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 4/5] drm: renesas: rz-du: Move mode_valid logic to
 per-output clock limits
Message-ID: <20260513230208.GB291825@killaraus.ideasonboard.com>
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260512144104.761531-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512144104.761531-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

Thank you for the patch.

On Tue, May 12, 2026 at 03:41:03PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Move pixel clock validation from a fixed encoder check to per-output
> constraints stored in rzg2l_du_output_routing.
> 
> Previously, rzg2l_du_encoder_mode_valid() applied a hard-coded 83.5 MHz
> upper limit specifically for DPAD0. This approach cannot scale across the
> RZ DU family because pixel clock limits vary per SoC and per output
> interface.
> 
> Add mode_clock_min and mode_clock_max fields to rzg2l_du_output_routing
> so that clock constraints are expressed at the granularity of individual
> output interfaces rather than globally per SoC. Update
> rzg2l_du_encoder_mode_valid() to look up the routing entry for the active
> output and return MODE_CLOCK_LOW or MODE_CLOCK_HIGH when the pixel clock
> falls outside the declared range. A value of 0 for either field means no
> bound is enforced in that direction.
> 
> Set the DPAD0 pixel clock limits for RZ/G2UL (R9A07G043U) to 20.875 MHz
> minimum and 83.5 MHz maximum. RZ/G2L and RZ/G2LC (R9A07G044) share the
> same DPAD0 pixel clock limits.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3:
> - Moved clock limits from device_info to output_routing to allow
>   per-output constraints.

Given that the DU has a single output, connected to multiple encoders,
is the clock frequency limitation really a *per-output* property of the
DU ? Clock constraints coming from encoders can be expressed in the
respective bridge drivers (and the DSI encoder driver does so already).

> - Updated commit message to reflect the change in approach.
> 
> v1->v2:
> - Dropped storing info pointer in struct rzg2l_du_encoder as it's not needed.
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 4 ++++
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 6 +++++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> index 0fef33a5a089..d1bc205eb5f8 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -33,6 +33,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g043u_info = {
>  		[RZG2L_DU_OUTPUT_DPAD0] = {
>  			.possible_outputs = BIT(0),
>  			.port = 0,
> +			.mode_clock_min = 20875,
> +			.mode_clock_max = 83500,
>  		},
>  	},
>  };
> @@ -47,6 +49,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
>  		[RZG2L_DU_OUTPUT_DPAD0] = {
>  			.possible_outputs = BIT(0),
>  			.port = 1,
> +			.mode_clock_min = 20875,
> +			.mode_clock_max = 83500,
>  		}
>  	}
>  };
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> index 58806c2a8f2b..307ae70dd382 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> @@ -30,6 +30,8 @@ enum rzg2l_du_output {
>   * struct rzg2l_du_output_routing - Output routing specification
>   * @possible_outputs: bitmask of possible outputs
>   * @port: device tree port number corresponding to this output route
> + * @mode_clock_min: minimum pixel clock in kHz
> + * @mode_clock_max: maximum pixel clock in kHz
>   *
>   * The DU has 2 possible outputs (DPAD0, DSI0). Output routing data
>   * specify the valid SoC outputs, which CRTC can drive the output, and the type
> @@ -38,6 +40,8 @@ enum rzg2l_du_output {
>  struct rzg2l_du_output_routing {
>  	unsigned int possible_outputs;
>  	unsigned int port;
> +	int mode_clock_min;
> +	int mode_clock_max;
>  };
>  
>  /*
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> index 0e567b57a408..4af2ae09ff39 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> @@ -50,8 +50,12 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
>  			    const struct drm_display_mode *mode)
>  {
>  	struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
> +	struct rzg2l_du_device *rcdu = to_rzg2l_du_device(renc->base.dev);
> +	const struct rzg2l_du_output_routing *route = &rcdu->info->routes[renc->output];
>  
> -	if (renc->output == RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83500)
> +	if (route->mode_clock_min && mode->clock < route->mode_clock_min)
> +		return MODE_CLOCK_LOW;
> +	if (route->mode_clock_max && mode->clock > route->mode_clock_max)
>  		return MODE_CLOCK_HIGH;
>  
>  	return MODE_OK;

-- 
Regards,

Laurent Pinchart
