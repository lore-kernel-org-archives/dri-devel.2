Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9EECD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F9F11A902;
	Fri,  5 Jun 2026 14:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V0uQ+uw+";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF6F11A903
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:36:47 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 168D721CD;
 Fri,  5 Jun 2026 16:36:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780670181;
 bh=1CqE6pEwSMtAxSWjLt49Lx0CVN9yZ7vzPMiK8AOIfZE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V0uQ+uw+kNVo71pAhXivfFtZgdFfAyRlvS5f/L8KX+pECzmWDphu2KBUCbJtdty8p
 kgGVlbSspgwgHoT0t/0JfH7mxcuLdPcC01Ov0OBVSPw/DjoaC4Efm+t1ogBGwCjeMo
 lTNn5pL5gcB9QWuMzQ34ogt9ZAfXKZgLmKe05zQY=
Date: Fri, 5 Jun 2026 17:36:45 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 10/76] drm/bridge: display-connector: Switch to
 atomic_create_state
Message-ID: <20260605143645.GJ84912@killaraus.ideasonboard.com>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-10-875d828d31bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-10-875d828d31bc@kernel.org>
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

On Sat, May 30, 2026 at 03:59:15PM +0200, Maxime Ripard wrote:
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
> 
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/display-connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index 16c0631adeb1..e849037c64ea 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -181,11 +181,11 @@ static const struct drm_bridge_funcs display_connector_bridge_funcs = {
>  	.edid_read = display_connector_edid_read,
>  	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
>  	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset = drm_atomic_helper_bridge_reset,
> +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
>  };
>  
>  static irqreturn_t display_connector_hpd_irq(int irq, void *arg)
>  {
>  	struct display_connector *conn = arg;
> 

-- 
Regards,

Laurent Pinchart
