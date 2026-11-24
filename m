Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC76606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HdXT1bDI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 867C510F2EE;
	Tue, 24 Nov 2026 08:30:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED96610F2F3;
 Tue, 24 Nov 2026 08:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795509004; x=1827045004;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=psRJyIV6yFBTlF7Cmlig6t3EIWf6JHTD+vN9ZIMMxKY=;
 b=HdXT1bDIWEnGWGIxb5tkIzbRV+i1lLthn7dIEKIHd5f4WtSSUF5iNAh7
 g/K8qcV95a8XJY8eeAWwnL4bNbT00HzTVUCt2I76vQZpiFjm4nSZ1vix6
 /BOrBGzn88ydt3RE2gCg1+2rv7atCklRe/T0nNufiJA6slYQhtYuuou36
 jdw+xRWeb2WpFUyqC1Nd66k7Ed29nTYZYOPRHdttYKVzbqElE5WCfLHP+
 KNJVS7ReTACO9XmJzkin9NiTuAuMwLbnMRAaQlKJo6TzhXDqILj5mlODH
 saLiIfAlIFiQEt9UeJo62mRIWvb8GW1yXQqsNmkLoIRIrqausvqjRb4Fs A==;
X-CSE-ConnectionGUID: D3wEhA2uSdWDe8lFC6Gixg==
X-CSE-MsgGUID: ffssrq9vSBi/jkJWAEqQsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4231930"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4231930"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 00:16:39 -0800
X-CSE-ConnectionGUID: g2eR8qiPQ7OQoIj0qxmzMw==
X-CSE-MsgGUID: gzN3EjXkQFOCZM3l6e7Trg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11532681"
Received: from dev-417.igk.intel.com (HELO dev-417) ([10.91.214.181])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 00:15:34 -0800
Date: Tue, 24 Nov 2026 09:15:27 +0100
From: =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 Ian Forbes <ian.forbes@broadcom.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>
Subject: Re: [PATCH v1 1/1] drm/ttm/tests: do not count pages after pool's
 teardown
Message-ID: <dme6l2hqdoxoavmormwnskhzogx6ojevu7aofnokbtqx2yl6qf@z3ligafvj6fi>
References: <20261124004312.3880264-1-michal.grzelak@linux.intel.com>
 <20261124004312.3880264-2-michal.grzelak@linux.intel.com>
 <CAPM=9tz_nwv4Cy5N_ihBqp6JS5rghETbJYiub4aVrJh=wy2-iQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM=9tz_nwv4Cy5N_ihBqp6JS5rghETbJYiub4aVrJh=wy2-iQ@mail.gmail.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 11:41:35AM GMT, Dave Airlie wrote:
> On Tue, 24 Nov 2026 at 11:01, Michał Grzelak
> <michal.grzelak@linux.intel.com> wrote:
> >
> > Currently ttm_pool_fini_basic() checks if page count of pool-type's lru
> > list is zero after tearing down its pre-populated pool.
> >
> > After commit 5ffdc8f83613 ("ttm/pool: Don't leak LRU list on shutdown")
> > this check causes NULL dereference because page's lru list is destroyed
> > during pool's teardown which leads to KUnit's crash:
> >
> > [20:08:24] ========== [PASSED] ttm_pool_alloc_basic_dma_addr ==========
> > [20:08:24] [PASSED] ttm_pool_alloc_order_caching_match
> > [20:08:24] [PASSED] ttm_pool_alloc_caching_mismatch
> > [20:08:24] [PASSED] ttm_pool_alloc_order_mismatch
> > [20:08:24] [PASSED] ttm_pool_free_dma_alloc
> > [20:08:24] [PASSED] ttm_pool_free_no_dma_alloc
> > [20:08:25] [ERROR] Test: ttm_pool: missing expected subtest!
> > [20:08:25]
> > [20:08:25] Pid: 80, comm: kunit_try_catch Tainted: G        W        N  7.4.0-rc4-g401a3e7b64d1
> > [20:08:25] RIP: 0033:list_lru_count_node+0xe/0x20
> > [20:08:25] RSP: 00000000a08dbef8  EFLAGS: 00010246
> > [20:08:25] RAX: 0000000000000001 RBX: 00000000a0803c70 RCX: 0000000000000020
> > [20:08:25] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000060853030
> > [20:08:25] RBP: 0000000060853000 R08: 00000000a08dbe98 R09: 00000000601246ac
> > [20:08:25] R10: 000000009f227d00 R11: 0000000000000000 R12: 0000000060124640
> > [20:08:25] R13: 0000000060853030 R14: 000000006047c950 R15: 00000000604c6488
> > [20:08:25] Kernel panic - not syncing: Segfault with no mm
> > [20:08:25] [CRASHED]
> > [20:08:25] [ERROR] Test: ttm_pool: missing subtest result line!
> > [20:08:25] # module: ttm_pool_test
> > [20:08:25] ==================== [CRASHED] ttm_pool ====================
> > [20:08:25] [ERROR] Test: main: missing expected subtest!
> > [20:08:25] [CRASHED]
> > [20:08:25] [ERROR] Test: main: missing expected subtest!
> > [20:08:25] [CRASHED]
> > [20:08:25] [ERROR] Test: main: missing expected subtest!
> > [20:08:25] [CRASHED]
> > [20:08:25] [ERROR] Test: main: missing expected subtest!
> > [20:08:25] [CRASHED]
> > [20:08:25] ============================================================
> > [20:08:25] Testing complete. Ran 28 tests: passed: 23, crashed: 5, errors: 6
> >
> > The crash in turn prevents Xe CI from running IGT.
> >
> > Drop the post-teardown assertion.
> >
> > Fixes: 5ffdc8f83613 ("ttm/pool: Don't leak LRU list on shutdown")
> > Cc: Ian Forbes <ian.forbes@broadcom.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Michał Grzelak <michal.grzelak@linux.intel.com>
> 
> Reviewed-by: Dave Airlie <airlied@redhat.com>
> 
> Let's land this and unblock CI and if we need to revisit do it after.
> 

Thank you Dave for your review. Could you apply this or help to merge
this? I don't have commit bit for drm-misc.

BR,
Michał
