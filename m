Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6980FCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5E710EE3F;
	Wed,  6 May 2026 17:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oMnc5Bn1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ald1lfxX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B4B10EE46
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:12:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646CxcJY529417
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 17:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=V4uUYe1yUyG
 7QRKd8WtYyuBLYfX08jPs1+jI/fe/6lw=; b=oMnc5Bn1/wESrN9F0tHA858g7/o
 sSbECMG/4E4UhxTBSEsDG/tnP6zNyXGUAnNuVwX7IAgR/5PMyaWBGnt/YhJsqTKn
 yLKGvF9kKhi05ciJ5XkjzvtfzqY2B+RXlOOXYgw+GP5QV0LwJH8webNlNbmhV7A6
 SSjcRe1bknOt7wDB+yD8M4KZ9bbNpqJwZFtjiOTtjgsYLtgTIl2Ij2mYY3HCV626
 p5tiPNdxMTXby1mYlq/mqHmFX60lfvZv2qXJE9mJT3hogmOVjujtxyqhDbRZFPGk
 78unQblFSsAf/CRWKK0zFcvlhN3nqobLq0lfDbZ6bDIaz+gUfEiBwJzclTw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e015xac3t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:12:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c822ebaa40dso1532460a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778087533; x=1778692333;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4uUYe1yUyG7QRKd8WtYyuBLYfX08jPs1+jI/fe/6lw=;
 b=ald1lfxXt86LSkdBZMUrIiA93i4en55vbQXw53TQ3DlRj3aOk/4AGFcZPvCXGNRtB+
 9ahLxs9oO8ywpktewUuKZBcZFqS4oTF6aynaLwN5gzQ3XGn+7IpBFioUcCH71Ur9ReB9
 afbWUEiScneccI0XQlpGaKaW+frY4TsKG94qhUnsmCOs8Mxk284Ii11E1ja/LalZbwmC
 ELTXOZakr1VF9MVAb6QsMwSyGNQVpL9bm7ZEHc6rl8erroTFPDytPmZ1ChLWWUUEjqyK
 H+iegHra3GcpuDsr8z/76XqBKTZ73Eq8RNX2Tf2o4hZ1Mz4Zc8ZpBSj5Q3h233aBLP3s
 Ak5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087533; x=1778692333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V4uUYe1yUyG7QRKd8WtYyuBLYfX08jPs1+jI/fe/6lw=;
 b=SqmbIAw+JDwLdmjJz7aDlXjsi2fuFZE6lD0LSMFt42SG8Yq5zFM99YBfHbDtq7Sb+E
 vsjI/i1FLjZwDmFwiXSydNsyeU+94aOvH0oeg6GHa7IMYzOIFfSFDLW+Tg1a0uxHOqGN
 Ke+s29uVeQVOpm87SHSc7V3HKKG9MvadaaDQGgKIVHiE9va2lhlMSuESVrPevJ3KlHkX
 fh7lvGY/h5T91y4khSkqWqyHXUXMwpm+15nhj3T52lpUXASwi5ck5J8b7ZLOBdvlSSy/
 b/AIIYJ9C8fw+/rXI2uKG2tfbpxKGRLSA9oGprPNRhgWaQ/j4GAC901cd1wLDSnVYAje
 v3Ew==
X-Gm-Message-State: AOJu0Yx6BQ8MQrO/AsdTfYlo5cbEp6+h4IHkUBwkI5SUlrJ1w2Wy65w2
 fsEdA/Ze/a1XjEf82ycKZZRWK11QoELocIkfkmXWoLkeT7MgPPI4+YN+rRagOM9zWsGXdKFzwY1
 gXkF4WsegTVhGx2kqlT8LG2l9auIsY3QDJUGb1XibqM5uJXt6RQGtikGNBdG+EDak/aJHsKdi/K
 tDeqk=
X-Gm-Gg: AeBDieveYLV/wEpOolT0eVltJatEqJNdQiFOHghG70atUMvRkp0ihXnLePfscp7Aps/
 pgHi3csmzCv9CDlyunMrl02ON4cTV/5vRlGxmqkQbDyM7JbIT4UsGgyBi8vXpJeFLKD43UeKvUD
 yxMbQWSytXmksckGrltPDU0bnCOBLZ6c1o7sjYBqV1ijVL3fxi8LnfgrmVWKy5XrsngLhEBC7VZ
 wbCY9KswNUWfu9yGKmPTOb+AD/jlmhxSj2PoRuqdMl27ufNwXLrOuZKzY7fxdUIteAQcsQaWj6y
 3o39kuukZsO01joxeiIP85aIPtUX8du6uOWFiDZ9eWCkDQ9iPmAZOoJm2R5aJCypP5/B2vxnwIw
 0UD8lr5Pf0gdr3te5sxjPAh2bBjHyoJoGJ0AgOP5tNwM=
X-Received: by 2002:a17:903:3bd0:b0:2b0:7d3d:756a with SMTP id
 d9443c01a7336-2ba794c05aemr52703085ad.35.1778087532907; 
 Wed, 06 May 2026 10:12:12 -0700 (PDT)
X-Received: by 2002:a17:903:3bd0:b0:2b0:7d3d:756a with SMTP id
 d9443c01a7336-2ba794c05aemr52702605ad.35.1778087532341; 
 Wed, 06 May 2026 10:12:12 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca10828sm34251455ad.56.2026.05.06.10.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:12:11 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 14/16] drm/msm/a6xx: Increase pwrup_reglist size
Date: Wed,  6 May 2026 10:10:38 -0700
Message-ID: <20260506171127.133572-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Os1/DS/t c=1 sm=1 tr=0 ts=69fb766d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=8lTVeMJbxB4f0FvlbnAA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 7OJblXr3rDMz061vaSTbdTqwJIbl_rBD
X-Proofpoint-ORIG-GUID: 7OJblXr3rDMz061vaSTbdTqwJIbl_rBD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OCBTYWx0ZWRfX4ThLAOh8HDL9
 DxcmD5Yywe5IBIR9EaKvRUpn+mlGcRx0lJnQpg7s0kP4q+1UH2Kmkb7fu0OIvS7302VgV5aKtc+
 gNs3n8H4biuThxjRhaIBnQp3/tzupIQ+ra7CjCOxhiGD3YOTUvxTPAgPPZ6LXI+gpS/tRuQkpaz
 MWPnGF6cvN/ESJhz3Y0raDKaMe+Oi0p9xqR9LP9AdI+khk3YEtxSMpNvT6ihMgAXsJaV9T5rqsD
 T2+YuBKqlbnamE0DeTAlN1DQCWvXkebEuWKujy+3B6zP6wgxSMjW6CeT/PM/zQg7yzsTDwaLY7X
 6C5R+48hoyeIm69WSxIGFREKaPcH7l5fojJpS1+LeFMyQEOw29gNtGMaQyDAYHqDknA35+drEpT
 f52ocEfolsvNbqD9SPvJGXbqyzXDRev4W0CXYjQf3vpEtcis14LIKj0iMwKO8BQfnfBoP1r5Psx
 qjDgxbbwIz9oTbjrSYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060168
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

To make room for appending SEL reg programming.  Without increasing the
size, we would overflow the pwrup_reglist at ~190 counters on gen8.
Or possibly fewer, considering that some gen8 counter groups also have
separate slice vs unslice SELectors.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a329d20033d7..61c6b0e781ce 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1183,7 +1183,7 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 		msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
 	}
 
-	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, PAGE_SIZE,
+	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, 2 * PAGE_SIZE,
 							 MSM_BO_WC  | MSM_BO_MAP_PRIV,
 							 gpu->vm, &a6xx_gpu->pwrup_reglist_bo,
 							 &a6xx_gpu->pwrup_reglist_iova);
-- 
2.54.0

