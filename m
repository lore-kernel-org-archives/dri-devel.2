Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFADCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7201E10EC75;
	Mon, 12 Oct 2026 04:16:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 874A310EBCF;
 Mon, 12 Oct 2026 04:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778576; x=1823314576;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2+R+J2ktMDG6VwcJlZVZwaScU1p+cPczIosCU8hRNmU=;
 b=YyprwUDm9G6wC38/CPDUEuKxkAG3zwQQTbBnxP6XdqaWaSnCBrvIfCCx
 pZzYC3KNqFoEYJ7+nZI6QqsqZf0JMlIkDGqDuh8r2E5zIHNqW2nU2Y0Bf
 COIx5JqIkrtL3v7T6NkmXyShAS4uEa/gTC40OE0tFQMGE3znjrMp3n5c2
 QgDT97r+YMPuNcjWUv2ZB2+y6YD5jxZ0rHCp+jzXCdbpQnIX/VofmVG1z
 jfPvapAqm/Ufr2FbcRFcmYowkPbNRgOekrLon0rOGbIJQkNJmc80lUgaG
 gsL+TlYKETvfbCD/+ZO/0CBqccGzQPcztSDHtFSjj1EFpoHx34co/W7BX w==;
X-CSE-ConnectionGUID: OBK9wm4TRma8U2zRNoSODg==
X-CSE-MsgGUID: auuzuP0YQ/yrqosiAcjKow==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="366213"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="366213"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:16 -0700
X-CSE-ConnectionGUID: SYQXoI24TkCsoo1XH17/0A==
X-CSE-MsgGUID: KXPzA63IQnyM6OVXDGNSnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256811"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:14 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 53/56] drm/i915/joiner: Move joiner pipe mask helper to
 intel_joiner.c
Date: Mon, 12 Oct 2026 09:28:02 +0530
Message-ID: <20261012035806.3361439-54-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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

intel_joiner_valid_primary_pipe_mask() implements joiner-specific
pipe validation logic and is only used by the joiner code.

Move the helper, along with find_consecutive_bits() dependency, from
intel_display.c to intel_joiner.c to keep joiner-related functionality
grouped together.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 47 --------------------
 drivers/gpu/drm/i915/display/intel_joiner.c  | 47 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_joiner.h  |  2 +
 3 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index f9233b5f5b6a..ea41432a86b7 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -192,53 +192,6 @@ is_trans_port_sync_mode(const struct intel_crtc_state *crtc_state)
 		is_trans_port_sync_slave(crtc_state);
 }
 
-/*
- * Return a bitmask of all the start indices of consecutive bitfields of size
- * width in mask.
- */
-static unsigned long find_consecutive_bits(unsigned long mask, int width)
-{
-	unsigned long bit, out_mask = 0;
-
-	if (!width)
-		return 0;
-
-	for_each_set_bit(bit, &mask, BITS_PER_TYPE(mask)) {
-		/* For each set bit, see if the following bits are set also */
-		unsigned long bitfield = GENMASK(bit + width - 1, bit);
-
-		if ((mask & bitfield) == bitfield)
-			out_mask |= BIT(bit);
-	}
-
-	return out_mask;
-}
-
-/*
- * Return a bitmask of all valid joiner primary pipes for joining
- * num_joined_pipes pipes. For completeness, return all valid pipes for
- * num_joined_pipes == 1.
- *
- * Return 0 if the platform doesn't support joining for the requested number of
- * pipes, or there are not enough consecutive pipes available.
- */
-u8 intel_joiner_valid_primary_pipe_mask(struct intel_display *display, int num_joined_pipes)
-{
-	if (num_joined_pipes == 1) {
-		return DISPLAY_RUNTIME_INFO(display)->pipe_mask;
-	} else if (num_joined_pipes == 2) {
-		if (!HAS_UNCOMPRESSED_JOINER(display) && !HAS_BIGJOINER(display))
-			return 0;
-	} else if (num_joined_pipes == 4) {
-		if (!HAS_ULTRAJOINER(display))
-			return 0;
-	} else {
-		return 0;
-	}
-
-	return find_consecutive_bits(DISPLAY_RUNTIME_INFO(display)->pipe_mask, num_joined_pipes);
-}
-
 static enum pipe joiner_primary_pipe(const struct intel_crtc_state *crtc_state)
 {
 	return ffs(crtc_state->joiner_pipes) - 1;
diff --git a/drivers/gpu/drm/i915/display/intel_joiner.c b/drivers/gpu/drm/i915/display/intel_joiner.c
index 4c50f226199d..9dfe855f5668 100644
--- a/drivers/gpu/drm/i915/display/intel_joiner.c
+++ b/drivers/gpu/drm/i915/display/intel_joiner.c
@@ -55,3 +55,50 @@ bool intel_joiner_candidate_valid(struct intel_connector *connector,
 
 	return intel_joiner_valid_primary_pipe_mask(display, num_joined_pipes);
 }
+
+/*
+ * Return a bitmask of all the start indices of consecutive bitfields of size
+ * width in mask.
+ */
+static unsigned long find_consecutive_bits(unsigned long mask, int width)
+{
+	unsigned long bit, out_mask = 0;
+
+	if (!width)
+		return 0;
+
+	for_each_set_bit(bit, &mask, BITS_PER_TYPE(mask)) {
+		/* For each set bit, see if the following bits are set also */
+		unsigned long bitfield = GENMASK(bit + width - 1, bit);
+
+		if ((mask & bitfield) == bitfield)
+			out_mask |= BIT(bit);
+	}
+
+	return out_mask;
+}
+
+/*
+ * Return a bitmask of all valid joiner primary pipes for joining
+ * num_joined_pipes pipes. For completeness, return all valid pipes for
+ * num_joined_pipes == 1.
+ *
+ * Return 0 if the platform doesn't support joining for the requested number of
+ * pipes, or there are not enough consecutive pipes available.
+ */
+u8 intel_joiner_valid_primary_pipe_mask(struct intel_display *display, int num_joined_pipes)
+{
+	if (num_joined_pipes == 1) {
+		return DISPLAY_RUNTIME_INFO(display)->pipe_mask;
+	} else if (num_joined_pipes == 2) {
+		if (!HAS_UNCOMPRESSED_JOINER(display) && !HAS_BIGJOINER(display))
+			return 0;
+	} else if (num_joined_pipes == 4) {
+		if (!HAS_ULTRAJOINER(display))
+			return 0;
+	} else {
+		return 0;
+	}
+
+	return find_consecutive_bits(DISPLAY_RUNTIME_INFO(display)->pipe_mask, num_joined_pipes);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_joiner.h b/drivers/gpu/drm/i915/display/intel_joiner.h
index 85e19ed1527f..962b9724c112 100644
--- a/drivers/gpu/drm/i915/display/intel_joiner.h
+++ b/drivers/gpu/drm/i915/display/intel_joiner.h
@@ -22,4 +22,6 @@ bool intel_joiner_candidate_valid(struct intel_connector *connector,
 	for ((__num_joined_pipes) = 1; (__num_joined_pipes) <= (I915_MAX_PIPES); (__num_joined_pipes)++) \
 		for_each_if(intel_joiner_candidate_valid(__connector, (__mode)->hdisplay, __num_joined_pipes))
 
+u8 intel_joiner_valid_primary_pipe_mask(struct intel_display *display, int num_joined_pipes);
+
 #endif /* __INTEL_JOINER_H__ */
-- 
2.50.1

