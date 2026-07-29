Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26116C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B8F10E049;
	Wed, 29 Jul 2026 16:07:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TwlP+5CY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA4610E049;
 Wed, 29 Jul 2026 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785341235; x=1816877235;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=gPkFwKwdUieHzBZRvQvt8JKIn+L7BhIOt+tUlINgXr4=;
 b=TwlP+5CYQS7SXk4sy9HYMG03UJnpOFcLFk2WYl6CTCGOFKudKipo6Z1q
 ku0Bv4dsS41NTU4h3HlK+UGuawCmfDB6lcz40itzcY9QrmIoftZ0so7df
 UecQjb8hKg/6cJUMD+mtJg8Sz8sPTsoXyab1tO5AMzYDSpBRHRk90uhOZ
 yi0z1jUbFMUuVawKOLE3WcO6ZewV0hf65oASlAdnjAfD7sx+u08HDQnJ4
 eM86PGkZdbPdXUnOeXaxVcmQUdW0b3GNT23+JralT8TqeUmKyCTZlzycb
 P67VHAJtHoTaNFbW6eMRLdBpenTGfCYSdQEYD9vppn84lJrbcgFKrVNnR w==;
X-CSE-ConnectionGUID: TRPIaoOrT1KmVncnffdu+g==
X-CSE-MsgGUID: /mDEylReRJCZ4pvalAH7pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86072541"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="86072541"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 09:07:14 -0700
X-CSE-ConnectionGUID: aqpePv4ZS0WnjcXpVCZX9w==
X-CSE-MsgGUID: IDIhUr/XRpmzzBMPylP/sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="283390764"
Received: from zzombora-mobl1 (HELO [10.245.245.14]) ([10.245.245.14])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 09:07:13 -0700
Message-ID: <2f136d39-51dc-4aaa-ab9b-4ba4c737ebfd@intel.com>
Date: Wed, 29 Jul 2026 17:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
From: Matthew Auld <matthew.auld@intel.com>
To: Tejas Upadhyay <tejas.upadhyay@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: arunpravin.paneerselvam@amd.com
References: <20260728124438.2679542-4-tejas.upadhyay@intel.com>
 <20260728124438.2679542-6-tejas.upadhyay@intel.com>
 <5c2f8869-3228-4cf9-8ac4-3ada7610aa61@intel.com>
Content-Language: en-GB
In-Reply-To: <5c2f8869-3228-4cf9-8ac4-3ada7610aa61@intel.com>
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

On 29/07/2026 16:38, Matthew Auld wrote:
> On 28/07/2026 13:44, Tejas Upadhyay wrote:
>> Add a new KUnit test gpu_test_buddy_addr_to_block() that validates the
>> gpu_buddy_allocated_addr_to_block() helper which traces a address back
>> to its allocated buddy block.
>>
>> The test covers:
>> - Exact address matching returns the correct allocated block
>> - An unallocated address inside the manager should return NULL
>> - An address outside the manager should return -ENXIO
> 
> Do we allow an unaligned addr? It looks like we do, but I would think 
> best to reject if not at least aligned to chunk size?

Or if that is a legit thing, then maybe also include it in the test 
coverage. And even if rejected, maybe also cover that in the test.

> 
>>
>> v3(Sashiko):
>> - remove unused target_addr variable
>> v2(Sashiko):
>> - Drop the mutex and lockdep annotation; standalone KUnit tests do
>>    not register a driver lock.
>>
>> Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
>> ---
>>   drivers/gpu/tests/gpu_buddy_test.c | 41 ++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/ 
>> gpu_buddy_test.c
>> index 89698563c61b..21c90e96ac13 100644
>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>> @@ -1422,6 +1422,46 @@ static void 
>> gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
>>       gpu_buddy_fini(&mm);
>>   }
>> +static void gpu_test_buddy_addr_to_block(struct kunit *test)
>> +{
>> +    struct gpu_buddy_block *allocated_block, *found_block;
>> +    LIST_HEAD(allocated_list);
>> +    const u64 test_size = SZ_4M + SZ_2M;
>> +    const u64 alloc_start = SZ_4M;
>> +    const u64 alloc_size = SZ_4K;
>> +    const u64 chunk_size = SZ_4K;
>> +    struct gpu_buddy mm;
>> +
>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, test_size, 
>> chunk_size),
>> +                   "buddy_init failed\n");
>> +
>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 
>> alloc_start,
>> +                                alloc_start + alloc_size,
>> +                                alloc_size, chunk_size,
>> +                                &allocated_list, 0),
>> +                   "buddy_alloc failed\n");
>> +
>> +    allocated_block = list_first_entry(&allocated_list, struct 
>> gpu_buddy_block, link);
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(allocated_block), 
>> alloc_start);
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm, allocated_block), 
>> alloc_size);
>> +
>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm, alloc_start);
>> +    KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);
>> +
>> +    /* An unallocated address inside the manager should return NULL. */
>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm,
>> +                            alloc_start - chunk_size);
>> +    KUNIT_EXPECT_NULL(test, found_block);
>> +
>> +    /* An address outside the manager should return -ENXIO. */
>> +    found_block = gpu_buddy_allocated_addr_to_block(&mm, test_size);
>> +    KUNIT_EXPECT_EQ(test, PTR_ERR(found_block), -ENXIO);
>> +
>> +    /* 3. Standard inline cleanup flow */
>> +    gpu_buddy_free_list(&mm, &allocated_list, 0);
>> +    gpu_buddy_fini(&mm);
>> +}
>> +
>>   static int gpu_buddy_suite_init(struct kunit_suite *suite)
>>   {
>>       while (!random_seed)
>> @@ -1446,6 +1486,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>       KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>>       KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
>>       KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
>> +    KUNIT_CASE(gpu_test_buddy_addr_to_block),
>>       {}
>>   };
> 

