Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9BA606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kl3hjtqH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aqvWtxsl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356AA10E10D;
	Mon, 26 Oct 2026 06:24:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA7310EBEC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:32 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4arHF3303617
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aEFp7w2tgG6bRDJtDTShC/IAhrO3WLDIL2BdyzZpv7U=; b=Kl3hjtqHrbNM6nOj
 xuJncX+4ETr1rcO1gtaxpuptG70g6UsCA5K/Ynn7toA8YQqwLAy/rYiM47629XK5
 FrxT9GKcl4jIDO3QYrJjHf0rmW7/TBkxY8LNm27cc/2M+kLf9xUaMPfpZCKaksQ8
 kTGZOmq+fzP3GAf+oxwvMKa3fk4Iz2b83SLTGaxF/IgvbsijG8Pkz3eMB6OdnTfF
 BWFoH18dsmGDfLW6vSgthw1Cqs0lIw2PJ5Dgnr4AokMjLycCaSVw/rBAxdWIF8dt
 pp++/eEl7NDUU9zanBQvzCzqu4fe6xQ59iD9j83N7ZiGe6b9kjdz2eCctfkNST90
 iKJsPw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsd56n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd6969473a4so1573767a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792995871; x=1793600671;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aEFp7w2tgG6bRDJtDTShC/IAhrO3WLDIL2BdyzZpv7U=;
 b=aqvWtxslrqVq6vXtNOuIE2nan9zNnQa5Bdn6PwBz0BPQ3L+Rsn8OZ+LarS25E2vhBo
 kri0fKagqcEsLg+A/5pU54ZoQ9qsrDgFLJ1BEFlCyZE/CKerG9u31jhP001dP6Wsp9+E
 bWTNozZftu/4waQzFUsNzZdSHp6eb5vs9pyJ/YWJuoMK9Jxzxn7qb8L3XucaXkJ2kT4N
 8wEYZ61gF2MIwVacLIswxDauSKD7miKFTvLo2ibmGDJkBIqaAqR5BvzbYMvuCQVgUYk/
 rdmAvFIqrB6QSXtSFUJ2b0gW01UVfL1pqUvdDSZN2o5u1NeIEGtPdTDUinw2xpCgOdm2
 oonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792995871; x=1793600671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aEFp7w2tgG6bRDJtDTShC/IAhrO3WLDIL2BdyzZpv7U=;
 b=qiBSYkofOwUBBtL7n612enuSYUFOctADeLJ0dZE8P0dYcXuar2xbRaEpGIWQxqnJAE
 YTmLVlV+MN0iOTfYTI3M2xOEgsD8YMHwXJVCywajx7ALF6tKG0i92pzPRbNL6MSWRdIK
 xNo7qP+nvzrqEpapTbeklFCA0+FYGQ5dmic1Jj0wzMNSfFKwuUdPDiW8DgYzlM5jRzpG
 idcDphyV+q10ccEiIy760nZXzogsyCnKxlCabf7N/r7isGnMta5uaqXu0a8oREU8A5ib
 ToJEjuL5z/tBAfrBBeW+VEAi4Rtqcz4Ef7Dja3xCoTpEChTI/MImlvozYPZAm5fiG5o+
 vDhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPryFigWdr3LMApNnc3sUxYBzgH0coNW28BSGJV5cKaysHFVHiavrFuQ1Nzn4ZkSspMyVCjbDADUc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ5UkLl2O9CB+4K9Q9yEjf5Kg1EJSnbVvUjtGlJIfWVJx3ovKiY
 P3dgRukH3EvKn62h+Z8p33gnsiMd3QRutSk+DkzUyT9xxzpM5VZuEW1iN912wbVLi70FQAFtOZ8
 NWmelV41mepuSY4bXRB5dxi59IS64ZYhfWGEQDFmPNABRTi8GtPRTHTnd30RULbvY/UY1mP4=
X-Gm-Gg: AYBFou2K+9kHOrj1XnTA/DfwpYN22T54XE7YgyzI19ng2VNSo3H85HLdHaftK8kToO3
 MM0t9CNirFbiz2F9kFIfSmdmWd7OMeM9BNxKHGTECTQwYh7uQUZSRuvDqh22O/0mti/YZ7p8keh
 tN1iNS41SkSkOUzFSCRC7QY7HeLyHALRWSZiMMyOBbU3x1CmXmvPnKpLZjmO3gWXKKFJ7u+TNEu
 zIBx2HFKTxAkD3Cved6ZyGLFdlDySMMYDRO70MC6CnSeOQsYAG7PjdAQF9nfMv7l5XF+vCdMsmb
 eyb8sag3UGpiM/QxQDoSY3KRsXN4acSxp7V2x9ZGtyirc8NlCPS6E7kSljGrrFezOLuS4+jpynU
 iqERjz6ySOfz3LA7m74AZVwwtAAwVY7BPIw==
X-Received: by 2002:a17:903:3c30:b0:2e9:821a:5527 with SMTP id
 d9443c01a7336-2ea9c6c73a1mr46780295ad.12.1792995870981; 
 Sun, 25 Oct 2026 23:24:30 -0700 (PDT)
X-Received: by 2002:a17:903:3c30:b0:2e9:821a:5527 with SMTP id
 d9443c01a7336-2ea9c6c73a1mr46780015ad.12.1792995870524; 
 Sun, 25 Oct 2026 23:24:30 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 23:24:30 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:26 +0530
Subject: [PATCH v2 16/23] drm/msm/dcp: Integrate the DSI bridge with KMS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-16-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=4407;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=YkElIL2VP9q3UDs86ECzwDFEF/OyzmGpxHXTXDTkMBY=;
 b=dK6ojiOmJgJpI/PfAGPWySwWrv1PqCpsjGAfv4a+OAjHAZ2np/K6tzX6Lr5Vz7Q11ykgxlBBr
 N1hOZCgwbYoDaTZ7PMa47CbVwaPr/4ZRRrA8jHmArpW87PZxJe5Cdu/
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: XnnCO_qiRuB6OOFRCS2GmdfU7YjseTQg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXzB6986LvlP7N
 I1UdGFqGDU1k1OskmKU6t6cvUl7GRxQVcsSnikvXXeIm/7FWMAzyR77rIPPNxBG3KMrXOOmxYM7
 4G0I0W4qjUeRflZREVJarpHyQSwpU59mdXtP7K+lT6X7HWguVEprxoOcyNc/FXiMLn6y1V0Mwpj
 f3SOrhw7qOEUPx4AN6A76nfJdos2zGkb34wDVOF1uzzsiOTRv6IDB+itya9frkkUE9imjBAK4Xs
 giSwEUYHNQbQJiuIjveQnEIPSVBL8iAxKQNBC/vKafenK0vaYx2euoSRtcwK7A2uoQkTkc6v+z1
 Szk0FQRRghHo+C2cW98jQi0FPrQERyAOKdor/xiRCJMm+G8C4iQ3tm3CVN/PXiWSnrhj2nv0/Ql
 0EUiBihuicOaLKxbVPhuB+60QC10orZGKsFz12WJ5KHYUwmUGYrek/++pDyNOeE8mAAAfmlfifn
 VEHQtkFB6pXeK+jKbJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX3HLDMmpaNXDE
 SWrrLNZE95A1FAjLXUX/ZJ7I3zMNziilDzzlZNif1W/2YHmDqUGQPjm7Na9/g6i9I64m/bE7HDN
 yid87yMRUjQzngcuH4Bkr6EXN9xI8vU=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adef21f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=vhVORTM7vdiWvPRSmu0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: XnnCO_qiRuB6OOFRCS2GmdfU7YjseTQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260025
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
 drivers/gpu/drm/msm/dcp/dcp_crtc.c    | 14 ++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c | 40 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h |  2 ++
 3 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
index ec4f74c2920f..173a07df71c5 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_crtc.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
@@ -147,6 +147,12 @@ static void dcp_crtc_atomic_begin(struct drm_crtc *crtc,
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
@@ -559,6 +565,7 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
 	const struct drm_plane_state *pstate;
 	u32 max_width, max_height;
 	u32 mixer_count;
+	bool needs_dirtyfb;
 	int num_planes = 0;
 	int ret;
 
@@ -569,6 +576,8 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
 	if (!crtc_state->enable || !crtc_state->active)
 		return 0;
 
+	needs_dirtyfb = dcp_dpu_kms_needs_dirtyfb(dcp_kms, crtc);
+
 	mixer_count = cstate->topology_mixer_count;
 	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
 		drm_err(crtc->dev,
@@ -598,8 +607,13 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
 
 	/* Limit visible planes to the firmware blend-stage count. */
 	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
+		struct dcp_plane_state *dcp_pstate;
+
 		if (!pstate || !pstate->visible)
 			continue;
+
+		dcp_pstate = to_dcp_plane_state((struct drm_plane_state *)pstate);
+		dcp_pstate->needs_dirtyfb = needs_dirtyfb;
 		num_planes++;
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

