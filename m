Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5E606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mYiHOJx7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LbDTWc+F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD1610E684;
	Fri, 23 Oct 2026 15:32:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27C110E658
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:57 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6B2L2974551
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X0RAPtvLQwr0f4zYSkwfWymS1oxVdn0ZzLk5Jnrs+0g=; b=mYiHOJx7nxAPfLHn
 b7ASTqQEyOGZjEi9FepmOGL274DHViQKxhFSCy8GbcxMcZS1U6N+40dgRZUmu3Z0
 Lf9GcwmjuoKGIDY3IZjMefGu7NZl7Mh4r3KSnSLYjh2m99d3BCtKAtMSWwuJg2rq
 +DlnJe4ioW6hhQ0A5wp1jA+k3uJxdYewYdcKi6TVnWj4O0tVtD1YmshNvAU5C19V
 BF93yH4v9B4LvnV7vPtbHMsvAh+P3EVs/K3EoX3o/C/7nrhAe1+Fdlu5QQbFJBUc
 qcB6tV9y0lMO9sOjBeztGpNZQKiMsfEyDld7ruLxXinz47kFXQ+p29dIC207x5An
 fOKX6Q==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw4t9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:56 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-988be118d98so188606241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769516; x=1793374316;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X0RAPtvLQwr0f4zYSkwfWymS1oxVdn0ZzLk5Jnrs+0g=;
 b=LbDTWc+FSb+z7YWtgd1aXD95iTu4xBU313a+5qSTzz7jKBY5AI1SWtoR5n2EK8ynKW
 osTozrmfxYj+q50P4cAmYWX7DZaNmoB/rZn8C/oBIbvREyLeusZ8PTYHgbaP7lAR4SHf
 nBOaymeZKBQ4xGgy1Q++j8wgNb3hPdFyVYirNj2QF+q6Qjkv8JkFjdu+G5aRK+cTp+uD
 NuPLK2M0Fc4HWXY65gtgXYuB1jsYdZQksakztGObfTj5XkKWI3QdN9dglQMcJZZ9H+vb
 4meQR1sIKIKWQINICvG6sGTNlShciBch79ObCY/407ggCfpiwKErTGovyvJSfn5/hkEM
 EfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769516; x=1793374316;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X0RAPtvLQwr0f4zYSkwfWymS1oxVdn0ZzLk5Jnrs+0g=;
 b=kcv1x6Aph/cJ8v7lnMknMpHaijvq8G8b9OwMRBOMIc/xY4OCT8zE1TAlVqPFPFXoUX
 jiwZsFujzLCzPMDzZo0vrBiXiRDHx8+y8GPITVZqGzKs2og1eWBtirFoXq26zOGq/rFC
 ouLxU0G8J5i8X7PSO0VtrhyIxgBZjRvK2pyJ8/nrq8Qwmtsw5G2YfG+VB2u6MZV3eAeR
 uyTRMNvaa0eamf2/Nk5X2FIXn9IY+QrD8/fjMBqtWd6NHPrFzutAiMnwMYitbr0uMVVP
 AWKW0Rt8vMCN6SKnfC0cOOIq3Kqm7ZBNt57LYqdj5WyKGN2eNcF51rkCaHf7BR+TM0p6
 XRrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXWzXnHKSvWlai6zhuT7cahNFRq+VwrQYxc76q9FueQf7El2WoFjaw9NlXPaNRi6WK0OwfZjU/6lU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKHsKFtj8jWPONiT1/wCBNNKBQoVwt0AwwguB99SoDFNmnSVXJM
 utULcB7nvRbwxQhYHzQdcjmhgQIUzmQa4MKIIm96H7vGc7o8+3rYDigWlwy8w482H1cFAG7tcOA
 PJ2qID+gKiz/qGmcNy3MqAEl8HVF1lY0pF+WUpGZHgFEA0iy3jFjT0Nf/tjGuF9B85rjuh4Q=
X-Gm-Gg: AYBFou1w1SY8r8EEFj4N+A4NUlFNNuqpI2nHoteEgfCm1zpRa9VHQ1u30mukpxD/qqQ
 xfFt9ZqJD2VuQ47vSGDp164dQM6fl7y85m3xauHQcFIeMSomjIm6azAaQBai2AeNe0xs0kWZNBl
 O+ESVDSiyy255HQBasClLfyhrYCfN9tqyZAf941kIE3Xsgl/jXMWPGRYkbK/TXadAG8by57oTFJ
 1qSFeu7ISaQnaSxCC1faoyzVS0sOFmXMUE8HqOMubis7XxI/i+J70iAzJvt5a6D6IAL/g+DzrH5
 HnbeaVoHK9KBdo81afxI/3uJobuNpKOBL9xpgSz5SJlPjeyjUTkCmOgPGXXApXmpSM+x6brwq7v
 PvQp4j7L/CypyBVIYRHw3hz+hLBgqCjUCEw60m8gjfEakIOa0KEUo87IAPkZfKP3FIx6/jEwBxN
 LSwlnbSv1JFEv4
X-Received: by 2002:a05:6102:6445:b0:7cc:5c9d:7e07 with SMTP id
 ada2fe7eead31-7ccc333f2b9mr842406137.11.1792769516162; 
 Fri, 23 Oct 2026 08:31:56 -0700 (PDT)
X-Received: by 2002:a05:6102:6445:b0:7cc:5c9d:7e07 with SMTP id
 ada2fe7eead31-7ccc333f2b9mr842373137.11.1792769515588; 
 Fri, 23 Oct 2026 08:31:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:21 +0300
Subject: [PATCH v2 06/14] drm/msm: let the kms drivers clean up a failed
 kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-6-83727c122de7@oss.qualcomm.com>
References: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
In-Reply-To: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3336;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HoBk7ONYzI5BFZMtAgm7hFiVZaXXxP5N1D12n+PHNRw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233UKjB0AzguQYF20e8Xuq63PgYz6kHfXh5gE
 5kPH91raPaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt91AAKCRCLPIo+Aiko
 1X6mB/0bHqsjhDghFWjXfNU0zQc5MkIGyr/gkhtFldPT4yz9VXOSKp9Bi45NVW76zBAGw8SYl8E
 LZhfWnxdEXhD1/hXnvN/0kB/iqC5CYBT9CoE+ArNeokZBFGLsD95p+3+dXLqsLrUo2bh3Aqv72N
 F+alAWrDDcP3Ht0jATqtiJS2U09LleaU4jzM1PmJW/4+yMA2PoJ1Z/yeaAcctTujmnGK0i+e9rN
 Oj+ydwq7GmKVAPtE8L7qhlYkdYfEWjWizmgryPYMTlsdgNQVu4V83jCgqyvrSM/l8MbBjcWzqzi
 izqnB9e7PpvdV37vfcqtJQqDTXWUtaWE2jSTySSVxgiY39P8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: UhFfqtz3S8lDTMaSbJcnvSjb2M5rR_qk
X-Proofpoint-ORIG-GUID: UhFfqtz3S8lDTMaSbJcnvSjb2M5rR_qk
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb7dec cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=DqDluaqBKgvBNGcJzpYA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXyzdndeAnMTSb
 6yB2XuKIZJN6e9bJT7sGZacsPoeclkrnnjNii1pH0ZcuO1A5SLSzlSEk9kamTMWeMY/9HyInt8h
 1l0NFrQbLAOqHULmO9W1NTwi5foGzjE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXx6VAcKZYhkp3
 borHlXQkmq8sfVY6v630m4vhaK+r2kGdm6WT63+1bFKkw0W6VzlQbY+SJLcHXa+ErgMOjubC6PQ
 tqyLVSVbWoyuj/bEJimrnknZBYEbMzBlY+vPgr784+EEVsQIUdYs/x4r8+Gq+qpTY4lgGdAVReo
 yv9UqJCjeFaYrHwSXNEoqSq87AN6/BzyzkSt4uGLX2pPRon625Plz7d6S9qMpPuArFj6J+H0wQj
 Il6drbbfUF5CBF2spxzeS2Gp4dG39IGRNRPyTUceS/jlnhehJtVhFR8YHTeZ7njTXjuoDq3vkX5
 kgmRA0mlIa0iExSdTzLsAzWTQ8zT1/TPE7Sd4J7rT0YSGQESC4V9UcPaFJbbvz8BSpBn5FG1lsr
 Miy+d1ftZFChZXCuelpNPo4F+rGA/rxRU56t2Ycem0iLd7a5/zH5BgDqM5yusU9scAqGSQYkrMM
 2YP37zfzmICaHUqF/Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060
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

A failed priv->kms_init() or ->hw_init() is cleaned up by the ->destroy()
callback, which makes ->destroy() responsible for tearing down a KMS in
any state between "not initialised at all" and "fully initialised". The
kernel convention is the opposite: a function which fails undoes its own
steps, and the teardown only ever sees a fully set up object.

Let the kms drivers switch to that convention one at a time: skip
->destroy() after a failed kms_init() of a driver which sets
init_unwinds, and let the drivers fold their hardware setup into
kms_init() and drop ->hw_init(). Set up the mode config before calling
kms_init(), so that it is already in place for the hardware setup.

While at it, tear the snapshot worker down after the KMS, in the reverse
order of its setup. Nothing queues a snapshot until msm_drm_kms_init()
has succeeded, so no dump can be pending when the KMS goes away.

The flag and the optional ->hw_init() go away once all the drivers have
been converted.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_kms.c | 23 ++++++++++++++---------
 drivers/gpu/drm/msm/msm_kms.h |  3 +++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index a94d2888a21e..e4d61935a6df 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -283,12 +283,6 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 		return ret;
 	}
 
-	ret = priv->kms_init(ddev);
-	if (ret) {
-		DRM_DEV_ERROR(dev, "failed to load kms\n");
-		goto err_destroy_kms;
-	}
-
 	/* Enable normalization of plane zpos */
 	ddev->mode_config.normalize_zpos = true;
 
@@ -296,12 +290,22 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	ddev->mode_config.helper_private = &mode_config_helper_funcs;
 
 	kms->dev = ddev;
-	ret = kms->funcs->hw_init(kms);
+	ret = priv->kms_init(ddev);
 	if (ret) {
-		DRM_DEV_ERROR(dev, "kms hw init failed: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to load kms\n");
+		if (kms->init_unwinds)
+			goto err_destroy_snapshot;
 		goto err_destroy_kms;
 	}
 
+	if (kms->funcs->hw_init) {
+		ret = kms->funcs->hw_init(kms);
+		if (ret) {
+			DRM_DEV_ERROR(dev, "kms hw init failed: %d\n", ret);
+			goto err_destroy_kms;
+		}
+	}
+
 	drm_helper_move_panel_connectors_to_head(ddev);
 
 	drm_for_each_crtc(crtc, ddev) {
@@ -344,9 +348,10 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 err_destroy_event_threads:
 	msm_drm_kms_destroy_event_threads(kms);
 err_destroy_kms:
-	msm_disp_snapshot_destroy(ddev);
 	if (kms->funcs)
 		kms->funcs->destroy(kms);
+err_destroy_snapshot:
+	msm_disp_snapshot_destroy(ddev);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index ee98393b9855..2f097e23e2e9 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -149,6 +149,9 @@ struct msm_kms {
 	int irq;
 	bool irq_requested;
 
+	/* set by the kms drivers whose kms_init() undoes its own failures */
+	bool init_unwinds;
+
 	/* rate limit the snapshot capture to once per attach */
 	atomic_t fault_snapshot_capture;
 

-- 
2.47.3

