Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A5606A886
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=a/lP3ijM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBDEC11254B;
	Fri, 13 Nov 2026 13:43:48 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C095110E2B1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 03:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1794542203;
 bh=hAiDmJ443y2iUubPvVfTIYqLx/39zAUaPPDN0i4fC9k=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=a/lP3ijMWgkal7l2BohGnJ3ekLRbNt2EIQwU0MMYuojPJut0mJiAtCJEKZ8bPOOp8
 Q65mU/q2aRmCXvjd1HhXJSjqq+Ev5eaM9PLisTcRqU8mE8IGmhPKYVIqaRBHcoCe5E
 ULFiG4SqYWE+T1GlChcXTER0AtEDdOLjksSwWYzc=
X-QQ-mid: zesmtpip2t1794542202tdf7edc25
X-QQ-Originating-IP: pjvt4R46xHwoXR/6JTLGH/XItwH2cP13Q18VXRvb/gk=
Received: from workstation-Precision-7920-Towe ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Nov 2026 11:56:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10146906103779689649
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
Subject: [PATCH bpf v3 1/2] bpf: make dmabuf iterator stay drained after NULL
Date: Fri, 13 Nov 2026 11:56:39 +0800
Message-Id: <20261113035640.948458-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
References: <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NJL+bfc5gN/m02E90MnK47QbFF60SCYpAJ5U7s7yWnsxMo6cOPzxj4Rl
 JnnMHwikp0+0OGowLd72xT2TVnHkGIevqJl8l6QAGK0NlynjESd+RHEN3CSp7LaV8qmb5Vb
 uDeMfC91Sy3bxzbHkzYZ2H0MQ7HHcce9sP6PMVxEf+u6FIHIjQvEYSn3dR9t5TZQ+xD0DDS
 muzT8p8MXEDlEyvVRk7cCNRc7u7Wem/tGBCYDo1vJ/n4C23Xh9oIl2j59Ntpj5yjFkBGVzP
 PF08Ino0S1D0MG1sy2XF1WFTUBAk9p+LW0i3ri+Tb8eEFDbzHtJ2I9iWRtBi2TRxKS4UOPX
 BVnEif33WTfWCPiMhB4Mcx1ESEO6upgtAs6LjSl30YH9q35xOCbdWQsCVNiywYsElIU0qlm
 U3ZFXSm1d3NiAMwIKa5fOB7HJEeEVmfTiSmVYuV6jx3T8ntCkvW1Mj3lZYOLhl+uREUSkxX
 Ow3h7Xsv6d+ieoPLfE1UP4P9Aw6nUQvzHle0Jhy+ZFbL3cWrxZkydX33gWiMVAHnEnBmhmF
 uwkmdirJ1/Q4Nk29nBh5ko49GtFtOBNEtzAPf75ncx/+fGsy2FDQlKbGPzZtY/kE7+4WOBW
 CwMWlA0YgfkBSR66OGEHsTak7K/3tjDtJNVgvt9biCDxh7gT16PbmJAnZ6TxZauqdyHLX+j
 ZWVZ4DZc3jkG4Xi0O6JSz8TFppfDbrIv3BmA37kY/+oZ+ohTA/8dS/yGEn0Hm6HF4fHnvrj
 NrDPsYaqq9vKR3GBWtY85LltTv3BKvmK1++aPy/6yIwvMhS4kA6DAGZfYX6sZ8bONnMXISB
 lnbk1yNgYnWO6hgOJlBa1pPI4gBFf1YRgJkVxEKpeDtRnEkWI+Sttcf7tRX9aQ8dp8zlZKT
 +DpnmEUZoB20psGI9T6oYh5dmRIeSi2wm2BjvmJYnDp3U9E5lcEFGC4NztBjYm/U098h4f3
 vcYmb+dnm7OaMQrp+Th0WFpHCV1U/T6d1BP7FZ46u7SbwEnqXcLzCfw1AbLgwM4EvY+DHhW
 mGvUxNXRGxyZp6Z4gkYnf48WBztbIo3AX/M3CxBM+VNE6qUL+ArwnXYsWFk7snJDAbyJP7E
 7R/Va0s4ks8JBV3Xr0t6w0=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
v3:
- No change from v2; reposted with the updated 2/2 attribution.

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

