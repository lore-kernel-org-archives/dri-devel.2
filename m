Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A5606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QdcOA+UD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92EF610E226;
	Mon, 26 Oct 2026 01:35:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D62910E0D3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 01:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792978538; x=1824514538;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6XeH1nDmIKEwWHahs4esRbq75DGdv4dggga0X48z5aw=;
 b=QdcOA+UDWabheqc4rpCXHcqxaEDsBkTuiHdzUfvw/ygqi2thXyme/MGO
 hGCsJtrdsKvGW1zlYCKFVwT1XREdzH+SCEiFwutguz+idXsUQEuwuH7XL
 jFBK5shWS53sSR/SVr51zdl2E0ZMBbKU5M/HjkpGSB7jsfcKX2ZBKcz9x
 rSlp3yw5WHOxzNigKsguj71DtXV7MuFS5O7aaqE9MdivD3z57NPwYD1y+
 4Kiq+wDdzIlHBNp9KiwmjFDIRSi4eUdWuyS6GltBq6uNovhGc20yz8rrH
 HmjV5USTZGt2/bcx6JXfdM7hpxENHyUHRNnFaEakViOo3rd8OlUxGO9KL g==;
X-CSE-ConnectionGUID: wciJIMfOQlibZDxmPAFcNA==
X-CSE-MsgGUID: 17OuevmsRfKV9Y1hDSatXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1516730"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1516730"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 18:35:36 -0700
X-CSE-ConnectionGUID: vn57Yzv8QpO+fs+7TSm88Q==
X-CSE-MsgGUID: UBJTCDoEQU252vSwaq5npw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4147146"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 25 Oct 2026 18:35:31 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xL9cW-00000000VL4-0M45;
 Mon, 26 Oct 2026 01:35:28 +0000
Date: Mon, 26 Oct 2026 09:34:44 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Philipp Stanner <phasta@kernel.org>
Subject: Re: [PATCH 2/2] dma-buf/dma-fence: Order setting of the signaled-bit
 properly
Message-ID: <202610260958.IcV50YNq-lkp@intel.com>
References: <20261021095512.1345191-4-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021095512.1345191-4-phasta@kernel.org>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philipp,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1ecab8b0bad393750c60cc3819ce9c256595463c]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/asm-generic-bitops-Add-set_bit_release/20261021-115512
base:   1ecab8b0bad393750c60cc3819ce9c256595463c
patch link:    https://lore.kernel.org/r/20261021095512.1345191-4-phasta%40kernel.org
patch subject: [PATCH 2/2] dma-buf/dma-fence: Order setting of the signaled-bit properly
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20261026/202610260958.IcV50YNq-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261026/202610260958.IcV50YNq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610260958.IcV50YNq-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma-buf/dma-fence.c: In function 'dma_fence_signal_timestamp_locked':
>> drivers/dma-buf/dma-fence.c:393:9: error: implicit declaration of function 'set_bit_release'; did you mean 'seq_release'? [-Wimplicit-function-declaration]
     393 |         set_bit_release(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
         |         ^~~~~~~~~~~~~~~
         |         seq_release


vim +393 drivers/dma-buf/dma-fence.c

   337	
   338	/**
   339	 * dma_fence_signal_timestamp_locked - signal completion of a fence
   340	 * @fence: the fence to signal
   341	 * @timestamp: fence signal timestamp in kernel's CLOCK_MONOTONIC time domain
   342	 *
   343	 * Signal completion for software callbacks on a fence, this will unblock
   344	 * dma_fence_wait() calls and run all the callbacks added with
   345	 * dma_fence_add_callback(). Can be called multiple times, but since a fence
   346	 * can only go from the unsignaled to the signaled state and not back, it will
   347	 * only be effective the first time. Set the timestamp provided as the fence
   348	 * signal timestamp.
   349	 *
   350	 * Unlike dma_fence_signal_timestamp(), this function must be called with
   351	 * &dma_fence.lock held.
   352	 */
   353	void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
   354					      ktime_t timestamp)
   355	{
   356		const struct dma_fence_ops *ops;
   357		struct dma_fence_cb *cur, *tmp;
   358		struct list_head cb_list;
   359	
   360		dma_fence_assert_held(fence);
   361	
   362		if (unlikely(dma_fence_test_signaled_flag(fence)))
   363			return;
   364	
   365		trace_dma_fence_signaled(fence);
   366	
   367		/*
   368		 * When neither a release nor a wait operation is specified set the ops
   369		 * pointer to NULL to allow the fence structure to become independent
   370		 * from who originally issued it.
   371		 */
   372		ops = rcu_dereference_protected(fence->ops, true);
   373		if (!ops->release && !ops->wait)
   374			RCU_INIT_POINTER(fence->ops, NULL);
   375	
   376		/* Stash the cb_list before replacing it with the timestamp */
   377		list_replace(&fence->cb_list, &cb_list);
   378	
   379		fence->timestamp = timestamp;
   380		set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
   381	
   382		list_for_each_entry_safe(cur, tmp, &cb_list, node) {
   383			INIT_LIST_HEAD(&cur->node);
   384			cur->func(fence, cur);
   385		}
   386	
   387		/*
   388		 * This orders the signaled-state with the test_bit_acquire() in
   389		 * dma_fence_test_signaled_flag(). This ensures that functions like
   390		 * dma_fence_is_signaled() can only ever return true once signaling is
   391		 * completed (i.e., after the callbacks above ran).
   392		 */
 > 393		set_bit_release(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
   394	}
   395	EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
   396	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
