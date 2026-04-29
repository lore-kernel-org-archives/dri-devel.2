Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2538FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FB010E187;
	Wed, 29 Apr 2026 08:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bNLSywHu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6977810E187
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777452241; x=1808988241;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Snkz0u5fJFeAAMWLOz6zhVtfL6hFPp6sMRG2O+s0pkY=;
 b=bNLSywHucS2G0XEGXS6gbUkmg+GEUYGJpdpSoT3kP7g8XyNt2Cmpgvlx
 MJKkW2ow3jRl394n49j1w/pyC/X8K5nciBrWE0t1Qs0AsZVW8x9CDnOJ8
 iZFV5vFA8ccgjjkqguebQno7CXTB/JWaWaWI6FKv325yt2dJWNAWD20CP
 QlQKCxyJFpPL7iw/ZsC1a3v5NAk0Yb+RFrqPPEL0RatnZBH5KzOZDit6i
 s2mytW6pWi30fGt1/R/eAm87FKLnQrYu0kwh5ogaJp8y5M58FYKsW6EWw
 Dc3OJUbqu+aRL2P/1LZPqW39MDdQ3DqUtpY186y1kI4/UwCU+oVyjy6T2 A==;
X-CSE-ConnectionGUID: h4LjIuNBSmmiKn2I3FCzcQ==
X-CSE-MsgGUID: 7S7C4oCMRbeaBnYNDfJYpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77542181"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="77542181"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 01:44:01 -0700
X-CSE-ConnectionGUID: RTVr2HIARZKLsCItGG1sHQ==
X-CSE-MsgGUID: f9w8p0JkSky+e3kNDIkrpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="233341932"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 01:43:59 -0700
From: Maciej Falkowski <maciej.falkowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>
Subject: [PATCH] MAINTAINERS: accel/ivpu: Remove myself and add Andrzej as
 maintainer
Date: Wed, 29 Apr 2026 10:39:58 +0200
Message-ID: <20260429083958.2148777-1-maciej.falkowski@linux.intel.com>
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

As I will be departing from my current position, I will
no longer maintain the driver, and remove myself from
ivpu's maintainers entry. Andrzej will support Karol
in maintaining the driver.

Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74d114884b34..54b941d6e8b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7835,8 +7835,8 @@ F:	drivers/soc/ti/smartreflex.c
 F:	include/linux/power/smartreflex.h
 
 DRM ACCEL DRIVERS FOR INTEL VPU
-M:	Maciej Falkowski <maciej.falkowski@linux.intel.com>
 M:	Karol Wachowski <karol.wachowski@linux.intel.com>
+M:	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.43.0

