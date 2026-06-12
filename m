Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B807CD98D6
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5D610EB0E;
	Fri, 12 Jun 2026 18:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bdTiR52D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952DB10EB0E
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:26:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 179D0601E2;
 Fri, 12 Jun 2026 18:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F781F000E9;
 Fri, 12 Jun 2026 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781288804;
 bh=fDvNS2WFK4zT+LRFpQO+de6OaZj5lw0a9i7V1PhdgMQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bdTiR52DuAksKAiSdHyvyD/q9Igu6YRQagQcIYDKwtj2aCVuNmfCvqsb9K8ndsfYL
 KJmW3lbmjz4PYiA/oNRIlOVcRkcCiy7ILGXmWf75a4lOdpveo1UgAJcZMzS6PVXq71
 xZMAKBmiyYb2F/trNjC6BNew8i6W9yB0XpPgkMitiOq2hMG8kIoj7x7sRTKtOfUgoY
 /IxFAdZhgjXo6Z++XGq1R6phb0ieJZ9ex8kZqlMUrlo0oQkS7TIF4uXzsWN8/Hc/Nv
 KRIslLwP4207Wmg7TMweiXS/Z5kw9s234ykVJ0JQoKzDAbYoBaWY2oivbHa/2EmaJ6
 QXv6GlPOtv4Eg==
Message-ID: <921fb98f-8737-4249-b07c-cafa2a4fdea0@kernel.org>
Date: Fri, 12 Jun 2026 13:26:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] accel/amdxdna: Fix iommu domain lifetime race
 during device removal
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260611055150.3070216-1-lizhi.hou@amd.com>
 <20260611055150.3070216-3-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260611055150.3070216-3-lizhi.hou@amd.com>
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



On 6/11/26 00:51, Lizhi Hou wrote:
> When force_iova mode is enabled, amdxdna_remove() frees xdna->domain. If
> amdxdna_gem_obj_free() is called after device removal, it may attempt to
> access xdna->domain, resulting in a use-after-free.
> 
> Fix the race by adding freeing xdna->domain as a managed release action,
> so its lifetime is managed by DRM and remains valid until all managed
> resources are released.
> 
> Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_iommu.c | 43 ++++++++++++++++++---------
>   1 file changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdna/amdxdna_iommu.c
> index eff00131d0f8..4f245b969eef 100644
> --- a/drivers/accel/amdxdna/amdxdna_iommu.c
> +++ b/drivers/accel/amdxdna/amdxdna_iommu.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <drm/amdxdna_accel.h>
> +#include <drm/drm_managed.h>
>   #include <linux/iommu.h>
>   #include <linux/iova.h>
>   
> @@ -153,10 +154,30 @@ void amdxdna_iommu_free(struct amdxdna_dev *xdna, size_t size,
>   	free_pages((unsigned long)cpu_addr, get_order(size));
>   }
>   
> +static void amdxdna_cleanup_force_iova(struct drm_device *dev, void *res)
> +{
> +	struct amdxdna_dev *xdna = to_xdna_dev(dev);
> +
> +	if (xdna->domain) {
> +		iommu_detach_group(xdna->domain, xdna->group);
> +		put_iova_domain(&xdna->iovad);
> +		iova_cache_put();
> +		iommu_domain_free(xdna->domain);
> +	}
> +
> +	iommu_group_put(xdna->group);
> +}
> +
> +void amdxdna_iommu_fini(struct amdxdna_dev *xdna)
> +{
> +	if (xdna->group && !xdna->domain)
> +		iommu_group_put(xdna->group);
> +}
> +
>   int amdxdna_iommu_init(struct amdxdna_dev *xdna)
>   {
>   	unsigned long order;
> -	int ret;
> +	int ret = 0;
>   
>   	xdna->group = iommu_group_get(xdna->ddev.dev);
>   	if (!xdna->group || !force_iova)
> @@ -182,8 +203,14 @@ int amdxdna_iommu_init(struct amdxdna_dev *xdna)
>   	if (ret)
>   		goto put_iova;
>   
> +	ret = drmm_add_action(&xdna->ddev, amdxdna_cleanup_force_iova, NULL);
> +	if (ret)
> +		goto detach_group;
> +
>   	return 0;
>   
> +detach_group:
> +	iommu_detach_group(xdna->domain, xdna->group);
>   put_iova:
>   	put_iova_domain(&xdna->iovad);
>   	iova_cache_put();
> @@ -191,20 +218,8 @@ int amdxdna_iommu_init(struct amdxdna_dev *xdna)
>   	iommu_domain_free(xdna->domain);
>   put_group:
>   	iommu_group_put(xdna->group);
> +	xdna->group = NULL;
>   	xdna->domain = NULL;
>   
>   	return ret;
>   }
> -
> -void amdxdna_iommu_fini(struct amdxdna_dev *xdna)
> -{
> -	if (xdna->domain) {
> -		iommu_detach_group(xdna->domain, xdna->group);
> -		put_iova_domain(&xdna->iovad);
> -		iova_cache_put();
> -		iommu_domain_free(xdna->domain);
> -	}
> -
> -	if (xdna->group)
> -		iommu_group_put(xdna->group);
> -}

