Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F499C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E5610E74F;
	Wed, 23 Sep 2026 10:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WG42YElg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kG+q7kwY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F2610E87B
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:20 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA2j5a3087091
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZYyN1iY5KNMe5cTxnYzNiplNmyWD2u4FFVlpqGjODAo=; b=WG42YElgMQfoDgp1
 JMkrjIz/tw2k/5eaVT4LKhK5oL6BCgcsvgZ1nXqJ/X7y8LflcASiFMc5slM6F+WT
 PXiN36RcTDEKlPxs5EhwvBb93NyUy/PmI0gYNsi5STY3NdqgYVB4PgCwWj2VGB1G
 T2lwCsN8PzyzfGlxft+B9c+Ccyg4nTPFO+0t66MLq22dDMmxe8MWl2NtwQ/MEhbG
 W4jbnvtKUBz8SeM7jtdgnjYac5DYJLViYLM6kkwo9Sf6npk0eVz1DsD9ANcZceEe
 mhnKtssgPtyXKtH57/e+ULy1bSmPq4NskqynPOe4jx/8XM1SE5mBfKiXqdOKF4HS
 L6d4ZA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwm8aju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:19 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso1450105c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159179; x=1790763979;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZYyN1iY5KNMe5cTxnYzNiplNmyWD2u4FFVlpqGjODAo=;
 b=kG+q7kwYv1YcZoMKVNWuCPj0eVBpZgs1qMall5Wz2635IMI2j1dsqFFV03vv415rX+
 k0FOKQbhV6yFP9L10jzQM4AM9FmAjTxAqCgcDr9B2COWvbsAeiB6fdV3JkOa5SCVX9d8
 PhWB9Lk/oztAyfve1rrJz+CTFhOBkrATD/5uxUZgsxjU4XafK45V7tRO7VOhnr3ERaRg
 9CM3R6ghncHISSR7apToPeyYA/teg7Fe21L21XfblkUerCoLgMCIE+7mNp1v1QeQqQyl
 RP+gR8Tl2jWuAfobeOIRZjT53Fr4LFimmClA4KkbBzmpQ8Ea1p8KEftvMpZ+9qF5gcqH
 zg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159179; x=1790763979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZYyN1iY5KNMe5cTxnYzNiplNmyWD2u4FFVlpqGjODAo=;
 b=m37Vd2dSTqLkrgfNNgA4jfVhGClAkCAt5Ef2HUghXIkCLCbj2cRY5RF3h2NJLgg1Ya
 frP53V8WqgvAj11RGvH3Qhl3z+wNF+I2JaAJvf759Fzs650g9KYGrOoirNo//aOVyzr8
 E+8DUz9rkfznKGmAZIsL+WGd0W4DdZlQ679UTtbEU3Xo7SSiEaeG0TM/g474gpb+rZ55
 g/jsbZ3N0RRBEjT6qS8BMqcRfxVjppTtXuiybtpGunsuixbPadfL81KMKm1S/7gR0ozU
 iRhZagYch/Lw4GSU50VZW1ajVq6JDZzsfAcvaM6rLLSUCLLALzDP3ecJykFLarzGRa8m
 YL+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQskTp1+YuKNydBGOQuXzpoBQdKid5VMT+JChBl0i58QXJRurHfh3C/27w6eRG6/RA0nEbDqOEULw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mlq+nNTDfQwgELlxYI4p1HOZEjCYrvHK9AY/gi+FYWcqFfaIFh
 vh4J5BTIUV5qWaU8pomuajnM/TjUAVR4Au1Yt4g8hoM4Ed4H32hYgKmd5k/Ph65a/MAmgeSSiNf
 IxMmRbqW6ngw2qA3lmgoHyBMS2zrM7j9INPDmB/LjSTRfRBTVVLrcZSt8xuv7gT3UjlIEHZs=
X-Gm-Gg: AYBFou0S1WJkNJqhOe/uyzL2IPwViAyugQ5kaYtnphFAEzA/vu2lnm31s7OtLdAK7H6
 3gWAgweA1DnouNKwJ2OHqjgGZn25jAR8y+fPlEQ/AHF8uMDQ5CK3+L6TZYSqnsEs/g5eeNp4RSC
 bECt/g9Co8r98+uqLnKhOWesf9OFvrVAIU40qkjAAvmPUuP2f7umg86eCdudDJQZyEpY6uUHu1H
 DPQx8Hk9NmWCRcsMte/UA4tIEi9kURS7nIbSd31jxFea6f8uLvwxs+qUf/zK0WLUTy9K0CR0mBa
 w3K0LGbLZtg7BuO+2nu/ALgFwMT3iB/BTSzGTQ5iS826rE2wBkaLI0eJKzGwqOKNCx0ukNT5uen
 0PcWoU+cMkPykv80Ys35eprw=
X-Received: by 2002:a05:701a:c96c:b0:13b:38fa:2dd with SMTP id
 a92af1059eb24-144f915501bmr2194609c88.23.1790159179100; 
 Wed, 23 Sep 2026 03:26:19 -0700 (PDT)
X-Received: by 2002:a05:701a:c96c:b0:13b:38fa:2dd with SMTP id
 a92af1059eb24-144f915501bmr2194590c88.23.1790159178553; 
 Wed, 23 Sep 2026 03:26:18 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:26:18 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:41 +0530
Subject: [PATCH 01/15] drm/msm/a6xx: Honor perfmode_bw threshold on A8x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-1-0c3c79a1a470@oss.qualcomm.com>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=1864;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=V21+W5V5cnpKq7cOeRXGNYr9Gsz3y+i1HRNlljSDkDQ=;
 b=gz27hGiIuj7IwDt3Zs0yojZ6ao33Idt442AqRxr7xS8f590tFgvvo0/KU6rsToa1fVC+5Pwr/
 GbXZl65xVv9CMvyQhgUFyagbyOlCz6K2SCKJdOQMo8EHar1jR6v6++h
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX7zcNAH0dEsKG
 AhK3zw/o88DPCzn5ZZKLXFf7aXAr722HAS81jgqXFiip9zCj852ZJ0UPHo4Y3k2PqmntBbqUyYO
 FhARnQql8N96CZsvsrLvixBgVlztIn8=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab3a94b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RtdH9gem4_UyrOKn0ZQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: AvO2JF0Hjk2ROdB1wyv5E3VRZoKQ0XPp
X-Proofpoint-ORIG-GUID: AvO2JF0Hjk2ROdB1wyv5E3VRZoKQ0XPp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX4FfwaSI1m2zz
 Y9vqYAwAFi+Cwz6lwIiyYzOshSmZF2PhuerFFZjyC9L63RzrvcNV+F5ypCCubxXUMksmWumd+7h
 yTEJRSWLhAi5aIPqR7h9GYeBvq19ISnaKHqXMFaG01m0mEar49INT1R4uoUVc7HgEIlgG2BosLw
 KJF2fjKYctHSyrKpNvp699MG5B4mFoYDvgsk+zfuaNM0289lG3CSXIjzhRygTwAOrD4Bye70Kz4
 lMyIgPnZclWCmuPWDroRNOeuOU132aigKD2Tk9cA405P7e/jBH7Wmx9QVrfJpuv+2eXrkoHI5LW
 AlIfTodx0QSm4XaX/SltMAxQCVwGQ3cSZODGkEK/lJ3avtkSxxoKxRmqXsnsUqYfhBXnwMe2dOJ
 lI0V9arqLVL2C5Ow6orB2EeFiNorQjQNQhyPLuDqtEGgUwnsC4RXh65PoWeazH8bB75um0PjGNT
 e88WIJYSdtP9Lcr9h5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230041
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

Instead of voting ACV for all bw corners for A8x GPU, restrict it to BW
votes above the perfmode_bw threshold, similar to the A7x GPUs.

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 8 ++++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 5 +++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 6d49c51df1a2..baf77a620572 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1656,8 +1656,12 @@ static int a6xx_gmu_rpmh_bw_votes_init(struct adreno_gpu *adreno_gpu,
 			if (bcm->fixed) {
 				u32 perfmode = 0;
 
-				/* GMU on A6xx votes perfmode on all valid bandwidth */
-				if (!adreno_is_a7xx(adreno_gpu) ||
+				/*
+				 * GMU on A6xx votes perfmode on all valid
+				 * bandwidth. A7xx and A8xx only vote perfmode
+				 * above the perfmode_bw threshold.
+				 */
+				if (adreno_is_a6xx(adreno_gpu) ||
 				    (bcm->perfmode_bw && bw >= bcm->perfmode_bw))
 					perfmode = bcm->perfmode;
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 114a40f79ef3..bd5c440f1753 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -580,6 +580,11 @@ static inline int adreno_is_a750_family(struct adreno_gpu *gpu)
 	return gpu->info->family == ADRENO_7XX_GEN3;
 }
 
+static inline int adreno_is_a6xx(struct adreno_gpu *gpu)
+{
+	return (gpu->info->family >= ADRENO_6XX_GEN1) && (gpu->info->family < ADRENO_7XX_GEN1);
+}
+
 static inline int adreno_is_a7xx(struct adreno_gpu *gpu)
 {
 	/* Update with non-fake (i.e. non-A702) Gen 7 GPUs */

-- 
2.55.0

