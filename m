Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0007C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331AF10F7A3;
	Thu, 24 Sep 2026 21:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mz7NdAbN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LAxv2Uin";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8900310F7AB
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:26 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdjV62996412
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uJ0xZghxcteqbgqQNa5Ju0bXGRBgVxcsciLwivSYvoE=; b=Mz7NdAbNAlf8h0Co
 k2v4yGHyQJRsvNr/GRswo+5QJlKr2zmQZkeapv6h6BM+47Elrbv7H5Q5wUPOi0CV
 y90QsqIEa0/evXlwgiZKdOc90VIse6kqNgcUHXiihM6CbH4diIV82OGShQ16lO2H
 S3u/TWHG4lXxReyWHHlMu1sNs354jxSsySVhApVZUCaGkVKYKPU+QGrhx8G82tgv
 BT0yC1NWnHd5ICZH4SNpAW8t41OPpPSty6YMjjxW+XXQ6MzOhDPX/2NXclt/4vnf
 xVJ4THoE/Zfrecoc6DWtBZslP3x7xcxppqYbPvnLmrk4WmT+cqBIp2XtKAjMJ3bO
 QkMyTQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw46522v1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:25 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-143803143c4so646935c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790284524; x=1790889324;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uJ0xZghxcteqbgqQNa5Ju0bXGRBgVxcsciLwivSYvoE=;
 b=LAxv2UinI721f/IylyRi96y2iBoJ0kcHcPCPfKb3zhk4/gkIoUTGJfncQR+x2LvDvT
 Ge/5FLl+C/oREW96ZM6Btfpa6yh9xXZDcZnZ9ZDbmaJ/K7GTKYRCQLO78Nu4edNuqTVJ
 vjnJB/l5xLe+Fw5lWNMuCJHOD+aTxshFkSukYRiTLuAZ0O84N4a9yAe9Z9R5hR8GTcTX
 r+6Yp8Cgpd3fCwE14AyIa7iwbPw6gDrRtVHwbzSROnAKiyY2jPToy5ZvwlYMKuaOHJUS
 eviKUBEyTUl8evQwD/V0Ac3rqEwjMxXE63tXamB4aNscAovMPn05Xi+sEDivHvfBEa5r
 s2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790284524; x=1790889324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uJ0xZghxcteqbgqQNa5Ju0bXGRBgVxcsciLwivSYvoE=;
 b=z6XCGlVxVyA7S2Ux90kb8BQLxHlh63ZqWPGzif9eVD973g3qN3iCHKv0SFXDXr0ut2
 BLBdtHdjVEbtUeHJ8MeidMTJoGPqI0y0w1ATquF1jXZRbqM2jQwNCYupr3t2Y+uhwm83
 e9JbZBzUctN8/RBw3iZpTVcg0rKHXQq9sxqBWiGpA1VOYqKGRn07kKkEZEMK8P0xcnWw
 OtmpR8Vagmrs1WjCEx/Wr4XC7OVwOjqdwGL7UWTpwUlfypwdrk0ODa8zH0oyS3TVdjUH
 Sb7xh1H3UBA9+MpJ8OKjgBp122rpFXrbTKnSUYvO94K0oKdFOJLpRDpoomqS6oTLHzyQ
 4/ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBwf3PRK4WhkJQg3b4nF6nlh72NrdTkWd24jnS61Mp07FyduUVGmatbghJC42cGdajFFX7VVu/EVK+Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lLW9DcJKU+DpEY+wXgo+Bc/q20PH6OPmw8+oBAju2dzMbiCyTO
 EvSaBWcb1ywikc+9EaPuB4oT2VztuWS3cEARuhWqUt2GrrTmhs0hnOuLm8YMo3FuQMQoj5cH12p
 XP9anl72JiyZkcJvjMIRcQ0yRkC6UgczaEUFYpmRnIphLb2UBzXzXlYvByexzN6uaAaSz28A=
X-Gm-Gg: AYBFou0GVDMMAskAk7CyYtZPb7ZVrZI2TDZKdZzFYTyZi2j0JwaLWL0Dvx5/rF7Rk4u
 MYNC/i7AjAUjR8AQ25DOrvIQZ5Pio2fNa0Zwlzj2VNBgpjO+WONeQ7NaiqZSJrKAiKHqeANqukh
 vOlAIIonLkDb3PERse/UrQ8RCVWJbUTZjfYiF7fNrSqUcc4F9uAbg0DYXCIQG/ZawS01RPnSMg2
 El+iy4DjKBv9K3PuhmHFr2g/YuH2nRxiVm29oG0uu+4M98KL1NCOqD5+mLWoyRByZOC/mtATgIk
 IMTkAz1CswSRBTFs7o4FuIzjROI0/HhzLqz9uplwVZ8TT4v//46BzKmzCqovXHD5d9EfwSEAc6Q
 0cVTjvH8MlGvDuRKId5l+cG0=
X-Received: by 2002:a05:701b:4183:10b0:143:271a:3df3 with SMTP id
 a92af1059eb24-1450403a968mr2967580c88.45.1790284524291; 
 Thu, 24 Sep 2026 14:15:24 -0700 (PDT)
X-Received: by 2002:a05:701b:4183:10b0:143:271a:3df3 with SMTP id
 a92af1059eb24-1450403a968mr2967553c88.45.1790284523639; 
 Thu, 24 Sep 2026 14:15:23 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acc47ab8sm1323776c88.6.2026.09.24.14.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:15:23 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 02:44:34 +0530
Subject: [PATCH 3/5] drm/msm/a8xx: Add Mahua GPU support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-mahua-gpu-v1-3-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
In-Reply-To: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790284491; l=3597;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=I88dKR93qprsU57JQfFiug9aNzx2vTCQK2zznJC5iNU=;
 b=1psEMZuRUs7tbF4UQyIgkdQzaYUKb5r3TO16eJsS2mHei0/EsusvgUpRTNXYMHS/LegWQxYOi
 A/A00OyHanVDzGuLxHDd8SWZF/3mR9HLEhmSEIt7x9ElBifOKeHpu0N
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab592ed cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=_hwIf5ch9eKH10-pnQIA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: EiwAcVE3t29v-uRYgnnzHcg1R3yPJQEk
X-Proofpoint-GUID: EiwAcVE3t29v-uRYgnnzHcg1R3yPJQEk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX6yP+W8tDBEI4
 jyG31HW2+jnZClHJffIHTRapHZmsbKOoBPJPHNOVyxjL0LorflpFpdDctoABTH61Zkv1o2mdZyX
 JSenJCDnSuIHlIhbw45BgRoscS8boEn6rF6/4slqBFIw8Ra/seGOguby7iIS1crh0uS1WZMzHZi
 6tL7V6st+GKpD9mBMbKewRK+3iQf+GjTu5USlyrjpthp0drjFmklxyqDiBxEBzx9OFtyP6fCOBA
 dOH5XnfGt1ThrTZJA/Jti0LtOZa68pMRv4ysSmDo4sa7BxLBTogO+bG27XN+gqgaExKxJMGc09M
 RScpBIvxUiWC8jjpOo1Bch2eBb8CTPRkiV56tXHM/B2Pvn2QcyywxidbV+ZIoiHzUmdpfvBxyEV
 pDK+++Guwrep6puT8qCDgm0VxmMY2oaEdnKBJwRvuzC6zh6X4TDqSdT1ZcGUJUxkydOghDTmaUi
 GRAyfWcek8HHpKT/7HQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX5TOvdRzVB+oG
 zZ6hQ0WUb8OG/OkOhHYoN0h0f0hAe29715W3bui5no2IfEozclEX2nZssKZTEhjSNs9l/gmScVg
 MRmvh2JWYohaNtnK9DlLn+q9mcYo0S0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240086
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Add support for Adreno X2-85 GPU present in Mahua SoC. This GPU is a
smaller version of Glymur GPU with fewer slices and smaller internal
memories, but shares the same register layout. Also, the GMU chipid is
different when compared to Glymur's GPU. Add a new catalog entry to
support this GPU.

Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 42 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  7 ++++--
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 90a0c7ffb3c8..3f11b16e9a1f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -2524,6 +2524,48 @@ static const struct adreno_info a8xx_gpus[] = {
 			{ 242, 1 },
 			{ 221, 2 },
 		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x44060000),
+		.family = ADRENO_8XX_GEN2,
+		.fw = {
+			[ADRENO_FW_SQE] = "gen80100_sqe.fw",
+			[ADRENO_FW_GMU] = "gen80100_gmu.bin",
+			[ADRENO_FW_AQE] = "gen80100_aqe.fw",
+		},
+		.gmem = 15 * SZ_1M + SZ_512K + SZ_256K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_PREEMPTION |
+			  ADRENO_QUIRK_SOFTFUSE,
+		.funcs = &a8xx_gpu_funcs,
+		.a6xx = &(const struct a6xx_info) {
+			.protect = &x285_protect,
+			.nonctxt_reglist = x285_nonctxt_regs,
+			.pwrup_reglist = &a840_pwrup_reglist,
+			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
+			.ifpc_reglist = &a840_ifpc_reglist,
+			.gbif_cx = a840_gbif,
+			.max_slices = 3,
+			.gmu_chipid = 0x80a0000,
+			.bcms = (const struct a6xx_bcm[]) {
+				{ .name = "SH0", .buswidth = 16 },
+				{ .name = "MC0", .buswidth = 4 },
+				{
+					.name = "ACV",
+					.fixed = true,
+					.perfmode = BIT(2),
+					.perfmode_bw = 16500000,
+				},
+				{ /* sentinel */ },
+			},
+		},
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 388, 1 },
+			{ 357, 2 },
+			{ 284, 3 },
+		),
 	}
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index add93c1fa039..165620d51109 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -200,7 +200,7 @@ static void a8xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	u32 val;
 
-	if (adreno_is_x285(adreno_gpu) && state)
+	if (adreno_is_x285_family(adreno_gpu) && state)
 		gpu_write(gpu, REG_A8XX_RBBM_CGC_0_PC, 0x00000702);
 
 	gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_MODE_CNTL,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 114a40f79ef3..eb394d9a1d9d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -597,9 +597,12 @@ static inline int adreno_is_a810(struct adreno_gpu *gpu)
 	return gpu->info->chip_ids[0] == 0x44010000;
 }
 
-static inline int adreno_is_x285(struct adreno_gpu *gpu)
+static inline int adreno_is_x285_family(const struct adreno_gpu *gpu)
 {
-	return gpu->info->chip_ids[0] == 0x44070001;
+	if (WARN_ON_ONCE(!gpu->info))
+		return false;
+	return gpu->info->chip_ids[0] == 0x44060000 ||
+	       gpu->info->chip_ids[0] == 0x44070001;
 }
 
 static inline int adreno_is_a840(struct adreno_gpu *gpu)

-- 
2.55.0

