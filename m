Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AD1CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 20:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BF310EC20;
	Tue, 12 May 2026 20:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h5YCUUsX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Al5w0fG/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F9A10EC20
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:45 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CFLGaa3421756
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G6yKKeAvSPsOjH6ZKXP00uW2gSK4QxJpofe//NFhx3w=; b=h5YCUUsXcGSYdonL
 CD8Vwi4L3+Urc7gLMRkzKWRsNyhVMPbSHEmfZF5k7fgv5+KU+nabrfe+P62d0qql
 kT3e4Wiydlw7fstVXuqvcjoTCrWLxxTmXqxzoKSH/b+81huHkb9DRmXNG8ad1akK
 /NFa8lZBFgPkQvlcCCcT7uS04/dx0cuFUb6+CcWBiYQXiMeG9TbG/GSZ4w3xS20J
 5/qHteSwOWdS/feMnZqHVRbltV3pGr+7+szmDaliyWiVbmyj/UURYOJXpkyMSW+S
 cgvopjO7+dnaRNnYNOupS36UwJEAUx4uuaTa5lPcrkUzb01yV9REtY0+mIZnPj9V
 SCgCvg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e46s9s8he-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8397b14a689so3778971b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778619223; x=1779224023;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G6yKKeAvSPsOjH6ZKXP00uW2gSK4QxJpofe//NFhx3w=;
 b=Al5w0fG/RiUHGyIvWcB4QKxpVqvuBqSPc62wUUm91r9M3OtI8jGbQLL/QpTmDrxIq8
 qln7yUuzjB5q1vzHMxq4pNOwzpLxH+8pC9/XgJJf3Ltd0gGt6DpoU/FObsxyH/w0U9gH
 EHk48V/IsGzLZvUaqSw/pJfzh8qNDorqoIRkOou+LkrTPYyapThcIX2olTuFT6NFAnVH
 8rdWMufSx7njiE9qrqKHnQEevnDo3rGk8cnAr8IggPj/PWZtZcnlLbiiKNbrKFnlWj5M
 AaLAfx7mwKy4pV1YpQkJmov2pOEK3ZbS4+D8N5UC/DUMRiTmjuNr4ZXvQs9uvIOU38/w
 Ow+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778619223; x=1779224023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G6yKKeAvSPsOjH6ZKXP00uW2gSK4QxJpofe//NFhx3w=;
 b=lOK/XP8q4JpKJguHG3gZ7OQ5Mazn8QyklQCT3rt4wwZNdTWyzn8rhs/sVkQ1OY78Jh
 S+586mw/7lYWMGN/5Ia4mBvPELa7/vmgkt+Pc40E8ebV/lHzt2hiRNcoEjRTyFrbeJ0z
 Abby9PzT9zJzM6Du65gQ1cKszgxDk6/KsXclO09YLmug3UPOfDvrfRKUMqhINegbsPHe
 5uOn8WLApvZYp0E0W8pk4SHdORCWUFDAmuKN6PLgOIf5onWp1589mG2u6FcFt7f8U+J9
 wSfszZEi2Aou4G9V3Bj+XtXizcTwkCCkueTRjptsKrxS6XnLyAQuDvNCBhuK3ryBsucD
 MQrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oRQ+Q8ybvdG+4AG6f7twi1cNfhZDiyfrfEz3NmeoQDcfYCWUkUXpsONmTOeMpF+ceLo12sljuNbs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQLOvfLE68Q9i6I3lTITNjghkfsVZ8wfHQgusg8d6D1S7Oj//O
 fn1vpAjcoO8CyppG50GoNedh3dxxJuvlU8WKilj/Xjhrvsc9aXoXYZEKN25DEy1gfFzbi2OgG68
 iJQ+7iu3SeTkU9BztZ2psMvhBSqgv7d3dlUctrKfhlcGAZ1tw6vBU5UIc1yWSHh0CcnJVsJY=
X-Gm-Gg: Acq92OEUOj69EBgRtAWzPge8B/IGq/vqO2DREwi1GsjfQlQbKZ9jTV4sTYLePlkIzn/
 NWdgkPJnYjNngc5A4riGC4VgZoKoeEtWrWjOS05upCBl0FaU+3BenZ9YQjVYu5stRS0DjuwR6lP
 gnWI2p3samUE/KkSPBY7NTRFv/SULQefwF9J6VKHYkZvkecaoEJ4dwaseJcYZ5L/Ot4ob5Ud+Hj
 14YD0JPJkUjSeeogHHSOiMl0GwUV1v2tRCrcntqqT+y/YsvoMUgzKEeXbb48arFwO5lOEsqMFzd
 h38NGyHBdeY12jVwEaEUg4cWxxc6Yhq6Ki1T41fNUqQiSNY9wZSaCjZ1bFHc4+B3NC7BlQ13tMF
 tNYGe2swK2toUK6IxiTxFcyaUyHVkjC3aYz00tmJdKu3ccg==
X-Received: by 2002:a05:6a00:8d1:b0:837:80a:5ac7 with SMTP id
 d2e1a72fcca58-83f042f0494mr260159b3a.45.1778619222965; 
 Tue, 12 May 2026 13:53:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d1:b0:837:80a:5ac7 with SMTP id
 d2e1a72fcca58-83f042f0494mr260117b3a.45.1778619222412; 
 Tue, 12 May 2026 13:53:42 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945c1bsm25453004b3a.15.2026.05.12.13.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:53:42 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 02:23:00 +0530
Subject: [PATCH RFT 5/5] drm/msm: Attach a driver to the GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-gmu-sync-state-fix-v1-5-6e33e6aa9b4f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778619193; l=10944;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=l7tswl8DO13o/CE8M9GoikhvHiFXnclNlk8V4N1cPCU=;
 b=ueV3F8Rn9m+DhL3z4Lges2jXXUB6/tF1GCwwBpwuzqOJ0oZAfDm9HcKPqZ5t8VgMk1rgrqSU+
 ixcbtWEj7ekCa/tfCzhtn7Xvz5fpb8lM9XyY221tXUT/VFx2Rkkng9L
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIxNCBTYWx0ZWRfX5JI3C94Xq8zb
 c1fXVckBXBBul/onAHEMmYZSBcn//cS6feLXuD7yeuxUgW3nNmL4QvChueZknhUtcHRzA4Ip1+Q
 Q2z06IgqrDjYM/phnwqM3zqKwamz5J1IQYJRknYYBjDZHJHiMsCWQzH7/Jmkv3IWkwOEl4BPfe5
 H66V7HDL2pkRpSar2wliSBVbh4sqgjP2pslOxYtunaE7Xkf5bsVsUkWr41DS6EEfEqixVGIn/Ex
 78pat/3kQ1TWDD3QjDn7bNStMvrGfkqSIk9sQVunEhIAkYTsS7buPRQ1g59mg034Ld5ntEYZX6/
 1lIk5HMRRdTH1HUPaA7sx1Mij13LtQQx/eks9Ws3r4+qzOWYQEKZmYgkh9UM1jkneXplMa0TV+t
 aNO8Jdhq7YKINOIsSjnlyXXQCwfUYbxrfKK6Ej7DOSFvjqnVaEctzhD9T/x9wjh04jXvkQQfshR
 y0xjLh02D7YQCmmOxSQ==
X-Proofpoint-GUID: 1G_bqFKR7cu6V1xZeTnAE7JeFw8bvTxG
X-Authority-Analysis: v=2.4 cv=L68theT8 c=1 sm=1 tr=0 ts=6a039358 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=TzZsgx1IjV9xhXMPmAMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 1G_bqFKR7cu6V1xZeTnAE7JeFw8bvTxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
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

With the introduction of sync_state in the genpd framework, any consumer
device of GCC and GPUCC which is not bound to a driver will result in
bootup warnings like below:

[   24.362666] gcc-kaanapali 100000.clock-controller: sync_state() pending due to 3d37000.gmu
[   24.371210] gxclkctl-kaanapali 3d64000.clock-controller: sync_state() pending due to 3d37000.gmu
[   24.380268] gpucc-kaanapali 3d90000.clock-controller: sync_state() pending due to 3d37000.gmu

To silence these warnings and also to have a proper state in driver core,
attach a driver to the GMU and set it up as a component device for the drm
master device.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 70 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 30 +++++--------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |  3 --
 drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  3 +-
 drivers/gpu/drm/msm/msm_drv.c              | 17 ++++----
 6 files changed, 92 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index ec13b27feee7..71bb621b01f3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2063,7 +2063,7 @@ void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu)
 	pm_runtime_put(&gpu->pdev->dev);
 }
 
-void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
+static void a6xx_gmu_destroy(struct a6xx_gpu *a6xx_gpu)
 {
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
@@ -2143,7 +2143,7 @@ static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev, resource_si
 	return ret;
 }
 
-int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
+static int a6xx_gmu_wrapper_pdev_bind(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 {
 	struct platform_device *pdev = of_find_device_by_node(node);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
@@ -2213,6 +2213,8 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto err_mmio;
 	}
 
+	mutex_init(&gmu->lock);
+
 	gmu->initialized = true;
 
 	return 0;
@@ -2230,7 +2232,7 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	return ret;
 }
 
-int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
+static int a6xx_gmu_pdev_bind(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 {
 	struct platform_device *pdev = of_find_device_by_node(node);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
@@ -2415,6 +2417,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	/* Initialize RPMh */
 	a6xx_gmu_rpmh_init(gmu);
 
+	mutex_init(&gmu->lock);
 	gmu->initialized = true;
 
 	return 0;
@@ -2444,3 +2447,64 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	return ret;
 }
+
+static int a6xx_gmu_bind(struct device *dev, struct device *master, void *data)
+{
+	int (*bind)(struct a6xx_gpu *gpu, struct device_node *node) = of_device_get_match_data(dev);
+	struct a6xx_gpu *a6xx_gpu = dev_get_drvdata(dev);
+
+	if (WARN_ON(!a6xx_gpu))
+		return -ENODEV;
+
+	return bind(a6xx_gpu, dev->of_node);
+}
+
+static void a6xx_gmu_unbind(struct device *dev, struct device *master, void *data)
+{
+	struct a6xx_gpu *a6xx_gpu = dev_get_drvdata(dev);
+
+	a6xx_gmu_destroy(a6xx_gpu);
+	dev_set_drvdata(dev, NULL);
+}
+
+static const struct component_ops a6xx_gmu_bind_ops = {
+	.bind   = a6xx_gmu_bind,
+	.unbind = a6xx_gmu_unbind,
+};
+
+static int a6xx_gmu_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &a6xx_gmu_bind_ops);
+}
+
+static void a6xx_gmu_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &a6xx_gmu_bind_ops);
+}
+
+static const struct of_device_id a6xx_gmu_dt_match[] = {
+	{ .compatible = "qcom,adreno-gmu", .data = a6xx_gmu_pdev_bind },
+	{ .compatible = "qcom,adreno-rgmu", .data = a6xx_gmu_wrapper_pdev_bind },
+	{ .compatible = "qcom,adreno-gmu-wrapper", .data = a6xx_gmu_wrapper_pdev_bind },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, a6xx_gmu_dt_match);
+
+static struct platform_driver adreno_gmu_driver = {
+	.probe = a6xx_gmu_probe,
+	.remove = a6xx_gmu_remove,
+	.driver = {
+		.name = "adreno_gmu",
+		.of_match_table = a6xx_gmu_dt_match,
+	},
+};
+
+void __init adreno_gmu_register(void)
+{
+	platform_driver_register(&adreno_gmu_driver);
+}
+
+void __exit adreno_gmu_unregister(void)
+{
+	platform_driver_unregister(&adreno_gmu_driver);
+}
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index d5aba072f44c..b4ae38e1a3d8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/devfreq.h>
+#include <linux/of_platform.h>
 #include <linux/pm_domain.h>
 #include <linux/soc/qcom/llcc-qcom.h>
 
@@ -2409,8 +2410,6 @@ static void a6xx_destroy(struct msm_gpu *gpu)
 
 	a6xx_llc_slices_destroy(a6xx_gpu);
 
-	a6xx_gmu_remove(a6xx_gpu);
-
 	adreno_gpu_cleanup(adreno_gpu);
 
 	kfree(a6xx_gpu);
@@ -2622,6 +2621,7 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	struct adreno_platform_config *config = pdev->dev.platform_data;
 	const struct adreno_info *info = config->info;
 	struct device_node *node;
+	struct platform_device *gmu_pdev;
 	struct a6xx_gpu *a6xx_gpu;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
@@ -2637,17 +2637,14 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu = &a6xx_gpu->base;
 	gpu = &adreno_gpu->base;
 
-	mutex_init(&a6xx_gpu->gmu.lock);
 	spin_lock_init(&a6xx_gpu->aperture_lock);
 
 	adreno_gpu->registers = NULL;
 
-	/* Check if there is a GMU phandle and set it up */
 	node = of_parse_phandle(pdev->dev.of_node, "qcom,gmu", 0);
-	/* FIXME: How do we gracefully handle this? */
-	BUG_ON(!node);
-
-	adreno_gpu->gmu_is_wrapper = of_device_is_compatible(node, "qcom,adreno-gmu-wrapper");
+	WARN_ON(!node);
+	adreno_gpu->gmu_is_wrapper = of_device_is_compatible(node,
+							     "qcom,adreno-gmu-wrapper");
 
 	adreno_gpu->base.hw_apriv =
 		!!(info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
@@ -2686,16 +2683,6 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	if (adreno_is_a618(adreno_gpu) || adreno_is_7c3(adreno_gpu))
 		priv->gpu_clamp_to_idle = true;
 
-	if (adreno_has_gmu_wrapper(adreno_gpu) || adreno_has_rgmu(adreno_gpu))
-		ret = a6xx_gmu_wrapper_init(a6xx_gpu, node);
-	else
-		ret = a6xx_gmu_init(a6xx_gpu, node);
-	of_node_put(node);
-	if (ret) {
-		a6xx_destroy(&(a6xx_gpu->base.base));
-		return ERR_PTR(ret);
-	}
-
 	adreno_gpu->uche_trap_base = 0x1fffffffff000ull;
 
 	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
@@ -2710,6 +2697,13 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	/* Set up the preemption specific bits and pieces for each ringbuffer */
 	a6xx_preempt_init(gpu);
 
+	gmu_pdev = of_find_device_by_node(node);
+	of_node_put(node);
+	if (gmu_pdev) {
+		platform_set_drvdata(gmu_pdev, a6xx_gpu);
+		put_device(&gmu_pdev->dev);
+	}
+
 	return gpu;
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index eb431e5e00b1..fe8d68df9944 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -268,9 +268,6 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu);
 int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 
-int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
-int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
-void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
 void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu);
 
 void a6xx_preempt_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 67686424f3a1..d70f98e283d5 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -423,6 +423,7 @@ void __init adreno_register(void)
 		return;
 
 	platform_driver_register(&adreno_driver);
+	adreno_gmu_register();
 }
 
 void __exit adreno_unregister(void)
@@ -430,5 +431,6 @@ void __exit adreno_unregister(void)
 	if (skip_gpu)
 		return;
 
+	adreno_gmu_unregister();
 	platform_driver_unregister(&adreno_driver);
 }
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index ec643b84646b..3a05cd98d215 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -642,7 +642,8 @@ int adreno_gpu_state_get(struct msm_gpu *gpu, struct msm_gpu_state *state);
 int adreno_gpu_state_put(struct msm_gpu_state *state);
 void adreno_show_object(struct drm_printer *p, void **ptr, int len,
 		bool *encoded);
-
+void adreno_gmu_register(void);
+void adreno_gmu_unregister(void);
 /*
  * Common helper function to initialize the default address space for arm-smmu
  * attached targets
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index af5aa7ff6179..426255fd0801 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1021,7 +1021,7 @@ static const struct of_device_id msm_gpu_match[] = {
 static int add_gpu_components(struct device *dev,
 			      struct component_match **matchptr)
 {
-	struct device_node *np;
+	struct device_node *np, *gmu_np;
 
 	np = of_find_matching_node(NULL, msm_gpu_match);
 	if (!np)
@@ -1030,6 +1030,11 @@ static int add_gpu_components(struct device *dev,
 	if (of_device_is_available(np) && adreno_has_gpu(np))
 		drm_of_component_match_add(dev, matchptr, component_compare_of, np);
 
+	gmu_np = of_parse_phandle(np, "qcom,gmu", 0);
+	if (of_device_is_available(gmu_np))
+		drm_of_component_match_add(dev, matchptr, component_compare_of, gmu_np);
+
+	of_node_put(gmu_np);
 	of_node_put(np);
 
 	return 0;
@@ -1131,13 +1136,9 @@ int msm_gpu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * The GPU pdev acts as both the component master and the sole
-	 * component (added by adreno_probe()). Future patches add the
-	 * GMU node as a second component on this same master.
-	 */
-	drm_of_component_match_add(&pdev->dev, &match,
-				   component_compare_of, pdev->dev.of_node);
+	ret = add_gpu_components(&pdev->dev, &match);
+	if (ret)
+		return ret;
 
 	return component_master_add_with_match(&pdev->dev, &msm_gpu_drm_ops,
 					       match);

-- 
2.51.0

