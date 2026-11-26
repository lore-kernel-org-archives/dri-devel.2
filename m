Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149A5606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N1Ypx5q7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GnOvZTZG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B2710FB90;
	Thu, 26 Nov 2026 06:31:42 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DB410FABE
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:30 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36RlH1686567
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 brD9nw0ilc6503CppAQfV6J/WFW3BjEKuOowfoV0NJY=; b=N1Ypx5q73qg54LHV
 KWFjjgW8Jo5d93cftQXdROuFyVDoGjX/FDdi+8yjRzjQ4qAske4QhGAqZBlTDdD+
 vqlEnuDQaW30jMVae/OoSRW+MHvKXohJkBPRZA4ZRBCTASj/mD6+DuCerMYIc6rK
 MWKjjp5kt/2JwnOwI5ZBX7u+odTksyMNSMkB0kMDxhqePRh/GP01Y10MwAdKZb8Z
 cVQjk7Sg8Av+OQpTObXqLPXXn9Rz9dgWneHvu6f7goBY/QNt5lv+iK4G8eyQc8L7
 zw/Wnokq6QVdIEGzgGvSy9SKvt8pxHjtwgFrtp2mt6NV6X1G4/O2En9nJczny/po
 GZLgjg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j66qf9knh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd652c0385bso4536460a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674688; x=1796279488;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=brD9nw0ilc6503CppAQfV6J/WFW3BjEKuOowfoV0NJY=;
 b=GnOvZTZGdwSh70b5wbxvbhO2IU89bDgV4KQstWNuGoXVmtAaNeHFKhic7eOre9R/D/
 lGP6jczKK795pNkPGJQZ5ndTKs/hnSEhOjaIFtelIV1PhgZa6Dx4keHa4dIVyR+93rJ8
 ZI7fhaY9gUwECpQ3aYEdBWs5g940eW6xI9icoYxPDNgtP1lgVyKHibq75+zxWbDSSUhd
 6jhXkRB3bhEma0o/3WGAUcAWiUmdVBBKXsH3VcrEZKS3ADZztHtA1DJPM94pcF5FyW6+
 fEpVZ7eSThGjvwK85DgngcLxYR1Pwuci73PIDSVapMu1RZNo+qvk/6ss0/uza2TXf/fU
 NH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674688; x=1796279488;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=brD9nw0ilc6503CppAQfV6J/WFW3BjEKuOowfoV0NJY=;
 b=pZ/QlK+AFQMCXmKDtzSVxDlo2HnZrEecs/Tj/8ZQxfrRaktvrL66AIsyyEpL87L37H
 p8SSQ7UJHdg6Yet+oya5GN+6sKVNwTDCwfmdYWyTpmQWrC23w+XHd2Ium0Zkjkkswp7D
 v8J88aC+dssW8lolc7MgJMzyuruzSePz45+fXRfpsAchByE2QDA35ct4wHXsL+SjtTx/
 zs6afsJ8q3+G9YZX5xFQLB8l+vOStV49Q/69gwgkIm/Qtt0NSHQSzrSMapafAMBF4b+S
 HydF5wEvlz61W/rop1Qj1+CRn+Y3KrURjG43gIPHLacNI0psOS8qBN8W+87P2JUFiUgN
 dAVw==
X-Forwarded-Encrypted: i=1;
 AL+hErEBp5Kjqu6lJptsx6r+hNlXArocuzKf6//gBk3gQPvOPN5Qs+UO2+kavYgJ4Ni0bURL6FggxMRHefo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/pEgPAWtMjLk548w8Z5Itw92UYp/9zdOId7hLoWh/QZairi3mK
 GZzcn+FZHvwhRjPQ9iPf/bITcEn22S3R6ZNMYI2/FzdrBZknhtniV4Lvmia9kjxseSO7TYeoZVt
 7iTn4XluVXmobzpbdP3udylNE9Lh7enz0FpCf50JGsngpuDJ6BHs8aZilQHoGuyuU05yqSwY=
X-Gm-Gg: AZFdTZcV8BTMakfPZW7Qs9qokJqkN1I/ujXIofDvqj+WMeX0tJY2F7kUEXWhHYz02I2
 AMMlli/aOHbdWi6+AoKpewcNDcf37wCxtuCImnL5SrwqD4/8P378gGl/HwL1Nq9QZtJO9rOnNg6
 m0eNZhSNO1/cJgOnOhfKEcCsfJCM8XaOCFEPgnvSYYtm4wy3AKPE5O0IrLsKU2+dqPseXYXurM8
 TIAt1nsGPN2Qxqo1vZSzen/noHA/3k4l/8KkzA+Mn14oEPwyTxdIeK4Fn0rMcECABi67t5dxXwr
 T0Y+OevWYK7kPznhqPo2VmUCImuo9GKmPDlSm7joiwTxzDZYRnrHteXUTjceV2BbCXtleZkJHXC
 VxSLunmlNwtMixrERToQ/66t90b3jswny+L9k9LB6TaFjURWCAEoT0PkaS4fXBX2CV4hfVRWwJm
 hy+lhU46Pt
X-Received: by 2002:a17:903:298d:b0:2e9:740c:36c with SMTP id
 d9443c01a7336-2f03f1ba67amr197849125ad.41.1795674687650; 
 Wed, 25 Nov 2026 22:31:27 -0800 (PST)
X-Received: by 2002:a17:903:298d:b0:2e9:740c:36c with SMTP id
 d9443c01a7336-2f03f1ba67amr197848865ad.41.1795674687077; 
 Wed, 25 Nov 2026 22:31:27 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:31:26 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:22 +0530
Subject: [PATCH v3 14/21] drm/msm/dcp: Add DCP DSI host and panel support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-14-f1e9d7505039@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=33319;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=/zEevJXsy+DU0YoeFW9Xf2/jnFcFfm6mhSRQfmzfkcQ=;
 b=XXO5th7YIhjFmLPc+Q3ookPMGhsGzPR7lO8sY4AQ+NqJUJ3TtCUkp15tWcfxcqBLoSDGqYOnC
 0zJYtGtFYRvBtU4fyUj3+VAu+ZkZHi5uAjl5GbfeMGzTiVqVZtfGADW
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: 77IP8fXHAOZXu4M6du35OsKf7DxYtCld
X-Proofpoint-GUID: 77IP8fXHAOZXu4M6du35OsKf7DxYtCld
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX+RpMdwl7XekF
 Yvmdsv0PWtWEKL4qg591RZxqXGpdB9c3kIrfa7PzzYNTBbjOpOTKaYwiK9//LkhmkxSX+llfrmx
 O5vDr2Fa2uPAPEYbP/imxZuhQ7QZIyI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXzcmJp6/H5DHu
 3eObcIcCvfS5dTo9B+82PVXpl0NtFAoQaqTQOwpb3hfxeJ6EMMSufnJut9kq0aSM/iMdtLB5jJK
 5y4JHm/1yLeBedfDsKEt5pQGpGvAYRgRvQNuSndwMKVgzr88UAImGOetclvnhbE5BsLinhfFFjy
 s6AVkM41AUVbu407DLfVJ/fcDvmtw4W4RMSyGyH67eI7wCuY5NYWyyZOADbELnk1TMzoVfCeTsq
 q0P3xnw0/iuVMPrRE/yneYH9HcKKsqDNte2eW0eVsSSC++hZnCEXGLBghVwhu3EPoAVu/ibITuv
 PdM4JPJYKo3HlMoeFqMyLIaoROyUPRfeasdBgT06ze/21/Y5etcn5zFXgaDYFrk1P7xa43uQUG/
 GMoVkxB9TBU7Y0W5LYcjptR6gXH8CgT9yKfXH3qhHloOxnF6wFvIDj0HsN7vrukKrHLoiFKalRU
 +/Ht/9lPnLsITIRRcBg==
X-Authority-Analysis: v=2.4 cv=Q5VHcI2a c=1 sm=1 tr=0 ts=6b07d241 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1v3qjqEwVcn8E8YlUJEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
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

Expose the DCP DSI host and panel as DRM-facing objects. The DCP
display path needs a host, panel configuration, bridge state, DSC
setup, DCS transfer buffers, and panel lifetime management before it
can drive a physical display.

Implement the MIPI DSI host, panel-device support, bridge state,
DSC configuration, DCS transfers, and DSI buffer management.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile             |   1 +
 drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c | 988 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h |  71 +++
 3 files changed, 1060 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 7fc4861d19df..5910891d75f9 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -75,6 +75,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_crtc.o \
 	dcp/dcp_dpu_kms.o \
 	dcp/dcp_plane.o \
+	dcp/dcp_dsi_bridge.o \
 	dcp/dcp_hfi_core.o \
 	dcp/dcp_hfi_crtc.o \
 	dcp/dcp_hfi_dsi.o \
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c b/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c
new file mode 100644
index 000000000000..93d545a558da
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c
@@ -0,0 +1,988 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP DSI bridge driver.
+ *
+ * Implements a DRM bridge for DSI displays in the DCP firmware-delegated
+ * architecture. DCP firmware owns the DSI PHY and controller; this driver
+ * uses HFI commands to configure DSI parameters rather than direct register
+ * writes.
+ */
+
+#include <linux/component.h>
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include <drm/display/drm_dsc.h>
+#include <drm/display/drm_dsc_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_of.h>
+
+#include <video/mipi_display.h>
+
+#include "dcp_crtc.h"
+#include "dcp_dsi_bridge.h"
+#include "dcp_dpu_kms.h"
+#include "dcp_hfi.h"
+#include "hfi/hfi_defs_panel.h"
+
+struct dcp_dsi_topology_state {
+	u32 topology_mixer_count;
+	u32 topology_enc_count;
+	u32 topology_intf_count;
+};
+
+struct dcp_dsi_bridge_state {
+	struct drm_bridge_state base;
+	struct dcp_dsi_topology_state topology;
+	struct drm_dsc_config dsc;
+	int prepare_error;
+};
+
+#define to_dcp_dsi_bridge_state(s) \
+	container_of(s, struct dcp_dsi_bridge_state, base)
+
+static struct dcp_dsi_bridge_state *
+dcp_dsi_bridge_get_state(struct dcp_dsi_bridge *bridge)
+{
+	return to_dcp_dsi_bridge_state(drm_priv_to_bridge_state(bridge->bridge.base.state));
+}
+
+static struct drm_bridge_state *
+dcp_dsi_bridge_atomic_create_state(struct drm_bridge *bridge)
+{
+	struct dcp_dsi_bridge_state *state;
+	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_bridge_state_init(&state->base, bridge);
+	state->topology.topology_mixer_count =
+		dsi_bridge->hfi_config.topology_mixer_count;
+	state->topology.topology_enc_count =
+		dsi_bridge->hfi_config.topology_enc_count;
+	state->topology.topology_intf_count =
+		dsi_bridge->hfi_config.topology_intf_count;
+	if (dsi_bridge->dsi_device && dsi_bridge->dsi_device->dsc)
+		state->dsc = *dsi_bridge->dsi_device->dsc;
+
+	return &state->base;
+}
+
+static struct drm_bridge_state *
+dcp_dsi_bridge_atomic_duplicate_state(struct drm_bridge *bridge)
+{
+	struct dcp_dsi_bridge_state *state, *old_state;
+
+	if (WARN_ON(!bridge->base.state))
+		return NULL;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return NULL;
+
+	old_state = to_dcp_dsi_bridge_state(drm_priv_to_bridge_state(bridge->base.state));
+	__drm_atomic_helper_bridge_duplicate_state(bridge, &state->base);
+	state->topology = old_state->topology;
+	state->dsc = old_state->dsc;
+	return &state->base;
+}
+
+static void dcp_dsi_bridge_atomic_destroy_state(struct drm_bridge *bridge,
+						struct drm_bridge_state *bridge_state)
+{
+	kfree(to_dcp_dsi_bridge_state(bridge_state));
+}
+
+static void
+dcp_dsi_bridge_build_hfi_config(struct dcp_dsi_bridge *dsi_bridge,
+				const struct dcp_dsi_bridge_state *state,
+				struct dcp_dsi_hfi_config *cfg)
+{
+	*cfg = dsi_bridge->hfi_config;
+	cfg->topology_mixer_count = state->topology.topology_mixer_count;
+	cfg->topology_enc_count = state->topology.topology_enc_count;
+	cfg->topology_intf_count = state->topology.topology_intf_count;
+	cfg->dsc = dsi_bridge->dsi_device && dsi_bridge->dsi_device->dsc ?
+		&state->dsc : NULL;
+}
+
+static void dcp_dsi_host_dev_release(struct device *dev)
+{
+	of_node_put(dev->of_node);
+}
+
+static bool dcp_dsi_bridge_cmd_mode(const struct dcp_dsi_bridge *dsi_bridge)
+{
+	return dsi_bridge->dsi_device &&
+		!(dsi_bridge->dsi_device->mode_flags & MIPI_DSI_MODE_VIDEO);
+}
+
+static u64 dcp_dsi_link_clock(const struct dcp_dsi_bridge *dsi_bridge,
+			      const struct dcp_dsi_hfi_config *cfg,
+			      const struct drm_display_mode *mode)
+{
+	const struct mipi_dsi_device *dsi = dsi_bridge->dsi_device;
+	int bpp;
+	u32 bpp_x16;
+
+	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
+	if (bpp < 0)
+		return 0;
+
+	bpp_x16 = cfg->dsc && cfg->dsc->bits_per_pixel ?
+		cfg->dsc->bits_per_pixel : bpp << 4;
+
+	if (dsi->hs_rate)
+		return dsi->hs_rate;
+
+	return div_u64((u64)mode->clock * 1000 * bpp_x16, dsi->lanes * 16);
+}
+
+static const struct component_ops dcp_dsi_component_ops;
+
+static int dcp_dsi_host_attach(struct mipi_dsi_host *host,
+			       struct mipi_dsi_device *dsi)
+{
+	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_host(host);
+	int ret;
+
+	if (!dsi->lanes || dsi->lanes > 4)
+		return -EINVAL;
+
+	switch (dsi->format) {
+	case MIPI_DSI_FMT_RGB888:
+	case MIPI_DSI_FMT_RGB666:
+	case MIPI_DSI_FMT_RGB666_PACKED:
+	case MIPI_DSI_FMT_RGB565:
+	case MIPI_DSI_FMT_RGB101010:
+		break;
+	default:
+		dev_err(&dsi->dev, "unsupported pixel format %u\n", dsi->format);
+		return -EINVAL;
+	}
+
+	dsi_bridge->dsi_device = dsi;
+
+	ret = component_add(&dsi_bridge->dsi_host_dev,
+			    &dcp_dsi_component_ops);
+	if (ret) {
+		/* MIPI DSI detach is not called when attach fails. */
+		dsi_bridge->dsi_device = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dcp_dsi_host_detach(struct mipi_dsi_host *host,
+			       struct mipi_dsi_device *dsi)
+{
+	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_host(host);
+
+	component_del(&dsi_bridge->dsi_host_dev, &dcp_dsi_component_ops);
+	dsi_bridge->dsi_device = NULL;
+	return 0;
+}
+
+static ssize_t dcp_dsi_host_transfer(struct mipi_dsi_host *host,
+				     const struct mipi_dsi_msg *msg)
+{
+	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_host(host);
+	struct dcp_dpu_kms *kms = dsi_bridge->kms;
+	u32 session_id;
+	bool temporary_session = false;
+	ssize_t ret;
+
+	guard(mutex)(&dsi_bridge->session_lock);
+	if (!dsi_bridge->dcs_tx_buf)
+		return -ENODEV;
+
+	/* Serialize DCS transfers */
+	guard(mutex)(&dsi_bridge->dcs_lock);
+
+	if (dsi_bridge->session_open) {
+		session_id = dsi_bridge->session_id;
+	} else {
+		/*
+		 * mipi_dsi_host_ops::transfer() may be called while the host is
+		 * disabled. Open a transaction-only DCP session in that case;
+		 * atomic_pre_enable() will create the full display session later.
+		 */
+		ret = dcp_hfi_display_enable(kms->hfi, dsi_bridge->intf_idx,
+					     dsi_bridge->fw_display_id,
+					     &session_id);
+		if (ret)
+			return ret;
+
+		temporary_session = true;
+	}
+
+	ret = dcp_hfi_dcs_transfer(kms->hfi, session_id, msg,
+				   dsi_bridge->dcs_tx_buf, dsi_bridge->dcs_tx_iova,
+				   dsi_bridge->dcs_rx_buf, dsi_bridge->dcs_rx_iova, 0,
+				   dsi_bridge->hfi_config.ctrl_indices[0]);
+	if (temporary_session) {
+		int cleanup_ret = dcp_hfi_display_disable(kms->hfi, session_id);
+
+		if (!cleanup_ret)
+			cleanup_ret = dcp_hfi_display_post_disable(kms->hfi, session_id);
+
+		if (ret >= 0 && cleanup_ret)
+			ret = cleanup_ret;
+	}
+	if (ret < 0)
+		dev_warn(kms->pm_dev,
+			 "INTF%u: live DCS command transfer failed: %zd\n",
+			 dsi_bridge->intf_idx, ret);
+
+	return ret;
+}
+
+static int dcp_dsi_component_bind(struct device *dev,
+				  struct device *master, void *data)
+{
+	struct dcp_dsi_bridge *dsi_bridge =
+		container_of(dev, struct dcp_dsi_bridge, dsi_host_dev);
+
+	dsi_bridge->downstream_bridge =
+		devm_drm_of_get_bridge(dev, dsi_bridge->dcp_np,
+				       dsi_bridge->intf_idx, 0);
+	if (IS_ERR(dsi_bridge->downstream_bridge)) {
+		int ret = PTR_ERR(dsi_bridge->downstream_bridge);
+
+		dsi_bridge->downstream_bridge = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void dcp_dsi_component_unbind(struct device *dev,
+				     struct device *master, void *data)
+{
+	struct dcp_dsi_bridge *dsi_bridge =
+		container_of(dev, struct dcp_dsi_bridge, dsi_host_dev);
+
+	dsi_bridge->downstream_bridge = NULL;
+}
+
+static const struct component_ops dcp_dsi_component_ops = {
+	.bind = dcp_dsi_component_bind,
+	.unbind = dcp_dsi_component_unbind,
+};
+
+static const struct mipi_dsi_host_ops dcp_dsi_host_ops = {
+	.attach   = dcp_dsi_host_attach,
+	.detach   = dcp_dsi_host_detach,
+	.transfer = dcp_dsi_host_transfer,
+};
+
+static int dcp_dsi_bridge_attach(struct drm_bridge *bridge,
+				 struct drm_encoder *encoder,
+				 enum drm_bridge_attach_flags flags)
+{
+	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
+	struct drm_bridge *downstream_bridge;
+	int ret;
+
+	downstream_bridge = dsi_bridge->downstream_bridge;
+	if (!downstream_bridge)
+		return -EPROBE_DEFER;
+
+	ret = drm_bridge_attach(encoder, downstream_bridge, bridge, flags);
+	if (ret) {
+		drm_err(bridge->dev,
+			"INTF%u: downstream bridge attach failed: %d\n",
+			dsi_bridge->intf_idx, ret);
+		return ret;
+	}
+
+	drm_dbg_driver(dsi_bridge->kms->dev,
+		       "INTF%u: downstream bridge attached\n",
+		       dsi_bridge->intf_idx);
+
+	return 0;
+}
+
+static u32 dcp_dsi_bridge_get_mixer_count(const struct dcp_dsi_hfi_config *cfg,
+					  const struct drm_display_mode *mode)
+{
+	u32 mixer_count = cfg->topology_mixer_count;
+
+	if (!mixer_count)
+		mixer_count = 1;
+
+	if (cfg->dsc) {
+		const struct drm_dsc_config *dsc = cfg->dsc;
+
+		if (dsc->slice_count)
+			mixer_count = dsc->slice_count;
+		else if (dsc->slice_width && mode->hdisplay)
+			mixer_count = DIV_ROUND_UP(mode->hdisplay,
+						   dsc->slice_width);
+	}
+
+	return mixer_count;
+}
+
+static void dcp_dsi_bridge_publish_session(struct dcp_dsi_bridge *dsi_bridge)
+{
+	struct dcp_dpu_kms *kms = dsi_bridge->kms;
+	struct drm_crtc *crtc;
+
+	crtc = dcp_dpu_kms_get_crtc(kms, dsi_bridge->fw_display_id);
+	if (crtc)
+		dcp_crtc_set_session(crtc, dsi_bridge->session_id);
+	else
+		drm_err(kms->dev, "INTF%u: no CRTC for session %u\n",
+			dsi_bridge->intf_idx, dsi_bridge->session_id);
+}
+
+static void dcp_dsi_bridge_clear_session(struct dcp_dsi_bridge *dsi_bridge)
+{
+	struct drm_crtc *crtc;
+
+	crtc = dcp_dpu_kms_get_crtc(dsi_bridge->kms, dsi_bridge->fw_display_id);
+	if (crtc)
+		dcp_crtc_clear_session(crtc);
+}
+
+static int dcp_dsi_bridge_setup_dsc(struct drm_dsc_config *dsc,
+				    const struct drm_display_mode *mode)
+{
+	enum drm_dsc_params_type params_type;
+	int ret;
+
+	dsc->pic_width = mode->hdisplay;
+	dsc->pic_height = mode->vdisplay;
+	dsc->convert_rgb = !dsc->native_422 && !dsc->native_420;
+	dsc->slice_chunk_size = DIV_ROUND_UP(dsc->slice_width *
+					dsc->bits_per_pixel, 8 * 16);
+	dsc->simple_422 = 0;
+	dsc->vbr_enable = 0;
+
+	if (dsc->dsc_version_major != 1)
+		return -EOPNOTSUPP;
+
+	switch (dsc->dsc_version_minor) {
+	case 1:
+		if (dsc->native_422 || dsc->native_420)
+			return -EOPNOTSUPP;
+		params_type = DRM_DSC_1_1_PRE_SCR;
+		break;
+	case 2:
+		if (dsc->native_422)
+			params_type = DRM_DSC_1_2_422;
+		else if (dsc->native_420)
+			params_type = DRM_DSC_1_2_420;
+		else
+			params_type = DRM_DSC_1_2_444;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	drm_dsc_set_const_params(dsc);
+	drm_dsc_set_rc_buf_thresh(dsc);
+	ret = drm_dsc_setup_rc_params(dsc, params_type);
+	if (ret)
+		return ret;
+
+	dsc->initial_scale_value = drm_dsc_initial_scale_value(dsc);
+	dsc->line_buf_depth = dsc->bits_per_component + 1;
+	ret = drm_dsc_compute_rc_parameters(dsc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int dcp_dsi_bridge_prepare_session(struct dcp_dsi_bridge *dsi_bridge,
+				   const struct drm_display_mode *mode)
+{
+	struct dcp_dpu_kms *kms = dsi_bridge->kms;
+	struct dcp_dsi_bridge_state *state = dcp_dsi_bridge_get_state(dsi_bridge);
+	struct dcp_dsi_hfi_config cfg;
+	int ret;
+	u32 opened_session_id;
+
+	if (!mode)
+		return -ENODEV;
+
+	guard(mutex)(&dsi_bridge->session_lock);
+	if (dsi_bridge->session_open)
+		return 0;
+
+	dsi_bridge->session_id = dsi_bridge->fw_display_id;
+
+	if (!dsi_bridge->dsi_device)
+		return -ENODEV;
+
+	dcp_dsi_bridge_build_hfi_config(dsi_bridge, state, &cfg);
+	/* Publish checked DSC values for the panel's PPS command. */
+	if (dsi_bridge->dsi_device->dsc)
+		*dsi_bridge->dsi_device->dsc = state->dsc;
+
+	ret = dcp_hfi_dsi_configure(kms->hfi, dsi_bridge->dsi_idx,
+				    mode,
+				    dsi_bridge->dsi_device,
+				    &cfg);
+	if (ret) {
+		drm_err(kms->dev, "INTF%u: HFI PANEL_INIT failed: %d\n",
+			dsi_bridge->intf_idx, ret);
+		goto err_clear_session;
+	}
+
+	if (mode->clock) {
+		ret = dcp_hfi_display_set_mode(kms->hfi,
+					       dsi_bridge->session_id,
+					       mode,
+					       dcp_dsi_link_clock(dsi_bridge, &cfg,
+								  mode));
+		if (ret) {
+			drm_err(kms->dev, "INTF%u: HFI SET_MODE failed: %d\n",
+				dsi_bridge->intf_idx, ret);
+			goto err_clear_session;
+		}
+	} else {
+		drm_warn(kms->dev, "INTF%u: no valid mode, skipping SET_MODE\n",
+			 dsi_bridge->intf_idx);
+	}
+
+	ret = dcp_hfi_display_enable(kms->hfi,
+				     dsi_bridge->intf_idx,
+				     dsi_bridge->fw_display_id,
+				     &opened_session_id);
+	if (ret) {
+		drm_err(kms->dev, "INTF%u: HFI DISPLAY_ENABLE failed: %d\n",
+			dsi_bridge->intf_idx, ret);
+		goto err_clear_session;
+	}
+	dsi_bridge->session_id   = opened_session_id;
+	dsi_bridge->session_open = true;
+	dcp_dsi_bridge_publish_session(dsi_bridge);
+
+	drm_dbg_driver(kms->dev, "INTF%u: session prepared (session_id=%u)\n",
+		       dsi_bridge->intf_idx, dsi_bridge->session_id);
+	return 0;
+
+err_clear_session:
+	dsi_bridge->session_id   = 0;
+	dsi_bridge->session_open = false;
+	dcp_dsi_bridge_clear_session(dsi_bridge);
+
+	return ret;
+}
+
+static void dcp_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					     struct drm_atomic_commit *state)
+{
+	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
+	int ret;
+
+	ret = dsi_bridge->session_open ? 0 : -ENODEV;
+	dcp_dsi_bridge_get_state(dsi_bridge)->prepare_error = ret;
+	if (ret)
+		drm_err(bridge->dev, "INTF%u: session prepare failed: %d\n",
+			dsi_bridge->intf_idx, ret);
+}
+
+static void dcp_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
+					 struct drm_atomic_commit *state)
+{
+	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
+	struct dcp_dpu_kms *kms = dsi_bridge->kms;
+	int ret;
+
+	drm_dbg_driver(kms->dev,
+		       "INTF%u: bridge atomic_enable (session_id=%u)\n",
+		       dsi_bridge->intf_idx, dsi_bridge->session_id);
+
+	if (dcp_dsi_bridge_get_state(dsi_bridge)->prepare_error)
+		return;
+	if (!dsi_bridge->session_open)
+		return;
+
+	ret = dcp_hfi_display_post_enable(kms->hfi, dsi_bridge->session_id);
+	if (ret) {
+		drm_err(bridge->dev,
+			"INTF%u: HFI DISPLAY_POST_ENABLE failed: %d\n",
+			dsi_bridge->intf_idx, ret);
+		goto err_disable;
+	}
+
+	dcp_dsi_bridge_publish_session(dsi_bridge);
+
+	ret = dcp_hfi_display_event_register(kms->hfi,
+					     dsi_bridge->session_id, HFI_EVENT_FRAME_SCAN_START);
+	if (ret)
+		goto err_disable;
+
+	ret = dcp_hfi_display_event_register(kms->hfi,
+					     dsi_bridge->session_id, HFI_EVENT_FRAME_SCAN_COMPLETE);
+	if (ret)
+		goto err_deregister_scan_start;
+
+	if (dcp_dsi_bridge_cmd_mode(dsi_bridge)) {
+		ret = dcp_hfi_crtc_set_autorefresh(kms->hfi,
+						   dsi_bridge->session_id, true, 1);
+		if (ret) {
+			drm_err(bridge->dev,
+				"INTF%u: initial autorefresh setup failed: %d\n",
+				dsi_bridge->intf_idx, ret);
+			goto err_deregister_scan_complete;
+		}
+	}
+
+	drm_dbg_driver(bridge->dev,
+		       "INTF%u: enable complete (session_id=%u)\n",
+		       dsi_bridge->intf_idx, dsi_bridge->session_id);
+	return;
+
+err_deregister_scan_complete:
+	dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
+					 HFI_EVENT_FRAME_SCAN_COMPLETE);
+err_deregister_scan_start:
+	dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
+					 HFI_EVENT_FRAME_SCAN_START);
+err_disable:
+	drm_err(bridge->dev,
+		"INTF%u: bridge enable failed; rolling back session\n",
+		dsi_bridge->intf_idx);
+	ret = dcp_hfi_display_disable(kms->hfi, dsi_bridge->session_id);
+	if (ret)
+		drm_warn(bridge->dev,
+			 "INTF%u: rollback DISPLAY_DISABLE failed: %d\n",
+			 dsi_bridge->intf_idx, ret);
+	ret = dcp_hfi_display_post_disable(kms->hfi, dsi_bridge->session_id);
+	if (ret)
+		drm_warn(bridge->dev,
+			 "INTF%u: rollback DISPLAY_POST_DISABLE failed: %d\n",
+			 dsi_bridge->intf_idx, ret);
+	scoped_guard(mutex, &dsi_bridge->session_lock) {
+		dsi_bridge->session_id   = 0;
+		dsi_bridge->session_open = false;
+	}
+	dcp_dsi_bridge_clear_session(dsi_bridge);
+}
+
+static void dcp_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
+					  struct drm_atomic_commit *state)
+{
+	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
+	struct dcp_dpu_kms *kms = dsi_bridge->kms;
+	int ret;
+
+	drm_dbg_driver(kms->dev,
+		       "INTF%u: atomic_disable (session_open=%d session_id=%u)\n",
+		       dsi_bridge->intf_idx, dsi_bridge->session_open,
+		       dsi_bridge->session_id);
+
+	guard(mutex)(&dsi_bridge->session_lock);
+	if (!dsi_bridge->session_open)
+		return;
+
+	if (dcp_dsi_bridge_cmd_mode(dsi_bridge)) {
+		ret = dcp_hfi_crtc_set_autorefresh(kms->hfi,
+						   dsi_bridge->session_id, false, 0);
+		if (ret)
+			drm_warn(bridge->dev,
+				 "INTF%u: autorefresh disable failed: %d\n",
+				 dsi_bridge->intf_idx, ret);
+	}
+
+	dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
+					 HFI_EVENT_FRAME_SCAN_COMPLETE);
+	dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
+					 HFI_EVENT_FRAME_SCAN_START);
+
+	ret = dcp_hfi_display_disable(kms->hfi, dsi_bridge->session_id);
+	if (ret)
+		drm_warn(bridge->dev,
+			 "INTF%u: HFI DISPLAY_DISABLE failed: %d\n",
+			 dsi_bridge->intf_idx, ret);
+}
+
+static void dcp_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+					       struct drm_atomic_commit *state)
+{
+	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
+	struct dcp_dpu_kms *kms = dsi_bridge->kms;
+	int ret;
+
+	drm_dbg_driver(kms->dev,
+		       "INTF%u: atomic_post_disable\n",
+		       dsi_bridge->intf_idx);
+
+	guard(mutex)(&dsi_bridge->session_lock);
+	if (!dsi_bridge->session_open)
+		return;
+
+	ret = dcp_hfi_display_post_disable(kms->hfi, dsi_bridge->session_id);
+	if (ret)
+		drm_warn(bridge->dev,
+			 "INTF%u: HFI DISPLAY_POST_DISABLE failed: %d\n",
+			 dsi_bridge->intf_idx, ret);
+
+	dsi_bridge->session_id   = 0;
+	dsi_bridge->session_open = false;
+
+	dcp_dsi_bridge_clear_session(dsi_bridge);
+}
+
+static int dcp_dsi_bridge_atomic_check(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
+	struct dcp_dsi_bridge_state *state =
+		to_dcp_dsi_bridge_state(bridge_state);
+	struct dcp_dpu_kms *kms = dsi_bridge->kms;
+	struct dcp_dsi_hfi_config cfg;
+	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
+	u32 mixer_count, bpc;
+	int ret;
+
+	state->prepare_error = 0;
+	state->topology.topology_mixer_count =
+		dsi_bridge->hfi_config.topology_mixer_count;
+	state->topology.topology_enc_count =
+		dsi_bridge->hfi_config.topology_enc_count;
+	state->topology.topology_intf_count =
+		dsi_bridge->hfi_config.topology_intf_count;
+
+	if (!mode->clock || !drm_mode_vrefresh(mode))
+		return -EINVAL;
+
+	if (dsi_bridge->dsi_device &&
+	    !dsi_bridge->dsi_device->lanes)
+		return -EINVAL;
+
+	if (dsi_bridge->dsi_device && dsi_bridge->dsi_device->dsc) {
+		state->dsc = *dsi_bridge->dsi_device->dsc;
+		ret = dcp_dsi_bridge_setup_dsc(&state->dsc, mode);
+		if (ret)
+			return ret;
+	}
+	dcp_dsi_bridge_build_hfi_config(dsi_bridge, state, &cfg);
+	if (dsi_bridge->dsi_device &&
+	    !dcp_dsi_link_clock(dsi_bridge, &cfg, mode))
+		return -EINVAL;
+
+	if (cfg.dsc) {
+		state->topology.topology_mixer_count =
+			dcp_dsi_bridge_get_mixer_count(&cfg, mode);
+		state->topology.topology_enc_count =
+			state->topology.topology_mixer_count;
+		state->topology.topology_intf_count = 1;
+	}
+	dcp_dsi_bridge_build_hfi_config(dsi_bridge, state, &cfg);
+
+	mixer_count = dcp_dsi_bridge_get_mixer_count(&cfg, mode);
+	bpc = cfg.dsc ? cfg.dsc->bits_per_component : 8;
+	dcp_crtc_set_topology_state(crtc_state, mixer_count, bpc);
+
+	if (mode->hdisplay > kms->caps->max_width) {
+		drm_dbg_atomic(kms->dev,
+			       "INTF%u: mode width %d exceeds DCP max width %u\n",
+			       dsi_bridge->intf_idx, mode->hdisplay,
+			       kms->caps->max_width);
+		return -EINVAL;
+	}
+
+	if (dsi_bridge->dsi_device) {
+		u64 link_clock = dcp_dsi_link_clock(dsi_bridge,
+						    &cfg, mode);
+
+		ret = dcp_hfi_display_mode_validate(kms->hfi,
+						    dsi_bridge->fw_display_id,
+						    mode, link_clock);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static const struct drm_bridge_funcs dcp_dsi_bridge_funcs = {
+	.attach                  = dcp_dsi_bridge_attach,
+	.atomic_pre_enable       = dcp_dsi_bridge_atomic_pre_enable,
+	.atomic_enable           = dcp_dsi_bridge_atomic_enable,
+	.atomic_disable          = dcp_dsi_bridge_atomic_disable,
+	.atomic_post_disable     = dcp_dsi_bridge_atomic_post_disable,
+	.atomic_check            = dcp_dsi_bridge_atomic_check,
+	.atomic_create_state     = dcp_dsi_bridge_atomic_create_state,
+	.atomic_duplicate_state  = dcp_dsi_bridge_atomic_duplicate_state,
+	.atomic_destroy_state    = dcp_dsi_bridge_atomic_destroy_state,
+};
+
+#define DCP_DSI_DUAL_MAP_ALIGN	SZ_1K
+
+static int dcp_dsi_dual_map_buf(struct dcp_dpu_kms *kms,
+				struct device *dma_dev, void *cpu_addr,
+				dma_addr_t iova, size_t size, int prot)
+{
+	struct sg_table sgt = { 0 };
+	struct iommu_domain *domain;
+	ssize_t mapped;
+	int ret;
+
+	if (!kms->iommu_dev || !cpu_addr || !iova ||
+	    !IS_ALIGNED(iova, DCP_DSI_DUAL_MAP_ALIGN))
+		return -EINVAL;
+
+	domain = iommu_get_domain_for_dev(kms->iommu_dev);
+	if (!domain)
+		return -ENODEV;
+
+	ret = dma_get_sgtable(dma_dev, &sgt, cpu_addr, iova, size);
+	if (ret)
+		return ret;
+
+	mapped = iommu_map_sgtable(domain, iova, &sgt, prot);
+	if (mapped != PAGE_ALIGN(size)) {
+		if (mapped > 0)
+			iommu_unmap(domain, iova, mapped);
+		ret = mapped < 0 ? mapped : -EIO;
+		drm_err(kms->dev,
+			"failed to dual-map iova=%pad into iommu_dev domain: %zd\n",
+			&iova, mapped);
+		sg_free_table(&sgt);
+		return ret;
+	}
+
+	sg_free_table(&sgt);
+	return 0;
+}
+
+static void dcp_dsi_dual_unmap_buf(struct dcp_dpu_kms *kms, dma_addr_t iova,
+				   size_t size)
+{
+	struct iommu_domain *domain;
+
+	if (!kms->iommu_dev || !iova)
+		return;
+
+	domain = iommu_get_domain_for_dev(kms->iommu_dev);
+	if (!domain)
+		return;
+
+	iommu_unmap(domain, iova, PAGE_ALIGN(size));
+}
+
+static void dcp_dsi_init_hfi_config_defaults(struct dcp_dsi_hfi_config *cfg,
+					     u32 dsi_idx)
+{
+	memset(cfg, 0, sizeof(*cfg));
+
+	cfg->display_type = HFI_PANEL_DISPLAY_TYPE_BUILT_IN_0;
+	cfg->num_ctrls = 1;
+	cfg->ctrl_indices[0] = dsi_idx;
+	cfg->num_phys = 1;
+	cfg->phy_indices[0] = dsi_idx;
+
+	cfg->dma_trigger = HFI_PANEL_TRIGGER_SW;
+	cfg->stream_trigger = HFI_PANEL_TRIGGER_NONE;
+	cfg->te_dcs_command = 1;
+	cfg->wr_mem_start = 0x2C;
+	cfg->wr_mem_continue = 0x3C;
+
+	cfg->phy_type = HFI_PANEL_PHY_OLED;
+	cfg->bllp_eof_power_mode = true;
+	cfg->bllp_power_mode = true;
+	cfg->lane_map = 1;
+	cfg->color_order = 1;
+
+	cfg->jitter_numer = 4;
+	cfg->jitter_denom = 1;
+	cfg->dcs_tx_buf_size = DCP_DSI_DCS_TX_BUF_SIZE;
+
+	cfg->topology_mixer_count = 1;
+	cfg->topology_intf_count = 1;
+}
+
+struct drm_bridge *dcp_dsi_bridge_init(struct dcp_dpu_kms *kms,
+				       struct device_node *np,
+				       struct device_node *dcp_np,
+				       u32 intf_idx,
+				       u32 dsi_idx,
+				       u32 fw_display_id)
+{
+	struct dcp_dsi_bridge *dsi_bridge;
+	struct dcp_dsi_hfi_config *cfg;
+	struct device *dev = kms->pm_dev;
+	struct device *dma_dev = kms->hfi->dma_dev;
+	int ret;
+
+	dsi_bridge = devm_drm_bridge_alloc(dev, struct dcp_dsi_bridge,
+					   bridge, &dcp_dsi_bridge_funcs);
+	if (IS_ERR(dsi_bridge))
+		return ERR_CAST(dsi_bridge);
+
+	dsi_bridge->dcp_np        = of_node_get(dcp_np);
+	dsi_bridge->kms           = kms;
+	dsi_bridge->intf_idx      = intf_idx;
+	dsi_bridge->dsi_idx       = dsi_idx;
+	dsi_bridge->fw_display_id = fw_display_id;
+
+	mutex_init(&dsi_bridge->session_lock);
+	mutex_init(&dsi_bridge->dcs_lock);
+
+	cfg = &dsi_bridge->hfi_config;
+	dcp_dsi_init_hfi_config_defaults(cfg, dsi_idx);
+
+	/*
+	 * Allocate the buffers for the firmware DMA domain here. The second
+	 * mapping into the display domain is deferred until msm_kms_init_vm()
+	 * has installed the final display IOMMU domain.
+	 */
+	dsi_bridge->dcs_tx_buf = dma_alloc_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
+						    &dsi_bridge->dcs_tx_iova, GFP_KERNEL);
+	if (!dsi_bridge->dcs_tx_buf) {
+		ret = -ENOMEM;
+		goto err_unwind_dma;
+	}
+
+	dsi_bridge->hfi_config.dcs_tx_dva = dsi_bridge->dcs_tx_iova;
+	dsi_bridge->hfi_config.dcs_tx_iova = dsi_bridge->dcs_tx_iova;
+
+	dsi_bridge->dcs_rx_buf = dma_alloc_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
+						    &dsi_bridge->dcs_rx_iova, GFP_KERNEL);
+	if (!dsi_bridge->dcs_rx_buf) {
+		ret = -ENOMEM;
+		goto err_unwind_dma;
+	}
+
+	device_initialize(&dsi_bridge->dsi_host_dev);
+	dsi_bridge->dsi_host_dev.release = dcp_dsi_host_dev_release;
+	dsi_bridge->dsi_host_dev.parent  = dev;
+	dsi_bridge->dsi_host_dev.of_node = of_node_get(np);
+	dev_set_name(&dsi_bridge->dsi_host_dev, "%pOFn", np);
+	dsi_bridge->dsi_host.ops = &dcp_dsi_host_ops;
+	dsi_bridge->dsi_host.dev = &dsi_bridge->dsi_host_dev;
+
+	ret = device_add(&dsi_bridge->dsi_host_dev);
+	if (ret) {
+		dev_err(dev,
+			"DSI%u: failed to add dsi_host_dev: %d\n", dsi_idx, ret);
+		put_device(&dsi_bridge->dsi_host_dev);
+		goto err_unwind_dma;
+	}
+
+	ret = mipi_dsi_host_register(&dsi_bridge->dsi_host);
+	if (ret) {
+		dev_err(dev,
+			"DSI%u: failed to register MIPI DSI host: %d\n",
+			dsi_idx, ret);
+		device_del(&dsi_bridge->dsi_host_dev);
+		put_device(&dsi_bridge->dsi_host_dev);
+		goto err_unwind_dma;
+	}
+
+	dsi_bridge->bridge.of_node = of_node_get(np);
+	dsi_bridge->bridge.type    = DRM_MODE_CONNECTOR_DSI;
+
+	drm_bridge_add(&dsi_bridge->bridge);
+
+	return &dsi_bridge->bridge;
+
+err_unwind_dma:
+	if (dsi_bridge->dcs_rx_buf) {
+		dma_free_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
+				  dsi_bridge->dcs_rx_buf,
+				  dsi_bridge->dcs_rx_iova);
+	}
+	if (dsi_bridge->dcs_tx_buf) {
+		dma_free_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
+				  dsi_bridge->dcs_tx_buf,
+				  dsi_bridge->dcs_tx_iova);
+	}
+	mutex_destroy(&dsi_bridge->session_lock);
+	mutex_destroy(&dsi_bridge->dcs_lock);
+	return ERR_PTR(ret);
+}
+
+int dcp_dsi_bridge_map_buffers(struct dcp_dsi_bridge *dsi_bridge)
+{
+	struct dcp_dpu_kms *kms = dsi_bridge->kms;
+	struct device *dma_dev = kms->hfi->dma_dev;
+	int ret;
+
+	if (dsi_bridge->dcs_mapped)
+		return 0;
+
+	ret = dcp_dsi_dual_map_buf(kms, dma_dev, dsi_bridge->dcs_tx_buf,
+				   dsi_bridge->dcs_tx_iova,
+				   DCP_DSI_DCS_TX_BUF_SIZE, IOMMU_READ);
+	if (ret)
+		return ret;
+
+	ret = dcp_dsi_dual_map_buf(kms, dma_dev, dsi_bridge->dcs_rx_buf,
+				   dsi_bridge->dcs_rx_iova,
+				   DCP_DSI_DCS_RX_BUF_SIZE, IOMMU_WRITE);
+	if (ret) {
+		dcp_dsi_dual_unmap_buf(kms, dsi_bridge->dcs_tx_iova,
+				       DCP_DSI_DCS_TX_BUF_SIZE);
+		return ret;
+	}
+
+	dsi_bridge->dcs_mapped = true;
+	drm_dbg_driver(kms->dev,
+		       "INTF%u: mapped DCS buffers tx=%pad rx=%pad in display domain\n",
+		       dsi_bridge->intf_idx, &dsi_bridge->dcs_tx_iova,
+		       &dsi_bridge->dcs_rx_iova);
+
+	return 0;
+}
+
+void dcp_dsi_bridge_unmap_buffers(struct dcp_dsi_bridge *dsi_bridge)
+{
+	struct dcp_dpu_kms *kms = dsi_bridge->kms;
+
+	if (!dsi_bridge->dcs_mapped)
+		return;
+
+	dcp_dsi_dual_unmap_buf(kms, dsi_bridge->dcs_tx_iova,
+			       DCP_DSI_DCS_TX_BUF_SIZE);
+	dcp_dsi_dual_unmap_buf(kms, dsi_bridge->dcs_rx_iova,
+			       DCP_DSI_DCS_RX_BUF_SIZE);
+	dsi_bridge->dcs_mapped = false;
+}
+
+void dcp_dsi_bridge_cleanup(struct dcp_dsi_bridge *dsi_bridge)
+{
+	struct device *dma_dev = dsi_bridge->kms->hfi->dma_dev;
+
+	drm_bridge_remove(&dsi_bridge->bridge);
+	of_node_put(dsi_bridge->bridge.of_node);
+	of_node_put(dsi_bridge->dcp_np);
+
+	mipi_dsi_host_unregister(&dsi_bridge->dsi_host);
+	device_del(&dsi_bridge->dsi_host_dev);
+	put_device(&dsi_bridge->dsi_host_dev);
+
+	dcp_dsi_bridge_unmap_buffers(dsi_bridge);
+	dma_free_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
+			  dsi_bridge->dcs_tx_buf, dsi_bridge->dcs_tx_iova);
+
+	dma_free_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
+			  dsi_bridge->dcs_rx_buf, dsi_bridge->dcs_rx_iova);
+
+	mutex_destroy(&dsi_bridge->session_lock);
+	mutex_destroy(&dsi_bridge->dcs_lock);
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h b/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h
new file mode 100644
index 000000000000..a91caaaaafa1
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP DSI bridge state and HFI configuration.
+ * DCP firmware owns the DSI PHY and controller; the bridge submits HFI commands.
+ */
+
+#ifndef __DCP_DSI_BRIDGE_H__
+#define __DCP_DSI_BRIDGE_H__
+
+#include <linux/dma-mapping.h>
+#include <linux/ktime.h>
+
+#include <drm/drm_bridge.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+
+#include "dcp_dsi_config.h"
+
+struct dcp_dpu_kms;
+struct device_node;
+
+struct dcp_dsi_bridge {
+	struct drm_bridge    bridge;
+	struct device        dsi_host_dev;
+	struct mipi_dsi_host  dsi_host;
+	struct mipi_dsi_device *dsi_device;
+	struct drm_bridge *downstream_bridge;
+
+	struct dcp_dpu_kms  *kms;
+	struct device_node  *dcp_np;
+	u32                  intf_idx;
+	u32                  dsi_idx;
+	u32                  fw_display_id;
+	u32                  session_id;
+	bool                 session_open;
+	/* Protects session_id and session_open. */
+	struct mutex         session_lock;
+
+	struct dcp_dsi_hfi_config hfi_config;
+	/* Serializes DCS transfers. */
+	struct mutex dcs_lock;
+
+	void       *dcs_tx_buf;
+	dma_addr_t  dcs_tx_iova;
+	void       *dcs_rx_buf;
+	dma_addr_t  dcs_rx_iova;
+	bool         dcs_mapped;
+};
+
+#define to_dcp_dsi_host(h) \
+	container_of(h, struct dcp_dsi_bridge, dsi_host)
+
+#define to_dcp_dsi_bridge(b) \
+	container_of(b, struct dcp_dsi_bridge, bridge)
+
+struct drm_bridge *dcp_dsi_bridge_init(struct dcp_dpu_kms *kms,
+				       struct device_node *np,
+				       struct device_node *dcp_np,
+				       u32 intf_idx,
+				       u32 dsi_idx,
+				       u32 fw_display_id);
+int dcp_dsi_bridge_map_buffers(struct dcp_dsi_bridge *dsi_bridge);
+void dcp_dsi_bridge_unmap_buffers(struct dcp_dsi_bridge *dsi_bridge);
+int dcp_dsi_bridge_prepare_session(struct dcp_dsi_bridge *dsi_bridge,
+				   const struct drm_display_mode *mode);
+void dcp_dsi_bridge_cleanup(struct dcp_dsi_bridge *dsi_bridge);
+
+#endif /* __DCP_DSI_BRIDGE_H__ */

-- 
2.43.0

