Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A36ACD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D02110E211;
	Mon, 15 Jun 2026 07:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E9PNY1Xf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F7210E211
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 07:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781506965; x=1813042965;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vi3hFWp2QnFSL2VM2gSimAX/Ii2ub7Zz+qgK/WvLZZc=;
 b=E9PNY1Xf63JbHPREE5HclGMYWCpTFx7+SVM/9vlmBCqm21qWBdQMVM2t
 J1zKPYrIBPKwQzXp6X2noQF01QB1CpavbyiDcbiLyKZLWx7jw+l9zZ6Na
 7j0syrqSCEZxQXDatCUOn/n/cGa91Eh/04UXtAZE97ckJyjgoR7X+hRuB
 Q0aMQIZNFQCizEFQqS2wBFhcgJUb4D9RdeCXJgR99DzLJWOXbCXBS7iCI
 0nHXP3dwnp50Q4SHR9kkF583xrWvYtZtk0Hyh7njNhuOfQRFCveLVHAL7
 kVhIOij6nxJ/qicqvyVp3MMyOSdLte9k+nfSm1pI+cPSqTbDP4wUSYqzK A==;
X-CSE-ConnectionGUID: eK5RWV9zRESl2NjAjK2MvQ==
X-CSE-MsgGUID: DIVEDqk4RW2ioJ9KBaXKWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="104910833"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="104910833"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 00:02:44 -0700
X-CSE-ConnectionGUID: pOtqoJ4RTSuSgGDTfnfyKw==
X-CSE-MsgGUID: qbSl4ObvRK+V3LuHHq16+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="285500315"
Received: from pgcooper-mobl.ger.corp.intel.com (HELO [10.246.16.57])
 ([10.246.16.57])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 00:02:42 -0700
Message-ID: <847f968b-abe6-4f8a-a7f8-a4f2f0921a4a@linux.intel.com>
Date: Mon, 15 Jun 2026 09:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: use kmem_cache for IPC rx_msg allocations
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com
References: <20260611055214.948748-1-karol.wachowski@linux.intel.com>
 <0eab4c8a-65e6-4644-a6ef-e46a0d262980@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <0eab4c8a-65e6-4644-a6ef-e46a0d262980@linux.intel.com>
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

On 12-Jun-26 9:12, Andrzej Kacprowski wrote:
> On 11-Jun-26 7:52 AM, Karol Wachowski wrote:
>> Use a dedicated kmem_cache for ivpu_ipc_rx_msg allocations instead of
>> the generic kmalloc. This gives each CPU its own hot freelist for this
>> object type, reducing allocator overhead in the IRQ handler and threaded
>> IRQ path where rx_msg objects are allocated and freed at high frequency.
>>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_ipc.c | 17 ++++++++++++++---
>>   drivers/accel/ivpu/ivpu_ipc.h |  1 +
>>   2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ 
>> ivpu_ipc.c
>> index 64864e9d8a0a..c5f11be86c8c 100644
>> --- a/drivers/accel/ivpu/ivpu_ipc.c
>> +++ b/drivers/accel/ivpu/ivpu_ipc.c
>> @@ -146,7 +146,7 @@ ivpu_ipc_rx_msg_add(struct ivpu_device *vdev, 
>> struct ivpu_ipc_consumer *cons,
>>       lockdep_assert_held(&ipc->cons_lock);
>> -    rx_msg = kzalloc_obj(*rx_msg, GFP_ATOMIC);
>> +    rx_msg = kmem_cache_zalloc(ipc->rx_msg_cache, GFP_ATOMIC);
>>       if (!rx_msg) {
>>           ivpu_ipc_rx_mark_free(vdev, ipc_hdr, jsm_msg);
>>           return;
>> @@ -174,7 +174,7 @@ ivpu_ipc_rx_msg_del(struct ivpu_device *vdev, 
>> struct ivpu_ipc_rx_msg *rx_msg)
>>       list_del(&rx_msg->link);
>>       ivpu_ipc_rx_mark_free(vdev, rx_msg->ipc_hdr, rx_msg->jsm_msg);
>>       atomic_dec(&vdev->ipc->rx_msg_count);
>> -    kfree(rx_msg);
>> +    kmem_cache_free(vdev->ipc->rx_msg_cache, rx_msg);
>>   }
>>   void ivpu_ipc_consumer_add(struct ivpu_device *vdev, struct 
>> ivpu_ipc_consumer *cons,
>> @@ -490,10 +490,18 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
>>       struct ivpu_ipc_info *ipc = vdev->ipc;
>>       int ret;
>> +    ipc->rx_msg_cache = kmem_cache_create("ivpu_ipc_rx_msg", 
>> sizeof(struct ivpu_ipc_rx_msg), 0,
>> +                          SLAB_HWCACHE_ALIGN, NULL);
>> +    if (!ipc->rx_msg_cache) {
>> +        ivpu_err(vdev, "Failed to create rx_msg_cache\n");
>> +        return -ENOMEM;
>> +    }
>> +
>>       ipc->mem_tx = ivpu_bo_create_global(vdev, SZ_16K, DRM_IVPU_BO_WC 
>> | DRM_IVPU_BO_MAPPABLE);
>>       if (!ipc->mem_tx) {
>>           ivpu_err(vdev, "Failed to allocate mem_tx\n");
>> -        return -ENOMEM;
>> +        ret = -ENOMEM;
>> +        goto err_destroy_cache;
>>       }
>>       ipc->mem_rx = ivpu_bo_create_global(vdev, SZ_16K, DRM_IVPU_BO_WC 
>> | DRM_IVPU_BO_MAPPABLE);
>> @@ -532,6 +540,8 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
>>       ivpu_bo_free(ipc->mem_rx);
>>   err_free_tx:
>>       ivpu_bo_free(ipc->mem_tx);
>> +err_destroy_cache:
>> +    kmem_cache_destroy(ipc->rx_msg_cache);
>>       return ret;
>>   }
>> @@ -544,6 +554,7 @@ void ivpu_ipc_fini(struct ivpu_device *vdev)
>>       drm_WARN_ON(&vdev->drm, atomic_read(&ipc->rx_msg_count) > 0);
>>       ivpu_ipc_mem_fini(vdev);
>> +    kmem_cache_destroy(ipc->rx_msg_cache);
>>   }
>>   void ivpu_ipc_enable(struct ivpu_device *vdev)
>> diff --git a/drivers/accel/ivpu/ivpu_ipc.h b/drivers/accel/ivpu/ 
>> ivpu_ipc.h
>> index 1c9cf67f1e5b..fb3e5816ca50 100644
>> --- a/drivers/accel/ivpu/ivpu_ipc.h
>> +++ b/drivers/accel/ivpu/ivpu_ipc.h
>> @@ -70,6 +70,7 @@ struct ivpu_ipc_info {
>>       struct gen_pool *mm_tx;
>>       struct ivpu_bo *mem_tx;
>>       struct ivpu_bo *mem_rx;
>> +    struct kmem_cache *rx_msg_cache;
>>       atomic_t rx_msg_count;
> Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Pushed to drm-misc-next.
