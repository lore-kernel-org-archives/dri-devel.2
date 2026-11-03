Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34245606A333
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EQoVBF3o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F9510F5DA;
	Tue,  3 Nov 2026 14:10:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3941110E80F;
 Tue,  3 Nov 2026 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793715018; x=1825251018;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HsUsQZQEIomTg/niZeDZNePLhqDX9fE6bfwU+cWRxpg=;
 b=EQoVBF3oALHjGGeY1mxgPsDtHAFQFoik4rzdboU2KycVijvL2aR/d1AC
 9p8/vZui2jMfiycnDfxeraoTuSJXVpdLp8bMPoQh3bETDrQdua0+D2X70
 Yrvu5ToO2Jj81+eLkDnLdUVKZT8X+q2o/4HHFYqUvW5MVjsEvEE26LJED
 KJTo5/xNfGn8J4rKiroEScPzvNiXaqVUhNnmHOAHRnmfrQrwNQGXow3iY
 kINY8mmaHKlaJSwC/G7iTXkacru6cer6tT2Bh9FiQFZlkL2e284xlW4NB
 ZC1b/NP3rD5d1jaZ5VQWhIw5KsuMDAEYtKWwjFWrGO9CBX0FtPtJDOWpA A==;
X-CSE-ConnectionGUID: NmC4OsJwSXu9A0/5ZiKLZg==
X-CSE-MsgGUID: FgvlURsYSQ2q0UCNiDhE8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2331654"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2331654"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:10:01 -0800
X-CSE-ConnectionGUID: xIul7NrsQtSH+wx7TOTBiQ==
X-CSE-MsgGUID: I7G8Fbr0QQOm7qPFKjLjEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6315938"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.245.160])
 ([10.245.245.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:09:59 -0800
Message-ID: <428f8c9f-5cf8-46f9-8611-52e6aa71a24b@intel.com>
Date: Tue, 3 Nov 2026 14:09:57 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20261021121813.1820345-1-arunpravin.paneerselvam@amd.com>
 <78a6d58b-4fa2-4325-a4c3-3cd732c15288@intel.com>
 <b32ccb67-0e02-467a-8c29-2ac4c815390d@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <b32ccb67-0e02-467a-8c29-2ac4c815390d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 03/11/2026 13:23, Arunpravin Paneer Selvam wrote:
> Hi Matthew,
> 
> On 10/21/2026 6:19 PM, Matthew Auld wrote:
>> On 21/10/2026 13:18, Arunpravin Paneer Selvam wrote:
>>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>>
>>> Range-restricted allocations (the visible-VRAM aperture) skip
>>> dirty_steer_window() and reach __alloc_range_bias() with no clear/dirty
>>> eligibility guard, so a dirty allocation freely splits clear extents 
>>> (and
>>> vice versa), interleaving the two classes until no large same-class run
>>> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
>>> search instead: block_incompatible() rejects opposite-class blocks in 
>>> the
>>> strict pass and relaxes only when the strict pass returns -ENOSPC, so a
>>> request still succeeds when only opposite-class space remains. A KUnit
>>> regression test covers the interleaving pattern and fails without the
>>> guard.
>>>
>>> v2: the strict pass can split a block and then reject both children, so
>>>      a split no longer implies a compatible block exists. Sashiko 
>>> reported
>>>      the resulting leaked splits; fix as suggested by Matthew:
>>>   - Push the parent back on the DFS stack after each split and merge it
>>>     back with unsplit_block() if both children are still free.
>>>   - Make block_incompatible() judge free blocks only (split nodes keep a
>>>     stale clear bit) and take the requested order, so mixed blocks that
>>>     can hold a compatible block are descended instead of skipped.
>>>   - Extend the KUnit test with a coalesced mixed block and a check that
>>>     a rejected split is merged back.
>>>
>>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>>> decoupled dirty tracker")
>>> Assisted-by: LLM
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>
>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> This version brought back a DAL CI failure. when the range allocator 
> wanted a clear (or dirty) block, it would split a mixed block to look 
> for a pure one, throw away the mixed halves, and then use unsplit_block 
> to join them again.
> Doing this on every allocation was costly: even though the merge 
> cascades back up through all levels, repeating this split-and-unsplit on 
> every allocation added enough overhead on the display hot path that a 
> large scanout buffer
> eventually failed with -ENOSPC (igt@kms_plane@plane-panning-bottom-right 
> on Radeon RX 9070 XT).
> 
> This change relaxes the rule for range allocations only: we just take a 
> mixed block as it is (the caller clears it if needed), so the first pass 
> never splits and never has to undo a split. Large same-class blocks stay 
> whole,
> so contiguous space is preserved and fragmentation goes down. The 
> behaviour is still correct, unsplit_block is no longer needed, and a 
> KUnit test reproduces the problem (it fails without the fix and passes 
> with it).
> 
> Could you please just review v3 of this patch?. It is a bit urgent as we 
> need it to land the base dirty-tracker patch on our internal branch.

I think sashiko is now complaining about the same thing from before?

> 
> Thanks,
> Arun.
>>
>> Are you just going to push this one by itself?
> 

