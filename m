Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD08C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9831110F3DB;
	Thu, 16 Jul 2026 20:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MSi/7gll";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jfrIMJV9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFAA810E686
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:53 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJoc4J3791887
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CCt/FUCHkSx
 E63Ah7s7mIN0CuS0Ln8VYXya9PKCt1vg=; b=MSi/7gllwQIi/Vxt8re6OlFaTcy
 q7m+gYPXopRP901Mgi5XxnsuhUPFqrLlinUDfQR+Bbbp5BHEyA+c4BfDK2cwvduG
 x6hL90CsEIakgL2ciL0aGpP2OR+wx4sK1dTDMzE81zm4I9LeUT9P23PdI6YAuF0f
 bC0aKe6UACPBGbVFl65CSQAXwx0PqJdRYcwK6KMaAl981Fz0FaTNNbzbh1/stAQD
 QIwhQ//Rt8bjoD2GsY6ekmuYOhsWD6dDkk4kzjExXkM1/I4uCYhT9/K9t8d5DuDS
 M8ftW02xfW5LUTktrz/lSlecVId6uAvHJ0/mzIFllX4szykXI7Y71uGmESw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feve1tyqd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cf27789c79so8381915ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232951; x=1784837751;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CCt/FUCHkSxE63Ah7s7mIN0CuS0Ln8VYXya9PKCt1vg=;
 b=jfrIMJV9X7ZAcxL0ZlUHV+IRu+PcX9nXVgn0X7LYoZuuxHsI+aS1cia35+W3cLPzCI
 iFYvzjASzf1neaqPgSSzqiKhhSpsN/X00+cOVPDGpKnLO7TcwWZhUlR+FeqDJZ2AIyhT
 2M3MZ4otMvmi5elQf3az/5urQv/raZw36b9nE1dAvKo47mfV0/vO2BT5DaGAcuZ0j0NI
 92W9cfxNvlJ9OxLcspNdc9+CT04odnmZykQtRjti01YZ2w1i11J/jD+HNLp21hVvz7Ol
 P44vrIQUyLTDPoDYDIyv9FkNrlCcJ28RX75V4KiezfzmrwO5RL3EDxie/VTh2R9+Bs9z
 +oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232951; x=1784837751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CCt/FUCHkSxE63Ah7s7mIN0CuS0Ln8VYXya9PKCt1vg=;
 b=DXmcUy3m4FM+JMBe0ZNEo7OZyGo6sPr3DgVWDzL6Y4yY0z0yrbaVrJx2eFJmWNe+bx
 2HdpnmNR+aD6H91Ytu7HPmotjkBtnC+PGmiFth57r8ulapVhn/DuNEzG4Mkvh4ed8PYo
 mZDK3Jqhkdx1Ka9jixNspe8i1ybkPyFrqA2vI/5NA1tDHQsnDv6pv7ZIPqRvNd9/N99y
 mVTzXa3huKOtzhTt2gSOUIgfssSr7e6qqcsMFxwWgcmhl/+2B4umdbZHTyj+OMRLtQ7d
 1aX3211IKK5u30nDI5lWtlLaV9pPfWc+AJS9TsTM8HJKvJVXzzdNZ4r5S6oZlnIZ75+z
 kkPg==
X-Gm-Message-State: AOJu0Yzq5xaTxmaOa+0pScrzOppnr/aEczsSNk+vroN8lzHsd6yuPqWs
 nA/5bKWg3xpSqb12jGD5gk5YMgScNWZSNTYN1/2tWsy75Lgdyad9s/NXfkDATSqlMPYpKYjNqAv
 yFw262rHduWDN3B4JzvIM5hWEHR/PkNWpvQ9z3yVJcwNjoTv4Y6D/VfGYzLW/b9bOENxAjxC7J6
 1D7yU=
X-Gm-Gg: AfdE7cnYwcnsiB/H7gaLUbcKyTZYvpFRveZ0RU+FYxqavnMsM8897GKHMqY7HZvUydd
 MYVagD7zQNM8NDsRW6QKbxVXlSTNvoQaX0W/HG1EfKVIY41bomb6z89pHRBa0i6r4j5CQcX9jGY
 4NezakIXgibuAcby0u2rDRBNFqlCHg43cS3VJrlkGfLXrJLfVLA5m00DhLTu7WAfFQO0lOEKtIW
 1p+V5xYyLv2HWElHP+wmYGBOJn7PEhbZmMu3EaAl+ALsOyClhsCFCmUFaBZmFQllOmWxCTXBUgA
 M0x74bZJNaWb4erBC4jWWjfkcIGFL2zhqqkflTq0nVJXscjplmeje0RS6Fr85rmgHWO+xl3H7vT
 elfF+tjbXiuHkg0Yy0RfkkHroh66og9NiBT372QiqlQsRT2w=
X-Received: by 2002:a17:902:c405:b0:2c9:e5e6:8621 with SMTP id
 d9443c01a7336-2cf2ec21900mr10315245ad.25.1784232951452; 
 Thu, 16 Jul 2026 13:15:51 -0700 (PDT)
X-Received: by 2002:a17:902:c405:b0:2c9:e5e6:8621 with SMTP id
 d9443c01a7336-2cf2ec21900mr10314815ad.25.1784232950968; 
 Thu, 16 Jul 2026 13:15:50 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf1015e45bsm25492355ad.33.2026.07.16.13.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:15:49 -0700 (PDT)
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
Subject: [PATCH v5 02/10] drm/msm: Rework queuelock
Date: Thu, 16 Jul 2026 13:15:25 -0700
Message-ID: <20260716201538.365824-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX58Fm7x7SS9ef
 HhsV/T6cLpJzkYJpmxHC0n2PKRJ5fbhO1t2G013ZyXNNqtdixjt0enaj9TBCKiNb/+1LBChu3Ll
 EAcLdctqbVsEHIQ8gX5LgP2mGrd6a+qxHMrkRZo46XOHzU0TOWy8knI2r7M9xz6szanKB6yJXA/
 iXacXFd0WAU9+3vXn647lsjTS27PfHvz9r+oHufTeasUUi7VnT8bm7NShM0TS78Edbw9ZQu7ZSB
 JhvFTgPyrWjvQ7I8BlJ6eA6Cs5Eq4utsLtRRQhQTehmj7dM2+5uaqlbpSR6tEBhSIVhTLPlpeXr
 kxVYND7fQu+CCLQjszvBQ/kufnWU72SiOO53R2ZZv+1asdTbQj1v1O4Mx6rr0tfPuQPWdSlnX/v
 UzrW30cnhkJWCDKoYWkCi/TlKmrtuIWduF7AprNLGP+e797YAbPxChalIWxoMFixlUJHC/8TECT
 ggnvC0e4u60Jw4MTmeg==
X-Authority-Analysis: v=2.4 cv=DvpmPm/+ c=1 sm=1 tr=0 ts=6a593bf8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=2F56w5eUDQPWH_qpgLoA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: r4mflL_aZRjANSovSTaAEVm4kgEcZ3V9
X-Proofpoint-ORIG-GUID: r4mflL_aZRjANSovSTaAEVm4kgEcZ3V9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX6jsjSelLaSUL
 VHRznQ8xNUA51g9belN/c7elW1ag+BDJSxnxvA1gfvhl3FM33fz8qPIK+BmlmGmGS1IC+siIb7e
 m0ZdrGbXqrFT3KygAAPhjXxwpYtYv7g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160206
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

