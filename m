Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CF606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ew2XsXLk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475F810FD17;
	Wed, 18 Nov 2026 14:31:11 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B0510FD17
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:31:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 12B37C4CBDA;
 Wed, 18 Nov 2026 14:31:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2C79D5FE9B;
 Wed, 18 Nov 2026 14:31:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5D73911BC1D28; Wed, 18 Nov 2026 15:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795012256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=392Hdswd6RPVgoARz97n2rCwM4IdCSNMtjJg6BE/bLM=;
 b=Ew2XsXLkqtUOpCPT12pc1hvd84aXYM7wHSOTaA+EnsN0dNFY3Ua2doiE0ZnT3/UMkbkIPE
 H1jB6j9Php5QHjUMbNW0pUBIx3QVZBlHFCWxIke3VinNVOJhoDfe9aUgbhd75IJfBBU0LN
 TBNmaFLMOWHoy02XumJqjJNTlxGk8PKr6CUNoLchmsl39lHvnqmF+gQ7aduTJmQ8Bw5AY5
 pSb4V4gvxIVY3rGJAAWcyOGqAoyUAnP4MtXuHSASvcjDRxKEzX7iyb4EFmp52iNpahDQvN
 io7gsIQses3V8zw4i8cjH8zrcQbeXMhat7BBtn62CrJT2tsWaaQZ40jIjx9mRA==
Message-ID: <a520c744-3578-4d2d-8d88-72cd4facab7b@bootlin.com>
Date: Wed, 18 Nov 2026 15:30:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] drm/vkms: rename VKMS_LUT_SIZE to
 VKMS_GAMMA_LUT_SIZE
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-2-leandro.ribeiro@collabora.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261106201813.129911-2-leandro.ribeiro@collabora.com>
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



On 11/6/26 21:18, Leandro Ribeiro wrote:
> This is the size of the CRTC gamma LUT size. So let's specify this
> in the name.
> 
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> Tested-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/vkms/vkms_crtc.c | 4 ++--
>   drivers/gpu/drm/vkms/vkms_drv.c  | 2 +-
>   drivers/gpu/drm/vkms/vkms_drv.h  | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index fe17f49305a9..019d7bc90cdc 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -222,13 +222,13 @@ struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *pri
>   
>   	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
>   
> -	ret = drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
> +	ret = drm_mode_crtc_set_gamma_size(crtc, VKMS_GAMMA_LUT_SIZE);
>   	if (ret) {
>   		DRM_ERROR("Failed to set gamma size\n");
>   		return ERR_PTR(ret);
>   	}
>   
> -	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_LUT_SIZE);
> +	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_GAMMA_LUT_SIZE);
>   
>   	drm_crtc_attach_background_color_property(crtc);
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 5a640b531d88..86a8a95694fd 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -113,7 +113,7 @@ static int vkms_atomic_check(struct drm_device *dev, struct drm_atomic_commit *s
>   			continue;
>   
>   		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut *)
> -		    > VKMS_LUT_SIZE)
> +		    > VKMS_GAMMA_LUT_SIZE)
>   			return -EINVAL;
>   	}
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index dea6cad3f1b9..34b855431af3 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -25,7 +25,7 @@
>   
>   #define NUM_OVERLAY_PLANES 8
>   
> -#define VKMS_LUT_SIZE 256
> +#define VKMS_GAMMA_LUT_SIZE 256
>   
>   /**
>    * struct vkms_frame_info - Structure to store the state of a frame

