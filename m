Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF5ACA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0694010E708;
	Sat,  3 Oct 2026 00:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BVQUptdV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WIKbrjdY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0150110E724
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:27:24 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeOpT3884883
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ogsS/jQqQGNaZU14R1Zy5X9gpKci6CxSdzR0pKxji9U=; b=BVQUptdVQjnSpGR3
 +kUWU5nihTeH6yXI322fiqgxqEwMsf3LrkMVBe3X15uZ++/A+/s3ma8TMgjSTtl+
 OnZ+zAuiYtU2JjuQfKCStkYzrREt6UzPblMQwG6IgaCr0d7FoZ66z5bklZdwj5ba
 CfNwl25hDiu3A/V0dxcyrjfHkj/jSvHcpj/Yq32jl0BWFtfhqjZqmzpvo3D6RM3o
 3LBG/s+g44iYH0nH/y8xZZaQ04vXC80jd7egf7iL2FmJyky1UKh7HpAr1ZnTHGEV
 vmJE7jog2njRuWCDmXgOiZausoVEHriAI+gtm2Su9aqKCt51J0NOwjO+sXurUVMn
 Osne0Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp40jv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:27:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso24082985a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987243; x=1791592043;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ogsS/jQqQGNaZU14R1Zy5X9gpKci6CxSdzR0pKxji9U=;
 b=WIKbrjdYQtSze5EDn6zpzsZ5G0GWZqNQC3I+QJn7lZaF6facCfvnkQimPruZJpOsJs
 SNHkelNiGhilQgXsSUboFdHbHUZPbRZh06bE7nMPYBKRgAe5mqgui13zCt1LjGlNQWhC
 Cde3OkShM16tFNovCin7E06LWkAc+bdFB9/iJQjG8Gf78W6bBSXxS2c3Zr/8+2BzB+cN
 TTraV1APqkCPLElDw4B572LCtIAv+dmaeQw7EqXvN1n6wXHWFxQQPYPu4TqILFbP3DU9
 +Mq9aMPmJNHRBzs9xGSVYROIL2G60NLuQm8VS2SLLw+sZew0F29CkYJRDwor5jenU+l+
 jUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987243; x=1791592043;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ogsS/jQqQGNaZU14R1Zy5X9gpKci6CxSdzR0pKxji9U=;
 b=gf4zrGp4ibVR5/VzTp3Vtrbr3epZt+5UL074IYWwqmR+O0m+c4lk6NIUvaRodSnE3r
 XeDluP4RHOKID2GqMAa6lJKWKCmuiDMFzYbIHwbLVvmmIFlQrIy6zUfLL9wjTyc+sJhk
 18y9dhOaXsEkOaqNa16t2eYTeLHmEcKnJ0uoaUhMdqMkwhmyXUZr4PXvUdEaxgV8uQDD
 QWmqGxM3HIdKheglVK0mFH7pHFbwF6E7/uNXhvc45eJfxdpxoZJhRFs98kS7m3glUvtD
 MUGZyFddBDjbdxQRwrPSttJTM0Fw2m/+VXKuWV1xqHqu74X+l764aYszPpbZkCb0T4u+
 e2sw==
X-Forwarded-Encrypted: i=1;
 AKwUvByzOwDJ4aSlth5tyQqad9ptulTiI9lGF9+V1R/NPhJsLugE8QRFjqs3U5SUVtbhXpRrt6sm1fkVEyY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m4mhky/zTyvBu81WovXV0SEH8evWW8SYK04vfeAE6XYMNQ/Szh
 EjGDbvKxMEucxNGABhO9jMRYyxe5YKsnTd64ndhWfylxtMfuNK49lErbp5MYKxxb/KOu4IVCU57
 aEWsFajBnKxv8FGR2YPqwfESFJR37ePUn3idwBTETdskhNczO+8eTVKuuIapv/ZI4gKjsCvA=
X-Gm-Gg: AYBFou3OuYVwaee6gWVAjBUoF/UueE85hTsmo9OM5VzyMGTFNpaL7AqhAdQPW21ymC3
 W058d7HmnnizLFiIDROxnV8jMWEdhgmFLfQVo32NVzl7pg91Z83ySlThbmzWsbV6CFhGQlolLLL
 xETFHepX5E7BWlgTNMUYIe7tlgAyT1a5cR06tPOa65kkYzmXT7E/+LvNDUCbyULyropg43iDhK0
 LjRIx/nj3wtTAum9io75MUg/j5Q3KBMDTSwXBoH3gFsK1k0idieS9Rnk0nDGufUZB2f04nup2eZ
 gPcFwEIZib4ocbc2FBGGbiMo3nFYV08YYLqhjHL/lQx27fjzqElXH6T7efo0HrBtRS8SsWbeU//
 ioS8C7c6Er7KQ5I6gyJVauFP9PDZVaw7376kFhLO2aPbPkYrDfqCNrjgDSeH59oK6OzzNQvY0/l
 e52jAjPvPtItfP
X-Received: by 2002:a05:620a:8905:b0:939:c1d4:e2e1 with SMTP id
 af79cd13be357-93e50ff4d21mr192194185a.25.1790987243369; 
 Fri, 02 Oct 2026 17:27:23 -0700 (PDT)
X-Received: by 2002:a05:620a:8905:b0:939:c1d4:e2e1 with SMTP id
 af79cd13be357-93e50ff4d21mr192191085a.25.1790987242879; 
 Fri, 02 Oct 2026 17:27:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb86e68806sm1120705e87.4.2026.10.02.17.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:27:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:27:13 +0300
Subject: [PATCH 05/11] drm/msm/mdp5: unwind a failed mdp5_kms_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-msm-kms-destroy-fixes-v1-5-e062b7dae77f@oss.qualcomm.com>
References: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
In-Reply-To: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4294;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=IFWL5o3N81bntEjvnmwlorbJQICmB+ZJO+BqKeM8HXE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEvgaymGG3Y9A8ghiW2JNHulGYyoIHagrR+OF
 sq+UkPHsN2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBL4AAKCRCLPIo+Aiko
 1U6wB/49mib2gRdKTNw8FYBBcTErHEA21B68qChnh22n3nTSotEFsaD00sQDaEQ4lj7Ua8lNB61
 QKsaX1eZxLjHolz+2xylPjO90iq9/j1RqypyxOxGtya2duz3CYZ8sF6XfucOwKKnXcJ8azX0Uib
 3sBv+RvTnUkayX3Y+0OXt+r1BuiK9hPEDIP3RN+PAILIUfO227bQDLnx9AN0j5zhZO8dGXyjDF0
 r2lau3v7+l9ItKAf+Y8PjKOjt9yvy7kpFLG7sFANGhxyZtZaN+rM8ikUYUg/pqxy+fQbcr3OE1X
 naUZUd/5+G5/XhDcmS6wrgOja/79nR7AbSGhrJWzomMj5SR2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6ac04bec cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=MU5U8ZpPrSxGNErEH5sA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: ru_Aehg1GiW-APUs_9-JJGxg4GkZWZ2P
X-Proofpoint-ORIG-GUID: ru_Aehg1GiW-APUs_9-JJGxg4GkZWZ2P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX68OJRdCMBPJ0
 KDoZJE/v32hUbvGs1GmEC7BOFc2zP61FAVxhLFJO/FAz1oyhnJzkYjuCQEECHS9qWEjen9IRbwx
 FxOq4IHIKhyexdHroeY1xFPurL66T+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX+G4CpdNhsps7
 swepWxnYpleH7bY38l7DiFJv83DjLAkW4U3XoUmzPgOeP7amxxtaWle2Txm4tMEn0UCPOef0oPg
 Wc07bmRQBIgre5hSe+iSwAP3qF1XlZczkn6Db/xPP4w4VlPE2VoHSKYum5I8kqL6fybO2CorhPa
 n2FMVepJdgoeLTmgYTeRUq7nsojKxJlDwDuOKpeMC/Nn8WFXoQQvP/ODWKEQ4ndTtuckMDIdGsy
 7cTD+pcFKflAQsBEYy0d2SiV8OLhsWzauyigs5ozgv3OGjf0Nk5be6zrH9tEmFUsv4lAlamVGH9
 KSgeM54Oz3HRIICo6ByWy3W7rxBnKsSFYhTYq7g35dRqtgmysAdpm5qCjg0go0mAA3VS2OVvZF7
 1o6jdwVvYrMls6eV/yuC2BVLpbepraafvSq3ub5D3rt8Rfl+qf0c04QYwxbQ4gBB7qyvDUPwXLM
 vlLQzvdxTGQ3jqwd6lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

mdp5_kms_init() returns straight away when one of its later steps fails,
leaving behind the kms, the runtime PM reference taken around the address
space setup and the address space itself, and lets the ->destroy()
callback, which the caller runs afterwards, clean up. When mdp5_init()
fails, however, it has already run mdp5_destroy() itself, and ->destroy()
runs it a second time: the global state object is finalised twice.

Undo the steps which have completed, in the reverse order, drop the
runtime PM reference on the error path as well, and tell the caller not
to run ->destroy() after a failed init. Fold the hardware setup, which
can't fail, into mdp5_kms_init().

Fixes: 8d58ef346f30 ("drm/msm/mdp5: Add global state as a private atomic object")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 44 ++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 3934cd060b27..8fc8cdcf7d8c 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -19,9 +19,8 @@
 #include "msm_mmu.h"
 #include "mdp5_kms.h"
 
-static int mdp5_hw_init(struct msm_kms *kms)
+static void mdp5_hw_init(struct mdp5_kms *mdp5_kms)
 {
-	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
 	struct device *dev = &mdp5_kms->pdev->dev;
 	unsigned long flags;
 
@@ -58,8 +57,6 @@ static int mdp5_hw_init(struct msm_kms *kms)
 	mdp5_ctlm_hw_reset(mdp5_kms->ctlm);
 
 	pm_runtime_put_sync(dev);
-
-	return 0;
 }
 
 /* Global/shared object state funcs */
@@ -198,24 +195,25 @@ static void mdp5_complete_commit(struct msm_kms *kms, unsigned crtc_mask)
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms);
 
-static void mdp5_kms_destroy(struct msm_kms *kms)
+static void mdp5_kms_destroy_vm(struct msm_kms *kms)
 {
-	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
+	struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
 
-	if (kms->vm) {
-		struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
+	mmu->funcs->detach(mmu);
+	drm_gpuvm_put(kms->vm);
+}
 
-		mmu->funcs->detach(mmu);
-		drm_gpuvm_put(kms->vm);
-	}
+static void mdp5_kms_destroy(struct msm_kms *kms)
+{
+	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
 
+	mdp5_kms_destroy_vm(kms);
 	mdp_kms_destroy(&mdp5_kms->base);
 	mdp5_destroy(mdp5_kms);
 }
 
 static const struct mdp_kms_funcs kms_funcs = {
 	.base = {
-		.hw_init         = mdp5_hw_init,
 		.irq_preinstall  = mdp5_irq_preinstall,
 		.irq_postinstall = mdp5_irq_postinstall,
 		.irq_uninstall   = mdp5_irq_uninstall,
@@ -506,6 +504,8 @@ static int mdp5_kms_init(struct drm_device *dev)
 	struct drm_gpuvm *vm;
 	int i, ret;
 
+	kms->init_unwinds = true;
+
 	ret = mdp5_init(to_platform_device(dev->dev), dev);
 	if (ret)
 		return ret;
@@ -517,7 +517,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 	ret = mdp_kms_init(&mdp5_kms->base, &kms_funcs);
 	if (ret) {
 		DRM_DEV_ERROR(&pdev->dev, "failed to init kms\n");
-		return ret;
+		goto err_mdp5_destroy;
 	}
 
 	config = mdp5_cfg_get_config(mdp5_kms->cfg);
@@ -538,19 +538,18 @@ static int mdp5_kms_init(struct drm_device *dev)
 	mdelay(16);
 
 	vm = msm_kms_init_vm(mdp5_kms->dev, pdev->dev.parent);
+	pm_runtime_put_sync(&pdev->dev);
 	if (IS_ERR(vm)) {
 		ret = PTR_ERR(vm);
-		return ret;
+		goto err_kms_destroy;
 	}
 
 	kms->vm = vm;
 
-	pm_runtime_put_sync(&pdev->dev);
-
 	ret = modeset_init(mdp5_kms);
 	if (ret) {
 		DRM_DEV_ERROR(&pdev->dev, "modeset_init failed: %d\n", ret);
-		return ret;
+		goto err_destroy_vm;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -561,7 +560,18 @@ static int mdp5_kms_init(struct drm_device *dev)
 	dev->max_vblank_count = 0; /* max_vblank_count is set on each CRTC */
 	dev->vblank_disable_immediate = true;
 
+	mdp5_hw_init(mdp5_kms);
+
 	return 0;
+
+err_destroy_vm:
+	mdp5_kms_destroy_vm(kms);
+err_kms_destroy:
+	mdp_kms_destroy(&mdp5_kms->base);
+err_mdp5_destroy:
+	mdp5_destroy(mdp5_kms);
+
+	return ret;
 }
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms)

-- 
2.47.3

