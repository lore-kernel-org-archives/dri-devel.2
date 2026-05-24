Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103EECD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 10:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A28710E35E;
	Sun, 24 May 2026 10:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CBi4Y3T/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XzrFJyPr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B7E10E353
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:45 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64O5AJ14015293
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jWB2ji/NIriYCqvzWJu07blT4Tg15A2umoRQFrcHfrg=; b=CBi4Y3T/NLLQTavM
 fTGD0lZf9binU8TuKK1jQOH049BfyDqPnYsasX08KQlZQrk8GSLYgfd6KDU1SAwi
 DQ6c/wnYkl9RZcYBw5IWt0iAU/d8DvovB2BkLJbsYFVM5yimdwaV6a+PdIO7S4Ay
 0N5zu5nG6/xnND72zcjeGJfQ2CO0qN7P1eaKhG9CLGe6TmgyTr0nT0t87kSdyjpj
 jNdvt8zl88becJJHV4st77qyPmbBtPzwU8qdEHR759vxRzrUsFO90WAb6WXhjm+R
 GtVBwYhFNwCgrWlmkcnQl4365/OVLVS9mqLstnQTaSB21bfrXhQbWKA+x0rhKNFH
 FuBLgQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4m7jww5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:44 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-956804755faso8774784241.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779618824; x=1780223624;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jWB2ji/NIriYCqvzWJu07blT4Tg15A2umoRQFrcHfrg=;
 b=XzrFJyPriOFZPTshemHW5//hULOhIu2OwBepjeYmKxq/+xJ/K24z3zWPRe33H4u0R8
 LvXbupdgKNejBt9DwFREm1cK5r48iX7Ggx1RctPj4OsgGtJ2Vr6De9YeoY27HERlsRUL
 kfJgsuNdRisPDyu6eCSRQmNyPFdxNI1YdHvGAE/rrvIrs9rUgFg6Y+EQdA8KPyabLb2t
 ZfoJUE8DjwKy0LNGssN1cjyzETeEsE+j4plL2QQdnoIe+X62FX5qvv3J4C6259qfecOL
 XPlFf764i4GIt/PliG4KMdzQoWezZWWpdavMqXDWkbvMhDSk0KZaztLBhsRJg3Bnw72G
 pSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779618824; x=1780223624;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jWB2ji/NIriYCqvzWJu07blT4Tg15A2umoRQFrcHfrg=;
 b=iH7gCQsargzLv5w0szc6ssgP2R93C01xfDdFV9gzwXS4nT5qG+bePmS8yPvlaCRuKj
 pVFg0QglvFHCIk0kTXe1lU1YSaZSoCUVJU7/h/4OJc7Iprk6xq3NO7dbzAbE5E0Lb69m
 Pf2TjZZZk4vEpBBlH2dS5gUjQ+z3BliYCUpAjEtQnQ7V0joFmWdQd1/ux6nazddFAhhk
 VQtO8GISiUpgXqVEKimo9Gyj6FI2t6D0lMEM1TcPFHgTsJvseSD4ZkqbpVlby87KD+pW
 bQQDVeTTuSszSPprWNyfhh+a+VDPiJ+eNYKvi23TIOMFk5jQ/G1DFPu7xvOcEJ4I+5pD
 iU/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bC6BNN83tpwB0XXqzTY5HR4q4l7MafYDp2qtxrL79eE9fRbOuXfAKayHhGe3iZ+1CMVG1pYUixDw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUSIyU/FI+uLffYU6zECo70E7oHKHqdUran4EatDwms+ugJUBi
 3GGt+K+iuxhndHyiTrVE04o4UExP/OwkfobM+X0mS+b08FIWnbcNjKHssbee83Jqw6f8+43GN0R
 /rNHoPxH7YBth2bhQWYWvMBaJ/6QaCQH+S9jeYuLEq2d9ZPP+wMJbkN/CkGYJBWOE5ySjKJU=
X-Gm-Gg: Acq92OESEDsGCxXSC5JlWecjg+WE3DErgOKikA26hgCQ1VkaGPoL9vgzKsiui6Q3k5n
 MicZ2bczy3W1cfO0OokWO1FBStd2rMn/C6WCllaWVA8nKwAwgy+Yv/QMmu7o81beT8maaGsJuXE
 fVfc2Otnoqj2s2o3esv3d1+wwgiLZBglpiSEVkRMpHHONrhq1jp5G1y8t5l2xZWVrV+FcFWA9dY
 NiJFLe697Syaj8treSeUfo6D97hjYMi4lQV6KXDoCfojCu1l325LvaaJ3RG4cSw2Fzx41GbFZ+p
 pjY7g5BZ4DhoR0itnyOpsL+9g4sDA72UkqGSgIyd4OI8gbZt1izRIIpp4Kur+NvhphCXS9cBoeg
 due1FBNQpDgf8Ie6/yMt+ZS9YRVmmDUbG3oi9EG2BZiTAndumIMg6z3N9WWPXgRhHc7k4E2Pw75
 bBsbrf6WNARwTEhOeZaTnl6YT2gNReIdr6lm0=
X-Received: by 2002:a05:6102:17c2:b0:633:f7ab:6bd5 with SMTP id
 ada2fe7eead31-673ce1a740dmr599293137.18.1779618824170; 
 Sun, 24 May 2026 03:33:44 -0700 (PDT)
X-Received: by 2002:a05:6102:17c2:b0:633:f7ab:6bd5 with SMTP id
 ada2fe7eead31-673ce1a740dmr599285137.18.1779618823652; 
 Sun, 24 May 2026 03:33:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cba880sm1816148e87.32.2026.05.24.03.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:33:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 24 May 2026 13:33:31 +0300
Subject: [PATCH v6 03/10] drm/msm/dp: Read DPCD and sink count in bridge
 detect()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-hpd-refactor-v6-3-cf3ab488dd7b@oss.qualcomm.com>
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
 Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4687;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=LfFUlOISMVD+0rSYX6TFT5QzTXuP4QCzs8WLa+Upwss=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqEtP8b1jf8vWsVak8pEAzirBQ6nFhtNhTuagcJ
 2cmHoxsOKWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahLT/AAKCRCLPIo+Aiko
 1TUrCACeoH68ha64/v9DyUk/onMpYPA0TMR46wrUUHV0iskEalybwo/KUI4o8EEmULyjEx4Arwg
 AUIFJ3s9eTW2BCsaIy25dhLt0H4iGLqiVLZGLEuvPqVG+vxgZu1/EOt/xF/cpN5D1xEBV5ca18K
 MePZgpqOEqJ6xN+TRzzbam6U23BqvFfTM/KHytunDZRQ1mCHIhxl8Ev2y4ZmcY9h2zpXjLlyPe4
 W53JiCw6/Ukwr/uB8Mvu0hDKjOACbqmj5pREIy69UdNqhwNzdUJIgsSSV+42zrwv4+Fs89/2Kj0
 a/5YqNwiwJJZ4TJ5sydzkaiVl1kRtbXKCXa3UbxvJddTyiZU
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: UiFLmNoBSRJ1X3KT9r9A2h4jtLUHdMv2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfX4ZXATTPgLBZb
 1VI3RQo7ELhQ5kjFXn7IVMOnbbirB2AC9f/coggCKwv/E1qkLPfvfh54f+ao2qh+bzbWlrIZZzQ
 YHre/iVKerYixEqcaZpDAHDCRSnTRS6FeUy3AgW2scJXIprZs/aa2rWp34mZBjITyDDqPM3ms9V
 dv6C5QFWsLjyJ/HsUXylKc5L1ax1o2rq7rkrRRpPDc7D1IswpYbEnzW3m/cjiryROFut93RdP6+
 mN/H8pUZkT0buJOw65uU6tp+Mwm/fHya+6mSY5/lX+0mt4lKzxyX3itQn++sMt5u5C4Bb0hXKXN
 Z4pUimEcWDmvNAN56lNjIrqYt6yYGzuK0UfuV0Fzs48qB0okei7HylPZhqmdmJklNhBoyzueBeA
 N0VDX5FuuqsMouhKuuAh0/MCzfXYiljFyP6Rzg8KcclCkAmfE4CQwgi2vPS0f1vMoDXCVy8s7JT
 zLdVaePUnyb2Q0RTUZQ==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a12d408 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=jcEwYMPARZwhhGfK5pwA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: UiFLmNoBSRJ1X3KT9r9A2h4jtLUHdMv2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Instead of relying on the link_ready flag to specify if DP is connected,
read the DPCD bits and get the sink count to accurately detect if DP is
connected.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 63 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_drm.c     | 20 ------------
 drivers/gpu/drm/msm/dp/dp_drm.h     |  2 ++
 3 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1dd168acbbc3..97c4752005c0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1152,6 +1152,69 @@ static int msm_dp_hpd_event_thread_start(struct msm_dp_display_private *msm_dp_p
 	return 0;
 }
 
+/**
+ * msm_dp_bridge_detect - callback to determine if connector is connected
+ *
+ * @bridge: Pointer to drm bridge structure
+ * @connector: Pointer to drm connector structure
+ *
+ * Returns: where there is a display connected to the DPTX (returning
+ * disconnected for branch devices without DP Sinks being connected).
+ */
+enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
+					       struct drm_connector *connector)
+{
+	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
+	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
+	int status = connector_status_disconnected;
+	struct msm_dp_display_private *priv;
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	struct drm_dp_desc desc;
+	int ret;
+
+	dp = to_dp_bridge(bridge)->msm_dp_display;
+
+	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+
+	if (!dp->link_ready)
+		return status;
+
+	msm_dp_aux_enable_xfers(priv->aux, true);
+
+	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
+	if (ret) {
+		DRM_ERROR("failed to pm_runtime_resume\n");
+		msm_dp_aux_enable_xfers(priv->aux, false);
+		return status;
+	}
+
+	ret = msm_dp_aux_is_link_connected(priv->aux);
+	if (dp->internal_hpd && !ret)
+		goto end;
+
+	ret = drm_dp_read_dpcd_caps(priv->aux, dpcd);
+	if (ret)
+		goto end;
+
+	ret = drm_dp_read_desc(priv->aux, &desc, drm_dp_is_branch(dpcd));
+	if (ret)
+		goto end;
+
+	status = connector_status_connected;
+	if (drm_dp_read_sink_count_cap(connector, dpcd, &desc)) {
+		int sink_count = drm_dp_read_sink_count(priv->aux);
+
+		drm_dbg_dp(dp->drm_dev, "sink_count = %d\n", sink_count);
+
+		if (sink_count <= 0)
+			status = connector_status_disconnected;
+	}
+
+end:
+	pm_runtime_put_sync(&dp->pdev->dev);
+	return status;
+}
+
 static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
 {
 	struct msm_dp_display_private *dp = dev_id;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 349175457566..991a3ca1e6bd 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -15,26 +15,6 @@
 #include "dp_audio.h"
 #include "dp_drm.h"
 
-/**
- * msm_dp_bridge_detect - callback to determine if connector is connected
- * @bridge: Pointer to drm bridge structure
- * @connector: Pointer to drm connector structure
- * Returns: Bridge's 'is connected' status
- */
-static enum drm_connector_status
-msm_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
-{
-	struct msm_dp *dp;
-
-	dp = to_dp_bridge(bridge)->msm_dp_display;
-
-	drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
-		str_true_false(dp->link_ready));
-
-	return (dp->link_ready) ? connector_status_connected :
-					connector_status_disconnected;
-}
-
 static int msm_dp_bridge_atomic_check(struct drm_bridge *bridge,
 			    struct drm_bridge_state *bridge_state,
 			    struct drm_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index ec76448e71ae..041aa026ae2e 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -25,6 +25,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 		   struct drm_encoder *encoder,
 		   bool yuv_supported);
 
+enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
+					       struct drm_connector *connector);
 void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 				 struct drm_atomic_commit *state);
 void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,

-- 
2.47.3

