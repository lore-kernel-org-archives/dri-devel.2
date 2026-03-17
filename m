Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E273EFD7072
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A4710E4E6;
	Tue, 17 Mar 2026 10:27:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z5GpOGej";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MkIXwois";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F8510E584
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:27:53 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H9H1SR4022233
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=oMe9m9KfSB/KXji7mjTpys
 JkU6Pplkay44063+xqQ5s=; b=Z5GpOGejCL6ldjVxCEX0JIxga7tLISIpWEVlNj
 LnAstR20Kz1WEa+XLbBWC4V7Z+of0gMK0RDqQUEDG8eZcDe65xQH+gVQOU+JD+D2
 nSH35sI9EkSpHn2iRJ6nl/6shk1N0OlzGwo391yt4SUa9U3wR0KxqSWurorzQbvO
 B6DC1glYQ7WXyHMjZZJOq7saYsrdvD7xrpA7zonp4t74LRf/zPOtHtsFss1XSXl5
 HAV4Yi/+VYReV5cjZEi1M5SV/lNXntBAmkp7qKmVwUts6DXWSxmT0GC3VS/TMIu+
 9IVhIUaA2vU9ldsbqUCB8/DTyuG7YmHqsmh79gvnO2MrexUg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxn3fkacr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:27:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35b901d542bso20709783a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773743271; x=1774348071;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oMe9m9KfSB/KXji7mjTpysJkU6Pplkay44063+xqQ5s=;
 b=MkIXwoisARjNKD1uZc/mNgekf0RTD4EzTLYet1gwKedAhoZbt2mNAhN/pYUhC/vxwj
 k/FK2atyiaczP9kykU1hq0Y5QX+k21fhdDBlndsBP1Hn2ZFtbNsbPJG6CZNeFd+dpxEe
 Dw5hDxHSWDsa75vTVWJZG+NKdKz9oTiZMQX1HkQMeOw9tibJWfZxg6nyAsm3xsoHF6a5
 3sxK2DgaVRzMOoGjfORu+ke5Qr1mo7eADeYokvD7UFZHna0NMPGkFYFb4q6mNGjW2oml
 rtPR4MKpS5isrEzhco0yIkQUGhPkrV2YDf/XkEGAV8IcS4z2/KGfRCjrx/VvPROxHH+j
 d9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773743271; x=1774348071;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMe9m9KfSB/KXji7mjTpysJkU6Pplkay44063+xqQ5s=;
 b=F9H9soOhk1MAMPfU3QLbH+7vprseRbUURSsOQ7LvR8+6GxJf9u4bDf+KWYxtQzy7BN
 4whedZs2coRt0dff0p7ekeswwL1Feb2Z3DP5pUoQ+5ni5yJZBQD17v5KGVX948wwc+UK
 U2DEH+j9RFxyk6hF0vCr3qfHwDLXjFYjOjcBKh3Qx2zhLeOHIGKeod7T9m6xBN0wcSWo
 FBiyV6VuWGpzCIgBdiJxBDICqp8/1JA6pvHEXijkva8cL7IgUU6rZ19l6KoyE96DIYDs
 JNMCvrNaIOwjwYnAr7jY9D3xaPMExM4fwlfXhYYE3OA6Ds04hzuUe2HjOud29Zp98d3J
 qIfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT6VB+V9b4+jZqgnr4hhP0GPD/xkpop23i6vYE9q4i/CBjuPVvOopPlArHocrFDDvtLQlzZNGgpiE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZLTUR6eoqOPaLRtxampgv4FlHSMWZucXAn2lv+Eoe1h58Gprh
 dXGZT2y56xV9quzbwexExNqZfdQmJDS3tXZxXTMldgOMziO0gP4x/CKtjpSbkvkNUJcu/wThqLp
 AP9DetkIaRBigyjsVhV4msTmKcHG97UmcRRbhaCZwkV1LNolqfQ78i0FRBcv4n+t9p149kBQ=
X-Gm-Gg: ATEYQzxN1k5qyOcG7X/knpQgLiXmQbDFlKzb73z5jFki90B3gxTX3ivWtInE3/C7TPc
 sDcq/JuUzobn/aX+RmKBb1JiBZvIBCQu3b3zYJ6Nm2flosYgQdjx17DcTV5+6L+7L/Xd6wsrOrH
 k2Jbu3bUDZx/5IV76rEKbCMdLqxsPFpcV9HIR/c4p3iPznXrFzOqQhJ200JmGiEWHXIZio7CyGr
 JfhG2d0w8gImUxzJ+QJBfOlXe6G3guGxvNkmMW9do3My7spKqQeOIGccTF3ZKRfzJY05g1ZhkSs
 WtMpO8qwUssic5tHBVQUx3MnT3PPgHvov5iWpLLmDF0Ow01xiZxKh0B+aCIdyw1NmNiXxPBxjty
 sRVDIe5cF/+UHLl08rsmqabY7EMDaUky6MwhAuk7kPLqx+Zcx
X-Received: by 2002:a17:90b:2241:b0:35b:9894:f6d5 with SMTP id
 98e67ed59e1d1-35b9894fa75mr7396173a91.31.1773743271037; 
 Tue, 17 Mar 2026 03:27:51 -0700 (PDT)
X-Received: by 2002:a17:90b:2241:b0:35b:9894:f6d5 with SMTP id
 98e67ed59e1d1-35b9894fa75mr7396138a91.31.1773743270420; 
 Tue, 17 Mar 2026 03:27:50 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35badbcdad9sm3178589a91.16.2026.03.17.03.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:27:49 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 15:57:23 +0530
Subject: [PATCH v2] drm/msm: default separate_gpu_kms to auto selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-separate_gpu_kms-v2-1-b027ca97b9fe@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIosuWkC/1WNwQqDMBBEf0X23Ii7Wms99T+KSNBVQ6uxWZUW8
 d8b7amXgTcwb1YQdoYF8mAFx4sRYwcPdAqg6vTQsjK1Z6CI0ijGVAmP2umJy3acy0cvKkpqqpq
 kviIT+NnouDHvQ3kvPHdGJus+x8OCe/uTEcW7jP9kCypUnFGMfGkwzc43KxK+Zv2sbN+HPqDYt
 u0L9CKNbLcAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773743265; l=7486;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=Wv9Le7mBgyQvDEQxKS0VD06CuMcA8Yv2iRruSyYTEdc=;
 b=6rO7FArB9QUjw17Logyyusd9M+STidugTXbhzouqb/h/Mqj1Vk/DKVx1ImkNL8WFr3VFfukjA
 eL9P0lRYq41Ba8Go3JfgHmZYoNGuWGCFG+/RyUohxOHdDRGtj52Gm2F
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Authority-Analysis: v=2.4 cv=C5bkCAP+ c=1 sm=1 tr=0 ts=69b92ca8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5TsJt5EyTeYoDRTaIssA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: bttdzk1CL_XTPC6hBsEF_PJ61uvpMpWX
X-Proofpoint-ORIG-GUID: bttdzk1CL_XTPC6hBsEF_PJ61uvpMpWX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA5MiBTYWx0ZWRfXyPDV4U03F+B+
 j0mZCbf7WWs2XtSjeCGvp8IYSvUArhds8B4+GAc+vxRkEC657LvRatkp7mRLTS5CcQftajisw8j
 MSQDei4FtXur7WR93+DQwOk2TiSalrVqZzkFKB3iRzd+2F2EFGjGq/JEEqZ4ecnaVmJVWsgaRAz
 rSsuzTKIBWjMA8ClAvSZ5DLHQULcWUJbqM2BL8oJNfpTG+rYJOPCtIz13W14Kg3CSJ+HnyccPex
 xQr0zuFGhnJXuLF+BOBTLQYtSxv2KR9u6MFFir3Fjc2Yz85/hpKX2LJ6bT7oCGvVApETMK+UBvX
 5GqcYJAXUHRzh0GyZZ4VI88KGAPCAXQ7RvDohyprurDMP2N7gLRGnM++Maryf28oucRdX10vUUg
 NkAmqcaHTzSuGv4IrziLN9YGiOw6Lku2PWyeNI0Aa+d539mtIJxTbqQw3Cfv4rDicrGWYgOcKJ8
 jy1nPOxV4agX+opAs7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170092
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

This ensures correct probing on multi-display platforms without
affecting single-display, single-GPU systems.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260223-seperate_gpu_kms-v1-1-e8231e7f1685@oss.qualcomm.com
---
Depends on:
  https://lore.kernel.org/lkml/20260124-adreno-module-table-v1-1-9c2dbb2638b4@oss.qualcomm.com/

  When separate_gpu_kms is enabled, the GPU and display drivers are
  probed independently. In this configuration, the Adreno GPU driver
  may no longer be loaded implicitly via the display subsystem.

  The referenced patch adds a MODULE_DEVICE_TABLE() entry for the
  Adreno GPU device, ensuring proper module autoloading based on
  device tree matching. This is required to guarantee that the GPU
  driver is loaded correctly when GPU and display probing are
  decoupled.

Changes in v2:

    - Drop dependency on Lemans dual-DPU device tree changes as this patch
      works independently (Dmitry)
    - Switch separate_gpu_kms to tristate and default to auto mode (Rob)
    - Rename msm_gpu_no_components() to msm_separate_gpu_kms_components() for clarity
    - Link to v1: https://lore.kernel.org/r/20260223-seperate_gpu_kms-v1-1-e8231e7f1685@oss.qualcomm.com
---
 drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +-
 drivers/gpu/drm/msm/msm_drv.c              | 52 ++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_drv.h              |  4 ++-
 drivers/gpu/drm/msm/msm_mdss.c             | 15 +++++++++
 4 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 4edfe80c5be7..e40648c05797 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -272,7 +272,7 @@ static const struct component_ops a3xx_ops = {
 static int adreno_probe(struct platform_device *pdev)
 {
 	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
-	    msm_gpu_no_components())
+	    msm_separate_gpu_kms_components())
 		return msm_gpu_probe(pdev, &a3xx_ops);
 
 	return component_add(&pdev->dev, &a3xx_ops);
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index e5ab1e28851d..575d1aea7927 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -54,16 +54,54 @@ static bool modeset = true;
 MODULE_PARM_DESC(modeset, "Use kernel modesetting [KMS] (1=on (default), 0=disable)");
 module_param(modeset, bool, 0600);
 
-static bool separate_gpu_kms;
-MODULE_PARM_DESC(separate_gpu_drm, "Use separate DRM device for the GPU (0=single DRM device for both GPU and display (default), 1=two DRM devices)");
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
+static int msm_count_gpus(void)
+{
+	struct device_node *np;
+	int count = 0;
+
+	for_each_matching_node(np, msm_gpu_match) {
+		if (of_device_is_available(np) && adreno_has_gpu(np))
+			count++;
+	}
+
+	return count;
+}
+
+static bool msm_separate_gpu_kms_auto(void)
+{
+	int gpus = msm_count_gpus();
+	int mdss = msm_mdss_count_masters();
+
+	if (gpus <= 0 || mdss <= 0)
+		return false;
+
+	/* If exactly one GPU and one display subsystem single card */
+	return (gpus > 1) || (mdss > 1);
+}
+
+bool msm_separate_gpu_kms_components(void)
 {
-	return separate_gpu_kms;
+	if (separate_gpu_kms == 1)
+		return true;
+	if (separate_gpu_kms == 0)
+		return false;
+	return msm_separate_gpu_kms_auto();
 }
 
 static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_ops)
@@ -1030,7 +1068,7 @@ static int add_gpu_components(struct device *dev,
 static int msm_drm_bind(struct device *dev)
 {
 	return msm_drm_init(dev,
-			    msm_gpu_no_components() ?
+			    msm_separate_gpu_kms_components() ?
 				    &msm_kms_driver :
 				    &msm_driver,
 			    NULL);
@@ -1069,7 +1107,7 @@ int msm_drv_probe(struct device *master_dev,
 			return ret;
 	}
 
-	if (!msm_gpu_no_components()) {
+	if (!msm_separate_gpu_kms_components()) {
 		ret = add_gpu_components(master_dev, &match);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 6d847d593f1a..64a5ad35f7a2 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -555,6 +555,8 @@ void msm_kms_shutdown(struct platform_device *pdev);
 
 bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
 
-bool msm_gpu_no_components(void);
+bool msm_separate_gpu_kms_components(void);
+
+int msm_mdss_count_masters(void);
 
 #endif /* __MSM_DRV_H__ */
diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9047e8d9ee89..00e3ac7dab3a 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -73,6 +73,21 @@ static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
 	return 0;
 }
 
+static const struct of_device_id mdss_dt_match[];
+
+int msm_mdss_count_masters(void)
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
base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
change-id: 20260316-separate_gpu_kms-04d2cf4d91e2

Best regards,
-- 
Mahadevan P <mahadevan.p@oss.qualcomm.com>

