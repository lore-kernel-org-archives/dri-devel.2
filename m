Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1A606A333
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T0NSkmwz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NY7g8dPs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC3C10E567;
	Fri, 30 Oct 2026 17:10:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2458910E814
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:12 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERLjE2495322
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WtDfSiAyMCJxbIHdUxSc4iYPCHHVnbHwzdCobB9y9Ng=; b=T0NSkmwzPaLPGzOU
 7ikUSz6iH7my4VOU2Ye2Eq5K19kb7zb+5fCnDFJ8ejMS29VGCIwgr8dr4s8KDEGU
 NdE/OoUQnkSwwL+n89KhrodQ7zgIfvrQXLsNNruaXFd+s/ZZ8sez1iBN00zwXN1m
 ZykcU15gAwZFnosmVp8JFoA+700WHn73xDZHzh/SaXZ8VsrWq7BXIQuUb5SaTZX1
 dOX4hQgHeu3RzX0X1tp3vVxLOTJvY5tj/Il+UHcEx/YvWLJjumIkSxxIE6co3MV7
 MD2vDdcLU2AUBCL45HFLkjMBwN25XVf6O2kpglGxVYxHZ047EPTAOzirrYLqZ+L1
 mT/6ow==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p46kw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:11 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so3102073c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793380210; x=1793985010;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WtDfSiAyMCJxbIHdUxSc4iYPCHHVnbHwzdCobB9y9Ng=;
 b=NY7g8dPsu9pqkb7jdZHvBCe1XDzfpmx9AV9nTrjpb7DQYcXvLTcnXa9A3f+wTT0CHF
 wS1M5xAmXbGOU99c6pnW1FpnXKkV1cXFZ371Hb1LasIWTGOO6Tvbe/uFVWyLWzkPXuRa
 y8hpsC0ChB1CC9q/Pv8gF3OKQBPX0kESknOjIc7xFkkVnPWveXVevSQnaBpM/X92+IdS
 egSNdliu2p8g1Ou7kqSaaHtPWBLGL754M5FXzuPkWcaXfEELdZaG0uH10lUWBx/3a8ai
 1g0wItnJnuGge5CmGCOTxNT4fnxK59Sm+GINHglJVq/LY1+EKAHRpb/rGo0zVchXV695
 U+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380210; x=1793985010;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WtDfSiAyMCJxbIHdUxSc4iYPCHHVnbHwzdCobB9y9Ng=;
 b=CM7spIamwHdp3KeQwXKN6dE2oi+rBAhEtWDh/n5CYJU9liYlI4g0BMLgj7iRgJfzSB
 zjTLsJWuZYHc4jW7t6XOSnEOyuzl0JQsHu78Zy59TBVMt/fnL1GjgTj2GrjKpYVNOuxl
 Z5HXwoS1d6UqvQ7hZcnQ+xezXFf/SsjGXBjBQHH3jN7496yI+/3GelxblfrRHXEtpXu+
 8JWEWS8fyMdOJdMmIhWrSshRIi9nmBvczd1HlTDZyLliHNIKb1WRKV58jxQ1gWDNCI9M
 NqiWLtaLjtrajXnrz8Az2LTx6Lsbvx1CaZpaHDmlrZSQOSaNhsaD9cMZvpNweVvJTCGT
 daSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFMyjrURYjcDmjI09dMGULajM6ZRt2IKH4Zc6hcJtWPz/eLGhDLYfALuOvBe/MFJte7zdrUkBqVLM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIAcPAyIqAN8xk2liOhecPg7c3G+fW9oe7tSsbWhqyjvo3n16NV
 E3k+ZdNLtkSn8RPZb05EvNbo6vQAkgJ1GprLcCNR9KIUyYwGOXOQAOoscZdYl6bLrlwx+uXSeHN
 JWhbGVXZ1BOQEsY35EN9rHufdQDVjrZFLE4/xjkexk5EYMBfbZhRry0yaoKy6Qkwu4LwAvIM=
X-Gm-Gg: AYBFou0DdAPbWO28cZ2M3MwM4dwY6i8AMr/OpzI5n6veWE/lgRm5oFuGiSnNINi4HlU
 +fC1qKYHr8QHfiC4/+1tFwqjAg0N13I+BKbT3PJYGzsMlE+GOYbRYMZTbpMMgGvY5x/cWOFeyOJ
 HN1sKH7hC6PKQhJB7UtronrpVP1CdOpxQya77HyZ+MNtPqfdlchuPBwwZd3L2cPTyP7cHnDfd7j
 598Du6EFh0bacSSNzRarwAD7g9KleyhBewz2CKl7b5s1JZa7TEVA/YUC8ZeYPvDt1Os3+0jZPXF
 M+hkeG3zbQim8/8gXUVc4YPLWHOE86KF1Rx0RLGP2Q6+T0rrWFh6prNH5STIqPrQ7pfvoYkMZuE
 mmq9LnoRML06ctDOklsQrg/ZTENQUchnnoawOuqtJkgaDMpVhn/LfP+wRERsmuAPm5L7pvuhnOQ
 ==
X-Received: by 2002:a05:7022:ed09:b0:17d:7b45:f927 with SMTP id
 a92af1059eb24-1ac5c2727e4mr3669377c88.33.1793380209371; 
 Fri, 30 Oct 2026 10:10:09 -0700 (PDT)
X-Received: by 2002:a05:7022:ed09:b0:17d:7b45:f927 with SMTP id
 a92af1059eb24-1ac5c2727e4mr3669330c88.33.1793380208649; 
 Fri, 30 Oct 2026 10:10:08 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm9481168c88.13.2026.10.30.10.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:10:08 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 22:39:26 +0530
Subject: [PATCH v2 5/8] drm/msm: Always use component model for standalone GPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-gmu-sync-state-fix-v2-5-89d3082d97af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793380169; l=4464;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=U9ojTQB94Ke42+FWj/Kd9ZSdUBJo1oU4ms+Faog05Fg=;
 b=9UAOSfgUgO894d0PjxIZr6P3k7jDFVUKk71nUfqlQFhBvHbXi6XnOHXN4CutsWWwp6OFy5vOf
 gOLje3CxNO2BWjO1eQ/ZR1Xb56z/649FH0nDgwNoklvXCxsM7fNLnrI
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX+jfWttblCkA+
 VRev7CP6LOygsSWLFMNhpJrMu3tFZrH6Y/el0C9vh05tRr2xrIt6KtEzmo0K+KVxs924SfqCBXG
 BESp/CD/UTkcptcoogJ2PK73URBtqu/ytc8R/WxOrxvClZ9Du45etudfgrXwz/Gc/KWbB8Nm5pI
 xfOpawWeBT66ACyXpcxcTlL8Z7IRLz7clAqy2sqaTJVSkps1iat75GtQAo7Zc0jAcQ2ymfG8FPa
 yiiylWvytuQCn2QkbSC0g8IPyaJFpNRK9VH0k5Mo676hodVIuBpRXR6qTu+jszzBKb99ssXenfn
 hAg8GKRolnbHLR9/G0dlBTo/mpkYZU1/M2vCGFtXSJ5Gk6EAFIIcIJCESeOswZMk5ebOmiUf6up
 vN+8Uq9HRcaJG609B/Y2RTxMHZQk5Y1k1N54YTpkwH9Y86sJ+l+/F8eCoAdBZJuPylpMn1R7DcY
 ze4rSFO7iVInWJ4Mgug==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX0HVsHPIfGQmU
 /OBvGDIp5DnJYIfXL6QjTlhwp/+407TbaC5/e9rfkiy1cVQnhjqC5Rvb+yWslCAGHfOI6S42ME1
 ENI4vwB6B25v0asuIPCgGDAWywNG6ak=
X-Proofpoint-ORIG-GUID: sxPztacsxqNYXtcmMmIEY2eUAYVrmicX
X-Proofpoint-GUID: sxPztacsxqNYXtcmMmIEY2eUAYVrmicX
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4cf73 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_hlE4qLb6NvLkdTQTB4A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300068
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

To prepare for adding the GMU as a peer component, turn the GPU pdev into
both a component master and the sole component of itself in this path.
A follow up patch will introduce GMU as a component device.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 26 +++++++++++++---------
 drivers/gpu/drm/msm/msm_drv.c              | 35 +++++++++++++++++++++++++-----
 drivers/gpu/drm/msm/msm_drv.h              |  6 ++---
 3 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 34718adefbfd..6b694b8bf8e3 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -271,24 +271,30 @@ static const struct component_ops a3xx_ops = {
 
 static int adreno_probe(struct platform_device *pdev)
 {
-	if (msm_separate_gpu_kms_components())
-		return msm_gpu_probe(pdev, &a3xx_ops);
+	int ret;
+
+	if (!msm_separate_gpu_kms_components())
+		return component_add(&pdev->dev, &a3xx_ops);
 
 	if (!adreno_has_gpu(pdev->dev.of_node))
 		return -ENODEV;
 
-	return component_add(&pdev->dev, &a3xx_ops);
+	ret = msm_gpu_probe(pdev);
+	if (ret)
+		return ret;
+
+	ret = component_add(&pdev->dev, &a3xx_ops);
+	if (ret)
+		msm_gpu_remove(pdev);
+
+	return ret;
 }
 
 static void adreno_remove(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
-
-	if (of_device_is_compatible(node, "amd,imageon") ||
-	    (msm_separate_gpu_kms_components() && adreno_has_gpu(node)))
-		msm_gpu_remove(pdev, &a3xx_ops);
-	else
-		component_del(&pdev->dev, &a3xx_ops);
+	component_del(&pdev->dev, &a3xx_ops);
+	if (msm_separate_gpu_kms_components())
+		msm_gpu_remove(pdev);
 }
 
 static void adreno_shutdown(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index e0c0f1248d1b..dbb6c70473bf 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1182,10 +1182,25 @@ int msm_drv_probe(struct device *master_dev,
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
 
 	priv = devres_alloc(msm_drm_priv_release, sizeof(*priv), GFP_KERNEL);
@@ -1201,13 +1216,21 @@ int msm_gpu_probe(struct platform_device *pdev,
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
index 107d0efb62ce..e70fd617f1e0 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -529,10 +529,8 @@ struct msm_drm_private *msm_drm_get_priv(struct device *dev);
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
2.55.0

