Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA17606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vltlr6IG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LEPpzFHk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1AD10F994;
	Thu, 26 Nov 2026 06:31:15 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27BC10F994
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:03 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ69kEu2749666
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TpWghRRvmYLzudQ3henUwyrMbKAZ60J9VUe5nLBlujM=; b=Vltlr6IGIQenfBXI
 cH9VKTLVGsJ9RnlFxWuUKYFxC7f86bPzqjpmjlaQtzMO8tItrIIytako93ocjs8g
 Ezlwab3b30yYHb1yYVZa7iOujjRgBpVjsEbsZ4DM42P68RzQrC42gWL0U+GX3C25
 TmdB2WfZtRP0FwX+nRgyV4Y+LRnahxU/dS6keRXJN3RYcOdnVKFRxfcKp+HjR+oI
 4FTjyiAN9XFFguk+fnxJizeuTUzoYYAUMpj1QeNraXg9UL5/2g2ux0oYaqrnSo7W
 n7fcd7mF/C3vVSgaNFS+Atz6dttevN22lH48Hx3Hc4lSAGNm6k58d/FxRx5Rs1HH
 AuyBTA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rg2c9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2efa9aea3c0so85576295ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674663; x=1796279463;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TpWghRRvmYLzudQ3henUwyrMbKAZ60J9VUe5nLBlujM=;
 b=LEPpzFHk7xXmtVHOrfmHLDbfxqeM0Pp5FBYW+xnd9UZN/a8KJ5iEXjL5yRVoajU0r/
 +rfbZxYhhulG82BLJ1WzYNAEnONiIneDKdc07EOoupsvRY3baynKSRnyKS8oUpP41k7y
 Cfjia/mznv9pyuYWYngCdzj7CTFRvbkOe/DCiof9nrFatqOfaxxqLcl9QzTVnaeHrHG0
 aUk5hK3YI4pwCsKz0x8pIMTUtXJfFRfeZArIzuFa/mu0ZRAEsiOWp/gXlMBRoRErw7hV
 /jCaFxUGNFuipryFrIgakb7plJSGQbPlOU1xOX6UovFa8p8X4o29zN4fQqAqc3JvBMvt
 Yw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674663; x=1796279463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TpWghRRvmYLzudQ3henUwyrMbKAZ60J9VUe5nLBlujM=;
 b=emOKpL8Bc+whlJcKFETDjvkiKA7XMXzTCUBkwTVyCclUXmaiDyBmRWHrw0So5oXgtS
 SVix8dsP7jka0WnVQ1sPlMADDkI+JFsQ4XYSNmMANtEXPKFWmeTHFZbt3vuYdHvEaJbd
 ztIVvc1/441gMn/0wemR2NgBdMxP7/TXtMdO4VzkxtHBHq1GG+23WXeDf5E5V4JKy1uP
 /YRcOUGRTLAPD64jwcT8UHogGjfC1exzShRM7uL3+aSnPR1XSL0e92qJEJqYqKRRfbaR
 SygyX7E6efcl5G/CBSmo9A6tys//gXR7nBpVoFyucmhgKtknHwBjregzX+ap80wmeTAw
 mQtA==
X-Forwarded-Encrypted: i=1;
 AL+hErGWDVX8bDNkPRmCYj4LavdVWox+728rCtAtQ9xurn8FXSUf4JWbV6r6iJv3dlm6PfcjYEKCawyYYmg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z//BbKUuy3iX6dS6lv5PIJqBoun5zrpgTlzN8RMah2DHihGiZhT
 /8roSjxXS2xbKtilG/Nu4nGOYbOeWjCFV36QEgoqhx5exn0qgKDHDI+8svE1Dl/RajPm+Dg3b9q
 Lf4NYHpHRQBtYTscd8kKE9Xh1yLcSAZGzvQQ9hChywSmXPTUk/KlqzCAeXlZarI8PleFl3kU=
X-Gm-Gg: AZFdTZeaZcv4IICIZ81fQBnYc4LHYv0kMPi3MHXwuIP85OKDHdufXsH71DwLNxCD+6O
 Z6DENuRFxIvxErXMvKOtm2LEMXpZxeQzmPeZVxOV7LfMExqA583A4UIgLQoRPpsjam7gQmHIzG6
 vqJ7AB35Ke2D+RM8nmd/xU2qPcUP8JwEl/+Jb+0HkDJVHsWONRbWd28fMhhqJYjlEdYyxpRmaSn
 9WDKFaTuWuWJNMBTHcyscDyPY1srY/Q/TVVtCOMgVOskuP5ERZ0lYNwo47CccCOLbI4HZC93J7T
 lUgcD/3s/cVw3aaz+xM0htPqfhDcudPYERkY2jv68L4VscCd2hrP4D3c6WUp+nxRrQT61Vo2A5X
 9OyQ4ILLohhHtR2jQcpB2KrQr2bD/n7vmBe3B5nm5PLdgeza+KrTZef+2NJY2a31u1YbaZlL++M
 /nYTJ/phPy
X-Received: by 2002:a17:902:ef45:b0:2f0:39c6:8ec8 with SMTP id
 d9443c01a7336-2f03ef4430bmr202899305ad.2.1795674662074; 
 Wed, 25 Nov 2026 22:31:02 -0800 (PST)
X-Received: by 2002:a17:902:ef45:b0:2f0:39c6:8ec8 with SMTP id
 d9443c01a7336-2f03ef4430bmr202899045ad.2.1795674661342; 
 Wed, 25 Nov 2026 22:31:01 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:31:00 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:19 +0530
Subject: [PATCH v3 11/21] drm/msm/dcp: Add DCP planes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-11-f1e9d7505039@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=38932;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=aI0z5TuGJ0esFg6WMSSTSN1LwByKUHcBFmQCfbnftz8=;
 b=SrIdgEJTYvAdMKyMIBYNG4pth+44XEOmiY00iRQsNN5nZYrd7xA//WwOu6JAibNDMIcs3tQzk
 uTijkoj0Dm8Do9DEr+ltedza7Kr7giogeTO81R84tmlDf8bZpiKeuJI
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX9WtMkbmzrL9V
 RSWnxpYwE0xnjUSKequc37/K6z3JwLR6hVMfw029SdpT2H/TKvlXBVGKbnzA3QYqstQmWaxVuMP
 isy8jcvdz6DNWyiD20txRparwsJY4/RpBOrFj1HYDhgBsjEh7dSHPpMx7tIK4LDcoVb2/AyCni4
 CtZxt7j73vLZ149xIzbI8pMRU9v7IsGG09GtMYoaWcLC4ekmc5RV8kV2REG5jXT52mXqIAtTEmr
 TLzaSfRyT6dvze/wlJrUm8q09A+cCMB3UIC1H3aErwZ8QGSFxshnGebLOZUs+30SV2Nishmi+4+
 fsXe/KHWqjKJ59IRlh7QXm/7k/AXhsJI9bZeh4OIlZT+Uv/Cg5MXlmHVsitSWv43Qv+p9RktsUr
 GylcO/jIM8L1LCDCgyTpYBtGgexyisZGtUSkHpzTMZqoYa0t9GXuix0cDIRgq3pMl6CpvdjMPd9
 7xVZ8J5RdgqIEWn0atA==
X-Proofpoint-GUID: 3zwurj46n8-w3hQOyC-Y8X38Gl9pUe4I
X-Proofpoint-ORIG-GUID: 3zwurj46n8-w3hQOyC-Y8X38Gl9pUe4I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX+mH/4ReHs3T0
 KHs4UDQAkIztdsGXn/jBY9SI6O8+hfUq66aMRROrGgOAby7HbYD9i2ImkRYPE7x/iLz2j0/YKcm
 LclDKGxprzOMztN7Hys+U3zF/NhBqmY=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b07d227 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=K24J6YuaatAtwjXtsW4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
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

Expose DCP overlay planes through the DRM plane API. Userspace needs
normal atomic plane state while the firmware-owned pipeline requires
validated formats, assigned pipes, mapped buffers, bandwidth votes,
and HFI property packets.

Implement plane validation, format and scaling checks, firmware pipe
assignment, framebuffer mapping, bandwidth calculation, atomic state
handling, and HFI updates and disables.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile              |    1 +
 drivers/gpu/drm/msm/dcp/dcp_crtc.c        |   35 +
 drivers/gpu/drm/msm/dcp/dcp_plane.c       | 1042 +++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_plane.h       |   36 +
 drivers/gpu/drm/msm/dcp/dcp_plane_state.h |   37 +
 5 files changed, 1151 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 738abdc98714..d0fbd8bdd49a 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -74,6 +74,7 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_crtc.o \
 	dcp/dcp_dpu_kms.o \
+	dcp/dcp_plane.o \
 	dcp/dcp_hfi_core.o \
 	dcp/dcp_hfi_crtc.o \
 	dcp/dcp_hfi_dsi.o \
diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
index 512da8c4ddbc..f58667ca458e 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_crtc.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
@@ -84,6 +84,36 @@ dcp_crtc_atomic_create_state(struct drm_crtc *crtc)
 	return &cstate->base;
 }
 
+static void dcp_crtc_aggregate_bw(struct drm_crtc_state *crtc_state,
+				  bool enable)
+{
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc_state);
+	struct drm_plane *plane;
+	const struct drm_plane_state *pstate;
+
+	cstate->dram_ib  = 0;
+	cstate->dram_ab  = 0;
+	cstate->llcc_ib  = 0;
+	cstate->llcc_ab  = 0;
+	cstate->core_clk = 0;
+
+	if (!enable)
+		return;
+
+	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
+		if (!pstate->visible)
+			continue;
+
+		const struct dcp_plane_state *dcp_pstate = to_dcp_plane_state(pstate);
+
+		cstate->dram_ib  = max(cstate->dram_ib, dcp_pstate->fetch_bw);
+		cstate->dram_ab += dcp_pstate->fetch_bw;
+		cstate->llcc_ib  = max(cstate->llcc_ib, dcp_pstate->fetch_bw);
+		cstate->llcc_ab += dcp_pstate->fetch_bw;
+		cstate->core_clk = max(cstate->core_clk, dcp_pstate->clk);
+	}
+}
+
 static enum drm_mode_status
 dcp_crtc_mode_valid(struct drm_crtc *crtc,
 		    const struct drm_display_mode *mode)
@@ -336,6 +366,9 @@ void dcp_crtc_complete_commit(struct drm_crtc *crtc)
 	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
 	unsigned long flags;
 
+	if (!crtc->state->active)
+		dcp_crtc_aggregate_bw(crtc->state, false);
+
 	spin_lock_irqsave(&crtc->dev->event_lock, flags);
 	if (dcp_crtc->event) {
 		drm_dbg_driver(crtc->dev,
@@ -538,6 +571,8 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
 		return -E2BIG;
 	}
 
+	dcp_crtc_aggregate_bw(crtc_state, true);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dcp/dcp_plane.c b/drivers/gpu/drm/msm/dcp/dcp_plane.c
new file mode 100644
index 000000000000..ff6ce28d61c8
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_plane.c
@@ -0,0 +1,1042 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP plane state validation and HFI property packet construction.
+ */
+
+#include <linux/math64.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_rect.h>
+
+#include "msm_drv.h"
+
+#include "dcp_crtc.h"
+#include "dcp_hfi.h"
+#include "dcp_dpu_kms.h"
+#include "dcp_plane.h"
+
+#define DCP_ZPOS_MAX			255
+#define DCP_MAX_IMG_WIDTH		0x3FFF
+#define DCP_MAX_IMG_HEIGHT		0x3FFF
+#define DCP_SSPP_MAX_PITCH_SIZE	0xFF00
+#define DCP_MAX_UPSCALE_RATIO	20
+#define DCP_MAX_DOWNSCALE_RATIO	4
+
+static const u32 dcp_plane_formats[] = {
+	DRM_FORMAT_ARGB8888, DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBX8888, DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB888,   DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,   DRM_FORMAT_BGR565,
+	DRM_FORMAT_ARGB1555, DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_RGBA5551, DRM_FORMAT_BGRA5551,
+	DRM_FORMAT_XRGB1555, DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_RGBX5551, DRM_FORMAT_BGRX5551,
+	DRM_FORMAT_ARGB4444, DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_RGBA4444, DRM_FORMAT_BGRA4444,
+	DRM_FORMAT_XRGB4444, DRM_FORMAT_XBGR4444,
+	DRM_FORMAT_RGBX4444, DRM_FORMAT_BGRX4444,
+	DRM_FORMAT_ARGB2101010, DRM_FORMAT_XRGB2101010,
+	DRM_FORMAT_ABGR2101010, DRM_FORMAT_XBGR2101010,
+	DRM_FORMAT_NV12, DRM_FORMAT_NV21,
+	DRM_FORMAT_P010, DRM_FORMAT_YUV420, DRM_FORMAT_YVU420,
+};
+
+static const u64 dcp_format_modifiers[] = {
+	DRM_FORMAT_MOD_QCOM_COMPRESSED,
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID,
+};
+
+static struct dcp_dpu_kms *_dcp_plane_get_kms(struct drm_plane *plane)
+{
+	struct msm_drm_private *priv = plane->dev->dev_private;
+
+	return to_dcp_dpu_kms(priv->kms);
+}
+
+static bool dcp_plane_hfi_pipe_valid(struct dcp_dpu_kms *dcp_kms, u32 pipe_id)
+{
+	const struct dcp_caps *caps;
+	u32 i;
+
+	if (!dcp_kms->caps)
+		return false;
+
+	caps = dcp_kms->caps;
+	for (i = 0; i < caps->num_vig_pipes; i++)
+		if (caps->vig_pipe_ids[i] == pipe_id)
+			return true;
+
+	for (i = 0; i < caps->num_dma_pipes; i++)
+		if (caps->dma_pipe_ids[i] == pipe_id)
+			return true;
+
+	return false;
+}
+
+static bool dcp_plane_pipe_is_vig(const struct dcp_caps *caps, u32 pipe_id)
+{
+	u32 i;
+
+	for (i = 0; i < caps->num_vig_pipes; i++)
+		if (caps->vig_pipe_ids[i] == pipe_id)
+			return true;
+
+	return false;
+}
+
+static bool dcp_plane_pipe_busy(struct drm_atomic_commit *state,
+				struct drm_plane *self, u32 pipe_id)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *plane_state;
+	struct drm_plane *iter_plane;
+	struct drm_plane_state *new_plane_state;
+	int i;
+
+	drm_for_each_plane(plane, state->dev) {
+		if (plane == self)
+			continue;
+
+		plane_state = plane->state;
+		for_each_new_plane_in_state(state, iter_plane, new_plane_state, i) {
+			if (iter_plane == plane) {
+				plane_state = new_plane_state;
+				break;
+			}
+		}
+
+		if (plane_state && plane_state->crtc && plane_state->visible &&
+		    to_dcp_plane_state(plane_state)->hfi_pipe_id == pipe_id)
+			return true;
+	}
+
+	return false;
+}
+
+static u32 dcp_plane_assign_pipe(struct dcp_dpu_kms *dcp_kms,
+				 struct drm_atomic_commit *state,
+				 struct drm_plane *plane,
+				 struct dcp_plane_state *pstate,
+				 bool yuv, bool scaling)
+{
+	const struct dcp_caps *caps = dcp_kms->caps;
+	u32 i, pipe_id;
+
+	/* YUV scanout requires a VIG pipe with the CSC path. */
+	if (dcp_plane_hfi_pipe_valid(dcp_kms, pstate->hfi_pipe_id) &&
+	    (!yuv || dcp_plane_pipe_is_vig(caps, pstate->hfi_pipe_id)) &&
+	    (!scaling || dcp_plane_pipe_is_vig(caps, pstate->hfi_pipe_id)) &&
+	    !dcp_plane_pipe_busy(state, plane, pstate->hfi_pipe_id))
+		return pstate->hfi_pipe_id;
+
+	/*
+	 * R1/virtual pipes are intentionally not allocated as independent
+	 * planes yet. They require transactional physical-pipe/R1 ownership
+	 * and multirect programming, which will be added with the resource
+	 * manager.
+	 */
+	for (i = 0; i < caps->num_vig_pipes; i++) {
+		pipe_id = caps->vig_pipe_ids[i];
+		if (!dcp_plane_pipe_busy(state, plane, pipe_id))
+			return pipe_id;
+	}
+
+	if (yuv || scaling)
+		return U32_MAX;
+
+	for (i = 0; i < caps->num_dma_pipes; i++) {
+		pipe_id = caps->dma_pipe_ids[i];
+		if (!dcp_plane_pipe_busy(state, plane, pipe_id))
+			return pipe_id;
+	}
+
+	return U32_MAX;
+}
+
+static const struct {
+	u32 fourcc;
+	u64 modifier;
+	u32 hfi_fmt;
+} dcp_fmt_table[] = {
+	{ DRM_FORMAT_ABGR8888,    DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_RGBA8888 },
+	{ DRM_FORMAT_XBGR8888,    DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_RGBX8888 },
+	{ DRM_FORMAT_ABGR2101010, DRM_FORMAT_MOD_QCOM_COMPRESSED,
+		HFI_COLOR_FORMAT_UBWC_RGBA10_10_10_2 },
+	{ DRM_FORMAT_XBGR2101010, DRM_FORMAT_MOD_QCOM_COMPRESSED,
+		HFI_COLOR_FORMAT_UBWC_RGBX10_10_10_2 },
+	{ DRM_FORMAT_BGR565,      DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_RGB565 },
+	{ DRM_FORMAT_NV12,        DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_NV12 },
+	{ DRM_FORMAT_P010,        DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_P010 },
+
+	{ DRM_FORMAT_RGB565,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGR565 },
+	{ DRM_FORMAT_BGR565,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGB565 },
+	{ DRM_FORMAT_RGB888,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGR888 },
+	{ DRM_FORMAT_BGR888,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGB888 },
+	{ DRM_FORMAT_ARGB8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA8888 },
+	{ DRM_FORMAT_ABGR8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA8888 },
+	{ DRM_FORMAT_RGBA8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR8888 },
+	{ DRM_FORMAT_BGRA8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB8888 },
+	{ DRM_FORMAT_XRGB8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX8888 },
+	{ DRM_FORMAT_XBGR8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX8888 },
+	{ DRM_FORMAT_RGBX8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR8888 },
+	{ DRM_FORMAT_BGRX8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB8888 },
+	{ DRM_FORMAT_ARGB2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA10_10_10_2 },
+	{ DRM_FORMAT_ABGR2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA10_10_10_2 },
+	{ DRM_FORMAT_RGBA1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR2_10_10_10 },
+	{ DRM_FORMAT_BGRA1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB2_10_10_10 },
+	{ DRM_FORMAT_XRGB2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX10_10_10_2 },
+	{ DRM_FORMAT_XBGR2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX10_10_10_2 },
+	{ DRM_FORMAT_RGBX1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR2_10_10_10 },
+	{ DRM_FORMAT_BGRX1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB2_10_10_10 },
+	{ DRM_FORMAT_ARGB1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA5551 },
+	{ DRM_FORMAT_ABGR1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA5551 },
+	{ DRM_FORMAT_RGBA5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR1555 },
+	{ DRM_FORMAT_BGRA5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB1555 },
+	{ DRM_FORMAT_XRGB1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX5551 },
+	{ DRM_FORMAT_XBGR1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX5551 },
+	{ DRM_FORMAT_RGBX5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR1555 },
+	{ DRM_FORMAT_BGRX5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB1555 },
+	{ DRM_FORMAT_ARGB4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA4444 },
+	{ DRM_FORMAT_ABGR4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA4444 },
+	{ DRM_FORMAT_RGBA4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR4444 },
+	{ DRM_FORMAT_BGRA4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB4444 },
+	{ DRM_FORMAT_XRGB4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX4444 },
+	{ DRM_FORMAT_XBGR4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX4444 },
+	{ DRM_FORMAT_RGBX4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR4444 },
+	{ DRM_FORMAT_BGRX4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB4444 },
+	{ DRM_FORMAT_YUV420,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_YU12 },
+	{ DRM_FORMAT_YVU420,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_YV12 },
+	{ DRM_FORMAT_NV12,         DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_NV12 },
+	{ DRM_FORMAT_NV21,         DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_NV21 },
+	{ DRM_FORMAT_P010,         DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_P010 },
+};
+
+static u32 dcp_drm_to_hfi_format(u32 fourcc, u64 modifier)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_fmt_table); i++) {
+		if (dcp_fmt_table[i].fourcc == fourcc &&
+		    dcp_fmt_table[i].modifier == modifier)
+			return dcp_fmt_table[i].hfi_fmt;
+	}
+
+	return U32_MAX;
+}
+
+static u32 dcp_drm_to_hfi_rotation(u32 drm_rotation)
+{
+	u32 hfi_rot = 0;
+
+	if (drm_rotation & DRM_MODE_ROTATE_0)
+		hfi_rot |= HFI_DISPLAY_ROTATION_0;
+	if (drm_rotation & DRM_MODE_ROTATE_90)
+		hfi_rot |= HFI_DISPLAY_ROTATION_90;
+	if (drm_rotation & DRM_MODE_ROTATE_180)
+		hfi_rot |= HFI_DISPLAY_ROTATION_180;
+	if (drm_rotation & DRM_MODE_ROTATE_270)
+		hfi_rot |= HFI_DISPLAY_ROTATION_270;
+	if (drm_rotation & DRM_MODE_REFLECT_X)
+		hfi_rot |= HFI_DISPLAY_REFLECT_X;
+	if (drm_rotation & DRM_MODE_REFLECT_Y)
+		hfi_rot |= HFI_DISPLAY_REFLECT_Y;
+
+	if (!hfi_rot)
+		hfi_rot = HFI_DISPLAY_ROTATION_0;
+
+	return hfi_rot;
+}
+
+static u32 dcp_drm_to_hfi_blend_op(u32 drm_blend_mode)
+{
+	switch (drm_blend_mode) {
+	case DRM_MODE_BLEND_PIXEL_NONE:	return HFI_BLEND_OP_OPAQUE;
+	case DRM_MODE_BLEND_PREMULTI:	return HFI_BLEND_OP_PREMULTIPLIED;
+	case DRM_MODE_BLEND_COVERAGE:	return HFI_BLEND_OP_COVERAGE;
+	default:			return HFI_BLEND_OP_NOT_DEFINED;
+	}
+}
+
+static u16 dcp_compute_bg_alpha(u32 pixel_blend_mode, u16 fg_alpha)
+{
+	switch (pixel_blend_mode) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		return DRM_BLEND_ALPHA_OPAQUE - fg_alpha;
+	case DRM_MODE_BLEND_PREMULTI:
+	case DRM_MODE_BLEND_COVERAGE:
+		return (fg_alpha != DRM_BLEND_ALPHA_OPAQUE) ? fg_alpha : 0;
+	default:
+		return DRM_BLEND_ALPHA_OPAQUE;
+	}
+}
+
+static u32 dcp_hfi_scale_alpha(const struct drm_plane_state *state, u32 alpha)
+{
+	if (to_dcp_crtc_state(state->crtc->state)->topology_bits_per_component >= 10)
+		return alpha;
+
+	return alpha << 8;
+}
+
+static u64 dcp_plane_calc_bw(u32 bpp,
+			     const struct drm_display_mode *mode,
+			     const struct drm_rect *src,
+			     const struct drm_rect *dst)
+{
+	int src_w = drm_rect_width(src) >> 16;
+	int src_h = drm_rect_height(src) >> 16;
+	int dst_h = drm_rect_height(dst);
+	int fps   = drm_mode_vrefresh(mode);
+	int vbp   = mode->vtotal - mode->vsync_end;
+	int vpw   = mode->vsync_end - mode->vsync_start;
+	int vfp   = mode->vsync_start - mode->vdisplay;
+	u32 hw_latency = 25;
+	u64 scale_factor = (src_h > dst_h) ? mult_frac(src_h, 1, dst_h) : 1;
+	u64 plane_bw, prefill_bw;
+
+	plane_bw = (u64)src_w * mode->vtotal * fps * bpp * scale_factor;
+	prefill_bw = plane_bw * hw_latency;
+
+	if ((vbp + vpw) > hw_latency)
+		do_div(prefill_bw, (vbp + vpw));
+	else if ((vbp + vpw + vfp) < hw_latency)
+		do_div(prefill_bw, (vbp + vpw + vfp));
+	else
+		do_div(prefill_bw, hw_latency);
+
+	/* HFI DRAM/LLCC votes are expressed in Kbps. */
+	return div_u64(max(plane_bw, prefill_bw), 1000);
+}
+
+static u64 dcp_plane_calc_clk(const struct drm_display_mode *mode,
+			      const struct drm_rect *src,
+			      const struct drm_rect *dst)
+{
+	int src_h = drm_rect_height(src) >> 16;
+	int dst_w = drm_rect_width(dst);
+	int dst_h = drm_rect_height(dst);
+	int fps   = drm_mode_vrefresh(mode);
+	u64 clk   = (u64)dst_w * mode->vtotal * fps;
+
+	if (src_h > dst_h) {
+		clk *= src_h;
+		do_div(clk, dst_h);
+	}
+	return clk;
+}
+
+void dcp_plane_calc_perf(const struct drm_plane_state *state,
+			 const struct drm_display_mode *mode,
+			 struct dcp_plane_perf *perf)
+{
+	struct drm_rect src, dst;
+	u32 bpp;
+
+	memset(perf, 0, sizeof(*perf));
+
+	if (!state || !state->visible || !state->fb || !mode || !mode->clock ||
+	    !drm_mode_vrefresh(mode))
+		return;
+
+	src = drm_plane_state_src(state);
+	dst = drm_plane_state_dest(state);
+	bpp = drm_format_info_bpp(state->fb->format, 0);
+
+	perf->fetch_bw = dcp_plane_calc_bw(bpp, mode, &src, &dst);
+	perf->clk = dcp_plane_calc_clk(mode, &src, &dst);
+}
+
+static inline u32 *prop_u32(u32 *p, u32 prop_id, u32 lid, u32 val)
+{
+	*p++ = HFI_PACK_KEY(prop_id, 0, 2);
+	*p++ = lid;
+	*p++ = val;
+	return p;
+}
+
+static inline u32 *prop_roi(u32 *p, u32 prop_id, u32 lid,
+			    u32 x, u32 y, u32 w, u32 h)
+{
+	*p++ = HFI_PACK_KEY(prop_id, 0, 5);
+	*p++ = lid;
+	*p++ = x; *p++ = y; *p++ = w; *p++ = h;
+	return p;
+}
+
+static inline u32 *prop_attach(u32 *p, u32 lid)
+{
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_DISPLAY_ATTACH_LAYER, 0, 1);
+	*p++ = lid;
+	return p;
+}
+
+static inline u32 *prop_src_addr(u32 *p, u32 lid,
+				 const dma_addr_t *iova, u32 hfi_fmt)
+{
+	/* The firmware format is struct hfi_plane_buff: all low words,
+	 * followed by all high words, then the common descriptor fields.
+	 */
+	p += HFI_PACK(p, HFI_PROPERTY_LAYER_SRC_ADDR, lid,
+		      lower_32_bits(iova[0]), lower_32_bits(iova[1]),
+		      lower_32_bits(iova[2]), lower_32_bits(iova[3]),
+		      upper_32_bits(iova[0]), upper_32_bits(iova[1]),
+		      upper_32_bits(iova[2]), upper_32_bits(iova[3]),
+		      0, 0, 0, hfi_fmt);
+	return p;
+}
+
+static inline u32 *prop_stride(u32 *p, u32 lid, const u32 *pitches)
+{
+	int i;
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_LAYER_STRIDE, 0, 5);
+	*p++ = lid;
+	for (i = 0; i < 4; i++)
+		*p++ = pitches[i];
+	return p;
+}
+
+static inline u32 *prop_cache_attr(u32 *p, u32 lid, u32 state, u32 op)
+{
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_LAYER_CACHE_ATTR, 0, 3);
+	*p++ = lid;
+	*p++ = state;
+	*p++ = op;
+	return p;
+}
+
+static int dcp_plane_build_one_hfi_props_packet(struct dcp_plane_state *pstate,
+						const struct drm_plane_state *state,
+						u32 session_id, u32 packet_id,
+						u8 *packet)
+{
+	struct drm_framebuffer *fb = state->fb;
+	struct hfi_cmd_buff_hdl hdl;
+	struct hfi_header_info hdr_info;
+	struct hfi_packet_info pkt_info;
+	u32 payload[DCP_PLANE_PROP_PKT_MAX_SIZE / sizeof(u32)];
+	u32 *p = payload;
+	u32 *num_props_ptr;
+	u32 num_props = 0;
+	u32 hfi_format;
+	u32 hfi_rotation;
+	u32 hfi_blend_op;
+	u32 pitches[4] = { 0 };
+	dma_addr_t fb_iova[HFI_MAX_PLANES] = { 0 };
+	u32 src_x, src_y, src_w, src_h;
+	u32 dst_x, dst_y, dst_w, dst_h;
+	u32 hfi_alpha, hfi_bg_alpha;
+	u32 lid = pstate->hfi_pipe_id;
+	int i, ret;
+	u32 payload_words;
+
+	hfi_format = pstate->hfi_format;
+
+	hfi_rotation = dcp_drm_to_hfi_rotation(state->rotation);
+	hfi_blend_op = dcp_drm_to_hfi_blend_op(state->pixel_blend_mode);
+
+	src_x = state->src_x >> 16;
+	src_y = state->src_y >> 16;
+	src_w = state->src_w >> 16;
+	src_h = state->src_h >> 16;
+	dst_x = state->crtc_x;
+	dst_y = state->crtc_y;
+	dst_w = state->crtc_w;
+	dst_h = state->crtc_h;
+
+	hfi_alpha = dcp_hfi_scale_alpha(state, state->alpha);
+	hfi_bg_alpha = dcp_hfi_scale_alpha(state,
+					   dcp_compute_bg_alpha(state->pixel_blend_mode,
+								state->alpha));
+
+	for (i = 0; i < 4 && i < fb->format->num_planes; i++)
+		pitches[i] = fb->pitches[i];
+
+	for (i = 0; i < HFI_MAX_PLANES && i < fb->format->num_planes; i++)
+		fb_iova[i] = msm_framebuffer_iova(fb, i);
+
+	num_props_ptr = p++;
+
+	p = prop_roi(p, HFI_PROPERTY_LAYER_SRC_ROI, lid,
+		     src_x, src_y, src_w, src_h);
+	num_props++;
+
+	p = prop_roi(p, HFI_PROPERTY_LAYER_DEST_ROI, lid,
+		     dst_x, dst_y, dst_w, dst_h);
+	num_props++;
+
+	p = prop_attach(p, lid);
+	num_props++;
+
+	p = prop_src_addr(p, lid, fb_iova, hfi_format);
+	num_props++;
+
+	p = prop_stride(p, lid, pitches);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_SRC_FORMAT, lid, hfi_format);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_ROTATION, lid, hfi_rotation);
+	num_props++;
+
+	p = prop_cache_attr(p, lid,
+			    HFI_CACHE_STATE_DISABLE,
+			    HFI_CACHE_OP_TYPE_NONE);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_ZPOS, lid,
+		     state->normalized_zpos);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_ALPHA, lid, hfi_alpha);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_BG_ALPHA, lid, hfi_bg_alpha);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_BLEND_TYPE, lid, hfi_blend_op);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_SRC_IMG_SIZE_W, lid,
+		     pstate->src_img_w);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_SRC_IMG_SIZE_H, lid,
+		     pstate->src_img_h);
+	num_props++;
+
+	*num_props_ptr = num_props;
+
+	payload_words = p - payload;
+
+	hdl.cmd_buffer = packet;
+	hdl.size       = DCP_PLANE_PROP_PKT_MAX_SIZE;
+
+	hdr_info.num_packets   = 0;
+	hdr_info.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
+	hdr_info.object_id     = session_id;
+	hdr_info.header_id     = packet_id;
+
+	ret = hfi_create_header(&hdl, &hdr_info);
+	if (ret)
+		return ret;
+
+	pkt_info.cmd          = HFI_COMMAND_DISPLAY_SET_PROPERTY;
+	pkt_info.id           = session_id & 0xFFFF;
+	pkt_info.flags        = HFI_TX_FLAGS_NON_DISCARDABLE;
+	pkt_info.packet_id    = packet_id;
+	pkt_info.payload_type = HFI_PAYLOAD_U32_ARRAY;
+	pkt_info.payload_size = payload_words * sizeof(u32);
+	pkt_info.payload_ptr  = payload;
+
+	ret = hfi_create_full_packet(&hdl, &pkt_info);
+	if (ret) {
+		pstate->prop_pkt_size = 0;
+		return ret;
+	}
+
+	pstate->prop_pkt_size = hfi_get_header_size(&hdl);
+
+	drm_dbg_driver(state->plane->dev,
+		       "DCP_COMMIT p=%u pipe=%u src=%ux%u+%ux%u dst=%ux%u+%ux%u fmt=0x%x mod=0x%llx alpha=%u bg_alpha=%u props=%u words=%u size=%zu\n",
+		       state->plane->base.id, lid, src_x, src_y, src_w, src_h,
+		       dst_x, dst_y, dst_w, dst_h, hfi_format, fb->modifier,
+		       hfi_alpha, hfi_bg_alpha, num_props, payload_words,
+		       pstate->prop_pkt_size);
+	return 0;
+}
+
+static int dcp_plane_build_hfi_props_packet(struct dcp_plane_state *pstate,
+					    const struct drm_plane_state *state,
+					    u32 session_id, u32 packet_id)
+{
+	int ret;
+
+	pstate->prop_pkt_size = 0;
+
+	ret = dcp_plane_build_one_hfi_props_packet(pstate, state, session_id,
+						   packet_id, pstate->prop_pkt);
+	return ret;
+}
+
+static int dcp_plane_prepare_fb(struct drm_plane *plane,
+				struct drm_plane_state *new_state)
+{
+	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
+	int ret;
+
+	drm_dbg_driver(plane->dev,
+		       "plane%u: prepare_fb fb=%u\n",
+		       plane->base.id,
+		       new_state->fb ? new_state->fb->base.id : 0);
+
+	if (!new_state->fb)
+		return 0;
+
+	ret = drm_gem_plane_helper_prepare_fb(plane, new_state);
+	if (ret)
+		return ret;
+
+	ret = msm_framebuffer_prepare(new_state->fb, pstate->needs_dirtyfb);
+	if (ret) {
+		drm_err(plane->dev, "plane%u: framebuffer prepare failed: %d\n",
+			plane->base.id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void dcp_plane_cleanup_fb(struct drm_plane *plane,
+				 struct drm_plane_state *old_state)
+{
+	struct dcp_plane_state *pstate = to_dcp_plane_state(old_state);
+
+	drm_dbg_driver(plane->dev,
+		       "plane%u: cleanup_fb fb=%u\n",
+		       plane->base.id,
+		       old_state->fb ? old_state->fb->base.id : 0);
+
+	if (!old_state->fb)
+		return;
+
+	msm_framebuffer_cleanup(old_state->fb, pstate->needs_dirtyfb);
+}
+
+static int dcp_plane_atomic_check(struct drm_plane *plane,
+				  struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
+	struct dcp_dpu_kms *dcp_kms = _dcp_plane_get_kms(plane);
+	struct drm_crtc_state *crtc_state;
+	struct drm_rect src;
+	struct drm_rect fb_rect = { 0 };
+	int min_scale = DRM_PLANE_NO_SCALING;
+	int max_scale = DRM_PLANE_NO_SCALING;
+	bool scaling;
+	int ret, i;
+	struct dcp_plane_perf perf;
+
+	drm_dbg_driver(plane->dev,
+		       "DCP_CHECK plane%u pipe=%u src=(%u,%u %ux%u) dst=(%d,%d %ux%u)\n",
+			plane->base.id, pstate->hfi_pipe_id,
+			new_state->src_x >> 16, new_state->src_y >> 16,
+			new_state->src_w >> 16, new_state->src_h >> 16,
+			new_state->crtc_x, new_state->crtc_y,
+			new_state->crtc_w, new_state->crtc_h);
+
+	pstate->prop_pkt_size = 0;
+	pstate->fetch_bw = 0;
+	pstate->clk = 0;
+
+	if (!new_state->crtc)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, new_state->crtc);
+	if (IS_ERR(crtc_state)) {
+		ret = PTR_ERR(crtc_state);
+		drm_err(plane->dev, "plane%u: failed to get CRTC state: %d\n",
+			plane->base.id, ret);
+		return ret;
+	}
+
+	if (!new_state->fb)
+		return 0;
+
+	scaling = new_state->src_w != ((u32)new_state->crtc_w << 16) ||
+			  new_state->src_h != ((u32)new_state->crtc_h << 16);
+
+	pstate->hfi_pipe_id = dcp_plane_assign_pipe(dcp_kms, state, plane,
+						    pstate, new_state->fb->format->is_yuv,
+						    scaling);
+	if (pstate->hfi_pipe_id == U32_MAX) {
+		drm_err(plane->dev, "plane%u: no compatible HFI pipe available\n",
+			plane->base.id);
+		return -ENOSPC;
+	}
+
+	if (dcp_plane_pipe_is_vig(dcp_kms->caps, pstate->hfi_pipe_id)) {
+		min_scale = FRAC_16_16(1, DCP_MAX_UPSCALE_RATIO);
+		max_scale = DCP_MAX_DOWNSCALE_RATIO << 16;
+	}
+
+	ret = drm_atomic_helper_check_plane_state(new_state, crtc_state,
+						  min_scale, max_scale,
+						  true, true);
+	if (ret) {
+		drm_err(plane->dev, "plane%u: plane state check failed: %d\n",
+			plane->base.id, ret);
+		return ret;
+	}
+
+	if (!new_state->visible)
+		return 0;
+	if (new_state->crtc_x < 0 || new_state->crtc_y < 0 ||
+	    new_state->crtc_w <= 0 || new_state->crtc_h <= 0 ||
+	    (u64)new_state->crtc_x + new_state->crtc_w >
+			crtc_state->adjusted_mode.hdisplay ||
+	    (u64)new_state->crtc_y + new_state->crtc_h >
+			crtc_state->adjusted_mode.vdisplay) {
+		drm_err(plane->dev,
+			"plane%u: destination out of bounds: (%d,%d %ux%u), mode %ux%u\n",
+			plane->base.id, new_state->crtc_x, new_state->crtc_y,
+			new_state->crtc_w, new_state->crtc_h,
+			crtc_state->adjusted_mode.hdisplay,
+			crtc_state->adjusted_mode.vdisplay);
+		return -EINVAL;
+	}
+
+	if (new_state->normalized_zpos >= DCP_MAX_BLEND_STAGES) {
+		drm_dbg_atomic(plane->dev,
+			       "plane%u: zpos %u exceeds blend stages %u\n",
+				plane->base.id, new_state->normalized_zpos,
+				DCP_MAX_BLEND_STAGES);
+		return -EINVAL;
+	}
+
+	dcp_plane_calc_perf(new_state, &crtc_state->adjusted_mode, &perf);
+	pstate->fetch_bw = perf.fetch_bw;
+	pstate->clk = perf.clk;
+
+	pstate->hfi_format = dcp_drm_to_hfi_format(new_state->fb->format->format,
+						   new_state->fb->modifier);
+	if (pstate->hfi_format == U32_MAX) {
+		drm_dbg_atomic(plane->dev, "plane%u: unsupported format 0x%x mod 0x%llx\n",
+			       plane->base.id,
+				 new_state->fb->format->format,
+				 new_state->fb->modifier);
+		drm_err(plane->dev,
+			"plane%u: unsupported format 0x%x modifier 0x%llx\n",
+			plane->base.id, new_state->fb->format->format,
+			new_state->fb->modifier);
+		return -EINVAL;
+	}
+
+	fb_rect.x2 = new_state->fb->width;
+	fb_rect.y2 = new_state->fb->height;
+
+	if (drm_rect_width(&fb_rect) > DCP_MAX_IMG_WIDTH ||
+	    drm_rect_height(&fb_rect) > DCP_MAX_IMG_HEIGHT) {
+		drm_err(plane->dev,
+			"plane%u: framebuffer too large: %ux%u (limit %ux%u)\n",
+			plane->base.id, new_state->fb->width, new_state->fb->height,
+			DCP_MAX_IMG_WIDTH, DCP_MAX_IMG_HEIGHT);
+		return -E2BIG;
+	}
+
+	for (i = 0; i < new_state->fb->format->num_planes; i++) {
+		if (new_state->fb->pitches[i] > DCP_SSPP_MAX_PITCH_SIZE) {
+			drm_err(plane->dev,
+				"plane%u: pitch[%d]=%u exceeds limit %u\n",
+				plane->base.id, i, new_state->fb->pitches[i],
+				DCP_SSPP_MAX_PITCH_SIZE);
+			return -E2BIG;
+		}
+	}
+
+	src = drm_plane_state_src(new_state);
+
+	pstate->src_img_w = new_state->fb->width;
+	pstate->src_img_h = new_state->fb->height;
+
+	if (new_state->fb->format->is_yuv) {
+		u32 src_x = src.x1 >> 16;
+		u32 src_y = src.y1 >> 16;
+		u32 src_w = drm_rect_width(&src) >> 16;
+		u32 src_h = drm_rect_height(&src) >> 16;
+
+		if (src_w < 2 || src_h < 2) {
+			drm_err(plane->dev,
+				"plane%u: YUV source too small: %ux%u\n",
+				plane->base.id, src_w, src_h);
+			return -EINVAL;
+		}
+
+		if (src_x & 0x1 || src_y & 0x1 || src_w & 0x1 || src_h & 0x1) {
+			drm_err(plane->dev,
+				"plane%u: unaligned YUV source: (%u,%u %ux%u)\n",
+				plane->base.id, src_x, src_y, src_w, src_h);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void dcp_plane_set_hfi_error(const struct drm_plane_state *state, int ret)
+{
+	struct dcp_crtc_state *cstate;
+
+	cstate = to_dcp_crtc_state(state->crtc->state);
+	if (!cstate->hfi_error)
+		cstate->hfi_error = ret;
+}
+
+static int dcp_plane_submit_update(struct drm_plane *plane,
+				   struct drm_plane_state *new_state)
+{
+	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
+	struct dcp_dpu_kms *dcp_kms = _dcp_plane_get_kms(plane);
+	u32 session_id;
+	int ret;
+
+	if (!dcp_crtc_get_session(new_state->crtc, &session_id)) {
+		drm_dbg_driver(plane->dev,
+			       "plane%u: update before HFI session open, deferring\n",
+			       plane->base.id);
+		return 0;
+	}
+
+	pstate->prop_pkt_id =
+		(u32)atomic_inc_return(&dcp_kms->hfi->packet_id);
+
+	ret = dcp_plane_build_hfi_props_packet(pstate, new_state, session_id,
+					       pstate->prop_pkt_id);
+	if (ret)
+		return ret;
+
+	ret = dcp_hfi_submit_prop_pkt(dcp_kms->hfi, pstate->prop_pkt,
+				      pstate->prop_pkt_size);
+	if (ret)
+		return ret;
+
+	drm_dbg_driver(plane->dev,
+		       "plane%u: submitted HFI update pipe=%u bytes=%zu\n",
+		       plane->base.id, pstate->hfi_pipe_id, pstate->prop_pkt_size);
+
+	return 0;
+}
+
+static int dcp_plane_submit_disable(struct drm_plane *plane,
+				    struct drm_plane_state *old_state)
+{
+	struct dcp_plane_state *pstate = to_dcp_plane_state(old_state);
+	struct dcp_dpu_kms *dcp_kms = _dcp_plane_get_kms(plane);
+	u32 session_id;
+
+	if (!old_state->crtc)
+		return 0;
+
+	if (!dcp_crtc_get_session(old_state->crtc, &session_id)) {
+		drm_dbg_driver(plane->dev,
+			       "plane%u: disable after HFI session close, skipping detach\n",
+			       plane->base.id);
+		return 0;
+	}
+
+	return dcp_hfi_plane_disable(dcp_kms->hfi, session_id,
+				     pstate->hfi_pipe_id);
+}
+
+static void dcp_plane_atomic_update(struct drm_plane *plane,
+				    struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
+	int ret;
+
+	drm_dbg_driver(plane->dev,
+		       "plane%u: atomic_update visible=%d fb=%u pipe_id=%u\n",
+		       plane->base.id, new_state->visible,
+		       new_state->fb ? new_state->fb->base.id : 0,
+		       pstate->hfi_pipe_id);
+
+	pstate->prop_pkt_size = 0;
+
+	if (!new_state->visible || !new_state->fb)
+		return;
+
+	ret = dcp_plane_submit_update(plane, new_state);
+	if (ret) {
+		drm_err(plane->dev,
+			"plane%u: HFI update failed: %d\n", plane->base.id, ret);
+		dcp_plane_set_hfi_error(new_state, ret);
+		return;
+	}
+}
+
+static void dcp_plane_atomic_disable(struct drm_plane *plane,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *old_state =
+		drm_atomic_get_old_plane_state(state, plane);
+	struct dcp_plane_state *pstate = to_dcp_plane_state(old_state);
+	int ret;
+
+	drm_dbg_driver(plane->dev,
+		       "plane%u: atomic_disable pipe_id=%u\n",
+		       plane->base.id, pstate->hfi_pipe_id);
+
+	ret = dcp_plane_submit_disable(plane, old_state);
+	if (ret) {
+		drm_err(plane->dev,
+			"plane%u: HFI detach failed: %d\n", plane->base.id, ret);
+		dcp_plane_set_hfi_error(old_state, ret);
+	}
+
+	pstate->prop_pkt_size = 0;
+	pstate->prop_pkt_id = 0;
+}
+
+static struct drm_plane_state *
+dcp_plane_atomic_duplicate_state(struct drm_plane *plane)
+{
+	struct dcp_plane_state *pstate, *old_pstate;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	old_pstate = to_dcp_plane_state(plane->state);
+	pstate = kzalloc_obj(*pstate, GFP_KERNEL);
+	if (!pstate)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &pstate->base);
+	pstate->hfi_pipe_id     = old_pstate->hfi_pipe_id;
+	pstate->src_img_w       = old_pstate->src_img_w;
+	pstate->src_img_h       = old_pstate->src_img_h;
+	pstate->fetch_bw       = old_pstate->fetch_bw;
+	pstate->clk            = old_pstate->clk;
+	pstate->needs_dirtyfb  = old_pstate->needs_dirtyfb;
+	pstate->prop_pkt_size   = 0;
+	pstate->prop_pkt_id     = old_pstate->prop_pkt_id;
+
+	return &pstate->base;
+}
+
+static void dcp_plane_atomic_destroy_state(struct drm_plane *plane,
+					   struct drm_plane_state *state)
+{
+	__drm_atomic_helper_plane_destroy_state(state);
+	kfree(to_dcp_plane_state(state));
+}
+
+static struct drm_plane_state *
+dcp_plane_atomic_create_state(struct drm_plane *plane)
+{
+	struct dcp_plane_state *pstate;
+	u32 hfi_pipe_id = to_dcp_plane(plane)->hfi_pipe_id;
+
+	pstate = kzalloc_obj(*pstate, GFP_KERNEL);
+	if (!pstate)
+		return NULL;
+
+	__drm_atomic_helper_plane_state_init(&pstate->base, plane);
+	pstate->hfi_pipe_id = hfi_pipe_id;
+
+	return &pstate->base;
+}
+
+static void dcp_plane_atomic_print_state(struct drm_printer *p,
+					 const struct drm_plane_state *state)
+{
+	const struct dcp_plane_state *pstate = to_dcp_plane_state(state);
+
+	drm_printf(p, "\tprop_pkt_size=%zu\n", pstate->prop_pkt_size);
+	drm_printf(p, "\thfi_pipe_id=%u\n", pstate->hfi_pipe_id);
+
+	if (pstate->prop_pkt_size) {
+		u32 hfi_rot = dcp_drm_to_hfi_rotation(state->rotation);
+
+		drm_printf(p, "\thfi_format=0x%x\n", pstate->hfi_format);
+		drm_printf(p, "\thfi_rotation=0x%x\n", hfi_rot);
+	}
+}
+
+static bool dcp_plane_format_mod_supported(struct drm_plane *plane,
+					   u32 format, uint64_t modifier)
+{
+	if (modifier == DRM_FORMAT_MOD_LINEAR)
+		return true;
+
+	if (modifier == DRM_FORMAT_MOD_QCOM_COMPRESSED)
+		return dcp_drm_to_hfi_format(format, modifier) != U32_MAX;
+
+	return false;
+}
+
+static const struct drm_plane_helper_funcs dcp_plane_helper_funcs = {
+	.prepare_fb     = dcp_plane_prepare_fb,
+	.cleanup_fb     = dcp_plane_cleanup_fb,
+	.atomic_check   = dcp_plane_atomic_check,
+	.atomic_update  = dcp_plane_atomic_update,
+	.atomic_disable = dcp_plane_atomic_disable,
+};
+
+static const struct drm_plane_funcs dcp_plane_funcs = {
+	.update_plane           = drm_atomic_helper_update_plane,
+	.disable_plane          = drm_atomic_helper_disable_plane,
+	.atomic_create_state    = dcp_plane_atomic_create_state,
+	.atomic_duplicate_state = dcp_plane_atomic_duplicate_state,
+	.atomic_destroy_state   = dcp_plane_atomic_destroy_state,
+	.format_mod_supported   = dcp_plane_format_mod_supported,
+	.atomic_print_state     = dcp_plane_atomic_print_state,
+};
+
+struct drm_plane *dcp_plane_init(struct drm_device *dev,
+				 u32 hfi_pipe_id,
+				 enum drm_plane_type type,
+				 unsigned long possible_crtcs)
+{
+	struct dcp_plane *dcp_plane;
+	struct drm_plane *plane;
+	int ret;
+
+	dcp_plane = drmm_universal_plane_alloc(dev, struct dcp_plane, base,
+					       possible_crtcs,
+							       &dcp_plane_funcs,
+							       dcp_plane_formats,
+							       ARRAY_SIZE(dcp_plane_formats),
+							       dcp_format_modifiers,
+					   type, NULL);
+	if (IS_ERR(dcp_plane))
+		return ERR_CAST(dcp_plane);
+
+	plane = &dcp_plane->base;
+	drm_plane_helper_add(plane, &dcp_plane_helper_funcs);
+
+	ret = drm_plane_create_zpos_property(plane, 0, 0, DCP_ZPOS_MAX);
+	if (ret)
+		drm_dbg_driver(plane->dev, "plane%u: zpos property failed\n", hfi_pipe_id);
+
+	drm_plane_create_alpha_property(plane);
+
+	drm_plane_create_blend_mode_property(plane,
+					     BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+		BIT(DRM_MODE_BLEND_PREMULTI) |
+		BIT(DRM_MODE_BLEND_COVERAGE));
+
+	drm_plane_create_rotation_property(plane,
+					   DRM_MODE_ROTATE_0,
+		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
+		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270 |
+		DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y);
+
+	drm_plane_enable_fb_damage_clips(plane);
+
+	dcp_plane->hfi_pipe_id = hfi_pipe_id;
+	if (plane->state)
+		to_dcp_plane_state(plane->state)->hfi_pipe_id = hfi_pipe_id;
+
+	drm_dbg_driver(dev, "plane initialized (type=%d, hfi_pipe_id=%u)\n",
+		       type, hfi_pipe_id);
+	return plane;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_plane.h b/drivers/gpu/drm/msm/dcp/dcp_plane.h
new file mode 100644
index 000000000000..377a156c046a
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_plane.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP plane implementation and API.
+ */
+
+#ifndef __DCP_PLANE_H__
+#define __DCP_PLANE_H__
+
+#include "dcp_plane_state.h"
+
+struct dcp_dpu_kms;
+struct drm_display_mode;
+
+struct dcp_plane_perf {
+	u64 fetch_bw;
+	u64 clk;
+};
+
+struct dcp_plane {
+	struct drm_plane base;
+	u32 hfi_pipe_id;
+};
+
+#define to_dcp_plane(x) container_of(x, struct dcp_plane, base)
+
+void dcp_plane_calc_perf(const struct drm_plane_state *state,
+			 const struct drm_display_mode *mode,
+			 struct dcp_plane_perf *perf);
+struct drm_plane *dcp_plane_init(struct drm_device *dev,
+				 u32 hfi_pipe_id,
+				 enum drm_plane_type type,
+				 unsigned long possible_crtcs);
+
+#endif /* __DCP_PLANE_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_plane_state.h b/drivers/gpu/drm/msm/dcp/dcp_plane_state.h
new file mode 100644
index 000000000000..aafa93cb69b9
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_plane_state.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP plane state definitions.
+ */
+
+#ifndef __DCP_PLANE_STATE_H__
+#define __DCP_PLANE_STATE_H__
+
+#include <drm/drm_plane.h>
+
+#define DCP_PLANE_PROP_PKT_MAX_SIZE	512
+
+struct dcp_plane_state {
+	struct drm_plane_state base;
+
+	u64 fetch_bw;
+	u64 clk;
+
+	u8     prop_pkt[DCP_PLANE_PROP_PKT_MAX_SIZE];
+	size_t prop_pkt_size;
+	u32 prop_pkt_id;
+
+	bool needs_dirtyfb;
+
+	u32 src_img_w;
+	u32 src_img_h;
+
+	u32 hfi_pipe_id;
+	u32 hfi_format;
+};
+
+#define to_dcp_plane_state(x) \
+	container_of(x, struct dcp_plane_state, base)
+
+#endif /* __DCP_PLANE_STATE_H__ */

-- 
2.43.0

