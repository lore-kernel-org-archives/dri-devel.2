Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E1CC5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55BDB10E61C;
	Mon, 17 Aug 2026 04:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WLmRz6qg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HwRivKYA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5166410E61C
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLDqqD4120292
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xtNZhPRfPIsrhmbaHits7E3dniqDAdMJ7RDyy78PBz0=; b=WLmRz6qgcnHoWMuE
 3IJbBWbdWdt7mRyR2KWpyLzzxaNoykZ0kqBxlPdX7aQkZJ7iEDnSABcUtyA+kdVP
 zo81BaA28l78zxImWb+alfvgcK6G4rY16kslLA67dsEZsDt/J8GXzcP7hIoMRyw5
 B94DLtmdvVD56w+mqjrE6shMd/9/l8AXz4BKSQ/Cpcn5An2bKprt7SjwM9/2Ppph
 yy+TVHU9hPiuaw4bmCr2ylIE2x5+1CtgZIXQICWrXkc/3NDa8M4PJWisSw3cWAv6
 VSDnK6+mRMepNMaOsK4EbUlZaC/sEGwp6QO2TSeyLgvmbcfJ4b5kGlCSznpOv+fF
 MsG+Mg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfd842-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so2514706a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942145; x=1787546945;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xtNZhPRfPIsrhmbaHits7E3dniqDAdMJ7RDyy78PBz0=;
 b=HwRivKYAUq7CHW5rO+YASyt3SGFD1dQ/nkenNrr9RC+j+SSjVaENnZBgEndzUOuYA2
 Tenuk8AWwG/Y4EQlXeCygcDMkI2+eehmb/KyLdX8pjwraVt7IJIPGsw34UVZ/mlB3gP1
 r5UVWbp1whjTD9sqsSwbp2AWfnJf//0ecaOlunTGr2eQlh0bvpmPpDhnQqjf/BuWF8bg
 fo7JmQYmqjdMK3xQWQuUEQRz/u/yec1wQIUvG/IE8AtfT/ZbsxLJTzEMFAQcACuih3SW
 H37vij+L3A0EvnmxVcpFR4BIOUvesNEilE6tkbCReFP1ERmX+YXrYqOgJBZFC6MPrfld
 5aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942145; x=1787546945;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xtNZhPRfPIsrhmbaHits7E3dniqDAdMJ7RDyy78PBz0=;
 b=rZQGiruK6Ww/Y77MENXGs2n5uxQNEGjmNS3/bRT16sxK+7ACFkjlJbHo3iLnJWGiZr
 Zjsw2XpiHY1lwWaKZM2ELkQLgoLpIW0c86KFgTcq1snV28fBQGLRaR3teB1Re7hrN2Nf
 XcnoxOk1MBjZ637itrbqhbI3ewUSc71dcrSPQt6gKcqIf5l4pGSfy4rxrSQCA/yAyEWl
 /jJ4EtQa/+PlbBs8eYXSZMkem9hVsNakA3yrIyrCqpjYuMB0y+38hLh1nLU0rExpuFRD
 5z3idoPjWpGrC4lhzsMjYIQK9K0m5AJHQWtLzn/3oF8/wdvPwe5FtvrkFDSF5WopiuJz
 LLOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnCMZ0SUtJ+rrtx1tD4eFZLwtHe6idL30h5yfWLZQPIF9kPUAyzF0kzDfO9Ivbt8rzeb6wOKvjP7Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1lAdxbImbhemxy7AgtEQK0E6COXoE+ox5g7X7Ix9mZy9MyJs1
 81RQptWzixJDM/BseAq1O515DQ5YOjioDmvDPlQQMv5NIXhU5rPI169JNHywqYS/Xl3xHq5PoqB
 VmOtJR02d98Rg3Rqcy3Z0FV3beyhY67MfWqT1r25XESHJxbHTHpe9ilSpKLS6zvqrVjnOEjc=
X-Gm-Gg: AR+sD12scTOgweigvxueTfeU4FHCjVQVTH/fpbh/33wmHnXPK8mxZ++rd79cszrB+EI
 0r+beK7nlSDUxjaw/96HBuBDbZVkIizk0lqnU14kqPMtqtJpKJ4SGfSWtJ6hIcSYKFmaEOas6ad
 Gy4B4ju6WbQOtUEy/FqUHzb8wPWdL/6n/dM9Sx7K9GWMlElwsCvOrFRPYS2sVAXPVRQkDw+nVGL
 xPujM0Mc97ha+6qz+BV+TPKDq0kMU5rzrMq78YIzaAu3cJzjIjP2FBLG7mcMQbbGopJjEfvu6Zb
 XWtAaRyj6yw3CHXVZUXPiDYp2oNT0TAhgIYCnGHZ5ou3VJGA/9V1tFpME/mXowLZ21qmFEgVE2P
 O/aHtfVDWlVeTcvKCnJ05Wx71rsdauZq1
X-Received: by 2002:a05:6a00:408b:b0:82f:2b0:2809 with SMTP id
 d2e1a72fcca58-84fde3651cemr22884358b3a.1.1786942144888; 
 Sun, 16 Aug 2026 21:49:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:408b:b0:82f:2b0:2809 with SMTP id
 d2e1a72fcca58-84fde3651cemr22884318b3a.1.1786942144318; 
 Sun, 16 Aug 2026 21:49:04 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:49:03 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:44 +0530
Subject: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=25515;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=3a40T88Ttftfhd8rY0565omKqH0hQXysBy4bcauR63Q=;
 b=4mmvzlFYYtEbvgmF05BD7BOcE3myoi7FufemkBr4ZowgZdfm5GxtZYdABZMFFU6AFT8qfGZ/r
 xmO4lYLN4HZBWNsbOhJ5/NDlfg/S7lz///ZaKl3X9RwFIzKlM3tk1Tg
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX220xALAcFU96
 yimhAv8HdJLAMOXOoG0bkWvza07SpZUHPgbMxP/TY7Z6WdCcrjd5HPi+GN/0JCyBs7xGpIVJ0ea
 4gkDGeDeMa8tA/EEPPvZpF1AM4aqyqE=
X-Proofpoint-ORIG-GUID: gsIYGy9EHUGIs9ne4qpw9lXvVveWa4L4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX3o72D4LUMPsk
 sczZa3lZIVY47FFrFw7ueqDj/A1LzjuLjeV0ATuB5h+4RmvvUFLQljUEitWjhJhc40YXlFoh0d6
 JHhaHuTHKJ4Lzcjc9wMCmw1+JG/CeFMrUFzPaQKrpjZucXGuTIqGrD9GK7XR6oG4UH9iVuX0pOF
 EFtDI0MpZuNYB06bx1giNdOQrACAIP0bk94y179U9aGWBHsE0VeiE8TuG3eckrn9AI2MGIgF3lY
 nOsEF8rrnF0DVIMOgHPdErn41L+H0uS2TE13/3XD7sbUISunEA1zCGAG2kTjeD3C46o4Y//v4jv
 9K0r0PA97jUDig+C3JuwLl+JgUzE52/GZncocriNaX7vWj3nPnOPoY6AaDA/OqbbFLREF407bFc
 7P7dKapWf0sAw14ckp+UWr/OGSyDXRbKjOy7emiIFlFbMMP99/vNFUTB4+yjVOkghoGN+jsNK2/
 SXQzBand5u9zG3Bmpzg==
X-Proofpoint-GUID: gsIYGy9EHUGIs9ne4qpw9lXvVveWa4L4
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a8292c2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=3AIGk1epJBJNjeN8eX0A:9 a=UoYv2gdXUR36Upsk:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
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

Introduce DMA-coherent buffer management for the QDA driver, wiring
together the GEM subsystem, the IOMMU memory manager, and a DMA
allocation backend.

qda_gem.c / qda_gem.h
  Implements the GEM object lifecycle for QDA buffers. Each buffer is
  represented by a qda_gem_obj which embeds a drm_gem_object and
  carries the kernel virtual address, DMA address, and a pointer to
  the IOMMU device that performed the allocation. The .free callback
  delegates to the memory manager, and the .mmap callback uses
  dma_mmap_coherent() via the DMA backend.

qda_memory_dma.c / qda_memory_dma.h
  DMA coherent allocation backend. qda_dma_alloc() calls
  dma_alloc_coherent() on the CB device and encodes the stream ID
  (SID) in the upper 32 bits of the returned DMA address, following
  the Qualcomm FastRPC convention for IOMMU address space tagging.
  qda_dma_free() strips the SID prefix before calling
  dma_free_coherent().

qda_memory_manager.c
  Adds process-to-device assignment: each DRM file (process) is
  assigned one IOMMU context bank device for the lifetime of the
  session. qda_memory_manager_assign_device() first checks whether
  the process already has a device (reusing it with a refcount
  increment), then falls back to claiming an unassigned device.
  qda_memory_manager_alloc() and qda_memory_manager_free() delegate
  to the DMA backend after resolving the correct CB device for the
  calling process.

qda_drv.c / qda_drv.h
  qda_file_priv gains an assigned_iommu_dev pointer and a pid field.
  The .postclose callback decrements the IOMMU device refcount and
  clears the process assignment when the last reference is dropped.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Changes in v2:
- Adapt to the dynamically-sized device array introduced in patch 07
  (kcalloc'd from DT node count, replaces fixed QDA_IOMMU_DEVICES_MAX)
- Protect register/unregister with the process_assignment_lock mutex so
  the device-assignment and device-registration paths are serialised
- No functional changes requested by reviewers on this patch
---
 drivers/accel/qda/Makefile             |   2 +
 drivers/accel/qda/qda_drv.c            |   4 +
 drivers/accel/qda/qda_drv.h            |   4 +
 drivers/accel/qda/qda_gem.c            | 134 ++++++++++++++++++
 drivers/accel/qda/qda_gem.h            |  52 +++++++
 drivers/accel/qda/qda_memory_dma.c     |  82 +++++++++++
 drivers/accel/qda/qda_memory_dma.h     |  17 +++
 drivers/accel/qda/qda_memory_manager.c | 239 ++++++++++++++++++++++++++++++++-
 drivers/accel/qda/qda_memory_manager.h |  30 +++++
 9 files changed, 559 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index b658dad35fee..a46ddceecfc5 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -8,7 +8,9 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
 qda-y := \
 	qda_cb.o \
 	qda_drv.o \
+	qda_gem.o \
 	qda_ioctl.o \
+	qda_memory_dma.o \
 	qda_memory_manager.o \
 	qda_rpmsg.o
 
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index e1fd8bfa12d7..2b14dab95507 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -21,6 +21,7 @@ static int qda_open(struct drm_device *dev, struct drm_file *file)
 	if (!qda_file_priv)
 		return -ENOMEM;
 
+	qda_file_priv->pid = current->pid;
 	qda_file_priv->qda_dev = qda_dev_from_drm(dev);
 	file->driver_priv = qda_file_priv;
 
@@ -31,6 +32,9 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
 {
 	struct qda_file_priv *qda_file_priv = file->driver_priv;
 
+	if (qda_file_priv->assigned_iommu_dev)
+		qda_memory_manager_release_device(qda_file_priv->assigned_iommu_dev);
+
 	kfree(qda_file_priv);
 	file->driver_priv = NULL;
 }
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index 690a833d732b..2fe58f3efec0 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -24,6 +24,10 @@
 struct qda_file_priv {
 	/** @qda_dev: Back-pointer to device structure */
 	struct qda_dev *qda_dev;
+	/** @assigned_iommu_dev: IOMMU device assigned to this process */
+	struct qda_iommu_device *assigned_iommu_dev;
+	/** @pid: Process ID for tracking */
+	pid_t pid;
 };
 
 /**
diff --git a/drivers/accel/qda/qda_gem.c b/drivers/accel/qda/qda_gem.c
new file mode 100644
index 000000000000..66e78013a726
--- /dev/null
+++ b/drivers/accel/qda/qda_gem.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <drm/drm_gem.h>
+#include <drm/drm_prime.h>
+#include <drm/drm_print.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include "qda_drv.h"
+#include "qda_gem.h"
+#include "qda_memory_manager.h"
+#include "qda_memory_dma.h"
+
+/**
+ * qda_gem_free_object() - Free a GEM object and its associated resources
+ * @gem_obj: DRM GEM object to free
+ */
+void qda_gem_free_object(struct drm_gem_object *gem_obj)
+{
+	struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(gem_obj);
+	struct qda_dev *qdev = qda_dev_from_drm(gem_obj->dev);
+
+	if (qda_gem_obj->virt && qdev->iommu_mgr)
+		qda_memory_manager_free(qdev->iommu_mgr, qda_gem_obj);
+
+	drm_gem_object_release(gem_obj);
+	kfree(qda_gem_obj);
+}
+
+/**
+ * qda_gem_mmap_obj() - Map a GEM object into userspace
+ * @drm_obj: DRM GEM object to map
+ * @vma: Virtual memory area to map into
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_gem_mmap_obj(struct drm_gem_object *drm_obj, struct vm_area_struct *vma)
+{
+	struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(drm_obj);
+	int ret;
+
+	/* The fake offset is only used to find the object, not to index it */
+	vma->vm_pgoff = 0;
+
+	ret = qda_dma_mmap(qda_gem_obj, vma);
+	if (ret)
+		return ret;
+
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
+
+	return 0;
+}
+
+static const struct drm_gem_object_funcs qda_gem_object_funcs = {
+	.free = qda_gem_free_object,
+	.mmap = qda_gem_mmap_obj,
+};
+
+/**
+ * qda_gem_alloc_object() - Allocate a new QDA GEM object
+ * @drm_dev: DRM device
+ * @aligned_size: Size of the object in bytes (must be page-aligned)
+ *
+ * Return: Pointer to the new GEM object, or ERR_PTR on failure
+ */
+struct qda_gem_obj *qda_gem_alloc_object(struct drm_device *drm_dev, size_t aligned_size)
+{
+	struct qda_gem_obj *qda_gem_obj;
+	int ret;
+
+	qda_gem_obj = kzalloc_obj(*qda_gem_obj);
+	if (!qda_gem_obj)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drm_gem_object_init(drm_dev, &qda_gem_obj->base, aligned_size);
+	if (ret) {
+		kfree(qda_gem_obj);
+		return ERR_PTR(ret);
+	}
+
+	qda_gem_obj->base.funcs = &qda_gem_object_funcs;
+	qda_gem_obj->size = aligned_size;
+
+	return qda_gem_obj;
+}
+
+void qda_gem_cleanup_object(struct qda_gem_obj *qda_gem_obj)
+{
+	drm_gem_object_release(&qda_gem_obj->base);
+	kfree(qda_gem_obj);
+}
+
+int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, u32 *handle)
+{
+	int ret;
+
+	ret = drm_gem_handle_create(file_priv, gem_obj, handle);
+	drm_gem_object_put(gem_obj);
+
+	return ret;
+}
+
+/**
+ * qda_gem_create_object() - Allocate and initialize a GEM object with DMA backing
+ * @drm_dev: DRM device
+ * @iommu_mgr: Memory manager to use for DMA allocation
+ * @size: Requested size in bytes
+ * @file_priv: DRM file private data for process association
+ *
+ * Return: Pointer to the base DRM GEM object on success, ERR_PTR on failure
+ */
+struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
+					     struct qda_memory_manager *iommu_mgr, size_t size,
+					     struct drm_file *file_priv)
+{
+	struct qda_gem_obj *qda_gem_obj;
+	size_t aligned_size;
+	int ret;
+
+	aligned_size = PAGE_ALIGN(size);
+	if (!aligned_size)
+		return ERR_PTR(-EINVAL);
+
+	qda_gem_obj = qda_gem_alloc_object(drm_dev, aligned_size);
+	if (IS_ERR(qda_gem_obj))
+		return ERR_CAST(qda_gem_obj);
+
+	ret = qda_memory_manager_alloc(iommu_mgr, qda_gem_obj, file_priv);
+	if (ret) {
+		qda_gem_cleanup_object(qda_gem_obj);
+		return ERR_PTR(ret);
+	}
+
+	return &qda_gem_obj->base;
+}
diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
new file mode 100644
index 000000000000..afd7c9b49549
--- /dev/null
+++ b/drivers/accel/qda/qda_gem.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef __QDA_GEM_H__
+#define __QDA_GEM_H__
+
+#include <linux/dma-mapping.h>
+#include <drm/drm_device.h>
+#include <drm/drm_gem.h>
+#include "qda_memory_manager.h"
+
+/**
+ * struct qda_gem_obj - QDA GEM buffer object
+ *
+ * Represents a GEM buffer object that can be allocated by the driver
+ * or imported from another driver via DMA-BUF.
+ */
+struct qda_gem_obj {
+	/** @base: DRM GEM object base — must be first member */
+	struct drm_gem_object base;
+	/** @iommu_dev: IOMMU context bank device that performed the allocation */
+	struct qda_iommu_device *iommu_dev;
+	/** @virt: Kernel virtual address of the allocated DMA memory */
+	void *virt;
+	/** @dma_addr: DMA address (with SID encoded in upper 32 bits) */
+	dma_addr_t dma_addr;
+	/** @size: Size of the buffer in bytes */
+	size_t size;
+};
+
+/**
+ * to_qda_gem_obj - Cast a drm_gem_object pointer to qda_gem_obj
+ * @gem_obj: Pointer to the embedded drm_gem_object
+ */
+#define to_qda_gem_obj(gem_obj) container_of(gem_obj, struct qda_gem_obj, base)
+
+/* GEM object lifecycle */
+struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
+					     struct qda_memory_manager *iommu_mgr,
+					     size_t size, struct drm_file *file_priv);
+void qda_gem_free_object(struct drm_gem_object *gem_obj);
+int qda_gem_mmap_obj(struct drm_gem_object *gem_obj, struct vm_area_struct *vma);
+
+/* Internal helpers (also used by PRIME import) */
+struct qda_gem_obj *qda_gem_alloc_object(struct drm_device *drm_dev, size_t aligned_size);
+void qda_gem_cleanup_object(struct qda_gem_obj *qda_gem_obj);
+
+/* Utility functions */
+int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, u32 *handle);
+
+#endif /* __QDA_GEM_H__ */
diff --git a/drivers/accel/qda/qda_memory_dma.c b/drivers/accel/qda/qda_memory_dma.c
new file mode 100644
index 000000000000..7072ed8edf0b
--- /dev/null
+++ b/drivers/accel/qda/qda_memory_dma.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include "qda_drv.h"
+#include "qda_gem.h"
+#include "qda_memory_dma.h"
+
+/*
+ * The DSP identifies the IOMMU context bank from the upper bits of the address,
+ * so the stream ID is folded into every address handed to it. The DMA API only
+ * ever sees the plain 32-bit address, which is why the context bank devices are
+ * created with a 32-bit DMA mask.
+ */
+static dma_addr_t get_actual_dma_addr(struct qda_gem_obj *gem_obj)
+{
+	return gem_obj->dma_addr - ((u64)gem_obj->iommu_dev->sid << 32);
+}
+
+static void setup_gem_object(struct qda_gem_obj *gem_obj, void *virt,
+			     dma_addr_t dma_addr, struct qda_iommu_device *iommu_dev)
+{
+	gem_obj->virt = virt;
+	gem_obj->dma_addr = dma_addr;
+	gem_obj->iommu_dev = iommu_dev;
+}
+
+static void cleanup_gem_object_fields(struct qda_gem_obj *gem_obj)
+{
+	gem_obj->virt = NULL;
+	gem_obj->dma_addr = 0;
+	gem_obj->iommu_dev = NULL;
+}
+
+/**
+ * qda_dma_alloc() - Allocate DMA coherent memory for a GEM object
+ * @iommu_dev: Pointer to the QDA IOMMU device structure
+ * @gem_obj: Pointer to GEM object to allocate memory for
+ * @size: Size of memory to allocate in bytes
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
+		  struct qda_gem_obj *gem_obj, size_t size)
+{
+	dma_addr_t dma_addr;
+	void *virt;
+
+	virt = dma_alloc_coherent(iommu_dev->dev, size, &dma_addr, GFP_KERNEL);
+	if (!virt)
+		return -ENOMEM;
+
+	dma_addr += ((u64)iommu_dev->sid << 32);
+	setup_gem_object(gem_obj, virt, dma_addr, iommu_dev);
+
+	return 0;
+}
+
+/**
+ * qda_dma_free() - Free DMA coherent memory for a GEM object
+ * @gem_obj: Pointer to GEM object to free memory for
+ */
+void qda_dma_free(struct qda_gem_obj *gem_obj)
+{
+	dma_free_coherent(gem_obj->iommu_dev->dev, gem_obj->size,
+			  gem_obj->virt, get_actual_dma_addr(gem_obj));
+
+	cleanup_gem_object_fields(gem_obj);
+}
+
+/**
+ * qda_dma_mmap() - Map DMA memory into userspace
+ * @gem_obj: Pointer to GEM object containing DMA memory
+ * @vma: Virtual memory area to map into
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *vma)
+{
+	return dma_mmap_coherent(gem_obj->iommu_dev->dev, vma, gem_obj->virt,
+				 get_actual_dma_addr(gem_obj), gem_obj->size);
+}
diff --git a/drivers/accel/qda/qda_memory_dma.h b/drivers/accel/qda/qda_memory_dma.h
new file mode 100644
index 000000000000..99352a99dc33
--- /dev/null
+++ b/drivers/accel/qda/qda_memory_dma.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_MEMORY_DMA_H__
+#define __QDA_MEMORY_DMA_H__
+
+#include <linux/dma-mapping.h>
+#include "qda_memory_manager.h"
+
+int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
+		  struct qda_gem_obj *gem_obj, size_t size);
+void qda_dma_free(struct qda_gem_obj *gem_obj);
+int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *vma);
+
+#endif /* __QDA_MEMORY_DMA_H__ */
diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
index b1a80ee77c35..d47c7419e11d 100644
--- a/drivers/accel/qda/qda_memory_manager.c
+++ b/drivers/accel/qda/qda_memory_manager.c
@@ -1,14 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
 
+#include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <drm/drm_file.h>
+#include <drm/drm_print.h>
 #include "qda_drv.h"
+#include "qda_gem.h"
 #include "qda_memory_manager.h"
+#include "qda_memory_dma.h"
+
+static void iommu_device_free(struct kref *ref)
+{
+	kfree(container_of(ref, struct qda_iommu_device, ref));
+}
 
 static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
 {
 	int i;
 
+	mutex_lock(&mem_mgr->process_assignment_lock);
 	for (i = 0; i < mem_mgr->num_devices; i++) {
 		struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
 
@@ -16,9 +28,215 @@ static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
 			continue;
 
 		mem_mgr->devices[i] = NULL;
-		kfree(iommu_dev);
+		kref_put(&iommu_dev->ref, iommu_device_free);
 	}
 	mem_mgr->num_devices = 0;
+	mutex_unlock(&mem_mgr->process_assignment_lock);
+}
+
+static void init_iommu_device_fields(struct qda_iommu_device *iommu_dev)
+{
+	spin_lock_init(&iommu_dev->lock);
+	refcount_set(&iommu_dev->users, 0);
+	kref_init(&iommu_dev->ref);
+	iommu_dev->assigned_pid = 0;
+	iommu_dev->assigned_file_priv = NULL;
+}
+
+static struct qda_iommu_device *find_device_for_pid(struct qda_memory_manager *mem_mgr,
+						    pid_t pid)
+{
+	struct qda_iommu_device *found_dev = NULL;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < mem_mgr->num_devices; i++) {
+		struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
+
+		if (!iommu_dev)
+			continue;
+
+		spin_lock_irqsave(&iommu_dev->lock, flags);
+		if (iommu_dev->assigned_pid == pid) {
+			found_dev = iommu_dev;
+			refcount_inc(&found_dev->users);
+			kref_get(&found_dev->ref);
+			spin_unlock_irqrestore(&iommu_dev->lock, flags);
+			break;
+		}
+		spin_unlock_irqrestore(&iommu_dev->lock, flags);
+	}
+
+	return found_dev;
+}
+
+static struct qda_iommu_device *assign_available_device_to_pid(struct qda_memory_manager *mem_mgr,
+							       pid_t pid,
+							       struct drm_file *file_priv)
+{
+	struct qda_iommu_device *selected_dev = NULL;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < mem_mgr->num_devices; i++) {
+		struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
+
+		if (!iommu_dev)
+			continue;
+
+		spin_lock_irqsave(&iommu_dev->lock, flags);
+		if (iommu_dev->assigned_pid == 0) {
+			iommu_dev->assigned_pid = pid;
+			iommu_dev->assigned_file_priv = file_priv;
+			selected_dev = iommu_dev;
+			refcount_set(&selected_dev->users, 1);
+			kref_get(&selected_dev->ref);
+			spin_unlock_irqrestore(&iommu_dev->lock, flags);
+			break;
+		}
+		spin_unlock_irqrestore(&iommu_dev->lock, flags);
+	}
+
+	return selected_dev;
+}
+
+static struct qda_iommu_device *get_process_iommu_device(struct qda_memory_manager *mem_mgr,
+							 struct drm_file *file_priv)
+{
+	struct qda_file_priv *qda_priv;
+
+	if (!file_priv || !file_priv->driver_priv)
+		return NULL;
+
+	qda_priv = (struct qda_file_priv *)file_priv->driver_priv;
+	return qda_priv->assigned_iommu_dev;
+}
+
+/**
+ * qda_memory_manager_assign_device() - Assign an IOMMU device to a process
+ * @mem_mgr: Pointer to memory manager
+ * @file_priv: DRM file private data for process association
+ *
+ * On success the caller owns a reference on the device and must release it
+ * with qda_memory_manager_release_device().
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mgr,
+				     struct drm_file *file_priv)
+{
+	struct qda_file_priv *qda_priv;
+	struct qda_iommu_device *selected_dev = NULL;
+	int ret = 0;
+	pid_t current_pid;
+
+	if (!file_priv || !file_priv->driver_priv)
+		return -EINVAL;
+
+	qda_priv = (struct qda_file_priv *)file_priv->driver_priv;
+	current_pid = qda_priv->pid;
+
+	mutex_lock(&mem_mgr->process_assignment_lock);
+
+	if (qda_priv->assigned_iommu_dev) {
+		ret = 0;
+		goto unlock_and_return;
+	}
+
+	selected_dev = find_device_for_pid(mem_mgr, current_pid);
+
+	if (selected_dev) {
+		qda_priv->assigned_iommu_dev = selected_dev;
+		goto unlock_and_return;
+	}
+
+	selected_dev = assign_available_device_to_pid(mem_mgr, current_pid, file_priv);
+
+	if (!selected_dev) {
+		drm_dbg_driver(file_priv->minor->dev, "No context bank available for PID %d\n",
+			       current_pid);
+		ret = -EBUSY;
+		goto unlock_and_return;
+	}
+
+	qda_priv->assigned_iommu_dev = selected_dev;
+
+unlock_and_return:
+	mutex_unlock(&mem_mgr->process_assignment_lock);
+
+	return ret;
+}
+
+/**
+ * qda_memory_manager_release_device() - Release a process assignment
+ * @iommu_dev: Device previously obtained from qda_memory_manager_assign_device()
+ *
+ * Drops the caller's reference. Once the last process using the device is
+ * gone the assignment is cleared so the device can serve another process.
+ */
+void qda_memory_manager_release_device(struct qda_iommu_device *iommu_dev)
+{
+	unsigned long flags;
+
+	if (refcount_dec_and_test(&iommu_dev->users)) {
+		spin_lock_irqsave(&iommu_dev->lock, flags);
+		iommu_dev->assigned_pid = 0;
+		iommu_dev->assigned_file_priv = NULL;
+		spin_unlock_irqrestore(&iommu_dev->lock, flags);
+	}
+
+	kref_put(&iommu_dev->ref, iommu_device_free);
+}
+
+static struct qda_iommu_device *get_or_assign_iommu_device(struct qda_memory_manager *mem_mgr,
+							   struct drm_file *file_priv)
+{
+	struct qda_iommu_device *iommu_dev;
+	int ret;
+
+	iommu_dev = get_process_iommu_device(mem_mgr, file_priv);
+	if (iommu_dev)
+		return iommu_dev;
+
+	ret = qda_memory_manager_assign_device(mem_mgr, file_priv);
+	if (ret)
+		return NULL;
+
+	iommu_dev = get_process_iommu_device(mem_mgr, file_priv);
+	if (iommu_dev)
+		return iommu_dev;
+
+	return NULL;
+}
+
+/**
+ * qda_memory_manager_alloc() - Allocate memory for a GEM object
+ * @mem_mgr: Pointer to memory manager
+ * @gem_obj: Pointer to GEM object to allocate memory for
+ * @file_priv: DRM file private data for process association
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj,
+			     struct drm_file *file_priv)
+{
+	struct qda_iommu_device *selected_dev;
+
+	selected_dev = get_or_assign_iommu_device(mem_mgr, file_priv);
+	if (!selected_dev)
+		return -EBUSY;
+
+	return qda_dma_alloc(selected_dev, gem_obj, gem_obj->size);
+}
+
+/**
+ * qda_memory_manager_free() - Free memory for a GEM object
+ * @mem_mgr: Pointer to memory manager
+ * @gem_obj: Pointer to GEM object to free memory for
+ */
+void qda_memory_manager_free(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj)
+{
+	qda_dma_free(gem_obj);
 }
 
 /**
@@ -31,13 +249,21 @@ static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
 int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
 				       struct qda_iommu_device *iommu_dev)
 {
-	if (mem_mgr->num_devices >= mem_mgr->max_devices)
-		return -ENOSPC;
+	int ret = 0;
 
+	mutex_lock(&mem_mgr->process_assignment_lock);
+	if (mem_mgr->num_devices >= mem_mgr->max_devices) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	init_iommu_device_fields(iommu_dev);
 	iommu_dev->id = mem_mgr->num_devices;
 	mem_mgr->devices[mem_mgr->num_devices++] = iommu_dev;
 
-	return 0;
+out:
+	mutex_unlock(&mem_mgr->process_assignment_lock);
+	return ret;
 }
 
 /**
@@ -52,14 +278,16 @@ void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
 {
 	int i;
 
+	mutex_lock(&mem_mgr->process_assignment_lock);
 	for (i = 0; i < mem_mgr->num_devices; i++) {
 		if (mem_mgr->devices[i] == iommu_dev) {
 			mem_mgr->devices[i] = NULL;
 			break;
 		}
 	}
+	mutex_unlock(&mem_mgr->process_assignment_lock);
 
-	kfree(iommu_dev);
+	kref_put(&iommu_dev->ref, iommu_device_free);
 }
 
 /**
@@ -80,6 +308,7 @@ int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int max_devices)
 
 	mem_mgr->num_devices = 0;
 	mem_mgr->max_devices = max_devices;
+	mutex_init(&mem_mgr->process_assignment_lock);
 
 	return 0;
 }
diff --git a/drivers/accel/qda/qda_memory_manager.h b/drivers/accel/qda/qda_memory_manager.h
index 7e38c8a18284..0949c0c213f6 100644
--- a/drivers/accel/qda/qda_memory_manager.h
+++ b/drivers/accel/qda/qda_memory_manager.h
@@ -7,25 +7,44 @@
 #define __QDA_MEMORY_MANAGER_H__
 
 #include <linux/device.h>
+#include <linux/kref.h>
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+#include <linux/spinlock.h>
+#include <drm/drm_file.h>
 
 /* Forward declarations */
 struct qda_dev;
+struct qda_gem_obj;
 
 /**
  * struct qda_iommu_device - IOMMU device instance for memory management
  *
  * Represents a single IOMMU-enabled device managed by the memory manager.
  * Each device can be assigned to a specific process session.
+ *
+ * The object outlives its registration: open files keep a reference through
+ * @ref, so a device can be unregistered while a process still holds it.
  */
 struct qda_iommu_device {
 	/** @dev: Pointer to the underlying device */
 	struct device *dev;
 	/** @qdev: Back-pointer to the parent QDA device */
 	struct qda_dev *qdev;
+	/** @assigned_file_priv: DRM file private data for the assigned process */
+	struct drm_file *assigned_file_priv;
 	/** @id: Unique identifier assigned by the memory manager */
 	u32 id;
 	/** @sid: Stream ID for IOMMU transactions */
 	u32 sid;
+	/** @assigned_pid: Process ID of the process assigned to this device */
+	pid_t assigned_pid;
+	/** @users: Number of open files sharing this device */
+	refcount_t users;
+	/** @ref: Reference count controlling when the object is freed */
+	struct kref ref;
+	/** @lock: Spinlock protecting concurrent access to device */
+	spinlock_t lock;
 };
 
 /**
@@ -42,6 +61,8 @@ struct qda_memory_manager {
 	int num_devices;
 	/** @max_devices: Capacity of the @devices array */
 	int max_devices;
+	/** @process_assignment_lock: Mutex protecting process-to-device assignments */
+	struct mutex process_assignment_lock;
 };
 
 int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int max_devices);
@@ -51,5 +72,14 @@ int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
 				       struct qda_iommu_device *iommu_dev);
 void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
 					  struct qda_iommu_device *iommu_dev);
+int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mgr,
+				     struct drm_file *file_priv);
+void qda_memory_manager_release_device(struct qda_iommu_device *iommu_dev);
+
+int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr,
+			     struct qda_gem_obj *gem_obj,
+			     struct drm_file *file_priv);
+void qda_memory_manager_free(struct qda_memory_manager *mem_mgr,
+			     struct qda_gem_obj *gem_obj);
 
 #endif /* __QDA_MEMORY_MANAGER_H__ */

-- 
2.34.1

