Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C2606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WVcKJHuh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bCUevNDS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3B410FB23;
	Thu, 26 Nov 2026 06:31:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED0410FB23
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:38 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36J7r1812751
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8N2yw0oLQ/TLTex0f5pxG2rL1Y8/RESC3ZsVZhW0BJM=; b=WVcKJHuh+DMfseRs
 QX1GtNjjKqiWQqxH1ODptt3bRovpf5U7YUhCcUy53PM2xp3uors1bODMEjuj1Km7
 IOGZD7gsSJqHKT03PLJqcBu3x5MHuMnPixl9050NeX6hGEjdIgblBRepvs+CT6pa
 H9H0JUCbHeJgwJJdRhdG1Ae2Qqu1b63vvZkEGEGzWm+WvzIPUpTvVTZSAkRqKbhk
 LZl94yjBr8AgTFdrork7PqLgatoznJtZl+Ys7xcS2VsjhPi0Fq/o5FnqGYTmIr28
 x8l0LziacoDyYR4pZkAGiMSA12f8q1B7qsZgj9vxKodI9qJMgRX5jqN3dtZqvNtS
 3WbE2Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak00x55-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2f0717e54b0so45088975ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674696; x=1796279496;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8N2yw0oLQ/TLTex0f5pxG2rL1Y8/RESC3ZsVZhW0BJM=;
 b=bCUevNDSnFdZZOaZkY6tyHSuNBZd+Un16792weYQosSsgs8k/08ntfhwR+iEKd37VT
 V4c1+ZJVhCk8EIPGqnEf7QrjTddPL6OcY+6oarYhzx8BU5AgHDCmJO5KYa1EuS9+M1n1
 Jwl+nkDGu4hedZ7hgv6CD4iyvlT3VyttwUJQ6YttqIWQn325iYvgQfIaieWnSAt/Gpo3
 dVSJHq8I5iy41JQEHwCr+BCwE2+C/4OVyqQeQ0TXFjPgwGmAtioHDxzubSUAduI2uyjs
 wP/rCME84IvLs2oqTuZyQ/cBXK29IV/aXJPaWMaiwJ5dSEfihR7RiAAduNQKake0aOkB
 2kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674696; x=1796279496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8N2yw0oLQ/TLTex0f5pxG2rL1Y8/RESC3ZsVZhW0BJM=;
 b=mE9CjAN98BlC9laMnmF3intDkyphAVZgx8scPBYU54+MNX24a8q8fu8LzTkRmIxYVH
 cWfErd68sJXH9CUHesNF5h/jkdxuBaod3vlUPAwUn3ysmEUDGinKitaFaclDQ7UHon/n
 MYLHMmNXsXMZHIhG9ngbFomJYrtc32LpLiwEhG9q+MGMGzZ50XRjE/N2jTmtkLB8/HRD
 9ac2w/6jC7pIru/ZY1/jn+v8AGUmyKoxb2wpAgQXERy0sQYzrpgIvXXZ2d+dIu2+DnQx
 xF8kYM+nJeNCRSwemiqt5a9o2ROhh10u1h9+YIC+7jeSGnTIsGChXSmLOwOLR/QPqI9J
 shiA==
X-Forwarded-Encrypted: i=1;
 AL+hErFC+6LB+9qKz+rrDrQ/o8pTFyCrOzk5Pq1/+8UD/fcp3icUz0OOxwcmmX/jLtcR4qtWIzTWSvTB0LI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8AtsGgGfSlexn3eFWO+2BtZUO5h9FPrp+4Q8QQm0TqFXBSG96J
 bVHe/yNclUfwweyXdg1Dxwn3HQpRxWv5qcxNrjjH6UdPA5LV1KvH8d+twRz24kHIsMtIY1V3Rlg
 /liZLx0rjswdB8ePUT8LbHcDro2yWysZRx1fSvRM4QozPIJjEnnSg6VJFE++SAY+sMUWc2U0=
X-Gm-Gg: AZFdTZdtMOHBMnKBM3tiKtfjl60Hn8asqQdLPttrL+OuEQEbP/4s2/IdCF1FerV0WQe
 Jc6etjXT2DJsE0BjMfL6chRXNj03zW+qkdFO37SwbsDEc2shxqJEnwEmOeBBQDOPSSuMoojHLLP
 ngfXq0wbBxM3LKfwakPhPgnLoGELDudrFv1cumfI4ic9jsrOr7hWHhXKb9QgNjJ50CpGRSOkS1K
 Slrv/KbZcvwI2Lkgaba7zStztqdkbNx0SujMhmjkeKFTkbLXvPbzxgBEBQLBuWt6e/uF8FCs9x9
 vu2Z+PVwsmAxtKJDLr/hH437g2ay22hN1HsKD5s65ey5mN9yXZb9hc7LeZTXe/0FN2K735KYf9V
 XOmXGxVkS4ahtffIUTdr3QWLZyMCxI3koL2zeFAlE138SiAGxgjzuo4Jb0amPgGHFP0e7pByGWZ
 qNBeWjkGjI
X-Received: by 2002:a17:902:e807:b0:2ef:ee1b:8e52 with SMTP id
 d9443c01a7336-2f03f1a4a23mr203555065ad.32.1795674696240; 
 Wed, 25 Nov 2026 22:31:36 -0800 (PST)
X-Received: by 2002:a17:902:e807:b0:2ef:ee1b:8e52 with SMTP id
 d9443c01a7336-2f03f1a4a23mr203554775ad.32.1795674695754; 
 Wed, 25 Nov 2026 22:31:35 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:31:35 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:23 +0530
Subject: [PATCH v3 15/21] drm/msm/dcp: Integrate the DSI bridge with KMS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-15-f1e9d7505039@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=4768;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=oh3IUL02t6aGFSKjrhDtJnQnen66NES1sHfBcS8WaPU=;
 b=N14igswgNEGw3maGVWKUQECTJPPBwrV/pfLL6ppSPDeeeF2JKUeqOi2iZiZyuv3+nZcDAd7Ho
 B5Pkx92gRFMDOAvXD8ZVsLkVaHX1kGUGRH/zgUpkBJNqf72KpO8lrjd
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b07d249 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_pBgebsfWxT5-yjw7VoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Ag-G1iMkXfI31969SHMRVvR7Rprx5a8V
X-Proofpoint-GUID: Ag-G1iMkXfI31969SHMRVvR7Rprx5a8V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX3NW9HOwNKcLv
 gDBhsi8UiZG7F9/k25w5wyxJH08ezLm5rxqe8/yP9GByzApBmEsWJ+RW7nf6YxlNpiOj4a/hnzb
 VanUeqsCmFkFqtnWKvJuIOnwbkvyH+FfUWgHmCwJNRTt/Q7i/RqxVX6gsaR70Z6og/sF6D0VNKF
 KuofXWICraniKtHw9KpFM0VtRFMGz2TvYLv41ETIczowLNJbJ2PFRLa2fptjr71idYTZd1I+yyR
 rV4UDn6D/SIKBtIX6HcJb7+ReN9yZ50OgneKcBQWrHTbI3jgujHqZu8kX8WxGkWWXDgj67DPp7Y
 Grt4P8/5mQmmvdfJFoigyk3KPdkalKinpFM0TsOlnQCC07AR9RKoHw7NqcpTvBhLebryEYWmrfn
 eEAEtIkBfJfhHeKicVHp+MXViQZZKjIbHAJnNzpswmgAYQo4Erakp0zrGxx2jiQvp8K/7NveO/F
 QEO4MLfsO+9L8J0WX5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXygpiQOjSw/Xb
 AUGWB+myY+JPZRahj7rTX35XKFaVjPF9VlFgDN05yObjCSnyQyTCy83NixE8xtLXpPDcwhWDwc7
 O8WU2OGJFTYlG4NxQZG5yoAA79SQHn0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
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

Connect the DCP DSI host and panel bridge to the DCP KMS
pipeline. Without bridge integration, DRM cannot create display
sessions, attach connectors, or run the bridge enable and disable
sequence for atomic commits.

Set up and tear down the bridge and CRTC relationship, pass panel
configuration through KMS, and connect bridge-backed display operations
to the DCP HFI commands.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dcp/dcp_crtc.c    | 21 ++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c | 40 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h |  2 ++
 3 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
index f58667ca458e..a79bf9189e74 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_crtc.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
@@ -24,6 +24,7 @@
 #include "dcp_drv.h"
 #include "dcp_hfi.h"
 #include "dcp_dpu_kms.h"
+#include "dcp_plane_state.h"
 
 #include "hfi/hfi_defs_display.h"
 #include "hfi/hfi_properties_display.h"
@@ -149,6 +150,12 @@ static void dcp_crtc_atomic_begin(struct drm_crtc *crtc,
 		return;
 	}
 
+	ret = dcp_dpu_kms_prepare_crtc_session(dcp_kms, crtc);
+	if (ret) {
+		cstate->hfi_error = ret;
+		return;
+	}
+
 	if (!dcp_crtc_get_session(crtc, &session_id)) {
 		cstate->hfi_error = -ENODEV;
 		return;
@@ -541,6 +548,9 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
 		drm_atomic_get_new_crtc_state(state, crtc);
 	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc_state);
 	u32 mixer_count;
+	struct drm_plane *plane;
+	const struct drm_plane_state *pstate;
+	bool needs_dirtyfb;
 	int ret;
 
 	drm_dbg_atomic(crtc->dev, "CRTC%u: atomic_check enable=%d active=%d mode=%s\n",
@@ -550,6 +560,8 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
 	if (!crtc_state->enable || !crtc_state->active)
 		return 0;
 
+	needs_dirtyfb = dcp_dpu_kms_needs_dirtyfb(dcp_kms, crtc);
+
 	mixer_count = cstate->topology_mixer_count;
 	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
 		drm_dbg_atomic(crtc->dev,
@@ -572,6 +584,15 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
 	}
 
 	dcp_crtc_aggregate_bw(crtc_state, true);
+	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
+		struct dcp_plane_state *dcp_pstate;
+
+		if (!pstate->visible)
+			continue;
+
+		dcp_pstate = to_dcp_plane_state((struct drm_plane_state *)pstate);
+		dcp_pstate->needs_dirtyfb = needs_dirtyfb;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
index 44b1c2200aee..61a4d8565359 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
@@ -7,6 +7,27 @@
 #include <drm/drm_crtc.h>
 
 #include "dcp_dpu_kms.h"
+#include "dcp_dsi_bridge.h"
+
+int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dcp_kms,
+				     struct drm_crtc *crtc)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		struct dcp_dsi_bridge *bridge = dcp_kms->dsi_bridge[i];
+
+		if (!bridge)
+			continue;
+		if (dcp_dpu_kms_get_crtc(dcp_kms, bridge->fw_display_id) != crtc)
+			continue;
+
+		return dcp_dsi_bridge_prepare_session(bridge,
+						      &crtc->state->adjusted_mode);
+	}
+
+	return -ENODEV;
+}
 
 struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dcp_kms,
 				      u32 display_id)
@@ -19,3 +40,22 @@ struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dcp_kms,
 
 	return NULL;
 }
+
+bool dcp_dpu_kms_needs_dirtyfb(struct dcp_dpu_kms *dcp_kms,
+			       struct drm_crtc *crtc)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		struct dcp_dsi_bridge *bridge = dcp_kms->dsi_bridge[i];
+
+		if (!bridge ||
+		    dcp_dpu_kms_get_crtc(dcp_kms, bridge->fw_display_id) != crtc)
+			continue;
+
+		return bridge->dsi_device &&
+			!(bridge->dsi_device->mode_flags & MIPI_DSI_MODE_VIDEO);
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
index f8010fc5d32f..333567a78ad7 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
@@ -44,6 +44,8 @@ struct dcp_dpu_kms {
 #define to_dcp_dpu_kms(x) container_of(x, struct dcp_dpu_kms, base)
 struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dcp_kms,
 				      u32 display_id);
+bool dcp_dpu_kms_needs_dirtyfb(struct dcp_dpu_kms *dcp_kms,
+			       struct drm_crtc *crtc);
 int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dcp_kms,
 				     struct drm_crtc *crtc);
 

-- 
2.43.0

