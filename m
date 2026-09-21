Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330B4C982D8
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 00:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB8E10E02A;
	Mon, 21 Sep 2026 00:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="TuX7DGwg";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C2010E02A
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 00:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789952362; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lL1jVEPuBqJBYKaejbSGzPwWM6IcPOo60xT8cuJH3icSrIFbFT+SXQTCkRQtJ1VO+1LDHyWBPvpfz4gkVKvB7whpBaNA75Fiyep1PLPu5xLZWPSs5e8DjxXWkZRIJbIqGpqDHXBDH/eXC5dn9ICW1hMSk6l5imq6WYfGhtm8ykE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789952362;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3uOE6/WbMU3Rw0wv+VLv145VBkxclKWWaSO5Z0wsDOU=; 
 b=VmZJJyF7PdUdxDz5fgdAM1pf/48zd7QmiznK28KVcw28EwOOTrV1FSEVHl4+I0vuqB+fXu/eiESmoJeMt6LIYXwPuI2hMGHWO78XCPwE2SdvFMzPONuPrQC8Z/ql5RHNVcSTrnmXgvAGkWkkfpIaSJhMHJRwyjOKMtT1ammrXKI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789952362; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=3uOE6/WbMU3Rw0wv+VLv145VBkxclKWWaSO5Z0wsDOU=;
 b=TuX7DGwgQQg6VVfVb/QZd+I6/2rnGezsu9HGXJT2OXYWji+wJTQD2fz+vlWnXG4Y
 W1JJTrtbW3cg+RkoFT4/IqXpN3W3+PpDDjYdBqq/azfnMO6zTzuW3FXEv7Wg10hup6N
 gLtsxRcL7/zZHM2pk/BVQ16vKSMUjeg5s5o/SnwI=
Received: by smtp.zohomail.com with SMTPS id 178995236151042.39333842971428;
 Sun, 20 Sep 2026 17:59:21 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Sun, 20 Sep 2026 17:59:09 -0700
Subject: [PATCH i-g-t v2] tests/panthor: skip sparse VM_BIND tests before v1.9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-b4-panthor_version_sparse-v2-1-fa395c125eb1@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NWwqDMBBFtyLz3SmJNkr75T6KSB6jBqyRiYQWc
 e9NXUE/7+vcHSKxpwiPYgem5KMPSxblpQA76WUk9C5rKEVZi7tUaG646mWbAveJ+Ffv46o5Eqr
 BuEpaK5xykPcr0+DfJ/sJHkfcoMv25OMW+HM+JnmGf8CTRImNtlKYRlFdydaGedYmsL7a8ILuO
 I4vgSVJwM0AAAA=
X-Change-ID: 20260915-b4-panthor_version_sparse-5fbd31cc0d5d
To: igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, boris.brezillon@collabora.com, 
 steven.price@arm.com, liviu.dudau@arm.com, adrian.larumbe@collabora.com, 
 kamil.konieczny@linux.intel.com, samitolvanen@google.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8313;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=Szy9Y8+zjtogDh+1jJnaGXQzpIa+Pa/KVMGWmfShe4E=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkbGpOXvC7xOPhnpvSrlKeJrTOfBW4xOFKWzDb94nFRh
 o3VYs/4OkpZGMS4GGTFFFnO2hv1iFe9N9Kd/78ZZg4rE8gQBi5OAZgIcwfD/4DbGxI1dTRy918T
 7/FgZdqvfOfPikR7m4qVjR0Su6JfdTH84fTw1jn3YNGqmVe+HlrWzeYrs+2rrUDWpac3rS8vWFq
 yhhUA
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

Add a shared macro igt_require_panthor_version() to check the version in
case other Panthor tests would like to use it in the future.

The Panthor version macro wraps the igt_require_f() macro so that we can
clear the last errno. The last errno is irrelevant to the version check
but __igt_skip_check() will still print it like this:

  Starting subtest: vm_bind_sparse
  Test requirement not met in function __igt_unique____real_main10, file ../tests/panthor/panthor_vm.c:296:
  Test requirement: __igt_panthor_driver_version_at_least(fd, 1, 9)
  Requires Panthor version 1.9 or newer
  Last errno: 2, No such file or directory
  Subtest vm_bind_sparse: SKIP (0.000s)

This makes the log noisier than it already is. So set the errno to 0 to
suppress that line. Skipping the test will now print:

  Starting subtest: vm_bind_sparse
  Test requirement not met in function __igt_unique____real_main10, file ../tests/panthor/panthor_vm.c:296:
  Test requirement: __igt_panthor_driver_version_at_least(fd, 1, 9)
  Requires Panthor version 1.9 or newer
  Subtest vm_bind_sparse: SKIP (0.000s)

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
Changes in v2:
- check for version at each subtest
- make version check available to all panthor tests
- use macro to suppress printing the last error
- Link to v1: https://lore.kernel.org/r/20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com
---
 lib/igt_panthor.c          | 14 ++++++++++++++
 lib/igt_panthor.h          | 18 ++++++++++++++++++
 tests/panthor/panthor_vm.c | 18 ++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/lib/igt_panthor.c b/lib/igt_panthor.c
index 11d8ec342..0f8c408d5 100644
--- a/lib/igt_panthor.c
+++ b/lib/igt_panthor.c
@@ -385,3 +385,17 @@ void igt_panthor_free_bo(int fd, struct panthor_bo *bo)
 
 	gem_close(fd, bo->handle);
 }
+
+bool __igt_panthor_driver_version_at_least(int fd, int major, int minor)
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
diff --git a/lib/igt_panthor.h b/lib/igt_panthor.h
index ba4a9bf1e..626e5d525 100644
--- a/lib/igt_panthor.h
+++ b/lib/igt_panthor.h
@@ -37,6 +37,24 @@ void igt_panthor_group_submit_simple(int fd, uint32_t group_handle,
 				     uint32_t stream_size, uint32_t syncobj_handle,
 				     int err);
 uint64_t igt_panthor_get_first_core(uint64_t cores_present);
+bool __igt_panthor_driver_version_at_least(int fd, int major, int minor);
+
+/**
+ * igt_require_panthor_version:
+ * @fd: device file descriptor
+ * @major: required Panthor major version
+ * @minor: required Panthor minor version
+ *
+ * Require the Panthor version to be at least the requested version.
+ */
+#define igt_require_panthor_version(fd, major, minor) do { \
+	/* igt_require_f() reports errno through __igt_skip_check(); */ \
+	/* clear it since errno is unrelated to the version check. */ \
+	errno = 0; \
+	igt_require_f(__igt_panthor_driver_version_at_least(fd, major, minor), \
+		      "Requires Panthor version %d.%d or newer\n", \
+		      major, minor); \
+} while (0)
 
 static inline void igt_panthor_vm_bind(int fd, uint32_t vm_id, uint32_t bo_handle,
 				       uint64_t va, uint64_t size, uint32_t flags, int err)
diff --git a/tests/panthor/panthor_vm.c b/tests/panthor/panthor_vm.c
index 9011df25e..bd8f14ecb 100644
--- a/tests/panthor/panthor_vm.c
+++ b/tests/panthor/panthor_vm.c
@@ -293,6 +293,7 @@ int igt_main() {
 		uint32_t vm_id;
 		uint64_t map_size = SZ_4K * 4;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -306,6 +307,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -321,6 +323,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -336,6 +339,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -351,6 +355,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -366,6 +371,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -382,6 +388,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -402,6 +409,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -422,6 +430,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -442,6 +451,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -463,6 +473,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -483,6 +494,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -503,6 +515,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -524,6 +537,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -545,6 +559,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -566,6 +581,7 @@ int igt_main() {
 		uint64_t map_size = SZ_2M * 3;
 		const int INITIAL_VA = SZ_4M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -585,6 +601,7 @@ int igt_main() {
 		uint64_t map_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - (SZ_2M * 3);
 		const int INITIAL_VA = SZ_512M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 
@@ -599,6 +616,7 @@ int igt_main() {
 		uint64_t unmap_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - map_size;
 		const int INITIAL_VA = SZ_512M;
 
+		igt_require_panthor_version(fd, 1, 9);
 		igt_panthor_vm_create(fd, &vm_id, 0);
 		igt_assert(vm_id != 0);
 

---
base-commit: 970700a95acd74bb987287d10147b5f23380519b
change-id: 20260915-b4-panthor_version_sparse-5fbd31cc0d5d

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

