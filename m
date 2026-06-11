Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAB6CD8CB9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E81110ED15;
	Thu, 11 Jun 2026 07:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="oiqd8Eg0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LtcNgLwi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oiqd8Eg0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LtcNgLwi";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D3E10ED15
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:21:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 355236AF1A;
 Thu, 11 Jun 2026 07:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781162488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qakiofYhKcESnKCrdto0FQXS6xwjtj4MCZT4kXoO/mo=;
 b=oiqd8Eg0SaZ2Bp8KlmCkcpXxvzWf/2COrOfyLgQMfavZLFjLM92NxeJKluF2YDnVQ8Tvxu
 hBT0Njj0z4K1gIMIdKOd66oaccHBSoIwz2gEjLXj6QBgn9aLSHCzdzhi5DIZqKVF1K6X7a
 o9tlYQjL6g5Q59usdGUXMo06JbtjNUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781162488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qakiofYhKcESnKCrdto0FQXS6xwjtj4MCZT4kXoO/mo=;
 b=LtcNgLwicW2kb8rDtzs53C0i6sN5JL6qXGRa3Msf7BMs1y5wWCzE/C2tRfJlNyzWzU9TGF
 CWI44Oy0nq4SltDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781162488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qakiofYhKcESnKCrdto0FQXS6xwjtj4MCZT4kXoO/mo=;
 b=oiqd8Eg0SaZ2Bp8KlmCkcpXxvzWf/2COrOfyLgQMfavZLFjLM92NxeJKluF2YDnVQ8Tvxu
 hBT0Njj0z4K1gIMIdKOd66oaccHBSoIwz2gEjLXj6QBgn9aLSHCzdzhi5DIZqKVF1K6X7a
 o9tlYQjL6g5Q59usdGUXMo06JbtjNUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781162488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qakiofYhKcESnKCrdto0FQXS6xwjtj4MCZT4kXoO/mo=;
 b=LtcNgLwicW2kb8rDtzs53C0i6sN5JL6qXGRa3Msf7BMs1y5wWCzE/C2tRfJlNyzWzU9TGF
 CWI44Oy0nq4SltDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F029C779A9;
 Thu, 11 Jun 2026 07:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iLxtOfdhKmqKKAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 11 Jun 2026 07:21:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: linux@armlinux.org.uk, airlied@gmail.com, simona@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/3] drm/armada: Make armada_framebuffer_create() an
 internal interface
Date: Thu, 11 Jun 2026 09:20:13 +0200
Message-ID: <20260611072121.71492-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611072121.71492-1-tzimmermann@suse.de>
References: <20260611072121.71492-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com,ffwll.ch,kernel.org,linux.intel.com];
 RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLeer19tzumyaughgdh7h6uhe9)];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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
2.54.0

