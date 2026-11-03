Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FA606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZQFMQVtg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D414D10E7D3;
	Tue,  3 Nov 2026 12:02:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEC010E7D3;
 Tue,  3 Nov 2026 12:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793707327; x=1825243327;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Qzzz/1+bdWOIUm3VjRK5xDOCiANztMGNr91Qy3aea2E=;
 b=ZQFMQVtg8pJR1+vBWHNHt6+5EwgKAVZjXugCxkTj4izFvqBICvpu6Gus
 jLIDegGIHcbu2tleCa0r1yZg3rvTmcvlxfrpHa+2JaUf+5IbETtxXYMqx
 1+apNYZvGJzBeI6I1vnWwF2FvfNvhsrZ1C7d90qJhFd/yV4n0lxNuf2Oq
 hFSrvbXVp6cWmYnJmPGReGZMXMuesGGxhaXijO2kz66wX6eAxo4Z3zUFu
 98uA+qvNqbIn1Ji+QxNFEx/MdBLCV3LVE7bu7qu+N/0UYXkF7Nc77A3ue
 7Lg9jYIDd9gdXFrraICDSijbIeSw7S1jY3ZJvpoyy1WqWpma8F8MKarWd A==;
X-CSE-ConnectionGUID: Y59pBCLRQeuIdR/qxnSiLw==
X-CSE-MsgGUID: PjtbV3D6Qg+0XVa1ov8liw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2335877"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2335877"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 04:02:06 -0800
X-CSE-ConnectionGUID: cxQgoln9QDi0HTBelnd1ZQ==
X-CSE-MsgGUID: Dy1Ba7l1TVWEb+RTSfjLWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6737577"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.245.160])
 ([10.245.245.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 04:02:04 -0800
Message-ID: <f61a62a6-01ba-4a82-8af1-435364232f1f@intel.com>
Date: Tue, 3 Nov 2026 12:02:02 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/33] drm/xe: Flush L2 asynchronously in
 xe_bo_trigger_rebind()
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-14-matthew.brost@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260711025619.2540575-14-matthew.brost@intel.com>
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/07/2026 03:55, Matthew Brost wrote:
> On L2-flush-optimized HW with a dma-resv (non-fault) VM, evicting a BO
> only needs to flush the L2 cache before the migration copy runs; the
> mappings themselves are torn down and rebuilt lazily via
> drm_gpuvm_bo_evict() and a subsequent rebind. Today this flush is done
> by waiting for the BO to go idle and then issuing a synchronous TLB
> invalidation per mapping VMA from inside xe_bo_trigger_rebind(). Both
> the idle wait and the synchronous invalidation stall the calling thread
> while holding the BO dma-resv lock, serializing the move behind all
> in-flight GPU work on the BO.
> 
> Replace this with an asynchronous flush. Add xe_vm_flush_vm_bo_tlb_async()
> which, for each VMA mapping the BO on each present tile, queues a TLB
> invalidation job on the tile migrate (kernel) exec queue. The jobs depend
> on the BO's in-flight GPU work, captured once as a singleton over
> DMA_RESV_USAGE_BOOKKEEP, so the flush only fires once the GPU is done with
> the current mapping. Each job's completion fence is installed into the
> BO's dma-resv as a DMA_RESV_USAGE_KERNEL fence, so the migration copy -
> which waits on the resv - waits on the flush without stalling this thread.
> 
> No PTEs are zapped and vma->tile_invalidated is left untouched: the
> mapping stays valid until the lazy rebind, and the only work performed
> here is the L2 flush. On any failure the caller falls back to the
> existing blocking wait-idle plus xe_vm_invalidate_vma() path.
> 
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Assisted-by: GitHub_Copilot:claude-opus-4.8
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

I think this one was split out right? But not merged yet?
