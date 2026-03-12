Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0708B106ACF6
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 23:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C6110E171;
	Thu, 12 Mar 2026 23:08:21 +0000 (UTC)
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A2810E0E5
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 23:08:19 +0000 (UTC)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl
 [94.211.6.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A9410208BD;
 Fri, 13 Mar 2026 00:08:16 +0100 (CET)
Date: Fri, 13 Mar 2026 00:08:15 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Pengyu Luo <mitltlatltl@gmail.com>, 
 ~postmarketos/upstreaming@lists.sr.ht,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Restore widebus calculation for CMDMode
 panels
Message-ID: <abNCphH1cGeora16@SoMainline.org>
References: <20260311-dsi-dsc-regresses-again-v1-1-6a422141eeea@somainline.org>
 <f88c030f-ebdb-49d1-8334-62f1f85154e7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88c030f-ebdb-49d1-8334-62f1f85154e7@collabora.com>
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

On 2026-03-12 14:18:43, AngeloGioacchino Del Regno wrote:
...
> Marijn et al,
> 
> I don't really know this hardware specifically, but I had a very fast look
> at this patch, and I believe that however you put it, this looks like being
> either plain wrong or very weird.

I would say I also don't know the hardware here very well, and which parameters
apply when and were.  Most importantly, just be aware that the code we're
looking at is for **DSC**, i.e. when we're no longer transfering single pixels
per pclk, but compressed slices of a given number of bytes that can loosely be
converted back to a "number of pixels".

> I think this should be, instead....
> 
> 	/* (don't add this comment) assuming RGB888/666, this will be 24 for both Command 
> and Video modes */
> 	bits_per_pclk = mipi_dsi_pixel_format_to_bpp(msm_host->format);

That would make sense, if it weren't for DSC.  The older downstream kernel I'm
looking at -for at least CMD mode- disregards the format entirely, and just
divides the "width" (computed like msm_dsc_get_bytes_per_line()) by 3 or 6
depending on widebus.

In other words that's clearly demonstrating that input/output "bits per
component" (in uncompressed space) are irrelevant when we're transmitting
compressed pixels.

> 	/* Can send twice the bits per clock if WideBus with Video Mode */
> 	if (wide_bus_enabled && msm_host->mode_flags & MIPI_DSI_MODE_VIDEO)
> 		bits_per_pclk *= 2;

And this is where the original patch got things wrong too; widebus isn't limited
to VIDEO mode, in fact we were specifically only allowing CMD mode to use it
thus far.  That comment and condition should be inverted.

In this old downstream, widebus also doesn't seem to affect the pclk rate for
VIDEO mode, only the ratio between bits per component and the chroma format
(making up the total size of the pixel) and the configured "bits per pixel"
value are taken into account; that ratio is generally 3.

> ...because, unless there's a hardware quirk (and that should be really clarified
> with a big comment stating that), I don't see why command mode should always be
> 24 bits per clock, and I also don't see why a widebus case would do 48 bits per
> clock even in the RGB666_PACKED and RGB565 cases (which may not even be possible
> but *meh*).
> 
> Just my two cents.
> 
> Reminding you all again that I don't know this HW, so I may have said something
> wrong here.
>
> Cheers!
> Angelo

Kind regards,
Marijn
