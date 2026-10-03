Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FB7CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DE410FA49;
	Sat,  3 Oct 2026 00:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HxBi3rem";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RVQn2CTz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F8310FA49
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:27:26 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ndwji3883819
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mkXrHRCfuN0GmbBK9rLrKsbGsgnfDbEVKr112JlZi40=; b=HxBi3remvD6d+azP
 9KExQ8eUm3liwiKjVc0zLaYddcm0VngMWzFZiHAS7E0wgeKrdXUo1B+2I9uvKt7O
 tfJnzQg0PK2Q8UvRnVI0iqlq6bDbvmj3bvNykIflkzmMsNxxstCIc2C9yACfykf+
 3ixmzlA8DIstr6oITLmnHzmH7j9qnODHL5TY5KfopYIqBSWaUzAJlh3qcp8JD8dQ
 J81xfyDdNp0g5jKunnYGoE56v5Ijf+ymDpf2hjEgbnNRkVinXFQcHyeN7gXdVYQL
 FS3PxVthheXq2JRQwZz2Z1Fo+jitikLopZobZtZA9qYFgyLewAFE5pFnV1437El7
 MYrICw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp40k2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:27:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91786abb5abso6522076d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987245; x=1791592045;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mkXrHRCfuN0GmbBK9rLrKsbGsgnfDbEVKr112JlZi40=;
 b=RVQn2CTzNErsL82K6OPXk239BD8aPuX4rCMpjzHlm4pE/uur42v1Ydeqz3NH9G/rGJ
 fPZkAeneLQWPTXH4PKxSk/EcgIoiUg4l3bM1YEtbLIrkqCnOCkzWz3kjyHXrBl//4jxY
 oHpko3d2jrYZK5jwzmsoZR1/jjAwSnH5pbJB3tE93qtMtew5/lfeQNhRasnJx/VQXoX4
 UiakjdDCuMLfa0qOAJn2+fiZhh0OZU1BuxBj0IfWY6WP5Kb5Xq22sqW4GtZlwDKHigMp
 AsqcwxeTrMplg8LKSRG8Wd7vWTGiG/cNg90y/krf1nFPWtCXbVo8I2Jpj53aSOR9HYR8
 glqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987245; x=1791592045;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mkXrHRCfuN0GmbBK9rLrKsbGsgnfDbEVKr112JlZi40=;
 b=12IJllMqP6JWEKNbP2OO7sHcuAPxk8vjlVkdB7r8KJ9KuH6KZh2PUQpM7boUXlxCx8
 0BRizTIgqdISaUGEVuLOCWwJ2B6Dp/V0pj8maHNv78dYrSWNkaFK3Aa7sPy6A4DmYFIb
 vAeNxTZerWpYzvh1U4i2SHZX+MK2lDifc8qfLaQ6WTF/4ZEthcpQ8ALCxGK0DaKDYZxZ
 dBZgvJl0aN5uGctmSEo5Ot6QwV1HwwAWnYBZduGc1Q+2B+EI6YTVuEOxoAWBLSTM7gUR
 dmYqGhXVuvmGNQlA+PtcmXK5IRTauTEnpAnZoiH9heknwi7XDzVjffeQ31IE+JCo52Lt
 xzrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0oPB6BMchJ9QxHQFKDH9YOLTRG/LkswvKMOWz/fRntDZAPJAf3aJ8HCHP+aRDc8H6hzqlR/pjWQ4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kJ211S9pUZzKVtuRCyV8zwjDJEpu3/DsBC9DzbQHOsHCtyXU86
 ljUKzeSHqwxR69e8eVV+CF90A0XqygydWkssFCYNNBuUylj302M17awPMFbkuwCZ0pyb+5PvBwu
 9fgYqbpyOV8LS0PA22Izr/2raWrRhlcKPfHJT43sBmCH3JYbS0YG7cB6HiChxDRHHUb0R81tB6v
 sajuA=
X-Gm-Gg: AYBFou1TgrElsnAqhNJTa+aZm0eHug0PS5mK9Itxc8Ip5mpOr4OwroRlNI+wHsOwIK+
 Mez1eRkPWNlXvomg2Fl+5iJkSfgHJqQiOimYVei+hF41xjwCs6e4fZ8caXxP2sx2NeoonIamKUk
 JHvBWvVxvWw1pZIbbk8T5qcTqX1Eo0dMgpiBg3wV56cQAeSuXOtYzqPJHzMJAe79Im6RyV+8rT8
 6LejSWxxeDOAmfPZFogaC2LieAHwmh7DEj9EVokCwHSA+zPR1SNBQA4lv1vyOfgVERtVg4gDDsJ
 k2whjZ3/cgPUd6gJktMtkPlHdDidrSoognpXELRh8gnlcpuXUEGp7K/rgPt147sPkUlexufUg4q
 mRr0DjykWrQmv87nLOTf2SaPY9xmOma44bp88YcuFW4Kas8IZozmPwh82ldFQhQKDGSGwt4O+uW
 HjEwCeo6OJhVv1
X-Received: by 2002:a05:620a:4413:b0:93b:fb3c:2d09 with SMTP id
 af79cd13be357-93e510fc7admr192193285a.66.1790987244766; 
 Fri, 02 Oct 2026 17:27:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4413:b0:93b:fb3c:2d09 with SMTP id
 af79cd13be357-93e510fc7admr192190585a.66.1790987244284; 
 Fri, 02 Oct 2026 17:27:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb86e68806sm1120705e87.4.2026.10.02.17.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:27:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:27:14 +0300
Subject: [PATCH 06/11] drm/msm/mdp4: unwind a failed mdp4_kms_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-msm-kms-destroy-fixes-v1-6-e062b7dae77f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5689;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2c1I87gys9JdEQITwLEUGMJIO/TOjP0g3COX8QyNL4s=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9YB7wfTDj7kTz9zrjOwfmPI/7pmYZtE+XmeQnXLg29s2
 CnFsGhvJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAm0hnG/k+31kffg9v1VHfi
 McuFsv/XhJw1eP+CRf3LkX5z44dMRde1iz3r9+58oRh3zaQlL9fpsDhH3YPoWaWf6r56fzBNu1/
 guXS5yb+96Vd/m3xO83FtM5SwOFPVeifXeGvrTvntixiNgmRYE3pnuDOIdfEmBknonHiwOrMpxk
 NYPc9Io05/UbCgnPe5/BOHjV0eBl95cOjjB8mg1Yb9y8Klr1Zo75Vbv5b7MuOd5ZyeH7WyNKoi7
 FbEP3M+zpp01k5r63SRzxo7ZfMLs6wn8d0VZVkTWbbubsBT71frJwrJ8+36dLGkYV7AT2+GyJ2K
 ujdyNup9ZZgv83Zmq52BkPlt2+tRTPKmz08J9FQFqc8BAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6ac04bed cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=j6QtfvlM2Oj41uVX788A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: NLIkUB2Lbjh6Blono-qAs4ZsobRKGPI7
X-Proofpoint-ORIG-GUID: NLIkUB2Lbjh6Blono-qAs4ZsobRKGPI7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX47OBLlEAiNaA
 xGLoIq6JxRAsf9okZteu51AX/1iORj0Uw8NfWdbA4wNCzpBWXDgLbfegXtT4B6gIrazwDsnr66l
 s4nNauzrLRatI1crVXI9EXhVAOqfKMM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfXyvjcsM5thNfY
 1orSPf5Vfv21FJ7KMerGK0NSixrN5aBf95bjlBOn6XZbXOf1nyKm9hWtBwIY1Cql+bcxz7Oa6Lu
 NvqlQHAgRIvSML4zynxrWp5quTQd6jxwHrIZsIhhixTMtPc3sNUw4hYs5RsA9AuvBGxyvrR/Z/r
 O36azTVbJURaGZ1WOHP+AXOIks6N12N5fYWI8dohNuuBDpm+awjaZkWO8Fj24ylVlvJvXUnn6Bh
 1TsXfCaYOaikFb1j71Fvu1Hf0ntnHHcQIv6EgtUsbxkdmb35laBOk6+vpUPPIaeJROtJYRRgbmo
 iVR+Z8KRRsOdpJoBsxH3zMWRUBGsHanO2jKiVpf5d1R7M/1UgCJShBQjJFc7sLifQN71VWvC/74
 8HzQ2u/jVUJJkxi9KfcXauWFbtCzn2/sMD+eCFv+RIOimhrWWWKkdtVgG//lknwodzNzMXMcrht
 SawfIfOSZAULbMcMe6w==
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
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 56 ++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 9b1d1982e683..8e51305f8dde 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -15,9 +15,8 @@
 #include "msm_mmu.h"
 #include "mdp4_kms.h"
 
-static int mdp4_hw_init(struct msm_kms *kms)
+static void mdp4_hw_init(struct mdp4_kms *mdp4_kms)
 {
-	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
 	struct drm_device *dev = mdp4_kms->dev;
 	u32 dmap_cfg, vg_cfg;
 	unsigned long clk;
@@ -70,8 +69,6 @@ static int mdp4_hw_init(struct msm_kms *kms)
 		mdp4_write(mdp4_kms, REG_MDP4_RESET_STATUS, 1);
 
 	pm_runtime_put_sync(dev->dev);
-
-	return 0;
 }
 
 static void mdp4_enable_commit(struct msm_kms *kms)
@@ -118,6 +115,14 @@ static long mdp4_round_pixclk(struct msm_kms *kms, unsigned long rate,
 	}
 }
 
+static void mdp4_destroy_vm(struct msm_kms *kms)
+{
+	struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
+
+	mmu->funcs->detach(mmu);
+	drm_gpuvm_put(kms->vm);
+}
+
 static void mdp4_destroy(struct msm_kms *kms)
 {
 	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
@@ -127,12 +132,7 @@ static void mdp4_destroy(struct msm_kms *kms)
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
@@ -142,7 +142,6 @@ static void mdp4_destroy(struct msm_kms *kms)
 
 static const struct mdp_kms_funcs kms_funcs = {
 	.base = {
-		.hw_init         = mdp4_hw_init,
 		.irq_preinstall  = mdp4_irq_preinstall,
 		.irq_postinstall = mdp4_irq_postinstall,
 		.irq_uninstall   = mdp4_irq_uninstall,
@@ -395,6 +394,9 @@ static int mdp4_kms_init(struct drm_device *dev)
 	/* TODO: Chips that aren't apq8064 have a 200 Mhz max_clk */
 	max_clk = 266667000;
 
+	priv->kms->init_unwinds = true;
+	mdp4_kms->dev = dev;
+
 	ret = mdp_kms_init(&mdp4_kms->base, &kms_funcs);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "failed to init kms\n");
@@ -403,13 +405,11 @@ static int mdp4_kms_init(struct drm_device *dev)
 
 	kms = priv->kms;
 
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
 
@@ -421,7 +421,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		DRM_DEV_ERROR(dev->dev, "unexpected MDP version: v%d.%d\n",
 			      major, minor);
 		ret = -ENXIO;
-		return ret;
+		goto err_disable_vdd;
 	}
 
 	mdp4_kms->rev = minor;
@@ -430,7 +430,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		if (!mdp4_kms->lut_clk) {
 			DRM_DEV_ERROR(dev->dev, "failed to get lut_clk\n");
 			ret = -ENODEV;
-			return ret;
+			goto err_disable_vdd;
 		}
 		clk_set_rate(mdp4_kms->lut_clk, max_clk);
 	}
@@ -452,7 +452,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	vm = msm_kms_init_vm(mdp4_kms->dev, NULL);
 	if (IS_ERR(vm)) {
 		ret = PTR_ERR(vm);
-		return ret;
+		goto err_disable_rpm;
 	}
 
 	kms->vm = vm;
@@ -460,7 +460,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	ret = modeset_init(mdp4_kms);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "modeset_init failed: %d\n", ret);
-		return ret;
+		goto err_destroy_vm;
 	}
 
 	mdp4_kms->blank_cursor_bo = msm_gem_new(dev, SZ_16K, MSM_BO_WC | MSM_BO_SCANOUT, NULL);
@@ -468,14 +468,14 @@ static int mdp4_kms_init(struct drm_device *dev)
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
@@ -483,7 +483,23 @@ static int mdp4_kms_init(struct drm_device *dev)
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

