Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB621075261
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C08A410E860;
	Thu, 19 Mar 2026 06:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HviWnwVj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C57A1ewc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2F110E860
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:31:58 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J5XdhX831272
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pD2aEY9dZogWGWfrJ0ewLTBoCN0zxUacyNzSIWJJ810=; b=HviWnwVjN+4miLXg
 WEqDIq8wMzPV3HzvNEcYIQEWEcXP5qTrPUMtBHkTiyarFe5/aLdfzc/mMqFwxvtk
 bMEBJpsQHUVHhvolh1gag9WtmGVO9gduAbUOK29nMki8+foFatMZ33NH8TyuCWGD
 P0kJqMx8TtRcaNK+K9OPdudsaWoZao6RnFHNCTcYr9/A76tT3l3CW2fstOiyV+RX
 OS5o27d8owJNGzxbcI+rv2hFAFK++kqWUUU6uL+ov0petfJkH3tZlFae3PM7zV8q
 tMya79RbgwOquJ2UVgRVO8eHi1tPfE2l8fhIRlzr1adMnLzPsSvhCWiUpK9/oAH2
 Fv0epw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0032j6n2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:31:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aecfe69196so4714655ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 23:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773901916; x=1774506716;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pD2aEY9dZogWGWfrJ0ewLTBoCN0zxUacyNzSIWJJ810=;
 b=C57A1ewclwto93xP/t7Nbb1ed9UREXFqh6qFLeFRO/Fif7lHJYyZHPuuiGjXIAjcBG
 BeBH3yh1uTLRnMJE3y76wAtfXuNcyRo+S8H6725kO0sMBdkrTwELT8pjZv5gIsERQF4Z
 S5th6G1KZ47AFMuEjr0CTB5fvXxP6kHAZ86D8w7yoN//DRQGqzZJ5iIkVEixx3J9IOkq
 YEXCb9Vz4IacP5amavHovandIJXJQwMwN7Vk7Z1h2Mp4ju0lWxJpkEx6ncFCvv79/tB6
 X1QlVVWgyd5feBiKaW9W6icLDI5hhzAeRQJKJ/HUmMRsBztd/Zb6SOJwFDiIsKFF8BYj
 wZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773901916; x=1774506716;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pD2aEY9dZogWGWfrJ0ewLTBoCN0zxUacyNzSIWJJ810=;
 b=s6g1LUWHwUc8xRP1vUSSsiLUuECvHfVenf7JrEyvfqxZuOxmawWYR01UMXfc922pWa
 aAVVp6coVUSs5YFOzhdqkzJCGdZDNCeP6iHj6fUU+JhoRCcg5sA/G3da0FPG4N1hqKCU
 xL5DbdYVlWzB4RXmfQ97gTgWVCVQlGnHvuBZCOhOPnE7f5SfJemTIpOERVAbIGsyxu6T
 oYMVATCp+ZJIA7nOdb6CGcj+gZ2EJfeUx32KsNeD6+WRqPKyKXBmoX+GDPWWFYQp5fl2
 IZxv+fH5+m0qOw/txXnO7bvCX5k51XckyWVfNSwrTKHXxu1I2hIVnME6M5ddTHZ4PnSp
 184A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4/20TZJGNmriEIq45168HCUfU6Yeomo/YPPHcBL1L/5hNJE7ChCB8cDw4z9SBH50vWV08Ci9Bx80=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXnf0fWEQOGS1U4EkxrAoXhOLpPVPATmPjH7FZFy0FwVSCLiXT
 EwVDWVbFk5LtBkoHV7STkW/fTXb5P9afXxpY9LLvUvOkRG3CjIezt7FEdtOClO/AI73+dOzBwOc
 k5Hhz1SJMaigk9k3cPeH7IcQ7T5EPkfFaK0QDtBz39sF6gy3CBvRfGylHmh/KNp7ggMLYAqayFd
 G14eA=
X-Gm-Gg: ATEYQzzeZdz43Bg3BBfyv7nqnXeV6fOWT16D5KUQwdTyMfpDP8yhBp/PUud6zfOuCLi
 0H8KyukN856YVuZuJDNHQVatwpntMTyufPznr57L/tgQHBxOxl2SQLwc5XfjJsV3OHmcYrVhmm/
 QsgMwaCPVuALtYmfY5qONHkYvMPN4i9vCyLP+opiHA11MNjhSxkrRw+K+wI3JejbwjrlXsnPIqS
 9OZHPsdzVQE+TOkLnJ7sw24DrLHe5omHSMfiJDk0hPkZrmakTjyTV/kL9muUnIUH4wRmtZk2rOm
 2RYjUaLfu/38hfoxPxQD6bS65FStwBWhBmwo9FsVOlGoQIZWQJBe0aLGoqJyV24vhFBotrMrtn0
 DgSjNofEYt8yxjnt5IIpoa/nD8l8C0ShNHZh4fuF6gjzIS2xe49U=
X-Received: by 2002:a17:903:1a67:b0:2b0:5a4c:726a with SMTP id
 d9443c01a7336-2b06e41afc9mr57930035ad.43.1773901916050; 
 Wed, 18 Mar 2026 23:31:56 -0700 (PDT)
X-Received: by 2002:a17:903:1a67:b0:2b0:5a4c:726a with SMTP id
 d9443c01a7336-2b06e41afc9mr57929645ad.43.1773901915508; 
 Wed, 18 Mar 2026 23:31:55 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e603937sm48572485ad.57.2026.03.18.23.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 23:31:55 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 12:01:42 +0530
Subject: [PATCH v4 2/9] bus: mhi: Move sahara protocol driver under
 drivers/bus/mhi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-sahara_protocol_new_v2-v4-2-47ad79308762@oss.qualcomm.com>
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773901902; l=7115;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=9tH2JRuQd/Ntg0H7RVSyFLnl0a6EFmaIQsmT7afSET0=;
 b=6q/DYzaxgzAsKW6ELr/JOhWo50oh5Rnj4wO+vwDmS0IpVLFCLr5domUKlxH8fnAs2r8vwr1Oo
 hF/k8fjzdMNAz1MY8ssF70N98PwgfPpONfm0KrK1Tx76sZYm612mscl
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-ORIG-GUID: eQLHSBiqSf9MMAs3Rpf1ZJIX9jlV8sZD
X-Proofpoint-GUID: eQLHSBiqSf9MMAs3Rpf1ZJIX9jlV8sZD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0OSBTYWx0ZWRfX0zrxaDDQLs1X
 khG6l/9plyUE5ZBdr9VUnwH+l/WJt9y8UeRjBd9JZUfBJWU8ki/yZuOzEUcI8rFLVGeRHR/HuNT
 vdqB2r8WrfJbC+iwgPUHTYjLD9YdRlf6Qj5AGbEV+++MMIRgjk8jKbOhXM0rf87lNvZN7PSh8lU
 F/Bbs53SdoXz1JGbCjtaoX7L8/YjAzYjK576ylKiKD6QcBu1JHFmzCxQ8iHZGgthCUESvTmm94a
 YdkQDs8MCHeSOqGRfpSK67432Jh/NFSCKtLyir7x3kFKiTBXPp06y5h7b5zhqKJXWpeMr+MJ6eu
 hldRDYdputi28D4sKLeri/XZzzEbmTjhVG5iiMcc1Zjge3zal2wvKc/ok0Ajz1UgnzLBdF1c8UG
 ymq5wJZwPChGxYuxuz5YhE6dLA3/8PYxaHA6f4D2B1pTkslfOiFtV08NCODbWjrQE/vOb+hDGf1
 fwJFDLgrDOmTmPry66Q==
X-Authority-Analysis: v=2.4 cv=WO9yn3sR c=1 sm=1 tr=0 ts=69bb985d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=YoiwXk0N_qN2JQiW-xcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190049
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

The Sahara protocol driver is currently located under the QAIC
accelerator subsystem even though protocol itself is transported over the
MHI bus and is used by multiple Qualcomm flashless devices.

Relocate the Sahara protocol driver to drivers/bus/mhi and register it as
an independent MHI protocol driver. This avoids treating Sahara as QAIC
specific and makes it available for reuse by other MHI based devices.

As part of this move, introduce a dedicated Kconfig and Makefile under the
MHI subsystem and expose the sahara interface via a common header.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 drivers/accel/qaic/Kconfig                      |  1 +
 drivers/accel/qaic/Makefile                     |  3 +--
 drivers/accel/qaic/qaic_drv.c                   | 11 ++---------
 drivers/bus/mhi/Kconfig                         |  1 +
 drivers/bus/mhi/Makefile                        |  3 +++
 drivers/bus/mhi/sahara/Kconfig                  | 18 ++++++++++++++++++
 drivers/bus/mhi/sahara/Makefile                 |  2 ++
 drivers/{accel/qaic => bus/mhi/sahara}/sahara.c | 16 +++++++++++-----
 {drivers/accel/qaic => include/linux}/sahara.h  |  0
 9 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/accel/qaic/Kconfig b/drivers/accel/qaic/Kconfig
index 116e42d152ca885b8c59e33c7a87519a0abc6bb3..1e5f1f4fa93c12d8ca8fb37633f2f0bee9997499 100644
--- a/drivers/accel/qaic/Kconfig
+++ b/drivers/accel/qaic/Kconfig
@@ -8,6 +8,7 @@ config DRM_ACCEL_QAIC
 	depends on DRM_ACCEL
 	depends on PCI && HAS_IOMEM
 	depends on MHI_BUS
+	select MHI_SAHARA
 	select CRC32
 	select WANT_DEV_COREDUMP
 	help
diff --git a/drivers/accel/qaic/Makefile b/drivers/accel/qaic/Makefile
index 71f727b74da3bb4478324689f02a7cea24a05c2d..e7b8458800072aa627f7f36c3257883aa56f4ce4 100644
--- a/drivers/accel/qaic/Makefile
+++ b/drivers/accel/qaic/Makefile
@@ -13,7 +13,6 @@ qaic-y := \
 	qaic_ras.o \
 	qaic_ssr.o \
 	qaic_sysfs.o \
-	qaic_timesync.o \
-	sahara.o
+	qaic_timesync.o
 
 qaic-$(CONFIG_DEBUG_FS) += qaic_debugfs.o
diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index 63fb8c7b4abcbe4f1b76c32106f4e8b9ea5e2c8e..76cc8086825e7949ed756d51fcb56a08f392d228 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -15,6 +15,7 @@
 #include <linux/msi.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/sahara.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/wait.h>
@@ -32,7 +33,6 @@
 #include "qaic_ras.h"
 #include "qaic_ssr.h"
 #include "qaic_timesync.h"
-#include "sahara.h"
 
 MODULE_IMPORT_NS("DMA_BUF");
 
@@ -782,18 +782,12 @@ static int __init qaic_init(void)
 	ret = pci_register_driver(&qaic_pci_driver);
 	if (ret) {
 		pr_debug("qaic: pci_register_driver failed %d\n", ret);
-		return ret;
+		goto free_pci;
 	}
 
 	ret = mhi_driver_register(&qaic_mhi_driver);
 	if (ret) {
 		pr_debug("qaic: mhi_driver_register failed %d\n", ret);
-		goto free_pci;
-	}
-
-	ret = sahara_register();
-	if (ret) {
-		pr_debug("qaic: sahara_register failed %d\n", ret);
 		goto free_mhi;
 	}
 
@@ -847,7 +841,6 @@ static void __exit qaic_exit(void)
 	qaic_ras_unregister();
 	qaic_bootlog_unregister();
 	qaic_timesync_deinit();
-	sahara_unregister();
 	mhi_driver_unregister(&qaic_mhi_driver);
 	pci_unregister_driver(&qaic_pci_driver);
 }
diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
index b39a11e6c624ba00349cca22d74bd876020590ab..4acedb886adccc6f76f69c241d53106da59b491f 100644
--- a/drivers/bus/mhi/Kconfig
+++ b/drivers/bus/mhi/Kconfig
@@ -7,3 +7,4 @@
 
 source "drivers/bus/mhi/host/Kconfig"
 source "drivers/bus/mhi/ep/Kconfig"
+source "drivers/bus/mhi/sahara/Kconfig"
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index 354204b0ef3ae4030469a24a659f32429d592aef..e4af535e1bb1bc9481fae60d7eb347700d2e874c 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -3,3 +3,6 @@ obj-$(CONFIG_MHI_BUS) += host/
 
 # Endpoint MHI stack
 obj-$(CONFIG_MHI_BUS_EP) += ep/
+
+# Sahara MHI protocol
+obj-$(CONFIG_MHI_SAHARA) += sahara/
diff --git a/drivers/bus/mhi/sahara/Kconfig b/drivers/bus/mhi/sahara/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..3f1caf6acd979a4af68aaf0e250aa54762e8cda5
--- /dev/null
+++ b/drivers/bus/mhi/sahara/Kconfig
@@ -0,0 +1,18 @@
+config MHI_SAHARA
+	tristate
+	depends on MHI_BUS
+	select FW_LOADER_COMPRESS
+	select FW_LOADER_COMPRESS_XZ
+	select FW_LOADER_COMPRESS_ZSTD
+	help
+	  Enable support for the Sahara protocol transported over the MHI bus.
+
+	  The Sahara protocol is used to transfer firmware images, retrieve
+	  memory dumps and exchange command mode DDR calibration data between
+	  host and device. This driver is not tied to a specific SoC and may be
+	  used by multiple MHI based devices.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called mhi_sahara.
diff --git a/drivers/bus/mhi/sahara/Makefile b/drivers/bus/mhi/sahara/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..fc02a25935011cbd7138ea8f24b88cf5b032a4ce
--- /dev/null
+++ b/drivers/bus/mhi/sahara/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_MHI_SAHARA) += mhi_sahara.o
+mhi_sahara-y := sahara.o
diff --git a/drivers/accel/qaic/sahara.c b/drivers/bus/mhi/sahara/sahara.c
similarity index 99%
rename from drivers/accel/qaic/sahara.c
rename to drivers/bus/mhi/sahara/sahara.c
index fd3c3b2d1fd3bb698809e6ca669128e2dce06613..8ff7b6425ac5423ef8f32117151dca10397686a8 100644
--- a/drivers/accel/qaic/sahara.c
+++ b/drivers/bus/mhi/sahara/sahara.c
@@ -1,6 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-/* Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved. */
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
 
 #include <linux/devcoredump.h>
 #include <linux/firmware.h>
@@ -9,12 +11,11 @@
 #include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/overflow.h>
+#include <linux/sahara.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 
-#include "sahara.h"
-
 #define SAHARA_HELLO_CMD		0x1  /* Min protocol version 1.0 */
 #define SAHARA_HELLO_RESP_CMD		0x2  /* Min protocol version 1.0 */
 #define SAHARA_READ_DATA_CMD		0x3  /* Min protocol version 1.0 */
@@ -928,8 +929,13 @@ int sahara_register(void)
 {
 	return mhi_driver_register(&sahara_mhi_driver);
 }
+module_init(sahara_register);
 
 void sahara_unregister(void)
 {
 	mhi_driver_unregister(&sahara_mhi_driver);
 }
+module_exit(sahara_unregister);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm Sahara MHI protocol driver");
diff --git a/drivers/accel/qaic/sahara.h b/include/linux/sahara.h
similarity index 100%
rename from drivers/accel/qaic/sahara.h
rename to include/linux/sahara.h

-- 
2.34.1

