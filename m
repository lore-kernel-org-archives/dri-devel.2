Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86FEC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 03:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C529D10E416;
	Tue, 22 Sep 2026 03:05:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="BpKJ90MT";
	dkim-atps=neutral
X-Greylist: delayed 93076 seconds by postgrey-1.36 at gabe;
 Tue, 22 Sep 2026 03:05:44 UTC
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762D710E416;
 Tue, 22 Sep 2026 03:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790046340; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dFSXCIDQOMaoSmgBBQvU11b2wh1epZvqu0YPwe0fNKi3v+OBYBd2sk737rdBLW4bdry6XiO+wnt/KP+uCi+iIEAA0uxfJ8EWUFaoXPWXnDrXySL0QMaqPNW5lFrBMQehHXkv91+AfDl2/NN4c0kzt1GhCTySQO0qeEcUZFDfxUw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790046340;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PXbI2lTfqqmAeWp6f+oE9zSfl2WfpxBwL8fvYVwJezw=; 
 b=RHZnnep6QmCWoRAix4iGwgoeA0FwTrR2djOOJTQbJQamn5GLEFDChPGAi5EyeMy6tckD2I9dvq5y3RqWBaiy71SaIzIkqsNOV2TnM/8W4MQfNXSYXSGU/ggXlRGQqpH3ANujzV3490jDXZjo+uUhafktuye2m63lpZjb8eM6OKY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790046340; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=PXbI2lTfqqmAeWp6f+oE9zSfl2WfpxBwL8fvYVwJezw=;
 b=BpKJ90MTJFP9aGiAyitsfhjp+vdJTrz086zLKotEcTJ1GXnwvEZawdQ+zv5ECjy6
 UYG6tjBKKYaZrvMDxwhsbGhRumT6EgW2BTMo2+f1uhv7kFL9JQH57JLygQ50aQPaA7i
 oDWS0uUs9pN9AdmdyV7fvFAmKbYS/xJKo3Byqv5U=
Received: by smtp.zohomail.com with SMTPS id 1790046339713467.8925374352067;
 Mon, 21 Sep 2026 20:05:39 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 21 Sep 2026 20:05:37 -0700
Subject: [PATCH i-g-t v3] tests/panthor: skip sparse VM_BIND tests before v1.9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-panthor_version_sparse-v3-1-c0af288ca073@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTQrCMBAF4KuUrI1kEtNSV95DpORn2gZqU5ISl
 NK7G7MSBHH5Zt58s5GIwWEk52ojAZOLzs85iENFzKjmAamzORPOeM1akFSf6KLmdfShSxje9S4
 uKkSkstdWgDHMSkvy/RKwd49iX4mjA13JLY9HF1cfnuVjgrL8A09AgTbKANONxFrAxfhpUtoHd
 TT+XuTEPzTOfmk8a70SrTTAJeovbd/3F4A57pYbAQAA
X-Change-ID: 20260915-b4-panthor_version_sparse-5fbd31cc0d5d
To: igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, boris.brezillon@collabora.com, 
 steven.price@arm.com, liviu.dudau@arm.com, adrian.larumbe@collabora.com, 
 kamil.konieczny@linux.intel.com, samitolvanen@google.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6724;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=Hi+2hJpRO7BIby799Zl7jNoQ+2SWvf2UnXGJSE5N/ug=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkbPzTlLj+ZKbB1esjHV2/2Gb1N+vdi5YsdTw+ozN+9P
 SBD5aq9S0cpC4MYF4OsmCLLWXujHvGq90a68/83w8xhZQIZwsDFKQATUXBgZOhkOCqemlMb9PEK
 e4T2eRneKX6f+q+e7v3Tw+EnpO1rkMLIsEjn9oamgo2S//YI/njVU3n1K9/qf1/U+l6s5lva9kA
 6ngEA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

Sparse VM_BIND support was introduced with Panthor DRM driver version
1.9. If a driver isn't advertising support for v1.9, skip the sparse
VM_BIND subtests.

Use the advertised driver version rather than probing for EINVAL, since
EINVAL may also indicate a uAPI regression rather than lack of support for
sparse VM_BIND.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
Changes in v3:
- change macro to function
- move the helper functions to tests/panthor
- add documentation for functions
- Link to v2: https://lore.kernel.org/r/20260920-b4-panthor_version_sparse-v2-1-fa395c125eb1@collabora.com

Changes in v2:
- check for version at each subtest
- make version check available to all panthor tests
- use macro to suppress printing the last error
- Link to v1: https://lore.kernel.org/r/20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com
---
 tests/panthor/panthor_vm.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/panthor/panthor_vm.c b/tests/panthor/panthor_vm.c
index 9011df25e..08a4b7f05 100644
--- a/tests/panthor/panthor_vm.c
+++ b/tests/panthor/panthor_vm.c
@@ -7,6 +7,47 @@
 #include "igt_sizes.h"
 #include "panthor_drm.h"
 
+/**
+ * panthor_driver_version_at_least:
+ * @fd: panthor device file descriptor
+ * @major: required Panthor major version
+ * @minor: required Panthor minor version
+ *
+ * Returns true if the Panthor version is at least the requested version.
+ */
+static bool
+panthor_driver_version_at_least(int fd, int major, int minor)
+{
+	drmVersionPtr version = drmGetVersion(fd);
+	bool supported;
+
+	igt_assert(version);
+	supported = version->version_major > major ||
+		    (version->version_major == major &&
+		     version->version_minor >= minor);
+	drmFreeVersion(version);
+
+	return supported;
+}
+
+/**
+ * require_panthor_version:
+ * @fd: device file descriptor
+ * @major: required Panthor major version
+ * @minor: required Panthor minor version
+ *
+ * Require the Panthor version to be at least the requested version.
+ */
+static void
+require_panthor_version(int fd, int major, int minor)
+{
+	if (!panthor_driver_version_at_least(fd, major, minor)) {
+		/* Clear irrelevant errno to avoid printing it in the skip log. */
+		errno = 0;
+		igt_skip("Panthor version %d.%d or newer required\n", major, minor);
+	}
+}
+
 int igt_main() {
 	int fd = -1;
 
@@ -293,6 +334,7 @@ int igt_main() {
 		uint32_t vm_id;
 		uint64_t map_size = SZ_4K * 4;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -306,6 +348,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -321,6 +364,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -336,6 +380,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -351,6 +396,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -366,6 +412,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -382,6 +429,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -402,6 +450,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -422,6 +471,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -442,6 +492,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -463,6 +514,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -483,6 +535,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -503,6 +556,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -524,6 +578,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -545,6 +600,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -566,6 +622,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -585,6 +642,7 @@ int igt_main() {
 		uint64_t map_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - (SZ_2M * 3);
 		const int INITIAL_VA = SZ_512M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -599,6 +657,7 @@ int igt_main() {
 		uint64_t unmap_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - map_size;
 		const int INITIAL_VA = SZ_512M;
 
+		require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 

---
base-commit: 520aba273f391e31e18b6fe98d71201eb505a683
change-id: 20260915-b4-panthor_version_sparse-5fbd31cc0d5d

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

