Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68DF606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BR9gWkW8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DED510EBC1;
	Mon,  2 Nov 2026 08:04:02 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7717310E527
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 06:46:03 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so1369348a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793601963; x=1794206763; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fij261aOp4ff0AwpnNS7x2Qa4LrIQ9juiwmci3p7/C8=;
 b=BR9gWkW8hbwfoqXv1sN6BOe5jeTP6KG4/SHhxiMQoaku8GYmAKc0k7cpWDbgI64Qu8
 oxRGsFUn4ZKeTlEvqlbxVN9A7tFqzLKEpkn5fRbpI6jMwfJWvnRcriEOJmyON3WlH+X2
 DJ94PyX/7D7YMlUXjxCGWtUvZ/7qRe0u3pxdgf9acRvOC7TjJEJyQp1Yj34g27ik5VRP
 NbCJs0nbaDuzFOl6WbT9c6u1Y9eqx2Fu0afCIJe9umcUSrSs30yUU4G42xbE1ShrO8Tk
 Xq3R1RCSrGu26PQCQGAWOmVJBtPHUkBIXVKwqrFDuc7pkv6Xt+gcO+iL871X9CmMMPAs
 1cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793601963; x=1794206763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fij261aOp4ff0AwpnNS7x2Qa4LrIQ9juiwmci3p7/C8=;
 b=AsUrpaaiPZZ3VAmrGlqS86HPWxD06+IUPc9ZNPkmVZyB9m2Zn8GPl5b1v16t6Fu/iT
 9gxpHHB0xryWN+u1P20zq1sIC9bajsJ1XUN7IUyU4d+qNPajD2dc2t83pw/C5rKLqdnG
 co7GCySGljVdLiMc29R4HvkzFUHrzF4+16yV6uqsLc+n7QHa4yunK6AVZwaEb2U7ElO5
 gzw/jsJ4nkuuGxHxTzTFzrulqhgUp6aABJP2BaOoJveXiclWxFUELXOi6l4nnvWa2b7D
 UtJrGRr7z6c1OISLzpwyZbajDHansC1Bjee8jBdAZz3TcQLPZMAl8xyT8GD+XrzpHS0c
 1uNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx37MNyKzw3FMqJOaPt8p09EDXDSHbGPAMMQKuNi88FpTl1aGf57Zc/+yMw5iu1Ic3VljVg/+pZCtc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z84o0gDTnMNt7WWUmt2aQU/x5vx7t/x85Eb6rM2SVzos4JSaKxQ
 Yink58r8OjQ9D5r2uwNnJG0CUU6zl7+NQqfG6t+4Xxf476AlLCOwrcJG
X-Gm-Gg: AYBFou1Q/qNMldVtZhH/NMW9vfXSgp79ZMzgBa7B/QYqeEzqTHR/wMjOOEUiCCvKv3+
 /XJhQq+Q2RgVqpZHxPua2B0T/Ww365Wrm0YGX/aDvJT5V41Dphtdh0NqLDX5eyZ8PhjKp1OLJQl
 3Awj1qqeN8JKrRHS2Xwgd1fMfXy2UdIAoOK/WjvsFGYJTipcF8VVvwZ/HD3Jdz3pmnORUKU+ggQ
 2gLJfrUnaAmlX3ZP9ZdOtbdc6ELqwDzKj796QoR7tJvYUljyOi5TgplPfl5+UEpKpia2ZKGEKsg
 GgFBcBvb4rg6kq4RKCO138bTFwz1pJAZPAAK5Rz4tV1EznSiMUAteB0HPscH8NMEqyAV9FKBBx2
 jAsQ2QWMowWHLWiEydWoG8l3vD0RpYbqj7lfkS7wo8O9OucMlDvClhoXtFgqCNz6cZkZxIsEWW6
 /vLBGdg+3D3ucqHqLmM4x+TkX5TD3QvcUVL+nVeS9GTDuDuWld8Ci5qCY9WfOO+iuxKhX8VgPNS
 AeIkt/wYo4qkz3Pb3f7J8JcAripDOmzUDKxiev+5jvvGXfcC4Jigrmvu8kvkB0natAmjlIkxqf+
 34XsxmNqnWn61vMGOkgVni0DoLjY6gAJb6Fxbqr/Tlf2+C4yQ1Zm0CPbIWrwHIPup7cobihMcdd
 f
X-Received: by 2002:a17:90b:224f:b0:3ac:8af9:4a6a with SMTP id
 98e67ed59e1d1-3ae8976f156mr7826857a91.42.1793601962666; 
 Sun, 01 Nov 2026 22:46:02 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845fb9f6sm12614376a91.17.2026.11.01.22.45.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Nov 2026 22:46:02 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: matthew.auld@intel.com,
	arunpravin.paneerselvam@amd.com
Cc: joelagnelf@nvidia.com, christian.koenig@amd.com, mairacanal@riseup.net,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] gpu/tests/buddy: Stop a test when gpu_buddy_init() fails
Date: Mon,  2 Nov 2026 14:45:53 +0800
Message-ID: <20261102064553.82038-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Three tests check gpu_buddy_init() with KUNIT_EXPECT_FALSE(), which only
records the failure, and go on to allocate from the allocator and to
call gpu_buddy_fini(). When gpu_buddy_init() fails, it has freed what it
allocated (or never allocated it), and the gpu_buddy is on the test's
stack, uninitialized, so the test then works on freed or garbage
pointers. The other tests in the file use KUNIT_ASSERT_FALSE(), which
stops the test case.

Use KUNIT_ASSERT_FALSE() in gpu_test_buddy_alloc_clear(),
gpu_test_buddy_alloc_contiguous() and gpu_test_buddy_alloc_limit() too.
In gpu_test_buddy_alloc_clear() each later call follows a
gpu_buddy_fini(), so stopping there leaves nothing allocated.

Found by kbound, a static analysis prototype for ownership mismatches at
kernel interfaces. Run-tested on QEMU (x86_64, KVM) with KASAN and the
suite as a module, with failslab limited to allocations under
gpu_buddy_init() and set to fail the first call's 1st to 5th allocation.
Before this patch, all 15 runs (three tests, five allocations) end in a
general protection fault, five of them after KASAN slab-use-after-free
reports in gpu_buddy_alloc_blocks() or __gpu_buddy_alloc_range(). With
it, each stops at the assertion, and the whole suite still passes
without injection.

Fixes: 932da861956a ("drm: selftest: convert drm_buddy selftest to KUnit")
Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test")
Fixes: c1696bf8d5f5 ("drm/tests: Add a test case for drm buddy clear allocation")
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed and tested them as
    described above.
    
    The runs were on mainline d135ab453a74; the test file is the same there
    and in drm-misc-next, which this patch is based on, except for an
    unrelated hunk in gpu_test_buddy_alloc_contiguous().

 drivers/gpu/tests/gpu_buddy_test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 2c6f1da1a6d1..e85d83e42bb7 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -975,7 +975,7 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
 	LIST_HEAD(clean);
 
 	mm_size = SZ_4K << max_order;
-	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
 
 	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
 
@@ -1035,7 +1035,7 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
 	gpu_buddy_free_list(&mm, &dirty, 0);
 	gpu_buddy_fini(&mm);
 
-	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
 
 	/*
 	 * Create a new mm. Intentionally fragment the address space by creating
@@ -1095,7 +1095,7 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
 	 */
 	mm_size = (SZ_4K << max_order) + (SZ_4K << (max_order - 2));
 
-	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
 	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
 	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4K << max_order,
 							    4 * ps, ps, &allocated,
@@ -1123,7 +1123,7 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
 	 * and the split blocks should be merged back to their original size, so
 	 * clear_avail must drop to 0.
 	 */
-	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
 	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
 
 	n_pages = mm_size / ps;
@@ -1147,7 +1147,7 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
 	 * the split blocks should be merged back to their original size, so the
 	 * whole address space (clear_avail) must equal mm_size.
 	 */
-	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
 	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
 
 	for (i = 0; i < n_pages; i++) {
@@ -1176,7 +1176,7 @@ static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
 	LIST_HEAD(right);
 	LIST_HEAD(allocated);
 
-	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
 
 	/*
 	 * Idea is to fragment the address space by alternating block
@@ -1490,7 +1490,7 @@ static void gpu_test_buddy_alloc_limit(struct kunit *test)
 	LIST_HEAD(allocated);
 	struct gpu_buddy mm;
 
-	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, size, SZ_4K));
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, size, SZ_4K));
 
 	KUNIT_EXPECT_EQ_MSG(test, mm.max_order, GPU_BUDDY_MAX_ORDER,
 			    "mm.max_order(%d) != %d\n", mm.max_order,

base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
-- 
2.53.0

