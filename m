Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDF5105F7A5
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AFDE10E122;
	Fri, 13 Mar 2026 12:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AOhaCGMv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10AF10E11E;
 Fri, 13 Mar 2026 12:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773404530; x=1804940530;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=T0iCDYfgU+silQsMHGEo3zfmEzyL7MdvX4oQX72mOZs=;
 b=AOhaCGMvW6RnuTMMerslDziIUSCbInjN8yd3w6dr2IjEku4SXon8YaAp
 Zso+yAkzG0UHvbtPcHaEbX/9HgGNfIZnRrFBiR2l9cdgVARzsCkuuNEHb
 z78U2uo0TZaHiT/xtG5mXmjpC2mTcHOzuXmWQwpcX9g6dEEN9AIV3NEGC
 HSxISiwAUinUNHeHyJwCA4JGnVLNxpQ1aKqtRGFAjxorCvipqV11pSNYV
 qI9WXl1WZ5fWZ2PPzh8xoKtbllHmAnsUcBPM/iLjETH/CFfjWV7R30/Hq
 QvgvOpoAcRr16WNdzb2CMkRwKzx8/EkwPRvz9hzKxShly7AFCMOCiZ5Jb Q==;
X-CSE-ConnectionGUID: f3h+haCiQ+eP7YcXNrkOeA==
X-CSE-MsgGUID: AHxlt6zARlaF8TLNYJxBJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="77116938"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="77116938"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 05:22:09 -0700
X-CSE-ConnectionGUID: jBj7DviUTTegO0RserRrtA==
X-CSE-MsgGUID: ewTYIhCZQy6ASnAWByrsKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="225269243"
Received: from amilburn-desk.amilburn-desk (HELO jhogande-mobl3.intel.com)
 ([10.245.245.196])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 05:22:08 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Subject: [PATCH 0/2] Disable Panel Replay as quirk for LGD panel
Date: Fri, 13 Mar 2026 14:21:43 +0200
Message-ID: <20260313122145.1747175-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

We are currently observing problems with Panel Replay on setup having
LGD panel. Due to this disable Panel Replay if this specific panel is detected.

Jouni Högander (2):
  drm/dp: Add quirk to disable Panel Replay on certain panels
  drm/i915/psr: Disable Panel Replay on DP_DPCD_QUIRK_NO_PANEL_REPLAY
    quirk

 drivers/gpu/drm/display/drm_dp_helper.c  | 2 ++
 drivers/gpu/drm/i915/display/intel_psr.c | 6 ++++++
 include/drm/display/drm_dp_helper.h      | 8 ++++++++
 3 files changed, 16 insertions(+)

-- 
2.43.0

