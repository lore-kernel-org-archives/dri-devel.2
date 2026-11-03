Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A26606A32F
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k71DnFWs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B84510F06F;
	Wed,  4 Nov 2026 08:58:35 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40EE10F5D9
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:02:57 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e6eb21a8fso1744066f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 06:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793714576; x=1794319376; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uu68lQxHEs/mkQVI9vO7Af9VdhM6SKqu6dRO3KGsMrE=;
 b=k71DnFWs2C4BOlmUnahOM7Tpz1HeLUdFBaa4ZpXLXj0nQk+kUxJBTLgF77VL6TTe5s
 ldm72W/gpjGb9OjAnhOMZ8W6ehuIBQCQHVJi5mDpqB2RPfH0yXcicC8EB+1o090miR5f
 yNcZ15dyDs9viE4h85XPNSlE6hAn/eZSS/dTotnz9WzwKpL3RLFd1nUjXZ3viTOFmuV7
 8QQnqRJaSzvW1bA+6xBg54s53MLrQfbwha3FOwGJsiz7LhGwly4U+J+9rBM9MX+TsUt/
 k2Bl0fEZvjsl2I9EHn2N9mFYBkkWonpZqodjbk/oo5QzYNh0VZtRmhB3MkffpZld2FQp
 O7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793714576; x=1794319376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uu68lQxHEs/mkQVI9vO7Af9VdhM6SKqu6dRO3KGsMrE=;
 b=so6LFBeNV/jLPfrYgXhic8mreyoGy1ZObQ+GUrJk/VYwpMVC9dLToDmg+Mh8h19zSs
 iFOeuP2dmQfGitD75BV/pKRjsM8NOQ29snjNiZhxqjvq/XI69Rtnq5TqsFYSmatjqfE1
 vJG9nwp7Ywgbh+mNoN+TyjGimYXAL2i6+yG64o/JPrXilbPeuQfkjYR1nvJuNsSFPX3v
 nbm7+50AeBgXyd0gW0bMehKTTZfx5n39m3SZgbd1QvP5JM1emmsfkndoJ/BbLDDgaOOO
 I7yus6YOJfqL8hx/HLGqZ1xNH4c7f072fM9g7FOl9PshyrQr+0nBtTALd9Gc55lIIy6Y
 7hbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBywAeLndvirIYXdCEwVV+tev6B5Gql9JkW8I7TrZDWzyvGSCrPGcbuGhe8MsQ7LB2Iy3mwF4VgpMWs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+FnrfLPfh8Wy8KybyjeGkMZV/73bwY07EErXOzJj2tWnQLplod
 +0+Cq6cjay7Kfy8HP78FTYg4EOvuMEUS3giZymBfuGEQNlFg9FrwEdNZ
X-Gm-Gg: AYBFou05gPhrc/URaDcA/GESTg0yvtWTL/WOWUKx/cueKzmhe+bTtl4od8CDmMDuGfH
 1AV5Ik42bp57EN1FD4TeNrnsjvohva3dC8vxI5Sxkn5Wpk6WIEstXY68AQhJe+flsff03M6u4CF
 HgFNCjdJ2/ok3L/kULet32M7VZW9vaEsl/2wh+pOSfMkdY45rsfpWrXyLr6BuuHJXrts1Nt37+y
 BN7NM+CEIZPz7/xSsea2VLjRve6w0F0SLTvMp2NqOdRGDb406jeDJQG6aExkxSy4LYi94ESM4Zw
 iZ6qY4P2uCeE4Owr0KqsK2HTkicT8aKShJfDr5e/8yGFHsl3BZBamXEyOB6M8JAZ/9zbVOCKBb3
 6iXBr1/Ei9geG1eQ3FFo4naJWg5iRigA7XXgvzV8WWh1vahThfDFGABzdMVdHqGxTshixgwoz60
 9sG9sinF9oI2K28rEcY8mkiAnisdVWQAdkuVNSPmC6i+Evf+U1tZZv6xSOAqlNcdciwa14AesSk
 QN/oJaajV2G+U/aPgVqF4iQ2tjwFcjEj/eiSpeFP7BJ66INFfBY/FVL91IISWuXv1RbsX3ebrqK
 6FVhThq9D6GGEJrYim/wWszV/Lh+SQg1PH8Ww2yXDyEBiuWxVQJ/fNIS+IyzGQLSqA4mCq14PQ2
 ZD1l02Q==
X-Received: by 2002:a05:6000:2486:b0:48d:ff81:5201 with SMTP id
 ffacd0b85a97d-48e6e4f44f2mr30393094f8f.41.1793714574925; 
 Tue, 03 Nov 2026 06:02:54 -0800 (PST)
Received: from gandalf.magpie-herring.ts.net ([90.251.75.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8c0b6sm24467507f8f.41.2026.11.03.06.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:02:52 -0800 (PST)
From: Zak Brighton Knight <zakbrightonknight@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Zak Brighton Knight <zakbrightonknight@gmail.com>
Subject: [PATCH] drm/i915/backlight: Keep ACPI backlight requests while the
 panel is off
Date: Tue,  3 Nov 2026 14:02:35 +0000
Message-ID: <20261103140235.1032320-1-zakbrightonknight@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the ACPI video backlight (acpi_video0), brightness changes reach
i915 as OpRegion ASLE requests: the firmware's _BCM method writes the
level to the mailbox and raises the ASLE interrupt.
intel_backlight_set_acpi() returns early when the connector has no
crtc, so a request made while the panel is off is dropped. The ACPI
video driver still reports the new level, but the panel comes back on
at the old one.

The connector has no crtc whenever userspace turns the screen off by
disabling the crtc and detaching the connector from it, which is what
mutter does for its power saving mode. GNOME's login screen makes this
easy to hit: it dims the screen when idle and turns it off a little
later, and on the next key press it restores the brightness while the
screen is still off. The screen comes back dim, and the next brightness
key press jumps from the level the backlight device reports.

On a ThinkPad T520 (Ivy Bridge, LVDS, coreboot), setting acpi_video0
to 10, turning the screen off through mutter, setting 14 and turning
the screen back on gives, with drm.debug=0x6:

  brightness 10, screen on:
    updating opregion backlight 73/255
    [CONNECTOR:92:LVDS-1] set backlight level = 444
  screen off:
    [CONNECTOR:92:LVDS-1] set backlight PWM = 0
  brightness 14, screen off:
    updating opregion backlight 170/255
  screen on:
    [CONNECTOR:92:LVDS-1] set backlight PWM = 444

after which acpi_video0 reads brightness 14 and actual_brightness 10.

The check goes back to commit 752aa88a1e78 ("drm/i915: make backlight
functions take a connector"). Commit 260d8f98ef9d ("drm/i915: Remove
most INVALID_PIPE checks from the backlight code") dropped it from the
native path, but kept it for BIOS requests, which can arrive during
driver init before the modeset readout, when there is no crtc yet. The
native path, intel_panel_set_backlight(), stores the level whatever the
connector state and leaves it to the next backlight enable.

Do the same for ACPI requests: always store the level, and skip only
the hardware update when there is no crtc, which still covers the
driver init case.

The problem was found and root-caused, and this patch was drafted, with
the help of an AI coding assistant (Claude, by Anthropic).

Fixes: 752aa88a1e78 ("drm/i915: make backlight functions take a connector")
Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
---
Tested on the T520 (i7-3840QM, Ivy Bridge, coreboot 24.08 with SeaBIOS)
with v7.4-rc1 plus this patch, built with PROVE_LOCKING, under GNOME 50
(mutter 50.6). intel_backlight_set_acpi() is the same in drm-intel-next
and drm-tip today, and the patch applies to both.

- The sequence above now ends with "set backlight PWM = 1035" when the
  screen comes back on, and acpi_video0 reads 14 for both brightness
  and actual_brightness. The same from 13 down to 6.
- Setting 12 while the screen is off, then suspending to RAM and
  resuming before turning the screen on: acpi_video re-sends 12 on
  resume ("Restoring backlight state"), and the screen comes back at 12.
- Suspend and resume with the screen on keeps the level, the level
  systemd restores at boot is applied, and there were no lockdep
  reports or warnings.

One case still comes back wrong, differently from before. On this
machine _BQC reports the PWM duty cycle, so reading actual_brightness
while the panel is off makes acpi_video cache its lowest level (2%),
and it re-sends that on resume. Without this patch, that request is
dropped and the panel comes back at the level from before the screen
went off; with it, the panel comes back at 2%. Mutter only reads
brightness, so I have only hit this from a test script.

Not tested: the driver init case the check was kept for. coreboot only
sends requests from _BCM, or from the brightness keys before the OS has
called _BCL, so I couldn't make it send one between the backlight
setup and the modeset readout. Not tested either on other platforms or
with other compositors.

https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15987 reports
the same symptom on a MacBookPro11,1: the brightness is wrong after the
display sleeps, and acpi_backlight=native fixes it. It may be this bug,
but I can't test that machine.

 drivers/gpu/drm/i915/display/intel_backlight.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index b128896cb..2310a9258 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -310,13 +310,7 @@ void intel_backlight_set_acpi(const struct drm_connector_state *conn_state,
 	struct intel_panel *panel = &connector->panel;
 	u32 hw_level;
 
-	/*
-	 * Lack of crtc may occur during driver init because
-	 * connection_mutex isn't held across the entire backlight
-	 * setup + modeset readout, and the BIOS can issue the
-	 * requests at any time.
-	 */
-	if (!panel->backlight.present || !conn_state->crtc)
+	if (!panel->backlight.present)
 		return;
 
 	mutex_lock(&display->backlight.lock);
@@ -332,7 +326,15 @@ void intel_backlight_set_acpi(const struct drm_connector_state *conn_state,
 					 panel->backlight.level,
 					 panel->backlight.device->props.max_brightness);
 
-	if (panel->backlight.enabled)
+	/*
+	 * Lack of crtc may occur during driver init because
+	 * connection_mutex isn't held across the entire backlight
+	 * setup + modeset readout, and the BIOS can issue the
+	 * requests at any time. There's no crtc either while
+	 * userspace has the panel turned off. Keep the level
+	 * anyway, it's applied when the backlight is next enabled.
+	 */
+	if (panel->backlight.enabled && conn_state->crtc)
 		intel_panel_actually_set_backlight(conn_state, hw_level);
 
 	mutex_unlock(&display->backlight.lock);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

