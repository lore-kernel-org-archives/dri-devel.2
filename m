Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCC6C624C9
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A219310E69D;
	Mon, 31 Aug 2026 07:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dn5A18bO";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E875E10E55D
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 16:17:12 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8541875f596so1120201b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788106632; x=1788711432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=54C0fnQ3Auto948vkBDj75sqdB7k3c+Pc38gSCW7U00=;
 b=Dn5A18bOwJoEwBF+MmdDj73pEHrCra3lSj/O3fO6HkaDojEJuRvLP6SQ+bd0QcTU9l
 bMTT0paVFxkbV6U3pxVXMLy9yVx0abuyF0CgJJ76RgKyUzJITSf2lprK7LCr0e09u994
 oCYxnfhxJfqNt5zTRp+t44Gmglq0bNMW2OldwRoqEGYu62e0qpwf9+p9pmQskTa2vqER
 CZ1+0vLZ86E/DgcrtUF9Su69+2b5+MrV2d03KCK1opf+EJyOWxITSz8r6r9hX7+Sl8XH
 UCJa6z517g3IXC4da/d3datgvODY4jp78Ll91f6kAvJ2sB6+BEjsRw891vwdLyr4vYJQ
 Pglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788106632; x=1788711432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=54C0fnQ3Auto948vkBDj75sqdB7k3c+Pc38gSCW7U00=;
 b=NwV1Jel2V3/uC8NsRmFDCtGtwL1gXzn1pCt3PGChT6K7ooyR7NKEZEyeQdv9rDvU5h
 4daN+RudIpbbZ+otuvnzbb58hcRQ+aq8EDfiuP6YX3TBkzALDEQUwMkieIhvaNKdYtXs
 BMK8PSPjVtuWdBl9f2pNbw4mq7QqNw4Gml2I7RFyU5uKTePd5ko5vOtoldUt3BJxWTyd
 isSsYaOvzT4Z/TbJZPgy1QcoPd155cBzCn1EWX82AcoKvLrnl6isi0bPp1mafY8XF6nl
 BE2YT4IbeF9rhragDoR4i0J0Gcj6oY7P24GJmsH/FuiEjO5KUa1INvuYprTyCVo1mew0
 NWeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpC6eVfUpatEH8AEeXIbA6A2JfIarEU+4BdZ1ayF+tCPN+0cl1taiolMiiRy27N4K/iCYUquI9Bo8w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lbLvbXqzNjsVS7OKtrdQyu7qjs62aqgITrd9qBWo6YclZzz3kN
 9943TpUMNzyaWfjbs2Plt5MZx6feTMLjN2RguVlIknuQgpP0VRFHwHI=
X-Gm-Gg: AR+sD12KMD/Ho9yqss6UkYjc9D8OC23vK9jDb9HHWYdK4N4TqaFvh6oXjVkKZJfY+Nq
 NFHKIayYC3mHizwKMpv04xx5Xkup6I0VQ4jtMcrhqrrqnC7Xmv4G/sua96ByaosM9agiU+ZIKsm
 Pv5myg55ZXje4mdzQcCJCfzGd4TEPKhUIK8eIEw2GThISAi+DvB64v3GmfjGt57+5TxAZ/m5KzQ
 cZ+X+10MdEfKw/V0Pk/JgBDrnzybgnq48e8Ii96dvNCu/iTi38VHRE08QBDuf7cGWhcEhNXbA/O
 Pv2GoHgBSUA3cQ7QTftMGqwJ4BxFu1bqNw294y7gqSJmHJZGqbTi2H5velml8k7qPiNtYhwTQZg
 woGvweHDkZPCltVtkI4FzIe6AgqyoQdv1qnZPlEO0AesKyYiBq7OqBoeDn/7xpoc2qZsnE1X+VV
 Zzkyob33oacx6bihml5/iQ/aoeiKzV9gJtCbnz2VZkxC1CfM3U2HIGonRurtia3BCw
X-Received: by 2002:a05:6a00:a118:b0:847:8449:2bb6 with SMTP id
 d2e1a72fcca58-8562953d5e9mr34140137b3a.4.1788106632245; 
 Sun, 30 Aug 2026 09:17:12 -0700 (PDT)
Received: from fedora ([2601:602:867e:54e0::bc1f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1f32f727bsm3008661a12.7.2026.08.30.09.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:17:11 -0700 (PDT)
From: Eduardo Diaz <iamedu@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Eduardo Diaz <iamedu@gmail.com>
Subject: [PATCH] drm/i915/cdclk: Don't trust boot readout for per-pipe
 cdclk/voltage tracking
Date: Sun, 30 Aug 2026 09:17:03 -0700
Message-ID: <20260830161703.11570-1-iamedu@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

On Panther Lake (xe3lpd) laptops, cold boot reliably corrupts the
internal eDP panel: pipe A gets a "Selective fetch area calculation
failed in pipe A" warning immediately followed by a CPU pipe A FIFO
underrun, and the panel stays corrupted for the rest of the session.
A subsequent suspend/resume cycle (or any other full re-modeset)
"fixes" it, which pointed at cdclk/voltage-level tracking rather than
a genuine hardware race.

intel_modeset_readout_hw_state() runs once at driver probe (and again
on resume) to figure out what firmware/GOP left the display in. For
each already-active pipe it calls intel_cdclk_update_hw_state(),
which seeds cdclk_state->min_cdclk[]/min_voltage_level[] directly
from the freshly read-out crtc_state. That treats "firmware left this
pipe active with mode X" as proof that this driver's own cdclk,
voltage-level and DBUF setup for mode X is already established in
hardware. It isn't -- only firmware's own, entirely separate code
path has ever touched those registers.

The OS driver's first real modeset for an inherited pipe typically
targets the same native panel mode, so the freshly computed
crtc_state->min_cdclk/min_voltage_level trivially match this
readout-seeded baseline. intel_cdclk_update_crtc_min_cdclk() and
intel_cdclk_update_crtc_min_voltage_level() then conclude nothing
changed and skip the recalculation, on the one commit where it
actually matters: taking a pipe from firmware ownership to being
correctly configured by this driver.

Fix this in two parts:

 - Invalidate the per-pipe min_cdclk[]/min_voltage_level[] tracking
   right after boot-time readout, so the first real atomic commit is
   guaranteed to see a difference.

 - Stop early-returning in intel_cdclk_update_crtc_min_cdclk() and
   intel_cdclk_update_crtc_min_voltage_level() based on the crtc_state
   comparison alone. That comparison is unreliable for exactly the
   same reason (it's derived from the same readout), and skips the
   real, tracked-state check below it.

Bisected on real hardware (Lenovo Yoga 9i 14IPH11, Panther Lake) down
to a narrow window between v6.19.10 (clean on every cold boot) and
v7.1.10 (broken on every cold boot); confirmed via live kernel
tracing that the skip path fires unconditionally on this platform
from the very first post-boot atomic commit onward. This fix
eliminates the FIFO underrun across many consecutive cold boots on
the same hardware, with no regression observed across suspend/resume.

The investigation and this fix were developed with the assistance of
Claude (Anthropic), driven and verified end to end on the affected
hardware by the Signed-off-by below.

Signed-off-by: Eduardo Diaz <iamedu@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_cdclk.c    | 45 ++++++++++++++-----
 drivers/gpu/drm/i915/display/intel_cdclk.h    |  1 +
 .../drm/i915/display/intel_modeset_setup.c    |  1 +
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index a53d887271..209a2373d1 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2981,11 +2981,14 @@ static int intel_cdclk_update_crtc_min_cdclk(struct intel_atomic_state *state,
 	bool allow_cdclk_decrease = intel_any_crtc_needs_modeset(state);
 	int ret;
 
-	if (new_min_cdclk == old_min_cdclk)
-		return 0;
-
-	if (!allow_cdclk_decrease && new_min_cdclk < old_min_cdclk)
-		return 0;
+	/*
+	 * old_min_cdclk comes from the previous crtc_state, which after
+	 * boot-time readout reflects whatever firmware/GOP left running,
+	 * not what this driver has programmed. For an inherited pipe it
+	 * equals new_min_cdclk by construction (same mode, same formula),
+	 * so an early return here would skip the recalculation that
+	 * matters. Always continue on to the cdclk_state check below.
+	 */
 
 	cdclk_state = intel_atomic_get_cdclk_state(state);
 	if (IS_ERR(cdclk_state))
@@ -3026,12 +3029,10 @@ static int intel_cdclk_update_crtc_min_voltage_level(struct intel_atomic_state *
 	bool allow_voltage_level_decrease = intel_any_crtc_needs_modeset(state);
 	int ret;
 
-	if (new_min_voltage_level == old_min_voltage_level)
-		return 0;
-
-	if (!allow_voltage_level_decrease &&
-	    new_min_voltage_level < old_min_voltage_level)
-		return 0;
+	/*
+	 * old_min_voltage_level is unreliable for the same reason; see
+	 * intel_cdclk_update_crtc_min_cdclk().
+	 */
 
 	cdclk_state = intel_atomic_get_cdclk_state(state);
 	if (IS_ERR(cdclk_state))
@@ -3705,6 +3706,28 @@ void intel_cdclk_update_hw_state(struct intel_display *display)
 	cdclk_state->dbuf_bw_min_cdclk = intel_dbuf_bw_min_cdclk(display, dbuf_bw_state);
 }
 
+/*
+ * intel_cdclk_update_hw_state() seeds min_cdclk[]/min_voltage_level[]
+ * from readout's crtc_state, i.e. from whatever firmware/GOP left
+ * running, not from anything this driver has programmed. A pipe's
+ * first real modeset usually targets the same native mode, so the
+ * freshly computed value matches this seeded baseline and
+ * intel_cdclk_update_crtc_min_cdclk()/_min_voltage_level() conclude
+ * nothing changed, skipping the recalculation that matters. Call
+ * this after readout so the first real commit sees a difference.
+ */
+void intel_cdclk_invalidate_min_tracking(struct intel_display *display)
+{
+	struct intel_cdclk_state *cdclk_state =
+		to_intel_cdclk_state(display->cdclk.obj.state);
+	enum pipe pipe;
+
+	for_each_pipe(display, pipe) {
+		cdclk_state->min_cdclk[pipe] = 0;
+		cdclk_state->min_voltage_level[pipe] = 0;
+	}
+}
+
 void intel_cdclk_crtc_disable_noatomic(struct intel_crtc *crtc)
 {
 	struct intel_display *display = to_intel_display(crtc);
diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.h b/drivers/gpu/drm/i915/display/intel_cdclk.h
index a60cbf745e..1517d3605a 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.h
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.h
@@ -46,6 +46,7 @@ int intel_cdclk_state_set_joined_mbus(struct intel_atomic_state *state, bool joi
 struct intel_cdclk_state *
 intel_atomic_get_cdclk_state(struct intel_atomic_state *state);
 void intel_cdclk_update_hw_state(struct intel_display *display);
+void intel_cdclk_invalidate_min_tracking(struct intel_display *display);
 void intel_cdclk_crtc_disable_noatomic(struct intel_crtc *crtc);
 int intel_cdclk_update_dbuf_bw_min_cdclk(struct intel_atomic_state *state,
 					 int old_min_cdclk, int new_min_cdclk,
diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
index 6aed881737..c7be6e63e7 100644
--- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
+++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
@@ -880,6 +880,7 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
 	intel_bw_update_hw_state(display);
 	intel_dbuf_bw_update_hw_state(display);
 	intel_cdclk_update_hw_state(display);
+	intel_cdclk_invalidate_min_tracking(display);
 
 	intel_pmdemand_init_pmdemand_params(display, pmdemand_state);
 }
-- 
2.55.0

