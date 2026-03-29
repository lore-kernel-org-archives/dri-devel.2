Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F786F3D60E
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 18:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCE310E0DC;
	Sun, 29 Mar 2026 18:04:35 +0000 (UTC)
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC65C10E0DA;
 Sun, 29 Mar 2026 18:04:33 +0000 (UTC)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl
 [94.211.6.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C5E213F727;
 Sun, 29 Mar 2026 20:04:30 +0200 (CEST)
Date: Sun, 29 Mar 2026 20:04:29 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/msm/dsi: fix hdisplay calculation for CMD mode
 panel
Message-ID: <acloO6wNq4ObclGZ@SoMainline.org>
References: <20260307111250.105772-1-mitltlatltl@gmail.com>
 <20260307111250.105772-2-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307111250.105772-2-mitltlatltl@gmail.com>
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

On 2026-03-07 19:12:49, Pengyu Luo wrote:
> ac47870fd795 incorrecly broke hdisplay calculation for CMD mode, fix
> it.

Where's the what/how/why?  This commit message explains exactly nothing while a
description is a requirement for submitting patches upstream:

https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

Take my version of this patch as an example.

> 
> Fixes: ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when programming dsi registers")
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 7c16216e8b..f63165c7ce 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1016,8 +1016,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		/*
>  		 * DPU sends 3 bytes per pclk cycle to DSI. If widebus is
>  		 * enabled, MDP always sends out 48-bit compressed data per
> -		 * pclk and on average, DSI consumes an amount of compressed
> -		 * data equivalent to the uncompressed pixel depth per pclk.
> +		 * pclk and on average, for video mode, DSI consumes only an
> +		 * amount of compressed data equivalent to the uncompressed
> +		 * pixel depth per pclk.

This needs a source and justification (in the commit message).  For most
panels where bpc is simply 8, the resulting rate is the same as when widebus is
disabled, meaning that widebus has no effect on the pclk rate in video-mode?

- Marijn

>  		 *
>  		 * Calculate the number of pclks needed to transmit one line of
>  		 * the compressed data.
> @@ -1029,10 +1030,14 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		 * unused anyway.
>  		 */
>  		h_total -= hdisplay;
> -		if (wide_bus_enabled)
> -			bits_per_pclk = dsc->bits_per_component * 3;
> -		else
> +		if (wide_bus_enabled) {
> +			if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO)
> +				bits_per_pclk = dsc->bits_per_component * 3;
> +			else
> +				bits_per_pclk = 48;
> +		} else {
>  			bits_per_pclk = 24;
> +		}
>  
>  		hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc) * 8, bits_per_pclk);
>  
> -- 
> 2.53.0
> 
