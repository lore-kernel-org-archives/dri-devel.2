Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72E6C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F049110F0B1;
	Thu, 27 Aug 2026 14:34:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iKqNaw07";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A5F10F0AC;
 Thu, 27 Aug 2026 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787841298; x=1819377298;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jeIQwi3vo/oh0OcrQrlGyPLcum+wNWTr4UBVlayndm0=;
 b=iKqNaw07Czs1Femkiki4/gGxulULavPCqVmk5/+1mz7dltF5sVa5nuRe
 6UGOL/zqmSyrHgwY6pW+znYeSPicII4FtoseMmHUe5A0Dm07HX46xxXnc
 OKYSxh2MLHo5+AoJIqFSPFST7gFlE2PNQzLQaKq9Lxqkt6gykRwi8BhTq
 nfWtHkZQ5aIOb6j346EC0zdEOMk0Nr3n6PiXJrLVgQ4MjgD5k7dOaYhTH
 nYVME7UP1VPfv57P2bsSbc09uQf0aDSYnL02l5Sxp4ktl9R+FLewfUfjf
 hbCcP5qS2YwLLG2qe5EwCuaBpR6U1gerrPTaqhnVyz5rAmwvH3tptU9MT Q==;
X-CSE-ConnectionGUID: KOoh1i3fTOKSfoeTUQ+hgQ==
X-CSE-MsgGUID: KXrzjS2UQc2r4wZIO66Nvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98676895"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="98676895"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 07:34:58 -0700
X-CSE-ConnectionGUID: Z0gbXI98SISGcfOB9PTmxg==
X-CSE-MsgGUID: ak10zBoITpeuwtdSIC0w3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="266096464"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.244.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 07:34:54 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [PATCH v3 0/2] DRM device registration fixes
Date: Thu, 27 Aug 2026 16:34:45 +0200
Message-ID: <20260827143447.99553-1-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.55.0
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

This series contains patches pertaining the drm_dev_register() and
drm_dev_unregister() functions. Turns out drm_dev_register() doesn't
properly unwind its effects in the error path, causing confusion and
bugs.

Additionally, a related patch for i915 is bundled, as i915 mistakenly
calls drm_dev_unregister() in the error path triggered by failing
drm_dev_register(), which on one hand introduced a WARN_ON() in
drm_client_sysrq_unregister(), caused by calling it without a previous
_register() (as it was skipped in drm_dev_register()); but on the other
hand silenced yet another WARN_ON() later on in the error path in
drm_mode_config_cleanup(). With the other patch, the driver can just
handle the error from drm_dev_register() cleanly without calling
drm_dev_unregister(). This is explained in detail in both the patches.

v2 -> v3:
 - Reorder the patches (Sebastian, Andi)

Krzysztof Karas (1):
  drm: Unwind drm device registration upon error

Krzysztof Niemiec (1):
  drm/i915: Remove drm_dev_unregister() from the error path during
    i915_driver_register()

 drivers/gpu/drm/drm_drv.c          | 2 ++
 drivers/gpu/drm/i915/i915_driver.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.55.0

