Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB73C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 192B710E8AA;
	Mon, 29 Jun 2026 13:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ti0gehum";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JMCdJob+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9020C10E8B3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:01 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TB5GkP2728583
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G/poH3AEjItoo7L5qbK6e3dZL/yIyyfNWIp0WMuk8fQ=; b=Ti0gehumpTP/8L2C
 7sGfmXxltb+EyzR4rV8Ja+8+wrj4zOozOmBYwS7sbKBkKYUzGLCmA94bB9oYcAxP
 wGANyjJs5pZwIj6Z3HP0AL0pgDGlr9QuQsT3Ignik7z/pvQJBJv27eodWz27cHj5
 SJ33mX6Wl0YLiLFF6Bs9HotiXLov3n+xQSpDSP2Tc+5kyyW5KL5/ei3OPfzy5V1V
 apoi0EBYEtbvwZqbBFwCfQc7tCBx39xlEVptJ4vViYcEhu2SbbyLlJz4ChKF4Nfv
 Ts6qiySj7ctnTokQz4trPLZ8bLpnYKRmN+fzDpUMJX69MQGC+PK0YtSZRiRaByW0
 IBkWSw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3qha8fju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:00 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5bdad49fe15so710214e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739020; x=1783343820;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G/poH3AEjItoo7L5qbK6e3dZL/yIyyfNWIp0WMuk8fQ=;
 b=JMCdJob+StXPFaXObmqRAtXKUxNHbAaQEIOsZ9E7wKx/T8g9ANNAvp4o0c1H1laEwy
 BuFzjuCofiVtn6ZoHXpjUwK3V5Sqy0GpMU55GOe8SLFCJwYarD3eVo826gR5b9plNHta
 XUvyrbzUR7xMvQx4AMPoqCsg/eyp52XQGzr28Gb0Delk9RMQEy6le7DlYNlW8T7vSM7c
 Nj6PzebcCku1hIfcyWGT6oqck8w8etikXYTyiafLhTW6zYe5RUBpKjNf6cUOx2TFUmIQ
 B/Xmjv0hHp4JgAZdyxA0TRfs2APr0ZQzvad1LIZwTDS6s6tq+gEL+KkekqZQzR+MKq5l
 9eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739020; x=1783343820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G/poH3AEjItoo7L5qbK6e3dZL/yIyyfNWIp0WMuk8fQ=;
 b=lT9c7yzctcF8QleJDeGB+JxPGKqbwwO7D2LhzZC3eFHtALSiD88Nw8FhJNulibpdN6
 pOpbmNNdmnGBo4TrtTyrLkffZWG44M7vKFSuk6RYtIyblNDgMwEKAZBW27kny0L1D5yV
 lLZUOjJJGHQBwxtG/h5Avkk7E9BJlwpQgf/VcAMHe6VzqSQF1JHxJpvUVZd098r+phCM
 MGOrvRgt9RUcPmINoqIDgk+6ytwluhbn4iSlciqcD3zXEZMPCg0zdOvWqIVO2KY6Zu2c
 uExtXbdF7jfFz2WHp0tfoX4N32aTvksbiRAf+LNteOCtAh3hmkO8Nkf0GOr5UuWeZaLB
 jeyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RooO+72asM01j3Ms5FEPKWymV8Mwi3R6MSF2VBT0g5Ut+bphoZCiS4I14k0KMwRS7G99LM4u58pi2k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzEGBTTuvXJsV+TJqqCqpla9QKOJgamJYEfB5akOQRoQ7uD0TW
 MbtkUGUQV4iXwooylKJy2dYrBdCY6sUNHJhEPJtIVPdlEmP15Vl7f+tWuK7D+7X2GjnU2vUT3eB
 rbghv0SemRI3pewRk+lDw21URpgUSZg4h7vFfl+SAJ4GurUONK81I7Pm6i5Bu5JzFtVEh0lnNFS
 Czh/Od3A==
X-Gm-Gg: AfdE7cnlBKkDbXB69NqOjWN03cHNIljJh++GwTQtAL7wOXWu+E4H8Qs79MG4uXCFNlq
 UD+8tQyQj89FBfUP11a/YziKml8L6MzZK4JLr8iWI+6XK23cOABZnpbPy9Z3xBpyiZM8CBUOEdw
 SEjcH8mH6Wc/ACV88MzqVDpJw8BDQPbXLBJOy0cpwDgWUJlDxf4JR7RS/obJImyrTEIXeQnO8Hj
 503KNT5YbqGpCwxOKzQFRk5uj9U+P5cMNq/Ppu5JHxqHPcuBhDI+Bh4uRWnZGLgvCdhBTLyHiYj
 biScH5w2//PPn5DYeUjlwzGO0/2388OZYN2Flt6jfoeHkHqU4dAgaMK/DqZDjP/C2dD9r1YmEnk
 SugmRxm17IPjrZPumwE81dGlhQ8B5CfubX6ZPpQqwGY8yhZP5sbF2nqzONuNU9QcSL0MzvZrSCw
 ==
X-Received: by 2002:a05:6122:c8a:b0:5a4:7e8b:3171 with SMTP id
 71dfb90a1353d-5bd69da3acdmr7383642e0c.11.1782739019892; 
 Mon, 29 Jun 2026 06:16:59 -0700 (PDT)
X-Received: by 2002:a05:6122:c8a:b0:5a4:7e8b:3171 with SMTP id
 71dfb90a1353d-5bd69da3acdmr7383603e0c.11.1782739019495; 
 Mon, 29 Jun 2026 06:16:59 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:16:59 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:24 +0800
Subject: [PATCH v5 06/25] drm/msm/dp: Add support to enable MST in mainlink
 control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-6-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=2592;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Mzn/mLQcqys/EJpBrtkVNH08m5/h5cbmf+/AjWnre0k=;
 b=4XjPuruS92hOctRGAyXEjiLK0lN0g678mz+ntFwexktPlD1SIlyk++U63JB0w8wv3Pb2g1GAX
 6Ur/Pseu19xBFwmaae3hEWmd1ZvmRnYhe1aWEZA3gZfAEqAMr7pEyRg
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: o3LQJte7gyow-XnGuV8VU3MEF9NDyR5k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX8aXfV+vU1bKQ
 Gvgx4AVAt1aOMoZ0hHoyqdinbjzQk7VUq3Lzn5N8ti6RL6Ytvpq1lU3uFPfQMFcqtwII5a5Dw/W
 76AqXHM/gN7BrCq8QLT1Ke8UdSXuK2rEtyHPDutEfcakFRWUGlMHrslW/i45UmgQLYrY6Yrvh+Z
 YK2T+r1CyLxts2MmerOhbWj6nYDRJEuQVsUCQ2+yqgIMjDiHOYBTtRijIxVuXZjA57gFH3AYXYO
 Z8mdzEFARj/GeX9L8xx0n4shKW0wtFPHsnyuSCmY5/8KqB1hld4KteRFa4jeMCbmVYItF82EV12
 48SElSs9aJexSqGdRTneYVWXfQoNYtvmRCU12M3afMHpfhSG3Hpmc6qvZK0SL6/NPe5GnACD1N3
 oYwl58WeStNUt8PLcKHo4N/uolGhVcVvyb0TxEp5ANYkynjKEjWTHN4XKc1/GDq1bD7hb+ekEqr
 Qafvj5KtGLvOnZwC0PA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXy1N/VLbXOq5j
 l4fFdvgXuSyGfMVNedcOoGWG2EOqV051IBft5y2wdx76QXC1eIpLRiba3pBIi/GA05j/9aE4gaK
 rfnHdxsoTHCKtlP9HzQcrLtNZe6f6cU=
X-Authority-Analysis: v=2.4 cv=O9UJeh9W c=1 sm=1 tr=0 ts=6a42704c cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GJT6Fafo9oTAj6z5dyEA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: o3LQJte7gyow-XnGuV8VU3MEF9NDyR5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

Add support to program the MST enable bit in the mainlink control
register when an MST session is active or being disabled.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 17 +++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_reg.h  |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 6754b10d418c..e9aa0e254234 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -276,6 +276,19 @@ int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
 	return 0;
 }
 
+static void msm_dp_ctrl_mst_config(struct msm_dp_ctrl_private *ctrl, bool enable)
+{
+	u32 mainlink_ctrl;
+
+	mainlink_ctrl = msm_dp_read_link(ctrl, REG_DP_MAINLINK_CTRL);
+	if (enable)
+		mainlink_ctrl |= DP_MAINLINK_CTRL_MST_EN;
+	else
+		mainlink_ctrl &= ~DP_MAINLINK_CTRL_MST_EN;
+
+	msm_dp_write_link(ctrl, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
+}
+
 /*
  * NOTE: resetting DP controller will also clear any pending HPD related interrupts
  */
@@ -2678,6 +2691,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
+	if (ctrl->mst_active)
+		msm_dp_ctrl_mst_config(ctrl, true);
+
 	if (panel->stream_id == DP_STREAM_0)
 		msm_dp_ctrl_config_ctrl_link(ctrl, panel);
 
@@ -2731,6 +2747,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	phy = ctrl->phy;
 
 	msm_dp_ctrl_mainlink_disable(ctrl);
+	msm_dp_ctrl_mst_config(ctrl, false);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 6808965878d4..deb40ed24654 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -128,6 +128,10 @@
 #define DP_MAINLINK_FLUSH_MODE_UPDATE_SDP	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 1)
 #define DP_MAINLINK_FLUSH_MODE_SDE_PERIPH_UPDATE	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 3)
 #define DP_MAINLINK_FB_BOUNDARY_SEL		(0x02000000)
+#define DP_MAINLINK_CTRL_ECF_MODE		BIT(26)
+#define DP_MAINLINK_CTRL_MST_ACTIVE		BIT(8)
+#define DP_MAINLINK_CTRL_MST_EN			(DP_MAINLINK_CTRL_ECF_MODE | \
+						DP_MAINLINK_CTRL_MST_ACTIVE)
 
 #define REG_DP_STATE_CTRL			(0x00000004)
 #define DP_STATE_CTRL_LINK_TRAINING_PATTERN1	(0x00000001)

-- 
2.43.0

