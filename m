Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE2AC5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84A110E3BF;
	Mon, 17 Aug 2026 04:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tq7/CKLl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nfb1W8R+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D3310E3BF
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:14 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCopM4127041
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JVjFJFtknCk1hPV1W6+tmqWmCFFfNSl+ERw3V/UKgOU=; b=Tq7/CKLlE9faSu2m
 tIaFs6SSgYkRq7YwTULJ9MBBH6Cp56eDTjNloeM2qco/DlJQAgIeF6jH3ck+2sfW
 ++aajZBP2dLztsk62mFbUKIHTWgP0cnSjzbJCXFhLrqApN+540I/4mmAL2WneaY/
 81G711T7UXSdvgtADaHcdeWQbgIvc7JFf88TNLarOOW67iA3L/IBaNKIsutO+CTx
 yBjwhEolEbReiNjYyed06L/jCohOc7jsv4WzXRC6Z5s5uuaZO1dD9LFFOG5ASfXg
 IWRnn4jh5dDRlq+AM59ndofVBHvONJZbTXfNetipA2UVYl1cnzc+bqHL5Ee5JInn
 IBVS7A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g322qauf9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84865f326efso3043729b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942093; x=1787546893;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JVjFJFtknCk1hPV1W6+tmqWmCFFfNSl+ERw3V/UKgOU=;
 b=Nfb1W8R+kgRYzTITvuzq8IesR6VYWUdQn3mbayEomsxUCHQ5ncZo1dtgltLEKkeg3N
 SE9cItgbvuRhtxT+DcnIWZgA62071FGIPDV358VBfGTaNXngvbszlSAbcggdIl2HrhWl
 YSDhcnYkUYhP5RKmlIty8rHXGOrrausbwPDoQW70feFFWVHCMDW30cmctTGKzE9KWMhE
 wc9dv+fg1piw+USxB8II9twmEr6pRAJB+epPgDLB87wDWasGjawN4qtOgR47WIxkS06o
 15qonSQziMEI3M+fsErHz8x+UGYZfZgKnao+eUibfc6TgjkQRDgeMNJwfZiIs1UoQu8N
 MNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942093; x=1787546893;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JVjFJFtknCk1hPV1W6+tmqWmCFFfNSl+ERw3V/UKgOU=;
 b=WMtmoIA265/NYJ+8VWLjpW/GOTjaUp15ue795xNdKIkF3+b6wdNWRSY4Nl/oVd0/Gc
 iRvS7CkgbNiDOHFdTG5szPSV8UjknUefuKYFnLrjD84nh/1NXsyfcpOVKTEjMJ7KUav0
 oQY92UI3pzUNZDSA3hpsi3e9dOoO5oHqWRGvsewvEmY2DMZ6NkuefmaFVZ5mIBpdqS03
 RaKPJ0fjawTc8SU9b3bJM88GdynTwdkUHHocEGrhO/8NSi2nbDdaPvsF37mpj1A+oIIP
 F3peQgeCC7moRNzEwm7sQ1gP6navLMpePivpp/P8BzYv+lmgJeWFBE7wdPQMZKUZooCU
 cSuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMYIaFqLVGIGhYcyLS1Ny3dCJiJkfnvxA+UyJWEDsBXbOtU3GwQhRtDn314yC4tzp1bQ5i1YPQ9is=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsJpk7g0Y3t9Tmys+Qc6IYFF92qfQfqu6eYm8v8xkuXhiM44if
 gFilhuCahFchhT9FhSQWCJIHSWZ85y+maEQoYFYjqdGmS6++LQDMGpqZ/gGLmS8OQFwbsagQYsn
 IOT+1+pvGUzvuCMi4Op4Zjnpmw1F0PSK6GyC+PTBywNsKefWCzGO91kA0hYcOFNBxbhKwQcs=
X-Gm-Gg: AR+sD10ctV10CcRFLbIOGE+GOP5UqYr1J8pduSnHXpzU7DHe7nC+IBNvEdQU4W5qplG
 D3ibS6Bw3IvySvgbx5W9PYrqwdRuQSDFIb+35RBUxaHwOREU1LnJfC68BtBLiawI5OE/BbsJPun
 re3blLrlB3uNMmkIv44mMiKTe7S+CdrNegOsy8/f8ofKfGCu9Nmk+5ejTliIfag9H4U4sECUnFw
 9WZ5G2DOPLwFpi/zfTHzjHg0XBZJ1K/JueXluzUjosTcUvdC7TqgWxnt2iRACtOCay0TLVUZWYi
 A89eYOcxQnvgHu12coOMf/q2KWaRsKkRfDve1DAjM7zApKFgr4xKA9oF3iy2Zr/PSFePkc/TSgS
 yJ6s6gf0Q/hHJhh4mM7bANsm+21KRUBnz
X-Received: by 2002:a05:6a00:4c19:b0:848:3dae:66e2 with SMTP id
 d2e1a72fcca58-84fde75cc05mr22597324b3a.26.1786942093109; 
 Sun, 16 Aug 2026 21:48:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c19:b0:848:3dae:66e2 with SMTP id
 d2e1a72fcca58-84fde75cc05mr22597268b3a.26.1786942092551; 
 Sun, 16 Aug 2026 21:48:12 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:48:12 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:38 +0530
Subject: [PATCH v2 03/15] accel/qda: Add initial QDA DRM accelerator driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-qda-v2-v2-3-69a02e9090d4@oss.qualcomm.com>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
In-Reply-To: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=10592;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=bdDPnz4gcKq0coBCdyc5K/JNPp8U0dWJWPQTjY7EdTs=;
 b=7hqbodnBNfBtCiJxftXub0GuG+tbSMtMDHXcKo6Cm1fICatkFdia93n9EEnsnOxE2Syq1HdNW
 MikWkslPnHRBxXTYTilta3uvOCxvTA0/pwHSrddTyF9udp0iTi1uREK
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX3gjKhGFzeEEE
 ZA/7EGzW4AahZmREWIjINYglxDfAyR18pdugqt9yuRngh2EntTXhlpeOcL41B6hWF1kT9oSUOce
 YKMBeN5GKAKkmdie8c7u7dAUJKYz/LE=
X-Proofpoint-GUID: XggXNYykwkc_ONnpXxWjXG-aakOhw5tq
X-Authority-Analysis: v=2.4 cv=C5PZDwP+ c=1 sm=1 tr=0 ts=6a82928d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=1wMbdgC_A7jj-OG1YmsA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfXxEc7zi18e7ym
 snpb//wwNOZSpFYYgi+0wj1zlaErVIvmZv++DZJ3R6XNppRYGULly+gMo7CiYgTaeQxg9rZzFsx
 +zAa9iT078Q5FqUKik03t0n91x3Q8Yx88r3v8MxsSH7sUgXKgIlrt7mnSSkmhC7hrsx0IOybGOh
 n0cmoAc/RZ8k//RPS5nF39hr4SQcod8EKkSPBCsnDdZmOKTSuSDzE5w0LZ6ShdHERTDVeVn2imX
 9+AN9b1NJTFYKxS/1C5RDQjieAwF3kLqz8ArcIGpah2VXeNGHLl8Lyck57F93TBWlub1L2J0W1/
 li54GTultctG9DXBYPB06CA+w/ozcids6x5QdRbPv9dW1vvXZYCG+hdEE7slT4xw13VvmbPyQsX
 luzIMhakI7stPqiWvYyS7WXXtilSog4oRNDAO5F48K5LHjKOpJPD7sZxTVDr4FaJ1MEv49FOHMK
 g/9mme/dcsnE7/0dKcA==
X-Proofpoint-ORIG-GUID: XggXNYykwkc_ONnpXxWjXG-aakOhw5tq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170033
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

Add the skeleton of the Qualcomm DSP Accelerator (QDA) driver, a DRM
accel driver for the Hexagon DSPs found on Qualcomm SoCs.

This patch registers a DRM accel device, exposing a /dev/accel/accelN
character device node, and binds it to the RPMsg channel used to reach
the DSP. Buffer management, IOMMU context banks and the FastRPC
protocol are added by later patches in this series.

qda_drv.c / qda_drv.h define the drm_driver ops table, the per-file
private state (qda_file_priv) and the main device structure (qda_dev),
which embeds drm_device so that it can be recovered with container_of().

qda_rpmsg.c binds to the "qcom,fastrpc" compatible via
module_rpmsg_driver(), reads the DSP domain name from the "label"
device-tree property, and registers the DRM device.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Changes in v2:
- Use module_rpmsg_driver() and drop the qda_rpmsg_register()/
  _unregister() wrappers, module_init()/module_exit() and
  qda_rpmsg.h entirely (Dmitry Baryshkov)
- Read the "label" property directly into qdev->dsp_name (Dmitry Baryshkov)
- Drop the probe/remove/init log messages (Dmitry Baryshkov)
- Return the result of qda_register_device() directly (Dmitry Baryshkov)
- Clarify the Kconfig help text (Dmitry Baryshkov)
---
 drivers/accel/Kconfig         |  1 +
 drivers/accel/Makefile        |  1 +
 drivers/accel/qda/Kconfig     | 30 ++++++++++++++++
 drivers/accel/qda/Makefile    | 10 ++++++
 drivers/accel/qda/qda_drv.c   | 71 ++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_drv.h   | 61 +++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_rpmsg.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 253 insertions(+)

diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
index bdf48ccafcf2..74ac0f71bc9d 100644
--- a/drivers/accel/Kconfig
+++ b/drivers/accel/Kconfig
@@ -29,6 +29,7 @@ source "drivers/accel/ethosu/Kconfig"
 source "drivers/accel/habanalabs/Kconfig"
 source "drivers/accel/ivpu/Kconfig"
 source "drivers/accel/qaic/Kconfig"
+source "drivers/accel/qda/Kconfig"
 source "drivers/accel/rocket/Kconfig"
 
 endif
diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 1d3a7251b950..58c08dd5f389 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
 obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
 obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
 obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
+obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
 obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
\ No newline at end of file
diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
new file mode 100644
index 000000000000..e679cd00f092
--- /dev/null
+++ b/drivers/accel/qda/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Qualcomm DSP accelerator driver
+#
+
+config DRM_ACCEL_QDA
+	tristate "Qualcomm DSP accelerator"
+	depends on DRM_ACCEL
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on RPMSG
+	help
+	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
+	  This driver provides a standardized interface for offloading computational
+	  tasks to the DSP, including audio processing, sensor offload, computer
+	  vision, and AI inference workloads.
+
+	  The driver supports all DSP domains (ADSP, CDSP, SDSP, GDSP) and
+	  implements the FastRPC protocol for communication between the application
+	  processor and DSP. It integrates with the Linux kernel's Compute
+	  Accelerators subsystem (drivers/accel/) and provides a modern alternative
+	  to the legacy FastRPC driver found in drivers/misc/.
+
+	  The interface exposed to userspace is described in
+	  include/uapi/drm/qda_accel.h and is used by the FastRPC userspace
+	  library at https://github.com/qualcomm/fastrpc.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called qda.
diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
new file mode 100644
index 000000000000..dbe809067a8b
--- /dev/null
+++ b/drivers/accel/qda/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for Qualcomm DSP accelerator driver
+#
+
+obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
+
+qda-y := \
+	qda_drv.o \
+	qda_rpmsg.o
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
new file mode 100644
index 000000000000..9a64f7dfcb6e
--- /dev/null
+++ b/drivers/accel/qda/qda_drv.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <drm/drm_accel.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_print.h>
+
+#include "qda_drv.h"
+
+static int qda_open(struct drm_device *dev, struct drm_file *file)
+{
+	struct qda_file_priv *qda_file_priv;
+
+	qda_file_priv = kzalloc_obj(*qda_file_priv);
+	if (!qda_file_priv)
+		return -ENOMEM;
+
+	qda_file_priv->qda_dev = qda_dev_from_drm(dev);
+	file->driver_priv = qda_file_priv;
+
+	return 0;
+}
+
+static void qda_postclose(struct drm_device *dev, struct drm_file *file)
+{
+	struct qda_file_priv *qda_file_priv = file->driver_priv;
+
+	kfree(qda_file_priv);
+	file->driver_priv = NULL;
+}
+
+DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
+
+static const struct drm_driver qda_drm_driver = {
+	.driver_features = DRIVER_COMPUTE_ACCEL,
+	.fops = &qda_accel_fops,
+	.open = qda_open,
+	.postclose = qda_postclose,
+	.name = QDA_DRIVER_NAME,
+	.desc = "Qualcomm DSP Accelerator Driver",
+};
+
+struct qda_dev *qda_alloc_device(struct device *dev)
+{
+	struct qda_dev *qdev;
+
+	qdev = devm_drm_dev_alloc(dev, &qda_drm_driver, struct qda_dev, drm_dev);
+	if (IS_ERR(qdev))
+		return ERR_CAST(qdev);
+
+	return qdev;
+}
+
+int qda_register_device(struct qda_dev *qdev)
+{
+	int ret;
+
+	ret = drm_dev_register(&qdev->drm_dev, 0);
+	if (ret)
+		drm_err(&qdev->drm_dev, "Failed to register DRM device: %d\n", ret);
+
+	return ret;
+}
+
+MODULE_AUTHOR("Qualcomm AI Infra Team");
+MODULE_DESCRIPTION("Qualcomm DSP Accelerator Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
new file mode 100644
index 000000000000..4a27fb40c280
--- /dev/null
+++ b/drivers/accel/qda/qda_drv.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_DRV_H__
+#define __QDA_DRV_H__
+
+#include <linux/device.h>
+#include <linux/rpmsg.h>
+#include <linux/types.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+
+/* Driver identification */
+#define QDA_DRIVER_NAME "qda"
+
+/**
+ * struct qda_file_priv - Per-process private data for DRM file
+ */
+struct qda_file_priv {
+	/** @qda_dev: Back-pointer to device structure */
+	struct qda_dev *qda_dev;
+};
+
+/**
+ * struct qda_dev - Main device structure for QDA driver
+ *
+ * The DRM device is embedded as the first member so that container_of()
+ * can recover the qda_dev from any drm_device pointer.
+ */
+struct qda_dev {
+	/** @drm_dev: Embedded DRM device; recover via qda_dev_from_drm() */
+	struct drm_device drm_dev;
+	/** @rpdev: RPMsg device for communication with the remote processor */
+	struct rpmsg_device *rpdev;
+	/** @dev: Underlying Linux device */
+	struct device *dev;
+	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
+	const char *dsp_name;
+};
+
+/**
+ * qda_dev_from_drm - Recover qda_dev from an embedded drm_device pointer
+ * @dev: Pointer to the embedded drm_device
+ *
+ * Return: Pointer to the enclosing qda_dev.
+ */
+static inline struct qda_dev *qda_dev_from_drm(struct drm_device *dev)
+{
+	return container_of(dev, struct qda_dev, drm_dev);
+}
+
+/* Device allocation (uses devm_drm_dev_alloc internally) */
+struct qda_dev *qda_alloc_device(struct device *dev);
+
+/* Core device lifecycle */
+int qda_register_device(struct qda_dev *qdev);
+
+#endif /* __QDA_DRV_H__ */
diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
new file mode 100644
index 000000000000..6a6e58333a68
--- /dev/null
+++ b/drivers/accel/qda/qda_rpmsg.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/rpmsg.h>
+#include <drm/drm_print.h>
+
+#include "qda_drv.h"
+
+static struct qda_dev *qda_rpmsg_alloc_and_init_qdev(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev;
+
+	qdev = qda_alloc_device(&rpdev->dev);
+	if (IS_ERR(qdev))
+		return qdev;
+
+	qdev->dev = &rpdev->dev;
+	qdev->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, qdev);
+
+	return qdev;
+}
+
+static int qda_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
+			void *priv, u32 src)
+{
+	/* Placeholder: responses will be dispatched here */
+	return 0;
+}
+
+static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev = dev_get_drvdata(&rpdev->dev);
+
+	/*
+	 * Unplug first so no ioctl or response callback can be in flight, then
+	 * fail any invocation still waiting for the now-departed DSP so it
+	 * releases the GEM objects it holds.
+	 */
+	drm_dev_unplug(&qdev->drm_dev);
+	qdev->rpdev = NULL;
+}
+
+static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev;
+	int ret;
+
+	qdev = qda_rpmsg_alloc_and_init_qdev(rpdev);
+	if (IS_ERR(qdev))
+		return PTR_ERR(qdev);
+
+	ret = of_property_read_string(rpdev->dev.of_node, "label", &qdev->dsp_name);
+	if (ret) {
+		dev_err(&rpdev->dev, "Missing 'label' property in DT node: %d\n", ret);
+		return ret;
+	}
+
+	return qda_register_device(qdev);
+}
+
+static const struct of_device_id qda_rpmsg_id_table[] = {
+	{ .compatible = "qcom,fastrpc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, qda_rpmsg_id_table);
+
+static struct rpmsg_driver qda_rpmsg_driver = {
+	.probe = qda_rpmsg_probe,
+	.remove = qda_rpmsg_remove,
+	.callback = qda_rpmsg_cb,
+	.drv = {
+		.name = "qcom,fastrpc",
+		.of_match_table = qda_rpmsg_id_table,
+	},
+};
+
+module_rpmsg_driver(qda_rpmsg_driver);

-- 
2.34.1

