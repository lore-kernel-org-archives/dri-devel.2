Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4406CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3304E10F108;
	Mon, 12 Oct 2026 13:33:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5524610F10A
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:16 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0Jtn1236677
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8tyr1gpgOHRS8r2SuSFNfT2SZyxcQrlJJDDGMe2As5A=; b=kptpQRFNAQafNxrG
 f38IILMSCnutMaYkhSV61P4jPhz72eqPMQhIT5wZbSPiSiIR4/CqE8sOxk0mguNX
 V45jfUSdoHtNZLF2Tk9uTzLZxnHAMuT/saXhH3oQ23J0SfqJ/6rcTh2ih2oqgfFs
 HexDvdZcCm280P9k6EMMqCmBgtl4nhTIYVir0okGdFjo8OWzioHDUrl2fdMCHvq2
 a2Jt1NDG6k3Ilvd+EWBbwYupXu+AdtJkUNma/O2sbgdst1Fm8s0rP7IF6Wi7Wtjg
 RflVQ9gfyySbs01d2gMRX75yULv2Z3Gs9Zc0JCzoRjU1FcylO/+Wr9XLZQewfyEE
 0eQBGA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dk6aw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso3092315eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791811994; x=1792416794;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8tyr1gpgOHRS8r2SuSFNfT2SZyxcQrlJJDDGMe2As5A=;
 b=LYjBghRNjLqYXr5CXHAdfusn8BWrbsdaYUJvNyImfZliq947MuMiydBwfAyfYrLMar
 NGB/Es2gqZbUHc/0iEbVUUSytSuFNnJJ4usnKfvte7dhGMd5DW/4a8tBJNODOtUnNumZ
 +kUwRUugSSL+gBJNfukipruEXqJ/yrhiLEVBa54YicYUQZosbc5crU5twR3NygsBzuGV
 E3Y6LcBuBUAeUDl0+OWxVsYeO9mMY/80UJKL0dZqDytoEyTCHuxDUyWZwYHLDh8EMojv
 T2QkWI68fWFkGZA+1KVLgQMPvdAPx7DZJpC+cy2MFHvRUk0dr5qMmZSGtPHZWFA6W61l
 SJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791811994; x=1792416794;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8tyr1gpgOHRS8r2SuSFNfT2SZyxcQrlJJDDGMe2As5A=;
 b=i/HQBOl6GgK+GvhK80oU0A6ZPq2Tmsd07eH5MZBM68J/KLUDRiDycGruT3fr6//vT1
 Z+vkK2VPX4GFHMjQKAeq2CAH91ovHMeWUMJVUMB91Bv5tZmZXhfMvsN+2/kr5TkaAYkQ
 S+MPtpKJ84g7D1hnlv6b2Dj0zobReyRIf161w7htPtEiJaEGWLmn+2Vd7Nreu8v1AEst
 8eKj3ZWLiWUj//T1MW/wZgjRkj1yDpNb2mgO1qM5VACO3kVFnvnOFOOQuYuZDSmCGVJa
 4ba/VcB8xPZldAfaAcg8WbQATr7QyS1s/jVsalK/dbG7T/wWIHO0X0DO7JhsTO2f5NTB
 kSEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcbV3j4F3Tv4kmIy3IZaP5IpgciL6ZutzKv25h9H+7x+bCCMHcvNOFhOVkT6Bwp+qWOkyvE6xgf1Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLDpwoGHSabsNRJQfQQfQH4kKaqdmMug/Y1HtI5JnS/OsCkGM2p
 DmAHHxituea/WbYB/pT1+2Wsh9UsCLn4pp/ByP3y9LBw0Vy441zNP73OdRB0nJmdL1iydwxUI5V
 2rsN/njpM2nFnL0dDA7KdeVLnl1JFmU2N3vGMHMPaKhcqewxQ0fGgkrANrLCZal8qDZk6NtI=
X-Gm-Gg: AYBFou3zXA0fh4zirlhGbVxb8DNS6R9LJNBmQ6oKYspnNBzrv1EP5O6bL9AjmXDv1ml
 Rl5nMxK1+VpPY1dBd5vPcEFDRlag7rJPzdQ91Kv64Ids0U3ZxzeCNhkKgwIK609zq4cc6clVcT7
 j1u8rcQiuUAbA9jmfFlHU0sg3eNgQoYlIBf/RKNrXemD9rwA3L/M2UYnW+r1p8A3bXpddxgYFEG
 BHkw8Y+XtaKtBn6VNlOnJrHgSPlIkYENT3U1hzyenXD87Ye2YfTx49Ng5IRZxlJCGCFc6IfGHmE
 ZslTKScnnh+iRsc12VBROX7F0vo0WuirxsYNN/n5Fxp7aYdT5mwyCvT60XJIvFTS25WpztEw6Ae
 X3ljA4Xm4OdUFXISm9wc+KzsoTxg=
X-Received: by 2002:a05:7300:561b:b0:35a:c5b4:5bcd with SMTP id
 5a478bee46e88-35ac5b4736amr3016399eec.13.1791811993679; 
 Mon, 12 Oct 2026 06:33:13 -0700 (PDT)
X-Received: by 2002:a05:7300:561b:b0:35a:c5b4:5bcd with SMTP id
 5a478bee46e88-35ac5b4736amr3016332eec.13.1791811992888; 
 Mon, 12 Oct 2026 06:33:12 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:33:12 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:14 +0530
Subject: [PATCH v2 04/13] drm/msm/dpu: Add support for DPU 12.1 on Nord
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-4-a2ab9af954d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=21301;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=1gAwSCzSCaGP31gFwhVe+Rw60SZgPEL+CJK2oRgIcAw=;
 b=8jMlHu9vUjqmJ0+B6MAm7cawMwKiDprJ0PZxk7nv7QK3Sr/IdKB/LGYGF8gYoShxPTfrrx39k
 Zu83qmpoo/oCdvOZvmzi8Wf8Ls6NFNyrBOi26qgQMMv0gvJLbMSLTEY
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX5wdVnSa9X58s
 jkia0jlJDfcttZrvEQ3tq1Ieys8UcD2G5uYfMkZtDHRPagWjJOB0Ra64ykHVOE0hBx0D5G+Gzj5
 2CFLMnV5AaCxFN5NRbtGfsPibw4STW4JyI3oK7bFtvcbdBnX9edbkuE7Fo6//bJiRbqwnL1yFzp
 By90eIDiPE3x6lgEJ0AKYLwRR4jxehG162loJS+/2vhvEFCS63upTZXXwz/jsO2qJACYOZ8LEL/
 aKPxs8ylVsGN+BcIpqi8oJE1Xfulm/+8BjZQNtpim1updJKHNYjVoh3wh0NR4DEhlHBDKkfiTe9
 d/D1f2mUjXhXHS06OpN8ugKFzZy0GCcQGIA5HrMqxE6YY0HhuIwxwQ2wgG1k5rt8VHrbruWCrqG
 Gvv74gdodBagnwVAumqU+G4urzAkk+D/lXUeJ1JpWMPjhugQf5v4eo+TNKNuweV6I8g/zi4AQBq
 NJlzXeZRPOmKCGdISDg==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6acce19b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=kGIIzWdZ1Uh505cunyMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: BsRVjxuCHybnwsQRfmGZYj5uqdtJ9yC4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX62Qm+lZdc3UX
 JRStUdYkcq3+EppoXZgSNF4guZLUi0LEc7S2TVtqtjLQGjG/l1DNkuqfHfI3ohPPgQi6xTBsIvN
 Mc6Xc3FYAoIQUJnaRwVLzd5FrhGgVGE=
X-Proofpoint-ORIG-GUID: BsRVjxuCHybnwsQRfmGZYj5uqdtJ9yC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add the DPU catalog entry for the Qualcomm Nord SoC (MDSS 12.1, DPU
1499A). Nord is DP-only with no DSI, and provides 8 DSPP blocks, 2
writeback blocks, 8 interfaces and 2 DP controllers.

Extend enum dpu_intf with INTF_9 and INTF_10, which Nord is the first
platform to use. The new entries are inserted before MDP_INTF1_TEAR_INTR
and MDP_INTF2_TEAR_INTR in enum dpu_hw_intr_reg, preserving the
contiguous MDP_INTF0_INTR..MDP_INTF10_INTR block that the
MDP_INTFn_INTR() macro relies on for correct index arithmetic.

Corresponding register entries are added to dpu_intr_set_7xxx (required
for Nord, which has core_major_ver = 12) and dpu_intr_set_13xx (for
consistency and to avoid a latent bug on future 13xx-family SoCs that
use INTF 9 or 10).

Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h  | 544 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |  20 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 7 files changed, 571 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h
new file mode 100644
index 000000000000..333eccb5c603
--- /dev/null
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h
@@ -0,0 +1,544 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DPU_12_1_NORD_H
+#define _DPU_12_1_NORD_H
+
+
+static const struct dpu_caps nord_dpu_caps = {
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
+static const struct dpu_mdp_cfg nord_mdp = {
+	.name = "top_0",
+	.base = 0, .len = 0x494,
+	.clk_ctrls = {
+		[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
+	},
+};
+
+static const struct dpu_ctl_cfg nord_ctl[] = {
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
+	}, {
+		.name = "ctl_4", .id = CTL_4,
+		.base = 0x19000, .len = 0x1000,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 13),
+	}, {
+		.name = "ctl_5", .id = CTL_5,
+		.base = 0x1a000, .len = 0x1000,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 23),
+	},
+};
+
+static const struct dpu_sspp_cfg nord_sspp[] = {
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
+		.name = "sspp_2", .id = SSPP_VIG2,
+		.base = 0x8000, .len = 0x344,
+		.features = VIG_SDM845_MASK_SDMA,
+		.sblk = &dpu_vig_sblk_qseed3_3_4,
+		.xin_id = 8,
+		.type = SSPP_TYPE_VIG,
+	}, {
+		.name = "sspp_3", .id = SSPP_VIG3,
+		.base = 0xa000, .len = 0x344,
+		.features = VIG_SDM845_MASK_SDMA,
+		.sblk = &dpu_vig_sblk_qseed3_3_4,
+		.xin_id = 12,
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
+	}, {
+		.name = "sspp_12", .id = SSPP_DMA4,
+		.base = 0x2c000, .len = 0x344,
+		.features = DMA_CURSOR_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 14,
+		.type = SSPP_TYPE_DMA,
+	}, {
+		.name = "sspp_13", .id = SSPP_DMA5,
+		.base = 0x2e000, .len = 0x344,
+		.features = DMA_CURSOR_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 15,
+		.type = SSPP_TYPE_DMA,
+	},
+};
+
+static const struct dpu_lm_cfg nord_lm[] = {
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
+		.dspp = DSPP_3,
+	}, {
+		.name = "lm_4", .id = LM_4,
+		.base = 0x48000, .len = 0x400,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_5,
+		.pingpong = PINGPONG_4,
+		.dspp = DSPP_4,
+	}, {
+		.name = "lm_5", .id = LM_5,
+		.base = 0x49000, .len = 0x400,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_4,
+		.pingpong = PINGPONG_5,
+		.dspp = DSPP_5,
+	}, {
+		.name = "lm_6", .id = LM_6,
+		.base = 0x4a000, .len = 0x400,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_7,
+		.pingpong = PINGPONG_6,
+		.dspp = DSPP_6,
+	}, {
+		.name = "lm_7", .id = LM_7,
+		.base = 0x4b000, .len = 0x400,
+		.features = MIXER_MSM8998_MASK,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_6,
+		.pingpong = PINGPONG_7,
+		.dspp = DSPP_7,
+	},
+};
+
+static const struct dpu_dspp_cfg nord_dspp[] = {
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
+	}, {
+		.name = "dspp_3", .id = DSPP_3,
+		.base = 0x5a000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	}, {
+		.name = "dspp_4", .id = DSPP_4,
+		.base = 0x5c000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	}, {
+		.name = "dspp_5", .id = DSPP_5,
+		.base = 0x5e000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	}, {
+		.name = "dspp_6", .id = DSPP_6,
+		.base = 0x60000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	}, {
+		.name = "dspp_7", .id = DSPP_7,
+		.base = 0x62000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	},
+};
+
+static const struct dpu_pingpong_cfg nord_pp[] = {
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
+		.name = "pingpong_4", .id = PINGPONG_4,
+		.base = 0x6d000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_2,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
+	}, {
+		.name = "pingpong_5", .id = PINGPONG_5,
+		.base = 0x6e000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_2,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
+	}, {
+		.name = "pingpong_6", .id = PINGPONG_6,
+		.base = 0x6f000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_3,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 20),
+	}, {
+		.name = "pingpong_7", .id = PINGPONG_7,
+		.base = 0x70000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_3,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 21),
+	}, {
+		.name = "pingpong_cwb_0", .id = PINGPONG_CWB_0,
+		.base = 0x66000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_4,
+	}, {
+		.name = "pingpong_cwb_1", .id = PINGPONG_CWB_1,
+		.base = 0x66400, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_4,
+	}, {
+		.name = "pingpong_cwb_2", .id = PINGPONG_CWB_2,
+		.base = 0x7e000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_5,
+	}, {
+		.name = "pingpong_cwb_3", .id = PINGPONG_CWB_3,
+		.base = 0x7e400, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_5,
+	},
+};
+
+static const struct dpu_merge_3d_cfg nord_merge_3d[] = {
+	{
+		.name = "merge_3d_0", .id = MERGE_3D_0,
+		.base = 0x4e000, .len = 0x1c,
+	}, {
+		.name = "merge_3d_1", .id = MERGE_3D_1,
+		.base = 0x4f000, .len = 0x1c,
+	}, {
+		.name = "merge_3d_2", .id = MERGE_3D_2,
+		.base = 0x50000, .len = 0x1c,
+	}, {
+		.name = "merge_3d_3", .id = MERGE_3D_3,
+		.base = 0x51000, .len = 0x1c,
+	}, {
+		.name = "merge_3d_4", .id = MERGE_3D_4,
+		.base = 0x66700, .len = 0x1c,
+	}, {
+		.name = "merge_3d_5", .id = MERGE_3D_5,
+		.base = 0x7e700, .len = 0x1c,
+	},
+};
+
+static const struct dpu_dsc_cfg nord_dsc[] = {
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
+	}, {
+		.name = "dce_1_1", .id = DSC_3,
+		.base = 0x81000, .len = 0x8,
+		.features = BIT(DPU_DSC_NATIVE_42x_EN),
+		.sblk = &sm8750_dsc_sblk_1,
+	}, {
+		.name = "dce_2_0", .id = DSC_4,
+		.base = 0x82000, .len = 0x8,
+		.features = BIT(DPU_DSC_NATIVE_42x_EN),
+		.sblk = &sm8750_dsc_sblk_0,
+	}, {
+		.name = "dce_2_1", .id = DSC_5,
+		.base = 0x82000, .len = 0x8,
+		.features = BIT(DPU_DSC_NATIVE_42x_EN),
+		.sblk = &sm8750_dsc_sblk_1,
+	}, {
+		.name = "dce_3_0", .id = DSC_6,
+		.base = 0x83000, .len = 0x8,
+		.features = BIT(DPU_DSC_NATIVE_42x_EN),
+		.sblk = &sm8750_dsc_sblk_0,
+	}, {
+		.name = "dce_3_1", .id = DSC_7,
+		.base = 0x83000, .len = 0x8,
+		.features = BIT(DPU_DSC_NATIVE_42x_EN),
+		.sblk = &sm8750_dsc_sblk_1,
+	},
+};
+
+static const struct dpu_wb_cfg nord_wb[] = {
+	{
+		.name = "wb_1", .id = WB_1,
+		.base = 0x64800, .len = 0x2c8,
+		.features = WB_SDM845_MASK,
+		.format_list = wb2_formats_rgb_yuv,
+		.num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
+		.xin_id = 7,
+		.maxlinewidth = 4096,
+		.intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 3),
+	}, {
+		.name = "wb_2", .id = WB_2,
+		.base = 0x65000, .len = 0x2c8,
+		.features = WB_SDM845_MASK,
+		.format_list = wb2_formats_rgb_yuv,
+		.num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
+		.xin_id = 6,
+		.maxlinewidth = 4096,
+		.intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 4),
+	},
+};
+
+static const struct dpu_cwb_cfg nord_cwb[] = {
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
+static const struct dpu_intf_cfg nord_intf[] = {
+	{
+		.name = "intf_0", .id = INTF_0,
+		.base = 0x34000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25),
+	}, {
+		.name = "intf_3", .id = INTF_3,
+		.base = 0x37000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
+	}, {
+		.name = "intf_4", .id = INTF_4,
+		.base = 0x38000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_1,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 20),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 21),
+	}, {
+		.name = "intf_6", .id = INTF_6,
+		.base = 0x3a000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 22),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 23),
+	}, {
+		.name = "intf_7", .id = INTF_7,
+		.base = 0x3b000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 0),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 1),
+	}, {
+		.name = "intf_8", .id = INTF_8,
+		.base = 0x3c000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_1,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 2),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 3),
+	}, {
+		.name = "intf_9", .id = INTF_9,
+		.base = 0x3d000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_1,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 4),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 5),
+	}, {
+		.name = "intf_10", .id = INTF_10,
+		.base = 0x3e000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_1,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 6),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 7),
+	},
+};
+
+static const struct dpu_perf_cfg nord_perf_data = {
+	.max_bw_low = 18900000,
+	.max_bw_high = 28500000,
+	.min_core_ib = 2500000,
+	.min_llcc_ib = 0,
+	.min_dram_ib = 800000,
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
+	},
+	.cdp_cfg = {
+		{.rd_enable = 1, .wr_enable = 1},
+		{.rd_enable = 1, .wr_enable = 0}
+	},
+	.clk_inefficiency_factor = 105,
+	.bw_inefficiency_factor = 120,
+};
+
+static const struct dpu_mdss_version nord_mdss_ver = {
+	.core_major_ver = 12,
+	.core_minor_ver = 1,
+};
+
+const struct dpu_mdss_cfg dpu_nord_cfg = {
+	.mdss_ver = &nord_mdss_ver,
+	.caps = &nord_dpu_caps,
+	.mdp = &nord_mdp,
+	.cdm = &dpu_cdm_5_x,
+	.ctl_count = ARRAY_SIZE(nord_ctl),
+	.ctl = nord_ctl,
+	.sspp_count = ARRAY_SIZE(nord_sspp),
+	.sspp = nord_sspp,
+	.mixer_count = ARRAY_SIZE(nord_lm),
+	.mixer = nord_lm,
+	.dspp_count = ARRAY_SIZE(nord_dspp),
+	.dspp = nord_dspp,
+	.pingpong_count = ARRAY_SIZE(nord_pp),
+	.pingpong = nord_pp,
+	.dsc_count = ARRAY_SIZE(nord_dsc),
+	.dsc = nord_dsc,
+	.merge_3d_count = ARRAY_SIZE(nord_merge_3d),
+	.merge_3d = nord_merge_3d,
+	.wb_count = ARRAY_SIZE(nord_wb),
+	.wb = nord_wb,
+	.cwb_count = ARRAY_SIZE(nord_cwb),
+	.cwb = nord_cwb,
+	.intf_count = ARRAY_SIZE(nord_intf),
+	.intf = nord_intf,
+	.vbif = &sm8650_vbif,
+	.perf = &nord_perf_data,
+};
+
+#endif
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 9a993cdfab85..63f3029d09fa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -796,6 +796,7 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
 #include "catalog/dpu_10_2_milos.h"
 
 #include "catalog/dpu_12_0_sm8750.h"
+#include "catalog/dpu_12_1_nord.h"
 #include "catalog/dpu_12_2_glymur.h"
 #include "catalog/dpu_12_4_eliza.h"
 #include "catalog/dpu_13_0_kaanapali.h"
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index f45faf87333e..bfbc8207ad9a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -772,6 +772,7 @@ extern const struct dpu_mdss_cfg dpu_msm8937_cfg;
 extern const struct dpu_mdss_cfg dpu_msm8953_cfg;
 extern const struct dpu_mdss_cfg dpu_msm8996_cfg;
 extern const struct dpu_mdss_cfg dpu_msm8998_cfg;
+extern const struct dpu_mdss_cfg dpu_nord_cfg;
 extern const struct dpu_mdss_cfg dpu_sar2130p_cfg;
 extern const struct dpu_mdss_cfg dpu_sdm630_cfg;
 extern const struct dpu_mdss_cfg dpu_sdm660_cfg;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index 5b7cd5241f45..c9c297ca080c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -206,6 +206,16 @@ static const struct dpu_intr_reg dpu_intr_set_7xxx[] = {
 		MDP_INTF_REV_7xxx_INTR_EN(8),
 		MDP_INTF_REV_7xxx_INTR_STATUS(8)
 	},
+	[MDP_INTF9_INTR] = {
+		MDP_INTF_REV_7xxx_INTR_CLEAR(9),
+		MDP_INTF_REV_7xxx_INTR_EN(9),
+		MDP_INTF_REV_7xxx_INTR_STATUS(9)
+	},
+	[MDP_INTF10_INTR] = {
+		MDP_INTF_REV_7xxx_INTR_CLEAR(10),
+		MDP_INTF_REV_7xxx_INTR_EN(10),
+		MDP_INTF_REV_7xxx_INTR_STATUS(10)
+	},
 };
 
 /*
@@ -282,6 +292,16 @@ static const struct dpu_intr_reg dpu_intr_set_13xx[] = {
 		MDP_INTF_REV_13xx_INTR_EN(8),
 		MDP_INTF_REV_13xx_INTR_STATUS(8)
 	},
+	[MDP_INTF9_INTR] = {
+		MDP_INTF_REV_13xx_INTR_CLEAR(9),
+		MDP_INTF_REV_13xx_INTR_EN(9),
+		MDP_INTF_REV_13xx_INTR_STATUS(9)
+	},
+	[MDP_INTF10_INTR] = {
+		MDP_INTF_REV_13xx_INTR_CLEAR(10),
+		MDP_INTF_REV_13xx_INTR_EN(10),
+		MDP_INTF_REV_13xx_INTR_STATUS(10)
+	},
 };
 
 #define DPU_IRQ_MASK(irq_idx)	(BIT(DPU_IRQ_BIT(irq_idx)))
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index 142358a105c5..7b8a04f8d209 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -27,6 +27,8 @@ enum dpu_hw_intr_reg {
 	MDP_INTF6_INTR,
 	MDP_INTF7_INTR,
 	MDP_INTF8_INTR,
+	MDP_INTF9_INTR,
+	MDP_INTF10_INTR,
 	MDP_INTF1_TEAR_INTR,
 	MDP_INTF2_TEAR_INTR,
 	MDP_AD4_0_INTR,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 0e65bf5ddc4a..7eccb4d2c65e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -226,6 +226,8 @@ enum dpu_intf {
 	INTF_6,
 	INTF_7,
 	INTF_8,
+	INTF_9,
+	INTF_10,
 	INTF_MAX
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..a91d4a1af94e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1489,6 +1489,7 @@ static const struct of_device_id dpu_dt_match[] = {
 	{ .compatible = "qcom,msm8953-mdp5", .data = &dpu_msm8953_cfg, },
 	{ .compatible = "qcom,msm8996-mdp5", .data = &dpu_msm8996_cfg, },
 	{ .compatible = "qcom,msm8998-dpu", .data = &dpu_msm8998_cfg, },
+	{ .compatible = "qcom,nord-dpu", .data = &dpu_nord_cfg, },
 	{ .compatible = "qcom,qcm2290-dpu", .data = &dpu_qcm2290_cfg, },
 	{ .compatible = "qcom,sa8775p-dpu", .data = &dpu_sa8775p_cfg, },
 	{ .compatible = "qcom,sar2130p-dpu", .data = &dpu_sar2130p_cfg, },

-- 
2.34.1

