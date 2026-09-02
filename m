Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3215EC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64DD710E036;
	Wed,  2 Sep 2026 20:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KNKy6ESq";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8253510E036
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:55:54 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 643231F8;
 Wed,  2 Sep 2026 22:54:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788382461;
 bh=yOp/QwLcsFzKak6geScZDKKxKOKgTlwu0GRjCfP776Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KNKy6ESqs9jc1DSUAxm2rIVPt6QfPXSje/ia548HWfrwix7W2Rg+9ymN3AXRk6YX0
 +zkHv6srVg7BOqu3aakf7Dn42VXqKZ36oFDQwcEIsQfR9/sk4xoWhifJKpXyB0LFSM
 Q0CH3JHEv1EanB5jfY7QzjWSrl+EYIK4tpKcO8Vw=
Date: Wed, 2 Sep 2026 23:55:51 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH v2 9/11] drm: xlnx: zynqmp_dpsub: Use
 devm_of_reserved_mem_device_init()
Message-ID: <20260902205551.GC287496@killaraus.ideasonboard.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
 <20260902201640.2024648-10-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902201640.2024648-10-mukesh.ojha@oss.qualcomm.com>
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

On Thu, Sep 03, 2026 at 01:46:38AM +0530, Mukesh Ojha wrote:
> Use the devres-managed devm_of_reserved_mem_device_init() instead of
> the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
> pair, letting the device resource manager handle cleanup automatically.
> 
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> index 53ab1a2a5aaf..e93a7a299b52 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> @@ -203,7 +203,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>  	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
>  
>  	/* Try the reserved memory. Proceed if there's none. */
> -	of_reserved_mem_device_init(&pdev->dev);
> +	devm_of_reserved_mem_device_init(&pdev->dev);
>  
>  	ret = zynqmp_dpsub_init_clocks(dpsub);
>  	if (ret < 0)
> @@ -255,7 +255,6 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	clk_disable_unprepare(dpsub->apb_clk);
>  err_mem:
> -	of_reserved_mem_device_release(&pdev->dev);
>  	if (!dpsub->drm)
>  		zynqmp_dpsub_release(dpsub);
>  	return ret;
> @@ -276,7 +275,6 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(&pdev->dev);
>  	clk_disable_unprepare(dpsub->apb_clk);
> -	of_reserved_mem_device_release(&pdev->dev);
>  
>  	if (!dpsub->drm)
>  		zynqmp_dpsub_release(dpsub);

-- 
Regards,

Laurent Pinchart
