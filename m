Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D664606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dyxZAyeL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bCNOYdEu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B52E10FA2D;
	Thu, 26 Nov 2026 06:31:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0AF10FA27
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:20 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36YOb1686634
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TRPs9xTWWhDxmrjGF62QzR1B12YtZbs2NVjgVgUhkyY=; b=dyxZAyeLoXziSVdw
 iC+yD/BhrmXWs2Mz2znH4Q01zluMofdlXIxR8MV4t018xpMrfk29vykrKGoBUbjU
 f2KKzPVfy1YMtD/4lI3s7W/3GKUckaDZl+Dsiw5IW/mHCgBUoWbCeXknA9G1vFC9
 HWk9OgkSU+uIOwInOx1JlnNfUAB7gyVKZudqR/kLVUvgnCThtMKyyuAEp1W6ayR4
 9s/3owaeohBfYuXEKomSpIGxrA8Y7UQX7IU3sB+jcmVZ1MIVA4cAFFGEjoCB/0N1
 SM6aqc8pMmSfGNsTaCSKm77cAXs9ZobXeo9LGi6jSyf1hFV9NX2Li8C15GU5TGtM
 yBSlDQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j66qf9km9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:31:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2f0ac2d8225so30403055ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674679; x=1796279479;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TRPs9xTWWhDxmrjGF62QzR1B12YtZbs2NVjgVgUhkyY=;
 b=bCNOYdEuyLNMhH1z2wOeh4/L+4C+eTXc8BW2nvJ48kKIMq/CIDQZCLaUbBgmHCQuHb
 kkUR4qM994DVlqOGSKtF7WHWh6LvdU/5zGK6AuL9Pc/7Od/V1n3VCe+d6N6CbxNXcAAz
 uyN24JPlDPYto5pKxUE8A+dbZPWN//AUcW+4elDxL24UVaOjviG+d4U+mp3pPkt828A1
 OsVRH24IhP3ZBob0AM+m4OTJRHqEmF1FX57QkHJ4lJKAq/katWUKdOn6oBAC9c1deGaN
 Os7n7uH5ScG36yHWS/whesmAkpANMEAGLmqWKmCWdDK0qSpLQOyJG7rn0culvIpCTkSN
 q+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674679; x=1796279479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TRPs9xTWWhDxmrjGF62QzR1B12YtZbs2NVjgVgUhkyY=;
 b=WWFLcL7wFglPufj4koe3/cOZlwpwn8Bsx39LTnA1F7b8YD1xb00SMh9LcRt+yxWr9r
 FZPlTSNGCYn7AfRM/3Yd0nG0CcjB7B8mjk3hwhx+vqz+pQCovIgScViG2t+atL6HA5IC
 NQdbGOTri//4TntnJm6D/SUcFno66+mUyc1FQ1offVwHMKXWe5hVjKG5idpq/8YNFhEg
 B/WGNFt85LtomN78R0vECRPtuHvda2fz3F7JKUwum7ehjEZgSsRlhBYXsLpCyS4L56xs
 Mxr1Kr3tX93tN9VrNBZN80NNQwvo+LvU+IB05QpMF8Iy6jJhfFbxg008OMe7CE9fT9ou
 HwJQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEVPt35zN71SkB6GA8gnwm01pqnPuwT/kjk0JkzEjkBF/mQz8yuQ3S/PIEakkxNWk2xltstdLyF6UY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z80KLJ1q+mH+g/yhX2c7P7awGop8Uz/bmz83A2nQiOCWjk8IxaH
 4KnYvc6+200l8Net6ZxZd89cpPz32iCoeKLv5hC4aAAuB6qN2P6pTI+YUZFBhoTA7GmkupRk/eH
 3fCFc0yd9LiTKjNV871o74iXe7ZRdC76lzKF0O7ChuuNa7SgOThN06NDasy6E+Y4wXjOUG6c=
X-Gm-Gg: AZFdTZdOQTqs0LHQKuagq2zP86LYcd6k2IOqtSJb6hgFp3h+IHHxV531x4qasWIeJ7Q
 R8Hhf8bBSkdmhWeSQjgMRP2aSCJonq1EjFHn251l8bepqXtAlMAzoxFl7fri/DqFoFdaTloeiNx
 ThBMvbusLDJGy5pUODvDYmmX5dEkrhaHVxiqQ8SZ17lqYhYBV1WdLGjaklgeaC1KXeXE6QWnueb
 UJV1oFvQ5HCcNgij0/R2RnTUumfoLI3xAb61Lc2iuis8zTaEtoKuIvK/FdTso8uusS6sSUxo7Ws
 mr/dfweNU/mIxdFo+sb2+3uC6bCR4QGpwgySKBm0NEFIKek0q2ksaw+ZE5mRh+/XGm9KDgERKqp
 idA7+PW1PJz68yGaX59n9lgfO/KYZX1X1dweIXsqODtJHgV/urgjBxsHTahXlPbRmrNcI63sTWD
 dVoeCfjRSv
X-Received: by 2002:a17:903:2f87:b0:2e4:a360:fcc6 with SMTP id
 d9443c01a7336-2f03f1b6f35mr208059625ad.35.1795674678913; 
 Wed, 25 Nov 2026 22:31:18 -0800 (PST)
X-Received: by 2002:a17:903:2f87:b0:2e4:a360:fcc6 with SMTP id
 d9443c01a7336-2f03f1b6f35mr208059285ad.35.1795674678428; 
 Wed, 25 Nov 2026 22:31:18 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:31:18 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:21 +0530
Subject: [PATCH v3 13/21] drm/msm/dcp: Add DCP encoder
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-13-f1e9d7505039@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=2743;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=PpQi3TK+4EMt9gGh4o3vbPSYlayx+DPAkJNGb6fSOT4=;
 b=rHX9dvqcJ5W/eFlpMpuncVY8cgdFvTmHcaNskFjZ1eUytMoYcapCuNhf2aQIK4txbmq7pybgW
 S5L86OZ/fOgCrflKIlH4nYxM8RLbY9i8OdHBkuuUSBl4OU4ccmJC+7Z
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: 5C9-w0UZc66CwVp7zybGFAvJ4oI1SAlm
X-Proofpoint-GUID: 5C9-w0UZc66CwVp7zybGFAvJ4oI1SAlm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX7Opy+qjKvkcq
 6CA8iiwCLo8bRiDYRryPnBO0gJijyqZmriA1ZYx7ciEpuIq9UcZUWAc2hgT7OGHXsnQsFRJl/TJ
 52Ac1QsZGJnbcWIlcj2ShnoCRT2FVdE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX0dYSDhLJ0vD1
 LJCE7LHYQJMWudpQW/zxaDQiwwvXCT837KN19QVX+ZpdMOutGn7cro/PobiYnVu4YsRynxqhnHn
 VMLu5/KO61IyHQDGvVfG91564EmYph+1YM1LDWyY50RHSdG1VxNhP7PbzamUEtyIO10he+B+LQF
 7W2GOL/LtSEUawKf+X9kG1Wez3YqLRmNR0vA6TRaCwCFB/kSLvwG84tde78LX0VErfhNzBIrX7R
 89NbMiNG9INE+jRoCxD8kqhtZn4JT6oU0gzAaR0Qr2JUNMqAykKLwEqsLOK4HnONIB/bWB2t6aF
 UwuZIvglV7+3JFIdpF5muD5n7C8L38YGPGWukxFPQ4l3cyEWUCh2KyW8foHn9hlvSO+DpTtWjMZ
 BdVc3cPJ/9/fSv6bWTRlh4jMtkzkO0Ny2rD5m08/si0oULoFj7uIzAQfH7GjOSGrPZ4JzKg0jnr
 S08oWfGEtGSIotGuYrA==
X-Authority-Analysis: v=2.4 cv=Q5VHcI2a c=1 sm=1 tr=0 ts=6b07d237 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=qqiwZq75wgHyRPlt0ZYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
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
index d0fbd8bdd49a..7fc4861d19df 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -82,6 +82,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_hfi_encoder.o \
 	dcp/dcp_hfi_kms.o \
 	dcp/dcp_hfi_plane.o \
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

