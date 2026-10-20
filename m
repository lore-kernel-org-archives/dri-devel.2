Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1994606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=gTxNTfGS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA6E10E1B6;
	Tue, 20 Oct 2026 01:33:27 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 20 Oct 2026 01:33:19 UTC
Received: from mail-m82198.xmail.ntesmail.com (mail-m82198.xmail.ntesmail.com
 [156.224.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF79310E1B6;
 Tue, 20 Oct 2026 01:33:19 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 51a0a3a65;
 Tue, 20 Oct 2026 09:28:12 +0800 (GMT+08:00)
Message-ID: <14852d51-eac2-4933-b786-948fbf0f0706@rock-chips.com>
Date: Tue, 20 Oct 2026 09:28:00 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] drm: writeback: don't destroy the shared writeback
 properties
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 John Harrison <John.Harrison@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
 Brian Starkey <brian.starkey@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
 <20261019-wb-drop-encoder-v7-7-d4288a26eb54@oss.qualcomm.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261019-wb-drop-encoder-v7-7-d4288a26eb54@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa156ec57c703a7kunm0a3e7447726d61
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSh9NVhlIHU9NH04dTUIaSlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=gTxNTfGSyaOOvMaGprXiXKZMOe++RQG0eP8q8U6hl3BtnG/aJfNYC74BwlxSIxLdaFPlnHalBnhZGuY6Ue0lc0Ck3vqRpTOL4qYXs/nsN7K86RyI6Pv7njesYRTmlHDOOwRXHIpWHfU72cr6PQxTfS2gZwn6HUgfyhdaSamIS/A=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=bWBcv8C01IwfRuVPSoLR1DOPENxFQuQLLISriS4I3Bo=;
 h=date:mime-version:subject:message-id:from;
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

Hi Dmitry,

On 10/19/2026 9:12 PM, Dmitry Baryshkov wrote:
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
> 

If a user attaches a private property to a connector, are they 
responsible for calling put on that property during cleanup? 
In that case, can drmm* functions be used to clean up these 
properties? Thank you.


> Fixes: 2f3f4a73631b ("drm: writeback: Add missing cleanup in case of initialization failure")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/drm_writeback.c | 34 ++++++----------------------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index 89c36f1414ce..2f6a7b50336c 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -148,22 +148,6 @@ static int create_writeback_properties(struct drm_device *dev)
>  	return 0;
>  }
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
>  /**
>   * __drm_writeback_connector_init - Initialize a writeback connector
>   *
> @@ -198,20 +182,18 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>  	int ret = create_writeback_properties(dev);
>  
>  	if (ret != 0)
> -		goto failed_properties;
> +		return ret;
>  
>  	connector->interlace_allowed = 0;
>  
>  	ret = drm_connector_attach_encoder(connector, enc);
>  	if (ret)
> -		goto failed_properties;
> +		return ret;
>  
>  	blob = drm_property_create_blob(dev, n_formats * sizeof(*formats),
>  					formats);
> -	if (IS_ERR(blob)) {
> -		ret = PTR_ERR(blob);
> -		goto failed_properties;
> -	}
> +	if (IS_ERR(blob))
> +		return PTR_ERR(blob);
>  
>  	INIT_LIST_HEAD(&wb_connector->job_queue);
>  	spin_lock_init(&wb_connector->job_lock);
> @@ -234,9 +216,6 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>  	wb_connector->pixel_formats_blob_ptr = blob;
>  
>  	return 0;
> -failed_properties:
> -	delete_writeback_properties(dev);
> -	return ret;
>  }
>  
>  /**
> @@ -295,8 +274,8 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
>   * @dev: DRM device
>   * @data: Pointer to the writeback connector to clean up
>   *
> - * This will decrement the reference counter of blobs and destroy properties. It
> - * will also clean the remaining jobs in this writeback connector. Caution: This helper will not
> + * This will decrement the reference counter of blobs. It will also clean the
> + * remaining jobs in this writeback connector. Caution: This helper will not
>   * clean up the attached encoder and the drm_connector.
>   */
>  static void drm_writeback_connector_cleanup(struct drm_device *dev,
> @@ -306,7 +285,6 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
>  	struct drm_writeback_job *pos, *n;
>  	struct drm_writeback_connector *wb_connector = data;
>  
> -	delete_writeback_properties(dev);
>  	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
>  
>  	spin_lock_irqsave(&wb_connector->job_lock, flags);
> 

-- 
Best, 
Chaoyi
