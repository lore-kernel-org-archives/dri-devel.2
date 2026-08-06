Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CB0C5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AFA810F226;
	Thu,  6 Aug 2026 15:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FJr1rE6g";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E60310F226;
 Thu,  6 Aug 2026 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786030753; x=1817566753;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cnfCxXKstVL4z938M4NnrjiD4Dy3oimxvNvygjhaRuE=;
 b=FJr1rE6gjiY9jmwFejtizrpIh7ZnrjvRalsgsD+mUblE3601Iditvw0j
 hIqiMv5yy61Fr8f05wbOH90uPuF8MNc9qIOC7bAJC/8iattPy73OjO1xU
 GFjpOU34dBfranLhE+lfvPVNafiLeRW1UFLwMoTkgQoL5v/c5T/xau5aK
 Sk6D99N7QxTaOj+29pJAuScNFGCZA/DurTpRUrrhhs1OQlpZCXa9eR20I
 0v0lyGNDoslL3L43n9uzbUIUKUp/qFPugyTB16+LG167ETmgeL3kRMknr
 Iql5y/fnyzyQ7cZvl04Tm3r4elkXLf/GgBA+PdT2rD5XcNawbtBaWwlyP w==;
X-CSE-ConnectionGUID: BoA/eDeDT2aV8/EVt+X6dA==
X-CSE-MsgGUID: JovYPkgARxyrC9wRUJ4g7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="96979766"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="96979766"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 08:39:13 -0700
X-CSE-ConnectionGUID: tQ/O/MnHT06Dr+KtjROZmw==
X-CSE-MsgGUID: 9gCdPIEbTTSCNUIyYB/HhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="292036469"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.245.11])
 ([10.245.245.11])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 08:39:12 -0700
Message-ID: <2526801e-1fdf-4386-8f48-99afb5f083a6@intel.com>
Date: Thu, 6 Aug 2026 16:39:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] gpu/tests/buddy: add dirty tracker performance
 KUnit test
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
 <20260731070741.2654251-2-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260731070741.2654251-2-Arunpravin.PaneerSelvam@amd.com>
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

On 31/07/2026 08:07, Arunpravin Paneer Selvam wrote:
> Add gpu_test_buddy_dirty_tracker_performance to demonstrate the key
> advantage of the decoupled dirty-tracker design over the old dual-tree
> / force_merge approach.
> 
> The test runs two scenarios on a 4 GiB pool after alternating
> clear/dirty fragmentation at 4 KiB granularity:
> 
>    1. Contiguous 4 GiB alloc: the old design requires __force_merge()
>       to rebuild max_order from scratch; the new design coalesces during
>       free() so the alloc is O(log N).
> 
>         old (force_merge) - 71 ms
>         dirty tracker design - 17 ms
> 
>    2. Repeated 256 KiB alloc throughput: the old design pays
>       __force_merge() on every alloc; the new design does not.
> 
>         old (force_merge) - 95 ms
>         dirty tracker design - 24 ms
> 
> Assisted-by: Claude:claude-opus-4-8
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

