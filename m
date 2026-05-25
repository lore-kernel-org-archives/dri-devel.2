Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F2BCD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 12:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999E010E2EC;
	Mon, 25 May 2026 12:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kRhdGVbp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T3nlVxxU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA5110E2EC
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:42:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PBPX083263593
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=gspTz+RCdd00FlSjfdVj6tl1b3B4ut3IzjE
 OfEUzLJI=; b=kRhdGVbpWTbKCytAZ8IksU24QLSo/2mOmI+OoxIahZpf2/zyX89
 EfHL56uZifaPsSQTqPfNPtRd1pCC2vPRVwBnof36KcXCVSi053bo5YqKELoXlg3Z
 4Kzw/UXqmQzxpxtk0M5IUACUXrEZ2NdQfpOzuS4b9d2lhWFENEPnXYMT2L0ZmEEV
 W2oEbq7NP0OrBATUkvm9l46V88Fx1rUlhPyGF6fsSNMvmkwrTOSG9ScgLLfmmyPy
 Y7CQsLN/Rqzm1WxZhNWzdnbLR4K1U3pKlMiCWraqaejFbmO+7swgocJV5FfpfKIO
 +746FT6wcQKvtzA3d4OxZmc6jCYo2dV65yQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs07by-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:42:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2babbeff9e4so104550645ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779712948; x=1780317748;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gspTz+RCdd00FlSjfdVj6tl1b3B4ut3IzjEOfEUzLJI=;
 b=T3nlVxxUx295N8EwtNFL8b19slaqYT1LhYSeRSx2rFP60iYd0lMhNqskzwxERVGlIE
 44sNfXEX0i3u9sDRm0gxBjfpGS4xbPb+MEH5VqRzwAv4bWeBoKydJJdSfWDro203AiLx
 z8WZb5VVI+XbKEqyF2YPi2sLHXwwkE8ZNuDbFjECtKXHAXMbxfFJ+lt5lc2bGWv4skBu
 klOuan2hJMUGK0fc/EW45HlW3FcqSj8K0manmVG0X6wJ3OrulIqncAEUVEbZOPE884pj
 Z0y+S87WNJxTINZhZcaPFPJFK6h9gxdWu2wMEM3mHP4sn9ERyx6404NuhH8nNoowVkaY
 WF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779712948; x=1780317748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gspTz+RCdd00FlSjfdVj6tl1b3B4ut3IzjEOfEUzLJI=;
 b=eVEjUUIhb2/ydU5arl9gNPLYOAZ7PgAUvGHxTo+71naqFm7ohEkJI+4pzjbcF0RsE+
 Fv9dUPinJYgSO0F23ZoU73pendEzOmoi/E2SLJH7N99psmX9OBCU7HAsBwYwanz1Wgtd
 g6wrqvu4myR1t5ZF7od1P7/whca4fE4obGVbdnBhRBJqelOOlshc+muXxkbFtDY8Qf5i
 abjWxeS5FEJsSkaaCxcQd1eJ+bMrVKefLKwtV4mtZVhhi59I8ou9eWtoCCKrwms69zla
 g6PgDd0o2trrgpcrGxVxDepK2gFUq4+lAubPM5wFXbbsE6ppmmXp+SxgnrBCrInU7nPa
 ACRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+K4OUerUMAAsmx/xMppivxauiyM8l+EJwp6uhSrfEs6VCn88ycKTMnvJgAHf71GFuxm5Uz2W7zyB0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxk3gEukPicY7vTunCYJykbXjpNY4LrcLd3ed3hANvJIMbaLglB
 nXvSkvjNJ4EMGFBmf2ixSSbAtCtTeC8vFNLsA671mvMQAXd1yBS7h3qcl6NcKk99eqvDMU4IvI5
 On/J6LwS4mnF6VbkIDemZws785J5RnnnGoz2K3tleCot9+M4Bm4MxVf1bMdnv7RhzaiPUeVM=
X-Gm-Gg: Acq92OFgUGPpGSThlZ0xKomOlpd5HcwcHhHxSR7WRkji/fwoZaK4XGDsDYkhfN4mSUm
 HvItoRa2JZXz36CZncnfLr5BJCdhif1IzJRxn0Jc8dilCJtJKQpjf5IIGn4ecF4Zj5Pze1D1T6B
 HOiod9PXJVzKh25PYdpv+oh2xkQO0G4JLZQYo6hjQPagNDuj7y4I1JMmOHTCWVPrPhkBMDopQoz
 15WIqo0+wyx1ximm5gxLi67272/NG4Xgqu0wqSCK3VALWbKJbn1+iEBGOVbIMeCAsnNeZ0qpDga
 zhN8oqPa2Y4n420yGISdY/OGy1TULIUltyN4C7odLQdQymmgF6/zwR7Q1htz21h6rATjEeS/lAO
 jXxvUL0GX9pEKffg5UprGuvVRZ7mIcs1fFt1CR/BusvIF92Mgm98+YGA=
X-Received: by 2002:a17:902:f709:b0:2bc:dca9:f0ed with SMTP id
 d9443c01a7336-2beb087b062mr115484175ad.15.1779712948084; 
 Mon, 25 May 2026 05:42:28 -0700 (PDT)
X-Received: by 2002:a17:902:f709:b0:2bc:dca9:f0ed with SMTP id
 d9443c01a7336-2beb087b062mr115483825ad.15.1779712947431; 
 Mon, 25 May 2026 05:42:27 -0700 (PDT)
Received: from hu-anane-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5205f16sm95717745ad.0.2026.05.25.05.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 05:42:27 -0700 (PDT)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
Subject: [PATCH v1] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
Date: Mon, 25 May 2026 18:12:22 +0530
Message-Id: <20260525124222.3082420-1-anandu.e@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a1443b5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=htDFEa73CQMYf3Ekz7QA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: vohi5lJ6jEHykw4zdW5vdpQidf8fqVDW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzMSBTYWx0ZWRfX/wWIFisKySF1
 L1Y6wQs3HETnIUaNxl3WlYlkVIZ/OOwChZ0GCw9nmHPlk+BqjdupA3FXcTQdiFERpfidyiumvnw
 5ar/EJHqncCb0/zgReVylRY1lfHW73N1dJWSQEpE49YzL8HC1YlEzxl4wro0wU2XUcD8y49+bgi
 Q/QeMyUkhmP5FF5j8Z36DnbUJ3rPRN0ztTKpj3J8BOc5Kspo5g4w2UIdzMZQrjJjB01u3yXVtbo
 zFfjIPnvvExigeFPK9tnyB32auc9Nyeoztxfozlze7YjAcvr4p0+YZDWAK9aSmpCQgpTVAwXDo4
 I4WfW/7rOq9s+NFgbSPFPIcGRf6Xy1mqFjfGSG3Bm6w8QVk55Q+Fi14f/jzuZvA14LQ01gMcptw
 vqggtN+qZe9IKjKB8G3iF7lwGcquRL9JG5DZTSYD/j2cb/ZWLzRihc6elDUqBPsiHy4aoOfw468
 7hfwZzqpSXMP4AAL/Cw==
X-Proofpoint-ORIG-GUID: vohi5lJ6jEHykw4zdW5vdpQidf8fqVDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250131
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

Also drain fl->interrupted on process exit and complete any sleeping
contexts with -EPIPE when the rpmsg channel is removed.

Fixes: 387f625585d1 ("misc: fastrpc: handle interrupted contexts")
Cc: stable@kernel.org
Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 69 ++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..22d0b0592c10 100644
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
@@ -542,6 +542,36 @@ static void fastrpc_context_put_wq(struct work_struct *work)
 	fastrpc_context_put(ctx);
 }
 
+static void fastrpc_context_save_interrupted(struct fastrpc_invoke_ctx *ctx)
+{
+	spin_lock(&ctx->fl->lock);
+	list_del(&ctx->node);
+	list_add_tail(&ctx->node, &ctx->fl->interrupted);
+	spin_unlock(&ctx->fl->lock);
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
@@ -1197,8 +1227,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   struct fastrpc_invoke_args *args)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
-	struct fastrpc_buf *buf, *b;
-
 	int err = 0;
 
 	if (!fl->sctx)
@@ -1212,6 +1240,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
@@ -1227,6 +1263,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
+wait:
 	if (kernel) {
 		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
 			err = -ETIMEDOUT;
@@ -1250,7 +1287,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		goto bail;
 
 bail:
-	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
+	if (ctx && err == -ERESTARTSYS) {
+		fastrpc_context_save_interrupted(ctx);
+	} else if (ctx && err != -ETIMEDOUT) {
 		/* We are done with this compute context */
 		spin_lock(&fl->lock);
 		list_del(&ctx->node);
@@ -1258,13 +1297,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
 
@@ -1598,6 +1630,11 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 		fastrpc_context_put(ctx);
 	}
 
+	list_for_each_entry_safe(ctx, n, &fl->interrupted, node) {
+		list_del(&ctx->node);
+		fastrpc_context_put(ctx);
+	}
+
 	list_for_each_entry_safe(map, m, &fl->maps, node)
 		fastrpc_map_put(map);
 
@@ -1637,6 +1674,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	spin_lock_init(&fl->lock);
 	mutex_init(&fl->mutex);
 	INIT_LIST_HEAD(&fl->pending);
+	INIT_LIST_HEAD(&fl->interrupted);
 	INIT_LIST_HEAD(&fl->maps);
 	INIT_LIST_HEAD(&fl->mmaps);
 	INIT_LIST_HEAD(&fl->user);
@@ -2435,7 +2473,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
-	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2467,13 +2504,16 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 		ctx->retval = -EPIPE;
 		complete(&ctx->work);
 	}
+	list_for_each_entry(ctx, &user->interrupted, node) {
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+	}
 	spin_unlock(&user->lock);
 }
 
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
-	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
@@ -2490,9 +2530,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
-	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
-		list_del(&buf->node);
-
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 
-- 
2.34.1

