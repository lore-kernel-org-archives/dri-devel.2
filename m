Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D213C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7EEF10EE34;
	Wed,  1 Jul 2026 08:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JSRSIxnv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h7ZbR1Wk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D7C610EE42
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 08:11:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615lT2p140748
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 08:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=umzU2CpFSZMS7JmI/ccMyh
 FV6ZNUMd1wMHgHsjP3Bz0=; b=JSRSIxnvAPZStuiv5aSdvVApUoCsYF6no3RKJR
 FrzCcO2IK6A0nr9g8E8iVtX+FPpY6GXiikqV5LtTcH1T/TO+iyv+LRpEKeiL/xDO
 d5QY4X1Kl1ywM2hrDig/bpSGvy/Xacj+pmBoEW2UG/nfwpr7psN5ylLtm6A023F1
 aWb7h6WuLHVv7TD6Ri854nOGaoXgTPyt/O0BRmA6qFhQ3gqdjbT1gxDuTm/YZKZr
 nRHQAUcBej8VLYoRmXCVX3enDAAr2W7ZimEZtYvBNteWhEQrbdGXN41RE4NhSUJJ
 cF0QK9lcRGw0u4O6iEv0Iz385vxG8dP7LPwEaqcBM+ESmtbg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99kbee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 08:11:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ca3b314193so5084725ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 01:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782893495; x=1783498295;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=umzU2CpFSZMS7JmI/ccMyhFV6ZNUMd1wMHgHsjP3Bz0=;
 b=h7ZbR1WkanZLe9iqO9onuSTuPVRGd4lfjFYe2SLL6aiNsoEqtRmFQgsLx+uAwI38W4
 PKjkN3mGNptXyg7tlCk2MIWUUKRFOzOtMHXWJK9PD4IvfoYqtXqkQS5HOSM9LJEeDsu5
 03+iM2eX/ePQX1jxOUhr4VwwNfVPhZftz0PrdBAke3Z1lvOHC8RT2eowcsMrknCqbpWA
 bnsxF9jnRcwjfopnOuzFXbEvSX/LR5+KLFHUSZURkgt0Wk9UeDl3nc9cf3ARiEduJFEz
 OjMYkDWXJlwy1VR3txC3DbLE3RcBMG8Wt36SXioWFHvXpV/iuDJYj0hOanE4+TUpAeW2
 lxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782893495; x=1783498295;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umzU2CpFSZMS7JmI/ccMyhFV6ZNUMd1wMHgHsjP3Bz0=;
 b=V9V47xyLG7flNPaAzFHn3TYFVoykz+YVYmKO6x+mbntZ941NKhdBQmUhy1k4G4eREb
 OsElp0fpHa1Dy1Uk9DizBhdA3MfMBfbP5zCvuv7T4s/n7T5YRX/v3UVc7epCluUjRXIP
 jjaLI2E5KUQWijzMnQL3PnVxtVrWzYlF8CYX5yRJU/Ls8PYwfnhTKldzoHoFzM7/UBLQ
 Qb2HIy0C9pY5kbeyyDvI/OCJb2tNgHYjXkXd0Kah3BZqHE5E+c42bSplvCh48R+FDMUk
 m57cb9TXkUiSDxLYKZbSew3CH34u7C5XelbkdNtpa5KShaP0Sfnn+G5nUnrOYz6vEDOK
 /syQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0ZkgdGGzYgywn3QMJgKqvR5cW3M2M/6RmLU6PBAaDUP4fcgpMSaLiJAQDy1pK0xwqHSWftrf3ErM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyISwZ+nNDlBQZV1ShCs+befwtUH5gBlj5GT5l1iHDVc+Gv1W70
 pOY/yBrDhVdYH3Mi6MSXjP6V3DngoHcpceSWqWIPS/2rjPcB9M8Y8R/OnWAppkjlsjXWcvT5Urk
 UOwMaihV+Wql7PDMtqykrFpvP4j9fzxfE8vUpxwUPrRyP+gWoJPDfIK8vkTMMr7fbDkRQaGk=
X-Gm-Gg: AfdE7cnHzVz8VdFd7HAfUu7eCRx/Axzjd+3OzsmEgewWyg7UWyUjdH7pYz9C1COlCOn
 rL/Dca+SxIkSembmIOfiIUZ4H1hjcizrIZXGW1FupMIaN/8zB9MoUipP3+6oVKDdGxvypdR8AQs
 uK0kkpW7UEuNTAH350wvhpNxCBK7Twu4cItEbgfidZF71tRGl1EN1SHEQl+GtradwjUsB+rtYin
 u4qfWsVQy8p0P1TARO7awMja0W45GU6A9CdaGtELjUDW5XWCqb+oYib5JyDhHi9CSD9IG7bFVpC
 Re2wa1cAGcW8co3phpquydUc0snaSB0oyuNLrHKvFNb3KD14yI1cgGXLP3BOanP56f/8VKGtQJC
 wY7TFtzTIpeBtkMOXKu9e
X-Received: by 2002:a17:902:e889:b0:2c9:abe1:c352 with SMTP id
 d9443c01a7336-2ca7e739c10mr9068095ad.13.1782893494725; 
 Wed, 01 Jul 2026 01:11:34 -0700 (PDT)
X-Received: by 2002:a17:902:e889:b0:2c9:abe1:c352 with SMTP id
 d9443c01a7336-2ca7e739c10mr9067745ad.13.1782893494147; 
 Wed, 01 Jul 2026 01:11:34 -0700 (PDT)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c82810sm27808675ad.28.2026.07.01.01.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 01:11:33 -0700 (PDT)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 13:41:25 +0530
Subject: [PATCH v2] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-master-v2-1-566bf8b7bd16@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKzLRGoC/yXM0QpAQBCF4VfRXNtak1a8ilwsBqMs7SClfXeLy
 6/+c24Q8kwCVXKDp5OFVxeBaQLdZN1IivtoQI1GFzpTi5WdvMLWGszNgGWfQYw3TwNf31Hd/Ja
 jnanb3zWE8ABAr8BsagAAAA==
X-Change-ID: 20260701-master-2ba6246f29d1
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4MSBTYWx0ZWRfX3+mX+8LreMbB
 ax9xOgCQ9XLuVAYPgYykWTbl4zpurv3hGxrjMSAJvonU94j5+Vn3xtWsTiSlGKYfrtF8b8pNBt3
 rqm486rWYRIPYHL6aIrYWTF+dUmP1kI=
X-Proofpoint-ORIG-GUID: OmTO4Nut6qB1WJ34Ne6FuWQsAOdXyEt6
X-Proofpoint-GUID: OmTO4Nut6qB1WJ34Ne6FuWQsAOdXyEt6
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a44cbb7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=I77tMjNYA1nZ5Wqn6hEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4MSBTYWx0ZWRfXxXDW5+kahmnU
 rpQU9o5hqDV00IPWEll/5jKB7pJDzALKl30aPCOPpx5yc0ktEPtxQnzPIBXJnm0sK2OMQVPEo9u
 K2VL71a93cTKjXgewSRJjtVQjvlTeAEoEt56VIgDrYpk30nh+FGg7h6VQvhVcX3MrqLvW/JQKPA
 gDYXD2YXdSahkBJKxibXLWV6mTT5LhcB5Zsd3lFY7T2cnU3Gj65eNYApuSGeEIv2PBfG4dVFqan
 l7uakiHXsEHvyJ7bXvIceYJvd9vQ2zVxV64/fzkXg3nOXG+GNijyFflOZeMKcflO11vyMjU8QsZ
 7aZaJUTR+OPOSs5inF3Oh9AI2SlrMuCimbTL9q3PqABVN8MS8UW7oprCjB2c0AQhI+dtcpGtuoO
 ATxAsYBuw3V8Sb96x/M0NuQE3RA3WUa/0wsROyMl3SBLJ2qpct95REGpIggb2Iy7SO/mITYWeLx
 3h9Zsk6doIO3BPHl58A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010081
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
list on -ERESTARTSYS. When the same thread retries the invoke with a
matching sc, restore the context and jump directly to the wait,
skipping context allocation and message re-send.

Three additional bugs are also fixed:

1. fastrpc_context_save_interrupted() did not drop the extra kref that
   fastrpc_invoke_send() took, so the worker's put only reached 1 and
   the context was never freed.  Drop the reference in save_interrupted()
   so the worker's put reaches 0 and triggers context_free.

2. The bail path skipped context cleanup on -ETIMEDOUT, leaking the
   context.  Remove the -ETIMEDOUT exception so timed-out contexts are
   freed like any other error path.

3. fastrpc_context_free() did not remove the context from fl->interrupted
   before freeing it.  A context freed via a racing channel removal left
   a dangling node in the list.  Add list_del_init() guarded by fl->lock
   before releasing resources.

Also drain fl->interrupted on process exit, complete any sleeping
contexts with -EPIPE and schedule put_wq to drop the worker ref when
the rpmsg channel is removed, and add dev_warn() on TIMEOUT and
ERESTARTSYS to aid post-mortem debugging.

Remove the obsolete invoke_interrupted_mmaps mechanism from
fastrpc_channel_ctx; context resources are now kept alive through the
context refcount rather than by migrating mmaps to a channel-level list.

Fixes: 387f625585d1 ("misc: fastrpc: handle interrupted contexts")
Cc: stable@kernel.org
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
This patch fixes a context leak and DSP hang that occur when a
fastrpc invoke syscall is interrupted by a signal, along with three
follow-on bugs found during review.

Changes in v2:
- Fix kref imbalance: fastrpc_context_save_interrupted() now drops the
  extra reference taken by fastrpc_invoke_send(), so the worker's put
  correctly reaches 0 and triggers context_free.
- Fix -ETIMEDOUT context leak: remove the ETIMEDOUT exception from the
  bail path so timed-out kernel invocations go through the same
  list_del_init + context_put cleanup as all other error paths.
- Fix dangling node: fastrpc_context_free() now calls list_del_init()
  under fl->lock before releasing resources, preventing a dangling node
  in fl->interrupted if a racing channel removal fires put_wq.
- fastrpc_notify_users() now calls schedule_work(&ctx->put_work) for
  interrupted contexts to drop the worker ref on channel removal.
- Add dev_warn() on TIMEOUT and ERESTARTSYS for post-mortem debugging.
- Use list_del_init() instead of list_del() in the bail path.

Link to v1: https://lore.kernel.org/all/20260525124222.3082420-1-anandu.e@oss.qualcomm.com/
---
 drivers/misc/fastrpc.c | 101 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 82 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a49384586d..c0859a501617 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -280,7 +280,6 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
 	struct fastrpc_buf *remote_heap;
-	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
 	u64 dma_mask;
@@ -297,6 +296,7 @@ struct fastrpc_user {
 	struct list_head user;
 	struct list_head maps;
 	struct list_head pending;
+	struct list_head interrupted;
 	struct list_head mmaps;
 
 	struct fastrpc_channel_ctx *cctx;
@@ -522,6 +522,11 @@ static void fastrpc_user_free(struct kref *ref)
 		fastrpc_context_put(ctx);
 	}
 
+	list_for_each_entry_safe(ctx, n, &fl->interrupted, node) {
+		list_del(&ctx->node);
+		fastrpc_context_put(ctx);
+	}
+
 	list_for_each_entry_safe(map, m, &fl->maps, node)
 		fastrpc_map_put(map);
 
@@ -557,6 +562,12 @@ static void fastrpc_context_free(struct kref *ref)
 	cctx = ctx->cctx;
 	fl = ctx->fl;
 
+	/* Remove from fl->interrupted if present; no-op for normal paths. */
+	spin_lock(&fl->lock);
+	if (!list_empty(&ctx->node))
+		list_del_init(&ctx->node);
+	spin_unlock(&fl->lock);
+
 	for (i = 0; i < ctx->nbufs; i++)
 		fastrpc_map_put(ctx->maps[i]);
 
@@ -594,6 +605,42 @@ static void fastrpc_context_put_wq(struct work_struct *work)
 	fastrpc_context_put(ctx);
 }
 
+static void fastrpc_context_save_interrupted(struct fastrpc_invoke_ctx *ctx)
+{
+	spin_lock(&ctx->fl->lock);
+	list_del(&ctx->node);
+	list_add_tail(&ctx->node, &ctx->fl->interrupted);
+	spin_unlock(&ctx->fl->lock);
+	/*
+	 * invoke_send bumped the kref to 2; the bail path skips the put
+	 * for ERESTARTSYS.  Drop it here so the worker's put reaches 0
+	 * and triggers context_free.
+	 */
+	fastrpc_context_put(ctx);
+}
+
+static struct fastrpc_invoke_ctx *fastrpc_context_restore_interrupted(
+			struct fastrpc_user *fl, u32 sc)
+{
+	struct fastrpc_invoke_ctx *ctx = NULL, *ictx, *n;
+
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(ictx, n, &fl->interrupted, node) {
+		if (ictx->pid != current->pid)
+			continue;
+		if (ictx->sc != sc || ictx->fl != fl) {
+			spin_unlock(&fl->lock);
+			return ERR_PTR(-EINVAL);
+		}
+		ctx = ictx;
+		list_del(&ctx->node);
+		list_add_tail(&ctx->node, &fl->pending);
+		break;
+	}
+	spin_unlock(&fl->lock);
+	return ctx;
+}
+
 #define CMP(aa, bb) ((aa) == (bb) ? 0 : (aa) < (bb) ? -1 : 1)
 static int olaps_cmp(const void *a, const void *b)
 {
@@ -1243,8 +1290,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   struct fastrpc_invoke_args *args)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
-	struct fastrpc_buf *buf, *b;
-
 	int err = 0;
 
 	if (!fl->sctx)
@@ -1258,6 +1303,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		return -EPERM;
 	}
 
+	if (!kernel) {
+		ctx = fastrpc_context_restore_interrupted(fl, sc);
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
+		if (ctx)
+			goto wait;
+	}
+
 	ctx = fastrpc_context_alloc(fl, kernel, sc, args);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -1273,11 +1326,20 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
+wait:
 	if (kernel) {
-		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
+		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ)) {
 			err = -ETIMEDOUT;
+			dev_warn(fl->sctx->dev,
+				"fastrpc_invoke: TIMEOUT ctxid=0x%llx handle=0x%x nscalars=%d\n",
+				ctx->ctxid, handle, ctx->nscalars);
+		}
 	} else {
 		err = wait_for_completion_interruptible(&ctx->work);
+		if (err == -ERESTARTSYS)
+			dev_warn(fl->sctx->dev,
+				"fastrpc_invoke: INTERRUPTED ctxid=0x%llx handle=0x%x nscalars=%d\n",
+				ctx->ctxid, handle, ctx->nscalars);
 	}
 
 	if (err)
@@ -1296,21 +1358,15 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		goto bail;
 
 bail:
-	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
-		/* We are done with this compute context */
+	if (ctx && err == -ERESTARTSYS) {
+		fastrpc_context_save_interrupted(ctx);
+	} else if (ctx) {
 		spin_lock(&fl->lock);
-		list_del(&ctx->node);
+		list_del_init(&ctx->node);
 		spin_unlock(&fl->lock);
 		fastrpc_context_put(ctx);
 	}
 
-	if (err == -ERESTARTSYS) {
-		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
-			list_del(&buf->node);
-			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
-		}
-	}
-
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
 
@@ -1662,6 +1718,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	spin_lock_init(&fl->lock);
 	mutex_init(&fl->mutex);
 	INIT_LIST_HEAD(&fl->pending);
+	INIT_LIST_HEAD(&fl->interrupted);
 	INIT_LIST_HEAD(&fl->maps);
 	INIT_LIST_HEAD(&fl->mmaps);
 	INIT_LIST_HEAD(&fl->user);
@@ -2460,7 +2517,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
-	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2493,13 +2549,23 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 		ctx->retval = -EPIPE;
 		complete(&ctx->work);
 	}
+	/*
+	 * Interrupted contexts hold two refs: one for the invoker and one
+	 * for the async worker from fastrpc_invoke_send.  Complete them so
+	 * any blocked retry wakes, and schedule put_wq to drop the worker
+	 * ref -- the invoker ref is released by fastrpc_user_free().
+	 */
+	list_for_each_entry(ctx, &user->interrupted, node) {
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+		schedule_work(&ctx->put_work);
+	}
 	spin_unlock(&user->lock);
 }
 
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
-	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
@@ -2516,9 +2582,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
-	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
-		list_del(&buf->node);
-
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260701-master-2ba6246f29d1

Best regards,
--  
Anandu Krishnan E <anandu.e@oss.qualcomm.com>

