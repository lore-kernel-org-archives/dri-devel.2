Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9565606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OIZ/bgLC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=amXl8WTq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B46610E6B6;
	Fri, 27 Nov 2026 19:45:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB83E10E429
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:03 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJB0GD3134358
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o+PD9nsg7NQ3bIbbLofFaflTGFjytKKE+xHErDhRfCg=; b=OIZ/bgLC3bikMgqC
 TWbphQ+kl3Y/O43vIKc8lRgYzvAATamWGR/1l0n2NxuhswbM1ATCLRviActAGUHK
 +3JVZKkJ2f4/7MNduKelWMGuPHvGZd/1Tc4v4yfc8YlBNXb3WFnT2TtQQYBHR0Ca
 Q8auKU72+JnCVlBLioqtppjsmwRwCoT13eTaPJRHV+xJU2DxQvbc72/RI11C6ZvB
 FaWTIw9wO83/eICBwX6JdNpq2GEzaIdbyUu3GnxDJ5uaT6KToEzjzHAr3suoq/X0
 gnZjFOH131+NARv2+RQynkKSsfmolIq2qUuD5pw9rRCHHeJdhym7JDo8ZGl/U/ce
 3XiJGA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gatrtu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f37c94ceeso1472988585a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808702; x=1796413502;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o+PD9nsg7NQ3bIbbLofFaflTGFjytKKE+xHErDhRfCg=;
 b=amXl8WTqwAxH1MpsEAnxlpM0uCX14pyhPTGUn2nh7+s6Gnmg/IBw+vkazLYETnnbkU
 +SP0mqPdzkbWav3OVA5JfGKUhJCRSj1u5bHzU65tbCHdjxPNJ5dvGUpxo8r9eVCMEPiY
 Iu4HNHzFKX5nth5NWpdNN2xrxF2tFTbOrqmUy2B9XW8sBUF7lrwHpQGypGJalnIFulxF
 X0hWF5gSwBm4hs+Msu8iP0Y0UM1vegyQn1HiDRHYiaY9E8eTW9se3WNV8/ZI5e6u7g7/
 FExxM6YW4Ng0GKJRUHZm3+lv30lMr59Ok4RdfjeSG07DiZgbAfItk9cPOc1Al+BrG2U2
 VwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808702; x=1796413502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o+PD9nsg7NQ3bIbbLofFaflTGFjytKKE+xHErDhRfCg=;
 b=XB75IhkkKswVZVdP8OLymGS9JmuIqkxg6EzKQycaKmimnV8cp2LJmLFXr9tXHfecUX
 W3kmOMe8QB8AhgBb0IaOXSdoMJb/4b079dYO0HkQR0OEsEFc/qKn0OT4DEXx0w7ZP55w
 mkINh2MLxeUsDus4v730hTuQ8WFHF5/znLuQotZaTjF6OY3Tdi8FgpixYxhGR7NdXVTv
 hyWqTP2hecQv0lMh8jiMBkmgIj0jxFKGJzL+gD6uGSjU5CISGC2krk/Bgstn7aY97hQc
 DiW3n2lMdO3R7qYRu/FiOdibDcRIuq1Z9RZZ03FO84KYUUd1q4GeJZaCRnRO+QSvJ5a3
 yS8A==
X-Forwarded-Encrypted: i=1;
 AL+hErGylmihciYzs1FKrFzd29B5esVK8K18d6ygH4+8bK59UBPO/Lrc/DjmHUfSJqIf1qfJ14tnKMdt700=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+vKdpfIHKrObUz9100BJ0Jrt73uUHQ/NW/HMYXGkQTfeYeE737
 ZqYUjfRjIkdBjkJyBjHYDeE8h2GVwSe6DSsRbbxf6ZsMPPPzqrpKWN7Jtp3TY2ZGm/q7clIoUhw
 6px6I7qV/rAsL0YswaZQMb75m3klyMVNcmQ6TWjKZjIP8a+b98LtNyq50qFIPJ/1X3l1Oi/s=
X-Gm-Gg: AZFdTZcoEzXC0qbIlix2rXki5PGqiuOrgMtGjIB2+1L7z9AFe/Md9x03ab2DmDADd2F
 QDb10b7HBbfhDyi8T8o80pHRQ1166UfVx/R1t7L9QnUnzKNzPhzdqoL+h+ctHiDp64WU0OzXd0z
 nUxpBlQMvW7iTtJV3FQXrMG0K3tynCmCWaN8FsG030efFglhUKwyayvwnmWnzpg6RRiyHyEVrtG
 5HlP8IZoAbHY/eXNPNkeYqGwwLt/QdqDmlcgumOvf+odSDNAe33sNsYA19oUJb8eT/eRVZwRieV
 0J+JYwB74EjSDtGPI0dPMIut2vb/MKZ7SHL1WwMCeL7kBo4G90uYRWk+JoRFGg/0rGK9V6c+JUi
 9RXLjcnv3vdkFWJHRx8skIHxZQl4uP3BCkjQ/0ov6aG3sZAIZhsZMSTlc5sm3b2xpvUv4LWmyTu
 v7YQ8VXCrRoheVSHZBONbkolBLX7h9lPX60mN55Bsxayvi1e9mwYGDzjHrDxL8ng==
X-Received: by 2002:a05:620a:4149:b0:949:8fcb:5cc2 with SMTP id
 af79cd13be357-949b357258emr4500838485a.12.1795808702116; 
 Fri, 27 Nov 2026 11:45:02 -0800 (PST)
X-Received: by 2002:a05:620a:4149:b0:949:8fcb:5cc2 with SMTP id
 af79cd13be357-949b357258emr4500835285a.12.1795808701661; 
 Fri, 27 Nov 2026 11:45:01 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:45:00 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:19 +0200
Subject: [PATCH v4 06/14] drm/msm: let the kms drivers clean up a failed
 kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-6-242b0a3f8e47@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3357;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/7dzbRzST7ZLot2nSYDYj6bDx6tl5/9Oqc6IS0KWVMQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2ehAupMjv9xb02YgbXVDPMIisf4lmpshqi8
 cxqU1aLewCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndngAKCRCLPIo+Aiko
 1bOuCACvk6ZN8lZm8Hlvkcv7gWN2XZnZ8SRQbNsU5Xwws4/JpPNjIa3EbWX+omF33XsfaDmVSio
 MEm7woHVqG5kpKziQabVplYskqhwpZSXoLmMjmb6ZJW4IYg4acd588m+myOjEUSSZj1mjKkxNQh
 NRWoxE/5wGXZ4rh+XlqEW2NBnHBP/zGubf4k35xaW5qXjSjvpGY90hgRdY9hydLDhVF1OfGIn3F
 676tl4JJVoC9t5S+WabmoRR7xrjQKIyNqvXk/TgbMp4RuSazJtVnpOFoA8/zR6bfiTviHYs7mm1
 LjHvY6bhLJphFRePAR6ZxOxGHP2ar6TgsP+8GQjjj8EfHUvW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: nzbHjaLGFGexalJVWH31hNGobxUPNBX-
X-Proofpoint-GUID: nzbHjaLGFGexalJVWH31hNGobxUPNBX-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX04+o9ndquv/6
 G2QnOG6qSB2uLBetAtjrfUdh82aIqLmmz2CwTmjausNGBWdxdb0jC2sDPV7F4trEMK6S3sVyLCt
 jdgOvDPDsa79m5um0BY2HsAh9PZuK7erk+Iv68cOPK1kTUcsHCJ9ssD+smGjssf9Bllxz8sn3xg
 tGkOv+lnPSMBmkPoGS74ZQhZUopBnFCzZGVsfIzAuv7c15WGN8fTPoDVSlnbHUliy9O6whWUei8
 vjKtmJvyo0aTHBomQYgvmEsKIgLHgQsJdXy8J4c8kMwJUAcmDDVMkN7w7cGSjgZWVd8ekt1CjOv
 kL3NYf5LcZkkhfq8va6u76SAuxR0KFXYrxYEOYCckQEs3nN7L+vnI1T6Yil9CJErOW5U1hpVxCY
 0vMfzV2tRjC+6tRavKYlJaV4p0vQ7HlJkr9PnS1iP35t5JZvAyZBp2dZsV+74NMut8LH0VxHn/q
 7+jup4JPlPeKxkCDl2w==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b09ddbe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=DqDluaqBKgvBNGcJzpYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX1qVDSXN5/e3C
 0+4zfMQRi1PdCEVWS0GFxToD5oIdxdpVtcFMdsapewRB6gxB0sTPp48lgPTKwrmuJkimx/0r5T0
 axKZb/WunCdwZiQe1XpFWs/bzRkUX5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
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

While at it, tear the snapshot worker down before the KMS on the error
path as well, matching the order of msm_drm_kms_uninit(). Nothing queues
a snapshot until msm_drm_kms_init() has succeeded, so no dump can be
pending either way, but keeping both teardown paths in the same order is
less surprising.

The flag and the optional ->hw_init() go away once all the drivers have
been converted.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_kms.c | 25 +++++++++++++++++--------
 drivers/gpu/drm/msm/msm_kms.h |  3 +++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index a94d2888a21e..da9ba8583420 100644
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
@@ -349,6 +353,11 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 		kms->funcs->destroy(kms);
 
 	return ret;
+
+err_destroy_snapshot:
+	msm_disp_snapshot_destroy(ddev);
+
+	return ret;
 }
 
 int msm_kms_pm_prepare(struct device *dev)
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

