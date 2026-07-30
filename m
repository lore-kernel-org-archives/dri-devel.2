Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE60DC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357D710E654;
	Thu, 30 Jul 2026 06:28:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a1r6CyCZ";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768FB10E65E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:27:50 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso1935978b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 23:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785392870; x=1785997670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ax7tbNUValSVYnoO1zdiSGKC5h5YwguB1K37baEZiC0=;
 b=a1r6CyCZ9g8w4AmoJkNjKwJ+ou9cuRFl9x5SkPxB6GfI7mCwxeo6UmDWqMVz+OkxRG
 AgPEhba7YKUsOV5D02CxRz1MFloQr3/vfvJ6aru6Fv9r43DKBcOHqWXvtf8DJwdOCn5K
 1PmI3Tw2KLXjJGAUPmmBTWq9Z6czzbRMmpk/IdyZPnynzcqWww+00qPm1X9U/KyY6ISb
 CrV4z0OVmXI8pvY010KQDWGJDS2DUXz1M2ahH1m/6ZsR1bHX/528GRYhCYOeTdomY+qm
 LwC3L4ywuRctoo6ONXyvif8gWzt2JkkS5jhIx1XOow0AKPn6Gah3dyo097jOq6n0/U0z
 EsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785392870; x=1785997670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ax7tbNUValSVYnoO1zdiSGKC5h5YwguB1K37baEZiC0=;
 b=MVqUrNXOTeHtEs8aTbuLwQOG+fXkg4g05qea/jWLOku/G/XBRKoexTI5E8c6C7oZOC
 lxgVHKqn1UTVHwRWJ/kYqd30QoaSLn7tw/XxAEX0ntiG0cFJFQhuNmUJXDNgsMx6F0FX
 x4iRmgsti4RSr0ZjCjNuorjTVOZHCFDeDRqIn3UQkRXSfAoDxEJQF5Mg0BhxIariKOVt
 EgrmtOiqZLXai6aZ07eh+wy43tjdtaJspdhs6Bniyk0qd7S9uuyykrVlQWRiUor++WJc
 1RZ2BLXJ24e4u7ejhtksUgcCRLG+WjA8isR5XiPSjM8V9fUaqawpbfaZpmDbN+Y5blQw
 nf2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaJAkizZSR5sNYhUcRUKcQLUQwGB2EoP39gDthwBx1uIsrkRhbR3pOtvpRUWYySx8lhwwBzKgrBeQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxADGA7BhfSGJ9qc8FOhSxt1BEKQqvr7E5eS4XezDeSrGlHJI/0
 iOaikVNpNj/CsNGTInUAOkjKl5EDfkteD/EOQ83YXg9jJSwmldfuqcjy
X-Gm-Gg: AR+sD11JoJoGzSFouLqnbOe4q0MjTuNHhlvH5/JUZLDHb0wqaEF4YnZ8WlgK46XLJpS
 7flGcwugNyscAheM1qsGooPVKUHnpEY6ZyA7M64nCiEBlmlK+pjygMscPd+xa8H8aOtdtzgf7yb
 Z6yUOL9BIsUl6kiM4GxuvIkjxvF7NgR7+PY2TPl2U083tilo6qopT0JzMPSKKlZF9cYPNY6VuJo
 U1rJK+tPz98GTWzKdMz7QCljwGZT8vm+KtRhHxVpVYb3u9Sh/OQ6TS4pAicWrbvmyM89CuldkTX
 DdOT+9asxmtvmCJ5JQtUFpgJJEAVCr2YHSdycODcIFnWTPuEtygjaznTEMh3aVnd79871GA/G9k
 SsQ9BytKPj27TDC9VACfmMapXSPt/5pa3JC9JOcRYHYhzCyAELQoU9kVNyhhLT2O23GEKOsXwZK
 0wE91rNF3dmHDWo6GwTYydKQLPd2Z79o7kPwjt9rMv60fcx0SPisCDU4Flg5e1vktU
X-Received: by 2002:a05:6a00:2d04:b0:848:2f7a:2e57 with SMTP id
 d2e1a72fcca58-84ebc4475aamr1325657b3a.70.1785392869924; 
 Wed, 29 Jul 2026 23:27:49 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea00507b0sm2503229b3a.14.2026.07.29.23.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 23:27:49 -0700 (PDT)
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
Subject: [PATCH v5 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT
 regression test
Date: Thu, 30 Jul 2026 14:26:45 +0800
Message-Id: <20260730062645.233148-5-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730062645.233148-1-shoubaineng@gmail.com>
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062645.233148-1-shoubaineng@gmail.com>
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
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 115 +++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index fc9694fc4e89..bd58e5b06c8b 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -390,6 +390,118 @@ static void test_alloc_errors(char *heap_name)
 	close(heap_fd);
 }
 
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
+ * We trigger the failure by placing the ioctl argument in a page,
+ * flipping it to PROT_READ between copy_from_user and copy_to_user,
+ * and counting open file descriptors before and after.
+ */
+static void test_alloc_no_fd_leak_on_efault(char *heap_name)
+{
+	int heap_fd = -1;
+	int fd_before, fd_after;
+	int ret;
+	long page_size;
+	struct dma_heap_allocation_data *req;
+
+	ksft_print_msg("Testing no fd leak when copy_to_user() fails:\n");
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
+	/* Count open fds before the ioctl */
+	fd_before = 0;
+	{
+		DIR *d = opendir("/proc/self/fd");
+		struct dirent *de;
+
+		if (!d) {
+			ksft_test_result_fail("opendir /proc/self/fd: %s\n",
+					      strerror(errno));
+			munmap(req, page_size);
+			goto out;
+		}
+		while ((de = readdir(d)))
+			if (de->d_name[0] != '.')
+				fd_before++;
+		closedir(d);
+		/* subtract the fd opened by opendir itself */
+	}
+
+	/*
+	 * Make the page read-only: copy_from_user() in the kernel will
+	 * still succeed (it already ran), but copy_to_user() that writes
+	 * the fd number back will fault.
+	 */
+	mprotect(req, page_size, PROT_READ);
+
+	ret = ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, req);
+
+	/* Re-allow writes so munmap can clean up */
+	mprotect(req, page_size, PROT_READ | PROT_WRITE);
+	munmap(req, page_size);
+
+	if (ret != -1 || errno != EFAULT) {
+		/*
+		 * If the ioctl didn't fail with EFAULT, either the kernel
+		 * handled it differently or mprotect raced.  Skip rather
+		 * than giving a false pass/fail.
+		 */
+		ksft_test_result_skip(
+			"ioctl did not return EFAULT (ret=%d errno=%d), skipping\n",
+			ret, errno);
+		goto out;
+	}
+
+	/* Count open fds after the failed ioctl */
+	fd_after = 0;
+	{
+		DIR *d = opendir("/proc/self/fd");
+		struct dirent *de;
+
+		if (!d) {
+			ksft_test_result_fail("opendir /proc/self/fd: %s\n",
+					      strerror(errno));
+			goto out;
+		}
+		while ((de = readdir(d)))
+			if (de->d_name[0] != '.')
+				fd_after++;
+		closedir(d);
+	}
+
+	ksft_test_result(fd_before == fd_after,
+			 "no fd leak on EFAULT: before=%d after=%d\n",
+			 fd_before, fd_after);
+out:
+	close(heap_fd);
+}
+
 static int numer_of_heaps(void)
 {
 	DIR *d = opendir(DEVPATH);
@@ -420,7 +532,7 @@ int main(void)
 		return KSFT_SKIP;
 	}
 
-	ksft_set_plan(11 * numer_of_heaps());
+	ksft_set_plan(12 * numer_of_heaps());
 
 	while ((dir = readdir(d))) {
 		if (!strncmp(dir->d_name, ".", 2))
@@ -435,6 +547,7 @@ int main(void)
 		test_alloc_zeroed(dir->d_name, ONE_MEG);
 		test_alloc_compat(dir->d_name);
 		test_alloc_errors(dir->d_name);
+		test_alloc_no_fd_leak_on_efault(dir->d_name);
 	}
 	closedir(d);
 
-- 
2.34.1

