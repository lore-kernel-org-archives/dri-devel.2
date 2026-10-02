Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BB0CA5FD9
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1531C10F43E;
	Fri,  2 Oct 2026 08:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EoxcJ6eD";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F2810F43E
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790927997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2ewRAcEFZL3TkjryfIMjnBrr7TaNrziWSopES4i/W8=;
 b=EoxcJ6eDvqQ9TdZeQwNCEzwIgs1JZAx7wXI6aEI+es+QdxdM+muhmW1xNfkFlYQ9hGU1iE
 E1gWN1+KvNsczoqFLhe1g7rGwIW04WYCXWLmG5vLS7FDeKNeh/yJSZEIzUI9s1BZch/KzW
 5rH9mvOsqM9s8xum8gopyYtyasLOKqY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-yeSqgj0hOSGsW4AEpeftNg-1; Fri, 02 Oct 2026 03:59:48 -0400
X-MC-Unique: yeSqgj0hOSGsW4AEpeftNg-1
X-Mimecast-MFC-AGG-ID: yeSqgj0hOSGsW4AEpeftNg_1790927988
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso2074823f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 00:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790927987; x=1791532787;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b2ewRAcEFZL3TkjryfIMjnBrr7TaNrziWSopES4i/W8=;
 b=UMf2TtVDvsU5D8/x75CnOysxiWE6R1wdBh3kHTv69xIOe+DACYJAAPhASvnipwCsU4
 x6jTUILzHlwp0vKfkIX8cNQ658cEtW2s+KhGB5MQu8u1AfUdElb5ZGM2+bkFrpQ2s+F9
 8R9hLR7l+rkdZ7ZcOAxbrAJkWmPB2jEYa4LJnrcmdUKtO9tZDN3Lsw22pIwADMQWuTZc
 /3J5mDksHgFpsYmmrdS2ld2UKiVdbo6Rx394wVXfgh7PK6AYzjmGtIfpYq++aXrI6pOY
 /tG6r6NqrLmy6YS4II2detSnaF88P9IE7ls6mao+/FFP16XAqXRqyIvT43g0paLH8MwC
 LjTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxV6i9eCl2BasCHFZUtps1hf37DRDGlsIYQkho/xDs59MGD529trGNW5kxwHrgY7tRzwbbQh3gXHIU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbtNPU9Qn9sViJ4od5o6XVTHtTSgMVgNTAeBJwU14EFbn+Crb+
 Gvx12KlFlitiD3lKddX65qdsd8yAdYn6P1It2ULVr1ZqW/NottbnWzxTmw0Rl0Gw6cTDLD0Vatk
 lF0P+tEeapseML/tpHbZ7lCDDLwxuwiSuFXON+t1w3NI5KwGXO8VNzUsjlyA5blmv6rDm6g==
X-Gm-Gg: AYBFou1p1l1MVdZO7ETzXjMoe41YO53OWFUmiLMp7qtPI+huSX/p7mlgYOIOMpmg9CZ
 424xF91TxbKgaUaGeZHwRn4aE/V+LS3z44tHXXkS+JMm0vKlvPaujhqT8onuSz8WA3wL3EBD2qx
 mGIo8tvNU9EBYl4MyV1ofOnO2C3mPWspBWmbeGcwUT7qQz8CBVaY+s1n0aRksKlyjYptfujjK4D
 ymdUhx6L0MJiXLFTH00OIESARZD0avdnbi06mxC+uIoXoXkSugCNHTSG1nioUZWwcbF0NMY20nP
 DVW9a1Mb8LBe9FlGc+nTED3Eu5/w/TbLOEJmImp+SDR84vp/7mT8TLUyVazvothmGXMglvOXJpY
 gIflUcW1aAvgVmHxMZ+Tx5j/GT9y+F3ghVm901+CNC+UFyFw=
X-Received: by 2002:adf:fec2:0:b0:48b:3f2:2ec7 with SMTP id
 ffacd0b85a97d-48b1274a1a3mr2621410f8f.31.1790927987604; 
 Fri, 02 Oct 2026 00:59:47 -0700 (PDT)
X-Received: by 2002:adf:fec2:0:b0:48b:3f2:2ec7 with SMTP id
 ffacd0b85a97d-48b1274a1a3mr2621375f8f.31.1790927987205; 
 Fri, 02 Oct 2026 00:59:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b383065a4sm3666324f8f.44.2026.10.02.00.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 00:59:46 -0700 (PDT)
Message-ID: <b1671981-0046-4702-a915-ac65ee6c9543@redhat.com>
Date: Fri, 2 Oct 2026 09:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/vmwgfx: Add drm_panic support
To: Ian Forbes <ian.forbes@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, maaz.mombasawala@broadcom.com,
 ryasuoka@redhat.com, zack.rusin@broadcom.com, tzimmermann@suse.de
References: <20251107204620.1021749-1-ian.forbes@broadcom.com>
 <20260929165104.928415-1-ian.forbes@broadcom.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260929165104.928415-1-ian.forbes@broadcom.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yEmAG2SQcSiOJcKIAnlZdMA-n4jtlP4_2auD57JTx0o_1790927988
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/29/26 18:51, Ian Forbes wrote:
> Uses VRAM as the scanout buffer then switches the device to legacy mode.
> Restrict support to 64 Bit so we don't waste valuable VA space on the
> mostly unused VRAM mapping.

Thanks a lot for to resending this patch.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Suggested-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
> ---
> 
> v2:
>   - Set SVGA_REG_CONFIG_DONE=false so that SVGA3 works correctly
> v3:
>   - Rebase
>   - Pre-map VRAM
>   - Restrict to 64 Bit only
> 
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c  |  6 +++++
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  |  1 +
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 34 ++++++++++++++++++++++++++++
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  5 ++++
>   drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  4 ++++
>   5 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 0f101aedb49a..e6e38b7a2d5b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -761,6 +761,12 @@ static int vmw_setup_pci_resources(struct vmw_private *dev,
>   		return -EINVAL;
>   	}
>   
> +#if defined(CONFIG_64BIT)
> +	dev->vram_mem = devm_memremap(dev->drm.dev,
> +				      dev->vram_start,
> +				      dev->vram_size,
> +				      MEMREMAP_WB | MEMREMAP_DEC);
> +#endif
>   	/*
>   	 * This is approximate size of the vram, the exact size will only
>   	 * be known after we read SVGA_REG_VRAM_SIZE. The PCI resource
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> index 38bea8abab84..463b5a5dfc43 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -472,6 +472,7 @@ struct vmw_private {
>   	resource_size_t max_primary_mem;
>   	u32 __iomem *rmmio;
>   	u32 *fifo_mem;
> +	u32 *vram_mem;
>   	resource_size_t fifo_mem_size;
>   	uint32_t fb_max_width;
>   	uint32_t fb_max_height;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> index 31d3ee0825ca..2d5e51ed5568 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -21,6 +21,7 @@
>   #include <drm/drm_sysfs.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_blend.h>
> +#include <drm/drm_panic.h>
>   
>   void vmw_du_init(struct vmw_display_unit *du)
>   {
> @@ -2034,3 +2035,36 @@ bool vmw_user_object_is_null(struct vmw_user_object *uo)
>   {
>   	return !uo->buffer && !uo->surface;
>   }
> +
> +int
> +vmw_get_scanout_buffer(struct drm_plane *plane, struct drm_scanout_buffer *sb)
> +{
> +	void  *vram;
> +	struct vmw_private *vmw_priv = container_of(plane->dev, struct vmw_private, drm);
> +
> +	// Only call on the primary display
> +	if (container_of(plane, struct vmw_display_unit, primary)->unit != 0)
> +		return -EINVAL;
> +
> +	vram = vmw_priv->vram_mem;
> +	if (!vram)
> +		return -ENOMEM;
> +
> +	vmw_write(vmw_priv, SVGA_REG_CONFIG_DONE, false);
> +
> +	iosys_map_set_vaddr(&sb->map[0], vram);
> +	sb->format = drm_format_info(DRM_FORMAT_RGB565);
> +	sb->width  = vmw_priv->initial_width;
> +	sb->height = vmw_priv->initial_height;
> +	sb->pitch[0] = drm_format_info_min_pitch(sb->format, 0, sb->width);
> +	return 0;
> +}
> +
> +void vmw_panic_flush(struct drm_plane *plane)
> +{
> +	struct vmw_private *vmw_priv = container_of(plane->dev, struct vmw_private, drm);
> +
> +	vmw_kms_write_svga(vmw_priv,
> +			   vmw_priv->initial_width, vmw_priv->initial_height,
> +			   vmw_priv->initial_width * 2, 16, 16);
> +}
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> index 2224d7d91d1b..139c194ec54b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> @@ -498,6 +498,11 @@ int vmw_kms_stdu_readback(struct vmw_private *dev_priv,
>   
>   int vmw_du_helper_plane_update(struct vmw_du_update_plane *update);
>   
> +struct drm_scanout_buffer;
> +
> +int vmw_get_scanout_buffer(struct drm_plane *pl, struct drm_scanout_buffer *sb);
> +void vmw_panic_flush(struct drm_plane *plane);
> +
>   /**
>    * vmw_du_translate_to_crtc - Translate a rect from framebuffer to crtc
>    * @state: Plane state.
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> index 4139837f4caf..bf4b22cd9e5d 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> @@ -1506,6 +1506,10 @@ drm_plane_helper_funcs vmw_stdu_primary_plane_helper_funcs = {
>   	.atomic_update = vmw_stdu_primary_plane_atomic_update,
>   	.prepare_fb = vmw_stdu_primary_plane_prepare_fb,
>   	.cleanup_fb = vmw_stdu_primary_plane_cleanup_fb,
> +#if defined(CONFIG_64BIT)
> +	.get_scanout_buffer = vmw_get_scanout_buffer,
> +	.panic_flush = vmw_panic_flush,
> +#endif
>   };
>   
>   static const struct drm_crtc_helper_funcs vmw_stdu_crtc_helper_funcs = {

