Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2E7C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C832710F5F7;
	Fri, 17 Jul 2026 20:48:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E22jaByj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jLFGQ/gh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC0810F5F2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:53 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtSk52449812
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CCt/FUCHkSx
 E63Ah7s7mIN0CuS0Ln8VYXya9PKCt1vg=; b=E22jaByjasWkOCk0HKNaWi8ncn8
 1DRpNa25wDeziZu9H9KRtnJ1///s2FpxAXj3JfXjJDgxRYQWlJrKORdbU3LEGTwc
 qiGvO6YS2F3MjMYvaHhTqR1B0nZ2lCYwXSwnKt/EKOYhUQTE0aH7SYcfXq3lUoph
 qGqMlx64rXDCsulGTHwkcGpyxtIZjaBXHZscUHYCStGCexh22jwMqmY2/LhNtik0
 +bQRSf53ffUzUAVEKfNtc4j+9sXIxtU14tK3GfhMNr2FrYXUWBAKM/AOSO9wNNzq
 VA3Z2tYkAXv6ySiQeO4h29WZckGhCn1Qe+oU0soOa/NnjVbtJqrtptYZeXg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffj78tg6k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc640dfde3so57323295ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321332; x=1784926132;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CCt/FUCHkSxE63Ah7s7mIN0CuS0Ln8VYXya9PKCt1vg=;
 b=jLFGQ/gh33UL2yD1ZQQ89l1alGVK2uFJmR6y5WkNWz2I6SDdKw34sGsiahsWeXWDMe
 5cRC01z2byAdLX8DMlvQMuQLZ+8eQ8wiP6lyvLf6nCpBVUqJ9PiZKQuYw/8dJ/m0ATrm
 oCIf+4aE3yaRp7I+7ZBot0CofYOo2JG+QssEFAH/19DlI6tRJK2zXjHvTWWlNEG3oZW2
 +xYvJVN4iBt5uBYdSntq56AFLFjI9cS/Cm1K79vygpgjzYsKgydixJsxD+/7OImJQwDI
 im4ayfecpKlI7QT8MSWNY4su1xcdLGiDGsjEW5MEeYzBtz126tP+80YQJB+OtsLZxRxL
 JtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321332; x=1784926132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CCt/FUCHkSxE63Ah7s7mIN0CuS0Ln8VYXya9PKCt1vg=;
 b=Erx3TFuPzpzvyoRNRkPRNLxVsD3uwHrDNY5092G/RmJU1M34zXHuYLjyo6EZFlFvE2
 SUt/5UPOGGfrzU56qWbuEGR16fe2OU2yUrE0ROwUkc/p7WTphPZFeu+1b4inEgEOIig+
 pMFnouWPdDiW6eT50y4YrCAQ1jrxndvIdQL4ZV1k6CNzya4rM4AWDHWfKkH6IQOx03Nj
 fES4IbeSV9081ZQKizTzigA1I/k5+NomelMBMsBH1a3qNzqIhMvvncwDShhVysS/4KQc
 AWed5cijNc5ywCXykYYYhcyP0oAiZD9hOCvVgWgfecd/lakGTAfEsQiDWZz0kPi//Ap6
 TZOw==
X-Gm-Message-State: AOJu0YzfwMs2xAtplssAQLOOX7OKkz4EVEhj/UufMsMX4urCBH9wDxp1
 xx20E0eluuKfuW9VGQa8Dm+TtBGuHWrRm62q/Xhnv4l5clSGzP0wQPzhkkhTWoHTgzUI8oHkZMA
 oWdQ5pxHeylCo0p3s+McIdsh27MKanJAhfPyQFhc1wha7Fmg0acyIIKlVPklKEtGhEFYl/mbDVA
 nin7c=
X-Gm-Gg: AfdE7ckAgGE1LuHnKFuZWVe+InrzoRnoMasJdxhfMg6TYC9Ev2sybxywa6FzvK2jbaD
 9HKU08b7E2g+xoNzLeSd66chNCnn5H7L2JYru9tVNmw8DOgEQl5+aM2SvkxLvoihsnEJDjZkM9S
 gyV5rzwpvn7zkWuP7ubWua5CcyET8J8DXF+RtXYNAplzq8EVKEHgwas3tvJYbpvIQH4CNZsk8hl
 iR6qhI9Vto+dvKSdD2Jgr1aHWpbpSJPRQi+Juzep78P2IDXXlypRG/g8ruG1lduNYQQQiYl67yM
 i9qLpiiBpRmocDk+60N2vXv6Ckfr6YGMZsrCc4YwppQde5ULkpqRgW3AqUAfTrqktiLIfJrdjWw
 B4jTHlr6EmDmtP5jK/l9/yLN5h2ZCKf0m1jwbozWFzXuWHkE=
X-Received: by 2002:a17:903:324e:b0:2ca:6514:9201 with SMTP id
 d9443c01a7336-2cf3486f1ffmr48129535ad.15.1784321332362; 
 Fri, 17 Jul 2026 13:48:52 -0700 (PDT)
X-Received: by 2002:a17:903:324e:b0:2ca:6514:9201 with SMTP id
 d9443c01a7336-2cf3486f1ffmr48129295ad.15.1784321331921; 
 Fri, 17 Jul 2026 13:48:51 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34713fe1sm16812945ad.55.2026.07.17.13.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:48:51 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 02/16] drm/msm: Rework queuelock
Date: Fri, 17 Jul 2026 13:48:18 -0700
Message-ID: <20260717204841.26120-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX/biAjOGKyovx
 ANWPcQeHVpkQbT4vrfVZ4FedPQbVOa3n8PQzEzJlS2jE65W6/kXNIr1eowyX0oZdQnsnwz75Wjq
 AwEZ1pdgcwm84jYRXgSY/fTz9bMCDk9aYpdAsQoZMvqGBZMJ8JZMkBEQ46dKr1mtnIHP0iQJWqp
 EsT2Mg5W7vFgaCUA0UCj9pDLuGUj5yOU8o0bBPN1ErLqvPHH3bsmTzSxSBWTSt/ofh/V+P6nOhH
 AzR154Ko8H/yP+B27b+N9zkNuF+A9E6U9g5G57fWoHaoRqW8q5WqY6YE5plbS/y3WYXZSn9pQ1r
 jueQdbapL80rKq0HyZ2mSZG0DP83dl5iljKLm9VS2WeqytS4xsdRUatei2tdXTmGtw6yljpAeU2
 EECrEtRNuIDTcj2F/RY3g7M2E1Jq5Xh0vk+sjyH4YdEAaKPx55O1/qn3Q7viviMT4/fEwMD2pAd
 +xlAThkGTNAlEkNk/ig==
X-Proofpoint-ORIG-GUID: W6p40W8h12sIGATPZchdSNMyuNR0djZ7
X-Authority-Analysis: v=2.4 cv=U9Ciy+ru c=1 sm=1 tr=0 ts=6a5a9535 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=2F56w5eUDQPWH_qpgLoA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: W6p40W8h12sIGATPZchdSNMyuNR0djZ7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX018m2Fi1vN8I
 BkED5LvlJXMXsz0SuvNt1ztbepGhtYJaK2HSBP9Qcdv4gP0/zG60eUyENd1dzrQvg/1QJMYTLO7
 WGqpNDByNv0tWPtuWNQ6VkYPJP6auWA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170214
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

Rename to ctxlock, and use cleanup guards to manage releasing the lock.
This will let us re-use it for other per-context read/write serial-
ization, such as VM creation.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c         |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h         |  4 ++--
 drivers/gpu/drm/msm/msm_submitqueue.c | 14 +++-----------
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ec88155e0ed7..384f32f4d0c2 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -251,7 +251,7 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ctx->submitqueues);
-	rwlock_init(&ctx->queuelock);
+	init_rwsem(&ctx->ctxlock);
 
 	kref_init(&ctx->ref);
 	msm_submitqueue_init(dev, ctx);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 6c83b8cbbb90..d27d54bdb7a7 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -392,8 +392,8 @@ msm_gpu_sysprof_no_ifpc(struct msm_gpu *gpu)
  * struct msm_context - per-drm_file context
  */
 struct msm_context {
-	/** @queuelock: synchronizes access to submitqueues list */
-	rwlock_t queuelock;
+	/** @ctxlock: synchronizes access to submitqueues list, etc */
+	struct rw_semaphore ctxlock;
 	/** @submitqueues: list of &msm_gpu_submitqueue created by userspace */
 	struct list_head submitqueues;
 	/**
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 1a5a77b28016..8b5980d5a6a7 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -93,18 +93,15 @@ struct msm_gpu_submitqueue *msm_submitqueue_get(struct msm_context *ctx,
 	if (!ctx)
 		return NULL;
 
-	read_lock(&ctx->queuelock);
+	guard(rwsem_read)(&ctx->ctxlock);
 
 	list_for_each_entry(entry, &ctx->submitqueues, node) {
 		if (entry->id == id) {
 			kref_get(&entry->ref);
-			read_unlock(&ctx->queuelock);
-
 			return entry;
 		}
 	}
 
-	read_unlock(&ctx->queuelock);
 	return NULL;
 }
 
@@ -237,7 +234,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 		return ret;
 	}
 
-	write_lock(&ctx->queuelock);
+	guard(rwsem_write)(&ctx->ctxlock);
 
 	queue->ctx = msm_context_get(ctx);
 	queue->id = ctx->queueid++;
@@ -251,8 +248,6 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 
 	list_add_tail(&queue->node, &ctx->submitqueues);
 
-	write_unlock(&ctx->queuelock);
-
 	return 0;
 }
 
@@ -335,19 +330,16 @@ int msm_submitqueue_remove(struct msm_context *ctx, u32 id)
 	if (!id)
 		return -ENOENT;
 
-	write_lock(&ctx->queuelock);
+	guard(rwsem_write)(&ctx->ctxlock);
 
 	list_for_each_entry(entry, &ctx->submitqueues, node) {
 		if (entry->id == id) {
 			list_del(&entry->node);
-			write_unlock(&ctx->queuelock);
-
 			msm_submitqueue_put(entry);
 			return 0;
 		}
 	}
 
-	write_unlock(&ctx->queuelock);
 	return -ENOENT;
 }
 
-- 
2.55.0

