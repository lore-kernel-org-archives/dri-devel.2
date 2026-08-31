Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07512C624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC4910E71A;
	Mon, 31 Aug 2026 08:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6jMyODY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RHM/Y8Z2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97EA10E71B
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:12 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xgC22924476
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jhBuptnYFpKMiy1xDLqY7AcfcTYcK7dB1Xlp1F9dyy8=; b=L6jMyODYMnE71ej2
 i+qbIMA49OESJawrWi9HeN9op4pBUEogR6W4MZ1AE4T5jp+ySsTL8dKuMGdV8E5h
 yRaFRExJOufBUc9fv9DQ7yirnqpCiUhbCJbO/1vG1f75DR/KzXGta6p4bftD5Hkt
 bGexQoOl1Z2POOsk62ZkpmAo3BbDJMBtYIgC3/Ak1pLUjfS2gzvVvtrwQupAtx2T
 M06+qVAN/+Vhe1fwpCFpAk/Neq5p1/KgDLITuPBsxAhWLEeNs4rCP4uCT6K/fRtB
 vPXZMwfxo1s66Xje9jtjj5OA8xFv3B8JHaumsyk/VoqhWcsnRb94G/Eig3h+Xkz2
 3fFcog==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7w9nk0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so455769385a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164291; x=1788769091;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jhBuptnYFpKMiy1xDLqY7AcfcTYcK7dB1Xlp1F9dyy8=;
 b=RHM/Y8Z2uAp5IIZR6pHcjYE5QUCYEBrm/aP5vYtPezjaRgEkJqCQdQRoMmWVJ5wzh9
 P2jtj0K25ceKkmcGjdJYPwCgTbDMMErxXDXDZi9q3llOPw8hWEiMsuAUrvM+uAKuHeVV
 4lCa9AgXjXdEbwg1OmhLWV6neal/T5XfLD/g2cdNHe2KOvRMYqUcm5IQcmESAhHJtoBT
 CQ0OEaCICcjBSlyUQ4gomk6FoSygvIIVy1QuZQtmtIvLnLEElxc8kvD+S263D1/JGAI8
 s1ab7q96o+TqeizFNXJnEm976txJjHWFxleGC6og0M89owDSxufgqBsFVTrcuoOdZGgd
 drkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164291; x=1788769091;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jhBuptnYFpKMiy1xDLqY7AcfcTYcK7dB1Xlp1F9dyy8=;
 b=gLn1QIP13oVClVJfa4cBTAcv5HRaiCJimzNiOK0AmOTmpgYFfRCiSHtPEBncK5avFc
 pbw6WvqayTN9Qce/NdPDAY7+EPufWbCb6S2OJDU02KXjkx8OQBN9bT42WRMWHfRdxCyp
 NlDc+yMlLmWVl4ou+5/Wn36RDqOgf5TGly0NkHtuqKkfyJV6ZEkKgDI/C6Eq57FY8NSs
 s77dMgEtF6XbEhhdsx1cvbH+XDjfOiUtSBuunqvB1sijyfZ/jR4sfiZKo45fsOwnQynx
 9VwnC6kFEDttV+m3WTVFoROZ7dwrliMHOAWHKJObbA+Ev55+2DHuFVlG5xj84/nHcZzZ
 3oGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMAmbC57OQbXgSpimhfQO8wNMyHcZWbim79w8U5SWDoruR5SDtf/D2eIrUGyfaU+/sY7koE8sv6LQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nZdER/R+lSsVcQnbkLh9Ypz0Jx6JQ1rRMlmsngm1jpU1DtMJkN
 owImezJawrAk9/9khaYOoD0zOaG/9fPUIrMbMcYzuvR3ZCd+Wya/DMeT7g/9oAiCwkGK2OXXT67
 uFd6MYYoPbIzhqPAKdvtp6TV57ifO302UHclEt3Ph+xLfJu5F9o6Z7xW+hAnTEI4TRgjCVYI=
X-Gm-Gg: AR+sD10UJVrEQnP40YaUgXngVkCMK1PVTgnxwbxg76YnqZLXvgzjMQybgI/SPrD84XE
 JVZyT3EhBV80NlififyoCIAzxivsmkIpy0vuTZoBh3ScdSI6oIC9YrCUB/jH5YKlN6YiMhYNdZk
 NXClwoQ7WR4qGFYwIx/JR/sJ8u0v+akLGr0WL0FiL9Rq7iwgM5x5yWrEUdheGlfizlVEPlaqfo7
 Pd6xJVBqoq2nWJ0ODfC8x167g+a/3sas31cDynRI45sJSThW2bhvGCbRoLHB+ZN5LxlUPW7vsKi
 igqX1lZUlJXKQ3B5H4uAmxbdj5aQMm/ELotra/db1OHzsj7GlFhu1vhMFg2yBN50V0Qb1XocNru
 rSKdAascdm5oNsTC3jLbSA+AeNpt/hpyGsXbzS6wvxRLJ3BZM4JZ31IE8CfWGDjw=
X-Received: by 2002:a05:620a:688f:b0:939:365b:37d8 with SMTP id
 af79cd13be357-93942b9d0c4mr132891085a.36.1788164290786; 
 Mon, 31 Aug 2026 01:18:10 -0700 (PDT)
X-Received: by 2002:a05:620a:688f:b0:939:365b:37d8 with SMTP id
 af79cd13be357-93942b9d0c4mr132886885a.36.1788164290247; 
 Mon, 31 Aug 2026 01:18:10 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:18:09 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:24 +0800
Subject: [PATCH v6 07/29] drm/msm/dp: add stream-aware link register accessors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-7-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=12701;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=9VpXdKX5WvjhOg7NrJO4/hZ1EJd5dXWP7ykt8AQMJ1Y=;
 b=PLWMmy9dTlNadABriOB9vpmhWbBOosKISG6w8NQBTQp9L9WUzQZUgeGHGJgn2zeSkOPoHnkiV
 ThE3ESo0DhsD3FzB4F5YtOJ54LacepQWBlQx1hdP8fCtluLDjL1mpnd
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a9538c3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=qYFs1fq_Vji6wCC2nv8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXyHWsJvIhq2GT
 NeWKUJCwPf0P9FaBWM87vEzlGmfcd00jsQ9aAvDCXpUPv9I2oI3PgI0dDcbcyAbiIgXLmNPtpXS
 RQZWdYGePOkGfEqiERwUOPKs6PKm/8Q=
X-Proofpoint-ORIG-GUID: K6ii4P-qGDy9Vm-GeT7nfxWZOv-2YeXT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX2ALiOghODPP4
 Nu4w2wbJxqN/CSNnmkTvOTMvnJEOOKduK+5azuLwotDE6YfhkPOUmG22+AYb1gx6t9T3/HUpSj1
 pSaCzYAdBgVasGQr0ggKhixpqOBrrdV0No2LXsKhcE6Z1B53vVDTsP4sYhtTqZoOqKKaffGGQNw
 HQ4wDVlHGzkXEjCF2EOzqYBhvU/mtcDSIjKxHLZ0znnKBiJ0jCtKtZou3PUyoujAQzRrsJ61PWw
 RrAqzbwl+sYFP2X3N4dqy4AlDv5O7WI2GG14sq45RZj7Lf2Btb65dV/NOrfi1Jdf/wFTdjGOiN1
 VALFRvlcICLMHb1UeKdwxMpiLsU9uaWkO8XxKusxDwZz6Tgx14NFFhk4+6rLQ2LC9XvRrd5mCwl
 EB3ammnWry+7/JIo2SGzwEHriW2l3Q4Wbyu5586WQCRJzoILOBzQcMM3e34Q3CPgjg3wesNyx4D
 5AG40imHGCHLncXwOeA==
X-Proofpoint-GUID: K6ii4P-qGDy9Vm-GeT7nfxWZOv-2YeXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310070
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
 drivers/gpu/drm/msm/dp/dp_display.c | 38 ++++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_panel.c   | 37 +++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_panel.h   |  2 ++
 5 files changed, 133 insertions(+), 12 deletions(-)

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
index 3dce9334d0c2..d0fc4ff508dc 100644
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
 	size_t pixel_len;
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
@@ -843,6 +851,12 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
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
@@ -1189,6 +1203,26 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 		}
 	}
 
+	display->mst2link_base = msm_dp_ioremap(pdev, 7, &display->mst2link_len);
+	if (IS_ERR(display->mst2link_base)) {
+		int ret = PTR_ERR(display->mst2link_base);
+
+		if (ret != -EINVAL)
+			return ret;
+		/* optional resource not present in DT */
+		display->mst2link_base = NULL;
+	}
+
+	display->mst3link_base = msm_dp_ioremap(pdev, 8, &display->mst3link_len);
+	if (IS_ERR(display->mst3link_base)) {
+		int ret = PTR_ERR(display->mst3link_base);
+
+		if (ret != -EINVAL)
+			return ret;
+		/* optional resource not present in DT */
+		display->mst3link_base = NULL;
+	}
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

