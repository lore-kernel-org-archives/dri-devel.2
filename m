Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7A5CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B36C10F035;
	Thu, 11 Jun 2026 17:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TOc7o0YF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A08B10F004
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781198904; x=1812734904;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OSyOTvYZVIsRSlVImx5LXmF0iwx9aNop6VsItRtuHkk=;
 b=TOc7o0YF3xDGf/UYjmRFCUnq1w7T/dnH+mIeiH7hG9CHiopjIE6dnQe1
 besDDApOPXw0pQdiPIYYNejZBtGCfetyWCuavglivjKSstvSyPOemFD3V
 bOyVWtn4bZxL87peDkhqILoApwtK0NrAI20oqwpoRMafZNMj8HvxD6VbZ
 nCDHoBZJ1Ji5elxcKVu8ezrhHoPNdrhUXBOInt66Din0PrsQwBLCvk4vP
 6Dpcz7SAAWOXa+4nNmtIuR60CcCWPLphBDXi42p4Dxcc1VjHe8gCFWoCS
 j09QgZ2Od6Wb2t/RLl+Lpc9mGvUppPNuFgOX/Xxyn7A2i/BwWbY+ElpPC A==;
X-CSE-ConnectionGUID: HEnm2kQCTgiKlj/TpKQufg==
X-CSE-MsgGUID: gC1Lm7uSTKylJwUZp+n12Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82212918"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="82212918"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 10:28:24 -0700
X-CSE-ConnectionGUID: tjOzBj1ATxa7Us8+Mf8n1A==
X-CSE-MsgGUID: CzHy/GBCR6WQdUNrcMqlxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="270576977"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.169])
 ([10.245.244.169])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 10:28:22 -0700
Message-ID: <e123dfee-632c-430b-8673-4a135cad5046@linux.intel.com>
Date: Thu, 11 Jun 2026 19:28:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
To: sashiko-reviews@lists.linux.dev
Cc: tj@kernel.org, mkoutny@suse.com, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
References: <20260611142242.2529-4-thomas.hellstrom@linux.intel.com>
 <20260611144046.E1EF91F00893@smtp.kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20260611144046.E1EF91F00893@smtp.kernel.org>
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


On 6/11/26 16:40, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Medium] The docstring for `struct dmem_cgroup_ops->reclaim` explicitly contradicts the implementation for `-ENOSPC` return values.

Fixed in v6.


>
> Pre-existing issues:
> - [High] On 32-bit systems, `dmemcg` limits tracked in bytes are truncated to 32-bit `unsigned long`, leading to overflows and artificially severe constraints.

Pre-existing issues are out of scope.

/Thomas


> --
>
> commit ccfc580d266b8b80afec154f819853307351d98a
> Author: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>
> cgroup/dmem: Add reclaim callback for lowering max below current usage
>
> Add an optional reclaim callback to struct dmem_cgroup_region. When
> dmem.max is set below the current usage of a cgroup pool, the new limit
> is applied immediately and then the driver is asked to evict memory.
>
>> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
>> index d9eab8a2c1ee6..d705e94d8784d 100644
>> --- a/include/linux/cgroup_dmem.h
>> +++ b/include/linux/cgroup_dmem.h
>> @@ -14,12 +14,33 @@ struct dmem_cgroup_pool_state;
>>   /* Opaque definition of a cgroup region, used internally */
>>   struct dmem_cgroup_region;
>>   
>> +/**
>> + * struct dmem_cgroup_ops - Operations for a dmem cgroup region.
>> + * @reclaim: Optional callback invoked when dmem.max is set below the current
>> + *           usage of a pool. The driver should attempt to free at least
>> + *           @target_bytes from @pool. May be called multiple times if usage
>> + *           remains above the limit after returning.
>> + *
>> + *           Return: 0 if some progress was made (even if less than
>> + *           @target_bytes was freed), -ENOSPC if no progress could be made,
>> + *           or another negative error code if a fatal error occurred.
>> + *           Any non-zero return stops further reclaim attempts.
> [Severity: Medium]
> Is the documentation accurate regarding the -ENOSPC return code?
>
> The docstring here explicitly states that any non-zero return stops further
> reclaim attempts. However, the implementation in set_resource_max() appears
> to intercept -ENOSPC and will retry up to 16 times:
>
>      if (ret && (ret != -ENOSPC || !retries--))
>          break;
>
> Could this mislead driver authors into assuming -ENOSPC is a terminal
> return code that aborts the loop immediately, when it actually subjects
> the driver to continuous retries?
>
>> + */
>> +struct dmem_cgroup_ops {
>> +	int (*reclaim)(struct dmem_cgroup_pool_state *pool,
>> +		       u64 target_bytes, void *priv);
>> +};
> [ ... ]
>
>> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
>> index 373ad04d289d5..f7166b8255c7b 100644
>> --- a/kernel/cgroup/dmem.c
>> +++ b/kernel/cgroup/dmem.c
> [ ... ]
>
>>   static void
>> -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
>> +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val, bool nonblock)
>>   {
>> -	page_counter_set_max(&pool->cnt, val);
>> +	struct dmem_cgroup_region *region = pool->region;
>> +	unsigned long limit = (unsigned long)val;
> [Severity: High]
> This is a pre-existing issue, but does this truncation to unsigned long cause
> severe limitations on 32-bit systems?
>
> The dmemcg subsystem accounts for memory limits in bytes, but integrates with
> the page_counter infrastructure which tracks limits using unsigned long. The
> 64-bit byte limit is truncated here, wrapping values larger than 4GB on 32-bit
> architectures.
>
> Additionally, when setting the limit to 'max' via dmemcg_parse_limit() or
> reset_all_resource_limits(), it translates to PAGE_COUNTER_MAX (which is
> ~524,287 on 32-bit). Because dmem_cgroup_try_charge() passes the allocation
> size in bytes to page_counter_try_charge(), a limit of 'max' restricts usage
> to ~512KB instead of being unlimited. Will this cause 32-bit workloads to OOM
> on allocations larger than ~512KB?
>
>> +
>> +	/*
>> +	 * Always update the limit, even if usage currently exceeds it.
>> +	 * Concurrent allocations will be throttled against the new limit
>> +	 * while reclaim is in progress.
>> +	 */
>> +	xchg(&pool->cnt.max, limit);
