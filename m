Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766E8FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBBF10EA26;
	Tue, 28 Apr 2026 07:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mqD6CWrE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TGQdS27K";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1DCD10EA26
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:33:41 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S6pfKb3760758
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Qpru+qluX0+pH7N4kcbo//
 xSN5otJGrfjPHoGqLaVww=; b=mqD6CWrEpY6tzdMiEEqMTCDvr58HXGsAEDNCQo
 SWThCm3lYTjipSsb9RSbjpGSCjxGuamAizx8vLx/xuzhjgc8gMWKOjYUT0XRoYBp
 veGkzq1HaZ2ScxOmHp1T6DIyOXtIsPxqJ7Wq6ZA+CR/ho/g02snXz7Wt1RMNb1nG
 VIyM8CsQ9uJqeob1mJu57h9c/U+nENviUSWCM9LIgG7A7ykhTCBT+A3qnKbVkXi0
 x9mctghCSIB9klq4zGEvKGqU4Q5hZ0fBZXnyE+1fkji/E4Hs7EvSZLQZdkkFZ3jx
 /+tsArF+V6pYGPdopq5DTXVZJZnWfDBCf3y344wk6N4HAStw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtacdu7xe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:33:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35fbaada2f3so20442028a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 00:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361620; x=1777966420;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qpru+qluX0+pH7N4kcbo//xSN5otJGrfjPHoGqLaVww=;
 b=TGQdS27KOXthMOERqOTdrBJLqnWFnaG5TNYG6GAr+16H6rOpDV8xMQ/y/G50Z+hDyz
 f8auaJSXB4nIIGY61J3RAQi9ryIVZspy6el2WUgLjlEtmeJWTIyqn701wdSpEwIUdQf2
 m1EmZEKfHvramNjH1HgG70+gbIL7w1C/WAie31xg7GATFc+JdNntCZHhIiAMiFjatghl
 kY+TXOcaac7N9Bk2zEWtZXvvUpju9ye6Od+q0ceQiXFAmRjmno0x/KyPIPApBea64nyP
 k9i2X/In+3ZldG7G94xdH/SrXQmVjY9gQGwXXAuOatiFIWmG2gdgQkNGzdJtnDe6i0Ck
 rlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361620; x=1777966420;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qpru+qluX0+pH7N4kcbo//xSN5otJGrfjPHoGqLaVww=;
 b=sgacmoSkvYFgLE2YTsyCH5c0DjCOBNfvEOzYNZq48WHhHuOQYhOPTzuOhmx3Y82k6s
 epIX0twRryAbNfE08ElZQD9sfnRCLB89zxlE2h1tIkuuMgol9qyVHfvLYQ5bLlGPBmMG
 ph1o8//1R949JnfquqaVHfdGDmLxImEylnCDANbJM5tcRWFRfq1A6PgEYKnGbS5ZhguL
 hRVLTiR2C1cM/JBNsawgKHZNZbCp46v+ZMadMIw1yL9AckbZt5GULM9+dPBmFrSJaLKS
 BRZikKYiCRcR99dCBLPq4NqPRwfq03fleB+I2p3MTbjN5tWqvcn2bc5LOSsCXnP+Xugg
 soAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zd/UREjdj4NnG/GPLmBn2xSZm9B0eC+igXJ/rTVTqIG0cDs00ZjGoyqDyzQWIZBgMvadS+JSzdBQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcO+wduKGmkJZpi7+b5XYmir6/BTX70jdz8oY88LgWFo67Lpel
 xxMxQFc24M+5kfM3YtfCj5Jk/khwCRaF8gsfXftqcKeMwVW03V+iVEGiThDRg3FAJdtCm8gWzvq
 zQ1CAy1AA1+554AIuu8wenf/+NuonMIEZHQpdDqKTz9HZuGhrNaVt3PIXaBFZb97iv9CZvco=
X-Gm-Gg: AeBDiesxY8QgUHzhHBdqebHczuGwXT2L6ebpHEMyRAjB8I81g5PIOjyXhx0/hQ639wQ
 JKEiS1dgFe4cAhiBTZtCy25kxFos8CT72bZmeOVMVaBud0WFoYsJj0eG2N8qSgVIEkfG/kU46rE
 99iItYua0VMvzoqsyaniDBPps4uJvum/syq/vReTsQwRB2A9yRfkzxs9XJDA9GEX4TLfORWnOQF
 LiKSN0POE6PwYF6IrLrlaxbVoMRUsQBtmdY1n7JUsYVXl4l8OOSEqTj7EFNqO6Jr04gL+TpbTIz
 sY01Wnde10MLJ2zcjrKdhS5k1y8N7FjQmBciSR+OjOF2WxMr4aMClJ0bGqqCk7SYN9FpGFiHPmW
 /BsXI6jnHE0bhi7XbjP0AwZk96PypzwsdzmleLBYr5I35CHcnjVohyz8=
X-Received: by 2002:a05:6300:86:b0:3a2:ecb8:56d8 with SMTP id
 adf61e73a8af0-3a39c2149e8mr2515435637.31.1777361620424; 
 Tue, 28 Apr 2026 00:33:40 -0700 (PDT)
X-Received: by 2002:a05:6300:86:b0:3a2:ecb8:56d8 with SMTP id
 adf61e73a8af0-3a39c2149e8mr2515403637.31.1777361619963; 
 Tue, 28 Apr 2026 00:33:39 -0700 (PDT)
Received: from hu-anane-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fc33d4c60sm1508477a12.23.2026.04.28.00.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:33:39 -0700 (PDT)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
Subject: [PATCH v3] misc: fastrpc: fix use-after-free of fastrpc_user in
 workqueue context
Date: Tue, 28 Apr 2026 13:03:34 +0530
Message-Id: <20260428073334.934358-1-anandu.e@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfX+eunJrkfMArj
 k2+lapHz7h95CxFRykDpFrCuE7exWcJObOiZclSoV4I2gd5KzPKXX1C/tFOn21N0+b6+N26jWt3
 ct+AqnNHxK8pb0c2icpi9/tYlI16oI8K/g9yAEc9ufdCUY35qWNVRGzuzv0N0zcMMNYu52A/TVl
 BBpE8AHY4ENSoqQHRFcvHdh+R/+u9u3ECMQHvWFDYsVE4OSax624ebYHaxZo7J1gz9teOvaupNK
 JKnfF7qQBRZigikdjldHIXY7Aqddcq1vwk0svX6KJOQrkQ8LX1vEY6BPxgSZv0KJ9De9jFq1QYG
 0JJ9EWXOXdPO95JwUJJAPdGDt5eYW819qrYDYAFZhbVcz+vr18Nk/i0OCFSUwc5m1CrMpToP+XQ
 rDpbUOYUcEXSlGhEcdvj0RQhmX6V4FsnXrxK14ObzzO++uYt1cAjgQpVOveWlMW7HNcYzTrTGfh
 vIQ8+627m/f/vieKHVw==
X-Authority-Analysis: v=2.4 cv=QsduG1yd c=1 sm=1 tr=0 ts=69f062d5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-d8OuwpfmgTKOJIC24EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: YquzDt1Hl4Ltk5-R3OKk9ME0LkP_KGBJ
X-Proofpoint-ORIG-GUID: YquzDt1Hl4Ltk5-R3OKk9ME0LkP_KGBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280069
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
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..49f0058824f0 100644
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
@@ -1590,29 +1636,13 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
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
 
-	mutex_destroy(&fl->mutex);
-	kfree(fl);
 	file->private_data = NULL;
 
+	/* Release the reference taken in fastrpc_device_open */
+	fastrpc_user_put(fl);
+
 	return 0;
 }
 
@@ -1655,6 +1685,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	spin_lock_irqsave(&cctx->lock, flags);
 	list_add_tail(&fl->user, &cctx->users);
 	spin_unlock_irqrestore(&cctx->lock, flags);
+	kref_init(&fl->refcount);
 
 	return 0;
 }
-- 
2.34.1

