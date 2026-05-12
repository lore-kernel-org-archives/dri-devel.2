Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C93CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 20:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1EAF10EC27;
	Tue, 12 May 2026 20:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OeVVG+Lj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b6l7NOUm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6109010EC20
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:29 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CKc6CU1410255
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wf9Q8Tx2vrt+yE2FnC2WSG2BLgxkvQB3xumvit79ifQ=; b=OeVVG+LjCHYxyTsG
 s2PJjNJuFwmll4NxxgdmnFpJUBYIrOTPQlPogMlVwqlAzstpqPl0bYc6MG5QimaG
 mCw2T5HeVjtlTv3HSLrQueoNFtcSHaVbsthAnpic01M9c8hS953Ly4mcchQVdFEV
 rhK53gnAp8tqTfx9xB6dT6pXHnVMjbBiwKKfaj1g/KJKnLCQmZa2Ol3CkDA/pQLO
 w4WT2QPQ3flOBnT0BT+fR/79Ut0/fD6q7RJfJxT2oJ0tly3jnepBSxCWnmgGbjQ1
 g2fqbPAgdF+QahE9pwMlbl+LPsozhGejEUT9WE/gDWkaQsRhcPAjjECBGGe8Bfz/
 426xBw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f31tt1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-837d43e9ff3so4417066b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778619208; x=1779224008;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wf9Q8Tx2vrt+yE2FnC2WSG2BLgxkvQB3xumvit79ifQ=;
 b=b6l7NOUmxMsVvEuI12PT+ulMy10pLrb5f96UyuPIu5UPhVTvruTaHGu0v5v1LrI//k
 ozKQuJdS8ZEqFtCHytCO8CRIykZLy7RuEueYkIVwYQr3bQmgz29kH0a6QBf/ZhOZB4MV
 flIpBEd7M6tHFH9vWeDEMimGmuGKg7Hc+ffijLczxyAXegC/piowTEi9D9D7yDG7a0AO
 mpFMu7ad4PBThQftBupSVd37uLNxoTmncx8aGuweQFrYoJCOAAq/qQpfKJp+56ZqRs37
 A3H629FVAQQHUTK4ndE56N1Yr2uu+SHbeQcT/EHCyc2eAAdUukI9p+leCHA+LTjmimyh
 lmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778619208; x=1779224008;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wf9Q8Tx2vrt+yE2FnC2WSG2BLgxkvQB3xumvit79ifQ=;
 b=eEfWweXjPYL9Tqoj9nwERW2DdggKvs1P4JXHIuZH2hb4f2TxG+anPFvnFOh5E5/XNf
 4Dsjl6q5ewJW2L5GrXYexJ63SgGoVYtOq8bEBn1uDjXO+i2wDsfxnTgV0eGfgGW+lt3Z
 gpGbhtEAPud9QPNnXG4h1FRdup8GpYBDmdTnBLQYfHuMRlXHd5wy4kYvDkkDI3wK5xCw
 103C3X06pcqys7+x4Yf1fQeiVQqO3TnDOHxnIAqiUyg9NgW3LKry7ltdGz9UZo0aizqi
 C8a28AffFRGMbKZ9t9UI6xY0NEr0HlPHi1kE1/k4YCpmEKG4o8xJDs7TDIX8VBcV7mEF
 xQZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zOiAs5O+CEL81Ztlh2CdxVqQxrxhMejypBDqxtIZi6+PGxzrfbLQF5sfN9JXUAEUHwdTGd9AEhB0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/bI2RSzjKA/IaXJx1/R3JhJYrOsmh/JKvhpsu1ee0tq8WNFhZ
 juRRniAoglbxqK1YdQnT02wZUSP+QFHnIeSMeFgwd1BDFkbrAZaxna/a75DMJVeHzKCeaoqrTye
 hM7GZdjyTE6zom2AUzbE7TKD/1k4UbhlZ/20wKBkiaBPFjlMA5jpubvhNDdmMB0LAJK0GBPI=
X-Gm-Gg: Acq92OHAxFHfKA0Ue2mnj5NcFHgfI/iXYicbYxqpH23zB5N2Fv8wbVYGBrpji6o/xdD
 TAxM+JMdhdwl4xSU+Qd4W57qWGV9Q5Dof6ZRg1pJRCyzaLl8AzvzIKRpXZuTZSScIDaaihY69oB
 XhvUtGDW9smyPm6a5iTgItOcogiMMa3fh6BP0HiO34bET6NT06+u4dejOBiUQFqtzMP6TB7uDp6
 oeFIoBXFpA+w+wUeHpkIgHHIrDm2CwgwC6Y3aweccqiHqNrIMldopmSzTKvKU/TzabGV/QqH89S
 sluqJYfMCNHUVUxMrlUtu2iGL67L0nFSL+ug1DSLNTBZX9EXUdAKfHUu4im2q2r7uIy648Kl0ay
 N4FOu9tkDT7m92OAj7/Itggj5Cfv20UrzwX4SAuy16L7lqg==
X-Received: by 2002:a05:6a00:3d0d:b0:827:2ee0:411f with SMTP id
 d2e1a72fcca58-83f03e910b4mr310262b3a.4.1778619208158; 
 Tue, 12 May 2026 13:53:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d0d:b0:827:2ee0:411f with SMTP id
 d2e1a72fcca58-83f03e910b4mr310223b3a.4.1778619207592; 
 Tue, 12 May 2026 13:53:27 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945c1bsm25453004b3a.15.2026.05.12.13.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:53:27 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 02:22:57 +0530
Subject: [PATCH RFT 2/5] drm/msm: Centralize the standalone drm device
 check for GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-gmu-sync-state-fix-v1-2-6e33e6aa9b4f@oss.qualcomm.com>
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
In-Reply-To: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778619193; l=2896;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=gXeWiA6W9piE+ObDgMzSw8HmOPRVkifD1pJGObyFyig=;
 b=jNm6AYPxND8Zd4dPFVsxuXQS2tAXO1YMWVaUgc2bEor3uuvHaEHqTnIyU1BQASaNPUYfC9EoR
 JlM8miS7CVUBxPAPkkYwGHkaGVmooKRJjvL4Nm9SYS4QJXly0UaVMaN
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: tXLAghRN8eDCgF6_RK7327z6Jz2QwdgU
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a039348 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Qn8wcy66etf9Ddiq8R4A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIxNCBTYWx0ZWRfX/nYLte4G7r2w
 gTnX3NUHeV+w13Xsy3SIZiRFiPKfbtSlJWxd4atjUxgHmSmK3UDAJzfHpyuX+/csTUt9fMJc96n
 t2LM5G5zpaYj7Sz/BNdvx9y3PLdCz01swEMPvWVQX4zdHPHmGRkiN9sEQOjlg8egLcE3Vm2Yl6+
 bvtCRw5b/gT36X+fuZo6/BG/aDQb2lJKV0rQLt8hTs/hbWhx5cNe61eJaiKEm0FQV0ZtOyac9/J
 Ecsaj2fggZ8SH0qAbFN4tuyPBTcvNNKyXmff1AqOgn2GNEJvnwOQ43x7qAGjs6lgM4SHB3Yy9xl
 GiQwqFbeQkvupd/QXGt+cVEb0US/ERLoZaA6lvxStZAjV1FzFh8d+Ut7CYzY6nda5Hl41a7yZ6g
 F5veAuGaKqBBxRllXQJFYcwR5br804T4N7oD83osx3KeN/Cvc+NH2oDdvYM0xx1e9YVhQv5p6Yh
 Savak9hjIHe55g2krFA==
X-Proofpoint-GUID: tXLAghRN8eDCgF6_RK7327z6Jz2QwdgU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120214
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

Replace msm_gpu_no_components() with msm_gpu_use_separate_drm_dev() and
move the platform-specific check for "amd,imageon" into the helper so the
policy is centralized and reused by both the core driver and adreno probe
path. No functional change intended.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c |  3 +--
 drivers/gpu/drm/msm/msm_drv.c              | 11 +++++++----
 drivers/gpu/drm/msm/msm_drv.h              |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 4edfe80c5be7..3052f3e36de0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -271,8 +271,7 @@ static const struct component_ops a3xx_ops = {
 
 static int adreno_probe(struct platform_device *pdev)
 {
-	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
-	    msm_gpu_no_components())
+	if (msm_gpu_use_separate_drm_dev(pdev))
 		return msm_gpu_probe(pdev, &a3xx_ops);
 
 	return component_add(&pdev->dev, &a3xx_ops);
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 195f40e331e5..b61deafd02c3 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -61,9 +61,12 @@ module_param(separate_gpu_kms, bool, 0400);
 DECLARE_FAULT_ATTR(fail_gem_alloc);
 DECLARE_FAULT_ATTR(fail_gem_iova);
 
-bool msm_gpu_no_components(void)
+bool msm_gpu_use_separate_drm_dev(struct platform_device *pdev)
 {
-	return separate_gpu_kms;
+	if (!pdev)
+		return separate_gpu_kms;
+
+	return of_device_is_compatible(pdev->dev.of_node, "amd,imageon") || separate_gpu_kms;
 }
 
 static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_ops)
@@ -1035,7 +1038,7 @@ static int add_gpu_components(struct device *dev,
 static int msm_drm_bind(struct device *dev)
 {
 	return msm_drm_init(dev,
-			    msm_gpu_no_components() ?
+			    msm_gpu_use_separate_drm_dev(NULL) ?
 				    &msm_kms_driver :
 				    &msm_driver,
 			    NULL);
@@ -1074,7 +1077,7 @@ int msm_drv_probe(struct device *master_dev,
 			return ret;
 	}
 
-	if (!msm_gpu_no_components()) {
+	if (!msm_gpu_use_separate_drm_dev(NULL)) {
 		ret = add_gpu_components(master_dev, &match);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 6d847d593f1a..6fcb696ceb7c 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -555,6 +555,6 @@ void msm_kms_shutdown(struct platform_device *pdev);
 
 bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
 
-bool msm_gpu_no_components(void);
+bool msm_gpu_use_separate_drm_dev(struct platform_device *pdev);
 
 #endif /* __MSM_DRV_H__ */

-- 
2.51.0

