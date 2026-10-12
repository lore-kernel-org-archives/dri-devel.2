Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D0ACA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6E210EF55;
	Mon, 12 Oct 2026 08:38:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE0210EF4B
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791794289; x=1823330289;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pG44e3tsp5bF6xHe3Z2E4HFRjTPpbQf/LXMySKEKqXQ=;
 b=OXW5X0rMpXRav5Ou2BkDzKnU6gAYG6EAwIwmLwoWO+CWq92eqNdPMsKi
 MP1ucOCuuSyz4b+3pBIXh28rNG9RPMBb/vCK4pfnD12RnhdaA42tV7ZXj
 X7ubhWM6sHHFtx/yQw2O0PQbBTwzN3mK864g1cBChYsgPVXMVQuO8YKeZ
 QczidbE0Bhfzw+9eT4/pogBiYcaQozcd/hJMwLzvWmn8szPXrrJa0Z0bM
 gzphy4Z32EoanBjkrvgt5FRLXXh5Ry628SvLaxnnK/v46NSWsTnFim2/L
 jYLG3/vSJGB1wYbsGIbTE2DbxKsiIvW0amSbZDOLqqHRYjZXzx7R7h4c4 Q==;
X-CSE-ConnectionGUID: EI2RzlKQRomJVppj/V9cjQ==
X-CSE-MsgGUID: b7Sa5axfSsKdh4ssXmIruw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="501000"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="501000"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:08 -0700
X-CSE-ConnectionGUID: PDss6T+zTDSzzhSR8t0NXQ==
X-CSE-MsgGUID: GeI0uolpS8GlGUhTpmLRhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1030684"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:07 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 0/5] accel/ivpu: Merge register headers and extend tile fuse
 config
Date: Mon, 12 Oct 2026 10:37:57 +0200
Message-ID: <20261012083802.2778448-1-karol.wachowski@linux.intel.com>
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

This series removes duplication between the per-generation register
definitions and code in the ivpu driver, and adds a debug test mode.

Patch 1 adds a test mode that enables the buttress FREQ_CHANGE interrupt
and stores the buttress interrupt mask in struct ivpu_hw_info.

Patches 2-4 merge the 37xx/40xx IP register headers, the identical 37xx
and 40xx IP functions, and the MTL/LNL buttress register headers. There
is no functional change.

Patch 5 extends the tile fuse config field to 7 bits.

Karol Wachowski (5):
  accel/ivpu: Add test mode to enable the FREQ_CHANGE interrupt
  accel/ivpu: Merge NPU IP register headers
  accel/ivpu: Merge identical 37xx and 40xx IP functions
  accel/ivpu: Merge buttress register headers
  accel/ivpu: Extend tile fuse config to 7 bits

 drivers/accel/ivpu/ivpu_drv.h                 |   1 +
 drivers/accel/ivpu/ivpu_hw.c                  |   5 -
 drivers/accel/ivpu/ivpu_hw.h                  |   7 +-
 drivers/accel/ivpu/ivpu_hw_40xx_reg.h         | 195 ---------
 drivers/accel/ivpu/ivpu_hw_btrs.c             |  32 +-
 drivers/accel/ivpu/ivpu_hw_btrs.h             |   2 -
 drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h     |  83 ----
 ...u_hw_btrs_lnl_reg.h => ivpu_hw_btrs_reg.h} |  84 +++-
 drivers/accel/ivpu/ivpu_hw_ip.c               | 396 +++---------------
 drivers/accel/ivpu/ivpu_hw_ip.h               |   3 +-
 .../{ivpu_hw_37xx_reg.h => ivpu_hw_ip_reg.h}  |  69 ++-
 11 files changed, 232 insertions(+), 645 deletions(-)
 delete mode 100644 drivers/accel/ivpu/ivpu_hw_40xx_reg.h
 delete mode 100644 drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h
 rename drivers/accel/ivpu/{ivpu_hw_btrs_lnl_reg.h => ivpu_hw_btrs_reg.h} (58%)
 rename drivers/accel/ivpu/{ivpu_hw_37xx_reg.h => ivpu_hw_ip_reg.h} (73%)

-- 
2.43.0

