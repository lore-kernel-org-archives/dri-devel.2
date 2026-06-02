Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191C0CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9FE10EEA6;
	Tue,  2 Jun 2026 10:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QF6ojkgt";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8EB5A10EEA5
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:34:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268B12364
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 03:34:18 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 D6E813F632
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780396463; bh=sSLG3wXzMGkuchBhOWXlkifyhi6ZS+mT6rRQfEDVsGo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QF6ojkgtfiWKB1BYJI9sFqp9mR8BcJmh8pFTtZFq4qB/yT7RAwg3w5+HD9+yNIYRn
 05ezoegyc7N7nB4wjpy6o7XufCW9osPaS61KfwK/gRNdabPuvVKgLJ092bySfX5noE
 pR0P+py2QqFTrmAmRktW0rkOcSNKx9ZzKU+ZOmqs=
Date: Tue, 2 Jun 2026 11:33:49 +0100
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
Subject: Re: [PATCH v5 4/8] drm/mali: use drmm_writeback_connector_init()
Message-ID: <ah6xjR_vHhsXqvyI@e142607>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-4-42567b7c7af2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505-wb-drop-encoder-v5-4-42567b7c7af2@oss.qualcomm.com>
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

On Tue, May 05, 2026 at 03:25:01AM +0300, Dmitry Baryshkov wrote:
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
>  drivers/gpu/drm/arm/malidp_mw.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index fad343842038..6e0c78e998aa 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -84,11 +84,6 @@ malidp_mw_connector_detect(struct drm_connector *connector, bool force)
>  	return connector_status_connected;
>  }
>  
> -static void malidp_mw_connector_destroy(struct drm_connector *connector)
> -{
> -	drm_connector_cleanup(connector);
> -}
> -
>  static struct drm_connector_state *
>  malidp_mw_connector_duplicate_state(struct drm_connector *connector)
>  {
> @@ -114,7 +109,6 @@ static const struct drm_connector_funcs malidp_mw_connector_funcs = {
>  	.reset = malidp_mw_connector_reset,
>  	.detect = malidp_mw_connector_detect,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.destroy = malidp_mw_connector_destroy,
>  	.atomic_duplicate_state = malidp_mw_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
> @@ -211,6 +205,7 @@ static u32 *get_writeback_formats(struct malidp_drm *malidp, int *n_formats)
>  int malidp_mw_connector_init(struct drm_device *drm)
>  {
>  	struct malidp_drm *malidp = drm_to_malidp(drm);
> +	struct drm_encoder *encoder;
>  	u32 *formats;
>  	int ret, n_formats;
>  
> @@ -224,11 +219,19 @@ int malidp_mw_connector_init(struct drm_device *drm)
>  	if (!formats)
>  		return -ENOMEM;
>  
> -	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
> -					   &malidp_mw_connector_funcs,
> -					   &malidp_mw_encoder_helper_funcs,
> -					   formats, n_formats,
> -					   1 << drm_crtc_index(&malidp->crtc));
> +	encoder = drmm_plain_encoder_alloc(drm, NULL, DRM_MODE_ENCODER_VIRTUAL,
> +					   NULL);
> +	if (IS_ERR(encoder))
> +		return PTR_ERR(encoder);
> +
> +	drm_encoder_helper_add(encoder, &malidp_mw_encoder_helper_funcs);
> +
> +	encoder->possible_crtcs = drm_crtc_mask(&malidp->crtc);
> +
> +	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector,
> +					    &malidp_mw_connector_funcs,
> +					    encoder,
> +					    formats, n_formats);
>  	kfree(formats);
>  	if (ret)
>  		return ret;
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
