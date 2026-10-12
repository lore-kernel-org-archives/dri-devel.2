Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3CBCA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C29910F2A9;
	Mon, 12 Oct 2026 18:05:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C1B10E656;
 Mon, 12 Oct 2026 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791828354; x=1823364354;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=c7MmapL2K5YfEx3yLiNiN2uADHN4neE8C513rSSvEM0=;
 b=Z1XiuU+l/QkvW/py/tHxnlomOLLFUuamwZLyRei6N8uUzN2CakCwhR+K
 wUFb4fVMWsStGt7GezeRYqdljpv+b/F4yU5nS/AvLXNdedJxqDsp6o2th
 BiLkUKIv5mk5PMykLT625vq7goIaT9EcXc6+BbW5ec/6tHbVTEe1sCEuc
 HQHA5hYdETOOsNPc6w94fdOAxBjMAtwwVy0FgcNPNKcsgfePg+GFOoZlT
 tk9sTrBYDHwJ0VFatnS2Bx5GYrD0sm2p+lW9gzNSZnVCwqkcYVBGaUqOr
 QuzJzfyUIYeVHhacCzMuOYftLIpLo3+SnoCHCU/pFnE1AJo54T/8zdttn A==;
X-CSE-ConnectionGUID: Rqn4QEy7TgGu4Hd1w1kxJA==
X-CSE-MsgGUID: vOEhaPiERNmitRXC+NZRSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="548316"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="548316"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 11:05:54 -0700
X-CSE-ConnectionGUID: sqUSxgaNQ4iLBy9W9QHE1A==
X-CSE-MsgGUID: /j6Z2quASuulGvwkVZeZHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1281733"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 11:05:53 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 0/2] drm: add a self-import PRIME dma-buf helper and use it in
 Xe
Date: Mon, 12 Oct 2026 11:05:41 -0700
Message-ID: <20261012180543.1488703-4-niranjana.vishwanathapura@intel.com>
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

Detecting that a PRIME dma-buf being imported was exported by the same
DRM device is a common pattern currently open-coded in drivers. This
series factors it into a generic helper and converts Xe to use it.

Patch 1 adds drm_gem_prime_self_import(): when the dma-buf originates
from the importing device and uses the expected dma-buf ops, it returns
the backing GEM object with an extra reference, letting drivers short-
circuit the generic PRIME import path and skip the extra dma-buf file
reference.

Patch 2 replaces Xe's driver-specific self-import detection with the new
helper, exposed within Xe as xe_dma_buf_to_gem() for future use.

No intended functional change.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

Farah Kassabri (2):
  drm/gem: add helper to detect self-imported PRIME dma-bufs
  drm/xe/dma-buf: Use drm helper to detect dma-buf self-import

 drivers/gpu/drm/drm_prime.c     | 48 +++++++++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_dma_buf.c | 23 +++++++++-------
 drivers/gpu/drm/xe/xe_dma_buf.h |  2 ++
 include/drm/drm_prime.h         |  4 +++
 4 files changed, 59 insertions(+), 18 deletions(-)

-- 
2.43.0

