Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E8606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m8XKVsEb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IaMStWpj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A052F10E6A5;
	Fri, 23 Oct 2026 15:32:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 756D710E677
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6B2K2974551
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5NpktZAYKvmRIXCSHEgS8BrkSWuOnrvqUCUENaXQblg=; b=m8XKVsEb+9dh4fnG
 RXcrquT259+z+ocon0xm7VF+/ElVxo8HCrdy0EQNQ0hK2ZzEAqMHspPGx5IY50Mb
 DSHpOUoOUGHqKKULI4duG/amlDj/AEBI9tuQLRrUXzn+uEk5l1jGE0pBmkN+f5yR
 7R/fZwQNEHhVL9PM9p7kxs7RDfePtaXQiH6nnznSAQugp7v6hMIbzjWHSq3a2aFy
 CItjNO4Fxq3wWmqHvMUQre85iHoGYLsv14bC/XcNYQvCORwe6VmL2Qpdf93NEt0r
 6hrbdNkRYsdGWOSTr3gquFMtI8vQuiV6TDW7zXZ7f6bJAL8LD+07Riha5NU75VAg
 1fo/sQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw4t8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:49 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bf634a101fso979609137.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769509; x=1793374309;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5NpktZAYKvmRIXCSHEgS8BrkSWuOnrvqUCUENaXQblg=;
 b=IaMStWpj276SeJM3+zNVms34T44AJkzRF8HlMU+FMZT+P6+D0+CQcspHH1lNXoqBz6
 0h4BSVncYgb6yquhHfXj+/92WzC/V82sm/iz7iCY+6oAz3DtMVAn1NShZBDdKpi9vLBH
 UKYv7ZJ4YT87srDM3pij5Jfz6c7g+lr3B/tMU8fpc8L8t1qCoGEMyy4TxP8yrFvZM0rJ
 AwOeo8fOPNfh2SvOdccCC6w8fipYQpuTJW2G6MUtZSdyMH9Gxy/uUuXhP7keDUJsAOUh
 u3v5GPig6dEAe5htSga6uAgJ3P6qkrJFJlFm1rv60vMy1PM/SabOUCBP7uftS5+LR99m
 gp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769509; x=1793374309;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5NpktZAYKvmRIXCSHEgS8BrkSWuOnrvqUCUENaXQblg=;
 b=f2y4Rc/m7wd8EqjCukrJMXQWVUkn+OAYSVNdRhkbq/5qPhLB7LfcWXLmhDj5x0a0xl
 TwvHz9GJnMPM6Da/lv+wzolf3QXL4xX4wgesE9JoWhgp2KRwhEMGqs0hnXq5P5wjJLzt
 bM9H1PdqaD5GT9XExEPLISkAfl6O6yIU8z2RMji5VvgMJ0fhxUZ3opvkLDKh2ea5KAWX
 jz/pOCrvueLcpEjVrkY1lTvynkUshz7PFoYIE5h6lG6xLlWT+wC7uTLSx1lIu2jmfCvi
 A+pHpWh6SqEX31KhAxh0zM7F1u2FgEp8lPn2uEVb2EvTMxdV7oHhpxKA5q0Yxm8FcUKE
 4XLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzErh+ZM/SuJd2sbrWHF6e4tDOeOxHHchFmYQ3Lsihk493lHI9eQZEIOMNhNHCATwUhFZMmXoEI640=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLf1twR4GzFvkxSBNT/DxnGYUqwodkNA+V24kZHCXwcRon9tlx
 fxWaYeC3roUp1O9G6MYSwI+KceqdADRdyWi4k0LdQRkFXK8FbQU25Pj2mczHTFjL61+qj2T/vuT
 6fGnZJPbolIyK4xAVqzWqyGtr7BkwmJSURV4JG4Zu2ssIKkw278x4sLO2eyzErlOr044loek=
X-Gm-Gg: AYBFou1YPrsG823L+hykn1LwpB3tprKEz359YlsCV/1mSQGjx2texm4qgpIh+qic67d
 aLO4I4GjAsfgAbRcWDk65VXI+mRuhFe2CxY1e1UMFfty8ow5zedTgfSo1jM5bfS/mkgaZddYypT
 JUYBs+U66Md/tO6/eZOFU47yHosPRCB5ej4xm6JuCXrV1/jRDZ1NHEblChNMP0NI4MDTcmMVO9L
 I5YKhIKnxkzuD5ViUKTdF/xS/z4HF/ocYF7ibyKKOgSe4ksOSWkTx3e/LHo8Zuh5jRmnzBi9CUB
 tn/k+NZuqI4Uga+nsyelPGEc4Dnk/JC8cAy/NB+3glOwfz61EsEhZ3Frg2Xq5SklQnthIi5NO6n
 Eiu3eutj27nfKB8ytQSvY441oxTO7b6KRLRqb0/G7SwQI6S3Jik89POiPUxCM6J75yU+pf1owcB
 M+06BcEwIktzel
X-Received: by 2002:a05:6102:689a:b0:7c1:8aa5:36c8 with SMTP id
 ada2fe7eead31-7ccc34d7213mr1222467137.36.1792769508587; 
 Fri, 23 Oct 2026 08:31:48 -0700 (PDT)
X-Received: by 2002:a05:6102:689a:b0:7c1:8aa5:36c8 with SMTP id
 ada2fe7eead31-7ccc34d7213mr1222444137.36.1792769508026; 
 Fri, 23 Oct 2026 08:31:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:18 +0300
Subject: [PATCH v2 03/14] drm/msm: unwind msm_drm_kms_init() on failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-3-83727c122de7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5574;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DsciqjUQUAepO/wMlEzWnFIrkDITaW1wbhoSQkjRRgA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233RR98+M8x1GCyQXFt1bY+cjezemfhNe5buV
 hg28ZWILQuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt90QAKCRCLPIo+Aiko
 1UJVB/0fojKOQ/dWFfXoDvkkdQPsTaXYpUQFiQXB/xhv4A8EXn1AwvVIos2gWqi/LWe2kMOD8QV
 PAZDG3CbbIMpWQhDoSI1MYOxHsr3iJ6EylI75M+869lD2hoOGhcHXF1VYvbDA4A7ehiD3qx/OZS
 ab88k0vA8m/pX77AVUA7Uml6AVwx85xMlnKXDAn/uSI+hFSTru4/cBy3jxB9R+hgBMUUm+ShIQ4
 6RmUHfHQrAis1gajSvGFml/3s7FIsyxFPk7hCX7xK1g4aqVytBU3EM6I9N4E2zoQT3/B/7kb5Wq
 MgU6oLdy5kUk+LgvN/PXru+xLh5SvDuacvymECXSrAEL1xNY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: hYukeyvRihmw4FzBONx_SFXUkFaUR9mI
X-Proofpoint-ORIG-GUID: hYukeyvRihmw4FzBONx_SFXUkFaUR9mI
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb7de5 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=_ChxW0iHWOZRcJAqfHkA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX0WiIG7n6xs1Q
 5rtFdP/219USv1OOmw0dUdfcZJbOYrSoRr40/L/pXLieE3DE/UPIpHkKPLNofZLNNDqxm0t+EUC
 55m038Y8mOUm7Sk1FV2w+vrTEnzMS5U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX2lyuMcQCgJBd
 ydVYoxd87AkYSGcdSRAxFZqouwlmIuB/D0ZapUwLlsNpxI5jefr9qi9ui15H/9SMyFcfAyUf+hp
 Th2TmqYku85wHt6LgXmaJS+dgoMWQKugI22SX0zDIRkC1Vn1ISBM+c/no8YrSIjqQLqv6KY7z29
 /HJ/XwW3w57e3CeJI+2dHtRpzY/KpZnjmFiYvIy6PAweDGF7D7EorqrubxK7VowmKdOrLE6+pf7
 NuSSDkZpmXK/YvQ3/y7a6b6LM9dOQrW00L7DfLldkHRTzl45bPMZ+gJmUU5ulOGPP47Lavnscgv
 QEhKZ6meUtZcjFpYSdxnQNrKSG1+++cdqarNQwKwUSdGIHZDzkOyWtgPiIfonAHPa85PNLZkeL1
 khY/408UxhPBYtD8WawT24ogrmCt3Gglq9uJkiRt4yFwG+einnVRWtf9UShqeXSQczZKuZWOF7K
 M08/m8QVbAd47f2WUwA==
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
index d157d227566a..6b24f353de7c 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -181,35 +181,46 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv,
 
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

