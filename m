Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0269606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j/HMIH1f;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eI7auzLY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4164710FB8B;
	Thu, 26 Nov 2026 06:31:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ACDC10FB8B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:46 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36WPX1647554
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aJXANNDzHBOXDx+TKd+4eWdvv//EoRiF6SepydzEvJo=; b=j/HMIH1fGAPo+aEV
 5UDm6w82VUlnhWriUCYbJpzHP98SkxW8i2Vryt6xtWhg4wnTm+xJaSCfNSuqnCeh
 m3Q8tbt8fYVVZaeyb0mWBTfoGdYD+6s083GoT0BQtIF5tZ4kbqrp4L2zPYwTlJVe
 dDQmz6mbM6iJTH2usWV3SUUhfgL9TOzsapfLl1S3TcOfJ/SKklC+i8RHht8jZRHk
 ceJeEdumrCB+ntxVFLTsvGJSxaNZUGVOK46I90ClAl5m2e+dWN6IvX9j+by72kJb
 F1YFQMDVxnBVZB+worM+DbkuEP0bM/F2kNQ9teXZQ+tluBTkpA7fLcKh9CTOMeP0
 cLFZSw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahu2d3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2f09a37f41dso38310305ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674705; x=1796279505;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aJXANNDzHBOXDx+TKd+4eWdvv//EoRiF6SepydzEvJo=;
 b=eI7auzLYy7I3DqtJyz/0+8kEktmkRlzzrUBAUwgrKhy0n9uflqkQVoMOhFlp722oQ+
 ohSyoJP3NK2uG+3FycGXn132OKkJpst6Tw8fyqKVYywHR/Gkr8Ol85ZKk2ht31iNzMvA
 sZ5fFUB1BtUQsqQ1w+Ypx6wCA2pY2owHuCwdOOzk/J3ze5LIvczxDIIcpVaUJeR9cnmi
 FW8JtkKKXHpKk9UkNqw4rqJFdhRFZ9knDRNAKIV7b4Cs5QuJHDkBxL7+wQj+OcJuEttf
 zkxehZRrfQHuCkptZ8t6jXjwOBgHcFOkz3MkRXDdu9bkIE1bnqL6rEF3OqVshVDyQEcP
 r5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674705; x=1796279505;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aJXANNDzHBOXDx+TKd+4eWdvv//EoRiF6SepydzEvJo=;
 b=IjowXydTNH4FpIubdfDN9899OusROxST7D14Szy7GkKCr16Nch+tPjaomnbT34M7oT
 ID21pHtQCiRh7s9D2cVhQVcoxENxrxmTCfWBb27NjdjJwIGYzdc2opdYfeIuaJ7pAv1/
 J62cMPC1fwoVWFtTmpjf0CG6xbcvMykoThxlhzSCXSdYaUsdtHEaEFiEZNCJVa8zZdX7
 HuzmQy2LsvcSgl3JpHjisZ1MsdCHQ14nbGQC8vC0pqh9aQ38aT+RgRUzsM43NiI2FJ/F
 Y8Hayc0p9AMFdFtCHQQvhDBYh2siUDfKUNxBKMzIPB1N+FjtVOMZO8kWA92jRoTD5sSd
 zaYw==
X-Forwarded-Encrypted: i=1;
 AL+hErGwUo82BxQaiHTeRU70nofv503Pc+j4knPDQ2kkzFjZDsnHWJPwTLqN8QfuCpWAjIEqQSm3qMALV4Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+YLFYYicrrP99hv/muS2QPj2qZABcN+GhLmqOqGxht4pxCWvm5
 Qomk0yMoZL9SSpQLMvpbYh9gqPcfcC4lNYBqVfhJBLK/ggiDv8uNRsfnDM2zPAHrq+RJPw30PzY
 qsdRWvzPizLU+ez8USpZUjVZtC0VISQzBBoTysMw4XfLTfc4B0RKg6jrmHKXKdLhAMZEPspc=
X-Gm-Gg: AZFdTZdYQA/z45E8ndwn9JIYNVO7hgnRjLMA7fEGUuBi5WQwnms00yqolgzvwsgCrgx
 e4hPla+Vkg3UivgbNcS3hBA6oc41CmzwXRhtp5J89S7AKFG/bKC5eMMXgNvl2xx5AFojVKEKNRV
 ZVzNmKYFQouBInyA7OzUvECkpL8g8euOLln1MVVd4CZIPZIaWBTUqTHRxxMrfblX6bKqT3HB8cA
 BUmSDm88aOlE9SjP2yPwSGdEf8qxx95KRbc64CiUFa/mvyuftB8zKkRjSM6h6gk163eJFu0zOmL
 c4wv1AfG8dZ6d0UhZEq1rYP9GWGOc6IT/2vWCCkfEOwoaYyQ/h9EUmpi8HJJUvJc+BCLLWPUAK7
 +qggm3mTyP6D6WE4fdDOhQIU6KtB38FZxtZEtK+5QFcdWm7NhQuJOaioPWeiN0ogHHXYOW/8y+w
 G83kNWZROT
X-Received: by 2002:a17:902:f545:b0:2f0:3123:8995 with SMTP id
 d9443c01a7336-2f03f1e856dmr233012645ad.22.1795674704950; 
 Wed, 25 Nov 2026 22:31:44 -0800 (PST)
X-Received: by 2002:a17:902:f545:b0:2f0:3123:8995 with SMTP id
 d9443c01a7336-2f03f1e856dmr233012205ad.22.1795674704329; 
 Wed, 25 Nov 2026 22:31:44 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:31:43 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:24 +0530
Subject: [PATCH v3 16/21] drm/msm/dcp: Register DCP display pipeline
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-16-f1e9d7505039@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=20054;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=8q6paXqbGLwkQpMdoyJi+8NAaouZKa9HWKgRCokHMmw=;
 b=qsDkVYdjZRUpBVkkHCD1ra2o3lfKsWMOYgR3x/1COQB5BpGro3uLyYZ/eeuwz1qLsbtqJfSyj
 vd713g0jvy9BZOXOGdTACzqCKwk8jn/ZM1olA2Mm4Vukr0v+F0kq6y5
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: 8SU--kIU2bNdxeD-gtyNLiNvRlE9urq2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX1yIl820ke3Ba
 Lvkd9KykWofpcbLdcf7TDM775V66Ixnkdkguy96mZHSCNHF6a8I9wxM+YqrTZYtd1vjArMcKILm
 V8xPIfgYyUuSMrJZECQy5DshHJc26GQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXytOvi1MRBwvG
 g1Do2PqhW52Vdm8ubbhGJgQ/eVskSB9rBQ00x99zEBE3lWxNrN6WWhulgLtlBqhyPo37mPgruXx
 mRHzaxgykXOpAvgIb2RoC2WtT58uODNu8ZGx81YVN71mWhVAJZSTxzoOGSKGAhUcBN5SYxhadT8
 MVseA3aPonxcfdNLrV5ASTZi/GQu9DCDJAlq+YqNXbaanD5+y5w3KwTIabAN+sBdsacq89IDd/G
 vihajlLQm0f9SNcNsW2djUh0gHfGgQZLkM3j4JPadk+JaVVUB6tPmZd1Pop5fMP16nznKRRI7V8
 gAal8VXOC9iP7DI/nynfNqhDerAXZwJ2W+Fqdep9X20llYyxP4Zm58Ma+aPrIaHXu6bkTI30xuy
 AzpgL01/2d4R+qr2ktHCPCcx2drhfhQOsnnzqXxCUQJ7RxQoOQ+2rz2SMs2LVR2Urs3NkoaJ8TX
 MKd5nUKMLSoujp47WmQ==
X-Proofpoint-ORIG-GUID: 8SU--kIU2bNdxeD-gtyNLiNvRlE9urq2
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b07d251 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=O7Cj744LGNAf-SsC5jEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
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

Register the DCP display pipeline from firmware capabilities and
the device-tree display graph. DCP exposes display resources through
firmware rather than host-visible display registers, so KMS objects
cannot be registered from a static hardware catalog alone.

Integrate power and IOMMU setup, parse capabilities and display
graph data, and create the DRM planes, CRTCs, encoders, bridges,
and connectors used by the DCP backend.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c | 647 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h |   6 +-
 2 files changed, 652 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
index 61a4d8565359..a8c04022d6cd 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
@@ -4,10 +4,29 @@
  * DCP KMS driver.
  */
 
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/pm_runtime.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_of.h>
+#include <drm/drm_plane.h>
+
+#include "msm_drv.h"
+#include "msm_gem.h"
+#include "msm_kms.h"
 
 #include "dcp_dpu_kms.h"
 #include "dcp_dsi_bridge.h"
+#include "dcp_crtc.h"
+#include "dcp_drv.h"
+#include "dcp_encoder.h"
+#include "dcp_hfi.h"
+#include "dcp_plane.h"
 
 int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dcp_kms,
 				     struct drm_crtc *crtc)
@@ -59,3 +78,631 @@ bool dcp_dpu_kms_needs_dirtyfb(struct dcp_dpu_kms *dcp_kms,
 
 	return false;
 }
+
+void dcp_dpu_kms_cleanup_bridges(struct dcp_dpu_kms *dcp_kms)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		if (!dcp_kms->dsi_bridge[i])
+			continue;
+
+		dcp_dsi_bridge_cleanup(dcp_kms->dsi_bridge[i]);
+		dcp_kms->dsi_bridge[i] = NULL;
+	}
+}
+
+static void dcp_dpu_kms_dump_caps(struct dcp_dpu_kms *dcp_kms)
+{
+	const struct dcp_caps *caps = dcp_kms->caps;
+	u32 i;
+
+	drm_dbg_driver(dcp_kms->dev, "DCP caps: hw=%u.%u fw=%u displays=%u\n",
+		       caps->dcp_hw_rev, caps->hw_rev, caps->fw_rev,
+		       caps->num_displays);
+	drm_dbg_driver(dcp_kms->dev, "DCP caps: max_planes=%u max=%ux%u\n",
+		       caps->max_planes, caps->max_width, caps->max_height);
+
+	drm_dbg_driver(dcp_kms->dev, "DCP caps: VIG pipes=%u virt=%u\n",
+		       caps->num_vig_pipes, caps->virt_vig_count);
+	for (i = 0; i < min_t(u32, caps->num_vig_pipes,
+			      DCP_MAX_SSPP_COUNT); i++)
+		drm_dbg_driver(dcp_kms->dev, "DCP caps: VIG[%u] pipe=%u r1=%u\n", i,
+			       caps->vig_pipe_ids[i], caps->vig_r1_indices[i]);
+
+	drm_dbg_driver(dcp_kms->dev, "DCP caps: DMA pipes=%u virt=%u\n",
+		       caps->num_dma_pipes, caps->virt_dma_count);
+	for (i = 0; i < min_t(u32, caps->num_dma_pipes,
+			      DCP_MAX_SSPP_COUNT); i++)
+		drm_dbg_driver(dcp_kms->dev, "DCP caps: DMA[%u] pipe=%u r1=%u\n", i,
+			       caps->dma_pipe_ids[i], caps->dma_r1_indices[i]);
+
+	drm_dbg_driver(dcp_kms->dev, "DCP caps: DSI count=%u\n", caps->dsi_count);
+}
+
+static int dcp_dpu_kms_hw_init(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+	struct drm_device *dev = dcp_kms->dev;
+	struct drm_gpuvm *vm;
+	unsigned int i;
+	int ret;
+
+	kms->irq = IRQ_NOTCONNECTED;
+	dev->mode_config.cursor_width  = 512;
+	dev->mode_config.cursor_height = 512;
+
+	ret = pm_runtime_resume_and_get(dcp_kms->pm_dev);
+	if (ret < 0) {
+		drm_err(dev, "failed to enable power: %d\n", ret);
+		return ret;
+	}
+
+	vm = msm_kms_init_vm(dev, NULL);
+	if (IS_ERR(vm)) {
+		drm_err(dev, "SMMU/IOMMU init failed: %pe\n", vm);
+		ret = PTR_ERR(vm);
+		goto err_cleanup;
+	}
+	kms->vm = vm;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		if (!dcp_kms->dsi_bridge[i])
+			continue;
+
+		ret = dcp_dsi_bridge_map_buffers(dcp_kms->dsi_bridge[i]);
+		if (ret) {
+			drm_err(dev, "failed to map DSI%u DCS buffers: %d\n", i, ret);
+			goto err_cleanup;
+		}
+	}
+
+	if (!dcp_kms->hfi) {
+		drm_err(dev, "HFI unavailable, cannot initialize DCP KMS\n");
+		ret = -ENODEV;
+		goto err_cleanup;
+	}
+	if (!dcp_kms->caps) {
+		drm_err(dev, "DCP caps unavailable, cannot initialize DCP KMS\n");
+		ret = -ENODEV;
+		goto err_cleanup;
+	}
+
+	dcp_dpu_kms_dump_caps(dcp_kms);
+
+	dev->mode_config.min_width  = 0;
+	dev->mode_config.min_height = 0;
+	dev->mode_config.max_width  = max(dcp_kms->caps->max_width,
+					  dcp_kms->caps->max_height);
+	dev->mode_config.max_height = dev->mode_config.max_width;
+	dev->max_vblank_count = 0xffffffff;
+	dev->vblank_disable_immediate = true;
+
+	ret = dcp_dpu_drm_obj_init(dcp_kms);
+	if (ret) {
+		dev_err_probe(dev->dev, ret, "DRM object init failed\n");
+		goto err_cleanup;
+	}
+
+	pm_runtime_put_autosuspend(dcp_kms->pm_dev);
+	drm_dbg_driver(dev, "DCP hw_init complete\n");
+	return 0;
+
+err_cleanup:
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		if (dcp_kms->dsi_bridge[i])
+			dcp_dsi_bridge_unmap_buffers(dcp_kms->dsi_bridge[i]);
+	}
+
+	if (kms->vm) {
+		struct msm_gem_vm *msm_vm = to_msm_vm(kms->vm);
+
+		if (msm_vm->mmu && msm_vm->mmu->funcs->detach)
+			msm_vm->mmu->funcs->detach(msm_vm->mmu);
+		drm_gpuvm_put(kms->vm);
+		kms->vm = NULL;
+	}
+	pm_runtime_put_autosuspend(dcp_kms->pm_dev);
+	return ret;
+}
+
+static void dcp_dpu_kms_enable_commit(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dcp_kms->pm_dev);
+	if (ret < 0) {
+		dcp_kms->commit_pm_active = false;
+		drm_err_ratelimited(dcp_kms->dev,
+				    "pm_runtime_resume_and_get failed: %d\n",
+				    ret);
+		return;
+	}
+
+	dcp_kms->commit_pm_active = true;
+}
+
+static void dcp_dpu_kms_disable_commit(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+
+	if (dcp_kms->commit_pm_active) {
+		pm_runtime_put_autosuspend(dcp_kms->pm_dev);
+		dcp_kms->commit_pm_active = false;
+	}
+}
+
+static int dcp_dpu_kms_check_mode_changed(struct msm_kms *kms,
+					  struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *new_crtc_state, *old_crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
+				      new_crtc_state, i) {
+		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
+			continue;
+		if (!new_crtc_state->active)
+			continue;
+		new_crtc_state->planes_changed = true;
+	}
+
+	return 0;
+}
+
+static void dcp_dpu_kms_flush_commit(struct msm_kms *kms, unsigned int crtc_mask)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(dcp_kms->dev, crtc, crtc_mask) {
+		if (!crtc->state || !crtc->state->active)
+			continue;
+		dcp_crtc_commit_kickoff(crtc);
+	}
+}
+
+static void dcp_dpu_kms_wait_flush(struct msm_kms *kms, unsigned int crtc_mask)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(dcp_kms->dev, crtc, crtc_mask)
+		dcp_crtc_wait_for_commit_done(crtc);
+}
+
+static void dcp_dpu_kms_complete_commit(struct msm_kms *kms, unsigned int crtc_mask)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(dcp_kms->dev, crtc, crtc_mask)
+		dcp_crtc_complete_commit(crtc);
+}
+
+static int dcp_dpu_kms_enable_vblank(struct msm_kms *kms, struct drm_crtc *crtc)
+{
+	return dcp_crtc_vblank(crtc, true);
+}
+
+static void dcp_dpu_kms_disable_vblank(struct msm_kms *kms,
+				       struct drm_crtc *crtc)
+{
+	dcp_crtc_vblank(crtc, false);
+}
+
+static void dcp_dpu_kms_destroy(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+
+	dcp_dpu_kms_cleanup_bridges(dcp_kms);
+
+	if (kms->vm) {
+		struct msm_gem_vm *msm_vm = to_msm_vm(kms->vm);
+
+		if (msm_vm->mmu && msm_vm->mmu->funcs->detach) {
+			drm_dbg_driver(dcp_kms->dev,
+				       "detaching IOMMU domain from dcp-dpus\n");
+			msm_vm->mmu->funcs->detach(msm_vm->mmu);
+		}
+
+		drm_gpuvm_put(kms->vm);
+		kms->vm = NULL;
+	}
+
+	if (dcp_kms->rpm_enabled) {
+		pm_runtime_disable(dcp_kms->pm_dev);
+		dcp_kms->rpm_enabled = false;
+	}
+
+	msm_kms_destroy(&dcp_kms->base);
+}
+
+static void dcp_dpu_kms_irq_preinstall(struct msm_kms *kms) {}
+static void dcp_dpu_kms_irq_uninstall(struct msm_kms *kms) {}
+
+static irqreturn_t dcp_dpu_kms_irq(struct msm_kms *kms)
+{
+	return IRQ_NONE;
+}
+
+static void dcp_dpu_kms_snapshot(struct msm_disp_state *disp_state,
+				 struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+
+	drm_dbg_driver(dcp_kms->dev,
+		       "DCP snapshot: max %ux%u\n",
+		       dcp_kms->caps->max_width,
+		       dcp_kms->caps->max_height);
+}
+
+const struct msm_kms_funcs dcp_dpu_kms_funcs = {
+	.hw_init            = dcp_dpu_kms_hw_init,
+	.irq_preinstall     = dcp_dpu_kms_irq_preinstall,
+	.irq_uninstall      = dcp_dpu_kms_irq_uninstall,
+	.irq                = dcp_dpu_kms_irq,
+	.enable_commit      = dcp_dpu_kms_enable_commit,
+	.disable_commit     = dcp_dpu_kms_disable_commit,
+	.check_mode_changed = dcp_dpu_kms_check_mode_changed,
+	.flush_commit       = dcp_dpu_kms_flush_commit,
+	.wait_flush         = dcp_dpu_kms_wait_flush,
+	.complete_commit    = dcp_dpu_kms_complete_commit,
+	.enable_vblank      = dcp_dpu_kms_enable_vblank,
+	.disable_vblank     = dcp_dpu_kms_disable_vblank,
+	.destroy            = dcp_dpu_kms_destroy,
+	.snapshot           = dcp_dpu_kms_snapshot,
+};
+
+static u32 dcp_dpu_kms_resolve_fw_display_id(struct dcp_dpu_kms *dcp_kms,
+					     u32 dsi_idx)
+{
+	const struct dcp_caps *caps = dcp_kms->caps;
+	u32 count;
+	const u32 *ids;
+	u32 id;
+
+	count = caps->dsi_count;
+	ids = caps->dsi_indices;
+
+	if (dsi_idx >= count) {
+		drm_err(dcp_kms->dev,
+			"DSI%u: no catalog entry (%u)\n", dsi_idx, count);
+		return U32_MAX;
+	}
+
+	id = ids[dsi_idx];
+
+	if (id > 0xFF) {
+		drm_err(dcp_kms->dev,
+			"DSI%u: catalog id 0x%x exceeds 8-bit range\n",
+			dsi_idx, id);
+		return U32_MAX;
+	}
+
+	return id;
+}
+
+int dcp_dpu_kms_init_dsi_bridges(struct dcp_dpu_kms *dcp_kms,
+				 struct component_match **matchptr)
+{
+	struct device_node *dpu_np = dcp_kms->dpus_np;
+	struct device_node *ep_np, *dsi_np, *child_np, *proto_np;
+	struct of_endpoint ep;
+	int ret;
+
+	for_each_of_graph_port(dpu_np, port_np) {
+		u32 intf_idx, dsi_idx, fw_display_id;
+		struct drm_bridge *bridge;
+
+		ep_np = of_get_next_child(port_np, NULL);
+		if (!ep_np)
+			continue;
+
+		ret = of_graph_parse_endpoint(ep_np, &ep);
+		of_node_put(ep_np);
+		if (ret)
+			continue;
+
+		intf_idx = ep.port;
+		dsi_np = NULL;
+		for_each_available_child_of_node(dpu_np, child_np) {
+			u32 reg;
+
+			if (!of_node_name_prefix(child_np, "interface") ||
+			    of_property_read_u32(child_np, "reg", &reg) ||
+			    reg != intf_idx)
+				continue;
+
+			for_each_available_child_of_node(child_np, proto_np) {
+				if (!of_node_name_prefix(proto_np, "dsi") ||
+				    of_property_read_u32(proto_np, "reg", &dsi_idx))
+					continue;
+
+				dsi_np = of_node_get(proto_np);
+				break;
+			}
+			of_node_put(proto_np);
+			break;
+		}
+		of_node_put(child_np);
+		if (!dsi_np)
+			return -ENODEV;
+
+		if (dsi_idx >= ARRAY_SIZE(dcp_kms->dsi_bridge)) {
+			of_node_put(dsi_np);
+			return -E2BIG;
+		}
+
+		if (dcp_kms->dsi_bridge[dsi_idx]) {
+			drm_err(dcp_kms->dev,
+				"multiple INTFs refer to DSI%u\n", dsi_idx);
+			of_node_put(dsi_np);
+			return -EINVAL;
+		}
+
+		fw_display_id =
+			dcp_dpu_kms_resolve_fw_display_id(dcp_kms, dsi_idx);
+		if (fw_display_id == U32_MAX) {
+			of_node_put(dsi_np);
+			return -EINVAL;
+		}
+
+		bridge = dcp_dsi_bridge_init(dcp_kms, dsi_np, dpu_np,
+					     intf_idx, dsi_idx, fw_display_id);
+		if (IS_ERR(bridge)) {
+			ret = PTR_ERR(bridge);
+			of_node_put(dsi_np);
+			return ret;
+		}
+
+		dcp_kms->dsi_bridge[dsi_idx] = to_dcp_dsi_bridge(bridge);
+		drm_of_component_match_add(dcp_kms->pm_dev, matchptr,
+					   component_compare_of, dsi_np);
+		of_node_put(dsi_np);
+	}
+
+	return 0;
+}
+
+static struct dcp_dsi_bridge *
+dcp_dpu_kms_find_dsi_bridge(struct dcp_dpu_kms *dcp_kms, u32 intf_idx)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		if (dcp_kms->dsi_bridge[i] &&
+		    dcp_kms->dsi_bridge[i]->intf_idx == intf_idx)
+			return dcp_kms->dsi_bridge[i];
+	}
+
+	return NULL;
+}
+
+static int dcp_dpu_kms_setup_bridges(struct dcp_dpu_kms *dcp_kms,
+				     struct device_node *dpu_np)
+{
+	struct drm_device *dev = dcp_kms->dev;
+	struct device_node *ep_np, *remote_np;
+	struct of_endpoint ep;
+	struct drm_encoder *encoder;
+	struct drm_bridge *bridge;
+	struct dcp_dsi_bridge *dsi_bridge;
+	struct drm_connector *connector;
+	int ret = 0;
+	int intf_idx;
+
+	for_each_of_graph_port(dpu_np, port_np) {
+		ep_np = of_get_next_child(port_np, NULL);
+		if (!ep_np)
+			continue;
+
+		ret = of_graph_parse_endpoint(ep_np, &ep);
+		if (ret) {
+			of_node_put(ep_np);
+			continue;
+		}
+
+		remote_np = of_graph_get_remote_port_parent(ep_np);
+		of_node_put(ep_np);
+		if (!remote_np)
+			continue;
+
+		if (!of_device_is_available(remote_np)) {
+			of_node_put(remote_np);
+			continue;
+		}
+
+		intf_idx = ep.port;
+		drm_dbg_driver(dev, "port@%u: DSI bridge intf_idx=%u\n",
+			       ep.port, intf_idx);
+		dsi_bridge = dcp_dpu_kms_find_dsi_bridge(dcp_kms, intf_idx);
+		if (!dsi_bridge) {
+			of_node_put(remote_np);
+			drm_err(dev, "port@%u: no DSI bridge for INTF%u\n",
+				ep.port, intf_idx);
+			ret = -ENODEV;
+			goto out;
+		}
+		bridge = &dsi_bridge->bridge;
+
+		of_node_put(remote_np);
+
+		encoder = dcp_encoder_init(dev, DRM_MODE_ENCODER_DSI);
+		if (IS_ERR(encoder)) {
+			ret = PTR_ERR(encoder);
+			drm_err(dev, "encoder init failed: %d\n", ret);
+			goto out;
+		}
+
+		ret = drm_bridge_attach(encoder, bridge, NULL,
+					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (ret) {
+			if (ret == -EPROBE_DEFER) {
+				drm_dbg_driver(dev,
+					       "port@%u bridge deferred; panel not ready\n",
+					       ep.port);
+				goto out;
+			}
+			drm_err(dev, "bridge attach failed: %d\n", ret);
+			goto out;
+		}
+
+		connector = drm_bridge_connector_init(dev, encoder);
+		if (IS_ERR(connector)) {
+			ret = PTR_ERR(connector);
+			drm_err(dev, "bridge connector init failed: %d\n", ret);
+			goto out;
+		}
+	}
+
+out:
+	if (ret)
+		dcp_dpu_kms_cleanup_bridges(dcp_kms);
+	return ret;
+}
+
+static int dcp_dpu_setup_pipeline(struct dcp_dpu_kms *dcp_kms,
+				  struct device_node *dpu_np)
+{
+	struct drm_device *dev = dcp_kms->dev;
+	struct drm_plane *primary_planes[DCP_DPU_MAX_CRTCS];
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
+	int primary_idx = 0;
+	int max_crtc_count;
+	int total_planes;
+	int i, ret;
+
+	ret = dcp_dpu_kms_setup_bridges(dcp_kms, dpu_np);
+	if (ret)
+		return dev_err_probe(dev->dev, ret, "bridge setup failed\n");
+
+	max_crtc_count = 0;
+	drm_for_each_encoder(encoder, dev)
+		max_crtc_count++;
+
+	max_crtc_count = min(max_crtc_count, DCP_DPU_MAX_CRTCS);
+	max_crtc_count = min_t(int, max_crtc_count,
+			       dcp_kms->caps->num_displays);
+	max_crtc_count = min_t(int, max_crtc_count,
+			       ARRAY_SIZE(dcp_kms->dsi_bridge));
+
+	total_planes = min_t(int, dcp_kms->caps->max_planes,
+			     DCP_DPU_MAX_CRTCS * DCP_DPU_MAX_PLANES);
+
+	for (i = 0; i < total_planes; i++) {
+		enum drm_plane_type type;
+		unsigned long possible_crtcs;
+
+		possible_crtcs = ((1UL << max_crtc_count) - 1)
+				 << dev->mode_config.num_crtc;
+
+		if (primary_idx < max_crtc_count)
+			type = DRM_PLANE_TYPE_PRIMARY;
+		else
+			type = DRM_PLANE_TYPE_OVERLAY;
+
+		plane = dcp_plane_init(dev, U32_MAX, type, possible_crtcs);
+		if (IS_ERR(plane)) {
+			ret = PTR_ERR(plane);
+			drm_err(dev, "plane init failed: %d\n", ret);
+			goto err_cleanup_bridges;
+		}
+
+		if (type == DRM_PLANE_TYPE_PRIMARY)
+			primary_planes[primary_idx++] = plane;
+	}
+
+	max_crtc_count = min(max_crtc_count, primary_idx);
+
+	dcp_kms->num_crtcs = 0;
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		u32 display_id;
+
+		if (dcp_kms->num_crtcs >= max_crtc_count)
+			break;
+		if (!dcp_kms->dsi_bridge[i])
+			continue;
+
+		display_id = dcp_kms->dsi_bridge[i]->fw_display_id;
+		if (dcp_dpu_kms_get_crtc(dcp_kms, display_id)) {
+			drm_err(dev, "duplicate firmware display ID %u\n",
+				display_id);
+			ret = -EINVAL;
+			goto err_cleanup_bridges;
+		}
+
+		crtc = dcp_crtc_init(dcp_kms, primary_planes[dcp_kms->num_crtcs],
+				     display_id);
+		if (IS_ERR(crtc)) {
+			ret = PTR_ERR(crtc);
+			drm_err(dev, "CRTC init failed: %d\n", ret);
+			goto err_cleanup_bridges;
+		}
+		dcp_kms->crtcs[dcp_kms->num_crtcs].crtc = crtc;
+		dcp_kms->crtcs[dcp_kms->num_crtcs++].display_id = display_id;
+	}
+
+	return 0;
+
+err_cleanup_bridges:
+	dcp_dpu_kms_cleanup_bridges(dcp_kms);
+	return ret;
+}
+
+int dcp_dpu_drm_obj_init(struct dcp_dpu_kms *dcp_kms)
+{
+	struct drm_device *dev = dcp_kms->dev;
+	struct device_node *dpus_np = dcp_kms->dpus_np;
+	struct drm_encoder *encoder;
+	int enc_idx = 0;
+	int ret;
+
+	if (!dpus_np) {
+		drm_err(dev, "no DCP subsystem node — cannot create DRM objects\n");
+		return -ENODEV;
+	}
+
+	ret = dcp_dpu_setup_pipeline(dcp_kms, dpus_np);
+	if (ret)
+		return dev_err_probe(dev->dev, ret, "pipeline setup failed\n");
+
+	/* v1 - Encoders map one-to-one to CRTCs; cloning is unsupported. */
+	drm_for_each_encoder(encoder, dev) {
+		encoder->possible_crtcs = BIT(enc_idx);
+		encoder->possible_clones = 0;
+		enc_idx++;
+	}
+
+	drm_dbg_driver(dev,
+		       "DCP KMS: DPU ready — %d CRTCs, %d planes, %d encoders\n",
+		       dev->mode_config.num_crtc,
+		       dev->mode_config.num_total_plane,
+		       dev->mode_config.num_encoder);
+
+	return 0;
+}
+
+int dcp_kms_init(struct drm_device *ddev)
+{
+	struct msm_drm_private *priv = ddev->dev_private;
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(priv->kms);
+	struct dcp_drv *drv = dcp_kms->drv;
+
+	dcp_kms->dev = ddev;
+	if (drv) {
+		drv->kms = dcp_kms;
+		dcp_kms->pm_dev = &drv->dcp_subsystem_dev->dev;
+	}
+
+	if (!dcp_kms->hfi)
+		return -ENODEV;
+	if (!dcp_kms->caps)
+		return -ENODEV;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
index 333567a78ad7..32f53c5e18bf 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
@@ -21,6 +21,7 @@ struct drm_crtc;
 #define DCP_DPU_AUTOSUSPEND_DELAY_MS	5000
 #define DCP_DPU_MAX_CRTCS	4
 #define DCP_DPU_MAX_PLANES	12
+#define DCP_DPU_MAX_DSI	2
 
 struct dcp_dpu_kms {
 	struct msm_kms		 base;
@@ -33,7 +34,7 @@ struct dcp_dpu_kms {
 	struct device		*iommu_dev;
 	bool			 rpm_enabled;
 	bool			 commit_pm_active;
-	struct dcp_dsi_bridge	*dsi_bridge[2];
+	struct dcp_dsi_bridge	*dsi_bridge[DCP_DPU_MAX_DSI];
 	struct {
 		struct drm_crtc *crtc;
 		u32 display_id;
@@ -50,6 +51,9 @@ int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dcp_kms,
 				     struct drm_crtc *crtc);
 
 int dcp_dpu_drm_obj_init(struct dcp_dpu_kms *dcp_kms);
+void dcp_dpu_kms_cleanup_bridges(struct dcp_dpu_kms *dcp_kms);
+int dcp_dpu_kms_init_dsi_bridges(struct dcp_dpu_kms *dcp_kms,
+				 struct component_match **matchptr);
 extern const struct msm_kms_funcs dcp_dpu_kms_funcs;
 int dcp_kms_init(struct drm_device *ddev);
 

-- 
2.43.0

