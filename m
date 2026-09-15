Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2B4C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025E410E42A;
	Tue, 15 Sep 2026 18:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k3DA4eu8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B307910E411;
 Tue, 15 Sep 2026 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497589; x=1821033589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xc1y0j/KrAS+5KaTgkfLHpBXz0PfUzFAfcP+CfVH00E=;
 b=k3DA4eu8HrrzVD63f5jPYf0c5/SOSK7ShBhNyfLm2HkpNqL5bJPVxowQ
 EqT+/PLXC6RYe0PXV1vAH0Hy+swv0tRoNrkkH/0Bu8DQZ1CvYAlKYIPWm
 Fs16IAkgatIJ9o3fp70cxaA6TvYvvqrfqFQP9gCou+vHIqR2WfqkVpWUh
 OEiCIwgJm1IeIfEFhybBf9DFmoEu/6deyfczAyS56rSOwe26V6kWZ0iYC
 1ji+0b6nKbn2z/eaOCwDK3Dwtz8+612APzayQRNouolN9mhVaqUVbFJEb
 L+2u1n0Nz5K/eTdIb48JQ3Q2ffzdJmeMe/X6Q7U59BpqHQUhxJhjX/R9x Q==;
X-CSE-ConnectionGUID: yZNqFfOARMqswSyzWWkFaA==
X-CSE-MsgGUID: V8KqM2F/R6a081c5COjWzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380368"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380368"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:48 -0700
X-CSE-ConnectionGUID: cgqc4EH5RzKF74WRyKsDtQ==
X-CSE-MsgGUID: T7aTO98cQFOFIwZFLc40EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148599"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:46 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 17/18] drm/i915/alpm: Program zero-based LFPS half cycle
 duration
Date: Tue, 15 Sep 2026 23:34:48 +0530
Message-Id: <20260915180449.277933-18-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260915180449.277933-1-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The LFPS Half Cycle Duration field, as well as the First and Last LFPS
Half Cycle Duration fields, in PORT_ALPM_LFPS_CTL are zero-based: per
Bspec the value programmed must be N_Symbol - 1. The number of symbols
was programmed directly, making each half cycle one symbol clock too
long.

Subtract one in the PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION,
PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION and
PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION field macros so the
programmed value matches the zero-based field encoding.

Bspec: 71632
Cc: Jouni Högander <jouni.hogander@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr_regs.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/drm/i915/display/intel_psr_regs.h
index 8f60b671755a..387edf8df6e9 100644
--- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
@@ -339,11 +339,17 @@
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN		7
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(val)		REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK, (val) - PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN)
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_XE3LPD(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK_XE3LPD, (val) - PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN)
+/*
+ * The LFPS half cycle duration fields (including the first and last half
+ * cycle) are zero-based, i.e. the value programmed is N_Symbol - 1.
+ *
+ * Bspec: 71632
+ */
 #define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(20, 16)
-#define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK, val)
+#define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK, (val) - 1)
 #define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(12, 8)
-#define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK, val)
+#define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK, (val) - 1)
 #define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(4, 0)
-#define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK, val)
+#define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK, (val) - 1)
 
 #endif /* __INTEL_PSR_REGS_H__ */
-- 
2.29.0

