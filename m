Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37308CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B9D610E04C;
	Tue, 13 Oct 2026 08:46:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED2C10F605
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:45:56 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8AFVx4071943
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kJz2HhWMtc9b/2odgKGLEGE+s//TZSVvWyfkwnNWaxE=; b=cHDvHLWlxNsgwfVE
 YCcRfm0b6MyalTK8Q5eKJN/kG3ZsdWFc5oOviFwffKSYPWx2woZqG3MdoHViZknn
 baaXj6WOdV8JA6XNgR03YpcijWtSfcxAL3Hmnnf2h/6O4fCeixT19Aggz4N5EXwv
 qpq32xTgpQYukn9tNij+NsrR9IDLQsUoQoYZw8iKZ1Pgvtf/xW8mnkvhxNHSd+A5
 axae19A3A5ndGkAU5P3iWRSm4K+eLQp0Ys5zE27eRO/mufI0w8MfLB14bI/2xA9B
 AI3qRfYJoPXqKxKS8iGffC6p6Vm7hkhOkOodMkYuxJnue6hHdHG6BNo8EhUcAJMg
 nQWP0A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h92jjukrg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:45:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-892ccb01fbfso2523315b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791881154; x=1792485954;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kJz2HhWMtc9b/2odgKGLEGE+s//TZSVvWyfkwnNWaxE=;
 b=FTcT/tEdYZdALkgkU/h4E1hBoZ5ur443IwI52Xe51E9vbTxOGLLf3ot4OHeGEQbK45
 7BoCHUykpCy1gmacfG/JygwH03+ycr9W46ZhhIqR6XWd0QjXDRGTNzSMK/LOqclV7Xif
 qsBs2h5by3UZLdoPUotQjCgElr3WcpiIJFsUrM+ebVKlFWzqkoWYIrM4yRVSb7q5vUTZ
 MKSb88iNQFRLjl7Ak0GfVTY2UhS4YO/qpRlanP926a8FVWJmMSBaWA83syyvWWHtTqBH
 6uQDT1BNw5txENFu523HXtIsiQ4aGlZH7ZcnV6ZSb92LCPCHzPKlIb+Ty1gNnpYgCzns
 ryUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881154; x=1792485954;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kJz2HhWMtc9b/2odgKGLEGE+s//TZSVvWyfkwnNWaxE=;
 b=GCOtsBAZFFDpQ2bV3cYsQDZAmBn/LN7k7dmOOQhIWjkXnS1DoEKIVWqfrH2bJeCxk0
 sGHsp9PTi7zvhraMAmz/1GXKlu8zJtb/ovWT0ERSdgFRXa9MyBTOTZywCEq5OjxfjKhl
 uDdNQiUW5bkGbUfyZuVYUJE2JVWaDaFEDBAWkqcfivQ50UdMgN0us5/c5Uqk4JfM9Ew2
 bXFQxBNPwSiqjNLwmw6/TNM76ieMkeMP7l/BqO8xBTumYi0b1Y/Q+Y1ry22abgNxINAP
 ogVaD8R+bcCeih9gLmQY4SXX7cnBIULrvf7Q6XhV57uxajhNU67iueL6juJE2CY5uEKE
 rkLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBlApI+fEC/00kkNfkipR+3YbEc8H1BzXP2K+Qy1JvemYjNc7b7fWXdFj1s24lUf/XFLhRZepJ3Lw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKUr/+xpo6OcpBzwLdIYpOC1tQtDHJa3WjqyBbh8ofGjuu3xXGr
 lRWvWoUmEXXryqW8GM4Aai68g5om/lafGJJyVeqpK1R44ucaL2gmEgvCChHSLtvkBCph/WvMA/S
 m8hAHV8hWo1VJXLKZHfod2HWjcG5k1z1VYmOCtxoc+E/7yhNYWkmoJgyNxfEf3AdcqdyNtpM=
X-Gm-Gg: AYBFou19ViX/oZ4y8ccoHxEkdymWbblbXxiPZV5QKmgoF8tLsUm0Hoc8qbDioaWFo+j
 s370i46lhmJ4l0o0GcYLsI7Ti2Jne/uAFPh9Jv7Ej4Fp3Q8D9/JHXR+38holSoS1ArMuGUZauzS
 XCv3q7qOSwpI/e7XkUrfr9x4nRevxr8VcY48hfsUNM1xLxau/yOVIOTo8p2qJDr5ttTP/Y4Ft2V
 rYACPmmzvQy+gkTunYiLeX+WKxPLMLtb4gS2NtdaAhXzTwPrz7nVBXLecvRmqlbepKh/5dHOiLr
 SuKeQk4tBi0diCfj0KUlqBQwsRxi/4+4XsllhFudUkehoFCwa1RMjDgzeVHla13LQLQ8rbiLvA5
 TiknvJReSvCjWfJdFNYVhtvuEwXY5
X-Received: by 2002:a05:6a21:3290:b0:3e1:a27e:3037 with SMTP id
 adf61e73a8af0-3e1a27e6848mr4810742637.19.1791881153874; 
 Tue, 13 Oct 2026 01:45:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:3290:b0:3e1:a27e:3037 with SMTP id
 adf61e73a8af0-3e1a27e6848mr4810707637.19.1791881153105; 
 Tue, 13 Oct 2026 01:45:53 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da0596f9sm5384721a12.31.2026.10.13.01.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:45:52 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:15:33 +0530
Subject: [PATCH v9 2/7] bus: mhi: Move Sahara protocol driver under MHI
 host client drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-sahara_protocol_new_v2-v9-2-dc9f24357c4a@oss.qualcomm.com>
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791881139; l=8139;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=c81Ncsft2VVG5nJP0v+rEpGREl+pBGszmXyGri/TePY=;
 b=FKHiDhrXcuWPSscw+hfJohCQPoutAq//8uuzEHfpCaq5AYIdUEKQhb7mY6FmNdqUWD/b6FOLL
 oyL+WWDHgsxAq7ar99BJSn1LAjoAOc0GIf2azQdkiMozJ0wrpTRy97n
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: rFY2mgds-xNQng8gMpkUTxgw4VRtQZPp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX1CvOGxHzYgR8
 +MsNpk42LuUmlZxXmf3aMtY43UGRr6gUSnGWKzBzPVbk7lFnv1ZHOmMKg/Iz6/TaH190/5ZLZqc
 tMiZ03yD5BHvuS0+0oZjsi9WyYWSJ94=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX+5LpQ7rRI/bz
 DvSPwDU94Qcu12KcBlI9tLlvFm0RVzxVkbLTNpfmYQuvFjo0Nx4PaPAf9Pbsa/MuHTupgEXdXFp
 vC1bu7RcY3TFa3WU+0MboSLsWdAuZlVdjayjPI8uKw1/6Eow3+oIzzMyvG4v54EgtRFKmW70RYI
 Dru2rlFWYuITpqoY019YpMTX6ds6cZbW7LmD0rYTk3YYZ+dIXBLO8Ajc9vuqIgxxhT64vxF5K4f
 x/xfIobKt4mm6jLQWrDmGGNyp+BuGoMG/A5AiTkHyTSgooxx+i4Uf1KUFE7gVPNrp96XvuJAaGR
 vY6cSKWWmwK5N5uapUqSwKuoRDT8DugHImmWmWVfNyb+a1Dsyy/PyA9EoSNm231UyLw3r6SW+9T
 X5DGJauLNOPtSKAyKKaJqeX7WRsLv/zU5tG5EdEy8lpkn5kpdcKxNa00pk+f0zC6zxa9IJB4z+5
 n7Uq1BlQepSB7QdY4yA==
X-Authority-Analysis: v=2.4 cv=GfKCDgXL c=1 sm=1 tr=0 ts=6acdefc3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=EyST5JTptKXFtIIvUhkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: rFY2mgds-xNQng8gMpkUTxgw4VRtQZPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130034
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

The Sahara protocol driver currently lives under the QAIC accelerator
subsystem even though the protocol is transported over MHI and is used by
multiple Qualcomm flashless devices. This makes Sahara appear QAIC specific
and complicates reuse by other MHI based devices.

Move the Sahara protocol driver under drivers/bus/mhi as a host client
driver and build it as an independent MHI protocol driver. This keeps the
QAIC driver focused on the accelerator device while allowing other MHI
users to enable Sahara without depending on QAIC.

As part of the move, add a dedicated Kconfig/Makefile hierarchy under the
MHI host client drivers and convert the driver to use module_mhi_driver()
instead of register/unregister hooks.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 drivers/accel/qaic/Kconfig                           |  1 +
 drivers/accel/qaic/Makefile                          |  3 +--
 drivers/accel/qaic/qaic_drv.c                        |  9 ---------
 drivers/accel/qaic/sahara.h                          | 10 ----------
 drivers/bus/mhi/host/Makefile                        |  2 +-
 drivers/bus/mhi/host/clients/Kconfig                 |  6 ++++++
 drivers/bus/mhi/host/clients/Makefile                |  1 +
 drivers/bus/mhi/host/clients/sahara/Kconfig          | 15 +++++++++++++++
 drivers/bus/mhi/host/clients/sahara/Makefile         |  2 ++
 .../qaic => bus/mhi/host/clients/sahara}/sahara.c    | 20 +++++++-------------
 10 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/accel/qaic/Kconfig b/drivers/accel/qaic/Kconfig
index 116e42d152ca885b8c59e33c7a87519a0abc6bb3..af90fdfcf77eeb6dd5ad309b33d793d4fdc91b1e 100644
--- a/drivers/accel/qaic/Kconfig
+++ b/drivers/accel/qaic/Kconfig
@@ -8,6 +8,7 @@ config DRM_ACCEL_QAIC
 	depends on DRM_ACCEL
 	depends on PCI && HAS_IOMEM
 	depends on MHI_BUS
+	depends on MHI_SAHARA
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
index 0acf6cdd44f81430ec52c7120b8b50c60721a615..64e87dfaa560376ecdf1e6f8bf7abf6153160926 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -32,7 +32,6 @@
 #include "qaic_ras.h"
 #include "qaic_ssr.h"
 #include "qaic_timesync.h"
-#include "sahara.h"
 
 MODULE_IMPORT_NS("DMA_BUF");
 
@@ -789,12 +788,6 @@ static int __init qaic_init(void)
 		goto free_pci;
 	}
 
-	ret = sahara_register();
-	if (ret) {
-		pr_debug("qaic: sahara_register failed %d\n", ret);
-		goto free_mhi;
-	}
-
 	ret = qaic_timesync_init();
 	if (ret)
 		pr_debug("qaic: qaic_timesync_init failed %d\n", ret);
@@ -816,7 +809,6 @@ static int __init qaic_init(void)
 
 free_bootlog:
 	qaic_bootlog_unregister();
-free_mhi:
 	mhi_driver_unregister(&qaic_mhi_driver);
 free_pci:
 	pci_unregister_driver(&qaic_pci_driver);
@@ -845,7 +837,6 @@ static void __exit qaic_exit(void)
 	qaic_ras_unregister();
 	qaic_bootlog_unregister();
 	qaic_timesync_deinit();
-	sahara_unregister();
 	mhi_driver_unregister(&qaic_mhi_driver);
 	pci_unregister_driver(&qaic_pci_driver);
 }
diff --git a/drivers/accel/qaic/sahara.h b/drivers/accel/qaic/sahara.h
deleted file mode 100644
index 08037281c80e28f6c85b924c45ce2c2f9dc60c39..0000000000000000000000000000000000000000
--- a/drivers/accel/qaic/sahara.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
-
-#ifndef __SAHARA_H__
-#define __SAHARA_H__
-
-int sahara_register(void);
-void sahara_unregister(void);
-#endif /* __SAHARA_H__ */
diff --git a/drivers/bus/mhi/host/Makefile b/drivers/bus/mhi/host/Makefile
index 2a16008aeb38127494782bbff4e1656428d2b776..2e8949f1a2fe6f3f3b2e1dc541f97d2c393d6a0f 100644
--- a/drivers/bus/mhi/host/Makefile
+++ b/drivers/bus/mhi/host/Makefile
@@ -4,4 +4,4 @@ mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
 
 obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
 mhi_pci_generic-y += pci_generic.o
-obj-y += clients/
+obj-$(CONFIG_MHI_BUS) += clients/
diff --git a/drivers/bus/mhi/host/clients/Kconfig b/drivers/bus/mhi/host/clients/Kconfig
index 8bb5715e61d0d6e64a51012b4e1594ba46e5bfc1..1932344157a5b1dc25c8d63f6d4ac38f896d08a7 100644
--- a/drivers/bus/mhi/host/clients/Kconfig
+++ b/drivers/bus/mhi/host/clients/Kconfig
@@ -15,3 +15,9 @@ config MHI_BUS_LOOPBACK
 
 	  To compile this driver as a module, choose M here. The module
 	  will be called mhi_loopback.
+
+menu "MHI host client drivers"
+
+source "drivers/bus/mhi/host/clients/sahara/Kconfig"
+
+endmenu
diff --git a/drivers/bus/mhi/host/clients/Makefile b/drivers/bus/mhi/host/clients/Makefile
index 3811b6928f42b38f94b1167941cf3b0fe512d32b..67e70de280369870164b4808f39d9b3340f2589b 100644
--- a/drivers/bus/mhi/host/clients/Makefile
+++ b/drivers/bus/mhi/host/clients/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MHI_BUS_LOOPBACK) += mhi_loopback.o
 mhi_loopback-y += loopback.o
+obj-$(CONFIG_MHI_SAHARA) += sahara/
diff --git a/drivers/bus/mhi/host/clients/sahara/Kconfig b/drivers/bus/mhi/host/clients/sahara/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..f1fc7013a2dee0be645c50f32305659e591de7e7
--- /dev/null
+++ b/drivers/bus/mhi/host/clients/sahara/Kconfig
@@ -0,0 +1,15 @@
+config MHI_SAHARA
+	tristate "Sahara protocol driver"
+	depends on MHI_BUS
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
diff --git a/drivers/bus/mhi/host/clients/sahara/Makefile b/drivers/bus/mhi/host/clients/sahara/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..fc02a25935011cbd7138ea8f24b88cf5b032a4ce
--- /dev/null
+++ b/drivers/bus/mhi/host/clients/sahara/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_MHI_SAHARA) += mhi_sahara.o
+mhi_sahara-y := sahara.o
diff --git a/drivers/accel/qaic/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
similarity index 99%
rename from drivers/accel/qaic/sahara.c
rename to drivers/bus/mhi/host/clients/sahara/sahara.c
index c7c0b3eb4b65fb7776a6c724cb3105046cf6f7eb..75c0cf6010e1506fe661cfd110112bbb37465880 100644
--- a/drivers/accel/qaic/sahara.c
+++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
-
-/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ */
 
 #include <linux/devcoredump.h>
 #include <linux/firmware.h>
@@ -12,8 +14,6 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 
-#include "sahara.h"
-
 #define SAHARA_HELLO_CMD		0x1  /* Min protocol version 1.0 */
 #define SAHARA_HELLO_RESP_CMD		0x2  /* Min protocol version 1.0 */
 #define SAHARA_READ_DATA_CMD		0x3  /* Min protocol version 1.0 */
@@ -922,13 +922,7 @@ static struct mhi_driver sahara_mhi_driver = {
 		.name = "sahara",
 	},
 };
+module_mhi_driver(sahara_mhi_driver);
 
-int sahara_register(void)
-{
-	return mhi_driver_register(&sahara_mhi_driver);
-}
-
-void sahara_unregister(void)
-{
-	mhi_driver_unregister(&sahara_mhi_driver);
-}
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm Sahara MHI protocol driver");

-- 
2.34.1

