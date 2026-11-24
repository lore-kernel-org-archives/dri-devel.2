Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AE606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zyXuPpa2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MOcBuqH+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zyXuPpa2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MOcBuqH+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7841F10F30C;
	Tue, 24 Nov 2026 08:42:33 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CC410F374;
 Tue, 24 Nov 2026 08:41:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBBD122267;
 Tue, 24 Nov 2026 08:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795509673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MHbB8QlUvSML4Ps81dOhLyVy12cLGfgs0u1sDZ7gS1A=;
 b=zyXuPpa22qQifB/CJpsmhOvyUxX0UMhstDvirot01CpC7rmWPHk1w8iQAXd7BO6ddhcmCh
 aJrWuunQOpYcYR0qQ6B7VqNJaTBq1hZxIP1KhZjpR/ldFec5bTN7Xo/IN10KRLb6y5ko8c
 g6LqKS9HqEmEsNw+NlgvO84wzyLaouE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795509673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MHbB8QlUvSML4Ps81dOhLyVy12cLGfgs0u1sDZ7gS1A=;
 b=MOcBuqH+pqPOzaObcgyLv7LoYst0cP25KjFkPAHAaGS3TUGLQaAY01+tJ58RWurSYJhqrs
 5xhMp9TEMvdIp6AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795509673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MHbB8QlUvSML4Ps81dOhLyVy12cLGfgs0u1sDZ7gS1A=;
 b=zyXuPpa22qQifB/CJpsmhOvyUxX0UMhstDvirot01CpC7rmWPHk1w8iQAXd7BO6ddhcmCh
 aJrWuunQOpYcYR0qQ6B7VqNJaTBq1hZxIP1KhZjpR/ldFec5bTN7Xo/IN10KRLb6y5ko8c
 g6LqKS9HqEmEsNw+NlgvO84wzyLaouE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795509673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MHbB8QlUvSML4Ps81dOhLyVy12cLGfgs0u1sDZ7gS1A=;
 b=MOcBuqH+pqPOzaObcgyLv7LoYst0cP25KjFkPAHAaGS3TUGLQaAY01+tJ58RWurSYJhqrs
 5xhMp9TEMvdIp6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C5C31339F;
 Tue, 24 Nov 2026 08:41:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TBJ4BqlNBWv4GAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 24 Nov 2026 08:41:13 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ville.syrjala@intel.com, rodrigo.vivi@intel.com,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND v3] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
Date: Tue, 24 Nov 2026 09:40:01 +0100
Message-ID: <20261124084108.528317-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[intel.com,linux.intel.com,ursulin.net,gmail.com,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -11.80
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

Call drm_atomic_helper_check_plane_damage() in plane_atomic_check()
before copying the damage information to guarantees that ignore_damage_clips
from struct drm_plane_state has the correct value. Although i915 does not
directly modify or use the flag, DRM's damage iterator will soon rely on
it.

As a side effect, if the CRTC has been marked for a full modeset before
the call to drm_atomic_helper_check_plane_damage() happens, the plane now
ignores all damage clips and does a full update.

Git commit 35ed38d58257 ("drm: Allow drivers to indicate the damage
helpers to ignore damage clips") introduced ignore_damage_clips to
selectively ignore damage clipping for certain framebuffer changes. The
mode-setting pipeline can disabled damage clippings for an atomic commit
by setting ignore_damage_clips in struct drm_plane_state. The atomic
commit will then do a full display update.

Future directions: there's currently a multitude of options that affect
damage clipping; with different places seeing different state. In order
to unify this, drm_atomic_helper_check_plane_state() will soon evaluate
all options in a single place and set ignore_damage_clips accordingly. All
later stages of the mode-setting pipeline will only look at this field.

v3:
- fix the call to drm_atomic_helper_check_plane_state()
- use primary-CRTC's plane state (Sashiko)
- note full-plane updates in commit description
v2:
- move _check_plane_damage() before reading damage first time (Sashiko)
- expand commit description

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_plane.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index d23de0f34e4b..058e92f383e4 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -955,7 +955,7 @@ static int plane_atomic_check(struct intel_atomic_state *state,
 		intel_atomic_get_new_plane_state(state, plane);
 	const struct intel_plane_state *old_plane_state =
 		intel_atomic_get_old_plane_state(state, plane);
-	const struct intel_plane_state *new_primary_crtc_plane_state;
+	struct intel_plane_state *new_primary_crtc_plane_state;
 	const struct intel_plane_state *old_primary_crtc_plane_state;
 	struct intel_crtc *crtc = intel_crtc_for_pipe(display, plane->pipe);
 	const struct intel_crtc_state *old_crtc_state =
@@ -978,6 +978,14 @@ static int plane_atomic_check(struct intel_atomic_state *state,
 		old_primary_crtc_plane_state = old_plane_state;
 	}
 
+	/*
+	 * Prepare plane-damage state before using it; do this on all
+	 * display versions to keep the underlying DRM plane state in
+	 * good shape.
+	 */
+	drm_atomic_helper_check_plane_damage(&state->base,
+					     &new_primary_crtc_plane_state->uapi);
+
 	intel_plane_copy_uapi_plane_damage(new_plane_state,
 					   old_primary_crtc_plane_state,
 					   new_primary_crtc_plane_state);

base-commit: 401a3e7b64d174c4f2b256b035de716c7b79bdc1
-- 
2.56.1

