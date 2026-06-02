Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527A2C5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A677410EC47;
	Tue,  2 Jun 2026 06:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BYvvW2e8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F40B10EC47
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 06:41:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8773E42B8E;
 Tue,  2 Jun 2026 06:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB5C1F00893;
 Tue,  2 Jun 2026 06:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780382466;
 bh=hf+zz5RBfcwn5BptzXmxGDV1gackBwjXE2k/ZdWhNxU=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=BYvvW2e8bhG5PAsR6Vg6h2LwrL4zH9vJyULpe6xEoktDLrcN7ZI6W3zalRO2vLq24
 f4eSl3RSbEj0+llgtXdqgR3kWvk2mlliecI35+XtHmVbdZhAXCiHfke+uNZ8l4i1nf
 yMGsa1k3jiGHHZloGxAlfVtWooVJyLkFVmeIkffipEyExUgSQqKsayQ4ORyYoQZXHV
 w86mk9ZE6d47MONvzN0z/NXfx6Dzst3HV1T6M4Qwcg4ScVtoFGQh97nz2d4Kb8eM2R
 R1m+CxBLONxk9J7jbYX3bkPz//QdI53tOyJzvx7xHOSVCQKZQKRaDvVNxk19ITJB3g
 oud00/qdCr92A==
Message-ID: <22a13916-db59-4275-8361-59e4bea2428a@kernel.org>
Date: Tue, 2 Jun 2026 08:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v4 3/4] drm/display: bridge_connector: init scdc debugfs
 for HDMI
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Daniel Stone <daniels@collabora.com>
References: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
 <20260527-scdc-link-health-v4-3-622ea40a1f59@collabora.com>
Content-Language: en-US, nl
In-Reply-To: <20260527-scdc-link-health-v4-3-622ea40a1f59@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 27/05/2026 16:03, Nicolas Frattaroli wrote:
> On drm_bridge_connectors that contain an HDMI bridge, initialise the
> SCDC debugfs entry under the connector's debugfs root.
> 
> Reviewed-by: Daniel Stone <daniels@collabora.com>

Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 649969fca141..8c2c890bd95d 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -25,6 +25,7 @@
>  #include <drm/display/drm_hdmi_cec_helper.h>
>  #include <drm/display/drm_hdmi_helper.h>
>  #include <drm/display/drm_hdmi_state_helper.h>
> +#include <drm/display/drm_scdc_helper.h>
>  
>  /**
>   * DOC: overview
> @@ -263,6 +264,9 @@ static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
>  		if (bridge->funcs->debugfs_init)
>  			bridge->funcs->debugfs_init(bridge, root);
>  	}
> +
> +	if (bridge_connector->bridge_hdmi)
> +		drm_scdc_debugfs_init(connector, root);
>  }
>  
>  static void drm_bridge_connector_reset(struct drm_connector *connector)
> 

