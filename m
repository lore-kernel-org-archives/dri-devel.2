Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8D0CD5BC8
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 10:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF9610E361;
	Sun, 24 May 2026 10:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VGMSB7ub";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="es0Sacq8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E937E10E358
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:55 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64NNPHqA3039040
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TB7URF+14neWSZzv3TOvuIj1hBLgUA7+iXkCJmncifE=; b=VGMSB7ubvkAT2fFd
 qcG4OGDcNzPLyat9WBkR7/mX228M1pYuntxRAGrAJ02sVr0gVWg7pQeZnCcXIgNx
 6JdB1AC+L/sLZt/L1YAz61ugZWYRTUOtrE8gvLSD2jTTgiHPIUVPFNyWCudKhdRI
 E5BsDuFayNMbFod85xoyAoXkT0SzzBBUZTn6QV0+u+3NCd7jRBLq+pS/tNWGAJqi
 1kZ0fqVzbzWh/i5JEd/BTmgVQfqYWU1CmiV6lpYqmRkwM8iZkdd7ODE16zsXEZFp
 DI6tERRuj9+7/eytnz5lvxhp+6iRREySTVnla7p+BhwalpNl0Ao2sWb4JmIS3pub
 HJ5KhA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3txk0q7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:54 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-575427e5360so7872693e0c.1
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779618834; x=1780223634;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TB7URF+14neWSZzv3TOvuIj1hBLgUA7+iXkCJmncifE=;
 b=es0Sacq84bVrFoq2w30hbyLGAPftWhRtHsW8zfbGyOGUeCTchreSsbjsqjqCRMtSBo
 I70/Ol4I+7a4wBFi394YRIEGWCGkGpskHPc7hXhliSKkIJwbtCK8WjNXPZuHilcG/Mnm
 kQV810zNghsNJ4p6E/QP6wzrO+QVRZol+DSizJkk2vfoK+Vrg5siWBFtH/GgclKXsQNi
 VfSmuKKeSw8unpmLGelQjScbIlqz5dHe4y0Y+6y34fLlcUWRN4ox2QSg7oOWZz2vS5Ao
 eIOPtQhx/q1A1q8hvwRiwjBw5w1rPxKusHeJwAw6DC5YMCi2Ih5/xa0T+eJ3pRDyNkcw
 zZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779618834; x=1780223634;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TB7URF+14neWSZzv3TOvuIj1hBLgUA7+iXkCJmncifE=;
 b=RQzUf3yD4NhpAJ7NfakxfKBJeGiHo5/QTZar4IKSdN+7HmUUZShUQDZjGhO3oZy63A
 n20HbkpWFpKuonmfyZtq/tDGxMZSwrMREVU3JvxJ7egtERnzqClYmE9nQkwPL70MdAhC
 tV7Rwosu9Z6/IFxbMR94stasHWJqScXhPIowlRGXSIDTnHC1h+1Tj0psktuHGXFewKzK
 rNr8VDwbH3JkgDIxVZGWFZUqiR54u61eT3kzfUH4ndsetW8KqeV9E7QzIEjlwhXVhJdb
 Iha0IZGx1q5Z6g6wkHbvAfIvkcC6rDNrQ7one0V8WOMilMaPPW3csJ2agqZBAd55W2Yq
 PFGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ90+Ic35FsTnyIOjpPhb+YfoSFOPz8IRM7Ow4lRZIBhjspn9+mbob/yRdDXBOtMw+QNP0qjZhKzTNs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0F+gmg5bZTlf7ukdzxr4Dut8Lv067vikg+qDw5zMxYM7s90DG
 NGs10aah04xGkY3JSDezep0S61Dqvwfrlum5pp+itfb4L6X6JyGXoUyyOu1fdUX82X6FKR3jiyN
 vii93+AyTh19RzaNRxcXx+K4qNzvjAuqV3EZ+FT2/LirJWg11seqLGswzlxnvYA8ksxFaJh4=
X-Gm-Gg: Acq92OEK4uMUIxUi4yyyi3G08pfvHfFP6CvBYR5ho+E1wYY/qcsupWTiZMd0lOFiGcR
 kFCVo5vHbnv+DwMA9T4/WmxeI2/j7fyXiNtfQy3gQT6KC8zgvNGL1F8vJL4e38CZ+3faGHUOhfV
 eUlc+7Ui4jb4M1uGn/F6EGvh8cXQ/oZq/1mbjgoTvcUZzaE0IuRxkVIi5qko9Iteb/XbLwLHx/k
 jhCdiLF7aVLXw3N7EIQxYexalgyz9TxYxM7e4DBGqxtu3Jcm8avbNok6HVwDDShk1/sTiDSWU3a
 XcGDj2PbXdM67vvIjkjAUdWFIuGIAQMR0Gs8bHEQrIMMH0uSvRxmwiTWTWcdEx5ixhlA0dla84U
 IHuWFDb+EB9RpSCxmCMpGwwpQ06Srff8QbNmZTGraMTG7dAO0iYEoqFJ3YZOM4AbQ5RsUgUx7cV
 UeMIJ1wz0fO5EPQi14o+hDKJ8Lp2Et0kkPF6U=
X-Received: by 2002:a05:6102:32d5:b0:65a:fee5:cf20 with SMTP id
 ada2fe7eead31-67c77a162ccmr5224002137.11.1779618834306; 
 Sun, 24 May 2026 03:33:54 -0700 (PDT)
X-Received: by 2002:a05:6102:32d5:b0:65a:fee5:cf20 with SMTP id
 ada2fe7eead31-67c77a162ccmr5223986137.11.1779618833880; 
 Sun, 24 May 2026 03:33:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cba880sm1816148e87.32.2026.05.24.03.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:33:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 24 May 2026 13:33:37 +0300
Subject: [PATCH v6 09/10] drm/msm/dp: turn link_ready into plugged
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-hpd-refactor-v6-9-cf3ab488dd7b@oss.qualcomm.com>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11362;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ub7kHvaTdp6oYgxq2bkDcUbPSdDHAbn5Cl++E4B/7mw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqEtP959XWR548FW1MS+zfNsWKUYY09py6AJtuP
 WjbMQyRhu2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahLT/QAKCRCLPIo+Aiko
 1REkB/97BLTx1u2rp376UdoaU8xUmMby1vC2cD0VjbzORIXMnLchVwWvaMwQZrlcFIpF44CLY8Y
 6JNNB/E1VyvLf6e+n+3he9S/PeA5GX6bdPtFOcaAdP+CC5UPYbFTOp2qbvkCGTe3bcRTjBY/kJm
 IWiSrMvUNQhHce7mU1uk9AM2OOZ/NO2P76PeMPMBDBqMnbJeK3nziOKtWJjbE8drjxY41pfIPpA
 pUUmnaft6UCGk8tGzVpBoKsN6kkb8ZNMU1IS5Jvk/gHv0gZy61pa2vWzz/Y3yBZwHtLZlu8/4XX
 /XMHtQuEzvD7m+pT92SQtH0zcCnqQ4dP5i/imEQBzvOoU/Lo
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfX9/nCVy2jH3gs
 COYe9HHzEs8/+UH55bBkmYGkp5z6LotlXIcMr+E8O5EGbWfEyclweIbFom+nT6CG8nq8yNXY6kX
 btTIJVXbhmufNWjiFDhp0KqIc29jHObG0bHaapZrQL4eH7xuxx+68s1Q4OEXOVwJBsFGcas4M/z
 9V0wiT82IAvZDcTOtxIQKng/bAC//n71XkpgTJKJKwYTd//sGY++KqvkIkwi+2jrjgtoOO1Jgqn
 hh8ZVTmza9Gzi/q5goYvPkrMirN1Jw6d2GsVW+pY/YrZ6vvFLd8kniVp80o3KDz19/59xa7nTwy
 sOwKuMemwx3x9En5mkL8mRLAMHrC9a2KAtn2sODscU7fOBxEFw0d9HH2eU/apndSyXVfFkWdCE/
 JV/2WVo/gwj2+8I6yUi0jTVwjshfoRbjyza7QNKxMqh8p0eLUs49pXo+yvSUXrx81Uo3RBP6N59
 RxXdrGUOze+Y+61wNKA==
X-Proofpoint-GUID: 7ZdX4Pxm3iH5O7TqaLF2UdhF26fLk14o
X-Proofpoint-ORIG-GUID: 7ZdX4Pxm3iH5O7TqaLF2UdhF26fLk14o
X-Authority-Analysis: v=2.4 cv=MetcfZ/f c=1 sm=1 tr=0 ts=6a12d413 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=L2aY2k0-BtRO-WKZelwA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240107
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

Tracking when the DP link is ready isn't that useful from the driver
point of view. It doesn't provide a direct information if the device
should be suspended, etc. Replace it with the 'plugged' boolean, which
is set when the driver knows that there is DPRX plugged.

Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 93 ++++++++++++++++++++++---------------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 -
 drivers/gpu/drm/msm/dp/dp_drm.c     | 41 ++--------------
 3 files changed, 60 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index fc41ac38556d..5fa745b486f5 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -53,6 +53,9 @@ struct msm_dp_display_private {
 	bool phy_initialized;
 	bool audio_supported;
 
+	struct mutex plugged_lock;
+	bool plugged;
+
 	struct drm_device *drm_dev;
 
 	struct drm_dp_aux *aux;
@@ -285,8 +288,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 						 dp->panel->dpcd,
 						 dp->panel->downstream_ports);
 
-	dp->msm_dp_display.link_ready = true;
-
 	dp->msm_dp_display.psr_supported = dp->panel->psr_cap.version && psr_enabled;
 
 	dp->audio_supported = info->has_audio;
@@ -304,7 +305,16 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	return rc;
 }
 
-static void msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
+/**
+ * msm_dp_display_host_phy_init() - start up DP PHY
+ * @dp: main display data structure
+ *
+ * Prepare DP PHY for the AUX transactions to succeed.
+ *
+ * Returns: true if this call has initliazed the PHY and false if the PHY has
+ * already been setup beforehand.
+ */
+static bool msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
 {
 	drm_dbg_dp(dp->drm_dev, "type=%d core_init=%d phy_init=%d\n",
 		dp->msm_dp_display.connector_type, dp->core_initialized,
@@ -313,7 +323,10 @@ static void msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
 	if (!dp->phy_initialized) {
 		msm_dp_ctrl_phy_init(dp->ctrl);
 		dp->phy_initialized = true;
+		return true;
 	}
+
+	return false;
 }
 
 static void msm_dp_display_host_phy_exit(struct msm_dp_display_private *dp)
@@ -367,14 +380,6 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
 	u32 sink_request = dp->link->sink_request;
 
 	drm_dbg_dp(dp->drm_dev, "%d\n", sink_request);
-	if (!dp->msm_dp_display.link_ready) {
-		if (sink_request & DP_LINK_STATUS_UPDATED) {
-			drm_dbg_dp(dp->drm_dev, "Disconnected sink_request: %d\n",
-							sink_request);
-			DRM_ERROR("Disconnected, no DP_LINK_STATUS_UPDATED\n");
-			return -EINVAL;
-		}
-	}
 
 	msm_dp_ctrl_handle_sink_request(dp->ctrl);
 
@@ -393,8 +398,7 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	if (dp->msm_dp_display.link_ready)
-		return 0;
+	guard(mutex)(&dp->plugged_lock);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret) {
@@ -407,18 +411,14 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 	msm_dp_display_host_phy_init(dp);
 
 	ret = msm_dp_display_process_hpd_high(dp);
-	if (ret) {	/* link train failed */
-		dp->msm_dp_display.link_ready = false;
-		msm_dp_aux_enable_xfers(dp->aux, false);
-		pm_runtime_put_sync(&pdev->dev);
-	}
 
 	drm_dbg_dp(dp->drm_dev, "After, type=%d sink_count=%d\n",
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	/* uevent will complete connection part */
-	return 0;
+	dp->plugged = true;
+
+	return ret;
 };
 
 static void msm_dp_display_handle_plugged_change(struct msm_dp *msm_dp_display,
@@ -447,7 +447,8 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	if (!dp->msm_dp_display.link_ready)
+	guard(mutex)(&dp->plugged_lock);
+	if (!dp->plugged)
 		return 0;
 
 	/* triggered by irq_hdp with sink_count = 0 */
@@ -464,8 +465,6 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 						 dp->panel->dpcd,
 						 dp->panel->downstream_ports);
 
-	dp->msm_dp_display.link_ready = false;
-
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
@@ -473,8 +472,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	/* uevent will complete disconnection part */
-	pm_runtime_put_sync(&pdev->dev);
+	if (dp->plugged) {
+		pm_runtime_put_sync(&pdev->dev);
+		dp->plugged = false;
+	}
+
 	return 0;
 }
 
@@ -823,42 +825,49 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	struct msm_dp_display_private *priv;
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	struct drm_dp_desc desc;
+	bool phy_deinit;
 	int ret;
 
 	dp = to_dp_bridge(bridge)->msm_dp_display;
 
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	if (!dp->link_ready)
-		return status;
-
+	guard(mutex)(&priv->plugged_lock);
 	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
 		return status;
 	}
 
+	phy_deinit = msm_dp_display_host_phy_init(priv);
+
 	msm_dp_aux_enable_xfers(priv->aux, true);
 
 	ret = msm_dp_aux_is_link_connected(priv->aux);
-	if (!ret) {
+	DRM_DEBUG_DP("aux link status: %x\n", ret);
+	if (!priv->plugged && !ret) {
 		DRM_DEBUG_DP("aux not connected\n");
+		priv->plugged = false;
 		goto end;
 	}
 
 	ret = drm_dp_read_dpcd_caps(priv->aux, dpcd);
 	if (ret) {
 		DRM_DEBUG_DP("failed to read caps\n");
+		priv->plugged = false;
 		goto end;
 	}
 
 	ret = drm_dp_read_desc(priv->aux, &desc, drm_dp_is_branch(dpcd));
 	if (ret) {
 		DRM_DEBUG_DP("failed to read desc\n");
+		priv->plugged = false;
 		goto end;
 	}
 
 	status = connector_status_connected;
+	priv->plugged = true;
+
 	if (drm_dp_read_sink_count_cap(connector, dpcd, &desc)) {
 		int sink_count = drm_dp_read_sink_count(priv->aux);
 
@@ -869,7 +878,19 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	}
 
 end:
-	pm_runtime_put_sync(&dp->pdev->dev);
+	/*
+	 * If we detected the DPRX, leave the controller on so that it doesn't
+	 * loose the state.
+	 */
+	if (!priv->plugged) {
+		if (phy_deinit) {
+			msm_dp_aux_enable_xfers(priv->aux, false);
+			msm_dp_display_host_phy_exit(priv);
+		}
+
+		pm_runtime_put_sync(&dp->pdev->dev);
+	}
+
 	return status;
 }
 
@@ -1127,6 +1148,8 @@ static int msm_dp_display_probe(struct platform_device *pdev)
 		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
 	dp->hpd_isr_status = 0;
 
+	mutex_init(&dp->plugged_lock);
+
 	rc = msm_dp_display_get_io(dp);
 	if (rc)
 		return rc;
@@ -1357,7 +1380,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	}
 
-	if (dp->link_ready && !dp->power_on) {
+	if (!dp->power_on) {
 		msm_dp_display_host_phy_init(msm_dp_display);
 		force_link_train = true;
 	}
@@ -1404,9 +1427,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 	if (dp->is_edp)
 		msm_dp_hpd_unplug_handle(msm_dp_display);
 
-	if (!dp->link_ready)
-		drm_dbg_dp(dp->drm_dev, "type=%d is disconnected\n", dp->connector_type);
-
 	msm_dp_display_disable(msm_dp_display);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
@@ -1504,9 +1524,8 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 
 	hpd_link_status = msm_dp_aux_is_link_connected(dp->aux);
 
-	drm_dbg_dp(dp->drm_dev, "type=%d link hpd_link_status=0x%x, link_ready=%d, status=%d\n",
-		   msm_dp_display->connector_type, hpd_link_status,
-		   msm_dp_display->link_ready, status);
+	drm_dbg_dp(dp->drm_dev, "type=%d link hpd_link_status=0x%x, status=%d\n",
+		   msm_dp_display->connector_type, hpd_link_status, status);
 
 	if (status == connector_status_connected) {
 		if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index d2d3d61eb0b0..0b65e16c790d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -17,7 +17,6 @@ struct msm_dp {
 	struct drm_connector *connector;
 	struct drm_bridge *next_bridge;
 	struct drm_bridge *bridge;
-	bool link_ready;
 	bool audio_enabled;
 	bool power_on;
 	unsigned int connector_type;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 528c9a40477f..b659d22f5f28 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -15,36 +15,6 @@
 #include "dp_audio.h"
 #include "dp_drm.h"
 
-static int msm_dp_bridge_atomic_check(struct drm_bridge *bridge,
-			    struct drm_bridge_state *bridge_state,
-			    struct drm_crtc_state *crtc_state,
-			    struct drm_connector_state *conn_state)
-{
-	struct msm_dp *dp;
-
-	dp = to_dp_bridge(bridge)->msm_dp_display;
-
-	drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
-		str_true_false(dp->link_ready));
-
-	/*
-	 * There is no protection in the DRM framework to check if the display
-	 * pipeline has been already disabled before trying to disable it again.
-	 * Hence if the sink is unplugged, the pipeline gets disabled, but the
-	 * crtc->active is still true. Any attempt to set the mode or manually
-	 * disable this encoder will result in the crash.
-	 *
-	 * TODO: add support for telling the DRM subsystem that the pipeline is
-	 * disabled by the hardware and thus all access to it should be forbidden.
-	 * After that this piece of code can be removed.
-	 */
-	if (bridge->ops & DRM_BRIDGE_OP_HPD)
-		return (dp->link_ready) ? 0 : -ENOTCONN;
-
-	return 0;
-}
-
-
 /**
  * msm_dp_bridge_get_modes - callback to add drm modes via drm_mode_probed_add()
  * @bridge: Poiner to drm bridge
@@ -62,12 +32,10 @@ static int msm_dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connect
 	dp = to_dp_bridge(bridge)->msm_dp_display;
 
 	/* pluggable case assumes EDID is read when HPD */
-	if (dp->link_ready) {
-		rc = msm_dp_display_get_modes(dp);
-		if (rc <= 0) {
-			DRM_ERROR("failed to get DP sink modes, rc=%d\n", rc);
-			return rc;
-		}
+	rc = msm_dp_display_get_modes(dp);
+	if (rc <= 0) {
+		DRM_ERROR("failed to get DP sink modes, rc=%d\n", rc);
+		return rc;
 	} else {
 		drm_dbg_dp(connector->dev, "No sink connected\n");
 	}
@@ -92,7 +60,6 @@ static const struct drm_bridge_funcs msm_dp_bridge_ops = {
 	.mode_valid   = msm_dp_bridge_mode_valid,
 	.get_modes    = msm_dp_bridge_get_modes,
 	.detect       = msm_dp_bridge_detect,
-	.atomic_check = msm_dp_bridge_atomic_check,
 	.hpd_enable   = msm_dp_bridge_hpd_enable,
 	.hpd_disable  = msm_dp_bridge_hpd_disable,
 	.hpd_notify   = msm_dp_bridge_hpd_notify,

-- 
2.47.3

