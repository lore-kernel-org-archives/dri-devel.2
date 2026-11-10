Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4960A2639
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=P81EvUDE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD6110F951;
	Wed, 11 Nov 2026 08:22:47 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020D110E0BE
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1794315076;
 bh=RxZl6p7PH/ZzZkbb7ep2WA/FeXnjYV/M8ID/0T9gT/Q=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=P81EvUDE43xzstajgf+sI9X+pLW+ob8SILVChwhEsrWzA4wVEQM05+0Fzb+oZ+QED
 m+qZpG8jrX0Jf/CKh1vPpdcikBw9T7cUs/7xepnGCDkYwgMiyKZfdrmrvvFj3faM0D
 hOncwWAg2Sf+tkvhorDN3MjK+ZMiItYf4Y1FfB7E=
X-QQ-mid: zesmtpip2t1794315069t11fc89a1
X-QQ-Originating-IP: DOWT+SLXdKkkQCd8sDpgnmX258kipbcc6y7odjw9PsU=
Received: from workstation-Precision-7920-Towe ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 10 Nov 2026 20:51:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12170903532052178925
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH] bpf: make dmabuf iterator stay drained after NULL
Date: Tue, 10 Nov 2026 20:51:06 +0800
Message-Id: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Of6TnALcrk8RsA+IeRm9l2S6bCt1a/e0DXFDHcHfDuku/1JelOLz/aIy
 vPTTJZ3+0aFk9JK1f3fbVuLHrp+iocOp3Wme3VRRpjoEzUrzAL39T+3k8I1M3TeN+dFgu2P
 Le2+hzWbfHvK9XHUBIZVwgChHSy7/67p7nBlo2DOVbN5V+ksNsebGHSwbuyOKz2YIY8uioD
 Yj9Wss5nE517ymdFINE1OcE4DoXeg45xDGeUm7fhkPQfOYKatkQXbdyRoi7gWtZ4nVzsS04
 DdN5CeihL8hw75LenchP1Go/W9Z8CVKU2Kg+kmWU+eEAmivsintXx0/jKVq7cTuJXKNieah
 D8QJzqZ0/wcAh3MEWKxeSmr4lS3mcSE4tNS9D1/LMH+5TwYOq0+dnfDiqW6HMWPm6ES2Wb3
 NEjGgXJcpPIM9O9KW3Mwp8GxHJ6CtD5F+H/7SwsNoXXnGcsPzyou31O+oPo3/BxVAHMi65E
 iNnyzKZkuJ3YOx+Mp6Wcs1iDOaMLNTXjk374xkExRFmFea0uho7+MlZ6p5dmfcjxKxNEa89
 YRKaUjUuECLBTO6NjTyG/zQWK3u+EvVNUx7Q1brGu0rRoc6uut9n4rN/QP8TlyuoF8+P21U
 GwA67a+L8onc+iOoQJ6wZ8jacT2ipm8oJGKh0D3hdEn5Qx6bN+VbXGUn0OIYcieg/M4e0Zs
 o6du6krQ6cfB2fSYB6NX2h3O4H+fAU1NK/DODC3Zd0Q/m+n9gKNMqluEwhSNrClw71jS26e
 Fg+XucncVQp0iGiUP+fi7AaVjhz7eLEt6nDoWESME/9YD/b6cftKFH5/F/VBr/S++UyQizS
 nVaWTm4diDbzO/f0dyH/vl75SOF3SujP7wGmgFbpWdqF7tTWybL7ZwfQlwqlanOPrYk7hbY
 BOqmDNKeke5R7QW/jafBDmkq65DiQ7gBYnJ4lY8PgUXXPivAgv7OJGawJO7oEJ/JOZD2jwH
 9tEf4KR/45CSJaCHxia8DML/klcuMKHy7xUeR0kEKAhcjHiJdPfL6DtST4N7ENBToTiBRcX
 FztCsmHejDp58wXf1rtWRjsjMk2oO44VPQlGAy4Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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

bpf_iter_dmabuf_next() uses kit->dmabuf == NULL to mean "iteration has
not started".  dma_buf_iter_next() also returns NULL at the end of the
list, so a next() call after exhaustion restarts from the list head.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats the result of later next() calls as the
constant zero.  A restarted dmabuf iteration therefore hands the BPF
program a kernel pointer while the verifier believes R0 == 0.

Use an invalid pointer value as the drained sentinel so the iterator
state keeps its one-pointer ABI, and skip dma_buf_put() for it.

Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 kernel/bpf/dmabuf_iter.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index cd500248abd9..a2b7c38f9ae6 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -156,6 +156,13 @@ struct bpf_iter_dmabuf_kern {
 	struct dma_buf *dmabuf;
 } __aligned(8);
 
+/*
+ * The iterator state is one pointer wide because struct bpf_iter_dmabuf is
+ * part of the generated vmlinux.h ABI.  Use an invalid pointer value as the
+ * "drained" sentinel instead of growing the state.
+ */
+#define DMABUF_ITER_DONE	((struct dma_buf *)1L)
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
@@ -173,11 +180,25 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;
 
+	/*
+	 * The verifier assumes that an iterator which returned NULL keeps
+	 * returning NULL (see process_iter_next_call()).  Without this check
+	 * the NULL left by the last dma_buf_iter_next() would be interpreted
+	 * as "not started" and the iteration would restart from the list head.
+	 */
+	if (kit->dmabuf == DMABUF_ITER_DONE)
+		return NULL;
+
 	if (kit->dmabuf)
 		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
 	else
 		kit->dmabuf = dma_buf_iter_begin();
 
+	if (!kit->dmabuf) {
+		kit->dmabuf = DMABUF_ITER_DONE;
+		return NULL;
+	}
+
 	return kit->dmabuf;
 }
 
@@ -185,7 +206,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;
 
-	if (kit->dmabuf)
+	if (kit->dmabuf && kit->dmabuf != DMABUF_ITER_DONE)
 		dma_buf_put(kit->dmabuf);
 }
 
-- 
2.34.1

