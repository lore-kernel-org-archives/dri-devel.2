Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A1CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 10:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935C510E103;
	Sun, 24 May 2026 10:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eRTO5095";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MJjPb54y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525C510E353
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:49 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64O35O9m2511185
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l8o6cIS01j0pOwxkyeeRqH0JHndoNuqGw7yx7pJcTtI=; b=eRTO5095bF0iAnpM
 bWvKPvKLmFlRlAaIbQAKnfEb0o/PL6NH41Z/A/qNx62Zp541S49MY3e+QB2026M7
 Sc4t7n0zoacI6CIZGzwpf8vcCUFPtYDG0tbTBn9a2b0r2iJIAHMcU2ZWnccF9Ru7
 HGNS0XmHPGBB8RpmSkQOzEtiwbrDLwD/8dnh5MIScQmaRnUxXFndz+fBXiKyr6kP
 9K0Tl8oIGya5WK6vBb6VlBT74Zsa5WzKog/q5CUz7zBFp3G5EXAFyt1xSX2jZUcm
 TgSopM9Earypu2386ZfSDnR7LD6RpMWWeZio2kb+a8ecU/XD6KV2xIFvOcd+jqcu
 +rtSyQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9jt6u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:48 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-577c69d3f04so9661161e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779618828; x=1780223628;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l8o6cIS01j0pOwxkyeeRqH0JHndoNuqGw7yx7pJcTtI=;
 b=MJjPb54ydxFy2nROyvw4O5U6r7tX3qGnL+/ukCrAL5ohBWA+vHCNvX3MWvWzZLjNt/
 l49QarT2UiGzd7ZY1zEJvhPh4YUf0XKPt6+7i3umWzL+iAG5l/x4ebrJ5DITxCOTiqF3
 8oxvdDZ4mP5IyT2EhTeG7Wjlg2FciW/3bztz02DgzprS8ZEE+WqC6hvhqzG1K+IOa9cN
 z2g9YGyYwuYrNIzjpivTNpfM4yz06Tb7CfeM2b/VpFaj8fwrjxxrozXRtfEyCW01Qjgt
 tTF0qD/CoIYGgXojYmQ0/xWuoGR2A+HPkHsIBVtWRnFY1ZgNy+D8e2bEA5XC1jnhqoaj
 pH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779618828; x=1780223628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l8o6cIS01j0pOwxkyeeRqH0JHndoNuqGw7yx7pJcTtI=;
 b=KNJGWJVnhv/fzP0+lvhuBIJP2+jZdKKEs6gf7jsS7VUbJv3G8RiomVhBB7Fp04fA3M
 9Hy+tTK8tPJFVRYjxyEYd5SuMaz9dJ089k3vzGTWum5oVS1z15uiIGvLAYIPuBIipYPm
 jlT6EpBYCwzJJKiPAlFGnlbh6EcQuNM9R2VirCZj9dxwQokyZodfhu5reeBo7Sdhmdfk
 +xk9rMTxINh7aqgYIB5d7Rg2uHaw7kANVqZoVvnP4URj9DfXPzzLJ1NVnJVO8Cxn+VFK
 8V2ybFcMYtT+0ChyXU/PxJbQDcri64R+8SPSGHn4grdgkOBxCYSNJsSwxMiP5CxMu4w2
 vF4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lU6Dc8+l0aqD/mftG202M5EIhBYU4HRron2JMGPmsaaWPpgBSVjAhWwrheg7p+8TLxUv/1r+lkfA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqEdKiw06UifkgudsHmool5Hq2AkYQ/NHBv3h12WgPHTIKEChI
 3HQ7OhfPMq53vIZh5LX5hNn29I6MJFYfiovKitoUVQc21aHYsQDOAex1WyVesywvno866Q/z+DV
 PEmgOb8l0aGRhLthZmAu+GbHz7GvpMvZrJxjc1TmU9DO+DKa1BpPb6qIIzzH9ddfRfmYHj5M=
X-Gm-Gg: Acq92OFoWhNWKfecC8+AgAmZ7xMslRWSJGRG4HScOyZ88drvj8p93k0d2/DHoO4n6EO
 4fuCKHqX50g+563J4JWS+YZwuuUHPm77yT41yCB6n5sN88LB3RlQSXpSFGjPRDe/v58PoL9A25g
 kVO0t0FM+0NlQOa2dPd6ppzUptb9Gaiyi4RO6bA5KilrlajrVejNxuMCen28daOl9kIjSix4Y5K
 PWy2+kq96YA5oRE8DGMiNOApLwQbrYZ0n/Znb5UfW6d0JPvdeF+xzVHk4/ONa/UpcSiOPiLWvWo
 w7vR33T92O5BpG2D67P8dG82vRDixLnWRsK8Y3HPHwzZ7+qefOEnqlXWNG+F/i2wO0iaSefYhok
 wcjhpcm8Lp1wZqCjlbCcUwyoU91VYNWuywRp747acJQXwTfpEI2/O4cCpWT1+VvsFC0VbkMAf8W
 CHO93/CMK8XjxOAV2g9Nj6nWYDs2yODHRGdJA=
X-Received: by 2002:a05:6122:3102:b0:56e:e9cf:7134 with SMTP id
 71dfb90a1353d-5865ee6c055mr5365398e0c.3.1779618827826; 
 Sun, 24 May 2026 03:33:47 -0700 (PDT)
X-Received: by 2002:a05:6122:3102:b0:56e:e9cf:7134 with SMTP id
 71dfb90a1353d-5865ee6c055mr5365392e0c.3.1779618827398; 
 Sun, 24 May 2026 03:33:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cba880sm1816148e87.32.2026.05.24.03.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:33:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 24 May 2026 13:33:33 +0300
Subject: [PATCH v6 05/10] drm/msm/dp: Drop EV_USER_NOTIFICATION
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-hpd-refactor-v6-5-cf3ab488dd7b@oss.qualcomm.com>
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
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4470;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7YL2ddERO+WKYrbTK+cxw/v4FUdiddSRzjsP3v7dOZY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqEtP8GADJovtb7rXvgjO2Y/Y256UfXFTz5vVkj
 Y27da5YrWqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahLT/AAKCRCLPIo+Aiko
 1WZjCACZl57V2MEbFbABu1TZ94QulG4M1cMv+VkqWhuzs7MQFLmzy166Yi+2PPo/Y5mQyyW7jmw
 SaaqWdfaqBDp3uI3JzpbYeWxH0J6ZAiXkQGJCfVKlKriHN5DJ3t32lYBEZmbLYy2sSwS+fAyOT6
 Ki45bFDNvsTv4CNxJ/pAHoN0yeR9rmVbFztEPGTT1nWgS31TngmP49SAtj2A03OU6q1+rZ4Vqx0
 sR9AaFNVgqyVkG8ellSQqmLVdEQY6A4X7LogzvFtRdBTOFxhGNnQ02VmbbcPK1B3wRDeu4yR2nB
 EUAhewevR+3uDLNdC6uC11jQi3HEmIgFL8CBSOm9IqJb0mVq
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: S0UBWHizcAcuvuwamTdsyDLqqwzQjxJw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfX8VIx5YLyzgaT
 DbTJv6WiqDzlpVeuvvYdSxp0k7lYpM4HozYLpwvu5oUfvHjFlHf9wOe/LC7cqpIYWthy3mBlXMe
 7DTZqFCJ0oLTapRzY6Vm2oYlPtNEguEQaGTc56C10rwo/oOB/9xyyw5dUR2+6MLEXu2VZpdDvY3
 Ok4GO5Ex+cVPxaaALNTPmuVWfRadMjlaZQ06DCN/pq+d/FkhDlI9Rs/zQbpQHiEhyA3W3j7fet8
 w9Kq9Y5LJ3vH1gP8SdZdZcZt43kQEAtZQwmbRiL55jiQBhnq3jAeRGuy7/ErkYQkjE5vusIPv22
 Y+jqePoVQbhtAjzYGqT4kWZBweKu62yQe7oYboL3tpsHpAxg9LVcpQyBiFyc/Li3cFotpg6Lxy7
 zSTeklFMDiJvTJ2v7AT+bM+PpVbcKlnyYKWoFjTt9G3Qbqm9119BXkdkhvkoWJ5lULoaM0OEDRD
 w9tonmEDwvlrWxT30Jg==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a12d40c cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=gW5k9mFOS1cgrKxYKbgA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: S0UBWHizcAcuvuwamTdsyDLqqwzQjxJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240107
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

From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

Currently, we queue an event for signalling HPD connect/disconnect. This
can mean a delay in plug/unplug handling and notifying DRM core when a
hotplug happens.

Drop EV_USER_NOTIFICATION and signal the IRQ event as part of hotplug
handling.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 28 ++++++++--------------------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  2 ++
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 036b4a5cece5..6b76bff7c8d0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -58,7 +58,6 @@ enum {
 	EV_HPD_PLUG_INT,
 	EV_IRQ_HPD_INT,
 	EV_HPD_UNPLUG_INT,
-	EV_USER_NOTIFICATION,
 };
 
 #define EVENT_TIMEOUT	(HZ/10)	/* 100ms */
@@ -344,17 +343,6 @@ static const struct component_ops msm_dp_display_comp_ops = {
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
@@ -378,7 +366,11 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
 
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
@@ -438,7 +430,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
-	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
+	msm_dp_display_send_hpd_notification(dp, true);
 
 end:
 	return rc;
@@ -507,7 +499,7 @@ static int msm_dp_display_notify_disconnect(struct device *dev)
 {
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
 
-	msm_dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
+	msm_dp_display_send_hpd_notification(dp, false);
 
 	return 0;
 }
@@ -528,7 +520,7 @@ static int msm_dp_display_handle_port_status_changed(struct msm_dp_display_priva
 		drm_dbg_dp(dp->drm_dev, "sink count is zero, nothing to do\n");
 		if (dp->hpd_state != ST_DISCONNECTED) {
 			dp->hpd_state = ST_DISCONNECT_PENDING;
-			msm_dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
+			msm_dp_display_send_hpd_notification(dp, false);
 		}
 	} else {
 		if (dp->hpd_state == ST_DISCONNECTED) {
@@ -1122,10 +1114,6 @@ static int hpd_event_thread(void *data)
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
index 991a3ca1e6bd..528c9a40477f 100644
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

