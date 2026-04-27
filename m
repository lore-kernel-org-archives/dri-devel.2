Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CE5FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0D610E5D8;
	Mon, 27 Apr 2026 07:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="URCg0Egv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CIHs9+Fb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E5A10E5D8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:40:28 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63QNEp8f1589169
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=JJOCYwwAvREjXQRgt0yQOK
 UxC5jJOFcFIqJRhmihN14=; b=URCg0EgvvJIjCLfwA8X9LCZvZ8DXFGb+7c/MUb
 FqGIcWcDAOLVWzdtCibRbRipB2awUz04oLZQxusR7v03NUAoM969pbWztGsS3gaM
 KTw2KW6qYZQZjDlZNzKq3ft0MVGTd0Xh27+M5JeEkcAurzPahDqYAYNzXiGv9Pr/
 Wq3WvxXRDAYLzWA02mZ3A83XdbnqrTMQmV7RmHUvRVlwY35CMWg0NRrwROx0Ps2t
 6AF0UHHv9ovvI4yzQdXZ/9XgVZ1zacg+x/20oVvyrcHf27BfVcsBXoiZUDGeiY0B
 c8RFDWjHBbcoBGN3oPolc0/JrJ5xw3vehyVRBxCqZwwdjHjA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsa4utxtn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:40:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2adc527eaf5so76302515ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777275627; x=1777880427;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JJOCYwwAvREjXQRgt0yQOKUxC5jJOFcFIqJRhmihN14=;
 b=CIHs9+Fbw7DycGaJeodoKqbSNUkHmp6bVmMS32U6e2GfWnVv4Jf5HCB20IXnLB1nno
 bU5HCFgBp/u66nFJf94X0ewlzkWdCDvjsfo6O0lXORoC6LaMZ5NQ63YLLR4HhWKTkH+9
 zZjMPjiocfxpA4S6Nx6QXt80giN8JAOwhJ1qSF9JKsVolyoR7xKyAm1CP7kCe5jHjjww
 eMR27JtrosfHqaKal5aVk8GPi2bgaEX9LguyV1rGvBV/tZpR0O06UM5W73SV+2C7sK7Z
 8VNZlAyRAFVdNoph4n01aLqvdDZa261qTr1zY+wCjO1yHtiNj7KwX2G+4P9OEES8yxXU
 4I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777275627; x=1777880427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJOCYwwAvREjXQRgt0yQOKUxC5jJOFcFIqJRhmihN14=;
 b=Ug8YNE1RqFVpuYWw5bRGHu3aIiwvi13bOd9xWpdI9giOreQydtBMTAIp//ijLAur/O
 LpF9h/fA+apwWjc0gChRmZUOTvFUY6kw/YlAof+tcCAddMODmQNvFwBXyQLOqW3zpXer
 KRT525cl/vqpkpdqhYLbJ0Dc8HwxKMVBSR80wwFAe8sacti+dsHDkZG2cebKI7oQnLDN
 ZkwXqVZossVtkz6NafSzaj8B7XlTIjY4M/DqdCwUTbZp7qDQEmd1+HqZZsSeAUF1oPK1
 ujmJiv4JE4GdoA3nlWtCAEXrtRSKzITq677UxZQzAInSeJi/V1mHb+ND8/Tb/7K8ffVQ
 Tm4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uMIdDQoEnMNenC+/83pDvRvQopRpaQoblMQp9lJG5OXwOYo8Ciav4lj1NWYcTd2gSkclYOujNxYU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxZzg+1v5V0mgBZii1xIdod6XvedKvj75surWsMV5LT2HUOJK1
 sog9s7Y7VVODY7dxZ6OIV28+RS3CJoYfA/E9TXv+FpAA6PBwDJkjsmJPCCUOOZTcH8nbbd30Axi
 AAZe7kSQyOfKaRWR+PUieNgHSOFkp4q3hYPwHqUUSdw/nct1xTMir16lT09KbzWpSafx0Ym4=
X-Gm-Gg: AeBDievlxKqLWFVndi8FJsKG06WyMaQSb20rp29qAai1lTOf+DT4yYqkoV9ul1WrAqg
 OhrBV6mTeFH+XKOHiCVcg9p0jrFudpZrnNwYrHekTyKlFWe9zZ23a7jwvZm/ZTgK1XK69ZockcN
 LbOyAsTqkD4uAs1tn92l9Y537mGq5zHk9qdpkc2j4eVBdN38kepdHP+Qgtn4YAJio87ZV6yv6Kt
 x8oWQOrL8vGuqQuF6BTFg9Lf97P0c+En55V8STLixYE8QKii7tTlWjDUr6aNuEuRpWlV1QH4hmx
 INPZ5AYlC0rZjUnJKQnjDPtGE/LH95S8D+LrisyLK8aYke4fdanGFsiBR87hkUDozIVSDcNudgN
 Z/UqOIsWqJTiY/xjyF/CymTwbkYrGB65V+yPxk8xiDJ72GugYdBUG85Q=
X-Received: by 2002:a17:902:fb03:b0:2b4:5f19:1d46 with SMTP id
 d9443c01a7336-2b5f9f3c5efmr297616345ad.19.1777275626945; 
 Mon, 27 Apr 2026 00:40:26 -0700 (PDT)
X-Received: by 2002:a17:902:fb03:b0:2b4:5f19:1d46 with SMTP id
 d9443c01a7336-2b5f9f3c5efmr297616005ad.19.1777275626349; 
 Mon, 27 Apr 2026 00:40:26 -0700 (PDT)
Received: from hu-anane-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa2f129sm277501945ad.29.2026.04.27.00.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 00:40:26 -0700 (PDT)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
To: srini@kernel.org
Cc: linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org,
 quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, ekansh.gupta@oss.qualcomm.com, stable@kernel.org
Subject: [PATCH v2] misc: fastrpc: fix use-after-free of fastrpc_user in
 workqueue context
Date: Mon, 27 Apr 2026 13:10:21 +0530
Message-Id: <20260427074021.3774769-1-anandu.e@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JrfLTGEvX8zWMRWdmKj2kiYvQ5yKxJg9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA4MSBTYWx0ZWRfX5qSw63jkE52V
 A7OGnagpXiXO5Q3pDXncA24rZi1WgT165lc3RGlj/q8wol5zE5ni9YhlK/bCZuUffsvk8ORZYn9
 qIsSbXIICUeEoTxr8Q42Wt5uckahdwMwZo/veM0e4Zz5AvMdqGP/gcuAR/NFYXQaoxIDtIX22Wf
 5snxUjfyTmnJpYaFXXSvQOFOqj3i7sx/xmHoilm6FeJ5VTg0mYElotkaSTTBQRrujAOEEHrvns9
 baAepqW3emun7opimdhgd3qeHlt8XlfLnJPUb1S9cufmpSwrxePmXfvb7AxzZyL1jMXTgAXjiZP
 CQNQgCrCW7D5+yuQCRrpGzGty6yz/YXdCyCpsznVKjRJv8gVkajXkS58owNdqjtWFimUfgWjt0b
 8kESpLKQOxvk0dPEQYprJyCijOH06NQ37Z2rfJkRQzhhgBZft7YAgNgPmUrtqfvLFYJfxagtY3A
 2PoOGF/12Af4H2S+cGg==
X-Proofpoint-ORIG-GUID: JrfLTGEvX8zWMRWdmKj2kiYvQ5yKxJg9
X-Authority-Analysis: v=2.4 cv=J/GaKgnS c=1 sm=1 tr=0 ts=69ef12eb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8KoG9AtTWN8LJ-d-xwUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270081
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
index 1080f9acf70a..7afbd470c9fd 100644
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
@@ -522,6 +566,8 @@ static void fastrpc_context_free(struct kref *ref)
 	kfree(ctx);
 
 	fastrpc_channel_ctx_put(cctx);
+	/* Release the reference taken in fastrpc_context_alloc() */
+	fastrpc_user_put(fl);
 }
 
 static void fastrpc_context_get(struct fastrpc_invoke_ctx *ctx)
@@ -628,6 +674,8 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 
 	/* Released in fastrpc_context_put() */
 	fastrpc_channel_ctx_get(cctx);
+	/* Take a reference to user, released in fastrpc_context_free() */
+	fastrpc_user_get(user);
 
 	ctx->sc = sc;
 	ctx->retval = -1;
@@ -659,6 +707,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	list_del(&ctx->node);
 	spin_unlock(&user->lock);
 	fastrpc_channel_ctx_put(cctx);
+	fastrpc_user_put(user);
 	kfree(ctx->maps);
 	kfree(ctx->olaps);
 	kfree(ctx);
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

