Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E836C5DF66
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 00:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BAF10E2DE;
	Fri, 14 Aug 2026 00:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="C/tFuJDs";
	dkim-atps=neutral
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com
 [209.85.217.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE6610E2DE
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 00:11:31 +0000 (UTC)
Received: by mail-vs1-f98.google.com with SMTP id
 ada2fe7eead31-7564b7a9490so1010923137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786666290; x=1787271090;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lPLCjaBrluuYCVSfAFnmUWBEGWcFRCNckcEAwJZW/NY=;
 b=Tk50LIeexvNQCY4hAOTCDRyRVMHhxMOaK5cSx09R873m3whTLxCMaNB+snMu8xSr+7
 snkaBD+FhY43C27QhlWrzhSmm4xiHKGYP0+8NafHUYivREFWm0U0+Zab/HoEQIHIYqPx
 eug4mpr+d1rzbryltPr/PQt7vl9XOVS16Fo5hNyotx+QFMs2W1DEN8B4p7fA1PnOJz+g
 ceocnJF70jvM2dTz3hadG7P40VvSfGpU1XOmZIkRv3+716EO63iWEgYaN85tkmJyHkqT
 2VZnZl7EycRCu3f6byKcfuCw/ZXgHn7Inv90Y5EkuwXLsuvMy8qVoQ07V9E7Dm59GwOv
 WAwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbUQdeQnDE9Ug+7EZf3nlKqEIcrKU2xHApMgC+sxIAwgb9d67SmbMgqiJbKg7ZyQzbsh8H5eVCYm4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7lryPAX2zAZ5sCM5zZuPhKsVoAtXLIQ0FpOlvW0sjidx+hf/r
 bkw96nU1sgYlRheGrZFnBB8jdcSo9/06TJAK2MsZv7Xxy6oAGHMJ7JChI0/5iQrCslkNw4ukQ6Q
 6WWa38MCDe9t9U9xqetEc2cpY5DmEk2dLnzxNo14pufJjk76p8gIxDudvBnKAo1p82JOfMICCk6
 DyZIMB1mStr0AQ3BCIzd6VpXriye4wzuScm3FwA+uvST4EIfKSuFLdIP+OoTrT8wjilIGe5yX9W
 FOiRVdK8DAM1OvoimRZDZL7tGYy
X-Gm-Gg: AR+sD12iW1dRbskGSPlWa+6RXzWqbYy4a3ElC3JvicFjQyh55oKUq0atUFza4pkADhy
 FJpObGzfdERgY5ZYaNIKtaQyeU/dxF9M6EQeTNWS20BJXGHlZ9OiISEhdswKwzrKKqzIMpfmFRJ
 9Ge5FGeSVWFJ8XDfqmTm1orJntxsB4O29U0oVp0jXesjOwwAkMYiA0PDlWb9Clo+iEsx2pjp/ht
 OqPFtnrKayg8Ij95kUCCWm9htYHVq59elZV2Mq2pM7zt/PSrWua7FzCgTxD1rpKFeJ0Ihfor3my
 +1vA9B68fgxy2VkYFl9HKbD5lPh8TeOBxpB6bSdUOKEG4SSkEkSeAFHdUaKRIG1u/qE1uSR55Q9
 EjW1BeGJ2iiUOkrdyhBE0DKQhAeVqDcq+qTAFuFU0JKuQpYGEhHZKANvBmcU0mSkgSGnpwiLpbi
 O7Z4FYG1VmRlLz2i+dqaHjhfhqXSZ0kfRq6Y+v6g==
X-Received: by 2002:a05:6102:2d0d:b0:73e:e4ab:1c84 with SMTP id
 ada2fe7eead31-76f23aeb969mr267011137.5.1786666290092; 
 Thu, 13 Aug 2026 17:11:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-76efa712c46sm7590137.18.2026.08.13.17.11.29
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Aug 2026 17:11:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so45529785a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1786666289; x=1787271089;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lPLCjaBrluuYCVSfAFnmUWBEGWcFRCNckcEAwJZW/NY=;
 b=C/tFuJDsa6EXS+dobUy6w9gYNX1qJyqKrd9ol/Jr0HynMkWbqrHHxvLziemf4Gp+jC
 C60HnkYVsi0YbVN3yns9xkEAJ4vwVmML3Rep0N2xQQjiY5vp2FZYqAqev4u0sFn9BKzi
 qCfrl2j3oEATVnZ5RLCMnfS0pBE68BK1G5gJg=
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0/WEPBsW1jIoZuX50IWIyR59QI7XhELBBTZsO+7qIfZ8Q1TNph5s9vmBD3xxA4ybHVrCNzPBLY5s=@lists.freedesktop.org
X-Received: by 2002:a05:620a:3185:b0:92b:9401:7320 with SMTP id
 af79cd13be357-936c05e1c10mr865753385a.2.1786666289407; 
 Thu, 13 Aug 2026 17:11:29 -0700 (PDT)
X-Received: by 2002:a05:620a:3185:b0:92b:9401:7320 with SMTP id
 af79cd13be357-936c05e1c10mr865749285a.2.1786666288932; 
 Thu, 13 Aug 2026 17:11:28 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936d02b0a91sm66761385a.42.2026.08.13.17.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 17:11:28 -0700 (PDT)
Message-ID: <5a599bdf-e8f6-407b-a6b0-c32b5edec346@broadcom.com>
Date: Thu, 13 Aug 2026 17:11:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: validate pitch coming from userspace
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, stable@vger.kernel.org,
 Youness HFA <hfa.youness@gmail.com>
References: <20260809204515.211045-1-zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260809204515.211045-1-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

On 8/9/26 1:45 PM, Zack Rusin wrote:
> Validate the pitch, alongside the box dimensions before trying
> to copy data from the underlying surface. Fixes possible
> out of bounds reads with cursor snooping.
> 
> Fixes: 2ac863719e51 ("vmwgfx: Snoop DMA transfers with non-covering sizes")
> Cc: stable@vger.kernel.org
> Reported-by: Youness HFA <hfa.youness@gmail.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> index d1e7df500190..f4d14b00d7aa 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -324,6 +324,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
>  	unsigned long kmap_num;
>  	SVGA3dCopyBox *box;
>  	u32 box_count;
> +	u64 src_extent;
>  	void *virtual;
>  	bool is_iomem;
>  	struct vmw_dma_cmd {
> @@ -372,8 +373,19 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
>  		return;
>  	}
>  
> +	if (box->w == 0 || box->h == 0)
> +		return;
> +
> +	src_extent = (u64)(box->h - 1) * cmd->dma.guest.pitch +
> +		     (u64)box->w * desc->pitchBytesPerBlock;
> +	if (src_extent > bo->base.size) {
> +		DRM_ERROR("Cursor snoop source of %llu bytes exceeds the %zu byte buffer\n",
> +			  src_extent, bo->base.size);
> +		return;
> +	}
> +
>  	kmap_offset = cmd->dma.guest.ptr.offset >> PAGE_SHIFT;
> -	kmap_num = (VMW_CURSOR_SNOOP_HEIGHT * image_pitch) >> PAGE_SHIFT;
> +	kmap_num = PFN_UP(src_extent);
>  
>  	ret = ttm_bo_reserve(bo, true, false, NULL);
>  	if (unlikely(ret != 0)) {
> @@ -387,14 +399,16 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
>  
>  	virtual = ttm_kmap_obj_virtual(&map, &is_iomem);
>  
> -	if (box->w == VMW_CURSOR_SNOOP_WIDTH && cmd->dma.guest.pitch == image_pitch) {
> +	if (box->w == VMW_CURSOR_SNOOP_WIDTH &&
> +	    box->h == VMW_CURSOR_SNOOP_HEIGHT &&
> +	    cmd->dma.guest.pitch == image_pitch) {
>  		memcpy(srf->snooper.image, virtual,
>  		       VMW_CURSOR_SNOOP_HEIGHT * image_pitch);
>  	} else {
>  		/* Image is unsigned pointer. */
>  		for (i = 0; i < box->h; i++)
>  			memcpy(srf->snooper.image + i * image_pitch,
> -			       virtual + i * cmd->dma.guest.pitch,
> +			       virtual + (size_t)i * cmd->dma.guest.pitch,
>  			       box->w * desc->pitchBytesPerBlock);
>  	}
>  	srf->snooper.id++;


LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

Will you also backport this to pre-6.14 LTR kernels when all this code was in vmwgfx_kms.c?


-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
