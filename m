Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6791F9EDF6
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B4710EA5D;
	Wed, 22 Apr 2026 15:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="UyOfh6L3";
	dkim-atps=neutral
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7284D10EA5D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=default;
 h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
 To:From:Date:subject:date:message-id:reply-to;
 bh=d1DRDQK2BzfYXwf9aVhwoDO1MQzx5va/tsd04ZS3/zE=; b=UyOfh6L3n1HQrgpWfJsoUapMK2
 Mms+xkV8SndVoV5jkfwqMhv88CX4fFsz+rmmcaafyR5mMqdwZM7rO/DxVxx8Kp063hD7Cy80jHPWK
 77zlsQy4M22uIGaexR7jfbz7nitv0G1XacatGlGDsGwIZl+DYBWA3714d3BZVanfHJE4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.98.2)
 (envelope-from <hugo@hugovil.com>) id 1wFZ65-000000007n7-3ML7;
 Wed, 22 Apr 2026 11:02:38 -0400
Date: Wed, 22 Apr 2026 11:02:37 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Pavel Machek <pavel@nabladev.com>,
 linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2] drm: renesas: rz-du: mipi_dsi: Fix return path on error
Message-Id: <20260422110237.15cd5208452a1d6d842ab5dd@hugovil.com>
In-Reply-To: <20260422145146.1638998-1-chris.brandt@renesas.com>
References: <20260422145146.1638998-1-chris.brandt@renesas.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --
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

Hi Chris,

On Wed, 22 Apr 2026 10:51:46 -0400
Chris Brandt <chris.brandt@renesas.com> wrote:

> In case of error, we should unwind correctly.
> Switching to using dmam_ instead of dma_ and moving the code earlier
> fixes the issue.
> 
> Fixes: 6f392f371650 ("drm: renesas: rz-du: Implement MIPI DSI host transfers")
> Suggested-by: Pavel Machek <pavel@nabladev.com>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> Acked-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> ---
> V1->V2:
>  - Need to take into account mipi_dsi_host_register was already called (Geert)
>  - Switch to using dmam_alloc_coherent to automate unwinding (Chris)
>  - Added Acked-by (Hugo)

You should not add "Acked-by" tags if you make
modifications _after_ someone has given its Ack (unless it is just a
minor cosmetic or coding style change)...

In other words, my ack was for V1, not V2 which is quite different from
V1 :)

Don't resend a V3 just for that, I will have a look later at V2...


> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index 29f2b7d24fe5..b908e702b607 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1442,6 +1442,11 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
>  		return dev_err_probe(dsi->dev, PTR_ERR(dsi->prstc),
>  				     "failed to get prst\n");
> 
> +	dsi->dcs_buf_virt = dmam_alloc_coherent(dsi->dev, RZG2L_DCS_BUF_SIZE,
> +						&dsi->dcs_buf_phys, GFP_KERNEL);
> +	if (!dsi->dcs_buf_virt)
> +		return -ENOMEM;
> +
>  	platform_set_drvdata(pdev, dsi);
> 
>  	pm_runtime_enable(dsi->dev);
> @@ -1474,11 +1479,6 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_pm_disable;
> 
> -	dsi->dcs_buf_virt = dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_BUF_SIZE,
> -					       &dsi->dcs_buf_phys, GFP_KERNEL);
> -	if (!dsi->dcs_buf_virt)
> -		return -ENOMEM;
> -
>  	return 0;
> 
>  err_phy:
> @@ -1493,8 +1493,6 @@ static void rzg2l_mipi_dsi_remove(struct platform_device *pdev)
>  {
>  	struct rzg2l_mipi_dsi *dsi = platform_get_drvdata(pdev);
> 
> -	dma_free_coherent(dsi->host.dev, RZG2L_DCS_BUF_SIZE, dsi->dcs_buf_virt,
> -			  dsi->dcs_buf_phys);
>  	mipi_dsi_host_unregister(&dsi->host);
>  	pm_runtime_disable(&pdev->dev);
>  }
> --
> 2.52.0
> 
> 


-- 
Hugo Villeneuve
