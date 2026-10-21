Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A2606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=QOXE3p3Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE8C10E047;
	Wed, 21 Oct 2026 18:23:31 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C45010E047;
 Wed, 21 Oct 2026 18:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=k+mGq79QMKjrSkSLMADnpcKSaAXj7e9cJf4qURAwo/M=; b=QOXE3p3QA5L0H+77bQ3KoiWi1C
 dxNtqz8H2MBSfebJ0xfyMZ5/4VvO42ldY0OHK/L5dAlPXLq4mH5uJrht2a58ZKalFGMcxMU38jhhI
 ARRh9Lm9BXgd3Dxckb1H98yF+oqJpLGpNYITUlOAsJMAp+gbJhT1ZFJuVTOb5dDFwJ3hMWbzvhJww
 2IDx0rE0C9n6Em/FqPknxm/wF+xH0rAWGVGL753LiqGls2TvKA4D94WS8fKHkkEzggEhdG6xSJ3mS
 tkxdBGCec8Uv/a0Y6+7c3T2aGH6i+CysDQjaQFFafb/ZBZw8N3lO7ZjJhn3Nz2/cE7JsFsYtr8XTp
 WPGom9lQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJaxo-005tpt-KC; Wed, 21 Oct 2026 20:23:00 +0200
Message-ID: <d792066e-c857-4e80-8587-44a58ab75815@Igalia.com>
Date: Wed, 21 Oct 2026 11:22:48 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/9] drm: writeback: clean up writeback connectors in
 drm_connector_cleanup()
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
 <20261019-wb-drop-encoder-v7-8-d4288a26eb54@oss.qualcomm.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20261019-wb-drop-encoder-v7-8-d4288a26eb54@oss.qualcomm.com>
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
> Only drmm_writeback_connector_init() registers
> drm_writeback_connector_cleanup(). Connectors set up with
> drm_writeback_connector_init() (amdgpu, komeda, malidp, rcar-du, vc4)
> never drop the formats blob or free the jobs still on the queue, leaking
> them together with their framebuffer and fence references.
>
> Call drm_writeback_connector_cleanup() from drm_connector_cleanup() for
> writeback connectors, the same way the HDMI audio and SCDC state is torn
> down there, so it runs for both kinds of initialization. The drmm action
> now just wraps it. Clearing the blob pointer makes the second invocation
> a no-op and also covers drm_connector_cleanup() being called after a
> failed __drm_writeback_connector_init().
>
> Fixes: 935774cd71fe ("drm: Add writeback connector type")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/drm_connector.c     |  3 +++
>   drivers/gpu/drm/drm_crtc_internal.h |  3 +++
>   drivers/gpu/drm/drm_writeback.c     | 30 +++++++++++++++++++++++-------
>   3 files changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 893716a9e489..1c2bef5e0636 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -929,6 +929,9 @@ void drm_connector_cleanup(struct drm_connector *connector)
>   	if (connector->hdmi.scdc_work_initialized)
>   		cancel_delayed_work_sync(&connector->hdmi.scdc_work);
>   
> +	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +		drm_writeback_connector_cleanup(connector);
> +
Could this be done via a new connector->funcs->cleanup() vfunc or 
something? Set that inside the writeback init path and it is guaranteed 
to then only be called for objects that explicitly requested it. That 
would be more robust and would keep sashiko happy. It would also keep a 
writeback connector specific declaration out of the crtc_internal header.

John.

>   	platform_device_unregister(connector->hdmi_audio.codec_pdev);
>   
>   	if (connector->privacy_screen) {
> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
> index 3492787c3697..f60216adcd31 100644
> --- a/drivers/gpu/drm/drm_crtc_internal.h
> +++ b/drivers/gpu/drm/drm_crtc_internal.h
> @@ -329,4 +329,7 @@ static inline void drm_panic_unregister(struct drm_device *dev) {}
>   static inline void drm_panic_init(void) {}
>   #endif
>   
> +/* drm_writeback.c */
> +void drm_writeback_connector_cleanup(struct drm_connector *connector);
> +
>   #endif /* __DRM_CRTC_INTERNAL_H__ */
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index 2f6a7b50336c..272012a70efe 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -21,6 +21,8 @@
>   #include <drm/drm_property.h>
>   #include <drm/drm_writeback.h>
>   
> +#include "drm_crtc_internal.h"
> +
>   /**
>    * DOC: overview
>    *
> @@ -271,21 +273,27 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
>   
>   /**
>    * drm_writeback_connector_cleanup - Cleanup the writeback connector
> - * @dev: DRM device
> - * @data: Pointer to the writeback connector to clean up
> + * @connector: Writeback connector to clean up
>    *
>    * This will decrement the reference counter of blobs. It will also clean the
>    * remaining jobs in this writeback connector. Caution: This helper will not
>    * clean up the attached encoder and the drm_connector.
> + *
> + * Called from drm_connector_cleanup() for all writeback connectors.
>    */
> -static void drm_writeback_connector_cleanup(struct drm_device *dev,
> -					    void *data)
> +void drm_writeback_connector_cleanup(struct drm_connector *connector)
>   {
> -	unsigned long flags;
> +	struct drm_writeback_connector *wb_connector =
> +		drm_connector_to_writeback(connector);
>   	struct drm_writeback_job *pos, *n;
> -	struct drm_writeback_connector *wb_connector = data;
> +	unsigned long flags;
> +
> +	/* __drm_writeback_connector_init() has failed */
> +	if (!wb_connector->pixel_formats_blob_ptr)
> +		return;
>   
>   	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
> +	wb_connector->pixel_formats_blob_ptr = NULL;
>   
>   	spin_lock_irqsave(&wb_connector->job_lock, flags);
>   	list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry) {
> @@ -295,6 +303,14 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
>   	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
>   }
>   
> +static void drm_writeback_connector_cleanup_action(struct drm_device *dev,
> +						   void *data)
> +{
> +	struct drm_writeback_connector *wb_connector = data;
> +
> +	drm_writeback_connector_cleanup(&wb_connector->base);
> +}
> +
>   /**
>    * drmm_writeback_connector_init - Initialize a writeback connector
>    *
> @@ -333,7 +349,7 @@ int drmm_writeback_connector_init(struct drm_device *dev,
>   	if (ret)
>   		return ret;
>   
> -	ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup,
> +	ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup_action,
>   				       wb_connector);
>   	if (ret)
>   		return ret;
>

