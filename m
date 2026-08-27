Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AEEC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 23:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A031710F1E7;
	Thu, 27 Aug 2026 23:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZcYWa6a0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="if1zcuhz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF3210F1E7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 23:13:15 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RMe6Ew1541129
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 23:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=33E8rQb2qz9pdouy7xP1qO
 TUfmQulAHsDkpXs6kmzjI=; b=ZcYWa6a0IF4i2QVR2NiAImmaJ+BpzQA+V5ewBc
 QaZkgxqMK4woDmHmkrajT99bXyIztuWKhgyvTPZvPNodlbi6p+SjBWsQMSbUE4FQ
 IfTEyuy4Ul2iXhXkhb3R0WDzl80yzVzXe+gx/l+oMv5gCpkkp5z1DeXzs6ssI6R9
 APFpgQ0+HFzEjSCvVGszXvBWjvu2wFZebHfZYbl1yJhCpmBGAnoF4bdFhSwdO5L7
 q/3PeCej/mqxq8G1tBzObX0wKRVlshrhVa/yhbhmcJbGQWlZJJEFb7qFo4VvLKN4
 GKiBL8nsRikliYJO3kyciIoaIXu4A3KVB/fdU3X68oOVYUVg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0hn6w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 23:13:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52fbe82672eso690751cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 16:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787872393; x=1788477193;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=33E8rQb2qz9pdouy7xP1qOTUfmQulAHsDkpXs6kmzjI=;
 b=if1zcuhzlfGCyhZlC7RFp3SZu2mHG0N0KrAVt/sIDT5bpQL9CilOcYLD19jjjq45Fw
 WO+Fq2jWAqLGE82Fc0IfdxmVzyeaG/v4pmis/du4o4EiSaDEzFmc3edAHlMUkV/yxhSG
 HBhEQRT7WBiV5KIINDvK8Bb7frNfuJ/lIMbb/kHBejf7ru1t/xW73y3wOTgk0YMe4gCY
 ZNlR+W9AMhInAhK8hIC45O7wEyX0RAI61sp1PFBZdiKDx9E35o/6iEndZMqCE2EjGc6i
 pxSnI9GTbKUuzCHOmsLnbzoApO9UdPLdG/HkTUaUHLkt/55NUUxIZ0Wdes141SZRsnZZ
 EMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787872393; x=1788477193;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=33E8rQb2qz9pdouy7xP1qOTUfmQulAHsDkpXs6kmzjI=;
 b=URh5yLj8pl786e5oVPabhHBNTLSJ+3w3AkWkqbLfECTP0CcExYQFoNRAeMoDZwW+a0
 3tIxaXPSzhglzBWuxPY/lE7XzG4WEwg4uDVk4cpSJeY0O3JW9vZ75tlwZS2MPjdbkuHq
 APeIHjS6s26Rsx59FGwfjUAamBEOIK6iYTfbM0UAIJ1VDdDpZrUbkGyrYnpSCN6vc7Ik
 M+z0HWer5uja8x6vlBWUBC/Zlgb9o1zHHfRAPDzjGyBZefFxxQW1Mn4XE91VVU0TUf0m
 UkFdEBhIfqHZ1yk64plKRHi5/oheSJzUFPEmGoWfojqGovTybeg2x3Xo++vX2AQLMdR7
 aWgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXTz2KmHx8VBtSph2M0kS2aYF7myHqGtm/SbmaoH0Rq8Iq8eAoUmSeukUKHEU2RSsoq+XshQ7J4EI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++llihJtmRsD6LJ/1uTGoWDTtVnJzSnOAcXJFhh5lCtSN+SDMLGm
 PuVWZTrwU7vkbZWYhCrrrdfXWx2jPVyxLO50JTz1ttRBTZ0BqO9oFb7d/5TPVNbk1YYj2np5VGe
 B3+pAEI1dvaNYc5495uDJtxZVM1FxSaGtUcLa1e99FeIGbmUUYRZOBMUjjymPDZxbyeSLnNA=
X-Gm-Gg: AR+sD13NWvTSahrxsBwDEIfrDsH0ugcaRYPl02LRT+Zbfl+5bRzR7paugZqNWHeWAA/
 OvL7vTM+zY4XvvmkewgngMvVGB7De/uUsHGNZ/va0h/GdG8OQxFZr7uKA0YsDoFS9+36/NiLIxL
 oqPTIzUSN5W8o4UTs7sPkreUNgb1bHyLjdUK/bsSO1CE6CoMB41bUj15dl/dP1IUMxLARsEXESZ
 fmuNbQ6ejzw7LlgFnSQftAxdlVwGpePe1/ajFZYjoy/77BZnWNw9A89l+exuDQ/Q7B0Pwzw5+AC
 1Gc1fXfu+CKs9DU+IV+4Z8n6W7IihG0IEzBXf1RGEHz26UT74yu7o01DfcXg6YNtCm1/9qJ2o3Z
 e/U77acJ0pKWdld6ICBNhptneZijEHl0zuTJxn5URnv7gvnrMsBXmSM2LbjUkPXGPvVSzNcD0eX
 VgyblibCuBfesc
X-Received: by 2002:a05:622a:1789:b0:51c:6b6:9d0b with SMTP id
 d75a77b69052e-52fb9459c8dmr35895991cf.2.1787872392862; 
 Thu, 27 Aug 2026 16:13:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1789:b0:51c:6b6:9d0b with SMTP id
 d75a77b69052e-52fb9459c8dmr35895411cf.2.1787872392413; 
 Thu, 27 Aug 2026 16:13:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b5e8a0ce6fsm12281e87.61.2026.08.27.16.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 16:13:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 02:13:08 +0300
Subject: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIPEkGoC/yXMQQqDMBBA0avIrB3QGDT2KtJFEkedglEyqRTEu
 zety7f4/wShyCTwKE6IdLDwFjLqsgC/2DAT8pgNqlJtZZRBp9GOkcKGiVeSZNcdJ+2Nbpu+dn0
 HudwjTfz5X4fnbXm7F/n0W8F1fQHmDVh0dwAAAA==
X-Change-ID: 20260828-b4-adreno-timestamp-f4c846391b97
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5091;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=h4R+ZpPIgW1F2JqTClcK8P+aNB8FKkfZNhNfzSGejNg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqkMSEl+lL1R/y/qyJedG8OzQi7/ysAH4qNRQzL
 Ua4JrIBrmSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCapDEhAAKCRCLPIo+Aiko
 1QxDB/wNtEpO694f+0xH1+PcmXn88IC/VmZJzwln0Lb2qlJyrRNnKKddBdM9tkNWnH6/BXZ5JMf
 FHm/yIdZx8A6CnGAjDPEPbOHjAW3oogTpWFWIuDuoGgnw4tJ3KHVOParuIPUKHRT3ppwqGLFAIM
 SFf3ZmWZTeEC7EhJPnmnRYcEPq+maG4cW3MAjVRnZDJQrdACCAZZzO0xztd1UDiofvKd6zqb3dQ
 F2RIIspdDaigjOLAiJvv+RF1JbrIWUZLAIlEVC7lVtJMyR6YOchf1DCRD2SH3sKoeKmmDDAaMxz
 iNk4beZIHPNunEYXGOBXmVjv9vuGALa3trmrtB3m4kqE27QI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5NyBTYWx0ZWRfX+RpKe33z8h7V
 Zxsa0waNy1AbZvHkbGXFbv7Hnv/DGvQyGrkYLGR+YtM3qbnz2PXEUWz0as4JAKk9bgSWrUx4bLu
 KFwGwnX9dSZ1eh7HosXvkeF5KHEOB4MUDk6sIFPtGfxJQq2G1nhnh3oApLWrd3pFpijhLS1S37A
 67lUV/YmxkKsdI93FurDfv7SUpO1XkB1A1Z4AdVAJWuK9bXKX9E/zLIuZap5mCuZVLS6O3hN0j/
 3YM7qn9A1KtNizuPVgpU6CIF3f3rzeBQlJhmEvaX6EUR74V7utoopw9SAtdoy16oXvlT3Gt64kj
 uW9UWVHMIVXNfvrTKojMSloSiuS04UwRhzdVYcRsw13lkTvM5+ICknxhYXB9iMvvm3QIWmopMrv
 w0VIYNCZ/VtiStS9NGWvSs+z9Qu+MOupw8xuUfNW7ff2zNKiDEygkIFYJbe7OaDiy/8fRpqVAur
 JvTuDRE5YEFkCKLO32A==
X-Proofpoint-GUID: pUNTWe6vKidvPTQkkdoyJk1oI0nh6jni
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90c489 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ShAjJNOzEIEqusN_WzUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: pUNTWe6vKidvPTQkkdoyJk1oI0nh6jni
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5NyBTYWx0ZWRfX8Aqgh8mIIRXG
 5QXmZL6tqGOImtg0ysL55FBJPzUV20zjP5/yXDqPg4rKM1hzEGNWdibaf3luHMgxP21pXOvTXAp
 ErKgMEycect1AkR+bo2ICSWNOYVZ7+w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_09,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270197
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

The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from
zero whenever the GPU is powered up again and the timestamp reported to
userspace jumps backwards. On an a702 six reads three seconds apart all
land in the 500..1200 tick range, stepping backwards twice, and on an
a530 the OpenCL device timer conformance test fails because
clGetDeviceAndHostTimer() returns an end time below the start time.

Save the counter in the suspend path of the affected generations, while
the GPU is still powered, and add the accumulated ticks to the value
reported to userspace.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from zero
whenever the GPU is powered up again and the timestamp userspace reads
jumps backwards.  Accumulate what the counter reached before each suspend
and add it to what is reported afterwards.

Measured on an a530 and an a702; the GMU parts keep their own counter alive
and are left alone.
---
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c   |  2 ++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  3 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  3 +++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index 6392126f48f2..7d9dd9460f5b 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -593,6 +593,8 @@ static int a4xx_pm_suspend(struct msm_gpu *gpu) {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	int ret;
 
+	adreno_save_timestamp(gpu);
+
 	ret = msm_gpu_pm_suspend(gpu);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index f1df2514c613..c5552f1085e0 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1423,6 +1423,8 @@ static int a5xx_pm_suspend(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A5XX_RBBM_BLOCK_SW_RESET_CMD, 0x00000000);
 	}
 
+	adreno_save_timestamp(gpu);
+
 	ret = msm_gpu_pm_suspend(gpu);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f9de9329dee3..106cc2ac55ff 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2252,6 +2252,9 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 
 	trace_msm_gpu_suspend(0);
 
+	/* only the GMU-less parts come here, and their counter is in the GPU */
+	adreno_save_timestamp(gpu);
+
 	a6xx_llc_deactivate(a6xx_gpu);
 
 	msm_devfreq_suspend(gpu);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 3370cd44382f..f83960b31901 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -226,6 +226,13 @@ adreno_iommu_create_vm(struct msm_gpu *gpu,
 	return vm;
 }
 
+void adreno_save_timestamp(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+
+	adreno_gpu->timestamp_offset += adreno_gpu->funcs->get_timestamp(gpu);
+}
+
 u64 adreno_private_vm_size(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -398,7 +405,8 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 	case MSM_PARAM_TIMESTAMP:
 		if (adreno_gpu->funcs->get_timestamp) {
 			pm_runtime_get_sync(&gpu->pdev->dev);
-			*value = adreno_gpu->funcs->get_timestamp(gpu);
+			*value = adreno_gpu->timestamp_offset +
+				 adreno_gpu->funcs->get_timestamp(gpu);
 			pm_runtime_put_autosuspend(&gpu->pdev->dev);
 
 			return 0;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 114a40f79ef3..db080a6d515c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -207,6 +207,8 @@ struct adreno_gpu {
 	uint16_t speedbin;
 	const struct adreno_gpu_funcs *funcs;
 
+	u64 timestamp_offset;
+
 	struct completion fault_coredump_done;
 
 	/* interesting register offsets to dump: */
@@ -610,6 +612,7 @@ static inline int adreno_is_a840(struct adreno_gpu *gpu)
 /* Put vm_start above 32b to catch issues with not setting xyz_BASE_HI */
 #define ADRENO_VM_START 0x100000000ULL
 u64 adreno_private_vm_size(struct msm_gpu *gpu);
+void adreno_save_timestamp(struct msm_gpu *gpu);
 int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		     uint32_t param, uint64_t *value, uint32_t *len);
 int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,

---
base-commit: 140b13475302601368c0cf4e193e66126a49feb3
change-id: 20260828-b4-adreno-timestamp-f4c846391b97

Best regards,
--  
With best wishes
Dmitry

