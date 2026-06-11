Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72131CD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0AD710ED71;
	Thu, 11 Jun 2026 07:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ao52wPXR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE4210ED71
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781164693; x=1812700693;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TFvoUxxZrergDNxRSBivXTrpWKdYR7ci7bGVdqx0nKs=;
 b=ao52wPXRtPuf4R/HQ5JHR/KIcBXHicgfp+bjshF1Gyqnpw0Vh7ncdyXK
 IodRzq3lS8j65eyB+b53GtmyaQqgwNQ+u+TeNxG8F0tf+u/vtpFK96GGS
 1zz0+oM3Gxwoiwi2yeti79Zk5S2EhWthhH5mIQrFPIAOuc9kAvc6yMs1d
 7h2GUIN/1on2ZDADTheftkPwzqCxXsYREd3eOjxkkYTDuUe7xkvBGpskT
 acKLZGEEyexy9wmMBQ82Bh8NPZZFa2WUIuASR2N04MybsZkZno/0OJG5X
 c303TybsurIjvAjwe5n7OgnrgPB3efFZFVlCYfyzgzsJ/OuGVoxUBOHqs g==;
X-CSE-ConnectionGUID: AAIg480yQZyCdV2Jv0cuZg==
X-CSE-MsgGUID: 36y56R1HQ12uAaUzWmh19g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82016487"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="82016487"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 00:58:13 -0700
X-CSE-ConnectionGUID: Q3zC1mlzQeqi5UxJ6S5MCA==
X-CSE-MsgGUID: vPbwuaiNSL2HAIx5/E3enA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="270081244"
Received: from jkollber-mobl1.ger.corp.intel.com (HELO [10.246.16.106])
 ([10.246.16.106])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 00:58:12 -0700
Message-ID: <7d335fd9-8911-48fb-9765-95aa637b5c67@linux.intel.com>
Date: Thu, 11 Jun 2026 09:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: use kmem_cache for IPC rx_msg allocations
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260611055214.948748-1-karol.wachowski@linux.intel.com>
 <20260611060448.197F71F00893@smtp.kernel.org>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260611060448.197F71F00893@smtp.kernel.org>
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

On 11-Jun-26 8:04, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Duplicate kmem_cache name on multi-device systems
> --
> 
> commit 41c16409be6704d2ef5ab21270390fee65dcf7aa
> Author: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> accel/ivpu: use kmem_cache for IPC rx_msg allocations
> 
> This commit introduces a dedicated kmem_cache for allocating IPC rx_msg
> objects to reduce allocator overhead in IRQ handlers.
> 
>> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
>> --- a/drivers/accel/ivpu/ivpu_ipc.c
>> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> 
> [ ... ]
> 
>> @@ -490,10 +490,18 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
>>   	struct ivpu_ipc_info *ipc = vdev->ipc;
>>   	int ret;
>>   
>> +	ipc->rx_msg_cache = kmem_cache_create("ivpu_ipc_rx_msg", sizeof(struct ivpu_ipc_rx_msg), 0,
>> +					      SLAB_HWCACHE_ALIGN, NULL);
> 
> [Severity: Medium]
> Will this cause a name collision if there are multiple ivpu devices in the
> same system?

In practice, no:
    1. There is a single NPU instance per system, so ivpu_ipc_init() 
runs once and the cache is created once

    2. Even with multiple instances it's safe, because the cache is 
mergeable (only SLAB_HWCACHE_ALIGN flag). On the merge path the name is 
registered only as a sysfs alias via sysfs_slab_alias(). So the 
CONFIG_DEBUG_VM duplicate-name check (which scans slab_caches by name) 
shouldn't fire.

   The WARN and sysfs collision require slab_nomerge and more than one 
device which doesn't occur for this driver.

> 
> Since this is initialized per-device in ivpu_ipc_init(), calling
> kmem_cache_create() multiple times with the same hardcoded string
> "ivpu_ipc_rx_msg" can trigger a kernel WARN in kmem_cache_sanity_check()
> when CONFIG_DEBUG_VM is enabled.
> 
> Furthermore, if SLUB merging is disabled via boot parameters or config,
> the duplicate name causes a sysfs kobject collision, leading to a sysfs
> warning and a failure to register the cache in sysfs.
> 
> Should this cache name be made unique per device using dev_name(), or
> should the cache be a global singleton?
> 
>> +	if (!ipc->rx_msg_cache) {
>> +		ivpu_err(vdev, "Failed to create rx_msg_cache\n");
>> +		return -ENOMEM;
>> +	}
>> +
>>   	ipc->mem_tx = ivpu_bo_create_global(vdev, SZ_16K, DRM_IVPU_BO_WC | DRM_IVPU_BO_MAPPABLE);
>>   	if (!ipc->mem_tx) {
>>   		ivpu_err(vdev, "Failed to allocate mem_tx\n");
>> -		return -ENOMEM;
>> +		ret = -ENOMEM;
>> +		goto err_destroy_cache;
>>   	}
> 

