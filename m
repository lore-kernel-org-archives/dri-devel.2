Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5560ECD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 20:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D9189AC3;
	Mon, 18 May 2026 20:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMpEo46L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RN+2LYe8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C23A589AC3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 20:35:15 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IJAEkX2701160
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 20:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KxpQ8qvZXX/EEKeXODhGQL
 t+l8ymJHRYKkRNEjmncAs=; b=mMpEo46LtkxbzrVoak3oUpll8mAE807oSGySsS
 XyQ8PUY/TmAoINrLbvnpyVUWUyJD93tN8llSH+zsy8y81iqhbl6OmLrbUcGyr73E
 T5xzn2ttnKSMZRxCnbPEq4QG++UuNK90V8tXiF/12QrxkblLyMA8E4TRaTV+8s5g
 2EPXIDSqSdYSVRfwuUbQ7ylpHWH1hsZCfBXNlUBprfHrOWVxFRAiO+2TqEjUddFZ
 ukaFIflzwRrBChx54eadKvbVRcvakRvkMTw2CGN909zJCofpSc/uEOwLJzBqvZig
 d5lNRLP/fryU3hrWuRfGgQ7C7VTCBafQG9fCK3wmcHc2aWgQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82mehuq1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 20:35:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3684cb22502so2443036a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779136514; x=1779741314;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KxpQ8qvZXX/EEKeXODhGQLt+l8ymJHRYKkRNEjmncAs=;
 b=RN+2LYe8bpeHdXedKAwwAb+Qx2oKSowrzB/ilrjAIFK0iB4FFb6LeM8MB3c/j4uh6O
 WeyyK/Y3tgk1TwuJreBSBAn3DoLTI8C2PNrrfN3txOUMGbBOij74flIDqBYiIBIxqcYB
 FyHp3gUXEppsycMaQYbq6v2+szSCOrEZUeMzSrcNtJESj1baXsHFwxfaO7i2q5QDREnb
 ECll2FguxWRkHwtzL0Bvm/1/wqLUraXCEN6EHt4nHdB+l6+cPX+R7I7+nd5aXfPA/uJc
 yHGm0kP1w4mo1do8tTODlCqaeRvCSXdp/JQf02kE19stqLkDVO8aidKCnymHkT1Tpn+7
 9xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779136514; x=1779741314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxpQ8qvZXX/EEKeXODhGQLt+l8ymJHRYKkRNEjmncAs=;
 b=C3pWLaKQhrGO3V2PGdl24N4T1w1iS2Y+rF8Rqw3izgYMoXdgfH/djU2qyYL//C34B4
 Uq/9p0Re6SLAzJDJ522UdOGf1uws9OJn20FhMfA8P7l3t8Bw1bdCZOAF8+6WY6eQDWlO
 hv1nocmjqzW5wwujTsBu8V9fey4exbKsOUjlPi+IuRhwpl4QTuOnOhF03UABpyd9nzOC
 nIIckU8VJP7fOJhcpFFxjcAa+p8YXbFOQtq3jQu+lxk7cJUICtw9kU+ibT4AFvuSnPmf
 FrzTKduBJk4kbvBCHwV+A4TWxoOhjQyeeK6EKEniB/O+Tkv6dsI+dkkHwLGnsyewZA2f
 ga5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rsZbrDGoz9cc9e5UJ6SrEh4EVGL1gno0wkWDZfH0Y7FUIVgH2Fnowlvoh5amKsLXzJcjfFcJdcCU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVrSA3EZPylJ8WLey9Pa9s9YF/x6gZa/NWz0TIsYTGDkEkvB8x
 jooJgTjX6HkTe6Eh9h8LsxWrJX48OaKr/mUYiqxBIaGan+30Ng2G8O0Fw9a1laQ6ID5H/thCCSt
 TrwhrNJuw8SJ9pUxoZJoVcy8QmWzUqr0mi3yj/tydUQZbvxjin0TWQyYcbg7pniv4m2wPLKU=
X-Gm-Gg: Acq92OFr1xTKXQjaj+QNONznuHAWejzo/LhiUMrMeffBHVeY1ctoiT7W9b2RBg2j6V+
 MpcviFS03QxudtbXxNOoNQ45Af9uwwA0vsIDmiAneO9EbKJBabggppxPrqzTqq5uY8dJfZQY1aj
 NNPXgowGQRUWYtxbTowjCNH+LGRnR1zvDzo/uA1SUbGfXOWvWYqzQ5l+u43/blIxPWg89Ar5fqF
 PMwVop16EqfjB/1Y4q+PGOje/hpIV1U3Ct26WflgpcTZyKwGb2mTjAsf4NUTZ5wftVzCDbBQyi0
 t6yxdeLeKDJYzolur3YEb87iNJGNDUJnakHTpLjQPSChbKi94ny3zzfV8sgpNJzWiJN14iXt2rb
 4MqzUH8aE5du9rZcP1F6wZ2stN0rI6azKJVfDbH3slp75
X-Received: by 2002:a17:90b:3505:b0:366:aba:4c86 with SMTP id
 98e67ed59e1d1-36951dd5abemr16453631a91.27.1779136513477; 
 Mon, 18 May 2026 13:35:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3505:b0:366:aba:4c86 with SMTP id
 98e67ed59e1d1-36951dd5abemr16453600a91.27.1779136512901; 
 Mon, 18 May 2026 13:35:12 -0700 (PDT)
Received: from hu-anane-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0600c3sm156725235ad.29.2026.05.18.13.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 13:35:12 -0700 (PDT)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
Subject: [PATCH v4] misc: fastrpc: fix use-after-free of fastrpc_user in
 workqueue context
Date: Tue, 19 May 2026 02:05:07 +0530
Message-Id: <20260518203507.3754994-1-anandu.e@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Tr7WQjXh c=1 sm=1 tr=0 ts=6a0b7802 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-d8OuwpfmgTKOJIC24EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 9SVZ4djcOCoJDo41jZ4caXmIliz7fstk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDIwNCBTYWx0ZWRfX4ZNjvwfcTTMB
 KEW2DcIAfOhmS9kr5gfAU2dwJcWEDshLxFsywBVnikTHc7NXsIRWziQgQ2aOaYQCcP5fguxOVYz
 xfXD1SyLjAX7f/hkCou86wZn06lwGix0PCHDlhzJmyk7LGDzIpItNCSEXZlZg1omzDBZ2bOOqW5
 RMcFoZQo3CKpYJxw5T35nHyfMO5wzl3ygsRDbPlKhrAimnlffFh8GOFvh44YRX1vC2k0QxRRkF5
 1D8YP/qHW1VeJmthSdvImvPEm5z7GdPjIQh9MI0mcQs81yCYYXby8lpZgKk6yTHb50T6FgWF/vZ
 Cn4SspKV/z0wupGr98GPB3dF+Wf1mI36vxRx7zp6n47YojrPWqeCI6CLvvjltxPJmR2acn2QfX9
 KQtHa30Ag9xvCSKNR57w7HWCrrpMVthkQUr0NDewHZKEyORbhiEJMz8O3oatK8at8zzMBm8l8Et
 0g8X+9yk89pzP9LKfUQ==
X-Proofpoint-ORIG-GUID: 9SVZ4djcOCoJDo41jZ4caXmIliz7fstk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180204
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

There is a race between fastrpc_device_release() and the workqueue
that processes DSP responses. When the user closes the file descriptor,
fastrpc_device_release() frees the fastrpc_user structure. Concurrently,
an in-flight DSP invocation can complete and fastrpc_rpmsg_callback()
schedules context cleanup via schedule_work(&ctx->put_work). If the
workqueue runs fastrpc_context_free() in parallel with or after
fastrpc_device_release() has freed the user structure, it dereferences
the freed fastrpc_user. Depending on the state of the context at the
time of the race, any one of the following accesses can be hit:

 1. fastrpc_buf_free() calls fastrpc_ipa_to_dma_addr(buf->fl->cctx, ...)
    to strip the SID bits from the stored IOVA before passing the
    physical address to dma_free_coherent().

 2. fastrpc_free_map() reads map->fl->cctx->vmperms[0].vmid to
    reconstruct the source permission bitmask needed for the
    qcom_scm_assign_mem() call that returns memory from the DSP VM
    back to HLOS.

 3. fastrpc_free_map() acquires map->fl->lock to safely remove the
    map node from the fl->maps list.

The resulting use-after-free manifests as:

  pc : fastrpc_buf_free+0x38/0x80 [fastrpc]
  lr : fastrpc_context_free+0xa8/0x1b0 [fastrpc]
  fastrpc_context_free+0xa8/0x1b0 [fastrpc]
  fastrpc_context_put_wq+0x78/0xa0 [fastrpc]
  process_one_work+0x180/0x450
  worker_thread+0x26c/0x388

Add kref-based reference counting to fastrpc_user. Have each invoke
context take a reference on the user at allocation time and release it
when the context is freed. Release the initial reference in
fastrpc_device_release() at file close. Move the teardown of the user
structure — freeing pending contexts, maps, mmaps, and the channel
context reference — into the kref release callback fastrpc_user_free(),
so that it runs only when the last reference is dropped, regardless of
whether that happens at device close or after the final in-flight
context completes.

Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
Cc: stable@kernel.org
Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
Changes in v4:
 - Fixed a blank line issue
 - Link to v3: https://lore.kernel.org/all/20260428073334.934358-1-anandu.e@oss.qualcomm.com/

Changes in v3:
 - Fixed fastrpc_user_put()/fastrpc_channel_ctx_put() call order in
   fastrpc_context_free() and the err_idr path of fastrpc_context_alloc();
   the correct ordering from v1 was accidentally reversed in v2
 - Link to v2: https://lore.kernel.org/all/20260427074021.3774769-1-anandu.e@oss.qualcomm.com/

Changes in v2:
 - Rewrote commit message to establish the problem first per review
   feedback; identified all three UAF dereference sites explicitly
 - Moved resource cleanup (pending contexts, maps, mmaps) into
   fastrpc_user_free() so teardown is consolidated in the kref
   release callback
 - Link to v1: https://lore.kernel.org/all/20260226151121.818852-1-anandu.e@oss.qualcomm.com/

 drivers/misc/fastrpc.c | 75 +++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..48f8262af539 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -310,6 +310,8 @@ struct fastrpc_user {
 	spinlock_t lock;
 	/* lock for allocations */
 	struct mutex mutex;
+	/* Reference count */
+	struct kref refcount;
 };
 
 /* Extract SMMU PA from consolidated IOVA */
@@ -497,15 +499,57 @@ static void fastrpc_channel_ctx_put(struct fastrpc_channel_ctx *cctx)
 	kref_put(&cctx->refcount, fastrpc_channel_ctx_free);
 }
 
+static void fastrpc_context_put(struct fastrpc_invoke_ctx *ctx);
+
+static void fastrpc_user_free(struct kref *ref)
+{
+	struct fastrpc_user *fl = container_of(ref, struct fastrpc_user, refcount);
+	struct fastrpc_invoke_ctx *ctx, *n;
+	struct fastrpc_map *map, *m;
+	struct fastrpc_buf *buf, *b;
+
+	if (fl->init_mem)
+		fastrpc_buf_free(fl->init_mem);
+
+	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
+		list_del(&ctx->node);
+		fastrpc_context_put(ctx);
+	}
+
+	list_for_each_entry_safe(map, m, &fl->maps, node)
+		fastrpc_map_put(map);
+
+	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
+		list_del(&buf->node);
+		fastrpc_buf_free(buf);
+	}
+
+	fastrpc_channel_ctx_put(fl->cctx);
+	mutex_destroy(&fl->mutex);
+	kfree(fl);
+}
+
+static void fastrpc_user_get(struct fastrpc_user *fl)
+{
+	kref_get(&fl->refcount);
+}
+
+static void fastrpc_user_put(struct fastrpc_user *fl)
+{
+	kref_put(&fl->refcount, fastrpc_user_free);
+}
+
 static void fastrpc_context_free(struct kref *ref)
 {
 	struct fastrpc_invoke_ctx *ctx;
 	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_user *fl;
 	unsigned long flags;
 	int i;
 
 	ctx = container_of(ref, struct fastrpc_invoke_ctx, refcount);
 	cctx = ctx->cctx;
+	fl = ctx->fl;
 
 	for (i = 0; i < ctx->nbufs; i++)
 		fastrpc_map_put(ctx->maps[i]);
@@ -521,6 +565,8 @@ static void fastrpc_context_free(struct kref *ref)
 	kfree(ctx->olaps);
 	kfree(ctx);
 
+	/* Release the reference taken in fastrpc_context_alloc() */
+	fastrpc_user_put(fl);
 	fastrpc_channel_ctx_put(cctx);
 }
 
@@ -628,6 +674,8 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 
 	/* Released in fastrpc_context_put() */
 	fastrpc_channel_ctx_get(cctx);
+	/* Take a reference to user, released in fastrpc_context_free() */
+	fastrpc_user_get(user);
 
 	ctx->sc = sc;
 	ctx->retval = -1;
@@ -658,6 +706,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	spin_lock(&user->lock);
 	list_del(&ctx->node);
 	spin_unlock(&user->lock);
+	fastrpc_user_put(user);
 	fastrpc_channel_ctx_put(cctx);
 	kfree(ctx->maps);
 	kfree(ctx->olaps);
@@ -1579,9 +1628,6 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx = fl->cctx;
-	struct fastrpc_invoke_ctx *ctx, *n;
-	struct fastrpc_map *map, *m;
-	struct fastrpc_buf *buf, *b;
 	unsigned long flags;
 
 	fastrpc_release_current_dsp_process(fl);
@@ -1590,28 +1636,10 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	list_del(&fl->user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	if (fl->init_mem)
-		fastrpc_buf_free(fl->init_mem);
-
-	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
-		list_del(&ctx->node);
-		fastrpc_context_put(ctx);
-	}
-
-	list_for_each_entry_safe(map, m, &fl->maps, node)
-		fastrpc_map_put(map);
-
-	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
-		list_del(&buf->node);
-		fastrpc_buf_free(buf);
-	}
-
 	fastrpc_session_free(cctx, fl->sctx);
-	fastrpc_channel_ctx_put(cctx);
-
-	mutex_destroy(&fl->mutex);
-	kfree(fl);
 	file->private_data = NULL;
+	/* Release the reference taken in fastrpc_device_open */
+	fastrpc_user_put(fl);
 
 	return 0;
 }
@@ -1655,6 +1683,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	spin_lock_irqsave(&cctx->lock, flags);
 	list_add_tail(&fl->user, &cctx->users);
 	spin_unlock_irqrestore(&cctx->lock, flags);
+	kref_init(&fl->refcount);
 
 	return 0;
 }
-- 
2.34.1

