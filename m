Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BF4F53D75
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD5E10E315;
	Mon, 16 Mar 2026 16:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Lxq5dk1Y";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE3610E2DD
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 16:42:59 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4210DBD2;
 Mon, 16 Mar 2026 17:41:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773679307;
 bh=+NWc8VwtCmn525XipCnNx0dZNSsnmYU3nirzpmPH0+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Lxq5dk1YqEe0IBL4hsBymS5CFyCH/laNLcHtee8y6zsAXXFhKHUOzViy2adrPulJD
 ko8AZ/rs8tB+TeEEx0eNceS3EHr2bNX38HpHIkISAEmNw5u6WFgV2S8IaVRAgdqoxB
 8hOxihMKb1KlqRK44ipjP1/3Lzr18+Lx0xpS7c+0=
Date: Mon, 16 Mar 2026 18:42:57 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] drm/bridge_connector: Convert to atomic_create_state
Message-ID: <20260316164257.GQ31604@killaraus.ideasonboard.com>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-14-de7397c8e1cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-drm-mode-config-init-v1-14-de7397c8e1cf@kernel.org>
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

On Tue, Mar 10, 2026 at 05:07:06PM +0100, Maxime Ripard wrote:
> The connector created by drm_bridge_connector only initializes a
> pristine state in reset, which is equivalent to that atomic_create_state
> would expect. Let's convert to it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index f686aa5c0ed9b84dbe5e0957df22d08aff2f1945..2f73576783f5f69ebce277a7537accefc94645a9 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -263,26 +263,33 @@ static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
>  		if (bridge->funcs->debugfs_init)
>  			bridge->funcs->debugfs_init(bridge, root);
>  	}
>  }
>  
> -static void drm_bridge_connector_reset(struct drm_connector *connector)
> +static struct drm_connector_state *
> +drm_bridge_connector_create_state(struct drm_connector *connector)
>  {
>  	struct drm_bridge_connector *bridge_connector =
>  		to_drm_bridge_connector(connector);
> +	struct drm_connector_state *conn_state;
> +
> +	conn_state = drm_atomic_helper_connector_create_state(connector);
> +	if (IS_ERR(conn_state))
> +		return conn_state;
>  
> -	drm_atomic_helper_connector_reset(connector);
>  	if (bridge_connector->bridge_hdmi)
>  		__drm_atomic_helper_connector_hdmi_reset(connector,

It would be good to rename this function too, to avoid using "reset".

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> -							 connector->state);
> +							 conn_state);
> +
> +	return conn_state;
>  }
>  
>  static const struct drm_connector_funcs drm_bridge_connector_funcs = {
> -	.reset = drm_bridge_connector_reset,
>  	.detect = drm_bridge_connector_detect,
>  	.force = drm_bridge_connector_force,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.atomic_create_state = drm_bridge_connector_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  	.debugfs_init = drm_bridge_connector_debugfs_init,
>  	.oob_hotplug_event = drm_bridge_connector_oob_hotplug_event,
>  };
> 

-- 
Regards,

Laurent Pinchart
