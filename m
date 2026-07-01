Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8D3C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D0F10E3E8;
	Wed,  1 Jul 2026 13:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="JIYPd0Nr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QR3r83Z2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JIYPd0Nr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QR3r83Z2";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD5710E3A6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 13:09:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 859C373BE5;
 Wed,  1 Jul 2026 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782911375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wt51QxejWjuu6bJtZgDESWH3vxx2i2i9ZOd+J9IuiwY=;
 b=JIYPd0NrDESaEC0NmfQ+rZ5XyecpBvPWMDTxc6jV6/+1pUSOzxREXC2J1e55hXlxiyZc5r
 sfPKKWwvoyQiUBcavtmdAQ0aws6VuR0NjZKGm2/vVRh0GMx+rA8y9jnycbb+0bNQDMPKb9
 TYiEVN9LntdlVhuL6qz2vCWaQCLZYO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782911375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wt51QxejWjuu6bJtZgDESWH3vxx2i2i9ZOd+J9IuiwY=;
 b=QR3r83Z2uF0BF+d9qP9zrIfvuNV4aYpVVBpNOWgFn+sQkkZf1pmkdFEnJj+B5VwcIkRsno
 KWrVa8WKhZyZOCBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782911375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wt51QxejWjuu6bJtZgDESWH3vxx2i2i9ZOd+J9IuiwY=;
 b=JIYPd0NrDESaEC0NmfQ+rZ5XyecpBvPWMDTxc6jV6/+1pUSOzxREXC2J1e55hXlxiyZc5r
 sfPKKWwvoyQiUBcavtmdAQ0aws6VuR0NjZKGm2/vVRh0GMx+rA8y9jnycbb+0bNQDMPKb9
 TYiEVN9LntdlVhuL6qz2vCWaQCLZYO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782911375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wt51QxejWjuu6bJtZgDESWH3vxx2i2i9ZOd+J9IuiwY=;
 b=QR3r83Z2uF0BF+d9qP9zrIfvuNV4aYpVVBpNOWgFn+sQkkZf1pmkdFEnJj+B5VwcIkRsno
 KWrVa8WKhZyZOCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A22F779AA;
 Wed,  1 Jul 2026 13:09:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HduLDI8RRWrucwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 01 Jul 2026 13:09:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
Date: Wed,  1 Jul 2026 15:07:23 +0200
Message-ID: <20260701130929.234695-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.990];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Git commit 35ed38d58257 ("drm: Allow drivers to indicate the damage
helpers to ignore damage clips") introduced ignore_damage_clips to
selectively ignore damage clipping in certain framebuffer changes. The
mode-setting pipeline can disabled damage clippings for an atomic commit
by setting ignore_damage_clips in struct drm_plane_state. The atomic
commit will then do a full display update.

Although the i915 driver does not modify the flag, DRM's damage iterator
will soon rely on it. Calling drm_atomic_helper_check_plane_damage() right
before drm_atomic_helper_damage_merged() guarantees that it has the correct
state. The i915 driver does not do this elsewhere so far.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
Taken with minor updates to the commit description from the series at

  https://lore.kernel.org/dri-devel/20260610152505.260172-1-tzimmermann@suse.de/
---
 drivers/gpu/drm/i915/display/intel_psr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 92af21d823a3..5a155f60110f 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2949,6 +2949,9 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		src = drm_plane_state_src(&new_plane_state->uapi);
 		drm_rect_fp_to_int(&src, &src);
 
+		/* Prepare plane-damage state before using it */
+		drm_atomic_helper_check_plane_damage(&state->base, &new_plane_state->uapi);
+
 		if (!drm_atomic_helper_damage_merged(&old_plane_state->uapi,
 						     &new_plane_state->uapi, &damaged_area))
 			continue;
-- 
2.54.0

