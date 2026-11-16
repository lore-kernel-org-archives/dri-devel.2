Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31023606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pTpXaik5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IIrlHr0m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CAC010F196;
	Mon, 16 Nov 2026 13:19:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569FF10F1A1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:52 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0n1I3770437
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OLtoSJeZjAckwtbCo1gNxFkHnpxWN2Z7BDJOvuvO4Ek=; b=pTpXaik5UaLuMpZ5
 gwosfZrHEBd5EvS0s48O2QogFIbv/SkJAFJuMsrQ+MA7DUj1gMPnu2uLfdqkcTmM
 dm1ugjQ4tPXb1NUGppLUq13ywjeRpSwlPrP4YPboXmfypO2bf0rEiO/MX3UFwIKx
 uB2TxD9Ey+nIUdydtSXJUb2dI7W4WotY+/PcP7v54lwDG1NfItVK9tmtVQcMYxUO
 pWibRKdiinOGy5nAflbUBMkcVjgUcEaqmanVclQ3NMUtEUUooQ8W+eCOGuw2EMzE
 9i6MZlOlNYMdGxKoFvUwhFpavOIxjagz2wiFGTsFnV4r1phh/3tqoPlkSgWAhp/t
 oAVBhA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6ggt14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91ebc622dc8so48465016d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835130; x=1795439930;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OLtoSJeZjAckwtbCo1gNxFkHnpxWN2Z7BDJOvuvO4Ek=;
 b=IIrlHr0mhMnrqIjHdi14omPX8FPm8PNUqTt6P0WhpbDCfJwzc3QnCLryZJT+BUSibZ
 qbmSLY+5kQSxohvCtF9YdeBIxj0r500PJPhase2CZOGhRButTu4beGID73sUYSwAL3XZ
 R0YE5eAFzpoTgpTWGOdB/P/FAIsHDtgc6b0OjxOdZQesV8XHemK7kRvUYzPtKglfkEP2
 ZANQlV2ZGkhjNH6kdthfpUUXMx7SHDXkluX57Lq4I7bfsU8On8zWUBzk4prVphADsw7M
 7LFY/Gl8AzYw7QlhF+DHunBrbWcAnkF8LEPMnJPvZlyHCdiAORncPUSCxY1OANm4T4Yp
 xHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835130; x=1795439930;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OLtoSJeZjAckwtbCo1gNxFkHnpxWN2Z7BDJOvuvO4Ek=;
 b=KG4mg2IrkkTrff11nJ/CRgTWLmRG4OAu5FkPu/IlLUXPYFbbA/XRRETuDLy+ZhDXp9
 dZhwFV3bMIiTSRCg+IBhQnv1KSG6rGx62TjtDm0hDRHhXrMCHoDHOKZK2XLU42W+oQ8E
 45NHj/JpnJ8gBckA9eTnLptjEXZnVgtQjIoDd/kWkCh8fyMTI38d7F3FMSrY9aIt7Oep
 TYFwE1opo8jbKBq+qb2K3MRK8r94NdlJVQYpbgXzrg/DFR5q9j8Z/aWbYw8vp+lAHmgu
 gQdywuQJrix2Ge05MhFGikms9HbC55v5JVdEO4sSns5Cf1bndGBJSzlGTXJzKNfDEDor
 O7ag==
X-Forwarded-Encrypted: i=1;
 AL+hErG+Fms6MW7bbQ1IoUHXu/gP1Gn2yiMVLwbpoO+euljIkm38ckQkzNhhMcHKtWFpCQLAA0ttBrWT/L4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8B4qq55vnE2deTduo4FEqi3e9M/TpyY7QuxyogE5Suc9JkyYFg
 7X/bPtTgW4gY8JlnqxSVWqi+VsrcWld79mBAodA5cFrwGtxA6pOcSHdLCwQSuD3ODLIwtOiTCrt
 pCSJqwai92hFV2docXoiCot/FmzdYm0eoe0E4/Dp69MWrrd2PPfSnMcelERZllyMzgF9TSsk=
X-Gm-Gg: AYBFou2MsbkUojH6YJdjTh472tOGvcajeVrvJCRvR85OvoQBxG4GghY6/GAuG4fgrbp
 eToOJKwRUdX/aMgGWkFNUXqtLPjcY8kWXWHBCL9dxQO3BdfA4h4rodaS8iRDpUHyUPMYDHJKdkv
 DZbY2qBFcVBgYpQ46vSJLgS9b3xpnBYdQ+lZtai4Q5/hpdRMIizHXXVrt8DKzC88xPnj+DxIl7p
 ZeUL40SyTjxx3bg5520aJ1LinZFtMir5sSxw+j91Wn1UrA1vJNa6fRW+f6pNzwZ/PstWxDGF8ci
 ilMLHYwSMR8+alUuxZeGfY3DmQXMDo63yyrotdf1w4fdNRJaA63Bo82YZ57n0t6Z9qT/7UNIzqH
 m6hvBavObXYlIw+IJ9tyqYEA+xBrHpLhMBg+szcWluYLBUS36DwAvc1jYA5vG6uGjJ+YXX0OF6i
 A7
X-Received: by 2002:a05:620a:84c9:b0:93c:6507:a6e2 with SMTP id
 af79cd13be357-9494bbdbaccmr1577628485a.65.1794835130351; 
 Mon, 16 Nov 2026 05:18:50 -0800 (PST)
X-Received: by 2002:a05:620a:84c9:b0:93c:6507:a6e2 with SMTP id
 af79cd13be357-9494bbdbaccmr1577622185a.65.1794835129672; 
 Mon, 16 Nov 2026 05:18:49 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8e1c94sm843927285a.39.2026.11.16.05.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:18:49 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:46:49 +0530
Subject: [PATCH v3 10/11] phy: qcom: edp: Add Nord-specific QSERDES COM
 register header
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-nord-drv-dt-v3-10-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
In-Reply-To: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
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
Cc: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835013; l=3377;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=uzH13SMkMubkKgwh4agZIOrQBBl5vNpCxmjdcZREAHk=;
 b=2jcTPord6CLMISExCWLoyHcqTIsMG4HEHO7kN0UTK6uiwaaMI6hNbcfoM3VzAX006i/Bc0BEB
 cBWkkijyMlNAVEhWe9jT4eodcbWIAjoO+vvpSe0yHdF62jnup/6CuZm
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX96KxcmWKWOqj
 znpal3eLRvLi0TkqOauEpxkwYXfNgsDyW0wv+C7lkC2k3MAeywqBV7iJ0us3hKE34xudfdvUyA4
 ZZwEa4NG070nid/SeuEKy0jOjBLJcNkW0s+zAhW53/sY7UUEopWAkchEr8j9qPprW+BT3PKeTdN
 ixyUb49HcXQ5AcbSX5Izxvz/ceHguSmJLHaAdhpa5caacGhjxjmdju5DZxXAKbd5D39AFNnV43D
 JIIT+Bd9dum5EXkQrUDZUF/IW+Bm/6PTzOyZz6MVLvCLYXVDGRVgrEz99WYpkrHOqR7PnVL4CVC
 H9YI0m8W5hVzIRQ5hI//QrSkk5/1RpSQynEfcyIeH0eKyxOD9wLxxiPI/0JB1fc88U+wUs8kguF
 ZuJqaHH3WKLi+cv7J+/v4wXCmFkzlA1V1sOtounIWVUKnTlEG7t2E8lOdoDF/LRL4DeHpwCi4R4
 ohXQENWCGMgh+yHW4cw==
X-Proofpoint-GUID: ASDxvh-Fyra4P2EXNdpzn2lwFGdDSjAX
X-Proofpoint-ORIG-GUID: ASDxvh-Fyra4P2EXNdpzn2lwFGdDSjAX
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afb02bb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=PUeSZSab_OCI25pZbQQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX+b2kHjCP9oi/
 Q70BQwR6hXZcId9noI7lSyLm46Ld+sqELw7i+g9EpRSc+0He+GK1s+FvBI2Cu3kUnb3AT9Tjk9I
 liG8yc/7n535KONq6q1K93Yxc72gVdo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160052
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

Nord relocates several QSERDES v8 COM registers relative to existing
SoCs.  Rather than adding _NORD-suffixed defines to the shared v8
header (which would leave it ambiguous whether non-suffixed registers
are valid for Nord), introduce a dedicated header
phy-qcom-qmp-qserdes-dp-com-v8-nord.h that lists all QSERDES COM
offsets Nord uses under the NORD_DP_QSERDES_COM_* namespace.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../qualcomm/phy-qcom-qmp-qserdes-dp-com-v8-nord.h | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8-nord.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8-nord.h
new file mode 100644
index 000000000000..f38b48dae39e
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8-nord.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_DP_COM_V8_NORD_H_
+#define QCOM_PHY_QMP_QSERDES_DP_COM_V8_NORD_H_
+
+/* Nord DP QMP PHY - QSERDES COM registers (relocated from v8 base offsets) */
+#define NORD_DP_QSERDES_COM_HSCLK_SEL_1			0x03c
+#define NORD_DP_QSERDES_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x058
+#define NORD_DP_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x05c
+#define NORD_DP_QSERDES_COM_SSC_STEP_SIZE1_MODE0	0x060
+#define NORD_DP_QSERDES_COM_SSC_STEP_SIZE2_MODE0	0x064
+#define NORD_DP_QSERDES_COM_CP_CTRL_MODE0		0x070
+#define NORD_DP_QSERDES_COM_PLL_RCTRL_MODE0		0x074
+#define NORD_DP_QSERDES_COM_PLL_CCTRL_MODE0		0x078
+#define NORD_DP_QSERDES_COM_CORECLK_DIV_MODE0		0x07c
+#define NORD_DP_QSERDES_COM_LOCK_CMP1_MODE0		0x080
+#define NORD_DP_QSERDES_COM_LOCK_CMP2_MODE0		0x084
+#define NORD_DP_QSERDES_COM_DEC_START_MODE0		0x088
+#define NORD_DP_QSERDES_COM_DIV_FRAC_START1_MODE0	0x090
+#define NORD_DP_QSERDES_COM_DIV_FRAC_START2_MODE0	0x094
+#define NORD_DP_QSERDES_COM_DIV_FRAC_START3_MODE0	0x098
+#define NORD_DP_QSERDES_COM_INTEGLOOP_GAIN0_MODE0	0x0a0
+#define NORD_DP_QSERDES_COM_INTEGLOOP_GAIN1_MODE0	0x0a4
+#define NORD_DP_QSERDES_COM_VCO_TUNE1_MODE0		0x0a8
+#define NORD_DP_QSERDES_COM_VCO_TUNE2_MODE0		0x0ac
+#define NORD_DP_QSERDES_COM_BG_TIMER			0x0bc
+#define NORD_DP_QSERDES_COM_SSC_EN_CENTER		0x0c0
+#define NORD_DP_QSERDES_COM_SSC_ADJ_PER1		0x0c4
+#define NORD_DP_QSERDES_COM_SSC_PER1			0x0cc
+#define NORD_DP_QSERDES_COM_SSC_PER2			0x0d0
+#define NORD_DP_QSERDES_COM_BIAS_EN_CLKBUFLR_EN	0x0dc
+#define NORD_DP_QSERDES_COM_CLK_ENABLE1			0x0e0
+#define NORD_DP_QSERDES_COM_SYS_CLK_CTRL		0x0e4
+#define NORD_DP_QSERDES_COM_SYSCLK_BUF_ENABLE		0x0e8
+#define NORD_DP_QSERDES_COM_PLL_IVCO			0x0f4
+#define NORD_DP_QSERDES_COM_SYSCLK_EN_SEL		0x110
+#define NORD_DP_QSERDES_COM_RESETSM_CNTRL		0x118
+#define NORD_DP_QSERDES_COM_LOCK_CMP_EN			0x120
+#define NORD_DP_QSERDES_COM_VCO_TUNE_CTRL		0x13c
+#define NORD_DP_QSERDES_COM_VCO_TUNE_MAP		0x140
+#define NORD_DP_QSERDES_COM_CLK_SELECT			0x164
+#define NORD_DP_QSERDES_COM_CORE_CLK_EN			0x170
+#define NORD_DP_QSERDES_COM_CMN_CONFIG_1		0x174
+#define NORD_DP_QSERDES_COM_SVS_MODE_CLK_SEL		0x17c
+#define NORD_DP_QSERDES_COM_CMN_STATUS			0x1d0
+#define NORD_DP_QSERDES_COM_C_READY_STATUS		0x1f8
+
+#endif

-- 
2.34.1

