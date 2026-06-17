Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBC5CD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C1410E979;
	Wed, 17 Jun 2026 09:20:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jT/cHbPT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B13410E979
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781688038; x=1813224038;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DivbDFT5qPVgVf5rxztUGE/zgHfwaMbiE9v/ib+p1oo=;
 b=jT/cHbPTu6zkS6uGRM5b+HRyTM6HXgAvLyDi7zXwkckqzMbA11Bbi8J/
 zSD1y1t9UezObmJS7wFEQAVzl9/dDFESyJyaUNuSVHiTAtEUJZSEyxXSi
 q6kGfczvsgiKu1LmuL0Ca66CDoVWi/ojRR6oNXXDTAh7VdLHEzifN/6NU
 rBUSK9kCPQ8txOseSOtQa8gARJdPUH7gjIk7s3Upty4BpfqhBar/pdj1o
 7DclyxGhuQBa4WaTnWplxPNyCWGq/+hZmKFyRSKYpQ9T1d6Flrlw5POmX
 rLcxnlZm6YhKyZ+CHM0/cpQQjRj+2YY2B6Nb8EZStvVKl/TRW3wGpj8cb g==;
X-CSE-ConnectionGUID: 3sSECd2bT3OXZHwRQAsH5g==
X-CSE-MsgGUID: Ku0YCfJzRCqEB2mJyp5a0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93043511"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="93043511"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 02:20:38 -0700
X-CSE-ConnectionGUID: lvRJ5TzNTz+iwyORvaB1ug==
X-CSE-MsgGUID: oCv6ZbTwQsi5riRwlXu7hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="278209304"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 02:20:37 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Karol Wachowski <karol.wachowski@linux.intel.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Drop IRQF_ONESHOT to allow IPC IRQ threading on
 PREEMPT_RT
Date: Wed, 17 Jun 2026 11:20:31 +0200
Message-ID: <20260617092031.3016582-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The IPC RX hardirq handler matches consumers under a spinlock and
allocates rx_msg buffers. On PREEMPT_RT these spinlocks become sleeping
locks and the allocation may sleep, neither of which is allowed in true
hardirq context, resulting in "sleeping function called from invalid
context" splats.

IRQF_ONESHOT makes genirq keep the primary handler in hardirq even when
forced threading is enabled, so on PREEMPT_RT the handler cannot be
threaded. Drop the flag so the primary handler is threaded on PREEMPT_RT
and the IPC RX path runs in a context where sleeping is allowed. On the
MSI interrupt chip (IRQCHIP_ONESHOT_SAFE) the flag was stripped anyway,
so non-RT behaviour is unchanged.

Fixes: 85c9cc2d25f8 ("accel/ivpu: Use threaded IRQ for IPC callback processing")
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Cc: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 6b34c52b1fba..95120957f42a 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -623,7 +623,7 @@ static int ivpu_irq_init(struct ivpu_device *vdev)
 	vdev->irq = pci_irq_vector(pdev, 0);
 
 	ret = devm_request_threaded_irq(vdev->drm.dev, vdev->irq, ivpu_hw_irq_handler,
-					ivpu_ipc_irq_thread_handler, IRQF_NO_AUTOEN | IRQF_ONESHOT,
+					ivpu_ipc_irq_thread_handler, IRQF_NO_AUTOEN,
 					DRIVER_NAME, vdev);
 	if (ret)
 		ivpu_err(vdev, "Failed to request an IRQ %d\n", ret);
-- 
2.43.0

