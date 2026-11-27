Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D0606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QLa4LdzB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TC0fTD88
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D2410EA81;
	Fri, 27 Nov 2026 19:45:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BFF10EA70
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJB55R1128343
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v90QvhkIgNCXcGu6Ga0Ig41/cN5GYuSQP4gP4y7SxzM=; b=QLa4LdzByzYmdRqr
 AVKBA2y89yHsCVutuNMIzR6SG75vrLExlMUHxD0iltmK1wNlw0ibZ5OX/rLgJ3O1
 YdCs+BWNu/E671RF1/fq3IijyJWvbfjELvqGtIItsbKApZiwEOqk0t5hu1eGDe1i
 h6KZJJxueKe+MjhnPS6JQaURo2Ze1z+8Fy1s6ruPe6w521sWprZF5IkHQxxdYPA6
 wLW2S+js2tk/wXmYOr7CuSMK9GP5540yZ5yEMTulqy+BasjN75Bco0EcTPSbOVy7
 Pb9G/e/RPHhi0T3x5LuPtCJ+bbljjeea07vt7dbAJCS3PZwPBxAsV9oMRLF6qeFi
 UfmnXw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6trtx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94961ed97d6so1382330885a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808698; x=1796413498;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v90QvhkIgNCXcGu6Ga0Ig41/cN5GYuSQP4gP4y7SxzM=;
 b=TC0fTD88J3ckOQfeu9BB53E8mGChWCTn0r1O88JWvDA8URi+lu5glsT4eOFgewadLt
 G3YVLdzApeVFJykGEhturyOVRnReuYIzCvSaEDoEI+GruiBjoSnIQTU2Z82Z45t/90MX
 YVQQEUSu3kTZvBSTqq68/J/hxdAN3h9T60EwYVQkO6c4Y0vXcDKpp7lt1WQ7/tIzJG2X
 7joLULEwdqWdDPTZFkta65RUpz0dA4SCKAzDBIJ7yH4XMx+oa11hbe/MKeDwNbWEzPbU
 1M/g7cGWsw/ExV3mHb6UEA8kZDA8KTJERoW+7/+ZUWnUV4nwlVAeeKphGwbjhWuyte0X
 Mb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808698; x=1796413498;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v90QvhkIgNCXcGu6Ga0Ig41/cN5GYuSQP4gP4y7SxzM=;
 b=VSB6x3JGnfjw6RIa3OG5FmjgNVVxJJzvjhfEYTjU/YMQLpWE/M8lgUBSZV6BEbqTJN
 UsQIWAvT8unV76QLXrrQMN5peDcyI+/ickJyE+hAK11ZaWxH/xBo5p19CHRcCA31+EkG
 fXwyWsdd0jOE56g/MFPIdZbKOxS45Al1qeHRQGlxs0tsySuOWkh6OKOI6TuuedsVQi9n
 lPvN/FZw92070wVcfkx37LEuUIMfqzfrTKC7JarulL7rDxiQbmyuDO09qz0iKU9nhckg
 JHxjOQSHR4x+g0Gk90MaKWQ0TkcqX9bqk2MmW9vf5ZzHFbfIBaphK3GzNjsaEfhlnywW
 +d3w==
X-Forwarded-Encrypted: i=1;
 AL+hErHSjftZIdJzScQo3J1VKuWKMuOdOLf0Iu75L0U4HL831AObSPoTRYZ4UvFVpiXpGybVSo260F0v9yk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/9GIRhLMpO6F7jzrRaUj2sAC/HSGkAoKSGMUKuTP8xSA7eZRu2
 AGzll55Ds9yw1Ri5y6cw8zxRyAhRzzNYBO5E7PWjcl468UcfTnz1aXvz6SmduogUJcBJeTIE5hO
 twTk2cgwQ638/blT75Aheh1cFPhmFzcwI/uKfRrC+onWOHfApktdi9WEEwmO/R3NGHByOaps=
X-Gm-Gg: AZFdTZcpRLMERdmEN77tfpSl1EyK2WcKjt9OnM9FPhEgNwJJ8IqsKbFFRjo2iWj5sHR
 8zeuOmoMnDI+6uvFqgntYbMmd1Gl8rDZYwv+8dcPrqhSPu3+8qFHcc2mrNyzBr2zZaNhBJupyjz
 fPuDdprVS2Mr9EoJooe2Zoh3AV4MHyokqcuNNkNovxKL1OtmsHAwxB1+FW5Az1UiDCP5lR9deuC
 vUCDjmTygizhHYiBwykvTNVaEyp/rDPoYaEPMO/8b8e48ChpuAi51A9Q0sYGs+/kn4JJ6fDjiSL
 hmwgYVsl+8DALHtrVATSB/S0z2nU9/sQrxPy0BfQGIa1dRnpzlixxKrscXO9ClgEZqQCj8wVH+Q
 JGoF0b6ohILPAOTIK58wf93VA+nmi4koelIyMcCfB+eMbx/we2StifLjpGSvW/wgv7QWgXRHpJ1
 MC9cNoUnKHx9I5M86NeiQwT+YXTnlPt79d3kdHnqSBXAO98aVi4JKKUrWHukmSjw==
X-Received: by 2002:a05:620a:40d:b0:949:f8bf:b6e9 with SMTP id
 af79cd13be357-949f8bfb90dmr1690142585a.25.1795808697780; 
 Fri, 27 Nov 2026 11:44:57 -0800 (PST)
X-Received: by 2002:a05:620a:40d:b0:949:f8bf:b6e9 with SMTP id
 af79cd13be357-949f8bfb90dmr1690140485a.25.1795808697360; 
 Fri, 27 Nov 2026 11:44:57 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:44:56 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:16 +0200
Subject: [PATCH v4 03/14] drm/msm: unwind msm_drm_kms_init() on failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-3-242b0a3f8e47@oss.qualcomm.com>
References: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
In-Reply-To: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5635;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=D7FE9O21+4uzqGcggiGh24L+2j3CuLP1bVL7YPFNAII=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2ZZUi1yMxzMGYeZS3t1SL5yrKR8jLb+gK+X
 PvyZZUnnOqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndmQAKCRCLPIo+Aiko
 1UAmB/9zEnXvb//f3se1mM5eYZs+0Cw02OYL/3nD78+RQhPPEQaMmT5+S0FDBMXF1DWn9LoAHO9
 m+fAsu8DUa7/osyV+4pdhMAPOotERNcGCqZKAZu2Jdu9XIAL0GjmaDBz5WwHbuW7qWZvXhKe47L
 vWlLyMZfYjcsNvN4O7GFTAXYYg7ksSohzCHkQMpjGFJ+JQR6kKNx8Plob9iXzaSx8g+eAb1JqON
 /y3kpq1MHPYrsmMThNPiAQR6pBuBxH9neg/yY5ECCZlKGMIlox7OUYQdjmx3cXWF9S07hS/KeaW
 UJV0f6KokszFSAG0/e9UEu5+dGRehq8Ot5X/N2/J0xcVMrdn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Jrkp9-WLo6S3sIc8e18CgJuEdaCK1tiZ
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09ddba cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=_ChxW0iHWOZRcJAqfHkA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX8PPtQeblgVJr
 oaToo2AcPn7Ykw7KFzBesYB2HaN76kznZp4P0uPHx8uivw1XcnBu4VF0Gv+GUClEoIiaa8zHLNX
 DjrA+VvcW6IhQQi/y1EQ+HbrljljeMo=
X-Proofpoint-GUID: Jrkp9-WLo6S3sIc8e18CgJuEdaCK1tiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfXzecZmVj/lJxH
 VOukp1Bsr8TfesQ7UgQ1vxAN9o3X+CbXaJim5pk3BwfVngsB1SbW3+Iyyfx04tl1J2q/CqBZXdP
 ChNN/D3db8m+xdk9uaG6CHxULYNW0Ki09vW7KyHnkD9HYOHaA9EnIoaWvQkpFvv01OS+5XLMqhI
 u2+vZh5VUFKw8dYGNN0xWB2JBP6luZgOx/5wLgV8Mwecr7Xv9OSYYQ6xD+GHoPzYqdfvl+oYizt
 oZndnSg/gt3Hi+k8+j2sn0UyhemHskClHFxuKz2rfjAK+cBHuRcZiYW6TeydZ76+/tGG+GG61QE
 kECN3LI9cecQHgL5mGMzuQkAG2lNDY3+q0HI7dbwFn1T5c8eXc1CqtwC1TDlsxgWuei968cmgGv
 CLattkEkv556rIr3Pzn703pwE3cKym61PSzGyzijK9rSJES8ntC/XqI92Rd3DZe42zpUuYV909j
 SReBLAhspTtHNHUp9AA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270078
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

msm_drm_kms_init() leaves behind whatever it has already set up when it
fails and lets the caller sort it out: msm_drm_init() jumps to
msm_drm_uninit(), which runs msm_drm_kms_uninit() for every device which
has a kms.  That is the teardown of a fully initialised KMS -- it flushes
kms->wq, calls ->irq_uninstall() and frees the IRQ, none of which exist
yet when the failure happened early.

The kms driver's own init is the first step which can fail, and since
commit a409b78fcdf7 ("drm/msm: move wq handling to KMS code") the
workqueue is created by msm_kms_init() rather than by msm_drm_init(), so a
failure there leaves a NULL kms->wq for flush_workqueue().

Undo the steps which have completed instead, and let msm_drm_init() unwind
its own error paths rather than calling the full teardown.

Fixes: a409b78fcdf7 ("drm/msm: move wq handling to KMS code")
Assisted-by: LLM
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 29 ++++++++++++++++++++---------
 drivers/gpu/drm/msm/msm_kms.c | 36 ++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5e8f3ce26b32..1e89fdaf0eea 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -230,35 +230,46 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv,
 
 	ret = msm_gem_shrinker_init(ddev);
 	if (ret)
-		goto err_msm_uninit;
+		goto err_unbind;
 
 	msm_gem_thp_init(ddev);
 
 	if (priv->kms_init) {
 		ret = msm_drm_kms_init(dev, drv);
 		if (ret)
-			goto err_msm_uninit;
+			goto err_shrinker_cleanup;
 	}
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret)
-		goto err_msm_uninit;
+		goto err_kms_uninit;
 
 	ret = msm_debugfs_late_init(ddev);
 	if (ret)
-		goto err_msm_uninit;
+		goto err_unregister;
 
 	if (priv->kms_init)
 		msm_drm_kms_post_init(dev);
 
 	return 0;
 
-err_msm_uninit:
-	msm_drm_uninit(dev, gpu_ops);
-
-	return ret;
-
+err_unregister:
+	drm_dev_unregister(ddev);
+	if (priv->kms_init)
+		msm_drm_kms_unregister(dev);
+	msm_rd_debugfs_cleanup(priv);
+err_kms_uninit:
+	if (priv->kms_init)
+		msm_drm_kms_uninit(dev);
+err_shrinker_cleanup:
+	msm_gem_shrinker_cleanup(ddev);
+err_unbind:
+	if (gpu_ops)
+		gpu_ops->unbind(dev, dev, NULL);
+	else
+		component_unbind_all(dev, ddev);
 err_put_dev:
+	ddev->dev_private = NULL;
 	drm_dev_put(ddev);
 
 	return ret;
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..f3e39c3907a9 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -225,13 +225,23 @@ void msm_drm_kms_unregister(struct device *dev)
 	drm_atomic_helper_shutdown(ddev);
 }
 
+static void msm_drm_kms_destroy_event_threads(struct msm_kms *kms)
+{
+	int i;
+
+	for (i = 0; i < MAX_CRTCS; i++) {
+		if (kms->event_thread[i].worker)
+			kthread_destroy_worker(kms->event_thread[i].worker);
+		kms->event_thread[i].worker = NULL;
+	}
+}
+
 void msm_drm_kms_uninit(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct msm_drm_private *priv = platform_get_drvdata(pdev);
 	struct drm_device *ddev = priv->dev;
 	struct msm_kms *kms = priv->kms;
-	int i;
 
 	BUG_ON(!kms);
 
@@ -242,11 +252,7 @@ void msm_drm_kms_uninit(struct device *dev)
 
 	flush_workqueue(kms->wq);
 
-	/* clean up event worker threads */
-	for (i = 0; i < MAX_CRTCS; i++) {
-		if (kms->event_thread[i].worker)
-			kthread_destroy_worker(kms->event_thread[i].worker);
-	}
+	msm_drm_kms_destroy_event_threads(kms);
 
 	drm_kms_helper_poll_fini(ddev);
 
@@ -282,7 +288,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	ret = priv->kms_init(ddev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to load kms\n");
-		goto err_msm_uninit;
+		goto err_destroy_kms;
 	}
 
 	/* Enable normalization of plane zpos */
@@ -295,7 +301,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	ret = kms->funcs->hw_init(kms);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "kms hw init failed: %d\n", ret);
-		goto err_msm_uninit;
+		goto err_destroy_kms;
 	}
 
 	drm_helper_move_panel_connectors_to_head(ddev);
@@ -311,7 +317,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 			ret = PTR_ERR(ev_thread->worker);
 			DRM_DEV_ERROR(dev, "failed to create crtc_event kthread\n");
 			ev_thread->worker = NULL;
-			goto err_msm_uninit;
+			goto err_destroy_event_threads;
 		}
 
 		sched_set_fifo(ev_thread->worker->task);
@@ -320,7 +326,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	ret = drm_vblank_init(ddev, ddev->mode_config.num_crtc);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev, "failed to initialize vblank\n");
-		goto err_msm_uninit;
+		goto err_destroy_event_threads;
 	}
 
 	pm_runtime_get_sync(dev);
@@ -328,14 +334,20 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	pm_runtime_put_sync(dev);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev, "failed to install IRQ handler\n");
-		goto err_msm_uninit;
+		goto err_destroy_event_threads;
 	}
 
 	drm_mode_config_reset(ddev);
 
 	return 0;
 
-err_msm_uninit:
+err_destroy_event_threads:
+	msm_drm_kms_destroy_event_threads(kms);
+err_destroy_kms:
+	msm_disp_snapshot_destroy(ddev);
+	if (kms->funcs)
+		kms->funcs->destroy(kms);
+
 	return ret;
 }
 

-- 
2.47.3

