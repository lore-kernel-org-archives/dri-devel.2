Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B78860A2603
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nV60/u8T;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aDLW+K7F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4C510FBA7;
	Thu, 26 Nov 2026 06:32:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D47B10FBA7
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36DZf2068353
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QbSPnWR8kb/S79wEwtwQ6OvIwXeEpZcXYPommKwTSFg=; b=nV60/u8TUDxNgoOZ
 XrAqCKaAhudhg9UtQFg3nTLSpYluqjtTejAqs0UJRljWjsm+DZCT9mlCfUmGSf6R
 VFR7Cg9FMyoZH9CWyF8TvcBN+fm0NBe+6tLCBYpkQPInUUJy4j+WxMFmMvy1lMBk
 34XQDlB+dTjpJEZ3LUOvmY6pJeFRpMVf8fbIDvv4pccswC9rI0r2ANyj5FP8StCa
 TZd1gifstMVkzdkIJ2L3WREy/P+Z34KyCbsiEO9zdo7pKHXw7hLurIwFsV3EM1za
 u/MOU7DFqJOjwlIe96C9h5aSeLe3lKNZBNILohcoVS2LMwQKAXhTXjNW1IfxipDp
 KI8PBw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662s9ryu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:32:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2f0e3ffabe0so11696575ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674722; x=1796279522;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QbSPnWR8kb/S79wEwtwQ6OvIwXeEpZcXYPommKwTSFg=;
 b=aDLW+K7FpltM5Kk2yJ3RdXeSpWYhaBN2dDBFzURNYWZ53ZaxqDS84wHwmuyZQrnUn4
 7cWZEYBdX18qw5/++6layUteE8FKSmEKalzIBqrRxzyctVbAowbPDf3yPeLmTbc5mZRv
 LHvAdcVhUWeVk1pZAqEA52chtP2DgpHHaSfP7hpDkt3XnAkLjCJsWmB8YpTJVKgaQugk
 mXJ5KXPgPrsXs9hnuwEwl6N3GPC4DktO3sTLb03rtuEbSST7Y4R6nh4JM8FMRz3VLJIa
 Ft/VwbcvS5PszsQVwYIvXCQsVA0r+5aiLvr1wcqnbdaJ9OPnEMUinaJO1jLX8T4X+Nc7
 G+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674722; x=1796279522;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QbSPnWR8kb/S79wEwtwQ6OvIwXeEpZcXYPommKwTSFg=;
 b=KcC+vgcFGxxJgi3JXgb+Eyz9gqf2gRfZiZMA6cuF7wPsXCqo7yHQR8oQsd83QdEPD5
 nA4lSUYwk6/SmH8ud/gRszlfFxE/gkDGgHmurTIagYSQacPirWHGpPZBTCmBgqTaUhcQ
 fnMErcLi2A1V5+C5Wd2pQZFw9xYKHQ1u93SSkIXtob/l4jSMh5vX7ph6wH7qtAw+5wjN
 8eOsARFmdp3iPfctdZpSk/fKiP7BCkj0HhugkrX1ADmR5BjTaIb9B+6eyTsyVd0hbHec
 NIp8LR+Ac+UDhPowK3GeIA8lQ+nM2EU/cYPnBo5JDDq/CYDx1UObfs3MSnBcjxtBsstf
 +MvA==
X-Forwarded-Encrypted: i=1;
 AL+hErHD1W3og66MbI99b0spVEJLffmeaXNQ6GxRGTZOoSlwvkoEp2X55bY9n9+nI1fmk2rhx6UljLMlHco=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9YcFdth6cyV6cDi9fEplkyFWBv+cij3VdUfiM+iKogqi6ciWVr
 Em5vvVxityUH56TTx91HW07ZmlCGiEX2iv5PTCeQzTtDAkd12BzDzwBDTDYCp8f2zEpIr/HQD+8
 jc2HJSFeqrxSmZSYPzKmm67uEXxzpOcSHwz9VV7XUTyr/QkVxfcTlRaMBNag67VtRtwGglbU=
X-Gm-Gg: AZFdTZeDM8JbZIGsYh6QRkzL2vo/IX8LHD1xliAmg5XpD48v/2icfbxaO9y3Y04o5ey
 6SbfB/nqIvtB4ja9q1roBIwfPGqS83eMfM4wgzkDPJ1qI04BZP/Hjz3fM6MQZHv37T3pzkCn7C9
 uSRRGdAPJvLEanVUim+gmy75UCW/qGXfzWZRdoxP3M4MsFrVk3CbirJuEgKDT0ODXvdY0zwSeDJ
 l0IxMXkuiZpOPKuKNhWhqigTkBjp/vL/X2/ufKnYuxV6o02ntthrdT5FheRg0vU3yXuN2SMhIA9
 frrf/lKBoYfZb9pSaKLqXkqN513e2I5Aww/OOY4U/YaxxechCki6ECXQathfoeZd/5rFsQlOvei
 4EKICxUDDEIUTc7hbDPNlaQglVNORPL0/R0IpoETghbddMZgKCUyk+pTrW7PkMB9JG2zKcb9LN6
 M1mCQ2JFWn
X-Received: by 2002:a17:903:178b:b0:2f0:60c4:9d1c with SMTP id
 d9443c01a7336-2f060c4a650mr152694005ad.50.1795674721441; 
 Wed, 25 Nov 2026 22:32:01 -0800 (PST)
X-Received: by 2002:a17:903:178b:b0:2f0:60c4:9d1c with SMTP id
 d9443c01a7336-2f060c4a650mr152693755ad.50.1795674720911; 
 Wed, 25 Nov 2026 22:32:00 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:32:00 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:26 +0530
Subject: [PATCH v3 18/21] drm/msm/dcp: Add DCP VirtIO driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-18-f1e9d7505039@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=17553;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=72qNZmxNqpZwghLZ2yqIpm8edihBEcmPw00gb7VCzbk=;
 b=9fkY6DRrwYoAy/ezl5dyIMfSfIZBelEtWuwnDxuz0As21nixYigGrbhCO/s3riXRkDMM//MNQ
 zcX5Fm05jMhCa6w9pZJYTJlGL/7sbySrCpAwOm4xa6ghk9SqyOWyyXn
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b07d262 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=2FSeUxzs4D6olrMjOcoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: xQSTtKJNVSwOXCrjHdGc-tajrJ6ZRjli
X-Proofpoint-ORIG-GUID: xQSTtKJNVSwOXCrjHdGc-tajrJ6ZRjli
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX2pbrsmNYUwfj
 0cD2H4y7e14Hy5t0OLIyaWSjb+6ysgjxYkxtK2bHuY02XzbS0QNLg4NVQQqdw/+Ou9oSIkWwkdQ
 zq6BNn4p29X+MUwfxn5QUjEkMFl8lceIxgzJAA7g0j7+scYFHvK4mCWuwx9ZS6Yz4ueEBIlHk1v
 Xw52k9tFOPfOqbvSiLW/4cGyQ7vAwezMbzMwtXK4MsFH5tJFsgTxb4NXBxUmv3OS+WK156vPcA8
 AOtsf9Ld1f1L0iS0ecoaZqw1KLpOKf9X8zrr5F7+OIJ/Bc52Bz1K8TwYj3kyBjDXmumzD2FNUN/
 xFJvzXd0o/eGIIAZ6L1diKcLrqYtzKVOrM7A9haFYu50LQeH1hj1exROVQxivTwdLUJpYYqL9E1
 A9DceWOmHXgftee/ZD4IE8lEjkFE/0AE/UQHzE57m27HWFfB2xd6tXOssiah4AzpGp5DVECl3am
 OIJHu9q+QgVBRWvvVRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXymjK9tIDTGks
 kY7ORAoTBCcA0o9ij7/toQ6/tSMVu17gPJCEB/f9hbJNoPROngwg6ma5pk5phpI1/d25OIOGXRH
 bOa24EZWeSLmSHd0hIJciqtAwupoT7U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
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

Add the DCP function driver that binds the VirtIO device to MSM
DRM. Without a function driver, Linux cannot establish HFI queues,
discover firmware capabilities, or register the firmware-owned
display backend.

Set up the DCP DMA and IOMMU identity, initialize VirtIO and HFI
transport, register the MSM DRM component, and synchronize suspend,
resume, remove, and shutdown with in-flight HFI activity.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile         |   2 +
 drivers/gpu/drm/msm/dcp/dcp_drv.c    | 193 ++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_drv.h    |  15 ++
 drivers/gpu/drm/msm/dcp/dcp_virtio.c | 310 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_virtio.h |  12 ++
 drivers/gpu/drm/msm/msm_drv.h        |   8 +
 6 files changed, 540 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 5910891d75f9..d6eeb5d5f681 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -84,6 +84,8 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_hfi_kms.o \
 	dcp/dcp_hfi_plane.o \
 	dcp/dcp_encoder.o \
+	dcp/dcp_drv.o \
+	dcp/dcp_virtio.o \
 	dcp/hfi/hfi_packer.o \
 	dcp/hfi/hfi_unpacker.o \
 	dcp/hfi/hfi_utils.o
diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.c b/drivers/gpu/drm/msm/dcp/dcp_drv.c
new file mode 100644
index 000000000000..62f38dff06ed
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_drv.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * DCP VirtIO driver.
+ */
+
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/panic_notifier.h>
+#include <linux/pm_runtime.h>
+
+#define DCP_DPU_AUTOSUSPEND_DELAY_MS	5000
+
+#include "dcp_drv.h"
+#include "dcp_dpu_kms.h"
+#include "dcp_hfi.h"
+#include "dcp_virtio.h"
+#include "msm_drv.h"
+#include "msm_kms.h"
+
+int dcp_subsystem_dev_init(struct dcp_drv *drv)
+{
+	struct virtio_device *vdev = drv->vdev;
+	struct device_node *dcp_subsystem_node;
+	struct platform_device *pdev;
+	struct device *dev;
+	char busid[32];
+	bool iommu_mapped;
+	int ret;
+
+	dcp_subsystem_node = of_node_get(vdev->dev.of_node);
+	if (!dcp_subsystem_node) {
+		dev_err(&vdev->dev, "no DCP subsystem DT node\n");
+		return -ENODEV;
+	}
+
+	snprintf(busid, sizeof(busid), "display-subsystem.%s",
+		 dev_name(vdev->dev.parent));
+
+	/*
+	 * DMA APIs accept a generic device, but MSM's component-master callbacks
+	 * still require a platform device and use its driver data. Create one for
+	 * the display-subsystem node and configure it with the display function's
+	 * IOMMU identity for DMA and msm_kms_init_vm().
+	 */
+	pdev = of_platform_device_create(dcp_subsystem_node, busid, vdev->dev.parent);
+	if (!pdev) {
+		dev_err(&vdev->dev, "dcp_subsystem_dev creation failed\n");
+		of_node_put(dcp_subsystem_node);
+		return -ENODEV;
+	}
+	dev = &pdev->dev;
+
+	dev->dma_parms = &drv->dcp_subsystem_dma_parms;
+	dma_set_max_seg_size(dev, UINT_MAX);
+
+	ret = of_dma_configure_id(dev, dcp_subsystem_node, true, NULL);
+	if (ret) {
+		dev_err(dev, "of_dma_configure_id failed: %d\n", ret);
+		goto err_destroy;
+	}
+
+	iommu_mapped = device_iommu_mapped(dev);
+	if (!iommu_mapped) {
+		dev_err(dev, "no IOMMU group attached\n");
+		ret = -ENODEV;
+		goto err_destroy;
+	}
+
+	dev_dbg(dev, "display-subsystem: iommu_mapped=%d iommu_group=%d\n",
+		iommu_mapped,
+		dev->iommu_group ? iommu_group_id(dev->iommu_group) : -1);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, DCP_DPU_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	drv->dcp_subsystem_dev = pdev;
+	drv->dcp_subsystem_node = dcp_subsystem_node;
+
+	return 0;
+
+err_destroy:
+	of_platform_device_destroy(dev, NULL);
+	of_node_put(dcp_subsystem_node);
+	return ret;
+}
+
+void dcp_subsystem_dev_deinit(struct dcp_drv *drv)
+{
+	if (!drv->dcp_subsystem_dev)
+		return;
+
+	pm_runtime_disable(&drv->dcp_subsystem_dev->dev);
+	of_platform_device_destroy(&drv->dcp_subsystem_dev->dev, NULL);
+	of_node_put(drv->dcp_subsystem_node);
+	drv->dcp_subsystem_dev = NULL;
+}
+
+int dcp_pm_prepare(struct device *vdev_dev)
+{
+	struct dcp_drv *drv = vdev_dev ?
+		dev_to_virtio(vdev_dev)->priv : NULL;
+
+	if (!drv || !drv->dcp_subsystem_dev)
+		return 0;
+
+	return msm_kms_pm_prepare(&drv->dcp_subsystem_dev->dev);
+}
+
+void dcp_pm_complete(struct device *vdev_dev)
+{
+	struct dcp_drv *drv = vdev_dev ?
+		dev_to_virtio(vdev_dev)->priv : NULL;
+
+	if (!drv || !drv->dcp_subsystem_dev)
+		return;
+
+	msm_kms_pm_complete(&drv->dcp_subsystem_dev->dev);
+}
+
+int dcp_component_register(struct dcp_drv *drv)
+{
+	struct device *dev = &drv->dcp_subsystem_dev->dev;
+	struct component_match *match = NULL;
+	int ret;
+
+	ret = dcp_dpu_kms_init_dsi_bridges(drv->kms, &match);
+	if (ret) {
+		dev_err(dev, "DSI host initialization failed: %d\n", ret);
+		dcp_dpu_kms_cleanup_bridges(drv->kms);
+		return ret;
+	}
+
+	/* A GPU is optional for the DCP display-only DRM device. */
+	ret = msm_add_gpu_components(dev, &match);
+	if (ret)
+		dev_err(dev, "failed to add GPU components: %d\n", ret);
+
+	ret = component_master_add_with_match(dev, &msm_drm_ops, match);
+	if (ret) {
+		dev_err(dev, "component_master_add_with_match failed: %d\n",
+			ret);
+		dcp_dpu_kms_cleanup_bridges(drv->kms);
+		return ret;
+	}
+
+	return 0;
+}
+
+void dcp_component_unregister(struct dcp_drv *drv)
+{
+	struct device *dev = &drv->dcp_subsystem_dev->dev;
+
+	component_master_del(dev, &msm_drm_ops);
+	dcp_dpu_kms_cleanup_bridges(drv->kms);
+}
+
+static int dcp_panic_notifier_cb(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct dcp_drv *drv = container_of(nb, struct dcp_drv, panic_notifier);
+
+	if (drv->hfi)
+		atomic_set(&drv->hfi->shutdown_in_progress, 1);
+
+	return NOTIFY_OK;
+}
+
+void dcp_panic_notifier_register(struct dcp_drv *drv)
+{
+	drv->panic_notifier.notifier_call = dcp_panic_notifier_cb;
+	atomic_notifier_chain_register(&panic_notifier_list, &drv->panic_notifier);
+}
+
+void dcp_panic_notifier_unregister(struct dcp_drv *drv)
+{
+	atomic_notifier_chain_unregister(&panic_notifier_list, &drv->panic_notifier);
+}
+
+void __init msm_dcp_register(void)
+{
+	dcp_virtio_register();
+}
+
+void __exit msm_dcp_unregister(void)
+{
+	dcp_virtio_unregister();
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
index 44d9b2cd5171..b19f8027aa3a 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_drv.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
@@ -12,7 +12,9 @@
 
 #include "dcp_hfi.h"
 
+struct virtio_device;
 struct dcp_dpu_kms;
+struct component_match;
 
 struct dcp_drv {
 	struct virtio_device	*vdev;
@@ -23,6 +25,19 @@ struct dcp_drv {
 	struct dcp_dpu_kms	*kms;
 	struct dcp_caps		 caps;
 	struct notifier_block	 panic_notifier;
+	bool			 vqs_allocated;
 };
 
+int dcp_subsystem_dev_init(struct dcp_drv *drv);
+void dcp_subsystem_dev_deinit(struct dcp_drv *drv);
+
+int dcp_component_register(struct dcp_drv *drv);
+void dcp_component_unregister(struct dcp_drv *drv);
+
+int dcp_pm_prepare(struct device *vdev_dev);
+void dcp_pm_complete(struct device *vdev_dev);
+
+void dcp_panic_notifier_register(struct dcp_drv *drv);
+void dcp_panic_notifier_unregister(struct dcp_drv *drv);
+
 #endif /* __DCP_DRV_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.c b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
new file mode 100644
index 000000000000..595e0650103c
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * DCP VirtIO device driver.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ids.h>
+
+#include "dcp_drv.h"
+#include "dcp_dpu_kms.h"
+#include "dcp_hfi.h"
+#include "dcp_virtio.h"
+#include "msm_drv.h"
+#include "msm_kms.h"
+
+static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv);
+
+static const unsigned int dcp_virtio_features[] = {
+	VIRTIO_F_VERSION_1,
+	VIRTIO_F_NOTIFICATION_DATA,
+	VIRTIO_F_RING_RESET,
+	VIRTIO_F_ACCESS_PLATFORM,
+};
+
+static int dcp_virtio_find_vqs(struct virtio_device *vdev,
+			       struct virtqueue *vqs[DCP_NUM_VQS])
+{
+	struct virtqueue_info vqs_info[DCP_NUM_VQS] = {
+		[DCP_VQ_CMD]  = { .name = "cmd",  .callback = dcp_hfi_cmd_callback },
+		[DCP_VQ_RESP] = { .name = "resp", .callback = dcp_hfi_resp_callback },
+	};
+
+	return virtio_find_vqs(vdev, DCP_NUM_VQS, vqs, vqs_info, NULL);
+}
+
+/*
+ * The VirtIO core owns transport discovery. This driver owns HFI setup and
+ * creates the DRM component only after firmware capabilities are available.
+ */
+static int dcp_virtio_probe(struct virtio_device *vdev)
+{
+	struct dcp_drv *drv;
+	struct virtqueue *vqs[DCP_NUM_VQS];
+	struct dcp_dpu_kms *dcp_kms;
+	struct msm_drm_private *priv;
+	int ret;
+
+	/* The VENDOR device ID is shared; this host DT node identifies DCP. */
+	if (!vdev->dev.parent ||
+	    !of_device_is_compatible(vdev->dev.parent->of_node,
+				     "qcom,dcp-virtio"))
+		return -ENODEV;
+
+	dev_dbg(&vdev->dev, "DCP VirtIO probe started\n");
+
+	drv = devm_kzalloc(&vdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->vdev = vdev;
+	vdev->priv = drv;
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+		dev_err(&vdev->dev, "VIRTIO_F_VERSION_1 not negotiated\n");
+		return -ENODEV;
+	}
+
+	/* Access-platform is required for the firmware-visible IOVA mappings. */
+	if (!virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM)) {
+		dev_err(&vdev->dev, "VIRTIO_F_ACCESS_PLATFORM not negotiated\n");
+		return -ENODEV;
+	}
+
+	ret = dcp_subsystem_dev_init(drv);
+	if (ret)
+		return ret;
+
+	ret = dcp_virtio_find_vqs(vdev, vqs);
+	if (ret) {
+		dev_err(&vdev->dev, "virtqueue allocation failed: %d\n", ret);
+		goto err_fn_dev;
+	}
+
+	drv->vqs_allocated = true;
+	ret = dcp_hfi_init(drv, vdev, vqs[DCP_VQ_CMD], vqs[DCP_VQ_RESP],
+			   vdev->dev.parent);
+	if (ret) {
+		dev_err(&vdev->dev, "HFI init failed: %d\n", ret);
+		goto err_del_vqs;
+	}
+
+	/*
+	 * Keep the device unready until HFI state and virtqueues are initialized.
+	 * KMS registration below depends on synchronous firmware initialization.
+	 */
+	virtio_device_ready(vdev);
+	virtqueue_kick(drv->hfi->resp_vq);
+
+	ret = dcp_hfi_send_device_init(drv->hfi);
+	if (ret) {
+		dev_err(&vdev->dev, "HFI DEVICE_INIT failed: %d\n", ret);
+		goto err_hfi_deinit;
+	}
+
+	ret = dcp_hfi_get_capabilities(drv->hfi, &drv->caps);
+	if (ret) {
+		dev_err(&vdev->dev, "HFI GET_CAPS failed: %d\n", ret);
+		goto err_hfi_deinit;
+	}
+
+	dev_dbg(&vdev->dev,
+		"DCP caps: %u displays, max %ux%u, %u planes\n",
+		drv->caps.num_displays, drv->caps.max_width, drv->caps.max_height,
+		drv->caps.max_planes);
+
+	dcp_kms = devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*dcp_kms), GFP_KERNEL);
+	if (!dcp_kms) {
+		ret = -ENOMEM;
+		goto err_hfi_deinit;
+	}
+
+	dcp_kms->drv       = drv;
+	dcp_kms->pm_dev    = &drv->dcp_subsystem_dev->dev;
+	dcp_kms->hfi       = drv->hfi;
+	dcp_kms->caps      = &drv->caps;
+	dcp_kms->dpus_np   = drv->dcp_subsystem_node;
+	dcp_kms->iommu_dev = &drv->dcp_subsystem_dev->dev;
+	drv->kms        = dcp_kms;
+
+	ret = msm_kms_init(&dcp_kms->base, &dcp_dpu_kms_funcs);
+	if (ret) {
+		dev_err(&vdev->dev, "msm_kms_init failed: %d\n", ret);
+		goto err_hfi_deinit;
+	}
+
+	priv = devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_hfi_deinit;
+	}
+
+	priv->kms      = &dcp_kms->base;
+	priv->kms_init = dcp_kms_init;
+	dev_set_drvdata(&drv->dcp_subsystem_dev->dev, priv);
+	dcp_kms->rpm_enabled = true;
+
+	/* Component binding now sees initialized HFI, capabilities, and IOMMU state. */
+	ret = dcp_component_register(drv);
+	if (ret) {
+		dev_err_probe(&vdev->dev, ret, "component register failed\n");
+		goto err_hfi_deinit;
+	}
+
+	dcp_panic_notifier_register(drv);
+
+	dev_dbg(&vdev->dev, "DCP VirtIO probe complete\n");
+	return 0;
+
+err_hfi_deinit:
+	dcp_virtio_hfi_cleanup(drv);
+	goto err_fn_dev;
+err_del_vqs:
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+	drv->vqs_allocated = false;
+err_fn_dev:
+	dcp_subsystem_dev_deinit(drv);
+	return ret;
+}
+
+static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv)
+{
+	struct virtio_device *vdev = drv->vdev;
+
+	if (!drv->hfi)
+		return;
+
+	dcp_hfi_stop(drv->hfi);
+	virtio_reset_device(vdev);
+	virtio_synchronize_cbs(vdev);
+	if (drv->vqs_allocated) {
+		dcp_hfi_quiesce_queues(drv->hfi);
+		vdev->config->del_vqs(vdev);
+		drv->vqs_allocated = false;
+	}
+	drv->hfi->cmd_vq = NULL;
+	drv->hfi->resp_vq = NULL;
+	dcp_hfi_deinit(drv->hfi);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int dcp_virtio_freeze(struct virtio_device *vdev)
+{
+	struct dcp_drv *drv = vdev->priv;
+
+	dcp_hfi_stop(drv->hfi);
+	virtio_reset_device(vdev);
+	virtio_synchronize_cbs(vdev);
+	if (drv->vqs_allocated) {
+		dcp_hfi_quiesce_queues(drv->hfi);
+		vdev->config->del_vqs(vdev);
+		drv->vqs_allocated = false;
+	}
+	drv->hfi->cmd_vq = NULL;
+	drv->hfi->resp_vq = NULL;
+
+	return 0;
+}
+
+static int dcp_virtio_restore(struct virtio_device *vdev)
+{
+	struct dcp_drv *drv = vdev->priv;
+	struct virtqueue *vqs[DCP_NUM_VQS];
+	int ret;
+
+	ret = dcp_virtio_find_vqs(vdev, vqs);
+	if (ret)
+		return ret;
+	drv->vqs_allocated = true;
+
+	ret = dcp_hfi_restore_queues(drv->hfi, vqs[DCP_VQ_CMD],
+				     vqs[DCP_VQ_RESP]);
+	if (ret) {
+		virtio_reset_device(vdev);
+		virtio_synchronize_cbs(vdev);
+		dcp_hfi_quiesce_queues(drv->hfi);
+		drv->vqs_allocated = false;
+		vdev->config->del_vqs(vdev);
+		drv->hfi->cmd_vq = NULL;
+		drv->hfi->resp_vq = NULL;
+		return ret;
+	}
+
+	virtio_device_ready(vdev);
+	virtqueue_kick(vqs[DCP_VQ_RESP]);
+
+	return 0;
+}
+#endif
+
+/* Remove DRM users before tearing down HFI and the VirtIO queues. */
+static void dcp_virtio_remove(struct virtio_device *vdev)
+{
+	struct dcp_drv *drv = vdev->priv;
+
+	dev_dbg(&vdev->dev, "DCP VirtIO remove\n");
+
+	dcp_component_unregister(drv);
+	dcp_panic_notifier_unregister(drv);
+
+	dcp_virtio_hfi_cleanup(drv);
+
+	dcp_subsystem_dev_deinit(drv);
+}
+
+/* KMS shutdown must complete while the firmware transport is available. */
+static void dcp_virtio_shutdown(struct virtio_device *vdev)
+{
+	struct dcp_drv *drv = vdev->priv;
+
+	pm_runtime_get_sync(&drv->dcp_subsystem_dev->dev);
+	msm_kms_shutdown(drv->dcp_subsystem_dev);
+	pm_runtime_put_noidle(&drv->dcp_subsystem_dev->dev);
+}
+
+static const struct virtio_device_id dcp_virtio_id_table[] = {
+	{ VIRTIO_ID_VENDOR, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+MODULE_DEVICE_TABLE(virtio, dcp_virtio_id_table);
+
+static const struct dev_pm_ops dcp_virtio_pm_ops = {
+	.prepare = dcp_pm_prepare,
+	.complete = dcp_pm_complete,
+};
+
+static struct virtio_driver dcp_virtio_driver = {
+	.driver = {
+		.name  = "qcom-dcp-hfi",
+		.owner = THIS_MODULE,
+		.pm    = &dcp_virtio_pm_ops,
+	},
+	.id_table           = dcp_virtio_id_table,
+	.feature_table      = dcp_virtio_features,
+	.feature_table_size = ARRAY_SIZE(dcp_virtio_features),
+	.probe              = dcp_virtio_probe,
+	.remove             = dcp_virtio_remove,
+	.shutdown           = dcp_virtio_shutdown,
+#ifdef CONFIG_PM_SLEEP
+	.freeze             = dcp_virtio_freeze,
+	.restore            = dcp_virtio_restore,
+#endif
+};
+
+int dcp_virtio_register(void)
+{
+	return register_virtio_driver(&dcp_virtio_driver);
+}
+
+void dcp_virtio_unregister(void)
+{
+	unregister_virtio_driver(&dcp_virtio_driver);
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.h b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
new file mode 100644
index 000000000000..c9cda98d4496
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DCP_VIRTIO_H__
+#define __DCP_VIRTIO_H__
+
+int dcp_virtio_register(void);
+void dcp_virtio_unregister(void);
+
+#endif /* __DCP_VIRTIO_H__ */
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index aa5dfd82ac6f..befaa9f2cb5c 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -417,6 +417,14 @@ static inline void msm_dpu_register(void) {}
 static inline void msm_dpu_unregister(void) {}
 #endif
 
+#ifdef CONFIG_DRM_MSM_DCP
+void msm_dcp_register(void);
+void msm_dcp_unregister(void);
+#else
+static inline void msm_dcp_register(void) {}
+static inline void msm_dcp_unregister(void) {}
+#endif
+
 #ifdef CONFIG_DRM_MSM_MDSS
 void msm_mdss_register(void);
 void msm_mdss_unregister(void);

-- 
2.43.0

