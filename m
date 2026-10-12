Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54AFCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E5410F111;
	Mon, 12 Oct 2026 13:33:52 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E899010F127
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:41 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC03lV801966
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nqvWxQWmUv2zJ6ZFnYqwngz9V/6SjlL9w6dmGrY4XIc=; b=D+Hr+UQDCHFw5PZ1
 1P/OZMZOjbJ/smVoPLqbBQVfG/i0BKf6sNe2DuG8tved9s6AS3NmAMTSuwWBEC/4
 4YMglO7zD0KDg1XxrCQc+BVbyDJgRVmOiqiIVxMxllh+Obv0YKaulOGOqlpnS/Qe
 HZBs+5nnGAmr6eHS3+xqQybmSj1NaGvNcuX1Lc58f6hWcWW0BMqlkEZOeS5Cycxe
 /hfuogYGhdqdRRdBoXx9j25IhACdN3HvwSO0IKoauj8LDO9amgWFua4OjYptvSvw
 UjZ4+CmnUOJ/CHm1RK+hTAVKh88rUjvX9DzWwh4/PQbU7nuGc3QCO980bHAkl1ji
 tYQOAA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcrwbs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a0c25def6so2281962eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812020; x=1792416820;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nqvWxQWmUv2zJ6ZFnYqwngz9V/6SjlL9w6dmGrY4XIc=;
 b=R7PnERofvep3QDbC1Q2ncZCgWSqQVodY6oVUx1iRB+PedCHL0mQKKSh/C77usFoYSW
 tck2QvXgiSyDAjhU5nJpMeOB+ql9JU+A9d8xdACMnGRY+mX7N0CxLF26PXO9mXemkPo4
 4SompQqXM1K8MvHCcrN4SPGMU1tdde+waFbtdlnq/Z8lPWqMnXHrUCfBYaxCJv7itXhv
 Bww+uxJcRgKxhPQRHG39wfKiEAgz+B00rKpPT5Dzb3sB453hdwcqoCIkQznRnYK69oPz
 fIJg2mXXEk26KCDnbIX5yoG6x996sz/tqZcZasqM4OGSAUIGLzIbfFLOC/2FDiSMC2V5
 ty1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812020; x=1792416820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nqvWxQWmUv2zJ6ZFnYqwngz9V/6SjlL9w6dmGrY4XIc=;
 b=gFDtgkzUhjISRy2LzxtdvEzI1BSCm2yJx7WXzJuxSEpT9FuK4pEKc40mGtUz8RDaEw
 ijVIc0BpfFBEO/hDY/m8uGKHWjwpt5jW/IEFQxTchDKe//y9NGVKd4ckjSUwccgDWapc
 8O3wOp800eiLix7rO/3Z3oBh8XCBOTiJ6XVWx2z5ItaRD0tKUjgKn9NjYel2PisXeuIf
 xWB/O6ie7wtDVpOZF++GOUiiisBGLwZsjlYABWXBAnTC+fabP6LVVaoXikE3iEewXCuM
 MrTXIipuWvZW143nM9fU2vwf8hPtIcYI/OS/y9+lTiN+WiQWlrgd8Kp0SxdgVee8h2Yz
 VizQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjzhjcPMrbqo5XkcUvtQzFgb3Rg69323pij5Na7dRCrY4BxOkHLULVcNf9R6+a+mrkde6jJJ1w8qA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLYYdsAilQbB0nW/FmWzMZq5wcEwgzUs2g03xe8ibsPTKqbDlvu
 +AvBU2Gp13K+Mzh6HjzTx/alYb3EL/vxfdvbJFAofgmEn3Qa9nno/TCyu7b9M+l4OKaSsAQOrgG
 E9JZFh4lyd1ouhdcmttMqVdWS96ZgK5MpGhkpPkXsRJjt9SYglLUvGw+GWtvO84aRGotEG1g=
X-Gm-Gg: AYBFou3ulpzRe24gBDt1o3aMlcYdvZ81K3+RhwCfqhDWQUnkA5KSKihDJCzkuquSQev
 4zR/zyifDIpbvlDalcXHk4Fj5LVTVLYjjNz4DcQMrMQ4sc86Y6d8Z5GGRXyVIxLs7vJpv/BBuyT
 nWHyICdn9dG1zSnS3qL9XhwI0TKUPr704OluJjwrcE+o62YfJ14rG2845wyfjhQY1GcrmB+Lvru
 SP/e2SE4SoER6BOVgZXp/x7cHl2su4O4muWwIyX+UdR/C7cIdeiAeazE3WOJ67n0xtNcEBN5RfZ
 ZJFyjD7B2MJDtNzqcMQ5qBO0trcmh+DKYICVdiXCTXcSKxw7TTWDFCU2zMsnHYzkbTMjSXZr2cN
 Dy9ftwSzp6sFH+Y3Pf58R40JiL8k=
X-Received: by 2002:a05:693c:895b:20b0:35a:7010:e7e with SMTP id
 5a478bee46e88-35a7010129bmr4364185eec.10.1791812020203; 
 Mon, 12 Oct 2026 06:33:40 -0700 (PDT)
X-Received: by 2002:a05:693c:895b:20b0:35a:7010:e7e with SMTP id
 5a478bee46e88-35a7010129bmr4364139eec.10.1791812019593; 
 Mon, 12 Oct 2026 06:33:39 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:33:39 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:17 +0530
Subject: [PATCH v2 07/13] phy: qcom: edp: Add Nord-specific register
 offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-7-a2ab9af954d2@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
In-Reply-To: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=2115;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=c/c4UrdKyLlxloOv0LlIJQUlth4rww+DxB4ild3JaGI=;
 b=kc3eX6lPE6whC9wQAkDtJNxIJhgIawVZOCerNkpQNd6HZGm4loYUzs011lrQvvzYbEgHT6xlF
 0zE9L0dbJi3CQQpCyAgx+ISicnD06hEAF2qQQosv/ETD2q1KD2Xfbir
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: ETgDIivfaepoiPFqsrpOfc2xwQS7XOHq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX/cMMGNoH1TiZ
 N6MF+LRy4C7cb2R2hzMw84pXThrQdU7GbZTMr1WyryUnIsoVP5axQYl4n4WMQZFPYQ42MBXrJrc
 lwxO3M65JjKcg77B30+iRkBjQWme6mk=
X-Proofpoint-ORIG-GUID: ETgDIivfaepoiPFqsrpOfc2xwQS7XOHq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX9m83IsAOxS1U
 QvTjk5WyljE6j1hULjcO8rDUPvUiaYUu+Z22eQRLw207G5VGg16w1QMD/mHGLMWzsEF0Cf95zud
 CxlmQpB6tAH4E/JGCaa6qvkQB5jyzQmRRF2l9PAZ/x6Sgz1pdeNdj5Cb8+CHT+52dUFDqYdiLJu
 fpgOCk6eEdB7jDGUEYfpPROCLDgcxUrKsFrxsmbOUU23k7t/nPrnEtUtnQSvJqzNi/zSRgPszeL
 x8ZU05c3w3QPgfZGBUfWMDS1h9pdKgHr7VY1tbKtMFZLSz0C06HaduUDNl068uF9gnGLctIcqwe
 7Qoh/9DI1gW8zxpwVP66HthM3kEHvnCcxCMAKNkGRSodv5/SllpSNTUeCVZAtayQ1aRg0tI+KWd
 OG+Ggyi2fmsjMKh/RgXgkgW8jEBxG+jZrQLnn9vRLMopXUV7XGtNlvp+zNJF2eWphXpn/LzpiVJ
 f6cZ1LfRnXNI5XoITBg==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acce1b5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=wv6mueO1Yvltf2_opTEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120053
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

From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

Nord relocates several DP PHY and QSERDES v8 COM registers relative
to existing SoCs.  Add Nord-specific defines for the relocated and
new-only registers in phy-qcom-qmp-qserdes-dp-com-v8.h and
phy-qcom-edp.c so Nord sequences can reference them by name.

Assisted-by: LLM
Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c                   | 7 +++++++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index a3c893f72908..d5c6835b6c70 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -42,8 +42,15 @@
 #define DP_PHY_VCO_DIV                          0x0074
 #define DP_PHY_TX0_TX1_LANE_CTL                 0x007c
 #define DP_PHY_TX2_TX3_LANE_CTL                 0x00a0
+#define DP_PHY_TX2_TX3_LANE_CTL_NORD            0x00c0
 
 #define DP_PHY_STATUS                           0x00e0
+#define DP_PHY_STATUS_NORD                      0x0110
+#define DP_PHY_LDO_CFG_NORD                     0x00f0
+
+#define DP_PHY_TX_LN0_DRV_LVL_NORD             0x00e4
+#define DP_PHY_TX_LN1_DRV_LVL_NORD             0x00e8
+#define TXn_TX_BAND_NORD                        0x0024
 
 /* LANE_TXn registers */
 #define TXn_CLKBUF_ENABLE                       0x0000
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
index 93edabb830af..008b17222a8d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
@@ -48,5 +48,8 @@
 #define DP_QSERDES_V8_COM_CLK_FWD_CONFIG_1		0x2f4
 #define DP_QSERDES_V8_COM_CMN_STATUS			0x314
 #define DP_QSERDES_V8_COM_C_READY_STATUS		0x33c
+#define DP_QSERDES_V8_COM_SVS_MODE_CLK_SEL_NORD		0x17c
+#define DP_QSERDES_V8_COM_CMN_STATUS_NORD		0x1d0
+#define DP_QSERDES_V8_COM_C_READY_STATUS_NORD		0x1f8
 
 #endif

-- 
2.34.1

