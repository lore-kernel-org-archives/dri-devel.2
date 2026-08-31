Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBFAC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86CCD10E701;
	Mon, 31 Aug 2026 08:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lavDuOap";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BSGDIr7V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1847A10E71B
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:07 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xaF33427321
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0YGchqah0UzfAha4yAxOufthwsRqWdGvnD0C4S2BIAM=; b=lavDuOapPspxC/xJ
 ylxmftYTEZe3RhzL62QFQAs2f3VK6SgaZyEJYl8N1XDH19WVngVp9qqhO3iBwN0U
 EaeQzE+ema3cjzOOR5uORzYwP85Lzp4keIwiNuetdFPVNoePrTnm3KzCNxXVT306
 W4AfUCNG88NwaohoKFio4fBg1L8kcogYMG78g7tvn3nVBPBZmTHG5VBo/xvsvyy6
 KjMa74ojh0MgsEYIt7DoU01Le0+Cs4rrQVZIDeSIi1/fmLsHQ2SA/5i18UXpo6oV
 yHkL4KeDEKTy0qMihvspTrSlaqNvnPkdV0fc2Dhv9UXuXj28T3l58RPb+vOr5e0o
 8dr5Aw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4pm8bpt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93903622880so639890085a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164285; x=1788769085;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0YGchqah0UzfAha4yAxOufthwsRqWdGvnD0C4S2BIAM=;
 b=BSGDIr7V9y+tfaDgdNqIn1PNAdGkLrBLJAO4Dt6IbjUJZd5nIkMJuzN3dv7bxqnwQN
 5bTFpUC/3vIoZL6NBF3ePmskh8vkgiAkbN/vCCc9VLg6YBC9ySBwAHZ3zXTdh9R5ckIt
 csVov577G3X/3LuIFb89+prK/29uTRWypRlL4afLPH0uciVkdNH+9nIg+uddV1TgxmT6
 rKSGr345DPHbSJPdcar3LCNnGNBMpGuWC7XwM5eI6gHmh5i2tSxrzmTox6bgSblcz1ys
 HKG/9AFLqF3hwjL2vmLVZGI0fg83zwB56N/ei2RqFVe5JrBJTRKiYgITMck6BD6pJdzN
 vU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164285; x=1788769085;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0YGchqah0UzfAha4yAxOufthwsRqWdGvnD0C4S2BIAM=;
 b=IqKaeAjdfHJLeUMjq2zzX4KZoRhU2f37drSfIDXRLjidilY0XCVK8A4/cc8110OkrD
 iOv7CieMdz6XJG7WwxGeSr7DPbAXcLU2K9uw242ZJYtfHTIyXdH9p4mEDsnqcp7CtcdM
 M8fXDZ+inq9ONPTpNrJuW2v5jk/riaNYerc+oYT2fOem2bkfkd/3/Zx+BxBXkuMayadQ
 Ro46atufTzsFmmlQav9tc1LSpkVpM4omNnhaPuTSW8dhFwapnmQPZ9e87r+84ZM151Vz
 cTI1LrKU14lNPsUOuGyJcyIzyEaUrA7JauLnCtOhb3Vfl+0uP9zBzyLz1DyN6rJNf78z
 mynA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5ho0hGrsI/oobfD89rCky08a9mhtnGmETMPO2mojw96cAvsNh96J0iz/0XStdCtb47H7u992WJLs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lAKCtDc+O9FPnfuWLjjbs/5P1kX6y85606sAtMJ+oQtYEUTCNn
 L3pYT3vfwcyIuYwgfrjfj9lrB++YUV8hDlFuCq/FVrMQEz2bQh0RZClTxG947gEzpYSXwzQYowA
 t3cdLEQJZoD/e6MuN4bIwMVS/VnbIl2B5N0R6/ONZivfjc1EKogGZdEHFrmQAGsxF4hmIUek=
X-Gm-Gg: AR+sD1209tcT8sqVoQfvDMHVTPopAi1dNGqEBcd4ikg+we7UoUZribBWYBrmPm4RFxz
 HNNZPbJH6exQ9Fj4wk8tv9l4+iVUvQN1Ia0emy0BBS7kJTD0hYslCBruaizH2hMpAw18Fcuviuy
 nNr5fsLMH0SnYRp59NWTZT/JqT/vqkLgc24paoZT9Gkxu+va26lr4RwJWz33nX/ew4JlXBJohJv
 qVKB1K2pn0/dTXxGLppntelcvFBbHYoqkSsz4e1Il/bK66Oy/XEQH1hq2yUGt42L1CU0n7iu5Oc
 /YjM5co2Ilnf8tGNBut4RHYbZqlCRZ1r0q3UjUSs2HkRv4eehjbGW2vNvdA/yvH83tlKZfr7iHR
 GVFycHsnkVwnlvk87Um9euN3uiUtPPkv7mKezVNfhgxoIv3M70GAMYr9YXrv0k88=
X-Received: by 2002:a05:620a:4148:b0:939:f89:368d with SMTP id
 af79cd13be357-93936daaf1dmr641868985a.22.1788164285189; 
 Mon, 31 Aug 2026 01:18:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4148:b0:939:f89:368d with SMTP id
 af79cd13be357-93936daaf1dmr641865285a.22.1788164284638; 
 Mon, 31 Aug 2026 01:18:04 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:18:04 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:23 +0800
Subject: [PATCH v6 06/29] drm/msm/dp: add MST stream register definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-6-c91d35d6fb9e@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=7708;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=8Dmslyk2Fa7jwFI4zAsCVxwM9n6Gty4eaAtju08j7YE=;
 b=w/zSTzHIBylC5OEE1JFvza/Hjm7dzHdrNSUdexO9AZv/Xjh4bGkg9L/u/jZW9utBO7DpDU6U3
 MPeWImQHOkyAc3W5yify5tJdsTNKxGyUL6jf6COdYPkTvVFGyYXX4MN
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: QxcqGu3-r9sgsQAapp23Z49QSU2WIvm-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXz39PMpB5I7Um
 +PZGPMp5LlMHXCXSKmW3V2hd8S0d7o4Pny+UVY0UWzbLeycYdLnaDd11WKeDzrtsJwYz6DmVVoa
 5a9YJacGFMBUalgZCVddhWXu1NtQCsAx37SnqQY6k7y5hMQH+69h4JAItauGj2qGiSLwInIXY+1
 cscSTbpbIkxlj5bhQAayGKUFD6rO2vY01gAR/Ix4oeITmz3WBJ9Z5nnD87SCMkuUG1m0TCKKtbz
 9O8Mg1aP/H3qBtBBDTJXNh6vF9H/wg+vgse/h+DnTu7EERQodOw+bchYeP8QNPf1RD5XSbnfBPF
 uN2Cw8ql7O+9LCByhumIPvZrnDnZhp+A6XTSgaeICkyv1ZXkHJTllYADzQQnVgNaQC53F7mKtec
 LlZz13Dhci/DckmgjyKfcWQ6wVo1XHtggPFQdxsuI6lM1rw+2pWqcAOU3YlL1dwNSti/Oe5jYta
 2mfLVE+alQTwJ2IDINw==
X-Proofpoint-GUID: QxcqGu3-r9sgsQAapp23Z49QSU2WIvm-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX9AX46CkMIaLo
 omznVO9s7qLd3sXAxZFrAg0+i3RU1SbPE5xaHCEtXhT7TLWJcEX5Bc+Fvj4g3oDQv9Z8A8BC+LW
 gAljYgUzqC0AgztH9ubsgsfkKK+XJok=
X-Authority-Analysis: v=2.4 cv=GbQnWwXL c=1 sm=1 tr=0 ts=6a9538bd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=qrQA6X-0r1DpH4znwvkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310070
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

Add the stream-1 (DP1) and MST-link register definitions together with
msm_dp_stream_reg(), a helper that translates stream-0 register offsets
into their stream-specific equivalents.

Keeping the register definitions and translation helper together ensures
that all supported mappings are defined in one place.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 65 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
 drivers/gpu/drm/msm/dp/dp_reg.h   | 56 +++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 7b5fc5bb16de..504d7542d30a 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -29,6 +29,71 @@ struct msm_dp_panel_private {
 	bool panel_on;
 };
 
+u32 msm_dp_stream_reg(enum msm_dp_stream_id id, u32 reg)
+{
+	bool is_s1 = (id == DP_STREAM_1);
+
+	if (id == DP_STREAM_0)
+		return reg;
+
+	switch (reg) {
+	case REG_DP_STATE_CTRL:
+		return is_s1 ? REG_DP_STATE_CTRL : REG_DP_MSTLINK_STATE_CTRL;
+	case REG_DP_CONFIGURATION_CTRL:
+		return is_s1 ? REG_DP1_CONFIGURATION_CTRL : REG_DP_MSTLINK_CONFIGURATION_CTRL;
+	case REG_DP_SOFTWARE_MVID:
+		return is_s1 ? REG_DP1_SOFTWARE_MVID : REG_DP_MSTLINK_SOFTWARE_MVID;
+	case REG_DP_SOFTWARE_NVID:
+		return is_s1 ? REG_DP1_SOFTWARE_NVID : REG_DP_MSTLINK_SOFTWARE_NVID;
+	case REG_DP_TOTAL_HOR_VER:
+		return is_s1 ? REG_DP1_TOTAL_HOR_VER : REG_DP_MSTLINK_TOTAL_HOR_VER;
+	case REG_DP_START_HOR_VER_FROM_SYNC:
+		return is_s1 ? REG_DP1_START_HOR_VER_FROM_SYNC
+			     : REG_DP_MSTLINK_START_HOR_VER_FROM_SYNC;
+	case REG_DP_HSYNC_VSYNC_WIDTH_POLARITY:
+		return is_s1 ? REG_DP1_HSYNC_VSYNC_WIDTH_POLARITY
+			     : REG_DP_MSTLINK_HSYNC_VSYNC_WIDTH_POLARITY;
+	case REG_DP_ACTIVE_HOR_VER:
+		return is_s1 ? REG_DP1_ACTIVE_HOR_VER : REG_DP_MSTLINK_ACTIVE_HOR_VER;
+	case REG_DP_MISC1_MISC0:
+		return is_s1 ? REG_DP1_MISC1_MISC0 : REG_DP_MSTLINK_MISC1_MISC0;
+	case REG_DP_DP0_TIMESLOT_1_32:
+		return is_s1 ? REG_DP_DP1_TIMESLOT_1_32 : REG_DP_MSTLINK_TIMESLOT_1_32;
+	case REG_DP_DP0_TIMESLOT_33_63:
+		return is_s1 ? REG_DP_DP1_TIMESLOT_33_63 : REG_DP_MSTLINK_TIMESLOT_33_63;
+	case REG_DP_DP0_RG:
+		return is_s1 ? REG_DP_DP1_RG : REG_DP_MSTLINK_DP_RG;
+	case MMSS_DP_SDP_CFG:
+		return is_s1 ? MMSS_DP1_SDP_CFG : MMSS_DP_MSTLINK_SDP_CFG;
+	case MMSS_DP_SDP_CFG2:
+		return is_s1 ? MMSS_DP1_SDP_CFG2 : MMSS_DP_MSTLINK_SDP_CFG2;
+	case MMSS_DP_SDP_CFG3:
+		return is_s1 ? MMSS_DP1_SDP_CFG3 : MMSS_DP_MSTLINK_SDP_CFG3;
+	case MMSS_DP_GENERIC0_0:
+		return is_s1 ? MMSS_DP1_GENERIC0_0 : MMSS_DP_MSTLINK_GENERIC0_0;
+	case MMSS_DP_GENERIC0_1:
+		return is_s1 ? MMSS_DP1_GENERIC0_1 : MMSS_DP_MSTLINK_GENERIC0_1;
+	case MMSS_DP_GENERIC0_2:
+		return is_s1 ? MMSS_DP1_GENERIC0_2 : MMSS_DP_MSTLINK_GENERIC0_2;
+	case MMSS_DP_GENERIC0_3:
+		return is_s1 ? MMSS_DP1_GENERIC0_3 : MMSS_DP_MSTLINK_GENERIC0_3;
+	case MMSS_DP_GENERIC0_4:
+		return is_s1 ? MMSS_DP1_GENERIC0_4 : MMSS_DP_MSTLINK_GENERIC0_4;
+	case MMSS_DP_GENERIC0_5:
+		return is_s1 ? MMSS_DP1_GENERIC0_5 : MMSS_DP_MSTLINK_GENERIC0_5;
+	case MMSS_DP_GENERIC0_6:
+		return is_s1 ? MMSS_DP1_GENERIC0_6 : MMSS_DP_MSTLINK_GENERIC0_6;
+	case MMSS_DP_GENERIC0_7:
+		return is_s1 ? MMSS_DP1_GENERIC0_7 : MMSS_DP_MSTLINK_GENERIC0_7;
+	case MMSS_DP_GENERIC0_8:
+		return is_s1 ? MMSS_DP1_GENERIC0_8 : MMSS_DP_MSTLINK_GENERIC0_8;
+	case MMSS_DP_GENERIC0_9:
+		return is_s1 ? MMSS_DP1_GENERIC0_9 : MMSS_DP_MSTLINK_GENERIC0_9;
+	default:
+		return reg;
+	}
+}
+
 static inline u32 msm_dp_read_link(struct msm_dp_panel_private *panel, u32 offset)
 {
 	return readl_relaxed(panel->link_base + offset);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 218a09a2fa65..75b23c106a99 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -99,6 +99,8 @@ static inline bool is_lane_count_valid(u32 lane_count)
 		lane_count == 4);
 }
 
+u32 msm_dp_stream_reg(enum msm_dp_stream_id id, u32 reg);
+
 struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
 			      struct msm_dp_link *link,
 			      void __iomem *link_base,
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index dda4b642c81b..265da58e064c 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -302,6 +302,35 @@
 #define MMSS_DP_VSCEXT_8			(0x000002F0)
 #define MMSS_DP_VSCEXT_9			(0x000002F4)
 
+/* Stream 1 (DP1) registers, relative to link_base. */
+#define REG_DP1_CONFIGURATION_CTRL		(0x00000400)
+#define REG_DP_DP0_TIMESLOT_1_32		(0x00000404)
+#define REG_DP_DP0_TIMESLOT_33_63		(0x00000408)
+#define REG_DP_DP1_TIMESLOT_1_32		(0x0000040C)
+#define REG_DP_DP1_TIMESLOT_33_63		(0x00000410)
+#define REG_DP1_SOFTWARE_MVID			(0x00000414)
+#define REG_DP1_SOFTWARE_NVID			(0x00000418)
+#define REG_DP1_TOTAL_HOR_VER			(0x0000041c)
+#define REG_DP1_START_HOR_VER_FROM_SYNC		(0x00000420)
+#define REG_DP1_HSYNC_VSYNC_WIDTH_POLARITY	(0x00000424)
+#define REG_DP1_ACTIVE_HOR_VER			(0x00000428)
+#define REG_DP1_MISC1_MISC0			(0x0000042c)
+#define MMSS_DP1_GENERIC0_0			(0x00000490)
+#define MMSS_DP1_GENERIC0_1			(0x00000494)
+#define MMSS_DP1_GENERIC0_2			(0x00000498)
+#define MMSS_DP1_GENERIC0_3			(0x0000049c)
+#define MMSS_DP1_GENERIC0_4			(0x000004a0)
+#define MMSS_DP1_GENERIC0_5			(0x000004a4)
+#define MMSS_DP1_GENERIC0_6			(0x000004a8)
+#define MMSS_DP1_GENERIC0_7			(0x000004ac)
+#define MMSS_DP1_GENERIC0_8			(0x000004b0)
+#define MMSS_DP1_GENERIC0_9			(0x000004b4)
+#define MMSS_DP1_SDP_CFG			(0x000004e0)
+#define MMSS_DP1_SDP_CFG2			(0x000004e4)
+#define MMSS_DP1_SDP_CFG3			(0x000004e8)
+#define REG_DP_DP0_RG				(0x000004f8)
+#define REG_DP_DP1_RG				(0x000004fc)
+
 #define MMSS_DP_BIST_ENABLE			(0x00000000)
 #define DP_BIST_ENABLE_DPBIST_EN		(0x00000001)
 
@@ -334,6 +363,33 @@
 #define DP_TPG_VIDEO_CONFIG_BPP_8BIT		(0x00000001)
 #define DP_TPG_VIDEO_CONFIG_RGB			(0x00000004)
 
+/* Streams 2/3 registers, relative to mst2link_base / mst3link_base. */
+#define REG_DP_MSTLINK_STATE_CTRL		(0x00000000)
+#define REG_DP_MSTLINK_CONFIGURATION_CTRL	(0x00000034)
+#define REG_DP_MSTLINK_TIMESLOT_1_32		(0x00000038)
+#define REG_DP_MSTLINK_TIMESLOT_33_63		(0x0000003c)
+#define REG_DP_MSTLINK_SOFTWARE_MVID		(0x00000040)
+#define REG_DP_MSTLINK_SOFTWARE_NVID		(0x00000044)
+#define REG_DP_MSTLINK_TOTAL_HOR_VER		(0x00000048)
+#define REG_DP_MSTLINK_START_HOR_VER_FROM_SYNC	(0x0000004c)
+#define REG_DP_MSTLINK_HSYNC_VSYNC_WIDTH_POLARITY	(0x00000050)
+#define REG_DP_MSTLINK_ACTIVE_HOR_VER		(0x00000054)
+#define REG_DP_MSTLINK_MISC1_MISC0		(0x00000058)
+#define MMSS_DP_MSTLINK_GENERIC0_0		(0x000000bc)
+#define MMSS_DP_MSTLINK_GENERIC0_1		(0x000000c0)
+#define MMSS_DP_MSTLINK_GENERIC0_2		(0x000000c4)
+#define MMSS_DP_MSTLINK_GENERIC0_3		(0x000000c8)
+#define MMSS_DP_MSTLINK_GENERIC0_4		(0x000000cc)
+#define MMSS_DP_MSTLINK_GENERIC0_5		(0x000000d0)
+#define MMSS_DP_MSTLINK_GENERIC0_6		(0x000000d4)
+#define MMSS_DP_MSTLINK_GENERIC0_7		(0x000000d8)
+#define MMSS_DP_MSTLINK_GENERIC0_8		(0x000000dc)
+#define MMSS_DP_MSTLINK_GENERIC0_9		(0x000000e0)
+#define MMSS_DP_MSTLINK_SDP_CFG			(0x0000010c)
+#define MMSS_DP_MSTLINK_SDP_CFG2		(0x00000110)
+#define MMSS_DP_MSTLINK_SDP_CFG3		(0x00000114)
+#define REG_DP_MSTLINK_DP_RG			(0x0000011C)
+
 #define MMSS_DP_ASYNC_FIFO_CONFIG		(0x00000088)
 
 #define REG_DP_PHY_AUX_INTERRUPT_CLEAR          (0x0000004C)

-- 
2.43.0

