Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F01F589AE
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC7910F0F0;
	Thu, 23 Apr 2026 12:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="L+bSUeYJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wNptb3LU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SwREC9N+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1qFfhwT5";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF25D10F0F0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:36:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 501706A86F;
 Thu, 23 Apr 2026 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776947800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPzlXDuykP1ToB7LlCkR8e9s3910HBfH+xDJbJGoX8I=;
 b=L+bSUeYJOa2s+NLK6+ReGrQuRq/4RDh0KONyvTdHMTebQDhOBHF9AdJA8unOzEVxTZz95e
 1NEPuTrec2sGwTB1qMnq+eApT0RJiPBmUrhN6pSyelyrsYBGdE8ifZguQQhMpa8ANERk5O
 VldIKAOERUnnbeLMdtAQQ9hpUDvEFh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776947800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPzlXDuykP1ToB7LlCkR8e9s3910HBfH+xDJbJGoX8I=;
 b=wNptb3LUMF9UhDgh8xEHgUjPSGd4UGZJCwpdmeVL0ND+afCwsP6JE4ljUo9vDX9Q5Jsvor
 X/w5p40d9Aia+3Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776947799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPzlXDuykP1ToB7LlCkR8e9s3910HBfH+xDJbJGoX8I=;
 b=SwREC9N+WsadGAe935mZWUnj3IfTp4z2c81FMNWdqxDX96YlAKKkOu9X4rnZYiyJdNhaBD
 Y7/xvYIGodgHzdntH+UtfZyYvJCMCwJzu/KEL6k8BwV24VEU98ncltisfL7/Eqdp0k+GiM
 XRSjuuxKAS6Vu3fu9TmPG4+Hzm4LJC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776947799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPzlXDuykP1ToB7LlCkR8e9s3910HBfH+xDJbJGoX8I=;
 b=1qFfhwT5c+Mz1WoDgwW0f1l8D0wp+rpTxfea1MxZkl0mSAP1Rr5aOvRCzo3TMqbT+8MDvD
 SWa/ioR1kI99SJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27946593B0;
 Thu, 23 Apr 2026 12:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UFZ0CFcS6mk/cwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 12:36:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: linux@armlinux.org.uk,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/3] drm/armada: Make armada_framebuffer_create() an internal
 interface
Date: Thu, 23 Apr 2026 14:30:06 +0200
Message-ID: <20260423123635.107126-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423123635.107126-1-tzimmermann@suse.de>
References: <20260423123635.107126-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
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

The only caller of armada_framebuffer_create() is armada_fb_create()
from the same source file. Declare the former as static.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/armada/armada_fb.c | 9 +++++----
 drivers/gpu/drm/armada/armada_fb.h | 3 ---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/armada_fb.c
index b828bba419bf..2f2348d543fd 100644
--- a/drivers/gpu/drm/armada/armada_fb.c
+++ b/drivers/gpu/drm/armada/armada_fb.c
@@ -18,10 +18,11 @@ static const struct drm_framebuffer_funcs armada_fb_funcs = {
 	.create_handle	= drm_gem_fb_create_handle,
 };
 
-struct armada_framebuffer *armada_framebuffer_create(struct drm_device *dev,
-						     const struct drm_format_info *info,
-						     const struct drm_mode_fb_cmd2 *mode,
-						     struct armada_gem_object *obj)
+static struct armada_framebuffer *
+armada_framebuffer_create(struct drm_device *dev,
+			  const struct drm_format_info *info,
+			  const struct drm_mode_fb_cmd2 *mode,
+			  struct armada_gem_object *obj)
 {
 	struct armada_framebuffer *dfb;
 	uint8_t format, config;
diff --git a/drivers/gpu/drm/armada/armada_fb.h b/drivers/gpu/drm/armada/armada_fb.h
index f2b990f055a2..0ba358ff9147 100644
--- a/drivers/gpu/drm/armada/armada_fb.h
+++ b/drivers/gpu/drm/armada/armada_fb.h
@@ -16,9 +16,6 @@ struct armada_framebuffer {
 	container_of(dfb, struct armada_framebuffer, fb)
 #define drm_fb_obj(fb) drm_to_armada_gem((fb)->obj[0])
 
-struct armada_framebuffer *armada_framebuffer_create(struct drm_device *,
-	const struct drm_format_info *info,
-	const struct drm_mode_fb_cmd2 *, struct armada_gem_object *);
 struct drm_framebuffer *armada_fb_create(struct drm_device *dev,
 	struct drm_file *dfile, const struct drm_format_info *info,
 	const struct drm_mode_fb_cmd2 *mode);
-- 
2.53.0

