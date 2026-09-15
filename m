Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286A6C88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681DE10E590;
	Tue, 15 Sep 2026 09:26:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104B410E590
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:26:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E9C1602BA;
 Tue, 15 Sep 2026 09:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21881F000FF;
 Tue, 15 Sep 2026 09:26:31 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, devarsht@ti.com, dri-devel@lists.freedesktop.org,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, jyri.sarha@iki.fi,
 laurent.pinchart+renesas@ideasonboard.com,
 maarten.lankhorst@linux.intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, simona@ffwll.ch, tomi.valkeinen@ideasonboard.com,
 tzimmermann@suse.de
Subject: Re: [PATCH v5 06/33] drm/bridge: Implement atomic_print_state
Date: Tue, 15 Sep 2026 11:26:30 +0200
Message-ID: <20260915092630.1708458-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907-drm-state-readout-v5-6-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-6-5fa1ac7a5148@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

	Hi Maxime,

> Bridges have some fields in their state worth printing, but we don't
> provide an atomic_print_state implementation to show those fields.
> 
> Provide one.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Thanks for your patch, which is now commit 4a7a146f1cc6791a
("drm/bridge: Implement atomic_print_state") in drm-misc/for-linux-next.

> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -548,14 +548,35 @@ drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
>  		return ERR_CAST(state);
>  
>  	return &state->base;
>  }
>  
> +static void
> +drm_bridge_atomic_print_priv_state(struct drm_printer *p,
> +				   const struct drm_private_state *s)
> +{
> +	const struct drm_bridge_state *state = drm_priv_to_bridge_state(s);

warning: passing argument 1 of ‘drm_priv_to_bridge_state’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]

Apparently you lost "[PATCH v2 4/28] drm/atomic: Convert
drm_priv_to_bridge_state to container_of_const"[1] along the way?

> +	struct drm_bridge *bridge = drm_priv_to_bridge(s->obj);
> +
> +	if (bridge->of_node)
> +		drm_printf(p, "bridge: %ps (%pOFfc)\n", bridge->funcs, bridge->of_node);
> +	else
> +		drm_printf(p, "bridge: %ps\n", bridge->funcs);
> +
> +	drm_printf_indent(p, 1, "input bus configuration:");
> +	drm_printf_indent(p, 2, "code: %04x", state->input_bus_cfg.format);
> +	drm_printf_indent(p, 2, "flags: %08x", state->input_bus_cfg.flags);
> +	drm_printf_indent(p, 1, "output bus configuration:");
> +	drm_printf_indent(p, 2, "code: %04x", state->output_bus_cfg.format);
> +	drm_printf_indent(p, 2, "flags: %08x", state->output_bus_cfg.flags);
> +}
> +

[1] https://lore.kernel.org/20260423-drm-state-readout-v2-4-8549f87cb978@kernel.org

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
