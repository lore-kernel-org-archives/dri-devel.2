Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A0EC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5317B10E6B2;
	Tue, 28 Jul 2026 07:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BzM6Ul/r";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCC810E53C;
 Tue, 28 Jul 2026 07:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785225501; x=1816761501;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=hxg5PfeUv/th54BccsV3gYAA+RuWUbr32nypxZfBPCo=;
 b=BzM6Ul/rOInQZQytVI2Ms1aWvRRHR0tQxwPXgnu+S7qQHFf3gyx2Pndo
 2bsDBQ2NPyvPowzAULLQyl1Hcgc3gBFH9zTsZLLYKl1OOzS9swPuedzIA
 Iai3/MaOhZYcFjJDpdkzluS2msOXVdZ3a9yiIqTtGge9ZbLahLlpQgJH7
 vvF/y1fkcQ6iO05I8Q5pIJOWJ4fFOnM+hTJxDAdpDriQFyINoAmE/zBWa
 z9WKj2abEAGQev6Nd348rCWw9kI3MYMPS/2kbUxcWWIOJQ1AGBO3FFLnh
 LfQEAxcycPwkldl1iXZQtUBEZpTAZO0WgOXzXXdLmiVeHgqMwejDpadn0 w==;
X-CSE-ConnectionGUID: yWDP5iGXSGGEAcpndyUywA==
X-CSE-MsgGUID: 5lqQrp7ESUCO9ncLqDTtfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="97178784"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="97178784"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 00:58:21 -0700
X-CSE-ConnectionGUID: z6KtyMUmRaW0Fjv+lsLS1g==
X-CSE-MsgGUID: mHMTUYrDSpaFqbBIfjo0Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="263134489"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.76])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 00:58:18 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 matthew.auld@intel.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: Re: [PATCH v6] drm/tests/gpu_buddy: add a new test case for buffer
 clearance during resume
In-Reply-To: <20260721114236.507578-1-Arunpravin.PaneerSelvam@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260721114236.507578-1-Arunpravin.PaneerSelvam@amd.com>
Date: Tue, 28 Jul 2026 10:58:16 +0300
Message-ID: <2f6a441823533feed75e1cba028f3ec5c8c33535@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 21 Jul 2026, Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com> wrote:
> Add a new unit test case for buffer clearance issue during
> resume.
>
> Using a non-power-of-two mm size, allocate alternating blocks of
> 4KiB in an even sequence and free them as cleared. All alternate
> blocks should be marked as dirty and the split blocks should be
> merged back to their original size when the blocks clear reset
> function is called.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> ---
> v6: Standalone repost of patch 3/3 from series 151686; the other two
>     patches are already applied. Rebased onto the gpu_buddy rename
>     (drm_buddy_test.c -> gpu_buddy_test.c, drm_buddy_* -> gpu_buddy_*)
>     and updated the subject accordingly. No functional change; kept
>     Matthew's Reviewed-by as the port is mechanical.
>
>  drivers/gpu/tests/gpu_buddy_test.c | 41 ++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
> index 7df5c2ae83bb..89698563c61b 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
> @@ -1002,6 +1002,47 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
>  				"buddy_alloc hit an error size=%lu\n", ps);
>  	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
>  	gpu_buddy_fini(&mm);
> +
> +	/*
> +	 * Using a non-power-of-two mm size, allocate alternating blocks of 4KiB in an
> +	 * even sequence and free them as cleared. All blocks should be marked as
> +	 * dirty and the split blocks should be merged back to their original
> +	 * size when the blocks clear reset function is called.
> +	 */
> +	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
> +	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
> +
> +	i = 0;
> +	n_pages = mm_size / ps;
> +	do {
> +		if (i % 2 == 0)
> +			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
> +									    ps, ps, &allocated, 0),
> +					"buddy_alloc hit an error size=%lu\n", ps);
> +	} while (++i < n_pages);

Please prefer a for loop over do-while or while. This is so much more
obvious:

	for (i = 0; i < n_pages; i++)

> +
> +	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
> +	gpu_buddy_reset_clear(&mm, false);
> +	KUNIT_EXPECT_EQ(test, mm.clear_avail, 0);
> +
> +	/*
> +	 * Using a non-power-of-two mm size, allocate alternating blocks of 4KiB in an
> +	 * odd sequence and free them as cleared. All blocks should be marked as
> +	 * cleared and the split blocks should be merged back to their original
> +	 * size when the blocks clear reset function is called.
> +	 */
> +	i = 0;
> +	do {
> +		if (i % 2 != 0)
> +			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
> +									    ps, ps, &allocated, 0),
> +					"buddy_alloc hit an error size=%lu\n", ps);
> +	} while (++i < n_pages);
> +
> +	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
> +	gpu_buddy_reset_clear(&mm, true);
> +	KUNIT_EXPECT_EQ(test, mm.clear_avail, mm_size);
> +	gpu_buddy_fini(&mm);
>  }
>  
>  static void gpu_test_buddy_alloc_contiguous(struct kunit *test)

-- 
Jani Nikula, Intel
