Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EBAC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B774F10F186;
	Wed,  9 Sep 2026 13:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WhYl010z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ok1TWWSA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31DB410F17D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:48:46 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689BUQla2376525
 for <dri-devel@lists.freedesktop.org>; Wed, 9 Sep 2026 13:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=gXUaaYBTPyVGwfzrBTCeQK
 7umpGaf7wY4Ve1YT9tETI=; b=WhYl010zLDUy0GwA9JEVUM6G1AN4Ko7qd1yFZZ
 NO5xCT0fLJ6dhuId5yyCH1sFtL9wFN3Kds0p42L8RvVMXh2evhmen4y9Nhf4ABr0
 SLNM9aAn30BpzrilluBalLhV+oYgn0yiAWb6DvocJMeHhZKvX8Eaawwd2o0pZoeS
 LEcU4Wm/O6w3sbtblIPegqLs703FqlvSM6HouyFYgQ99hwW4R5/zSAXoQukK4NGG
 TLWxcU/f+gBdrNTwARQsE/U2Sudadzzk/F8qhnUKCgE9l495rxH0atAqZ8onhQuN
 XzBGZkX7ViepvLgHoGzwlDypEG8SSG7QVWBJXS7XxZnDxXFw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5ru0rg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 13:48:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-395543dc382so1540321a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788961724; x=1789566524;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gXUaaYBTPyVGwfzrBTCeQK7umpGaf7wY4Ve1YT9tETI=;
 b=Ok1TWWSA3KzTx52YycXFFE+WDih5k9+s0+aZMp0FiNOaN1xfcH5UgIcOlQfL0O6HGf
 9JIHUpIEE3qhPk36H4qVlHEWiY3XHIZWdGdo3wyNkIQw1uuO7KoHMTIywceYcwHYR8e6
 whT03vk/1a+xKfWeAN9iSgymzFGzXCfA/Z/jJNsL82EtCe86BNP+Sz540Jw3x6UID4YK
 XXCOOieO1FCuKU9aM0n+fV6lMC7Fr3AfCs11jgFa+FWpZXy2Ak1xOH3vLdWGaCypSfYj
 ngJEkUVpD3VvNfE9R/Vhbq6sLCRQ0/04POwAoYbqwSPrcXmYnoqKhYkT/nrlBRBmCwne
 XMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788961724; x=1789566524;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gXUaaYBTPyVGwfzrBTCeQK7umpGaf7wY4Ve1YT9tETI=;
 b=W2smUynHdB4exCH66qmxI2XW/IA0l0QvQINrL8JNhht6zdyRM/DMkhhMpFm1WiKBiy
 5xG+60Z/3IMWV4gVvKhDpaT8WTfN5Sqsrl4sBMBckWj1FcmFw7R3hYFyAZsDeybCAlOm
 R64+mculDoKlQAacNWD+REdq7pq+Q0rcJTbEyrRi2I58Piow0xYcPf+xjLdlqoiKwd9a
 agODWHkJerdRB/je3Av19XTOSXUsMDFWhD3e1ztFyNk07a2xy4Ju0GcXLnRXUw7xyPVj
 VitZHgMqqU/R5jJeuYbdjPiB7nNJmPgSUKss7zeJ0y4/qZHt9zqqnOpG/u3CpcsIJQhJ
 55YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByknzy8W8fvGPMuGS5CDDh6B6eakx8uYUaPQpwXhSlXBl7Wh2lLAF/i9qQJ5H55vW6o4g+r1MDhzjY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lf20hrCPcg5rwrfguE7q2B/T5RvQSR2xmvGYz0vvUqmh6efI7N
 GJP+51medjvt8M73h9a2zzLjBpxx0HymL7gi5uNzq7Ir0wLdY8K/d0sbDntdq4c/gQ1Xk38xyq7
 HbqcftL0mniJ9wq5AZCvZkmKRYxyDCfScHvQm0+eReeR4cmKOFEzCvqh4vrqEvazzv4p3MT0=
X-Gm-Gg: AYBFou1rYoc2LIMHpPvCPXPRDGIFmDG4ECxMC68ac606d7e1e1e8RCjXosgVUd+70yj
 D2OtO4Pip4XGjNcaq6qNwJ3AVAkUVI570OUQXc8c4DmTSO/hAvmxjRv/S2hskFTQ4R/8rpWGeE1
 fAAyePx8q98U0VSLt7oaVs5tDR6camGpjqAmXjWIW69Mw2ibWtZ1uAPbPGoNVus9cJrocDVkjLg
 WcPgjJbkvWFyXYnBXHWNQvmuEHpLzYRMgHGYKkm8kflp38l+oNSkvhE/M7n37fMZN3p1Is6Hr4r
 H4w126nqQtVk2c+G9FkMVEXvBERKuQtWFObz7Q5hIb0eZAyXJmfgb0GCEAw/rKKGx2ZyR7gdGWm
 1kkpEZKwRUeQBn0761GtoO93u7vU=
X-Received: by 2002:a17:90b:57e6:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-39d70a34abcmr1422035a91.7.1788961723691; 
 Wed, 09 Sep 2026 06:48:43 -0700 (PDT)
X-Received: by 2002:a17:90b:57e6:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-39d70a34abcmr1421985a91.7.1788961723186; 
 Wed, 09 Sep 2026 06:48:43 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39cd658a683sm1523906a91.2.2026.09.09.06.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:48:42 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 19:18:34 +0530
Subject: [PATCH RESEND v3] drm/msm: default separate_gpu_kms to auto selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-separate_gpu_kms-v3-1-eae64dfbb635@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788961718; l=10232;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=fNTiS/H2gUkjedeL15QTSU/7mML3BWEe0xtBdBQqtlg=;
 b=GL9+6L2h75hSqHqAsE723CzMb49IgZgUm+107fsBtTE+mordWxd8tOpt6HFUaPD/PHBU0iUSr
 GVqtVaLqr74A9HXtM9axJWYCfrUKn9MJADMrIUvE7thY84+ibtDdXFL
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Authority-Analysis: v=2.4 cv=M+997Sws c=1 sm=1 tr=0 ts=6aa163bc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7nrE9rN0imP4snLddHEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: JER50T6zHsjmqRcTwlZKc1nZll8z5yJ-
X-Proofpoint-ORIG-GUID: JER50T6zHsjmqRcTwlZKc1nZll8z5yJ-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1NCBTYWx0ZWRfX9ShVjC/A+X5Y
 pe9QPFi8LpaxXQjqR1gavB9d22e91SmA6j5tOOHnhffdZ9QeUbTHzH/j5eTE9x7swx35bHHamw1
 aG4UC5cOqz1ysWBnFrFglowL82qmXK0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1NCBTYWx0ZWRfX9Ic9feKuzDeS
 VnqNoTbmCwqKCodXHiaGoi1lNWpZmAsnQ+vT8p3lzG6CWN43eQhXWhAateVKjztec/v/U7DXh4p
 6sJLqd5vtauG7e1oDJH9/I6IIx/URIRGXzpVZugUxiP2wmFn0hPUV+kpBh6AfskIpmo/73V5V9n
 T2h7VAIGZZnKhalRMy+n8ki/rl3ghmHC2Rta+SuZSIhxvHiV4rsI7ce2p+8rHlV6o9EFoTizHRY
 3ppDpUZjfb5zeJK3lcVdp5CinYJqzFUlhFIMXcV0tAYfIKwuD2h8fW30nCAvH8CmC1589FWcODS
 /nL3EzSuhowE83zGSFXdp/Fbedle6mw7y94ozE3lp/1wdvQgE8jLGHjnTk+W3K3LX427c/ZLALU
 2cx6uZCOivQGXKS/ORmpRJcsGGOy5rV5670GxCY8FMvDY4186RbzgzRw++WgSHuCoShD0iHbFO3
 Syuty45rcRCxpEZoNTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090154
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
 drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c   | 14 +++++++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   | 14 +++++++
 drivers/gpu/drm/msm/msm_drv.c              | 64 ++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_drv.h              |  8 +++-
 drivers/gpu/drm/msm/msm_mdss.c             | 15 +++++++
 6 files changed, 107 insertions(+), 10 deletions(-)

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
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 809ca191e9de..409000b739b6 100644
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
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 1e3dc9bf9494..086895c9f103 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -19,6 +19,20 @@
 #include "msm_mmu.h"
 #include "mdp5_kms.h"
 
+static const struct of_device_id mdp5_dt_match[];
+int msm_count_mdp5(void)
+{
+	struct device_node *np;
+	int count = 0;
+
+	for_each_matching_node(np, mdp5_dt_match) {
+		if (of_device_is_available(np))
+			count++;
+	}
+
+	return count;
+}
+
 static int mdp5_hw_init(struct msm_kms *kms)
 {
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index e5ab1e28851d..e2101c6632ac 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -54,16 +54,64 @@ static bool modeset = true;
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
+static inline bool msm_gpu_node_present(struct device_node *np)
+{
+	return np && of_device_is_available(np) && adreno_has_gpu(np);
+}
+
+static int msm_count_gpus(void)
+{
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
+	int display_subsystems = msm_count_mdss() + msm_count_mdp4() + msm_count_mdp5();
+
+	if (gpus <= 0 || display_subsystems <= 0)
+		return false;
+
+	/* If exactly one GPU and one display subsystem single card */
+	return (gpus > 1) || (display_subsystems > 1);
+}
+
+bool msm_separate_gpu_kms_components(void)
 {
-	return separate_gpu_kms;
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, msm_gpu_match);
+	if (!msm_gpu_node_present(np))
+		return true;
+	if (separate_gpu_kms == 1)
+		return true;
+	if (separate_gpu_kms == 0)
+		return false;
+	return msm_separate_gpu_kms_auto();
 }
 
 static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_ops)
@@ -1019,7 +1067,7 @@ static int add_gpu_components(struct device *dev,
 	if (!np)
 		return 0;
 
-	if (of_device_is_available(np) && adreno_has_gpu(np))
+	if (msm_gpu_node_present(np))
 		drm_of_component_match_add(dev, matchptr, component_compare_of, np);
 
 	of_node_put(np);
@@ -1030,7 +1078,7 @@ static int add_gpu_components(struct device *dev,
 static int msm_drm_bind(struct device *dev)
 {
 	return msm_drm_init(dev,
-			    msm_gpu_no_components() ?
+			    msm_separate_gpu_kms_components() ?
 				    &msm_kms_driver :
 				    &msm_driver,
 			    NULL);
@@ -1069,7 +1117,7 @@ int msm_drv_probe(struct device *master_dev,
 			return ret;
 	}
 
-	if (!msm_gpu_no_components()) {
+	if (!msm_separate_gpu_kms_components()) {
 		ret = add_gpu_components(master_dev, &match);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 6d847d593f1a..a977fe7b36b8 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -555,6 +555,12 @@ void msm_kms_shutdown(struct platform_device *pdev);
 
 bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
 
-bool msm_gpu_no_components(void);
+bool msm_separate_gpu_kms_components(void);
+
+int msm_count_mdss(void);
+
+int msm_count_mdp4(void);
+
+int msm_count_mdp5(void);
 
 #endif /* __MSM_DRV_H__ */
diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9047e8d9ee89..4c788f2647b0 100644
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
base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
change-id: 20260316-separate_gpu_kms-04d2cf4d91e2

Best regards,
-- 
Mahadevan P <mahadevan.p@oss.qualcomm.com>

