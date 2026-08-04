Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AF5C56202
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFAB10E8E5;
	Tue,  4 Aug 2026 08:17:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CyEYZ6xs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED73510E8E1;
 Tue,  4 Aug 2026 08:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785831457; x=1817367457;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=T0ubyKb9DmzYtyWupwtG+oii/wFgqI4pmTG2VRCeYx0=;
 b=CyEYZ6xszX7u6VxNXnoqjoTWH4F5U1DDRUr0kta3zTxDgqOMiAs21Vk+
 lxeJVkyEV/SK37WosuIougOhUye3/oubAxfhuYtSrwrw9h456/6eeaNcR
 qv5MbhxqXeCCrQQT5SDlQhVQIQbP01NnSUl94f3CJXTGuwFFU9KH6ty+C
 2k+985RJhmf8ZfFGEDOOnVnYC+23QKCIrKgux1SoxLyHBkTqXtT84OeeH
 hG7NKHZE+3wregaYQYkin39vBiZArAnqJYRNMbr8s6FdAdBhCoV6ZiyjX
 gj/N8fA0GUuj8fwUj+HoUavz3MNhlDYPAVo1ocngphs6vCU09eryPlDCI w==;
X-CSE-ConnectionGUID: vVYDEX7qRhWBzIDLCuw+GQ==
X-CSE-MsgGUID: AdcvqsTVR9q9hzjuoBj79Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103914954"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="103914954"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 01:17:28 -0700
X-CSE-ConnectionGUID: F6qAsKUdS3KR/Rl0a0W0Nw==
X-CSE-MsgGUID: 1SDnrt+XTZaM6eUOhB2dcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="255150919"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.172])
 ([10.245.245.172])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 01:17:26 -0700
Message-ID: <8835e73a-9ff1-4c06-adb5-1655cc5a1eed@intel.com>
Date: Tue, 4 Aug 2026 09:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/tests/gpu_buddy: fix interleaving in buffer
 clearance test
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, jani.nikula@linux.intel.com,
 Sashiko-bot <sashiko-bot@kernel.org>
References: <20260803065656.2960810-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260803065656.2960810-1-Arunpravin.PaneerSelvam@amd.com>
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

On 03/08/2026 07:56, Arunpravin Paneer Selvam wrote:
> The resume clearance test skipped every other allocation, expecting an
> interleaved clear/dirty layout. But the buddy allocator hands out blocks
> contiguously, so this just allocated half the pages in one chunk and never
> exercised gpu_buddy_reset_clear()'s force-merge of opposite-state buddies.
> Allocate all pages into two lists instead and free one cleared, one dirty,
> to build a truly interleaved pattern.
> 
> v2: Use for loops instead of do-while for the allocation loops (Jani Nikula)
> 
> Fixes: e3335ccbf4da ("drm/tests/gpu_buddy: add a new test case for buffer clearance during resume")
> Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260721114236.507578-1-Arunpravin.PaneerSelvam@amd.com?part=1
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Assisted-by: GitHub_Copilot:claude-opus-4.8
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/tests/gpu_buddy_test.c | 57 +++++++++++++++++-------------
>   1 file changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
> index 89698563c61b..e258bf1fa0fb 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
> @@ -1004,42 +1004,51 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
>   	gpu_buddy_fini(&mm);
>   
>   	/*
> -	 * Using a non-power-of-two mm size, allocate alternating blocks of 4KiB in an
> -	 * even sequence and free them as cleared. All blocks should be marked as
> -	 * dirty and the split blocks should be merged back to their original
> -	 * size when the blocks clear reset function is called.
> +	 * Using a non-power-of-two mm size, allocate all 4KiB blocks and split
> +	 * them across two alternating lists, then free one list as cleared and
> +	 * the other as dirty. This interleaves cleared and dirty blocks so that
> +	 * neighbouring buddies cannot be merged, fragmenting the address space.
> +	 * After gpu_buddy_reset_clear(false) every block should be marked dirty
> +	 * and the split blocks should be merged back to their original size, so
> +	 * clear_avail must drop to 0.
>   	 */
>   	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
>   	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
>   
> -	i = 0;
>   	n_pages = mm_size / ps;
> -	do {
> -		if (i % 2 == 0)
> -			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
> -									    ps, ps, &allocated, 0),
> -					"buddy_alloc hit an error size=%lu\n", ps);
> -	} while (++i < n_pages);
> +	for (i = 0; i < n_pages; i++) {
> +		struct list_head *list = (i % 2) ? &clean : &dirty;
>   
> -	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
> +		KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
> +								    ps, ps, list, 0),
> +				"buddy_alloc hit an error size=%lu\n", ps);
> +	}
> +
> +	gpu_buddy_free_list(&mm, &clean, GPU_BUDDY_CLEARED);
> +	gpu_buddy_free_list(&mm, &dirty, 0);
>   	gpu_buddy_reset_clear(&mm, false);
>   	KUNIT_EXPECT_EQ(test, mm.clear_avail, 0);
> +	gpu_buddy_fini(&mm);
>   
>   	/*
> -	 * Using a non-power-of-two mm size, allocate alternating blocks of 4KiB in an
> -	 * odd sequence and free them as cleared. All blocks should be marked as
> -	 * cleared and the split blocks should be merged back to their original
> -	 * size when the blocks clear reset function is called.
> +	 * Repeat the same fragmented setup, but this time call
> +	 * gpu_buddy_reset_clear(true). Every block should be marked cleared and
> +	 * the split blocks should be merged back to their original size, so the
> +	 * whole address space (clear_avail) must equal mm_size.
>   	 */
> -	i = 0;
> -	do {
> -		if (i % 2 != 0)
> -			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
> -									    ps, ps, &allocated, 0),
> -					"buddy_alloc hit an error size=%lu\n", ps);
> -	} while (++i < n_pages);
> +	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
> +	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
>   
> -	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
> +	for (i = 0; i < n_pages; i++) {
> +		struct list_head *list = (i % 2) ? &clean : &dirty;
> +
> +		KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
> +								    ps, ps, list, 0),
> +				"buddy_alloc hit an error size=%lu\n", ps);
> +	}
> +
> +	gpu_buddy_free_list(&mm, &clean, GPU_BUDDY_CLEARED);
> +	gpu_buddy_free_list(&mm, &dirty, 0);
>   	gpu_buddy_reset_clear(&mm, true);
>   	KUNIT_EXPECT_EQ(test, mm.clear_avail, mm_size);
>   	gpu_buddy_fini(&mm);
> 
> base-commit: bc47d5937f21c5fc94504f03e18f1adb56d97634

