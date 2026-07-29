Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60028C54F55
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A8E10ECC1;
	Wed, 29 Jul 2026 15:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbAzXx1Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="er2NqMvk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC77E10ECC7
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TFFlUH2092562
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CCt/FUCHkSx
 E63Ah7s7mIN0CuS0Ln8VYXya9PKCt1vg=; b=BbAzXx1Yixt4o/EdlUKj+9Ws9FN
 +xbzwmhrIpr04/L4n58yeyn3GQuxF7Rw5dk+cRvJA9dX/btPccWhS4XevqbcP9yY
 rrncA9Uu14eDLyEM0pbaP1FAAy9AqVqs3PEOaGjSb2gqNoth81wdGv4TjHIw0AUb
 7Mp9RDTRJcuL/JvyZRWq2DMdtMQrihLdpazzmLePcuTU5vZrdwK8Urn44wUU927V
 YTfOoICggZ8JYn+Rda8VGRC5h6I/izpjns55w0Oq0blbIJywhOm6RT47+KUDFqb6
 /wji3TFHk5q8V85yOc7jojkRttV7IB1LQEHUyZ/G822d/wurG/9iw5Xbw3g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqm0fgb5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-381250979d5so1179787a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340615; x=1785945415;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CCt/FUCHkSxE63Ah7s7mIN0CuS0Ln8VYXya9PKCt1vg=;
 b=er2NqMvk5DwwdbiQcFrcm45lE866c9sVgTTenITfFFFEROLa7iQKoa0kKrWPOg6wK1
 P5+eq6BH6N/Nwr9nhqsGsUqnxI5dnHj2hJmUgqZOmPyrng3dWaEfI/97eIhCzYHAjdEO
 iM2Bfmf6VkSga3xwsDgjVhEPHj+6KtzfzeOfxWAg+zxzhlSKF4BYQf9LkdYs6uy2qlFp
 47OGyMwiK7arcclkxa3M4FHCn6ytcBayThl9IITTk3LK8qBuIWRbnuSMuq6cZWOwLsia
 DfEAAR8AKSeJeIUxLrwmzQMvJMt4fQ0B9VmbZA2Z/jTIyzd5mqpPP/3eMITXP56LJSYA
 z/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340615; x=1785945415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CCt/FUCHkSxE63Ah7s7mIN0CuS0Ln8VYXya9PKCt1vg=;
 b=KMRTw8shB20wIa0Zjz6hplip4PdPr/sOOUSCkGdk0I0Qv3O3E+PDfoRxexXIV6Pyt9
 5V3eZS8GaA6d2CcjoMsdsvGkXcioUfmwkWCR5aBJAx6cuNxIZ/D2VKiYB/rxR8TSRRUu
 lj9Ei9ZXh0qkL49TxbJN4CoRU0l1o1K5SR+zhUxmvNN+pbGUSPotVqrhD+JS9Mp778Nm
 T/AIzApzRynKdz9L/1WzUIDDkZildh6UUJdNVRMw8RxELeiJePTy3icev3kgCtQBF5LW
 oH9EopF6mBOOz3o41wDC7M+ANmFsZVB5KCNrz+zKmiW4I5LzKcGmK42K2881uZNTi7R2
 jWIg==
X-Gm-Message-State: AOJu0Yxr+FoDv0nRftQX+oo2XRoJ5hQHKYeFzQeklUCCu5sZKwAeP7O9
 jpUl8cYxXsooWRQYL2XOIjrUHqPcfdWM6FS5va2EXtJpg82bxuHbBh2pm7wkxeykg9KWiAXa39e
 K+uKBN//xo/eq1a5dm3M76CfEzEGbglTWNTsSrj+xEDs9wRvpKmuLTznppi+rPkOEbKXu1IgQkX
 p4+Qs=
X-Gm-Gg: AR+sD12bXzuCf7ox2QwoAWDLvnoyxltsufSdIcqcXed+cke0jfb+77M+GSsDm2Jymz5
 7Ql/v691M8vxQxOBqRhg0xI7YkC+DiCyhQVEv0OZRDkP9aNSL/H3KqAdBJboq3PZKW0cZ0DfFFz
 KVFrurt+PuEYLNWQelhGe3IkVuMNG2a1NlyZlJ0UNqaFOh2yWA237J+aKdnY81B9KceY3GAcQUp
 +GBWgKg+NVj0DLJJ3ZuigMSsKX/EjprJJI+G8TOWXMl3kq3gv9vT4kfp2HHe8L4P3iDbKcfWuxn
 B7/WHQdCelZRxa0lWDK2MTVDgOz8qKDwY8fF0y+f+HGx0ajqjoUWLVtTBiyodKSQGRXYogNQSQe
 bvSTl3EMrGZgDfJbflJ8zRHgGyIeQtsL2MvBxQ5uusZa47kg=
X-Received: by 2002:a17:90b:258e:b0:387:e0db:bc2c with SMTP id
 98e67ed59e1d1-38f6a422e25mr7851769a91.34.1785340614591; 
 Wed, 29 Jul 2026 08:56:54 -0700 (PDT)
X-Received: by 2002:a17:90b:258e:b0:387:e0db:bc2c with SMTP id
 98e67ed59e1d1-38f6a422e25mr7851733a91.34.1785340614131; 
 Wed, 29 Jul 2026 08:56:54 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f2b690fsm1637860a91.13.2026.07.29.08.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:56:53 -0700 (PDT)
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
Subject: [PATCH v7 02/17] drm/msm: Rework queuelock
Date: Wed, 29 Jul 2026 08:55:39 -0700
Message-ID: <20260729155609.20190-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yWzkoe6LYx5__7sJoSfksdWpdUXu9hIc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX4VOBPZUSbNRN
 XMZCyuuXaUO6co1aVzOnPT6T+gx93mYL13zlpskKZdDQbzQ94Lw7YmoMt57CP3uB+ifg2xAV7Kt
 fLerEEfPrDV0bbCaWEXapXfv8C3qcwuAYhdRXxalZ2mCguG6rgK41eGif6t9yW9Dh0fyNcUYHFK
 OolMy0PYRzm+ZUNbu70k1zN2uaZsuCSQrtbYPBoABBqMWEtq1IhcjGB4MEoa6A+tGEES2BlTiou
 6rBCpSO/RAG/un1F80IufcNi8hUvu3CgInH81Q4hL8Q/34414JJNW9NWPqYswBBPoWFtnzzQo32
 8w96i5EHzpUrp3PpEI5PloK3afGBBjKYlxst0UTstEyHUZk16pst8S3MmlY4Wzg0EZbJdgyQD6f
 IwJXRQgowoRZ5Gf/bB4QGDZAl2WDeUcTcFri9x+NwNDrsOu//6qV72MAQLGpOFGqNmK0l8laBHL
 dnJ+iTPpbL9H0v4JyNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfXzcUKT1exgJgv
 m32mjmRoe/z5Q1+Z2DoUuviFDy8cJPhH6eV3nfGYsK/1bBBU0Lp3+Zy/cpzoeXPHV881j9gjpJm
 6keb0k5qsjuQGPpUB7+GoTt1LaCXOqE=
X-Authority-Analysis: v=2.4 cv=LvuiDHdc c=1 sm=1 tr=0 ts=6a6a22c7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=2F56w5eUDQPWH_qpgLoA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: yWzkoe6LYx5__7sJoSfksdWpdUXu9hIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290127
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

