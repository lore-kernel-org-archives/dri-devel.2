Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F92606A329
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BbDNc+Ht;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P6CPpvNE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDD010EBDE;
	Mon, 26 Oct 2026 06:22:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E47E10EBD7
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:22:35 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b76p2806463
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AeP247M9ox3eKXqTZK5xlmawqY9yNRGdJtyiG2QIHDw=; b=BbDNc+HtE4SBycEi
 tblPbiI/V+EBpnx84kH827IdfW2T7qF2uNVYI+uDrnCQc8qyhZIbvyRG2I6C+Zau
 SFilWGB2PDrONPzqsMh7MWOkfqeXxM7qfCGchL+ZiCpRgEGz0MAL9cf8qoTxCu/K
 E5ieLopKk8B2I63tvjp6shu6+qd6ZPyZlYF9XzYV75a3ZIiIKSCY3Z1M9Ddu4Wme
 AEbRRRAXhvKfDS0A+vPbk29m53xhSwzFA/MUU2mIPX/fOdrZ8b8y16vFv9xtLoXF
 s/Tkd9Rh8ooORmTB50glZ1qhLFKwEeUSMr8aEdgsckb26ZD6WHp6LBJS8Ww9KXWj
 XCSjlw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xn445-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:22:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e869e00005so42533735ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792995753; x=1793600553;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AeP247M9ox3eKXqTZK5xlmawqY9yNRGdJtyiG2QIHDw=;
 b=P6CPpvNEasVilmp7mBBkxfjc8fkfwauD1lGrR6/XoK+324nG9AYgart64VPwF25HFz
 W0fIXkOPf9b8NpYAqXrK4+bqG9CPSJ3fjBLk/HF3QAV9HQ3SxYN+6NvqfSSY8RazcbuJ
 uwoIh61oODxBoLhvDPFFtgelSIIwufVSd7rf+t3vVI4y20wHUMJJP+rBMLnvqgMh1q/i
 lI2sVaY2+Y7AEGm09fc/yjFX5RD07pNs8uRsarBhuQvUXFcfwERpNEoLtXfUz/IUblEH
 Brrjzbrw+C9doNP8X5MggwHIKH9D+R4aurUfz+7z2/R6j4cNfpkNnydaZB+bDe8qIlaa
 rFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792995753; x=1793600553;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AeP247M9ox3eKXqTZK5xlmawqY9yNRGdJtyiG2QIHDw=;
 b=E+Rx7on8V5D52bxWdqhc9hOMllpPlTCYJClKD0ewb9p9aC4jg3XZ0mTJ75nGr5FMgX
 6/YYXm5Q6FxPft4hqKY32TSk6k+OnkstbQY0iBHOVuK7hWmz9qYtfMXTWT6regeykAhc
 3VeiP5owceA9UlBpqUC81l8Zuakp+CSL6sbnLLrr7GVAkceADS9u9gRg215xARt2gRi7
 +ftyvVmguq7/0JtOD2xuMj2utGVGsFVa3GzdH5+9VqMV3QTOAApbaE7rDd4lRk8031Kr
 HByGWC3c8blmG1BAtTo4Gnvw0FR+6XIbIZpFN0OJIO0y/fbrm2dsRjlm6U0ks1+s8bag
 4ZMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzn5Tzqc9NzHIv6go55OHHCFcVMFqWgIkUjCONq0ryL2du5w5rmi2ddzkK9E15/i26IgPBIDyY8WHA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKXIU/fuU6bm/5wK25zQs8N16HV+uSYpnwo70xc6iyQcFBbRiYX
 vEA0ohSASrgvpCFTDswTrYSDGOLN+94BQOwB3GhLoaopZGCejWE8V4D8JC5aaOG8pBVnsYkl19b
 oju29k1eScWjTTijjGqmrlYT9FiLKOQzzNNwQHA9QRpsXLq7tPP8oAa/fZ4N24sI5eGiNelo=
X-Gm-Gg: AYBFou0TW0/EQRaPaudtD0Qhetq6ZDTE69OO63pUbpHWgd5Aajso3fDi6tMV6vZ7FWY
 gbmZ0JSDsP7alcHNF2+LF/0b1yyyvVN+UWNDZfq5Q0+TddpWgKI/keoVEf0nlrBEuTgRL2x+n4M
 SEFgmtjRjQdcNUy6n9osJg+vy1J+Qn0Ke5GGrChcZ8uHGpP2GNjHihLYmsbHKlMXTBPJek8QMkJ
 yD5nxB1UZ//LX8NKDSVdvJKWPqWjTmuQQX+dIEaEjsXccPeqMmLMaXxIWs8ClL9fCEuFJjfDT0T
 AJ8XVajdFvG2/u/0rm1nDpERyYsY+0DQXLrrjQcDS3ytIz74dOZ/SvUGHtSvpGaTy7WormVz2MI
 NPA5Kc0pidaEJ+yUKo2KgY2V41inmZHpDVg==
X-Received: by 2002:a17:903:2990:b0:2e5:78b1:33fc with SMTP id
 d9443c01a7336-2ea9c87d9femr55229885ad.53.1792995752777; 
 Sun, 25 Oct 2026 23:22:32 -0700 (PDT)
X-Received: by 2002:a17:903:2990:b0:2e5:78b1:33fc with SMTP id
 d9443c01a7336-2ea9c87d9femr55229505ad.53.1792995752182; 
 Sun, 25 Oct 2026 23:22:32 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 23:22:31 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:15 +0530
Subject: [PATCH v2 05/23] drm/msm/dcp: Add HFI panel definitions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-5-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=19933;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=iSIt4lLu6YzZAw44mF6l058OZd4GV41635W2zrAWp1w=;
 b=3P3wca/4m+IV1zVZupOOCiTzjiJRfxs2XaNq+8n7EF03P2SveQTSU3Tbc8uPVRLEptci4nMGI
 ISWoJg6RpwaDqtbtyOMYZuFkzXIu/BJocGgQEaC9r9dal4L/6P/KmXv
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: jLILQ3-rpstf2F1xA675Q4C_Dtg640IF
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adef1aa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=uSNoWdYxy1FJq9SozSAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX/k9iq4y0Soyf
 nRhV4XMwSDXPieVoM/FLTCqcor3qVtHMiGJIkhAmWSgIo58AcqLI9YVfv7H89FGFDlFCVuYXgeu
 4eIHVcdnB3cBZGi/9JxwAwTFoUMEfnQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX+/67iWudEry5
 vN5zDXqwEA9DG4COJza+SiqFhuWHIt4dkVMZN5Wk780kfZYIewNvVWoYmPB843BDhlsYc94rSwy
 gbdMQyz6Z06MBgnWQpyjA4J6qtvL8srqpLVt0uy7VWBWvbbhIQBapCF9QOhy37toRB+Fuuyft+G
 W+3aWW+4XgCoNiV3eEhKSVakg6D/hgYR2e+EXt6nHyCFK4aXLSDR25UoKxUZHuTM7UgNVoj115X
 k/aa3jVpxN8/Fpu2+47RPwkT7lHYixsA7ViCAP2KJg8hv2iIMdEBxUm+ox5fFjTNpZydOb7m9wi
 gfd2wsB2hGPjlwA6MwXVJks9AhgPk80hZo3ljYT5kVrzLC599c+n0/j/V3Oh6Q0x6rJ5YD85RBS
 aJgt2z3s55D8bVkGG+h0c0JYICeMWHZsp3uNSG623s1rpNMWZy+4bsNMpaKqTUCAY1Qbf+icGdq
 ZjACkoGROMel9iGtG8w==
X-Proofpoint-ORIG-GUID: jLILQ3-rpstf2F1xA675Q4C_Dtg640IF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Define the HFI panel protocol required to initialize DSI panels and
issue DCS transfers through DCP firmware. Without these definitions,
the DSI path cannot describe panel modes or panel commands to firmware.

Describe panel commands, timing and panel data structures, and property
identifiers used by panel initialization and DCS transfer helpers.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h   |  27 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h       | 287 +++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_properties_panel.h | 198 ++++++++++++++
 3 files changed, 512 insertions(+)

diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h
new file mode 100644
index 000000000000..ceccc8da8a29
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_COMMANDS_PANEL_H__
+#define __H_HFI_COMMANDS_PANEL_H__
+
+/* Panel-command range. */
+#define HFI_COMMAND_PANEL_BEGIN                                         0x03000000
+
+/* Start panel initialization; send with timing and generic packets in one HFI header. */
+#define HFI_COMMAND_PANEL_INIT_PANEL_CAPS                            0x03000001
+
+/* Provide one panel timing-mode description. */
+#define HFI_COMMAND_PANEL_INIT_TIMING_MODE_CAPS                      0x03000002
+
+/* Provide non-timing panel properties. */
+#define HFI_COMMAND_PANEL_INIT_GENERIC_CAPS                          0x03000003
+
+/* Deinitialize panel attributes. */
+#define HFI_COMMAND_PANEL_DEINIT                                     0x03000004
+
+/* End of panel-command range. */
+#define HFI_COMMAND_PANEL_END                                        0x03ffffff
+
+#endif /* __H_HFI_COMMANDS_PANEL_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h
new file mode 100644
index 000000000000..a38d778898b2
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_DEFS_PANEL_H__
+#define __H_HFI_DEFS_PANEL_H__
+
+#include "hfi_defs_common.h"
+
+/* Panel format, link, and power properties. */
+enum hfi_panel_phy_type {
+	HFI_PANEL_PHY_OLED      = 0x1,
+	HFI_PANEL_PHY_LCD       = 0x2,
+};
+
+/* Lower values have higher display priority. */
+enum hfi_panel_display_type {
+	HFI_PANEL_DISPLAY_TYPE_NONE           = 0x0,
+	HFI_PANEL_DISPLAY_TYPE_BUILT_IN_0     = 0x1,
+	HFI_PANEL_DISPLAY_TYPE_BUILT_IN_1     = 0x2,
+	HFI_PANEL_DISPLAY_TYPE_BUILT_IN_2     = 0x3,
+	HFI_PANEL_DISPLAY_TYPE_BUILT_IN_3     = 0x4,
+	HFI_PANEL_DISPLAY_TYPE_BUILT_IN_4     = 0x5,
+};
+
+enum hfi_panel_bpp {
+	HFI_PANEL_BPP_3      = 1,
+	HFI_PANEL_BPP_8      = 2,
+	HFI_PANEL_BPP_12     = 3,
+	HFI_PANEL_BPP_16     = 4,
+	HFI_PANEL_BPP_18     = 5,
+	HFI_PANEL_BPP_24     = 6,
+	HFI_PANEL_BPP_30     = 7,
+};
+
+enum hfi_panel_deinit_prop {
+	HFI_PANEL_DEINIT_CONT_SPLASH = 0x00000001,
+};
+
+enum hfi_panel_lane_enable {
+	HFI_PANEL_LANE_0      = 0x00000001,
+	HFI_PANEL_LANE_1      = 0x00000002,
+	HFI_PANEL_LANE_2      = 0x00000004,
+	HFI_PANEL_LANE_3      = 0x00000008,
+};
+
+enum hfi_panel_lane_map {
+	HFI_PANEL_LANE_MAP_0123 = 1,
+};
+
+enum hfi_panel_color_order_type {
+	HFI_PANEL_COLOR_ORDER_RGB_SWAP_RGB   = 0x1,
+	HFI_PANEL_COLOR_ORDER_RGB_SWAP_RBG   = 0x2,
+	HFI_PANEL_COLOR_ORDER_RGB_SWAP_BRG   = 0x3,
+	HFI_PANEL_COLOR_ORDER_RGB_SWAP_GRB   = 0x4,
+	HFI_PANEL_COLOR_ORDER_RGB_SWAP_GBR   = 0x5,
+};
+
+enum hfi_panel_vsync_source {
+	HFI_PANEL_VSYNC_SOURCE_GPIO_0  = 0x0,
+	HFI_PANEL_VSYNC_SOURCE_GPIO_1  = 0x1,
+	HFI_PANEL_VSYNC_SOURCE_GPIO_2  = 0x2,
+	HFI_PANEL_VSYNC_SOURCE_GPIO_3  = 0x3,
+	HFI_PANEL_VSYNC_SOURCE_GPIO_4  = 0x4,
+	HFI_PANEL_VSYNC_SOURCE_GPIO_5  = 0x5,
+	HFI_PANEL_VSYNC_SOURCE_WD      = 0xf,
+};
+
+enum hfi_panel_trigger_type {
+	HFI_PANEL_TRIGGER_NONE      = 1,
+	HFI_PANEL_TRIGGER_TE        = 2,
+	HFI_PANEL_TRIGGER_SW        = 3,
+	HFI_PANEL_TRIGGER_SW_TE     = 4,
+	HFI_PANEL_TRIGGER_SW_SEOF   = 5,
+	HFI_PANEL_TRIGGER_SEOF      = 6,
+};
+
+enum hfi_panel_fps_traffic_mode {
+	HFI_PANEL_TRAFFIC_NON_BURST_SYNC_PULSE_MODE     = 1,
+	HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE     = 2,
+	HFI_PANEL_TRAFFIC_BURST_MODE                    = 3,
+};
+
+enum hfi_panel_modes {
+	HFI_PANEL_VIDEO_MODE_8_BIT      = 0x1,
+	HFI_PANEL_VIDEO_MODE_10_BIT     = 0x2,
+	HFI_PANEL_CMD_MODE_8_BIT        = 0x4,
+	HFI_PANEL_CMD_MODE_10_BIT       = 0x8,
+	HFI_PANEL_VIDEO_MODE_PSR_8_BIT	= 0x10,
+	HFI_PANEL_VIDEO_MODE_PSR_10_BIT	= 0x20,
+	HFI_PANEL_VIDEO_LTPO_8_BIT	= 0x40,
+	HFI_PANEL_VIDEO_LTPO_10_BIT	= 0x80
+};
+
+enum hfi_panel_backlight_ctrl {
+	HFI_PANEL_BACKLIGHT_CTRL_UNKNOWN    = 0x0,
+	HFI_PANEL_BACKLIGHT_CTRL_PWM        = 0x1,
+	HFI_PANEL_BACKLIGHT_CTRL_WLED       = 0x2,
+	HFI_PANEL_BACKLIGHT_CTRL_DCS        = 0x3,
+	HFI_PANEL_BACKLIGHT_CTRL_EXTERNAL   = 0x4,
+};
+
+enum hfi_panel_compression_mode {
+	HFI_PANEL_COMPRESSION_NONE  = 0,
+	HFI_PANEL_COMPRESSION_DSC   = 1,
+};
+
+enum hfi_panel_chroma_format_type {
+	HFI_PANEL_CHROMA_FORMAT_444     = 1,
+	HFI_PANEL_CHROMA_FORMAT_422     = 2,
+	HFI_PANEL_CHROMA_FORMAT_420     = 3,
+};
+
+enum hfi_panel_color_space_type {
+	HFI_PANEL_COLOR_SPACE_RGB     = 1,
+	HFI_PANEL_COLOR_SPACE_YUV     = 2,
+};
+
+enum hfi_panel_dfps_type {
+	HFI_PANEL_DFPS_NONE = 0,
+	HFI_PANEL_DFPS_SUSPEND_RESUME,
+	HFI_PANEL_DFPS_IMMEDIATE_CLK,
+	HFI_PANEL_DFPS_IMMEDIATE_HFP,
+	HFI_PANEL_DFPS_IMMEDIATE_VFP,
+	HFI_PANEL_DFPS_MAX
+};
+
+/* Panel topology. */
+struct hfi_panel_topology {
+	u32 mixer_count;
+	u32 enc_count;
+	u32 display_count;
+};
+
+/* DSI command sequencing. */
+enum hfi_panel_dcs_cmd_state {
+	HFI_PANEL_DSI_HS_MODE   = 0x1,
+	HFI_PANEL_DSI_LP_MODE   = 0x2,
+};
+
+enum hfi_panel_dcs_command_type {
+	HFI_DCS_CMD_PRE_ON                      = 0x00000000,
+	HFI_DCS_CMD_ON                          = 0x00000001,
+	HFI_DCS_CMD_VIDEO_ON                    = 0x00000002,
+	HFI_DCS_CMD_COMMAND_ON                  = 0x00000003,
+	HFI_DCS_CMD_POST_PANEL_ON               = 0x00000004,
+	HFI_DCS_CMD_PRE_OFF                     = 0x00000005,
+	HFI_DCS_CMD_OFF                         = 0x00000006,
+	HFI_DCS_CMD_POST_OFF                    = 0x00000007,
+	HFI_DCS_CMD_PRE_RES_SWITCH              = 0x00000008,
+	HFI_DCS_CMD_RES_SWITCH                  = 0x0000009,
+	HFI_DCS_CMD_POST_RES_SWITCH             = 0x00000010,
+	HFI_DCS_CMD_VIDEO_MODE_SWITCH_INS       = 0x00000011,
+	HFI_DCS_CMD_VIDEO_MODE_SWITCH_OUTS      = 0x00000012,
+	HFI_DCS_CMD_COMMAND_MODE_SWITCH_INS     = 0x00000013,
+	HFI_DCS_CMD_COMMAND_MODE_SWITCH_OUTS    = 0x00000014,
+	HFI_DCS_CMD_PANEL_STATUS                = 0x00000015,
+	HFI_DCS_CMD_LP1                         = 0x00000016,
+	HFI_DCS_CMD_LP2                         = 0x00000017,
+	HFI_DCS_CMD_NOLP                        = 0x00000018,
+	HFI_DCS_CMD_PPS                         = 0x00000019,
+	HFI_DCS_CMD_ROI                         = 0x00000020,
+	HFI_DCS_CMD_TIMING_SWITCH               = 0x00000021,
+	HFI_DCS_CMD_POST_MODE_SWITCH_ON         = 0x00000022,
+	HFI_DCS_CMD_QSYNC_ONS                   = 0x00000023,
+	HFI_DCS_CMD_QSYNC_OFFS                  = 0x00000024,
+	HFI_DCS_CMD_MAX                         = 0x00000025
+};
+
+/* Panel ESD status modes. */
+enum hfi_panel_esd_status_mode {
+	HFI_PANEL_ESD_STATUS_MODE_REG_READ       = 0x1,
+	HFI_PANEL_ESD_STATUS_MODE_SW_BTA         = 0x2,
+	HFI_PANEL_ESD_STATUS_MODE_PANEL_TE       = 0x3,
+	HFI_PANEL_ESD_STATUS_MODE_PANEL_RW       = 0x4,
+	HFI_PANEL_ESD_STATUS_MODE_SW_SIM_SUCCESS = 0x5,
+	HFI_PANEL_ESD_STATUS_MODE_SW_SIM_FAILURE = 0x6
+};
+
+/* Panel timing parameters. */
+struct hfi_panel_res_data {
+	u32 active_width;
+	u32 active_height;
+	u32 h_front_porch;
+	u32 h_back_porch;
+	u32 h_left_border;
+	u32 h_right_border;
+	u32 h_pulse_width;
+	u32 h_sync_skew;
+	u32 h_sync_pulse;
+	u32 v_front_porch;
+	u32 v_back_porch;
+	u32 v_top_border;
+	u32 v_bottom_border;
+	u32 v_pulse_width;
+};
+
+/* Panel compression parameters. */
+struct hfi_panel_compression_params {
+	enum hfi_panel_compression_mode	mode;
+	u32 version;
+	u32 scr_version;
+	u32 slice_height;
+	u32 slice_width;
+	u32 slices_per_pkt;
+	u32 bits_per_component;
+	u32 pps_delay_ms;
+	u32 bits_per_pixel;
+	enum hfi_panel_chroma_format_type chroma_format;
+	enum hfi_panel_color_space_type color_space;
+	u32 block_prediction_enable;
+};
+
+/* DCS command buffers. */
+struct hfi_panel_dcs_cmd_buffer_info {
+	u32 offset_l;
+	u32 offset_h;
+	u32 size;
+	u32 delay;
+	u32 ctrl_flags;
+	enum hfi_panel_dcs_cmd_state mode;
+	u32 reserve1;
+	u32 reserve2;
+};
+
+struct hfi_panel_compression_rc_override {
+	u8 min_qp[15];
+	u8 padding1;
+	u8 max_qp[15];
+	u8 padding2;
+	u8 offsets[15];
+	u8 padding3;
+};
+
+/* Panel ESD configuration. */
+/* Register-read fields are valid only in REG_READ mode. */
+struct hfi_panel_esd_config {
+	u32 size;
+	enum hfi_panel_esd_status_mode status_mode;
+
+		u32 count;
+	u32 groups;
+
+	u32 hfi_dsi_cmd_desc_lsb;
+	u32 hfi_dsi_cmd_desc_msb;
+
+	u32 valid_params_lsb;
+	u32 valid_params_msb;
+
+	u32 status_values_lsb;
+	u32 status_values_msb;
+};
+
+struct hfi_qsync_params {
+	u32 avr_step_fps;
+	u32 qsync_min_fps;
+};
+
+struct hfi_panel_esync_caps {
+	u32 esync_support;
+	u32 esync_milli_skew;
+	u32 hsync_milli_pulse_width;
+	u32 emsync_milli_pulse_width;
+	u32 emsync_fps;
+};
+
+struct hfi_panel_dfps_caps {
+	u32 dfps_support;
+	u32 min_refresh_rate;
+	u32 max_refresh_rate;
+	enum hfi_panel_dfps_type type;
+};
+
+struct hfi_display_vrr_frame_params {
+	u32 frame_interval_ns_lo;
+	u32 frame_interval_ns_hi;
+	u32 usecase_idx;
+};
+
+/* Panel operating-mode capabilities. */
+struct hfi_panel_operating_mode_caps {
+	u32 panel_mode_switch_enabled;
+	u32 vsync_aligned_switch;
+};
+
+#endif /* __H_HFI_DEFS_PANEL_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_panel.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_panel.h
new file mode 100644
index 000000000000..53c7789239a6
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_panel.h
@@ -0,0 +1,198 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_PROPERTIES_PANEL_H__
+#define __H_HFI_PROPERTIES_PANEL_H__
+
+/* Panel-property range. */
+#define HFI_PROPERTY_PANEL_BEGIN                                     0x00040000
+
+/* Sets the total number of timing modes available for the panel. */
+#define HFI_PROPERTY_PANEL_TIMING_MODE_COUNT                         0x00040001
+
+/* Sets the index of the timing mode. */
+
+#define HFI_PROPERTY_PANEL_INDEX                                     0x00040002
+/* Sets the panel clock speed in Hz. */
+#define HFI_PROPERTY_PANEL_CLOCKRATE                                 0x00040003
+
+/* Sets the frame rate for the panel. */
+#define HFI_PROPERTY_PANEL_FRAMERATE                                 0x00040004
+
+/* Sets active dimensions, porches, pulse width, and sync skew. */
+#define HFI_PROPERTY_PANEL_RESOLUTION_DATA                           0x00040005
+
+/* Sets jitter as a numerator/denominator pair for early wakeup. */
+#define HFI_PROPERTY_PANEL_JITTER                                    0x00040006
+
+/* Sets all the compression data for VDC / DSC. */
+#define HFI_PROPERTY_PANEL_COMPRESSION_DATA                          0x00040007
+
+/* Lists available display topologies. */
+#define HFI_PROPERTY_PANEL_DISPLAY_TOPOLOGY                          0x00040008
+
+/* Sets the default topology index. */
+#define HFI_PROPERTY_PANEL_DEFAULT_TOPOLOGY_INDEX                    0x00040009
+
+/* Panel name available for current timing mode. */
+#define HFI_PROPERTY_PANEL_NAME                                      0x0004000a
+
+/* Specifies the type of the panel, OLED / LCD. */
+#define HFI_PROPERTY_PANEL_PHYSICAL_TYPE                             0x0004000b
+
+/* Sets the panel bits per pixel. */
+#define HFI_PROPERTY_PANEL_BPP                                       0x0004000c
+
+/* Enables or disables each DSI data lane. */
+#define HFI_PROPERTY_PANEL_LANES_STATE                               0x0004000d
+
+/* Specifies the panel lane map. */
+#define HFI_PROPERTY_PANEL_LANE_MAP                                  0x0004000e
+
+/* Specifies the R, G and B channel ordering. */
+#define HFI_PROPERTY_PANEL_COLOR_ORDER                               0x0004000f
+
+/* Specifies the trigger mechanism to be used for DMA path. */
+#define HFI_PROPERTY_PANEL_DMA_TRIGGER                               0x00040010
+
+/* Property used to enable appending end of transmission packets. */
+#define HFI_PROPERTY_PANEL_TX_EOT_APPEND                             0x00040011
+
+/* Selects the DSI lane state at BLLP end-of-frame. */
+#define HFI_PROPERTY_PANEL_BLLP_EOF_POWER_MODE                       0x00040012
+
+/* Selects the DSI lane state during BLLP. */
+#define HFI_PROPERTY_PANEL_BLLP_POWER_MODE                           0x00040013
+
+/* Specifies the panel traffic mode. */
+#define HFI_PROPERTY_PANEL_TRAFFIC_MODE                              0x00040014
+
+/* Specifies the virtual channel identifier. */
+#define HFI_PROPERTY_PANEL_VIRTUAL_CHANNEL_ID                        0x00040015
+
+/* DCS command for write_memory_start. */
+#define HFI_PROPERTY_PANEL_WR_MEM_START                              0x00040016
+
+/* DCS command for write_memory_continue. */
+#define HFI_PROPERTY_PANEL_WR_MEM_CONTINUE                           0x00040017
+
+/* Inserts the DCS command. */
+#define HFI_PROPERTY_PANEL_TE_DCS_COMMAND                            0x00040018
+
+/* Specifies the panel operating mode. */
+#define HFI_PROPERTY_PANEL_OPERATING_MODE                            0x00040019
+
+/* Specifies the min backlight level supported by the panel. */
+#define HFI_PROPERTY_PANEL_BL_MIN_LEVEL                              0x0004001a
+
+/* Specifies the max backlight level supported by the panel. */
+#define HFI_PROPERTY_PANEL_BL_MAX_LEVEL                              0x0004001b
+
+/* Specifies the max brightness level supported. */
+#define HFI_PROPERTY_PANEL_BRIGHTNESS_MAX_LEVEL                      0x0004001c
+
+/* Specifies the DSI controllers to use for primary panel. */
+#define HFI_PROPERTY_PANEL_CTRL_NUM                                  0x0004001d
+
+/* Specifies the DSI PHYs to use for primary panel. */
+#define HFI_PROPERTY_PANEL_PHY_NUM                                   0x0004001e
+
+/* An array that lists the sequence of reset GPIO values and sleeps. */
+#define HFI_PROPERTY_PANEL_RESET_SEQUENCE                            0x0004001f
+
+/* Specifies the implementation of backlight control for this panel. */
+#define HFI_PROPERTY_PANEL_BL_PMIC_CONTROL_TYPE                      0x00040020
+
+/* Specifies the implementation of backlight control for secondary panel. */
+#define HFI_PROPERTY_PANEL_SEC_BL_PMIC_CONTROL_TYPE                  0x00040021
+
+/* Specifies whether to invert the display brightness value. */
+#define HFI_PROPERTY_PANEL_BL_INVERTED_DBV                           0x00040022
+
+/* Sets DCS command buffer data for different types of DCS commands. */
+#define HFI_PROPERTY_PANEL_DCS_CMD_INFO                              0x00040024
+
+/* Provides iova of DPU Mapped buffer of HW understandable panel commands. */
+#define HFI_PROPERTY_PANEL_DPU_ADDRESS                              0x00040025
+
+/* Provides dva of DCP Mapped buffer of structures of cmd descriptions. */
+#define HFI_PROPERTY_PANEL_DCP_ADDRESS                              0x00040026
+
+/* Provides D-PHY timing parameters. */
+#define HFI_PROPERTY_PANEL_DPHY_TIMINGS                              0x00040027
+
+/* Entry to select vsync source from GPIO's/Watchdog timer. */
+#define HFI_PROPERTY_PANEL_VSYNC_SOURCE                              0x00040028
+
+/* Selects the pixel-stream trigger for command mode. */
+#define HFI_PROPERTY_PANEL_STREAM_TRIGGER                            0x00040029
+
+/* Specifies the TE Path for command mode panels. */
+#define HFI_PROPERTY_PANEL_TE_MODE                                   0x0004002a
+
+/* Reports whether the panel uses C-PHY. */
+#define HFI_PROPERTY_PANEL_CPHY_MODE                                 0x0004002b
+
+/* Provides the shared DCP address for DCS command DMA. */
+#define HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_DVA                        0x0004002c
+
+/* Provides the shared DPU address for DCS command DMA. */
+#define HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_IOVA                       0x0004002d
+
+/* Sets the compression rate control override value for the panel. */
+#define HFI_PROPERTY_PANEL_COMPRESSION_RC_OVERRIDE                   0x0004002e
+
+/* Selects the line that triggers DSI command DMA. */
+#define HFI_PROPERTY_PANEL_DMA_SCHEDULE_LINE                         0x0004002f
+
+/* Provides the panel ESD config data required for ESD status check to the DCP. */
+#define HFI_PROPERTY_PANEL_ESD_CONFIG                                0x00040030
+
+/* Specifies the QSYNC parameters of the panel. */
+#define HFI_PROPERTY_PANEL_QSYNC_PARAMS                              0x00040031
+
+/* Provides esync properties for VHM panel. */
+#define HFI_PROPERTY_PANEL_ESYNC_CAPS				     0x00040032
+
+/* Specifies the DFPS capabilities supported by the panel. */
+#define HFI_PROPERTY_PANEL_DFPS_CAPS                                 0x00040033
+
+/* Specifies the frequency stepping pattern of the panel. */
+#define HFI_PROPERTY_PANEL_FREQ_PATTERN				     0x00040034
+
+/* Specifies whether panel requires LP11_INIT mode. */
+#define HFI_PROPERTY_PANEL_LP11_INIT                                 0x00040035
+
+/* Specifies the width of the DMA scheduling window, expressed in number of display lines. */
+#define HFI_PROPERTY_PANEL_DMA_SCHEDULE_WINDOW                       0x00040036
+
+/* Provides DSI bit clock frequencies for dynamic refresh. */
+#define HFI_PROPERTY_PANEL_DYN_REF_CLK_FREQS                         0x00040038
+
+/* Reports supported operating-mode switches. */
+#define HFI_PROPERTY_PANEL_OPERATING_SWITCH_CAPABILITY               0x00040039
+
+/* Selects the display type and priority. */
+#define HFI_PROPERTY_PANEL_DISPLAY_TYPE                              0x0004003a
+
+/* Specifies whether ULPS (Ultra Low Power State) is supported by the panel. */
+#define HFI_PROPERTY_PANEL_ULPS_SUPPORTED                            0x0004003b
+
+/* Specifies the DSI custom command set start index and count. */
+#define HFI_PROPERTY_PANEL_DSI_CUSTOM_DCS_CMDS_SET_INFO              0x00040040
+
+/* Provides per-mode esync timing capabilities for VHM panel. */
+#define HFI_PROPERTY_PANEL_ESYNC_TIMING_CAPS                         0x00040041
+
+/* Provides per-mode qsync timing parameters for panels supporting QSYNC/AVR. */
+#define HFI_PROPERTY_PANEL_QSYNC_TIMING_PARAMS                       0x00040042
+
+/* Specifies the current display format being used by the panel. */
+#define HFI_PROPERTY_PANEL_COLOR_FORMAT                              0x00040043
+
+/* End of panel-property range. */
+#define HFI_PROPERTY_PANEL_END                                       0x0004ffff
+
+#endif /* __H_HFI_PROPERTIES_PANEL_H__ */

-- 
2.43.0

