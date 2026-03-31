Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11456109B469
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4E710E94F;
	Tue, 31 Mar 2026 13:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JA2q8yOl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DCD10E92D
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hnpxZKQoTgBsAdBksQ4KyMOEEX+2/hPCEGLFq6cT9nk=; b=JA2q8yOl0BVPybMWKb1tPQo9Rq
 ZckDV2zsDUHngHjnahUmz9yCcJzMW+oV8HMLp1PuvNjGzJVTBFwgxhw1yNtLSvRGUpCXiTlbl9LLh
 IpSrLLC9b+xRR/hzTCtqUlYK0ZV+E9ULKjBk0bL1e2JI4pOk5NLfEn7I1Zu49aYJAhkFCpaxkAk2g
 DssKRUTI8XIb7FS4Dgb5dL1BCIFYedN4F5iTDGVahR6BD0/AJbROv4l37xRbIQRIRVXodzY1l2gzT
 xhBfxc2gjQzxNA/3nIWTnXeWYyHuKd5TQNkjVFDfzD9lP2QOEZ77NqL62rC93gghcsfCBDf0HJBi2
 c4T2ON+A==;
Received: from [189.89.58.122] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w7Z9Q-009TD7-Qe; Tue, 31 Mar 2026 15:29:01 +0200
Message-ID: <80b0a8a0-90c4-44c5-bd56-c58653ca18be@igalia.com>
Date: Tue, 31 Mar 2026 10:28:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/vc4: Protect madv read in vc4_gem_object_mmap()
 with madv_lock
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
 <20260330-vc4-misc-fixes-v1-4-92defc940a29@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260330-vc4-misc-fixes-v1-4-92defc940a29@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 30/03/2026 14:51, Maíra Canal wrote:
> The mmap callback reads bo->madv without holding madv_lock, racing with
> concurrent DRM_IOCTL_VC4_GEM_MADVISE calls that modify the field under
> the same lock. Add the missing locking to prevent the data race.
>
> Fixes: b9f19259b84d ("drm/vc4: Add the DRM_IOCTL_VC4_GEM_MADVISE ioctl")
Reviewed-by: Melissa Wen <mwen@igalia.com>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_bo.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index f45ba47b4ba8645f371215c083d3ead3ddd5ffe8..9377e58f9bc256ea81e19cc442d04139feec20fe 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> @@ -738,12 +738,15 @@ static int vc4_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
>   		return -EINVAL;
>   	}
>   
> +	mutex_lock(&bo->madv_lock);
>   	if (bo->madv != VC4_MADV_WILLNEED) {
>   		DRM_DEBUG("mmapping of %s BO not allowed\n",
>   			  bo->madv == VC4_MADV_DONTNEED ?
>   			  "purgeable" : "purged");
> +		mutex_unlock(&bo->madv_lock);
>   		return -EINVAL;
>   	}
> +	mutex_unlock(&bo->madv_lock);
>   
>   	return drm_gem_dma_mmap(&bo->base, vma);
>   }
>

