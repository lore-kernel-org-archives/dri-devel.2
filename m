Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4543606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E0YSeKnB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5D210E319;
	Wed, 21 Oct 2026 12:49:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D890E10E120;
 Wed, 21 Oct 2026 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792586953; x=1824122953;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nCIM4mK7IB9zs5ZCIjWP8kFBNob7jKhJGF/UooEWFsQ=;
 b=E0YSeKnBQ3R9MCWIh80od0RJyXttrjwWtcRx6jrxvif4SiGJr1joNQUx
 HXewz8tkaKquOBphN/t3ThZG+SWLTj9k38g1hm+ouO6IpEv7wVegNoO3B
 1zudKmS8cNEAGCoGxq7iyDFitnwysuVojccmL34CG1C2ixGYUlHzHSPv7
 P4pUHQiQZJWO6yTM6BouLVI9CUZyYoRJm6ZQJtZZRYOiQwK0eNQCg0MRE
 E2NyQiQVxRCu1+9/834ehJsOrfIJMgcAd8lIfCU7pc5BZ3rMzdHWfRQ61
 STADMQad5I53FmYoCFClxRx0L326YUKjM4fHU3KOlbcxDoBFvl/weTDks w==;
X-CSE-ConnectionGUID: JDYT97ORT+KauShXnKfXEw==
X-CSE-MsgGUID: zPDD3lwrSQKfa6Uxene5mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1346201"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1346201"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 05:49:12 -0700
X-CSE-ConnectionGUID: RsHaUi/nSXGvL+wRMjvO/Q==
X-CSE-MsgGUID: vF4SjO6AS32RBPyusXYxTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3028393"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.245.71])
 ([10.245.245.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 05:49:11 -0700
Message-ID: <78a6d58b-4fa2-4325-a4c3-3cd732c15288@intel.com>
Date: Wed, 21 Oct 2026 13:49:08 +0100
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
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20261021121813.1820345-1-arunpravin.paneerselvam@amd.com>
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/10/2026 13:18, Arunpravin Paneer Selvam wrote:
> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> 
> Range-restricted allocations (the visible-VRAM aperture) skip
> dirty_steer_window() and reach __alloc_range_bias() with no clear/dirty
> eligibility guard, so a dirty allocation freely splits clear extents (and
> vice versa), interleaving the two classes until no large same-class run
> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
> search instead: block_incompatible() rejects opposite-class blocks in the
> strict pass and relaxes only when the strict pass returns -ENOSPC, so a
> request still succeeds when only opposite-class space remains. A KUnit
> regression test covers the interleaving pattern and fails without the
> guard.
> 
> v2: the strict pass can split a block and then reject both children, so
>      a split no longer implies a compatible block exists. Sashiko reported
>      the resulting leaked splits; fix as suggested by Matthew:
>   - Push the parent back on the DFS stack after each split and merge it
>     back with unsplit_block() if both children are still free.
>   - Make block_incompatible() judge free blocks only (split nodes keep a
>     stale clear bit) and take the requested order, so mixed blocks that
>     can hold a compatible block are descended instead of skipped.
>   - Extend the KUnit test with a coalesced mixed block and a check that
>     a rejected split is merged back.
> 
> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
> Assisted-by: LLM
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Are you just going to push this one by itself?
