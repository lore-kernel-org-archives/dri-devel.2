Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417B2CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881D810E7AC;
	Mon, 28 Sep 2026 06:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X4M8ulpk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q7WCqZ+m";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0927510E7AC
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:59:16 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S597221501012
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6riuziqggSIQ5VIX9CrxjJ
 eBcpTwr5JJlcJHLZ23opo=; b=X4M8ulpk943Ba2JoFbRRWMnNYbasonQENBHUd0
 bU9rQs/jHENvvD4HVpLKoVanGGjyyCzOTGXhqOvZZPfjvlGm+S4tMZtloCM0ttzy
 w8GWnFgb0qSGepjnT0ItKuMj1pd2qWa1EnOu9hK1G5K86rlt6oleKtJrQhQecrbR
 FMh6VH+HM5iuxN46gaupSXrUyrNuNJOOTqo9a/+uet7FX4IatQTwBjzLOozpYTOG
 rp/FFVOEU8DyRutdBFZTpa/sR+9ioLC9S/BxAyDAYsmXRsTB4uoRZCegttpnC9Ry
 3CXIlx8NHVAf1c0JnZhk9PaReva/Sa+ffSYKc4PzFfubz3XQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubgan3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:59:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-86917d18880so2000910b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 23:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790578755; x=1791183555;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6riuziqggSIQ5VIX9CrxjJeBcpTwr5JJlcJHLZ23opo=;
 b=Q7WCqZ+m+jj2Vj106bxDxvvb3b594qG5IDfl5SOl+Px+jaUhAAm7r5U82o9jKRduf+
 V8lMR2n5sPvpcmQjW76lPuOw2uFER2+MIE+fC3hbCh2P7xpWpOq9MQMR72bzA8PC8568
 kSomVpbhaR5Mjd2l3WKTUmG4qbyOKXxbv8Ro9vQmOpKy3r/ZjcjzSn/D4o3YzvoCH21s
 xZar+wFfZEy6TwuCZz+5MbhVV18vGCbo/gyknNQ7fiPu0MgrcYvk9n1zS5bVrYFcont+
 fkqhGrxapLl7tgkz1lsAigg9dSouu/lmcsuuhEh2tBx9Q1jM6Dutywn6DRhAyVszxOp8
 qH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790578755; x=1791183555;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6riuziqggSIQ5VIX9CrxjJeBcpTwr5JJlcJHLZ23opo=;
 b=camofw8/S25Thg+FrLG4ksYg3D/L0W1yM5cL8O01jpy06beh8nBqP5a983H7KF2UOC
 S8j9m1w2u55Oa5XGLI/TxS48UOg/7P3S7BcltPIbV3eJOz2NXe5rpPD5dNXSmDvQjkFZ
 454XV4en5+C4AqtRuZkVpJPTUfZjWsNLtJpQn/iVbwqI8rr7/4cPvwKl7BTOfucUN3xC
 AcjINMKU9ZfniuusczZ4doLGmaUs/ZD7Je99KmD8Q4EttCuOyn9yEY4tkXZsRJyIr1Ok
 anvEH1O9Us+1VH4+zz2/04vAFqbS6/KzKwrrUI8IdKqbj8KeIpzGQryW6QH/MhNxtUah
 IZJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFwLRAUUDI/uh+/oAutAlXgv9/3RmvPvD8Y9OSBuiOGZ+8QOrWCJaGNGEip+0PKIoEs4VqjctllyM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lafh8fwlAXHvmIUg10vJb0Bg7RgRXh2NHlq2qUqc6LybPXYDTP
 QiPhU6cvVJyWT5CKJ7rxChDGL0tjd6+rthKYdFuq9O4IOCMdyiSxKc3gpp/i+Kb9aLiZftCPsWH
 kMlf2GpPvxlyF5Dw+0yiTQZO9QxSP4nA2Z8yjk7D7UYOtaE4Y17uTwJ23y+GS7cArsku4jjA=
X-Gm-Gg: AYBFou2SgwVQ/LaokYVntCeKK+CNMHdaBaq/pa5bEYKYQzL5VoVY23ADr8IuOOPh+Pc
 PkBtMbIPMHMwvz8abUCxNnK06FVD8+wOwHbOHH/62psujgxtWlDFUhRQSTH8kuyA99fQYDgZbwE
 4HZSKJt204iu4WLQ153Cahe1VIhFNULuVkL2VxUdqXFNE/WAYIfLUumygsKBRPKAZL3M3Zbvlzz
 TSGMIypVnd4rebdgXaiCY6U/DtZiOpuKi1doWo25vlB8DGhIMA30+N6caBtYUDlxT3qOFhPBDMf
 lwKxeKfdfAECvv50hfkRE4NltOJkR87MV/QthMB0xX3/D0YY2vjfSqho5Mj4zAgh3fl5TJT8DJW
 Y/0b0S6RT1fi47KOJdtOrSy0U+w==
X-Received: by 2002:a05:6a00:4fd2:b0:882:157d:95c7 with SMTP id
 d2e1a72fcca58-882157da533mr3260914b3a.14.1790578754561; 
 Sun, 27 Sep 2026 23:59:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fd2:b0:882:157d:95c7 with SMTP id
 d2e1a72fcca58-882157da533mr3260890b3a.14.1790578754068; 
 Sun, 27 Sep 2026 23:59:14 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-883218be96bsm1106706b3a.52.2026.09.27.23.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 23:59:13 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:28:45 +0530
Subject: [PATCH v4] drm/msm: default separate_gpu_kms to auto selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-separate_gpu_kms-v4-1-3f33175de133@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACQQumoC/3XOwQrCMAwG4FeRnq00aV2tJ99DRLou06Jzs9Wiy
 N7dTg8q6iXwB/4vubFIwVNk89GNBUo++vaQgxqPmNvaw4a4r3JmKLAQEgoeqbPBnmi96c7rXRO
 5UBW6WlUGCFmudYFqf3mQy1XOWx9Pbbg+LiQYtk8MUQ4YfWAJOHCaoQTSNRSz6aKNcXI8271rm
 2aSBxvMhC9Hgv5+KmF2SoHaWaNLU9MfR745UvxwZHaspKkqjTMK9A+n7/s7j+4jLUcBAAA=
X-Change-ID: 20260316-separate_gpu_kms-04d2cf4d91e2
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790578749; l=10135;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=Qbu1ajf2zMMBmGHIiRKeFRx8ze0javq01HlVA1lp2Mc=;
 b=9eYVLlvU5vvz5oTTfbLCudBaNI1mc7M3jI39PZOEPJ0cVYtedY3jGoCe54N/1lmDeITPuVBHN
 TEboS2ZjU7hCnVUtm/DF4nK0ONHSutDwcH5P+pMknpWyUJVtLOtIp0y
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-GUID: HQit2Cnf9NHytnWiz49PjdEpADaQEGMF
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba1043 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_92pshTILgvs2gbH5AkA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: HQit2Cnf9NHytnWiz49PjdEpADaQEGMF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNyBTYWx0ZWRfX/4pGXDt3tkZP
 68Jtci7uGwOaqDYe6yapXH+BqAK/fMDLjYuR3ACphFrFNnjJpD/SJ0W39GZgACZUpgaZ3gKcp9m
 62XvZRHjj4yoSoitOMAMlGGRVwEXgGHqkwoklgtDs4MWKsdVKtZrD7rVu3EUtchDRQ/d0CiHJk3
 V8QmVlPDqMtouPb2zlCK8msf9UfIwY7tqW7OFuIw93TvKFThJYpPW3UTxglWExqZnzKVoGeXPGp
 7FFNsiSvoF+sC0b7s/XUR2Bgrmk50ZraAxf5dXNxbZ6cW2u6YYrc7p7bzcvcIFmesaN64FlhMO0
 NZmJB57Ber/rI0hgsuf9boNmICQsxACVnYvmE1iQk4YLQt3GdIqhx36ydjJS7pqm9khOtr8O5ET
 VMDEr8uWAdzGwcxME/8asK53yGkpzzPOJjGjx4DFJn3fUXZnH63qOsSwm+wSZF9k8xzTp/LWdJy
 OqkxsqV8bttgifvo/Xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNyBTYWx0ZWRfXxirhM1cd4bYF
 mP5vWizO6yAG59CpbfP0s+PmMqGLKEQmWzuF2r3tp6x8CnLR0YagYcHWvBfnIMvUzMa0OX1ynbF
 D/9l/rk6BqjWT76zXyScwEc0Tlz1vFc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280027
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

On platforms with multiple display subsystems, such as SA8775P, the GPU
binds to the first display subsystem that probes. This implicit binding
prevents subsequent display subsystems from probing successfully,
breaking multi-display support.

Use the tristate separate_gpu_kms module parameter with the default
value set to auto (-1). In auto mode, the driver selects the binding
behavior based on the number of GPUs and display subsystems. This allows
display subsystems to probe independently when required, while
preserving the existing single-card behavior on simpler systems.

The separate_gpu_kms module parameter has the following semantics:

  -1 (auto, default):
     Select the binding mode based on hardware topology. If exactly one
     GPU and one display subsystem are present, bind them together to
     form a single DRM device. Otherwise, expose the GPU and display
     subsystems as separate DRM devices.

   0:
     Always bind the GPU and display together to form a single DRM
     device.

   1:
     Always expose the GPU and display subsystems as separate DRM
     devices.

Additionally, ensure that display subsystems are always exposed as
separate DRM devices when no recognized Adreno GPU is present,
regardless of the separate_gpu_kms setting.

This ensures correct probing on multi-display platforms without
affecting single-display, single-GPU systems.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
Changes in v4:
- Fix OF node refcount leak in msm_separate_gpu_kms_components(). (sashiko-bot)
- Fix build errors when MDSS/MDP4 are disabled by adding stubs. (kernel test robot)
- Drop msm_count_mdp5(); MDP5 always sits under a qcom,mdss node, so it was
  counted twice.
- adreno_probe(): don't create a standalone GPU device for an unrecognized
  GPU.
- Link to v3: https://lore.kernel.org/r/20260330-separate_gpu_kms-v3-1-a3e54b9c9417@oss.qualcomm.com

Changes in v3:
- Ensure display subsystems are always exposed as separate DRM devices when
  no recognized Adreno GPU is present (!adreno_has_gpu()), regardless of
  separate_gpu_kms setting. (Dmitry)
- Extend auto-selection logic to account for legacy display controllers (MDP4 and MDP5). (Dmitry)
- Rename msm_mdss_count_masters() to msm_mdss_count() to better reflect functionality. (Dmitry)
- Common helper to determine presence of a valid Adreno GPU node, avoiding repeated
  adreno_has_gpu() and availability checks.
- Update commit message to reflect the above behavior.
- Link to v2: https://lore.kernel.org/r/20260317-separate_gpu_kms-v2-1-b027ca97b9fe@oss.qualcomm.com

Changes in v2:
- Drop dependency on Lemans dual-DPU device tree changes as this patch
  works independently (Dmitry)
- Switch separate_gpu_kms to tristate and default to auto mode (Rob)
- Rename msm_gpu_no_components() to msm_separate_gpu_kms_components() for clarity
- Link to v1: https://lore.kernel.org/r/20260223-seperate_gpu_kms-v1-1-e8231e7f1685@oss.qualcomm.com
---
 drivers/gpu/drm/msm/adreno/adreno_device.c |  6 ++-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c   | 14 +++++++
 drivers/gpu/drm/msm/msm_drv.c              | 65 ++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_drv.h              |  6 ++-
 drivers/gpu/drm/msm/msm_mdss.c             | 15 +++++++
 5 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 05c77fe27e62..7108d4aa59b5 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -271,8 +271,10 @@ static const struct component_ops a3xx_ops = {
 
 static int adreno_probe(struct platform_device *pdev)
 {
-	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
-	    msm_gpu_no_components())
+	struct device_node *node = pdev->dev.of_node;
+
+	if (of_device_is_compatible(node, "amd,imageon") ||
+	    (msm_separate_gpu_kms_components() && adreno_has_gpu(node)))
 		return msm_gpu_probe(pdev, &a3xx_ops);
 
 	return component_add(&pdev->dev, &a3xx_ops);
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 9b1d1982e683..c299fef1a400 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -15,6 +15,20 @@
 #include "msm_mmu.h"
 #include "mdp4_kms.h"
 
+static const struct of_device_id mdp4_dt_match[];
+int msm_count_mdp4(void)
+{
+	struct device_node *np;
+	int count = 0;
+
+	for_each_matching_node(np, mdp4_dt_match) {
+		if (of_device_is_available(np))
+			count++;
+	}
+
+	return count;
+}
+
 static int mdp4_hw_init(struct msm_kms *kms)
 {
 	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index f3d2eaa04f14..2ac7fcd468d3 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -54,16 +54,65 @@ static bool modeset = true;
 MODULE_PARM_DESC(modeset, "Use kernel modesetting [KMS] (1=on (default), 0=disable)");
 module_param(modeset, bool, 0600);
 
-static bool separate_gpu_kms;
-MODULE_PARM_DESC(separate_gpu_kms, "Use separate DRM device for the GPU (0=single DRM device for both GPU and display (default), 1=two DRM devices)");
-module_param(separate_gpu_kms, bool, 0400);
+/*
+ * separate_gpu_kms (tristate):
+ *   -1 (default): decide automatically based on hardware topology. Split devices
+ *                 if there is more than one GPU or more than one display master.
+ *    0: force single DRM device (bind display + GPU)
+ *    1: force separate DRM devices
+ */
+static int separate_gpu_kms = -1;
+MODULE_PARM_DESC(separate_gpu_kms,
+		 "Use separate DRM device for the GPU (-1=auto (default), 0=single DRM device, 1=separate DRM devices)");
+module_param(separate_gpu_kms, int, 0400);
 
 DECLARE_FAULT_ATTR(fail_gem_alloc);
 DECLARE_FAULT_ATTR(fail_gem_iova);
 
-bool msm_gpu_no_components(void)
+static const struct of_device_id msm_gpu_match[];
+static inline bool msm_gpu_node_present(struct device_node *np)
+{
+	return np && of_device_is_available(np) && adreno_has_gpu(np);
+}
+
+static int msm_count_gpus(void)
 {
-	return separate_gpu_kms;
+	struct device_node *np;
+	int count = 0;
+
+	for_each_matching_node(np, msm_gpu_match) {
+		if (msm_gpu_node_present(np))
+			count++;
+	}
+
+	return count;
+}
+
+static bool msm_separate_gpu_kms_auto(void)
+{
+	int gpus = msm_count_gpus();
+	int display_subsystems = msm_count_mdss() + msm_count_mdp4();
+
+	if (gpus <= 0 || display_subsystems <= 0)
+		return false;
+
+	/* Single card if there is exactly one GPU and one display subsystem */
+	return gpus > 1 || display_subsystems > 1;
+}
+
+bool msm_separate_gpu_kms_components(void)
+{
+	if (msm_count_gpus() == 0)
+		return true;
+
+	switch (separate_gpu_kms) {
+	case 0:
+		return false;
+	case 1:
+		return true;
+	default:
+		return msm_separate_gpu_kms_auto();
+	}
 }
 
 static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_ops)
@@ -1029,7 +1078,7 @@ static int add_gpu_components(struct device *dev,
 	if (!np)
 		return 0;
 
-	if (of_device_is_available(np) && adreno_has_gpu(np))
+	if (msm_gpu_node_present(np))
 		drm_of_component_match_add(dev, matchptr, component_compare_of, np);
 
 	of_node_put(np);
@@ -1040,7 +1089,7 @@ static int add_gpu_components(struct device *dev,
 static int msm_drm_bind(struct device *dev)
 {
 	return msm_drm_init(dev,
-			    msm_gpu_no_components() ?
+			    msm_separate_gpu_kms_components() ?
 				    &msm_kms_driver :
 				    &msm_driver,
 			    NULL);
@@ -1079,7 +1128,7 @@ int msm_drv_probe(struct device *master_dev,
 			return ret;
 	}
 
-	if (!msm_gpu_no_components()) {
+	if (!msm_separate_gpu_kms_components()) {
 		ret = add_gpu_components(master_dev, &match);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index eb4bbae8557b..2840e8a5052d 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -394,9 +394,11 @@ static inline bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
 #ifdef CONFIG_DRM_MSM_MDP4
 void msm_mdp4_register(void);
 void msm_mdp4_unregister(void);
+int msm_count_mdp4(void);
 #else
 static inline void msm_mdp4_register(void) {}
 static inline void msm_mdp4_unregister(void) {}
+static inline int msm_count_mdp4(void) { return 0; }
 #endif
 
 #ifdef CONFIG_DRM_MSM_MDP5
@@ -418,9 +420,11 @@ static inline void msm_dpu_unregister(void) {}
 #ifdef CONFIG_DRM_MSM_MDSS
 void msm_mdss_register(void);
 void msm_mdss_unregister(void);
+int msm_count_mdss(void);
 #else
 static inline void msm_mdss_register(void) {}
 static inline void msm_mdss_unregister(void) {}
+static inline int msm_count_mdss(void) { return 0; }
 #endif
 
 #ifdef CONFIG_DEBUG_FS
@@ -534,6 +538,6 @@ void msm_kms_shutdown(struct platform_device *pdev);
 
 bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
 
-bool msm_gpu_no_components(void);
+bool msm_separate_gpu_kms_components(void);
 
 #endif /* __MSM_DRV_H__ */
diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9087c4b290db..e69b122f2687 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -73,6 +73,21 @@ static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
 	return 0;
 }
 
+static const struct of_device_id mdss_dt_match[];
+
+int msm_count_mdss(void)
+{
+	struct device_node *np;
+	int count = 0;
+
+	for_each_matching_node(np, mdss_dt_match) {
+		if (of_device_is_available(np))
+			count++;
+	}
+
+	return count;
+}
+
 static void msm_mdss_irq(struct irq_desc *desc)
 {
 	struct msm_mdss *msm_mdss = irq_desc_get_handler_data(desc);

---
base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
change-id: 20260316-separate_gpu_kms-04d2cf4d91e2

Best regards,
-- 
Mahadevan P <mahadevan.p@oss.qualcomm.com>

