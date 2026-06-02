Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B32CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6235010EDA5;
	Tue,  2 Jun 2026 09:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cQUCxNQG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AUksO/4s";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0429510EDA5
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:12:12 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652452B71937322
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VmZT1gSX0SYi9K0NfM0grDl/MdLFvJ3fRETebuBTp1g=; b=cQUCxNQGvvAzBL7a
 YPXhQt3l+qQPkXvq4QSJOLQWhsjlXwDloIYF6NvJyTLa2EqZgewmStEeAhzD2z/D
 6ssOJO2coEOpFo89UzU/vATzlFWv82faP7g2J21GzzOrJywCePFNciqTFxq1nZKW
 TsuAtnwIuxQ8VWZBIzxlaiHhVy/Vcshn6d+SKypEa6fOyqQJiDRD1APXGL8E+i1O
 cNlWGvArJT9gmPwEdfBqLEDD/Y+Qb5hdvhkWM4KKTH1QF4MqdO8ep7GJ6i+s1RMh
 +/d0nsnGmT5F/TAhtjNq98aQim+dgEFZlqdMrs6SwnnGAB2IQf2ULzL968yGoAug
 9fh/vw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqubh601-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:12:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516d4b3f3a1so222127101cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391531; x=1780996331;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VmZT1gSX0SYi9K0NfM0grDl/MdLFvJ3fRETebuBTp1g=;
 b=AUksO/4svcqgiRxVkmQa/PhK36JmYpwyQ2iayYGvZ9nWdkwAaRHoKlxNlcdWpccD11
 VoFXXv4Tfvgphvz6owG0y8VkAaoz4+LbndXdl6C1Yg8TiJ+t9yD4jNQxhVDK+9sTqhyB
 +XwmhtViGmdA6xcG7OXlvoF8lr7jHbsLv07o3awf+2IiJFftN+OIUHe3lB2+KoJXHcKw
 hTFSFsXNG9SaWIrJSS6ihfVNKeC/POZoa55dusrnNbrYNujZeUaIIOF9tlOh4qkWsCTX
 Ry0teicxk7xGy8j+9fJKIwguv+xAFKrUf9xYekE+QcznrRM8gxW4WK4wBzYXbGhSMQTW
 NGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391531; x=1780996331;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VmZT1gSX0SYi9K0NfM0grDl/MdLFvJ3fRETebuBTp1g=;
 b=C7rooNEYrMn/s0ilr6g6Ba5OaG41DLk7smWKaqmZg7sKfVGWAiXm7+x+hyxQIxTUvH
 5lbm9ca2EiDt5hR/8nyQicv4GhZDQM5+uhuT0AphZKM3Fh5LdEJpczhiHe6hDJHcFYsE
 60FwsHmG1257Dr4En9btIim6Yd2tkEESQ8flAA7Quolk/I2030upx/dAEHfH28GEmBDS
 MxEkJrFENFiq/sdW1tnYFcMWoJrtq+zzX7qCoXN+gDZkISpENoHb0Mu0d7r344Qp99f2
 5Hszfn4sh3YlG6nW9MxNlNeRm6IaP27yvc67+sE5QrpPtvgGS7UoFojIRb5s5ef+OdtS
 Bivw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/GVw0iEvPu9iF9FnMzPdwFr/jHmic/bVZlBYs8jArHAgkPDSaELlUVuyId1YV0pEUJT10nC5CBPs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzK3Aor69v1nSq6qLdL1DbiILLR6NhVvTb9IeyQ31oQLf4y5k4D
 YTNr3rzMwCMOq0jO2bAXQI8w0ZJZN1pjtxKOa40dLQFI5WEVP2CQwQ4MBhHY9XQo5aWoltPhHyb
 FH4ZJFxqjEvuUiXyUb/Qcm4R/N7RixVat50sGxATbOOs+MiyBxSQhcUFI+q5Qf2bPoYvhk0U=
X-Gm-Gg: Acq92OHCcJQqiaWHT9fcpsa2aCcyK7VimIdSCQ/fW1CgU6U400jP2xF+aqgznAT/Mqv
 2aTP3OJFyRDDjjEdt7Qk9iZuF25IP3Lrbz0kPTjKAyz5KN5CO8QYZR3uDCkGgDYEY6j+lIQ0Xiz
 FvUHaXfD7LjCvY9fvUstCOL4tugcDKOAYTwFwtcyXWOVe2B9rpVFoZ9OAZ8EdS2xU5IpiyiWLzp
 bcuXDaEvaGK4oXDPEITdzeWRkQ5FuOlDH9mwHB24i6Vx7zTfMkJNVXybIPI7b9UjehyNFfKvDMB
 U71HiHRqHVLQgiva52Jcm632sUl2xlzPK9D+yh3HyQf+LN5Zdcku5jrmV5iw1UCGp8IC3dXjSnI
 eS4fj7HnOGS7j290KhAgNmstSswqom3P/vTzAAek22gCXh7TOF1MYnhbuwkrk/4+G4mHFDnbf0w
 jKfgjE5EZtw0y65TEpuQ==
X-Received: by 2002:a05:622a:199d:b0:517:7246:8781 with SMTP id
 d75a77b69052e-51772468aafmr993481cf.8.1780391531173; 
 Tue, 02 Jun 2026 02:12:11 -0700 (PDT)
X-Received: by 2002:a05:622a:199d:b0:517:7246:8781 with SMTP id
 d75a77b69052e-51772468aafmr992911cf.8.1780391530535; 
 Tue, 02 Jun 2026 02:12:10 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:12:10 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:22 +0800
Subject: [PATCH v6 10/15] drm/msm/dp: allow dp_ctrl stream APIs to use any
 panel passed to it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-10-2c17ff40a9b2@oss.qualcomm.com>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
In-Reply-To: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=32290;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=0/xJup617qd9RHy62Q62tgv+NCDfsSbiBTKALpu4TLA=;
 b=PvCJvZ3XBMWjWDWjL4M8ORF4no4nuilzQctn5deU+XL5/rJsXgvui/l51NMdyocuvxytamxJL
 RYKPjUHgZWqD/5iBvKnL/4GOpCEkrrQurrTwB3+UImlN/WLaezpw28e
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: D04eZFrJnUL_uV5BpHu9bhtONKH6xD9X
X-Proofpoint-GUID: D04eZFrJnUL_uV5BpHu9bhtONKH6xD9X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfX1OvvLHj5kQ3o
 Y6Vi19YlExputsqIH9AOVaLkvhI98lzprxUKF3LfMvq8Nu6KGBUxdreF1eJvXlI4HFxsdcVeqWf
 fNldDk1ApSVHJWnICKn9BxHLyvZLk0U0N0U3HP7c9tGL4q+WF/k/cIjhGnVkCLCrZAh4BdUcepS
 zT3Rt4gZCH+U+mw+vEK0WnDgg3MJ0ujbdd1cKx19K/DdhP3wfX+DHMKCXpEBbBZXcE/v/nI6C9d
 OFzuEzFZgiNU+cEeb/U8uTOryABsuWZQ0Q4ghAgMrRl3MNTS6LnsyceTx+k/odsmjXZCyyYsySK
 pG0lUgTyvUNqgt8QofxgE/IN9V8MNu+kw685ItaxHaLcl7K4cQsO9b+gTYjY76OSSB3XByNLLCm
 PbfkwvhUoheM9ObrSeFtjthjFYa/zhR0DIVESoVt9OGROwwCoL0pYl8lEZ0LiG4Ui8dOXuIVwLS
 9vXuCcJ/2eQD7sFGHiA==
X-Authority-Analysis: v=2.4 cv=FcoHAp+6 c=1 sm=1 tr=0 ts=6a1e9e6c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=531mWe0hPKX_9nM1v_MA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020086
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

With MST, multiple sinks share a single DP controller, so a cached
panel in msm_dp_ctrl_private can no longer represent the per-stream
sink. Drop the cache and pass panel explicitly to all stream-related
dp_ctrl APIs.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 196 ++++++++++++++++++++----------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  28 ++++--
 drivers/gpu/drm/msm/dp/dp_display.c |  24 ++---
 3 files changed, 140 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index d0c5ffb907e5..902a6f5d181d 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -114,7 +114,6 @@ struct msm_dp_ctrl_private {
 	struct drm_device *drm_dev;
 	struct device *dev;
 	struct drm_dp_aux *aux;
-	struct msm_dp_panel *panel;
 	struct msm_dp_link *link;
 	void __iomem *ahb_base;
 	void __iomem *link_base;
@@ -202,7 +201,8 @@ static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
 /*
  * NOTE: resetting DP controller will also clear any pending HPD related interrupts
  */
-void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctrl,
+		       struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl =
 		container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
@@ -219,7 +219,7 @@ void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	if (!ctrl->hw_revision) {
 		ctrl->hw_revision = msm_dp_read_ahb(ctrl, REG_DP_HW_VERSION);
-		ctrl->panel->hw_revision = ctrl->hw_revision;
+		panel->hw_revision = ctrl->hw_revision;
 	}
 }
 
@@ -414,10 +414,11 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
 	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
 }
 
-static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl,
+					 struct msm_dp_panel *panel)
 {
 	u32 config = 0;
-	const u8 *dpcd = ctrl->panel->dpcd;
+	const u8 *dpcd = panel->dpcd;
 
 	/* Default-> LSCLK DIV: 1/4 LCLK  */
 	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
@@ -480,13 +481,14 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
 }
 
-static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl,
+						struct msm_dp_panel *panel)
 {
-	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, panel);
 
-	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
+	msm_dp_ctrl_config_misc1_misc0(ctrl, panel);
 
-	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
+	msm_dp_panel_timing_cfg(panel, ctrl->msm_dp_ctrl.wide_bus_en);
 }
 
 /*
@@ -1256,20 +1258,21 @@ static void _dp_ctrl_calc_tu(struct msm_dp_ctrl_private *ctrl,
 }
 
 static void msm_dp_ctrl_calc_tu_parameters(struct msm_dp_ctrl_private *ctrl,
+		struct msm_dp_panel *panel,
 		struct msm_dp_vc_tu_mapping_table *tu_table)
 {
 	struct msm_dp_tu_calc_input in;
-	struct drm_display_mode *drm_mode;
+	const struct drm_display_mode *drm_mode;
 
-	drm_mode = &ctrl->panel->msm_dp_mode.drm_mode;
+	drm_mode = &panel->msm_dp_mode.drm_mode;
 
 	in.lclk = ctrl->link->link_params.rate / 1000;
 	in.pclk_khz = drm_mode->clock;
 	in.hactive = drm_mode->hdisplay;
 	in.hporch = drm_mode->htotal - drm_mode->hdisplay;
 	in.nlanes = ctrl->link->link_params.num_lanes;
-	in.bpp = ctrl->panel->msm_dp_mode.bpp;
-	in.pixel_enc = ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420 ? 420 : 444;
+	in.bpp = panel->msm_dp_mode.bpp;
+	in.pixel_enc = panel->msm_dp_mode.out_fmt_is_yuv_420 ? 420 : 444;
 	in.dsc_en = 0;
 	in.async_en = 0;
 	in.fec_en = 0;
@@ -1279,14 +1282,15 @@ static void msm_dp_ctrl_calc_tu_parameters(struct msm_dp_ctrl_private *ctrl,
 	_dp_ctrl_calc_tu(ctrl, &in, tu_table);
 }
 
-static void msm_dp_ctrl_setup_tr_unit(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_setup_tr_unit(struct msm_dp_ctrl_private *ctrl,
+				      struct msm_dp_panel *panel)
 {
 	u32 msm_dp_tu = 0x0;
 	u32 valid_boundary = 0x0;
 	u32 valid_boundary2 = 0x0;
 	struct msm_dp_vc_tu_mapping_table tu_calc_table;
 
-	msm_dp_ctrl_calc_tu_parameters(ctrl, &tu_calc_table);
+	msm_dp_ctrl_calc_tu_parameters(ctrl, panel, &tu_calc_table);
 
 	msm_dp_tu |= tu_calc_table.tu_size_minus1;
 	valid_boundary |= tu_calc_table.valid_boundary_link;
@@ -1438,6 +1442,7 @@ static int msm_dp_ctrl_set_pattern_state_bit(struct msm_dp_ctrl_private *ctrl,
 }
 
 static int msm_dp_ctrl_link_train_1(struct msm_dp_ctrl_private *ctrl,
+			struct msm_dp_panel *panel,
 			int *training_step, enum drm_dp_phy dp_phy)
 {
 	int delay_us;
@@ -1446,7 +1451,7 @@ static int msm_dp_ctrl_link_train_1(struct msm_dp_ctrl_private *ctrl,
 	int const maximum_retries = 4;
 
 	delay_us = drm_dp_read_clock_recovery_delay(ctrl->aux,
-						    ctrl->panel->dpcd, dp_phy, false);
+						    panel->dpcd, dp_phy, false);
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, 0);
 
@@ -1532,14 +1537,15 @@ static int msm_dp_ctrl_link_rate_down_shift(struct msm_dp_ctrl_private *ctrl)
 	return ret;
 }
 
-static int msm_dp_ctrl_link_lane_down_shift(struct msm_dp_ctrl_private *ctrl)
+static int msm_dp_ctrl_link_lane_down_shift(struct msm_dp_ctrl_private *ctrl,
+					    struct msm_dp_panel *panel)
 {
 
 	if (ctrl->link->link_params.num_lanes == 1)
 		return -1;
 
 	ctrl->link->link_params.num_lanes /= 2;
-	ctrl->link->link_params.rate = ctrl->panel->link_info.rate;
+	ctrl->link->link_params.rate = panel->link_info.rate;
 
 	ctrl->link->phy_params.p_level = 0;
 	ctrl->link->phy_params.v_level = 0;
@@ -1548,6 +1554,7 @@ static int msm_dp_ctrl_link_lane_down_shift(struct msm_dp_ctrl_private *ctrl)
 }
 
 static void msm_dp_ctrl_clear_training_pattern(struct msm_dp_ctrl_private *ctrl,
+					       struct msm_dp_panel *panel,
 					       enum drm_dp_phy dp_phy)
 {
 	int delay_us;
@@ -1555,11 +1562,12 @@ static void msm_dp_ctrl_clear_training_pattern(struct msm_dp_ctrl_private *ctrl,
 	msm_dp_ctrl_train_pattern_set(ctrl, DP_TRAINING_PATTERN_DISABLE, dp_phy);
 
 	delay_us = drm_dp_read_channel_eq_delay(ctrl->aux,
-						ctrl->panel->dpcd, dp_phy, false);
+						panel->dpcd, dp_phy, false);
 	fsleep(delay_us);
 }
 
 static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
+			struct msm_dp_panel *panel,
 			int *training_step, enum drm_dp_phy dp_phy)
 {
 	int delay_us;
@@ -1570,16 +1578,16 @@ static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
 	u8 link_status[DP_LINK_STATUS_SIZE];
 
 	delay_us = drm_dp_read_channel_eq_delay(ctrl->aux,
-						ctrl->panel->dpcd, dp_phy, false);
+						panel->dpcd, dp_phy, false);
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, 0);
 
 	*training_step = DP_TRAINING_2;
 
-	if (drm_dp_tps4_supported(ctrl->panel->dpcd)) {
+	if (drm_dp_tps4_supported(panel->dpcd)) {
 		pattern = DP_TRAINING_PATTERN_4;
 		state_ctrl_bit = 4;
-	} else if (drm_dp_tps3_supported(ctrl->panel->dpcd)) {
+	} else if (drm_dp_tps3_supported(panel->dpcd)) {
 		pattern = DP_TRAINING_PATTERN_3;
 		state_ctrl_bit = 3;
 	} else {
@@ -1616,18 +1624,19 @@ static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
 }
 
 static int msm_dp_ctrl_link_train_1_2(struct msm_dp_ctrl_private *ctrl,
+				      struct msm_dp_panel *panel,
 				      int *training_step, enum drm_dp_phy dp_phy)
 {
 	int ret;
 
-	ret = msm_dp_ctrl_link_train_1(ctrl, training_step, dp_phy);
+	ret = msm_dp_ctrl_link_train_1(ctrl, panel, training_step, dp_phy);
 	if (ret) {
 		DRM_ERROR("link training #1 on phy %d failed. ret=%d\n", dp_phy, ret);
 		return ret;
 	}
 	drm_dbg_dp(ctrl->drm_dev, "link training #1 on phy %d successful\n", dp_phy);
 
-	ret = msm_dp_ctrl_link_train_2(ctrl, training_step, dp_phy);
+	ret = msm_dp_ctrl_link_train_2(ctrl, panel, training_step, dp_phy);
 	if (ret) {
 		DRM_ERROR("link training #2 on phy %d failed. ret=%d\n", dp_phy, ret);
 		return ret;
@@ -1638,16 +1647,17 @@ static int msm_dp_ctrl_link_train_1_2(struct msm_dp_ctrl_private *ctrl,
 }
 
 static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
+			struct msm_dp_panel *panel,
 			int *training_step)
 {
 	int i;
 	int ret = 0;
-	const u8 *dpcd = ctrl->panel->dpcd;
+	const u8 *dpcd = panel->dpcd;
 	u8 encoding[] = { 0, DP_SET_ANSI_8B10B };
 	u8 assr;
 	struct msm_dp_link_info link_info = {0};
 
-	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl, panel);
 
 	link_info.num_lanes = ctrl->link->link_params.num_lanes;
 	link_info.rate = ctrl->link->link_params.rate;
@@ -1670,8 +1680,8 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 	for (i = ctrl->link->lttpr_count - 1; i >= 0; i--) {
 		enum drm_dp_phy dp_phy = DP_PHY_LTTPR(i);
 
-		ret = msm_dp_ctrl_link_train_1_2(ctrl, training_step, dp_phy);
-		msm_dp_ctrl_clear_training_pattern(ctrl, dp_phy);
+		ret = msm_dp_ctrl_link_train_1_2(ctrl, panel, training_step, dp_phy);
+		msm_dp_ctrl_clear_training_pattern(ctrl, panel, dp_phy);
 
 		if (ret)
 			break;
@@ -1682,7 +1692,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 		goto end;
 	}
 
-	ret = msm_dp_ctrl_link_train_1_2(ctrl, training_step, DP_PHY_DPRX);
+	ret = msm_dp_ctrl_link_train_1_2(ctrl, panel, training_step, DP_PHY_DPRX);
 	if (ret) {
 		DRM_ERROR("link training on sink failed. ret=%d\n", ret);
 		goto end;
@@ -1695,6 +1705,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 }
 
 static int msm_dp_ctrl_setup_main_link(struct msm_dp_ctrl_private *ctrl,
+			struct msm_dp_panel *panel,
 			int *training_step)
 {
 	int ret = 0;
@@ -1710,7 +1721,7 @@ static int msm_dp_ctrl_setup_main_link(struct msm_dp_ctrl_private *ctrl,
 	 * a link training pattern, we have to first do soft reset.
 	 */
 
-	ret = msm_dp_ctrl_link_train(ctrl, training_step);
+	ret = msm_dp_ctrl_link_train(ctrl, panel, training_step);
 
 	return ret;
 }
@@ -1809,11 +1820,12 @@ static void msm_dp_ctrl_link_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl)
 		   str_on_off(ctrl->core_clks_on));
 }
 
-static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private *ctrl)
+static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private *ctrl,
+					      struct msm_dp_panel *panel)
 {
 	int ret = 0;
 	struct phy *phy = ctrl->phy;
-	const u8 *dpcd = ctrl->panel->dpcd;
+	const u8 *dpcd = panel->dpcd;
 
 	ctrl->phy_opts.dp.lanes = ctrl->link->link_params.num_lanes;
 	ctrl->phy_opts.dp.link_rate = ctrl->link->link_params.rate / 100;
@@ -1865,13 +1877,14 @@ static void msm_dp_ctrl_psr_exit(struct msm_dp_ctrl_private *ctrl)
 	msm_dp_write_link(ctrl, REG_PSR_CMD, cmd);
 }
 
-void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *msm_dp_ctrl,
+			    struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl = container_of(msm_dp_ctrl,
 			struct msm_dp_ctrl_private, msm_dp_ctrl);
 	u32 cfg;
 
-	if (!ctrl->panel->psr_cap.version)
+	if (!panel->psr_cap.version)
 		return;
 
 	/* enable PSR1 function */
@@ -1886,12 +1899,13 @@ void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *msm_dp_ctrl)
 	drm_dp_dpcd_write(ctrl->aux, DP_PSR_EN_CFG, &cfg, 1);
 }
 
-void msm_dp_ctrl_set_psr(struct msm_dp_ctrl *msm_dp_ctrl, bool enter)
+void msm_dp_ctrl_set_psr(struct msm_dp_ctrl *msm_dp_ctrl,
+			 struct msm_dp_panel *panel, bool enter)
 {
 	struct msm_dp_ctrl_private *ctrl = container_of(msm_dp_ctrl,
 			struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	if (!ctrl->panel->psr_cap.version)
+	if (!panel->psr_cap.version)
 		return;
 
 	/*
@@ -1961,7 +1975,8 @@ void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl)
 	phy_exit(phy);
 }
 
-static int msm_dp_ctrl_reinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
+static int msm_dp_ctrl_reinitialize_mainlink(struct msm_dp_ctrl_private *ctrl,
+					     struct msm_dp_panel *panel)
 {
 	struct phy *phy = ctrl->phy;
 	int ret = 0;
@@ -1982,7 +1997,7 @@ static int msm_dp_ctrl_reinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
 	/* hw recommended delay before re-enabling clocks */
 	msleep(20);
 
-	ret = msm_dp_ctrl_enable_mainlink_clocks(ctrl);
+	ret = msm_dp_ctrl_enable_mainlink_clocks(ctrl, panel);
 	if (ret) {
 		DRM_ERROR("Failed to enable mainlink clks. ret=%d\n", ret);
 		return ret;
@@ -1991,7 +2006,8 @@ static int msm_dp_ctrl_reinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
 	return ret;
 }
 
-static int msm_dp_ctrl_deinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
+static int msm_dp_ctrl_deinitialize_mainlink(struct msm_dp_ctrl_private *ctrl,
+					     struct msm_dp_panel *panel)
 {
 	struct phy *phy;
 
@@ -1999,7 +2015,7 @@ static int msm_dp_ctrl_deinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
 
 	msm_dp_ctrl_mainlink_disable(ctrl);
 
-	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
@@ -2013,7 +2029,8 @@ static int msm_dp_ctrl_deinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
 	return 0;
 }
 
-static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
+static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl,
+					struct msm_dp_panel *panel)
 {
 	int ret = 0;
 	int training_step = DP_TRAINING_NONE;
@@ -2023,11 +2040,11 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
 	ctrl->link->phy_params.p_level = 0;
 	ctrl->link->phy_params.v_level = 0;
 
-	ret = msm_dp_ctrl_setup_main_link(ctrl, &training_step);
+	ret = msm_dp_ctrl_setup_main_link(ctrl, panel, &training_step);
 	if (ret)
 		goto end;
 
-	msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
+	msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 
@@ -2207,7 +2224,8 @@ static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
 	}
 }
 
-static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl)
+static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl,
+						struct msm_dp_panel *panel)
 {
 	int ret;
 	unsigned long pixel_rate;
@@ -2223,15 +2241,15 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	 * running. Add the global reset just before disabling the
 	 * link clocks and core clocks.
 	 */
-	msm_dp_ctrl_off(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off(&ctrl->msm_dp_ctrl, panel);
 
-	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
+	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
 	if (ret) {
 		DRM_ERROR("failed to enable DP link controller\n");
 		return ret;
 	}
 
-	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
+	pixel_rate = panel->msm_dp_mode.drm_mode.clock;
 	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
 
 	msm_dp_ctrl_send_phy_test_pattern(ctrl);
@@ -2239,7 +2257,8 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	return 0;
 }
 
-void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
+				     struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	u32 sink_request = 0x0;
@@ -2254,14 +2273,14 @@ void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	if (sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {
 		drm_dbg_dp(ctrl->drm_dev, "PHY_TEST_PATTERN request\n");
-		if (msm_dp_ctrl_process_phy_test_request(ctrl)) {
+		if (msm_dp_ctrl_process_phy_test_request(ctrl, panel)) {
 			DRM_ERROR("process phy_test_req failed\n");
 			return;
 		}
 	}
 
 	if (sink_request & DP_LINK_STATUS_UPDATED) {
-		if (msm_dp_ctrl_link_maintenance(ctrl)) {
+		if (msm_dp_ctrl_link_maintenance(ctrl, panel)) {
 			DRM_ERROR("LM failed: TEST_LINK_TRAINING\n");
 			return;
 		}
@@ -2269,7 +2288,7 @@ void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	if (sink_request & DP_TEST_LINK_TRAINING) {
 		msm_dp_link_send_test_response(ctrl->link);
-		if (msm_dp_ctrl_link_maintenance(ctrl)) {
+		if (msm_dp_ctrl_link_maintenance(ctrl, panel)) {
 			DRM_ERROR("LM failed: TEST_LINK_TRAINING\n");
 			return;
 		}
@@ -2305,7 +2324,8 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp_ctrl_private *ctrl)
 	return drm_dp_channel_eq_ok(link_status, num_lanes);
 }
 
-int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
+int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			struct msm_dp_panel *panel)
 {
 	int rc = 0;
 	struct msm_dp_ctrl_private *ctrl;
@@ -2321,8 +2341,8 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	rate = ctrl->panel->link_info.rate;
-	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
+	rate = panel->link_info.rate;
+	pixel_rate = panel->msm_dp_mode.drm_mode.clock;
 
 	msm_dp_ctrl_core_clk_enable(&ctrl->msm_dp_ctrl);
 
@@ -2334,8 +2354,8 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
 	} else {
 		ctrl->link->link_params.rate = rate;
 		ctrl->link->link_params.num_lanes =
-			ctrl->panel->link_info.num_lanes;
-		if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
+			panel->link_info.num_lanes;
+		if (panel->msm_dp_mode.out_fmt_is_yuv_420)
 			pixel_rate >>= 1;
 	}
 
@@ -2343,13 +2363,13 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
 		ctrl->link->link_params.rate, ctrl->link->link_params.num_lanes,
 		pixel_rate);
 
-	rc = msm_dp_ctrl_enable_mainlink_clocks(ctrl);
+	rc = msm_dp_ctrl_enable_mainlink_clocks(ctrl, panel);
 	if (rc)
 		return rc;
 
 	while (--link_train_max_retries) {
 		training_step = DP_TRAINING_NONE;
-		rc = msm_dp_ctrl_setup_main_link(ctrl, &training_step);
+		rc = msm_dp_ctrl_setup_main_link(ctrl, panel, &training_step);
 		if (rc == 0) {
 			/* training completed successfully */
 			break;
@@ -2368,7 +2388,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
 					 * some lanes are ready,
 					 * reduce lane number
 					 */
-					rc = msm_dp_ctrl_link_lane_down_shift(ctrl);
+					rc = msm_dp_ctrl_link_lane_down_shift(ctrl, panel);
 					if (rc < 0) { /* lane == 1 already */
 						/* end with failure */
 						break;
@@ -2389,7 +2409,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
 					ctrl->link->link_params.num_lanes))
 				rc = msm_dp_ctrl_link_rate_down_shift(ctrl);
 			else
-				rc = msm_dp_ctrl_link_lane_down_shift(ctrl);
+				rc = msm_dp_ctrl_link_lane_down_shift(ctrl, panel);
 
 			if (rc < 0) {
 				/* end with failure */
@@ -2397,10 +2417,10 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
 			}
 
 			/* stop link training before start re training  */
-			msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
+			msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
 		}
 
-		rc = msm_dp_ctrl_reinitialize_mainlink(ctrl);
+		rc = msm_dp_ctrl_reinitialize_mainlink(ctrl, panel);
 		if (rc) {
 			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n", rc);
 			break;
@@ -2421,20 +2441,21 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
 		 * link training failed
 		 * end txing train pattern here
 		 */
-		msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
+		msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
 
-		msm_dp_ctrl_deinitialize_mainlink(ctrl);
+		msm_dp_ctrl_deinitialize_mainlink(ctrl, panel);
 		rc = -ECONNRESET;
 	}
 
 	return rc;
 }
 
-static int msm_dp_ctrl_link_retrain(struct msm_dp_ctrl_private *ctrl)
+static int msm_dp_ctrl_link_retrain(struct msm_dp_ctrl_private *ctrl,
+				    struct msm_dp_panel *panel)
 {
 	int training_step = DP_TRAINING_NONE;
 
-	return msm_dp_ctrl_setup_main_link(ctrl, &training_step);
+	return msm_dp_ctrl_setup_main_link(ctrl, panel, &training_step);
 }
 
 static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
@@ -2505,7 +2526,9 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
 	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_NVID, nvid);
 }
 
-int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train)
+int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
+				  struct msm_dp_panel *panel,
+				  bool force_link_train)
 {
 	int ret = 0;
 	struct msm_dp_ctrl_private *ctrl;
@@ -2524,7 +2547,7 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li
 		ctrl->core_clks_on, ctrl->link_clks_on, ctrl->stream_clks_on);
 
 	if (!ctrl->link_clks_on) { /* link clk is off */
-		ret = msm_dp_ctrl_enable_mainlink_clocks(ctrl);
+		ret = msm_dp_ctrl_enable_mainlink_clocks(ctrl, panel);
 		if (ret) {
 			DRM_ERROR("Failed to start link clocks. ret=%d\n", ret);
 			return ret;
@@ -2532,15 +2555,15 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li
 	}
 
 	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
-		msm_dp_ctrl_link_retrain(ctrl);
+		msm_dp_ctrl_link_retrain(ctrl, panel);
 
 	/* stop txing train pattern to end link training */
-	msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
+	msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
 
 	return ret;
 }
 
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel)
 {
 	int ret = 0;
 	bool mainlink_ready = false;
@@ -2553,10 +2576,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	pixel_rate_orig = ctrl->panel->msm_dp_mode.drm_mode.clock;
+	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
 	pixel_rate = pixel_rate_orig;
 
-	if (msm_dp_ctrl->wide_bus_en || ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
+	if (msm_dp_ctrl->wide_bus_en || panel->msm_dp_mode.out_fmt_is_yuv_420)
 		pixel_rate >>= 1;
 
 	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
@@ -2573,18 +2596,18 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
-	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl, panel);
 
-	msm_dp_ctrl_configure_source_params(ctrl);
+	msm_dp_ctrl_configure_source_params(ctrl, panel);
 
 	msm_dp_ctrl_config_msa(ctrl,
 		ctrl->link->link_params.rate,
 		pixel_rate_orig,
-		ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420);
+		panel->msm_dp_mode.out_fmt_is_yuv_420);
 
-	msm_dp_panel_clear_dsc_dto(ctrl->panel);
+	msm_dp_panel_clear_dsc_dto(panel);
 
-	msm_dp_ctrl_setup_tr_unit(ctrl);
+	msm_dp_ctrl_setup_tr_unit(ctrl, panel);
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 
@@ -2612,7 +2635,8 @@ void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 	phy_init(phy);
 }
 
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
+		     struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2620,11 +2644,11 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 	phy = ctrl->phy;
 
-	msm_dp_panel_disable_vsc_sdp(ctrl->panel);
+	msm_dp_panel_disable_vsc_sdp(panel);
 
 	msm_dp_ctrl_mainlink_disable(ctrl);
 
-	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
 	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl);
 	dev_pm_opp_set_rate(ctrl->dev, 0);
@@ -2633,7 +2657,8 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 	phy_power_off(phy);
 }
 
-irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
+irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
+			    struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	u32 isr;
@@ -2644,7 +2669,7 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	if (ctrl->panel->psr_cap.version) {
+	if (panel->psr_cap.version) {
 		isr = msm_dp_ctrl_get_psr_interrupt(ctrl);
 
 		if (isr)
@@ -2733,7 +2758,7 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 }
 
 struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
-			struct msm_dp_panel *panel,	struct drm_dp_aux *aux,
+			struct drm_dp_aux *aux,
 			struct phy *phy,
 			void __iomem *ahb_base,
 			void __iomem *link_base)
@@ -2741,7 +2766,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
 	struct msm_dp_ctrl_private *ctrl;
 	int ret;
 
-	if (!dev || !panel || !aux || !link) {
+	if (!dev || !aux || !link) {
 		DRM_ERROR("invalid input\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -2769,7 +2794,6 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
 	init_completion(&ctrl->video_comp);
 
 	/* in parameters */
-	ctrl->panel    = panel;
 	ctrl->aux      = aux;
 	ctrl->link     = link;
 	ctrl->dev      = dev;
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 5d615f50d13b..00b430392a52 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -16,28 +16,36 @@ struct msm_dp_ctrl {
 
 struct phy;
 
-int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
-int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
+int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			struct msm_dp_panel *panel);
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel);
+int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
+				  struct msm_dp_panel *panel,
+				  bool force_link_train);
+void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
+		     struct msm_dp_panel *panel);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
-irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
-void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl);
+irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
+			    struct msm_dp_panel *panel);
+void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
+				     struct msm_dp_panel *panel);
 struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
 				    struct msm_dp_link *link,
-				    struct msm_dp_panel *panel,
 				    struct drm_dp_aux *aux,
 				    struct phy *phy,
 				    void __iomem *ahb_base,
 				    void __iomem *link_base);
 
-void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctrl,
+		       struct msm_dp_panel *panel);
 void msm_dp_ctrl_phy_init(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_irq_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl);
 
-void msm_dp_ctrl_set_psr(struct msm_dp_ctrl *msm_dp_ctrl, bool enable);
-void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_set_psr(struct msm_dp_ctrl *msm_dp_ctrl,
+			 struct msm_dp_panel *panel, bool enable);
+void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *msm_dp_ctrl,
+			    struct msm_dp_panel *panel);
 
 int msm_dp_ctrl_core_clk_enable(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_core_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index b8dab3f8a7c2..230e14615a23 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -359,7 +359,7 @@ static void msm_dp_display_host_init(struct msm_dp_display_private *dp)
 		dp->phy_initialized);
 
 	msm_dp_ctrl_core_clk_enable(dp->ctrl);
-	msm_dp_ctrl_reset(dp->ctrl);
+	msm_dp_ctrl_reset(dp->ctrl, dp->panel);
 	msm_dp_ctrl_enable_irq(dp->ctrl);
 	msm_dp_aux_init(dp->aux);
 	dp->core_initialized = true;
@@ -371,7 +371,7 @@ static void msm_dp_display_host_deinit(struct msm_dp_display_private *dp)
 		dp->msm_dp_display.connector_type, dp->core_initialized,
 		dp->phy_initialized);
 
-	msm_dp_ctrl_reset(dp->ctrl);
+	msm_dp_ctrl_reset(dp->ctrl, dp->panel);
 	msm_dp_ctrl_disable_irq(dp->ctrl);
 	msm_dp_aux_deinit(dp->aux);
 	msm_dp_ctrl_core_clk_disable(dp->ctrl);
@@ -392,7 +392,7 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
 
 	drm_dbg_dp(dp->drm_dev, "%d\n", sink_request);
 
-	msm_dp_ctrl_handle_sink_request(dp->ctrl);
+	msm_dp_ctrl_handle_sink_request(dp->ctrl, dp->panel);
 
 	if (sink_request & DP_TEST_LINK_VIDEO_PATTERN)
 		msm_dp_display_handle_video_request(dp);
@@ -570,7 +570,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		goto error_link;
 	}
 
-	dp->ctrl = msm_dp_ctrl_get(dev, dp->link, dp->panel, dp->aux,
+	dp->ctrl = msm_dp_ctrl_get(dev, dp->link, dp->aux,
 			       phy, dp->ahb_base, dp->link_base);
 	if (IS_ERR(dp->ctrl)) {
 		rc = PTR_ERR(dp->ctrl);
@@ -642,12 +642,12 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 		force_link_train = true;
 	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl);
+	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
 	if (rc)
 		DRM_ERROR("Failed link training (rc=%d)\n", rc);
 	// TODO: schedule drm_connector_set_link_status_property()
 
-	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
+	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
 }
 
 static int msm_dp_display_enable(struct msm_dp_display_private *dp)
@@ -661,7 +661,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -686,7 +686,7 @@ static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
 	msm_dp_display_handle_plugged_change(msm_dp_display, true);
 
 	if (msm_dp_display->psr_supported)
-		msm_dp_ctrl_config_psr(dp->ctrl);
+		msm_dp_ctrl_config_psr(dp->ctrl, dp->panel);
 
 	return 0;
 }
@@ -725,7 +725,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 		/* set dongle to D3 (power off) mode */
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off(dp->ctrl);
+		msm_dp_ctrl_off(dp->ctrl, dp->panel);
 		/* re-init the PHY so that we can listen to Dongle disconnect */
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	} else {
@@ -733,7 +733,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 		 * unplugged interrupt
 		 * dongle unplugged out of DUT
 		 */
-		msm_dp_ctrl_off(dp->ctrl);
+		msm_dp_ctrl_off(dp->ctrl, dp->panel);
 		msm_dp_display_host_phy_exit(dp);
 	}
 
@@ -869,7 +869,7 @@ void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
 	}
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
-	msm_dp_ctrl_set_psr(dp->ctrl, enter);
+	msm_dp_ctrl_set_psr(dp->ctrl, dp->panel, enter);
 }
 
 /**
@@ -979,7 +979,7 @@ static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
 	}
 
 	/* DP controller isr */
-	ret |= msm_dp_ctrl_isr(dp->ctrl);
+	ret |= msm_dp_ctrl_isr(dp->ctrl, dp->panel);
 
 	return ret;
 }

-- 
2.43.0

