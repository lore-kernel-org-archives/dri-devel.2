Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7779ECD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5A910F15A;
	Thu,  7 May 2026 14:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZWeZiCKu";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDE410E262;
 Thu,  7 May 2026 14:06:59 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 25B22664;
 Thu,  7 May 2026 16:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778162814;
 bh=XdoQSHYguWVmYaizw/9HEyu4QWIFpuURw2/1dzsB9v0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZWeZiCKu+oIq14ANWhg9axIzcW14nW7oj/PYT+3BfRAGqbsCwMlfTrl+CGtMDhZrQ
 tXLV1TsYQALqmjgL5A0/3fYM5BRZOXZi9j7ReRC0s2HpoxszhmDFvl4+8ldreI27CM
 6ia3Rtcw3CxN1hDJJYIIjf3Au2tq1XrN8aXaVc4c=
Date: Thu, 7 May 2026 17:06:57 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v5 01/11] drm/bridge: drm_bridge_put(): ignore ERR_PTR
Message-ID: <20260507140657.GK1938994@killaraus.ideasonboard.com>
References: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-0-472b913b5cb7@bootlin.com>
 <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-1-472b913b5cb7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-1-472b913b5cb7@bootlin.com>
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

On Thu, May 07, 2026 at 03:45:19PM +0200, Luca Ceresoli wrote:
> Most functions returning a struct drm_bridge pointer currently return a
> valid pointer or NULL, but this restricts their ability to return an error
> code as an ERR_PTR describing the error kind.
> 
> In preparation to have new APIs that can return a struct drm_bridge pointer
> holding an ERR_PTR (and for those which already do) make drm_bridge_put()
> ignore ERR_PTR values, just like it ignores NULL pointers.
> 
> This will avoid annoying error checking in many places and the risk of
> missing error checks.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Link: https://lore.kernel.org/all/20260318152533.GA633439@killaraus.ideasonboard.com/
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Link: https://lore.kernel.org/all/omlnswxukeqgnatzdvooaashgkfcacjevkvbkm6xt33itgua2k@jcmzll2w6kdq/
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> 
> Changes in v5:
> - don't change drm_bridge_get(), only drm_bridge_put() has known use cases
> 
> Changes in v4:
> - removed incorrect change to drm_bridge_clear_and_put() kdoc
> 
> Patch added in v2
> ---
>  drivers/gpu/drm/drm_bridge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index d4b3478258ec..4aaea517b436 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -300,7 +300,7 @@ EXPORT_SYMBOL(drm_bridge_get);
>  
>  /**
>   * drm_bridge_put - Release a bridge reference
> - * @bridge: DRM bridge; if NULL this function does nothing
> + * @bridge: DRM bridge; if NULL or an ERR_PTR this function does nothing
>   *
>   * This function decrements the bridge's reference count and frees the
>   * object if the reference count drops to zero.
> @@ -310,7 +310,7 @@ EXPORT_SYMBOL(drm_bridge_get);
>   */
>  void drm_bridge_put(struct drm_bridge *bridge)
>  {
> -	if (bridge)
> +	if (!IS_ERR_OR_NULL(bridge))
>  		kref_put(&bridge->refcount, __drm_bridge_free);
>  }
>  EXPORT_SYMBOL(drm_bridge_put);
> 

-- 
Regards,

Laurent Pinchart
