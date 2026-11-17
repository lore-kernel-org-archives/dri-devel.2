Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A454606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MnZBlu7N;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C9gr9A69
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF4D10EAE1;
	Tue, 17 Nov 2026 09:40:22 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0FD10EAE1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:40:06 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AH8wMmf2935699
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ivcu7icy+v5UgwpSbnoG8gD/Yiq18mY0ukKMJKEVeBs=; b=MnZBlu7NadjpLoE1
 qVAjWUj+sh9C2x+laGTw0FJMhjuKPLhnAiCl5mGbX3ff1uDXpGgsZru5mMv6w1ee
 hRgcMAJl+82Xo3KOG5iWX3lrwNEmCxp4sIvhlvso1MVNga0zezdFyeaSkfaLppa+
 yiRPDwIfEfmVxaB2sXFxAsgBZ5l1sa9KXKB5d+wv6cR65EKAailbNSkSWq4eJrbc
 pmTXBkcwlB3YJNc0cYzXVQ5yR769byG2VllmGpI/z8NMPqZqdZQfiZnEdV/v1WWt
 zexxB1OmICaArAs9/Tl3+5qf303Ohi7nC2K7fmdLA79RAzZcgNxQozlJbyETLt1S
 a9SRFg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m0ae4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:40:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8b691cf0eeaso3214732b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794908405; x=1795513205;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ivcu7icy+v5UgwpSbnoG8gD/Yiq18mY0ukKMJKEVeBs=;
 b=C9gr9A69zLrXpu1T7mOIhnrblfUWCUGqr3nt9ZT4JfYwZb+OTPjE77SyatmTJf0eAU
 IxCfzuyXXOGRb72tunU53vwe/f7kEAMW68qv1qAhhEwNAQt0zBRxcLoD2K+1veROqmHH
 dviVpIZP1LegdvHxAeuSbXKeOuisIqBMBf661EDiatARHdRcIKN7eG18zzOsSEazBzDv
 2UG/y2v+FqMqLJDRJpLeFnLtIGq2hr0ojvyMMs06ND1c3p2zhga8Rek67O1wJiOxr72D
 +9ylOaxAJ1nUBOJ6afIg8OqAaZ7SA+1AMkGEZHj2Z9uwMhQ4IxmcorNzwanHU2uAN/O0
 Amlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908405; x=1795513205;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ivcu7icy+v5UgwpSbnoG8gD/Yiq18mY0ukKMJKEVeBs=;
 b=eL+h+rg/WRvA2fHBwQ88kX2LXXsgnaozGjyY5K2ASvfhWzYowjjIA9tIjfCJHFr01I
 h+Vnzkb5aAPJnAQsEJ9obq+UG6du3qFzCaasKo1BJjcDMkZcJJUgNnoJTyAtNMiIXvW4
 gg06a4l8tFMe3ARdfTwVbI49rLztf3IgLrZ0fxlggFvQoyDAAFEkjk9ap3RBYSg0Cgv1
 4+7IrlTeYienvQs7qgRub1qgfjznPDTLoZtvXJkIqUj1tVU9g5bHG8M0nM1GfNyPdwHT
 1xdr6Ck1pzfSBViJTN9WtYr0bQG8NES/ONFmGSzhR+ccOB8qQs6rGJpCeoW14jlv13yn
 9R1w==
X-Forwarded-Encrypted: i=1;
 AL+hErEGI22Ae8wakcm0+NEDG9Gundpx2DaXlo5GmoGvwSTpLn0rN8iItp6cvhv5Y4puacVValsJfFvUz5U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z96AAUaBduWmHKC2t8IvDK0QLOf2S7Le5T1krhuCai6IdRAC5GU
 tl5ReY1Wcz6tSyxGUEmuKGx8142hrAPQn+bbGFpkKdp96spoQvfIG7GRZyDIiTKunLPF3Ntc0i2
 vZOLw0Gdf3H1nXrKSdun4HlLVbuW7lFsEmtwF8il3H0KuimkscWtFyvKH66/Cz6/Wp92avek=
X-Gm-Gg: AYBFou2Z7EwUYb9tSlodlm42ItONlEPIPOjDGlIbr2yDGx+XxnIQ0fUQ5C5kwcTpRgO
 +NP3yT8F9lbsnh++ra14u79tpja60yU0Q50P8wV59vXKoSAqvAP4Y2HsjZsh3FJbvvmmaEYrbz3
 SopWMev04wUszDYP8JC0NI2B+vTTWNWJDIxreaJHLUZBoxSaqNWBKmJUMNLsIQOqRXikhBmVWwB
 uMJDAnsLecT+xxbsh/UbnvLmKN36rYkMvzeo5n9GQguG9eH7C+o4pDO2K7EBRjRDZKzKej6EnXG
 Qr/Yg4uq8S97+eem9SqzXjWcfBJa0uY3EJjWygd8kKq/rYFdU6DmtJCcl+lvc0aWeT7qDZHjl++
 +LxiVuWDP/eVlL0cFa26zjnAfDtEIOIj2npvhXT990URVd6V+l1MDXBrQzA==
X-Received: by 2002:a05:6a20:a128:b0:3fb:1640:c525 with SMTP id
 adf61e73a8af0-3fb1640d2c7mr6283551637.67.1794908405222; 
 Tue, 17 Nov 2026 01:40:05 -0800 (PST)
X-Received: by 2002:a05:6a20:a128:b0:3fb:1640:c525 with SMTP id
 adf61e73a8af0-3fb1640d2c7mr6283529637.67.1794908404621; 
 Tue, 17 Nov 2026 01:40:04 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc160bfabsm5299078a12.4.2026.11.17.01.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 01:40:04 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 15:09:47 +0530
Subject: [PATCH v4 3/3] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-interrupted-invoke-v4-v4-3-2320a8a7eda2@oss.qualcomm.com>
References: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
In-Reply-To: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzOCBTYWx0ZWRfX6ob2l/zrQpPV
 RXdD6yCyJ5z77DQzE2jhohkYcMmt+Ce7TdzObD7ABPSyDUvebaZ5rx8JhOvivpv0BuvYGnqG+j0
 kX0g2BZTeNM4cGsbuLcjxvsLcb5yI+8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzOCBTYWx0ZWRfX24jvxHf+FxZM
 TxZ1eHdJdx0FwJFHFdMLcDJ45iGPBct09h/ZyoNXgBMHkqgfznj8BNbcHdMaY6tPVFPGHZ82BsL
 xuwFCxMJvn4qD+e1ufA/rZg2+6hdM7g9C6rGf5f/LGhInY78kgUBIkLcX5h2WKdJpGE14S2urFG
 fny5dK1jejT/IpTP0zkRyUj9/tUSO/n4qrVo1PfmCRToyhoblq6aKwt9L3Af5ME5IveYwa4jM/k
 I5lzA14JHK5qhu3TnNdVgKFeH77giEg2Gn+mTlwPyt8yapeh/K9SToJQQkLSvfOrwSCngV+ZiOX
 Z1nGXW+cq7dW7bttV829CXDkzatTXoDn4a+hFSxr4EMpaNG2ArrMFhyI5VUPVtZimYRXjrJ8/8s
 8yAi/M1GVBcPIj1rVGGAYIH9BqtugZgdrTpktokibKP/cdE45t/xPMKYV3lNpF8WUlm3/tgKLbs
 C/4p0lPRwpLS0gakr2A==
X-Proofpoint-GUID: ShXj4kDI_YyuhH7yvv5QCqlqn3Ywo_JO
X-Proofpoint-ORIG-GUID: ShXj4kDI_YyuhH7yvv5QCqlqn3Ywo_JO
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afc20f6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RNeuuNIWPYGONN0YOXQA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170038
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fastrpc invokes work by sending an RPC message to the DSP and blocking
in wait_for_completion_interruptible() until the DSP responds. If a
signal arrives during this wait, the syscall returns -ERESTARTSYS and
the invoke context, which holds the in-flight DMA buffers and
completion state, is left stranded in fl->pending.

On the next syscall attempt (either auto-restarted by the kernel via
SA_RESTART or manually retried by user-space after EINTR), a fresh
context is allocated and the RPC message is re-sent to the DSP. This
has two consequences:

 - The original context leaks in fl->pending until the file is closed.
 - The DSP receives a duplicate invocation. If the DSP was mid-way
   through processing the first request and had issued a reverse RPC
   call back to the host, the retry sends a new forward request
   instead of the expected reverse-RPC response. The DSP thread
   waiting for that response is never woken, causing a hang.

Fix this by saving the interrupted context to a new fl->interrupted
list on -ERESTARTSYS, instead of freeing it or leaving it on
fl->pending. The context keeps the same reference it already held;
only list membership changes, so the refcount stays symmetric no
matter how many times a context is interrupted and retried. When the
same thread retries with a matching handle and sc, the context is
pulled back onto fl->pending and the call jumps straight to the wait,
skipping context allocation and message re-send. A mismatched
handle/sc falls through to a normal fresh allocation, so a thread
that issues a different call after an interrupted one is never
wedged.

A context on fl->interrupted can be matched and reclaimed by
fastrpc_context_restore_interrupted() on a retry while a concurrent
kref_put() from an unrelated drain (SSR, fd close, or a delayed DSP
response) has already dropped its refcount to zero and is waiting on
fl->lock to unlink it in fastrpc_context_free(). Without a check, the
retry can win that lock race, hand back a context already committed
to being freed, and use it after the other side frees it.
kref_get_unless_zero() closes the window: it fails if the refcount is
already zero, so the retry falls through to a fresh allocation
instead of resurrecting a dying context.

Distinguish an interruption of the send itself (rpmsg_send() returning
-ERESTARTSYS before the message ever reaches the DSP) from an
interruption of the wait that follows a successful send: only the
latter is safe to park and resume without resending, since nothing is
actually in flight in the former case. Rather than track this with an
extra flag, give the two failure sites their own cleanup instead of
funnelling both into the same bail: label.

ctx->args is now owned by the context (copied at alloc time) and
freed exactly once by fastrpc_context_free(), rather than aliasing the
caller's array, which could otherwise be freed or reused by the time
a parked context is eventually drained.

A context parked on fl->interrupted is reachable from a resumed retry,
process exit and SSR all at once. fastrpc_context_free() now removes
it from whichever list it is on before releasing its resources, using
list_del_init() (plain list_del() poisons the node, which would
otherwise break this same check if the context is freed via a race
with one of the other drains). Because the DSP response worker
(fastrpc_rpmsg_callback()) and the exit/SSR/fd-close paths can all end
up scheduling the same ctx->put_work for a parked context, a
put_work_scheduled flag checked and set under fl->lock ensures only
one of them actually queues it.

fastrpc_device_release() now also drains fl->interrupted, completing
any parked context with -EPIPE and dropping the invoker's reference,
so a context stuck there at fd close cannot leak it. It cannot drop
the worker reference unconditionally, though: the DSP may still be
using that context's buffers if it hasn't answered yet, and freeing
them under it would be unsafe. fastrpc_release_current_dsp_process(),
already called at the top of fastrpc_device_release(), tells the DSP
to tear down the whole process; if that succeeds, the DSP is known to
be done with everything for this process, so the worker reference is
dropped too. If it doesn't succeed, the context is left exactly where
a real response or a future SSR would still find it: still linked on
fl->interrupted, and fl is left on cctx->users (the unlink moves from
fastrpc_device_release() into fastrpc_user_free(), which only runs
once fl truly has no references left) so fastrpc_notify_users() can
still walk down to it later.

The same unreachable-orphan problem exists for a timed-out kernel
invoke (-ETIMEDOUT, only possible when kernel=true): the bail: path
used to unconditionally unlink the context from fl->pending before
dropping its reference, even though the DSP may still answer later.
Leave it linked on fl->pending in that case instead, so
fastrpc_notify_users() can still find and release it if the channel
is torn down before that answer arrives.

Remove the obsolete invoke_interrupted_mmaps mechanism from
fastrpc_channel_ctx; context resources are now kept alive through the
context refcount rather than by migrating mmaps to a channel-level
list.

Fixes: 387f625585d1 ("misc: fastrpc: handle interrupted contexts")
Cc: stable@kernel.org
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 188 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 146 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c5c3679f87..dd4d3c88e9 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -268,6 +268,7 @@ struct fastrpc_invoke_ctx {
 	int pid;
 	int client_id;
 	u32 sc;
+	u32 handle;
 	u64 *fdlist;
 	u32 *crc;
 	/* Poll memory that DSP updates */
@@ -278,6 +279,8 @@ struct fastrpc_invoke_ctx {
 	bool is_work_done;
 	/* process updates poll memory instead of glink response */
 	bool is_polled;
+	/* set once put_work has been scheduled for this ctx, guarded by fl->lock */
+	bool put_work_scheduled;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -329,7 +332,6 @@ struct fastrpc_channel_ctx {
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
-	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
 	bool poll_mode_supported;
@@ -349,6 +351,7 @@ struct fastrpc_user {
 	struct list_head user;
 	struct list_head maps;
 	struct list_head pending;
+	struct list_head interrupted;
 	struct list_head mmaps;
 
 	struct fastrpc_channel_ctx *cctx;
@@ -568,8 +571,15 @@ static void fastrpc_context_put(struct fastrpc_invoke_ctx *ctx);
 static void fastrpc_user_free(struct kref *ref)
 {
 	struct fastrpc_user *fl = container_of(ref, struct fastrpc_user, refcount);
+	struct fastrpc_channel_ctx *cctx = fl->cctx;
 	struct fastrpc_map *map, *m;
 	struct fastrpc_buf *buf, *b;
+	unsigned long flags;
+
+	/* fl stays on cctx->users until this point, so an SSR before fd close can still find it. */
+	spin_lock_irqsave(&cctx->lock, flags);
+	list_del(&fl->user);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	fastrpc_buf_free(fl->init_mem);
 
@@ -581,7 +591,7 @@ static void fastrpc_user_free(struct kref *ref)
 		fastrpc_buf_free(buf);
 	}
 
-	fastrpc_channel_ctx_put(fl->cctx);
+	fastrpc_channel_ctx_put(cctx);
 	mutex_destroy(&fl->mutex);
 	kfree(fl);
 }
@@ -608,6 +618,12 @@ static void fastrpc_context_free(struct kref *ref)
 	cctx = ctx->cctx;
 	fl = ctx->fl;
 
+	/* list_del_init(), not list_del(): a concurrent drain may still check list_empty(). */
+	spin_lock(&fl->lock);
+	if (!list_empty(&ctx->node))
+		list_del_init(&ctx->node);
+	spin_unlock(&fl->lock);
+
 	for (i = 0; i < ctx->nbufs; i++)
 		fastrpc_map_put(ctx->maps[i]);
 
@@ -619,6 +635,7 @@ static void fastrpc_context_free(struct kref *ref)
 
 	kfree(ctx->maps);
 	kfree(ctx->olaps);
+	kfree(ctx->args);
 	kfree(ctx);
 
 	/* Release the reference taken in fastrpc_context_alloc() */
@@ -644,6 +661,54 @@ static void fastrpc_context_put_wq(struct work_struct *work)
 	fastrpc_context_put(ctx);
 }
 
+/* Schedules put_work at most once per ctx; racing callers may both try. */
+static void fastrpc_context_schedule_put_work(struct fastrpc_invoke_ctx *ctx)
+{
+	bool do_schedule;
+
+	spin_lock(&ctx->fl->lock);
+	do_schedule = !ctx->put_work_scheduled;
+	ctx->put_work_scheduled = true;
+	spin_unlock(&ctx->fl->lock);
+
+	if (do_schedule)
+		schedule_work(&ctx->put_work);
+}
+
+/* References held by ctx are left intact; only list membership changes. */
+static void fastrpc_context_save_interrupted(struct fastrpc_invoke_ctx *ctx)
+{
+	spin_lock(&ctx->fl->lock);
+	list_move_tail(&ctx->node, &ctx->fl->interrupted);
+	spin_unlock(&ctx->fl->lock);
+}
+
+/* Matches on handle+sc, not sc alone, to avoid resuming an unrelated call. */
+static struct fastrpc_invoke_ctx *fastrpc_context_restore_interrupted(struct fastrpc_user *fl,
+								      u32 handle, u32 sc)
+{
+	struct fastrpc_invoke_ctx *ctx = NULL, *ictx;
+
+	spin_lock(&fl->lock);
+	list_for_each_entry(ictx, &fl->interrupted, node) {
+		if (ictx->pid == current->pid && ictx->handle == handle &&
+		    ictx->sc == sc) {
+			/* May already be mid-teardown; don't resurrect it. */
+			if (kref_get_unless_zero(&ictx->refcount)) {
+				ctx = ictx;
+				list_move_tail(&ctx->node, &fl->pending);
+			}
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+
+	if (ctx)
+		fastrpc_context_put(ctx);
+
+	return ctx;
+}
+
 #define CMP(aa, bb) ((aa) == (bb) ? 0 : (aa) < (bb) ? -1 : 1)
 static int olaps_cmp(const void *a, const void *b)
 {
@@ -694,7 +759,7 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 }
 
 static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
-			struct fastrpc_user *user, u32 kernel, u32 sc,
+			struct fastrpc_user *user, u32 kernel, u32 handle, u32 sc,
 			struct fastrpc_invoke_args *args)
 {
 	struct fastrpc_channel_ctx *cctx = user->cctx;
@@ -724,7 +789,15 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			kfree(ctx);
 			return ERR_PTR(-ENOMEM);
 		}
-		ctx->args = args;
+		/* Own copy: ctx may outlive the caller's args if parked on fl->interrupted. */
+		ctx->args = kzalloc_objs(*ctx->args, ctx->nscalars);
+		if (!ctx->args) {
+			kfree(ctx->olaps);
+			kfree(ctx->maps);
+			kfree(ctx);
+			return ERR_PTR(-ENOMEM);
+		}
+		memcpy(ctx->args, args, ctx->nscalars * sizeof(*args));
 		fastrpc_get_buff_overlaps(ctx);
 	}
 
@@ -734,6 +807,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	fastrpc_user_get(user);
 
 	ctx->sc = sc;
+	ctx->handle = handle;
 	ctx->retval = -1;
 	ctx->pid = current->pid;
 	ctx->client_id = user->client_id;
@@ -768,6 +842,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	fastrpc_channel_ctx_put(cctx);
 	kfree(ctx->maps);
 	kfree(ctx->olaps);
+	kfree(ctx->args);
 	kfree(ctx);
 
 	return ERR_PTR(ret);
@@ -1358,8 +1433,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   struct fastrpc_invoke_args *args)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
-	struct fastrpc_buf *buf, *b;
-
 	int err = 0;
 
 	if (!fl->sctx)
@@ -1373,7 +1446,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		return -EPERM;
 	}
 
-	ctx = fastrpc_context_alloc(fl, kernel, sc, args);
+	/* Resume an interrupted invoke instead of resending to the DSP. */
+	if (!kernel)
+		ctx = fastrpc_context_restore_interrupted(fl, handle, sc);
+	if (ctx)
+		goto wait;
+
+	ctx = fastrpc_context_alloc(fl, kernel, handle, sc, args);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
@@ -1385,8 +1464,15 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	dma_wmb();
 	/* Send invoke buffer to remote dsp */
 	err = fastrpc_invoke_send(fl->sctx, ctx, kernel, handle);
-	if (err)
-		goto bail;
+	if (err) {
+		/* Never sent, so not safe to park and resume like bail: does. */
+		spin_lock(&fl->lock);
+		list_del_init(&ctx->node);
+		spin_unlock(&fl->lock);
+		fastrpc_context_put(ctx);
+		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
+		return err;
+	}
 
 	/*
 	 * Set message context as polled if the call is for a user PD
@@ -1395,7 +1481,16 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (handle > FASTRPC_MAX_STATIC_HANDLE && fl->pd == USER_PD && fl->poll_mode)
 		ctx->is_polled = true;
 
+wait:
 	err = fastrpc_wait_for_completion(ctx, kernel);
+	if (err == -ETIMEDOUT)
+		dev_warn(fl->sctx->dev,
+			 "fastrpc_invoke: TIMEOUT ctxid=0x%llx handle=0x%x nscalars=%d\n",
+			 ctx->ctxid, handle, ctx->nscalars);
+	else if (err == -ERESTARTSYS)
+		dev_dbg(fl->sctx->dev,
+			"fastrpc_invoke: INTERRUPTED ctxid=0x%llx handle=0x%x nscalars=%d\n",
+			ctx->ctxid, handle, ctx->nscalars);
 	if (err)
 		goto bail;
 
@@ -1412,21 +1507,16 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		goto bail;
 
 bail:
-	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
-		/* We are done with this compute context */
-		spin_lock(&fl->lock);
-		list_del(&ctx->node);
-		spin_unlock(&fl->lock);
-		fastrpc_context_put(ctx);
-	}
-
 	if (err == -ERESTARTSYS) {
+		fastrpc_context_save_interrupted(ctx);
+	} else if (err == -ETIMEDOUT) {
+		/* Leave linked: a late DSP answer or notify_users() still needs to reach it. */
+		fastrpc_context_put(ctx);
+	} else {
 		spin_lock(&fl->lock);
-		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
-			list_del(&buf->node);
-			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
-		}
+		list_del_init(&ctx->node);
 		spin_unlock(&fl->lock);
+		fastrpc_context_put(ctx);
 	}
 
 	if (err)
@@ -1728,13 +1818,28 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx = fl->cctx;
-	unsigned long flags;
+	struct fastrpc_invoke_ctx *ctx, *n;
+	int release_err;
 
-	fastrpc_release_current_dsp_process(fl);
+	release_err = fastrpc_release_current_dsp_process(fl);
 
-	spin_lock_irqsave(&cctx->lock, flags);
-	list_del(&fl->user);
-	spin_unlock_irqrestore(&cctx->lock, flags);
+	/*
+	 * Drop the invoker ref unconditionally: no retry can arrive once the
+	 * fd is closed. Drop the worker ref only if the DSP confirmed it is
+	 * done with the process; otherwise leave ctx linked so a real answer
+	 * or a later SSR can still release it.
+	 */
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(ctx, n, &fl->interrupted, node) {
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+		spin_unlock(&fl->lock);
+		if (!release_err)
+			fastrpc_context_schedule_put_work(ctx);
+		fastrpc_context_put(ctx);
+		spin_lock(&fl->lock);
+	}
+	spin_unlock(&fl->lock);
 
 	fastrpc_session_free(cctx, fl->sctx);
 	file->private_data = NULL;
@@ -1765,6 +1870,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	spin_lock_init(&fl->lock);
 	mutex_init(&fl->mutex);
 	INIT_LIST_HEAD(&fl->pending);
+	INIT_LIST_HEAD(&fl->interrupted);
 	INIT_LIST_HEAD(&fl->maps);
 	INIT_LIST_HEAD(&fl->mmaps);
 	INIT_LIST_HEAD(&fl->user);
@@ -2784,7 +2890,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
-	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2835,13 +2940,16 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 	list_for_each_entry(ctx, &user->pending, node) {
 		ctx->retval = -EPIPE;
 		complete(&ctx->work);
-		/*
-		 * fastrpc_invoke_send() took a second reference for the
-		 * DSP response that will now never arrive since the
-		 * channel is gone; schedule the matching put the same
-		 * way a real response would via fastrpc_rpmsg_callback().
-		 */
-		schedule_work(&ctx->put_work);
+		fastrpc_context_schedule_put_work(ctx);
+	}
+	/*
+	 * Invoker ref for a parked context is released by fastrpc_user_free()
+	 * or fastrpc_device_release(); this only drops the worker ref.
+	 */
+	list_for_each_entry(ctx, &user->interrupted, node) {
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+		fastrpc_context_schedule_put_work(ctx);
 	}
 	spin_unlock(&user->lock);
 }
@@ -2849,7 +2957,6 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
-	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
@@ -2866,9 +2973,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
-	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
-		list_del(&buf->node);
-
 	fastrpc_remote_heap_release(cctx, rpdev);
 
 	fastrpc_cb_devices_destroy(rpdev);
@@ -2932,11 +3036,11 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	complete(&ctx->work);
 
 	/*
-	 * The DMA buffer associated with the context cannot be freed in
-	 * interrupt context so schedule it through a worker thread to
-	 * avoid a kernel BUG.
+	 * Can't free the DMA buffer in interrupt context; defer to a
+	 * worker. Guarded: notify_users()/device_release() may also be
+	 * racing to schedule this for the same ctx.
 	 */
-	schedule_work(&ctx->put_work);
+	fastrpc_context_schedule_put_work(ctx);
 
 	return 0;
 }

-- 
2.34.1

