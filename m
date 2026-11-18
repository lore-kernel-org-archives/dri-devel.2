Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39300606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=s01hniYD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A9910EBD2;
	Wed, 18 Nov 2026 08:23:30 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB18B10E509;
 Wed, 18 Nov 2026 03:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1794972802;
 bh=YBj7F4I90IGKi8cfgKadgBBTN/FnYbC0nvHjsK56iT4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=s01hniYDBu1qVGlN+mJ/6Rzpxhav288dWTCLHexraZPCJThvst20E3KujK2fkvPJa
 efvxfGz6Zgl3YaGdz6WszsZr0h0OwD0Xz0D+AJv0aR2NrCw28HqU9BqHNlaBwMLuQO
 +Wq4867RbI31NM5U9f9nT4zbV0yOkcVbP/qtiSd0=
X-QQ-mid: zesmtpgz9t1794972800t002a3add
X-QQ-Originating-IP: ZPeXYgEqB33GYeECWIshq316oUwbgzeSxRhmtGUcVBM=
Received: from exmail.qq.com ( [14.155.229.203])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Nov 2026 11:33:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6685117099968580623
EX-QQ-RecipientCnt: 8
From: Hanson Wang <hanson.wang@ugreen.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 hanson.wang@ugreen.com
Subject: [PATCH] drm/i915/bw: sync global BW after non-atomic plane disable
Date: Wed, 18 Nov 2026 11:33:12 +0800
Message-Id: <20261118033312.902366-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MjlOSqg8Riw08vgkbgCwoiUM5XWTJf9ADWm8qhUG6W5kBS7KKio8t4T7
 Aj8KoI+4ANeZ2GUG4vQO2JSrYzi7LWW/LeI+Ouh3UKwkT4w8Uj0dTxUCE8yR8PMVJDlNkgS
 DPpqUoPC2NXFSBh+8V6Qe2G7EIHWOVUmVgJfjTHwc85z+3j6k7Zkvar4hQoxFt3jdcDqMgC
 0SqrhwDJVOTqSh1p/3XTheoHpZkB9xfnd8TCkEGwb2Ij0Lb0j+Vnx3MF9+sUK+z6xGro1s2
 AAYlKOju4RvSQt5lRS6F7p3r/VDBQgohZ5HmFsZM03EIsvHpN8QkyGX/9A4IRcjEFqUWZ2k
 p587emoAV2sUzTEf3VRXDVducNl0yZjxuqSjTSElcqnOFujUHJaWXE4vlvFvsCEAGjqwBuG
 IjtfHxh15/wqWY0VDSqo7WCzlg5g0TXSLBKnMWZrgbTUXAbyNiqIxLbwXfC+KskjrQTguQA
 rtAPnVgyJSNg7CdjzjW3G3mPTFzu19+XcWjVpUl9wbGo5tGyVQR15XW0mfdWwSEut9J/2P3
 V4KLq/8AsmlhGPaNtPEoPZJ4YDUNcr1Cevh+rIDslGTyccaiIy2Ecm2I8V5K4eH3tTAiuUq
 J+2myGohK/SXHFbanVV8N2HNRnTa6Q7rbNtLzvqVR5xB5LA0XHNMitGOasZxrd7d84+UfZJ
 9D15KkzEvbrqiJoQv2/jFdfSXovh5Ca/qFTXum+7m/nIcexOZNawUdFm113BtG1cGU+Qqyp
 lunRF+PUNawQZL00RpcabQAqRG6AYZmbwReAJct45KaIkbQ4+C1+mOEkk/Qf34Elj7oUisV
 r9RXFRmPutRyIBjeKm/FlqtONQppE/l9eiVkvDTeK/hyqcUAFArxas2ZZtT/dXBG1OKCXka
 evB/JqaSr0nb+FHuKX4T+RaleoZ+Z+fkL3dl35kButjXiZ5I3Mbf29ECBg06bwYynl5+g6K
 S0NnJylNKEdrQhWCsVMJwXdBhGe1V9ozwZ0YNmhA6ZY5mhKeDVqa1OWf6M037/gDIUdMS/n
 t2MasSSnyBGmQAc2gLDpI4ahzIqbjFaDtxprmW7Q==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hardware readout copies the firmware plane configuration into the
global bandwidth state. skl_dbuf_sanitize() may then disable those
planes through intel_plane_disable_noatomic(), which clears the
CRTC-local active_planes, data_rate and DDB entries but does not
update the global state.

A later atomic modeset sees both the old and new per-CRTC bandwidth
as zero and skips the global update. The sanitized pipe therefore
keeps contributing a phantom data rate and an active plane to the
QGV check.

Do not force !hw.active to zero. A logically enabled but inactive CRTC
must retain its bandwidth reservation so that reactivating it cannot
fail due to insufficient bandwidth. After the non-atomic disable,
recompute the global intel_bw_state and the separate dbuf bandwidth
state from the updated CRTC-local plane and DDB state.

Reproduced on two N5105 systems from different board vendors running
6.18.15. After DBUF sanitization, pipe B retained 196000 kB/s and one
plane in the global BW state despite its local plane state being
cleared and the pipe subsequently being disabled.

With the corresponding fix backported to 6.18.15 on one system, the
same sanitization path updated the global accounting to 0 kB/s and
zero planes. Subsequent QGV checks no longer included the stale
bandwidth.

Link: https://lore.kernel.org/intel-gfx/20261016014704.3876294-1-hanson.wang@ugreen.com

Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
Testing:
- The corresponding 6.18.15 backport was tested on one N5105 system.
- This mainline version has not been runtime-tested.
- The original high-bandwidth application failure was not replayed.

diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
index 99fd84a5ac13..84fe1f68e312 100644
--- a/drivers/gpu/drm/i915/display/intel_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_bw.c
@@ -1444,6 +1444,20 @@ static void intel_bw_crtc_update(struct intel_bw_state *bw_state,
 		    bw_state->num_active_planes[crtc->pipe]);
 }
 
+void intel_bw_crtc_update_noatomic(struct intel_crtc *crtc)
+{
+	struct intel_display *display = to_intel_display(crtc);
+	struct intel_bw_state *bw_state =
+		to_intel_bw_state(display->bw.obj.state);
+	const struct intel_crtc_state *crtc_state =
+		to_intel_crtc_state(crtc->base.state);
+
+	if (DISPLAY_VER(display) < 11)
+		return;
+
+	intel_bw_crtc_update(bw_state, crtc_state);
+}
+
 void intel_bw_update_hw_state(struct intel_display *display)
 {
 	struct intel_bw_state *bw_state =
@@ -1456,12 +1470,9 @@ void intel_bw_update_hw_state(struct intel_display *display)
 	bw_state->pipe_sagv_reject = 0;
 
 	for_each_intel_crtc(display, crtc) {
-		const struct intel_crtc_state *crtc_state =
-			to_intel_crtc_state(crtc->base.state);
 		enum pipe pipe = crtc->pipe;
 
-		if (DISPLAY_VER(display) >= 11)
-			intel_bw_crtc_update(bw_state, crtc_state);
+		intel_bw_crtc_update_noatomic(crtc);
 
 		/* initially SAGV has been forced off */
 		bw_state->pipe_sagv_reject |= BIT(pipe);
diff --git a/drivers/gpu/drm/i915/display/intel_bw.h b/drivers/gpu/drm/i915/display/intel_bw.h
index 99b447388245..41ace27608dc 100644
--- a/drivers/gpu/drm/i915/display/intel_bw.h
+++ b/drivers/gpu/drm/i915/display/intel_bw.h
@@ -30,6 +30,7 @@ void intel_bw_init_hw(struct intel_display *display);
 int intel_bw_init(struct intel_display *display);
 int intel_bw_atomic_check(struct intel_atomic_state *state);
 void intel_bw_update_hw_state(struct intel_display *display);
+void intel_bw_crtc_update_noatomic(struct intel_crtc *crtc);
 void intel_bw_crtc_disable_noatomic(struct intel_crtc *crtc);
 
 bool intel_bw_pmdemand_needs_update(struct intel_atomic_state *state);
diff --git a/drivers/gpu/drm/i915/display/intel_dbuf_bw.c b/drivers/gpu/drm/i915/display/intel_dbuf_bw.c
index 6cf674c586dc..453ceaa52e26 100644
--- a/drivers/gpu/drm/i915/display/intel_dbuf_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_dbuf_bw.c
@@ -226,21 +226,29 @@ int intel_dbuf_bw_calc_min_cdclk(struct intel_atomic_state *state,
 	return 0;
 }
 
-void intel_dbuf_bw_update_hw_state(struct intel_display *display)
+void intel_dbuf_bw_crtc_update_noatomic(struct intel_crtc *crtc)
 {
+	struct intel_display *display = to_intel_display(crtc);
 	struct intel_dbuf_bw_state *dbuf_bw_state =
 		to_intel_dbuf_bw_state(display->dbuf_bw.obj.state);
-	struct intel_crtc *crtc;
+	const struct intel_crtc_state *crtc_state =
+		to_intel_crtc_state(crtc->base.state);
 
 	if (DISPLAY_VER(display) < 9)
 		return;
 
-	for_each_intel_crtc(display, crtc) {
-		const struct intel_crtc_state *crtc_state =
-			to_intel_crtc_state(crtc->base.state);
+	skl_crtc_calc_dbuf_bw(&dbuf_bw_state->dbuf_bw[crtc->pipe], crtc_state);
+}
 
-		skl_crtc_calc_dbuf_bw(&dbuf_bw_state->dbuf_bw[crtc->pipe], crtc_state);
-	}
+void intel_dbuf_bw_update_hw_state(struct intel_display *display)
+{
+	struct intel_crtc *crtc;
+
+	if (DISPLAY_VER(display) < 9)
+		return;
+
+	for_each_intel_crtc(display, crtc)
+		intel_dbuf_bw_crtc_update_noatomic(crtc);
 }
 
 void intel_dbuf_bw_crtc_disable_noatomic(struct intel_crtc *crtc)
diff --git a/drivers/gpu/drm/i915/display/intel_dbuf_bw.h b/drivers/gpu/drm/i915/display/intel_dbuf_bw.h
index 61875b9d5969..434f3c605995 100644
--- a/drivers/gpu/drm/i915/display/intel_dbuf_bw.h
+++ b/drivers/gpu/drm/i915/display/intel_dbuf_bw.h
@@ -32,6 +32,7 @@ int intel_dbuf_bw_calc_min_cdclk(struct intel_atomic_state *state,
 int intel_dbuf_bw_min_cdclk(struct intel_display *display,
 			    const struct intel_dbuf_bw_state *dbuf_bw_state);
 void intel_dbuf_bw_update_hw_state(struct intel_display *display);
+void intel_dbuf_bw_crtc_update_noatomic(struct intel_crtc *crtc);
 void intel_dbuf_bw_crtc_disable_noatomic(struct intel_crtc *crtc);
 
 #endif /* __INTEL_DBUF_BW_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index b897678a93c0..b81d8f288810 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -67,6 +67,7 @@
 #include "intel_cursor.h"
 #include "intel_cursor_regs.h"
 #include "intel_cx0_phy.h"
+#include "intel_dbuf_bw.h"
 #include "intel_ddi.h"
 #include "intel_de.h"
 #include "intel_dip.h"
@@ -679,6 +680,14 @@ void intel_plane_disable_noatomic(struct intel_crtc *crtc,
 
 	skl_wm_plane_disable_noatomic(crtc, plane);
 
+	/*
+	 * Keep the global bandwidth states in sync with the updated
+	 * CRTC-local plane and DDB state. Otherwise a later atomic check
+	 * may skip the update when its old and new inputs are identical.
+	 */
+	intel_bw_crtc_update_noatomic(crtc);
+	intel_dbuf_bw_crtc_update_noatomic(crtc);
+
 	if ((crtc_state->active_planes & ~BIT(PLANE_CURSOR)) == 0 &&
 	    hsw_ips_disable(crtc_state)) {
 		crtc_state->ips_enabled = false;
-- 
2.34.1
