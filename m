Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0830BC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640A510E3D1;
	Mon, 21 Sep 2026 14:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gVsjKXmw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32AC210E76B
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790002267; x=1821538267;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dZEwI7g4dYES7aErZZpGKM/HppoAmrsp+BlvEEDOJ7k=;
 b=gVsjKXmwhmd22ExP7vWolc71lBSe4Ixu/FD6zkeibScp+Pfjsyu2PULH
 Pg6yuVw7FTiWPLFxX+suiQWDoC/PipnZ/JHP0EW8qOQJhtBkFiXG6smEn
 1RDZmxCBTAZm/j9G3ZVZZ19W+Uo3pFSFomhnIj5lXdXWsjwnyQ2P0y5PI
 IKmdSKSMzsp0G45erpPCLum6y5lXacyXntCMnxW8Qxxt3l5OmVlsvXSFu
 OieYJSpZDPtmNHcrob/y4O8LnpECBKG+sRZ8L8PBwLkWqGlZjYeQXrZD2
 sbR1Ow3i8mhXs22opXjkGMn7MsYNMF1Q1yy9/ljnncHvWzzQ8JT9Up5+L w==;
X-CSE-ConnectionGUID: zOM6ho/gS8mLAWQykTYmpQ==
X-CSE-MsgGUID: 4HJUZCfZRPeuU513zPNFbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1022995"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="1022995"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 07:50:18 -0700
X-CSE-ConnectionGUID: FXg7ZlbpSJehyE9nPrXfHQ==
X-CSE-MsgGUID: 7AC8FencRbitjVrOOKL8OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3727613"
Received: from slopesdx-mobl.gar.corp.intel.com (HELO [10.246.16.95])
 ([10.246.16.95])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 07:50:17 -0700
Message-ID: <e4754250-8d0f-45db-982a-cc0b64c0aa47@linux.intel.com>
Date: Mon, 21 Sep 2026 16:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Use separate flag for job timeout
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260914084301.894028-1-karol.wachowski@linux.intel.com>
 <20260914085805.09BF61F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260914085805.09BF61F000FF@smtp.kernel.org>
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

On 14-Sep-26 10:58, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Lockless `xa_load` without RCU read lock and RCU-deferred freeing leads to a potential Use-After-Free of `file_priv`.
> --
> 
> commit 267f0542c58f023dad2c373ec173ea2fa96d1b24
> Author: Jakub Pawlak <jakub.pawlak@intel.com>
> 
> accel/ivpu: Use separate flag for job timeout
>      
> Use separate flag to mark a job timeout as a reason
> of starting context_abort_work. This allows to distinguish
> engine reset reason and clearly adjust reset procedure flow.
> 
>> diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
>> index 41efd8985fa67..b2025274f91de 100644
>> --- a/drivers/accel/ivpu/ivpu_mmu.c
>> +++ b/drivers/accel/ivpu/ivpu_mmu.c
> [ ... ]
>> @@ -964,7 +964,6 @@ void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev)
>>   		file_priv = xa_load(&vdev->context_xa, ssid);
>>   		if (file_priv) {
>>   			if (!READ_ONCE(file_priv->has_mmu_faults)) {
>> -				atomic_set(&vdev->faults_detected, 1);
>>   				ivpu_mmu_dump_event(vdev, event);
>>   				WRITE_ONCE(file_priv->has_mmu_faults, true);
>>   			}
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for file_priv to be freed
> concurrently while it is being accessed here?
> 
> xa_load() internally acquires and releases rcu_read_lock(), so the returned
> file_priv pointer is unprotected once xa_load() returns.
> 
> If a userspace application triggers an MMU fault and immediately closes the
> file descriptor, could ivpu_postclose() drop the last reference and invoke
> file_priv_release() before the hardware event queue is processed?
> 
> If file_priv_release() erases the entry from the xarray via xa_erase_irq()
> and frees it synchronously via kfree(), does this lead to a use-after-free
> when ivpu_mmu_irq_evtq_handler() subsequently accesses
> file_priv->has_mmu_faults?
> 

Thanks for the review.

Right, the race is real: xa_load() returns file_priv without
any protection, and the entry can be erased and the object freed before
has_mmu_faults is updated.

However, this is pre-existing and orthogonal to this patch: v2 only
removes atomic_set(&vdev->faults_detected, 1) from that block, so it
neither introduces nor worsens the race.

I will address it in a separate patch, with a proper Fixes: tag and
Cc: stable@vger.kernel.

At the same time I would like to proceed with this patch.

Thanks,
Karol

