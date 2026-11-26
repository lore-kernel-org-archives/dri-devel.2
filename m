Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF9606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=him2RwER;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dGsgDyMZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FD810FA12;
	Thu, 26 Nov 2026 06:31:06 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E853B10FA12
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:30:54 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36I5f1157417
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RvgyFotzKS+hdDkrX6HYEJDgngjZPzcGsNSVyTC0FVM=; b=him2RwER3q52KBax
 7qbjPwe6nizWroBbskqNVFm6kBswwk9cPdLwURJRE7/Jo0Vmgkbk/xMJ4mRH0CCX
 u056VduwUIngEEwM++z35ZnhxgdkPQdzmh6xbnnCW3DRxOI+5azz/1pot2ndeSNY
 j9qMrPUb7oYBhqcoq9yiXIAdIRy2VXVVG7xxfYQeAYkgD1Tx8GpfW5LpFCMI3tnt
 WREnCsi0Hoq9a9OHufqy3D/AjOzr6nuIcV8rH2s1PkcsHIWq39bk+4CO9Uz+wSC1
 SPyP3S+zHPvce/sjxnNn7RuZUIc/2wEMph/goOZeUsQdaGnOoRbzk+cI/aVeJ0kE
 Knoq4g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62aejrqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:30:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2f045e399acso57889965ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674654; x=1796279454;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RvgyFotzKS+hdDkrX6HYEJDgngjZPzcGsNSVyTC0FVM=;
 b=dGsgDyMZvu/uwbs2saj+X8KbzzoH/g69rXxw6sjF8U/oyc/ZFsDjWW4aCvNaXmXgf7
 fbhSxWR549QrhU/nIx0L67tFehrmn2+5NRrCruPcbnJpNBdy5QdP1t8n1byeaiX4FevA
 RmKGjPq/3fdujiygQvnuCXrruUM9Al2E0V+ux4x5nhjVA6ddibAxSmG+ffPVhtWs0/NQ
 KObn72bHdUdC5s1lDtD+3ZPVqd7hKhTkw9l0wf/UWhQnP7l3QZj8N/ECmwQfih/0BJu5
 +ozngtgMSBnf2o6Dx1RnP5x3nrZLCsBFuxV+rEbu2eR72xt+FK//buRhne8HjC20n0Ne
 CmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674654; x=1796279454;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RvgyFotzKS+hdDkrX6HYEJDgngjZPzcGsNSVyTC0FVM=;
 b=nRKp6VwN4ioo8cJPMtkeoje4T5e3OgtiO3RYR3+t/45Gf8lXftWIzKtjlDOEMnlELz
 oUcMPcSeUR12sr2GiOw25w4mGWK2Eej3ffRcwv3hzFFx8mSfYKLUgpJhYOkmguqJOtwR
 zf+zJwKkeT13AO9YDQeHcRpksP21SrHE/ncRXNp5KfdC65byuOvtQa8JXdRET40d92AL
 14x2ovYZN2tbcmzezKEqaQUo+RbzZlEF1pnJhT5Z1n/GjSHWXtNuZTzdRdCdN1K4IPQM
 XmqWOxNUn2uirI5cWEJr6Qg+U7iOk7l571QVGu+2gkVYrxm4JJ3NRtykFKUDoaHyCahq
 QHbg==
X-Forwarded-Encrypted: i=1;
 AL+hErECDeZkEegQK8PIeM5zGZeXbabv8AxzBSCsEIL8wEzDfCnSs+iGk7aq8BQJH6xMLt4VwaG34jqFVFQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+g8nYZqFKjpVZLBJCKaFRqvlrPJE+J38r1RIPWrT3E58CPeFkZ
 /biayTbIA70Rzq+wMRk3G6ErjBspDMFHsRuP4eSatVu3BTFgLvYVRXxn1IGl0oytntnYMuXSNvK
 K6JCu5PgfugCjyAeW/A75E4otRfLkHYrKp8u406nmZMQlZyc3+Rp5fJqr2ZTqlgOkfb43XXE=
X-Gm-Gg: AZFdTZcYzTNBlHcut3NAiLKepHHDtdByLUmTnEYc7d08qwTShHoiafu5TlcqGDO2Qnf
 OfbZQYqFTkLEu2nbLYRAr9ODlRzFv/JMq8ug0e4nqEPa6gQ1Wfw3r2AfAPXJsT793hTdntiJtAi
 s+vgvFIKsn7cTVghp84dJlBgUwi4Nbrgj+9t6oas2tTzMxYwiUUAQb/dJ4eYzs5vxrOETuzoNcW
 E4aU5fdGmxiBO6KhxbtYN/O7f2ns69H2T2gws7C0RFMRtAZHN7YPJkBJ8nA5vSQ7hN0Agzjcqiq
 dACr+6oLw74ezpzxv4i6KvktJ0zwi1iKfuSoz2466gYnwvjK/0p5OcBqS049T+785vZChZ7K8YO
 9q8ZXmb3aU4QlRsq5UdoRkx8kF850Z5iLfnrTtceySWk56zCyogPh2SSgh+PcsjlS79P9qkdI5S
 L06Xa4rT16
X-Received: by 2002:a17:902:d60f:b0:2e2:c283:354f with SMTP id
 d9443c01a7336-2f0b9123089mr78776535ad.28.1795674653344; 
 Wed, 25 Nov 2026 22:30:53 -0800 (PST)
X-Received: by 2002:a17:902:d60f:b0:2e2:c283:354f with SMTP id
 d9443c01a7336-2f0b9123089mr78776035ad.28.1795674652695; 
 Wed, 25 Nov 2026 22:30:52 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:30:52 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:18 +0530
Subject: [PATCH v3 10/21] drm/msm/dcp: Add DCP CRTCs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-10-f1e9d7505039@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=26301;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=4zU4F6F/99xRXeW7TI5wmsuC/efjzhHYgODuIaIkVn8=;
 b=qGdeLM+6jrQ7Kq4wm6uTFK1F9ZWFfcS2R0grlBGFITKNM+mF+FFw0Z159TQvpIi6ZS7Fo53fO
 vK4hWwb4hQwCqaMFB+JHWkFVuZzmeS0kI8qTUuk+fYizA1FllMVY6KW
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX1pbf/7xC05Lv
 /N3TigUhe5mySMC9KElbjJ/B3CZ0RHgSNDAkJ0GM4IkAIaUPC7A4xGT9PbLinT3FTwdgWgfYwS6
 f/0Lutzk0VpfnxNYpVq+0UGyfMsV4wKvZ+U3IxkmI/Ra9QYK+fNxWsqIRAAe8+jnSIMWTslPNoY
 LzDtpldTO1VkO21IsN/sDLWa43G3KG5+hGyZRiQVgdrAkSLia0QGcTOf9nvjoTbSJecNUIRTU50
 cDSgGknwe5zI1T70wygmM6HrmR/5Vxe5O0EByq1URPxfwlWs/iHM7URE9UyWNRyYzEDNdMsQAFe
 VIDEL4rAVikl4G544BVHqyFRfhVzBAWJc23wNDoNSATPrDc4mxgxchY7Ux2qx5Cw6ge5eICV5JZ
 5Bthp84qxTPHw85vDnVWgVCChryy2uNdZwm/cuRG5lvmVM+soHIEJjMbogAYyfTzO91kxCdV1nK
 PYTeFHXXl07Vg0+DSkQ==
X-Proofpoint-GUID: hrJbVlLusrpXpY3Dp6Vm4jOJImqDVTYS
X-Proofpoint-ORIG-GUID: hrJbVlLusrpXpY3Dp6Vm4jOJImqDVTYS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXx1stEFhJZZWQ
 vGy5KsgWWIpk02pNWi41qeEyJUL/OSVz/LlD+gDzyR+RnI/x9WmezoR6Il451IbF5g7XQMwnavx
 uR74NTYrR3I48woLYrgNUG1XggnHScg=
X-Authority-Analysis: v=2.4 cv=PqoG/AM3 c=1 sm=1 tr=0 ts=6b07d21e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=V6dx341SavrEW83xMVAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
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

Create DRM CRTC objects to expose firmware-owned displays through the
MSM DRM driver. Track display topology and firmware sessions so atomic
modesetting and frame completion can be handled per display.

Implement CRTC objects, display lookup, session state, and vblank handling.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile          |   2 +
 drivers/gpu/drm/msm/dcp/dcp_crtc.c    | 665 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_crtc.h    |  85 +++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c |  21 ++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h |  54 +++
 5 files changed, 827 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 6a75bec4e95e..738abdc98714 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -72,6 +72,8 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 	disp/mdp5/mdp5_smp.o \
 
 msm-display-$(CONFIG_DRM_MSM_DCP) += \
+	dcp/dcp_crtc.o \
+	dcp/dcp_dpu_kms.o \
 	dcp/dcp_hfi_core.o \
 	dcp/dcp_hfi_crtc.o \
 	dcp/dcp_hfi_dsi.o \
diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
new file mode 100644
index 000000000000..512da8c4ddbc
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
@@ -0,0 +1,665 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * DCP CRTC implementation.
+ */
+
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_rect.h>
+#include <drm/drm_vblank.h>
+
+#include <drm/drm_managed.h>
+
+#include "msm_drv.h"
+
+#include "dcp_crtc.h"
+#include "dcp_drv.h"
+#include "dcp_hfi.h"
+#include "dcp_dpu_kms.h"
+
+#include "hfi/hfi_defs_display.h"
+#include "hfi/hfi_properties_display.h"
+
+#define DCP_FRAME_DONE_TIMEOUT_MS	500
+
+static struct dcp_dpu_kms *dcp_crtc_get_kms(struct drm_crtc *crtc)
+{
+	struct msm_drm_private *priv = crtc->dev->dev_private;
+
+	return to_dcp_dpu_kms(priv->kms);
+}
+
+static struct drm_crtc_state *
+dcp_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
+{
+	struct dcp_crtc_state *cstate;
+
+	if (WARN_ON(!crtc->state))
+		return NULL;
+
+	cstate = kzalloc_obj(*cstate, GFP_KERNEL);
+	if (!cstate)
+		return NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &cstate->base);
+
+	cstate->topology_mixer_count =
+		to_dcp_crtc_state(crtc->state)->topology_mixer_count;
+	cstate->topology_bits_per_component =
+		to_dcp_crtc_state(crtc->state)->topology_bits_per_component;
+	memcpy(cstate->mixer_roi, to_dcp_crtc_state(crtc->state)->mixer_roi,
+	       sizeof(cstate->mixer_roi));
+	return &cstate->base;
+}
+
+static void dcp_crtc_atomic_destroy_state(struct drm_crtc *crtc,
+					  struct drm_crtc_state *state)
+{
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(state);
+
+	__drm_atomic_helper_crtc_destroy_state(state);
+	kfree(cstate);
+}
+
+static struct drm_crtc_state *
+dcp_crtc_atomic_create_state(struct drm_crtc *crtc)
+{
+	struct dcp_crtc_state *cstate;
+
+	cstate = kzalloc_obj(*cstate, GFP_KERNEL);
+	if (!cstate)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_crtc_state_init(&cstate->base, crtc);
+	cstate->topology_mixer_count = 1;
+	cstate->topology_bits_per_component = 8;
+	return &cstate->base;
+}
+
+static enum drm_mode_status
+dcp_crtc_mode_valid(struct drm_crtc *crtc,
+		    const struct drm_display_mode *mode)
+{
+	struct dcp_dpu_kms *kms = dcp_crtc_get_kms(crtc);
+
+	if (mode->hdisplay > kms->caps->max_width)
+		return MODE_BAD_WIDTH;
+
+	return MODE_OK;
+}
+
+static void dcp_crtc_atomic_begin(struct drm_crtc *crtc,
+				  struct drm_atomic_commit *state)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	u32 mixer_count;
+	u32 session_id;
+	u32 i;
+	int ret;
+
+	/*
+	 * MSM commits pass flags=0 to drm_atomic_helper_commit_planes().
+	 * ACTIVE_ONLY would also skip atomic_flush() for inactive CRTCs, where
+	 * this driver still needs to capture pending DRM events.
+	 */
+	if (!crtc->state->active)
+		return;
+	if (!dcp_kms->commit_pm_active) {
+		cstate->hfi_error = -EIO;
+		return;
+	}
+
+	if (!dcp_crtc_get_session(crtc, &session_id)) {
+		cstate->hfi_error = -ENODEV;
+		return;
+	}
+
+	if (cstate->core_clk > 0 || cstate->dram_ib > 0) {
+		ret = dcp_hfi_crtc_set_bw(dcp_kms->hfi, session_id,
+					  cstate->dram_ib,  cstate->dram_ab,
+					  cstate->llcc_ib,  cstate->llcc_ab,
+					  cstate->core_clk);
+		if (ret) {
+			cstate->hfi_error = ret;
+			return;
+		}
+	}
+
+	mixer_count = cstate->topology_mixer_count;
+	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
+		cstate->hfi_error = -EINVAL;
+		return;
+	}
+	for (i = 0; i < mixer_count; i++) {
+		struct drm_rect *roi = &cstate->mixer_roi[i];
+
+		if (drm_rect_width(roi) <= 0 || drm_rect_height(roi) <= 0) {
+			drm_err(crtc->dev, "CRTC%u: invalid zero-sized LM%u ROI\n",
+				dcp_crtc->display_id, i);
+			cstate->hfi_error = -EINVAL;
+			return;
+		}
+
+		ret = dcp_hfi_crtc_set_resource(dcp_kms->hfi, session_id,
+						i, drm_rect_width(roi),
+						drm_rect_height(roi),
+						roi->x1, roi->y1);
+		if (ret) {
+			cstate->hfi_error = ret;
+			return;
+		}
+	}
+
+	ret = dcp_hfi_crtc_set_dest_roi(dcp_kms->hfi, session_id, 0, 0,
+					crtc->state->adjusted_mode.hdisplay,
+					crtc->state->adjusted_mode.vdisplay);
+	if (ret) {
+		cstate->hfi_error = ret;
+		return;
+	}
+}
+
+static void dcp_crtc_atomic_flush(struct drm_crtc *crtc,
+				  struct drm_atomic_commit *state)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	unsigned long flags;
+	u32 session_id;
+	int ret;
+
+	/* Inactive CRTCs may carry an event but must not receive HFI updates. */
+	if (!crtc->state->enable || !crtc->state->active)
+		goto flush_done;
+	drm_dbg_driver(crtc->dev, "DCP_FLUSH CRTC%u mask=0x%x err=%d\n",
+		       dcp_crtc->display_id, crtc->state->plane_mask,
+		       cstate->hfi_error);
+
+	if (!dcp_crtc_get_session(crtc, &session_id)) {
+		drm_dbg_driver(crtc->dev,
+			       "CRTC%u: atomic flush without HFI session\n",
+			       dcp_crtc->display_id);
+		goto flush_done;
+	}
+
+	if (cstate->hfi_error)
+		goto flush_done;
+
+	ret = dcp_hfi_crtc_set_scan_sequence_id(dcp_kms->hfi, session_id,
+						++dcp_crtc->commit_seq_id);
+	if (ret)
+		goto flush_error;
+
+	ret = dcp_hfi_crtc_set_autorefresh(dcp_kms->hfi,
+					   session_id, true, 1);
+	if (ret)
+		goto flush_error;
+
+	goto flush_done;
+
+flush_error:
+	cstate->hfi_error = ret;
+
+flush_done:
+	spin_lock_irqsave(&crtc->dev->event_lock, flags);
+	dcp_crtc->event = crtc->state->event;
+	crtc->state->event = NULL;
+	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+}
+
+void dcp_crtc_set_session(struct drm_crtc *crtc, u32 session_id)
+{
+	struct dcp_crtc *dcp_crtc;
+	unsigned long flags;
+
+	dcp_crtc = to_dcp_crtc(crtc);
+	spin_lock_irqsave(&dcp_crtc->spin_lock, flags);
+	dcp_crtc->session_id = session_id;
+	dcp_crtc->session_valid = true;
+	spin_unlock_irqrestore(&dcp_crtc->spin_lock, flags);
+}
+
+void dcp_crtc_clear_session(struct drm_crtc *crtc)
+{
+	struct dcp_crtc *dcp_crtc;
+	unsigned long flags;
+
+	dcp_crtc = to_dcp_crtc(crtc);
+	spin_lock_irqsave(&dcp_crtc->spin_lock, flags);
+	dcp_crtc->session_valid = false;
+	dcp_crtc->session_id = 0;
+	spin_unlock_irqrestore(&dcp_crtc->spin_lock, flags);
+}
+
+bool dcp_crtc_get_session(struct drm_crtc *crtc, u32 *session_id)
+{
+	struct dcp_crtc *dcp_crtc;
+	unsigned long flags;
+	bool valid;
+
+	dcp_crtc = to_dcp_crtc(crtc);
+	spin_lock_irqsave(&dcp_crtc->spin_lock, flags);
+	valid = dcp_crtc->session_valid;
+	if (valid)
+		*session_id = dcp_crtc->session_id;
+	spin_unlock_irqrestore(&dcp_crtc->spin_lock, flags);
+
+	return valid;
+}
+
+void dcp_crtc_set_topology_state(struct drm_crtc_state *state,
+				 u32 mixer_count,
+				 u32 bits_per_component)
+{
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(state);
+
+	cstate->topology_mixer_count = mixer_count;
+	cstate->topology_bits_per_component = bits_per_component;
+}
+
+void dcp_crtc_commit_kickoff(struct drm_crtc *crtc)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	u32 session_id;
+	int ret;
+
+	if (cstate->hfi_error) {
+		drm_err(crtc->dev,
+			"DCP_TRIGGER CRTC%u suppressed after HFI error %d\n",
+			dcp_crtc->display_id, cstate->hfi_error);
+		return;
+	}
+
+	if (!dcp_crtc_get_session(crtc, &session_id)) {
+		drm_warn(crtc->dev,
+			 "CRTC%u: no active session, skipping FRAME_TRIGGER\n",
+			 dcp_crtc->display_id);
+		return;
+	}
+
+	/* MSM serializes commits, so only one frame completion may be pending. */
+	if (atomic_cmpxchg(&dcp_crtc->pending_kickoff_cnt, 0, 1)) {
+		drm_err(crtc->dev,
+			"CRTC%u: frame completion already pending (dropped commit_seq_id=%u, in-flight pending_seq_id=%u)\n",
+			dcp_crtc->display_id, dcp_crtc->commit_seq_id,
+			dcp_crtc->pending_seq_id);
+		cstate->hfi_error = -EBUSY;
+		return;
+	}
+	dcp_crtc->pending_seq_id = dcp_crtc->commit_seq_id;
+
+	ret = dcp_hfi_display_commit(dcp_kms->hfi, session_id);
+	if (ret) {
+		drm_err(crtc->dev,
+			"HFI commit failed for CRTC%u (session=%u): %d\n",
+			dcp_crtc->display_id, session_id, ret);
+		atomic_dec(&dcp_crtc->pending_kickoff_cnt);
+		wake_up(&dcp_crtc->frame_done_wq);
+	}
+}
+
+void dcp_crtc_wait_for_commit_done(struct drm_crtc *crtc)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	unsigned long timeout = msecs_to_jiffies(DCP_FRAME_DONE_TIMEOUT_MS);
+
+	if (!atomic_read(&dcp_crtc->pending_kickoff_cnt))
+		return;
+
+	if (!wait_event_timeout(dcp_crtc->frame_done_wq,
+				atomic_read(&dcp_crtc->pending_kickoff_cnt) == 0,
+				timeout)) {
+		drm_err(crtc->dev,
+			"frame done timeout for CRTC%u pending_seq_id=%u commit_seq_id=%u\n",
+			dcp_crtc->display_id, dcp_crtc->pending_seq_id,
+			dcp_crtc->commit_seq_id);
+		atomic_set(&dcp_crtc->pending_kickoff_cnt, 0);
+	}
+}
+
+void dcp_crtc_complete_commit(struct drm_crtc *crtc)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	unsigned long flags;
+
+	spin_lock_irqsave(&crtc->dev->event_lock, flags);
+	if (dcp_crtc->event) {
+		drm_dbg_driver(crtc->dev,
+			       "DCP_TS CRTC%u: page-flip event send time=%lld vblank_count=%llu commit_seq_id=%u pending_seq_id=%u hfi_error=%d%s\n",
+			       dcp_crtc->display_id, ktime_to_ns(ktime_get()),
+			       drm_crtc_vblank_count(crtc),
+			       dcp_crtc->commit_seq_id, dcp_crtc->pending_seq_id,
+			       cstate->hfi_error,
+			       dcp_crtc->commit_seq_id != dcp_crtc->pending_seq_id ?
+			       " MISMATCH-UNCONFIRMED-FRAME" : "");
+		drm_crtc_send_vblank_event(crtc, dcp_crtc->event);
+		dcp_crtc->event = NULL;
+	}
+	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+}
+
+int dcp_crtc_vblank(struct drm_crtc *crtc, bool enable)
+{
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	u32 session_id;
+	int ret;
+
+	/* A published session implies KMS/HFI setup has completed. */
+	if (!dcp_crtc_get_session(crtc, &session_id))
+		return -ENODEV;
+
+	if (enable)
+		ret = dcp_hfi_display_event_register_async(dcp_kms->hfi,
+							   session_id, HFI_EVENT_VSYNC);
+	else
+		ret = dcp_hfi_display_event_deregister_async(dcp_kms->hfi,
+							     session_id, HFI_EVENT_VSYNC);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void dcp_crtc_vblank_callback(struct drm_crtc *crtc, u64 timestamp_ns)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+
+	/* DRM owns the vblank enable state and filters late HFI callbacks. */
+	if (!READ_ONCE(drm_crtc_vblank_crtc(crtc)->enabled))
+		return;
+
+	if (timestamp_ns)
+		WRITE_ONCE(dcp_crtc->hw_vblank_timestamp_ns, timestamp_ns);
+
+	if (ktime_compare(dcp_crtc->vblank_cb_time, ktime_set(0, 0)) == 0)
+		dcp_crtc->vblank_cb_time = ktime_get();
+	else
+		dcp_crtc->vblank_cb_count++;
+
+	drm_dbg_driver(crtc->dev,
+		       "DCP_TS CRTC%u: HFI VSYNC time=%lld hw_time=%llu vblank_count=%llu (pre-handle)\n",
+		       dcp_crtc->display_id, ktime_to_ns(ktime_get()),
+		       timestamp_ns, drm_crtc_vblank_count(crtc));
+	drm_crtc_handle_vblank(crtc);
+}
+
+static struct drm_crtc *dcp_crtc_find_by_session_id(struct dcp_dpu_kms *dcp_kms,
+						    u32 session_id)
+{
+	struct drm_crtc *crtc;
+	u32 active_session_id;
+	unsigned int i;
+
+	for (i = 0; i < dcp_kms->num_crtcs; i++) {
+		crtc = dcp_kms->crtcs[i].crtc;
+		if (crtc && dcp_crtc_get_session(crtc, &active_session_id) &&
+		    active_session_id == session_id)
+			return crtc;
+	}
+
+	return NULL;
+}
+
+void dcp_crtc_hfi_vblank_cb(struct dcp_drv *drv, u32 session_id, u64 timestamp_ns)
+{
+	struct drm_crtc *crtc;
+
+	/* Ignore async events until KMS is linked during probe or teardown. */
+	if (!drv || !drv->kms)
+		return;
+
+	crtc = dcp_crtc_find_by_session_id(drv->kms, session_id);
+	if (!crtc) {
+		drm_err_ratelimited(drv->kms->dev,
+				    "unknown CRTC for HFI VSYNC session %u\n",
+				    session_id);
+		return;
+	}
+
+	dcp_crtc_vblank_callback(crtc, timestamp_ns);
+}
+
+void dcp_crtc_hfi_frame_done_cb(struct dcp_drv *drv, u32 session_id,
+				u32 sequence_id, u64 timestamp_ns)
+{
+	struct dcp_dpu_kms *dcp_kms;
+	struct dcp_crtc *dcp_crtc;
+	struct drm_crtc *crtc;
+
+	/* Ignore async events until KMS is linked during probe or teardown. */
+	if (!drv || !drv->kms)
+		return;
+
+	dcp_kms = drv->kms;
+	crtc = dcp_crtc_find_by_session_id(dcp_kms, session_id);
+	if (!crtc) {
+		drm_err_ratelimited(dcp_kms->dev,
+				    "unknown CRTC for HFI frame-done session %u seq=%u\n",
+				    session_id, sequence_id);
+		return;
+	}
+
+	dcp_crtc = to_dcp_crtc(crtc);
+	/* A single pending commit makes equality valid across sequence wrap. */
+	if (sequence_id != dcp_crtc->pending_seq_id) {
+		drm_warn(crtc->dev,
+			 "CRTC%u: ignoring stale FRAME_SCAN_COMPLETE seq=%u expected=%u\n",
+			 dcp_crtc->display_id, sequence_id,
+			 dcp_crtc->pending_seq_id);
+		return;
+	}
+	drm_dbg_driver(crtc->dev,
+		       "DCP_TS CRTC%u: FRAME_SCAN_COMPLETE seq=%u time=%lld hw_time=%llu vblank_count=%llu\n",
+		       dcp_crtc->display_id, sequence_id,
+		       ktime_to_ns(ktime_get()), timestamp_ns,
+		       drm_crtc_vblank_count(crtc));
+	atomic_add_unless(&dcp_crtc->pending_kickoff_cnt, -1, 0);
+	wake_up(&dcp_crtc->frame_done_wq);
+}
+
+static int dcp_crtc_setup_mixer_rois(struct drm_crtc *crtc,
+				     struct drm_crtc_state *crtc_state,
+				     struct dcp_crtc_state *cstate)
+{
+	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
+	u32 mixer_count = cstate->topology_mixer_count;
+	u32 mixer_width = mode->hdisplay / mixer_count;
+	u32 i;
+
+	if (!mixer_width)
+		return -EINVAL;
+
+	for (i = 0; i < mixer_count; i++) {
+		struct drm_rect *roi = &cstate->mixer_roi[i];
+
+		roi->x1 = (mode->hdisplay * i) / mixer_count;
+		roi->y1 = 0;
+		roi->x2 = (mode->hdisplay * (i + 1)) / mixer_count;
+		roi->y2 = mode->vdisplay;
+		drm_dbg_driver(crtc->dev,
+			       "DCP_CHECK CRTC%u LM%u roi=(%d,%d %dx%d)\n",
+				to_dcp_crtc(crtc)->display_id, i,
+				roi->x1, roi->y1,
+				drm_rect_width(roi), drm_rect_height(roi));
+	}
+
+	return 0;
+}
+
+static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
+				 struct drm_atomic_commit *state)
+{
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	struct drm_crtc_state *crtc_state =
+		drm_atomic_get_new_crtc_state(state, crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc_state);
+	u32 mixer_count;
+	int ret;
+
+	drm_dbg_atomic(crtc->dev, "CRTC%u: atomic_check enable=%d active=%d mode=%s\n",
+		       crtc->base.id, crtc_state->enable, crtc_state->active,
+		       crtc_state->mode.name[0] ? crtc_state->mode.name : "none");
+
+	if (!crtc_state->enable || !crtc_state->active)
+		return 0;
+
+	mixer_count = cstate->topology_mixer_count;
+	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
+		drm_dbg_atomic(crtc->dev,
+			       "CRTC%u: invalid mixer count %u (limit 1..%u)\n",
+				crtc->base.id, mixer_count, DCP_MAX_MIXERS);
+		return -EINVAL;
+	}
+
+	ret = dcp_crtc_setup_mixer_rois(crtc, crtc_state, cstate);
+	if (ret)
+		return ret;
+
+	if (crtc_state->adjusted_mode.hdisplay > dcp_kms->caps->max_width) {
+		drm_dbg_atomic(crtc->dev,
+			       "CRTC%u: mode width %d exceeds DCP max width %u\n",
+			       crtc->base.id,
+			       crtc_state->adjusted_mode.hdisplay,
+			       dcp_kms->caps->max_width);
+		return -E2BIG;
+	}
+
+	return 0;
+}
+
+static u32 dcp_crtc_get_vblank_counter(struct drm_crtc *crtc)
+{
+	return drm_crtc_vblank_count(crtc);
+}
+
+static bool dcp_crtc_get_vblank_timestamp(struct drm_crtc *crtc, int *max_error,
+					  ktime_t *vblank_time, bool in_vblank_irq)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	u64 timestamp_ns = READ_ONCE(dcp_crtc->hw_vblank_timestamp_ns);
+
+	if (!timestamp_ns)
+		return false;
+
+	*vblank_time = ns_to_ktime(timestamp_ns);
+	return true;
+}
+
+static void dcp_crtc_atomic_enable(struct drm_crtc *crtc,
+				   struct drm_atomic_commit *state)
+{
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	u32 session_id;
+	int ret;
+
+	if (!dcp_crtc_get_session(crtc, &session_id))
+		return;
+
+	ret = dcp_hfi_crtc_set_power_mode(dcp_kms->hfi, session_id,
+					  HFI_MODE_DPMS_ON);
+	if (ret) {
+		drm_err(crtc->dev, "CRTC%u: DPMS ON failed: %d\n",
+			to_dcp_crtc(crtc)->display_id, ret);
+		cstate->hfi_error = ret;
+	}
+
+	drm_crtc_vblank_on(crtc);
+}
+
+static void dcp_crtc_atomic_disable(struct drm_crtc *crtc,
+				    struct drm_atomic_commit *state)
+{
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	u32 session_id;
+	int ret;
+
+	if (dcp_crtc_get_session(crtc, &session_id)) {
+		ret = dcp_hfi_crtc_set_bw(dcp_kms->hfi, session_id, 0, 0, 0, 0, 0);
+		if (ret) {
+			drm_err(crtc->dev,
+				"CRTC%u: clearing bandwidth vote failed: %d\n",
+				to_dcp_crtc(crtc)->display_id, ret);
+			cstate->hfi_error = ret;
+		}
+
+		ret = dcp_hfi_crtc_set_power_mode(dcp_kms->hfi, session_id,
+						  HFI_MODE_DPMS_OFF);
+		if (ret) {
+			drm_err(crtc->dev, "CRTC%u: DPMS OFF failed: %d\n",
+				to_dcp_crtc(crtc)->display_id, ret);
+			cstate->hfi_error = ret;
+		}
+	}
+
+	drm_crtc_vblank_off(crtc);
+}
+
+static const struct drm_crtc_funcs dcp_crtc_funcs = {
+	.set_config             = drm_atomic_helper_set_config,
+	.page_flip              = drm_atomic_helper_page_flip,
+	.atomic_create_state    = dcp_crtc_atomic_create_state,
+	.atomic_duplicate_state = dcp_crtc_atomic_duplicate_state,
+	.atomic_destroy_state   = dcp_crtc_atomic_destroy_state,
+	.enable_vblank          = msm_crtc_enable_vblank,
+	.disable_vblank         = msm_crtc_disable_vblank,
+	.get_vblank_counter     = dcp_crtc_get_vblank_counter,
+	.get_vblank_timestamp   = dcp_crtc_get_vblank_timestamp,
+};
+
+static const struct drm_crtc_helper_funcs dcp_crtc_helper_funcs = {
+	.atomic_check         = dcp_crtc_atomic_check,
+	.atomic_enable        = dcp_crtc_atomic_enable,
+	.atomic_disable       = dcp_crtc_atomic_disable,
+	.atomic_begin         = dcp_crtc_atomic_begin,
+	.atomic_flush         = dcp_crtc_atomic_flush,
+	.mode_valid           = dcp_crtc_mode_valid,
+};
+
+struct drm_crtc *dcp_crtc_init(struct dcp_dpu_kms *kms,
+			       struct drm_plane *primary_plane,
+			       u32 display_id)
+{
+	struct drm_device *dev = kms->dev;
+	struct dcp_crtc *dcp_crtc;
+	int ret;
+
+	dcp_crtc = drmm_kzalloc(dev, sizeof(*dcp_crtc), GFP_KERNEL);
+	if (!dcp_crtc)
+		return ERR_PTR(-ENOMEM);
+
+	dcp_crtc->display_id = display_id;
+
+	spin_lock_init(&dcp_crtc->spin_lock);
+	init_waitqueue_head(&dcp_crtc->frame_done_wq);
+	atomic_set(&dcp_crtc->pending_kickoff_cnt, 0);
+
+	ret = drmm_crtc_init_with_planes(dev, &dcp_crtc->base,
+					 primary_plane, NULL,
+					 &dcp_crtc_funcs,
+					 NULL);
+	if (ret) {
+		drm_err(dev, "CRTC%u init failed: %d\n", display_id, ret);
+		return ERR_PTR(ret);
+	}
+
+	drm_crtc_helper_add(&dcp_crtc->base, &dcp_crtc_helper_funcs);
+
+	drm_dbg_driver(dev, "CRTC%u initialized\n", display_id);
+	return &dcp_crtc->base;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.h b/drivers/gpu/drm/msm/dcp/dcp_crtc.h
new file mode 100644
index 000000000000..b6a435a686c5
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP CRTC implementation.
+ */
+
+#ifndef __DCP_CRTC_H__
+#define __DCP_CRTC_H__
+
+#include <linux/completion.h>
+#include <linux/spinlock.h>
+
+#include <drm/drm_crtc.h>
+#include <drm/drm_rect.h>
+
+struct dcp_dpu_kms;
+struct drm_plane;
+
+#define DCP_MAX_MIXERS 6
+#define DCP_MAX_BLEND_STAGES 12
+
+struct dcp_crtc {
+	struct drm_crtc base;
+	u32 display_id;
+	u32 session_id;
+	/* Set after DISPLAY_ENABLE; cleared after display teardown. ID zero is valid. */
+	bool session_valid;
+
+	struct drm_pending_vblank_event *event;
+	wait_queue_head_t frame_done_wq;
+	atomic_t          pending_kickoff_cnt;
+	/* Protects CRTC-local vblank and commit state. */
+	spinlock_t        spin_lock;
+	u32     vblank_cb_count;
+	ktime_t vblank_cb_time;
+	/* Latest firmware-reported VSYNC timestamp; 0 until the first HFI VSYNC. */
+	u64     hw_vblank_timestamp_ns;
+	bool    enabled;
+	u32 commit_seq_id;
+	u32 pending_seq_id;
+};
+
+struct dcp_crtc_state {
+	struct drm_crtc_state base;
+
+	u32 topology_mixer_count;
+	u32 topology_bits_per_component;
+	struct drm_rect mixer_roi[DCP_MAX_MIXERS];
+
+	int hfi_error;
+	u64 bw_ctl;
+
+	u64 dram_ib;
+	u64 dram_ab;
+	u64 llcc_ib;
+	u64 llcc_ab;
+	u64 core_clk;
+};
+
+#define to_dcp_crtc(x)       container_of(x, struct dcp_crtc, base)
+#define to_dcp_crtc_state(x) container_of(x, struct dcp_crtc_state, base)
+
+struct drm_crtc *dcp_crtc_init(struct dcp_dpu_kms *kms,
+			       struct drm_plane *primary_plane,
+			       u32 display_id);
+
+void dcp_crtc_commit_kickoff(struct drm_crtc *crtc);
+void dcp_crtc_wait_for_commit_done(struct drm_crtc *crtc);
+void dcp_crtc_complete_commit(struct drm_crtc *crtc);
+int dcp_crtc_vblank(struct drm_crtc *crtc, bool enable);
+
+struct dcp_drv;
+void dcp_crtc_hfi_vblank_cb(struct dcp_drv *drv, u32 session_id, u64 timestamp_ns);
+void dcp_crtc_hfi_frame_done_cb(struct dcp_drv *drv, u32 session_id,
+				u32 sequence_id, u64 timestamp_ns);
+
+void dcp_crtc_set_session(struct drm_crtc *crtc, u32 session_id);
+void dcp_crtc_clear_session(struct drm_crtc *crtc);
+bool dcp_crtc_get_session(struct drm_crtc *crtc, u32 *session_id);
+void dcp_crtc_set_topology_state(struct drm_crtc_state *state,
+				 u32 mixer_count,
+				 u32 bits_per_component);
+
+#endif /* __DCP_CRTC_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
new file mode 100644
index 000000000000..44b1c2200aee
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * DCP KMS driver.
+ */
+
+#include <drm/drm_crtc.h>
+
+#include "dcp_dpu_kms.h"
+
+struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dcp_kms,
+				      u32 display_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < dcp_kms->num_crtcs; i++)
+		if (dcp_kms->crtcs[i].display_id == display_id)
+			return dcp_kms->crtcs[i].crtc;
+
+	return NULL;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
new file mode 100644
index 000000000000..f8010fc5d32f
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * DCP KMS state.
+ */
+
+#ifndef __DCP_DPU_KMS_H__
+#define __DCP_DPU_KMS_H__
+
+#include <linux/spinlock.h>
+
+#include "msm_drv.h"
+#include "msm_kms.h"
+
+struct dcp_hfi;
+struct dcp_caps;
+struct dcp_dsi_bridge;
+struct dcp_drv;
+struct drm_crtc;
+
+#define DCP_DPU_AUTOSUSPEND_DELAY_MS	5000
+#define DCP_DPU_MAX_CRTCS	4
+#define DCP_DPU_MAX_PLANES	12
+
+struct dcp_dpu_kms {
+	struct msm_kms		 base;
+	struct drm_device	*dev;
+	struct device		*pm_dev;
+	struct dcp_drv		*drv;
+	struct dcp_hfi		*hfi;
+	struct dcp_caps		*caps;
+	struct device_node	*dpus_np;
+	struct device		*iommu_dev;
+	bool			 rpm_enabled;
+	bool			 commit_pm_active;
+	struct dcp_dsi_bridge	*dsi_bridge[2];
+	struct {
+		struct drm_crtc *crtc;
+		u32 display_id;
+	} crtcs[DCP_DPU_MAX_CRTCS];
+	unsigned int num_crtcs;
+};
+
+#define to_dcp_dpu_kms(x) container_of(x, struct dcp_dpu_kms, base)
+struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dcp_kms,
+				      u32 display_id);
+int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dcp_kms,
+				     struct drm_crtc *crtc);
+
+int dcp_dpu_drm_obj_init(struct dcp_dpu_kms *dcp_kms);
+extern const struct msm_kms_funcs dcp_dpu_kms_funcs;
+int dcp_kms_init(struct drm_device *ddev);
+
+#endif /* __DCP_DPU_KMS_H__ */

-- 
2.43.0

