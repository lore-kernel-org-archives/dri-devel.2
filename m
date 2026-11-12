Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6F606AD66
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=pCEFkGoh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BDD110E4EC;
	Thu, 12 Nov 2026 01:32:46 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7673410E4EC;
 Thu, 12 Nov 2026 01:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=StFp1g4ubx1WuclDmg58dMlRXvni7TqI4/w/yKHNuxg=; t=1794447160; x=2109807160; 
 b=pCEFkGohaCJyKgy3bJZiCUrJ2Y2scXWbeWQcYZGG41snZBj2s4CsEXw7s6vUikVvRbwZ3H3/dMl
 ucpsbYj9AHVtjpVeBVYBkVlY/WRl1pG5A7c2FdZHw29TTfn+erlgECG+v0AsiDB6WvLzfZOrte3Jy
 6iAYUPifDO8mKYPA9/xYfKIPU7Ho20YnrgXXawPzglBWibtpcpZjfM5gOneytA+IfLCvJ9PGpHs2F
 cAJSi99H8ySWzHGGNG3mku50gwMM5DNIS2gwi0lOa7lqSLJgJPcKj17e/f1MQ46sJfrar/k124IjR
 hAhCvP1JRXnF70dHKC2JaR9gX446DFFqUYig==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xRJfi-009F3i-Aj; Thu, 12 Nov 2026 02:32:14 +0100
Message-ID: <ee8a57d3-d290-4a20-a3ca-ac8e17a7561c@Igalia.com>
Date: Wed, 11 Nov 2026 17:32:05 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/10] drm: writeback: don't destroy the shared
 writeback properties
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
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
 <20261111-wb-drop-encoder-v8-7-62948ed87d13@oss.qualcomm.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20261111-wb-drop-encoder-v8-7-62948ed87d13@oss.qualcomm.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 16:42, Dmitry Baryshkov wrote:
> The writeback properties are created once per device and attached to
> every writeback connector. Nevertheless, a failing
> __drm_writeback_connector_init() destroys all three of them. If an
> earlier writeback connector has already been registered (komeda and
> rcar-du create one per CRTC), it is left holding stale property
> pointers. The drmm cleanup action likewise destroys them as soon as the
> first connector goes away.
>
> Leave the properties alone. They are on the device's property list, so
> drm_mode_config_cleanup() destroys them together with all other
> properties.
This does appear to be the actual behaviour. More importantly, it is 
also the intended behaviour according to various comments sprinkled 
around the property creation functions.

Reviewed-by: John Harrison <John.Harrison@Igalia.com>

> Fixes: 2f3f4a73631b ("drm: writeback: Add missing cleanup in case of initialization failure")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/drm_writeback.c | 34 ++++++----------------------------
>   1 file changed, 6 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index 89c36f1414ce..2f6a7b50336c 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -148,22 +148,6 @@ static int create_writeback_properties(struct drm_device *dev)
>   	return 0;
>   }
>   
> -static void delete_writeback_properties(struct drm_device *dev)
> -{
> -	if (dev->mode_config.writeback_pixel_formats_property) {
> -		drm_property_destroy(dev, dev->mode_config.writeback_pixel_formats_property);
> -		dev->mode_config.writeback_pixel_formats_property = NULL;
> -	}
> -	if (dev->mode_config.writeback_out_fence_ptr_property) {
> -		drm_property_destroy(dev, dev->mode_config.writeback_out_fence_ptr_property);
> -		dev->mode_config.writeback_out_fence_ptr_property = NULL;
> -	}
> -	if (dev->mode_config.writeback_fb_id_property) {
> -		drm_property_destroy(dev, dev->mode_config.writeback_fb_id_property);
> -		dev->mode_config.writeback_fb_id_property = NULL;
> -	}
> -}
> -
>   /**
>    * __drm_writeback_connector_init - Initialize a writeback connector
>    *
> @@ -198,20 +182,18 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>   	int ret = create_writeback_properties(dev);
>   
>   	if (ret != 0)
> -		goto failed_properties;
> +		return ret;
>   
>   	connector->interlace_allowed = 0;
>   
>   	ret = drm_connector_attach_encoder(connector, enc);
>   	if (ret)
> -		goto failed_properties;
> +		return ret;
>   
>   	blob = drm_property_create_blob(dev, n_formats * sizeof(*formats),
>   					formats);
> -	if (IS_ERR(blob)) {
> -		ret = PTR_ERR(blob);
> -		goto failed_properties;
> -	}
> +	if (IS_ERR(blob))
> +		return PTR_ERR(blob);
>   
>   	INIT_LIST_HEAD(&wb_connector->job_queue);
>   	spin_lock_init(&wb_connector->job_lock);
> @@ -234,9 +216,6 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>   	wb_connector->pixel_formats_blob_ptr = blob;
>   
>   	return 0;
> -failed_properties:
> -	delete_writeback_properties(dev);
> -	return ret;
>   }
>   
>   /**
> @@ -295,8 +274,8 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
>    * @dev: DRM device
>    * @data: Pointer to the writeback connector to clean up
>    *
> - * This will decrement the reference counter of blobs and destroy properties. It
> - * will also clean the remaining jobs in this writeback connector. Caution: This helper will not
> + * This will decrement the reference counter of blobs. It will also clean the
> + * remaining jobs in this writeback connector. Caution: This helper will not
>    * clean up the attached encoder and the drm_connector.
>    */
>   static void drm_writeback_connector_cleanup(struct drm_device *dev,
> @@ -306,7 +285,6 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
>   	struct drm_writeback_job *pos, *n;
>   	struct drm_writeback_connector *wb_connector = data;
>   
> -	delete_writeback_properties(dev);
>   	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
>   
>   	spin_lock_irqsave(&wb_connector->job_lock, flags);
>

