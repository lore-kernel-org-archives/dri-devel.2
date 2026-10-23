Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CFB606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ccYxxnd+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kpr3Tvlr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB08510E757;
	Fri, 23 Oct 2026 23:21:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAFB510E763
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:45 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvHdV372118
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Sx0rmsBgZt30dKcVPh3q3dkCSTQ2aAKHx6qQ0xn5dLI=; b=ccYxxnd+R/pFHP7/
 g51SyrzgCLl4oLK5b6v2MdW0lFb1RLBV2TXI/bTbn5mSunKZi1MjWDw6EnNBN6eO
 IKu8/IJ0xQlOpr+a0vbv9MdgnVxFVbAI9WRuOAOhefV3Vt0qrzg3Q7yulllhw0ew
 wzG4z+ZvU7hak2aNa6gdUHpZopbiZm+/UcqbMTmGeBSkQI09JeWFB/qu6YjzFAmO
 I9JXYyC8nu3sJJovW/JZmhr9NiF8+/SfSs+GpmMkfkJ97NBb/j7Qfrnoyh9M24Ey
 q61CBMEfapK9hqXzUCIag5KhPrpM4ucLc+4lO05z7e0b5QlJoerERP4XNIb8A66l
 MoT9Tw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas89bne-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so270413985a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797644; x=1793402444;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sx0rmsBgZt30dKcVPh3q3dkCSTQ2aAKHx6qQ0xn5dLI=;
 b=Kpr3TvlrUedmCS5aaQ45MZmYiOlNuXQ2L9U+fpeg0wU6p1iNYMUloWsXYZphmQYejq
 ug9zY1cpjnloiEQHn9Y0mWZDNN3pEhjHJHcorVyRs0USyXxQ0JsX99fJNyUhUPahbMQw
 YpaXqZKPHYG0WreURwzQHyviKyJC4MB/+4WcrY+YyJmXo/XYlpty8i7o9zXpgojjYnNU
 RntM/sKwkRQogqErf5N7FP7mjvBe8gZ7iInNks3ZgiSLyeQaQXAtojghchX60gRq76nL
 TrSLL0cTv/k/tCjsqMrqOOIAZLZBL0Gse8RjetlsqVz//nuCIssMvDcDDqWBNzCRKZ8N
 DZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797644; x=1793402444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sx0rmsBgZt30dKcVPh3q3dkCSTQ2aAKHx6qQ0xn5dLI=;
 b=TF6lJcNqmuMK6OarTwfudpS2DpAkcEGx0tx7FQ/8srI7AhktonF6Hadsx6HwjGXnaK
 LT0LOS+5q4mqRMzZsERevucruzUZHz/Jq/mjvW0v5sJNBMvDhQxvH+A8ITw+aUOsmr79
 MvEtnM/zt2m9bbRSSpmGqirEjodyAAlm53uN3Wj2Z6BBap1wHYn5fg0WxL3XVlMJJwm1
 UzYYzRvwmhGKznl4w4tFn1KD2tdTZA4a4rZYiPFWSzXl+22metKiRAxlv7aIy2pT9sKU
 1tt6M7GNo9uytCV2saVfYbOhgz+Emo0bIEYQ0vBu+Pf9niagkDDZVcvcc22smsauUG/R
 GU6w==
X-Forwarded-Encrypted: i=1;
 AKwUvByl5IqsJJy9t0h1+vE3TuS/JIDCZYA62edW8bVZe9BA+KqlVs4kdgTiuvdJvv0ni9NINxQMB7s2lP0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL5n65T3hZeCayio8Ue0uWpqUic0850rzqv85Ehnu7fN3dezqaJ
 BhQliL4C02nqqllYda8zqX2JaIAtn52Kvm90HxpYvtiJQAU2n0n+XTpcq/2t4rrg1fKGoJoZTUA
 abFFt6F7NpGU2/xYdWNWH97GMmjlUzzKoQ+z2xdiGwBV4Y5irHT4Sq9s/jzkN1JlJuHTL6vs=
X-Gm-Gg: AYBFou09PRFVSPQLWgp68ZwM/JCBMTc1w1CGYQQkzV1S6BLj9qDMnZ7sYMvI7ojAwM0
 5Ps8cVO0CyuUCuywuOW2EOjHX5J+xdheoSYOZCTsfR3Bzc2aosMgtonMmGDBqUFWZWDzxCpE7zY
 S2sM426dXpdE46BK9vFOt63qdKDbxibhpsKlrMQF5677Tt9BB/tm+ptRjuL+66sxLrrvE15nYDc
 5qptn1PNQ/+CQaX8KkUWIThX4zGbZ3ujH7/tq0E75kPTDCiYoTCVUe7kCL38irYPx2MgXItlSbX
 AM4xsoe2+2JcMfx+atlR2jrt55tmZpKxooSLLrV8e2bRwo90M7x/yc43fuh2XtZifRLHLVT6i8c
 /Ix9DeoCZ7fOWdehqdxFNFWxlCXAx18emuRipABL6ir4l765/Xmhs+hpJfV/efOnXxxehGubifU
 av3qQrTkYI/htR
X-Received: by 2002:a05:620a:4385:b0:93c:70da:e45e with SMTP id
 af79cd13be357-940ef94005bmr81745585a.36.1792797643821; 
 Fri, 23 Oct 2026 16:20:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4385:b0:93c:70da:e45e with SMTP id
 af79cd13be357-940ef94005bmr81743085a.36.1792797643386; 
 Fri, 23 Oct 2026 16:20:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:47 +0300
Subject: [PATCH v3 14/14] drm/msm: drop the runtime PM flags from the KMS
 teardown
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-14-66a30120a5ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4747;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=j1URGN0eQiJYgrQP9gUgcFK+tRqsBG/bZhmilF0Ffy0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uZ6IYe4lXDGxIc3dTkjP1KBXZ7PEqcwnluM
 tizt7Pj6TmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrmQAKCRCLPIo+Aiko
 1X/kB/0e3R/JH2VlWRkymZJSn/JsK11fHILuNXsOmkqwBC0TAsU5ccYcD5HM+0f9E5v/DprbgMA
 MiiK8meTNpPD/pZh5bJbcmG+rF2fpnA/fqCNvDRD8LYzFcaSnym0XgSAQVqLGI6gaCCPRVPEQBl
 gC7FZQEDDNg2S11lOkvTnYIBjqZlfi1hpj7MGO08uz2RX3zCcS16mrMCdmsu568pVDm9Xye58Dz
 Fhx3V0AHza/rTNFQVKk1RB/c38ZF8T4ZeCJ9Xik559abOWtQLYITs+1iDxLedPylliZz3kdTpQJ
 wGCg75ZlvzqrSUjkX/09V375EdjUBhFdefIFLR8KaNqIQSEY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXwbRq4tbI+A4I
 vIexVNWNHs1kiYoeFr0DiJUK2CRoxROMz+sdhqQOGh1KvUNHtiiAL/FhL8sbyUgjLHEyEVYDcpt
 iwuTz9k0Ym7VzI9wCO0wFPMks74znpo=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adbebcc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Yohvr2p7PhcuVfY586MA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX/bjqnOYD56d/
 KdIBODSf4eFksXdxt9RSae8lnQclUtNm6UKnvdGgoGd+pZBMfk2IBGpy2o/qvrB5YsD5QzY5QMr
 573EgOMXuoZBefdZ39gI+VQ4mJnPp3vfH5tFNQVkGLURtk4OIw07CZ6J0m9TiCwbNnEEYbiCVSX
 nwG+ZVy7WMvsrdxGU47ljoxv/fdSMcDeiuw7UaiW1X9MRohVb6qHMF5ZASBI3IfuGsFQ6+HUBPh
 +yq4+fz+zS1IvfGVCgjowBeNKkIeCNyt0D0w+XF7N8wM37GMq4SNG+fDkgZe26c38fRfXqKyk34
 QjySUGcbHHhkySxzJ03moBhP56+5drtW3VWsrSi9IN7bEkU0dyhGQdzk1hHTpo6XcC7mA3Ew1kV
 JQyIe2A6zhvRV4tvhgE/CxrPRhsD2kC+FyDV8wT8z+EKdBXqYyOwrOyPc5JkGt9nIzLze8tIVE7
 WvYlmzuU7OC4k5bfP+A==
X-Proofpoint-GUID: a8OWi5jZG5Q4ExV_mA3TnLaqqsBbYI2k
X-Proofpoint-ORIG-GUID: a8OWi5jZG5Q4ExV_mA3TnLaqqsBbYI2k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
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

The DPU, MDP4 and MDP5 drivers track whether they have enabled runtime PM,
and MDP4 whether it has pinned its blank cursor, so that ->destroy() can
tear down a KMS whose init failed half way. ->destroy() now only runs for
a KMS which was initialised successfully, where both are always true.

Drop the flags and the checks.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  | 4 +---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h  | 1 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 7 ++-----
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h | 2 --
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 5 +----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h | 2 --
 6 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 3546efacba3c..e994fd267c5b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -927,8 +927,7 @@ static void dpu_kms_destroy(struct msm_kms *kms)
 
 	msm_kms_destroy(&dpu_kms->base);
 
-	if (dpu_kms->rpm_enabled)
-		pm_runtime_disable(&dpu_kms->pdev->dev);
+	pm_runtime_disable(&dpu_kms->pdev->dev);
 }
 
 static int dpu_irq_postinstall(struct msm_kms *kms)
@@ -1320,7 +1319,6 @@ static int dpu_kms_init(struct drm_device *ddev)
 	dpu_kms->dev = ddev;
 
 	pm_runtime_enable(&pdev->dev);
-	dpu_kms->rpm_enabled = true;
 
 	ret = dpu_kms_hw_init(dpu_kms);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index e39831a397b1..769b8ce6332f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -87,7 +87,6 @@ struct dpu_kms {
 	bool has_danger_ctrl;
 
 	struct platform_device *pdev;
-	bool rpm_enabled;
 
 	struct clk_bulk_data *clocks;
 	size_t num_clocks;
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index cb95a492e070..8b07881c3f8d 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -143,14 +143,12 @@ static void mdp4_destroy(struct msm_kms *kms)
 	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
 	struct device *dev = mdp4_kms->dev->dev;
 
-	if (mdp4_kms->blank_cursor_iova)
-		msm_gem_unpin_iova(mdp4_kms->blank_cursor_bo, kms->vm);
+	msm_gem_unpin_iova(mdp4_kms->blank_cursor_bo, kms->vm);
 	drm_gem_object_put(mdp4_kms->blank_cursor_bo);
 
 	mdp4_destroy_vm(kms);
 
-	if (mdp4_kms->rpm_enabled)
-		pm_runtime_disable(dev);
+	pm_runtime_disable(dev);
 
 	if (mdp4_kms->vdd)
 		regulator_disable(mdp4_kms->vdd);
@@ -451,7 +449,6 @@ static int mdp4_kms_init(struct drm_device *dev)
 	}
 
 	pm_runtime_enable(dev->dev);
-	mdp4_kms->rpm_enabled = true;
 
 	/* make sure things are off before attaching iommu (bootloader could
 	 * have left things on, in which case we'll start getting faults if
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
index 06458d4ee48c..9dd829ec9401 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
@@ -34,8 +34,6 @@ struct mdp4_kms {
 
 	struct mdp_irq error_handler;
 
-	bool rpm_enabled;
-
 	/* empty/blank cursor bo to use when cursor is "disabled" */
 	struct drm_gem_object *blank_cursor_bo;
 	uint64_t blank_cursor_iova;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index c349eedd55a6..bbf459bff35d 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -575,9 +575,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms)
 {
-	if (mdp5_kms->rpm_enabled)
-		pm_runtime_disable(&mdp5_kms->pdev->dev);
-
+	pm_runtime_disable(&mdp5_kms->pdev->dev);
 	drm_atomic_private_obj_fini(&mdp5_kms->glob_state);
 
 	mdp5_kms->num_hwpipes = 0;
@@ -734,7 +732,6 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 	clk_set_rate(mdp5_kms->core_clk, 200000000);
 
 	pm_runtime_enable(&pdev->dev);
-	mdp5_kms->rpm_enabled = true;
 
 	read_mdp_hw_revision(mdp5_kms, &major, &minor);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
index 7bf2172fce0b..c0b163c4baa3 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
@@ -62,8 +62,6 @@ struct mdp5_kms {
 	 */
 	spinlock_t resource_lock;
 
-	bool rpm_enabled;
-
 	struct mdp_irq error_handler;
 
 	int enable_count;

-- 
2.47.3

