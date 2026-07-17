Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41200C44521
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68BBA10E4F1;
	Fri, 17 Jul 2026 20:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwrqJAeF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EGeCNn6A";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BED410F5FD
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:03 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJthGB2824116
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DUl9fsdKYPz
 3kO0o4cBY5wSMLk2mQuvR/wBV0AkKLB4=; b=XwrqJAeFroKkT6DMCKHKZmRuDFK
 UXiApOwgHkJ5QUxGS1J0lUqaguEdg2T6EOyVpLg5pvAWyisgatvW39xTvN6o418D
 2CgFvqnaL0kMWTAGXV77TbEtSNNaTBj/iFsak+4pP3S0Lh9iPlSn6IgJvLZtli6H
 7LiNdEJi9CLrC4V3+k9vr05asYNfJSHJkY4gcnqmyKAN/isyTFYxSxWOtcr+O/6w
 cNyG4oMT3Yc6Xsx/HBOoNKVvdF+fTJWk7YZCnhelVK4NO2pYPqk9W7+wqjDIyyZG
 r7yL3M6xUiWuFzk7ra7yEIYGuoaCiUIlrM7KQjdiOJnt8MLaLLQwApVFcZA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff8139p6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84240683a82so2050704b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321341; x=1784926141;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DUl9fsdKYPz3kO0o4cBY5wSMLk2mQuvR/wBV0AkKLB4=;
 b=EGeCNn6AiMcft1y87hYqSTXP1w8Ewz5iyGIToDRT2UNAW7xwPjlu5KUPbUheuJMulL
 44zm7w7q9CkIgGm97iiOcb5y1qBAmHSu8qGbcYPuRB71XLn5BavKF/1gObitjeD8omQ+
 o4/KfHOiNGCtqrcRvTzXQJtw2lk5+LMtQcLPcd4LvqWPboPhNm9tLFsOQaLrVathhaPN
 /CSvCTrKHNgJdF7KX6tUhWIdn/+Zg/4oT9LqxYK4CN//w0+UBl2sfztUsAlp9fBSFPlE
 JUUUz5Bs4WDcCneajxGYKvEpArBikiRTCCck0Dluaqo6qCkJx78MsSrIS0+bVd9iMeDL
 nD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321341; x=1784926141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DUl9fsdKYPz3kO0o4cBY5wSMLk2mQuvR/wBV0AkKLB4=;
 b=rbRUIfY0xfgzc+0TVRoGt52fsqs9SmcetYAqfMRfTDpCeHj2MhdpV1+tmEiFH0BcEl
 3cnZjd58q0XPoLIOABfff25Bdn2wtIgWYypaz+Yfyyz/70cpgDfd1rrs1A3c/D/Cf+VL
 585u+1LAJkT9DV+ale0nLpNiylK/Db+ZBq5B8NggaXeHbsto6JNW2vEBD4SDKS/GQ3Yy
 xw9dZh37oXEX+qx6lk9YVHHqzPHTAbiE9d9L+skz2vYdUoqaebENRn38pVBwuTpimOWz
 QQQ5fk1otYYnyI6hUv1zZBEEKNTCZDVXh4m3YZeyZuGWhJVgN4qAim+ZvP0g82NHaZyC
 a8oA==
X-Gm-Message-State: AOJu0YzasorpQeQohducHZnbCuJF0ZCVLXK7sNhHWMxzxailKLJyjWVD
 PJfYiSwTS2FvHZUr4tWOo6gJ0JG3FWPZpiV0dLuxTa/rCFyOaiD7TaaBuw6G3Kij9aOtpI5Kerq
 tsSX5YMCAVMxBk4hWtRbcY5ngfTUt7uDOegHx8xsez/yRqfRlaSs/5TE5rKC9GsiTOSzI84h6Gt
 WklYU=
X-Gm-Gg: AfdE7cni8tZ9WYHYvAcYnc9BwGlgAPLGpiZ2T8okMrnUTkWK0TAG2NwcJ82w5VjumP4
 zS0Azj8j29uugTcFbOAN2mhvdX+J+U+UrzN5LnmOqo64HGRbSaqtV9fBj4htt3ILpreqP7FVNU4
 0YAjvY0uc/Tti5+X+fdVwDNjQvMRggBfXZnoWsZZvu/ILYSkaTfW6+6DvB1wwOZ3FWqIb5eYqEd
 E3aCHgyxvb1hpHXyjkzxPB6kz6XJTpQmmE4J0kqug0K/6pna2XzGfuQi/wi8el+YB9bZYseQ5Xa
 NQTFl0y6RJPUvOz/PQmkOfKBZa+lDZTFYheUNFBjDcaDCebP8o7+Zf5gpXE6Sf13N2uibWscn8Y
 VELCWC6/fdStb7mNj4DbBciC6vxL5H4HxgKWk7pdICQHKtQQ=
X-Received: by 2002:a05:6a00:2e0e:b0:847:9919:e772 with SMTP id
 d2e1a72fcca58-84c28aa67eemr4402589b3a.21.1784321341011; 
 Fri, 17 Jul 2026 13:49:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e0e:b0:847:9919:e772 with SMTP id
 d2e1a72fcca58-84c28aa67eemr4402571b3a.21.1784321340577; 
 Fri, 17 Jul 2026 13:49:00 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2adc3466sm1742806b3a.15.2026.07.17.13.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:48:59 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 07/16] drm/msm/a6xx: Access VM directly in submit path
Date: Fri, 17 Jul 2026 13:48:23 -0700
Message-ID: <20260717204841.26120-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RbqgzVtv c=1 sm=1 tr=0 ts=6a5a953d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=QS8Fz2UHHwPDOV3g--wA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 2Qs5MQd6-BpRsDkLzb_0UhqyTkNGxFFV
X-Proofpoint-ORIG-GUID: 2Qs5MQd6-BpRsDkLzb_0UhqyTkNGxFFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX9HHibe0Mc59o
 l/7eRE5eDvKAowUOc2ddknflQd+70SzX7pDQI5O3klZyzvLz4uoWqNldTBDuaFeqEneQDjKg0aS
 v8wMC0AySKKu6Fq5uleOQSsuIrx1UQ08lG+nKKGziluPsJ6WO9W+lUKAbfraLnJKuWTa5lWq0fR
 w5U57xzWXRXUdwu6t+Vtd4Kwpn6IARTQJ0+6KvSUHYCAno3Cwu5q65oVIdNKiL630VNmiTloWKT
 AFYVbmFMsyO59ijntnXFvigpFD0NXa8CdHjKqkc6T3D5yOVe8BdBql5EU8+kMcv7vDWDv319vrO
 jD77EGIm4QpORjOIE2OCOK4kbU01IZy1sx8T/4d+HLrNS2lDng7K/xbxzKfYDP/oLyuM5WYVWvx
 1aOHmJjulzSZ8AtYPXByoOsW0oWgxVPOaMAQDGrJXJ2dvR7I+ntKvg05iB6GscpJxDF4z5OJBgt
 bQ3k2vWfcljQFhxmz6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX8h4g4F9BRLsd
 dmMfI27sXi3i0E0oHvWNLLQ2SczV2mOWmPnhdZk3jG9rCSrHCAN7ah0BK09sIqxKqAbn5c2wXsH
 Rcy1W+WeScMdqcN3Vb4m+oMIFWG2n1M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170214
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

The GEM_SUBMIT ioctl has already ensured that the VM is created, so we
aren't expecting to lazily create the VM this deep into the ioctl.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8b3bb2fd433b..7f1673163f67 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -229,7 +229,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 {
 	bool sysprof = msm_gpu_sysprof_no_perfcntr_zap(&a6xx_gpu->base.base);
 	struct msm_context *ctx = submit->queue->ctx;
-	struct drm_gpuvm *vm = msm_context_vm(submit->dev, ctx);
+	struct drm_gpuvm *vm = ctx->vm;
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	phys_addr_t ttbr;
 	u32 asid;
-- 
2.55.0

