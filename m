Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C28606A335
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=tZW4o+wP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E97E11253A;
	Fri, 13 Nov 2026 13:43:48 +0000 (UTC)
X-Greylist: delayed 4313 seconds by postgrey-1.36 at gabe;
 Fri, 13 Nov 2026 03:56:49 UTC
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E46310E17F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 03:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1794542206;
 bh=dPhxcd6/BZYgx50DAMwodoQTThTXpPpE+XC7POngjKc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=tZW4o+wP4u2aKyvmdv8OtQtI7wAI6PUv4Kl+nHnECdilJdzwgdFvlLZM0/1EyUDMo
 PhEgKU+AMKfUJ14CndUAtIPC+jiPg73Fti7l+s4UCAahM7wUYqPnoUrzzd+EB1+PUq
 E+/K2wNCBo790xw8ux9n5hIYPjE6Pxx3DdC2dQ/I=
X-QQ-mid: zesmtpip2t1794542205tbf655990
X-QQ-Originating-IP: e1SLVr7RTm7aupYw6jdBDKSKPKp3JMysT4SS655xl4c=
Received: from workstation-Precision-7920-Towe ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Nov 2026 11:56:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6820046291963919950
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, tjmercier@google.com,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test that a drained dmabuf iterator
 keeps returning NULL
Date: Fri, 13 Nov 2026 11:56:40 +0800
Message-Id: <20261113035640.948458-2-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113035640.948458-1-k.chen@smail.nju.edu.cn>
References: <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
 <20261113035640.948458-1-k.chen@smail.nju.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MVMn5D3ouL6CRs7SYK/eQvRARRNYnt+QewD2lzqvtDn3REqkJ18ZVb0o
 oACC/KUJSpl7Wh4Mfz/L/UDEYeX/ViPetGE0xoPZRkKOURX/c/zMbOryVhWrkHcrhCuilIq
 Vz/i7Wq7fN7Ll3WP7sZU2VEr9RvQ95Lm/DWFZg7vpp+eD6o/f+hOd20ftHbixafOiNo18i3
 BQnt2YCPNFShxJG6OY7ude53TgAvqAiXiO9FT0GQL9qT6K4k2sO17Hlw+dUwuKhuscJlHys
 K/A8cu8P6G2jRIPoxbaor5cNtKjB1loOvZo8UXOEcuc7sAexTD0GhR0TrzOBBnglFyDmN+6
 dHxBakKQDO4D23rH2CtAnYhoAUZ5nM7W6Xk5sYZj78rQVqDtODLHz8NFLYL2mhLMIYgfHQt
 oizyF5ND3fQiVElJDsuOHWwHVrXnY/M0+IeZurlXmWALk9izPVs0A+D0p4IRU2FfYFbhoMw
 pbDxM6QTsCUAOne/U5UiFoGrc16QaYA83nUz8lCUlaqB8D9fIzi8xgJc3TMxAqu79wABPcC
 lNWXcUbv/puS5ZBnwJ0uhD4LMip6i48ueSHJ+ckBNsUjF9J7UzbBZGEICfcBpMYO8tITrJN
 cYnBYpCiRNADS+pvWQD8YXNl1EZmNVjfWBMZGdPRl3LWcwte5d91ErxfXsiGyEmrTEeP0x3
 +Vk51N8sRWtXQpYH+7+skq9S2nRo/59AxeupyAurbLepXgOeI6Ksifh6z6gumQR1z3n6np8
 LIWg8ftbvvqPHvWVzulQB+auPyvDwVQTJSucac75V1fmeboxmsbPFwN8uYQXOHUwy+rioFj
 OccnBQKFJFwuoQi8/K/mToBlRQ3mVSAMt4RjUNo67FuAhx5hOz70xhx4OJ51yGQLJvE0fb0
 S2LausbvnCyK75VDiAit34EAH60WRF3ODJtRHCKZecM9AUUZZsB8UUg+3klOL3kHnNBGAm5
 PgztHvP/GfzcOMPv7/jALJOMg6+gWsYMT8Xq7bF4BFElF9GiiViz7M8vefLzZ7V4oZyYJ0O
 UogpF/6Cm+AZJN0em7ZEr3yzpIsqHg7rHlJ/Z8AUb/wdV/MU85VSgz3gvjRZMIp4uBz5hn7
 VxiStPrZkx7Dre0c6OxsKUaGKnxtP1iMDlvGdSWdZ82tQOxRD1RsftwZlwzWtWE6nlG9wd9
 65ha9X7WNSj/oDhYpvSvyMNAoA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The BPF iterator docs in bpf_iterators.rst specify that the next
function of an open-coded iterator should keep returning NULL after it
has been returned once.

Add a subtest that checks this for the dmabuf iterator.  It drains an
iterator, calls bpf_iter_dmabuf_next() once more and checks that the
result is NULL.  The dma-bufs the test creates keep the list from being
empty, so an iterator that starts over would return one of them.

The existing open_coded subtest uses bpf_for_each(), which stops at the
first NULL and never calls next() on a drained iterator.

The selftest was originally posted by T.J. Mercier in the v1 thread:

Link: https://lore.kernel.org/bpf/CABdmKX09vLG4U-7FwF-vm_iTy1AjGUPXka08KhWE+qJ0J=XGMA@mail.gmail.com/

Co-developed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
v3:
- Add T.J. Mercier's Co-developed-by and matching Signed-off-by.
- No code change.

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
2.34.1

