Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2162AC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7656F10E62A;
	Mon, 17 Aug 2026 04:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SV7P/OdB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A0b3l4jp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D12A10E62A
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:24 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCvM3855667
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 exAvU1dq5FUW7Fek/YNz53xNMTya5lAEp49AniBShNA=; b=SV7P/OdByidSXhDd
 wvwVQsLjkbLCEFK0ChdbsaZZsfBBnrk7As6MZ3lzdIUlxKAvBPU4FAGUK2Xb94qI
 4sMNh5GiA3vbN/huUhWWLfSukQ96Qk5U8SP3adzEASYAe1aQ8iRw8w1qWJf6UDaj
 iDzSH4ttCQm2/W9RITJ+jUOqpm+lKCW3uXrMUJ6jAKMpagHaIAQJzkey4Kqy+hNX
 +Blgh0qdhdKB3rwGKblaKH0BA3/6roj5nvWvtfDxLmbmduD2rzircCGaQ/xWTMqn
 E1bRXDlwApfH5O4fsUub7551dnE6wqyDNWdPgU4bYb4I6EQaw/J8ewNy85/F/CS3
 YlohAQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwn57e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84e4ef486c7so2550907b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942162; x=1787546962;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=exAvU1dq5FUW7Fek/YNz53xNMTya5lAEp49AniBShNA=;
 b=A0b3l4jpwkuzziMj3C0coNe29fgQLmyPat+26+mgkGHeRQlQCdGaBuWlAIqLl6o8tW
 dPZYnkqW2zCy6uNvhs+KJZj23Pp2dstnZ2aBbOJkdxj4mYksdGVx0CJDrD4y+pPlfJQg
 Uc4qG9upCKg3Eve3217HBM0x7gBb91ft+KATv0IQPzuxJHSILpcr6wmDrnHllrYCarup
 wm0ISAP6jDTb/hVTTMNhUO9oAGO4xCcRqShCVLwKvmufndDyxGtCTxt0/t0FSPAx1E7U
 rPC00cAQdEc2CBrm+itE51Gdi8n6aV0i6KIUBbJxB9ndXTZSFkN5NltrYTsOsRM7ocDS
 Xp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942162; x=1787546962;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=exAvU1dq5FUW7Fek/YNz53xNMTya5lAEp49AniBShNA=;
 b=jlfniEvhwBSsY8IkliPnP2a1G23yG6OSpMeD1J4fbKw1SsydT+CkatfL06GU7Qoay9
 SkiYz4hQVOBm66byRCRnY2Nl1fysvRnEUd0DdAkdtdwahcM+ilPm9pPGrg9G5Nyb1j0o
 o/o3i9ofEbOYaevvcrTa0GdTaR5tSGKI7uUrhs2f2rD6qXPwPeAmbxOGMbTZOyeCI+f+
 Z4rDniDKrtL1pMLlvvob7li88/vW1inLdSo4IDiWVKmHhhkc3nqhI8SnQu7noSQEcqkt
 EmUy3PvrVw0749EfY9XfscOw/6UzbpLupfCJL5JNPSW/xZnHl0cprMClcQ1UYRG6HvgS
 DJXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqKr2S75xF3r0r7JizAGdG+cxIa0IIeoy5PTOFZQLUl/BMJdZLnI2InoI6NZYSjGkcUPTq4HiMhxg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzNopws8EGYqFfpqOxJZr1Xo8Ba0RBA8zLtJte67xxM6L8ZYYF
 k8iiifcybd7eJA5tJAqU0XM7Mlrt3JTtKj2o6URxLJL4T+j/rFkDIbkkpZEXdZYRsZNKBdPTiMJ
 mxZyjuP7qk9fPoJi+2iQ7TZtcR3LxEUdR2RiCGhfkV9WVDZQbgiSAKteKHoOKiCNQOtFZC2I=
X-Gm-Gg: AR+sD13dzTN3aMLUhMghYW2xToSDIF2Ia2F/Q9aLo72attyY944F3a1LbC7h0bhQzKc
 mkNtJrfzP+VueO1SBgUEi8bqVY6aFidZbpRtZIpyLF/kVwvVTpC4pd8cCXrT5PQks+4yuVWwWbK
 vzEeuZyZYD4yn4EPWmjWoEjk/q8yAmnTQz+hhgi/5YkRQqTLWedcRrPDNmY0E/Dn/PSj9X61tON
 BwUkzFROeMEPOCSI6HrHn1QjNsxn8OX7Z2DFGKbBy7WFtqIbeOPVwwmew7ujy9524B9JC0HE60A
 UiRb2eQDqotI5Ckfx/mGKpMzQoSbpX3wOAsYXi6DMuMNIOuQCCfECO1mDiw9dUWJNhHmW8wOuMp
 e/oRo+pJw5zDcMvjjpABRDyhDWFlmTzZP
X-Received: by 2002:a05:6a00:2384:b0:84a:32ba:a262 with SMTP id
 d2e1a72fcca58-84fc7a2d32fmr23327720b3a.7.1786942162145; 
 Sun, 16 Aug 2026 21:49:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:2384:b0:84a:32ba:a262 with SMTP id
 d2e1a72fcca58-84fc7a2d32fmr23327663b3a.7.1786942161539; 
 Sun, 16 Aug 2026 21:49:21 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:49:21 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:46 +0530
Subject: [PATCH v2 11/15] accel/qda: Add PRIME DMA-BUF import support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-qda-v2-v2-11-69a02e9090d4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=16954;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=moLqx5cbFJtktupEG+Q82hxg3Qpm2qyk2dTAATzVRyA=;
 b=jkkmRQXUVLzy+DmYB+n9rlpO/o/MwYW0X8wdrbhCCZCJ3Iox//Ns5aKBrcdowLDbYfmwBzgqv
 NaezbqlsEZlCpAdMKkWt6ZzndAdMMwWlFuOPt5ZC8qkdnZcL3oQ0j9R
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: 6RJuKPtz2ifTdU6__7dP351G-j-o54W-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX0UO/ujGZS0/u
 vBzJfGSHqGBKBZEI34VHWHDv4kyYghP9xfth1QVKcJiKSnOxxF1+x5Tc1KpFLzKnh7v5PAlNdB2
 WzqJizkkdBuhTX2qf/UXfmFTQSN29RQgiCrKz8oPgk/Hct52I1SzvhxuWNfdWebAA4Pgki5OtOB
 F7JVpt0jHPSMtKbEXCWdwfpacqHowXG+EBV6gkJ0e0ea7Yi8GYROaefAN2c1xg02i82pALHNiO5
 e6EDeIGQS/RMqt5tAnNXbMXSI+P3IfXNiyHHltcQUr7IbxYESt3MXhDtVnDJuOu+j4Gm0KwFB5h
 uLsNOn3hX/nfZQmloS/b3U+sU4iwjmsTCPdBVhPxsiEL41H4Gc4XL5cFDVEprN+RZol7I7pIUcm
 2IA/0Vce4nwphDi0c9Lbc9HMj9AnCLd5E52pt6dweqQxBPtmJfF3tD/BupnvZxrgA88dMzVJj+8
 WT+qb43q7C5D5fySrvg==
X-Proofpoint-GUID: 6RJuKPtz2ifTdU6__7dP351G-j-o54W-
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a8292d4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=uzR8CpETjqjp4ZOwAqoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX8jEu9XG8a7MZ
 QZCCIqD5cOVCqpnYQyWQDklSpMSMkbuXjUo8z8fOY9eVDW75JHqtwByS+wTDjR5QOMnx47tG9y0
 bDgnmOOceKD/D3cuwax2Xt3oYY4sZuI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170033
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

Allow user-space to import DMA-BUF file descriptors from other
subsystems (GPU, camera, video) into the QDA driver via the standard
DRM PRIME interface.

qda_prime.c
  Implements qda_gem_prime_import(), which is set as the driver's
  .gem_prime_import callback. On import it:
  1. Short-circuits self-import: if the dma_buf was exported by this
     device and is not itself an import, the existing GEM object is
     returned with an incremented reference count.
  2. Attaches to the dma_buf and maps it with DMA_BIDIRECTIONAL via
     dma_buf_map_attachment_unlocked(), obtaining an sg_table whose
     DMA addresses are IOMMU virtual addresses in the CB device's
     address space.
  3. Calls qda_memory_manager_alloc() to record the mapping and encode
     the SID in the upper bits of the DMA address, matching the
     convention used for natively allocated buffers.

  qda_prime_fd_to_handle() wraps drm_gem_prime_fd_to_handle() under
  qdev->import_lock, storing the calling file_priv in
  qdev->current_import_file_priv so that qda_gem_prime_import() can
  retrieve it (the .gem_prime_import callback does not receive
  file_priv directly, but the context bank to attach to is per-process).

qda_gem.c
  qda_gem_free_object() is extended to handle the imported-buffer
  teardown path: unmap the sg_table, detach from the dma_buf, and
  release the dma_buf reference.
  qda_gem_mmap_obj() rejects mmap requests on imported objects, which
  must be mapped through the exporter instead.

qda_memory_manager.c
  The DSP is given a single base address per buffer, so only buffers
  that are mapped as one contiguous range can be described to it.
  qda_memory_manager_map_imported() therefore walks the imported
  buffer's scatterlist and rejects any buffer whose entries are not
  contiguous; contiguous imports (for example from the CMA DMA-buf
  heap) are accepted. Whether an exporter or IOMMU coalesces a buffer
  into a single range is not guaranteed, so this is verified rather
  than assumed.
  qda_memory_manager_free() skips the DMA free path for imported
  buffers since the memory is owned by the exporter.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Changes in v2:
- Do not assume the exporter or IOMMU maps an imported buffer as a
  single contiguous range; walk the scatterlist and cleanly reject
  non-contiguous imports instead (Christian König)
- Document that only contiguous imports (e.g. CMA DMA-buf heap) are
  supported
- Return -EBUSY rather than -ENODEV when no context bank is available
---
 drivers/accel/qda/Makefile             |   1 +
 drivers/accel/qda/qda_drv.c            |  12 ++-
 drivers/accel/qda/qda_drv.h            |   4 +
 drivers/accel/qda/qda_gem.c            |  25 ++++-
 drivers/accel/qda/qda_gem.h            |   8 ++
 drivers/accel/qda/qda_memory_manager.c |  42 +++++++++
 drivers/accel/qda/qda_prime.c          | 167 +++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_prime.h          |  18 ++++
 8 files changed, 274 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index a46ddceecfc5..fb092e56d7f3 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -12,6 +12,7 @@ qda-y := \
 	qda_ioctl.o \
 	qda_memory_dma.o \
 	qda_memory_manager.o \
+	qda_prime.o \
 	qda_rpmsg.o
 
 obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index d22c2c66ffc4..a68a07d0ae56 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -7,11 +7,13 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_prime.h>
 #include <drm/drm_print.h>
 #include <drm/qda_accel.h>
 
 #include "qda_drv.h"
 #include "qda_ioctl.h"
+#include "qda_prime.h"
 
 static int qda_open(struct drm_device *dev, struct drm_file *file)
 {
@@ -54,6 +56,8 @@ static const struct drm_driver qda_drm_driver = {
 	.postclose = qda_postclose,
 	.ioctls = qda_ioctls,
 	.num_ioctls = ARRAY_SIZE(qda_ioctls),
+	.gem_prime_import = qda_gem_prime_import,
+	.prime_fd_to_handle = qda_prime_fd_to_handle,
 	.name = QDA_DRIVER_NAME,
 	.desc = "Qualcomm DSP Accelerator Driver",
 };
@@ -72,6 +76,7 @@ struct qda_dev *qda_alloc_device(struct device *dev)
 
 void qda_deinit_device(struct qda_dev *qdev)
 {
+	mutex_destroy(&qdev->import_lock);
 	if (qdev->iommu_mgr) {
 		qda_memory_manager_exit(qdev->iommu_mgr);
 		kfree(qdev->iommu_mgr);
@@ -83,14 +88,19 @@ int qda_init_device(struct qda_dev *qdev, int num_cbs)
 {
 	int ret;
 
+	mutex_init(&qdev->import_lock);
+	qdev->current_import_file_priv = NULL;
 	qdev->iommu_mgr = kzalloc_obj(*qdev->iommu_mgr);
-	if (!qdev->iommu_mgr)
+	if (!qdev->iommu_mgr) {
+		mutex_destroy(&qdev->import_lock);
 		return -ENOMEM;
+	}
 	ret = qda_memory_manager_init(qdev->iommu_mgr, num_cbs);
 	if (ret) {
 		drm_err(&qdev->drm_dev, "Failed to initialize memory manager: %d\n", ret);
 		kfree(qdev->iommu_mgr);
 		qdev->iommu_mgr = NULL;
+		mutex_destroy(&qdev->import_lock);
 	}
 
 	return ret;
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index 2fe58f3efec0..422e70b971b8 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -47,6 +47,10 @@ struct qda_dev {
 	struct list_head cb_devs;
 	/** @iommu_mgr: IOMMU/memory manager instance */
 	struct qda_memory_manager *iommu_mgr;
+	/** @import_lock: Lock protecting prime import context */
+	struct mutex import_lock;
+	/** @current_import_file_priv: Current file_priv during prime import */
+	struct drm_file *current_import_file_priv;
 	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
 	const char *dsp_name;
 };
diff --git a/drivers/accel/qda/qda_gem.c b/drivers/accel/qda/qda_gem.c
index 66e78013a726..6f5c54daa951 100644
--- a/drivers/accel/qda/qda_gem.c
+++ b/drivers/accel/qda/qda_gem.c
@@ -9,6 +9,7 @@
 #include "qda_gem.h"
 #include "qda_memory_manager.h"
 #include "qda_memory_dma.h"
+#include "qda_prime.h"
 
 /**
  * qda_gem_free_object() - Free a GEM object and its associated resources
@@ -19,8 +20,20 @@ void qda_gem_free_object(struct drm_gem_object *gem_obj)
 	struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(gem_obj);
 	struct qda_dev *qdev = qda_dev_from_drm(gem_obj->dev);
 
-	if (qda_gem_obj->virt && qdev->iommu_mgr)
-		qda_memory_manager_free(qdev->iommu_mgr, qda_gem_obj);
+	if (qda_gem_obj->is_imported) {
+		if (qda_gem_obj->attachment && qda_gem_obj->sgt)
+			dma_buf_unmap_attachment_unlocked(qda_gem_obj->attachment,
+							  qda_gem_obj->sgt, DMA_BIDIRECTIONAL);
+		if (qda_gem_obj->attachment)
+			dma_buf_detach(qda_gem_obj->dma_buf, qda_gem_obj->attachment);
+		if (qda_gem_obj->dma_buf)
+			dma_buf_put(qda_gem_obj->dma_buf);
+		if (qda_gem_obj->iommu_dev && qdev->iommu_mgr)
+			qda_memory_manager_free(qdev->iommu_mgr, qda_gem_obj);
+	} else {
+		if (qda_gem_obj->virt && qdev->iommu_mgr)
+			qda_memory_manager_free(qdev->iommu_mgr, qda_gem_obj);
+	}
 
 	drm_gem_object_release(gem_obj);
 	kfree(qda_gem_obj);
@@ -38,6 +51,10 @@ int qda_gem_mmap_obj(struct drm_gem_object *drm_obj, struct vm_area_struct *vma)
 	struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(drm_obj);
 	int ret;
 
+	/* Imported dma-buf objects must be mmap'd through the exporter, not the importer */
+	if (qda_gem_obj->is_imported)
+		return -EINVAL;
+
 	/* The fake offset is only used to find the object, not to index it */
 	vma->vm_pgoff = 0;
 
@@ -123,6 +140,10 @@ struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
 	qda_gem_obj = qda_gem_alloc_object(drm_dev, aligned_size);
 	if (IS_ERR(qda_gem_obj))
 		return ERR_CAST(qda_gem_obj);
+	qda_gem_obj->is_imported = false;
+	qda_gem_obj->dma_buf = NULL;
+	qda_gem_obj->attachment = NULL;
+	qda_gem_obj->sgt = NULL;
 
 	ret = qda_memory_manager_alloc(iommu_mgr, qda_gem_obj, file_priv);
 	if (ret) {
diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
index afd7c9b49549..3e28d14099fb 100644
--- a/drivers/accel/qda/qda_gem.h
+++ b/drivers/accel/qda/qda_gem.h
@@ -21,12 +21,20 @@ struct qda_gem_obj {
 	struct drm_gem_object base;
 	/** @iommu_dev: IOMMU context bank device that performed the allocation */
 	struct qda_iommu_device *iommu_dev;
+	/** @dma_buf: Reference to imported dma_buf */
+	struct dma_buf *dma_buf;
+	/** @attachment: DMA buf attachment */
+	struct dma_buf_attachment *attachment;
+	/** @sgt: Scatter-gather table */
+	struct sg_table *sgt;
 	/** @virt: Kernel virtual address of the allocated DMA memory */
 	void *virt;
 	/** @dma_addr: DMA address (with SID encoded in upper 32 bits) */
 	dma_addr_t dma_addr;
 	/** @size: Size of the buffer in bytes */
 	size_t size;
+	/** @is_imported: True if buffer is imported, false if allocated */
+	bool is_imported;
 };
 
 /**
diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
index d47c7419e11d..3c25ec47cd09 100644
--- a/drivers/accel/qda/qda_memory_manager.c
+++ b/drivers/accel/qda/qda_memory_manager.c
@@ -209,6 +209,41 @@ static struct qda_iommu_device *get_or_assign_iommu_device(struct qda_memory_man
 	return NULL;
 }
 
+static int qda_memory_manager_map_imported(struct qda_gem_obj *gem_obj,
+					   struct qda_iommu_device *iommu_dev)
+{
+	dma_addr_t dma_addr, expected_addr = 0;
+	struct scatterlist *sg, *s;
+	int i;
+
+	sg = gem_obj->sgt->sgl;
+
+	/*
+	 * Verify that the imported DMA-BUF is contiguous. While some platforms
+	 * or IOMMUs might map buffers as a single range, we must not silently
+	 * assume this is always the case. We loop through the scatterlist
+	 * entries and reject any that are non-contiguous.
+	 */
+	for_each_sg(gem_obj->sgt->sgl, s, gem_obj->sgt->nents, i) {
+		dma_addr_t curr_addr = sg_dma_address(s);
+
+		if (i > 0 && curr_addr != expected_addr) {
+			drm_err_ratelimited(gem_obj->base.dev,
+					    "Imported DMA-BUF is non-contiguous; rejecting mapping\n");
+			return -EINVAL;
+		}
+		expected_addr = curr_addr + sg_dma_len(s);
+	}
+
+	gem_obj->iommu_dev = iommu_dev;
+
+	dma_addr = sg_dma_address(sg);
+	dma_addr += ((u64)iommu_dev->sid << 32);
+	gem_obj->dma_addr = dma_addr;
+
+	return 0;
+}
+
 /**
  * qda_memory_manager_alloc() - Allocate memory for a GEM object
  * @mem_mgr: Pointer to memory manager
@@ -226,6 +261,9 @@ int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr, struct qda_gem_
 	if (!selected_dev)
 		return -EBUSY;
 
+	if (gem_obj->is_imported)
+		return qda_memory_manager_map_imported(gem_obj, selected_dev);
+
 	return qda_dma_alloc(selected_dev, gem_obj, gem_obj->size);
 }
 
@@ -236,6 +274,10 @@ int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr, struct qda_gem_
  */
 void qda_memory_manager_free(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj)
 {
+	/* Imported buffers are unmapped through the exporter, not here */
+	if (gem_obj->is_imported)
+		return;
+
 	qda_dma_free(gem_obj);
 }
 
diff --git a/drivers/accel/qda/qda_prime.c b/drivers/accel/qda/qda_prime.c
new file mode 100644
index 000000000000..306b3037c19c
--- /dev/null
+++ b/drivers/accel/qda/qda_prime.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <drm/drm_gem.h>
+#include <drm/drm_prime.h>
+#include <drm/drm_print.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include "qda_drv.h"
+#include "qda_gem.h"
+#include "qda_prime.h"
+#include "qda_memory_manager.h"
+
+static struct drm_gem_object *check_own_buffer(struct drm_device *dev, struct dma_buf *dma_buf)
+{
+	struct drm_gem_object *existing_gem;
+
+	/* Only safe to access priv if this dma-buf was exported by this device */
+	if (!drm_gem_is_prime_exported_dma_buf(dev, dma_buf))
+		return NULL;
+
+	existing_gem = dma_buf->priv;
+	if (existing_gem->dev != dev)
+		return NULL;
+
+	if (to_qda_gem_obj(existing_gem)->is_imported)
+		return NULL;
+
+	drm_gem_object_get(existing_gem);
+	return existing_gem;
+}
+
+static struct qda_iommu_device *get_iommu_device_for_import(struct qda_dev *qdev,
+							    struct drm_file **file_priv_out)
+{
+	struct drm_file *file_priv;
+	struct qda_file_priv *qda_file_priv;
+	struct qda_iommu_device *iommu_dev;
+
+	file_priv = qdev->current_import_file_priv;
+	*file_priv_out = file_priv;
+
+	if (!file_priv || !file_priv->driver_priv)
+		return NULL;
+
+	qda_file_priv = (struct qda_file_priv *)file_priv->driver_priv;
+	iommu_dev = qda_file_priv->assigned_iommu_dev;
+
+	if (!iommu_dev) {
+		if (qda_memory_manager_assign_device(qdev->iommu_mgr, file_priv))
+			return NULL;
+
+		iommu_dev = qda_file_priv->assigned_iommu_dev;
+	}
+
+	return iommu_dev;
+}
+
+static int setup_dma_buf_mapping(struct qda_gem_obj *qda_gem_obj, struct dma_buf *dma_buf,
+				 struct device *attach_dev)
+{
+	struct dma_buf_attachment *attachment;
+	struct sg_table *sgt;
+	int ret;
+
+	attachment = dma_buf_attach(dma_buf, attach_dev);
+	if (IS_ERR(attachment))
+		return PTR_ERR(attachment);
+
+	qda_gem_obj->attachment = attachment;
+
+	sgt = dma_buf_map_attachment_unlocked(attachment, DMA_BIDIRECTIONAL);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		dma_buf_detach(dma_buf, attachment);
+		return ret;
+	}
+	qda_gem_obj->sgt = sgt;
+
+	return 0;
+}
+
+/**
+ * qda_gem_prime_import() - Import a DMA-BUF as a GEM object
+ * @dev: DRM device structure
+ * @dma_buf: DMA-BUF to import
+ *
+ * Return: Pointer to the imported GEM object on success, ERR_PTR on failure
+ */
+struct drm_gem_object *qda_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
+{
+	struct qda_dev *qdev = qda_dev_from_drm(dev);
+	struct qda_gem_obj *qda_gem_obj;
+	struct drm_file *file_priv;
+	struct qda_iommu_device *iommu_dev;
+	struct drm_gem_object *existing_gem;
+	size_t aligned_size;
+	int ret;
+
+	existing_gem = check_own_buffer(dev, dma_buf);
+	if (existing_gem)
+		return existing_gem;
+
+	iommu_dev = get_iommu_device_for_import(qdev, &file_priv);
+	if (!iommu_dev || !iommu_dev->dev) {
+		drm_dbg_driver(dev, "No context bank available for prime import\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	aligned_size = PAGE_ALIGN(dma_buf->size);
+	qda_gem_obj = qda_gem_alloc_object(dev, aligned_size);
+	if (IS_ERR(qda_gem_obj))
+		return ERR_CAST(qda_gem_obj);
+
+	qda_gem_obj->is_imported = true;
+	qda_gem_obj->dma_buf = dma_buf;
+	qda_gem_obj->virt = NULL;
+	qda_gem_obj->iommu_dev = iommu_dev;
+
+	get_dma_buf(dma_buf);
+
+	ret = setup_dma_buf_mapping(qda_gem_obj, dma_buf, iommu_dev->dev);
+	if (ret)
+		goto err_put_dma_buf;
+
+	ret = qda_memory_manager_alloc(qdev->iommu_mgr, qda_gem_obj, file_priv);
+	if (ret)
+		goto err_unmap;
+
+	return &qda_gem_obj->base;
+
+err_unmap:
+	dma_buf_unmap_attachment_unlocked(qda_gem_obj->attachment,
+					  qda_gem_obj->sgt, DMA_BIDIRECTIONAL);
+	dma_buf_detach(dma_buf, qda_gem_obj->attachment);
+err_put_dma_buf:
+	dma_buf_put(dma_buf);
+	qda_gem_cleanup_object(qda_gem_obj);
+	return ERR_PTR(ret);
+}
+
+/**
+ * qda_prime_fd_to_handle() - Convert a PRIME fd to a GEM handle
+ * @dev: DRM device structure
+ * @file_priv: DRM file private data
+ * @prime_fd: File descriptor of the PRIME buffer
+ * @handle: Output GEM handle
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_prime_fd_to_handle(struct drm_device *dev, struct drm_file *file_priv,
+			   int prime_fd, u32 *handle)
+{
+	struct qda_dev *qdev = qda_dev_from_drm(dev);
+	int ret;
+
+	mutex_lock(&qdev->import_lock);
+	qdev->current_import_file_priv = file_priv;
+
+	ret = drm_gem_prime_fd_to_handle(dev, file_priv, prime_fd, handle);
+
+	qdev->current_import_file_priv = NULL;
+	mutex_unlock(&qdev->import_lock);
+
+	return ret;
+}
+
+MODULE_IMPORT_NS("DMA_BUF");
diff --git a/drivers/accel/qda/qda_prime.h b/drivers/accel/qda/qda_prime.h
new file mode 100644
index 000000000000..9b3850d54fa7
--- /dev/null
+++ b/drivers/accel/qda/qda_prime.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_PRIME_H__
+#define __QDA_PRIME_H__
+
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+#include <linux/dma-buf.h>
+
+struct drm_gem_object *qda_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf);
+int qda_prime_fd_to_handle(struct drm_device *dev, struct drm_file *file_priv,
+			   int prime_fd, u32 *handle);
+
+#endif /* __QDA_PRIME_H__ */

-- 
2.34.1

