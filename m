Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFCD606A899
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=optzp7yl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D8D10EB09;
	Thu, 12 Nov 2026 01:35:24 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7D710EADA;
 Thu, 12 Nov 2026 01:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=9qYkLbX/jBWfhi0JFqENdn73axFTFxV3xClGvE2vBpQ=; t=1794447317; x=2109807317; 
 b=optzp7yl2JiIzWmjx7ND2MX4WrKcVWtjy5ztRpOBXhGBEf2SpXy0ste3E+cLa9TA8vkoAGLFS+X
 PoogpbcEAZHv16V1DJWf3+kATIU0j2L3tUgQlUEI+pTVaHOWANJOf6z0O4OiUVjwjnUsOnuN0wYnu
 pzHKjQ83/8DBBuaCZvPKXNJothLz3zf8toDFELXBBE5v0XJDOGSqRcOPHCEJzRkT178NAMnV4cltF
 UkwNpHgP4YZFZdrg6ZNJyvSxK9f5YAgaR182bOaPe3fAds3of8W+7oRIUfDlJivPiJ5X+viIRt1v8
 hvzZ+1rwr3xqB6lFkVe+IMeZ12lpmrXqYTRQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xRJiP-009F7G-62; Thu, 12 Nov 2026 02:35:01 +0100
Message-ID: <3be36c29-8c6d-4205-9c93-3de2445577e0@Igalia.com>
Date: Wed, 11 Nov 2026 17:34:53 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/10] drm: writeback: clean up writeback jobs outside
 the job_lock
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
 <20261111-wb-drop-encoder-v8-8-62948ed87d13@oss.qualcomm.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20261111-wb-drop-encoder-v8-8-62948ed87d13@oss.qualcomm.com>
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
> drm_writeback_connector_cleanup() frees the jobs left on the queue while
> holding job_lock with interrupts disabled. drm_writeback_cleanup_job()
> may sleep, though: dropping the last framebuffer reference takes
> mode_config.idr_mutex and other mutexes, and a driver's
> cleanup_writeback_job() hook (e.g. amdgpu) grabs a dma_resv ww_mutex.
>
> Splice the queue onto a local list under the lock and free the jobs after
> dropping it, so the sleeping work runs in process context.
>
> Fixes: 1914ba2b91ea ("drm: writeback: Create drmm variants for drm_writeback_connector initialization")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: John Harrison <John.Harrison@Igalia.com>

> ---
>   drivers/gpu/drm/drm_writeback.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index 2f6a7b50336c..6487f4a104f2 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -281,18 +281,21 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
>   static void drm_writeback_connector_cleanup(struct drm_device *dev,
>   					    void *data)
>   {
> -	unsigned long flags;
> -	struct drm_writeback_job *pos, *n;
>   	struct drm_writeback_connector *wb_connector = data;
> +	struct drm_writeback_job *pos, *n;
> +	unsigned long flags;
> +	LIST_HEAD(jobs);
>   
>   	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
>   
>   	spin_lock_irqsave(&wb_connector->job_lock, flags);
> -	list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry) {
> +	list_splice_init(&wb_connector->job_queue, &jobs);
> +	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
> +
> +	list_for_each_entry_safe(pos, n, &jobs, list_entry) {
>   		list_del(&pos->list_entry);
>   		drm_writeback_cleanup_job(pos);
>   	}
> -	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
>   }
>   
>   /**
>

