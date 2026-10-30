Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10913606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KKc15qTT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=It4+I/2l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA7B10E7CE;
	Fri, 30 Oct 2026 17:10:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5FD10E7F5
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:31 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERANr4102831
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NqysJ98XcrozyZLY/2WYGT3NbR4IsTCmWWqG8pG6dWU=; b=KKc15qTTp7wvMKJS
 /KFhsGFj29Adakf/hPTUfl+XR6VmdIi8WGyziJE63xP+8BCLQWFWclcmWMXv2aju
 Zo9gXE5HKw0+9cvS+XLfLicLcDLxgYUuSyKts1PppkP3Wwfhlb/0bZP7fEYn5liG
 0EhWv4rzHB1UCegYw/uzvmD3i8IeXG3F6kWFGaGNtmDRgZmFiSy8J+Ko1e5wkxys
 5aP8IJ4dkp0/H+PI7xltNDxCb6C/BNW6WXrImN/PvuGKHsWFley0q/NMCiq+kFt+
 YwvIZ9ZV1F4yjHx5hgKjK2S02sVMtobqa8xIINeJMVQhzPVY1wRO4POjcBklvokr
 33Zh9A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm5hm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so2193789eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793380230; x=1793985030;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NqysJ98XcrozyZLY/2WYGT3NbR4IsTCmWWqG8pG6dWU=;
 b=It4+I/2l828CLCXD/Wt0wrTOvbUtocisXfivC+vdRgmF0+SziNTtR9rdqQeTffQ10G
 x86TrWNBolC3+LACmdRNX0WsCZ46krLIgF1142VS6lGeKZ9JoZ6y1JjCBHetlsIoUWfA
 eNvN0hok1gCn8sM5NG5Jnw6SBqTRxNPIVpzp1iSFm75XNP067PEGg2DplyXhtNI/R+VU
 3w/7I38/l14auufDEifXt3IYm4K0tvFmSh/fMVyWKGUWyd7Yt6Eimh7Ucp1z1N6+27m7
 NwNCtwlb1PSPcdeEQZ7UqkaNIAZLsLoT1YVm4DPlBIt8FaWMpfcLHOkdExXsnd1ZCWNQ
 xFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380230; x=1793985030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NqysJ98XcrozyZLY/2WYGT3NbR4IsTCmWWqG8pG6dWU=;
 b=Uvbx/CpJ4XYvS5C7j3OOPky2alCfRerNZYtEVodsy1WsnxXb4X3C2AEam8X74r2y9W
 JGpLic30QuuTPoO77dRxhoUof6DhP1rFvVjv8viL/Z7Et+iRBtij/l1fm9qyVshs/ugw
 8DGt9+jpsvO6VMNeMJUIFxvWRZKkncJ++yORkmD2NIekzb+6ULvsdWgzoGJfweIFx+pN
 V3bfPbdm4kSFqeKh+r5MottmuF7ZsGGKINyldn2wADpkp/pzUcBJDSY9w408jCX3Cvyf
 3zSjCbSZikHdWzV4Q0TU9ZByc9HTwt2PzMq+RVsF618lNgylsmTXmJvAj+TIVQVFtfkH
 czag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrvIbWmdn/ldko5ZDQeqoV0ntsf+38Vi9XFiJg1o3kj7JlVegv+Zisj725xoXIlwReQDAfYV36qlg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLcOOBpgCX/mn80X+i+GafMA90YGyN19/j5fSxS1c/jasmvbaQ9
 NcyQW6IqxXHqHsIv3Ocj0VHIIz57C/jDQJoqWJwfL0rfU3c3USaz2jkYAiNHy1Jbn/7cEDVu5g3
 X2XeSIUmSGlmnJPkxsyh0XoBSh05BBF4QaDN/HEmsf08ssqOyXHL32nVXO8Eiq8Xa9HDxMtk=
X-Gm-Gg: AYBFou3dD/LKdtEBWeoGyJYHpVGJoapGD1EGrQ9Heskc6NIxgSkrO5zVGg8XmGlUBoF
 6QBH5C3wOu09sv/QxfKWqXk5lq8MkMRO/Z4un57uBQxKQSr19yGrOWYpwzvdQCZc321FOgb5M29
 XwiONz+ZgSwMNG57PzZZcw4Gb0seM17/kB34xZ29yblF7zOzL+k3J2/hk6GoAQI6Jyd1pxSbFf7
 bJATc+pGotnBbOEqf3iECCJjoRZbKiz0Jd8n618vTfBXkrSVAV0A5bMHlzZazj0gGki6Ms+Rl6M
 uM84nVnOhVTqlUUMum9Q/pdxnkCGv56zXfYxJzOo3uk2J18l283Lutw0nW9N1VQE45FcLOp7XHA
 MrO2Kt7p7gKQp04NXhCnEcfudIatP7/g0k/IjOcbQrF73q0qyAVBDD4z7xGiViPX6w2u92ZfieQ
 ==
X-Received: by 2002:a05:701b:4509:20b0:1a3:9936:d11e with SMTP id
 a92af1059eb24-1ac5e6007a2mr3643700c88.41.1793380229601; 
 Fri, 30 Oct 2026 10:10:29 -0700 (PDT)
X-Received: by 2002:a05:701b:4509:20b0:1a3:9936:d11e with SMTP id
 a92af1059eb24-1ac5e6007a2mr3643671c88.41.1793380229048; 
 Fri, 30 Oct 2026 10:10:29 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm9481168c88.13.2026.10.30.10.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:10:28 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 22:39:29 +0530
Subject: [PATCH v2 8/8] drm/msm: Consolidate msm_gpu_probe into msm_drv_probe
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-gmu-sync-state-fix-v2-8-89d3082d97af@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
In-Reply-To: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Haitao Xu <haitao.xu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793380169; l=6057;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=sONlzsPT29UAeBqmPTtdX60UvCZl7+AmXROlA7B8TK0=;
 b=Wan5DlUHIgj5ZMjZoOWy7AETlH0P+Dg0NF03vz5Gx7628wEF7YAS58IASRYgG9b0Oj0QC9OW1
 3rbCl83bwGPBFRMRamrvC8W+EJN9jzuEwC+myfjEnILg2WQFy5igWNF
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfXyiKStqJg1cy8
 sio+l++l/Iy0KWBuXD/bEESsGDNFdFiqjRX8K6ya8xTQCwfjf3huQIwmjrSqEZS94oIPpAdC2Sc
 YRjz/jDjHJ2GTBBpK8WFNpTG24ufHD85ilEaZc6yol1MBSRUOYsW29AJX+Di07ij+zLvT21jxuE
 TxUmysmOIGhhJxGi3Jw6/wmVRA0djgOfA8iUxUvtBwKQppKubGSUAI1qFvHFtE5pmJZSi9NyoXO
 68UIeciefhshOPcXWCgzF70+Juw2HWfhL5H93RLETxn8hv1Bs07abqxkbkyNoKO6QKtbbuhfLZw
 /BlWW3nyi8Z8LpbByCbBVU4GdwnKL7m4ofy+54LHsljpaJe2AP+moGO6dgcBoNLo1VQpJsizI9z
 n/9XSJUV0rG/xIXVLOZWkV7NcvWAEDYORr1OQGYAbuvfHltzSNwy0ZUnOBFOj5m3z4dZR/yo/Ie
 3vR2uCmMjI83D76+P0g==
X-Proofpoint-ORIG-GUID: LEvTwfFzJDRaKeG3L0OrYhi-d6umM8KD
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4cf86 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=2p9jR3MHfXHM8ZZsoHgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX4xMAbJnexWER
 bw05jmKkw94as6A0MepWVoBoPGZ9Uv/GBg98sfd+5dH3L8n0pESF3/AZszpI7u9iDNuRqdODR/i
 UVw6vcGLLXYJPp7eltHYjzQTd8Zs5RE=
X-Proofpoint-GUID: LEvTwfFzJDRaKeG3L0OrYhi-d6umM8KD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300068
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

From: Haitao Xu <haitao.xu@oss.qualcomm.com>

msm_gpu_probe() duplicates the setup already done by msm_drv_probe():
allocating msm_drm_private, setting the DMA mask, scanning for GPU
components, and registering a component master.

Reduce msm_gpu_probe() to delegate to msm_drv_probe(dev, NULL, NULL) and
drop the now-unused msm_gpu_drm_{bind,unbind,ops} helpers. Extend
msm_drm_bind() to select msm_gpu_driver when kms_init is NULL, and relax
the add_gpu_components() guard in msm_drv_probe() to always run for
GPU-only callers.

Signed-off-by: Haitao Xu <haitao.xu@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c |  3 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  3 +-
 drivers/gpu/drm/msm/msm_drv.c            | 61 +++++++++-----------------------
 drivers/gpu/drm/msm/msm_drv.h            |  1 +
 5 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index c044d3c9737a..4e5ba85317f6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1423,7 +1423,7 @@ static int dpu_dev_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return msm_drv_probe(&pdev->dev, dpu_kms_init, &dpu_kms->base);
+	return msm_drv_probe(&pdev->dev, NULL, dpu_kms_init, &dpu_kms->base);
 }
 
 static void dpu_dev_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index c299fef1a400..ad08a040982f 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -553,7 +553,8 @@ static int mdp4_probe(struct platform_device *pdev)
 	if (IS_ERR(mdp4_kms->lut_clk))
 		return dev_err_probe(dev, PTR_ERR(mdp4_kms->lut_clk), "failed to get lut_clk\n");
 
-	return msm_drv_probe(&pdev->dev, mdp4_kms_init, &mdp4_kms->base.base);
+	return msm_drv_probe(&pdev->dev, NULL, mdp4_kms_init,
+			     &mdp4_kms->base.base);
 }
 
 static void mdp4_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 40b4415c0fba..067e23fb9649 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -858,7 +858,8 @@ static int mdp5_dev_probe(struct platform_device *pdev)
 
 	mdp5_kms->base.base.irq = irq;
 
-	return msm_drv_probe(&pdev->dev, mdp5_kms_init, &mdp5_kms->base.base);
+	return msm_drv_probe(&pdev->dev, NULL, mdp5_kms_init,
+			     &mdp5_kms->base.base);
 }
 
 static void mdp5_dev_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index c3b6a5f8f54e..9eb5d182eaed 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1129,10 +1129,17 @@ static int add_gpu_components(struct device *dev,
 
 static int msm_drm_bind(struct device *dev)
 {
-	return msm_drm_init(dev,
-			    msm_separate_gpu_kms_components() ?
-				    &msm_kms_driver :
-				    &msm_driver);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
+	const struct drm_driver *drv;
+
+	if (!priv->kms_init)
+		drv = &msm_gpu_driver;
+	else if (msm_separate_gpu_kms_components())
+		drv = &msm_kms_driver;
+	else
+		drv = &msm_driver;
+
+	return msm_drm_init(dev, drv);
 }
 
 static void msm_drm_unbind(struct device *dev)
@@ -1146,6 +1153,7 @@ const struct component_master_ops msm_drm_ops = {
 };
 
 int msm_drv_probe(struct device *master_dev,
+	struct device_node *gpu_np,
 	int (*kms_init)(struct drm_device *dev),
 	struct msm_kms *kms)
 {
@@ -1169,8 +1177,8 @@ int msm_drv_probe(struct device *master_dev,
 			return ret;
 	}
 
-	if (!msm_separate_gpu_kms_components()) {
-		ret = add_gpu_components(master_dev, NULL, &match);
+	if (!kms_init || !msm_separate_gpu_kms_components()) {
+		ret = add_gpu_components(master_dev, gpu_np, &match);
 		if (ret)
 			return ret;
 	}
@@ -1189,51 +1197,14 @@ int msm_drv_probe(struct device *master_dev,
 	return 0;
 }
 
-static int msm_gpu_drm_bind(struct device *dev)
-{
-	return msm_drm_init(dev, &msm_gpu_driver);
-}
-
-static void msm_gpu_drm_unbind(struct device *dev)
-{
-	msm_drm_uninit(dev);
-}
-
-static const struct component_master_ops msm_gpu_drm_ops = {
-	.bind = msm_gpu_drm_bind,
-	.unbind = msm_gpu_drm_unbind,
-};
-
 int msm_gpu_probe(struct platform_device *pdev)
 {
-	struct msm_drm_private *priv;
-	struct component_match *match = NULL;
-	int ret;
-
-	priv = devres_alloc(msm_drm_priv_release, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	devres_add(&pdev->dev, priv);
-
-	/* on all devices that I am aware of, iommu's which can map
-	 * any address the cpu can see are used:
-	 */
-	ret = dma_set_mask_and_coherent(&pdev->dev, ~0);
-	if (ret)
-		return ret;
-
-	ret = add_gpu_components(&pdev->dev, pdev->dev.of_node, &match);
-	if (ret)
-		return ret;
-
-	return component_master_add_with_match(&pdev->dev, &msm_gpu_drm_ops,
-					       match);
+	return msm_drv_probe(&pdev->dev, pdev->dev.of_node, NULL, NULL);
 }
 
 void msm_gpu_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &msm_gpu_drm_ops);
+	component_master_del(&pdev->dev, &msm_drm_ops);
 }
 
 static int __init msm_drm_register(void)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index e70fd617f1e0..b65702ac0140 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -532,6 +532,7 @@ void msm_kms_pm_complete(struct device *dev);
 int msm_gpu_probe(struct platform_device *pdev);
 void msm_gpu_remove(struct platform_device *pdev);
 int msm_drv_probe(struct device *dev,
+	struct device_node *gpu_np,
 	int (*kms_init)(struct drm_device *dev),
 	struct msm_kms *kms);
 void msm_kms_shutdown(struct platform_device *pdev);

-- 
2.55.0

