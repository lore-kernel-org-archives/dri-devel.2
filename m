Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7839BCD6E57
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3821133ED;
	Mon,  1 Jun 2026 14:19:43 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E95C1133ED
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 14:19:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83BE7676DD;
 Mon,  1 Jun 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E0D779A7;
 Mon,  1 Jun 2026 14:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aN1ICPGUHWpSdwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 01 Jun 2026 14:19:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch, michel.daenzer@mailbox.org, louis.chauvet@bootlin.com,
 ville.syrjala@linux.intel.com, jani.nikula@intel.com, mhklkml@zohomail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/7] drm/vblank: timer: Estimate vblank timeout if timer is
 disabled
Date: Mon,  1 Jun 2026 16:08:33 +0200
Message-ID: <20260601141922.91498-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601141922.91498-1-tzimmermann@suse.de>
References: <20260601141922.91498-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 83BE7676DD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
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

Estimate the next vblank timeout from the duration of a frame in
the currently programmed display mode. Timeouts are aligned to
frame duration, so we can round up to the next alignment.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index cecaef98aa52..b5d2fb741b2d 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2333,6 +2333,17 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 			return false; /* already expired */
 
 		framedur_ns = vblank->framedur_ns;
+	} else if (mode->crtc_clock) {
+		u64 framesize = mode->crtc_htotal * mode->crtc_vtotal;
+
+		/*
+		 * With the vblank timer being disabled, we don't have an
+		 * expiry time. As the timeouts are aligned to the display
+		 * mode's clock, we can estimate when the expiry time would
+		 * have been.
+		 */
+		framedur_ns = div_u64(framesize * 1000000llu, mode->crtc_clock);
+		*vblank_time = roundup(ktime_get_ns(), framedur_ns);
 	} else {
 		return false;
 	}
-- 
2.54.0

