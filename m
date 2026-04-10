Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B694E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E47010E921;
	Fri, 10 Apr 2026 09:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aqi9DRV2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CPU2AQex";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01FE10E923
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:19 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5oJUE1925359
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PQPABXuaBBLVN92KBP183Zw7YQBShFEgYenJ2CGRAHY=; b=aqi9DRV25sUgxeXH
 tcj2NOJP4RQuAbWf+pI05k8XLW60kRBGaYerRqyILNWaBpVLT1vqsug3s8THanmz
 VB7jxaBwl2wPfSrmZWIKHgApvmaPLAnRMHeSlOzf/B7dLurWTlyM+dOISBGN59b+
 K1oj3pprI2HlfX6TkkjKuX9qGVHJzO1aS3STYss1MYtAkhwcU1y2aS8IZubhClGm
 +z4odfiTVoJG2gAm/eE3MIBLpoGiFIO4+T58h67rcGf3n4Dcrl11yDrSnvaGJyJK
 mt+qWtmjTOzOUXLiviSx/0DN6I8P4jtcdrAQyn2zrxjvPxxJShxxCcrYQlupjbUT
 qZy6ew==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudjrtb1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a31df1907cso51965896d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813778; x=1776418578;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PQPABXuaBBLVN92KBP183Zw7YQBShFEgYenJ2CGRAHY=;
 b=CPU2AQexwlLq+/BWXTTIpE6gGpgoUel2/KOMzvm973rKZxttPFjXiFeFUvQHupNAUJ
 PIYgA/N62fOKxNi11whZHc2CgrNiOPeA0iM18YNYQpeYIZ16QJeRwObXyU5msYSsFwSC
 Y1bL/C1LzeHWsSkiPOhmCUeFZhWfqsvI5LLm4/k76kwd9BzCffCCvIJByVsIWMFEBITA
 86X42+w8eeKggghr6PnxR+iP1Xr9JRN4jk0mdL6Ty4oxD8Y7SISQ5wYz/CZekm9FvSf4
 kwgev3h/M0nTv0Tm5CBnFeYYwR9/jtoJE83VkvLc65gInBkhMdZgYUyXgGL5jWlMdu2q
 YwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813778; x=1776418578;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PQPABXuaBBLVN92KBP183Zw7YQBShFEgYenJ2CGRAHY=;
 b=odDK8HSb9qp1431ikvltc/WPv+Zo/BJJehGN/cNVbpurvDy4IqSaJk3Ex6NmZ0yqUa
 KWl5xRN3pwJUQ+IPg4089l4F6VPz9TXCNOxdGlO5stt62qcn+jBq+9fAkWi8ZV3umn87
 G8up8GsQUtEKUtSemzM63b45eqXQuUbsjFkGo8phuZcJw2itYKyvmQiR/t4JnBcb6rh8
 pnIYJ5yXskrIzjq1IOdTM03Kniu80T2YZf3TAg3mPBjqxI89LcYHHivDvlnLFG17CuEo
 ngFGq0nHx80bGQKm+nWKB1uKXa+E+6oT2KjcScWnZJgjgTnQXY36q60JyT1er0JLFDtG
 yB9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfaf5dkXR9GUyXsyXkwK0+VHOM/lRQva1fCW2EwapyJ5Fz2qzr2OtEsJGK1XdvyOtzbH7OtL8LkB8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaKR8hQdndY5FQYMORVpyvzOGCrRC3NYvFo2ClDN8zGMxA5h7G
 5tIim0C5H0uRkhEReRm+VDNxaBB7HyBiOvW/gnOxyVBBtAbj6h+BBJYpsx7JUjwT9MX1T2zu1v/
 Jtkd5V6Ci366gWM2GfavyXKaJsWF2gGKxq057TWzFT+Urffn4ROwq+9B2lFRIKEapmxByEmQ=
X-Gm-Gg: AeBDietDqbItH0OKUyHCpyBZbH/dW90qZyQDXB5dS8cxHB5mNDBM49wiapP8s98vS5A
 sVENy5x+yQBTP06irHgRxuo7GwWD0DBqOK/eQmm3ANsorMPnY/qqaK94YWrtZgUJsG8p3EN2NJw
 MKLMZWDlzHsFAMNT2PWRIYOlRJFKCSaIoJW7BgaOhFDzVKV14ck4rja6I1eK1g3mtHG1W2el40e
 y0lHWMhb8UGgiIxlenPrlJUjDipwPZBlXfdTzmo/aDa4JyHzSjeUkPyzGl8F6R0+37MUYCIzaSL
 xj7kylLfvuXak48Ds7NKmBtlFAEA6VvrEQXM3fBmDB96MJdFgfii0mKSWZSHbbPPVItNCGDYvQf
 HAl31wMvKXfSf/oPG6KmTb7SZS+HCHsvP+yvcIzBKDTk9z+13iI5K0upjkECfoTRruxRrmpfkKR
 u/Si9IXdg=
X-Received: by 2002:a05:6214:4018:b0:8a2:3f80:2a22 with SMTP id
 6a1803df08f44-8ac862d6535mr30227176d6.46.1775813778153; 
 Fri, 10 Apr 2026 02:36:18 -0700 (PDT)
X-Received: by 2002:a05:6214:4018:b0:8a2:3f80:2a22 with SMTP id
 6a1803df08f44-8ac862d6535mr30226966d6.46.1775813777733; 
 Fri, 10 Apr 2026 02:36:17 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:17 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:04 +0800
Subject: [PATCH v4 29/39] drm/msm/dp: add an API to initialize MST on sink side
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-29-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=3422;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=0Fikc4rnY1UekND7dRzqfk9ihtHHa+1WVLOx8xNYQ4o=;
 b=8hLy4E3IvJa2/IITkmxuQf2Wv5ngHhhb4QUgFjbsYdAiYbRSJwQd5KzIEu7dyeYgwGFmLpyc9
 HSXKtsPBq4vCeEwjzSFU4cgwzG5Fc6sYOnSxY1LINd1pZBOCqp2I7U9
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=X+hi7mTe c=1 sm=1 tr=0 ts=69d8c493 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=vCCEq3Mv4WXTdc8uXsoA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: UkNMJcSivH_8oMHAxdCWXV3O6_rRSLDH
X-Proofpoint-ORIG-GUID: UkNMJcSivH_8oMHAxdCWXV3O6_rRSLDH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfXwkokyqZK+t4v
 lwnz+T5rX74x3sp55rmrv2wHdT0hzZ4P9aSq3NYIybzJ0AxkfzVT3Uq14peYwcYF/Xcz0S8j59/
 UJ5hvCrIo/Sr96a4Y0yD2/fn/TLG8xPqlkghJcGLzJv17DoU1AbF5dwEtqc9YIVJYYDKPdojrt2
 E3VA4xjMXg6aKA3Jse0NhPeCbs0RQKnuhbc6BrEtLKdHaXeWnOehUAXnAVKp5JaD71ZN7jMB98Z
 xUHV5xf68pXmW3YmMsrxfhFHpad1KB4dVU5DYnVX7lQMu7kiTzyv3HqEa+I8RvzMJIee3fjap+R
 mnSXI5qDvZR9rPdQ1lzSpFGzzIx+A3EGwc7KAxZTnFway7/CBUF+66XsyZxhzw7l9QC9qJFsSdx
 qEs+Y4GI8dr9wdt48UoDaVk9TWikWKuFYFwGTOA3XaV9Q1/+C+S6L/Gd07bMyc8n6/CrbkZ3lJt
 hu7XhUXM2Q4A7i9wWXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100089
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

If the DP controller is capable of supporting multiple streams
then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
DPCD register to enable MST mode.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 57 ++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8ae690ce2b9f..abf26951819a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -14,6 +14,7 @@
 #include <linux/string_choices.h>
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_edid.h>
 
 #include "msm_drv.h"
@@ -270,6 +271,40 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
 	return lttpr_count;
 }
 
+static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
+{
+	const unsigned long clear_mstm_ctrl_timeout_us = 100000;
+	u8 old_mstm_ctrl;
+	struct msm_dp *msm_dp = &dp->msm_dp_display;
+	int ret;
+
+	/* clear sink MST state */
+	drm_dp_dpcd_read_byte(dp->aux, DP_MSTM_CTRL, &old_mstm_ctrl);
+
+	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL, 0);
+	if (ret < 0) {
+		DRM_ERROR("failed to clear DP_MSTM_CTRL, ret=%d\n", ret);
+		return;
+	}
+
+	/* add extra delay if MST old state is on*/
+	if (old_mstm_ctrl) {
+		drm_dbg_dp(dp->drm_dev, "wait %luus to set DP_MSTM_CTRL set 0\n",
+			   clear_mstm_ctrl_timeout_us);
+		usleep_range(clear_mstm_ctrl_timeout_us,
+			     clear_mstm_ctrl_timeout_us + 1000);
+	}
+
+	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
+				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
+	if (ret < 0) {
+		DRM_ERROR("sink MST enablement failed\n");
+		return;
+	}
+
+	msm_dp->mst_active = true;
+}
+
 static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 {
 	struct drm_connector *connector = dp->msm_dp_display.connector;
@@ -288,14 +323,19 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	if (rc)
 		goto end;
 
-	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
-	drm_edid_connector_update(connector, drm_edid);
+	if (!(dp->max_stream > 1) || !drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd)) {
+		drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
+		drm_edid_connector_update(connector, drm_edid);
 
-	if (!drm_edid) {
-		DRM_ERROR("panel edid read failed\n");
-		/* check edid read fail is due to unplug */
-		if (!msm_dp_aux_is_link_connected(dp->aux))
-			return -ETIMEDOUT;
+		if (!drm_edid) {
+			DRM_ERROR("panel edid read failed\n");
+			/* check edid read fail is due to unplug */
+			if (!msm_dp_aux_is_link_connected(dp->aux))
+				return -ETIMEDOUT;
+		}
+
+		if (rc)
+			goto end;
 	}
 
 	msm_dp_link_process_request(dp->link);
@@ -317,6 +357,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	 */
 	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
 
+	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
+		msm_dp_display_mst_init(dp);
+
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
 end:

-- 
2.43.0

