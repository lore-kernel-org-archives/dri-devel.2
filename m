Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1716606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=hecidf4Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2894310E31A;
	Wed, 21 Oct 2026 18:33:25 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33BF10E31A;
 Wed, 21 Oct 2026 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=7jgKOdLsgvQJKNOMTOZC41PaMPlEkcHgH9vTY2CQXdA=; b=hecidf4Zvb6KucUY3eq3X/XKXX
 sHiU+xXRkJcm0AGH6IlWOq91HFwHhsoEOBDkTQFSiTTnDI9i7wO3W3kuosxkigS7b+sCmtuB1xYYc
 QEboIVXsdwfdykMy8gmZUsfQ6mfPKMNla5dzFD1BWYjItwjq5qmQI1w/ZPRB9/sTWbyGTXGRn0EUo
 w6vOVGaGWgbA3gAs536+s5tdhNJb1tL9Z8R8/3esSMCNnAEnts1955hUcxOlMbmZ8ehRQ3Jv6sIzw
 XPkv2Nlpjxw0XMaA4eh69jlzryylEtuziFBxvFfU2SbSokBAM1U8hUf6NEBL9eIO6N6dcT9lXER70
 xRE8vtSA==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJb7V-005uGb-MW; Wed, 21 Oct 2026 20:33:01 +0200
Message-ID: <0328d182-0a13-45f9-9ae7-317453b7eec0@Igalia.com>
Date: Wed, 21 Oct 2026 11:32:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] drm: writeback: drop the drmm writeback cleanup
 action
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
 <20261019-wb-drop-encoder-v7-9-d4288a26eb54@oss.qualcomm.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20261019-wb-drop-encoder-v7-9-d4288a26eb54@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 06:12, Dmitry Baryshkov wrote:
> drmm_connector_init() already registers drm_connector_cleanup() as a
> managed action, and that now cleans up the writeback state too. The
> extra action registered by drmm_writeback_connector_init() just does the
> same work a little earlier, leaving drm_connector_cleanup() nothing to
> do. Drop it.
>
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: John Harrison <John.Harrison@Igalia.com>

> ---
>   drivers/gpu/drm/drm_writeback.c | 25 ++++---------------------
>   1 file changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index 272012a70efe..0c5d2fbe7a7c 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -16,7 +16,6 @@
>   #include <drm/drm_device.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_framebuffer.h>
> -#include <drm/drm_managed.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_property.h>
>   #include <drm/drm_writeback.h>
> @@ -303,14 +302,6 @@ void drm_writeback_connector_cleanup(struct drm_connector *connector)
>   	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
>   }
>   
> -static void drm_writeback_connector_cleanup_action(struct drm_device *dev,
> -						   void *data)
> -{
> -	struct drm_writeback_connector *wb_connector = data;
> -
> -	drm_writeback_connector_cleanup(&wb_connector->base);
> -}
> -
>   /**
>    * drmm_writeback_connector_init - Initialize a writeback connector
>    *
> @@ -321,7 +312,8 @@ static void drm_writeback_connector_cleanup_action(struct drm_device *dev,
>    * @formats: Array of supported pixel formats for the writeback engine
>    * @n_formats: Length of the formats array
>    *
> - * This function initialize a writeback connector and register its cleanup.
> + * This function initializes a writeback connector. Cleanup is automatically
> + * handled with a call to drm_connector_cleanup() in a DRM-managed action.
>    *
>    * This function creates the writeback-connector-specific properties if they
>    * have not been already created, initializes the connector as
> @@ -344,17 +336,8 @@ int drmm_writeback_connector_init(struct drm_device *dev,
>   	if (ret)
>   		return ret;
>   
> -	ret = __drm_writeback_connector_init(dev, wb_connector, enc, formats,
> -					     n_formats);
> -	if (ret)
> -		return ret;
> -
> -	ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup_action,
> -				       wb_connector);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return __drm_writeback_connector_init(dev, wb_connector, enc, formats,
> +					      n_formats);
>   }
>   EXPORT_SYMBOL(drmm_writeback_connector_init);
>   
>

