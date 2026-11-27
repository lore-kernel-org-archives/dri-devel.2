Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92F606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lT7I76Yk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GuaT+R4Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6BCD112D5C;
	Fri, 27 Nov 2026 19:46:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E993410E970
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:07 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAvHP1127694
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TiRcY3S9QKPQ7+xH5TOegkjcGBPIklke4QHyTc7bS8s=; b=lT7I76YkhtN4PFMw
 5qBOl0wMvUdD0TGRKAI9nCHvsV2EMhbwnpsNeDHo4hsXORAPlCv1E9kJwxE9fCIV
 2+e9RURAggSmdHjTlkeyNelxHOlBo4Vs3y2XAIlftOkwSTlwV1evQmdWrnJniHPK
 qRxXAbN0hNFV0H+9+1um3BmhqzLE2kwM+hPqqS3kKcuBKeQZxWxjoWNjMjkIiN5S
 MWr6Cvh1fjY38iKXWrOZfQkC2W5eixCbBTFAEX8UjBfy/JKQcVfwLZPCrsuSsKbj
 upsA823LpvVBq0LLbJLU0HgM2UIAmMmPMo7Csk89juqFhy5FIKZ2tJz4RItYU2sY
 0CHc9g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6trv6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2005ce21so1280728685a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808706; x=1796413506;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TiRcY3S9QKPQ7+xH5TOegkjcGBPIklke4QHyTc7bS8s=;
 b=GuaT+R4ZAz4vlwjlmZ8HAuuKNTo1S7Sa3xMQR+iZmp8Y7COZPHmBaso6x+waNaOpq8
 /+IqtBllZl2aDvA6Qvzhm6s2psOydSqaSMi7Wel61F508JrW3dgi0dpaL1IXl8OuyL/5
 LKhhWg5gIOKB4Ocl0J6H/9Ds2DsoXJYBkEKjg+Lc22YQL9IximAquBo/hylh4IoCrNvI
 A68mXdpyEYMIF3pGDARgOyqG5aae8EkxY3JQsdM4cBpWMalyuyzPq9ZUu4JN79KoCAsR
 9RTPhLz/gtCd69aLvD1gkfHLaqd/R3Nt/eRN4vjFEWVKFJbQVlaMCX/ADbuemyMWKyLT
 2EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808706; x=1796413506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TiRcY3S9QKPQ7+xH5TOegkjcGBPIklke4QHyTc7bS8s=;
 b=fIfPGcEGQr+T5A9XO/TwcGD66g4H9cefE+IBNbjl6QI3LpF2Aqu7EAqBVM4bj/p6Ho
 s1YUpGMWAZbkLgbp5gnWDnHvxN46cuX/engCWy4CFNEyKccmYK/YIN1GMaYgpx/Z/7t/
 bxJATdmdDE3H8JLU5kRmV9QFMuc439VixEMTvYCwcIvidH3r56/6UlA832dENFhW/bmK
 IC+KtfhU7KEcnlq3P98Csv0/oXdQ4ZkrzlqF2+XOvsh3AlJl/SHzKS9fnMubrVWIGFsx
 2TKaz9jboh8nVwxS+2mMdwTnxPe0GAzNGiMg+4XPqCUbeZ0XNsmhE6H1a9SM7wlXXykH
 orLA==
X-Forwarded-Encrypted: i=1;
 AL+hErGnfq2gYTe9k7HpJSB2DvctdeA6XY2UIM1oWTCSO0PTxz2bNPJPuwpMnAe4LgfCSKGiHgGosmW+vfg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8xMdNUZGG6aS+XbEif02Gx2eXWzjHIsU+mWNwqigPWHPg4tyfN
 P7GyZ2u+7Thcd7+b1R84RpukBM3OvR5tE3o/gIfTuT64aaSDLq0dCh8bxVZFgkQQqlHjm0dyKKU
 qy70D6QdYgg3WXsv3R65x4FuP+stNTt0C1Lz/3OyeKSrzJB0sAeaD+V/BoN/9CaYATQj+wdQ=
X-Gm-Gg: AZFdTZcUAW07qvQJ50LJ9XXb5p0uHY1D7FeejhvTCaJZuaA4zXDMiFRzu7OgXDitAxV
 P//yco1c0MJMKeuWT0063vZ6Vi/WxvEt17uxJrusMFQ2+lWHAjlEdmAs3PJ5KWWPwI1yxPnTJS1
 /IfPiE8OCIgNGR14oVnEYWBjAcy3rhgZtOEirxtsE/oLnCVqhy+BpwNVlURakXYOi868KjiJdag
 CzDv9BcgE5h2afrLtBmb+ZK91yJxE6GhWMhSGT1JsZ3seXKl8F31i9DLqYIZc6pTG+5Kj6et2WK
 WpYqO3sQy4v8BGRHYOB6QmPapw2VY2gfcacI5Q2nrcGh6k3GktbAObtQP4QW+IcW/bnpUpGC9CO
 1bMgEbMV0ocs23cZSQK3BfAEyT+/veU24j5JdSrSDV06s9oBtLWthRwSc0gyt3ANgZhaCRY9Kwp
 jm4oEEZwWDSddhFSoR4SxokCTE+iNh+ndV5QmNQh3l/7cY12knL1GK4/f5AeQ4Iw==
X-Received: by 2002:a05:620a:5394:10b0:949:bda2:194d with SMTP id
 af79cd13be357-949bda21c95mr3243170885a.83.1795808706177; 
 Fri, 27 Nov 2026 11:45:06 -0800 (PST)
X-Received: by 2002:a05:620a:5394:10b0:949:bda2:194d with SMTP id
 af79cd13be357-949bda21c95mr3243165885a.83.1795808705662; 
 Fri, 27 Nov 2026 11:45:05 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:45:04 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:21 +0200
Subject: [PATCH v4 08/14] drm/msm/mdp4: unwind a failed mdp4_kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-8-242b0a3f8e47@oss.qualcomm.com>
References: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
In-Reply-To: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6028;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=xcpZH/JchJVGlWrWDcBXjibsRjJg497QsmYpUE4TNpg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2jfkCaZnHFLyBVnOT/TOH2fQmbOy0Xm7jKe
 ZuP34BdLWqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndowAKCRCLPIo+Aiko
 1TMuB/99gAkJCsdqUs6LDWs705IAgry+J01ObO8FSwcAttbKjP0qlISAvOazaCXFTyiZ+RWMHii
 a5M/hHmQgq1R59kJCEGntlG90tY9/UTgC6xlCSr4m1BEWJmM4WCAdkIrHO41rahW2C+ocO9UAki
 qymH53ebepwj0nmNgeIA92IZgwO3oZglUKA88BEY2wuyepqE+SyS9M18Q9xpZ0FyMoYtMbu0EAx
 LA8wimH3K7GNpve8jlWRLO5OFXpe7F+AEmP7nue/9LJlti9Wrh++2Pr9S3FMxNPuFr5Hh3cEPmS
 mJpVpZaJRlii5T74/7bDmdf83cPM9mUGoDwCfSqRvyfF/PVl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: sxzu1F9iWqSsGx5E-oWNqDXmp85j2o8E
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09ddc2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=j6QtfvlM2Oj41uVX788A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfXynEO3hdtKcid
 W0/f5c3q0O45ac0hK2JJhKAzfKJaqD/+F46g+t7Cmv5q5AaAdG4hsf1CkiXk83Q+MXt/t9XcJpN
 bk26cb+CCOZPke+/H+p4NXjntEAM09E=
X-Proofpoint-GUID: sxzu1F9iWqSsGx5E-oWNqDXmp85j2o8E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX8ZA8OuWHdVvO
 KomuhCEeJ04+rzJv/Vbwvs0PvqJYynSmP4jQnSfZrMnsqGzm0TBUVagrNGPWM2Uykx2+lVwLyX4
 hEW9VAfKlrwLCf2JDYL7fM3KHl7ruX/kcrZdbxpGIje/qR7D18ADRk/g4SHRFoyz92y8MxUGIHk
 mlGm/65SK8PJ+L6CsK/B+A5K7y/OsCl2jZrtelP8KR8C67dj50oJ4ElO8LU4uyKV6OFjq/otuVf
 Tra6R0DvKslb6mgyPqfXm6pwohcXoMDmbmZqgP0K/ETagWGDnSQaM3XJbFMD36z3ugOK6HRZOry
 fRVJd8dpLzHCHPBJX/SDt+Av38e97CONfL3PE6r8tMxjGRyes+RmiFrqXiD9AOgdpe5SA6WdwIk
 1ayEBDIj6TpwjjED5d2LXRdNtk4yIjdYPbRa1YL8Z/s73jAW3Dk1n7VivDtKBqgtmB/pXuhKbQ5
 eVmWSU4XautRcjHD2qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270078
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
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

