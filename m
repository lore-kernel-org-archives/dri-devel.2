Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36667C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5391310F172;
	Thu,  6 Aug 2026 10:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OjJMntda";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E1310F15D;
 Thu,  6 Aug 2026 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786011568; x=1817547568;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NLnzG3DU/EL58GfX5igWM7vR1FgGPcuVwRQwBJ97EEI=;
 b=OjJMntdabPa5iCEa6vrWQXYqkylG3TOWVqKa/VO6R2qDrJp2Mi/8PCxH
 km1LoqP4Oevn4w2gVlsLpbz9uQXeKT4v6SdKNCTIBegkQDQP1MPcImUVk
 SWMr4NY+Cbv6zx0YHJbyi4br6KoZ/d/SYMxXAAa3Eg6TR4G1FnkncNwx9
 wmYRPzM05G14jprfMT9dKImKQfbzfZHTZAOjmk6wPZW/8BYp2cTeJeKP+
 cgLdsDuADJo8jk9IYyRZxycImYpkPpXaw5aAhxZ81RIcRfBDsNbSTFt8s
 pstNNJckGu3mZlmqwCOUD1vIv6kUrAfD4Hv7C/SlxrlUcXWPc4AVi5j5b Q==;
X-CSE-ConnectionGUID: 5luD6MXwQQWCw6YpeYZfkA==
X-CSE-MsgGUID: /9I9wI5EStG+X5iY11oixw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86716269"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86716269"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 03:19:28 -0700
X-CSE-ConnectionGUID: BS22+3/ZTtOYJgL2w5IyAw==
X-CSE-MsgGUID: sFUCmVbXSrCwOU99QNbAzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="266293085"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.245.11])
 ([10.245.245.11])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 03:19:27 -0700
Message-ID: <002dcde7-5dc4-4fc4-93d9-984fe5e6344a@intel.com>
Date: Thu, 6 Aug 2026 11:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
To: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "arunpravin.paneerselvam@amd.com" <arunpravin.paneerselvam@amd.com>
References: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
 <20260806053624.3215216-6-tejas.upadhyay@intel.com>
 <5675a0ee-a5ee-480e-9a02-b71225c1d86d@intel.com>
 <DS0PR11MB87188855F06D221DCF900AD381D22@DS0PR11MB8718.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <DS0PR11MB87188855F06D221DCF900AD381D22@DS0PR11MB8718.namprd11.prod.outlook.com>
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

On 06/08/2026 10:46, Upadhyay, Tejas wrote:
> 
> 
>> -----Original Message-----
>> From: Auld, Matthew <matthew.auld@intel.com>
>> Sent: 06 August 2026 14:31
>> To: Upadhyay, Tejas <tejas.upadhyay@intel.com>; intel-
>> xe@lists.freedesktop.org; dri-devel@lists.freedesktop.org
>> Cc: arunpravin.paneerselvam@amd.com
>> Subject: Re: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
>> gpu_buddy_allocated_addr_to_block
>>
>> On 06/08/2026 06:36, Tejas Upadhyay wrote:
>>> Add a new KUnit test gpu_test_buddy_addr_to_block() that validates the
>>> gpu_buddy_allocated_addr_to_block() helper which traces a address back
>>> to its allocated buddy block.
>>>
>>> The test covers:
>>> - Exact address matching returns the correct allocated block
>>> - An unallocated address inside the manager should return NULL
>>> - An address outside the manager should return -ENXIO
>>>
>>> v4(MattA):
>>> - Add test for unaligned address
>>> v3(Sashiko):
>>> - remove unused target_addr variable
>>> v2(Sashiko):
>>> - Drop the mutex and lockdep annotation; standalone KUnit tests do
>>>     not register a driver lock.
>>>
>>> Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
>>
>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> 
> Hi Matt,
> 
> Thanks for review. Since I don’t have merge rights on drm-tip, Would you please help merging this series.

I think Arun normally merges these. Arun, any objections? We need this 
for an upcoming driver feature (patches on the list), so wanted to land 
this API ahead of time. I don't think this will conflict much with the 
big rework you were doing.

> 
> Tejas
>>
>>> ---
>>>    drivers/gpu/tests/gpu_buddy_test.c | 45
>> ++++++++++++++++++++++++++++++
>>>    1 file changed, 45 insertions(+)
>>>
>>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c
>>> b/drivers/gpu/tests/gpu_buddy_test.c
>>> index 7df5c2ae83bb..04e425eb8bdd 100644
>>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>>> @@ -1381,6 +1381,50 @@ static void
>> gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
>>>    	gpu_buddy_fini(&mm);
>>>    }
>>>
>>> +static void gpu_test_buddy_addr_to_block(struct kunit *test) {
>>> +	struct gpu_buddy_block *allocated_block, *found_block;
>>> +	LIST_HEAD(allocated_list);
>>> +	const u64 test_size = SZ_4M + SZ_2M;
>>> +	const u64 alloc_start = SZ_4M;
>>> +	const u64 alloc_size = SZ_4K;
>>> +	const u64 chunk_size = SZ_4K;
>>> +	struct gpu_buddy mm;
>>> +
>>> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, test_size,
>> chunk_size),
>>> +			       "buddy_init failed\n");
>>> +
>>> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm,
>> alloc_start,
>>> +							    alloc_start +
>> alloc_size,
>>> +							    alloc_size,
>> chunk_size,
>>> +							    &allocated_list, 0),
>>> +			       "buddy_alloc failed\n");
>>> +
>>> +	allocated_block = list_first_entry(&allocated_list, struct
>> gpu_buddy_block, link);
>>> +	KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(allocated_block),
>> alloc_start);
>>> +	KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm,
>> allocated_block),
>>> +alloc_size);
>>> +
>>> +	found_block = gpu_buddy_allocated_addr_to_block(&mm,
>> alloc_start);
>>> +	KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
>>> +
>>> +	/* Unaligned address inside the allocated block (should resolve to the
>> same block) */
>>> +	found_block = gpu_buddy_allocated_addr_to_block(&mm, alloc_start
>> + 16);
>>> +	KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
>>> +
>>> +	/* An unallocated address inside the manager should return NULL. */
>>> +	found_block = gpu_buddy_allocated_addr_to_block(&mm,
>>> +							alloc_start -
>> chunk_size);
>>> +	KUNIT_EXPECT_NULL(test, found_block);
>>> +
>>> +	/* An address outside the manager should return -ENXIO. */
>>> +	found_block = gpu_buddy_allocated_addr_to_block(&mm, test_size);
>>> +	KUNIT_EXPECT_EQ(test, PTR_ERR(found_block), -ENXIO);
>>> +
>>> +	/* 3. Standard inline cleanup flow */
>>> +	gpu_buddy_free_list(&mm, &allocated_list, 0);
>>> +	gpu_buddy_fini(&mm);
>>> +}
>>> +
>>>    static int gpu_buddy_suite_init(struct kunit_suite *suite)
>>>    {
>>>    	while (!random_seed)
>>> @@ -1405,6 +1449,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>>    	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>>>    	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
>>>    	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
>>> +	KUNIT_CASE(gpu_test_buddy_addr_to_block),
>>>    	{}
>>>    };
>>>
> 

