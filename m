Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AAEC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3B310F055;
	Thu, 23 Jul 2026 09:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NH+bjiul";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PeAK88Yh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B428C10F054
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:52:17 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N8qhxx3387913
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Yi7hVAqdx5+cG+NkT2CBYz
 PFi9Gmuq4cd1/cykcXE/U=; b=NH+bjiulBcwR3zHDKxyh5us7xEuY1NOrn4qoeb
 ZKdaMm1tsuKKsbfFQtj3UbZZxU22uAK3M6jrVDRFXUBgFVNrDlBWiEdGDgH8JL58
 mXi1qroFRlAp0Ho/jTir5X/V4JZlCpQMf4LZV3HQlAnxSw8VMYDIJqXFmPTZZCw2
 OCv/GeJNqbvOmdSmUQULjnnZ9w1x57Bio79UDx0zq3LUq2nIGT22YRFjayjr5t4s
 +k0+U5eQffcMubdUzvLxSi0NI3IvXUIJnScIHvK7NuHcFWgcyZ6mJZJMiUJysuES
 R0vZ8nV1lka34gYhuSAupnZdqJUbvURmD1THfoCnZkJ2Lmcg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk275kg3c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:52:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-522de3c645dso12750161cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784800336; x=1785405136;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yi7hVAqdx5+cG+NkT2CBYzPFi9Gmuq4cd1/cykcXE/U=;
 b=PeAK88YhRNlGEjR0lZuKH7g1VgkjgzJC9GYGWYLGgvzpoUuvO+Qj+bZh9qUR0N3ENw
 eJkniRJi9ZjE/aMagkwRs6JCaPtD1KPqnqM8aNay7iAWrjqBks58lHoNrtEQF/cUU9dk
 cm+bqzzztuuOjKpOD6i3PMoEBzOAPSskrM1Bu7vLgxx9JI1GyueCvvOZDmEhG7YmqbxO
 GbdMLB47Xz0UQ7K/xLaB8k36eCxD23mfrhhnOiChDBVy6ptU6IImD2Jh0Bw90S91+FC7
 46SbrdUE5avwn/9yRA/lDahVw98aCeEuwsujvjenAlBxE7nojuXSxP26N6KANgDghVnV
 s/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784800336; x=1785405136;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Yi7hVAqdx5+cG+NkT2CBYzPFi9Gmuq4cd1/cykcXE/U=;
 b=Yjmv5B2hJYY/pZKdxazftRrB5IwpAJ2HyUbA3CPQawGjO5Kfe4yf6c7bUNcdLTmhjP
 vuM1LvhB63LWv5ZYA4peV2aGw08ueDHp4xDTKibQVCLqFqP9IL4cRZ+NvcZ0PuJxJ5Zj
 2yrqDEv2clMiJNeIBHB80KwpNvX//S+udvkLtM6ttxdFQaECOAKvh22sWUUkZzr4KppN
 LB0uSpHHS+GIWuaf2OXshgLdyNJdJIWLhH2MVmgOlThAxmF7VQmdV/VlLqZIrc+ASo+v
 E6avi0X8C8CyoCGgjGyHD4MG18FlXYptvPIr0qGsf9W3/uSC85M6NLTnCtlLHWEJp9V9
 ovbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/ryoJApmPbL1k4FPMx5cWQ4vRdozF9UsV7a9XfARiFfK98v0KPILdCYNl4uxMlQbN5ZHI6VEZY+8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLaA9qYa2R3n21kmjXLGxj21mYA8zfsBAuoA79dgDM+1+NutAG
 4CW1Cz7EQ0sJSnAsnSDftgxi8x/0AjgCRz/13+cRUrjqccoEXbJs546DEVekJXdQ/tigZX+AfgF
 pE1YwTms0OAisKCMmyqR0RoWmZvNFp0PU1MS5jScr7hKCViaGFg+bqm58ASPBuBsRu3y6fJY=
X-Gm-Gg: AR+sD13E3QXCLAaQzlQxbLekDSPxZXD6e0Wi83nCZxNzyFIQDVxKpq0XGDi7X4AWeXu
 Kt6tW2kj0yd1/+CjzNMucWdhFQuDE3nDzojmsxX0xuiaAlspF0p66twqV4JwETEyDBA5cOHJYF3
 f1N3B9gtMjegoQMhA33szpq1T5DhUysbX6DYMQgrHKfl3teZJ556NZX52LWEDcahbVew3NzWdg1
 hf4F6B9tvqi1xMnAs9wWALRt4Kadj97gRnj8mory8j+6cngbClFWmjWqKuYbnhVa1nzLo25zE37
 +Hs9DaiRpOI0zGMiXmo1xJiyBWpG3ASd/S9LiumGMt1Q/cXQGEUOII1cHzJ6jOxk0PuEXciXKM9
 h97g+VYTjGwrPjzLewcY+9LS/eoNTT7N7AymTFflR1HgBBSZniABLSMdLhOQW0UU0BiTJ/zo28F
 OGAqObzz5Q9/awNw==
X-Received: by 2002:ac8:5d91:0:b0:51c:7b12:5fcd with SMTP id
 d75a77b69052e-5283dfe4310mr21417151cf.73.1784800335951; 
 Thu, 23 Jul 2026 02:52:15 -0700 (PDT)
X-Received: by 2002:ac8:5d91:0:b0:51c:7b12:5fcd with SMTP id
 d75a77b69052e-5283dfe4310mr21416851cf.73.1784800335303; 
 Thu, 23 Jul 2026 02:52:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b9a7f6sm914182e87.18.2026.07.23.02.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:52:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 12:52:12 +0300
Subject: [PATCH] drm/msm: don't tear down KMS twice when KMS init fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-msm-fix-crash-v1-1-78fb4721c2d9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEzkYWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNj3dziXN20zArd5KLE4gxdi2RDYyMjgxRLEzNTJaCegqJUoCTYvOh
 YCL+4NCkrNbkEZIhSbS0Abd07NXEAAAA=
X-Change-ID: 20260723-msm-fix-crash-8c13220d9465
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5923;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=tFjBQeSwNPpemccFfW4O6nejCPixfNCYpDKMS0D8dxU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYeRNmz9PZbpb99urpycMGW2Buxz0S/wLzzb3Z
 07Ea8i6WxSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamHkTQAKCRCLPIo+Aiko
 1fbzB/9Ll7BeCLzI1pD/AZGi9hqZK75TI9ni3LjjE62J2gAeZ23SkfEFspKyOav3dLPsV7pCKRO
 w2YEkDV3fI4GKKnJoKpU0NV95U8MWPXc9SaxcC2PEDHjxSS3b4bmwMYO82zHHqaRU7RpGO3hPm3
 kJTkewm0G1hwNHGpYUhag6OuPpBwfrQaoEVys0Na8R25t6cLDIZ3pDsAVnVz92C5/yt3ca3Zr6Q
 ZHviG1X8WEJrD8T6tSxFxHOxUAx7RJanis7VJX09bVN8b0jCGVjuM+ffC6Ii6g2n81F36wbmrk+
 o5AutjdLZIJwg3blsx5lOljBoTg1l8EtoHQtDPz97TDfAn2C
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Q53iJY2a c=1 sm=1 tr=0 ts=6a61e451 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=hHd2ON2UwJ03A3v6ol4A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5NyBTYWx0ZWRfX/lWyio8/QXOB
 4nFzR73ckTJrcvmnU4sEalGBUnWY3fNqnbMxnpKdSMhr2KVg6ARbogU9dz2d5nov/o9QvakKrbM
 CnMijpsmQoWYQh4vc/ZFzfG8QmX5DtY=
X-Proofpoint-GUID: Lg-mXxLMifJkGXCQRukK95PZfufiF2z6
X-Proofpoint-ORIG-GUID: Lg-mXxLMifJkGXCQRukK95PZfufiF2z6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5NyBTYWx0ZWRfXxQt29Xt639k8
 8qsM1mTLGVGr6EdMmbYyaWqVCOkBIa8xR2C7I0iGtH/AWnd1a1Gvumw+r9aa1nr3ETu71mVaKym
 t5L1nr0TxfYm1bD0S7iWw82aG1rhMOmKHmguSgZipYqjAKhrerH6O2+EbcRrs/yutoW0IuT3y0v
 5VI87kuO8NxTON9OGINRz9+Y0hQ6zdQgi+rMslBool9FdTtDFZxbbwVv5w2Ti7LbXjabkJSj/s4
 xcJ31W7bdqqXs6TY+ErmGDJUfgTnBzC51ZCJ2Z6YM0kMwS47E3S68trRGkFWxxTg11+U/xnGSJX
 jK+QHGQmyZEaXrJkZFTl0/OSwkir2FHeEy9xxSYFyQxaz8wEcZV9elOb/5/r91IC9ySe25AZW62
 W7XUgRnbHmoj3mKg/nT4p/kfJv7k4vNg/8XLR6wMldbiECyCnV5sxQlyCiQnMlwqu/01Db0H1Kn
 +xrEQ1YpaJxExGDRWZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230097
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

When priv->kms_init() (mdp4_kms_init() / mdp5_kms_init()) fails partway
through, both display drivers already tear their KMS state down via
mdp4_destroy() / mdp5_kms_destroy() before returning the error. The
common error path in msm_drm_init() then runs msm_drm_uninit() ->
msm_drm_kms_uninit(), which tries to destroy the very same KMS a second
time, which causes a use-after-free crash.

Bring MDP4/MDP5 in line with the DPU driver whose dpu_kms_init() doesn't
perform error cleanup on the failure. Let the common path own the
cleanup, instead of freeing the KMS from their error paths.

The crash trace for the reference:

  __lock_acquire from lock_acquire (kernel/locking/lockdep.c:5906 kernel/locking/lockdep.c:5863)
  lock_acquire from touch_wq_lockdep_map (kernel/workqueue.c:4094 (discriminator 1))
  touch_wq_lockdep_map from __flush_workqueue (kernel/workqueue.c:4136)
  __flush_workqueue from msm_drm_kms_uninit (drivers/gpu/drm/msm/msm_kms.c:243 (discriminator 33))
  msm_drm_kms_uninit from msm_drm_uninit (drivers/gpu/drm/msm/msm_drv.c:93)
  msm_drm_uninit from msm_drm_init (drivers/gpu/drm/msm/msm_drv.c:184)
  msm_drm_init from try_to_bring_up_aggregate_device (drivers/base/component.c:249 drivers/base/component.c:227)
  try_to_bring_up_aggregate_device from __component_add (drivers/base/component.c:269 drivers/base/component.c:748)
  __component_add from dsi_host_attach (drivers/gpu/drm/msm/dsi/dsi_host.c:1739)
  dsi_host_attach from mipi_dsi_attach (drivers/gpu/drm/drm_mipi_dsi.c:383)
  mipi_dsi_attach from sharp_nt_panel_probe (drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c:247)

Fixes: 506efcba3129 ("drm/msm: carve out KMS code from msm_drv.c")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 22 ++++++++--------------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 11 +++--------
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 7726edb0d4ed..6ae49f94fea7 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -398,7 +398,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	ret = mdp_kms_init(&mdp4_kms->base, &kms_funcs);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "failed to init kms\n");
-		goto fail;
+		return ret;
 	}
 
 	kms = priv->kms;
@@ -409,7 +409,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		ret = regulator_enable(mdp4_kms->vdd);
 		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to enable regulator vdd: %d\n", ret);
-			goto fail;
+			return ret;
 		}
 	}
 
@@ -421,7 +421,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		DRM_DEV_ERROR(dev->dev, "unexpected MDP version: v%d.%d\n",
 			      major, minor);
 		ret = -ENXIO;
-		goto fail;
+		return ret;
 	}
 
 	mdp4_kms->rev = minor;
@@ -430,7 +430,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		if (!mdp4_kms->lut_clk) {
 			DRM_DEV_ERROR(dev->dev, "failed to get lut_clk\n");
 			ret = -ENODEV;
-			goto fail;
+			return ret;
 		}
 		clk_set_rate(mdp4_kms->lut_clk, max_clk);
 	}
@@ -452,7 +452,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	vm = msm_kms_init_vm(mdp4_kms->dev, NULL);
 	if (IS_ERR(vm)) {
 		ret = PTR_ERR(vm);
-		goto fail;
+		return ret;
 	}
 
 	kms->vm = vm;
@@ -460,7 +460,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	ret = modeset_init(mdp4_kms);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "modeset_init failed: %d\n", ret);
-		goto fail;
+		return ret;
 	}
 
 	mdp4_kms->blank_cursor_bo = msm_gem_new(dev, SZ_16K, MSM_BO_WC | MSM_BO_SCANOUT);
@@ -468,14 +468,14 @@ static int mdp4_kms_init(struct drm_device *dev)
 		ret = PTR_ERR(mdp4_kms->blank_cursor_bo);
 		DRM_DEV_ERROR(dev->dev, "could not allocate blank-cursor bo: %d\n", ret);
 		mdp4_kms->blank_cursor_bo = NULL;
-		goto fail;
+		return ret;
 	}
 
 	ret = msm_gem_get_and_pin_iova(mdp4_kms->blank_cursor_bo, kms->vm,
 			&mdp4_kms->blank_cursor_iova);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "could not pin blank-cursor bo: %d\n", ret);
-		goto fail;
+		return ret;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -484,12 +484,6 @@ static int mdp4_kms_init(struct drm_device *dev)
 	dev->mode_config.max_height = 2048;
 
 	return 0;
-
-fail:
-	if (kms)
-		mdp4_destroy(kms);
-
-	return ret;
 }
 
 static const struct dev_pm_ops mdp4_pm_ops = {
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 0a004ab9fc85..3934cd060b27 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -517,7 +517,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 	ret = mdp_kms_init(&mdp5_kms->base, &kms_funcs);
 	if (ret) {
 		DRM_DEV_ERROR(&pdev->dev, "failed to init kms\n");
-		goto fail;
+		return ret;
 	}
 
 	config = mdp5_cfg_get_config(mdp5_kms->cfg);
@@ -540,7 +540,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 	vm = msm_kms_init_vm(mdp5_kms->dev, pdev->dev.parent);
 	if (IS_ERR(vm)) {
 		ret = PTR_ERR(vm);
-		goto fail;
+		return ret;
 	}
 
 	kms->vm = vm;
@@ -550,7 +550,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 	ret = modeset_init(mdp5_kms);
 	if (ret) {
 		DRM_DEV_ERROR(&pdev->dev, "modeset_init failed: %d\n", ret);
-		goto fail;
+		return ret;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -562,11 +562,6 @@ static int mdp5_kms_init(struct drm_device *dev)
 	dev->vblank_disable_immediate = true;
 
 	return 0;
-fail:
-	if (kms)
-		mdp5_kms_destroy(kms);
-
-	return ret;
 }
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms)

---
base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
change-id: 20260723-msm-fix-crash-8c13220d9465

Best regards,
--  
With best wishes
Dmitry

