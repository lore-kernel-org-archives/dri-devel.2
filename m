Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17320CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CBF810EC00;
	Sat,  3 Oct 2026 00:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TePXfy04";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FUMvKfDZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDF210F9BE
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:27:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Neshd3187117
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gyqt5AdRUlY/YQ93y0b7WfmjMyO1z9nII1C2dDiQyp8=; b=TePXfy04IN2rXJ78
 jwPq8z8aU3zLkuLCYwDx/0bf/QVwkE6MZBweJFrAOvZF6Ry7G/zTF0qJ+RIFR1Ff
 zLancNdSjspo76HNJb3jqd+keaAi93mLfRETDUMlghFI2nUbsoIpE7vgvNi/7+D7
 CJhy1LB8EfQWL4ZXsaKYDG6unCt8kViXvrKWXeSkgsi97kxAETmq/6RINEbVXiek
 yYT1AY1L+59256g/kzRummgsSyStAAjXSIaJgSugimF6ptzaF6AYeF6SL2KaPdR/
 VNQdV765aRb/e8rEGbWJEjHaH2RqAVi+PX75nOofAe1gQ5cfjbOzvenW0wmJSeUp
 /04C9w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh4ur9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:27:33 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91789a9107fso7642256d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987253; x=1791592053;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gyqt5AdRUlY/YQ93y0b7WfmjMyO1z9nII1C2dDiQyp8=;
 b=FUMvKfDZu0KmXiIds1xBCexcf0jMQEGrwVyJrK4RO/i6LSdpsQhtjT50SmjuPWSErW
 dWAzpgzbtybpe3/j1KH8k0G2Zszfu0kZcdHH0lxXXIrNQ4KyyLTRF1dozGGu0is2N9jG
 csQ3ghzafFSpprH+AJZ07Jv5nRS/ccdYfhnBJFAbN22SFFVfknRFixZ7t0tcn3CldPR6
 8fOifzWy/HClmrVP148OG9x1IUhnmliKQzCVVcsErweNwfTiQ9AiTRj0SCnT/26RDDYg
 CBtzn34bLjlHSnDofj8WDaD3eYKgWNUOFzd8wFotALqnszRFrk9YMaOCqIv06QpnO/I0
 fUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987253; x=1791592053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gyqt5AdRUlY/YQ93y0b7WfmjMyO1z9nII1C2dDiQyp8=;
 b=ymCYxh3DBLHUaapesirPtL2x0RKqUFtDzSwSLmTUxUnsnqBcOGeZmpHoM1rm5DFZnq
 RyXg5bE+2qzoIXDpsqtaf0gRzYdsC/fCyNuDgzyUQH2ZgxjNyE6f3slhOjHFOSn5Pg3u
 NyHVEAlEUp7PMGwGUsb09pkcHBcFoK1/Lw8u7N30MqCZfc111cjLwGOKUX3RkmgM8HLA
 NNQqBUpiFuXIGkhHiA4uCCA1R0DqP+pvN1NL4hq0m0k2xBoRFymVPqmT9SDdo6mS+luy
 gNNQCwWx6H2T5mP6S90UR8Rfwh4zmgFV1cS3X/OJjLFIwjFH+cpaI607Ws96k/tYB1bp
 Q3Eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqwCnW6mwa26DVwT2Pcnnj7s0XdCjjHszXy7MxQpvqg9C1Bmib8OK2UAEfH6uNFMlHT21Wic5MOLE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lnjvk8hBs8hC6Kc5x4IazREw5unDMWYEedAkuYqK9eHoy1hRoN
 PtGjSylhGkkqVjamnMUh5DNttAN9Qs6emStAGZPako6Pm2hOeRLGJ1bHeqGES3JtusL1g7GjqR7
 ALr7vF5FM/1ldpRAhdPRSnwPiPq4ZxhunkwaX7mOVxS2sBi0Zedima9KBjtlJFlD0JQAgTJQ=
X-Gm-Gg: AYBFou2YWHl43E7nHNruCeL12vCbkAHzlSLPYpcexqnR3LnKhmifO0F7BZ0OeHS/znG
 FGSTsBJS+HEMXgUj4oWqh7Aww/WBlyzRC5IcsSOQdg6zqjNzJ9W9ePHxXJgZYgIziH9MJwVAIng
 aOSCf984bsBMJhlhQlpiboXbFGYQeR5EIguealh9wupP50fcdNO3FROdcK0ZlMTdMeahK/2bUQZ
 OClWVhUHXcUM17eK7pqi7Tqq0viRc+865ETS9HokTveE9+MthhbuzHdmJlH7N/aAiooT8uepovG
 2210r13ZchOSidcigsrn5n5x0qN/S2DBZa//lkkvL65D83uBlhcOCkndceI3f9McaMSt9y01mZO
 857BHoyzegFK+94WISWwys8E51XpKmPPFzQeZni3R6cx9aOGHFUZnn0W7TOWqy6Z/6Y3TiXWuZf
 OrrAXmcIie99ME
X-Received: by 2002:a05:620a:460b:b0:93c:69ac:bbec with SMTP id
 af79cd13be357-93e510389b6mr220241085a.38.1790987253027; 
 Fri, 02 Oct 2026 17:27:33 -0700 (PDT)
X-Received: by 2002:a05:620a:460b:b0:93c:69ac:bbec with SMTP id
 af79cd13be357-93e510389b6mr220238585a.38.1790987252574; 
 Fri, 02 Oct 2026 17:27:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb86e68806sm1120705e87.4.2026.10.02.17.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:27:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:27:19 +0300
Subject: [PATCH 11/11] drm/msm: drop the runtime PM flags from the KMS teardown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-msm-kms-destroy-fixes-v1-11-e062b7dae77f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4721;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mXKVBYToJoPrLb4p3hSAaFS5AuCcufjkDa6V35Zg0sM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEvh672QUDihEaHzfnfmjxcZOhm+wbZYSBezg
 1Y8NXqsifSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBL4QAKCRCLPIo+Aiko
 1U4KB/9PP/hgZRnuOBFK1jSfU+2usiu9jSM4/egWc3tPXf1VS+9SCUM/LWdxTf+lw+mlFrZcbTR
 YWAwwdXWcJGcXex4284vU9V7li/rAd7zp3D7SP+4ENvjPSaf0dT74oxqGjuTr0gg2vBVRt3wo5S
 7jCyRUk0GbzRm68W+ZSt26UZIv3IelXIEvEsBTa/KNU8r/E4oBhGosdINTLfjpW0rEoiNGnfIyS
 QgdEgDKdin3kw9K7PEnQ6Xk9dphM2p7FExQIcFA9eP0WpDV1jnChHXykgVi79t0usVfzXuW+g7D
 8LEEs8z40ItTnWaeaRoK7yDbC49H4hKcMpR1Qhf0M+pJY9pm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX5864aVnUmr4v
 qoJFwY66GE/E/XouBK+F016QT3DRgdSdocCaPHc6qa7BJfcIrWhvG2s/7bCdn53+DZH8tQearUT
 iQx0GTXhhRPQG029TNtB04SxkHMEcAc=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6ac04bf5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Yohvr2p7PhcuVfY586MA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX4En3R9O9zI0B
 ogdMzrnTl/BACBWXjc2LVgUZ5td6drUDHkc8ivn/YKo8o1Hzxrxa4zpUNKeq3OLFqmyAyUz3biu
 Q9qAqx6cw7Gfn5rMNwPORg9rTYszmzn649c3l97Fj45de4LUfLgG9oHRI5logw8aooQzRQcdUqo
 oYpXJnkSoF5/R88K3V1GvlqLpvPguOdIZ8a7m36plFZepwc5/rchPaawozLrVRju7Z0CYRsB7HU
 wj7UqE9aAX0nCtF8nNaSufHoJCYRqszLmeUbbLj34R4O/TlrVhxD6msxa75OhObasKYNNG0fySe
 U9F3/3z1qrWmFqNmX/tLHnLsztf4mqFv92T2s3zFyJcsSjKJfUHbVCfihtbhocOr2N5504YXQve
 78NPqHB9j9fJGG64I6Xn0nGl3CIx02A7N4hvgPO05orBl/xJInlRUVkwPyO/9ya42uZKzSOtJTi
 u8+TleE0+OlA0utPBtQ==
X-Proofpoint-GUID: -fgyqCKACv6_dT1mJshf_2hPtSLSvo2F
X-Proofpoint-ORIG-GUID: -fgyqCKACv6_dT1mJshf_2hPtSLSvo2F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
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
index 2de4d881d13d..9756ebcce1b1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -916,8 +916,7 @@ static void dpu_kms_destroy(struct msm_kms *kms)
 
 	msm_kms_destroy(&dpu_kms->base);
 
-	if (dpu_kms->rpm_enabled)
-		pm_runtime_disable(&dpu_kms->pdev->dev);
+	pm_runtime_disable(&dpu_kms->pdev->dev);
 }
 
 static int dpu_irq_postinstall(struct msm_kms *kms)
@@ -1306,7 +1305,6 @@ static int dpu_kms_init(struct drm_device *ddev)
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
index 8529e7b2008d..daca49641811 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -128,14 +128,12 @@ static void mdp4_destroy(struct msm_kms *kms)
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
@@ -438,7 +436,6 @@ static int mdp4_kms_init(struct drm_device *dev)
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
index 80bb6ac56618..af9ac108c06c 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -574,9 +574,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms)
 {
-	if (mdp5_kms->rpm_enabled)
-		pm_runtime_disable(&mdp5_kms->pdev->dev);
-
+	pm_runtime_disable(&mdp5_kms->pdev->dev);
 	drm_atomic_private_obj_fini(&mdp5_kms->glob_state);
 }
 
@@ -729,7 +727,6 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
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

