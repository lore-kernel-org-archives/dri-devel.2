Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E779606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tiHz+Cm8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BFE112499;
	Thu, 19 Nov 2026 14:33:24 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D40C11249B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:33:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 42328C4CBF6;
 Thu, 19 Nov 2026 14:33:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CC94060237;
 Thu, 19 Nov 2026 14:33:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 838A511BC0C25; Thu, 19 Nov 2026 15:33:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795098791; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3iOPrmDBeLNuU6Puk+mYmzZxNUc6D6NyMUemoCOwSNc=;
 b=tiHz+Cm86tKjAD8gIEkpXuUz7hMXYZeTeGmbwPRS3IyH12FdiM6q2jviIhVq/P6jeFiX3L
 jZz6AuGeKXLbBvTVJMxwZoYz8M/oKz3iFVVD1+rHKRciLTAbwbzfUwFRiMAglLF/PURsNE
 Weg6bwz8JUCMS282/dlS6PbuZmfwp68fKVFR5zeGfoLkf1tLBgYTMYzWPGZKDS7KzHDRqN
 wk460xOMhlP6Bj12SCesaG4cC33NYiEXjFrfGL1X1G1lqzS/3wifZ0a98xRcFm7b+4UgCc
 MaGlUnm7fAu/z72U/icFTi/mqherhAe6HL6k3GhCwOtfjh58qeaS29ZUnlNtKg==
Message-ID: <16a151dd-de63-48ff-8e2a-2d60d71caebd@bootlin.com>
Date: Thu, 19 Nov 2026 15:33:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vkms: Fix kernel-doc parameter and member names
To: Aryan Sinha <sinha.aryan03@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261012154449.42015-1-sinha.aryan03@gmail.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261012154449.42015-1-sinha.aryan03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 10/12/26 17:44, Aryan Sinha wrote:
> A handful of kernel-doc entries name things that do not exist. struct
> vkms_output documents encoder and connector and misspells wb_connector,
> struct vkms_connector calls its base member drm, vkms_crtc_init() lists a
> crtc argument it does not take, the CRTC plane helpers say crtc_config
> instead of crtc_cfg, and vkms_config_plane_get_type() is written without
> the get.
> 
> struct vkms_device used a dash instead of a colon, so its entries were
> being ignored rather than warned about. Switch it over and drop output,
> which is not a member either.
> 
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> @vblank_hrtimer and @period_ns in struct vkms_output are stale too, but
> they are already removed by Thomas Zimmermann's pending patch, so this
> one leaves them alone:
> https://lore.kernel.org/all/20260420131831.242882-1-tzimmermann@suse.de/
>   drivers/gpu/drm/vkms/vkms_config.h    |  6 +++---
>   drivers/gpu/drm/vkms/vkms_connector.h |  2 +-
>   drivers/gpu/drm/vkms/vkms_drv.h       | 11 ++++-------
>   3 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 8f7f286a4..56805b0c9 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -269,7 +269,7 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config);
>   void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg);
>   
>   /**
> - * vkms_config_plane_type() - Return the plane type
> + * vkms_config_plane_get_type() - Return the plane type
>    * @plane_cfg: Plane to get the type from
>    */
>   static inline enum drm_plane_type
> @@ -373,7 +373,7 @@ vkms_config_crtc_set_writeback(struct vkms_config_crtc *crtc_cfg,
>   /**
>    * vkms_config_crtc_primary_plane() - Return the primary plane for a CRTC
>    * @config: Configuration containing the CRTC
> - * @crtc_config: Target CRTC
> + * @crtc_cfg: Target CRTC
>    *
>    * Note that, if multiple primary planes are found, the first one is returned.
>    * In this case, the configuration will be invalid. See vkms_config_is_valid().
> @@ -387,7 +387,7 @@ struct vkms_config_plane *vkms_config_crtc_primary_plane(const struct vkms_confi
>   /**
>    * vkms_config_crtc_cursor_plane() - Return the cursor plane for a CRTC
>    * @config: Configuration containing the CRTC
> - * @crtc_config: Target CRTC
> + * @crtc_cfg: Target CRTC
>    *
>    * Note that, if multiple cursor planes are found, the first one is returned.
>    * In this case, the configuration will be invalid. See vkms_config_is_valid().
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
> index ed312f4ef..52ae97af2 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.h
> +++ b/drivers/gpu/drm/vkms/vkms_connector.h
> @@ -11,7 +11,7 @@
>   /**
>    * struct vkms_connector - VKMS custom type wrapping around the DRM connector
>    *
> - * @drm: Base DRM connector
> + * @base: Base DRM connector
>    */
>   struct vkms_connector {
>   	struct drm_connector base;
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 0933e4ce0..1c94a2dea 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -202,9 +202,8 @@ struct vkms_crtc_state {
>    * struct vkms_output - Internal representation of all output components in VKMS
>    *
>    * @crtc: Base CRTC in DRM
> - * @encoder: DRM encoder used for this output
> - * @connector: DRM connector used for this output
> - * @wb_connecter: DRM writeback connector used for this output
> + * @wb_connector: DRM writeback connector used for this output
> + * @wb_encoder: DRM encoder used for this output
>    * @vblank_hrtimer: Timer used to trigger the vblank
>    * @period_ns: vblank period, in nanoseconds, used to configure @vblank_hrtimer and to compute
>    *	       vblank timestamps
> @@ -234,9 +233,8 @@ struct vkms_config_plane;
>   /**
>    * struct vkms_device - Description of a VKMS device
>    *
> - * @drm - Base device in DRM
> - * @faux_dev - Associated faux device
> - * @output - Configuration and sub-components of the VKMS device
> + * @drm: Base device in DRM
> + * @faux_dev: Associated faux device
>    * @config: Configuration used in this VKMS device
>    */
>   struct vkms_device {
> @@ -284,7 +282,6 @@ void vkms_destroy(struct vkms_config *config);
>   /**
>    * vkms_crtc_init() - Initialize a CRTC for VKMS
>    * @dev: DRM device associated with the VKMS buffer
> - * @crtc: uninitialized CRTC device
>    * @primary: primary plane to attach to the CRTC
>    * @cursor: plane to attach to the CRTC
>    */

