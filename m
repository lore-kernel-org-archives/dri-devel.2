Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759C606A687
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=llo93vim;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dyDNUPgl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9377510FA17;
	Thu, 26 Nov 2026 06:30:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459BA10F8EB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:30:47 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36WrZ1686624
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XTpr7J/pVVPMid7XMJXRJDpa+IDEl4bFZ8gv0AnjgYY=; b=llo93vimdbEj2dP9
 9VXj5ipedbu4sTa/joZ1eQs3QPkW6vBMy4roHRXQhQ2oPJ0mThF/tK7EhU9VsYz+
 SlHT7kKYu0bzzFRXN945uyW/kbNpUeQxYhRWyS53eqNQK5oRSR6ig4rTcodGjM39
 3BZ7arRGf5o+gNZV38JQ2aq7uK858S52z9EvsqGfbipGVqXk9yvREViGizfRB6b4
 F571ScfMoDuAMRbvNDYtfKd6NNEwpayaEZKWBQWVBMzFnO1d0gzlchDSwbdG+iAn
 Fzz9N6IIMguRNkNzIMyv+p3z5ddtnQtnrXNBaPTfNEZkPfC1dp33H84DZr6Dnj+E
 pJPN4w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j66qf9kgb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:30:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2f040c6e0ceso63073825ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674645; x=1796279445;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XTpr7J/pVVPMid7XMJXRJDpa+IDEl4bFZ8gv0AnjgYY=;
 b=dyDNUPgljoIaLkcpsUzYjFfKkdg9f6EfYtAINo0yP/z3rb+NGlFXF8afZuHlAQ4kSi
 Et8/qQKuOQ0vSNWw4K0LP7lYDOAYkMWU4B+AaUY4F80jc7MhDcAZtUtBEw5QAY4n7YgE
 O0vMp1YfF9CPSaJ3CS8Ljp93k6a691cwZsaTcII5upViv8ECNf2FikGrqDU+h6t3Y9i8
 zpA8z9GVvAbOrRbodTHR3O4DGh6qByy9osGk0EQM0fYjw3f1WmFYU0MQrEkzAFUf7mpo
 OMqHXC6j4ZKpw7D1ue5EStm++WrRsU7HjnH8cJAIDJVbV8xPtP69XwY2koH9jEIjRpHX
 7AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674645; x=1796279445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XTpr7J/pVVPMid7XMJXRJDpa+IDEl4bFZ8gv0AnjgYY=;
 b=wVb1Dy6HKjRpaoCmvKQU2489RGPRkIwzMtvBBQ0eocHmo8ZnNJlVnTULhhY/eX7mmS
 55o/kIN8T8jKScU8X+xXMWnBR8ehqIjKuJC/NA1jKH6ffc3enhDo79RPFiENDnplqc1m
 5p5tRcKwky3ZNoUBaR9XGar3IK0cXWK8p0DRaXSSuALejuR8/K4X93dhpjJXPdwtM/oU
 akf0cUcOHBUj7aI/nq+aS8LR0BqJ+1IJZ9x6q7rhQ0Xtxne2n7ybrMk6ns5XAfYmXL0A
 1EzdaeFPoTjZPs+5JHG4mxIazXn+VRzghEG6VyqiHVCE53ae4v7XdOeVcFscp1K+X45m
 mErg==
X-Forwarded-Encrypted: i=1;
 AL+hErEipSyy130KFfkyDBKU6KV6/h/tVUDxNls6DsLC1BnnP+p1R2c4rfYMDjP9C1f5N2fhuufhenKu9mk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+pBz4zyZjSkRcfbNAS7bk4z49sVHdEgedRp+Dkz+iqK+ygwH+g
 nLoAbFC68/fctc9prXlB78PYJgZQWofKaM8wtqlGVqgyQOPITePxuos7K3+rqfAIA2xynLxQlTy
 KEEP77Qna76KS3kJvAN+kUSCJ5e/U/Z+Gkg/24yDwOi5mbqDiW8c7GfsY3/OPxMHgsfbPKJQ=
X-Gm-Gg: AZFdTZdwMo0/r4gMZKzgmvftBQDNbG2W01wI9PqE0dWd8jc3BNMLgua2YyeVxQHPvx4
 On+zDL6K2JDRcdDGS+QsUpzaFvt7c3niSrgj+iUsbwLWY+rIxmBC8OmPYZtaDUxnjHzaQWfMyak
 sdjlkj3j71L0iQY07ZY0vUBYR0rrc9Tu2HsVqfmhEi/OBFufhKWv5mEm2Y/LCcQrQIYufhjIRTV
 jVA+dcQJmE4MEfrX6z9ndmxidGtfMVyIX5l6T3vZVSk0A5lg/DyRc/Xdw8sj3FG7kh23EeGiQz7
 6hHGU0VEGLyiL+bOJ+z8xGiqQeWgIrSZKeg0Ues8C2U7e2CUc6BZ6DONoMzGmUi2s2x6Vbq/jjr
 K/HAuUH/rqgLzEF3CICOIJRIn/G6jbeNugqwVFUu80gr1DyHojHicUzkgrKRM+B99GSTFRWJnvS
 9brQ2f5C2z
X-Received: by 2002:a17:902:dacc:b0:2ea:19bc:2fe2 with SMTP id
 d9443c01a7336-2f03ef59bf0mr200938305ad.10.1795674644769; 
 Wed, 25 Nov 2026 22:30:44 -0800 (PST)
X-Received: by 2002:a17:902:dacc:b0:2ea:19bc:2fe2 with SMTP id
 d9443c01a7336-2f03ef59bf0mr200937675ad.10.1795674644051; 
 Wed, 25 Nov 2026 22:30:44 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:30:43 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:17 +0530
Subject: [PATCH v3 09/21] drm/msm/dcp: Add HFI DSI and panel commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-9-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
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
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=30510;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=Pa4i5dK1uqJebhb4OH7q9E+oR7vnoLBJtY9AUBrpZOk=;
 b=p4vcoSXMTCNncG61hFEGsrIYbwNdGr57NU3fqxfbJaYgfApvlni+v+0tlb58SIO8secTqu1Zr
 WcpGEsSxc//BAXuXMKweSllYNTc9LBC77hfNc8mD8iiNfhhlRWXDdUp
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: ZlWklOm7QfKgilDz92p5-8oCD751LONP
X-Proofpoint-GUID: ZlWklOm7QfKgilDz92p5-8oCD751LONP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX2rIBIar3Ga8+
 nPKWS7QNs1XVWhiUR5gGf+QwvhKSTX4n/QW6s0lnoX52bYzVLSeHxyvXbnJDoJTi0P8bjF4vQYv
 VLbpMkuTg2bVleCvnadcI7r7/+ufamQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX7liJPNfoejAi
 i/wZbl2m6pZU8akRkShs2bsmDE0JDqxOaB3DUHJH/7OptSi1tg7Tsrx5MPb9SXfFpVX7QWRcHbV
 8TIo93qkJsSRgJx/OlhjDKlGMMGkjIsIH+ZWquKj02iisBtd6wY6C2T86om4HqmeH7Zy4V4jqeH
 zok3EobPa0R/y0Z0mtMa9gpYMNAKn5Tsl3swAg6cW5b5UXwMTBjdcLR5jlb5sjdRluIiE3k4E/U
 xEKw/7G6vsSlj3C+0fS5jnZVnnLLvdwY/n9HdKw4h2FkPk/9hW4uw7EWK+339Oq/fxuVbbuq8OK
 QrNaVOfSjh5Vf8sOsqQWZHRmqN8Vi3HaS1BpDN949ZYBbvNGi2+AUMFPFFSNrlo36Uwn81XNwzI
 JOKN/ju2SRN8iGx469x+LquGVXW8Lo84Rn9yPazoJSnPFlo7SGCJUmS0JMp1/BXoGQBT8sX9OaI
 +VnSqk7WM19ElQRJqMg==
X-Authority-Analysis: v=2.4 cv=Q5VHcI2a c=1 sm=1 tr=0 ts=6b07d216 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Um52liGsam6oDUn3MNwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024
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

Translate DSI host and panel operations into HFI commands. Firmware
owns the DSI hardware, so mode validation, display power, panel setup,
and DCS transfers must cross the HFI interface instead of accessing
controller registers from Linux.

Implement DSI mode validation, display session and power management,
panel initialization, and DCS transfer helpers while keeping them
separate from generic display commands.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile                 |   2 +
 drivers/gpu/drm/msm/dcp/dcp_dsi_config.h     |  67 +++
 drivers/gpu/drm/msm/dcp/dcp_hfi.h            |  21 +
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c        | 166 ++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_config.c | 597 +++++++++++++++++++++++++++
 5 files changed, 853 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 08edb1c38a81..6a75bec4e95e 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -74,6 +74,8 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_hfi_core.o \
 	dcp/dcp_hfi_crtc.o \
+	dcp/dcp_hfi_dsi.o \
+	dcp/dcp_hfi_dsi_config.o \
 	dcp/dcp_hfi_encoder.o \
 	dcp/dcp_hfi_kms.o \
 	dcp/dcp_hfi_plane.o \
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_config.h b/drivers/gpu/drm/msm/dcp/dcp_dsi_config.h
new file mode 100644
index 000000000000..5f2013739edf
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_config.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP DSI output configuration shared by the HFI implementation and the
+ * DRM DSI bridge.
+ */
+
+#ifndef __DCP_DSI_CONFIG_H__
+#define __DCP_DSI_CONFIG_H__
+
+#include <linux/dma-mapping.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+struct drm_dsc_config;
+
+#define DCP_DSI_MAX_PHY_TIMINGS	32
+
+/**
+ * struct dcp_dsi_hfi_config - DSI configuration passed to HFI.
+ *
+ * This contains the DSI output configuration plus mode-dependent values
+ * assembled before the HFI configuration commands are sent.
+ */
+struct dcp_dsi_hfi_config {
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
+	const struct drm_dsc_config *dsc;
+	bool dsc_rc_override; /* Send the DRM DSC rate-control ranges to HFI. */
+	u32 topology_mixer_count;
+	u32 topology_enc_count;
+	u32 topology_intf_count;
+};
+
+/* DCS buffers use IOVAs directly in the firmware command descriptor. */
+#define DCP_DSI_DCS_TX_BUF_SIZE	SZ_4K
+#define DCP_DSI_DCS_RX_BUF_SIZE	SZ_4K
+
+#endif /* __DCP_DSI_CONFIG_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi.h b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
index 2b2c92daf18f..2408fcc59d65 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_hfi.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
@@ -240,4 +240,25 @@ int dcp_hfi_get_capabilities(struct dcp_hfi *hfi, struct dcp_caps *caps);
 int dcp_hfi_set_display_property(struct dcp_hfi *hfi, u32 session_id,
 				 u32 prop_id, u32 value);
 
+struct dcp_dsi_hfi_config;
+int dcp_hfi_dsi_configure(struct dcp_hfi *hfi, u32 dsi_idx,
+			  const struct drm_display_mode *mode,
+			  const struct mipi_dsi_device *dsi,
+			  const struct dcp_dsi_hfi_config *cfg);
+int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx,
+			   u32 display_id, u32 *session_id);
+int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
+				  const struct drm_display_mode *mode,
+				  u64 clk_rate_hz);
+int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
+			     const struct drm_display_mode *mode,
+			     u64 clk_rate_hz);
+int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id);
+ssize_t dcp_hfi_dcs_transfer(struct dcp_hfi *hfi, u32 session_id,
+			     const struct mipi_dsi_msg *msg,
+			     void *tx_buf, dma_addr_t tx_iova,
+			     void *rx_buf, dma_addr_t rx_iova,
+			     u32 post_wait_ms, u32 ctrl_idx);
 #endif /* __DCP_HFI_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
new file mode 100644
index 000000000000..2f8aaca6f347
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * HFI commands for the DSI display-session lifecycle.
+ * DSI configuration and DCS transfers are implemented in dcp_hfi_dsi_config.c.
+ */
+
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
+				   const struct hfi_display_mode_info *info)
+{
+	dev_dbg(hfi->dev,
+		"HFI %s s=%u h=%u/%u/%u/%u v=%u/%u/%u/%u p=%u/%u r=%u clk=%llu sz=%u\n",
+		cmd, session_id,
+		info->h_active, info->h_back_porch, info->h_sync_width,
+		info->h_front_porch,
+		info->v_active, info->v_back_porch, info->v_sync_width,
+		info->v_front_porch,
+		info->h_sync_polarity, info->v_sync_polarity,
+		info->refresh_rate,
+		(u64)info->clk_rate_hz_lo | ((u64)info->clk_rate_hz_hi << 32),
+		info->size);
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
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_config.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_config.c
new file mode 100644
index 000000000000..8c4855334caa
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_config.c
@@ -0,0 +1,597 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * HFI commands for DSI configuration and DCS transfers.
+ * Firmware owns the DSI controller and PHY.
+ */
+
+#include <linux/device.h>
+#include <linux/math64.h>
+#include <drm/display/drm_dsc.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_mipi_dsi.h>
+
+#include "dcp_dsi_config.h"
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
+static u32 dcp_dsi_traffic_mode(const struct mipi_dsi_device *dsi)
+{
+	if (!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO))
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
+	u32 mask = HFI_PANEL_LANE_0;
+
+	if (num_lanes >= 2)
+		mask |= HFI_PANEL_LANE_1;
+	if (num_lanes >= 3)
+		mask |= HFI_PANEL_LANE_2;
+	if (num_lanes >= 4)
+		mask |= HFI_PANEL_LANE_3;
+
+	return mask;
+}
+
+static bool dcp_hfi_dsi_wait(struct dcp_hfi *hfi,
+			     struct dcp_hfi_completion *comp)
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
+int dcp_hfi_dsi_configure(struct dcp_hfi *hfi, u32 dsi_idx,
+			  const struct drm_display_mode *mode,
+			  const struct mipi_dsi_device *dsi,
+			  const struct dcp_dsi_hfi_config *cfg)
+{
+	u32 bllp_eof, bllp_pwr, dma_trig, esd_mode, lane_map, num_phys;
+	u32 display_type, link_bpp_x16, traffic_mode, vsync_source;
+	struct dcp_hfi_completion comp1, comp2, comp3;
+	struct hfi_header_info hdr_info1, hdr_info2;
+	u32 num_ctrls, num_lanes, num_props;
+	u32 dma_win, payload[128], wr_cont;
+	struct hfi_cmd_buff_hdl hdl1, hdl2;
+	bool timeout1, timeout2, timeout3;
+	u32 phy_type, str_trig, wr_start;
+	struct hfi_packet_info pkt_info;
+	struct dcp_hfi_buf *buf1, *buf2;
+	u32 packet_id2, packet_id3;
+	bool cphy, lp11, ulps;
+	bool is_cmd_mode;
+	u32 packet_id;
+	u32 color_ord;
+	int bpp, ret;
+	bool tx_eot;
+	u32 te_dcs;
+	u64 clk_hz;
+	u32 vc_id;
+	u32 *p;
+
+	if (cfg->num_ctrls > ARRAY_SIZE(cfg->ctrl_indices) ||
+	    cfg->num_phys > ARRAY_SIZE(cfg->phy_indices))
+		return -EINVAL;
+
+	display_type = cfg->display_type;
+	vsync_source = cfg->vsync_source;
+	phy_type = cfg->phy_type;
+	num_lanes = dsi->lanes;
+	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
+	if (bpp < 0)
+		return -EINVAL;
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
+	hdr_info1.object_id     = dsi_idx;
+	hdr_info1.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl1, &hdr_info1);
+	if (ret) {
+		dev_err(hfi->dev, "PANEL_INIT: hfi_create_header (A) failed: %d\n",
+			ret);
+		goto err_free_buf1;
+	}
+
+	num_props = 0;
+
+	p = payload + 1;
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_TIMING_MODE_COUNT, 1);
+
+	/* DCS TX buffer is described by both DVA and IOVA properties. */
+	if (cfg->dcs_tx_iova && cfg->dcs_tx_dva &&
+	    !(cfg->dcs_tx_iova & 0x3ff) && !(cfg->dcs_tx_dva & 0x3ff)) {
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_DVA,
+			       lower_32_bits(cfg->dcs_tx_dva),
+			       upper_32_bits(cfg->dcs_tx_dva),
+			       cfg->dcs_tx_buf_size, 0, 0);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_IOVA,
+			       lower_32_bits(cfg->dcs_tx_iova),
+			       upper_32_bits(cfg->dcs_tx_iova),
+			       cfg->dcs_tx_buf_size, 0, 0);
+	}
+	payload[0] = num_props;
+
+	packet_id = dcp_hfi_next_packet_id(hfi);
+	pkt_info.cmd          = HFI_COMMAND_PANEL_INIT_PANEL_CAPS;
+	pkt_info.id           = dsi_idx & 0xFFFF;
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
+		"dsi%u: DCP mode %dx%d@%dHz clk=%ukHz ht=%u hs=%u/%u vt=%u vs=%u/%u f=0x%x\n",
+		dsi_idx, mode->hdisplay, mode->vdisplay,
+		drm_mode_vrefresh(mode), mode->clock,
+		mode->htotal, mode->hsync_start, mode->hsync_end,
+		mode->vtotal, mode->vsync_start, mode->vsync_end,
+		mode->flags);
+
+	te_dcs = cfg->te_dcs_command;
+	dma_trig = cfg->dma_trigger;
+	str_trig = cfg->stream_trigger;
+	wr_start = cfg->wr_mem_start;
+	wr_cont = cfg->wr_mem_continue;
+	lane_map = cfg->lane_map;
+	color_ord = cfg->color_order;
+	vc_id = dsi->channel;
+	esd_mode = cfg->esd_mode;
+	dma_win = cfg->dma_sched_window;
+	lp11 = cfg->lp11_init;
+	cphy = cfg->cphy_mode;
+	ulps = cfg->ulps_supported;
+	tx_eot = !(dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET);
+	bllp_eof = cfg->bllp_eof_power_mode;
+	bllp_pwr = cfg->bllp_power_mode;
+	num_ctrls = cfg->num_ctrls;
+	num_phys = cfg->num_phys;
+	num_props = 0;
+
+	p = payload + 1;
+
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_PHYSICAL_TYPE, phy_type);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_BPP, dcp_bpp_to_hfi(bpp));
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_LANES_STATE,
+		       dcp_lanes_to_hfi(num_lanes));
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_OPERATING_MODE,
+		       is_cmd_mode ? HFI_PANEL_CMD_MODE_8_BIT :
+		       HFI_PANEL_VIDEO_MODE_8_BIT);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_DISPLAY_TYPE, display_type);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_VSYNC_SOURCE, vsync_source);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_TRAFFIC_MODE, traffic_mode);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_TE_DCS_COMMAND, te_dcs);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_DMA_TRIGGER, dma_trig);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_STREAM_TRIGGER, str_trig);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_WR_MEM_START, wr_start);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_WR_MEM_CONTINUE, wr_cont);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_LP11_INIT, lp11 ? HFI_TRUE : HFI_FALSE);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_CPHY_MODE, cphy ? HFI_TRUE : HFI_FALSE);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_ULPS_SUPPORTED,
+		       ulps ? HFI_TRUE : HFI_FALSE);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_TX_EOT_APPEND,
+		       tx_eot ? HFI_TRUE : HFI_FALSE);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_BLLP_EOF_POWER_MODE,
+		       bllp_eof ? HFI_TRUE : HFI_FALSE);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_BLLP_POWER_MODE,
+		       bllp_pwr ? HFI_TRUE : HFI_FALSE);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_COLOR_ORDER, color_ord);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_VIRTUAL_CHANNEL_ID, vc_id);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_LANE_MAP, lane_map);
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_ESD_CONFIG,
+		       10 * sizeof(u32), esd_mode,
+		       0, 0, 0, 0, 0, 0, 0, 0);
+
+	num_props++;
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_CTRL_NUM, 0, 1 + num_ctrls);
+	*p++ = num_ctrls;
+	memcpy(p, cfg->ctrl_indices, num_ctrls * sizeof(*p));
+	p += num_ctrls;
+
+	num_props++;
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_PHY_NUM, 0, 1 + num_phys);
+	*p++ = num_phys;
+	memcpy(p, cfg->phy_indices, num_phys * sizeof(*p));
+	p += num_phys;
+
+	num_props++;
+	p += HFI_PACK(p, HFI_PROPERTY_PANEL_DMA_SCHEDULE_WINDOW, dma_win);
+	payload[0] = num_props;
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
+	hdr_info2.object_id     = dsi_idx;
+	hdr_info2.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl2, &hdr_info2);
+	if (ret) {
+		dev_err(hfi->dev, "PANEL_INIT: hfi_create_header (B) failed: %d\n",
+			ret);
+		goto err_free_both;
+	}
+
+	num_props = 7; /* timing properties; PHY and DSC are optional. */
+
+	if (cfg->dsc)
+		num_props++;
+	if (cfg->dsc && cfg->dsc_rc_override)
+		num_props++;
+	if (cfg->num_phy_timings)
+		num_props++;
+	p = payload;
+	*p++ = num_props;
+	p = payload + 1;
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_INDEX, 0, 1);
+	*p++ = 0;
+
+	/* HFI PANEL_CLOCKRATE carries the selected DSI bit clock per lane. */
+	if (cfg->dsc && cfg->dsc->bits_per_pixel)
+		link_bpp_x16 = cfg->dsc->bits_per_pixel;
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
+	if (cfg->dsc) {
+		u32 chroma_format = 0;
+		u32 color_space = 0;
+
+		if (cfg->dsc->native_422)
+			chroma_format = 1;
+		else if (cfg->dsc->native_420)
+			chroma_format = 2;
+		if (cfg->dsc->native_422 || cfg->dsc->native_420)
+			color_space = 1;
+
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_COMPRESSION_DATA, 0, 12);
+		*p++ = HFI_PANEL_COMPRESSION_DSC;
+		*p++ = (cfg->dsc->dsc_version_major << 4) |
+			cfg->dsc->dsc_version_minor;
+		*p++ = 0; /* scr_version is not set by DRM DSC config. */
+		*p++ = cfg->dsc->slice_height;
+		*p++ = cfg->dsc->slice_width;
+		*p++ = 1; /* one slice per packet */
+		*p++ = cfg->dsc->bits_per_component;
+		*p++ = 0; /* no post-PPS delay */
+		*p++ = cfg->dsc->bits_per_pixel;
+		*p++ = chroma_format;
+		*p++ = color_space;
+		*p++ = cfg->dsc->block_pred_enable;
+	}
+
+	if (cfg->dsc && cfg->dsc_rc_override) {
+		struct hfi_panel_compression_rc_override rc_override = {};
+
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(rc_override.min_qp); i++) {
+			rc_override.min_qp[i] = cfg->dsc->rc_range_params[i].range_min_qp;
+			rc_override.max_qp[i] = cfg->dsc->rc_range_params[i].range_max_qp;
+			rc_override.offsets[i] = cfg->dsc->rc_range_params[i].range_bpg_offset;
+		}
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
+			"dsi%u: PANEL_INIT: failed to register GENERIC_CAPS completion: %d\n",
+			dsi_idx, ret);
+		goto err_free_both;
+	}
+
+	ret = dcp_hfi_send_cmd_async(hfi, buf1,
+				     hfi_get_header_size(&hdl1), &comp1);
+	if (ret) {
+		dev_err(hfi->dev,
+			"dsi%u: PANEL_INIT caps/generic (header A) failed\n",
+			dsi_idx);
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
+			"dsi%u: HFI_COMMAND_PANEL_INIT_TIMING_MODE_CAPS (header B) failed\n",
+			dsi_idx);
+		comp2.packet_id = 0; /* never registered/in-flight, nothing to wait on */
+	}
+
+	timeout1 = dcp_hfi_dsi_wait(hfi, &comp1);
+	timeout3 = dcp_hfi_dsi_wait(hfi, &comp3);
+	if (comp2.packet_id)
+		timeout2 = dcp_hfi_dsi_wait(hfi, &comp2);
+	else
+		timeout2 = false;
+
+	if (timeout1 || timeout2 || timeout3) {
+		dev_err(hfi->dev,
+			"dsi%u: HFI PANEL_INIT timed out (caps=%d timing_mode=%d generic=%d)\n",
+			dsi_idx, !timeout1, !timeout2, !timeout3);
+		return -ETIMEDOUT;
+	}
+
+	if (ret)
+		return ret; /* header B send_cmd_async failure, comp1/comp3 now retired */
+
+	if (comp1.status || comp2.status || comp3.status)
+		dev_err(hfi->dev,
+			"dsi%u: PANEL_INIT failed: caps=%d topology=%d generic=%d\n",
+			dsi_idx, comp1.status, comp2.status, comp3.status);
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
+			     void *tx_buf, dma_addr_t tx_iova,
+			     void *rx_buf, dma_addr_t rx_iova,
+			     u32 post_wait_ms, u32 ctrl_idx)
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
+				HFI_CMD_BUFF_DISPLAY,
+				session_id,
+				HFI_PAYLOAD_U32_ARRAY,
+				&cmd_desc, sizeof(cmd_desc),
+				HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				HFI_TX_FLAGS_NON_DISCARDABLE,
+				NULL, 0,
+				DCP_HFI_TIMEOUT_DISPLAY_DCS_MS);
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

-- 
2.43.0

