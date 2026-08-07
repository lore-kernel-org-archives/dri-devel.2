Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D3FC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F4110F449;
	Fri,  7 Aug 2026 10:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fZXJkWzc";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34DD910F449
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:12:27 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so2869410b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786097547; x=1786702347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b1QPAle4B6UVEoKy/UvltvjtFmYUt6krDcEVyTwixgM=;
 b=fZXJkWzciM4mXVS2UTlKiKaSvhE4vEuTTQZsRY7skfTivGmUa8fOV4sVFsyI+PorbK
 h5cfWyibiJIQL9MBVX0cAcAunFtEm6mpewb6qw57JTdecMJumWcus0H4nsw4zRTk3eYH
 WAxqK6isB3sgS4dbnC4Bro2Tn1sIW5EED+ubtnJp0lozVh1TcvVVAO2Tp2mvVPAOytNI
 0C1elsK0Vkj1TEFSRSyVMqMUNYrcpu+PTLU89OlPx6A+8bT22u9SupOHdcu/P7ho3x4q
 vMp/f2shYq/Tq5FyAhQRC+f1ghdHccSbJA6LhgX/NNRIIorr5xlmdLxIndJXzFUqEzER
 /NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097547; x=1786702347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b1QPAle4B6UVEoKy/UvltvjtFmYUt6krDcEVyTwixgM=;
 b=NNTvSRQ8Hp8X/0yC/Yk0McfqPte+5niYkLcwqch3eedO/tn3pz9FLOvCUgPrLhRYsc
 UveGbhfqYREIcACXIMimNyGcTrLVrXmn5G9MWxXilNGaDleNoLxSIpiPDzfw+iWsSX7d
 r95WHINhlGI3JPli+bqbGIeHgCXSUJ8pVI1wSKrC67EioXIRzME12VnV4hO2+kmz9qxR
 l880GJTgfur0G6Zu5zMw9QFX0KcKkLaSkMRDQe98YQG3KeI4UAeCGSvJl0B1SrzmbXnr
 k/XNqBcie/C1j2ZL5ebQtlsov0ZhslBVFgZg1yGVHJdMkOf7s7e1nn5AQkKMWGmKuFRF
 w/+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpuw/gdLcFn8EYHMKH00h77I5E7JRZNtN/z4Gn0m7jFyEx4ejx2LRO+XwKRQkfVeDy/yvWUxyaqHC0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7RUSfrV0bhIu8S0IopSUaUsOV+nVO5Z9DD/mYL7X86HUC9Q26
 o77F4tMau7EQJjlyGT9ffrkfjhmCjpUJefQg8CRVR7XtPsolfQ/EOLRj
X-Gm-Gg: AR+sD10zbBORcCh5jsZOJvkNX8jlunN8YmXw8HfxgS1XPM1N41Yr4ubCIIm9rStzSQ+
 QUyVN2Zxy8yffq6F6NIG0n3d4rKLxMINgxTbjc/SZWuGyxvEE3LYOg68Ok/rpPuSG6ap3DYag4m
 phQOafp7H7rTAJN+gPbiJCMQpBF2Y9Y7h1dZViU40tJFS3BjIsk2cyF3swYDBhdSWmkZ6BaEQTv
 BehwWuZRd/R4cZ0Ln+jKeijVRRqf/cG8LGM0JNAs/vYqKd6Pf8uckaaCXz/ISkk32sTSOLGXjdu
 kHpyDJ+wnhgql3XH4mDr4ChnwvIAl7m0NmuE0zDSvDtN8szdundUyGlk4wxJHdLrV5OTOEiNS2G
 s5/XHOjoDjZf/MTR5Xp9oUXjgSGQF+66hzqFyjIvKXYy8ghLKSSueQ+k6DJ6ER3brIatUqqyXdy
 KOdM6TT/ceTpbotfiRQg/xKLRhnuqcwbnP/+xjhEInzvqENmTccjRhiq2y5G/aJK2V
X-Received: by 2002:a05:6a00:ba06:b0:84d:ff47:fa53 with SMTP id
 d2e1a72fcca58-84f4fd9f842mr10114159b3a.2.1786097546501; 
 Fri, 07 Aug 2026 03:12:26 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a5528adsm797510b3a.45.2026.08.07.03.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:12:26 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>,
 Srinivas Kandagatla <srini@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v6 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT
 regression test
Date: Fri,  7 Aug 2026 18:11:40 +0800
Message-Id: <20260807101140.1357218-5-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807101140.1357218-1-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260807101140.1357218-1-shoubaineng@gmail.com>
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

Add a test case that verifies no file descriptor is leaked when
DMA_HEAP_IOCTL_ALLOC succeeds internally but copy_to_user() fails
to deliver the fd number back to userspace.

The failure is triggered by placing the ioctl argument in a private
anonymous page and flipping it to PROT_READ (via mprotect) between
the kernel's copy_from_user() and copy_to_user() calls.  With the
buggy kernel the ioctl returns -EFAULT but leaves an extra open fd
in the process's fd table; with the fixed kernel the fd count is
unchanged.

This serves as a regression test for:
  "dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds"

Suggested-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 113 +++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index fc9694fc4e89..1d49df671919 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -390,6 +390,116 @@ static void test_alloc_errors(char *heap_name)
 	close(heap_fd);
 }
 
+/*
+ * count_open_fds - return the number of open file descriptors.
+ *
+ * The fd opened by opendir() itself is counted, but since it is opened
+ * and closed within each call, it cancels out when comparing two counts.
+ * Returns -1 on error.
+ */
+static int count_open_fds(void)
+{
+	DIR *d = opendir("/proc/self/fd");
+	struct dirent *de;
+	int count = 0;
+
+	if (!d)
+		return -1;
+
+	while ((de = readdir(d)))
+		if (de->d_name[0] != '.')
+			count++;
+	closedir(d);
+	return count;
+}
+
+/*
+ * test_alloc_no_fd_leak_on_efault - verify no fd is leaked when
+ * copy_to_user() fails during DMA_HEAP_IOCTL_ALLOC.
+ *
+ * The bug: dma_buf_fd() called fd_install() before copy_to_user().
+ * If copy_to_user() then failed (e.g. via mprotect), the fd was
+ * silently installed in the fd table but never returned to userspace.
+ *
+ * The fix: reserve the fd with get_unused_fd_flags() first, attempt
+ * copy_to_user(), and only call fd_install() on success.
+ *
+ * We trigger the failure by placing the ioctl argument in a private
+ * anonymous page and flipping it to PROT_READ before the ioctl.
+ * Inside the kernel, copy_from_user() reads from the page (reads are
+ * allowed under PROT_READ, so it succeeds), but copy_to_user() that
+ * writes the fd number back faults, returning -EFAULT.  We then
+ * count open file descriptors before and after; with the bug an extra
+ * fd is left in the table.
+ */
+static void test_alloc_no_fd_leak_on_efault(char *heap_name)
+{
+	int heap_fd = -1;
+	int fd_before, fd_after;
+	int ret;
+	long page_size;
+	struct dma_heap_allocation_data *req;
+
+	ksft_print_msg("Testing fd leak when copy_to_user() fails:\n");
+
+	heap_fd = dmabuf_heap_open(heap_name);
+
+	page_size = sysconf(_SC_PAGESIZE);
+
+	/*
+	 * Place the ioctl argument in its own private anonymous page so
+	 * we can flip its protection independently.
+	 */
+	req = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (req == MAP_FAILED) {
+		ksft_test_result_fail("mmap failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	memset(req, 0, sizeof(*req));
+	req->len      = page_size;
+	req->fd_flags = O_RDWR | O_CLOEXEC;
+
+	fd_before = count_open_fds();
+	if (fd_before < 0) {
+		ksft_test_result_fail("count_open_fds: %s\n", strerror(errno));
+		munmap(req, page_size);
+		goto out;
+	}
+
+	/*
+	 * Make the page read-only so copy_to_user() will fault.  The
+	 * ioctl must fail with -1; if it returns success the test setup
+	 * is broken (mprotect is synchronous, so there is no race).
+	 */
+	mprotect(req, page_size, PROT_READ);
+
+	ret = ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, req);
+
+	/* Re-allow writes so munmap can clean up */
+	mprotect(req, page_size, PROT_READ | PROT_WRITE);
+	munmap(req, page_size);
+
+	if (ret != -1) {
+		ksft_test_result_fail("ioctl returned %d, expected -1 EFAULT\n",
+				      ret);
+		goto out;
+	}
+
+	fd_after = count_open_fds();
+	if (fd_after < 0) {
+		ksft_test_result_fail("count_open_fds: %s\n", strerror(errno));
+		goto out;
+	}
+
+	ksft_test_result(fd_before == fd_after,
+			 "fd leak on EFAULT: before=%d after=%d\n",
+			 fd_before, fd_after);
+out:
+	close(heap_fd);
+}
+
 static int numer_of_heaps(void)
 {
 	DIR *d = opendir(DEVPATH);
@@ -420,7 +530,7 @@ int main(void)
 		return KSFT_SKIP;
 	}
 
-	ksft_set_plan(11 * numer_of_heaps());
+	ksft_set_plan(12 * numer_of_heaps());
 
 	while ((dir = readdir(d))) {
 		if (!strncmp(dir->d_name, ".", 2))
@@ -435,6 +545,7 @@ int main(void)
 		test_alloc_zeroed(dir->d_name, ONE_MEG);
 		test_alloc_compat(dir->d_name);
 		test_alloc_errors(dir->d_name);
+		test_alloc_no_fd_leak_on_efault(dir->d_name);
 	}
 	closedir(d);
 
-- 
2.34.1

