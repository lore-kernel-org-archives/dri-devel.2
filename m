Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A02606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KhCwhSVa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SepALNnh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B25F110E273;
	Fri, 30 Oct 2026 17:10:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B16112935
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:58 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERj3I3207537
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MNY+Xl+6T4UEwDBWIt1uS+hdJNrhBZefG9ZAqTj1DwA=; b=KhCwhSVaiGrnj1u6
 fK2cP2KXEP5da6gh62zCmNCO2BGTAz6Om2CMLNBkqRmhWqwO7BxESMMlYTbfRleg
 alCXJBj6lnRNk0lgHeDkySTw9K+Af8VQIcUy9SpWl+1S41hvRrreGk7a9hy87bWy
 cJU5aKC+7IjYi1eGmEk888tdIT2g89AItSS0/e6776J38/PEugZ4oPxfDFY2FYdt
 cdnSEeIJ5ipKMMrVDYdc4nKPbjszMlLC0s/4kTqAxi1a7Y4IMfleNJis4/Gb6FKy
 Mf80pPnSmChXT3HJeH03qJeAVCkAEgJYxXQRHilLDOjb8AYs9MDoRxCGCLeAsXGT
 KaDy0Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm4xy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a223755e4so3740218eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793380196; x=1793984996;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MNY+Xl+6T4UEwDBWIt1uS+hdJNrhBZefG9ZAqTj1DwA=;
 b=SepALNnhlQ+HC8qOZ3m4+qoOa1hlr226ghh1xUVUhFq32dd9l5NR6BfgOxfiBnXy1X
 24x3Ym6h+Xr65pqc+G9UriaOhv8xv8/oEQsedp3xzMEWlWLG09zcLLFHf7PpfsAxUL+l
 FcQilLS0s9sut0wVzTf6Aetfa+qCnyn+XNdYZtD4jqc6Atz52sIvebnaHA5lIfoco+u9
 MBsYY30rHzVnv2d8e2q0pByNGMxSWjXXOomg1g3QOMzm9nktUcQE8BxjiIkqYXhnS94u
 RRTQVsSZYa4kpaVZAxX4K53gu/qet543P/8QHJDjiqi204svp0s+SRbBM4Wp6Q/RtlfG
 acrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380196; x=1793984996;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MNY+Xl+6T4UEwDBWIt1uS+hdJNrhBZefG9ZAqTj1DwA=;
 b=pon8rH13Q0u6RwCEtuM2I/GeMwx9IsHJq+ykrXbvQtdfNHwEXJY//W+gvtbe1ZUJkW
 SIxY1u+Vno8wUEkerRMbCDthUMGJeMxXGf98e1yv7spD+/BhjZRF4hm6BpzL2siHTNme
 YYXWKv7wJ2AtIm51Caydjwuhuy7JsmZYKcSx0cblupkTY/+aG28URLPdk6b2aP9/qZXL
 dbe7BQcMi55JFDhUEiAxUqdOMAWlAA6EJTJ3GeRCRQ3mG6Dg/D7YktHAFvNkRcGWNxoC
 la7njy5ppxauyBL4tXaWnuE8XPuUfB5UJzqgKiyvXv0ssqemIRSA9vSq+He6iT5tuDh1
 XJIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzg/GQLhXDVv2x+CTiQ2Fz60Gz74rx6qZbZZA6SEeMLFPGS9gE98NqIiajfXr4cLj+ULcgN4dGwjbg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIKmi6vwHWu003LX2lFbz0VdWEhQiXOT7YQR71v9eLkSSGF6JLI
 53cGNIvzAdLcWSTbiFcpxMhfIb0hEGGGlQnaGkxvpoCaVMlrQRao1qKfuWFhqDi3tnqrWj/RcIj
 qfXl+YocW8meTnWpJDhwmVv810zK8BBx7+SJTwI/VQW5GS7KiRlAt+1ZrTK4E9fEaRrf+2I4=
X-Gm-Gg: AYBFou0Ntph8ohnHyJVT1kslE3/FJJANbzVBulGGpPcsQvXgyCUpUgHXJdRqrbSDX0g
 8tmBss8Gth/GMkS4l/gvHQfHRr8/O29XFPVNsJWqWHG124kiQLct5toKyVjh3nIpGNRLbL9DOMS
 IeWAsXeg4+i1ajlg1u/2GeCabSsigXsDQkH1PrQhIS6wU80gNidQOI02vsaJpvUdFalWsMLILi+
 EBlte565gSR4/08YcIsSE2ZU4o4PyZb/SKkZCyArRIvoxsA/V95DVZId6WG4s13QN15cs9hg8nT
 0nX44XpH6Ccp17Cw4ag7uvuuAD60zSibyjjzzYHJm4lbQj/wXS1yggDakwS9FTMRq3Py/6n5lsf
 LoPwv8riQarVwoTS5XSDSOqXqMzQyVE5TB+2bFtmwcv+VYBi55pNSwVJyHL9Rs5zOns7utCvjwQ
 ==
X-Received: by 2002:a05:701b:2088:10b0:163:8b44:902c with SMTP id
 a92af1059eb24-1ac5c64c523mr3898570c88.17.1793380196172; 
 Fri, 30 Oct 2026 10:09:56 -0700 (PDT)
X-Received: by 2002:a05:701b:2088:10b0:163:8b44:902c with SMTP id
 a92af1059eb24-1ac5c64c523mr3898540c88.17.1793380195553; 
 Fri, 30 Oct 2026 10:09:55 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm9481168c88.13.2026.10.30.10.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:09:55 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 22:39:24 +0530
Subject: [PATCH v2 3/8] drm/msm: Keep DRM private data separate from GPU
 drvdata
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-gmu-sync-state-fix-v2-3-89d3082d97af@oss.qualcomm.com>
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793380168; l=12739;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=mdoeTxvLcE2BiflRifWdedT2HWOyH64ezGV97yCZIv4=;
 b=41bb6hJAMQ+g+sWIxLW3woDWrirUcw5cJ21PvI+J4e50jpniUuYFacSNfNgceod+UImX12YfY
 2BWEUgKEcx7DoOIv+6nkQ62kux0+2UjKCR6Gt6asktMFjttel7nAIeK
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4cf65 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=mqA-2NgDKB53S3mr2GcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 2y7o9rEx4_ef0sMUWa1o6e3pvFxOy4L6
X-Proofpoint-GUID: 2y7o9rEx4_ef0sMUWa1o6e3pvFxOy4L6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX2dXXfr3+IXdP
 tShB9qY28BNrJuzP2b+Vt3wuUQ5on+GaWfaAaUSYp6eklWjn9ZLXdvEa/ekiuhGvINM41gXUN/7
 2ukEpqq7oBzL6ubi5+mW6tK4TY4oELxIB5iZ8tC0rt5QG6QaVHLN7znj3eElmckEAP4q5S186wZ
 7rCfF1/n+ddTrRfUZqIf0sIyEIW8jcc2nLIvyqF3C3z7X4Z/rrJEqAkmk35JegM0FXVNs+BG7wC
 cPvmlPUCDeQpd8Ro+Q/crSMDXnoAmkqfzGNynxn5xgAKjHr8XFou4CDI7f5mgNOUYuthatUK2kB
 kBg+t6MMbPB76w+0O6y50QWu2Yi4mclz3RQw8hpMc60XDyjFmZ8JLTEmdtBXvvFdP/dVjrd3mme
 rix8CwdsE1kgS6mEcIY0PAROtPa3M3CKzBF9mP9VqdP47jY3QrQYMQNJSVBzjgKVeapAfWF2FSw
 GjhxHsjEZxgzdDFDDjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX8lzIr1TVwJoc
 u3BrpzBkUZ/l5rYCxDwCjAEXEN3fSfgulBV9kHviS2pcK9FNMqAqMztdvz8aRcdNg7usUQTPjAV
 4vqAfKep5rMoxTNVdCJeb31yE/bKcGo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In separate GPU/KMS mode, the GPU device is also the DRM component
master. msm_drv_probe() stores priv in its drvdata, but msm_gpu_init()
overwrites it with &gpu->adreno_smmu. So, it is better to avoid using
drm priv data in the master's dev->drvdata.

As an alternative, store priv in a devres entry of the drm master and
retrieve it from there during component bind. Update all component
drivers to use the new helpers.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c |  6 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    |  6 ++----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   |  6 ++----
 drivers/gpu/drm/msm/dp/dp_display.c        |  4 ++--
 drivers/gpu/drm/msm/dsi/dsi.c              |  4 ++--
 drivers/gpu/drm/msm/hdmi/hdmi.c            |  4 ++--
 drivers/gpu/drm/msm/msm_drv.c              | 24 +++++++++++++++++-------
 drivers/gpu/drm/msm/msm_drv.h              |  2 ++
 drivers/gpu/drm/msm/msm_kms.c              | 17 +++++++----------
 9 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 1798bb12805a..cdf26b38b904 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -209,10 +209,10 @@ bool adreno_has_gpu(struct device_node *node)
 
 static int adreno_bind(struct device *dev, struct device *master, void *data)
 {
+	struct msm_drm_private *priv = msm_drm_get_priv(master);
 	static struct adreno_platform_config config = {};
-	const struct adreno_info *info;
-	struct msm_drm_private *priv = dev_get_drvdata(master);
 	struct drm_device *drm = priv->dev;
+	const struct adreno_info *info;
 	struct msm_gpu *gpu;
 	int ret;
 
@@ -254,7 +254,7 @@ static int adreno_system_suspend(struct device *dev);
 static void adreno_unbind(struct device *dev, struct device *master,
 		void *data)
 {
-	struct msm_drm_private *priv = dev_get_drvdata(master);
+	struct msm_drm_private *priv = msm_drm_get_priv(master);
 	struct msm_gpu *gpu = dev_to_gpu(dev);
 
 	if (pm_runtime_enabled(dev))
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..c044d3c9737a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1434,8 +1434,7 @@ static void dpu_dev_remove(struct platform_device *pdev)
 static int __maybe_unused dpu_runtime_suspend(struct device *dev)
 {
 	int i;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
 
 	clk_bulk_disable_unprepare(dpu_kms->num_clocks, dpu_kms->clocks);
@@ -1449,8 +1448,7 @@ static int __maybe_unused dpu_runtime_suspend(struct device *dev)
 static int __maybe_unused dpu_runtime_resume(struct device *dev)
 {
 	int rc = -1;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
 	struct drm_encoder *encoder;
 	struct drm_device *ddev;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 3934cd060b27..40b4415c0fba 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -869,8 +869,7 @@ static void mdp5_dev_remove(struct platform_device *pdev)
 
 static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
 
 	DBG("");
@@ -880,8 +879,7 @@ static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
 
 static __maybe_unused int mdp5_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
 
 	DBG("");
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9299ce616fdb..40ce87d7d252 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -214,7 +214,7 @@ static int msm_dp_display_bind(struct device *dev, struct device *master,
 {
 	int rc = 0;
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
-	struct msm_drm_private *priv = dev_get_drvdata(master);
+	struct msm_drm_private *priv = msm_drm_get_priv(master);
 	struct drm_device *drm = priv->dev;
 
 	dp->msm_dp_display.drm_dev = drm;
@@ -237,7 +237,7 @@ static void msm_dp_display_unbind(struct device *dev, struct device *master,
 			      void *data)
 {
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
-	struct msm_drm_private *priv = dev_get_drvdata(master);
+	struct msm_drm_private *priv = msm_drm_get_priv(master);
 
 	of_dp_aux_depopulate_bus(dp->aux);
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index c726fc628a08..bc6d470bb191 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -119,7 +119,7 @@ static struct msm_dsi *dsi_init(struct platform_device *pdev)
 
 static int dsi_bind(struct device *dev, struct device *master, void *data)
 {
-	struct msm_drm_private *priv = dev_get_drvdata(master);
+	struct msm_drm_private *priv = msm_drm_get_priv(master);
 	struct msm_dsi *msm_dsi = dev_get_drvdata(dev);
 
 	/*
@@ -146,7 +146,7 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 static void dsi_unbind(struct device *dev, struct device *master,
 		void *data)
 {
-	struct msm_drm_private *priv = dev_get_drvdata(master);
+	struct msm_drm_private *priv = msm_drm_get_priv(master);
 	struct msm_dsi *msm_dsi = dev_get_drvdata(dev);
 
 	msm_dsi_tx_buf_free(msm_dsi->host);
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 474006084633..2ca7693773b2 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -236,7 +236,7 @@ static const struct hdmi_platform_config hdmi_tx_8974_config = {
 
 static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 {
-	struct msm_drm_private *priv = dev_get_drvdata(master);
+	struct msm_drm_private *priv = msm_drm_get_priv(master);
 	struct hdmi *hdmi = dev_get_drvdata(dev);
 	int err;
 
@@ -251,7 +251,7 @@ static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 static void msm_hdmi_unbind(struct device *dev, struct device *master,
 		void *data)
 {
-	struct msm_drm_private *priv = dev_get_drvdata(master);
+	struct msm_drm_private *priv = msm_drm_get_priv(master);
 
 	if (priv->kms->hdmi) {
 		msm_hdmi_destroy(priv->kms->hdmi);
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5e8f3ce26b32..e25ef578d2b3 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -137,10 +137,19 @@ bool msm_separate_gpu_kms_components(void)
 	}
 }
 
+static void msm_drm_priv_release(struct device *dev, void *res)
+{
+	/* The devres core frees the allocation after this callback. */
+}
+
+struct msm_drm_private *msm_drm_get_priv(struct device *dev)
+{
+	return devres_find(dev, msm_drm_priv_release, NULL, NULL);
+}
+
 static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_ops)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct drm_device *ddev = priv->dev;
 
 	/*
@@ -177,7 +186,7 @@ static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_op
 static int msm_drm_init(struct device *dev, const struct drm_driver *drv,
 			const struct component_ops *gpu_ops)
 {
-	struct msm_drm_private *priv = dev_get_drvdata(dev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct drm_device *ddev;
 	int ret;
 
@@ -1137,13 +1146,14 @@ int msm_drv_probe(struct device *master_dev,
 	struct component_match *match = NULL;
 	int ret;
 
-	priv = devm_kzalloc(master_dev, sizeof(*priv), GFP_KERNEL);
+	priv = devres_alloc(msm_drm_priv_release, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->kms = kms;
 	priv->kms_init = kms_init;
-	dev_set_drvdata(master_dev, priv);
+	/* Register before component binding so priv survives unbind/rebind. */
+	devres_add(master_dev, priv);
 
 	/* Add mdp components if we have KMS. */
 	if (kms_init) {
@@ -1178,11 +1188,11 @@ int msm_gpu_probe(struct platform_device *pdev,
 	struct msm_drm_private *priv;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devres_alloc(msm_drm_priv_release, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
+	devres_add(&pdev->dev, priv);
 
 	/* on all devices that I am aware of, iommu's which can map
 	 * any address the cpu can see are used:
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 2840e8a5052d..107d0efb62ce 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -524,6 +524,8 @@ static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
 
 extern const struct component_master_ops msm_drm_ops;
 
+struct msm_drm_private *msm_drm_get_priv(struct device *dev);
+
 int msm_kms_pm_prepare(struct device *dev);
 void msm_kms_pm_complete(struct device *dev);
 
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..3597dc276579 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -218,8 +218,7 @@ struct drm_gpuvm *msm_kms_init_vm(struct drm_device *dev, struct device *mdss_de
 
 void msm_drm_kms_unregister(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct drm_device *ddev = priv->dev;
 
 	drm_atomic_helper_shutdown(ddev);
@@ -227,8 +226,7 @@ void msm_drm_kms_unregister(struct device *dev)
 
 void msm_drm_kms_uninit(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct drm_device *ddev = priv->dev;
 	struct msm_kms *kms = priv->kms;
 	int i;
@@ -262,7 +260,7 @@ void msm_drm_kms_uninit(struct device *dev)
 
 int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 {
-	struct msm_drm_private *priv = dev_get_drvdata(dev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct drm_device *ddev = priv->dev;
 	struct msm_kms *kms = priv->kms;
 	struct drm_crtc *crtc;
@@ -341,7 +339,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 
 int msm_kms_pm_prepare(struct device *dev)
 {
-	struct msm_drm_private *priv = dev_get_drvdata(dev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct drm_device *ddev = priv ? priv->dev : NULL;
 
 	if (!priv || !priv->kms)
@@ -352,7 +350,7 @@ int msm_kms_pm_prepare(struct device *dev)
 
 void msm_kms_pm_complete(struct device *dev)
 {
-	struct msm_drm_private *priv = dev_get_drvdata(dev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct drm_device *ddev = priv ? priv->dev : NULL;
 
 	if (!priv || !priv->kms)
@@ -363,7 +361,7 @@ void msm_kms_pm_complete(struct device *dev)
 
 void msm_kms_shutdown(struct platform_device *pdev)
 {
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = msm_drm_get_priv(&pdev->dev);
 	struct drm_device *drm = priv ? priv->dev : NULL;
 
 	/*
@@ -379,8 +377,7 @@ void msm_kms_shutdown(struct platform_device *pdev)
 
 void msm_drm_kms_post_init(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct drm_device *ddev = priv->dev;
 
 	drm_kms_helper_poll_init(ddev);

-- 
2.55.0

