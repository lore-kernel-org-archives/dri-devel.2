Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD05CCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2D510EFEA;
	Thu, 28 May 2026 10:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VzSF8HuN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TDw8vzTv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407DD10EFF0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vRZa4016310
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 toiQ8+ElWmOZI++E+BWr1iSCUEgENnEGEvNlwdrGuBY=; b=VzSF8HuN32O5gLPg
 bvn75tUrx+BeVRFuR+eOgBmhStHy3CHaruxwyOEHXD+03JLOXCz2AJDz8npLHWO+
 AzRgQ/FWm9ksou8NLhMM9YfL2o3upUCVk6pyeoKYCc7nuIo+VQcuh2A7NPOrv40S
 AFSSGQ1YtO8AEz9bElhctWZzkkb2QHJLM5NEAHW713o9k78WlKDtwnMEmA0CMi1B
 zKesx678rmFzTfyCFVK1QnTTPB9ZdJE796sn2cUxkHtiNe7nNetPiQuQMC0kfsKA
 X/xpT6GoSS0hM9SciwbAm3jQ2m5okkC6pK/HeGi0WqZepOA/KDjI5AoGGm6ASEW1
 UY4fpQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y5adg1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91382222f94so2415232985a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964880; x=1780569680;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=toiQ8+ElWmOZI++E+BWr1iSCUEgENnEGEvNlwdrGuBY=;
 b=TDw8vzTva5vN1G7BHG1nJCklIi9JVhQKxYwZ69HOGMg0ZnSgaZFKXhCsLL8PVefsBU
 9zwqt8sGK8Z9fE0VEWyu9kYFOoPGfAuCl/qJDs8v+DrNWT7RB2n39Phx1WrV03h4Wz9c
 7lqN6hAFSP0rfwVelP+A6ddlWiTAErKPwRvjmf4mRrvza8we0aOE/xVtZIXWPL+ETxsH
 TH1QOHF9/jwrC6KEG0F/5ayf2vpr7wKoZzoVZ25Y4of+NuY4ranmb3Xwb6PuM97vlaue
 WScdgFTLtea1+0bb+P0e0NwPd3NobXbLZrTh6yYol5GPgksD22ByxcyFZs8k0pXc7pJB
 JAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964880; x=1780569680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=toiQ8+ElWmOZI++E+BWr1iSCUEgENnEGEvNlwdrGuBY=;
 b=Vsuqps95NxwhdnXtLRJmS3W6xDJxRxq9jfDFbSJmWr2J3USNLHD7Z6+SEyK9eYYb6j
 201Xsq0EIPOvLQDuGUMi/V4lcEdzrZ6NHnkxu0wKdLwB6jKI8b+qN0RWlxtiVZOjfEWO
 6wyVYCGdS1JgPKpljDwmdrgX0JyO+533tdnJwe9LUp26yghjAVSuuvYqLigWNnUFNiIC
 NiAjTbzRNSO9tjDPJQT6cupEUoV3oRggUXZoG+jSFHTC5y2AqZOXcCwF2kxpsxsF7SvA
 TkNyDq/bHoJscAU2tEqydIGpmVuVhsbxib/Ryo2ARu+qRr3Fvc3snFBEfMfQm3mKJpGe
 8y4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OQVXaP07cJWsJQbGR/j4FLWTRGGjQYUE1+vDtHnPynoGK36yWRmMeCgAzp1RXReli0dvqAeGHBKI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+8psnEG62wpTgpDyK+D2Od4kCPy8S0Azs1RmnwITpdnRjRhME
 XzDtAQ4xMX/c+p9G/KKI3awhsMfw13ht/ft7+gqQcg4FVX++TxfNyjz8W0tOGy9mp81iivG0yLq
 PxsgLlbSlYVJntMOnP9EpqpDha4kuVKKuFwCUEbmtPLK1/26vHk2nigUU6xmaAH76hYX4jFU=
X-Gm-Gg: Acq92OGJ5+XxE4EAMgN7bHhENec9n4K6EM2Rm72UK2wvySwFyY2jS1MxPVduAuY/m6A
 /FclOmtVg0VmjchYVsKOPwvN7aVh3/aeFn+u1+dvkNKmewNvMmOr/5eCIT+yCfyoG+jIGicNCwE
 pUCtK9uA77QGn0ZnaRxcDqBf12Ms0fyAZgO6EzLzdSGFNkK6duZR78I7BcxFq2ZuMOw/a++hlLk
 QbUIntJOBoQ7eKKBge2/7sqMeJc3DY29I5bAHeZLMnBE4bqd4ZoHCjc0FLUBcG8G+y2mfN2IWIM
 z2FKpSrfGzoYgZIQR9Jm3+V4wi/vEIDj+GrsHAKDP5ROtJSCPYV6uB8+mRhtkDvprma3EmFvmCp
 Wxns5LMsWRcYvZ1ZmsUS7P9FGcw8H4y7ekEEg28iLNltNAmvZvY7h4eNDbGAqzrJJi9Q12LwTTl
 BYypP0F9UFkIUROFiLYg==
X-Received: by 2002:a05:620a:40c6:b0:914:e3ff:e89a with SMTP id
 af79cd13be357-914e3ffec5emr2014203885a.44.1779964879803; 
 Thu, 28 May 2026 03:41:19 -0700 (PDT)
X-Received: by 2002:a05:620a:40c6:b0:914:e3ff:e89a with SMTP id
 af79cd13be357-914e3ffec5emr2014200685a.44.1779964879329; 
 Thu, 28 May 2026 03:41:19 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:41:19 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:30 +0800
Subject: [PATCH v5 09/15] drm/msm/dp: re-arrange dp_display_disable() into
 functional parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-9-a9221c1f1f3b@oss.qualcomm.com>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
In-Reply-To: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=3890;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Gg4tv21+td583ahpOswrb0tuTDaAio5HpF6DslP1vNA=;
 b=sx9y/gqDawpFRVhXuuTJ/PCPoqxJ9NvxKy22y7ghmDb6hM7tJFuIopZfqoq8Ktkk4XNad3s3C
 QKubjTq3H1JDrVvOXWm9gaJO0XEnWKdgU+mpv43JolLNXIEXzCqpkuy
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=OM4XGyaB c=1 sm=1 tr=0 ts=6a181bd0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7LH33tsxRIP6uNRhSrAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Pfuwu10pRMuIoAJxZMay854_DSYaGZxE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwOCBTYWx0ZWRfX11RM4pwbjYg8
 Ad+Yq2y+2CYR6vCsYIRvO7FTkttQyvm56QQ6HXUZ+y4o0oaexVfUWAxBxyfRSTDlLAqEy4uAuaZ
 2OYSiE1MAlVRp5d2ZyU2rOn3I6eC6jERNiQon5Z2SjOsB8LkZGPcsZd5UiJ5yM1BgtyeW68cRle
 eORpPho820jI2LmtwRE4WcOBEGpmrtWglQGiJmXbnuqt18lcjE9//0fJv5bXsHZyFAajON7Z2vd
 FNWcfDIIP9uSPY9kWMNrSl8Wh1xZRUAUuFMVGZYP7bUS1b5IOaBp0uqtqZE4KvVkieg2ObxEiNK
 M3ipUiNx2mAEbcCblCbocAtMo2CG6NzJfYQRbP3UyGBPcrAxstWbx4o0aM05EYiQH/zGWws3vjz
 9PsL1YCKBp7PrvPEwiXBr17HTV4R/PUFwXMvZPDsRCg82GOneX2TNryD20uL2xk0lAGtbRMhwnR
 KIB5/N8NNBIUKIVIRzw==
X-Proofpoint-GUID: Pfuwu10pRMuIoAJxZMay854_DSYaGZxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280108
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
index d8297ebf7d56..fcce67df4660 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2600,7 +2600,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	return ret;
 }
 
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2608,23 +2608,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
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
index cf859f880943..b8dab3f8a7c2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -714,12 +714,20 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
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

