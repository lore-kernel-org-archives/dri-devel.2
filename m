Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A08CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97CB10E255;
	Thu, 25 Jun 2026 19:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GYTbPnoc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jZGQUQVn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5FB210E247
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFe9422838453
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MBmzUwdpwOW
 8f0OBvo8XEGa9qbPb7NiLUabU+Y9s2y4=; b=GYTbPnocIofMqsHo/huqipvjJmd
 J0pUHz6JKq/DKk75RtGkNCC52Gcutz0fguNM9NE1IdBQRNtKlxy14lWr0togA7QP
 xqmxAsDAo8gZ6thvrrBelT/L6ucep4AXvEibIyAJhow5LTXczuEtqwb7mZssARZJ
 WW4GLiPgd9OPTF+y/d8o7OUYMr1ZW5ve0tLiE/4E4YrAh0RDnu9Zxgj+Bo3TDpO2
 yhWluz5HfenRam/iGfcoKY530n+0bTT3SMYmyLKmIVP+2ymbY8pyat31IQu9oET3
 /QYYMCgTpIVhC7vtMHstzSGhv0xApi3Orlc/pu32l6iCXDDNmAdwtB0qa2Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uyqkuxp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8a247a74b7so98591a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782414945; x=1783019745;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBmzUwdpwOW8f0OBvo8XEGa9qbPb7NiLUabU+Y9s2y4=;
 b=jZGQUQVnL6euh310cUGZA30Tq6i0hNCXRFDgpa/bp4TTWIG6qtMg5giEsg4CrZ77nv
 OLRabN84/ZQZWOoT7jG7AfoQNA45orWs3r02daFvwl2TzFX6SjuC7JOGnBYgXyrNfg1y
 nerDvpz3Y9hy5cXQ/e9Ib4UEBQZS/ndHnbPAY9RBdxHtmbLSHs6+3mD9oxeESBNDpDUs
 H5W0ppvC44Rvr0MLMkOYu9GexLgPBE8/bS2rnVN4VfaRRjdS8Jk+ReiuijWzedStsCcx
 tWBa8YhWGnIOQeDQu0Le/0XzlxcP5vRkggNtG/kklpt95yRJizdHJzahwDNmYXFzNE0H
 jaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414945; x=1783019745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MBmzUwdpwOW8f0OBvo8XEGa9qbPb7NiLUabU+Y9s2y4=;
 b=rixz010VsAaBGcOZ9VJ2vn6B8IY21qb5UzeftjokUGWAGm35dWwI7m7CJ1Ei5q80i1
 OvISzrMVCCCL4eGPbMdrg7WSwW8H+Ribo2LBAit6vttFkpaYlMpoIihLCdg/SHib+OpT
 HsEVAdvrNdQyQlimJAjmG89+ewLxgrUQz+Vx+leAjJ+GvZF3zkraYf1boMX4MPS/QY64
 j1TR+Q+CRwWLJC9LKxjJ5zAg6ovYzeMLQyj49CEQof8zscuelRJ6yPAs2qB+3B+wBPT1
 DLVpxruFrWEWFv4KWBIPxK148nCIHJqecyMkW5zyDc0kVY68ZQd1c5RLFa+bldy3Vu/f
 UvWQ==
X-Gm-Message-State: AOJu0YxCgcFbgqER9/4pj+iShUSlXf02c+tPgzbW1HFcR7Hu9NwwS4pn
 z5HyBHFyqRLF30TvApu4FXfopFu4jIsN3d0AMrBQSMJvWtk9Xev8m9iRzVNR3cb41bRyxPNfxh7
 sUxf3Q0E4KdOiXrjfieD6dYYUmgBrnvYAM84sXAq1fivKgSJRgA38+ZgRhPS8GCucL6SJc9fXJH
 0kL80=
X-Gm-Gg: AfdE7cmh7TLDFfzVYSR/8fUvssN8pluGd1jycMbqcjopVSrwhqjZrOd9yaHsCniU5c0
 8nWdooGAhrpPl+qVCoDw+VtPyh5It7tdoC6co3qE3/iYEBj18KDhs4zufUXo6HHOUlM8xPGEFJM
 QWiG+Fu3HgRF7QUcIKXtEGtvKixUdlf8z9//3M3iAucMUtTJWFzzQIBSKPCeroEhMVoOzceWk6s
 d9wxLP3ptz+vYbkPgsuMAeK4z6G/9sgua48L8xiPQRrTc64dajmMCUYpzMmqGjl1PLZVgtq6SKi
 DpHpsX00N7Ob/2S7b4lJiGKt/19wih27m0RUyH3hibv9NK30jszGG/zEJMeJHQDNT4O++pdM/v3
 a+1AHPhNf0P6OOoz+qbkmmBUr4D0KP011fuoesH1ndgk6LkIklW6GAyTozA==
X-Received: by 2002:a05:6a20:7491:b0:398:7eea:50a0 with SMTP id
 adf61e73a8af0-3bd4ad9023cmr4376102637.18.1782414944638; 
 Thu, 25 Jun 2026 12:15:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:7491:b0:398:7eea:50a0 with SMTP id
 adf61e73a8af0-3bd4ad9023cmr4376065637.18.1782414944010; 
 Thu, 25 Jun 2026 12:15:44 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c92bcb9c813sm2176638a12.25.2026.06.25.12.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:15:43 -0700 (PDT)
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
Subject: [PATCH v2 1/3] drm/msm: Fix barriers accessing ctx vm
Date: Thu, 25 Jun 2026 12:15:33 -0700
Message-ID: <20260625191537.47965-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625191537.47965-1-robin.clark@oss.qualcomm.com>
References: <20260625191537.47965-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xJS2wDMDHqxkP_C-zQuACCJaQMTg0riA
X-Proofpoint-ORIG-GUID: xJS2wDMDHqxkP_C-zQuACCJaQMTg0riA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE2NSBTYWx0ZWRfX2UkPZbI5+lIE
 rwICgUVL84Dh/xsDEu5kBxLtADT4YvWD5tH8iLhYTWSV0Cd/yJ/TbehwYnfEmxRHewACoMNbiPR
 fGzA7ykoGEo95S1/AGfZwAhVATaSqMo=
X-Authority-Analysis: v=2.4 cv=EsLiaycA c=1 sm=1 tr=0 ts=6a3d7e61 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PXeb_Y4BrUyLDKu8J0IA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE2NSBTYWx0ZWRfXzuhM1NY2LByr
 QXlMSE8LsxMQj6SooiSoAtBBCeYKYGqnyFN09lnWm1OH0xC1n59GA5lhzCwLoJfCrJCWfxd6Dvs
 3agM1I6C8/UNJzkxzr8+wNKJ4SnGrahmsHXj6Z9wryvqnjvFqXctOBb1Qnmszq6ihIboNxhtCi5
 JmzrMQQ/2SYdUUG6d0aRu0iGtTS3qWqO7+yn2VaKizo+qAlVZTIJobaAsLZHfCb8LSErI75P2Qd
 zM5Gvv7oCAcYG6ZOQW33rxQyG/xY1rkGBJKn1vTb988Puy/GwEWo7UVPw4NB23513N3948LCPZu
 7DxgymerQpEVJkWJ7wNdRm3BY4GpzTAfNGh+64Qw+7DtMKgVSfxUylHy7o59WnvW+Szl9fQXsUi
 /fjhZjWp6P6LOak6LQZIUddIl/y3sJuzFQ9Uc1numOsGXaH0DZhv86ZXw4SopOKN4WSKaTefkA/
 ExrvhecyExPuwpT3GaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250165
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
Fixes: feb8ef4636a4 ("drm/msm: Add opt-in for VM_BIND")
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
2.54.0

