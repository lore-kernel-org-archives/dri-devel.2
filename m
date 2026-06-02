Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D43CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0032710EE9B;
	Tue,  2 Jun 2026 10:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HGBC4leZ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id C9C6710EE9B
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:33:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C067353D
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 03:33:02 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 3293A3F93E
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780396387; bh=iOHUK6brXgyIm879Y6Al2FeqYaz5id6uidKZL33WOWI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HGBC4leZNohwQyphX/3IryBRBxWRH1mskr33fFwojF+eMFlFxxn8GE55YqP8JbbsQ
 9YLegGqHkssXaW59v/k4HvXh8u0VbbRpU7R3KJQutZXWUe1x4FhrnWxoa8jzippgPF
 J2Un9AV4ueLv53KNibnTbaMZnrDEvoyVuxR47nVw=
Date: Tue, 2 Jun 2026 11:32:32 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 3/8] drm/komeda: use drmm_writeback_connector_init()
Message-ID: <ah6xQEWemicF_ECc@e142607>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-3-42567b7c7af2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505-wb-drop-encoder-v5-3-42567b7c7af2@oss.qualcomm.com>
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

On Tue, May 05, 2026 at 03:25:00AM +0300, Dmitry Baryshkov wrote:
> The driver uses drm_writeback_connector_init() instead of its drmm
> counterpart, but it doesn't perform the job queue cleanup (neither
> manually nor by calling drm_writeback_connector_cleanup()). On the
> contrary, the drmm_writeback_connector_init() function ensures the
> proper cleanup of the job queue.
> 
> Use drmm_plain_encoder_alloc() to allocate simple encoder and
> drmm_writeback_connector_init() in order to initialize writeback
> connector instance.
> 
> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++++++++----------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 41cc3e080dc9..bcc53d4015f1 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -5,6 +5,7 @@
>   *
>   */
>  #include <drm/drm_framebuffer.h>
> +#include <drm/drm_managed.h>
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
>  
> @@ -121,17 +122,10 @@ komeda_wb_connector_fill_modes(struct drm_connector *connector,
>  	return 0;
>  }
>  
> -static void komeda_wb_connector_destroy(struct drm_connector *connector)
> -{
> -	drm_connector_cleanup(connector);
> -	kfree(to_kconn(to_wb_conn(connector)));
> -}
> -
>  static const struct drm_connector_funcs komeda_wb_connector_funcs = {
>  	.reset			= drm_atomic_helper_connector_reset,
>  	.detect			= komeda_wb_connector_detect,
>  	.fill_modes		= komeda_wb_connector_fill_modes,
> -	.destroy		= komeda_wb_connector_destroy,
>  	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
>  };
> @@ -143,13 +137,15 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>  	struct komeda_wb_connector *kwb_conn;
>  	struct drm_writeback_connector *wb_conn;
>  	struct drm_display_info *info;
> +	struct drm_encoder *encoder;
> +
>  	u32 *formats, n_formats = 0;
>  	int err;
>  
>  	if (!kcrtc->master->wb_layer)
>  		return 0;
>  
> -	kwb_conn = kzalloc_obj(*kwb_conn);
> +	kwb_conn = drmm_kzalloc(&kms->base, sizeof(*kwb_conn), GFP_KERNEL);
>  	if (!kwb_conn)
>  		return -ENOMEM;
>  
> @@ -165,11 +161,19 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>  		return -ENOMEM;
>  	}
>  
> -	err = drm_writeback_connector_init(&kms->base, wb_conn,
> -					   &komeda_wb_connector_funcs,
> -					   &komeda_wb_encoder_helper_funcs,
> -					   formats, n_formats,
> -					   BIT(drm_crtc_index(&kcrtc->base)));
> +	encoder = drmm_plain_encoder_alloc(&kms->base, NULL,
> +					   DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	if (IS_ERR(encoder))
> +		return PTR_ERR(encoder);
> +
> +	drm_encoder_helper_add(encoder, &komeda_wb_encoder_helper_funcs);
> +
> +	encoder->possible_crtcs = drm_crtc_mask(&kcrtc->base);
> +
> +	err = drmm_writeback_connector_init(&kms->base, wb_conn,
> +					    &komeda_wb_connector_funcs,
> +					    encoder,
> +					    formats, n_formats);
>  	komeda_put_fourcc_list(formats);
>  	if (err) {
>  		kfree(kwb_conn);
> 
> -- 
> 2.47.3
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
