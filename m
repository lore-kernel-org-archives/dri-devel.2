Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4222C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F3810ECD3;
	Wed, 29 Jul 2026 15:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SHTv4fE1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LpsLtTZ5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771A310ECCA
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:06 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3Fvm2194941
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6DIg0hlu8qf
 HUQoWpRSk0/2wgFEbxEIf2WTCugbqRdk=; b=SHTv4fE1R+3eIyGWde7C603jX+y
 Dsgp9SUmQUeoFY0nDGSX1TGtMDuMPXvDzZYEiQcgRdC9RffSX8ptriMsut7DLkhx
 sRu1FD39aI08Pg4teGEXzUFAd1N1HrUeaHVEzuQkjz/JPJ/pymgYS4nvZnzasfXY
 JE3oKFeZMrbSKmCOGfQUdJBriNoELyuYpTj13lC5ALLqP/Sc6JRfnErtIBCoHWba
 PPWwam/+y8BTwsUUKdjpg3UWzCmdD9eMGTjAn+waYjSJZJhUHtoMc1t3cX+qIgCi
 q7ds0sFXOBn0Jn7pOlbCdHrqtW6dW44SaSQPCbbAD1N2OyJ7Hh8/JPyDm8Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkfm8g7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cee894b3d8so20181265ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340624; x=1785945424;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DIg0hlu8qfHUQoWpRSk0/2wgFEbxEIf2WTCugbqRdk=;
 b=LpsLtTZ52AStSGH0n0LUWc9XTwiZKeRXmtW6Zp4bvk+b2iexWrbC+H+Daa/e5OqdGm
 MIcs+A0b/G4WU7ODhxrf9mySQJp/jpYMXtiqFugR1dJgt2QlmcEAWmivShDxBemMyUFe
 SuQ+0R0rvSZsXnHBuSwEaraIPo2odplneasDv3FIvTw7192++Sa9HJyoKQvzyAYbg5gp
 5zZn9RvuUfY7YEewWpoHS/b6Nwbk5y8sYF6nZkYyYk9xP6Dwyo4z8qqi4iedg+uIW4AT
 Ee3WwLZDYJAIlPc4qRtZ3A1XpIdIQ8ICkhSoeW2WNQjmN/P/VOfC15cic6QPOrwfUpBX
 Qf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340624; x=1785945424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6DIg0hlu8qfHUQoWpRSk0/2wgFEbxEIf2WTCugbqRdk=;
 b=llvhsPZPlAIl0W88W+CoRPhRMQQx+luP+5PiMBH/UTEdMauPbqis4ApL59u3/ZQKhe
 fVjIfsF/3h3QTM7T49K7UQVgHyE6OpNPh0v2yQ5Rorz/0HENpTGFwZPhPn/lm4jr5JWX
 Drz0jSAFHWyiZZKK8KSF73iJg/Gtjx1CGOyj6vh8eVX3nqebK6mViFLZI0EdXglKagKD
 6Unoj/X+bzeu4SGoKeWRNCToCEHI9wHZtkjYMSQX3oc24fyiNfqPmUad/z6S7Z5wcJjT
 /wxOVRqjy6sIgoDLl6+581qbtmfnUuwAo7u6VRpyo8uG8rFBpOlo48tMFFvvBMLTbuN3
 fCrw==
X-Gm-Message-State: AOJu0YyA2Gq3EZ4m4XTIcWhm6QKWrV0uKkngnh+zBqcVGo7Shw264HyF
 py7xmi0+Jm99CjRIyGz4SdP4ZcrTIlsziJdW6Ltqub8UKX+gtc0cVQz6rtt46a5Fmd5FHWTpaak
 xdRP4WEJMVtMRDbn65v4gwAlRVVZNTBIY9ZhGh725EyoIPW3to6E8IuFYRav3UiU5d90/tXMasO
 iwJfE=
X-Gm-Gg: AR+sD11EGEMchjX1j+8mJr54zQ+rtpkMWinaTRGD9ARzOqkT3cgEEUIfm6Uy8zwAk62
 hIrsVsEWlSYnL1lSDn3R5aAYUNJ9tDL8hxNdu/4CdA0OHkNzMB0JyboQrb+UR7Dhis3rSQryHxf
 itcUEV4Z9x4YzjohvDX/dHITaLE57sxSAc9/A6caiDK3Kkz6Ci7/ab/fnWLgPvhwqjcNaXyhbL8
 5H7Vw4w9J8jWBSoK3W911d89XRgDK7c7brTzIiGZAq5kgYDVmObMno/LIGr+CxSjpbSmWy1Id76
 KWcNJUYvXH9PmzuSWE9w1QpJb+v0L4okFYhM6LV5SM9NePKarzdqNmcIHY7x+KY55NkOYWdAkg9
 xPGyFTR39eNnR4ZN4Jjs6YuXe3l3nyl958XkpXJsiPS0aMGw=
X-Received: by 2002:a17:902:e5c1:b0:2cf:c532:2603 with SMTP id
 d9443c01a7336-2d015f0eedcmr84854685ad.35.1785340624182; 
 Wed, 29 Jul 2026 08:57:04 -0700 (PDT)
X-Received: by 2002:a17:902:e5c1:b0:2cf:c532:2603 with SMTP id
 d9443c01a7336-2d015f0eedcmr84854385ad.35.1785340623779; 
 Wed, 29 Jul 2026 08:57:03 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022a151fbsm13620435ad.10.2026.07.29.08.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:03 -0700 (PDT)
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
Subject: [PATCH v7 08/17] drm/msm: Add helper to check for per-process
 pgtables VM
Date: Wed, 29 Jul 2026 08:55:45 -0700
Message-ID: <20260729155609.20190-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D6p37PRj c=1 sm=1 tr=0 ts=6a6a22d1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=4aDCzPfTH0uMOhJcsooA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Y2la3emfImSM6kVJ1D_4k5txsnwEoPbm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX5u9v515EczK0
 3TGqZUCyFNbYDxFsz8PDO7CY8x9GN/ldhk7A03uTxmxrgc5Lp+6WfvHHz1o0ZwBnLNVmquLEAZU
 HVW8j5/aRU9i4qt6Lj3dcO0Y1Be+adc=
X-Proofpoint-ORIG-GUID: Y2la3emfImSM6kVJ1D_4k5txsnwEoPbm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX23PNKfjAjk15
 jYOMLAFqYQe1A2/nGiLCamg08/lJQz6o1py0iIsXtlvfU/VlTBeDXOF12y1Du/pHRG5rDVw3FEU
 MMhrPCji0fcKKkozCenkw5N9hq3DquNiVdKV22RbF97BFsVfbwGwr3IFUuELftD/s3Sa/l3V3HW
 QckfWfyzqqGmeKNIc75M8B6T7grj9QlGLhSjlLj/LgS+NPgKmsdzK6sAAI0QHxavA4IwU390Cx7
 HTgC2qB9bG4T3J8gDPzTpsdnM9uimUqtoSwIdpT9a4ZnQeQ0kuaOEXz7epI/ApK188uJw/kjYk8
 kMHwYd5lI+GQ3dkNo57N1dZtIRX63+99dx+HeGDihtn0cTcWRpucLpyVUV9QEvl8xC/wQ1/bMvi
 k6RubcS9sm6EgoX2+tIP0Gr+FDAgqIZqBg0Q6fR3RKUtdz7nf/RJHia1yDWyksA8ksVK69tn2iP
 K6p5t048Qul5U48ZxUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290127
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

This will simplify a following commit to allow lazy VM creation to fail.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 0d54141ff089..5738eac9aebd 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -356,6 +356,12 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 	return 0;
 }
 
+static bool
+valid_per_process_vm(struct msm_gpu *gpu, struct drm_gpuvm *vm)
+{
+	return (vm != gpu->vm);
+}
+
 int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		     uint32_t param, uint64_t *value, uint32_t *len)
 {
@@ -414,12 +420,12 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = gpu->suspend_count;
 		return 0;
 	case MSM_PARAM_VA_START:
-		if (vm == gpu->vm)
+		if (!valid_per_process_vm(gpu, vm))
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 		*value = vm->mm_start;
 		return 0;
 	case MSM_PARAM_VA_SIZE:
-		if (vm == gpu->vm)
+		if (!valid_per_process_vm(gpu, vm))
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 		*value = vm->mm_range;
 		return 0;
-- 
2.55.0

