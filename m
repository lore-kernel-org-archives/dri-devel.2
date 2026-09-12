Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280F9C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C4C10E70D;
	Sat, 12 Sep 2026 12:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="odbHMnLB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bVMBKYEt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13C110E707
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:32 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBe5Bq3759770
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fom6VPNFv+zfCScGSH9gH/TJ+nxhdKVXDPLYwY2IORM=; b=odbHMnLBY1lHaDjq
 07RMtATDAqsWnH/VlLe/IUtSd0wJhtuxnTYaIe7ejwdvbvjrrVxZQj0Tli6jIV/g
 KIE721bOIYXo6AVUiE/PQ2Myj0n6YdY1rU4g1L2qwNkQs/go4cN53fvetRyHtHqR
 dHXnwj5J/DhIiycPo8gfhvSi8Cm1l+RK6tkw1h7ydlcNAda36QqNt944srzGGJ5e
 dt/sFP66rb8SiWhhOzgUTXIONo+L0US93ehDJceGVwo+iduC6SEz8JUqtmJp+rZq
 eZtD6Ih91YPTajkuNJ+deiPvejTkbm6N8lZLdYE6/hd/NcmChKaavTWuho2ilVup
 bWjtjg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c8ybk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:32 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-79285c98038so1447638137.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789217311; x=1789822111;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fom6VPNFv+zfCScGSH9gH/TJ+nxhdKVXDPLYwY2IORM=;
 b=bVMBKYEtWXN7BvNqi1v4PhCKw5Yn3drnPQRiOtKTw58ZrkoD7lM57z1JJMG5DsEcFB
 c3R20atBx0CrYvb296eGKNjHi+X4/EUiatMHDb2AGerm4H2tWklSymPOPqqlE5LGAo2x
 GqjwG9K/Mgj2rftLH6sQCXqxZ9TWSjNmMmIHtBJ+VD3tcYZwHd0hLmCidvgxBkz6I8Gg
 3cQDNqhzCw4sS8pf6aLh0sieFdm3CDuc3/pb3sS5nZXGtzCH+kM4Ib1aAuXL81S+iczO
 P2Z3qhdnN14f9w/E1dgdAfFYwwP3655LPohA8Vd4cj9mTdrOfOw4YbtFNGE6D0joC6dz
 7DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217311; x=1789822111;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fom6VPNFv+zfCScGSH9gH/TJ+nxhdKVXDPLYwY2IORM=;
 b=MaBQy8JciuhxinwwbgR9eP8Xa6HkkEDjMzZ52SlZ3+hBVS7rxJ0QChyj8gqdqaF6F+
 kpE8xtFWECAbDBnspns1dnPwi8d5vL7rP4bEtLuzSUd203EM6j5TAYbsmFPGtNBF8N8J
 cjCnrhgaL963leyjY8yJMrjwy9NHUSN30rH4pykX8bP2vlDoDwsJ1DjZmzqs6gu9VuUQ
 fQ+xX2/txSWm3/OGmpFRpZYOQzh3997GnIQFXUn/W1AOKJtIF1SafQ59ur8aO0WH6LgS
 2EfXW6LBKzoeo2UmplIsBJGUmo0SwZZiWKCQubYmZ4CQXvDdSyFdB5FI6PHfUeDIiIZ6
 3oFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByFeiPh08LWt19CqnnQsB5c1fL5iNVIL1FS1/ayKyCbdtKjn+ZK3XmuS9Q6Iu0tqrEDPCrbHuiHEXQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ktPa2KgHTtqiKZeSrnb0BOmAnLSZLZacBmXJLRStNbmLd/dejP
 DjYz7fJG61Ja4+orndpEHDDIm/nkjfqTRKl9Py2i6jjOo6XSYSgEwMJ/Tf6JMiKvYI4EIqnbVO2
 HFuewOJtkHJOixp1rYrtLtK7LeqEqLB0GTiadByUXRuO81tMV4iqq0LwqoRWx+hdxBzpJgB8=
X-Gm-Gg: AYBFou3gwZ97DNN+LQnR+lse+2Mb2p2c5MXsgN8IKoA1WsPuYahaE49XnwkdueJM7iL
 0yOy8HjNWZnPXUyDxXmW6nkx1lSITYdz2xvk5t0M8a+8i86neKqgQfckIfWklbH87Gw86kg2UZC
 3dkG4S0xdM2tafNNet8jegj8LBxN7i8gvC/+ebmzsafXo+ickYg0E8WAxCW9n36cGhuwDzF9N3+
 DsVqANiidRmQi9cMPQOu2yse85avAlfquhawUIATEizhyyaEB5lzFU1x8JznB+P2TxcPRaElZnG
 G1iHalHn+Sm2A8qJTrE6SsGBaSMJmd3x75tP0PuwA8CocGO0qvDqJKSOxgqn2t002m4eDFM/cSY
 Iwofs0SvpwrIiLxoxw0EKI07ybbJPddBpGYNimSXMMnapfy6PAS8ZIiKw3lRTv7Ec3r5b+CC2WV
 KLfFkJtDtDJdl1
X-Received: by 2002:a05:6102:524a:b0:794:d445:bc2b with SMTP id
 ada2fe7eead31-795abdea367mr1987707137.13.1789217311461; 
 Sat, 12 Sep 2026 05:48:31 -0700 (PDT)
X-Received: by 2002:a05:6102:524a:b0:794:d445:bc2b with SMTP id
 ada2fe7eead31-795abdea367mr1987692137.13.1789217311052; 
 Sat, 12 Sep 2026 05:48:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5af37a4eesm8825701fa.34.2026.09.12.05.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:48:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 15:48:23 +0300
Subject: [PATCH v3 3/8] drm/msm: unwind msm_drm_kms_init() on failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-fd-kms-fix-smmu-v3-3-a7ddc6fe2032@oss.qualcomm.com>
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=B0Ov3Ba0etJAVBf0pjyCAO0OwkOHjmreEqnlFJFY7wg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqpUoX6z++179jcgihzVdhoDvznApSa7Yi2fxEj
 TXhIxGcA1GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqVKFwAKCRCLPIo+Aiko
 1csBCACdTalb8vsJlE0T9l62d0tbWRLt9uyl9jK/+WzEAaJ5Mby6G1adoguqtNS+RkktK/ULuJ8
 r5GuXIRao/XZmq7Uq3TEOe8hk8Cgu6wBfThHCiAenbr6EEtFe1K3l15m+hsFlSNoZhJVvvCLxqM
 xvcLQN8L82MyrJWaDvyXMjJ1gLZijJmMLDKlDtVod8KFObPpo7y01nLUjpbIKtUIHWplTAZLlfU
 67HCz3AaOuvPXNScXmeQ85Nr6fZoSR4RpcxBwRY3aOxWrg/k4LWWtaZwy2bjqYa/BbdcUR5KmfJ
 /sdsBEF3pyYetG1enFQC3vY3As9cBW5es+Jo2PAH0vUIVHlh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX7lDj9nQF/aTJ
 LuoE97LdRgkXXPck14VpxaxIa1DWglWV84blCxZ5jsKsIcbsD5n5Gylq1Khq58kQb0K6U8IEHL2
 B4EqcbOSXO5XmvBTJtn6D9fYw8ips1A=
X-Proofpoint-GUID: VPzpZonzcYaZDQ9orzKhbAPN-eiwfiBT
X-Authority-Analysis: v=2.4 cv=BdZNQbt2 c=1 sm=1 tr=0 ts=6aa54a20 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=_ChxW0iHWOZRcJAqfHkA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: VPzpZonzcYaZDQ9orzKhbAPN-eiwfiBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX1Z3x+mWhVH5O
 Z3Kd+Qlj99b+90Sqfp0bElJL48wKArauzrLfOACNdgjSxGeLa/UWznnBSe3gQvr4XtxMbi5CFwu
 rCNoN6MIT31gCyTtO89tk5O1SiEK7mbcWV7hPJ+XKZ+y+huhjVA21ARqGnP5UTAMaeW7/Od/3Bs
 Wvsxo7tOXoxwptw3nIdmqySBWC3RBEI771ODn1OxCGWB8PvbEnQ4ZxZtCRdFMMVAHxYN7NBC0sc
 KwSZosoOaJ88tGhQykG8nWWL35UtRO3I9rKn/4RRoHL+9nqx1aVC+GSsOBrNdCA3QK9vLZwudV5
 54zoPXNnlQkUVZak43ymeT0wnqx1oa+u0oq4cjjrYjHeZ6m8u2+wKd9btHt+sOqQ3UAgrUjJSIU
 vlKwRAZTumpF5BoJB98QhQ6QXWOlDmPL7ftWU7E2307qNxlJOpPiUJTsT0vAnmcdicaFKxg/gi2
 7xLFATSF0Jv3euoZhYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120184
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
 drivers/gpu/drm/msm/msm_drv.c | 27 +++++++++++++++++++++------
 drivers/gpu/drm/msm/msm_kms.c | 36 ++++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index db1b655dd055..c842321c9069 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -159,29 +159,44 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv,
 
 	ret = msm_gem_shrinker_init(ddev);
 	if (ret)
-		goto err_msm_uninit;
+		goto err_unbind;
 
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
+	ddev->dev_private = NULL;
+	drm_dev_put(ddev);
 
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

