Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0941606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bC0jnxGP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74EA10E3F1;
	Sun, 22 Nov 2026 07:44:15 +0000 (UTC)
Received: from mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C23AF10E3F0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:44:05 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=9Bjh+mLwWCYX/lvrGtaVs+DhROo/OhYvZoDPXw0dP3Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795333443; v=1; x=1795938243;
 b=bC0jnxGPSaPpJtl1gBeDr0ifYR2/e/dkmb364Rzq7+DRLQVqlQCdFJSDw8+fqi84VAkeziHK
 5Kj2n5xErRzr0PPJDyyCwoNV+E1X5o0OuG3r2IKkR8V0p/tICIuXrB8MwzA9NG6bPJ2gWQ+mqhx
 URcamZdvRwTz81xS2Hrjs7hU=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 5445dd188f8cd78c;
 Sun, 22 Nov 2026 07:37:59 +0000
X-Mizu-Trace-ID: 5445dd188f8cd78c
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Sun, 22 Nov 2026 02:37:38 -0500
Subject: [PATCH 3/3] selftests/udmabuf: test mapping a huge page backed udmabuf
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-feat-udmabuf-huge-pfnmap-v1-3-dcba888940c2@linux.dev>
References: <20261122-feat-udmabuf-huge-pfnmap-v1-0-dcba888940c2@linux.dev>
In-Reply-To: <20261122-feat-udmabuf-huge-pfnmap-v1-0-dcba888940c2@linux.dev>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

udmabuf maps the ranges of a buffer that are backed by huge pages with
PMDs, provided the mapping covers whole PMDs at an aligned address.

The existing tests of huge page backed buffers only map a few pages, so
they never get a PMD mapping or check what is read through one.

Map a 64 MiB udmabuf backed by 2 MiB huge pages and read back what was
written to the memfd: through a mapping of the whole buffer, which must
be PMD aligned when THP support is built in, through a mapping at an
unaligned offset, and from a forked child.

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 90 ++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index d78aec662586b..e09330fece6fb 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -14,6 +14,7 @@
 #include <sys/ioctl.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
+#include <sys/wait.h>
 #include <linux/memfd.h>
 #include <linux/udmabuf.h>
 #include "kselftest.h"
@@ -130,6 +131,91 @@ static int compare_chunks(void *addr1, void *addr2, off64_t memfd_size)
 	return ret;
 }
 
+#define HPAGE_SIZE	(2UL << 20)
+#define HUGE_BUF_SIZE	(32 * HPAGE_SIZE)
+
+/* Check that @len bytes of @buf at @off read back what was written to @mem */
+static bool check_huge_range(int buf, char *mem, off_t off, size_t len)
+{
+	char *addr;
+	size_t i;
+	bool ok = true;
+
+	addr = mmap(NULL, len, PROT_READ, MAP_SHARED, buf, off);
+	if (addr == MAP_FAILED)
+		return false;
+
+	for (i = 0; i < len; i += getpagesize()) {
+		if (addr[i] != mem[off + i]) {
+			ok = false;
+			break;
+		}
+	}
+
+	munmap(addr, len);
+	return ok;
+}
+
+/*
+ * Map a udmabuf backed by 2MB huge pages, which can be mapped with PMDs, and
+ * read it back from a PMD-aligned address, a sub-range at an unaligned offset
+ * and a forked child.
+ */
+static void test_huge_mapping(int devfd)
+{
+	struct udmabuf_create create = {};
+	int memfd, buf, status;
+	bool thp, aligned, ok;
+	char *mem, *addr;
+	pid_t pid;
+	size_t i;
+
+	memfd = create_memfd_with_seals(HUGE_BUF_SIZE, true);
+	mem = mmap_fd(memfd, HUGE_BUF_SIZE);
+	for (i = 0; i < HUGE_BUF_SIZE; i += getpagesize())
+		mem[i] = (char)(i / getpagesize());
+
+	create.memfd = memfd;
+	create.size = HUGE_BUF_SIZE;
+	buf = ioctl(devfd, UDMABUF_CREATE, &create);
+	if (buf < 0) {
+		ksft_test_result_fail("%s: [FAIL,test-8]\n", TEST_PREFIX);
+		ksft_test_result_skip("%s: [SKIP,test-9]\n", TEST_PREFIX);
+		goto out;
+	}
+
+	/* The address is only aligned when THP support is built in */
+	thp = !access("/sys/kernel/mm/transparent_hugepage", F_OK);
+	addr = mmap(NULL, HUGE_BUF_SIZE, PROT_READ, MAP_SHARED, buf, 0);
+	aligned = addr != MAP_FAILED &&
+		  (!thp || !((unsigned long)addr % HPAGE_SIZE));
+	if (addr != MAP_FAILED)
+		munmap(addr, HUGE_BUF_SIZE);
+	ok = aligned && check_huge_range(buf, mem, 0, HUGE_BUF_SIZE);
+	if (ok)
+		ksft_test_result_pass("%s: [PASS,test-8]\n", TEST_PREFIX);
+	else
+		ksft_test_result_fail("%s: [FAIL,test-8]\n", TEST_PREFIX);
+
+	ok = check_huge_range(buf, mem, HPAGE_SIZE + getpagesize(),
+			      5 * HPAGE_SIZE + 3 * getpagesize());
+	pid = fork();
+	if (!pid)
+		_exit(check_huge_range(buf, mem, 0, HUGE_BUF_SIZE) ? 0 : 1);
+	if (pid < 0 || waitpid(pid, &status, 0) != pid ||
+	    !WIFEXITED(status) || WEXITSTATUS(status))
+		ok = false;
+	if (ok)
+		ksft_test_result_pass("%s: [PASS,test-9]\n", TEST_PREFIX);
+	else
+		ksft_test_result_fail("%s: [FAIL,test-9]\n", TEST_PREFIX);
+
+	close(buf);
+out:
+	munmap(mem, HUGE_BUF_SIZE);
+	close(memfd);
+}
+
 int main(int argc, char *argv[])
 {
 	struct udmabuf_create create;
@@ -138,7 +224,7 @@ int main(int argc, char *argv[])
 	void *addr1, *addr2;
 
 	ksft_print_header();
-	ksft_set_plan(7);
+	ksft_set_plan(9);
 
 	devfd = open("/dev/udmabuf", O_RDWR);
 	if (devfd < 0) {
@@ -268,6 +354,8 @@ int main(int argc, char *argv[])
 
 	close(buf);
 	close(memfd);
+
+	test_huge_mapping(devfd);
 	close(devfd);
 
 	ksft_print_msg("%s: ok\n", TEST_PREFIX);

-- 
2.43.0

