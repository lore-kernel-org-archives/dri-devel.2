Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99890106B50C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E1010E8B8;
	Wed, 25 Mar 2026 12:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9Se5181";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J+rPV5/w";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B04E10E8B3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:16 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBGaIT876370
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sE/X9TaBswHSoutSFu5zfCfu4vgJw1Sp7OALRwW9W2E=; b=T9Se5181rG6pMXPi
 ZFkTpDaTgxsVskEbrtROTawt3F/BH+Gb+Z3wM89mSwsCs9SGlAk8mwHrDyzCD3Ie
 4woEAfN5oYgM5Dug8DguJZvbDhBEtcfh4YndtRtIil8Ze2b/xipMSrqbgLjyOxaO
 Rw62FQAAMoPFmcQPGLkerH67hispEbMhhUe2PALX2xDakVljaUGYoyj5Lp3zjtPF
 4jjtkOanMXpSBHmdh77UpdoT0lADB3m9WIJ92P8xpPrNlPy/GpZ6rJ8os/tfmnaD
 FFcLH++9uiiAj5iofVTJllKV53RiMj0tuoPzZT/9C+iG6xY9CNa3tAnq8gNfOvLg
 D3xXvA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40f4k44q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:14 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-94ac4a7230dso5541927241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774441034; x=1775045834;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sE/X9TaBswHSoutSFu5zfCfu4vgJw1Sp7OALRwW9W2E=;
 b=J+rPV5/wM6a9Cex+adDg6aQ+Tvn7YmdDikDixa3eRAq+vF1T/U0LOdS4zpj1Pc6AQ8
 feuA9oBUmQfErWNgkV3sMM48LWWTz7yqGkc9IaXnjkTA6GPsuyeB68vCZ2VB1Xkpwl2U
 oss1XuE7LiicQ4VjkFgg3c0JwFiexvvEByGKTLgqazIKkGFfooryaztRAeAWyE63llEB
 iX1BbrwdIXchaPwW88wj2yGWPnbEb1RvP+Pi/c99ks9mYSypur/pEtRzjOXD8MTBL3SF
 1jG+mr+IuSC0VPKMTcPD2LyPWSLKlIuEjyHfA1L0P5nWu873SIWz0TkOvgHx0GlTrBEC
 VDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441034; x=1775045834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sE/X9TaBswHSoutSFu5zfCfu4vgJw1Sp7OALRwW9W2E=;
 b=NKYOJMSb1HVUcnyq/gqG6n45hRYyR7Xylc7NMdbC+qbNNRF4crwpMO/lorTAjRCFY8
 m5MTdpCS8pEGNvP2V/RhDqJ9GW5HXLQPFXH8M7b8PAvK6qrySekWOcdRtVydwx356uap
 /OwmphZ4f7fxJQlY0W9StO22t0TRHD7zvvZU+sp4IxM39HIB56NOsXjYTj2fI/akHFd0
 g5F+mlaL5TILyUqweZkaKw/76BrDuhiu+4oGlb6rg1sHa+/SJGen0H9U5KbXbiMIg/6S
 f/qs7KUlcXOwWNHbKdHcvKQXvgIwNTw5TbcZ/dT5xj1b9VGj8VI1CNRRAuJoOcteReEI
 JBzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgSAgL8sjFdzOgKPs8/4vhiZ/hZcPOixM4Bs4kroshGHS3oTu7VwNR8kKXABjkrWeCKScjmIqYQ3Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfOIXX34zYU9FiEDdiKgbJhUseprp2D3JmKhph8n4QtXqrkYO6
 jfdMxCvvGyQk87sBUcn9xJk2PERy8ZWQjF/PQ1b91WyJ5ptXk5YoL6vxyY5K6dtemxouOiWGqpR
 Zau6eoY42baSnOxe6handBW4HSMCyScQs/UN8ojZmm6kTP5p+c2lZidHhIj7XM1c3vkrCrkc=
X-Gm-Gg: ATEYQzzFI+lt8IYNreq7KQR3fQI13LK40fZvY5FS9q4LR0JIn78xfH+FMf6MqF0D2G8
 9FyXoTmgnmsOVoT9oX5LCl+6qSZhvX5BA9E1lzB4PMiHjZdU/PC84WbEJrgQxKNsVL3BenjGxmZ
 WTJFItVJHKd3X98ipAsEZ06nq729Vs5MIsoaH2kdlPoO1AT+GMNNuPXzn1IZj3m4aYRm2u/0pSc
 U2esiMCAGEK3VTXWP51ogzlAO7uadl8p52ybnDJgTnbsSebZy8EcBeZEY4W8zRlOsuO/Hx95kDu
 /eqORolBi99BeLcFA2C3HBv5i/coV0N25C8E9GFNzo3qA/ZwrXeP8yN6gHuZ8S8p/Dyg3oZASy7
 hL8JaQq0pMOseU3zHq7yK10I3Pulvs4qjDHfElHyd3QnZ
X-Received: by 2002:a05:6102:809f:b0:602:709a:52ce with SMTP id
 ada2fe7eead31-603870aae4cmr1471011137.10.1774441033979; 
 Wed, 25 Mar 2026 05:17:13 -0700 (PDT)
X-Received: by 2002:a05:6102:809f:b0:602:709a:52ce with SMTP id
 ada2fe7eead31-603870aae4cmr1470994137.10.1774441033500; 
 Wed, 25 Mar 2026 05:17:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8a106339sm6480356f8f.36.2026.03.25.05.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:17:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 13:16:47 +0100
Subject: [PATCH v3 6/8] drm/msm/dpu: Add support for Eliza SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-drm-display-eliza-v3-6-dc2b2f0c74a2@oss.qualcomm.com>
References: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
In-Reply-To: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12943;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=PbitL4CSumQClLc/UFacpLO1SjYL2Pb+7GHHapEhIn4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpw9I09lPDIkR4Ne2Dxj9VnGQFjH9OqZo9yVtCe
 1kKhTDn3dGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCacPSNAAKCRDBN2bmhouD
 12suD/0cpelqU1g4GbcWW2fN8eXA/bh1P7TYOaJVYTO2IksxO6nS7Pt8m0HQzPOtpDNv7Xo4Ddn
 G7Kwgr/kFFdDHTqZZJugBRbFvJ/DkFa5HOIKk8qGanQOtiRwlc17xUd5VjPftqp2WKDlHZeMKpE
 lYVomZNJkYTcnsKsFnbDX3k4RKsQoCgX7lTpZoauAX6tPPlBPeB+BzjKWSOjZKMJDB+4c+nKbf2
 +6D5wjPa3D+0VWZwEaoZdMZNuWcswEjuv50D1W97ZAZAxiNlYyfTp3nVoZgcTFsQrkLzJUtJ9FE
 QBCnJ037okJzSAjJr6J0xge4061FaOFRnFAvwF5EfR06bV/HB26RpO0bpFlUlfaA6e5MKGMljcS
 pZaJ9ViFEVzBZKzVcDEyR0nECcJ3qbZV11LcyWB78ydp+uzGOQVXAPTn/loNNo+db00+dhtbQcB
 S+0JbLLftxepxkGNCXRhzLjXA2EmPBIOBDp+iFSX/t/PRCKxmsjP6k2Lk8Hqok3j15vLNzmEXLu
 ycOesARm+GECT9H4DvL7Xo1eqQ0Ub+yab5kjIZmVegrjTVwIThL0gp3qtLKPQCHdf/7S5mkN/gg
 1XV+iovHXPvHhQFCYX4I6xEBr+wFT7OGsr361vopao156t/lSMHv+jZHEXH7+s41YBthd3kcxsj
 +3ZZIgzc8swYt3g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NyBTYWx0ZWRfX1UU2/Y3usVfn
 VMnS+likV99D0+Pjs5ika2vFiCOcos4B5hap24eRwMCDxWOrEqkeFTZ6q6gAn3sFUoeUkcx1iRp
 JtYieGV+SAf4q2imFdWyLmt12ZsZYdg9I6zm19XlNniSe1v1gAtt6gFXTB6hvu93/BxD2sE8J1u
 1ydqZP0rSkXIC/S44YuslSOXTT9hJUylN4icHhXqep8zI+mqn1aFHypT2Q7Raq86YYCxU9i3KAj
 XfyP7NUEif+IrMyz4fqCuc3sJkgyn8dnv+J/5B176TLUSug8qflqzA+xOD6S0A5hmcv3wR5wNdL
 E4BAp/zhg9syp1hZdh7Om9OkrsmHegW/39IGhSGvn//Gt0wbqNG+WyDHT6Tfg6Xpdmdhr/k3DZ/
 Vvbd2WtsV7EtBebAUONwdq6p74wKpXDy7jwJPuOMnLq+E0ew2aLwGm/y8qGrx4Bhod1adUw5XlL
 pSC/XRFWWK1IHe88edQ==
X-Proofpoint-ORIG-GUID: HHlqIESC5uixXup9sq6Q3gkPuADj_T_B
X-Authority-Analysis: v=2.4 cv=Cd8FJbrl c=1 sm=1 tr=0 ts=69c3d24b cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=iownPTfTGqJqHk1l-jUA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: HHlqIESC5uixXup9sq6Q3gkPuADj_T_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250087
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

Add support for DPU (v12.4) on Qualcomm Eliza SoC, with one
incomplete/skipped part: HDMI interface (INT_4).

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v2:
1. Drop stale comment
2. Fix INTF_3 controller_id -> DP0 (Dmitry)
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h | 365 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 4 files changed, 368 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h
new file mode 100644
index 000000000000..f718a181af21
--- /dev/null
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h
@@ -0,0 +1,365 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _DPU_12_4_ELIZA_H
+#define _DPU_12_4_ELIZA_H
+
+static const struct dpu_caps eliza_dpu_caps = {
+	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
+	.max_mixer_blendstages = 0xb,
+	.has_src_split = true,
+	.has_dim_layer = true,
+	.has_idle_pc = true,
+	.has_3d_merge = true,
+	.max_linewidth = 8192,
+	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
+};
+
+static const struct dpu_mdp_cfg eliza_mdp = {
+	.name = "top_0",
+	.base = 0, .len = 0x494,
+	.clk_ctrls = {
+		[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
+	},
+};
+
+static const struct dpu_ctl_cfg eliza_ctl[] = {
+	{
+		.name = "ctl_0", .id = CTL_0,
+		.base = 0x15000, .len = 0x1000,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
+	}, {
+		.name = "ctl_1", .id = CTL_1,
+		.base = 0x16000, .len = 0x1000,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 10),
+	}, {
+		.name = "ctl_2", .id = CTL_2,
+		.base = 0x17000, .len = 0x1000,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 11),
+	}, {
+		.name = "ctl_3", .id = CTL_3,
+		.base = 0x18000, .len = 0x1000,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 12),
+	},
+};
+
+static const struct dpu_sspp_cfg eliza_sspp[] = {
+	{
+		.name = "sspp_0", .id = SSPP_VIG0,
+		.base = 0x4000, .len = 0x344,
+		.features = VIG_SDM845_MASK_SDMA,
+		.sblk = &dpu_vig_sblk_qseed3_3_4,
+		.xin_id = 0,
+		.type = SSPP_TYPE_VIG,
+	}, {
+		.name = "sspp_1", .id = SSPP_VIG1,
+		.base = 0x6000, .len = 0x344,
+		.features = VIG_SDM845_MASK_SDMA,
+		.sblk = &dpu_vig_sblk_qseed3_3_4,
+		.xin_id = 4,
+		.type = SSPP_TYPE_VIG,
+	}, {
+		.name = "sspp_8", .id = SSPP_DMA0,
+		.base = 0x24000, .len = 0x344,
+		.features = DMA_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 1,
+		.type = SSPP_TYPE_DMA,
+	}, {
+		.name = "sspp_9", .id = SSPP_DMA1,
+		.base = 0x26000, .len = 0x344,
+		.features = DMA_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 5,
+		.type = SSPP_TYPE_DMA,
+	}, {
+		.name = "sspp_10", .id = SSPP_DMA2,
+		.base = 0x28000, .len = 0x344,
+		.features = DMA_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 9,
+		.type = SSPP_TYPE_DMA,
+	}, {
+		.name = "sspp_11", .id = SSPP_DMA3,
+		.base = 0x2a000, .len = 0x344,
+		.features = DMA_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 13,
+		.type = SSPP_TYPE_DMA,
+	},
+};
+
+static const struct dpu_lm_cfg eliza_lm[] = {
+	{
+		.name = "lm_0", .id = LM_0,
+		.base = 0x44000, .len = 0x400,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_1,
+		.pingpong = PINGPONG_0,
+		.dspp = DSPP_0,
+	}, {
+		.name = "lm_1", .id = LM_1,
+		.base = 0x45000, .len = 0x400,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_0,
+		.pingpong = PINGPONG_1,
+		.dspp = DSPP_1,
+	}, {
+		.name = "lm_2", .id = LM_2,
+		.base = 0x46000, .len = 0x400,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_3,
+		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
+	}, {
+		.name = "lm_3", .id = LM_3,
+		.base = 0x47000, .len = 0x400,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_2,
+		.pingpong = PINGPONG_3,
+	},
+};
+
+static const struct dpu_dspp_cfg eliza_dspp[] = {
+	{
+		.name = "dspp_0", .id = DSPP_0,
+		.base = 0x54000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	}, {
+		.name = "dspp_1", .id = DSPP_1,
+		.base = 0x56000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	}, {
+		.name = "dspp_2", .id = DSPP_2,
+		.base = 0x58000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	},
+};
+
+static const struct dpu_pingpong_cfg eliza_pp[] = {
+	{
+		.name = "pingpong_0", .id = PINGPONG_0,
+		.base = 0x69000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_0,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
+	}, {
+		.name = "pingpong_1", .id = PINGPONG_1,
+		.base = 0x6a000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_0,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
+	}, {
+		.name = "pingpong_2", .id = PINGPONG_2,
+		.base = 0x6b000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_1,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
+	}, {
+		.name = "pingpong_3", .id = PINGPONG_3,
+		.base = 0x6c000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_1,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
+	}, {
+		.name = "pingpong_cwb_0", .id = PINGPONG_CWB_0,
+		.base = 0x66000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_2,
+	}, {
+		.name = "pingpong_cwb_1", .id = PINGPONG_CWB_1,
+		.base = 0x66400, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_2,
+	}, {
+		.name = "pingpong_cwb_2", .id = PINGPONG_CWB_2,
+		.base = 0x7e000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_3,
+	}, {
+		.name = "pingpong_cwb_3", .id = PINGPONG_CWB_3,
+		.base = 0x7e400, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_3,
+	},
+};
+
+static const struct dpu_merge_3d_cfg eliza_merge_3d[] = {
+	{
+		.name = "merge_3d_0", .id = MERGE_3D_0,
+		.base = 0x4e000, .len = 0x1c,
+	}, {
+		.name = "merge_3d_1", .id = MERGE_3D_1,
+		.base = 0x4f000, .len = 0x1c,
+	}, {
+		.name = "merge_3d_2", .id = MERGE_3D_2,
+		.base = 0x66700, .len = 0x1c,
+	}, {
+		.name = "merge_3d_3", .id = MERGE_3D_3,
+		.base = 0x7e700, .len = 0x1c,
+	},
+};
+
+/*
+ * NOTE: Each display compression engine (DCE) contains dual hard
+ * slice DSC encoders so both share same base address but with
+ * its own different sub block address.
+ */
+static const struct dpu_dsc_cfg eliza_dsc[] = {
+	{
+		.name = "dce_0_0", .id = DSC_0,
+		.base = 0x80000, .len = 0x8,
+		.features = BIT(DPU_DSC_NATIVE_42x_EN),
+		.sblk = &sm8750_dsc_sblk_0,
+	}, {
+		.name = "dce_0_1", .id = DSC_1,
+		.base = 0x80000, .len = 0x8,
+		.features = BIT(DPU_DSC_NATIVE_42x_EN),
+		.sblk = &sm8750_dsc_sblk_1,
+	}, {
+		.name = "dce_1_0", .id = DSC_2,
+		.base = 0x81000, .len = 0x8,
+		.features = BIT(DPU_DSC_NATIVE_42x_EN),
+		.sblk = &sm8750_dsc_sblk_0,
+	},
+};
+
+static const struct dpu_wb_cfg eliza_wb[] = {
+	{
+		.name = "wb_2", .id = WB_2,
+		.base = 0x65000, .len = 0x2c8,
+		.features = WB_SDM845_MASK,
+		.format_list = wb2_formats_rgb_yuv,
+		.num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
+		.xin_id = 6,
+		.vbif_idx = VBIF_RT,
+		.maxlinewidth = 4096,
+		.intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 4),
+	},
+};
+
+static const struct dpu_cwb_cfg eliza_cwb[] = {
+	{
+		.name = "cwb_0", .id = CWB_0,
+		.base = 0x66200, .len = 0x20,
+	},
+	{
+		.name = "cwb_1", .id = CWB_1,
+		.base = 0x66600, .len = 0x20,
+	},
+	{
+		.name = "cwb_2", .id = CWB_2,
+		.base = 0x7e200, .len = 0x20,
+	},
+	{
+		.name = "cwb_3", .id = CWB_3,
+		.base = 0x7e600, .len = 0x20,
+	},
+};
+
+static const struct dpu_intf_cfg eliza_intf[] = {
+	{
+		.name = "intf_0", .id = INTF_0,
+		.base = 0x34000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25),
+	}, {
+		.name = "intf_1", .id = INTF_1,
+		.base = 0x35000, .len = 0x4bc,
+		.type = INTF_DSI,
+		.controller_id = MSM_DSI_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 26),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 27),
+		.intr_tear_rd_ptr = DPU_IRQ_IDX(MDP_INTF1_TEAR_INTR, 2),
+	}, {
+		.name = "intf_2", .id = INTF_2,
+		.base = 0x36000, .len = 0x4bc,
+		.type = INTF_DSI,
+		.controller_id = MSM_DSI_CONTROLLER_1,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 28),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 29),
+		.intr_tear_rd_ptr = DPU_IRQ_IDX(MDP_INTF2_TEAR_INTR, 2),
+	}, {
+		.name = "intf_3", .id = INTF_3,
+		.base = 0x37000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
+	}
+};
+
+static const struct dpu_perf_cfg eliza_perf_data = {
+	.max_bw_low = 6800000,
+	.max_bw_high = 14200000,
+	.min_core_ib = 2500000,
+	.min_llcc_ib = 0,
+	.min_dram_ib = 1600000,
+	.min_prefill_lines = 35,
+	.danger_lut_tbl = {0x3ffff, 0x3ffff, 0x0},
+	.safe_lut_tbl = {0xfe00, 0xfe00, 0xffff},
+	.qos_lut_tbl = {
+		{.nentry = ARRAY_SIZE(sc7180_qos_linear),
+		.entries = sc7180_qos_linear
+		},
+		{.nentry = ARRAY_SIZE(sc7180_qos_macrotile),
+		.entries = sc7180_qos_macrotile
+		},
+		{.nentry = ARRAY_SIZE(sc7180_qos_nrt),
+		.entries = sc7180_qos_nrt
+		},
+		/* TODO: macrotile-qseed is different from macrotile */
+	},
+	.cdp_cfg = {
+		{.rd_enable = 1, .wr_enable = 1},
+		{.rd_enable = 1, .wr_enable = 0}
+	},
+	.clk_inefficiency_factor = 105,
+	.bw_inefficiency_factor = 120,
+};
+
+static const struct dpu_mdss_version eliza_mdss_ver = {
+	.core_major_ver = 12,
+	.core_minor_ver = 4,
+};
+
+const struct dpu_mdss_cfg dpu_eliza_cfg = {
+	.mdss_ver = &eliza_mdss_ver,
+	.caps = &eliza_dpu_caps,
+	.mdp = &eliza_mdp,
+	.cdm = &dpu_cdm_5_x,
+	.ctl_count = ARRAY_SIZE(eliza_ctl),
+	.ctl = eliza_ctl,
+	.sspp_count = ARRAY_SIZE(eliza_sspp),
+	.sspp = eliza_sspp,
+	.mixer_count = ARRAY_SIZE(eliza_lm),
+	.mixer = eliza_lm,
+	.dspp_count = ARRAY_SIZE(eliza_dspp),
+	.dspp = eliza_dspp,
+	.pingpong_count = ARRAY_SIZE(eliza_pp),
+	.pingpong = eliza_pp,
+	.dsc_count = ARRAY_SIZE(eliza_dsc),
+	.dsc = eliza_dsc,
+	.merge_3d_count = ARRAY_SIZE(eliza_merge_3d),
+	.merge_3d = eliza_merge_3d,
+	.wb_count = ARRAY_SIZE(eliza_wb),
+	.wb = eliza_wb,
+	.cwb_count = ARRAY_SIZE(eliza_cwb),
+	.cwb = sm8650_cwb,
+	.intf_count = ARRAY_SIZE(eliza_intf),
+	.intf = eliza_intf,
+	.vbif_count = ARRAY_SIZE(sm8650_vbif),
+	.vbif = sm8650_vbif,
+	.perf = &eliza_perf_data,
+};
+
+#endif
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index c4e1f6b7345d..b096b748707e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -771,4 +771,5 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
 #include "catalog/dpu_10_0_sm8650.h"
 #include "catalog/dpu_12_0_sm8750.h"
 #include "catalog/dpu_12_2_glymur.h"
+#include "catalog/dpu_12_4_eliza.h"
 #include "catalog/dpu_13_0_kaanapali.h"
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 70d5ed4732f2..dedab08ea1d7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -767,6 +767,7 @@ struct dpu_mdss_cfg {
 	const struct dpu_format_extended *vig_formats;
 };
 
+extern const struct dpu_mdss_cfg dpu_eliza_cfg;
 extern const struct dpu_mdss_cfg dpu_glymur_cfg;
 extern const struct dpu_mdss_cfg dpu_kaanapali_cfg;
 extern const struct dpu_mdss_cfg dpu_msm8917_cfg;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 31743699d05f..1d8e6007a350 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1506,6 +1506,7 @@ static const struct dev_pm_ops dpu_pm_ops = {
 };
 
 static const struct of_device_id dpu_dt_match[] = {
+	{ .compatible = "qcom,eliza-dpu", .data = &dpu_eliza_cfg, },
 	{ .compatible = "qcom,glymur-dpu", .data = &dpu_glymur_cfg, },
 	{ .compatible = "qcom,kaanapali-dpu", .data = &dpu_kaanapali_cfg, },
 	{ .compatible = "qcom,msm8917-mdp5", .data = &dpu_msm8917_cfg, },

-- 
2.51.0

