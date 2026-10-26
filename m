Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570B606A328
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A2CpUTms;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EmpbV1Ex
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D62810EBE6;
	Mon, 26 Oct 2026 06:24:22 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F7A10EBF7
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:11 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4arbD1181762
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dbYNMN9z8CYSu3KpTs+t1qX2w1pkqwFymCUjX7ig2RA=; b=A2CpUTms71nD3qMT
 L4/4i1Uxo6TbXp+ULA2JOUWJq2RPs5f7/Is5LQtEIqUBqSyJwG5yTytIEXmlYRnO
 LlnaVPZUXEekEjDBabYAdzux3qlYkdyLq0g8l1+AvZZWmFLVO21gMmpWwEoVt1qj
 YsSmT283eahVnjKt0dFeClSdA8tZQU6rF5Gn+syDn5y98A4CjtkOzmeVfWv1onop
 UWGrWmNmrL5TfcN9N6C0sVttd2bdPucg+iCOMhT3yuWDzTo6Zlq0H9peHrL+DlC8
 iPvSEXoDaHTUTjKzgijekV06B18x+lZcNECmkQ5j6TXlKExQXExoHjPWjGHppbzU
 uXYOEg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27w29q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ea71803effso28682895ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792995849; x=1793600649;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dbYNMN9z8CYSu3KpTs+t1qX2w1pkqwFymCUjX7ig2RA=;
 b=EmpbV1ExhCBY/dHkcR5aeG56YE8RJcCUnn+hmEVyhUOll3WXHV70SPhO6w+gsDWAnG
 Qa59ed6eqv1cqQkat42BQOkFlNgyyccUZseVmPEjXpOvOZhLa6pH4FmZhGHg0ypFer1M
 7/B1Z804YZ1HIArVM4UZ5ss4xKqyJ3DW7d/wmF7pQpUM1welF2XMSNcJ3EpoV++C5SEH
 nbcKqn9zhi5pnBmc6Q1AkX3AkmXc6cWw52OvXWu2zq8cFpjNaViulR/+M+8xueCcfc0r
 d8p13MUwf10GUooFwBI3t+68anJxKe/YN7tBQRCeekKukeNDNgW9gTc0hBezeV1uewUF
 Bgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792995849; x=1793600649;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dbYNMN9z8CYSu3KpTs+t1qX2w1pkqwFymCUjX7ig2RA=;
 b=tO3+BuaY3Ivl4fWctQveFychU4d1spfH1LvTXUJnitTx56JKO8hvkdTyCWXRDRm6Pv
 Y2+mh0nuIv8ObrwIxPS3SnxzTHE8u8fuUnqx2JRIjQewjzYuXQ/B1Pl1GTNmlLOar4Mu
 woA+Cchq3z5jZ8KfMENdV/Jce2vYcpvIUmeM3Tb7ZeZYpsNpetCzrcJ/AAee/JOH6nFK
 ZDyhLHssPZf9h8fh1FqODyMRh/z315O9xfVjT1uR6v5vjUeOXx4StEb/RvEhWxGjY39f
 A1ZeZjOsZuJPNm9erRwViwm7k8aKbQjU7hhjS9R8Fhv9jJyxKPhUiBUkp0vIuSFZZpNx
 9Law==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/ZDJcqOZVRzXQntGvG0H4VEi7PNCG0euerr5VnYnTRx0W4HasfxxGMiCMjMItmumpOQ3ssJxylvQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLNBd29ePqMQduVNi872yKCMwS+KNgfWGeW7blTBSV+C1gUtylX
 PmDnucAk+bdlK4NOHvCho7EQ7XHhQ/9fOFrtHLAmisekTXZ5OBgB/N1f3+HVLDtNUXFxgnyAPyG
 QSWSmwhK7YAB9zCsNiOlBEKZtkAD6qWfuOVQLyMxTmj68+v8wssheGSyUKxYs+gOl1iMuOAY=
X-Gm-Gg: AYBFou3GBWePijmaNlgEyZTye1dU+9Bi80aFRrwDC2s33U5AYlJF3V0u7sE4IaXYBqw
 Y/rNdXg/wiDLSADmTIVw7p+DcQH5SH0wTaYo09HnSDZswVtFJ+TKaLudfR4LGCUa3qRzkEx8ksc
 1ySDtpAqjImLQ1HvlUDiKE0WnZCWmAGh9PTc4U7DgCVaQIRxRM6KZJw8CqFJjlU6rmB1ZEUK4x9
 cd/w1gyNcwiXLElLWAOj8DNFasN29gS/74Ti0fMBfMo+IOlj2WEiG4oLfkN2tZ8p7NSeKhcVfKt
 aCuBJjN6OxSr18b6h91oCka05dfbk3+ox4L407fV0O38ldRH9a3u0AY0LRHm8I8h1k7vmHxMMmY
 yoHtXLNjuVfRSnilf1+/DJw2MAuIwgxNlRA==
X-Received: by 2002:a17:902:f60c:b0:2e7:12d5:cc3a with SMTP id
 d9443c01a7336-2ea9c63d377mr43098925ad.36.1792995849354; 
 Sun, 25 Oct 2026 23:24:09 -0700 (PDT)
X-Received: by 2002:a17:902:f60c:b0:2e7:12d5:cc3a with SMTP id
 d9443c01a7336-2ea9c63d377mr43098645ad.36.1792995848887; 
 Sun, 25 Oct 2026 23:24:08 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 23:24:08 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:24 +0530
Subject: [PATCH v2 14/23] drm/msm/dcp: Add DCP encoder
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-14-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=2736;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=13ayK5iaWertmFXymKPgINfX7fwgPHD+tgYvEDAKLs8=;
 b=zmwgbeRZoqTMrzpI8+a/t3MlIu3IDSlRDVgwwS54kYHPLh7/+sgEF+x7gACCHhdFfzZZj8Vly
 V7W/Eljs9FoDWuakAW53sDKzOr21oUkTPeVA72jFeTstFMQfl57YL2J
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adef20a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=qqiwZq75wgHyRPlt0ZYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Hv3JCm1t018LzKPEDaN56_PRxXmDJLsp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX812bQQMJWFJb
 m5e9iCGtvbRrlXAKskM/Jfv6Rk5HRpPnjNj9ABdjhIRyj1OjUq4eq1kthgTq/hO/J+6EKsImZna
 5pFlF0yvFIFkEV3JQMejU1xGj63wrHw=
X-Proofpoint-GUID: Hv3JCm1t018LzKPEDaN56_PRxXmDJLsp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX3QqNKhnp7U6q
 JS6N2lnnCPckgM1wTe3ajlHKR1KDNwQQfyf8pt/gNOdhYu5dVygwO63vXPg9kw8KZIJAtj9EGfk
 h5r176B5vhFbnJcy0OdGQYKJstd2AL3dj0d8BoEO9uhzvHJJT/ukWRiGHOWf27Ij+c4lY86bH2/
 OpzRPgW4uHiugmMQLbS44dPm/WnGSr4SoGpom48uK6ckVaPYv63CeCoNq1hzNBTdT6V5jX8OK2u
 E0YcDup7swpLWRdoxtq01AKY1ncUEQIeAtONwOFGHrxKlngkIhtkQUg2pslLWoemDH6Hyb3rD2I
 fwDMWAlZAJW6HcufK6R06lrFJjulEIcXqCfiRkSEHeDnzM555mg4PuV7RpPkROOjjCi2EXvE7Ef
 ySC3w+SXckpSsUJSVxMzh/ryRL+pHNT2Yac5uJbEjJB90ZUzdbM8T8R3b4MTgo0vG+23PQ73zOA
 g1ovAe5Imq4DqUGL+kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Create the DRM encoder required to connect a DCP CRTC to its
firmware-backed output bridge. The encoder must fit the existing MSM
DRM object model while remaining independent of bridge discovery and
KMS registration.

Implement the DCP encoder wrapper, allocation, and DRM object
initialization.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile          |  1 +
 drivers/gpu/drm/msm/dcp/dcp_encoder.c | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_encoder.h | 16 ++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index b425fefda890..4024f6b1e3cf 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -83,6 +83,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_hfi_kms.o \
 	dcp/dcp_hfi_plane.o \
 	dcp/dcp_ipcc.o \
+	dcp/dcp_encoder.o \
 	dcp/hfi/hfi_packer.o \
 	dcp/hfi/hfi_unpacker.o \
 	dcp/hfi/hfi_utils.o
diff --git a/drivers/gpu/drm/msm/dcp/dcp_encoder.c b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
new file mode 100644
index 000000000000..e7a64c960bdc
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
@@ -0,0 +1,29 @@
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
+	if (ret)
+		return ERR_PTR(ret);
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

