Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C80CCA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5286E10E175;
	Thu,  1 Oct 2026 19:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MYzwVYGe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fMznbLY6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7495210E175
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:45:42 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691HV6In2354096
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 19:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=imlkCdVK4y8CefNk7xQGek
 nG/13MHXsaNLitlWMDIwU=; b=MYzwVYGevCsiKgbFFlFXBVQ5tMGsJ1mmIsUGQg
 r+W3KkX9KNgp7r+nEwpav1fAbGhlBtfBjNWIBx0xRV4J/i3uBdlrhDfcJpuVkf5J
 K9orwcXx6o+/x6HD8KG9x8lmLo7tHZ+11VDODjMhd8EAFH05OZvahzTnz/aha5+0
 x98402QfG7UTWlgto2k6djs9kst6QV4DWEEp5L41Ysm2XMgTUI8BM6Jj6QxJa6jJ
 t6UV4jAzlr/FpZVXK7P8FhLbs4YsM7yi9YIQ7d2pAjeoGKSWl24HCTBwBfztXB1E
 ay9WuNM+dIYFh/aJNnIt/u1kRm2nAW3eDcz/JChi0O3TJiSA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1v030k6j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 19:45:41 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1416f32fe11so7493817c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790883940; x=1791488740;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=imlkCdVK4y8CefNk7xQGeknG/13MHXsaNLitlWMDIwU=;
 b=fMznbLY6CaxdrIzmTqZLeqT8w3lAOmQO8jAfpMTS0+L3N96kMCWbQ77qFiBFyA5VC+
 3O9tSzAv7sSwrMHo9nHAJkx0Lkubc2Q8fmR4b2vj1NV89X1ZhFOmMfjhtyaxopeGI1Qc
 FsmDplkk7eVZHBbBQk8UmHHKiP/NwQBpj+1o0e5ii+TPJ8MAYUpBdMfHWhZOP4oBUsWP
 tgrT5qdiJgmJyku2jhskT7xlucoRh8rw2TsbrUYrhyGWZAIofmHXchg2ZYxV+b7itcAo
 RLKw6KQfV8Wylj15MBvEvJLUhQEAkTH3kshDXPBiy+aGqhQsvnJLDIOqsOIrCaCAZm6d
 QpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790883940; x=1791488740;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=imlkCdVK4y8CefNk7xQGeknG/13MHXsaNLitlWMDIwU=;
 b=NisNFNFsp2lrF5FDQvfdJ0hFTvUIBUSATWHVIldIRTwfPYYZgHnmO9UWxVpycmgQro
 JnkhQ4Y3s5yQO6EQOiMix9lsSKbuXMrWyCO7TElP5IbEfisNINVvAVM6ulnFK4UKo/BJ
 yMM342B0P3egU+MyGHlygECASzAVlC3kxQMp3QNFvD6K2Eik48TN/uE/SZ9vEGoFwfJj
 RcyZyT0kk6aXS8bf0jpuoMTC/5eSnciDSxoA3t487n2DmCFFwtf0qP0oK96tHxqk/G2q
 To4arZA0WbkwH3Txl9YnOzmZTa8qWiecr+SwIT6dezgE7d3O400209vkT4jHYiNcnvHB
 QUDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEL/ibRx04fNkF/KVt93tlTS3EZC48S++a3h0lRPpL/x3x7A96d6xDEn/dTEH30sNJnp2H0hQlniI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nZn/u2gmrJMwf8mcc/3ODA4tV2z/tMHI3NAG/4SMYzLNP6O+3f
 fu/2cPnqyYJv6OhoZ31DnR49KqcZNXikQP+eZa3i7J5zgymWbBrslVCie2hh9zzsV/SfWm6p3Kv
 qQZBXYzYHkKVohjkZ487f6J6HT5yudsmosjsFA4EvobMipyfWTK/fS9BXm16h+Y1oFQUkAoI=
X-Gm-Gg: AYBFou0mwLZj1k+9/Z+25kDzYXIhUcenQYibByFhQsRa7oBx8Xct3dW78Ofbs1WcUdF
 9bOJy3ku+mFm1n1mT3T3iXBv116Hcj7yygTskCbUHfOdMYK+iiHKuFKt+iZlaMUUyF0W/poP9vr
 yq/FHN95i+67DoF+GyitYsqZM+h4p4xnXgOMatm78HnXx/8r9yIO0+VNNSeovkQdqQgvp3mpSHS
 mKkIwCkh2CSve4ZI95vcT3usS5vbSEe3q5o3Mw6Lw/ibbUJuF4w9ljWSiZh9qx1iAi+Udh7xiLK
 xcwIOlGYHSvXFgoudiiR0sb/ZdhAj9JElMjn62Fv075Qj5OgjhFV6LUjoEAvMeN7Adefg9Q7+Z/
 3UWJfl91ybw==
X-Received: by 2002:a05:7022:e09:b0:144:fb31:a597 with SMTP id
 a92af1059eb24-14f5cdc4149mr217911c88.47.1790883939661; 
 Thu, 01 Oct 2026 12:45:39 -0700 (PDT)
X-Received: by 2002:a05:7022:e09:b0:144:fb31:a597 with SMTP id
 a92af1059eb24-14f5cdc4149mr217858c88.47.1790883938701; 
 Thu, 01 Oct 2026 12:45:38 -0700 (PDT)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f45fedd43sm1210900c88.4.2026.10.01.12.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:45:37 -0700 (PDT)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Fri, 02 Oct 2026 01:15:30 +0530
Subject: [PATCH v3] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-anandu-fastrpc-interrupted-invoke-v3-v3-1-31e90439d2ba@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFm4vmoC/yXNywrCMBCF4Vcps3YgaYKgryIu0mSio5CGyYVC6
 bsbdXe+zX92KCRMBa7TDkKdC69pwJwm8E+XHoQchmFW81ldjEKXXAoNoytVskdOlURarhTG7uu
 bsBvUatFGeWtt1DBSWSjy9ru53f8ubXmRr982HMcHIgdA/IgAAAA=
X-Change-ID: 20260930-anandu-fastrpc-interrupted-invoke-v3-10b130c444f1
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3OCBTYWx0ZWRfX2sMjzAikXUxr
 Ku6rEBPH8Skxs50z9hQ+FDzpmKrZJp/DN8Q+QyDU0ReZG5UxvBdNVUNP1SU+A4XpbomwURWTCkh
 usOx0U3JnQop6gv2SH8HR6Zd98++U4E=
X-Authority-Analysis: v=2.4 cv=GqfXaU1C c=1 sm=1 tr=0 ts=6abeb865 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p835DqasiJLdI_LsOtQA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: _aAoTxU5wqzlTX4lzSdXwtJpgvv4xDut
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3OCBTYWx0ZWRfXwyxV3b3NeX75
 3pKAuM19QVqkijC0FsnYyQKb/ISkELsETGFGW2bGihK+DNjFf36o1TsABQncOKs3244GyDL7zst
 mZhdy0lNqbOTWVTJrdDVIMmD/0LcHMmVfrHWMPTthBJfpLO6QXVbhEYg78XjjbhEUrhvpTWky6u
 0X9t1KyKzVwTZrnvEpfLd5kYmFBTmmquDi08eL3wWoCx5l1LgXvwBm4nUzx4oJdcVei5VpSmwf2
 93Kl9BhSZebF2pwJdIP/GAtVxzc7iaGyLZFJ74RUKLLBmP9M2HSB9bwWVyTDB0gna9KizGzyTeX
 /71mm5xxZuSFadmc1fT+VyvMbyY1ernSVyGYnkohz3FGzwO3DfV66lgVXDHD2cwH5597b7WLwmf
 9p0U4/LRqVJ8l47aSrJ+XiJOU60I82SravDW4fyhD4eDLGaBx0NkkW69srHvZkeYd0JWPR01Cpc
 T++Tw61hsSL56pab6Vw==
X-Proofpoint-ORIG-GUID: _aAoTxU5wqzlTX4lzSdXwtJpgvv4xDut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010078
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

fastrpc invokes work by sending an RPC message to the DSP and blocking
in wait_for_completion_interruptible() until the DSP responds. If a
signal arrives during this wait, the syscall returns -ERESTARTSYS and
the invoke context which holds the in-flight DMA buffers and
completion state is left stranded in fl->pending.

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
same thread retries the invoke with a matching handle and sc, the
context is pulled back onto fl->pending and the call jumps straight
to the wait, skipping context allocation and message re-send. Any
retry whose handle/sc does not match a parked context simply falls
through to a normal fresh allocation, so a thread that goes on to
issue a different call after an interrupted one is never wedged.
ctx->args is repointed at the retry's own args on resume so DSP output
lands in the current call's buffers rather than the original,
already-freed ones; fastrpc_context_alloc() now also takes its own
copy of args up front, so ctx->args is always owned by the context and
is freed exactly once, by fastrpc_context_free(), regardless of
whether the context completes normally, is resumed after an
interruption, or is drained unresumed.

A context parked on fl->interrupted is reachable from three places
that can run concurrently: a resumed retry, process exit, and SSR via
rpmsg channel removal/notify. fastrpc_context_free() now removes the
context from whichever list it is on before releasing its resources,
using list_del_init() (plain list_del() poisons the node, which would
otherwise break this same check if the context is freed via a race
with one of the exit/SSR drains). fastrpc_device_release() and
fastrpc_rpmsg_remove()'s fastrpc_notify_users() both drain
fl->interrupted, completing any parked context with -EPIPE and
dropping the invoker's reference, so a context stuck there at fd close
or channel teardown cannot leak the context -- or, in the fd-close
case, fl itself, since fl's own reference is held via the context
until this drain releases it. Because the DSP response worker
(fastrpc_rpmsg_callback()) and the exit/SSR path can both end up
scheduling the same ctx->put_work for a parked context, a
put_work_scheduled flag checked and set under fl->lock ensures only
one of them actually queues it.

The -ETIMEDOUT path is also brought in line with normal cleanup: it
used to be exempted from the bail-path list_del()/context_put(),
leaking the context on every kernel-invocation timeout.

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
This patch fixes a context leak and DSP hang that occur when a
fastrpc invoke syscall is interrupted by a signal, along with seven
follow-on bugs found during review and self-review.

Changes in v3:
- fastrpc_context_save_interrupted() no longer drops a reference when
  parking the context, fixing a kref double-put that left the context
  under-refcounted.
- Restoring an interrupted context now matches on both handle and sc,
  not sc alone, so a stale/differently-shaped retry cannot be handed a
  buffer layout it didn't allocate.
- A mismatched handle/sc on retry now falls through to allocating a
  fresh context instead of returning -EINVAL, so a thread issuing a
  different call after an interrupted one is never permanently
  wedged.
- Added a put_work_scheduled flag, checked and set under fl->lock, to
  guard against fastrpc_notify_users() and fastrpc_rpmsg_callback()
  both scheduling put_work for the same context.
- fastrpc_device_release() now drains fl->interrupted and drops the
  invoker's reference on each parked context before releasing its own
  reference on fl, fixing a leak of both fl and the context if the fd
  is closed while a context is still parked.
- fastrpc_device_release()'s and fastrpc_user_free()'s drain loops now
  use list_del_init() instead of list_del(), avoiding a poisoned-node
  list_empty() check in fastrpc_context_free().
- fastrpc_invoke_send() can return -ERESTARTSYS from rpmsg_send()
  itself before the message is ever delivered to the DSP. This is now
  distinguished with a `sent` flag so only a completion-wait
  interruption after a successful send is parked as resumable.
- ctx->args is now repointed at the retry's args on resume instead of
  pointing at the original call's already-freed buffers; an
  args_owned flag lets fastrpc_context_free() free ctx->args if a
  parked context is drained/abandoned without ever being resumed.

Link to v2: https://lore.kernel.org/all/805d5de8-477c-41e9-b192-d889d1cca9b6@oss.qualcomm.com/
Link to v1: https://lore.kernel.org/all/20260525124222.3082420-1-anandu.e@oss.qualcomm.com/
---
 drivers/misc/fastrpc.c | 157 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 129 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5ac7b3e78ba7..f51cb772e683 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -261,6 +261,7 @@ struct fastrpc_invoke_ctx {
 	int pid;
 	int client_id;
 	u32 sc;
+	u32 handle;
 	u64 *fdlist;
 	u32 *crc;
 	/* Poll memory that DSP updates */
@@ -271,6 +272,8 @@ struct fastrpc_invoke_ctx {
 	bool is_work_done;
 	/* process updates poll memory instead of glink response */
 	bool is_polled;
+	/* set once put_work has been scheduled for this ctx, guarded by fl->lock */
+	bool put_work_scheduled;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -320,7 +323,6 @@ struct fastrpc_channel_ctx {
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
-	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
 	bool poll_mode_supported;
@@ -340,6 +342,7 @@ struct fastrpc_user {
 	struct list_head user;
 	struct list_head maps;
 	struct list_head pending;
+	struct list_head interrupted;
 	struct list_head mmaps;
 
 	struct fastrpc_channel_ctx *cctx;
@@ -566,7 +569,12 @@ static void fastrpc_user_free(struct kref *ref)
 	fastrpc_buf_free(fl->init_mem);
 
 	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
-		list_del(&ctx->node);
+		list_del_init(&ctx->node);
+		fastrpc_context_put(ctx);
+	}
+
+	list_for_each_entry_safe(ctx, n, &fl->interrupted, node) {
+		list_del_init(&ctx->node);
 		fastrpc_context_put(ctx);
 	}
 
@@ -605,6 +613,11 @@ static void fastrpc_context_free(struct kref *ref)
 	cctx = ctx->cctx;
 	fl = ctx->fl;
 
+	spin_lock(&fl->lock);
+	if (!list_empty(&ctx->node))
+		list_del_init(&ctx->node);
+	spin_unlock(&fl->lock);
+
 	for (i = 0; i < ctx->nbufs; i++)
 		fastrpc_map_put(ctx->maps[i]);
 
@@ -616,6 +629,7 @@ static void fastrpc_context_free(struct kref *ref)
 
 	kfree(ctx->maps);
 	kfree(ctx->olaps);
+	kfree(ctx->args);
 	kfree(ctx);
 
 	/* Release the reference taken in fastrpc_context_alloc() */
@@ -641,6 +655,50 @@ static void fastrpc_context_put_wq(struct work_struct *work)
 	fastrpc_context_put(ctx);
 }
 
+/* Ensures put_work is scheduled at most once per ctx; racing callers may both try. */
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
+/* References taken for ctx are left intact; ownership just moves between lists. */
+static void fastrpc_context_save_interrupted(struct fastrpc_invoke_ctx *ctx)
+{
+	spin_lock(&ctx->fl->lock);
+	list_del(&ctx->node);
+	list_add_tail(&ctx->node, &ctx->fl->interrupted);
+	spin_unlock(&ctx->fl->lock);
+}
+
+/* Matches on handle+sc, not sc alone, to avoid resuming an unrelated call. */
+static struct fastrpc_invoke_ctx *fastrpc_context_restore_interrupted(
+			struct fastrpc_user *fl, u32 handle, u32 sc)
+{
+	struct fastrpc_invoke_ctx *ctx = NULL, *ictx;
+
+	spin_lock(&fl->lock);
+	list_for_each_entry(ictx, &fl->interrupted, node) {
+		if (ictx->pid == current->pid && ictx->handle == handle &&
+		    ictx->sc == sc) {
+			ctx = ictx;
+			list_del(&ctx->node);
+			list_add_tail(&ctx->node, &fl->pending);
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+
+	return ctx;
+}
+
 #define CMP(aa, bb) ((aa) == (bb) ? 0 : (aa) < (bb) ? -1 : 1)
 static int olaps_cmp(const void *a, const void *b)
 {
@@ -721,7 +779,15 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
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
 
@@ -765,6 +831,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	fastrpc_channel_ctx_put(cctx);
 	kfree(ctx->maps);
 	kfree(ctx->olaps);
+	kfree(ctx->args);
 	kfree(ctx);
 
 	return ERR_PTR(ret);
@@ -1325,10 +1392,18 @@ static inline int fastrpc_wait_for_response(struct fastrpc_invoke_ctx *ctx,
 	int err = 0;
 
 	if (kernel) {
-		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
+		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ)) {
 			err = -ETIMEDOUT;
+			dev_warn(ctx->fl->sctx->dev,
+				 "fastrpc_invoke: TIMEOUT ctxid=0x%llx handle=0x%x nscalars=%d\n",
+				 ctx->ctxid, ctx->handle, ctx->nscalars);
+		}
 	} else {
 		err = wait_for_completion_interruptible(&ctx->work);
+		if (err == -ERESTARTSYS)
+			dev_warn(ctx->fl->sctx->dev,
+				 "fastrpc_invoke: INTERRUPTED ctxid=0x%llx handle=0x%x nscalars=%d\n",
+				 ctx->ctxid, ctx->handle, ctx->nscalars);
 	}
 
 	return err;
@@ -1355,8 +1430,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   struct fastrpc_invoke_args *args)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
-	struct fastrpc_buf *buf, *b;
-
+	bool resumed = false;
 	int err = 0;
 
 	if (!fl->sctx)
@@ -1370,9 +1444,21 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		return -EPERM;
 	}
 
-	ctx = fastrpc_context_alloc(fl, kernel, sc, args);
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
+	if (!kernel)
+		ctx = fastrpc_context_restore_interrupted(fl, handle, sc);
+
+	if (ctx) {
+		/* ctx->args is already populated from before the interruption. */
+		resumed = true;
+	} else {
+		ctx = fastrpc_context_alloc(fl, kernel, sc, args);
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
+		ctx->handle = handle;
+	}
+
+	if (resumed)
+		goto wait;
 
 	err = fastrpc_get_args(kernel, ctx);
 	if (err)
@@ -1392,6 +1478,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (handle > FASTRPC_MAX_STATIC_HANDLE && fl->pd == USER_PD && fl->poll_mode)
 		ctx->is_polled = true;
 
+wait:
 	err = fastrpc_wait_for_completion(ctx, kernel);
 	if (err)
 		goto bail;
@@ -1409,21 +1496,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
@@ -1725,6 +1804,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx = fl->cctx;
+	struct fastrpc_invoke_ctx *ctx, *n;
 	unsigned long flags;
 
 	fastrpc_release_current_dsp_process(fl);
@@ -1733,6 +1813,18 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	list_del(&fl->user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
+	/* fl is already unlinked from cctx->users; drop the invoker's ref so it isn't leaked. */
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(ctx, n, &fl->interrupted, node) {
+		list_del_init(&ctx->node);
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+		spin_unlock(&fl->lock);
+		fastrpc_context_put(ctx);
+		spin_lock(&fl->lock);
+	}
+	spin_unlock(&fl->lock);
+
 	fastrpc_session_free(cctx, fl->sctx);
 	file->private_data = NULL;
 	/* Release the reference taken in fastrpc_device_open */
@@ -1762,6 +1854,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	spin_lock_init(&fl->lock);
 	mutex_init(&fl->mutex);
 	INIT_LIST_HEAD(&fl->pending);
+	INIT_LIST_HEAD(&fl->interrupted);
 	INIT_LIST_HEAD(&fl->maps);
 	INIT_LIST_HEAD(&fl->mmaps);
 	INIT_LIST_HEAD(&fl->user);
@@ -1871,6 +1964,7 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	}
 
 	err = fastrpc_internal_invoke(fl, false, inv.handle, inv.sc, args);
+	/* ctx keeps its own copy of args, so this is always safe to free. */
 	kfree(args);
 
 	return err;
@@ -2636,7 +2730,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
-	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2669,13 +2762,22 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 		ctx->retval = -EPIPE;
 		complete(&ctx->work);
 	}
+
+	/* Drops only the worker ref; the invoker ref is released by fastrpc_user_free(). */
+	list_for_each_entry(ctx, &user->interrupted, node) {
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+		if (!ctx->put_work_scheduled) {
+			ctx->put_work_scheduled = true;
+			schedule_work(&ctx->put_work);
+		}
+	}
 	spin_unlock(&user->lock);
 }
 
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
-	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
@@ -2692,9 +2794,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
-	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
-		list_del(&buf->node);
-
 	if (cctx->remote_heap_size && cctx->vmcount) {
 		u64 src_perms = 0;
 		int err, i;
@@ -2778,9 +2877,11 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	/*
 	 * The DMA buffer associated with the context cannot be freed in
 	 * interrupt context so schedule it through a worker thread to
-	 * avoid a kernel BUG.
+	 * avoid a kernel BUG. fastrpc_context_schedule_put_work() guards
+	 * against a concurrent fastrpc_notify_users() also scheduling this
+	 * same work item for an interrupted context.
 	 */
-	schedule_work(&ctx->put_work);
+	fastrpc_context_schedule_put_work(ctx);
 
 	return 0;
 }

---
base-commit: ef071c4906eb45d16b60f09154cf0bc6ec8f5435
change-id: 20260930-anandu-fastrpc-interrupted-invoke-v3-10b130c444f1

Best regards,
--  
Anandu Krishnan E <anandu.e@oss.qualcomm.com>

