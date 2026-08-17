Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80E2C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343AE10E638;
	Mon, 17 Aug 2026 05:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZb97VB7";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7356810E638
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:05:28 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso1798325a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 22:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786943128; x=1787547928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ziVl5gmafK8z7JTYijjTnWVXlXKGtu8Xos512S76WIk=;
 b=BZb97VB7dAPQGNxZIxZDCJ+cO57snbBQz74KiWf4502z0EOit3vMNBAxqwvYUKgjzw
 3/kNdwNLif2AdGJsooB/Ka4kXI+j+GFS60ih5hRVQTYozFzZJk7rYHyIjSgaq1yPZVhX
 98Ban4BV87hXSmuTqE5YjIMp8pWfZCXG+ZUP41dhgiDNaB82Aw3MoIzkDdwTMPiehFgp
 6r9GHHCHoEmEY8TboOkaBe28Ii1BOdD6/YetARUKUw5K7JW9IHZ91dHnViZKkIHK4BUo
 N4zn1kngQLM9nbYu8Bsqm0UIWYhNNe+qG3mebOk7JE5W4QEA5qHOwW3Ps+d0WESBPh2X
 V9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786943128; x=1787547928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ziVl5gmafK8z7JTYijjTnWVXlXKGtu8Xos512S76WIk=;
 b=b/XW6ZJ54gksBtJzGlERYK9YVLN+EEhBHYreOdeMijjRSm44dtV2LnXj/X4L03Zg6r
 CKzBOKX0ZFgUa+wFsRkQQxDaLE2GuBvPV+9RPZE2NkEi3lXAquzZQWaIiVMdHLu3OH8t
 6wJjrNEdUFyC3GuIP4qqrK6v9YptwlpX/kE4fohS7ZTV4qNhgTyTSsmcPFBxbbO4D21B
 Mqo9bJDodQLSzyWqh98pDRpwORlnfyxbxB+He+BAuqvC10sheHELHcaC8uCOptv0sSdx
 h7D1OfpPH40NXrZokdVLAXnI8ba5kkkSqZqxeiG//sJ4jg2KWSydJ4vluid1QjOVqw6K
 Su1g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPQwSBPsXGmuDwzuhO+etvtbwTbUKjT07IjBPcMyWh7Yy/OGK6PZgzse9Aqs1S1RnRYQHr7tbK30c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3A180rECzCyMYYayPH8hTGXkm7LRJyw8i99vlsJPep+3xAtjY
 xibZUomdOoWPINDCCyk28b5UPGe3E2+KKtLcc86v0xY2wq5oo2V6hewQ
X-Gm-Gg: AR+sD10U0Qt65xyONtONvMAZxOFLdR8XM/SvkiFhND22CVlZ5eySzCMNiDAtRS4h2EQ
 jbTwfLtyy7NUU3lKuaWeGAXDApgWRNr4u9ezCCSa7rFS0S6Ynuhsz41bEZdPZdplY1Ip/7K6HZI
 GZER2VTdn0NwnceKaCekLajzvqDqWfe4qoscfPtiEyzjvMBT0XaGyeTmZTvkeECGDyakALYHXpm
 6xjY+qDZ/wn7v30Tctjk+6bMY30KfHIVTr5fFZLTltB1LUweCspDJWIYd0MmEfbLTJNFsF2U7tD
 aWTogoNrGzQg4ACDGLhkb0PfmmR9sFPaQ/y5krnfTxVf9x89K/cUcg3QMi+m+uAupwhmb96B4LB
 cvGH+Xh8kerarm7xvjG167Zl75/vOrEL26Uh70AfTXI2TFcH7aKbpyWpvvo+QHdNy+VumpXG/+W
 k5NzMb+zrwYD+FtimiUL3ejpgIqfXP8h+RyrGuH09j0lEjGNaXraaNylZlQfUQc6XJ
X-Received: by 2002:a05:6a00:1f03:b0:846:bc81:3e29 with SMTP id
 d2e1a72fcca58-84fde365255mr23307379b3a.2.1786943127867; 
 Sun, 16 Aug 2026 22:05:27 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d267310sm2131036b3a.53.2026.08.16.22.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 22:05:27 -0700 (PDT)
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
Subject: [PATCH v7 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT
 regression test
Date: Mon, 17 Aug 2026 13:04:57 +0800
Message-Id: <20260817050457.1005285-5-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817050457.1005285-1-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260817050457.1005285-1-shoubaineng@gmail.com>
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
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
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

