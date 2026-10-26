Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C5606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iGIUSRp7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE4010E97B;
	Mon, 26 Oct 2026 05:40:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8239610E96D;
 Mon, 26 Oct 2026 05:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993232; x=1824529232;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xr9lLmSR0vgQU5s8NAeJ2XZV+2VuvKAoSiqpMVF5Ops=;
 b=iGIUSRp7okWooeqWz19/D1TPN3dH3NwVBAq9jdWAsWDWV7tijJ7sCc95
 QmzXzJndXcDzA8wYWzkxlGSp8yeO8xr1fXHAAXAgNo1Xugsy6AR52MD91
 T6SiDtFqEz0ANduzVheG5ALisosT64XQvLO3dOl+O+AFqalFH1RfCog4R
 IHuNJgDZIBPWta3LV2mA0FN8hQDSPN8cbJmkW9FpiwJAt+pSmdt+d8GpK
 NoK7+K/dUgfZF0tuhxsyRN7UIDFc8uz+i689qqP0xjyt5jsYQpk6FGwZf
 Ht/0ndG4TPBf0s9363rgCX2J9h+Yrgx/qAJ5eUgiOTaIklZVqeDfRsUh3 g==;
X-CSE-ConnectionGUID: k/c8d6pBR/CZp4Tup4bDKA==
X-CSE-MsgGUID: h7+6ddeUTCq7jzVpzwePCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550189"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550189"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:32 -0700
X-CSE-ConnectionGUID: 4i4nfh5pRx+5/MiYCk+Adw==
X-CSE-MsgGUID: ssyieCiNTrmYNNTo99mALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001864"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:30 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 06/20] drm/i915/alpm: Refactor Auxless wake time calculation
Date: Mon, 26 Oct 2026 11:09:17 +0530
Message-ID: <20261026054001.799894-7-animesh.manna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026054001.799894-1-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Divide the auxless wake time calculation in parts which will
help later to add Xe3p related modification.

v2: Refactor first existing calculation. [Jani]
v3: Cosmetic changes. [Jani, Suraj]
v4: Keep num_ml_phy_lock for readability and return the
    establishment period directly. [Jouni]

Bspec: 71477
Cc: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 31 ++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 12dc79198494..ab6612b4506e 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -109,6 +109,25 @@ static int get_lfps_half_cycle_clocks(const struct intel_crtc_state *crtc_state)
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
+	int num_ml_phy_lock, tcds;
+
+	num_ml_phy_lock = 7 + DIV_ROUND_UP(6500, tml_phy_lock) + 1;
+	tcds = num_ml_phy_lock * tml_phy_lock;
+
+	return SILENCE_PERIOD_TIME + t1 + tcds;
+}
+
 /*
  * AUX-Less Wake Time = CEILING( ((PHY P2 to P0) + tLFPS_Period, Max+
  * tSilence, Max+ tPHY Establishment + tCDS) / tline)
@@ -130,17 +149,11 @@ static int get_lfps_half_cycle_clocks(const struct intel_crtc_state *crtc_state)
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
2.43.0

