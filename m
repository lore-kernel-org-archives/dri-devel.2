Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74372606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mxDlVb/4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Et7+YG6x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FC1112935;
	Fri, 30 Oct 2026 17:10:36 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D33A11292A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:25 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERhoC3207514
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MGiP+wlabFkesvK1GxyrQtqtDvcfG0vhc5WfZFEonYw=; b=mxDlVb/4oNjbGPp+
 D1IDaKBIrATqv/za5Qjgo0vHnkuLx4V+89qIAw4VTbiLvZ2xVJipLOb5BOy33fPd
 nbpDuXxy6kCffhskOIsWee5g81kN4l6B4bkVFgFC6iYb/B7G15jMwTPUHDDum4Wm
 S4hFYcyxjIWxyqDqLp+/njMQAUcAbO8kk7IXjgkYuxVIgF6X6OUz0bB6M5fZdkZG
 xRRsAvsv2tTTGnQb4bBQTGjAyRQUMUZzPj8/0FdV5aWq/l7g4kCYQzRy1iJbQear
 UtfAGEhX3zPZN7ZXkCUaH9ZCQ+KqOyNcpSKiT1DSopDqZfK3TuzS2PxxOV+m12av
 GUll9w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm511-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:10:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1a2af4c8cbaso438195c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793380223; x=1793985023;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MGiP+wlabFkesvK1GxyrQtqtDvcfG0vhc5WfZFEonYw=;
 b=Et7+YG6xDpYaP2J3JdRWE1O2Erdw3c83khp5Jksea1vTfjlXRiHpZ7NIBrTto+fmUk
 QRnbH38OEN8d1F/b3ohb9ZgJuMXB2UdvRlGscMbrMpmeBNkkfY7mLSLtEm2gJ4dEMHPP
 GJ/X/OPb38h5s1/drgZz7fVI0uapcPgaFLPSM+ol38dtn3yHzJhPn3CZn3qVjkbYwpoX
 ZSqMQDyk+lemv1NsncnDSghfnWuFMH99Mg8UHkBRHmVbNan/sAdok2VjkZFFEx0yxrXl
 w9PDNz1yWW1h3sJ0yyTdbxQ1PxmPaMrkKqAMZ3BOPdkZbxL1pu7VQchkCT9IOW3xxxHf
 JR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380223; x=1793985023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MGiP+wlabFkesvK1GxyrQtqtDvcfG0vhc5WfZFEonYw=;
 b=cBJptvUCqHNyFHibo6BZEHpnlkwdv8wgpWtooMPyI6j5Kjy7aMzHkKFTpGQq3UF3PV
 ZukasR1rJMa/HGxmW2ELHwOXlVPdkQ0Scac8MdJf8WP6ZHM3Sv0yX+sOOg+4RHCgL5kZ
 02S9ajE9zQgWWjdAI7dxtcVXnvj/GoMVYHshNsXpXyRaEw2scEyKz0U8jnHKPVCO7ayX
 gJayJGYbE/u63i4SnxjdI9I5tu2pNVMIwGjn88S9uN9uTkVcMI8A+WICjjrHUgtr7tv/
 5laG7X4nyqybu64Vrg4GsEk1d7yDr//G5BKbPAMFXIP23aYdDyVdQJw85mG7PM0czbU6
 lTjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyOWGYFV4kIQjKyP6MqWumsazVs/zxd5QRcPY6oKLoHc7nG0C7+WwQCbhdayNzENE/uLAkLoTNba0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJJO5ksgYVw8Mr20MZBjpmFM2pIYegR6budsIeHA3XI5EHpB1Qq
 sacSns1+jBLOurXGq7ufP3mxlFPI1yk4ueeqamd3vsHp5CVaO8DxTqDReo/4qb0lO/DKNMRBNss
 5DV5cVqOAsT1g5FzovJ1wO09bNNQdjLQvle0eJaxgIe+fsF7BhCSQ26LQCmMXdWpQyPGAo6w=
X-Gm-Gg: AYBFou2yn3Ngr0OALzy3E6IGdJVdZEgefaMNJTHzdMM8hh6zx1daynSD0Y/GxdqPu6I
 qe7UaNiq5IwWbok/jPOWu4rNlNS8fViznDSqwNILvLynjMiTzTiNI1SwL5yeJAxYEilz5LzfF87
 hIcF8M0G0tUCgi6QER93csnPikJyOUvra4kEdVFBfSd4gNjD2CSFIYjrAB81lasDpKXHk/Mpud7
 8aa+P7XLndU98Zamr0UF9Fdx7oJGEAe8cIRD0N4N24Xsw/fWG/PHJteJKHB++Is0BXUnNGCpRTP
 KNGjYA13KW/y1DXVVeP5cqLe7HQtwegbblDVxafdFqf+NE8ZLkNh0VRuD2CjzjY4BosbsJKV7Wj
 y773t6T3y8HQcohxdabjnZZygayHxp9MrsgswmUvUqP1y425YS52XFkXeFV/rfDKnJic6pfshnA
 ==
X-Received: by 2002:a05:7022:b048:10b0:19e:f233:4f87 with SMTP id
 a92af1059eb24-1ac5a2a1483mr4187504c88.15.1793380222789; 
 Fri, 30 Oct 2026 10:10:22 -0700 (PDT)
X-Received: by 2002:a05:7022:b048:10b0:19e:f233:4f87 with SMTP id
 a92af1059eb24-1ac5a2a1483mr4187449c88.15.1793380222148; 
 Fri, 30 Oct 2026 10:10:22 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm9481168c88.13.2026.10.30.10.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:10:21 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 22:39:28 +0530
Subject: [PATCH v2 7/8] drm/msm: Remove dead gpu_ops parameter from
 msm_drm_init/uninit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-gmu-sync-state-fix-v2-7-89d3082d97af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793380169; l=3626;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=XYzrF1O+N18oo1WMb7vD+Ua6dmg/Pfyq8adeQ+1TTRI=;
 b=AeDXa+GtzzyMm0oaBDru2QN6HdwHKwdCslwODLXpk9nsqIHELXhhUDyoLMUMBZThf++prZhT6
 Ks4x71aTbYFByk/GK5D+xvdwZRy7gy40154QOFWf9X/igvU5LHbWB+q
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4cf80 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=n7tE8WeWehBHorqAUqwA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: HaFsHimLq6Wszz4yhMIf3OWmFiLSUhqL
X-Proofpoint-GUID: HaFsHimLq6Wszz4yhMIf3OWmFiLSUhqL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX1Y17uF2jdBId
 d57ZrQq2r35+izjKPsKBGpabkDYigfpcijWYILFnpBfQ/7rtJ05n6cX3kGWSFSlJnlvZ4LLLxRd
 vWF4Muw46ZNwcWr6nBKKSVAuIiWfQwwurKdhuMa3XD2gacQcR4HbuP67Q1ZjywbCqDjZestwGmi
 ujhETX/d3FY+ZExUYWJmFOM8X7btqf0apS03yrsrAzwD4HbAQdoItbxHs1zuswxemi7ALrVZL/T
 W5fTU31Y3XuzDlU9QzdHP60rpS+p6prY8AdhWoxJkrVdZPIT2o87T7hVLp2SO1k/3yjawgbkZ/h
 9hMPikdoxdBOGsSmH3Wg9PnJz3zNKktjn21lGBAvQP337pD3wEImrGF/nmHXFpP9kR1zGTgr4Q0
 BkBK4AKZEpt0g8woTi26S+dcubt2nhquJRwuVP0vz3aIuOwOKosBqUhIfkugvTXNeN2P3q7dh5C
 pKcAW2fRQcdhQQ1GSxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX53LfhpO6/+8M
 OPqYLLRtBzML/3k4G4QFNsAZGbYk3m0xRmPvt7jbxNoajdHIE+MScwjd+4GUkSF/MwtUlX79uQh
 7CPFJUDC88lsKdSOQsHJORKJiuKMGcs=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haitao Xu <haitao.xu@oss.qualcomm.com>

The gpu_ops parameter on msm_drm_init() and msm_drm_uninit() was
introduced as an escape hatch for the standalone GPU path, where
adreno_probe() bypassed the component framework and called the bind/unbind
ops directly instead of going through component_bind_all() /
component_unbind_all().

Now that the standalone GPU path always uses the component model (the GPU
pdev is both master and sole member of its own component aggregate), all
callers pass NULL for gpu_ops, making the conditional dead code.

Drop the parameter and collapse the conditional branches into the
component_bind_all() / component_unbind_all() calls that are now always
taken.

Signed-off-by: Haitao Xu <haitao.xu@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 9ad2260f4971..c3b6a5f8f54e 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -148,7 +148,7 @@ struct msm_drm_private *msm_drm_get_priv(struct device *dev)
 	return devres_find(dev, msm_drm_priv_release, NULL, NULL);
 }
 
-static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_ops)
+static int msm_drm_uninit(struct device *dev)
 {
 	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct drm_device *ddev = priv->dev;
@@ -181,10 +181,7 @@ static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_op
 		msm_devfreq_cleanup(dev_to_gpu(gpu_dev));
 	}
 
-	if (gpu_ops)
-		gpu_ops->unbind(dev, dev, NULL);
-	else
-		component_unbind_all(dev, ddev);
+	component_unbind_all(dev, ddev);
 
 	ddev->dev_private = NULL;
 	drm_dev_put(ddev);
@@ -192,8 +189,7 @@ static int msm_drm_uninit(struct device *dev, const struct component_ops *gpu_op
 	return 0;
 }
 
-static int msm_drm_init(struct device *dev, const struct drm_driver *drv,
-			const struct component_ops *gpu_ops)
+static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 {
 	struct msm_drm_private *priv = msm_drm_get_priv(dev);
 	struct drm_device *ddev;
@@ -239,10 +235,7 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv,
 	dma_set_max_seg_size(dev, UINT_MAX);
 
 	/* Bind all our sub-components: */
-	if (gpu_ops)
-		ret = gpu_ops->bind(dev, dev, NULL);
-	else
-		ret = component_bind_all(dev, ddev);
+	ret = component_bind_all(dev, ddev);
 	if (ret)
 		goto err_put_dev;
 
@@ -276,7 +269,7 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv,
 	return 0;
 
 err_msm_uninit:
-	msm_drm_uninit(dev, gpu_ops);
+	msm_drm_uninit(dev);
 
 	return ret;
 
@@ -1139,13 +1132,12 @@ static int msm_drm_bind(struct device *dev)
 	return msm_drm_init(dev,
 			    msm_separate_gpu_kms_components() ?
 				    &msm_kms_driver :
-				    &msm_driver,
-			    NULL);
+				    &msm_driver);
 }
 
 static void msm_drm_unbind(struct device *dev)
 {
-	msm_drm_uninit(dev, NULL);
+	msm_drm_uninit(dev);
 }
 
 const struct component_master_ops msm_drm_ops = {
@@ -1199,12 +1191,12 @@ int msm_drv_probe(struct device *master_dev,
 
 static int msm_gpu_drm_bind(struct device *dev)
 {
-	return msm_drm_init(dev, &msm_gpu_driver, NULL);
+	return msm_drm_init(dev, &msm_gpu_driver);
 }
 
 static void msm_gpu_drm_unbind(struct device *dev)
 {
-	msm_drm_uninit(dev, NULL);
+	msm_drm_uninit(dev);
 }
 
 static const struct component_master_ops msm_gpu_drm_ops = {

-- 
2.55.0

