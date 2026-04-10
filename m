Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC596E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436DE10E90A;
	Fri, 10 Apr 2026 09:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DuCK2X4d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CsRpdRuf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C1110E90F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:34 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5oS7S4148726
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XH5OGuuCFVVaQxq2zBNoNsrh1MXRyUkvunIP+bf+M8E=; b=DuCK2X4dDgRx0TLP
 pZC/w+lxLRWC1exZaXODf/ciUVMITVO1NZkLB4d9yWKVubIxCidHhcNtwJNKxHYw
 /wDx6ULd6O439NXgxlwvIG63DbqRaa3xils1KYsfgtJUU2IMFvlqd8s5v8LP5AhU
 18FcaeJR2uTTHMYvh5eemAwHNu4B8b5aX31jNfobMjat65kC2IGTE5OU8OLQcSw/
 /4I/+vDVraK/w2TFlXc6N0C0DjI8JgKzRYLf3tUZRjrBJIAT+AqOwltDYveSMa2+
 JcehQo6Ck/XtzJakqd3fu6leFduVSdW9u4yuD3QrSAnNX2FgBNLxWWVDECd5oPXK
 wL+/Lw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudggsgy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:33 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89cd03be011so41261346d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813672; x=1776418472;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XH5OGuuCFVVaQxq2zBNoNsrh1MXRyUkvunIP+bf+M8E=;
 b=CsRpdRufBjeUU9/+HMUUn5OhlalMKTYNNwDj8WT2yCtdh2cDgzLNR8yksZpFsGH3Ii
 qDzNx1o9ZbtoKrfYBsU5GeKZJGhx9kfYA4zFP2Ej9pMuftZEL+YVNz8UU7Nx+26F2XGx
 Yrs5Q4XzYGWsxfkP3L7kEXF2hyk5W+Hr0JREl2wd+IVGwQ6Hu1L3r+xfyOLfkqQBW+AB
 jvzJlGsgG5eBlE3HPncJD8MN3o1bt/bnsZPlDnTIpRDMiUM7a60xCRtTum/REFGCf0WQ
 fNAsdNRyr9yAuMhtEputNLhtBuHjYg+9GTlys2hCze6SapfZcjmcvp09NEEnFvM0TJin
 hrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813672; x=1776418472;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XH5OGuuCFVVaQxq2zBNoNsrh1MXRyUkvunIP+bf+M8E=;
 b=l25gQefAKaFFls/2P4dBK401NqVg16i9uD2UOmNalvW4MJzdAqv3xBBXlHdMRoDxb0
 L+5RaznnJ+xNtoISKShDhGMEIQ++WB9lFjl59s2TsvC0M+Y0xovUEeD7/wfD4qAaugcq
 Gor9NCCZbHNXcFJKLBAxr22NS9M45oZBlS42m+AYPu9P12nCavoQdNBSHEOp/1hyCqTf
 T42YxAmTme2LT8zB9pSUEoOIs8vPyeDH/P0hcVNcIWrw/PMyTmWT7kTuQKaD+8Z2yIw9
 oejh5UTRAlSZpYQ7sxm009xZA60awg2tBuaUZyFFCmNWvbLPSnlGPWR3ukWDKCqnezLU
 Ftuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtX6CL0fu8X31kDy7AtjIXaxCwiJ52CucJ/n3JLj0nmEauQR4ts2Fciz5cRLYWC4WkUdsq0ffyGjc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzon7UbxdbTIor0iNGSsJqzVwd5XUrHakWnDpdgdCkk+0xJtYyk
 JrWnPMwWsKBlfPz9LiLOw8waa9VpMQUMWqk7q7+FYOefeywUbdUn9G+Q76KCeyNuq/73E0WCZXD
 GDogFndc4H0oODeSnMZ3aOe2GGao/eL55WSWTb0wqEdJuzPITvemSQYr2Z9O6EuYhIaSX4Kw=
X-Gm-Gg: AeBDiesComPmx6beUy0h+ACKnUmK9fYIU84ohFIkze06/Mz9QMkCKQqP6uHPiw9SATb
 8Q+rO4plHMfumWYJVXclaOXH5CgbdX4xHW0+Y2UUqdTk5GxHfNswcfcVVkegmz911oyojDel3iE
 D2qePzM3mWTtTw0QH0OEZdcsds1sztjgNE/OJdF/LfzEkbeIyWiQyjJ48lcGkTdZ6xUg3/tFprP
 0uEur+xDUZ/dNLJjib5PR4BeOM9e2m52lz0N4SRCptIU5FwUxDz+dboBR/flz5X9cZ8kHWE0C82
 4+3Q5MMSDlLYmnabKrJ2ZysHcIOrBalBG3bpzKA2kJklUq8nqLkVBz14WP/X17V7XwR2ggMO5Aa
 kBZzn8a4yPJ+1yeXLmMxP6ZsFxQzxtDVao+tpk+Soq3hcFq3BKo8P7nL+XNxTNh17GTn5wwrBEq
 xs6NGvTx4=
X-Received: by 2002:a05:6214:4e84:b0:8a7:32c8:7075 with SMTP id
 6a1803df08f44-8ac861aa864mr28916336d6.19.1775813672612; 
 Fri, 10 Apr 2026 02:34:32 -0700 (PDT)
X-Received: by 2002:a05:6214:4e84:b0:8a7:32c8:7075 with SMTP id
 6a1803df08f44-8ac861aa864mr28916026d6.19.1775813672207; 
 Fri, 10 Apr 2026 02:34:32 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:31 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:43 +0800
Subject: [PATCH v4 08/39] drm/msm/dp: allow dp_ctrl stream APIs to use any
 panel passed to it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-8-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=4382;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=BkXona5TbnmF2de1k2yc2BT4vzk4O5UWrXuvAHrPtBc=;
 b=p8UCmpq5XBfAtP50t/F6FDt0RigWiXxicBr6UCmW8ZWVkMnfjZJQawhqlnqHAx9w1xHwzUAg9
 BnhX3u/uhRsBZpIBYOrbH170cbtzxIjAqzA4NdvcERnaV5l/G1uySGm
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: O5xvFi9kOyXOU5xebOVnvD40qpMMj841
X-Proofpoint-GUID: O5xvFi9kOyXOU5xebOVnvD40qpMMj841
X-Authority-Analysis: v=2.4 cv=H/brBeYi c=1 sm=1 tr=0 ts=69d8c429 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=x41-kvR0HCwjNSFKcS0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfX+5/k33Y523Ws
 XXEdtVxZQ/rRW9MAXzDuMsdmLw0M2vnhbvUZRMfQUxw+kSeiHRjklhStLPM4fpLXuWpe7NXmA/a
 k1zY7KqnRbkvaY9OvIHfsY4IKdl962qu8yarRGtA3NhDccqIPFSwNsAjA9Ns02fzoArPD/ZrQ7U
 9CZ8lf0s/XbVP8gQgBceXZlWbT5JitLSWQTHY/esmYZf2inQhp2pDYQ/pAhjpgj2OoxbwbdnoPj
 WNLvF8SC4xbWIrqQDcdpilhQCafnpARO9w58aIjmi2wyyhPVfqGXc/qFpMXRXPDhgVvQVkEyFvH
 lQ4p2R47J0KYxdRqUlgu4oTxkTfdA535nkAs3bnLPYhOR+iZI6T6GCfPSe2dcy+97BsvpRAFMYn
 1vVcYrtfs3WJDK4IGwstLj7/K3L8x1kuHUN8kj5Ti9rjdzf2/UZKyjh3G539JzDz7HZFb+i6jpC
 jqr2r5BsAPH2ga6gwMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100088
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

Currently, the dp_ctrl stream APIs operate on their own dp_panel
which is stored inside the dp_ctrl's private struct. However with MST,
the stored panel represents the fixed link and not the sinks which
are hotplugged. Allow the stream related APIs to work on the panel
which is passed to them rather than the stored one. For SST cases,
this shall continue to use the stored dp_panel.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 21 +++++++++++----------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index cd58968d4e14..d0eed8c7df45 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -477,13 +477,14 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
 }
 
-static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl,
+						struct msm_dp_panel *msm_dp_panel)
 {
-	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, msm_dp_panel);
 
-	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
+	msm_dp_ctrl_config_misc1_misc0(ctrl, msm_dp_panel);
 
-	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
+	msm_dp_panel_timing_cfg(msm_dp_panel, ctrl->msm_dp_ctrl.wide_bus_en);
 }
 
 /*
@@ -2523,7 +2524,7 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li
 	return ret;
 }
 
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
 {
 	int ret = 0;
 	bool mainlink_ready = false;
@@ -2536,10 +2537,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	pixel_rate_orig = ctrl->panel->msm_dp_mode.drm_mode.clock;
+	pixel_rate_orig = msm_dp_panel->msm_dp_mode.drm_mode.clock;
 	pixel_rate = pixel_rate_orig;
 
-	if (msm_dp_ctrl->wide_bus_en || ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
+	if (msm_dp_ctrl->wide_bus_en || msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
 		pixel_rate >>= 1;
 
 	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
@@ -2571,14 +2572,14 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	msm_dp_setup_peripheral_flush(ctrl);
 	msm_dp_ctrl_config_ctrl_link(ctrl);
 
-	msm_dp_ctrl_configure_source_params(ctrl);
+	msm_dp_ctrl_configure_source_params(ctrl, msm_dp_panel);
 
 	msm_dp_ctrl_config_msa(ctrl,
 		ctrl->link->link_params.rate,
 		pixel_rate_orig,
-		ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420);
+		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420);
 
-	msm_dp_panel_clear_dsc_dto(ctrl->panel);
+	msm_dp_panel_clear_dsc_dto(msm_dp_panel);
 
 	msm_dp_ctrl_setup_tr_unit(ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 5d615f50d13b..32196e97cbe9 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -17,7 +17,7 @@ struct msm_dp_ctrl {
 struct phy;
 
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 58c46d5ab4d8..1bf1335712bc 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -666,7 +666,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
 	if (!rc)
 		msm_dp_display->power_on = true;
 

-- 
2.43.0

