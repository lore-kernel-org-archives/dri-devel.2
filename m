Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEC3CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BD0D112105;
	Thu, 15 Oct 2026 07:40:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19588112110
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:03 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F1PnjO3468853
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E25GlgOVqzhPXuSoArfl/adEZQk2DbN/hy7GjVs7DnI=; b=kgxATm/22HPZ15zr
 i/9dIfT64+dfIF2htZawUp6yGFnwxT2jyj+ax6b9jY6zScwkiqwAX7GSpM+CABjy
 +UCFO0D5GWYwOkQFmGUVkj9fYqi7PyT/uAigi0ck6KHfu55GwJeYp932PcqeoLLR
 hG/wLgWxyxS+AFzaCm7IgQpoJn9K9Vu9DUYbbHzF1lWtjblxnxs1VD5td/JAN7XK
 dIYNy13EHh1M7egL4bXRxe79Skukj1iQ4aC8JAmp0HeDIALCXcOJC4Eanu9BSeTs
 tji1X3+m+cKkLETDmhHsO/gTL92iLEBR2YUz2px0qzSuAX626MGtVefrRMlyACzT
 3YNGGw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd7b1au-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e93f67358eso15387535ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792050001; x=1792654801;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E25GlgOVqzhPXuSoArfl/adEZQk2DbN/hy7GjVs7DnI=;
 b=iupRFqJ8Gy15Ps2lBu9DuOfuqPdocqGaNRUlT3UzRdJ+lWtJjnslQHMR/rNJ1+uo4h
 /NFM1aIlLybbE+ADXLZcvz2ujigwQJvFo5ofpM+hcZmBzb+7l9me2sY2XNUSjOjpV66E
 1U7wMCrXHitzyr7ys1RB9G8SZ2LCQwMSjK3vSfg6VjfRlBoKzLZAlbYcvaK+bJ632oGF
 XDsqgvuo4l38fh8F84UeMWq07ly9Pl7v9LZ64K035S0GgUlUuoHafUqpl3mp1ukTru46
 azHH/YgDKJ/V/dQcNgvrryzUW4ZVrKoiBkMaP+jY5zuObPUqEUGWBB3vXj4RgeEPcTqj
 uYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792050001; x=1792654801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E25GlgOVqzhPXuSoArfl/adEZQk2DbN/hy7GjVs7DnI=;
 b=ZTK89zFEcZQYk3WKj/Xww98LmiNJpg+uokAbeCIIMKQLwY5tCP8wy0EJZx5881IBmb
 rlLaOAOv4/ITJNXytLvucs2X6S+sAH6V1te0ng29WvJFfIJvhUVnFK6nvQjjbG8PHX6I
 RX6apu7SyyZ74uLkemV862VC6o6siO9OhKL9a8Yr440/JEVgbGp52k3a4CwOaNv16HMy
 Q67poEVsIOllLxDJFwO0Xf326d/8bVzFd3PjNMYfMRUnRtfvjx/w/ive46alAZzfeKm6
 8Xk+C3nJMLEOEPzmZ1h1K+MYMNUFi1vVGCbYhC8owxZQwWEjh3eGKy5OX3VaUwtoogS5
 S/Zg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkUCt0o+04WkkASfpYXGEn0BqFadjAHBit/VXE8DkK0MW7htg8/qEQuOZ5o28093uxrTAOSSTFlRE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK/29zalG+3YG9bgloV5nA0MS9Xzm7/M2NXRGnmDkHv+SpQjC3b
 Zyl3js7lbqI5gEFolLXyjd1yI6l/KtoR0Nd8e7YzKNzwyM244eFcW/gIT6BUnEkvjgPzPZlINLG
 wrqEDI9L8w+uzzsfxT3KLsISFvMfBMApWn6jtttpSOBXIHixk1bDCtaX/ozAGBlsOHwV46fQ=
X-Gm-Gg: AYBFou0inWckd/Y2IAsXHArg5emHA3wzMJS8Iq0fT0SrH4IU7IwvBid3xQ81gs5ZXYC
 rUO9LpQaglTiYMy26URo1k4xBg6gh/V/QWUsLD9YqpxLmgrijPzifcnVhhE+wdb00k4cVpxpXvW
 /PI/CuB5+4Pe8iAmzCSnYoPyZJf4rPyh1qAHx0mrV2AcqEFqhIAckqErJBAx3Qx5fvpvDF8X6uI
 PxiMufobsS9KTNAQF9L4DTh6cYeIR1OV4LYeOSbFv1bdlAsPjyZWI2rV5cL6dZY3bFoR7BG5tmf
 agmpHF/dknzHOB7+C9XDwE6cmp0WOtTaK+krZkmWOtftB1T1jKzo4LyGW6K32dd33vQ3hXPneHn
 QpURnUz8RBrMmpTMWnVxe35kvGLyAUrn711s=
X-Received: by 2002:a17:902:e844:b0:2e9:3dd2:a90c with SMTP id
 d9443c01a7336-2e93dd2c030mr38660305ad.20.1792050001451; 
 Thu, 15 Oct 2026 00:40:01 -0700 (PDT)
X-Received: by 2002:a17:902:e844:b0:2e9:3dd2:a90c with SMTP id
 d9443c01a7336-2e93dd2c030mr38659915ad.20.1792050000969; 
 Thu, 15 Oct 2026 00:40:00 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:40:00 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:27 +0530
Subject: [PATCH 07/13] drm/msm/dcp: Add DCP encoder
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-7-48aad0fe4f72@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=2785;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=UJhftP8nMB+QwFfi+IKmgq66mzPjGJcFwEcVUt7DekQ=;
 b=1raZEztaPazQAIhOuIyFmobIDPV0NJEw6iVxWR4ayn+cdx3GwNnRCG9NkdgqZhOKICYdscJ+b
 6wUMufXyB2rA0y6L1aTSwcM9oS3i5LoCoN/F68NtBdMu9OJQ8UtuBrS
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6ad08352 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=qqiwZq75wgHyRPlt0ZYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: EvqMQwVeQCuRwNXisFB3BrEW4nwfNtc5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX44B/3rNTsMEO
 kp4azRVs3tMH8O5sdFtdxuVwTAQuLqw2aEQMNenqz4nxoOx7rsPAiebZEN4/AhrNXNAYL9vsfP5
 VKjfoVczOsliS5nW64LMZxgmBNZiOu1xRAEzIQs7GSUSCgwyOZ7lLJEPN+y0ZMglaAb/RCBCQiH
 3B7IL0T2/QM+nQ7nUYUy4OPE+QyNpq/fv7j5PC0Z7t+/7nrTY9E4LfcVyzeYMvYXb2pBIUAlCmP
 2bt0YjisI21kiK1K+w6RY5jQMxjSio2J5z3C5R9h3vxvvvblTU+oFIETB9CLpg5nQ27mPmwLVG0
 6MA1QlwSUoM59CvGrkRt4Xj6c1eLgHdlGjgZFIzIXO7fAt8ZBGvUWNPegn+pwSW4xwQKwPoiK+8
 t+G05c4uUMSFEwp4VwsYm4Gji9mbEz/WTxdvdxbsQ8nt+cPI7YnNLMRt+/SJjUk0paE98gVYJJc
 F+O8HM7qdbOLsiL8URw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX3ZmM0YRtkoks
 3plybkkm1mZOk2IQtptzhiWmAiGkmPOdbkSbx99iESiUjHM3/ySpYkZAyDqUkNi9HZ27Fqj/xcJ
 KwN+jt8RT4rlnc/EmAnJfTJjKm3dC9k=
X-Proofpoint-ORIG-GUID: EvqMQwVeQCuRwNXisFB3BrEW4nwfNtc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
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

The DCP display pipeline needs a DRM encoder to connect a CRTC to its
firmware-backed output bridge while reusing the existing MSM DRM object
model.

Add the DCP encoder wrapper and keep encoder allocation and DRM object
initialization independent from bridge and KMS registration.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
 drivers/gpu/drm/msm/Makefile          |  1 +
 drivers/gpu/drm/msm/dcp/dcp_encoder.c | 31 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_encoder.h | 16 ++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index b7c1a2e9a19e..e7d24be72113 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -81,6 +81,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_hfi_plane.o \
 	dcp/dcp_ipcc.o \
 	dcp/dcp_plane.o \
+	dcp/dcp_encoder.o \
 	dcp/hfi/hfi_packer.o \
 	dcp/hfi/hfi_unpacker.o \
 	dcp/hfi/hfi_utils.o
diff --git a/drivers/gpu/drm/msm/dcp/dcp_encoder.c b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
new file mode 100644
index 000000000000..bc173fffb325
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP encoder wrapper for the CRTC-to-bridge connection.
+ * Hardware programming and mode sequencing are handled by the bridge and HFI.
+ */
+
+#include <drm/drm_encoder.h>
+#include <drm/drm_managed.h>
+
+#include "dcp_encoder.h"
+
+struct drm_encoder *dcp_encoder_init(struct drm_device *dev, int enc_type)
+{
+	struct drm_encoder *encoder;
+	int ret;
+
+	encoder = drmm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
+	if (!encoder)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drmm_encoder_init(dev, encoder, NULL, enc_type, "encoder%d",
+				dev->mode_config.num_encoder);
+	if (ret) {
+		dev_err(dev->dev, "encoder init failed: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	return encoder;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_encoder.h b/drivers/gpu/drm/msm/dcp/dcp_encoder.h
new file mode 100644
index 000000000000..de40c9bca4bb
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_encoder.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP encoder interface between the CRTC and bridge chain.
+ * Hardware programming is delegated to DCP firmware.
+ */
+
+#ifndef __DCP_ENCODER_H__
+#define __DCP_ENCODER_H__
+
+#include <drm/drm_encoder.h>
+
+struct drm_encoder *dcp_encoder_init(struct drm_device *dev, int enc_type);
+
+#endif /* __DCP_ENCODER_H__ */

-- 
2.43.0

