Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9755CC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDAB010F5F2;
	Fri, 17 Jul 2026 20:48:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HYVF7vDY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I3dSF/Az";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC6410F5F2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:53 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtXcu2887032
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5Uxk/s1mozQ
 uhwk+cHuG2u1j538IneDvUnNY45Gdb+E=; b=HYVF7vDY2e3C+8BC/VNnDuMIKRo
 Hb3vOjhGh50xH16si8F+8QaaqKqXGHly7IktU02xVR+vJBcHDZh+BTJ/JGAwAvA4
 kOX2SAA/wz/22H7j1ZJxC9HWReHkPL12jZoWfz2HVhjmJerLDhZR2uw5ENfYx+lq
 eNIQf3FvZwiH0M+MZ6VIkmPUKnHDX8andEqJNBA6WYJdMUz+5Yz8q0oILwWVbyTF
 HWyLI55qFBlCqGy2abo36WCuBWwwb6bGSh6AGIVX6K8QLDK0Ah4lmcJAHQFtRXFj
 Q6YDAhyeZN5TKTDIKPcmBOO/3HWzviH43gtDeYULA02ctSZOi0SUGg0gOug==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfjn4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so33915835ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321331; x=1784926131;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Uxk/s1mozQuhwk+cHuG2u1j538IneDvUnNY45Gdb+E=;
 b=I3dSF/AzoaglhLQamyM8WsgvKZouNrxOHMHexC5gEXhhMcBsWbMNjKDkpXlQDaM29G
 B7W4iJtMYfPdojadwZIBMqx989HqqBxzzf3Ji92b3VDdhCkdNq4cc4sCqCQLw66CvTlT
 y4MBClBNV1ZBplRuPX4lA/18Sqh6BeA8R6s9/fNYUvZxVLyz7/9hcbKkbSAT7PnKTtWu
 5V3DB40Gxsmbjmf/GyJbsI0OLfh7jRO1YcJXvuLf6/fzAgUD+VagfZLTsfdPw3vtGeWk
 0wFg8n+pcpvIrq20UfjVVPSwooLf26zRIHy56lGVS8Lrd7e0gN4ELz6LJXOPryWS9iyu
 335Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321331; x=1784926131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Uxk/s1mozQuhwk+cHuG2u1j538IneDvUnNY45Gdb+E=;
 b=IocMjJCKaM0ebYozAZJv0jCgMzmX/chKJsvCZRw9FfVHRZOziiqRzu2uqnSEcJxFzT
 ra/cGW64wigRDf3TGnrzUv3PyUVxNtc0vidAlL2u3ydghw+tKR/TXQyn6CKOPjr3GLNx
 dGtDz2xkxrmXpiptY6ubHnG7BlDT9zlXvH7oH6J2M3SNPAAGqTQUXhEkrqdNoKzg5NrL
 7OeZSwJfd4DjuEMAP9nHtqXz+7kHYuFDB9hHqlQNgohhNGsfE3UHv6PxjSA/1Q9OKh3G
 Un6dWniqpJd/HwrE57BBVBE3Ovwep+cShQQyIpNPqsVEtuESodlWKKsBnNK0XUOVEubW
 Oyfg==
X-Gm-Message-State: AOJu0YxTb7X6A83Hpy5zPZ38IZk+uwFMcZ2vNqx+GJFTFpjvVaOsZbEw
 Dn5VhFPgMsOvuJeFHFCMZz5Qy8Bdsjb4ckaukdoGX8n1i5EuKju22W/dFYX4gZ7+T3MsOihPqeC
 2h+2IcCstJqtfz2tElinrHAHQcKhg3ZLCpwwJaRoaj65E3oi/uCTBLIABbAcg/Tn+A46eJWc7gm
 7IRi0=
X-Gm-Gg: AfdE7cl5kpMgyeINvPQf0KOM50e+VfM8d7SpHNy41j9Nhg0DKtKKq0Xnu8pFJB9Ym1B
 sxWCBWJ3XXesl62N+vV1STA448KHQBr5Pp1eudLb9gIhKaC7wbsuLvyCaUuAO+K3SGwGlHgqu1w
 /lxXLC9/cuVbBTwMPQoBqtYd7j+WhI7XpC5/lIgSFb+Dvx4jlJuUWLhH86S140m+J0V4vi1n384
 gRt/YyrynvR1ETTqn4YoYLBtgUUEojR66ATMAwPTcIlco5PYVHTac7uIvCncYzGe+Ccpedh8Ijw
 bh3+QkWkmy5fiDiUa1aGHbyyIWBfbyTojC6gZu18q6pBRiXSeHA69SuLgtdWZ02pCCY+FZ0DEQ4
 g/eaOTOvyE7izFrZ3/9b69T8mqlusdVWLOC5xJReyFXgJTpY=
X-Received: by 2002:a17:903:1b27:b0:2ca:16:c169 with SMTP id
 d9443c01a7336-2cf1f2ee1ccmr94204795ad.12.1784321330728; 
 Fri, 17 Jul 2026 13:48:50 -0700 (PDT)
X-Received: by 2002:a17:903:1b27:b0:2ca:16:c169 with SMTP id
 d9443c01a7336-2cf1f2ee1ccmr94204325ad.12.1784321330304; 
 Fri, 17 Jul 2026 13:48:50 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34490c1fsm16779755ad.10.2026.07.17.13.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:48:49 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 01/16] drm/msm: Fix barriers accessing ctx vm
Date: Fri, 17 Jul 2026 13:48:17 -0700
Message-ID: <20260717204841.26120-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX0S/KR4KLikic
 YaftDwdR4qJFBHXggk+uoz16c+vry1KX4LA39WqJgZlFtTPDBKqukbM3yoVERby3vHbkHW6tKBO
 UUOeMcvvyjC2F4RGei14BlHddZV0PGWLYPDZaXH5NsZXuTTDyn03zdBKn3f1BaXKfnDC7L2EeCF
 3gOKkTWz/kZh9kSQMoHUpyptkaVMA2he42LZyUnz6GSvonApmA1G5XyheLXKL0G2WvBNMinP7Xu
 V8p8CZO7jSmiUqf2nv55n+G/uv5/x7FH81oYz0KZAa0dtrVbgfB5F2T8X8Ll0GtTYrkHsfmT23Z
 5KV5YV7UmeGjSyhI5br925+TdbLBJaboGPq4o2yeXlpOgmScXLlPQq/76Z3yWbg7HQPpqttQLEg
 kO9iwBsDtiEeGpRb2VDutMSwD4iitKO264R9d6tzHnbl2EwU5QV8daIaxY5X3bTblwHXUR0/cp+
 5b3sZL5liW9/OUP+IGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX5F0vNvih9VaC
 pyVtOG6eQ6dyKnoT/ZiZK2JT61mdmDBEqDTBntQbw/CFeO6YRVQFo4zurmVebojCniotrlLAvpZ
 LOMC8Z8JNScu9T9lJRht5YK/nMU1kHA=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5a9533 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PXeb_Y4BrUyLDKu8J0IA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: wSruoHWwrko37qT2_ivdk5-bN9BqoU1p
X-Proofpoint-ORIG-GUID: wSruoHWwrko37qT2_ivdk5-bN9BqoU1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
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

Don't rely on store ordering to protect us from caller seeing a
partially initialized vm.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 32d5ebea2596..ec88155e0ed7 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -224,18 +224,19 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx
 {
 	static DEFINE_MUTEX(init_lock);
 	struct msm_drm_private *priv = dev->dev_private;
+	struct drm_gpuvm *vm = smp_load_acquire(&ctx->vm);
 
 	/* Once ctx->vm is created it is valid for the lifetime of the context: */
-	if (ctx->vm)
-		return ctx->vm;
+	if (vm)
+		return vm;
+
+	guard(mutex)(&init_lock);
 
-	mutex_lock(&init_lock);
 	if (!ctx->vm) {
-		ctx->vm = msm_gpu_create_private_vm(
+		vm = msm_gpu_create_private_vm(
 			priv->gpu, current, !ctx->userspace_managed_vm);
-
+		smp_store_release(&ctx->vm, vm);
 	}
-	mutex_unlock(&init_lock);
 
 	return ctx->vm;
 }
-- 
2.55.0

