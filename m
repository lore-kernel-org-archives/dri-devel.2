Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90824606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ExfmwGKC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CC110EA83;
	Wed, 11 Nov 2026 19:59:51 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B87F10FD9D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:59:46 +0000 (UTC)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-847e2926d94so7138769a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794427185; x=1795031985;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EZv892Hp/w8YN/pcYxItocv35LQiqipWkaKIWNQFLHU=;
 b=ExfmwGKCueevub2wXglRU9l6WO0PhmoNWAssRVtcwtp0h7h6yqY9tD5LbTlBqK/7Rf
 Ob86/KDC3czrwDpSCaDuaLEEs2k92ty6EpaiZyw05dxyYwXK5aU2GRlNJ6alKlsr7QdY
 3Kj+IigmXWZ7uADXkhtBzMOMUwU7b0wp+cTYocFg57V4bwz3Sw+XmWXagVeH+poW9dUm
 zMD3QKXaaAwwcBlhc6CK9domC+P/yuIHhIV7vvi/K/9QpVdkk8QcH8f3Ipf7Q+H2DMkr
 vtLc4w4ijRdV0iy6jpIN/ZbpTFGG6G2ju0XZo8r2JyFSoUROEIK+PrwevK282ON9CmMp
 qhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427185; x=1795031985;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EZv892Hp/w8YN/pcYxItocv35LQiqipWkaKIWNQFLHU=;
 b=uPa7WdJP1WeXAobA+ExNgLduri+MWfzJZGvL2srhhozMicKSOoWI1Qd2sczh0YX7dr
 Kv1SyKo2fyRsrIXVN6oigxBHZsPQu44isFbOLVi21tLI5OmhDsK1fGYcmFWHRxCj2OGf
 vemi3c50vp8hMM6rpohhJPgUTu530bCrSBOltP7oykvDyJ5QUapJa2gQs0YhAhFGaUGX
 9Wt+Nk4xg82Fk+3LVEidBh2IRm99NxaqOxNDwKzWP/WP7Qw2zndsAdFFMd61JSHKMzWm
 UYQUqQbDZyGBzHLPXfRvSNcE8F4KISJBXGjkOmeeiTymnZ2HEXw6fCkVA5RtnsEzPQPb
 Lu8g==
X-Forwarded-Encrypted: i=1;
 AL+hErE+qadMHuJ0frdm0uyuAL6p/XWYkKA7pNyzqQ9lpvfAIHH8oGTgmXaMm3H3Jx9VKUmVBZVWPRIfu4M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+4Ao+BBDCfo6QU47VRuJb60nlylXAsfsFg7LbPj4snoOrjd3BY
 pVdeUSV4uH/LLKsF75lKia3cXICXok2z1l7t0s3Ib6deC6f+pEKg1pk86/4Ue+zH8DKk8wUvL/m
 mewjdJszfXg+iJgmXJg==
X-Received: from iohf22-n2.prod.google.com
 ([2002:a05:6602:a5d6:20b0:9e3:4b87:936d])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c1b2:b0:4d6:90f4:48ab with SMTP id
 5614622812f47-56b97c18413mr3271887b6e.45.1794427184911; 
 Wed, 11 Nov 2026 11:59:44 -0800 (PST)
Date: Wed, 11 Nov 2026 11:59:42 -0800
In-Reply-To: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111195942.1283060-1-tjmercier@google.com>
Subject: [PATCH bpf] selftests/bpf: Test that a drained dmabuf iterator keeps
 returning NULL
From: "T.J. Mercier" <tjmercier@google.com>
To: k.chen@smail.nju.edu.cn, ast@kernel.org, daniel@iogearbox.net, 
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
 christian.koenig@amd.com, sumit.semwal@linaro.org, phasta@kernel.org, 
 tj@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The BPF iterator docs in bpf_iterators.rst specify that the next
function of an open-coded iterator should keep returning NULL after it
has been returned once.

Add a subtest that checks this for the dmabuf iterator. It drains an
iterator, calls bpf_iter_dmabuf_next() once more and checks that the
result is NULL. The dma-bufs the test creates keep the list from being
empty, so an iterator that starts over would return one of them.

The existing open_coded subtest uses bpf_for_each(), which stops at the
first NULL and never calls next() on a drained iterator.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
This depends on Kang Chen's fix and fails without it:
https://lore.kernel.org/bpf/20261110125106.2935677-1-k.chen@smail.nju.edu.cn/
Kang, feel free to carry it as 2/2 in your v2.

 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 19 +++++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
index 1a5dc1adae73..c1f81b5dccdc 100644
--- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
@@ -265,6 +265,23 @@ static void subtest_dmabuf_iter_check_open_coded(struct dmabuf_iter *skel, int m
 	} while (bpf_map_get_next_key(map_fd, key, key));
 }
 
+static void subtest_dmabuf_iter_check_next_after_drain(struct dmabuf_iter *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, fd;
+
+	fd = bpf_program__fd(skel->progs.iter_dmabuf_next_after_drain);
+
+	err = bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	/* The test buffers exist, so a restarted iteration would find one */
+	ASSERT_EQ(skel->data->next_after_drain, 0, "next_after_drain");
+}
+
 void test_dmabuf_iter(void)
 {
 	struct dmabuf_iter *skel = NULL;
@@ -315,6 +332,8 @@ void test_dmabuf_iter(void)
 	}
 	if (test__start_subtest("open_coded"))
 		subtest_dmabuf_iter_check_open_coded(skel, map_fd);
+	if (test__start_subtest("next_after_drain"))
+		subtest_dmabuf_iter_check_next_after_drain(skel);
 
 destroy:
 	destroy_test_buffers();
diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
index 9cbb7442646e..d5421b75c39c 100644
--- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
@@ -99,3 +99,22 @@ int iter_dmabuf_for_each(const void *ctx)
 
 	return 0;
 }
+
+/* Result of a bpf_iter_dmabuf_next() call after the iterator was drained */
+__u64 next_after_drain = -1;
+
+SEC("syscall")
+int iter_dmabuf_next_after_drain(const void *ctx)
+{
+	struct bpf_iter_dmabuf it;
+
+	bpf_iter_dmabuf_new(&it);
+	while (bpf_iter_dmabuf_next(&it))
+		;
+
+	/* Store the raw value; the verifier would remove a branch on it */
+	next_after_drain = (__u64)bpf_iter_dmabuf_next(&it);
+	bpf_iter_dmabuf_destroy(&it);
+
+	return 0;
+}
-- 
2.56.0.567.gdb80ae8cd5-goog

