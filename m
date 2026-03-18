Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284D4107BCF4
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB2A10E15E;
	Wed, 18 Mar 2026 16:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PkXCphOI";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4923110E15E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:02:42 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 45B43308;
 Wed, 18 Mar 2026 17:01:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773849688;
 bh=F6T7WgQFzL9ZsxQ2e0wKCFuwA3qMfjikGbQKgaO6svc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PkXCphOIbFqGyMnwvp8YfTYTjZ072oxSDQnICaXV6Wv0m6bY7bqMYina6aSOaQLDe
 UxGi6W4PPPoEAawz518le518dPSuTHketU43ICcLzppG0dTKftMKrsI7R31kyJv3DN
 DjVH10XqTJLgxsE0jCZdv/oS3eyaQAQ1vP/Mktqc=
Date: Wed, 18 Mar 2026 18:02:39 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 asahi@lists.linux.dev
Subject: Re: [PATCH v2 1/4] drm/rcar-du: Use drm_gem_dma_get_sg_table()
 helper to get scatter gather table
Message-ID: <20260318160239.GB633439@killaraus.ideasonboard.com>
References: <20260317064049.696795-1-wenst@chromium.org>
 <20260317064049.696795-2-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317064049.696795-2-wenst@chromium.org>
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

Hi Chen-Yu,

Thank you for the patch.

On Tue, Mar 17, 2026 at 02:40:43PM +0800, Chen-Yu Tsai wrote:
> The rcar-du driver is directly calling dma_get_sgtable() on a
> drm_gem_dma_object. Not passing the dma_attrs field in may cause
> problems when DMA_ATTR_NO_KERNEL_MAPPING is added to the GEM DMA
> helpers gain support later.
> 
> Instead, use the drm_gem_dma_get_sg_table() helper to get the scatter
> gather table.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - new patch
> 
> Not sure if we should add a helper like drm_fb_dma_get_gem_addr(). This
> seems to be the only driver that is using a scatter gather table to pass
> DMA addresses.

The DU can't access memory directly (at least on Gen3 and newer), and
goes through a separate device called VSP that acts as an external DMA
engine (*) and compositor. This is why buffers need to be mapped
manually to the VSP, the GEM helpers would otherwise use the DU struct
device, which isn't correct. I can't use drm_device.dma_dev as the DMA
initiator can be different per CRTC.

I don't think a separate helper with a single user would be very useful
here, especially given that part of the logic in
drm_fb_dma_get_gem_addr() is in the separate vsp1 driver. Refactoring
may get messy, for little benefit.

* And in some cases the VSP further delegates memory access to the FCP,
which is yet another DMA initiator from an IOMMU point of view.

> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> index 94c22d2db197..6a62608ee3a9 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> @@ -291,10 +291,16 @@ int rcar_du_vsp_map_fb(struct rcar_du_vsp *vsp, struct drm_framebuffer *fb,
>  				dst = sg_next(dst);
>  			}
>  		} else {
> -			ret = dma_get_sgtable(rcdu->dev, sgt, gem->vaddr,
> -					      gem->dma_addr, gem->base.size);

Did you compile the patch ? The rcdu variable is now unused. Apart from
that, it compiles fine and seems to operate as expected.

> -			if (ret)
> +			struct sg_table *ret_sgt;
> +
> +			ret_sgt = drm_gem_dma_get_sg_table(gem);
> +			if (IS_ERR(ret_sgt)) {
> +				ret = PTR_ERR(ret_sgt);
>  				goto fail;
> +			}
> +
> +			memcpy(sgt, ret_sgt, sizeof(*sgt));
> +			kfree(ret_sgt);

It's a bit of a shame to kmalloc() a new sg_table and free it right
after :-/ Would it be that bad to switch to dma_get_sgtable_attrs()
here, and pass gem->dma_attrs to the function ?

>  		}
>  
>  		ret = vsp1_du_map_sg(vsp->vsp, sgt);

-- 
Regards,

Laurent Pinchart
