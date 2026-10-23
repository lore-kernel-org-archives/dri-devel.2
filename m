Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B61606A337
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a9iO2Sbv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dEunZ9m8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FCA112D22;
	Fri, 23 Oct 2026 23:20:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46BD10E733
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:24 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLuvtK877178
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j5i3h6tN81K6GqWEezW10xaQvjQAFm09qTmB4BA5ppY=; b=a9iO2SbvV/Fpl0MR
 jAvoH2lR8GzMp2R4EltVuOwVK/TFnV/TiFdy8llNI1CyokZXcJy2hh3lKTwzslNF
 zyiuMMmXyo+TLHil8YXvLPVXBSahytP2Plr9OI66UUCgbESFLIXc8Q3cNfRVGoAx
 FupdamU71ie8Yd67O701QUoxNaTlfd10MIAAo7bIsJlCpg9/mfbcCtr+tAj2tt0a
 7uknFwMz7Oqwtj6OARE8Nxs1rVJjld1nokFbLeZHPWVti6hqFB/IzhagKlh2u94a
 RFg3sfu9QYsqlN8govtdTqS+ebdnMfHPiZqhXcnNW/BqMuEhInfvDUf7rDl9GouI
 t0dT3A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr68v0v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so29885366d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797623; x=1793402423;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j5i3h6tN81K6GqWEezW10xaQvjQAFm09qTmB4BA5ppY=;
 b=dEunZ9m8QWYLftUXHVCD7QtbmH8bnsfGnVllpOAdUXsDgGey0MjMP4+NKHcmQAjfVC
 GWn+g7hKxPipRsXvTGGv2K72Q9qI+eBRhGWLj5Dj1egpyJ4keFFaNQXu3M7g+0lSE//4
 09zAOf/1hqfBBnRJsauAn+E1xHVuCCJGM+RQxDz2b6PE8bXoSPMsmEsPzBmZCy0fMb6R
 hmB56ym0sBew1QMQgfuNQxAUDem8pwk/5MZn/l8coV0E7XrPyBJWf1dIHbX2lZu0QMJn
 rSyHiJWPCyzbUwVG8bZzwEhJHj9vJenP1SEwZijIVeCZOlU3SeH6fUsbpq1zP4QaS4ap
 glyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797623; x=1793402423;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j5i3h6tN81K6GqWEezW10xaQvjQAFm09qTmB4BA5ppY=;
 b=1Ar9+ypfBXUFiEP2vvT9RvvH8k2QwAmwIXpSHWQeBBha0IG41ENgtEYBuv6X0GQsqD
 NcAyYWtk3nGcaPu/fHc3DZA9c6F/gjZr8pRUMiIJb6BG2EpCrGfheKyX8/zucM51XUcQ
 orAq69O2JB+6EcJTOSSpIJZv2mbkdTEUtHlSFe9IqUvv0du4r+JTRItk+SKk6/v9e5oG
 7bnxEP54aku7anS49gJK3PMDAo9AXtlx4WvKD29XubBE4Kng1yDGSc5rOp2JhpZy1Qzc
 hWbBNYvJyDB2SVUzUuAoIJgk6p05TI+ABJ0KaNDj+58tMKKbrMqY1JkjlhT+BLz7tKMq
 PtrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5eWlfFUIXFZlttndkQIO09303Y5EPn86AftnkYJHxQCCmwMXW+fRZTL675fYqaPiENW9R9XlCGio=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKJgCHrZd2m3+CQP1Z9rgDntob3xwhiI/hO6C5BuY1FNyWBi7u7
 VRSL0oF+vYyhPwRLHhSpBqr9B0FlJR3OsIHS8dt7S/aRiMlNvvv9ZiOllWpKPSKjtk49iHuHZpF
 l8nSC/mTDdo9eLCIt3gA7XPu9WSgXmBZc8cOQzubX1bZ/UZfSazNRQrDgPAgfqgyS1eX/DX4=
X-Gm-Gg: AYBFou0qEly6kZXmU8bunchIw4TigIPU9JZoLJsyDf9/leD04C4CfPNL74TAhpTTzo8
 T8njWPYeRPn1pKvEAcri0fLAaGWwI2Ma8+2eM4D7MpScq7//Ti5M62qnGnCrfzTOlVz1fCDXK+l
 upsvOCqUH/p3svAAj6FnDHL+Kbet2/j9ROGGf0JkbABdDHNoMbMyJ0jyZXfVrRizndaq7cOrnol
 D2ppQrfrkWUl5+jD7dm1WBtfADJw5x087wA0LiARwWB5vPyaAGrLBLSVvCr7mPWmTNesKCMz5U8
 S6nxwjeePATJyji0E6SM4brTI9m6IFBjatosHU4r1010sgIWfp3SZmHQjKVZTcf/kNs7K1aFNZA
 A5Tdx9DRJwkfy6oKPcxTnk2beV6UbIkvjsSpIKXSeLC2hOPZIyTaCfdjgEPInatKCtBR+5k6y7h
 XbAPCBAOTtZB3D
X-Received: by 2002:a05:620a:608a:b0:93e:5fbf:a41c with SMTP id
 af79cd13be357-940ef8bce10mr89611285a.16.1792797623259; 
 Fri, 23 Oct 2026 16:20:23 -0700 (PDT)
X-Received: by 2002:a05:620a:608a:b0:93e:5fbf:a41c with SMTP id
 af79cd13be357-940ef8bce10mr89609285a.16.1792797622802; 
 Fri, 23 Oct 2026 16:20:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:41 +0300
Subject: [PATCH v3 08/14] drm/msm/mdp4: unwind a failed mdp4_kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-8-66a30120a5ea@oss.qualcomm.com>
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5970;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=B/6y71z7QZD5In0hTeKTmGTBI2ihmUVSVBNm9f6oKmM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uUdaM0NnOuVLj898v2QdtaUnwFeVQRpBHcc
 XyBUaFTW+mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrlAAKCRCLPIo+Aiko
 1evjB/49zUKYkvnvAWGzAg3lxD20MXjvpIkl/ZfrdzJK6dOX64hvE+8udwke14BS2Cln/znh0zl
 Y2yahTL3O6VMyvkrG6wHpJfNGBpgBLLJGX4k8Mi4TvlejJ1WkkjvM2R5DFMrwcRcp8aJBd0i+oG
 YGs7QBtkYmWIC0kNb3j0bpkJmS3FelBvh6X/6tuYuchOAhM2pX/FdFBFNZTItWS6IrM2AsgzQYN
 gt4VH4XuSFBSoztU+x6ThnIgpmYBsX1ZpaYY63FpKXPjl3CQ/ak1ozdCqwhWy88Z/rvRQGDYnwk
 MskUvsmNPkSfvJ/+OeQW0B3Cx0bFi4D7ytVfgM+FE7yJoSVU
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6adbebb8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=j6QtfvlM2Oj41uVX788A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX6pQqEIBbyw5i
 FjXOyrXC1/8Mp+3Ivh1ikZBzLwYDRY70LVPQ7uPSysQeIcakOiBWQ0uFAsOMgXra1X1M1ocLQZA
 ki1s91Q2RodzyVETpMmf4WXBjg72f4bGXN28shZ9Ct2Yl+cmrQ/ujoG2svfCM6f1n34a8re3UXZ
 t6kxaf31cSH9rydddBM6TLMQWe0jb2RsNwW/vgSwVS6+JCecU/iHs4tefIE5slQbCMC753L+q1o
 eeVLV1rjXVA0vgV6N+zyigMjGO86M8W9CLXi8bB+4rB0uy6/3lpHSRARvyxty7PctA01YXisjLp
 rOxat8hWKXaB4I3m0ZvUQBYQ5ywMuwuEfU/yN+S+hvpGaSpnl5E3joclmUvgLQI36AXFRUm0Jnc
 0Uylf+40jEGbZHofBCk7isDDmZnApnlugAr4HmpynuLxQxfE3XFEOZ3xezwNcZLoDRsB38THPOq
 9+t3gT8Nr5f4Kcn6Ozw==
X-Proofpoint-ORIG-GUID: SAX4P4OGPM-Q4XcDMtAIeDCSgQITJPpk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX0cZPC6QHx3mq
 /HI7jlOURPROI8oRvUUKNd1gyeUYem/SIH8LZ6BjfHLrigABHx/w1prod69p/mwaFxpUoIF2zkD
 I+PtForK/g7o9QOB3y5pFxMbBiEHn9M=
X-Proofpoint-GUID: SAX4P4OGPM-Q4XcDMtAIeDCSgQITJPpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mdp4_kms_init() returns straight away when one of its steps fails and
lets the ->destroy() callback, which the caller runs afterwards, clean
up. mdp4_destroy() however dereferences mdp4_kms->dev, which is only set
after mdp_kms_init() has succeeded, so a failure there turns into a NULL
pointer dereference. It also leaves the vdd regulator enabled.

Set mdp4_kms->dev before anything can fail, undo the steps which have
completed, in the reverse order, and tell the caller not to run
->destroy() after a failed init. Fold the hardware setup, which can't
fail, into mdp4_kms_init().

Fixes: 93c125e4ea98 ("drm/msm: don't tear down KMS twice when KMS init fails")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 61 ++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index c299fef1a400..c2172e5f9e85 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -29,9 +29,8 @@ int msm_count_mdp4(void)
 	return count;
 }
 
-static int mdp4_hw_init(struct msm_kms *kms)
+static void mdp4_hw_init(struct mdp4_kms *mdp4_kms)
 {
-	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
 	struct drm_device *dev = mdp4_kms->dev;
 	u32 dmap_cfg, vg_cfg;
 	unsigned long clk;
@@ -84,8 +83,6 @@ static int mdp4_hw_init(struct msm_kms *kms)
 		mdp4_write(mdp4_kms, REG_MDP4_RESET_STATUS, 1);
 
 	pm_runtime_put_sync(dev->dev);
-
-	return 0;
 }
 
 static void mdp4_enable_commit(struct msm_kms *kms)
@@ -132,6 +129,15 @@ static long mdp4_round_pixclk(struct msm_kms *kms, unsigned long rate,
 	}
 }
 
+static void mdp4_destroy_vm(struct msm_kms *kms)
+{
+	struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
+
+	mmu->funcs->detach(mmu);
+	drm_gpuvm_put(kms->vm);
+	kms->vm = NULL;
+}
+
 static void mdp4_destroy(struct msm_kms *kms)
 {
 	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
@@ -141,12 +147,7 @@ static void mdp4_destroy(struct msm_kms *kms)
 		msm_gem_unpin_iova(mdp4_kms->blank_cursor_bo, kms->vm);
 	drm_gem_object_put(mdp4_kms->blank_cursor_bo);
 
-	if (kms->vm) {
-		struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
-
-		mmu->funcs->detach(mmu);
-		drm_gpuvm_put(kms->vm);
-	}
+	mdp4_destroy_vm(kms);
 
 	if (mdp4_kms->rpm_enabled)
 		pm_runtime_disable(dev);
@@ -156,7 +157,6 @@ static void mdp4_destroy(struct msm_kms *kms)
 
 static const struct mdp_kms_funcs kms_funcs = {
 	.base = {
-		.hw_init         = mdp4_hw_init,
 		.irq_preinstall  = mdp4_irq_preinstall,
 		.irq_postinstall = mdp4_irq_postinstall,
 		.irq_uninstall   = mdp4_irq_uninstall,
@@ -400,7 +400,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(priv->kms));
-	struct msm_kms *kms = NULL;
+	struct msm_kms *kms = priv->kms;
 	struct drm_gpuvm *vm;
 	int ret;
 	u32 major, minor;
@@ -409,21 +409,20 @@ static int mdp4_kms_init(struct drm_device *dev)
 	/* TODO: Chips that aren't apq8064 have a 200 Mhz max_clk */
 	max_clk = 266667000;
 
+	kms->init_unwinds = true;
+	mdp4_kms->dev = dev;
+
 	ret = mdp_kms_init(&mdp4_kms->base, &kms_funcs);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "failed to init kms\n");
 		return ret;
 	}
 
-	kms = priv->kms;
-
-	mdp4_kms->dev = dev;
-
 	if (mdp4_kms->vdd) {
 		ret = regulator_enable(mdp4_kms->vdd);
 		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to enable regulator vdd: %d\n", ret);
-			return ret;
+			goto err_kms_destroy;
 		}
 	}
 
@@ -435,7 +434,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		DRM_DEV_ERROR(dev->dev, "unexpected MDP version: v%d.%d\n",
 			      major, minor);
 		ret = -ENXIO;
-		return ret;
+		goto err_disable_vdd;
 	}
 
 	mdp4_kms->rev = minor;
@@ -444,7 +443,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		if (!mdp4_kms->lut_clk) {
 			DRM_DEV_ERROR(dev->dev, "failed to get lut_clk\n");
 			ret = -ENODEV;
-			return ret;
+			goto err_disable_vdd;
 		}
 		clk_set_rate(mdp4_kms->lut_clk, max_clk);
 	}
@@ -466,7 +465,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	vm = msm_kms_init_vm(mdp4_kms->dev, NULL);
 	if (IS_ERR(vm)) {
 		ret = PTR_ERR(vm);
-		return ret;
+		goto err_disable_rpm;
 	}
 
 	kms->vm = vm;
@@ -474,7 +473,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	ret = modeset_init(mdp4_kms);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "modeset_init failed: %d\n", ret);
-		return ret;
+		goto err_destroy_vm;
 	}
 
 	mdp4_kms->blank_cursor_bo = msm_gem_new(dev, SZ_16K, MSM_BO_WC | MSM_BO_SCANOUT, NULL);
@@ -482,14 +481,14 @@ static int mdp4_kms_init(struct drm_device *dev)
 		ret = PTR_ERR(mdp4_kms->blank_cursor_bo);
 		DRM_DEV_ERROR(dev->dev, "could not allocate blank-cursor bo: %d\n", ret);
 		mdp4_kms->blank_cursor_bo = NULL;
-		return ret;
+		goto err_destroy_vm;
 	}
 
 	ret = msm_gem_get_and_pin_iova(mdp4_kms->blank_cursor_bo, kms->vm,
 			&mdp4_kms->blank_cursor_iova);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "could not pin blank-cursor bo: %d\n", ret);
-		return ret;
+		goto err_put_cursor;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -497,7 +496,23 @@ static int mdp4_kms_init(struct drm_device *dev)
 	dev->mode_config.max_width = 2048;
 	dev->mode_config.max_height = 2048;
 
+	mdp4_hw_init(mdp4_kms);
+
 	return 0;
+
+err_put_cursor:
+	drm_gem_object_put(mdp4_kms->blank_cursor_bo);
+err_destroy_vm:
+	mdp4_destroy_vm(kms);
+err_disable_rpm:
+	pm_runtime_disable(dev->dev);
+err_disable_vdd:
+	if (mdp4_kms->vdd)
+		regulator_disable(mdp4_kms->vdd);
+err_kms_destroy:
+	mdp_kms_destroy(&mdp4_kms->base);
+
+	return ret;
 }
 
 static const struct dev_pm_ops mdp4_pm_ops = {

-- 
2.47.3

