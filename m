Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05795CD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207D910E1A7;
	Fri, 22 May 2026 09:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fhjZcluT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D4B10E1A7
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=35pb7+wreCk9gzZD6cPL4iMbZh40TiocycuDxOWNlgQ=; b=fhjZcluTy2nGkqti5yZk+kjfRo
 NDKMEQKn3t9qaEGoM+zntFd4boMetjxV0GRAV/FspQwquBIQNFr4zj1oOrQZYfpmXvmO8jSunkwm4
 W1pjeTA15AiOjHDR2FIBOCNwur02dbYbUV9X1+hOMmf1TbrL3QsCovdu3v8h36c4mGoPtQP6gyFD+
 sOn1XALeohbXOv7YI7wPrYNFJeoPcLaNi0I7QbjQsMO3ErVzUF3Hm9bqFBabVL3JkTGAHykSegGuM
 jHFkrVtghKzV8HuCvrlmZ4ywNumLLp2Cj55Mnd1J0l4fdZL1V3HZQT4vEJU3eCIwaOp0PFURrxdSV
 /weZBBqQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wQLlN-004mCf-NC; Fri, 22 May 2026 11:01:49 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 kernel test robot <lkp@intel.com>, Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] drm/sched: Fix clang build warning in kunit tests
Date: Fri, 22 May 2026 10:01:29 +0100
Message-ID: <20260522090129.9385-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

Initializing compile time constant struct or arrays from another such
variable is a gcc extension, while clang strictly requires a compile time
constant literal.

As reported by LKP:

>> drivers/gpu/drm/scheduler/tests/tests_scheduler.c:675:10: error: initializer element is not a compile-time constant
                                 drm_sched_scheduler_two_clients_attr),
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:224:13: note: expanded from macro 'KUNIT_CASE_PARAM_ATTR'
                     .attr = attributes, .module_name = KBUILD_MODNAME}
                             ^~~~~~~~~~
   1 error generated.

vim +675 drivers/gpu/drm/scheduler/tests/tests_scheduler.c

   671
   672	static struct kunit_case drm_sched_scheduler_two_clients_tests[] = {
   673		KUNIT_CASE_PARAM_ATTR(drm_sched_scheduler_two_clients_test,
   674				      drm_sched_scheduler_two_clients_gen_params,
 > 675				      drm_sched_scheduler_two_clients_attr),
   676		{}
   677	};
   678

Fix it by using a compound literal as other tests do.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605220312.Pu7UO05u-lkp@intel.com/
Fixes: 97ef806a5314 ("drm/sched: Add some scheduling quality unit tests")
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/tests/tests_scheduler.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
index 8b2e4ef9915f..90d31888cf92 100644
--- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
+++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
@@ -666,14 +666,10 @@ static void drm_sched_scheduler_two_clients_test(struct kunit *test)
 	}
 }
 
-static const struct kunit_attributes drm_sched_scheduler_two_clients_attr = {
-	.speed = KUNIT_SPEED_SLOW,
-};
-
 static struct kunit_case drm_sched_scheduler_two_clients_tests[] = {
 	KUNIT_CASE_PARAM_ATTR(drm_sched_scheduler_two_clients_test,
 			      drm_sched_scheduler_two_clients_gen_params,
-			      drm_sched_scheduler_two_clients_attr),
+			      { .speed = KUNIT_SPEED_SLOW }),
 	{}
 };
 
@@ -858,14 +854,10 @@ static void drm_sched_scheduler_many_clients_test(struct kunit *test)
 		drm_mock_sched_entity_free(client[i].entity);
 }
 
-static const struct kunit_attributes drm_sched_scheduler_many_clients_attr = {
-	.speed = KUNIT_SPEED_SLOW,
-};
-
 static struct kunit_case drm_sched_scheduler_many_clients_tests[] = {
 	KUNIT_CASE_PARAM_ATTR(drm_sched_scheduler_many_clients_test,
 			      drm_sched_scheduler_many_clients_gen_params,
-			      drm_sched_scheduler_many_clients_attr),
+			      { .speed = KUNIT_SPEED_SLOW }),
 	{}
 };
 
-- 
2.54.0

