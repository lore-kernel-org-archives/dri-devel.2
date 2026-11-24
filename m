Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7593606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M6cOcWr6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC6110E54D;
	Tue, 24 Nov 2026 00:43:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F4110ECE6;
 Tue, 24 Nov 2026 00:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795481025; x=1827017025;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fZkZSF+7X8W7qBapOeAtXmDSgdYDuEsbX0l9Wpp1UYk=;
 b=M6cOcWr6jQN7RgUPLIY87wYsC7ukqTKsrF1SUjvkckFx+DcdzLhQis59
 4kxhNl3JqMmF4w8dT2uzDbyx9HYDm8SjJg744K+fbgZ95lFR6VchK57iI
 yACOkDYTgtKOfma3NzoYsPIgLlcanep9AnVSBsUJoPfnnRdWtI4Lxx3Di
 1jqdk4wXT2eB0jjJ5GAx3FA4SG7PYuYsBkqhGDieW3JV/VEH6Q79F7KCK
 O3xOR17YcIH32Vukrft92LbR8d/yW8WAeHZwwNaBgA1kGxSuFlXj/pYRb
 9Iz8JXe2SXUXxUNmNfcvbzvQ4Dps+d5C9HVXR/XYaa0dwBeRmyY88SHv/ Q==;
X-CSE-ConnectionGUID: RQoQjrnCQMu56b2TiLddhw==
X-CSE-MsgGUID: iF8fXUh2QMKF6Klx+XyppQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4147847"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4147847"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 16:43:45 -0800
X-CSE-ConnectionGUID: wJtC+yTITJCdIaJDkMl/Iw==
X-CSE-MsgGUID: Ia2I8tg8S22uOYukrMH2zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11304487"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 16:43:42 -0800
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Ian Forbes <ian.forbes@broadcom.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
Subject: [PATCH v1 1/1] drm/ttm/tests: do not count pages after pool's teardown
Date: Tue, 24 Nov 2026 01:43:12 +0100
Message-ID: <20261124004312.3880264-2-michal.grzelak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261124004312.3880264-1-michal.grzelak@linux.intel.com>
References: <20261124004312.3880264-1-michal.grzelak@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently ttm_pool_fini_basic() checks if page count of pool-type's lru
list is zero after tearing down its pre-populated pool.

After commit 5ffdc8f83613 ("ttm/pool: Don't leak LRU list on shutdown")
this check causes NULL dereference because page's lru list is destroyed
during pool's teardown which leads to KUnit's crash:

[20:08:24] ========== [PASSED] ttm_pool_alloc_basic_dma_addr ==========
[20:08:24] [PASSED] ttm_pool_alloc_order_caching_match
[20:08:24] [PASSED] ttm_pool_alloc_caching_mismatch
[20:08:24] [PASSED] ttm_pool_alloc_order_mismatch
[20:08:24] [PASSED] ttm_pool_free_dma_alloc
[20:08:24] [PASSED] ttm_pool_free_no_dma_alloc
[20:08:25] [ERROR] Test: ttm_pool: missing expected subtest!
[20:08:25]
[20:08:25] Pid: 80, comm: kunit_try_catch Tainted: G        W        N  7.4.0-rc4-g401a3e7b64d1
[20:08:25] RIP: 0033:list_lru_count_node+0xe/0x20
[20:08:25] RSP: 00000000a08dbef8  EFLAGS: 00010246
[20:08:25] RAX: 0000000000000001 RBX: 00000000a0803c70 RCX: 0000000000000020
[20:08:25] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000060853030
[20:08:25] RBP: 0000000060853000 R08: 00000000a08dbe98 R09: 00000000601246ac
[20:08:25] R10: 000000009f227d00 R11: 0000000000000000 R12: 0000000060124640
[20:08:25] R13: 0000000060853030 R14: 000000006047c950 R15: 00000000604c6488
[20:08:25] Kernel panic - not syncing: Segfault with no mm
[20:08:25] [CRASHED]
[20:08:25] [ERROR] Test: ttm_pool: missing subtest result line!
[20:08:25] # module: ttm_pool_test
[20:08:25] ==================== [CRASHED] ttm_pool ====================
[20:08:25] [ERROR] Test: main: missing expected subtest!
[20:08:25] [CRASHED]
[20:08:25] [ERROR] Test: main: missing expected subtest!
[20:08:25] [CRASHED]
[20:08:25] [ERROR] Test: main: missing expected subtest!
[20:08:25] [CRASHED]
[20:08:25] [ERROR] Test: main: missing expected subtest!
[20:08:25] [CRASHED]
[20:08:25] ============================================================
[20:08:25] Testing complete. Ran 28 tests: passed: 23, crashed: 5, errors: 6

The crash in turn prevents Xe CI from running IGT.

Drop the post-teardown assertion.

Fixes: 5ffdc8f83613 ("ttm/pool: Don't leak LRU list on shutdown")
Cc: Ian Forbes <ian.forbes@broadcom.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Michał Grzelak <michal.grzelak@linux.intel.com>
---
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
index be75c8abf3883..dab03dd6c9dd7 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
@@ -401,8 +401,6 @@ static void ttm_pool_fini_basic(struct kunit *test)
 	KUNIT_ASSERT_FALSE(test, !list_lru_count(&pt->pages));
 
 	ttm_pool_fini(pool);
-
-	KUNIT_ASSERT_TRUE(test, !list_lru_count(&pt->pages));
 }
 
 static struct kunit_case ttm_pool_test_cases[] = {
-- 
2.45.2

