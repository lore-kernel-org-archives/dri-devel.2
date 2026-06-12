Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7EECD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533E710F2A9;
	Fri, 12 Jun 2026 07:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BIuT9w9u";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0050210F2A9
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781248358; x=1812784358;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bUJPVlwGV7oV3DLjYRgJflQae7CbAxZLA9Hg13GQ8Qc=;
 b=BIuT9w9uLVUYM6wPWYynPCMCegp8iK8DHjL6TeefJaIYGjTsor83gRL/
 y+93rZ0oET94ypjAm00EulaTqcefVCs7JTu8KztZhnF1gsw6mhLOVx4+P
 O6ScoqSXGaqLIhkYF51dA9sCLT6uk6jlxsK4o9CT0lRvH3cmMWHYvjr0i
 pVtnsxA53s1D7n1HkWa8sCAvVJNEGiJdsNSGn1yBhJlot15ud8uFYzePJ
 Eg1Blhzme2v9DJBEdNgsZ10PNRa/JDBrSe2XQbxIAR6UQKEaEoT5ACtNq
 qkg1A9Dy8dchtkzo2lytYA+HD0KOVDZuhEzoXEiR4VSdRBmoMp6RXn5WF w==;
X-CSE-ConnectionGUID: IEO3O0wATMyaDpZxQOhHcw==
X-CSE-MsgGUID: rhdUkl4mQq2RcGQ6xPudpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93566178"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="93566178"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 00:12:37 -0700
X-CSE-ConnectionGUID: dtVWLf3STJqT2X8V43wT/g==
X-CSE-MsgGUID: RdTfT7JcQcO/czNOr0GC5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="248628500"
Received: from soc-5cg43972ff.clients.intel.com (HELO [10.102.88.80])
 ([10.102.88.80])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 00:12:36 -0700
Message-ID: <0eab4c8a-65e6-4644-a6ef-e46a0d262980@linux.intel.com>
Date: Fri, 12 Jun 2026 09:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: use kmem_cache for IPC rx_msg allocations
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com
References: <20260611055214.948748-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <20260611055214.948748-1-karol.wachowski@linux.intel.com>
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

On 11-Jun-26 7:52 AM, Karol Wachowski wrote:
> Use a dedicated kmem_cache for ivpu_ipc_rx_msg allocations instead of
> the generic kmalloc. This gives each CPU its own hot freelist for this
> object type, reducing allocator overhead in the IRQ handler and threaded
> IRQ path where rx_msg objects are allocated and freed at high frequency.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_ipc.c | 17 ++++++++++++++---
>   drivers/accel/ivpu/ivpu_ipc.h |  1 +
>   2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index 64864e9d8a0a..c5f11be86c8c 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -146,7 +146,7 @@ ivpu_ipc_rx_msg_add(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>   
>   	lockdep_assert_held(&ipc->cons_lock);
>   
> -	rx_msg = kzalloc_obj(*rx_msg, GFP_ATOMIC);
> +	rx_msg = kmem_cache_zalloc(ipc->rx_msg_cache, GFP_ATOMIC);
>   	if (!rx_msg) {
>   		ivpu_ipc_rx_mark_free(vdev, ipc_hdr, jsm_msg);
>   		return;
> @@ -174,7 +174,7 @@ ivpu_ipc_rx_msg_del(struct ivpu_device *vdev, struct ivpu_ipc_rx_msg *rx_msg)
>   	list_del(&rx_msg->link);
>   	ivpu_ipc_rx_mark_free(vdev, rx_msg->ipc_hdr, rx_msg->jsm_msg);
>   	atomic_dec(&vdev->ipc->rx_msg_count);
> -	kfree(rx_msg);
> +	kmem_cache_free(vdev->ipc->rx_msg_cache, rx_msg);
>   }
>   
>   void ivpu_ipc_consumer_add(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
> @@ -490,10 +490,18 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
>   	struct ivpu_ipc_info *ipc = vdev->ipc;
>   	int ret;
>   
> +	ipc->rx_msg_cache = kmem_cache_create("ivpu_ipc_rx_msg", sizeof(struct ivpu_ipc_rx_msg), 0,
> +					      SLAB_HWCACHE_ALIGN, NULL);
> +	if (!ipc->rx_msg_cache) {
> +		ivpu_err(vdev, "Failed to create rx_msg_cache\n");
> +		return -ENOMEM;
> +	}
> +
>   	ipc->mem_tx = ivpu_bo_create_global(vdev, SZ_16K, DRM_IVPU_BO_WC | DRM_IVPU_BO_MAPPABLE);
>   	if (!ipc->mem_tx) {
>   		ivpu_err(vdev, "Failed to allocate mem_tx\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_destroy_cache;
>   	}
>   
>   	ipc->mem_rx = ivpu_bo_create_global(vdev, SZ_16K, DRM_IVPU_BO_WC | DRM_IVPU_BO_MAPPABLE);
> @@ -532,6 +540,8 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
>   	ivpu_bo_free(ipc->mem_rx);
>   err_free_tx:
>   	ivpu_bo_free(ipc->mem_tx);
> +err_destroy_cache:
> +	kmem_cache_destroy(ipc->rx_msg_cache);
>   	return ret;
>   }
>   
> @@ -544,6 +554,7 @@ void ivpu_ipc_fini(struct ivpu_device *vdev)
>   	drm_WARN_ON(&vdev->drm, atomic_read(&ipc->rx_msg_count) > 0);
>   
>   	ivpu_ipc_mem_fini(vdev);
> +	kmem_cache_destroy(ipc->rx_msg_cache);
>   }
>   
>   void ivpu_ipc_enable(struct ivpu_device *vdev)
> diff --git a/drivers/accel/ivpu/ivpu_ipc.h b/drivers/accel/ivpu/ivpu_ipc.h
> index 1c9cf67f1e5b..fb3e5816ca50 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.h
> +++ b/drivers/accel/ivpu/ivpu_ipc.h
> @@ -70,6 +70,7 @@ struct ivpu_ipc_info {
>   	struct gen_pool *mm_tx;
>   	struct ivpu_bo *mem_tx;
>   	struct ivpu_bo *mem_rx;
> +	struct kmem_cache *rx_msg_cache;
>   
>   	atomic_t rx_msg_count;
>   
Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
