Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332C710F3DCD
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 473F310E6CA;
	Mon, 30 Mar 2026 14:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DPrPaunh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B2F10E678;
 Mon, 30 Mar 2026 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774879595; x=1806415595;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LFj2e2KhIL9KBHqjSMGZFHwUjEkXICi74OMAEgaXoWY=;
 b=DPrPaunhjQKQqFjIBbadOKIFObmRsNqRDJ4O+3ggOgC8rtAOSR1uFgZ3
 Dg6uSSuhjRMoNhMRsVVWn2TnoxLa+q++pO4WT3zsdfSjXhjkCMy11rpMw
 YA/bUyV3lq2s5h3Cm3BT3PD1NTXyL4VsUxhVdVUJk7aZ2qQ0dyBlpooPH
 n1TpqXypiug77nLdLo67M8ZCKih9OZa9OhQAqXbZhLaxM5kKJY7rG3iNo
 eiGY776yWQ//lOpZtWHLDt+m7IJrgcOIMmUaUhPj6+sEX7twXc4jcIG4P
 3G0ptWuGW0c9XI/MHqpLHTIRhK0SNMHKIimSAPHiRsB5yhIPA0NR7hL09 Q==;
X-CSE-ConnectionGUID: JTOGis7HQzyXIJKRlG+jYA==
X-CSE-MsgGUID: jVQUXldbQUOmxg+yS7CNxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79474782"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="79474782"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:06:35 -0700
X-CSE-ConnectionGUID: B41ZagmrRVqFyIXrTDZbhQ==
X-CSE-MsgGUID: bKJfUU7eSz2XHa4iFv3L5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="249271512"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.223.74.76])
 by fmviesa001.fm.intel.com with ESMTP; 30 Mar 2026 07:06:32 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v10 0/3] Panel Replay BW optimization
Date: Mon, 30 Mar 2026 19:06:17 +0530
Message-Id: <20260330133620.3750559-1-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
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

Unused bandwidth can be used by external display agents for Panel Replay
enabled DP panel during idleness with link on. This patch series
enabling the same.

Signed-off-by: Animesh Manna <animesh.manna@intel.com>

Animesh Manna (3):
  drm/display: Add drm helper to check pr optimization support
  drm/i915/display: Add hook to check optimization support for Intel
    platforms
  drm/i915/display: Panel Replay BW optimization for DP2.0 tunneling

 drivers/gpu/drm/display/drm_dp_tunnel.c       | 17 +++++++++++++
 .../gpu/drm/i915/display/intel_display_regs.h |  1 +
 .../gpu/drm/i915/display/intel_dp_tunnel.c    | 18 +++++++++++++
 .../gpu/drm/i915/display/intel_dp_tunnel.h    |  6 +++++
 drivers/gpu/drm/i915/display/intel_psr.c      | 25 +++++++++++++++++--
 include/drm/display/drm_dp_tunnel.h           |  6 +++++
 6 files changed, 71 insertions(+), 2 deletions(-)

-- 
2.29.0

