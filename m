Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FDDC982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B29D810EA21;
	Tue, 15 Sep 2026 18:39:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E8RDZDXF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0024610ED1B;
 Tue, 15 Sep 2026 18:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497552; x=1821033552;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1b5sJlIEsP5cpWte9amnQP/pRG4Y/xs1e3IHUiZZeDw=;
 b=E8RDZDXFPaaRxeYZJRo6Qz9MhzTapXVGbrsZ61f4AWW1mgGLjQiwJYXV
 GzO/DbQBO4xtsZDsOq5Rpbt0NZuNcNVNoSpnTN0ArT9WsagSr22nkoj45
 712uS2dbqDtpP05A7ikBrh8hk8swojPmZqBRYHtkKsLBQJSB2I1jqczK8
 UeQw9nPD8G2WuW0aan2vPaQKx+wMcHkTDG9Q9+FXqg3DC2VUqWYsovEJO
 4qL2FRe5YWutxy8N+nH7FULw5KF+wW2Vb1VVo7TZFB+y/4gSwxkVk+8hb
 WN9aGGZTpZbAzPoRKXRyoZwFrzztTWz9KxFeP1fUgbxndQ9MRqX4t5WVi g==;
X-CSE-ConnectionGUID: guueRx4eRQ60IDIMyWulIw==
X-CSE-MsgGUID: 7I5NUc9QRYqw/Kcwv1PZ8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380281"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380281"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:12 -0700
X-CSE-ConnectionGUID: EsY34LaqQbKk8QjCdVdG0Q==
X-CSE-MsgGUID: MzzUlEewSc6eKiKu9i67ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148476"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:10 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 05/18] drm/i915/alpm: Refactor Auxless wake time calculation
Date: Tue, 15 Sep 2026 23:34:36 +0530
Message-Id: <20260915180449.277933-6-animesh.manna@intel.com>
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

Divide the auxless wake time calculation in parts which will
help later to add Xe3p related modification.

v2: Refactor first existing calculation. [Jani]
v3: Cosmetic changes. [Jani, Suraj]

Bspec: 71477
Cc: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 31 ++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 901493bb1448..d5823174576a 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -102,6 +102,25 @@ static int get_lfps_half_cycle_clocks(const struct intel_crtc_state *crtc_state)
 		1000 / (2 * LFPS_CYCLE_COUNT);
 }
 
+static int get_tphy2_p2_to_p0(const struct intel_crtc_state *crtc_state)
+{
+	return 12 * 1000;
+}
+
+static int get_establishment_period(const struct intel_crtc_state *crtc_state)
+{
+	int t1 = 50 * 1000;
+	int tps4 = 252;
+	/* port_clock is link rate in 10kbit/s units */
+	int tml_phy_lock = 1000 * 1000 * tps4 / crtc_state->port_clock;
+	int tcds, establishment_period;
+
+	tcds = (7 + DIV_ROUND_UP(6500, tml_phy_lock) + 1) * tml_phy_lock;
+	establishment_period = (SILENCE_PERIOD_TIME + t1 + tcds);
+
+	return establishment_period;
+}
+
 /*
  * AUX-Less Wake Time = CEILING( ((PHY P2 to P0) + tLFPS_Period, Max+
  * tSilence, Max+ tPHY Establishment + tCDS) / tline)
@@ -123,17 +142,11 @@ static int get_lfps_half_cycle_clocks(const struct intel_crtc_state *crtc_state)
  */
 static int _lnl_compute_aux_less_wake_time(const struct intel_crtc_state *crtc_state)
 {
-	int tphy2_p2_to_p0 = 12 * 1000;
-	int t1 = 50 * 1000;
-	int tps4 = 252;
-	/* port_clock is link rate in 10kbit/s units */
-	int tml_phy_lock = 1000 * 1000 * tps4 / crtc_state->port_clock;
-	int num_ml_phy_lock = 7 + DIV_ROUND_UP(6500, tml_phy_lock) + 1;
-	int t2 = num_ml_phy_lock * tml_phy_lock;
-	int tcds = 1 * t2;
+	int tphy2_p2_to_p0 = get_tphy2_p2_to_p0(crtc_state);
+	int establishment_period = get_establishment_period(crtc_state);
 
 	return DIV_ROUND_UP(tphy2_p2_to_p0 + get_lfps_cycle_time(crtc_state) +
-			    SILENCE_PERIOD_TIME + t1 + tcds, 1000);
+			    establishment_period, 1000);
 }
 
 static int
-- 
2.29.0

