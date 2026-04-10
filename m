Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA80E99065
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9261610E907;
	Fri, 10 Apr 2026 09:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bS25G3ml";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCqt3RR9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576CA10E907
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:15 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A7rlGn115215
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c2cqSDHqNgVvUpQ2UDVNucOxrHSj4G+nvJMZ5j+4sYo=; b=bS25G3ml963D+4sM
 rIYshNcvxf34m20u5h2a3JAnaoKmjZvCJqNg4St8GECKzSod1RnQf8CqyI9usCDm
 8OffamoR43yl2Xb6b0thW9WoKftG0+b6fKicOSnb2iMnjJ7jwjrI5HabRnUO9IDZ
 dOg662rLTytDOX2cFhcvzBaNYN9GYYq4AaSuh3pmjzRXs6X88t2bZjBgmnUBJzlK
 QbgEzzx3TgXuR9Ilwy9HsnzC+0y85RozdzUGDc89Bwhq2wPzGxQgwAnqxoCNsVFJ
 N+HqNcDUQhzPJGTPTwd126NExF3lKIllpiIVWGiQx8jcy99z3liAmBroFNUAeLJh
 p1UWEw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xb8td-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89ffce20deaso43737326d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813654; x=1776418454;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c2cqSDHqNgVvUpQ2UDVNucOxrHSj4G+nvJMZ5j+4sYo=;
 b=dCqt3RR9SKgS7F8iD0cILmk+57YeOsiPOjyQFwFw5kq56rAZ8jSUSuoGaxDhN0u6E1
 4gM9xXlsCE51qhPygoWVMi3fWAqrEcbwcOveoF0Z3rVTKiKOn5bBXF55cobMXe7Zp2D6
 75izjfp4bxaG7ssWkyb8afubyYbLoDcPx68QDJuP37gT4uSxfNQEw1M7/8uIGhIm/hm6
 iwfj5M+Wp48DcCbK8pt6kus4RwpUQ0855Qv0WyD+RT8j5CS3KSlJuk9RSnAr+SwDZotZ
 mvc1+H0VMxmqSvMyQEcDbtWP3e0nC/0ozPbHAKx8CNDdQ8xFBPS+ziqAnJ5MJq8J4G1p
 siUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813654; x=1776418454;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c2cqSDHqNgVvUpQ2UDVNucOxrHSj4G+nvJMZ5j+4sYo=;
 b=YeRRG4GKL02XRnLmD2pmbmn+Qatyep/vpgduuWblUQkagQnK/0p4xLYsBy8nKvt593
 Av5vwQpqEIVqJ1/dvEcuoLhO55krXwFqTAueW/rZZ7qHdHySJh9u2VxRwYJ39MdI7qZr
 AO44EpIZWS1kzVUqKP+fp7GomT3vs8wv/qnePElrCB5MyW4Sh4HXlK8zJb4dyUDfs6gh
 8I5iMdTYt/VclI74LFyIoTa7gseTrdDv9tHjcprwZfzaJwiO0YpmoMcQ0/ezeuGaiyRN
 VJip9B8gHq1WJDWnk+iYr1iOFnctS0VjkST+KoGV+dKBre4XsieFwts8S2dBLGEWAbhE
 155A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFdlXC8NDPAE5Fkxg3ClghIkyW+I/GlWTKGaNufZkubIhRZPe1GcF66nIuTAX0X1Rf+TmIRNX5gwA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywlRcRKutDYeVKJWG6VzronvNLxdOK15m2IXnofaIjiLie0dfj
 MUPnmGKEqGfi06rXNPmRi6PERvXc3jpjqFoN80VdHROuftot8/DVUCvE070RgljKCFpY2tkBBte
 /jYYql39dwF9pqV2V4ChZJvUktHr4/8b5zhb1QTJ/Svt0EpHFkToR3Ru87sdbr8O7rolHJMQ=
X-Gm-Gg: AeBDievJrN0SX4U+cByT5XPg+0iJprr7R7acdWkLNPLSw7Yl4cjPVirAh9uHh5Y82lD
 TC0P+Wlf3BEdh2eN+ylodUjAU9SDXRLs5SUhpn/acMA8wJNM9vnLoSsn1hrErxbWg7NkaYgPu59
 msZRtprqIUzfmlJ7WVZGqJRxhvoKUpBFSe/8UUxDYw2q40GCLTMxLjOi2eho+sMp+yCkWWUNAEr
 R6kJUjFahAVFNGDZp2n/GaCVNCUkGKDjFs2sJlpprQFdirrbToj+qNQmlX+30aFetqf1QIofkx8
 lJUTGv0At5rW21S5V62Eiy2mLjFT7ZU1OxEPF7wheN81tfL2quCUCUPi3sTDkveODnH3Jrf/LRB
 H5ixn5INTOnlQxBigq/VEWaA1v9bjJ5g4BKVlsr6KjnMs29dq6pMOli2wFwB26it1hH9kX+JQRd
 FZHnxS4nU=
X-Received: by 2002:ad4:5949:0:b0:89c:c75a:e83b with SMTP id
 6a1803df08f44-8ac86319c15mr31742786d6.54.1775813653698; 
 Fri, 10 Apr 2026 02:34:13 -0700 (PDT)
X-Received: by 2002:ad4:5949:0:b0:89c:c75a:e83b with SMTP id
 6a1803df08f44-8ac86319c15mr31742456d6.54.1775813653299; 
 Fri, 10 Apr 2026 02:34:13 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:13 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:39 +0800
Subject: [PATCH v4 04/39] drm/msm/dp: re-arrange dp_display_disable() into
 functional parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-4-b20518dea8de@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=3890;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=jXQCAxCiXUJRF5Hy5TGXsy0zyup8wBHq7tf5RYhaBiU=;
 b=WGsTo1NHR/4bJtLAXFiYRnBHZTj9PqjbvGytlM2rfB5uHc5KVWe4B1JU8TM6JJaCmRKf6Haro
 NY/UjH39L99BndgMunlcShYVvNU/wAP5i0xUmW2OYB6CqGXjQY6e4I0
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfXwe+56qY8d8A8
 G24dY+TEGLXQgyiuBX3eC/FpRV8iUJYQtlt5cvwSi8btmkimWzyUiYcUebmvE59bsyLJ6hY4mDJ
 sSVQXLcFXWfCIfwBz+wPsWpl2Y8csHoYWL8OIljbS+dqQCWu5RaGJtySEZO92iAdLdjyQY82Esq
 ukv20YDlKI1GGm5LadSOJ3vbQYkjlOzdHxmgDL900z6h/1y4DY5QgddRwTJM0J/LN7CaJNQNpOW
 OqNU3hnoU7qEnEWCsP8B3YdUl/d7OLrSwpgTTR/e2Ojtd6zBRptgL3+4jBcQvbaHmp+0j9wykmu
 75TzBF/3pATYIwEJVxijoqBsDiAVtredqRRcdoovU6B+zrx/ZR9bsSXjP8IlfdwLVKz30BfGnY9
 I18+gSWYUQsVm1sWnJt8Lhe881IF3iroSWJvWv6ZnkRY5plVBDbsSnVKaQavQc8I9GUI2+QLVDR
 UDAmlInaiQVyvSsZkYQ==
X-Proofpoint-GUID: nIk6X6D0YQDowsAmc_J8N_gK3i0BUd52
X-Proofpoint-ORIG-GUID: nIk6X6D0YQDowsAmc_J8N_gK3i0BUd52
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8c416 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=We74lq4XQ-Qw3Vo_XYoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100088
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

dp_display_disable() handles special case of when monitor is
disconnected from the dongle while the dongle stays connected
thereby needing a separate function dp_ctrl_off_link_stream()
for this. However with a slight rework this can still be handled
by keeping common paths same for regular and special case.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 19 +------------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++++++-
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 0fd4a7b6d931..476346e3ac19 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2576,7 +2576,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	return ret;
 }
 
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2584,23 +2584,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 	phy = ctrl->phy;
 
-	msm_dp_panel_disable_vsc_sdp(ctrl->panel);
-
-	/* set dongle to D3 (power off) mode */
-	msm_dp_link_psm_config(ctrl->link, &ctrl->panel->link_info, true);
-
-	msm_dp_ctrl_mainlink_disable(ctrl);
-
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
-	}
-
-	dev_pm_opp_set_rate(ctrl->dev, 0);
-	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
-
-	phy_power_off(phy);
-
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
 	phy_init(phy);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 1497f1a8fc2f..5d615f50d13b 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -19,7 +19,6 @@ struct phy;
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
@@ -46,4 +45,5 @@ void msm_dp_ctrl_core_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5ecbc83c3838..58c46d5ab4d8 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -719,12 +719,20 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 	if (!msm_dp_display->power_on)
 		return 0;
 
+	msm_dp_panel_disable_vsc_sdp(dp->panel);
+
+	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0) {
 		/*
 		 * irq_hpd with sink_count = 0
 		 * hdmi unplugged out of dongle
 		 */
-		msm_dp_ctrl_off_link_stream(dp->ctrl);
+
+		/* set dongle to D3 (power off) mode */
+		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+		msm_dp_ctrl_off(dp->ctrl);
+		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	} else {
 		/*
 		 * unplugged interrupt

-- 
2.43.0

