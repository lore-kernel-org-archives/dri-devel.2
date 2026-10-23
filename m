Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021AC606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B6BiMhq/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QKfQggi/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5299310E716;
	Fri, 23 Oct 2026 23:20:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964F810E701
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:08 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvBfa371942
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZAcouakyejRyGfq2Cqhm0mLaJYsny6pKnH0rzfdwlss=; b=B6BiMhq/hBnywIxV
 Qaory4HVBJSyQH18QJEnyxRknEv7Uw90iL2qCDcNcSF4SpxzoMlZbEOXNfixVEVi
 acYiH213IzGrzlCd7RHybJd6yBX60HpqAOyajblYg4AaDHjmw9gSvIQj4sMyOY3o
 k+nLg23Ay9SNk9/ZvtNrs+tLHvj7DSFrriQb19P8RvRZtaCuxWi4gM4KdKo0MOOs
 9OLscWvHdzaVFmoE/VJWgirijvMR21ORY2ibNaYMb0r3v4Oh4u4VFaEmkIrOhMEf
 3Em5qanNHuUT9FYYi9hmBSfsF2gzsaWVwYpIdcU4l79xSpDxpmTbQImqFUhfU4Y3
 CW9Jdw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas89bja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbf2fd504so263458585a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797607; x=1793402407;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZAcouakyejRyGfq2Cqhm0mLaJYsny6pKnH0rzfdwlss=;
 b=QKfQggi/MhFrJRaz4vHRtW6XYzBfBdmfjzuDUh+zp4QCqATVct79hH/bj11WqQiL1N
 RW602j8Fv8KB/1P1Mt0VPLvzlqZaSbkJcDJ2q4piI6WQSVIvKvtvb6jex4iu8/uQZYQ1
 1QBqMoTnu4IaVat+n0GnpPdwVSXIg5b2wdkYpLoSV9GRsRZ+yFpQTy/AFc+kHVzX81z2
 s0LJ9zJLW9aTfgCw2w0sh/LjIZYfFVJV08nkn+D/xxt2cY/2zwzYUAtuHAww8iQ/S1ym
 qixm4Q/lAPF/nolmKIhP5eXkqxS80BitqswAjvvEyctkmEhnUya6R+193AQ7YMPSZK3X
 /baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797607; x=1793402407;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZAcouakyejRyGfq2Cqhm0mLaJYsny6pKnH0rzfdwlss=;
 b=A15s9QxXtCgN65yZ22emT//zac8soI2+BiPHOziSlxVYrxdphOWph9VNxe+vOjX6Hu
 Vjr7dnU/sNXWc62sD0W+RtjLECS20HFgSa1ZfTkGrJFqGE/MSlZ549aXLjqg5idEUk2h
 Ndc0ciLmpFNJr+qJW0fNlSL61O7cZ+r4IzQNnMpuejwBb34MqdQ/XrZD2xzrL7OO1dcT
 8SfrXHNisKJBpcMu2ceBO/SwDvBmWMYr+c0DByxDOiwv0zcf7v1hLuEjdEDPOLy1JefV
 8AfYYv4GvhkbpuyFEO2q1/suESHdsNLathXvHvevKOJk8BGCUNwlcFJ6UlH9te9eZQtp
 T+1g==
X-Forwarded-Encrypted: i=1;
 AKwUvByfTH0UPIlBFFBs5c+p6KxZ1ufrk4xJ39l0rMp+bP4P/bVB9yd1K9c7U3WZAZFe9ZNZKdvuqANm8nM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJGzPLQ35R3VTCkfwYyaKxhiidMDYYfXF0oaR4FZ6TSvs1NRoXm
 A7PGzBhWxNjRX+J6FfMobSm4ZRc6amE7+u2tXXKoHZL818HArmaMFWX70QPxp+I5cDnT+goBXza
 4MKB/PCh9dcL1h/NQVRNTFEy7vlJLHVvO8XDub/9YMTkbaV7m5rF+8+LdC2gXUp309uaXp70=
X-Gm-Gg: AYBFou01+okXa+A3nwhKXxBmxgAiYbqsv0+yjf98I5xZP2nThwA0HjC1Ol8Qvsoq/es
 o/YwK9J7m4gzCqkDbYCTLUwUXJTcX5Nyr3ZBwYmseQQE5G0X1WC6P4eny+J3KtrnS14dJIhTXUp
 dbIH2Ri9/uhhqeNfECJTd3uzgFFeFcfD8wYIWqgIw7LZu4sCmgNmWE2dbIto1TErsaffOF3F83Z
 UuZOg1qVxUDegzQR/8IkP+MgmxCuB8DNsLLH8kreouX5qza15YpjaM4aKy583zr3AYBlCKLJiKl
 U1IbdbRQJNsKC2VGABsFzaKINKRjVbFTRzLAJ8PzEfE2EnrLC7ZfJ5GAr7W7S5jbKNJscnditIl
 VLxFc9NdOdj4fupFLYHYfZGdV/o/BLMeTEIr+p49iXUqE9guPS1OAHSyY4Uuj/W1GOui2EHnN7P
 fjWCAzcRTpNuef
X-Received: by 2002:a05:620a:40d5:b0:93b:d7a3:45d4 with SMTP id
 af79cd13be357-940ef9802e9mr88928185a.61.1792797606784; 
 Fri, 23 Oct 2026 16:20:06 -0700 (PDT)
X-Received: by 2002:a05:620a:40d5:b0:93b:d7a3:45d4 with SMTP id
 af79cd13be357-940ef9802e9mr88924085a.61.1792797606253; 
 Fri, 23 Oct 2026 16:20:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:36 +0300
Subject: [PATCH v3 03/14] drm/msm: unwind msm_drm_kms_init() on failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-3-66a30120a5ea@oss.qualcomm.com>
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5574;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=coiPc4C0940VKA04JsEvpFMf7jlgO3eT5zzOhxeuIrQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uPUU4eXC3ASovgu5IK7Gc7YHyELW8wTJ5BP
 a2Uei6hHgWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrjwAKCRCLPIo+Aiko
 1e7sB/9TcrMuiE+5XpRGqbSTd0g4q6l3AaYylDuvL2y6uUA33bFwulQQLYUHmOubzYsLa9TTVfz
 cYTx52lm2yaiNJFgb5ThcqMx9ogSpF9UKvet6wodD93NkHzJb5V2LfrO8VgM8gIvtsDMEQoC6br
 sYZHMGbTIRMDYdyHcKSFwZGf8AtZ2ulfeRYoLCbDNWtQF8zti58yen2MEO9RJ/E9asuQ5m+/j22
 3oqwgLuqiSq1n+klO+VqASpuBjfTh4uglzzccN8YGLSiTxZZBw7nAuHP1nTfgxaYbV2Qv+cEBLD
 cL9OtyxxL+sEcil6/vdnd5Orl0Fg06wVnHrHrqXyRgaN32nZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX4nrPME+5HoCU
 PzOwYlFOKQ4FKYadsMU7vO4bkG/xcuR6/0sMX7hMHgJxn7h/wQgDE7TT6839umqMDcCWjpH460d
 G5mlDc35Y+6crcUH05d+WqbvvM99cIg=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adbeba7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=_ChxW0iHWOZRcJAqfHkA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXxzorn9HdwbvU
 cv6Uq7JjePrEttkU4ZswKh8xAribm0ypF0XiGopcXpaNJ7PBOilyY/DpCm4yMUTYFazEieDMPW0
 vWMK4GvoS6NtZYQxn7BgVwa07ylQ4nNsD9BY9zsFH4pwbjNmJ41JXfRavjJXA6lSATNgqPoADpD
 D8XAMuGVvfq556GTvgpQfci4yWuXCsfz6eE0pUgg1NjVgyruD2M/LVXbEYp/qNPFqBPvx00Xx1R
 kVyf/uzMq5MXBenwCnpXGMVKEJGB7pyrBUNoteP/mi+8zSnPniWqnpPdAkxkg9MuO5RldlA6/m2
 0VNEWtCjIVVTFPyrgcEkgnD8fwVR+6ui0ERYVW14W7AEcU8I27qMx4gJjiaPV+NmAoLspcO2SC/
 YxuLd/nG2I/CTRvnpZ++b6lEz9MXkMbB0DgFESrsMIxUUuVTAuuNOrjPDKF0w08GNsoLRZxQQo8
 2RvegMbwTlkmPRW2MCg==
X-Proofpoint-GUID: RtwjY5X1nKExeyzwDK91Uhkv5vkbIN9w
X-Proofpoint-ORIG-GUID: RtwjY5X1nKExeyzwDK91Uhkv5vkbIN9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
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

