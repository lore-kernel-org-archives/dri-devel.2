Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2E6C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49CB10E008;
	Wed, 16 Sep 2026 18:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SON14eeV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gjcHAwji";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB67310E008
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:59:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GHP0VN3237421
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=oNh5E4YjPV8Mu31/aT2lj/zyB3bKAAIBtti
 yNhLYqOs=; b=SON14eeVgYUiQGCrUv1gWqAVLKyoojRGGX/4C941WcnT/GAUi3P
 SRXlUmeGgSwzgadAU9HFF3av+UWpxqrnXdjd4OeVNw0iT3NUaoLvlCsvpfUkjyHn
 Ai+hFDtmiMVK8Ci0Pt+spyS28dQMAiJTrvzK/4/g/ahsajJpmmPbSDA6Hx6zzSPe
 AEnqfUv2MGUlbQnfDPMhAuVUjAV1D41bKG908FCfgBZWKSEL1cOOz/eif8996tQ9
 rocKNih9OQNFBrRl9oNROR+i92wV1idbH065McJhfmkb39lEduCM6G4u0kkjGngg
 03OoU2whbwccWYbV2YVkwCU3sB4sM0WuSUA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqyga0c3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:59:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39b6416441eso24540a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789585142; x=1790189942;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oNh5E4YjPV8Mu31/aT2lj/zyB3bKAAIBttiyNhLYqOs=;
 b=gjcHAwjipG5t2bkWTgAUmHF+Bj8zqaw8AQ+c41m6PFGhRTVNc0SGwmv+h6gLSoGG1Z
 frt/iBNQRjQqWL18eytSuYAj5Owg+DmFvHhcTehTQAlxOciAsLVEwa+uCL00JTPSyqm8
 /5hDf/LTFYy0WZHcdKmTtE2m7MHjgrSFTjum3qIMLnl/p9F1Gaya/3qMj0LNUipl0t/f
 1KynjWFflagek56IkMee5+AnT8Tvj+lxQQgdUbhAYqWQFO/MRhdMv0s/Qygqu+ij8H6B
 0QNEeuGrSQKdecJ2d4d7JBRiHN7NVsaSwsm4pcKo1LgBE+wV/umaun4y0g081d1a9ClT
 ruYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789585142; x=1790189942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oNh5E4YjPV8Mu31/aT2lj/zyB3bKAAIBttiyNhLYqOs=;
 b=FQP+MgqYLHQiCe5ve94hQWnI0/Qa7uW+R+L43Mhe2xobBa1ARmsCZGhgdABfoubmIB
 qM56cokQas61SMstEJwDsAxjAWNt94m64GYhMcZe0gLVdlu9qxYQY+ie+KLs+9SQ5ENT
 YxEPFB2qTClFhmIOuI1YuxqjX3OzGW6eQfut5SqwXj1r8yzv2w81Xe85+sAEc+ALKqi/
 SCRpKK80+4+BASZE9zfDLi4BOdOLY5BAOQWCbjrx05wRsHLu1y237AFJE2DkeJj10BC7
 gqGzOez+XroF5nKBOO4C36zZrUCBEFqnOOCsncf2byzhcrjb9WyZZFsi1yMwqMaHnBJZ
 lpbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPExgFJ/l8vxHcO0/mswqw7ieBiU6YTZBS3IvV+8QuuoGLubc5TtBRirSciJ5Q6mrhbz3ZG60gdfs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++klBgiHIX/BmZk/oGeN13SyRwq9gEMxnQ+KWp/EpORRxRh+9C8X
 9SGeJ4AbWCUOvynRZFM/W6syk8b86sFm1e4+5Hfp05y20PpqYploxyF3iDj49quWAlsYRGOrWTc
 XZ+iVxUpbkrMlxMkMACqUQX089A56cgOLLov7mBXiT1jPjTNL5nALa9uTgKkUxeyNT83CS80=
X-Gm-Gg: AYBFou0ew9HAb6isCP1jJqvSPGQrci0KLl6IMP/79CZVdBNyZ3oGLrZxRuYOHMThkqy
 5yZYbkmkq7YBty6ZZYhia13AmPHHbWPPFSVkt7fKsRIklXzajEQCA0Gqq3ZEBrmzMEcoUkrr+lN
 N9YHb70E6B6KWFOVLmBMbXOCJDSZPOumgkwQ+HPEp9TrjvzYEt2aF+Pm9Gtd7OC7IXaeAGb9hzL
 UhPjOu2F3u6GXFX6BX4WSI4eESrGfAwNuh2MfqrILNFv94uLxcFS5Jj9y7OeaeS2lBdssUffLqS
 y2Qf+k8Z4SzKCUTVXb3giei2lml5sOHG9aR687GUSvA+bIGGMBi29pTyllA/V7cyAmd5FxaAPRJ
 SImtN1vabySU7oHrrSZMpjgU9/lGA4CF0a+U=
X-Received: by 2002:a17:90b:1a8f:b0:39b:61f1:8032 with SMTP id
 98e67ed59e1d1-39e1e42497cmr8260217a91.16.1789585142326; 
 Wed, 16 Sep 2026 11:59:02 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8f:b0:39b:61f1:8032 with SMTP id
 98e67ed59e1d1-39e1e42497cmr8260135a91.16.1789585141688; 
 Wed, 16 Sep 2026 11:59:01 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bfb19f8cesm11790987eec.2.2026.09.16.11.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 11:59:01 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: [PATCH] misc: fastrpc: Add cache maintenance for non-coherent
 platforms
Date: Thu, 17 Sep 2026 00:28:50 +0530
Message-Id: <20260916185850.3686010-1-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nYyOZ0LJQdkh0Kg01L35nc2OslQx5bA7
X-Proofpoint-GUID: nYyOZ0LJQdkh0Kg01L35nc2OslQx5bA7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI2MiBTYWx0ZWRfX5h4c0kGxKWgD
 yjjEWpUYzEH6C+wjcqHgM4aM1Ifut6m+LLZhPVHAfTtA2O9Mr4mACoG+1YyvEmRXT08h4TatLOJ
 JpmUThG+C1NZo7NBa9evV1T7boRoNtk=
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6aaae6f7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MU9f_CYsPQiu3DAa9dAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI2MiBTYWx0ZWRfX7lfOC+KIbVa5
 AID1S8y1KymzeNNDQ1W5wOuYzXxUz29HiaFVX6FniijUEIELtyONkyP2JM9K6dFr92H7CEOtf5S
 U4q+9FbKeCMCbkVBSp8ieN61hKCQrfZ1FgyUQyPnr+qByVZMOGtmyJeZlRCQhew7lFJY7z0h1HJ
 eJIlrfm95/zmI+fs2Qi8DTijTyvwa+mzuYcRQOV09gJG1eUNm/wzx9le5qGPq7DfQZQlGA00ngk
 NPdqo7Z4MsYP1rsd0pUxGLGTFRdUttLe5DTqPdKiEZ0ISOw8YZ/zy/j8b+Nh7kuN5OxctiJmSk4
 vONlcTK/w2J8l2taS4QYcmxyyWyc31iPjmk37I2hy+OC5cqm/gdUOi3i/F5//vKvQktkkT+5cxL
 L1pk/IEz7yJKSYbqoF8XAHHtIgLzm5RqhOXaelK7Yh1l1dIQG0M8viJzysvvh1go7OQF9m9E/8A
 OHjCC+qjKszoUKHcHoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160262
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

Some platforms using fastrpc do not support DMA coherency on
HLOS. On such systems, explicit cache maintenance is
required to ensure data consistency for RPC argument buffers.

Add cache maintenance for argument buffers when operating on
non-coherent platforms:
- Flush input buffers before invoking RPC to ensure CPU writes are
  visible to the DSP
- Invalidate output buffers after RPC completion to ensure DSP
  writes are visible to the CPU

Introduce helper functions fastrpc_flush_args() and
fastrpc_inv_args() to perform the required dma-buf cache
operations. These are invoked only when the device is not marked
as DMA coherent.

The coherency capability is determined using the "dma-coherent"
device tree property and stored per session context.

This ensures correct data synchronization on platforms lacking
DMA coherency, while avoiding unnecessary overhead on coherent
systems.

Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---

 Patch [v1]: https://lore.kernel.org/all/20260604194811.2437567-1-abhinav.parihar@oss.qualcomm.com/

 Changes in v2:
  - Fix buffer overlap handling to ensure cache maintenance is performed
    when input and output buffers overlap and the overlap calculation
    suppresses the buffer's mstart/mend range.
  - Add a do_cmo flag to track buffers that require cache maintenance
    even when their overlap range is clipped.
  - Invalidate output buffers before sending the RPC request, preventing
    stale CPU cache lines from being written back while the DSP updates
    the buffers.
  - Use DMA_FROM_DEVICE consistently for both begin_cpu_access() and
    end_cpu_access() when invalidating output buffers.

 drivers/misc/fastrpc.c | 77 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d4fac2caca86..83d04b9d2ea0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -217,6 +217,7 @@ struct fastrpc_buf_overlap {
 	u64 mstart;
 	u64 mend;
 	u64 offset;
+	bool do_cmo;
 };
 
 struct fastrpc_buf {
@@ -292,6 +293,7 @@ struct fastrpc_session_ctx {
 	int sid;
 	bool used;
 	bool valid;
+	bool coherent;
 };
 
 struct fastrpc_soc_data {
@@ -655,7 +657,9 @@ static int olaps_cmp(const void *a, const void *b)
 static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 {
 	u64 max_end = 0;
+	int max_raix = -1;
 	int i;
+	int inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 
 	for (i = 0; i < ctx->nbufs; ++i) {
 		ctx->olaps[i].start = ctx->args[i].ptr;
@@ -675,6 +679,9 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 			if (ctx->olaps[i].end > max_end) {
 				max_end = ctx->olaps[i].end;
 			} else {
+				if ((max_raix < inbufs && ctx->olaps[i].raix + 1 > inbufs) ||
+					(ctx->olaps[i].raix < inbufs && max_raix + 1 > inbufs))
+					ctx->olaps[i].do_cmo = true;
 				ctx->olaps[i].mend = 0;
 				ctx->olaps[i].mstart = 0;
 			}
@@ -684,6 +691,7 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 			ctx->olaps[i].mstart = ctx->olaps[i].start;
 			ctx->olaps[i].offset = 0;
 			max_end = ctx->olaps[i].end;
+			max_raix = ctx->olaps[i].raix;
 		}
 	}
 }
@@ -703,6 +711,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 
 	INIT_LIST_HEAD(&ctx->node);
 	ctx->fl = user;
+	ctx->sc = sc;
 	ctx->nscalars = REMOTE_SCALARS_LENGTH(sc);
 	ctx->nbufs = REMOTE_SCALARS_INBUFS(sc) +
 		     REMOTE_SCALARS_OUTBUFS(sc);
@@ -728,7 +737,6 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	/* Take a reference to user, released in fastrpc_context_free() */
 	fastrpc_user_get(user);
 
-	ctx->sc = sc;
 	ctx->retval = -1;
 	ctx->pid = current->pid;
 	ctx->client_id = user->client_id;
@@ -1067,6 +1075,64 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 	return 0;
 }
 
+static void fastrpc_flush_args(struct fastrpc_invoke_ctx *ctx)
+{
+	union fastrpc_remote_arg *rpra = ctx->rpra;
+	int i, inbufs, outbufs;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
+
+	for (i = 0; i < inbufs + outbufs; ++i) {
+		int raix = ctx->olaps[i].raix;
+		struct fastrpc_map *map = ctx->maps[raix];
+
+		if (raix + 1 > inbufs)
+			continue;
+		if (!map || !map->buf)
+			continue;
+
+		if (rpra[raix].buf.len && (ctx->olaps[i].mstart || ctx->olaps[i].do_cmo)) {
+			dma_buf_begin_cpu_access(map->buf, DMA_TO_DEVICE);
+			dma_buf_end_cpu_access(map->buf, DMA_TO_DEVICE);
+		}
+	}
+}
+
+static void fastrpc_inv_args(struct fastrpc_invoke_ctx *ctx)
+{
+	union fastrpc_remote_arg *rpra = ctx->rpra;
+	int i, inbufs, outbufs;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
+
+	for (i = 0; i < inbufs + outbufs; ++i) {
+		int raix = ctx->olaps[i].raix;
+		struct fastrpc_map *map = ctx->maps[raix];
+
+		if (raix + 1 <= inbufs)
+			continue;
+		if (!rpra[raix].buf.len)
+			continue;
+		if (!map || !map->buf)
+			continue;
+
+		/*
+		 * Skip invalidation if the argument overlaps with the
+		 * RPC control header page.
+		 */
+		if (((uintptr_t)rpra & PAGE_MASK) ==
+			((uintptr_t)rpra[raix].buf.pv & PAGE_MASK))
+			continue;
+
+		if (ctx->olaps[i].mstart || ctx->olaps[i].do_cmo) {
+			dma_buf_begin_cpu_access(map->buf, DMA_FROM_DEVICE);
+			dma_buf_end_cpu_access(map->buf, DMA_FROM_DEVICE);
+		}
+	}
+}
+
 static struct fastrpc_invoke_buf *fastrpc_invoke_buf_start(union fastrpc_remote_arg *pra, int len)
 {
 	return (struct fastrpc_invoke_buf *)(&pra[len]);
@@ -1191,6 +1257,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		}
 	}
 
+	if (!ctx->fl->sctx->coherent)
+		fastrpc_flush_args(ctx);
+
 	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
 		list[i].num = ctx->args[i].length ? 1 : 0;
 		list[i].pgidx = i;
@@ -1376,6 +1445,8 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
+	if (!fl->sctx->coherent)
+		fastrpc_inv_args(ctx);
 	/* make sure that all CPU memory writes are seen by DSP */
 	dma_wmb();
 	/* Send invoke buffer to remote dsp */
@@ -1396,6 +1467,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 
 	/* make sure that all memory writes by DSP are seen by CPU */
 	dma_rmb();
+	if (!fl->sctx->coherent)
+		fastrpc_inv_args(ctx);
+
 	/* populate all the output buffers with results */
 	err = fastrpc_put_args(ctx, kernel);
 	if (err)
@@ -2393,6 +2467,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	sess->used = false;
 	sess->valid = true;
 	sess->dev = dev;
+	sess->coherent = of_property_read_bool(dev->of_node, "dma-coherent");
 	dev_set_drvdata(dev, sess);
 	sess->sid = sid;
 
-- 
2.34.1

