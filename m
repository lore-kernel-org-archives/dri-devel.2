Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF3606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iRUzcfEC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yzwrFknr;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iRUzcfEC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yzwrFknr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F0B112481;
	Thu, 19 Nov 2026 14:22:18 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C3D10E87E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:21:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1143F224A8;
 Thu, 19 Nov 2026 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCvgNNzNzAU8oVlxPQCllxA4ysYrcHXBADOlpckeK7s=;
 b=iRUzcfEC5Cn4cC1I2fsSJwraRDjhLa5bJOl+fzZU6DDwRKTUvJxzgmUiitiF7NqW935LK+
 KGdRCo1pIhHWZ68olYhJczW37b9TiwnNXwXF/iIbKjj3SqSpUEspuYOYdTMCOD49dosts/
 cnsETlyGAd06sW1rZG/ob+m7GwkzdZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCvgNNzNzAU8oVlxPQCllxA4ysYrcHXBADOlpckeK7s=;
 b=yzwrFknrlecDI7xEYYF8wIzNV8SqknkVVBIt7vb9089Ypljd7TwxNPC4UxllgwxQNXr89q
 lyW0Ijd+BSUpjkCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iRUzcfEC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yzwrFknr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCvgNNzNzAU8oVlxPQCllxA4ysYrcHXBADOlpckeK7s=;
 b=iRUzcfEC5Cn4cC1I2fsSJwraRDjhLa5bJOl+fzZU6DDwRKTUvJxzgmUiitiF7NqW935LK+
 KGdRCo1pIhHWZ68olYhJczW37b9TiwnNXwXF/iIbKjj3SqSpUEspuYOYdTMCOD49dosts/
 cnsETlyGAd06sW1rZG/ob+m7GwkzdZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCvgNNzNzAU8oVlxPQCllxA4ysYrcHXBADOlpckeK7s=;
 b=yzwrFknrlecDI7xEYYF8wIzNV8SqknkVVBIt7vb9089Ypljd7TwxNPC4UxllgwxQNXr89q
 lyW0Ijd+BSUpjkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97E8A13510;
 Thu, 19 Nov 2026 14:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RynyAeAF/2rJfgAAD6G6ig:T10
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Nov 2026 14:21:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 09/11] drm/udl: Synchronize pending URBs on each frame
Date: Thu, 19 Nov 2026 15:02:21 +0100
Message-ID: <20261119142114.152052-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119142114.152052-1-tzimmermann@suse.de>
References: <20261119142114.152052-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-10.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,poorly.run,suse.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -10.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 1143F224A8
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

Wait for in-flight URBs from the previous frame before sending out
the current frame. Throttles frame rate to USB limits.

PC display usually runs with a refresh rate of 60 Hz or more. Sending
out URBs for each frame at this rate easily overloads the USB. This
results in display lag up to several seconds. Udl currently avoids
this by limiting the number of URBs to 20 at a time. This prevents
overloading the USB, but also prevents udl from using all the
bandwidth available.

Solving this requires more flexibility in the number of in-flight
URBs. The exact value depends on the framebuffer configuration and
the available bandwidth on the USB.

Before removing the limit on the URB count, add another means of
synchronizing the frame rate to the USB. Do this in atomic_begin, so
that the USB has the maximum time between sending two frames.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_modeset.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index bbba1dee8e4f..caa0a117e3c2 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -329,6 +329,23 @@ static const struct drm_plane_funcs udl_primary_plane_funcs = {
  * CRTC
  */
 
+static void udl_crtc_helper_atomic_begin(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct drm_device *dev = crtc->dev;
+	struct udl_device *udl = to_udl(dev);
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
+
+	/*
+	 * It is acceptable to briefly block in this call, but
+	 * having it timeout frequently indicates a problem.
+	 */
+	udl_sync_pending_urbs(udl);
+	drm_dev_exit(idx);
+}
+
 static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 {
 	struct drm_device *dev = crtc->dev;
@@ -395,6 +412,7 @@ static void udl_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_ato
 
 static const struct drm_crtc_helper_funcs udl_crtc_helper_funcs = {
 	.atomic_check = drm_crtc_helper_atomic_check,
+	.atomic_begin = udl_crtc_helper_atomic_begin,
 	.atomic_enable = udl_crtc_helper_atomic_enable,
 	.atomic_disable = udl_crtc_helper_atomic_disable,
 };
-- 
2.56.0

