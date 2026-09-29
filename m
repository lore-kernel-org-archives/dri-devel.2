Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BDBCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A70610EC97;
	Tue, 29 Sep 2026 04:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c+0xgEL2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OFXdMQu4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC12B10EB1D
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:03 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47Nco3891450
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KgMSDTV4LFduv2tnamqe0eTVJ7MAHMAdZMdKQg/9Cbg=; b=c+0xgEL2pMItXVPG
 YID4I7kvP1xdZ2dSqDX2HcpbuA49sxp9otnLMXzZcEo8T7+FGxoxmxm27s1J5bjL
 Z2Mshhmux7TLRIsjsfLfP7adebcEvDA/8xme5KN/pXSRDhqtJ7tjY1xEJVdY4s+3
 fgk2fM9v0b3vMTfVAYx+TJG6hvuJKh+KpnzYjOQX9E4Vp/ylGl4Y2FJCXmvDxKvX
 MLbWa3wREZrKgk4TMIQvwmAUiCYOoFsl4dnuifmZb0Ca+nDzkbWOAK+Sg8m8mvWn
 U19Iv/tifnzD6v+qeNRgMuz9N7GjlYdX2ip7xTBLX28rKylh1VOEwe2WLlNT4PNX
 OhGu9A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfkv3mu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-533306413ccso10415371cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656022; x=1791260822;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KgMSDTV4LFduv2tnamqe0eTVJ7MAHMAdZMdKQg/9Cbg=;
 b=OFXdMQu48HnL3/Tqj0jVTN4SRT4oNT00nqXAbVQFIbFECeO9kVoFP+7/xdltsXwk21
 NaiyUzN8lndVvp0xZPNSr3l3z404URSufOMwMbeChQhCh6rVJAx92mmSGe35N/b0BDnd
 PlDS1RaaOAKB5zPgfNTOPpoK4XD4Uhb1E44Gxkw1//lktDDo7ZgkF+/vSfoIMyByATbz
 QXNBITJaQci0Po58eaJSRzSQSy1wovE4qHQujVvFzfFpI143kdk6KabuzZDRpyvENXF6
 E6nQGf2uM1tJ20KMQFQHHX1OepBWAftvStiFa7dUKRtdS6+Ocizth8DnU/BUIkmNzY5u
 iqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656022; x=1791260822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KgMSDTV4LFduv2tnamqe0eTVJ7MAHMAdZMdKQg/9Cbg=;
 b=nA5zJmcw9CSNmcHHmIXMmZIZr7qEVh6PTop5/YdVpSugLAa0d5oAVDtNh6fIc2qnHa
 Mynexu8drsEktkKxiZGGfPiM+uqZE8ghe01roC5F1zSAwB3KUI/x1fUj5ZTCarYQj7e1
 4MkoXlsFkqAud72ntbpW3yU+1e1uDaKTysWuUp7Brku538YHx7kxSCHpY2Z95Gunjo7z
 Vy5ny7s9p2MG6JSSq4st7XAjFR2EWXJeGSHKXm2PqYcxOBAGqYbD02UVv4un1cI67UtO
 felsdS79O9LyM084bjn6xm1dhYtJV7smnMm0bJNFBEyeoe+uZaAj2U/YbMWouYaBbNei
 m3hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByYG0V4b087MB0QwZY/4m6VnfiPpiXvPQ+wCALoVdtk4jI5+TGfucDQcdMx+0Jl9ezFjObrzzeOHpY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lNu50KePLo2N/Jc1Ch2nbCwf+ExO5RZW/eoZoPGU8g18YkepDX
 aH+Pw00+br1e5QAPPWmRXzSby9mc6kIXlDh9RCO9C6+nXBpyp2h3mDrkgCkmyzUaMeodL+nya/I
 MFUEy8F0pXl3F3qrNr7hdbenxLMlit5EZbJlccOc8n3iJyGZsGRGDP54JhkExANqqkWUM8Wg=
X-Gm-Gg: AYBFou0iONNC7awV19cLPDajmQ/v8UW+BWuCFTCN1IYe9J65HCYWhDB69RDBliIMv3s
 tv6IiJVu8ZBCRcvlmTszYTx/saZjKtSJTu95R7w9ab4UjYBTgoe1M8KSnUpz2K2EeQOIQv1NGFL
 2U1Z0zV3fMf2jMlrgB7zORp+wXu5dRSl3GMOH2+qdWoH7fThwwOSoXrGAP9hSwGJc/Emx7G0vPp
 Yd5zS511JaDNGudaa+Jbb12KsDTJu6SRP8P5uMi4VLXHAMcEZMzmihXHAQ0dVx90oECZty404NN
 Bg9OYCYqJ072lQThWqeWr05VuLwcqvItrZnFNZTpf82upp2kHn22pdiR29nY+yhgdmVy7oo6Wht
 mQITQ46KU+uLP3qkQHZ0gqmQnBh13N/XN6Ny9FnrmGUflSVqdw/n9J3ouJRPCOK8=
X-Received: by 2002:ac8:5a0b:0:b0:532:885e:5ce8 with SMTP id
 d75a77b69052e-53357e16d8cmr26774011cf.0.1790656021564; 
 Mon, 28 Sep 2026 21:27:01 -0700 (PDT)
X-Received: by 2002:ac8:5a0b:0:b0:532:885e:5ce8 with SMTP id
 d75a77b69052e-53357e16d8cmr26773861cf.0.1790656021053; 
 Mon, 28 Sep 2026 21:27:01 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:27:00 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:31 +0800
Subject: [PATCH v7 07/35] drm/msm/dp: add stream-aware link register accessors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-7-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=12463;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=tmRJom/ZnZkEj9eTqJ/sHhBFWy9zEdTwNmilYcIQNoc=;
 b=ttJMXFHf16fxn34e6FbBifgi7GdulYIj9MdBTnXf2M2jdQ813trki/y3tVsIUx1QWR04PwA8T
 +GBfXLB30bGCNDN9vehgs61JxVUuQtYeqhy0NUtFPWEZUF1zz2Cb7FH
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXzWeD/tC4ezUP
 4OKiZ5Y8bV7GLRz+HjvmMyaVPspOdTmghIondwJiAWuUqFUatuPp84CWxC1sHNzR3Ic6D7OF7c9
 UQxjj+0kzY+j5rZ+ipad3SqgixSGd10G0mK7bv8MK4DjrhHvFwDtVBdVCgabmra6Nw8Sa/h+2dF
 wCAPOxizUspinSXWqbu10YWlV6c7Y9SCjxXFwiWRFd6UNLKMSslQ1EgKq77cfe8YZEZdtdKcfbU
 F2/8dYK6RgP8Crqe38uN6cNfSOivANsqX+Z0QJKJClaw2Q1Is8d/MLyQrazbUueudvvuZxD0a4h
 GALkxgYR2Sl+JE1W/AKOFAr/D31jmYBmeR5doCFj+gD6L1SRHw36omaI9GO0KTGsdw6V4lGpjFJ
 P6Vnc+oQMdRyNwgJrH0xRwyVuzAp/HVzlao+ED3JHQi7sFdxo+Eh/VugJa7YMXCl3esyP2N0KvR
 k+Zqkv2Rz6NdFydBmDw==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6abb3e16 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=qYFs1fq_Vji6wCC2nv8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: AzFRe36e-Zm59-NCpmsdPvqIO54f0LwR
X-Proofpoint-ORIG-GUID: AzFRe36e-Zm59-NCpmsdPvqIO54f0LwR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXyn7iGBqOahhJ
 4uyvbBWuH/0GYGlRpyUbVcnP5WZfNdbicMjLYfqJoqMxR7GbzavkiXgtlajRf2IwORtno5atbYZ
 yIIdDsGHGEXBHeNvNiP1//FvpQ8fZE4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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

DisplayPort MST uses multiple stream-specific register spaces. Streams
0 and 1 share the primary link register block with different register
offsets, while streams 2 and 3 use dedicated MST link register blocks.

Add stream-aware register access helpers that translate stream-specific
register offsets and route accesses to the appropriate register space
based on the stream id.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 64 +++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++-
 drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++++++--
 drivers/gpu/drm/msm/dp/dp_panel.c   | 37 +++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_panel.h   |  2 ++
 5 files changed, 121 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index c0f5226dc383..e1614bc49a7c 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -117,6 +117,8 @@ struct msm_dp_ctrl_private {
 	struct msm_dp_link *link;
 	void __iomem *ahb_base;
 	void __iomem *link_base;
+	void __iomem *mst2link_base;
+	void __iomem *mst3link_base;
 
 	struct phy *phy;
 
@@ -172,6 +174,49 @@ static inline void msm_dp_write_link(struct msm_dp_ctrl_private *ctrl,
 	writel(data, ctrl->link_base + offset);
 }
 
+static inline u32 msm_dp_read_stream_link(struct msm_dp_ctrl_private *ctrl,
+					   enum msm_dp_stream_id stream_id, u32 offset)
+{
+	offset = msm_dp_stream_reg(stream_id, offset);
+	switch (stream_id) {
+	case DP_STREAM_0:
+	case DP_STREAM_1:
+		return readl_relaxed(ctrl->link_base + offset);
+	case DP_STREAM_2:
+		return readl_relaxed(ctrl->mst2link_base + offset);
+	case DP_STREAM_3:
+		return readl_relaxed(ctrl->mst3link_base + offset);
+	default:
+		DRM_ERROR("error stream_id\n");
+		return 0;
+	}
+}
+
+static inline void msm_dp_write_stream_link(struct msm_dp_ctrl_private *ctrl,
+					     enum msm_dp_stream_id stream_id, u32 offset, u32 data)
+{
+	/*
+	 * To make sure link reg writes happens before any other operation,
+	 * this function uses writel() instread of writel_relaxed()
+	 */
+	offset = msm_dp_stream_reg(stream_id, offset);
+	switch (stream_id) {
+	case DP_STREAM_0:
+	case DP_STREAM_1:
+		writel(data, ctrl->link_base + offset);
+		break;
+	case DP_STREAM_2:
+		writel(data, ctrl->mst2link_base + offset);
+		break;
+	case DP_STREAM_3:
+		writel(data, ctrl->mst3link_base + offset);
+		break;
+	default:
+		DRM_ERROR("error stream_id\n");
+		break;
+	}
+}
+
 static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
 					struct msm_dp_link_info *link)
 {
@@ -397,7 +442,8 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
 	 * RMW: called from atomic_enable(), serialized by the DRM atomic framework.
 	 * Clear stream-specific fields before OR-ing to avoid bit accumulation.
 	 */
-	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
+	config = msm_dp_read_stream_link(ctrl, msm_dp_panel->stream_id,
+					 REG_DP_CONFIGURATION_CTRL);
 	config &= ~(DP_CONFIGURATION_CTRL_RGB_YUV_MASK |
 		    DP_CONFIGURATION_CTRL_BPC_MASK |
 		    DP_CONFIGURATION_CTRL_SEND_VSC);
@@ -415,7 +461,7 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
 
 	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
 
-	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
+	msm_dp_write_stream_link(ctrl, msm_dp_panel->stream_id, REG_DP_CONFIGURATION_CTRL, config);
 }
 
 static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl,
@@ -472,7 +518,7 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 							  msm_dp_panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
 
-	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
+	misc_val = msm_dp_read_stream_link(ctrl, msm_dp_panel->stream_id, REG_DP_MISC1_MISC0);
 
 	/* clear bpp bits */
 	misc_val &= ~(0x07 << DP_MISC0_TEST_BITS_DEPTH_SHIFT);
@@ -482,7 +528,7 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 	misc_val |= DP_MISC0_SYNCHRONOUS_CLK;
 
 	drm_dbg_dp(ctrl->drm_dev, "misc settings = 0x%x\n", misc_val);
-	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
+	msm_dp_write_stream_link(ctrl, msm_dp_panel->stream_id, REG_DP_MISC1_MISC0, misc_val);
 }
 
 static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl,
@@ -2528,8 +2574,8 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
 		nvid *= 3;
 
 	drm_dbg_dp(ctrl->drm_dev, "mvid=0x%x, nvid=0x%x\n", mvid, nvid);
-	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_MVID, mvid);
-	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_NVID, nvid);
+	msm_dp_write_stream_link(ctrl, panel->stream_id, REG_DP_SOFTWARE_MVID, mvid);
+	msm_dp_write_stream_link(ctrl, panel->stream_id, REG_DP_SOFTWARE_NVID, nvid);
 }
 
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
@@ -2784,7 +2830,9 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
 			struct drm_dp_aux *aux,
 			struct phy *phy,
 			void __iomem *ahb_base,
-			void __iomem *link_base)
+			void __iomem *link_base,
+			void __iomem *mst2link_base,
+			void __iomem *mst3link_base)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	int ret;
@@ -2823,6 +2871,8 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
 	ctrl->phy      = phy;
 	ctrl->ahb_base = ahb_base;
 	ctrl->link_base = link_base;
+	ctrl->mst2link_base = mst2link_base;
+	ctrl->mst3link_base = mst3link_base;
 
 	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index bf593f4a4480..80d9258501b4 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -35,7 +35,9 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
 				    struct drm_dp_aux *aux,
 				    struct phy *phy,
 				    void __iomem *ahb_base,
-				    void __iomem *link_base);
+				    void __iomem *link_base,
+				    void __iomem *mst2link_base,
+				    void __iomem *mst3link_base);
 
 void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctrl,
 		       struct msm_dp_panel *panel);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d8b28a562653..bb5e35e11b4d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -85,6 +85,12 @@ struct msm_dp_display_private {
 	void __iomem *link_base;
 	size_t link_len;
 
+	void __iomem *mst2link_base;
+	size_t mst2link_len;
+
+	void __iomem *mst3link_base;
+	size_t mst3link_len;
+
 	void __iomem *pixel_base[DP_STREAM_MAX];
 	size_t pixel_len[DP_STREAM_MAX];
 };
@@ -562,7 +568,8 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		goto error_link;
 	}
 
-	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base[0]);
+	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base,
+				     dp->mst2link_base, dp->mst3link_base, dp->pixel_base[0]);
 	if (IS_ERR(dp->panel)) {
 		rc = PTR_ERR(dp->panel);
 		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
@@ -571,7 +578,8 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 	}
 
 	dp->ctrl = msm_dp_ctrl_get(dev, dp->link, dp->aux,
-				   phy, dp->ahb_base, dp->link_base);
+			       phy, dp->ahb_base, dp->link_base,
+			       dp->mst2link_base, dp->mst3link_base);
 	if (IS_ERR(dp->ctrl)) {
 		rc = PTR_ERR(dp->ctrl);
 		DRM_ERROR("failed to initialize ctrl, rc = %d\n", rc);
@@ -846,6 +854,12 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
 				    msm_dp_display->aux_base, "dp_aux");
 	msm_disp_snapshot_add_block(disp_state, msm_dp_display->link_len,
 				    msm_dp_display->link_base, "dp_link");
+	if (msm_dp_display->mst2link_base)
+		msm_disp_snapshot_add_block(disp_state, msm_dp_display->mst2link_len,
+					    msm_dp_display->mst2link_base, "dp_mst2link");
+	if (msm_dp_display->mst3link_base)
+		msm_disp_snapshot_add_block(disp_state, msm_dp_display->mst3link_len,
+					    msm_dp_display->mst3link_base, "dp_mst3link");
 
 	for (int i = 0; i < DP_STREAM_MAX; i++) {
 		if (!msm_dp_ctrl_stream_clks_on(msm_dp_display->ctrl, i))
@@ -1208,6 +1222,14 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 			break;
 	}
 
+	display->mst2link_base = msm_dp_ioremap_optional(pdev, 7, &display->mst2link_len);
+	if (IS_ERR(display->mst2link_base))
+		return PTR_ERR(display->mst2link_base);
+
+	display->mst3link_base = msm_dp_ioremap_optional(pdev, 8, &display->mst3link_len);
+	if (IS_ERR(display->mst3link_base))
+		return PTR_ERR(display->mst3link_base);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 504d7542d30a..d3468b73fdc3 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -25,6 +25,8 @@ struct msm_dp_panel_private {
 	struct drm_dp_aux *aux;
 	struct msm_dp_link *link;
 	void __iomem *link_base;
+	void __iomem *mst2link_base;
+	void __iomem *mst3link_base;
 	void __iomem *pixel_base;
 	bool panel_on;
 };
@@ -96,7 +98,19 @@ u32 msm_dp_stream_reg(enum msm_dp_stream_id id, u32 reg)
 
 static inline u32 msm_dp_read_link(struct msm_dp_panel_private *panel, u32 offset)
 {
-	return readl_relaxed(panel->link_base + offset);
+	offset = msm_dp_stream_reg(panel->msm_dp_panel.stream_id, offset);
+	switch (panel->msm_dp_panel.stream_id) {
+	case DP_STREAM_0:
+	case DP_STREAM_1:
+		return readl_relaxed(panel->link_base + offset);
+	case DP_STREAM_2:
+		return readl_relaxed(panel->mst2link_base + offset);
+	case DP_STREAM_3:
+		return readl_relaxed(panel->mst3link_base + offset);
+	default:
+		DRM_ERROR("error stream_id\n");
+		return 0;
+	}
 }
 
 static inline void msm_dp_write_link(struct msm_dp_panel_private *panel,
@@ -106,7 +120,22 @@ static inline void msm_dp_write_link(struct msm_dp_panel_private *panel,
 	 * To make sure link reg writes happens before any other operation,
 	 * this function uses writel() instread of writel_relaxed()
 	 */
-	writel(data, panel->link_base + offset);
+	offset = msm_dp_stream_reg(panel->msm_dp_panel.stream_id, offset);
+	switch (panel->msm_dp_panel.stream_id) {
+	case DP_STREAM_0:
+	case DP_STREAM_1:
+		writel(data, panel->link_base + offset);
+		break;
+	case DP_STREAM_2:
+		writel(data, panel->mst2link_base + offset);
+		break;
+	case DP_STREAM_3:
+		writel(data, panel->mst3link_base + offset);
+		break;
+	default:
+		DRM_ERROR("error stream_id\n");
+		break;
+	}
 }
 
 static inline void msm_dp_write_pn(struct msm_dp_panel_private *panel,
@@ -766,6 +795,8 @@ int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
 struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
 			      struct msm_dp_link *link,
 			      void __iomem *link_base,
+			      void __iomem *mst2link_base,
+			      void __iomem *mst3link_base,
 			      void __iomem *pixel_base)
 {
 	struct msm_dp_panel_private *panel;
@@ -785,6 +816,8 @@ struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux
 	panel->link = link;
 	panel->link_base = link_base;
 	panel->pixel_base = pixel_base;
+	panel->mst2link_base = mst2link_base;
+	panel->mst3link_base = mst3link_base;
 
 	msm_dp_panel = &panel->msm_dp_panel;
 	msm_dp_panel->max_bw_code = DP_LINK_BW_8_1;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 75b23c106a99..dc046fec24fc 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -104,5 +104,7 @@ u32 msm_dp_stream_reg(enum msm_dp_stream_id id, u32 reg);
 struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
 			      struct msm_dp_link *link,
 			      void __iomem *link_base,
+			      void __iomem *mst2link_base,
+			      void __iomem *mst3link_base,
 			      void __iomem *pixel_base);
 #endif /* _DP_PANEL_H_ */

-- 
2.43.0

