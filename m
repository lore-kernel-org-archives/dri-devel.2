Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4905606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eqnu3wg5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D85910E374;
	Thu, 26 Nov 2026 16:47:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2468E10E374;
 Thu, 26 Nov 2026 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795711619; x=1827247619;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oV+rL4Ye32leUCpvCVNu9+QEOQR+m/8xyEB4JN41pSE=;
 b=eqnu3wg5vooD39qjjdq5pdopPhv/7bYb0d7mMv0yiYbOlv7lRmS9qAl+
 Fs7Lug0ne5/YQa4fOVQ2K6PcLEunTHNjqky42RTE65e5YHXMPTYLaHn4u
 SVOWbaueD9cCIyLY28tXWSIr+JA0jYfTtkPS0blLY/xMXq4cPonvc3f6u
 mMhH4jjgKjYfy0wK72F/AC5gUZuk2mWJniCSkWOwow8TaQ/QVMfew2Uhm
 4NQ4a2IX9X0oGZMFvy6zBwf730TPoYRaMct+7AwUc1ZSiCzMvVG0POOo7
 vG98l5qBFJxDyxaUD8eEfGeOWE3ccescsVE+qw4SfF2sZ6w+t3IGmW8XA Q==;
X-CSE-ConnectionGUID: T2q4rtS1RLaVbRvvb+OxFw==
X-CSE-MsgGUID: HZFOPIGXQHeB0AMDT2MFCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4531730"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4531730"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:46:59 -0800
X-CSE-ConnectionGUID: dgBV7b8ERfuruUDFmmqrpw==
X-CSE-MsgGUID: f+oEYsJgQoSo+DMCuQ//QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12363711"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:46:58 -0800
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
Subject: [PATCH v1 1/1] drm/ttm/tests: s/recrusive/recursive/
Date: Thu, 26 Nov 2026 17:45:16 +0100
Message-ID: <20261126164516.102435-2-michal.grzelak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261126164516.102435-1-michal.grzelak@linux.intel.com>
References: <20261126164516.102435-1-michal.grzelak@linux.intel.com>
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

Remove typo from KUnit test case.

Signed-off-by: Michał Grzelak <michal.grzelak@linux.intel.com>
---
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
index e22a1335f1664..88902e15cb273 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
@@ -1117,7 +1117,7 @@ static void ttm_bo_validate_evict_gutting(struct kunit *test)
 	ttm_mock_manager_fini(priv->ttm_dev, mem_type);
 }
 
-static void ttm_bo_validate_recrusive_evict(struct kunit *test)
+static void ttm_bo_validate_recursive_evict(struct kunit *test)
 {
 	u32 mem_type = TTM_PL_TT, mem_type_evict = TTM_PL_MOCK2;
 	struct ttm_operation_ctx ctx_init = { }, ctx_val  = { };
@@ -1200,7 +1200,7 @@ static struct kunit_case ttm_bo_validate_test_cases[] = {
 	KUNIT_CASE(ttm_bo_validate_deleted_evict),
 	KUNIT_CASE(ttm_bo_validate_busy_domain_evict),
 	KUNIT_CASE(ttm_bo_validate_evict_gutting),
-	KUNIT_CASE(ttm_bo_validate_recrusive_evict),
+	KUNIT_CASE(ttm_bo_validate_recursive_evict),
 	{}
 };
 
-- 
2.45.2

