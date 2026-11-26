Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2937606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=mpuSNqdR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C46C10E02E;
	Thu, 26 Nov 2026 02:03:55 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF43510E02E;
 Thu, 26 Nov 2026 02:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1795658551;
 bh=B6OUgow/KIB9PEtIV4VzEgJ3v/rvczyz08jWT2HoqmI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=mpuSNqdRjw9XGICV0bnqt/Tal4C/XU7cRaxrbiabkp5IwxvKhxXrws+2i2DcOTIaM
 EtkS/9MQJx4Hlsmkc3f2og6eL50Kzy8/99Ndx21ouLj+DW4OaJKixyXqo2SCh/n730
 xX8pifNQNEKVx2lZPlaxExQolcThoIpV5wLnfIPc=
X-QQ-mid: esmtpsz20t1795658541tf1bd9397
X-QQ-Originating-IP: JSb5GDPXRkflXD9z2ysNC2qeVKxFb/jLFlwMZpY6Oig=
Received: from exmail.qq.com ( [14.153.244.37])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 26 Nov 2026 10:02:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3984067700861124271
EX-QQ-RecipientCnt: 9
From: Hanson Wang <hanson.wang@ugreen.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 ville.syrjala@linux.intel.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, hanson.wang@ugreen.com
Subject: [PATCH v2 RESEND] drm/i915/display: Refresh global state after
 non-atomic sanitization
Date: Thu, 26 Nov 2026 10:02:13 +0800
Message-Id: <20261126020213.3412946-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MMKcwIwa79XOfHiQ9WZNicME22AQzpDEn3cLHr8dw2frl53V5nZ+gTcc
 cDzJn4P3zbQh7kV+1dnWCuRkLXhwb+mzgot2LVzzLd209OA0NKXf1Ad3O7fInKVfP4cKERl
 6Q5JwynRE9OCll9M6cgfWkhQOsoZIU+ZF3LFxY5mdzJ2TGpHL4Gn/jQ3b2HTtuRzJ1i4Lkd
 Tv8JcrBt0ejQqW5Rw7ErfaxnmwQOkLzueGUKwaRAhQ3vYnjlMV24fzZY3/NZI5g+H8KPgyf
 a59T0oN4kx1dwxI8A7QGEez33c9WTNkNG8VVu9/lyk3rHgC8oYaI8hw0VKvVtx8eG69MzSu
 HhmEYqKrWGDw83pBolOma81WF0rHMGpyX+hGx7oKdFBPIsBUaSQZLFXm2coY4fQv1IXXmo0
 sGzoMvIxcD6TtU6Qw3rAddms6bhRAg73CuGkR6oznvuBLQDSA2OY8/fyhk48cShumJJVNpo
 XdfuiYHXDpHV0//hnRWe1Lwu6igPXcAXkYKhvx+M1EQqX43bVvXirJC44nc6eu5QbSctBh1
 /t+vToMmJ23w1p/NHEp22clKMf83QqD/W9Thsoa6/G4rPFhsSxdurf+RQhoLwK+lO9QhgGc
 wqOxOoFvRbuVA6S1j0WBEk0AlJWCW1GyqBPapmnu0XZcsIDAxGF0RQENSJNNa8vFH0aSJLC
 27DJfr6TsEiKmfrcoWLLvZQp2gOOVce5PvQnMHEFHWKV0YhhxkUg/jpY6hAviep3kzB/UUN
 fLWp4ebNd0czMBmdLWXIgkn3HJvPnATr9rn+SBsEWDQoMimcQvI6OSjvda2awvqpfxzCuPX
 iOWf2kB6QszbGQLOl9OHxziIndtY54uD9iFO9GPbaFQoOV5+hAKnhrD1017cHRo0W4kxsdX
 KLFfLHLst71DHLv+bzvYvhg2gZ/vWyoqihZuStoIk3roWekwizCfdcAB9IxjMF+4lbNRj7H
 9NNwB/LYTW2xvRMhfH+XgLPrdn0XlfsA4tgL38ES7vTi33y+cx8WFfDmieN2iptNHPXeQzk
 cL8cI/XDWKi7q2AOS9uptR7h2h7V1GjirPltJFuZafW5YvLVGf
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hardware state readout accounts firmware planes in the global bandwidth
state before sanitization. skl_dbuf_sanitize() may subsequently disable
those planes through intel_plane_disable_noatomic(), which clears the
CRTC-local plane data but leaves the global bandwidth entries unchanged.
A later atomic check can see identical, already cleared old and new
CRTC-local inputs and skip the global update. The stale data rate and
plane count then remain part of the QGV bandwidth check.

The issue was reproduced on an N5105 system running mainline.
After DBUF sanitization had cleared pipe B's local plane state,
the global bandwidth state still accounted for 196000 kB/s and
one plane.

Add intel_display_update_hw_state() to group the existing bandwidth,
DBUF bandwidth and CDCLK state updates. Keep the initial update after
hardware readout, and repeat it after intel_wm_sanitize(), once the
non-atomic CRTC and plane sanitization is complete. Update DBUF bandwidth
before CDCLK, which derives a minimum clock requirement from that state.

Also refresh the global state after intel_initial_plane_config(): failure
to reconstruct a BIOS framebuffer can disable a primary plane after the
main sanitization sequence has finished.

Reuse the existing accounting helpers so logically enabled but inactive
CRTCs retain their memory bandwidth reservations.

Fixes: 15512021eb39 ("drm/i915: Workaround broken BIOS DBUF configuration on TGL/RKL")
Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://lore.kernel.org/intel-gfx/20261118033312.902366-1-hanson.wang@ugreen.com
Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
Resend v2 as a new thread at Ville's request so Patchwork can
pick it up correctly and CI can run. No changes from v2.

Changes in v2:
- Add intel_display_update_hw_state() as suggested by Ville, reusing
  the existing BW, DBUF bandwidth and CDCLK update helpers.
- Refresh global accounting after the complete modeset sanitization
  sequence, including intel_wm_sanitize(), instead of adding per-CRTC
  update helpers to intel_plane_disable_noatomic().
- Also cover non-atomic plane disable on BIOS framebuffer takeover
  failure in intel_initial_plane_config().
- Preserve the initial readout update and the existing intermediate
  CRTC-disable bookkeeping used during sanitization.
- Add a Fixes tag for the DBUF sanitization path.

Testing:
- W=1 compilation of both changed C files for i915 and Xe display.
- Strict checkpatch passed.
- Boot-tested v2 on an affected N5105 system with HDMI connected,
  based on 666539eecdf4 (7.4.0-rc3+). The original DBUF sanitization
  path was reproduced, and pipe B's global accounting changed from
  196000 kB/s and one plane to 0 kB/s and zero planes after
  intel_wm_sanitize().
- Post-boot inspection confirmed that pipe B contributed no bandwidth
  or planes to the global BW and DBUF bandwidth states. Subsequent
  QGV checks no longer included the stale contribution.
- This was a v1-to-v2 boot test, not an unpatched-versus-patched
  comparison.
- The original high-bandwidth workload, HDMI hotplug, suspend/resume,
  cold boot, enabled-but-inactive transitions and BIOS framebuffer
  reconstruction failure were not tested with v2.

 .../drm/i915/display/intel_initial_plane.c    |  4 ++++
 .../drm/i915/display/intel_modeset_setup.c    | 24 ++++++++++++++++---
 .../drm/i915/display/intel_modeset_setup.h    |  1 +
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_initial_plane.c b/drivers/gpu/drm/i915/display/intel_initial_plane.c
index 7427f41e4d7e..022798baf7e0 100644
--- a/drivers/gpu/drm/i915/display/intel_initial_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_initial_plane.c
@@ -15,6 +15,7 @@
 #include "intel_fb.h"
 #include "intel_frontbuffer.h"
 #include "intel_initial_plane.h"
+#include "intel_modeset_setup.h"
 #include "intel_parent.h"
 #include "intel_plane.h"
 
@@ -237,4 +238,7 @@ void intel_initial_plane_config(struct intel_display *display)
 
 		plane_config_fini(display, plane_config);
 	}
+
+	/* Failure to reconstruct the BIOS framebuffer may disable a plane. */
+	intel_display_update_hw_state(display);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
index 6aed88173770..bb8f3acd3595 100644
--- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
+++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
@@ -14,6 +14,7 @@
 #include "i9xx_wm.h"
 #include "intel_atomic.h"
 #include "intel_bw.h"
+#include "intel_cdclk.h"
 #include "intel_cmtg.h"
 #include "intel_color.h"
 #include "intel_crtc.h"
@@ -37,6 +38,22 @@
 #include "intel_wm.h"
 #include "skl_watermark.h"
 
+/**
+ * intel_display_update_hw_state - synchronize global display accounting
+ * @display: display instance
+ *
+ * Update the global state from the current CRTC and plane state during
+ * hardware state setup, with atomic commits excluded. Call this again
+ * after non-atomic sanitization has changed the local state.
+ */
+void intel_display_update_hw_state(struct intel_display *display)
+{
+	intel_bw_update_hw_state(display);
+	/* CDCLK requirements depend on the DBUF bandwidth state. */
+	intel_dbuf_bw_update_hw_state(display);
+	intel_cdclk_update_hw_state(display);
+}
+
 static void intel_crtc_disable_noatomic_begin(struct intel_crtc *crtc,
 					      struct drm_modeset_acquire_ctx *ctx)
 {
@@ -877,9 +894,7 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
 	if (DISPLAY_VER(display) >= 9)
 		intel_wm_get_hw_state(display);
 
-	intel_bw_update_hw_state(display);
-	intel_dbuf_bw_update_hw_state(display);
-	intel_cdclk_update_hw_state(display);
+	intel_display_update_hw_state(display);
 
 	intel_pmdemand_init_pmdemand_params(display, pmdemand_state);
 }
@@ -995,6 +1010,9 @@ void intel_modeset_setup_hw_state(struct intel_display *display,
 		intel_wm_get_hw_state(display);
 	intel_wm_sanitize(display);
 
+	/* Sanitization may have disabled planes without an atomic commit. */
+	intel_display_update_hw_state(display);
+
 	for_each_intel_crtc(display, crtc) {
 		struct intel_crtc_state *crtc_state =
 			to_intel_crtc_state(crtc->base.state);
diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.h b/drivers/gpu/drm/i915/display/intel_modeset_setup.h
index f5e6f3ae9572..28a9165f7fca 100644
--- a/drivers/gpu/drm/i915/display/intel_modeset_setup.h
+++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.h
@@ -9,6 +9,7 @@
 struct drm_modeset_acquire_ctx;
 struct intel_display;
 
+void intel_display_update_hw_state(struct intel_display *display);
 void intel_modeset_setup_hw_state(struct intel_display *display,
 				  struct drm_modeset_acquire_ctx *ctx);
 

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.34.1

