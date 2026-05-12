Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B143CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 20:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB28E10E590;
	Tue, 12 May 2026 20:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Piyn6MQj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VW8mkmIb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31BEE10E590
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:40 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CHYGKU591824
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 swPhCGipxaJd5Dc4rfX69t4v279JtEBqZKQ855juAH4=; b=Piyn6MQj4QBsCGwz
 4NIknQg/yIJB+GTC/kEzCFMxGFnDg7KsCrWvIvitwSiPn/jsh4/ktnJyu3P6RhsQ
 Z39R2mmSNC8LcjjE+ol0YpeQ6Hgo9KLx4EGk/ouR64/Z5tEO/Wd9LOWaNCqphTnU
 YflBSBLrIj0cFDmICZzG4tAYaGMMpeu0svp1hzYJRxlM7dYc7bO0BoxtGWmucMam
 Q8PfXeakOyM22jlQeAk9KvB1IXKQE0lQUwST6ZJk4DHd0111JRFpLN/mX+6QJdyl
 H22h5La6/9vWejgX2iqEgTGaebzPiciTrGpMUt55O4SeWAekdcFfoNgw55a/F5ZD
 FxNFUA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319tbvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-83536dc3be5so6418135b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778619218; x=1779224018;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=swPhCGipxaJd5Dc4rfX69t4v279JtEBqZKQ855juAH4=;
 b=VW8mkmIbsBhTijOs/R41ha3T6CyoluoteleBRgLrZQoYeo6Et0vnvz/mrUC3kaxM5S
 3jiRK9kcLzCNdfRGu0tQnC9hETYKLMhcLhxtIddQliLLDMPIBZLWJN+ioa3qB19okUW3
 u4prRtyUMYB8ogN3dsP2gFZHX79A0gHjK6jFeCciBtiU7DJ29eYalVX47RDU5Bme7jal
 UKjmC3eVEeLL8UD6W0oFosRZGvo5qAf0i0Ra/SPoctbKlmI26UFEFtBW8sPakwHA16hx
 oD1dfD5mMHmviZqntHelksv5EZPqXti+qI46B0oS41L3sRQnKKE429X5yxtrBqAPm6WX
 S1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778619218; x=1779224018;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=swPhCGipxaJd5Dc4rfX69t4v279JtEBqZKQ855juAH4=;
 b=OBrPn0StaMq1eTom0Zfpv3kXHn0qEQOkNMX3DS3SHXEgWF0LMcOjRMGpmF6S7v0N7A
 GVmTTsF0YWQGsanHrnmMAt7iPUHwk5qDb+T92myJCQYyLFpDyM0YqJ9Rxgf5i8mkM+iw
 IaJoRlEr2f7jVgYKIH5X7NXgislzIYwqZ/1zkMNtVKVny6ZTfFwx4HU3Fkw4NSdjP+NF
 Yl6XSLcsUX2GGuwgYmpGOg5w+Ug2CcfW7PrHoKcEkL6F+XZwmWhb968oOrldIlSdy/gX
 j35eyZCxUm6rDlWV4MZ/H89a0t/0t+/C4mKS8GNpGNzpxvQ+xuf7yTWQCQdHwxGsIoUG
 LJwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ87p2FqYlpmxIagjs3e9VOCWTw02Y+uUA7B92ciyEmYOL2PGiOakQ9Ac/4y0YLjvMCkAOdihcGN42o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6KndywSgzDeXgsm/p0UnbntDwvRtxY1ly9bxE7a/MlPMS13Cw
 7vC0Itjm2Vw1mvsExeiqm4l74HnAs9Zyjk9m0OE13x05LHF03v/9WTUiRjlZBGkGTEjk0/+NX2i
 J8DmXlONI/UDG9lStoZsC7OZcQHRbuU/tw95snZne3gTbgKos3gSffxm6pTNq07JTvLCfgXo=
X-Gm-Gg: Acq92OFBLW8kQLPtcjZOdIS0X6+6VVBvfs+bJqVDuwrBCELAgp8La1jsia62vaHGwhG
 LiR9+LT1tXmJh/1VcbritrFh6qnnuczM7bMBKcjRYhT1TuaQzJw7hlADTyLYpkpBQFm10LLMQWM
 0bINXPWQi+oAaxhEEd5hdnfCQKmHC3F5YliwvJiZVXOId/JV1vlkaJaA9tMtbl/pzCo/5KXkwoq
 yjPZekhyYGTxuwBCWFZQH7VNnd75PkkkourLnhuuL8IVRZsf6IZ/gSW7PU7LHAotIRMDiP1drWn
 uiRazZOTRf8G72USnayGaUzSBqyfwZoygqI2b3bS3HMj2wefNb3Yf1gqwaNU/qPwcnPlQ0rnnpP
 oS/gEoEN+AGsaK2lESloiIEeq/FsMuT4/zM8MxYC+G8wk5g==
X-Received: by 2002:a05:6a00:18aa:b0:832:e65:ddcd with SMTP id
 d2e1a72fcca58-83f042ddf57mr256259b3a.45.1778619218044; 
 Tue, 12 May 2026 13:53:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:18aa:b0:832:e65:ddcd with SMTP id
 d2e1a72fcca58-83f042ddf57mr256233b3a.45.1778619217531; 
 Tue, 12 May 2026 13:53:37 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945c1bsm25453004b3a.15.2026.05.12.13.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:53:37 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 02:22:59 +0530
Subject: [PATCH RFT 4/5] drm/msm: Always use component model for standalone GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-gmu-sync-state-fix-v1-4-6e33e6aa9b4f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778619193; l=4605;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=y12N0KJvr64smCvrggJzXSn04iLlv4CRGLxoGyZ3CWI=;
 b=pMv3uWBLuKrtsb+osbNDctX4oBE0ISGKmHp9tbKJzC6lx8D3z5z42w3xBQrTFswn//Jp5URXd
 zuFJtfX9zOsDQVk5SA+qRpFqpJNCpY0mXDeS7PNZ8V64J9FEq/Makgo
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIxNCBTYWx0ZWRfX2+HGQIuvXemw
 LyymPHTOJ00l7HSteoASRXIibhB6IXmqNofQ+ntDkIqcP5DJ0P9wtsSqwft5n7+EauFl83lW+4W
 Uwci7OK6AYUYD7Ru4+35NhimEod2GkFqeqYVoxkwYCrQmtVK5WHX7qnsiU7503UyguVpkpvbbBz
 7l0X5BkO6Lel6HVUjxDOPybm8SKLCYoI5brgTkn3UIm4tlwexDydosmJMEXUW10lXkl9+G7Q6uq
 W8TVOtDWdabOskgLJr4SB//JP4C+bYlyTamRhbRY+UCoyBNcNKn55ZioQa/HjJxdqDcTfi0jvNk
 G+cMYE1N2lp/zB9Ks4o+pZq6OHZ99prLO3BoOxQvoz+77tICnuilZHlAfN1GyFB9oiBv9v3lBrL
 CpOzObnG26+io1pZGb9O7oc6SU9MvrvVdCFIo2qXQ9l39mAv4PxX6ajrvACdGajStZg8fzme3SU
 oIdOXQl083V9YcA4HJA==
X-Proofpoint-GUID: 4mNEoTb0LMdTpIWgQSisWgIyrnZM-Bzv
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a039353 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_hlE4qLb6NvLkdTQTB4A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 4mNEoTb0LMdTpIWgQSisWgIyrnZM-Bzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
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

When separate_gpu_kms=1 (or the device is compatible with "amd,imageon"),
msm_gpu_no_components() evaluates true and adreno_probe() bypasses the
component framework by calling msm_gpu_probe() directly. In this case,
we skip creating components and directly bind the GPU.

That shortcut makes it impossible to add a second sibling on the GPU
master without introducing ad-hoc plumbing. To prepare for adding the
GMU as a peer component on this master, turn the GPU pdev into both a
component master and the sole component of itself in this path. A follow
up patch will introduce GMU as a component device.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 20 ++++++++++++-----
 drivers/gpu/drm/msm/msm_drv.c              | 35 +++++++++++++++++++++++++-----
 drivers/gpu/drm/msm/msm_drv.h              |  6 ++---
 3 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 66953e551d86..67686424f3a1 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -271,18 +271,26 @@ static const struct component_ops a3xx_ops = {
 
 static int adreno_probe(struct platform_device *pdev)
 {
-	if (msm_gpu_use_separate_drm_dev(pdev))
-		return msm_gpu_probe(pdev, &a3xx_ops);
+	int ret;
 
-	return component_add(&pdev->dev, &a3xx_ops);
+	if (msm_gpu_use_separate_drm_dev(pdev)) {
+		ret = msm_gpu_probe(pdev);
+		if (ret)
+			return ret;
+	}
+
+	ret = component_add(&pdev->dev, &a3xx_ops);
+	if (ret && msm_gpu_use_separate_drm_dev(pdev))
+		msm_gpu_remove(pdev);
+
+	return ret;
 }
 
 static void adreno_remove(struct platform_device *pdev)
 {
+	component_del(&pdev->dev, &a3xx_ops);
 	if (msm_gpu_use_separate_drm_dev(pdev))
-		msm_gpu_remove(pdev, &a3xx_ops);
-	else
-		component_del(&pdev->dev, &a3xx_ops);
+		msm_gpu_remove(pdev);
 }
 
 static void adreno_shutdown(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index b61deafd02c3..af5aa7ff6179 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1097,10 +1097,25 @@ int msm_drv_probe(struct device *master_dev,
 	return 0;
 }
 
-int msm_gpu_probe(struct platform_device *pdev,
-		  const struct component_ops *ops)
+static int msm_gpu_drm_bind(struct device *dev)
+{
+	return msm_drm_init(dev, &msm_gpu_driver, NULL);
+}
+
+static void msm_gpu_drm_unbind(struct device *dev)
+{
+	msm_drm_uninit(dev, NULL);
+}
+
+static const struct component_master_ops msm_gpu_drm_ops = {
+	.bind = msm_gpu_drm_bind,
+	.unbind = msm_gpu_drm_unbind,
+};
+
+int msm_gpu_probe(struct platform_device *pdev)
 {
 	struct msm_drm_private *priv;
+	struct component_match *match = NULL;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -1116,13 +1131,21 @@ int msm_gpu_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	return msm_drm_init(&pdev->dev, &msm_gpu_driver, ops);
+	/*
+	 * The GPU pdev acts as both the component master and the sole
+	 * component (added by adreno_probe()). Future patches add the
+	 * GMU node as a second component on this same master.
+	 */
+	drm_of_component_match_add(&pdev->dev, &match,
+				   component_compare_of, pdev->dev.of_node);
+
+	return component_master_add_with_match(&pdev->dev, &msm_gpu_drm_ops,
+					       match);
 }
 
-void msm_gpu_remove(struct platform_device *pdev,
-		    const struct component_ops *ops)
+void msm_gpu_remove(struct platform_device *pdev)
 {
-	msm_drm_uninit(&pdev->dev, ops);
+	component_master_del(&pdev->dev, &msm_gpu_drm_ops);
 }
 
 static int __init msm_drm_register(void)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 6fcb696ceb7c..6264ff27496f 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -544,10 +544,8 @@ extern const struct component_master_ops msm_drm_ops;
 int msm_kms_pm_prepare(struct device *dev);
 void msm_kms_pm_complete(struct device *dev);
 
-int msm_gpu_probe(struct platform_device *pdev,
-		  const struct component_ops *ops);
-void msm_gpu_remove(struct platform_device *pdev,
-		    const struct component_ops *ops);
+int msm_gpu_probe(struct platform_device *pdev);
+void msm_gpu_remove(struct platform_device *pdev);
 int msm_drv_probe(struct device *dev,
 	int (*kms_init)(struct drm_device *dev),
 	struct msm_kms *kms);

-- 
2.51.0

