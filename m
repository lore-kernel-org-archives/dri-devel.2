Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18A1FEC0FD
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D5910E182;
	Tue, 24 Mar 2026 19:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KRekaKKZ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9565010E65B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:33:15 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 81622591;
 Tue, 24 Mar 2026 20:31:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774380716;
 bh=8SHW4vqyRDiHZ525hvVTra1ahe2CRERg8tA7pJuY1Qg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KRekaKKZ0NZXiT6ogz3MmxbJbJPUYJqD498up6STRhgg9quAl1HjEsPYdIHUx9RLu
 rxv2ecV1oSut79aw92UHOyXRfKWzNThm/jcn3MKv6FKPuTiWFyTOuzRQfTm6vzZ8UX
 6n/WPzzZLvIHnJbio9cdOUjb9uHosTUeP687GNKo=
Date: Tue, 24 Mar 2026 21:33:11 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, geert@linux-m68k.org,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: rz-du: Ensure correct suspend/resume ordering with
 VSP
Message-ID: <20260324193311.GB2461076@killaraus.ideasonboard.com>
References: <20260324180512.2277875-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324180512.2277875-1-tommaso.merciai.xr@bp.renesas.com>
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

On Tue, Mar 24, 2026 at 07:05:05PM +0100, Tommaso Merciai wrote:
> The VSP serves as an interface to memory and a compositor to the DU. It
> therefore needs to be suspended after and resumed before the DU, to be
> properly stopped and restarted in a controlled fashion driven by the DU
> driver. This currently works by chance. Avoid relying on luck by
> enforcing the correct suspend/resume ordering with device links.
> 
> Based on similar work done by Laurent Pinchart for R-Car DU.

If the R-Car DU patch gets merged before this one, you could mention the
commit ID here.

> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c | 16 ++++++++++++++++
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> index bd486377f037..eb626c3cc421 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> @@ -20,6 +20,7 @@
>  #include <drm/drm_vblank.h>
>  
>  #include <linux/bitops.h>
> +#include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> @@ -293,6 +294,9 @@ static void rzg2l_du_vsp_cleanup(struct drm_device *dev, void *res)
>  {
>  	struct rzg2l_du_vsp *vsp = res;
>  
> +	if (vsp->link)
> +		device_link_del(vsp->link);
> +
>  	put_device(vsp->vsp);
>  }
>  
> @@ -317,6 +321,18 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
>  	if (ret < 0)
>  		return ret;
>  
> +	/*
> +	 * Enforce suspend/resume ordering between the DU (consumer) and the
> +	 * VSP (supplier). The DU will be suspended before and resume after the
> +	 * VSP.
> +	 */
> +	vsp->link = device_link_add(rcdu->dev, vsp->vsp, DL_FLAG_STATELESS);
> +	if (!vsp->link) {
> +		dev_err(rcdu->dev, "Failed to create device link to VSP %s\n",
> +			dev_name(vsp->vsp));
> +		return -EINVAL;
> +	}
> +
>  	ret = vsp1_du_init(vsp->vsp);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
> index 322eb80dcbaf..a22aaf0843ed 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
> @@ -15,6 +15,7 @@
>  #include <linux/scatterlist.h>
>  
>  struct device;
> +struct device_link;
>  struct drm_framebuffer;
>  struct rzg2l_du_device;
>  struct rzg2l_du_format_info;
> @@ -29,6 +30,7 @@ struct rzg2l_du_vsp_plane {
>  struct rzg2l_du_vsp {
>  	unsigned int index;
>  	struct device *vsp;
> +	struct device_link *link;
>  	struct rzg2l_du_device *dev;
>  };
>  

-- 
Regards,

Laurent Pinchart
