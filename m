Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DE7CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BFDC10F01E;
	Wed, 17 Jun 2026 15:12:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="KuOcx0Bj";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC1A10F01E
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781709121; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O6nzthhr8ffBguhipBY1ICa0UJr7rAfF9URhb2cx7k7D1v88Fx1nRBFqOAtA+s0XzQ2fK0SgN5cJqQ1hWCRy7SQ9Y93wFDsvyDOKmHVXG7xAbsuKZ3bTyf/CnQeJndDTap2dPVPPDNoWfkK5Bw8KXcQ6+TUKLhTVHX/K1M9xuqg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781709121;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZjtSjyFt5TZ4cLUaoZ7JBXmXW1BxNLYyNANiatQ+YOk=; 
 b=MznfHGQZ1vJvbpP/LKPrXlWb6tVM4Bcdxz3S9QFQ9v68N8Ps+qxAMSXoEQs5TgixMkmY6sbaBB07VCkhbXtp9eY1UZHmzCyofJGySl/8/pO3l7QOb/KcnalNLF7RibJlCgn/090dr1WlbTAx1L+VgoG3FxlKkNAM4CIN5ErEz8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781709121; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ZjtSjyFt5TZ4cLUaoZ7JBXmXW1BxNLYyNANiatQ+YOk=;
 b=KuOcx0BjcFPbwoBpYv23pS1DvpYDcnYHn9dha5Wxa0nvvYUFPkx+g6wgPvjH1tE0
 YDKODIQtC0wQXCRyExyp6UMWJ0lNDtGiWcllzeIFt7QG3rUD4vP+lVRxH6TOvroPkOu
 /KxnyETSFMUv88tYig2L8XGFO1qD7NmPLj6Zro5o=
Received: by mx.zohomail.com with SMTPS id 1781709119480302.08162841751493;
 Wed, 17 Jun 2026 08:11:59 -0700 (PDT)
Message-ID: <54d6527d-30c2-4e73-846d-c0e5276c8f74@collabora.com>
Date: Wed, 17 Jun 2026 18:11:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Use common error handling code in two
 functions
To: Markus Elfring <Markus.Elfring@web.de>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <b7440806-e9e8-4027-afe1-f6fe9297d8b2@web.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <b7440806-e9e8-4027-afe1-f6fe9297d8b2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

Hi,

On 6/9/26 21:08, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 9 Jun 2026 20:00:07 +0200
> 
> Use additional labels so that a bit of exception handling can be better
> reused at the end of two function implementations.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c   |  7 +++----
>  drivers/gpu/drm/virtio/virtgpu_vram.c | 16 ++++++++--------
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 67865810a2e7..05b19c73103a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -318,15 +318,14 @@ static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
>  
>  	*sg_ents = DIV_ROUND_UP(size, PAGE_SIZE);
>  	ret = sg_alloc_table(sgt, *sg_ents, GFP_KERNEL);
> -	if (ret) {
> -		kfree(sgt);
> -		return NULL;
> -	}
> +	if (ret)
> +		goto free_sgt;
>  
>  	for_each_sgtable_sg(sgt, sg, i) {
>  		pg = vmalloc_to_page(data);
>  		if (!pg) {
>  			sg_free_table(sgt);
> +free_sgt:
>  			kfree(sgt);
>  			return NULL;
>  		}
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
> index 4ae3cbc35dd3..ec5b669fccfa 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> @@ -212,16 +212,12 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
>  
>  	/* Create fake offset */
>  	ret = drm_gem_create_mmap_offset(obj);
> -	if (ret) {
> -		kfree(vram);
> -		return ret;
> -	}
> +	if (ret)
> +		goto free_vram;
>  
>  	ret = virtio_gpu_resource_id_get(vgdev, &vram->base.hw_res_handle);
> -	if (ret) {
> -		kfree(vram);
> -		return ret;
> -	}
> +	if (ret)
> +		goto free_vram;
>  
>  	virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params, NULL,
>  					    0);
> @@ -237,6 +233,10 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
>  
>  	*bo_ptr = &vram->base;
>  	return 0;
> +
> +free_vram:
> +	kfree(vram);
> +	return ret;
>  }
>  
>  void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)

Please see [1], will be great if you could address the reported issues
with this patch in v2 and add another patch fixing the
virtio_gpu_resource_id_get() error handling.

[1]
https://sashiko.dev/#/patchset/b7440806-e9e8-4027-afe1-f6fe9297d8b2%40web.de

-- 
Best regards,
Dmitry
