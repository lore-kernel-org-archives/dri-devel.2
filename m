Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84104606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Ydtw7KnN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B37E110E4B0;
	Wed, 11 Nov 2026 23:16:53 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2464710E4C0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:16:47 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 44DF422B;
 Thu, 12 Nov 2026 00:14:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794438862;
 bh=z0dg7bwU2AAoMLZ79Myh4uGTQaMh+gcfY67SeB0Tlv4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ydtw7KnN0JpDWFAoRtrJahH5aWkusxuCN0PY/k/3ePCt0lPSp7vPcpbdfpNo022R2
 fv9gBmDZ83xYbRPNXsDlKt7B01xDdhFW+TnYG9z7BN8PHLWQJucSwDJCn/d1mmqMeE
 k13Wvp9epVQNLdNwT9hMEzVDcBkto18wJciq3i3A=
Date: Thu, 12 Nov 2026 01:16:44 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank.Li@oss.nxp.com
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>,
 "open list:DRM DRIVERS FOR XILINX" <dri-devel@lists.freedesktop.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
 open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] drm: xlnx: zynqmp_disp: use
 dmaengine_get_copy_align() accessor
Message-ID: <20261111231644.GC449775@killaraus.ideasonboard.com>
References: <20261111200739.3823753-1-Frank.Li@oss.nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111200739.3823753-1-Frank.Li@oss.nxp.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 03:07:37PM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use the dmaengine_get_copy_align() helper instead of directly accessing
> the copy_align field from the DMA device structure.
> 
> No functional change and prepare to move struct dma_device to private.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Tomi, I assume you'll push this to drm-misc. Please let me know if
that's not correct.

> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index e998f22686748..0753236b9546a 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -1433,7 +1433,7 @@ int zynqmp_disp_probe(struct zynqmp_dpsub *dpsub)
>  		struct zynqmp_disp_layer *layer;
>  
>  		layer = &disp->layers[ZYNQMP_DPSUB_LAYER_VID];
> -		dpsub->dma_align = 1 << layer->dmas[0].chan->device->copy_align;
> +		dpsub->dma_align = 1 << dmaengine_get_copy_align(layer->dmas[0].chan);
>  	}
>  
>  	dpsub->disp = disp;

-- 
Regards,

Laurent Pinchart
