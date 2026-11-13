Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D4606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=gOxtODFq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 625DA11255E;
	Fri, 13 Nov 2026 13:43:54 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEDC810E63D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 02:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1794537891;
 bh=l5lZWNF7Ym38b1LI7ehF+OPGmdiH9wvt6SCkHsFrtjw=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=gOxtODFquZ6qM11cjavoeLWu/7D72/nrGmfDSjTyPTKlBvyzWUxgtP88AOBH/I/Np
 kICCbJVRuvOjL+xXm912VmHnx5Z4pPsWKtEuNDrJrlUSimeEhhPHPkPx5h8QGQK+vq
 k5tk21/LwSgkeNDkYP87qfqrQJSJ8C2G91Xiuhhg=
X-QQ-mid: zesmtpip2t1794537889t9e608108
X-QQ-Originating-IP: /Dst6S97j4UJ+YS+s8qXpvhzGetRv4t3V4IIfCGjFGI=
Received: from workstation-Precision-7920-Towe ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Nov 2026 10:44:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8035796014243981157
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
Subject: [PATCH bpf v2 1/2] bpf: make dmabuf iterator stay drained after NULL
Date: Fri, 13 Nov 2026 10:44:46 +0800
Message-Id: <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MjqaYNLY8QZGJszbSAppscBWRdlMG+zMbHf+MeJn3oSHTkWESnyckha8
 /1RKf+CZ2KJjVPK9CziiTSjjso1gH0ckXskEnIz8paJ/ieazUyoYRyPYgVGPVALWrQemeoE
 DzcDOEliV0aMuCWG6z3GYY8A9tdxY1bK0tl86G+WI1gf7tr3WvhCZ6xcgzpZVwSBG89fCd2
 wwnzgLdUi1Klj/aSgwhV4hfvnYwnyqVQj6ofbe/nC+3mn0432hIOLDGeev3a+Ari8eug/cu
 3M6BCCai/NjoFDaCr4YBT0tloayP9Tmlty1CX/tRIbuYoA5lcMLq2K6vMpTZUPRxhHrctVI
 zPxKQSW9wrtzWz+vhck5WMEtjMJuhGwWr50TIdJjABixD3pQkPoYWn11kgaffvJ3rrloKEz
 DMk3LeSD+e4+VduFN/u7CKrDuZx8nJoNdrfKIhJN2yjUkmkgoQkbTfxnn2vbbRT9JdhGubY
 3b/7D+IQzL7q2hIjKVdDTTDB9zx5XUnTRRVI4NElRGtXm4pthDvWDMnBlcMrBtKbwNkMy1G
 mpIJzIMB9iXsmnta/P8XJVrPberg1UdupC9nNENgzJudBlyNTGJX1FXKmEkw5bZzfhVukEN
 OQdkshjxtvnIF1ViX47FZhRZhK1WUCjuM/Uq1w7Dstx+KmRZ2MNZjkps/oPYEQ1iwBr353d
 Owvnj8XGxIxrT33pDAZvKhPDUXvF4wLVDP51WmdHifaIfpQvNOWMKe0c8xzKwwrUBUqqf7e
 p7extZD2KdYDzmOBALf/l31fPqN2ESbIRA8JTkVHyawh21iDCGwzyN6uXJndcFxm73mur2S
 WrmNFBfwU3TfURVUyj5J/O32V7TAB6t7+SRjozzYyQZaN6mQIjL+P9NeICH2Uk3So4+xXN0
 oGViuAbQTWpNXpAYEgW70tcSkmdwnaXpwguYg0u4V1i5+fry/RZuvUb21OOGkEQ3ahc5wHY
 txemdHXRAZKCd6zZowQ+VGM11tw/1vKFMPyJmBQaRo3QOxOzlxagosY5ZAH+FwVSb+c6cPw
 Ej7p6TNw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

bpf_iter_dmabuf_next() uses kit->dmabuf == NULL to mean "iteration has
not started".  dma_buf_iter_next() also returns NULL at the end of the
list, so a next() call after exhaustion restarts from the list head.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats the result of later next() calls as the
constant zero.  A restarted dmabuf iteration therefore hands the BPF
program a kernel pointer while the verifier believes R0 == 0.

NULL now means drained.  Initialize the state to DMABUF_ITER_START and
translate it to dma_buf_iter_begin() on the first next().  The iterator
state is BPF-visible ABI (one pointer wide), so use an invalid pointer
sentinel instead of growing it.

Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
v2:
- Use DMABUF_ITER_START; NULL now means drained.
- Move the ABI explanation to the commit message.

 kernel/bpf/dmabuf_iter.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index cd500248abd9..390f6d730a67 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -156,6 +156,9 @@ struct bpf_iter_dmabuf_kern {
 	struct dma_buf *dmabuf;
 } __aligned(8);
 
+/* NULL means drained; START means "not started yet". */
+#define DMABUF_ITER_START	((struct dma_buf *)1L)
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
@@ -165,7 +168,7 @@ __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
 	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
 	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
 
-	kit->dmabuf = NULL;
+	kit->dmabuf = DMABUF_ITER_START;
 	return 0;
 }
 
@@ -173,10 +176,14 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;
 
-	if (kit->dmabuf)
-		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
-	else
+	/* Once NULL is returned, next() has to keep returning NULL. */
+	if (!kit->dmabuf)
+		return NULL;
+
+	if (kit->dmabuf == DMABUF_ITER_START)
 		kit->dmabuf = dma_buf_iter_begin();
+	else
+		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
 
 	return kit->dmabuf;
 }
@@ -185,7 +192,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
 {
 	struct bpf_iter_dmabuf_kern *kit = (void *)it;
 
-	if (kit->dmabuf)
+	if (kit->dmabuf && kit->dmabuf != DMABUF_ITER_START)
 		dma_buf_put(kit->dmabuf);
 }
 
-- 
2.34.1

