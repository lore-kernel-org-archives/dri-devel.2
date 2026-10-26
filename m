Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E6606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mpU1OtgL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B7510E97D;
	Mon, 26 Oct 2026 05:40:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABBF910E97E;
 Mon, 26 Oct 2026 05:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993241; x=1824529241;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dcu3ue2TOPrSPrZFCnpY0RTlvHnufOOHX6Fi36xXMfI=;
 b=mpU1OtgLi67eynFjuncEDtVcZe8twB5ZNVB0NSd7JxJZnb1VeNSsGfUJ
 B1euYWIQ8fq5zFquFRqQRG8J3LjBv+e7uFxLZ7FNPYQ/aOdi+s1v+XmUf
 6qvme262RjHQ3l6NN2XiGA68eF+autlPrIG7EyTc5qk9GqFIpE+yrf/XD
 P2ECFBpQOGUZ7XzOp8jvKZ5UEQj3CEl0t7LTt8QThyViPWDa9dFps7FxF
 /k1euO75kmoWoaaCd8jJLpLBSZixsyAYehylZntqZ80v6evpo49rGZFtW
 CpUdoTohATZW/TMiA9svuYQEbyq03ht4HIr81b1+XR0dZZbioAkLnPWzj A==;
X-CSE-ConnectionGUID: FWbO1JyLSzCA3OPQSXKvtQ==
X-CSE-MsgGUID: zLHB4qGuRG+m/pxAlw0hVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550198"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550198"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:41 -0700
X-CSE-ConnectionGUID: NgPD6tLBSy+mtRGxT/g4tg==
X-CSE-MsgGUID: VmEa+ootTeesNSBnYnpG6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001909"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:39 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 09/20] drm/i915/alpm: table based establishment period
Date: Mon, 26 Oct 2026 11:09:20 +0530
Message-ID: <20261026054001.799894-10-animesh.manna@intel.com>
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

With LTTPRs present, the establishment period calculated by the formula
is shorter than the values tabulated in the DP2.1 VESA spec by roughly
one LFPS period per LTTPR, even when max silence and LFPS periods are
used. This has been observed to cause flip done timeouts during ALPM
testing on a setup with LTTPRs.

Use the establishment period from the VESA spec table for the listed
link rates with 1 to 6 LTTPRs. Fall back to the calculated value for
link rates not in the table, LTTPR counts beyond the table and when no
LTTPR is present, where the formula already matches the spec.

v2: Add check for negative error codes from drm_dp_lttpr_count(). [sashiko]
v3:
- Explain why the spec table is used instead of the formula. [Jouni]
- Drop the no-LTTPR row as the formula matches the spec there.
- Drop link rates without tabulated values and replace the link rate
  enum and switch with a port_clock based lookup table.

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 43 ++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 0083752d94f0..2bf2ca956439 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -124,6 +124,42 @@ static int get_ml_phy_lock_len(const struct intel_crtc_state *crtc_state)
 	return intel_dp_is_uhbr(crtc_state) ? ML_PHY_LOCK_LEN_UHBR : ML_PHY_LOCK_LEN;
 }
 
+/*
+ * Establishment period in ns with LTTPRs, taken from the DP2.1 VESA spec.
+ * The spec values are computed with the max silence and LFPS periods and
+ * are longer than what the formula gives with LTTPRs present. Using the
+ * formula result has been seen to cause flip done timeouts, so prefer the
+ * spec values for the listed link rates.
+ */
+static const struct {
+	int port_clock;
+	int period[6];	/* indexed by LTTPR count - 1 */
+} lttpr_establishment_periods[] = {
+	{  162000, { 155670, 181160, 206650, 232140, 257620, 283110 } },	/* RBR */
+	{  270000, { 151310, 172450, 193580, 214710, 235850, 256980 } },	/* HBR */
+	{  540000, { 148050, 165910, 183780, 201650, 219510, 237380 } },	/* HBR2 */
+	{  810000, { 146960, 163740, 180510, 197290, 214070, 230850 } },	/* HBR3 */
+	{ 1000000, { 153650, 177120, 200590, 224060, 247530, 271000 } },	/* UHBR10 */
+	{ 1350000, { 151350, 172520, 193690, 214860, 236030, 257200 } },	/* UHBR13.5 */
+	{ 2000000, { 149220, 168220, 187290, 206320, 225360, 244390 } },	/* UHBR20 */
+};
+
+static int get_lttpr_establishment_period(int port_clock, int lttpr_count)
+{
+	int i;
+
+	if (lttpr_count < 1 ||
+	    lttpr_count > ARRAY_SIZE(lttpr_establishment_periods[0].period))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(lttpr_establishment_periods); i++) {
+		if (lttpr_establishment_periods[i].port_clock == port_clock)
+			return lttpr_establishment_periods[i].period[lttpr_count - 1];
+	}
+
+	return 0;
+}
+
 static int get_establishment_period(struct intel_dp *intel_dp,
 				    const struct intel_crtc_state *crtc_state)
 {
@@ -137,7 +173,7 @@ static int get_establishment_period(struct intel_dp *intel_dp,
 		intel_dp_link_symbol_size(crtc_state->port_clock) * 100000 /
 		crtc_state->port_clock;
 	int lttpr_count = 0;
-	int num_ml_phy_lock, tcds;
+	int num_ml_phy_lock, tcds, period;
 
 	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP)) {
 		num_ml_phy_lock = 7 + DIV_ROUND_UP(6500, tml_phy_lock) + 1;
@@ -155,6 +191,11 @@ static int get_establishment_period(struct intel_dp *intel_dp,
 
 	tcds = num_ml_phy_lock * tml_phy_lock;
 
+	period = get_lttpr_establishment_period(crtc_state->port_clock,
+						lttpr_count);
+	if (period)
+		return period;
+
 	if (lttpr_count > 0) {
 		/* tlw and tcs values are taken from DP2.1 spec */
 		int tlw = 13000;
-- 
2.43.0

