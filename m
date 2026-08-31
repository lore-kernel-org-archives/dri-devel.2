Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11002C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C05910E71E;
	Mon, 31 Aug 2026 08:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RClJgwUo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KT/+TzTg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A92410E71E
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:22 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xZoo3427261
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TOMG3yp218IRb7X4mHLShdrli/+A+w+d0UixRrJLDGE=; b=RClJgwUo77pHmJAY
 6hldljYsej+SBGeFDATTQ7DAPg4GbKFxE3jBYHnBOD40YEzwCdtJj94kiKRc/LhE
 DR55lro1hbFv9358OPYwvtcKZldpeEiijNqiqErlF0B/x6EpNHrl8N3Noq5rxLYl
 M1DYQcz4cs9NRhvd46uunakQG2a7Q+efAvz6ew831g3uEEXj/jZ+pF257NP44ayi
 ADle7OwGgkuTMM5QiNSzmOOBptCGy5BGliRs0B9kE65eLdRAVlRZxwZiDNGRYCd/
 VmH7LYHbERuV4JAWdEbHftdA4oEmKpDI9FdKbqkAp+mQttFSPmloX0zoWyzNj+F3
 qMcV6Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4pm8brp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93918756165so698490785a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164301; x=1788769101;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TOMG3yp218IRb7X4mHLShdrli/+A+w+d0UixRrJLDGE=;
 b=KT/+TzTgmu5qUem72OIpVoEeGwe5Xn9/JvrGTWfXjlg2i5tefWctcFSoHX+DbN76fk
 hevMwsZIo0HJlKarh52LRJ2J31y910b9GfwVbinkRJlCXSqvcSiFhDermfN/Shj4pBm3
 HjpmvXj9CNPsTViSITH6eGlCJD2kC7QRWBNzbrTm6Uz6Pc2lUxxqcZkGb0pd6e2GO7PO
 nN5si444QC+SIomO2MD2ldUarVWS/wFvCHyh3YXoLveOoFWR1TovEG6Y28DiZK51BE/n
 ouWU6jEFS/TcfgBpNLArl7mCNjIKiUcl1qUQT6csracD3bbZeOd11lJ156UzmgEOYfgh
 sWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164301; x=1788769101;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TOMG3yp218IRb7X4mHLShdrli/+A+w+d0UixRrJLDGE=;
 b=fGFWI4uQ514gS7hunXo+gD7qe3XbfGJEkCDP8paI4UZVmTumG3uWBQP6hOSSNh0vzK
 uBHTFpvkbApo/ESP4UyBHznyZS7p4Sjd+35pW0nGxsL9dyYyMv2ZDNSPpQQxtK3sI5Bk
 /tplMhadD7iy13nqecwG8Yt1Ll5fW3pAiRsL7ow9A5WXrtQNZx6VKH6SacXYIUc4Cl43
 kKPQR+hJG9WH/mR3TvgubKIfUwAxDAipgkC3Q0v/pUAtIPsfIhir/sR7/ByrTpHjKEBi
 D2Pfye+wBScJ5GL9/oZUm024LTOkn+yrD8ePUbXRUzoLt8iHowRy8kzfqN/+PX0y7l27
 sK3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1Q1gBdM16FzPZet3HNapHqxdvs/Tf6LoGfPreDblznBu5UPFONkVQ30DLsKynGmOhYxzxSL/q1y0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n3ESE6X8Lm2+YIZsEKg9Yotp2lowImilyQ6YvEMWK1MdFT1eb9
 dPj9u6U5Prfz8Q3RhduLdjjkcw5p5lgwXWe+Pfy3+UsIr3QDuEB5jraxbFn/Usi2MJijhCMqpry
 8rBgpxXw6OYZttWeAj5cLfkcmED8DTylrbyee/4KHpWWIex479TKe8nBoL96obuUJXYgB7/Y=
X-Gm-Gg: AR+sD12hEhSC1jaej3vp+9GvfO1QQxuBCM+Uq42+gh2bHoPX6zontr9l2HTZB42Gza7
 /D+QzDOkQyFa/nxss5rxhmdAAZ/9F6aYgM6l2czIIl8e7G07D3DYmq+WgViPQ+RfLpj8XJPiuhd
 oeGIc0k5xoN18qqVKMWEXYqt1APu53eiTcE+9A4PO69knOEloLLgxINRn5wrwvBUpMxI+roWGpE
 UM32Vg/DR+b8+6FEer82FPPuyo614p1g4PPRixkyY5++Vmt0m9+SLHkNpCB1+uNFGBcJkPHGNde
 EjDZQ6d2NfkdqdqZpdvUjUIaitgJrktGiLzvqGL4q7JnmQBDLFgbMR44L6hRyxjDf6eaeG0a73B
 +1E19NLFKbGTKDmoViMzbWWQP842qVzXa7l9PoMsq1VhXIzk66y6PcNeRDC3W6cw=
X-Received: by 2002:a05:620a:800b:b0:939:7c8:78a9 with SMTP id
 af79cd13be357-939427fc764mr120628585a.3.1788164301485; 
 Mon, 31 Aug 2026 01:18:21 -0700 (PDT)
X-Received: by 2002:a05:620a:800b:b0:939:7c8:78a9 with SMTP id
 af79cd13be357-939427fc764mr120625085a.3.1788164301042; 
 Mon, 31 Aug 2026 01:18:21 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:18:20 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:26 +0800
Subject: [PATCH v6 09/29] drm/msm/dp: add support to enable MST in mainlink
 control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-9-c91d35d6fb9e@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=2557;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=8IxMe+vOOiLPxKEsXO6U2qctxURhGCfNOY0j4XpqOyE=;
 b=5Lliw3sD7lBYuB4Fhpkt0TWooGx6Wfwa+3oaQRLxQPkkMtj8jfKPFkgbLrvA78umzegQp9FlX
 XbaNtx+8RPSB56FR9NXiIqgKFVI2H+O836qf1iXoazP7hMeyWMuXnTS
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: iaDg2HYDkmCritX9lW56_Q6GovrwO9ni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXxj5Zo+fAI0j7
 QSSfiFs3MCAwi1gHRE0OZ+xP6Hc69QASjAmbQZxxSecDBjwrdTdPNHqVrAF3DhbdXDCa9L+LVNk
 xUetL9gWiDwl7mIgAJLgcp956jJXhSFpVDy+AJPL93V3YZLzLdUCyVfsHMskmQL8sMFUmVwaAIr
 YWeKpwkZ7QgmOz7utZZJOTlJXqRL5f9+eisKS0occ2tn4K2ewlL/bsMwBfYdpGcQEF0Q0bTOUgm
 mx11JLH1UWWz9c4YCWGd+gXr83NxupiyWzbaDgzZTdkNTK8Pi6paK66a9gEYYCWgO9Nvj9P53bP
 nAE2gs+JB7eonYL/8Y6MsAIqUE8zmyzy+9id4wFcXld4nOCFFMWMUni1o9XIjmtESxus10Hdym6
 aHNwO225i6Gr4XT107laWn1RgD3ThZkrztyKkF/RUx8WHZF04LkoWdSNu3EgRrKI3eq8kzdBitJ
 Qhv7U8whk6BtjadjCbA==
X-Proofpoint-GUID: iaDg2HYDkmCritX9lW56_Q6GovrwO9ni
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX4DgNEPGrVC22
 FYNa7lfhYqJ1eB+2Oyi4T6lf7NRYk3cwDWhkVHGyxb+/Qlg1eXjRuIILUfl0udBHG5YF6kYDZMf
 +WkclbsS+nHTMvB5odnkD6CJPWyAahg=
X-Authority-Analysis: v=2.4 cv=GbQnWwXL c=1 sm=1 tr=0 ts=6a9538ce cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GJT6Fafo9oTAj6z5dyEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add support to program the MST enable bit in the mainlink control
register when an MST session is active or being disabled.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 16 ++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_reg.h  |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 65d22505c2b6..cd6ae0d5372c 100644
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
@@ -2680,6 +2693,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
+	if (ctrl->mst_active)
+		msm_dp_ctrl_mst_config(ctrl, true);
 
 	msm_dp_ctrl_configure_source_params(ctrl, panel);
 
@@ -2730,6 +2745,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	phy = ctrl->phy;
 
 	msm_dp_ctrl_mainlink_disable(ctrl);
+	msm_dp_ctrl_mst_config(ctrl, false);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 9263e61c794c..cc74b1ed628e 100644
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

