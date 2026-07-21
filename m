Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401C3C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B121410E706;
	Tue, 21 Jul 2026 08:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="JgjW7153";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9bXfJdrM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JgjW7153";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9bXfJdrM";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B155C10E6DE
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:21:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0ECFC3E61;
 Tue, 21 Jul 2026 08:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784622074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g3p7NhHkrrkmq6Eg4P3XqhgRlLkuDdR28KUihZ1Gu3Y=;
 b=JgjW7153saTJtKK0v9/X5Ih0gQBSCZDq5VMgMP4CUIxV2aB///vDk9GIfRzTKS6otlemS2
 sK7elkMD5dom+BFg6cKYRTw7dLg/YLSa1qW5Nn3ybVZhY87vk/RDcm2kP/br8BNEixtZV3
 0Yz54CV3ADbw5vLhZAsKs4QOr9AVHkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784622074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g3p7NhHkrrkmq6Eg4P3XqhgRlLkuDdR28KUihZ1Gu3Y=;
 b=9bXfJdrMuCU+22XSWeOCZhmUryhnx8jYNRox7lGv5W4Eki0QyKMDLNb6oij52rro6iS+uE
 ONHQYOo/oR13YmDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JgjW7153;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9bXfJdrM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784622074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g3p7NhHkrrkmq6Eg4P3XqhgRlLkuDdR28KUihZ1Gu3Y=;
 b=JgjW7153saTJtKK0v9/X5Ih0gQBSCZDq5VMgMP4CUIxV2aB///vDk9GIfRzTKS6otlemS2
 sK7elkMD5dom+BFg6cKYRTw7dLg/YLSa1qW5Nn3ybVZhY87vk/RDcm2kP/br8BNEixtZV3
 0Yz54CV3ADbw5vLhZAsKs4QOr9AVHkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784622074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g3p7NhHkrrkmq6Eg4P3XqhgRlLkuDdR28KUihZ1Gu3Y=;
 b=9bXfJdrMuCU+22XSWeOCZhmUryhnx8jYNRox7lGv5W4Eki0QyKMDLNb6oij52rro6iS+uE
 ONHQYOo/oR13YmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC63A779AA;
 Tue, 21 Jul 2026 08:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NfqsKPkrX2r2UgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Jul 2026 08:21:13 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ville.syrjala@intel.com, rodrigo.vivi@intel.com,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
Date: Tue, 21 Jul 2026 10:20:27 +0200
Message-ID: <20260721082108.225599-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0ECFC3E61
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[intel.com,linux.intel.com,ursulin.net,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[13];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Calling drm_atomic_helper_check_plane_damage() in plane_atomic_check()
before copying the damage information guarantees that ignore_damage_clips
from struct drm_plane_state has the correct value. Although i915 does not
directly modify or use the flag, DRM's damage iterator will soon rely on
it.

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

v2:
- move _check_plane_damage() before reading damage first time (Sashiko)
- expand commit description

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
Taken with updates from the series at

  https://lore.kernel.org/dri-devel/20260610152505.260172-1-tzimmermann@suse.de/
---
 drivers/gpu/drm/i915/display/intel_plane.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index a440f92ff00c..7d312c88a1db 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -873,6 +873,14 @@ static int plane_atomic_check(struct intel_atomic_state *state,
 		old_primary_crtc_plane_state = old_plane_state;
 	}
 
+	/*
+	 * Prepare plane-damage state before using it; do this on all
+	 * display versions to keep the underlying DRM plane state in
+	 * good shape.
+	 */
+	drm_atomic_helper_check_plane_damage(&new_plane_state->base,
+					     &new_uapi_plane_state->uapi);
+
 	intel_plane_copy_uapi_plane_damage(new_plane_state,
 					   old_primary_crtc_plane_state,
 					   new_primary_crtc_plane_state);

base-commit: fcaba3bc017906059b910ece3f83185e93010581
-- 
2.54.0

