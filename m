Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10ACFCD3445
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 07:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38A510E41E;
	Thu,  7 May 2026 07:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="QeStYHZy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LvbIYvx9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QeStYHZy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LvbIYvx9";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1188B10E030
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 07:57:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B5C9D5D353;
 Thu,  7 May 2026 07:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778140650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6pllsNOZ2gawk2OziatCgyMCSrtk5u8hHJAp8POW0M=;
 b=QeStYHZyp/H5Ko8Krujwf0knkinfngRwsv1mMqjT05b5Rzomv+4TJ4XBrOIJL1wapVkoNj
 FBF0pESzDNn2B33xGtdVlQP22ZcmFM94TG78vgN/xpt8SH4nFQ8Wo8Hs3aZTSwHdDCECLT
 A6vMqhRp7d8XNMwSihOYLDO9KZA9N1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778140650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6pllsNOZ2gawk2OziatCgyMCSrtk5u8hHJAp8POW0M=;
 b=LvbIYvx9YHmaVd4psSMAwuszlLK/Q2dhFNNWfsuFVOf97agWCKNcXZQJWTUSdd/9wiJh3I
 pKgwRwFXSrX/jeAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778140650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6pllsNOZ2gawk2OziatCgyMCSrtk5u8hHJAp8POW0M=;
 b=QeStYHZyp/H5Ko8Krujwf0knkinfngRwsv1mMqjT05b5Rzomv+4TJ4XBrOIJL1wapVkoNj
 FBF0pESzDNn2B33xGtdVlQP22ZcmFM94TG78vgN/xpt8SH4nFQ8Wo8Hs3aZTSwHdDCECLT
 A6vMqhRp7d8XNMwSihOYLDO9KZA9N1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778140650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6pllsNOZ2gawk2OziatCgyMCSrtk5u8hHJAp8POW0M=;
 b=LvbIYvx9YHmaVd4psSMAwuszlLK/Q2dhFNNWfsuFVOf97agWCKNcXZQJWTUSdd/9wiJh3I
 pKgwRwFXSrX/jeAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CBED593A8;
 Thu,  7 May 2026 07:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WDxoDepF/GnZJAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 07 May 2026 07:57:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org, maarten.lankhorst@linux.intel.com, airlied@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, admin@kodeit.net,
 gargaditya08@proton.me, paul@crapouillou.net, zack.rusin@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: [PATCH 01/10] drm/damage-helper: Do not alter damage clips on modeset,
 but ignore them
Date: Thu,  7 May 2026 09:12:20 +0200
Message-ID: <20260507075725.29738-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507075725.29738-1-tzimmermann@suse.de>
References: <20260507075725.29738-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCPT_COUNT_TWELVE(0.00)[18]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,broadcom.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqqu4k9zio1uathxs7idfp4sa)];
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

User space supplies rectangles for damage clipping in a plane property.
For full mode sets, we still require a full plane update. In this case,
leave the information as-is and set the ignore_damage_clips flag instead.
The damage iterator will later ignore any damage information.

Also fixes a bug where ignore_damage_clips was not cleared across plane
duplications.

Leaving the damage information as-is might be helpful to drivers that
benefit from it even on full modesets (e.g., for cache management). It
will also help with consolidating the damage-handling logic.

Also add a new unit test that evaluates the ignore_damage_clips flag. It
sets two damage clips plus the flag and tests if the reported damage
covers the entire framebuffer.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/drm_atomic_state_helper.c     |  1 +
 drivers/gpu/drm/drm_damage_helper.c           |  6 ++--
 .../gpu/drm/tests/drm_damage_helper_test.c    | 28 +++++++++++++++++++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 76746ad4a1bb..42f25b273dac 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -359,6 +359,7 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
 	state->fence = NULL;
 	state->commit = NULL;
 	state->fb_damage_clips = NULL;
+	state->ignore_damage_clips = false;
 	state->color_mgmt_changed = false;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index 1b6850aa1688..85e20f83f757 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -78,10 +78,8 @@ void drm_atomic_helper_check_plane_damage(struct drm_atomic_state *state,
 		if (WARN_ON(!crtc_state))
 			return;
 
-		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
-			drm_property_blob_put(plane_state->fb_damage_clips);
-			plane_state->fb_damage_clips = NULL;
-		}
+		if (drm_atomic_crtc_needs_modeset(crtc_state))
+			plane_state->ignore_damage_clips = true;
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_check_plane_damage);
diff --git a/drivers/gpu/drm/tests/drm_damage_helper_test.c b/drivers/gpu/drm/tests/drm_damage_helper_test.c
index 0df2e1a54b0d..64f038a62ffe 100644
--- a/drivers/gpu/drm/tests/drm_damage_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c
@@ -603,6 +603,33 @@ static void drm_test_damage_iter_damage_not_visible(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should not return any damage.");
 }
 
+static void drm_test_damage_iter_damage_ignore(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage[2];
+	struct drm_rect clip;
+	u32 num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	/* 2 damage clips, but ignore them. */
+	set_damage_clip(&damage[0], 20, 30, 200, 180);
+	set_damage_clip(&damage[1], 240, 200, 280, 250);
+	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	mock->state.ignore_damage_clips = true;
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip) {
+		if (num_hits == 0)
+			check_damage_clip(test, &clip, 0, 0, 1024, 768);
+		num_hits++;
+	}
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return full-framebuffer damage.");
+}
+
 static struct kunit_case drm_damage_helper_tests[] = {
 	KUNIT_CASE(drm_test_damage_iter_no_damage),
 	KUNIT_CASE(drm_test_damage_iter_no_damage_fractional_src),
@@ -625,6 +652,7 @@ static struct kunit_case drm_damage_helper_tests[] = {
 	KUNIT_CASE(drm_test_damage_iter_damage_one_outside),
 	KUNIT_CASE(drm_test_damage_iter_damage_src_moved),
 	KUNIT_CASE(drm_test_damage_iter_damage_not_visible),
+	KUNIT_CASE(drm_test_damage_iter_damage_ignore),
 	{ }
 };
 
-- 
2.54.0

