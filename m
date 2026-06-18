Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9EACD98E2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B7310ED67;
	Thu, 18 Jun 2026 08:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="lygreDiy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BsTbgjrr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lygreDiy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BsTbgjrr";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4AAD10F200
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 08:43:38 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3792175EE5;
 Thu, 18 Jun 2026 08:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781772213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulJEldl8us0bMrqKR0SkZjeCHFhLfEtvx/KYBtRZ8xY=;
 b=lygreDiyVwOoCmF97Qbw+pOUZrrULwHag8/EknnwTTwzAU9p0a6aUABQ4udA3UKLCztyJ1
 JB/KDItBPQ37+tSYMrP0ioGkMP33vnCgRFONAGFx8Jq7181irYktpWCwNnAm+KI4GR6TFQ
 P5BGZe6w5jt7YNU8YVj0FZf65KBfK4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781772213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulJEldl8us0bMrqKR0SkZjeCHFhLfEtvx/KYBtRZ8xY=;
 b=BsTbgjrriOWJDl/ABLO54B4coz+faCqS8ZNjCmONSrC0i/3oPc6GkP/W6hXw1tOV1wqd7r
 JEM89RlFbuvVAqAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781772213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulJEldl8us0bMrqKR0SkZjeCHFhLfEtvx/KYBtRZ8xY=;
 b=lygreDiyVwOoCmF97Qbw+pOUZrrULwHag8/EknnwTTwzAU9p0a6aUABQ4udA3UKLCztyJ1
 JB/KDItBPQ37+tSYMrP0ioGkMP33vnCgRFONAGFx8Jq7181irYktpWCwNnAm+KI4GR6TFQ
 P5BGZe6w5jt7YNU8YVj0FZf65KBfK4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781772213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulJEldl8us0bMrqKR0SkZjeCHFhLfEtvx/KYBtRZ8xY=;
 b=BsTbgjrriOWJDl/ABLO54B4coz+faCqS8ZNjCmONSrC0i/3oPc6GkP/W6hXw1tOV1wqd7r
 JEM89RlFbuvVAqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E09F3779A8;
 Thu, 18 Jun 2026 08:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2FqhNbSvM2pAPwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 18 Jun 2026 08:43:32 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 2/4] drm/sysfb: Avoid possible truncation with calculating
 visible size
Date: Thu, 18 Jun 2026 10:41:58 +0200
Message-ID: <20260618084327.46567-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618084327.46567-1-tzimmermann@suse.de>
References: <20260618084327.46567-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[10]; TO_DN_SOME(0.00)[];
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

Calculating the visible size of the system framebuffer can result in
truncation of the result. The calculation uses 32-bit arithmetics,
which can overflow if the values for height and stride are large. Fix
the issue by multiplying with mul_u32_u32().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260617114027.1F2A71F000E9@smtp.kernel.org/
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
---
I've added Reported-by and Closes tags because this is a pre-existing issue.
---
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
index 361b7233600c..8b14eaa304c0 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
@@ -2,6 +2,7 @@
 
 #include <linux/export.h>
 #include <linux/limits.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/screen_info.h>
 
@@ -67,7 +68,7 @@ EXPORT_SYMBOL(drm_sysfb_get_stride_si);
 u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
 				  unsigned int height, unsigned int stride, u64 size)
 {
-	u64 vsize = height * stride;
+	u64 vsize = mul_u32_u32(height, stride);
 
 	return drm_sysfb_get_validated_size0(dev, "visible size", vsize, size);
 }
-- 
2.54.0

