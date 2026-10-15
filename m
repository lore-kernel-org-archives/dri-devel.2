Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F94CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2603C112109;
	Thu, 15 Oct 2026 07:39:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8BC112109
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:44 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6lZgi586364
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dokoDXcqZs0QGuce2bqTicgP5rVNidLrgMW+gP0gybI=; b=XiIccyng0jwgmJ/l
 uE30fkg+Jb2qmSUPr22M41fF3nw6zyYMak09jrSMvARZXCAX+yazYn6rwrLe7Dd8
 rik21rTAjn4zHJC1qHeSZVeppJPO3ICtW6T7+v55aESz57VU1rf+gx5BzdB2axlU
 wEft0NsbVrHCV3EmQL74i5tPOZCJSDQ56wkV8NOa+dwBZXG+POFohbzztEb7LOws
 JLYW1yaHXolXr8kqBCvQCSeiQNKOTHbJQ+gqfjXmstJ/c06GsCBdzVutykthss7Y
 7ytBGzp6C0P6NxQgU8Wf3M8Cc1PTyOdAkDELgGZZRE/ihSVLJQW5UZPXSvJU2Jvr
 8kCVKg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdeskcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e8e16d22d8so27314955ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792049983; x=1792654783;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dokoDXcqZs0QGuce2bqTicgP5rVNidLrgMW+gP0gybI=;
 b=DXsdhsuQB9jPK8mTeqVVRIU+svefmkXGW9iha/7x8O4mJySFxS+l3S/lt6pR+0X30T
 Z1vjl0vCtXiLgHTFynMsc2QG5jwdcalej5ICqgd4/dnISdeWm+35uoeX0X+lWMI2ylEg
 sX78vsEOf1KESaUEPgPuUR8iD1+kMy6iMhZH3czTQBkyjACkss/fOSGCXTYBwcnQQm+G
 krYEfrIbcV7kj7iM5362r9e3A+WIBSqDNbAmhKU1RzqUkF2G+/7A4n2YgSaTZGkjWm6W
 J0Gomayl6OvzCe1ggNJv/OnZb1jPVc/op/Z7SvjmFq8QSD8d2AwRpkWcdDsx7mlNQ0U3
 Axag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792049983; x=1792654783;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dokoDXcqZs0QGuce2bqTicgP5rVNidLrgMW+gP0gybI=;
 b=CENe07K3oWwygUpY1jBAr7s0eTYCUHgcQLb6p1ybzG5m+geVJZfIrx5Y5aKENOYbMh
 VFjoN5nSxLxGugLtE76K1YBsq+GWWegzi2Pkt78TCitDykXrsHuDuQaT7zg+CBWrSZLt
 FtkuDlG8/GSwRUq5ISfpnELaamI6NiAyuipCGFEZymDsdBQhHyMe3JBHoq6bpqyZJJnl
 6w5jWAwEFyXBj6F7Mm4+4Hnb4gjQA5R5dhB/AP1MkJtz4Y7a4uONZvDArLV2QyODZEl2
 KbkTWP0WIVANb9BtguA83+nhZE77DZQrgs4Vzyp9luHC63+XaEZs24b4eQxeE55JM8e1
 gEFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNqWXWqniPN7RpFhLwlMt26RDCVYkwXBaP3l5GPnCEOCWrrbj9ytO3MCbunDYgB9UvEGhH8FWpWIc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJlv2Ni6qwBg7Jxd2CGglMXqN9T5wWeUEnLqM9hCQJWzJ9bcT/r
 CTVADj2+cZFAf8qTmtVQ7lBUg4DkS+Qjssw3LRK681Lzqo7lGzN8HgROP7Ul9Bomc/6oRTzIx4G
 G2778QNSD/UtUaW3Vbee941Pa67V+EjremZd5izGRDFrThR+SNIgknFVLBnn/Fg/LHaKPwSU=
X-Gm-Gg: AYBFou0AJHX52QIU7h32nJA0FbupMs15l6zKNfMqGkMJwWqu5XKNqGyT12hg+zrL4lk
 sU0PJLfOlLfkUUAGdlYY3WYmgzwgT3jo7tuT8zNRr3ly34xHF+jCEZ+0c3MrK9wBh4zO1obUiYv
 hDy+S5nY7d8TEJthnwJTFZOd04VYUwn0l2BXKPeIVVDecAKN3tcy6+mZ8ZMaEpKtnhfljb1VShK
 lvW3THAh5BoQebUyuoRhfmhjs+hKDo5tuaIu1j8O0nEa/xwxW4pJRaoeFRYhKHvqtS+HsQoY2jo
 zf7ndJj08buU6Lp2Wnh9ZSTC94qOGtTjPfwiRC44KLHkt/V4lmaMFfhv/8tKfDNPdyKGrHFnHpt
 AZoTirGjP2e+yFvQzmSv2RDja8VHRRCcc3Fw=
X-Received: by 2002:a17:902:cec2:b0:2db:7941:9e11 with SMTP id
 d9443c01a7336-2e842cd431cmr167805665ad.9.1792049982004; 
 Thu, 15 Oct 2026 00:39:42 -0700 (PDT)
X-Received: by 2002:a17:902:cec2:b0:2db:7941:9e11 with SMTP id
 d9443c01a7336-2e842cd431cmr167805255ad.9.1792049981086; 
 Thu, 15 Oct 2026 00:39:41 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:39:40 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:25 +0530
Subject: [PATCH 05/13] drm/msm/dcp: Add HFI display command implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-5-48aad0fe4f72@oss.qualcomm.com>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=58026;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=wUSOaWYC+oejQ7vJNnDe0haf/gi1E+wLH/e76qrH7j4=;
 b=G40XJ86DAk6YCjKRN1GYj4UqaWNiiN2LaYKPCwjVIt5mQIFRfG/HyxSVBuXr8XNadYmSB+OfB
 QkznweNxfvLCZp/TQmMkCqoipvQP15OZro07BB3/YxGcboEy6cQJyZ0
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0833f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=WfGb2qJL7reDrkCA8KQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: btp1wXNKr9JwmmEo3pAbITEyMoTCsNiI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX+asehIjhXKIa
 r8bDILN/h6QSgzjolsbuaDPe/AGpSpSURnVLSXwet5q3EN2vudCuTuOdDmlt51ogTMb89cLBgJy
 YuLwln7j99sgUdJeWFyff+M0eLFZq3UrzfNIcdA/TUszaqjNXS/62tQhmsfitVkwIkRIHso3WNV
 Pc6xG/mnkTue+TJ0LEALzjs0YMa25Jz1iWUJt4yeA7wzvcB7od+t8tbKu9bgCZ5zqgG4t1Nst7E
 lnDlV/iJ1ygQWXxAxnGsWSb8kLoJW9rVhxBfFFmbs/evcsZvf0sxniLB9fDtWpCFyUaytEg3u9U
 a9OQI/sLKXntGOqGVahZEEAX92p0zEtj/T8MktL5fP50YC9yZ6KNKh6JccuNnz7vxRz0B4pHKZR
 AMmpxWMGsGEaYAuf9YvJA2ygGclbdMIcCTCbGzxZw2xYjn6HwHj6O3t5RuJuDsKLlR4dCGNju7n
 VOcLuMgxijVzRns+CkQ==
X-Proofpoint-GUID: btp1wXNKr9JwmmEo3pAbITEyMoTCsNiI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX4ovnLHLx5ROa
 UOk33m6gLFWg/JcS+IM3zJN1TaLoZaBSqusupZW46qe0AZ4Da+9vCD9NL/CAYiN0HaF3d0CzQPT
 G9Jpv8u4aadKqK2OxfbRb3ioqv95RR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150030
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

Because DCP owns the display hardware, DRM state must be translated into
the firmware protocol instead of being written to display registers.

Add HFI command helpers for capabilities, display resources, CRTCs, planes,
encoders, DSI, and panel configuration. Translate modeset and plane state
into HFI properties for bandwidth, layers, mixers, frame sequencing, and
frame triggering, and add panel initialization and DCS transfer support.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
 drivers/gpu/drm/msm/Makefile                |   6 +
 drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h     |  77 ++++
 drivers/gpu/drm/msm/dcp/dcp_hfi.h           |  57 +++
 drivers/gpu/drm/msm/dcp/dcp_hfi_crtc.c      | 191 +++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c       | 253 ++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c | 601 ++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_encoder.c   |  64 +++
 drivers/gpu/drm/msm/dcp/dcp_hfi_kms.c       | 451 +++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_plane.c     |  64 +++
 9 files changed, 1764 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 4195bc0e1fc9..039c2e697258 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -71,6 +71,12 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 
 msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_hfi_core.o \
+	dcp/dcp_hfi_crtc.o \
+	dcp/dcp_hfi_dsi.o \
+	dcp/dcp_hfi_dsi_panel.o \
+	dcp/dcp_hfi_encoder.o \
+	dcp/dcp_hfi_kms.o \
+	dcp/dcp_hfi_plane.o \
 	dcp/dcp_ipcc.o \
 	dcp/hfi/hfi_packer.o \
 	dcp/hfi/hfi_unpacker.o \
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
new file mode 100644
index 000000000000..a46cd9f4a7dc
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP DSI panel configuration shared by the HFI panel implementation and
+ * the DRM DSI bridge.
+ */
+
+#ifndef __DCP_DSI_PANEL_H__
+#define __DCP_DSI_PANEL_H__
+
+#include <linux/dma-mapping.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#define DCP_DSI_MAX_PHY_TIMINGS	32
+
+/**
+ * struct dcp_dsi_hfi_panel_config - Firmware-only DSI panel properties.
+ */
+struct dcp_dsi_hfi_panel_config {
+	u32 display_type;
+	u32 num_ctrls;
+	u32 ctrl_indices[4];
+	u32 num_phys;
+	u32 phy_indices[4];
+	u32 vsync_source;
+	u32 te_dcs_command;
+	u32 dma_trigger;
+	u32 stream_trigger;
+	u32 wr_mem_start;
+	u32 wr_mem_continue;
+	u32 dma_sched_line;
+	u32 dma_sched_window;
+	u32 phy_type;
+	bool cphy_mode;
+	bool lp11_init;
+	bool ulps_supported;
+	bool bllp_eof_power_mode;
+	bool bllp_power_mode;
+	u32 lane_map;
+	u32 color_order;
+	u32 esd_mode;
+	u32 jitter_numer;
+	u32 jitter_denom;
+	dma_addr_t dcs_tx_dva;
+	dma_addr_t dcs_tx_iova;
+	u32 dcs_tx_buf_size;
+	u32 phy_timings[DCP_DSI_MAX_PHY_TIMINGS];
+	u32 num_phy_timings;
+	bool dsc_enabled;
+	u32 dsc_version_major;
+	u32 dsc_version_minor;
+	u32 dsc_scr_version;
+	u32 dsc_slice_height;
+	u32 dsc_slice_width;
+	u32 dsc_slices_per_pkt;
+	u32 dsc_bits_per_component;
+	u32 dsc_pps_delay_ms;
+	u32 dsc_bits_per_pixel;
+	u32 dsc_chroma_format;
+	u32 dsc_color_space;
+	u32 dsc_block_prediction_enable;
+	bool dsc_rc_override;
+	u8 dsc_rc_min_qp[15];
+	u8 dsc_rc_max_qp[15];
+	u8 dsc_rc_bpg_offsets[15];
+	u32 topology_mixer_count;
+	u32 topology_enc_count;
+	u32 topology_intf_count;
+};
+
+/* DCS buffers use IOVAs directly in the firmware command descriptor. */
+#define DCP_DSI_DCS_TX_BUF_SIZE	SZ_4K
+#define DCP_DSI_DCS_RX_BUF_SIZE	SZ_4K
+
+#endif /* __DCP_DSI_PANEL_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi.h b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
index 726087e5c8a2..664d44f0e48b 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_hfi.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
@@ -211,4 +211,61 @@ int dcp_hfi_send_no_wait_atomic_flags(struct dcp_hfi *hfi, u32 cmd,
 				      enum hfi_cmd_buff_type cmd_type, u32 object_id,
 				       enum hfi_packet_payload_type payload_type,
 				       void *payload, u32 payload_size, u32 tx_flags);
+int dcp_hfi_display_event_register(struct dcp_hfi *hfi, u32 session_id,
+				   u32 event_id);
+int dcp_hfi_display_event_deregister(struct dcp_hfi *hfi, u32 session_id,
+				     u32 event_id);
+int dcp_hfi_display_event_register_async(struct dcp_hfi *hfi, u32 session_id,
+					 u32 event_id);
+int dcp_hfi_display_event_deregister_async(struct dcp_hfi *hfi,
+					   u32 session_id, u32 event_id);
+int dcp_hfi_crtc_set_resource(struct dcp_hfi *hfi, u32 session_id,
+			      u32 lm_idx, u32 width, u32 height,
+			      u32 roi_x, u32 roi_y);
+int dcp_hfi_crtc_set_dest_roi(struct dcp_hfi *hfi, u32 session_id,
+			      u32 x, u32 y, u32 width, u32 height);
+int dcp_hfi_crtc_set_scan_sequence_id(struct dcp_hfi *hfi, u32 session_id,
+				      u32 seq_id);
+int dcp_hfi_crtc_set_power_mode(struct dcp_hfi *hfi, u32 session_id,
+				enum hfi_display_power_mode mode);
+int dcp_hfi_crtc_set_autorefresh(struct dcp_hfi *hfi, u32 session_id,
+				 bool enable, u32 frame_count);
+int dcp_hfi_crtc_set_bw(struct dcp_hfi *hfi, u32 session_id,
+			u64 dram_ib, u64 dram_ab, u64 llcc_ib,
+			u64 llcc_ab, u64 core_clk);
+int dcp_hfi_submit_prop_pkt(struct dcp_hfi *hfi, const void *pkt,
+			    size_t pkt_size);
+int dcp_hfi_plane_disable(struct dcp_hfi *hfi, u32 session_id, u32 pipe_idx);
+int dcp_hfi_display_commit(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_send_device_init(struct dcp_hfi *hfi);
+int dcp_hfi_get_capabilities(struct dcp_hfi *hfi, struct dcp_caps *caps);
+int dcp_hfi_send_resource_register(struct dcp_hfi *hfi);
+int dcp_hfi_set_display_property(struct dcp_hfi *hfi, u32 session_id,
+				 u32 prop_id, u32 value);
+
+struct dcp_dsi_hfi_panel_config;
+int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
+		       const struct drm_display_mode *mode,
+		       const struct mipi_dsi_device *dsi,
+		       const struct dcp_dsi_hfi_panel_config *cfg);
+int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx,
+			   u32 display_id, u32 *session_id);
+int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
+				  const struct drm_display_mode *mode,
+			     u64 clk_rate_hz);
+int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
+			     const struct drm_display_mode *mode,
+			     u64 clk_rate_hz);
+int dcp_hfi_display_power_register(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_display_power_control_ack(struct dcp_hfi *hfi, u32 session_id,
+				      u32 packet_id);
+int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id);
+ssize_t dcp_hfi_dcs_transfer(struct dcp_hfi *hfi, u32 session_id,
+			     const struct mipi_dsi_msg *msg,
+			     void *tx_buf, dma_addr_t tx_iova,
+			     void *rx_buf, dma_addr_t rx_iova,
+			     u32 post_wait_ms, u32 ctrl_idx);
 #endif /* __DCP_HFI_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_crtc.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_crtc.c
new file mode 100644
index 000000000000..14a6db46db87
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_crtc.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * HFI commands for display events and CRTC properties.
+ */
+
+#include <linux/device.h>
+
+#include "dcp_hfi_priv.h"
+#include "dcp_hfi.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_commands_display_events.h"
+#include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_defs_display.h"
+#include "hfi/hfi_properties_display.h"
+
+int dcp_hfi_display_event_register(struct dcp_hfi *hfi, u32 session_id,
+				   u32 event_cmd)
+{
+	int ret = dcp_hfi_send_sync(hfi,
+				      HFI_COMMAND_DISPLAY_EVENT_REGISTER,
+				      HFI_CMD_BUFF_DISPLAY, session_id,
+				      HFI_PAYLOAD_U32,
+				      &event_cmd, sizeof(event_cmd),
+				      HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				      HFI_TX_FLAGS_NON_DISCARDABLE,
+				      NULL, 0,
+				      DCP_HFI_TIMEOUT_DISPLAY_MS);
+	return ret;
+}
+
+int dcp_hfi_display_event_deregister(struct dcp_hfi *hfi, u32 session_id,
+				     u32 event_cmd)
+{
+	int ret = dcp_hfi_send_sync(hfi,
+				      HFI_COMMAND_DISPLAY_EVENT_DEREGISTER,
+				      HFI_CMD_BUFF_DISPLAY, session_id,
+				      HFI_PAYLOAD_U32,
+				      &event_cmd, sizeof(event_cmd),
+				      HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				      HFI_TX_FLAGS_NON_DISCARDABLE,
+				      NULL, 0,
+				      DCP_HFI_TIMEOUT_DISPLAY_MS);
+	return ret;
+}
+
+int dcp_hfi_display_event_register_async(struct dcp_hfi *hfi,
+					 u32 session_id, u32 event_cmd)
+{
+	return dcp_hfi_send_no_wait_atomic_flags(hfi,
+			HFI_COMMAND_DISPLAY_EVENT_REGISTER,
+			HFI_CMD_BUFF_DISPLAY, session_id, HFI_PAYLOAD_U32,
+			&event_cmd, sizeof(event_cmd), HFI_TX_FLAGS_NON_DISCARDABLE);
+}
+
+int dcp_hfi_display_event_deregister_async(struct dcp_hfi *hfi,
+					   u32 session_id, u32 event_cmd)
+{
+	return dcp_hfi_send_no_wait_atomic_flags(hfi,
+			HFI_COMMAND_DISPLAY_EVENT_DEREGISTER,
+			HFI_CMD_BUFF_DISPLAY, session_id, HFI_PAYLOAD_U32,
+			&event_cmd, sizeof(event_cmd), HFI_TX_FLAGS_NON_DISCARDABLE);
+}
+
+int dcp_hfi_crtc_set_resource(struct dcp_hfi *hfi, u32 session_id,
+			      u32 lm_idx, u32 width, u32 height,
+				u32 roi_x, u32 roi_y)
+{
+	u32 payload[7];
+
+	payload[0] = 1;
+	HFI_PACK(&payload[1], HFI_PROPERTY_DISPLAY_SET_RESOURCE_DATA,
+		 HFI_RESOURCE_LM, lm_idx, width, height,
+		 (roi_x << 16) | (roi_y & 0xFFFF));
+
+	return dcp_hfi_send_no_wait_flags(hfi,
+				       HFI_COMMAND_DISPLAY_SET_PROPERTY,
+				       HFI_CMD_BUFF_DISPLAY,
+				       session_id,
+				       HFI_PAYLOAD_U32_ARRAY,
+				       payload, sizeof(payload),
+				       HFI_TX_FLAGS_NON_DISCARDABLE);
+}
+
+int dcp_hfi_crtc_set_dest_roi(struct dcp_hfi *hfi, u32 session_id,
+			      u32 x, u32 y, u32 width, u32 height)
+{
+	u32 payload[9];
+
+	payload[0] = 1;
+	HFI_PACK(&payload[1], HFI_PROPERTY_DISPLAY_DEST_ROI,
+		 session_id, PANEL_ROI, 1, x, y, width, height);
+
+	return dcp_hfi_send_no_wait_flags(hfi,
+				       HFI_COMMAND_DISPLAY_SET_PROPERTY,
+				       HFI_CMD_BUFF_DISPLAY, session_id,
+				       HFI_PAYLOAD_U32_ARRAY, payload,
+				       sizeof(payload), HFI_TX_FLAGS_NON_DISCARDABLE);
+}
+
+int dcp_hfi_crtc_set_scan_sequence_id(struct dcp_hfi *hfi, u32 session_id,
+				      u32 seq_id)
+{
+	u32 payload[3];
+
+	payload[0] = 1;
+	payload[1] = HFI_PACK_KEY(HFI_PROPERTY_DISPLAY_SCAN_SEQUENCE_ID, 0, 1);
+	payload[2] = seq_id;
+
+	return dcp_hfi_send_no_wait(hfi,
+				      HFI_COMMAND_DISPLAY_SET_PROPERTY,
+				      HFI_CMD_BUFF_DISPLAY,
+				      session_id,
+				      HFI_PAYLOAD_U32_ARRAY,
+				      payload, sizeof(payload));
+}
+
+int dcp_hfi_crtc_set_power_mode(struct dcp_hfi *hfi, u32 session_id,
+				enum hfi_display_power_mode mode)
+{
+	u32 payload[3];
+
+	payload[0] = 1;
+	payload[1] = HFI_PACK_KEY(HFI_PROPERTY_DISPLAY_POWER_MODE, 0, 1);
+	payload[2] = (u32)mode;
+
+	return dcp_hfi_send_no_wait(hfi,
+				      HFI_COMMAND_DISPLAY_SET_PROPERTY,
+				      HFI_CMD_BUFF_DISPLAY,
+				      session_id,
+				      HFI_PAYLOAD_U32_ARRAY,
+				      payload, sizeof(payload));
+}
+
+int dcp_hfi_crtc_set_autorefresh(struct dcp_hfi *hfi, u32 session_id,
+				 bool enable, u32 frame_count)
+{
+	u32 payload[4];
+
+	payload[0] = 1;
+	payload[1] = HFI_PACK_KEY(HFI_PROPERTY_DISPLAY_AUTOREFRESH_CFG, 0, 2);
+	payload[2] = enable ? 1 : 0;
+	payload[3] = frame_count;
+
+	return dcp_hfi_send_sync(hfi,
+				 HFI_COMMAND_DISPLAY_SET_PROPERTY,
+				 HFI_CMD_BUFF_DISPLAY,
+				 session_id,
+				 HFI_PAYLOAD_U32_ARRAY,
+				 payload, sizeof(payload),
+				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE,
+				 NULL, 0,
+				 DCP_HFI_TIMEOUT_DISPLAY_MS);
+}
+
+int dcp_hfi_crtc_set_bw(struct dcp_hfi *hfi, u32 session_id,
+			u64 dram_ib, u64 dram_ab,
+			  u64 llcc_ib, u64 llcc_ab,
+			  u64 core_clk)
+{
+	u32 payload[16];
+	u32 *p = payload;
+
+	*p++ = 5;
+
+#define PACK_U64_PROP(prop_id, val) \
+	do { \
+		typeof(val) __val = (val); \
+		*p++ = HFI_PACK_KEY((prop_id), 0, 2); \
+		*p++ = lower_32_bits(__val); \
+		*p++ = upper_32_bits(__val); \
+	} while (0)
+
+	PACK_U64_PROP(HFI_PROPERTY_DISPLAY_DRAM_IB,  dram_ib);
+	PACK_U64_PROP(HFI_PROPERTY_DISPLAY_DRAM_AB,  dram_ab);
+	PACK_U64_PROP(HFI_PROPERTY_DISPLAY_LLCC_IB,  llcc_ib);
+	PACK_U64_PROP(HFI_PROPERTY_DISPLAY_LLCC_AB,  llcc_ab);
+	PACK_U64_PROP(HFI_PROPERTY_DISPLAY_CORE_CLK, core_clk);
+
+#undef PACK_U64_PROP
+
+	return dcp_hfi_send_no_wait(hfi,
+				      HFI_COMMAND_DISPLAY_SET_PROPERTY,
+				      HFI_CMD_BUFF_DISPLAY,
+				      session_id,
+				      HFI_PAYLOAD_U32_ARRAY,
+				      payload,
+				      (u32)((p - payload) * sizeof(u32)));
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
new file mode 100644
index 000000000000..de34a6c6783b
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * HFI commands for the DSI display-session lifecycle.
+ * Panel initialization and DCS transfers are implemented in dcp_hfi_dsi_panel.c.
+ */
+
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <drm/drm_modes.h>
+
+#include "dcp_hfi.h"
+#include "dcp_hfi_priv.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_defs_display.h"
+#include "hfi/hfi_packet.h"
+#include "hfi/hfi_packer.h"
+#include "hfi/hfi_properties_display.h"
+
+static void dcp_hfi_fill_mode_info(struct hfi_display_mode_info *info,
+				   const struct drm_display_mode *mode)
+{
+	memset(info, 0, sizeof(*info));
+	info->size            = sizeof(*info);
+	info->h_active        = mode->hdisplay;
+	info->h_back_porch    = mode->htotal - mode->hsync_end;
+	info->h_sync_width    = mode->hsync_end - mode->hsync_start;
+	info->h_front_porch   = mode->hsync_start - mode->hdisplay;
+	info->h_skew          = mode->hskew;
+	info->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_PHSYNC);
+	info->v_active        = mode->vdisplay;
+	info->v_back_porch    = mode->vtotal - mode->vsync_end;
+	info->v_sync_width    = mode->vsync_end - mode->vsync_start;
+	info->v_front_porch   = mode->vsync_start - mode->vdisplay;
+	info->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_PVSYNC);
+	info->refresh_rate    = drm_mode_vrefresh(mode);
+	info->clk_rate_hz_lo = lower_32_bits((u64)mode->clock * 1000);
+	info->clk_rate_hz_hi = upper_32_bits((u64)mode->clock * 1000);
+}
+
+static void dcp_hfi_dump_mode_info(struct dcp_hfi *hfi, const char *cmd,
+				   u32 session_id,
+				const struct hfi_display_mode_info *info)
+{
+	dev_dbg(hfi->dev,
+		"HFI %s s=%u h=%u/%u/%u/%u v=%u/%u/%u/%u p=%u/%u r=%u clk=%llu sz=%u\n",
+		 cmd, session_id,
+		 info->h_active, info->h_back_porch, info->h_sync_width,
+		 info->h_front_porch,
+		 info->v_active, info->v_back_porch, info->v_sync_width,
+		 info->v_front_porch,
+		 info->h_sync_polarity, info->v_sync_polarity,
+		 info->refresh_rate,
+		 (u64)info->clk_rate_hz_lo | ((u64)info->clk_rate_hz_hi << 32),
+		 info->size);
+}
+
+int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
+				  const struct drm_display_mode *mode, u64 clk_rate_hz)
+{
+	struct hfi_display_mode_info info;
+	int ret;
+
+	dcp_hfi_fill_mode_info(&info, mode);
+	info.clk_rate_hz_lo = lower_32_bits(clk_rate_hz);
+	info.clk_rate_hz_hi = upper_32_bits(clk_rate_hz);
+	dcp_hfi_dump_mode_info(hfi, "HFI MODE_VALIDATE", session_id, &info);
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_MODE_VALIDATE,
+				HFI_CMD_BUFF_DISPLAY, session_id,
+				HFI_PAYLOAD_U32_ARRAY,
+				&info, sizeof(info),
+				HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				HFI_TX_FLAGS_NON_DISCARDABLE,
+				NULL, 0,
+				DCP_HFI_TIMEOUT_MODE_MS);
+
+	return ret;
+}
+
+int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
+			     const struct drm_display_mode *mode, u64 clk_rate_hz)
+{
+	struct hfi_display_mode_info info;
+	int ret;
+
+	dcp_hfi_fill_mode_info(&info, mode);
+	info.clk_rate_hz_lo = lower_32_bits(clk_rate_hz);
+	info.clk_rate_hz_hi = upper_32_bits(clk_rate_hz);
+	dcp_hfi_dump_mode_info(hfi, "HFI SET_MODE", session_id, &info);
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_SET_MODE,
+				HFI_CMD_BUFF_DISPLAY, session_id,
+				HFI_PAYLOAD_U32_ARRAY,
+				&info, sizeof(info),
+				HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				HFI_TX_FLAGS_NON_DISCARDABLE,
+				NULL, 0,
+				DCP_HFI_TIMEOUT_MODE_MS);
+
+	return ret;
+}
+
+int dcp_hfi_display_power_register(struct dcp_hfi *hfi, u32 session_id)
+{
+	return dcp_hfi_send_sync(hfi,
+				 HFI_COMMAND_DISPLAY_POWER_REGISTER,
+				 HFI_CMD_BUFF_DISPLAY, session_id,
+				 HFI_PAYLOAD_NONE, NULL, 0,
+				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE,
+				 NULL, 0,
+				 DCP_HFI_TIMEOUT_DISPLAY_MS);
+}
+
+int dcp_hfi_display_power_control_ack(struct dcp_hfi *hfi, u32 session_id,
+				      u32 packet_id)
+{
+	struct dcp_hfi_buf *buf;
+	struct hfi_cmd_buff_hdl hdl;
+	struct hfi_header_info hdr_info;
+	struct hfi_packet_info pkt_info;
+	int ret;
+
+	buf = dcp_hfi_buf_alloc(hfi);
+	if (!buf)
+		return -ENOMEM;
+
+	hdl.cmd_buffer = buf->data;
+	hdl.size       = DCP_HFI_BUF_SIZE;
+
+	hdr_info.num_packets   = 0;
+	hdr_info.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
+	hdr_info.object_id     = session_id;
+	hdr_info.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl, &hdr_info);
+	if (ret)
+		goto err_free_buf;
+
+	pkt_info.cmd          = HFI_COMMAND_DISPLAY_POWER_CONTROL;
+	pkt_info.id           = session_id & 0xFFFF;
+	pkt_info.flags        = HFI_RX_FLAGS_SUCCESS;
+	pkt_info.packet_id    = packet_id;
+	pkt_info.payload_type = HFI_PAYLOAD_NONE;
+	pkt_info.payload_size = 0;
+	pkt_info.payload_ptr  = NULL;
+
+	ret = hfi_create_packet_header(&hdl, &pkt_info);
+	if (ret)
+		goto err_free_buf;
+
+	return dcp_hfi_send_cmd_async(hfi, buf, hfi_get_header_size(&hdl), NULL);
+
+err_free_buf:
+	dcp_hfi_buf_free(hfi, buf);
+	return ret;
+}
+
+int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx, u32 display_id,
+			   u32 *session_id)
+{
+	int ret;
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_ENABLE,
+				HFI_CMD_BUFF_DISPLAY, display_id,
+				HFI_PAYLOAD_NONE, NULL, 0,
+				HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				HFI_TX_FLAGS_NON_DISCARDABLE,
+				NULL, 0,
+				DCP_HFI_TIMEOUT_DISPLAY_MS);
+	if (ret) {
+		dev_err(hfi->dev,
+			"HFI DISPLAY_ENABLE intf=%u display_id=%u failed: %d\n",
+			intf_idx, display_id, ret);
+		return ret;
+	}
+
+	*session_id = display_id;
+
+	return 0;
+}
+
+int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id)
+{
+	return dcp_hfi_send_sync(hfi,
+				 HFI_COMMAND_DISPLAY_POST_ENABLE,
+				 HFI_CMD_BUFF_DISPLAY, session_id,
+				 HFI_PAYLOAD_NONE, NULL, 0,
+				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE,
+				 NULL, 0,
+				 DCP_HFI_TIMEOUT_DISPLAY_MS);
+}
+
+int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id)
+{
+	return dcp_hfi_send_sync(hfi,
+				 HFI_COMMAND_DISPLAY_DISABLE,
+				 HFI_CMD_BUFF_DISPLAY, session_id,
+				 HFI_PAYLOAD_NONE, NULL, 0,
+				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE,
+				 NULL, 0,
+				 DCP_HFI_TIMEOUT_DISPLAY_MS);
+}
+
+int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id)
+{
+	return dcp_hfi_send_sync(hfi,
+				 HFI_COMMAND_DISPLAY_POST_DISABLE,
+				 HFI_CMD_BUFF_DISPLAY, session_id,
+				 HFI_PAYLOAD_NONE, NULL, 0,
+				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE,
+				 NULL, 0,
+				 DCP_HFI_TIMEOUT_DISPLAY_MS);
+}
+
+int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id)
+{
+	int ret;
+
+	ret = dcp_hfi_display_disable(hfi, session_id);
+	if (ret) {
+		dev_warn(hfi->dev, "HFI DISPLAY_DISABLE failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = dcp_hfi_display_post_disable(hfi, session_id);
+	if (ret) {
+		dev_warn(hfi->dev, "HFI DISPLAY_POST_DISABLE failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_CLOSE,
+				HFI_CMD_BUFF_DISPLAY, session_id,
+				HFI_PAYLOAD_NONE, NULL, 0,
+				HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				HFI_TX_FLAGS_NON_DISCARDABLE,
+				NULL, 0,
+				DCP_HFI_TIMEOUT_DISPLAY_MS);
+	if (ret)
+		dev_warn(hfi->dev, "HFI DISPLAY_CLOSE failed: %d\n", ret);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
new file mode 100644
index 000000000000..48a87d52f697
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * HFI commands for panel initialization and DCS transfers.
+ * Firmware owns the DSI controller and PHY.
+ */
+
+#include <linux/device.h>
+#include <linux/math64.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_mipi_dsi.h>
+
+#include "dcp_dsi_panel.h"
+#include "dcp_hfi.h"
+#include "dcp_hfi_priv.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_commands_panel.h"
+#include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_defs_panel.h"
+#include "hfi/hfi_packet.h"
+#include "hfi/hfi_packer.h"
+#include "hfi/hfi_properties_panel.h"
+
+#define DCP_DSI_CTRL_CMD_READ              BIT(0)
+#define DCP_DSI_CTRL_CMD_FETCH_MEMORY      BIT(5)
+#define DCP_DSI_CTRL_CMD_LAST_COMMAND      BIT(6)
+
+static u32 dcp_bpp_to_hfi(u32 bpp)
+{
+	switch (bpp) {
+	case 16: return HFI_PANEL_BPP_16;
+	case 18: return HFI_PANEL_BPP_18;
+	case 30: return HFI_PANEL_BPP_30;
+	case 24:
+	default: return HFI_PANEL_BPP_24;
+	}
+}
+
+static u32 dcp_dsi_format_bpp(enum mipi_dsi_pixel_format format)
+{
+	int bpp;
+
+	bpp = mipi_dsi_pixel_format_to_bpp(format);
+	if (bpp < 0)
+		return 24;
+
+	return bpp;
+}
+
+static u32 dcp_dsi_traffic_mode(const struct mipi_dsi_device *dsi)
+{
+	if (!dsi || !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO))
+		return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE;
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		return HFI_PANEL_TRAFFIC_BURST_MODE;
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+		return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_PULSE_MODE;
+	return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE;
+}
+
+static u32 dcp_lanes_to_hfi(u32 num_lanes)
+{
+	u32 mask = 0;
+
+	if (num_lanes >= 1)
+		mask |= HFI_PANEL_LANE_0;
+	if (num_lanes >= 2)
+		mask |= HFI_PANEL_LANE_1;
+	if (num_lanes >= 3)
+		mask |= HFI_PANEL_LANE_2;
+	if (num_lanes >= 4)
+		mask |= HFI_PANEL_LANE_3;
+
+	return mask ?: HFI_PANEL_LANE_0;
+}
+
+static bool dcp_hfi_panel_wait(struct dcp_hfi *hfi,
+			       struct dcp_hfi_completion *comp)
+{
+	unsigned long flags;
+
+	if (wait_for_completion_timeout(&comp->done,
+					msecs_to_jiffies(DCP_HFI_TIMEOUT_DISPLAY_MS)))
+		return false;
+
+	/* Serialize removal with response dispatch before the stack object dies. */
+	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+	dcp_hfi_pending_find(hfi, comp->packet_id);
+	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+	return true;
+}
+
+int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
+		       const struct drm_display_mode *mode,
+		       const struct mipi_dsi_device *dsi,
+		       const struct dcp_dsi_hfi_panel_config *cfg)
+{
+	u32 num_lanes;
+	u32 bpp;
+	bool is_cmd_mode;
+	u32 display_type;
+	u32 vsync_source;
+	u32 traffic_mode;
+	u32 phy_type;
+
+	struct dcp_hfi_buf *buf1, *buf2;
+	struct hfi_cmd_buff_hdl hdl1, hdl2;
+	struct hfi_header_info hdr_info1, hdr_info2;
+	struct hfi_packet_info pkt_info;
+	struct dcp_hfi_completion comp1, comp2, comp3;
+	u32 payload[128];
+	u32 *p;
+	u32 packet_id, packet_id2, packet_id3;
+	u64 clk_hz;
+	int ret;
+	bool timeout1, timeout2, timeout3;
+	u32 link_bpp_x16;
+
+	if (!hfi || !mode || !dsi || !dsi->lanes || !cfg)
+		return -EINVAL;
+	if (cfg->num_ctrls > ARRAY_SIZE(cfg->ctrl_indices) ||
+	    cfg->num_phys > ARRAY_SIZE(cfg->phy_indices))
+		return -EINVAL;
+
+	display_type = cfg->display_type;
+	vsync_source = cfg->vsync_source;
+	phy_type = cfg->phy_type;
+	num_lanes = dsi->lanes;
+	bpp = dcp_dsi_format_bpp(dsi->format);
+	is_cmd_mode = !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
+	traffic_mode = dcp_dsi_traffic_mode(dsi);
+	link_bpp_x16 = bpp << 4;
+
+	buf1 = dcp_hfi_buf_alloc(hfi);
+	if (!buf1) {
+		dev_err(hfi->dev, "HFI PANEL_INIT: TX buffer exhausted\n");
+		return -ENOMEM;
+	}
+
+	hdl1.cmd_buffer = buf1->data;
+	hdl1.size       = DCP_HFI_BUF_SIZE;
+
+	hdr_info1.num_packets   = 0;
+	hdr_info1.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
+	hdr_info1.object_id     = intf_idx;
+	hdr_info1.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl1, &hdr_info1);
+	if (ret) {
+		dev_err(hfi->dev, "PANEL_INIT: hfi_create_header (A) failed: %d\n",
+			ret);
+		goto err_free_buf1;
+	}
+
+	{
+		u32 num_props = 0;
+
+		p = payload + 1;
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TIMING_MODE_COUNT, 1);
+
+		/* DCS TX buffer is described by both DVA and IOVA properties. */
+		if (cfg->dcs_tx_iova && cfg->dcs_tx_dva &&
+		    !(cfg->dcs_tx_iova & 0x3ff) && !(cfg->dcs_tx_dva & 0x3ff)) {
+			num_props++;
+			p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_DVA,
+				       lower_32_bits(cfg->dcs_tx_dva),
+				       upper_32_bits(cfg->dcs_tx_dva),
+				       cfg->dcs_tx_buf_size, 0, 0);
+			num_props++;
+			p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_IOVA,
+				       lower_32_bits(cfg->dcs_tx_iova),
+				       upper_32_bits(cfg->dcs_tx_iova),
+				       cfg->dcs_tx_buf_size, 0, 0);
+		}
+		payload[0] = num_props;
+	}
+
+	packet_id = dcp_hfi_next_packet_id(hfi);
+	pkt_info.cmd          = HFI_COMMAND_PANEL_INIT_PANEL_CAPS;
+	pkt_info.id           = intf_idx & 0xFFFF;
+	pkt_info.flags        = HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE;
+	pkt_info.packet_id    = packet_id;
+	pkt_info.payload_type = HFI_PAYLOAD_U32_ARRAY;
+	pkt_info.payload_size = (u32)((p - payload) * sizeof(u32));
+	pkt_info.payload_ptr  = payload;
+
+	ret = hfi_create_full_packet(&hdl1, &pkt_info);
+	if (ret)
+		goto err_free_buf1;
+
+	dev_dbg(hfi->dev,
+		"intf%u: DCP mode %dx%d@%dHz clk=%ukHz ht=%u hs=%u/%u vt=%u vs=%u/%u f=0x%x\n",
+		 intf_idx, mode->hdisplay, mode->vdisplay,
+		 drm_mode_vrefresh(mode), mode->clock,
+		 mode->htotal, mode->hsync_start, mode->hsync_end,
+		 mode->vtotal, mode->vsync_start, mode->vsync_end,
+		 mode->flags);
+
+	{
+		u32 te_dcs     = cfg->te_dcs_command;
+		u32 dma_trig   = cfg->dma_trigger;
+		u32 str_trig   = cfg->stream_trigger;
+		u32 wr_start   = cfg->wr_mem_start;
+		u32 wr_cont    = cfg->wr_mem_continue;
+		u32 lane_map   = cfg->lane_map;
+		u32 color_ord  = cfg->color_order;
+		u32 vc_id      = dsi->channel;
+		u32 esd_mode   = cfg->esd_mode;
+		u32 dma_win    = cfg->dma_sched_window;
+		bool lp11      = cfg->lp11_init;
+		bool cphy      = cfg->cphy_mode;
+		bool ulps      = cfg->ulps_supported;
+		bool tx_eot    = !(dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET);
+		bool bllp_eof  = cfg->bllp_eof_power_mode;
+		bool bllp_pwr  = cfg->bllp_power_mode;
+		u32 num_ctrls  = cfg->num_ctrls;
+		u32 num_phys   = cfg->num_phys;
+		u32 num_props = 0;
+
+		p = payload + 1;
+
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_PHYSICAL_TYPE, phy_type);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_BPP, dcp_bpp_to_hfi(bpp));
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_LANES_STATE,
+			       dcp_lanes_to_hfi(num_lanes));
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_OPERATING_MODE,
+			       is_cmd_mode ? HFI_PANEL_CMD_MODE_8_BIT :
+			       HFI_PANEL_VIDEO_MODE_8_BIT);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_DISPLAY_TYPE, display_type);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_VSYNC_SOURCE, vsync_source);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TRAFFIC_MODE, traffic_mode);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TE_DCS_COMMAND, te_dcs);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_DMA_TRIGGER, dma_trig);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_STREAM_TRIGGER, str_trig);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_WR_MEM_START, wr_start);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_WR_MEM_CONTINUE, wr_cont);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_LP11_INIT, lp11 ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_CPHY_MODE, cphy ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_ULPS_SUPPORTED,
+			       ulps ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TX_EOT_APPEND,
+			       tx_eot ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_BLLP_EOF_POWER_MODE,
+			       bllp_eof ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_BLLP_POWER_MODE,
+			       bllp_pwr ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_COLOR_ORDER, color_ord);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_VIRTUAL_CHANNEL_ID, vc_id);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_LANE_MAP, lane_map);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_ESD_CONFIG,
+			       10 * sizeof(u32), esd_mode,
+			       0, 0, 0, 0, 0, 0, 0, 0);
+
+		num_props++;
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_CTRL_NUM, 0, 1 + num_ctrls);
+		*p++ = num_ctrls;
+		memcpy(p, cfg->ctrl_indices, num_ctrls * sizeof(*p));
+		p += num_ctrls;
+
+		num_props++;
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_PHY_NUM, 0, 1 + num_phys);
+		*p++ = num_phys;
+		memcpy(p, cfg->phy_indices, num_phys * sizeof(*p));
+		p += num_phys;
+
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_DMA_SCHEDULE_WINDOW, dma_win);
+		payload[0] = num_props;
+	}
+
+	packet_id3 = dcp_hfi_next_packet_id(hfi);
+	pkt_info.cmd          = HFI_COMMAND_PANEL_INIT_GENERIC_CAPS;
+	pkt_info.flags        = HFI_TX_FLAGS_NON_DISCARDABLE | HFI_TX_FLAGS_RESPONSE_REQUIRED;
+	pkt_info.packet_id    = packet_id3;
+	pkt_info.payload_size = (u32)((p - payload) * sizeof(u32));
+	pkt_info.payload_ptr  = payload;
+
+	ret = hfi_create_full_packet(&hdl1, &pkt_info);
+	if (ret)
+		goto err_free_buf1;
+
+	buf2 = dcp_hfi_buf_alloc(hfi);
+	if (!buf2) {
+		dev_err(hfi->dev, "HFI PANEL_INIT: TX buffer exhausted (B)\n");
+		ret = -ENOMEM;
+		goto err_free_buf1;
+	}
+
+	hdl2.cmd_buffer = buf2->data;
+	hdl2.size       = DCP_HFI_BUF_SIZE;
+
+	hdr_info2.num_packets   = 0;
+	hdr_info2.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
+	hdr_info2.object_id     = intf_idx;
+	hdr_info2.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl2, &hdr_info2);
+	if (ret) {
+		dev_err(hfi->dev, "PANEL_INIT: hfi_create_header (B) failed: %d\n",
+			ret);
+		goto err_free_both;
+	}
+
+	{
+		u32 num_props = 7; /* timing properties; DPHY and DSC are optional */
+
+		if (cfg->dsc_enabled)
+			num_props++;
+		if (cfg->dsc_enabled && cfg->dsc_rc_override)
+			num_props++;
+		if (cfg->num_phy_timings)
+			num_props++;
+		p = payload;
+		*p++ = num_props;
+	}
+	p = payload + 1;
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_INDEX, 0, 1);
+	*p++ = 0;
+
+	/* PANEL_CLOCKRATE is the panel-selected DSI bit clock per lane. */
+	if (cfg->dsc_enabled && cfg->dsc_bits_per_pixel)
+		link_bpp_x16 = cfg->dsc_bits_per_pixel;
+	clk_hz = dsi->hs_rate ? dsi->hs_rate :
+		div_u64((u64)mode->clock * 1000 * link_bpp_x16,
+			num_lanes * 16);
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_CLOCKRATE, 0, 2);
+	*p++ = lower_32_bits(clk_hz);
+	*p++ = upper_32_bits(clk_hz);
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_FRAMERATE, 0, 1);
+	*p++ = drm_mode_vrefresh(mode);
+
+	/* Firmware expects numerator/denominator timing jitter per mode. */
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_JITTER, 0, 2);
+	*p++ = cfg->jitter_numer;
+	*p++ = cfg->jitter_denom;
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_RESOLUTION_DATA, 0, 14);
+	*p++ = mode->hdisplay;                       /* active_width */
+	*p++ = mode->vdisplay;                       /* active_height */
+	*p++ = mode->hsync_start - mode->hdisplay;   /* h_front_porch */
+	*p++ = mode->htotal - mode->hsync_end;       /* h_back_porch */
+	*p++ = 0;                                    /* h_left_border */
+	*p++ = 0;                                    /* h_right_border */
+	*p++ = mode->hsync_end - mode->hsync_start;  /* h_pulse_width */
+	*p++ = mode->hskew;                          /* h_sync_skew */
+	*p++ = 0;                                    /* h_sync_pulse (TODO: confirm) */
+	*p++ = mode->vsync_start - mode->vdisplay;   /* v_front_porch */
+	*p++ = mode->vtotal - mode->vsync_end;       /* v_back_porch */
+	*p++ = 0;                                    /* v_top_border */
+	*p++ = 0;                                    /* v_bottom_border */
+	*p++ = mode->vsync_end - mode->vsync_start;  /* v_pulse_width */
+
+	/* Topology fields follow the firmware panel format. */
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_DISPLAY_TOPOLOGY, 0, 4);
+	*p++ = 1;
+	*p++ = cfg->topology_mixer_count;
+	*p++ = cfg->topology_enc_count;
+	*p++ = cfg->topology_intf_count;
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_DEFAULT_TOPOLOGY_INDEX, 0, 1);
+	*p++ = 0;
+
+	if (cfg->dsc_enabled) {
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_COMPRESSION_DATA, 0, 12);
+		*p++ = HFI_PANEL_COMPRESSION_DSC;
+		*p++ = (cfg->dsc_version_major << 4) | cfg->dsc_version_minor;
+		*p++ = cfg->dsc_scr_version;
+		*p++ = cfg->dsc_slice_height;
+		*p++ = cfg->dsc_slice_width;
+		*p++ = cfg->dsc_slices_per_pkt;
+		*p++ = cfg->dsc_bits_per_component;
+		*p++ = cfg->dsc_pps_delay_ms;
+		*p++ = cfg->dsc_bits_per_pixel;
+		*p++ = cfg->dsc_chroma_format;
+		*p++ = cfg->dsc_color_space;
+		*p++ = cfg->dsc_block_prediction_enable;
+	}
+
+	if (cfg->dsc_enabled && cfg->dsc_rc_override) {
+		struct hfi_panel_compression_rc_override rc_override = {};
+
+		memcpy(rc_override.min_qp, cfg->dsc_rc_min_qp,
+		       sizeof(rc_override.min_qp));
+		memcpy(rc_override.max_qp, cfg->dsc_rc_max_qp,
+		       sizeof(rc_override.max_qp));
+		memcpy(rc_override.offsets, cfg->dsc_rc_bpg_offsets,
+		       sizeof(rc_override.offsets));
+
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_COMPRESSION_RC_OVERRIDE, 0,
+				sizeof(rc_override) / sizeof(u32));
+		memcpy(p, &rc_override, sizeof(rc_override));
+		p += sizeof(rc_override) / sizeof(u32);
+	}
+
+	/* DCP computes PHY timings unless an explicit override is supplied. */
+	if (cfg->num_phy_timings) {
+		u32 n = min_t(u32, cfg->num_phy_timings, DCP_DSI_MAX_PHY_TIMINGS);
+
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_DPHY_TIMINGS, 0, n + 1);
+		*p++ = n;
+		memcpy(p, cfg->phy_timings, n * sizeof(*p));
+		p += n;
+	}
+
+	packet_id2 = dcp_hfi_next_packet_id(hfi);
+	pkt_info.cmd          = HFI_COMMAND_PANEL_INIT_TIMING_MODE_CAPS;
+	pkt_info.flags        = HFI_TX_FLAGS_NON_DISCARDABLE | HFI_TX_FLAGS_RESPONSE_REQUIRED;
+	pkt_info.packet_id    = packet_id2;
+	pkt_info.payload_size = (u32)((p - payload) * sizeof(u32));
+	pkt_info.payload_ptr  = payload;
+
+	ret = hfi_create_full_packet(&hdl2, &pkt_info);
+	if (ret)
+		goto err_free_both;
+
+	/*
+	 * Header A carries 2 packets (PANEL_CAPS, GENERIC_CAPS); firmware
+	 * ACKs each individually by its own packet_id. comp1 is registered
+	 * internally by dcp_hfi_send_cmd_async() below; comp3 must be
+	 * pre-registered here or its response is dropped as "no pending
+	 * completion". Header B carries only TIMING_MODE_CAPS (the topology
+	 * property that drives DCP's MDP resource reservation) — comp2 is
+	 * registered internally by its own dcp_hfi_send_cmd_async() call.
+	 */
+	init_completion(&comp1.done);
+	comp1.resp_data = NULL;
+	comp1.resp_len  = 0;
+	comp1.status    = 0;
+	comp1.packet_id = packet_id;
+
+	init_completion(&comp2.done);
+	comp2.resp_data = NULL;
+	comp2.resp_len  = 0;
+	comp2.status    = 0;
+	comp2.packet_id = packet_id2;
+
+	init_completion(&comp3.done);
+	comp3.resp_data = NULL;
+	comp3.resp_len  = 0;
+	comp3.status    = 0;
+	comp3.packet_id = packet_id3;
+
+	ret = dcp_hfi_pending_add(hfi, &comp3);
+	if (ret) {
+		dev_err(hfi->dev,
+			"intf%u: PANEL_INIT: failed to register GENERIC_CAPS completion: %d\n",
+			intf_idx, ret);
+		goto err_free_both;
+	}
+
+	ret = dcp_hfi_send_cmd_async(hfi, buf1,
+				     hfi_get_header_size(&hdl1), &comp1);
+	if (ret) {
+		dev_err(hfi->dev,
+			"intf%u: PANEL_INIT caps/generic (header A) failed\n",
+			intf_idx);
+		dcp_hfi_pending_find(hfi, packet_id3);
+		dcp_hfi_buf_free(hfi, buf2);
+		return ret;
+	}
+
+	/* Stack completions must be retired before returning after submission. */
+	ret = dcp_hfi_send_cmd_async(hfi, buf2,
+				     hfi_get_header_size(&hdl2), &comp2);
+	if (ret) {
+		dev_err(hfi->dev,
+			"intf%u: HFI_COMMAND_PANEL_INIT_TIMING_MODE_CAPS (header B) failed\n",
+			intf_idx);
+		comp2.packet_id = 0; /* never registered/in-flight, nothing to wait on */
+	}
+
+	timeout1 = dcp_hfi_panel_wait(hfi, &comp1);
+	timeout3 = dcp_hfi_panel_wait(hfi, &comp3);
+	if (comp2.packet_id)
+		timeout2 = dcp_hfi_panel_wait(hfi, &comp2);
+	else
+		timeout2 = false;
+
+	if (timeout1 || timeout2 || timeout3) {
+		dev_err(hfi->dev,
+			"intf%u: HFI PANEL_INIT timed out (caps=%d timing_mode=%d generic=%d)\n",
+			intf_idx, !timeout1, !timeout2, !timeout3);
+		return -ETIMEDOUT;
+	}
+
+	if (ret)
+		return ret; /* header B send_cmd_async failure, comp1/comp3 now retired */
+
+	if (comp1.status || comp2.status || comp3.status)
+		dev_err(hfi->dev,
+			"intf%u: PANEL_INIT failed: caps=%d topology=%d generic=%d\n",
+			intf_idx, comp1.status, comp2.status, comp3.status);
+
+	return comp1.status ? comp1.status :
+	       comp2.status ? comp2.status : comp3.status;
+
+err_free_both:
+	dcp_hfi_buf_free(hfi, buf2);
+err_free_buf1:
+	dcp_hfi_buf_free(hfi, buf1);
+	return ret;
+}
+
+ssize_t dcp_hfi_dcs_transfer(struct dcp_hfi *hfi, u32 session_id,
+			     const struct mipi_dsi_msg *msg,
+			       void *tx_buf, dma_addr_t tx_iova,
+			       void *rx_buf, dma_addr_t rx_iova,
+			       u32 post_wait_ms, u32 ctrl_idx)
+{
+	struct hfi_dsi_cmd_desc cmd_desc = {};
+	static atomic_t seq_no = ATOMIC_INIT(0);
+	int ret;
+
+	if (!msg || !msg->tx_buf || !msg->tx_len)
+		return -EINVAL;
+
+	if (msg->rx_len && (!msg->rx_buf || !rx_buf))
+		return -EINVAL;
+
+	if (msg->tx_len > DCP_DSI_DCS_TX_BUF_SIZE) {
+		dev_err(hfi->dev, "DCS TX too large: %zu > %u\n",
+			msg->tx_len, DCP_DSI_DCS_TX_BUF_SIZE);
+		return -EINVAL;
+	}
+
+	memcpy(tx_buf, msg->tx_buf, msg->tx_len);
+
+	cmd_desc.size             = sizeof(cmd_desc);
+	cmd_desc.channel          = msg->channel;
+	cmd_desc.type             = msg->type;
+	cmd_desc.flags            = msg->flags;
+	cmd_desc.tx_len           = msg->tx_len;
+	cmd_desc.tx_buff_addr_lsb = lower_32_bits(tx_iova);
+	cmd_desc.tx_buff_addr_msb = upper_32_bits(tx_iova);
+	cmd_desc.ctrl_idx         = ctrl_idx;
+	cmd_desc.ctrl_flags       = DCP_DSI_CTRL_CMD_FETCH_MEMORY |
+					DCP_DSI_CTRL_CMD_LAST_COMMAND;
+	if (msg->rx_len)
+		cmd_desc.ctrl_flags |= DCP_DSI_CTRL_CMD_READ;
+	cmd_desc.last_command     = 1;
+	cmd_desc.post_wait_ms     = post_wait_ms;
+	cmd_desc.seq_no           = atomic_inc_return(&seq_no);
+
+	if (msg->rx_len > 0) {
+		if (msg->rx_len > DCP_DSI_DCS_RX_BUF_SIZE)
+			return -EINVAL;
+		memset(rx_buf, 0, msg->rx_len);
+		cmd_desc.rx_len           = msg->rx_len;
+		cmd_desc.rx_buff_addr_lsb = lower_32_bits(rx_iova);
+		cmd_desc.rx_buff_addr_msb = upper_32_bits(rx_iova);
+	}
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_TRANSFER_DCS_CMD,
+				  HFI_CMD_BUFF_DISPLAY,
+				  session_id,
+				  HFI_PAYLOAD_U32_ARRAY,
+				  &cmd_desc, sizeof(cmd_desc),
+				  HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				  HFI_TX_FLAGS_NON_DISCARDABLE,
+				  NULL, 0,
+				  DCP_HFI_TIMEOUT_DISPLAY_DCS_MS);
+	if (ret) {
+		dev_err(hfi->dev,
+			"HFI DCS_TRANSFER type=0x%x len=%zu failed: %d\n",
+			msg->type, msg->tx_len, ret);
+		return ret;
+	}
+
+	if (msg->rx_len > 0)
+		memcpy(msg->rx_buf, rx_buf, msg->rx_len);
+
+	return msg->tx_len;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_encoder.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_encoder.c
new file mode 100644
index 000000000000..c86046fbc730
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_encoder.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * HFI commands for display commits and encoder properties.
+ */
+
+#include <linux/device.h>
+
+#include "dcp_hfi_priv.h"
+#include "dcp_hfi.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_properties_display.h"
+#include "hfi/hfi_packet.h"
+
+int dcp_hfi_display_commit(struct dcp_hfi *hfi, u32 session_id)
+{
+	u32 commit_flag = HFI_COMMIT;
+	int ret;
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_FRAME_TRIGGER,
+				  HFI_CMD_BUFF_DISPLAY,
+				  session_id,
+				  HFI_PAYLOAD_U32,
+				  &commit_flag, sizeof(commit_flag),
+				  HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				  HFI_TX_FLAGS_NON_DISCARDABLE,
+				  NULL, 0,
+				  DCP_HFI_TIMEOUT_COMMIT_MS);
+	if (ret)
+		dev_err(hfi->dev, "HFI FRAME_TRIGGER(COMMIT) failed: %d\n",
+			ret);
+
+	return ret;
+}
+
+int dcp_hfi_set_display_property(struct dcp_hfi *hfi, u32 session_id,
+				 u32 prop_id, u32 value)
+{
+	u32 payload[3];
+	int ret;
+
+	payload[0] = 1;
+	payload[1] = HFI_PACK_KEY(prop_id, 0, 1);
+	payload[2] = value;
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_SET_PROPERTY,
+				  HFI_CMD_BUFF_DISPLAY,
+				  session_id,
+				  HFI_PAYLOAD_U32_ARRAY,
+				  payload, sizeof(payload),
+				  HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				  HFI_TX_FLAGS_NON_DISCARDABLE,
+				  NULL, 0,
+				  DCP_HFI_TIMEOUT_DISPLAY_MS);
+	if (ret)
+		dev_err(hfi->dev,
+			"HFI SET_PROPERTY prop=0x%x failed: %d\n",
+			prop_id, ret);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_kms.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_kms.c
new file mode 100644
index 000000000000..1246620fc6d5
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_kms.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * HFI commands for device initialization, capability parsing, and resource setup.
+ */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "dcp_hfi.h"
+#include "dcp_hfi_priv.h"
+#include "hfi/hfi_commands_device.h"
+#include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_pack_unpack_common.h"
+#include "hfi/hfi_properties_device.h"
+#include "hfi/hfi_properties_display.h"
+#include "hfi/hfi_utils.h"
+
+static void dcp_hfi_caps_cache_init(struct dcp_hfi_caps_cache *cache)
+{
+	init_completion(&cache->device_done);
+	init_completion(&cache->display_done);
+}
+
+static int dcp_hfi_caps_cache_start(struct dcp_hfi *hfi)
+{
+	struct dcp_hfi_caps_cache *cache;
+	unsigned long flags;
+
+	cache = kzalloc_obj(*cache, GFP_KERNEL);
+	if (!cache)
+		return -ENOMEM;
+
+	dcp_hfi_caps_cache_init(cache);
+
+	spin_lock_irqsave(&hfi->caps_lock, flags);
+	if (hfi->caps_cache) {
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		kfree(cache);
+		return -EBUSY;
+	}
+	hfi->caps_cache = cache;
+	spin_unlock_irqrestore(&hfi->caps_lock, flags);
+
+	return 0;
+}
+
+static struct dcp_hfi_caps_cache *dcp_hfi_caps_cache_detach(struct dcp_hfi *hfi)
+{
+	struct dcp_hfi_caps_cache *cache;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hfi->caps_lock, flags);
+	cache = hfi->caps_cache;
+	hfi->caps_cache = NULL;
+	spin_unlock_irqrestore(&hfi->caps_lock, flags);
+
+	return cache;
+}
+
+static void dcp_hfi_caps_cache_stop(struct dcp_hfi *hfi)
+{
+	kfree(dcp_hfi_caps_cache_detach(hfi));
+}
+
+int dcp_hfi_send_device_init(struct dcp_hfi *hfi)
+{
+	int ret;
+
+	mutex_lock(&hfi->caps_cache_lock);
+	ret = dcp_hfi_caps_cache_start(hfi);
+	if (ret) {
+		mutex_unlock(&hfi->caps_cache_lock);
+		return ret;
+	}
+
+	/* Payload and flags follow the HFI device-command definition. */
+	dev_dbg(hfi->dev,
+		"HFI DEVICE_INIT cmd=0x%x flags=0x%x timeout=%ums\n",
+		 HFI_COMMAND_DEVICE_INIT,
+		 HFI_TX_FLAGS_RESPONSE_REQUIRED | HFI_TX_FLAGS_NON_DISCARDABLE,
+		 DCP_HFI_TIMEOUT_INIT_MS);
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DEVICE_INIT,
+				     HFI_CMD_BUFF_DEVICE, 0,
+				     HFI_PAYLOAD_NONE, NULL, 0,
+				     HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				     HFI_TX_FLAGS_NON_DISCARDABLE,
+				     NULL, 0,
+				     DCP_HFI_TIMEOUT_INIT_MS);
+	if (ret) {
+		dev_err(hfi->dev, "HFI DEVICE_INIT failed: %d\n", ret);
+		dcp_hfi_caps_cache_stop(hfi);
+	} else {
+		dev_dbg(hfi->dev, "HFI DEVICE_INIT succeeded\n");
+	}
+
+	mutex_unlock(&hfi->caps_cache_lock);
+	return ret;
+}
+
+static void dcp_hfi_parse_init_caps_kv(struct dcp_caps *caps,
+				       u32 prop_key,
+					  const u32 *payload,
+					  u32 max_words)
+{
+	u32 prop_id = HFI_PROP_ID(prop_key);
+	u32 count, i;
+
+	if (!payload || !max_words)
+		return;
+
+	switch (prop_id) {
+	case HFI_PROPERTY_DEVICE_INIT_DCP_HW_VERSION:
+		caps->dcp_hw_rev = payload[0];
+		break;
+	case HFI_PROPERTY_DEVICE_INIT_MDSS_HW_VERSION:
+		caps->hw_rev = payload[0];
+		break;
+	case HFI_PROPERTY_DEVICE_INIT_DCP_FW_VERSION:
+		caps->fw_rev = payload[0];
+		break;
+	case HFI_PROPERTY_DEVICE_INIT_VIG_INDICES:
+		if (max_words < 1)
+			break;
+		count = payload[0];
+		if (count > max_words - 1)
+			count = max_words - 1;
+		caps->num_vig_pipes = 0;
+		caps->virt_vig_count = 0;
+		for (i = 0; i < count; i++) {
+			u32 idx = payload[1 + i];
+
+			if (DCP_REC_ID(idx) == 0) {
+				if (caps->num_vig_pipes < DCP_MAX_SSPP_COUNT)
+					caps->vig_pipe_ids[caps->num_vig_pipes++] = idx;
+			} else {
+				if (caps->virt_vig_count < DCP_MAX_SSPP_COUNT)
+					caps->vig_r1_indices[caps->virt_vig_count++] = idx;
+			}
+		}
+		break;
+	case HFI_PROPERTY_DEVICE_INIT_DMA_INDICES:
+		if (max_words < 1)
+			break;
+		count = payload[0];
+		if (count > max_words - 1)
+			count = max_words - 1;
+		caps->num_dma_pipes = 0;
+		caps->virt_dma_count = 0;
+		for (i = 0; i < count; i++) {
+			u32 idx = payload[1 + i];
+
+			if (DCP_REC_ID(idx) == 0) {
+				if (caps->num_dma_pipes < DCP_MAX_SSPP_COUNT)
+					caps->dma_pipe_ids[caps->num_dma_pipes++] = idx;
+			} else {
+				if (caps->virt_dma_count < DCP_MAX_SSPP_COUNT)
+					caps->dma_r1_indices[caps->virt_dma_count++] = idx;
+			}
+		}
+		break;
+	case HFI_PROPERTY_DEVICE_INIT_MAX_DISPLAY_COUNT:
+		caps->num_crtcs = payload[0];
+		break;
+	case HFI_PROPERTY_DEVICE_INIT_DSI_INDICES:
+		if (max_words < 1)
+			break;
+		count = min_t(u32, payload[0], DCP_MAX_BLOCKS);
+		if (count > max_words - 1)
+			count = max_words - 1;
+		caps->dsi_count = count;
+		for (i = 0; i < count; i++)
+			caps->dsi_indices[i] = payload[1 + i];
+		break;
+	case HFI_PROPERTY_DEVICE_INIT_MAX_DSI_RESOLUTION:
+		caps->max_dsi_resolution = payload[0];
+		{
+			u32 w = (payload[0] >> 16) & 0xFFFF;
+			u32 h = payload[0] & 0xFFFF;
+
+			if (w > caps->max_width)
+				caps->max_width  = w;
+			if (h > caps->max_height)
+				caps->max_height = h;
+		}
+		break;
+	case HFI_PROPERTY_DEVICE_INIT_DP_INDICES:
+		if (max_words < 1)
+			break;
+		count = min_t(u32, payload[0], DCP_MAX_BLOCKS);
+		if (count > max_words - 1)
+			count = max_words - 1;
+		caps->dp_count = count;
+		for (i = 0; i < count; i++)
+			caps->dp_indices[i] = payload[1 + i];
+		break;
+
+	case HFI_PROPERTY_DISPLAY_DYN_CLK_SUPPORT:
+
+		caps->dyn_clk_support = (payload[0] == HFI_TRUE);
+		break;
+	case HFI_PROPERTY_DEVICE_INIT_ACTIVE_LAYERS:
+		if (max_words < 1)
+			break;
+		{
+			u32 num_disp = payload[0];
+			u32 prop_sz  = 2;
+
+			if (max_words < 1 + num_disp * prop_sz)
+				break;
+			for (i = 0; i < num_disp; i++) {
+				u32 disp_id  = payload[1 + i * prop_sz];
+				u32 pipe_msk = payload[2 + i * prop_sz];
+
+				if (disp_id < DCP_MAX_DISPLAYS)
+					caps->active_pipes_mask[disp_id] = pipe_msk;
+			}
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void dcp_hfi_log_pipe_ids(struct device *dev, const char *label,
+				 const u32 *ids, u32 count)
+{
+	char buf[128];
+	int pos = 0;
+	u32 i;
+
+	for (i = 0; i < count && pos < (int)sizeof(buf) - 8; i++)
+		pos += scnprintf(buf + pos, sizeof(buf) - pos,
+				  "%s0x%x", i ? "," : "", ids[i]);
+
+	dev_dbg(dev, "%s: count=%u ids=[%s]\n", label, count, buf);
+}
+
+static int dcp_hfi_parse_kv_buf(struct dcp_hfi *hfi, struct dcp_caps *caps,
+				const u8 *buf, u32 buf_len)
+{
+	struct hfi_util_kv_parser kv_parser;
+	u32 prop_key, *prop_payload, max_words, last_read;
+	int ret;
+
+	ret = hfi_util_kv_parser_init(&kv_parser, buf_len, (u32 *)buf);
+	if (ret) {
+		dev_err(hfi->dev, "KV parser init failed: %d\n", ret);
+		return ret;
+	}
+
+	last_read = 0;
+	ret = hfi_util_kv_parser_get_next(&kv_parser, last_read,
+					  &prop_key, &prop_payload, &max_words);
+	while (!ret && prop_key) {
+		dcp_hfi_parse_init_caps_kv(caps, prop_key,
+					   prop_payload, max_words);
+		last_read = HFI_PROP_SZ(prop_key) ?: max_words;
+		ret = hfi_util_kv_parser_get_next(&kv_parser, last_read,
+						  &prop_key, &prop_payload,
+						   &max_words);
+	}
+	return ret;
+}
+
+int dcp_hfi_get_capabilities(struct dcp_hfi *hfi, struct dcp_caps *caps)
+{
+	struct dcp_hfi_caps_cache *cache;
+	int ret = 0, opt_ret;
+
+	memset(caps, 0, sizeof(*caps));
+
+	mutex_lock(&hfi->caps_cache_lock);
+	cache = hfi->caps_cache;
+	if (!cache) {
+		mutex_unlock(&hfi->caps_cache_lock);
+		return -ENODEV;
+	}
+
+	if (!wait_for_completion_timeout(&cache->device_done,
+					 msecs_to_jiffies(DCP_HFI_TIMEOUT_CAPS_MS))) {
+		dev_err(hfi->dev,
+			"DEVICE_INIT_DEVICE_CAPS timeout after %ums\n",
+			DCP_HFI_TIMEOUT_CAPS_MS);
+		ret = -ETIMEDOUT;
+		goto out_free_cache;
+	}
+
+	if (!cache->device_len) {
+		dev_err(hfi->dev, "DEVICE_INIT_DEVICE_CAPS: empty payload\n");
+		ret = -ENODATA;
+		goto out_free_cache;
+	}
+
+	ret = dcp_hfi_parse_kv_buf(hfi, caps, cache->device_buf,
+				   cache->device_len);
+	if (ret)
+		goto out_free_cache;
+
+	if (!wait_for_completion_timeout(&cache->display_done,
+					 msecs_to_jiffies(DCP_HFI_TIMEOUT_CAPS_MS))) {
+		dev_warn(hfi->dev,
+			 "DEVICE_INIT_DISPLAY_CAPS not received — dyn_clk_support unavailable\n");
+	} else if (cache->display_len > 0) {
+		opt_ret = dcp_hfi_parse_kv_buf(hfi, caps,
+					       cache->display_buf,
+					       cache->display_len);
+		if (opt_ret) {
+			dev_warn(hfi->dev,
+				 "DISPLAY_CAPS parse failed: %d (non-fatal)\n",
+				 opt_ret);
+		} else {
+			dev_dbg(hfi->dev,
+				"DISPLAY_CAPS: dyn_clk=%d\n",
+				caps->dyn_clk_support);
+		}
+	}
+	if (cache->vig_len > 0) {
+		opt_ret = dcp_hfi_parse_kv_buf(hfi, caps,
+					       cache->vig_buf,
+					       cache->vig_len);
+		if (opt_ret)
+			dev_warn(hfi->dev,
+				 "VIG_CAPS parse failed: %d (non-fatal)\n",
+				 opt_ret);
+		else
+			dcp_hfi_log_pipe_ids(hfi->dev, "VIG_CAPS",
+					     caps->vig_pipe_ids,
+					       caps->num_vig_pipes);
+	}
+
+	if (cache->dma_len > 0) {
+		opt_ret = dcp_hfi_parse_kv_buf(hfi, caps,
+					       cache->dma_buf,
+					       cache->dma_len);
+		if (opt_ret)
+			dev_warn(hfi->dev,
+				 "DMA_CAPS parse failed: %d (non-fatal)\n",
+				 opt_ret);
+		else
+			dcp_hfi_log_pipe_ids(hfi->dev, "DMA_CAPS",
+					     caps->dma_pipe_ids,
+					       caps->num_dma_pipes);
+	}
+
+	if (cache->vig_r1_len > 0) {
+		opt_ret = dcp_hfi_parse_kv_buf(hfi, caps,
+					       cache->vig_r1_buf,
+					       cache->vig_r1_len);
+		if (opt_ret)
+			dev_warn(hfi->dev,
+				 "VIG_R1_CAPS parse failed: %d (non-fatal)\n",
+				 opt_ret);
+		else
+			dcp_hfi_log_pipe_ids(hfi->dev, "VIG_R1_CAPS",
+					     caps->vig_r1_indices,
+					       caps->virt_vig_count);
+	}
+
+	if (cache->dma_r1_len > 0) {
+		opt_ret = dcp_hfi_parse_kv_buf(hfi, caps,
+					       cache->dma_r1_buf,
+					       cache->dma_r1_len);
+		if (opt_ret)
+			dev_warn(hfi->dev,
+				 "DMA_R1_CAPS parse failed: %d (non-fatal)\n",
+				 opt_ret);
+		else
+			dcp_hfi_log_pipe_ids(hfi->dev, "DMA_R1_CAPS",
+					     caps->dma_r1_indices,
+					       caps->virt_dma_count);
+	}
+
+	caps->valid = false;
+	caps->max_planes = caps->num_vig_pipes + caps->num_dma_pipes;
+	if (!caps->num_crtcs) {
+		dev_err(hfi->dev, "invalid DCP caps: zero display count\n");
+		ret = -EINVAL;
+		goto out_free_cache;
+	}
+
+	if (!caps->max_width || !caps->max_height) {
+		dev_err(hfi->dev, "invalid DCP caps: max resolution %ux%u\n",
+			caps->max_width, caps->max_height);
+		ret = -EINVAL;
+		goto out_free_cache;
+	}
+
+	if (!caps->max_planes) {
+		dev_err(hfi->dev, "invalid DCP caps: no scanout pipes\n");
+		ret = -EINVAL;
+		goto out_free_cache;
+	}
+
+	caps->valid = true;
+
+	dev_dbg(hfi->dev,
+		"DCP caps: fw=0x%x hw=0x%x dcp=0x%x disp=%u max=%ux%u vig=%u dma=%u\n",
+		 caps->fw_rev, caps->hw_rev, caps->dcp_hw_rev,
+		 caps->num_crtcs, caps->max_width, caps->max_height,
+		 caps->num_vig_pipes, caps->num_dma_pipes);
+
+out_free_cache:
+	kfree(dcp_hfi_caps_cache_detach(hfi));
+	mutex_unlock(&hfi->caps_cache_lock);
+	return ret;
+}
+
+int dcp_hfi_send_resource_register(struct dcp_hfi *hfi)
+{
+	static const u32 resource_ids[] = {
+		HFI_PROPERTY_DISPLAY_DRAM_IB,
+		HFI_PROPERTY_DISPLAY_DRAM_AB,
+		HFI_PROPERTY_DISPLAY_LLCC_IB,
+		HFI_PROPERTY_DISPLAY_LLCC_AB,
+		HFI_PROPERTY_DISPLAY_CORE_IB,
+		HFI_PROPERTY_DISPLAY_CORE_AB,
+		HFI_PROPERTY_DISPLAY_CORE_CLK,
+	};
+	u32 payload[1 + ARRAY_SIZE(resource_ids)];
+	u32 i;
+	int ret;
+
+	payload[0] = ARRAY_SIZE(resource_ids);
+	for (i = 0; i < ARRAY_SIZE(resource_ids); i++)
+		payload[1 + i] = resource_ids[i];
+
+	dev_dbg(hfi->dev, "sending HFI_COMMAND_DEVICE_RESOURCE_REGISTER (%zu resources)\n",
+		ARRAY_SIZE(resource_ids));
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DEVICE_RESOURCE_REGISTER,
+				     HFI_CMD_BUFF_DEVICE, 0,
+				     HFI_PAYLOAD_U32_ARRAY,
+				     payload, sizeof(payload),
+				     HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				     HFI_TX_FLAGS_NON_DISCARDABLE,
+				     NULL, 0,
+				     DCP_HFI_TIMEOUT_RESOURCE_REGISTER_MS);
+	if (ret)
+		dev_err(hfi->dev,
+			"HFI RESOURCE_REGISTER failed: %d\n", ret);
+	else
+		dev_dbg(hfi->dev, "HFI RESOURCE_REGISTER succeeded\n");
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_plane.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_plane.c
new file mode 100644
index 000000000000..0573634025f4
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_plane.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * HFI commands for plane properties and layer detach.
+ */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+
+#include "dcp_hfi.h"
+#include "dcp_hfi_priv.h"
+
+int dcp_hfi_submit_prop_pkt(struct dcp_hfi *hfi,
+			    const void *pkt, size_t pkt_size)
+{
+	struct dcp_hfi_buf *buf;
+
+	if (!hfi || !pkt || !pkt_size)
+		return -EINVAL;
+
+	buf = dcp_hfi_buf_alloc(hfi);
+	if (!buf) {
+		dev_err(hfi->dev, "HFI prop pkt: TX buffer pool exhausted\n");
+		return -ENOMEM;
+	}
+
+	if (pkt_size > DCP_HFI_BUF_SIZE) {
+		dev_err(hfi->dev, "HFI prop pkt too large: %zu > %d\n",
+			pkt_size, DCP_HFI_BUF_SIZE);
+		dcp_hfi_buf_free(hfi, buf);
+		return -EINVAL;
+	}
+
+	memcpy(buf->data, pkt, pkt_size);
+
+	return dcp_hfi_send_cmd_async(hfi, buf, pkt_size, NULL);
+}
+
+int dcp_hfi_plane_disable(struct dcp_hfi *hfi, u32 session_id, u32 pipe_idx)
+{
+	u32 payload[3];
+	int ret;
+
+	payload[0] = 1;
+	payload[1] = HFI_PACK_KEY(HFI_PROPERTY_DISPLAY_DETACH_LAYER, 0, 1);
+	payload[2] = pipe_idx;
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_SET_PROPERTY,
+				  HFI_CMD_BUFF_DISPLAY,
+				  session_id,
+				  HFI_PAYLOAD_U32_ARRAY,
+				  payload, sizeof(payload),
+				  HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				  HFI_TX_FLAGS_NON_DISCARDABLE,
+				  NULL, 0,
+				  DCP_HFI_TIMEOUT_DISPLAY_MS);
+	if (ret)
+		dev_warn(hfi->dev,
+			 "HFI DETACH_LAYER pipe=%u failed: %d\n",
+			 pipe_idx, ret);
+	return ret;
+}

-- 
2.43.0

