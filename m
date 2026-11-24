Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16710606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jl8Lk34C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DCF10F8AE;
	Tue, 24 Nov 2026 22:46:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A229310F853;
 Tue, 24 Nov 2026 22:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795560396; x=1827096396;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xZmrXdyyLCCv7KGAFdegMRqXrIEZwrhHLBWmQ4aTIY0=;
 b=Jl8Lk34CDuT6tNXA1qQoGne2bRtPCwnfhUb7jKF4x+hsib7je3GqP+op
 1kYbgWfuAuv4+eZAEKeyAFvxW4zThsjPhyatJKKldFOAiTCBPWppjTPK7
 Zl8PCLAGj1x1gmPG+VewnE4xtFIMmFrr17GOQfoAFCx6t33d/4zXi9Ap0
 ggDrGLGnrgUNvcTf5looA3LRE/Nq86UIhnVo4jXwxemVv/qAnQIP0V5fT
 wAMlp6XmEZ8cbexe7TqxcYSZS7HQkClXsC7pgiulHRK3nz5viIsx33Vo3
 ame3/NArJYfBUTT8GLV5OjhPXau39Vt9qEQ8XgIMY8Zaf48nvQNVkxrX9 g==;
X-CSE-ConnectionGUID: WF5TfBc4QCGYlGbqkWh5Gg==
X-CSE-MsgGUID: FJPu8roFRISYGePyzREVpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4396177"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4396177"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 14:46:35 -0800
X-CSE-ConnectionGUID: 12/icIvbQJehWThwQQeP1Q==
X-CSE-MsgGUID: lwJ2g6zRTZiBMtPhVda3OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11484754"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.204])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 14:46:33 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 2/2] drm/i915/bios: Attempt to match the VBT PnP ID against
 DisplayID first
Date: Wed, 25 Nov 2026 00:46:21 +0200
Message-ID: <20261124224621.6506-3-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
References: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The Windows driver policy appears to be now to first match the
VBT PnP ID against the DisplayID product ID block, and only if
there is no match (not even a partial one) then attempt to
match the against the EDID base block vendor/product ID.
Implement the same policy.

We also need to implement the same weird scheme of just smashing
the first two bytes of the DisplayID three byte OUI into the
old EISA/PNPID field of the EDID defined structure. That is
then matched against the similar old EDID style structures in
the VBT.

Smoke tested with a firmware override of EDID and VBT:
 [drm:get_panel_type [xe]] Panel type (VBT): 255
 [drm:pnpid_get_panel_type [xe]] DisplayID manufacturer name: NRA, product code: 16826, serial number: 0, year of manufacture: 2014
 [drm:pnpid_get_panel_type [xe]] DisplayID raw product id: ba 41 ba 41 00 00 00 00 00 18
 [drm:get_panel_type [xe]] Panel type (PNPID DisplayID): 3
 [drm:pnpid_get_panel_type [xe]] EDID manufacturer name: SDC, product code: 16826, serial number: 65441, year of manufacture: 2024
 [drm:pnpid_get_panel_type [xe]] EDID raw product id: 4c 83 ba 41 a1 ff 00 00 00 22
 [drm:get_panel_type [xe]] Panel type (fallback): 0
 [drm:get_panel_type [xe]] Selected panel type (PNPID DisplayID): 3

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8969
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_bios.c | 81 ++++++++++++++++++-----
 1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index b77d1599482a..5b0fc87e7673 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -684,27 +684,22 @@ static int vbt_get_panel_type(struct intel_display *display,
 }
 
 static int pnpid_get_panel_type(struct intel_display *display,
-				const struct intel_bios_encoder_data *devdata,
-				const struct drm_edid *drm_edid, bool use_fallback)
+				const struct drm_edid_product_id *product_id,
+				const char *source)
 {
 	const struct bdb_lfp_data *data;
 	const struct bdb_lfp_data_ptrs *ptrs;
-	struct drm_edid_product_id product_id, product_id_nodate;
+	struct drm_edid_product_id product_id_nodate;
 	struct drm_printer p;
 	int i, best = -1;
 
-	if (!drm_edid)
-		return -1;
+	p = drm_dbg_printer(display->drm, DRM_UT_KMS, source);
+	drm_edid_print_product_id(&p, product_id, true);
 
-	drm_edid_get_product_id(drm_edid, &product_id);
-
-	product_id_nodate = product_id;
+	product_id_nodate = *product_id;
 	product_id_nodate.week_of_manufacture = 0;
 	product_id_nodate.year_of_manufacture = 0;
 
-	p = drm_dbg_printer(display->drm, DRM_UT_KMS, "EDID");
-	drm_edid_print_product_id(&p, &product_id, true);
-
 	ptrs = bdb_find_section(display, BDB_LFP_DATA_PTRS);
 	if (!ptrs)
 		return -1;
@@ -718,7 +713,7 @@ static int pnpid_get_panel_type(struct intel_display *display,
 			get_lfp_pnp_id(data, ptrs, i);
 
 		/* full match? */
-		if (!memcmp(vbt_id, &product_id, sizeof(*vbt_id)))
+		if (!memcmp(vbt_id, product_id, sizeof(*vbt_id)))
 			return i;
 
 		/*
@@ -733,6 +728,48 @@ static int pnpid_get_panel_type(struct intel_display *display,
 	return best;
 }
 
+static int pnpid_edid_get_panel_type(struct intel_display *display,
+				     const struct intel_bios_encoder_data *devdata,
+				     const struct drm_edid *drm_edid, bool use_fallback)
+{
+	struct drm_edid_product_id product_id;
+
+	if (!drm_edid)
+		return -1;
+
+	drm_edid_get_product_id(drm_edid, &product_id);
+
+	return pnpid_get_panel_type(display, &product_id, "EDID");
+}
+
+static int pnpid_displayid_get_panel_type(struct intel_display *display,
+					  const struct intel_bios_encoder_data *devdata,
+					  const struct drm_edid *drm_edid, bool use_fallback)
+{
+	struct drm_displayid_product_id displayid_id;
+	struct drm_edid_product_id product_id;
+
+	if (!drm_edid)
+		return -1;
+
+	drm_displayid_get_product_id(drm_edid, &displayid_id);
+
+	/*
+	 * Only the first two bytes of the OUI get
+	 * smashed into the old EISA/PNPID field, and
+	 * that gets matched against what's in the VBT.
+	 */
+	product_id.manufacturer_name =
+		cpu_to_be16((displayid_id.vendor_id[0] << 8) |
+			    displayid_id.vendor_id[1]);
+	product_id.product_code = displayid_id.product_code;
+	product_id.serial_number = displayid_id.serial_number;
+	product_id.week_of_manufacture = displayid_id.week_of_manufacture;
+	product_id.year_of_manufacture = displayid_id.year_of_manufacture;
+
+	return pnpid_get_panel_type(display, &product_id, "DisplayID");
+}
+
 static int fallback_get_panel_type(struct intel_display *display,
 				   const struct intel_bios_encoder_data *devdata,
 				   const struct drm_edid *drm_edid, bool use_fallback)
@@ -743,7 +780,8 @@ static int fallback_get_panel_type(struct intel_display *display,
 enum panel_type {
 	PANEL_TYPE_OPREGION,
 	PANEL_TYPE_VBT,
-	PANEL_TYPE_PNPID,
+	PANEL_TYPE_PNPID_DISPLAYID,
+	PANEL_TYPE_PNPID_EDID,
 	PANEL_TYPE_FALLBACK,
 };
 
@@ -766,9 +804,13 @@ static int get_panel_type(struct intel_display *display,
 			.name = "VBT",
 			.get_panel_type = vbt_get_panel_type,
 		},
-		[PANEL_TYPE_PNPID] = {
-			.name = "PNPID",
-			.get_panel_type = pnpid_get_panel_type,
+		[PANEL_TYPE_PNPID_DISPLAYID] = {
+			.name = "PNPID DisplayID",
+			.get_panel_type = pnpid_displayid_get_panel_type,
+		},
+		[PANEL_TYPE_PNPID_EDID] = {
+			.name = "PNPID EDID",
+			.get_panel_type = pnpid_edid_get_panel_type,
 		},
 		[PANEL_TYPE_FALLBACK] = {
 			.name = "fallback",
@@ -792,8 +834,11 @@ static int get_panel_type(struct intel_display *display,
 	if (is_panel_type_valid(panel_types[PANEL_TYPE_OPREGION].panel_type))
 		i = PANEL_TYPE_OPREGION;
 	else if (is_panel_type_pnp(panel_types[PANEL_TYPE_VBT].panel_type) &&
-		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID].panel_type))
-		i = PANEL_TYPE_PNPID;
+		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID_DISPLAYID].panel_type))
+		i = PANEL_TYPE_PNPID_DISPLAYID;
+	else if (is_panel_type_pnp(panel_types[PANEL_TYPE_VBT].panel_type) &&
+		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID_EDID].panel_type))
+		i = PANEL_TYPE_PNPID_EDID;
 	else if (is_panel_type_valid(panel_types[PANEL_TYPE_VBT].panel_type))
 		i = PANEL_TYPE_VBT;
 	else
-- 
2.56.1

