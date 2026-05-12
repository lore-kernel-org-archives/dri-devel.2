Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DD2CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 21:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 949BC10EC3A;
	Tue, 12 May 2026 21:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="l93Yln6A";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B1710EC3A;
 Tue, 12 May 2026 21:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4tn2Ni9jKP+kiRuacUqsEqrUv5YJ2KAREatFI021hpo=; b=l93Yln6A2lVLeYnwHDlIwwyddf
 0WFTRxocCcbG0HHRiGGPzW2EXzUBQ7+peFvc5QD3jptmtNZIuUQ3tHkFRxLXS5FJtJ4hVFChHSpgO
 rJdg3gNs/gqaesIVCueW4buj0eEo54ccI2ZQV9tiwG6domb0nrpHAsUOfZ50riNiKr1yFKqdAdxf0
 CMRYG91vOpqC6XXMSdbJcTuhQcxv0MweorWRmOKTJmW5hL0mPn+a0sVekXTTNoXH1NiN/E92qSrX7
 DIw7rQ5OQSj027Wh1QWV+6BaGDSJUGbrce7CgjcjE8stRnLWM+7vspMPkCECAxqFc84i84blNPmoQ
 bJCNs60g==;
Received: from 179-242-241-236.3g.claro.net.br ([179.242.241.236]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMv1c-009frh-Af; Tue, 12 May 2026 23:52:24 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH i-g-t 2/8] Adjust xe_cgroups test to use igt_dmem_driver
Date: Tue, 12 May 2026 18:51:49 -0300
Message-ID: <20260512215156.4083082-3-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512215156.4083082-1-cascardo@igalia.com>
References: <20260512215156.4083082-1-cascardo@igalia.com>
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

Using the driver should not have any functional changes.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 tests/intel/xe_cgroups.c | 69 ++++++++--------------------------------
 1 file changed, 14 insertions(+), 55 deletions(-)

diff --git a/tests/intel/xe_cgroups.c b/tests/intel/xe_cgroups.c
index 08cf8e3bdc5b..9ff8d46570ab 100644
--- a/tests/intel/xe_cgroups.c
+++ b/tests/intel/xe_cgroups.c
@@ -25,6 +25,7 @@
 #include "igt.h"
 #include "igt_aux.h"
 #include "igt_cgroup.h"
+#include "igt_dmem_driver.h"
 #include "xe_drm.h"
 #include "xe/xe_ioctl.h"
 #include "xe/xe_query.h"
@@ -110,27 +111,14 @@ static uint64_t wait_for_usage_drop(struct igt_cgroup *cg, const char *region,
 	return current;
 }
 
-static int fill_vram(int fd, uint32_t vm, uint64_t vram_region,
-		     uint32_t *handles, int max_bo)
+static int fill_vram(struct igt_dmem_driver *drv, void *ctx, int fd, int max_bo)
 {
-	uint32_t handle;
-	uint64_t addr = BIND_BASE;
 	int n_bo, err = 0;
 
 	for (n_bo = 0; n_bo < max_bo; n_bo++) {
-		err = __xe_bo_create(fd, 0, BO_SIZE, vram_region,
-				     DRM_XE_GEM_CREATE_FLAG_DEFER_BACKING,
-				     NULL, &handle);
+		err = drv->allocate_vram(ctx, n_bo, BO_SIZE);
 		if (err)
 			break;
-
-		handles[n_bo] = handle;
-
-		err = __xe_vm_bind_lr_sync(fd, vm, handle, 0, addr, BO_SIZE, 0);
-		if (err)
-			break;
-
-		addr += BO_SIZE;
 	}
 
 	igt_assert_f(err == -ENOMEM || err == -ENOSPC,
@@ -140,47 +128,20 @@ static int fill_vram(int fd, uint32_t vm, uint64_t vram_region,
 	return n_bo;
 }
 
-static void unfill_vram(int fd, uint32_t vm, uint32_t *handles, int n_bo)
-{
-	uint64_t addr = BIND_BASE;
-	int i;
-
-	for (i = 0; i < n_bo; i++) {
-		if (handles[i]) {
-			xe_vm_unbind_lr_sync(fd, vm, 0, addr, BO_SIZE);
-			gem_close(fd, handles[i]);
-		}
-		addr += BO_SIZE;
-	}
-	free(handles);
-}
-
-static void test_write_eviction(int fd, unsigned int flags)
+static void test_write_eviction(int fd, unsigned int flags, struct igt_dmem_driver *drv)
 {
+	void *ctx;
 	struct igt_cgroup *cg;
 	char *cg_region;
-	uint32_t vm;
-	uint64_t vram_region = 0;
-	uint64_t region;
-	uint32_t *handles = NULL;
 	int n_bo = 0, max_bo;
 	uint64_t current, capacity, cg_max, limit, after;
-	int set_err;
+	int set_err, err;
 
 	/* Check dmem cgroup controller is available before doing anything else */
 	igt_require_f(igt_cgroup_dmem_available(),
 		      "dmem cgroup controller not available (no cgroup v2 or no registered regions)\n");
 
-	/* Find first VRAM region */
-	xe_for_each_mem_region(fd, all_memory_regions(fd), region) {
-		if (xe_region_class(fd, region) == DRM_XE_MEM_REGION_CLASS_VRAM) {
-			vram_region = region;
-			break;
-		}
-	}
-	igt_require_f(vram_region, "No VRAM region found on this device\n");
-
-	cg_region = xe_cgroup_region_name(fd, vram_region);
+	cg_region = drv->get_region_name(fd);
 	igt_require_f(cg_region, "Region not tracked by dmem cgroup controller\n");
 
 	igt_cgroup_dmem_get_capacity(cg_region, &capacity);
@@ -204,13 +165,12 @@ static void test_write_eviction(int fd, unsigned int flags)
 	igt_cgroup_move_current(cg);
 	igt_cgroup_dmem_set_max(cg, cg_region, cg_max);
 
-	vm = xe_vm_create(fd, DRM_XE_VM_CREATE_FLAG_LR_MODE, 0);
-
 	max_bo = (cg_max / BO_SIZE) + 8; /* headroom for overcommit */
-	handles = calloc(max_bo, sizeof(*handles));
-	igt_assert(handles);
 
-	n_bo = fill_vram(fd, vm, vram_region, handles, max_bo);
+	err = drv->init(&ctx, fd, max_bo);
+	igt_assert_f(!err, "Failed to initialize driver");
+
+	n_bo = fill_vram(drv, ctx, fd, max_bo);
 
 	igt_cgroup_dmem_get_current(cg, cg_region, &current);
 	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
@@ -261,9 +221,8 @@ static void test_write_eviction(int fd, unsigned int flags)
 
 	/* Cleanup */
 	igt_cgroup_dmem_set_max(cg, cg_region, IGT_CGROUP_DMEM_MAX);
-	unfill_vram(fd, vm, handles, n_bo);
-	handles = NULL;
-	xe_vm_destroy(fd, vm);
+	drv->free_vram(ctx, n_bo, BO_SIZE);
+	drv->deinit(ctx);
 	free(cg_region);
 	igt_cgroup_free(cg);
 }
@@ -288,7 +247,7 @@ int igt_main()
 
 	for (int i = 0; subtests[i].name; i++)
 		igt_subtest(subtests[i].name)
-			test_write_eviction(fd, subtests[i].flags);
+			test_write_eviction(fd, subtests[i].flags, &xe_dmem_driver);
 
 	igt_fixture() {
 		drm_close_driver(fd);
-- 
2.47.3

