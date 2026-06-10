Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E18ECD98D6
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13ECC10EA7F;
	Wed, 10 Jun 2026 15:25:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="UPlsKJOw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7FpMHr4e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UPlsKJOw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7FpMHr4e";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5B010EA8E
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:25:33 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E47416AEA8;
 Wed, 10 Jun 2026 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781105119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFESXTPcE3Y+rjrUnIDIihl7ns8gRcpEocg6I0wkelM=;
 b=UPlsKJOwz0OtoxvOQUccXAF3ETu2oy6z1kdiA7LLNhbaKRIqoFYx0yt6+avqbyk6VTz7Ay
 W2h6hgMycHHK/8f6IPptElkzePQmuP3gtEK6xpKEpxkvabC31OUvjXr9G5D17KTO1QPBQT
 pazgzdTzWXqmrJgFVJY3U3N1aQ176dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781105119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFESXTPcE3Y+rjrUnIDIihl7ns8gRcpEocg6I0wkelM=;
 b=7FpMHr4ewgDGbhKphuteZT8SXxUORYW1dm1zPKQcopgTz96a689V0Mf2d4zXgIHkEWC0uE
 up4RiPKp/tn51EBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781105119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFESXTPcE3Y+rjrUnIDIihl7ns8gRcpEocg6I0wkelM=;
 b=UPlsKJOwz0OtoxvOQUccXAF3ETu2oy6z1kdiA7LLNhbaKRIqoFYx0yt6+avqbyk6VTz7Ay
 W2h6hgMycHHK/8f6IPptElkzePQmuP3gtEK6xpKEpxkvabC31OUvjXr9G5D17KTO1QPBQT
 pazgzdTzWXqmrJgFVJY3U3N1aQ176dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781105119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFESXTPcE3Y+rjrUnIDIihl7ns8gRcpEocg6I0wkelM=;
 b=7FpMHr4ewgDGbhKphuteZT8SXxUORYW1dm1zPKQcopgTz96a689V0Mf2d4zXgIHkEWC0uE
 up4RiPKp/tn51EBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05B7E779A9;
 Wed, 10 Jun 2026 15:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6HoBAN+BKWr3HwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org, maarten.lankhorst@linux.intel.com, airlied@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, admin@kodeit.net,
 gargaditya08@proton.me, paul@crapouillou.net, jani.nikula@linux.intel.com,
 mhklkml@zohomail.com, zack.rusin@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, javierm@redhat.com, dmitry.osipenko@collabora.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v5 09/15] drm/ingenic: Remove calls to
 drm_atomic_helper_check_plane_damage()
Date: Wed, 10 Jun 2026 17:18:25 +0200
Message-ID: <20260610152505.260172-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610152505.260172-1-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.79 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.19)[-0.934]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_TWELVE(0.00)[31]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,zohomail.com,broadcom.com,amd.com,igalia.com,intel.com,ursulin.net,collabora.com,chromium.org];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLq3cifbxyhc6qbbynzfc6amns)];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

Atomic helpers call drm_atomic_helper_check_plane_damage() after the
atomic_check anyway. See atomic_helper_check_planes(). Remove the calls
from the planes' atomic_check.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 3 ---
 drivers/gpu/drm/ingenic/ingenic-ipu.c     | 8 ++------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66..e99b44e3ac92 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -519,9 +519,6 @@ static int ingenic_drm_plane_atomic_check(struct drm_plane *plane,
 	     old_plane_state->fb->format->format != new_plane_state->fb->format->format))
 		crtc_state->mode_changed = true;
 
-	if (priv->soc_info->map_noncoherent)
-		drm_atomic_helper_check_plane_damage(state, new_plane_state);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index 56143a191f36..fd17c642c7ac 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -594,7 +594,7 @@ static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
 
 	if (!new_plane_state->crtc ||
 	    !crtc_state->mode.hdisplay || !crtc_state->mode.vdisplay)
-		goto out_check_damage;
+		return 0;
 
 	/* Plane must be fully visible */
 	if (new_plane_state->crtc_x < 0 || new_plane_state->crtc_y < 0 ||
@@ -611,7 +611,7 @@ static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
 		return -EINVAL;
 
 	if (!osd_changed(new_plane_state, old_plane_state))
-		goto out_check_damage;
+		return 0;
 
 	crtc_state->mode_changed = true;
 
@@ -645,10 +645,6 @@ static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
 	ipu_state->denom_w = denom_w;
 	ipu_state->denom_h = denom_h;
 
-out_check_damage:
-	if (ingenic_drm_map_noncoherent(ipu->master))
-		drm_atomic_helper_check_plane_damage(state, new_plane_state);
-
 	return 0;
 }
 
-- 
2.54.0

