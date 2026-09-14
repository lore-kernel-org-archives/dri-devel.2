Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385F8C88E6A
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417F910E81A;
	Mon, 14 Sep 2026 08:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fPsusMSl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACC610E064;
 Mon, 14 Sep 2026 08:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789376312; x=1820912312;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JeE+tY6GYgFDHEhWkOf22mR2pY6MuJp9GJvQBuOjXVY=;
 b=fPsusMSlaIzL4h9eo20jG8CNf495zooHZn0ewGHbfR1oY7Lsm0p/gcT9
 nKOhH2GyHx1F5SnchHnjvM9E2fRb25xad3DFMhGbFF6Wx0+OcGhAebjAO
 cBm+XCb82v2oynlxKjwzoO1Luft+09530f+uSCHSXLYoMPwC02gpMo8y+
 8jJO7nLGsOSAdi9QZ3t+3FSknv5DvDdUcsv7RxN4XGFcYRsbumUrgRKWp
 kxH7xNrzTAyxDMS8za3/e4aHhnunOBH1w3veZ8DyUIQlRy6cj9aJI46Ra
 xgnrhOq9R76jpl/AtFVQnCqzEMswPArqZb0TWQZaRa41OL0uxt6q3VGi3 A==;
X-CSE-ConnectionGUID: yJO7+huBSYKwhEVZ7PMe/Q==
X-CSE-MsgGUID: eMuREW/zSvKX2mIs+IDVGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="88666086"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="88666086"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 01:58:31 -0700
X-CSE-ConnectionGUID: LubDt4NrTd2QnmaL1Po8yQ==
X-CSE-MsgGUID: AwT3oSrBQgW9yKJiisqIpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="276744495"
Received: from fred-panther-lake-client-platform.sh.intel.com
 ([10.239.144.217])
 by orviesa005.jf.intel.com with ESMTP; 14 Sep 2026 01:58:29 -0700
From: Fred Gao <fred.gao@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, ville.syrjala@linux.intel.com,
 Fred Gao <fred.gao@intel.com>, stable@vger.kernel.org,
 Chenchen Wang <chenchen.wang@intel.com>
Subject: [PATCH] drm/i915/panel: Only consider seamless DRRS modes as the
 highest mode
Date: Mon, 14 Sep 2026 16:55:25 +0800
Message-ID: <20260914085525.2669889-1-fred.gao@intel.com>
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

intel_dp_mode_clock() uses intel_panel_highest_mode() when seamless M/N
updates are supported, so that the link configuration can accommodate
every refresh rate DRRS may seamlessly switch to.

However, the fixed mode list is populated using is_alt_fixed_mode(),
which only requires a matching active size and non-sync flags. Whether a
mode can actually be reached with a seamless M/N update is decided by
intel_panel_downclock_mode() using is_alt_drrs_mode(), which requires
matching timings and flags. intel_panel_highest_mode() used neither and
simply picked the highest clock in the list. A mode reachable only with a
full modeset could therefore inflate the reserved bandwidth and
needlessly reduce the selected bpp.

On a 5120x2160 eDP panel the DisplayID preferred mode uses 717260 kHz,
while a CTA mode with different blanking uses 742500 kHz. With HBR2 x4,
2160000 kB/s is available. The preferred mode fits at 24 bpp:

  717260 * 24 / 8 = 2151780 kB/s

but the CTA mode does not:

  742500 * 24 / 8 = 2227500 kB/s

Selecting the CTA clock therefore reduces the link configuration to 18
bpp. The firmware state is 24 bpp, so the mismatch forces a full modeset
and an eDP backlight and panel power cycle during driver takeover.

Use is_alt_drrs_mode() so intel_panel_highest_mode() considers the same
set of modes as intel_panel_downclock_mode(). Bandwidth is still reserved
for genuine seamless DRRS alternatives, including when userspace selects
the downclock mode as the active mode, while modes that require a full
modeset no longer affect the result. If no fixed mode is compatible, the
helper continues to return the adjusted mode.

Fixes: e6f29923c048 ("drm/i915: Allow M/N change during fastset on bdw+")
Cc: <stable@vger.kernel.org>
Signed-off-by: Fred Gao <fred.gao@intel.com>
Reviewed-by: Chenchen Wang <chenchen.wang@intel.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 81e638d0c7b3..343bd8439566 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -192,7 +192,8 @@ intel_panel_highest_mode(struct intel_connector *connector,
 
-	/* pick the fixed_mode that has the highest clock */
+	/* pick the highest clock we can seamlessly switch to */
 	list_for_each_entry(fixed_mode, &connector->panel.fixed_modes, head) {
-		if (fixed_mode->clock > best_mode->clock)
+		if (is_alt_drrs_mode(fixed_mode, adjusted_mode) &&
+		    fixed_mode->clock > best_mode->clock)
 			best_mode = fixed_mode;
 	}
 
-- 
2.43.0
