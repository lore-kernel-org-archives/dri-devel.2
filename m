Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF9606A322
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=neyCiyvS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E581C1127A2;
	Fri, 30 Oct 2026 12:03:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFEBF10E115;
 Fri, 30 Oct 2026 12:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361829; x=1824897829;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HfZKicBOEOn0BLukdKrxbtb4WfU0ufduiMTqDDNg2X0=;
 b=neyCiyvSOeSbA7J4B1rC7i3pyxjOSi0QofBP5pqe71t7kigXYfBCYzGh
 adO8orw7PyzrHKhH06cZL1fLU1N1PeMKsC3jD9+x0jFiBXMhIKYP4XKwB
 ie3XDEmsJmMyZl5NLZLZgxfks/1DMrOvQwtBegH/fVpwHbjc7V4RxbhHP
 vpq04k1HPhShpjnheBzw+mOJ2e3pEfGXIWe+t++DJI99yCNwt+kbuCS1M
 sddOehMK2YNDwn2ZMjY1ySG9gRJEIpYBRa8EOkEy4Ye3PN+mnl1AEETQ5
 z5acTXNVBfTlSrl4JluIPlVpO2tGksQaQWOAA+/jRNDH4m1pvQZIG5KV3 A==;
X-CSE-ConnectionGUID: 9yj383DUQT2cKoQmeUjpQQ==
X-CSE-MsgGUID: T4a1k/qCTTKmrhjy8d129A==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2226506"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2226506"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:49 -0700
X-CSE-ConnectionGUID: zhcSclTDSZuuwX5qtqEi+A==
X-CSE-MsgGUID: J0Mxq7EMQP6cVAVBq7tZeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7211061"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:47 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 07/13] drm/i915/debugfs: pass struct drm_printer to
 intel_encoder_info()
Date: Fri, 30 Oct 2026 14:03:10 +0200
Message-ID: <dc08bd773021e6859e2b49de034e9406f3ce4631.1793361738.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793361738.git.jani.nikula@intel.com>
References: <cover.1793361738.git.jani.nikula@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass struct drm_printer to intel_encoder_info(). While at it, drop
unused crtc parameter.

Prefer struct drm_printer * over struct seq_file * to unify and allow
use of drm_printer helpers.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_debugfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 7de84ac4323d..075f29c241d1 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -176,15 +176,14 @@ static void intel_seq_print_mode(struct seq_file *m, int tabs,
 	seq_printf(m, DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
 }
 
-static void intel_encoder_info(struct seq_file *m,
-			       struct intel_crtc *crtc,
+static void intel_encoder_info(struct drm_printer *p,
 			       struct intel_encoder *encoder)
 {
-	struct intel_display *display = node_to_intel_display(m->private);
+	struct intel_display *display = to_intel_display(encoder);
 	struct drm_connector_list_iter conn_iter;
 	struct drm_connector *connector;
 
-	seq_printf(m, "\t[ENCODER:%d:%s]: connectors:\n",
+	drm_printf(p, "\t[ENCODER:%d:%s]: connectors:\n",
 		   encoder->base.base.id, encoder->base.name);
 
 	drm_connector_list_iter_begin(display->drm, &conn_iter);
@@ -195,7 +194,7 @@ static void intel_encoder_info(struct seq_file *m,
 		if (conn_state->best_encoder != &encoder->base)
 			continue;
 
-		seq_printf(m, "\t\t[CONNECTOR:%d:%s]\n",
+		drm_printf(p, "\t\t[CONNECTOR:%d:%s]\n",
 			   connector->base.id, connector->name);
 	}
 	drm_connector_list_iter_end(&conn_iter);
@@ -594,7 +593,7 @@ static void intel_crtc_info(struct seq_file *m, struct intel_crtc *crtc)
 
 	for_each_intel_encoder_mask(display->drm, encoder,
 				    crtc_state->uapi.encoder_mask)
-		intel_encoder_info(m, crtc, encoder);
+		intel_encoder_info(&p, encoder);
 
 	intel_plane_info(&p, crtc);
 
-- 
2.47.3

