Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5C7CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 21:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E1110EC30;
	Tue, 12 May 2026 21:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pi1M75fy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A20F10EC30;
 Tue, 12 May 2026 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ADRJdd6DbFjFBNsAOqsXMBnIGMV6n0RQ4NYaDHYxWvU=; b=pi1M75fy1SwJNusXRj+XM2itCt
 lYdFM9IV1gc37m9J7YenWyRW9HHMdbYPXbKZSfizOwlq0g7l6AjwsxUT/CWPCx4lPD3fOhYLjVaWE
 BLA4sYmNaodIdDaglDKBV0IANAvdh11Av7ssFcoNZVoXZxiBqzP2NbPuFe+Uzkg6KMryhwGAC6E5j
 Fr7GrLhZLN26aZEkJDEo75LvEKT7H+7a3pjBJ7nN5NA1WYXQhMbQg5UY7exAeWJ+9yCLbR5gJr80Y
 qmsupKVaDretG9OgOC1nntLnbFbB5wnpKdYDFqozs7GOt7V/suc0Z+VWYTNihohT6vIxXDMZ0vyoy
 Hsuocxgw==;
Received: from 179-242-241-236.3g.claro.net.br ([179.242.241.236]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMv27-009frh-Qw; Tue, 12 May 2026 23:52:55 +0200
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
Subject: [PATCH i-g-t 8/8] dmem: get region once per driver
Date: Tue, 12 May 2026 18:51:55 -0300
Message-ID: <20260512215156.4083082-9-cascardo@igalia.com>
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

It is expected that only the same region is going to be tested for, so
there is no use getting the region name for every test for a given driver.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 tests/drv_dmem_cgroups.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tests/drv_dmem_cgroups.c b/tests/drv_dmem_cgroups.c
index 0791bb62d3a2..30f9caf3630c 100644
--- a/tests/drv_dmem_cgroups.c
+++ b/tests/drv_dmem_cgroups.c
@@ -124,18 +124,14 @@ static int fill_vram(const struct igt_dmem_driver *drv, void *ctx, int fd, int m
 	return n_bo;
 }
 
-static void test_write_eviction(int fd, unsigned int flags, const struct igt_dmem_driver *drv)
+static void test_write_eviction(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv)
 {
 	void *ctx;
 	struct igt_cgroup *cg;
-	char *cg_region;
 	int n_bo = 0, max_bo;
 	uint64_t current, capacity, cg_max, limit, after;
 	int set_err, err;
 
-	cg_region = drv->get_region_name(fd);
-	igt_require_f(cg_region, "Region not tracked by dmem cgroup controller\n");
-
 	igt_cgroup_dmem_get_capacity(cg_region, &capacity);
 	igt_require_f(capacity >= 4 * BO_SIZE,
 		      "VRAM capacity (%"PRIu64" MiB) too small to test\n",
@@ -215,7 +211,6 @@ static void test_write_eviction(int fd, unsigned int flags, const struct igt_dme
 	igt_cgroup_dmem_set_max(cg, cg_region, IGT_CGROUP_DMEM_MAX);
 	drv->free_vram(ctx, n_bo, BO_SIZE);
 	drv->deinit(ctx);
-	free(cg_region);
 	igt_cgroup_free(cg);
 }
 
@@ -230,18 +225,14 @@ static int allocate_vram(const struct igt_dmem_driver *drv, void *ctx, int fd, i
 	return err ?: n_bo;
 }
 
-static void test_current(int fd, unsigned int flags, const struct igt_dmem_driver *drv)
+static void test_current(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv)
 {
 	struct igt_cgroup *cg;
-	char *cg_region;
 	void *ctx;
 	uint64_t current, capacity, cg_max;
 	int n_bo = 0, max_bo;
 	int err;
 
-	cg_region = drv->get_region_name(fd);
-	igt_require_f(cg_region, "Region not tracked by dmem cgroup controller\n");
-
 	igt_cgroup_dmem_get_capacity(cg_region, &capacity);
 	igt_require_f(capacity >= 4 * BO_SIZE,
 		      "VRAM capacity (%"PRIu64" MiB) too small to test\n",
@@ -339,13 +330,12 @@ static void test_current(int fd, unsigned int flags, const struct igt_dmem_drive
 		     current / SZ_1M, USAGE_SLACK / SZ_1M);
 
 	drv->deinit(ctx);
-	free(cg_region);
 	igt_cgroup_free(cg);
 }
 
 static const struct {
 	const char *name;
-	void (*test_fn)(int fd, unsigned int flags, const struct igt_dmem_driver *drv);
+	void (*test_fn)(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv);
 	unsigned int flags;
 } subtests[] = {
 	{ "current", test_current, 0 },
@@ -376,20 +366,24 @@ int igt_main()
 	for (int d = 0; drivers[d].driver; d++) {
 		igt_subtest_group() {
 			int fd = -1;
+			char *cg_region;
 			igt_fixture() {
 				fd = drm_open_driver(drivers[d].driver_flag);
 				igt_require_f(fd >= 0,
 					"No %s device found, skipping\n",
 					drivers[d].driver->name);
+				cg_region = drivers[d].driver->get_region_name(fd);
+				igt_require_f(cg_region, "Region not tracked by dmem cgroup controller\n");
 			}
 
 			for (int i = 0; subtests[i].name; i++)
 				igt_subtest_f("%s-%s", drivers[d].driver->name, subtests[i].name)
-					subtests[i].test_fn(fd, subtests[i].flags, drivers[d].driver);
+					subtests[i].test_fn(fd, cg_region, subtests[i].flags, drivers[d].driver);
 
 			igt_fixture() {
 				if (fd >= 0)
 					drm_close_driver(fd);
+				free(cg_region);
 			}
 		}
 	}
-- 
2.47.3

