Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F71107BCD1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AB610EC6F;
	Sat, 14 Mar 2026 01:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I/ctSXwH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bvqaF3vS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D7810ECCB
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DNH37B112260
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8tg/xGuicw7U9Xav9pczQObs2YXJZYVzFJvZGTJOhik=; b=I/ctSXwH52K3mw2U
 MO548GHScOUbbjltbKyP8aaPmm8pYZ6Wc7BCE7DyH1BMCjewRp5osSdAleD6fsJD
 PqmJ4bBOxLzT5+GeObKc8y6JntnM2mFZQgCtQiI2Wcvj7iHJZMw38NRWQHwZbqcz
 fg4pq2TjZt1XgcjHGU96dzRdv0GB8/pMTFcvErBT7qJ3ohBYOouyQtKOwXqHzoKZ
 QfSGhTkBQEGiDV/tQQ+4r6B4KUJqo4ybHEHXFJnTqPelbkYkPj4lLFh+aG2mZl9N
 CKDOzcpCqi56c3h2nUJJpoRjmHlzLjcZTAJnHl8v+eu/FHjDhvk20ch1GaPo9jK5
 M8Xj5g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh5mahe2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89a108d17d2so197235486d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773450569; x=1774055369;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8tg/xGuicw7U9Xav9pczQObs2YXJZYVzFJvZGTJOhik=;
 b=bvqaF3vSB5GGDtMdkRp+Kwycp2NThoLJrg1nTlOE+mTEm3UOtulUq33UL0l8lnWjL/
 1jzIKuHJBZYs/CvlIPBNXIKVDTrP6VZBTP73hLLK/xLMn7q76LDsagw3wF+6cC2v13rF
 lkQJ/hu7LCyN+Zey8hUcNZQZBA8Kv/HUJ+kgjEHv1b2d7DY/Jf609FaCN2QQmdg6M37l
 Qpb/LljxKTCIgj6N8HrCDOxDGzFpky2ruR4//gsvdQBDHphZx0ydgjsgbPUfyl0F+/7t
 lqoURGFvNEIbBXxZLERx/AQrleVlQEVQZM1mW1zOVvAeDc7YOYwuTvRzvTdUIy3+rXrv
 1ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450569; x=1774055369;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8tg/xGuicw7U9Xav9pczQObs2YXJZYVzFJvZGTJOhik=;
 b=JWCVIqSU8FylnipVFJW7Q+QE96/b4w6iXyn499Y4MuHFH8xRVLumf26sTgjCqbRBdY
 FD7Bmk7+hGudS7/y5XKAqYokwDrELH7mdYp1qEdQsijcuHuDFlj1JJpPT4PMVBRM3jIl
 1FDhOlEjv8OMsaJfeQAQiodupQS3qmTpwLv5JR3Fb+oY81C0W4n01/K/ZyH8c2lOaczr
 wkrbKiJwAVWh2N2Eg5aLXzNZXAZRWK68TJVO+tlKPHwuS0S0PHM1MA8CyCiLGoTdpAn7
 kk9sjT9LDXF6xc/YwIOVkqB3xVg7iKhIJDzsuftHHPAo9uKzFp0BUh1IkZlw4JRPjivh
 J7Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz1hivhLEWN5bPfeulEBylakEvSH2a7w/U6kSXT/NxuDFkrlVWjDrgWsQGJ163KxZYXiwPFVJfKYg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGdtVuP2QhhO2bwgfuIIYfivfwwplycCS2EukBu109NujsUjZo
 GSCCA6EDUk8/gxpbogyfnz/dHbnDeUgGObyUpl+FfitZuELYzdWZDZyuntX9eZHOvjRtiBwjTnT
 Q5i4S6V1fl+IUahhL+67+YzZZlVvMwza5JRVDGsNM8gDN4qayr1O6/yyycL2fJ/eEcNekekw=
X-Gm-Gg: ATEYQzyh42VC7vsCgd3YQ4thMx9Abzys0LhQWvra6NVanmMBNfkcqz7i+1snnw4DBE/
 XM/SWl7zMLH3+HYXfrTwbLlbhoykrLVn7QeCFSAwdLz6y937qx7MIL+d8yNR63jYUTyelilxsIH
 i7rELqPIE3AUzhBUn/VDEVbJPPE1RDSisxbHWuyfZyRAbCMKJndKIFsErdCwMkgRWHBMDViUEL7
 PCLDdawfrnBJ62OZTIlmUN4AUpsER9IZU5CbigeWHX7ubtEetI4+6xnITJJVRtO1dHg3Yuv2Lbh
 bawCoWbhG29Tgi34AhQoBzopLrmHi8qSeMW2+UKiC0A1l5dHgcIUJWlxKA4rkTOaJ4jPdu5xwMh
 lVD7faLbf9NIBHTLuAG7TcIYIc0z2JWQMCaIp8Pr+JPbhSqtLCgHwnM5oHmrQXs2k34PVULwRxx
 vKDlh+66vShrBqbgrrHyU2ATxOKJj4yruBwlQ=
X-Received: by 2002:a05:620a:4609:b0:8cd:8a55:510d with SMTP id
 af79cd13be357-8cdb5b1b198mr785837885a.48.1773450568649; 
 Fri, 13 Mar 2026 18:09:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4609:b0:8cd:8a55:510d with SMTP id
 af79cd13be357-8cdb5b1b198mr785835385a.48.1773450568179; 
 Fri, 13 Mar 2026 18:09:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366b22sm1806805e87.77.2026.03.13.18.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:09:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 03:09:09 +0200
Subject: [PATCH v5 05/10] drm/msm/dp: Drop EV_USER_NOTIFICATION
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-hpd-refactor-v5-5-0c8450737d64@oss.qualcomm.com>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
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
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4138;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vX+57P9cyOcJ2Ge82Wk30SNt2ZHf9zxIx/x8h+QULh8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptLUz4IAmlxbS1UTnKvwkZ4YZHxl9HswZRItXb
 bBeZtxAb8qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabS1MwAKCRCLPIo+Aiko
 1TsmB/9cwJSdIlXYS4OWflFP0DNWpVn7iX4Ula8PJ9ALfCCocThDLOj4TvaYaLwUvCq5KXFwWwJ
 OhwGdUJQ1k0PyIJcZt5fNhXctUp4g0qDvxghT7mcQnZ7hGrgs5TB00zgE1l3xq96CcdujiX5j0z
 RJ54lDHtzpKfmujGOgjl7CBvgMOUqurCXl1YQHu+JxqDmB14WE73vOndqw5fNjU0ziIm8XV9qHX
 zR/nO9hsWQgeiTmVEzVUfSocnVUtsnxmaXSr44TqKKDF8yt01kZpcD7OgOYNlWmXBhiV+FHZtMe
 lhZ/r3pWTA4aMPdn91DzvEVrfwKqne1mhNZ1ai5nGxAnZSar
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: MvBrm9MuoOKK2ISw8EQ68LNMIFOc4Y5U
X-Proofpoint-GUID: MvBrm9MuoOKK2ISw8EQ68LNMIFOc4Y5U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwNiBTYWx0ZWRfX4wpMuyHKRWbg
 R6SFnu/tni1YHk1qjYyR5XeLhGIulsfBW2GpVhzjxBiUDIhPtNHRp+R51aSjSgXvZFX4LTtP7Se
 02/o0gO4m6nH5dj4+zdBZ12YztrTs7iifWCFLwgUop60gwCbZQ/zUb3TqSmcTq5JUPxRh9225YW
 kGhVjrZX970hMEaJLLO/gIwTZeFSxxPXoeJtuNjhU8vSgpEgAB/kEl4jeZ0kwSy0CeSK8byJtVv
 xA9+eDWzK0T2upj2tPlxeLCeuhAXEMhwyiKpgEIBX7gTeg8jNc+8NiMTxecRjcpXkOo9+NjrkJC
 VH7xV1u4i2XvjKyVjRIzGnFUfzgYx9ZU4DuE2BCrRWLbODyg+FYa79J1XZ06Lg6KMQGDo8B8qrx
 Ib88BaG3cgGE4Enw9jQIcL0GSsilyR/noVpcxX0vB3QOPyxZC59HSerWTWKMfn4n408kc7/u+Xb
 jmeu3otg0H/b5lJXmlQ==
X-Authority-Analysis: v=2.4 cv=S6TUAYsP c=1 sm=1 tr=0 ts=69b4b549 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=gW5k9mFOS1cgrKxYKbgA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140006
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

From: Jessica Zhang <jesszhan0024@gmail.com>

Currently, we queue an event for signalling HPD connect/disconnect. This
can mean a delay in plug/unplug handling and notifying DRM core when a
hotplug happens.

Drop EV_USER_NOTIFICATION and signal the IRQ event as part of hotplug
handling.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 28 ++++++++--------------------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  2 ++
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e7b1ed5491c4..05c292e27126 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -58,7 +58,6 @@ enum {
 	EV_HPD_PLUG_INT,
 	EV_IRQ_HPD_INT,
 	EV_HPD_UNPLUG_INT,
-	EV_USER_NOTIFICATION,
 };
 
 #define EVENT_TIMEOUT	(HZ/10)	/* 100ms */
@@ -343,17 +342,6 @@ static const struct component_ops msm_dp_display_comp_ops = {
 	.unbind = msm_dp_display_unbind,
 };
 
-static void msm_dp_display_send_hpd_event(struct msm_dp *msm_dp_display)
-{
-	struct msm_dp_display_private *dp;
-	struct drm_connector *connector;
-
-	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
-
-	connector = dp->msm_dp_display.connector;
-	drm_helper_hpd_irq_event(connector->dev);
-}
-
 static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *dp,
 					    bool hpd)
 {
@@ -377,7 +365,11 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
 
 	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
 			dp->msm_dp_display.connector_type, hpd);
-	msm_dp_display_send_hpd_event(&dp->msm_dp_display);
+
+	drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
+			      hpd ?
+			      connector_status_connected :
+			      connector_status_disconnected);
 
 	return 0;
 }
@@ -437,7 +429,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
-	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
+	msm_dp_display_send_hpd_notification(dp, true);
 
 end:
 	return rc;
@@ -506,7 +498,7 @@ static int msm_dp_display_notify_disconnect(struct device *dev)
 {
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
 
-	msm_dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
+	msm_dp_display_send_hpd_notification(dp, false);
 
 	return 0;
 }
@@ -527,7 +519,7 @@ static int msm_dp_display_handle_port_status_changed(struct msm_dp_display_priva
 		drm_dbg_dp(dp->drm_dev, "sink count is zero, nothing to do\n");
 		if (dp->hpd_state != ST_DISCONNECTED) {
 			dp->hpd_state = ST_DISCONNECT_PENDING;
-			msm_dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
+			msm_dp_display_send_hpd_notification(dp, false);
 		}
 	} else {
 		if (dp->hpd_state == ST_DISCONNECTED) {
@@ -1121,10 +1113,6 @@ static int hpd_event_thread(void *data)
 		case EV_IRQ_HPD_INT:
 			msm_dp_irq_hpd_handle(msm_dp_priv, todo->data);
 			break;
-		case EV_USER_NOTIFICATION:
-			msm_dp_display_send_hpd_notification(msm_dp_priv,
-						todo->data);
-			break;
 		default:
 			break;
 		}
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index cc6e2cab36e9..60094061c102 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -16,6 +16,7 @@ struct msm_dp {
 	struct platform_device *pdev;
 	struct drm_connector *connector;
 	struct drm_bridge *next_bridge;
+	struct drm_bridge *bridge;
 	bool link_ready;
 	bool audio_enabled;
 	bool power_on;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index e4622c85fb66..f935093c4df4 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -340,6 +340,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 		}
 	}
 
+	msm_dp_display->bridge = bridge;
+
 	return 0;
 }
 

-- 
2.47.3

