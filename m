Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16E6083606
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxLKm0Xp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523F610F6B0;
	Tue,  3 Nov 2026 15:55:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F2C10F6B0
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:55:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EC1F60254;
 Tue,  3 Nov 2026 15:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FC61F00A02;
 Tue,  3 Nov 2026 15:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793721301;
 bh=9oI+39KPSefDJAX6kpWWwyfL2A7o2EUE+Zm7n2vH2s8=;
 h=From:To:Cc:Subject:Date;
 b=VxLKm0XpRkMgxWDksOnroNDk3UvSJoO4QJ9r0n9YglpI+On+nE3urJ70ewW9eaLCh
 4cBtwp3vTI3xgbbDoq5DzvqVucTw39IFI48XI8lkzhLxMYzKMnvvaAt2Bwl4iVUqf9
 LZWkeNvG+Pu4mjqCgScZyTRkRYfzbzE2xe8jUKta0J6hYJO1tSBbkth46ERxmmTzh7
 hjcbQnhRywh6vCH06HBNVQ1/Z6QUZgl7YsXGIop7SNHYjEZtGO2sCxpdVkNkZgE6ge
 AzS1oNfh24dc4ohRkHhvCZtc+c8wF1sKIvtT2LDclwhvgRxCDIZJ68dGlW0ULmT4BX
 4zZJ+EJx0VqqA==
From: Sasha Levin <sashal@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: dmabuf-heaps: print size_t with %zu
Date: Tue,  3 Nov 2026 10:54:59 -0500
Message-ID: <20261103155459.534792-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 32-bit architectures size_t is an unsigned int, and printing it with
%ld warns:

  dmabuf-heap.c:215:43: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Wformat=]

Use %zu.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with a 32-bit build of the selftests with a 64-bit time_t (gcc 16
and clang 21 with -m32 -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm builds show the same warnings. The changed files
build without format warnings there now, and the x86_64 builds don't
change. The other selftests get the same kind of fix in separate
patches.

 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 1d49df6719198..c65efc088e88d 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -212,7 +212,7 @@ static void test_alloc_zeroed(char *heap_name, size_t size)
 	void *p = NULL;
 	char *c;
 
-	ksft_print_msg("Testing alloced %ldk buffers are zeroed:\n", size / 1024);
+	ksft_print_msg("Testing alloced %zuk buffers are zeroed:\n", size / 1024);
 	heap_fd = dmabuf_heap_open(heap_name);
 
 	/* Allocate and fill a bunch of buffers */
-- 
2.53.0

