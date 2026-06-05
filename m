Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F584CD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75AD11A910;
	Fri,  5 Jun 2026 14:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LO8PM+Zv";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C0311A90F
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:40:22 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D78D1B9A;
 Fri,  5 Jun 2026 16:39:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780670395;
 bh=kVi5IRL01kjYIyrgz7OCAhvXQmYm7TBykopjcZ8ZJm8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LO8PM+Zv5xgrpYCDpiyQNTBwFDyYlBvXBGyMzoKGdEzY7y4DIXFuy7KXXXsPmzaHU
 7m0yjoUBBt2NVo8iT6yrlzl8eK7nMnl1oC41XCrtVoBi8lhe5JxFOvk/3AdYsHKS3s
 +YDYbNZWo8gHrW51Ll2XgFra/eBM0/ryzvMQBmMQ=
Date: Fri, 5 Jun 2026 17:40:19 +0300
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
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 Biju Das <biju.das.jz@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 61/76] drm/renesas: rz-du: mipi_dsi: Switch to
 atomic_create_state
Message-ID: <20260605144019.GO84912@killaraus.ideasonboard.com>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-61-875d828d31bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-61-875d828d31bc@kernel.org>
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

On Sat, May 30, 2026 at 04:00:06PM +0200, Maxime Ripard wrote:
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
> 
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index a2c864860075..0590ade96b91 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1107,11 +1107,11 @@ rzg2l_mipi_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  
>  static const struct drm_bridge_funcs rzg2l_mipi_dsi_bridge_ops = {
>  	.attach = rzg2l_mipi_dsi_attach,
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset = drm_atomic_helper_bridge_reset,
> +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
>  	.atomic_pre_enable = rzg2l_mipi_dsi_atomic_pre_enable,
>  	.atomic_enable = rzg2l_mipi_dsi_atomic_enable,
>  	.atomic_disable = rzg2l_mipi_dsi_atomic_disable,
>  	.atomic_post_disable = rzg2l_mipi_dsi_atomic_post_disable,
>  	.mode_valid = rzg2l_mipi_dsi_bridge_mode_valid,

-- 
Regards,

Laurent Pinchart
