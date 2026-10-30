Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B4606A322
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f4d/vnuZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA1D1127A1;
	Fri, 30 Oct 2026 12:03:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16D01127A1;
 Fri, 30 Oct 2026 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361825; x=1824897825;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gNv4PCPJ9VybhqfVmLXdXpMwPpyY+zQNoO/Dc5a7UaQ=;
 b=f4d/vnuZyk0i6Bi0R0UpQbgUEK7uJwBXKxd5NtMaUXEDWpG7HSP1UF4g
 kHZ04VYN24Z8cZsPJFsvknArNlMkfqchZF5ydyES53w1abp+50oE6DczU
 O0eOS6FBy/BXm/dFc3Ehr5LKop8HL/WT7S359766jc06wGfB+RmxzNQ/i
 4MmWrrDKC/7lje8CZi2OR16B/HKVo3IUBKd+iGpGl6u8iS94T/oWJIgdg
 m2u+3Rh2D870DjoA2Qk5YNVJZ3dDsRsIQK0IWZkhFybxQf6iVz4VKTiYq
 i6B6UFjudvw3/HaJHYl3/+1Jb/Hsnu86U1AHZ3EABtuzcxiQ93eGxeovz g==;
X-CSE-ConnectionGUID: eBwhOGluTcmqj3XTUZIrNg==
X-CSE-MsgGUID: ltc+5Uf3TmyBvMj+QRCLhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2226502"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2226502"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:45 -0700
X-CSE-ConnectionGUID: Ir2K0uH8QHKCZ5xImJ3aBQ==
X-CSE-MsgGUID: 27C8haaYQzqk51YKjUcVxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7211055"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:43 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 06/13] drm/i915/debugfs: pass struct drm_printer to
 intel_scaler_info()
Date: Fri, 30 Oct 2026 14:03:09 +0200
Message-ID: <e1ce8bb290e2498f1b57c97b9250056ff858d9e9.1793361738.git.jani.nikula@intel.com>
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

Pass struct drm_printer to intel_scaler_info().

Prefer struct drm_printer * over struct seq_file * to unify and allow
use of drm_printer helpers.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_debugfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index da70047f1449..7de84ac4323d 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -412,7 +412,7 @@ static void intel_plane_info(struct drm_printer *p, struct intel_crtc *crtc)
 	}
 }
 
-static void intel_scaler_info(struct seq_file *m, struct intel_crtc *crtc)
+static void intel_scaler_info(struct drm_printer *p, struct intel_crtc *crtc)
 {
 	const struct intel_crtc_state *crtc_state =
 		to_intel_crtc_state(crtc->base.state);
@@ -421,7 +421,7 @@ static void intel_scaler_info(struct seq_file *m, struct intel_crtc *crtc)
 
 	/* Not all platforms have a scaler */
 	if (num_scalers) {
-		seq_printf(m, "\tnum_scalers=%d, scaler_users=%x scaler_id=%d scaling_filter=%d sharpness_strength=%d",
+		drm_printf(p, "\tnum_scalers=%d, scaler_users=%x scaler_id=%d scaling_filter=%d sharpness_strength=%d",
 			   num_scalers,
 			   crtc_state->scaler_state.scaler_users,
 			   crtc_state->scaler_state.scaler_id,
@@ -432,12 +432,12 @@ static void intel_scaler_info(struct seq_file *m, struct intel_crtc *crtc)
 			const struct intel_scaler *sc =
 				&crtc_state->scaler_state.scalers[i];
 
-			seq_printf(m, ", scalers[%d]: use=%s, mode=%x",
+			drm_printf(p, ", scalers[%d]: use=%s, mode=%x",
 				   i, str_yes_no(sc->in_use), sc->mode);
 		}
-		seq_puts(m, "\n");
+		drm_puts(p, "\n");
 	} else {
-		seq_puts(m, "\tNo scalers available on this platform\n");
+		drm_puts(p, "\tNo scalers available on this platform\n");
 	}
 }
 
@@ -577,7 +577,7 @@ static void intel_crtc_info(struct seq_file *m, struct intel_crtc *crtc)
 	seq_printf(m, "\tport_clock=%d, lane_count=%d\n",
 		   crtc_state->port_clock, crtc_state->lane_count);
 
-	intel_scaler_info(m, crtc);
+	intel_scaler_info(&p, crtc);
 
 	if (DISPLAY_VER(display) >= 9) {
 		u32 background = crtc_state->hw.background_color;
-- 
2.47.3

