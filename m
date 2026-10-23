Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84512606A335
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ao/ptJg5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L8Uqbt8r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBAF010E723;
	Fri, 23 Oct 2026 23:20:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCBC10E746
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLv009877207
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X0RAPtvLQwr0f4zYSkwfWymS1oxVdn0ZzLk5Jnrs+0g=; b=Ao/ptJg59NS90RVm
 IGmrpKzIwqaXNdqe+TSdzd7jaqz0A0fCndBOYYCyoedLyy4Bb+Hn8etARNyCVZje
 gKXLLTKipqKSqDFQfA3dNMXvgXZBQtuHvcXDXm48J49Olv0QMYdoss9vZmrEXvUh
 KgfBqJK4AzojPMdH+zN0VBiZY9CszrYqlOattt4DLIvcjkJeoHOjHevYpnlXrQv7
 FixPtNTIH+OEHSmFNCXDpK9MMHx5bV8PKtwUQA872tl2xRi6yYniKqHiWNhse6w3
 Bu6yHpj7ffVRhhhG64aDbs+wbwuQFOpPY78tpScAbDLAbkoiG2v3f+G6XjA8soOh
 KJJOvQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr68v07-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f559420f3so143574385a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797617; x=1793402417;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X0RAPtvLQwr0f4zYSkwfWymS1oxVdn0ZzLk5Jnrs+0g=;
 b=L8Uqbt8rGBB0t0IHAPxExxyfpk7ddkWv8sElysSBuridpwHwpJ2Yd1NmGgB4t6pcBW
 C4XP+NQwOrK52ZDy4oS7CNwgcuqUHYeqXVhYe9HsAr5FF/h/WJhDbE0TGwS8nip2CqVL
 iVJDZtKLM6S0OAryrDli3tJhh6KJkVQVw2rBKaX019OTy1itKW8E5HiAqFgNscb/T1jf
 UdpCvsz5n9mMhX+MM9wDKy4o53XbD4clu7rHL105h2HJ9juh4v0Te/nnE4RwrV/NLf/C
 ZQXqklImt/HPZ+scFUSVEOI/gj2tz6qWkRpo5lY6TmBgj5Vpz1tonrqNBrZjc+w8fMOz
 9vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797617; x=1793402417;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X0RAPtvLQwr0f4zYSkwfWymS1oxVdn0ZzLk5Jnrs+0g=;
 b=g7+oG93vRI2nfIlmz2sc9wxeDkYJXVQjDI4yRQsaYMmQ2wlFgTThhvg5G5/CovPOF8
 E0jfPfcG4CWAI79yUFVVVKegat9KbN7vn+/YUW1M02xijMcf9HkAxUayar6xXCMiDIIZ
 oDIX/mCXyUGyrrVcaJpP0Kh66lwIb4/es+Xk+JlL1AFILbTvldRGC01jMSFbzqA6f/sq
 A91PRKVkBEqqT/YdkzzO3cm8zNPqJ1gXZ+lMIkVszIgxShI8j2RsHyop1qdaKqzXf26v
 oflLk5xxHBZvYIDcsgMdq5VGAurXWXXeTdhRswb1g2172kpkUq1b3qMbEYI+1qadXSr/
 ziUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQrt6pkIU6rnD/0pS31K0xD325Q8GDQKdpHqQaZmlEa/85O92XwErjHUUHv3Cu10mRpL9U/otbkjo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLq9xG2MpDUBNdI0hM3T5zhgC96d3Qjvju3qdkJFh9na2re5z33
 ivo1Q4I8IF/pB7OnTkiUevPsZ5Qc36q5yi7aPzF/bctKcGL/0SrFTiiaW29/zfN2fGFfUte5hcl
 Um++ghd0iJJNpTPO8AhLltYNPfrFjwYmDA/pBhyNNpwBmIBSav2L7XgYxolUkPt9HT2eUQpI=
X-Gm-Gg: AYBFou0mk0z0gTGAynVpPX4o9L0PoqG+2xzRvzFHKRiJdVvAdmpL4w2F0V+vPA5uOnw
 DBLa9QadkzlJNf3v7NmeaX+chJA597g8uAJsukeRI26nnJNvKs6JXk6qrU9c5KDCxQYseEIiJfB
 FyQEXZ/PkxQUvUvlm8Rt6CfZ82CXT2LBJRV9EETtbCdodJgGa6sPwJuISqYf6uuo5ubA3EoBkXQ
 OTFwne1sRb+2yteESLuy6iLN8wa4PubdeVfA6lYA6zoZ0R3qWYhbjrb0dxkXWc80+vnwALz+ZKH
 0Us7IDTDMnr+dRFtQLZfEnZD2c2SrO/+V3TLl2w3Fdm1ALscMNMe9aEwwA1nxKoerDaYHXPotrX
 xAYwnu6kP/uRrLdUnbORkNiOCkMB5s1njyaELBDk16YQiDYgYUBsS4BIZjvczmzTHKld3WWX75H
 g/m7n/XHubzrkd
X-Received: by 2002:a05:620a:468c:b0:939:2d77:d6a8 with SMTP id
 af79cd13be357-940ef938c5dmr85203885a.34.1792797617006; 
 Fri, 23 Oct 2026 16:20:17 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:939:2d77:d6a8 with SMTP id
 af79cd13be357-940ef938c5dmr85200485a.34.1792797616467; 
 Fri, 23 Oct 2026 16:20:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:39 +0300
Subject: [PATCH v3 06/14] drm/msm: let the kms drivers clean up a failed
 kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-6-66a30120a5ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3336;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HoBk7ONYzI5BFZMtAgm7hFiVZaXXxP5N1D12n+PHNRw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uSLsuuUeBLROB8GPizxh79t6pB0V13gYz3j
 y7Imxa6t16JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrkgAKCRCLPIo+Aiko
 1ZS9B/9nFMwfcym2Tmvvdg3HlSJfRlePWnMrdzeap8J9fhto+rlTogLlnWUK6mvz50PPrYOa8PK
 IFgsGCPkTf9DEBYPtnWx+cQ9yPj7pCqGE3S/8yrmnqH+EhuiOe5v/2/E3gUs8/01xfoi3gUqeNR
 mamI0zzk7PuXvrp2M4BHHo44KknDOMBaHwa+LcqnauENGZHeWcIEMqwFaUwxROLK954gnWEVDQ8
 2QKXPbWYbIyl2slK2NofcrteCJrxJX0yfwErqPAQ7+vx03z1/3ECR2QI2UUoigrBMMyBs1CpU6W
 DTQtEFMG+wMrWmvtiCtf466BlqAVVRXy4LpP2DftoE44WMjh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6adbebb2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=DqDluaqBKgvBNGcJzpYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX7pSuFPkAB3FU
 PsdVzSV4+6ZNXzaoHAjkjyK+70XV9ZwIT/IMJ6DNGtkqAbceY0kb9iajFWXGVIhj1hWnIsqiEKp
 Yw9iGpg/jporFTC6qxTOsUNlUjJkhGcY7JDevriIEmCXnxqG7gSMuea4sMy+0LXjwaqpprvz2gv
 p6nVs9u94d7P5xi+wpUTlXlcT7UotEX1RcCMEcgrJC51fTeNZqZHTYzpfDVp8gPa4aBQpXVOuE1
 8qLSi2abg4yXF3c79lXMEuBEb88D/1UEHFeUkYylraA8XMzX+5e/6ySNoI6y75bLoeaw9qVMD3O
 V3AtvUo0JMghkoxoa0szYjsPGiu+1zs6NDP0BA+a31BuaE0js0cz7fpy6MfKEM0W1mALed4mbCF
 N+ApXo+Ac+9YR7zWK21XtHgszmPJ0hEEFNFrzo5Tro6KY49mUiqYtT/vm7tOQraKe51dcLNO23A
 ofVmg0sOZE1iREqDPrg==
X-Proofpoint-ORIG-GUID: N8kZUj_kxUYbxG3ZzhysHLiwO5axepLG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX0HEY+Il9CVQy
 FLs56ANvqrDl0lWZd3R46SCVAQUqsgFr7C7/nCTchkedr+fWO4TcNFp2OJzcB9IpgrKFHNQwxaH
 KINwDwXcET7XQsrtXjg1rJmCAGBEuXk=
X-Proofpoint-GUID: N8kZUj_kxUYbxG3ZzhysHLiwO5axepLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
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

