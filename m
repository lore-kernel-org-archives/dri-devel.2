Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B0606A336
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Bb+oJzfB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kQRVExeQ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cJolHz5J;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a3eapJBs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BF9112493;
	Thu, 19 Nov 2026 14:23:11 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED43311249D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:22:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4F0381FBDB;
 Thu, 19 Nov 2026 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tft214Oeiyspd/HRLs0gkBizCT1/sKVSFca8DyYIpeA=;
 b=Bb+oJzfBZihvZT/p1dUiK1DMSbAOFNo5flTF+X1EFFzSlemcrkEH0oPDV7Xa9utzCGh8fe
 Avowi0xTjaL5N7PSyTEB50iJuZm7BuFfmsmhgvQY8fjrfBG43UE/sCDhpJI3ZO1nAieOjx
 kxldUZDjnoFCS00YaYlrj0uGPoKhBTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tft214Oeiyspd/HRLs0gkBizCT1/sKVSFca8DyYIpeA=;
 b=kQRVExeQX7cQDQW4AKVt21fFwjdA6aSLvCwaEPqEx4YM+nigQadi6l7jw2xlgOxRvARaE0
 jYsd6tedCEkpluBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cJolHz5J;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a3eapJBs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tft214Oeiyspd/HRLs0gkBizCT1/sKVSFca8DyYIpeA=;
 b=cJolHz5JmbixYtiB5Qj/ff++1j4C+QT0+U44Q7ueehulZDvQizQaAP99nEJ8C06jMfrbnF
 Z2wyHKJ46QPRkLTbaSvOMSwKW18Qd/aqy47vzH2oqRdONrTs7ZfIRuI0F4WQdNlMPu7EMh
 ZqXh4SqaSRS3o0aAAwMxuR++o9EaZGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tft214Oeiyspd/HRLs0gkBizCT1/sKVSFca8DyYIpeA=;
 b=a3eapJBstqn/dQCgDtBM4m0nSa3sGn+Q96YjG9P59vVML/5/4P0WKxCXJ16C9NvENIErPC
 cFDzYFGItA5cH0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9546134F6;
 Thu, 19 Nov 2026 14:21:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RynyAeAF/2rJfgAAD6G6ig:T8
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Nov 2026 14:21:22 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 07/11] drm/udl: Managed cleanup of URB cache
Date: Thu, 19 Nov 2026 15:02:19 +0100
Message-ID: <20261119142114.152052-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119142114.152052-1-tzimmermann@suse.de>
References: <20261119142114.152052-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F0381FBDB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,plugable.com:email,suse.de:dkim,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -10.51
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

Clean up the URB cache as part of the USB device cleanup with managed
helpers. Remove udl_drop_usb() and the clean-up code from udl_init().
All happens automatically.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.c  |  2 --
 drivers/gpu/drm/udl/udl_drv.h  |  1 -
 drivers/gpu/drm/udl/udl_main.c | 43 +++++++++++++++++-----------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 1922988625eb..f84d020a1953 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -110,10 +110,8 @@ static int udl_usb_probe(struct usb_interface *interface,
 static void udl_usb_disconnect(struct usb_interface *interface)
 {
 	struct drm_device *dev = usb_get_intfdata(interface);
-	struct udl_device *udl = to_udl(dev);
 
 	drm_dev_unplug(dev);
-	udl_drop_usb(udl);
 }
 
 /*
diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 4736d83aec9a..2722625ab7a8 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -84,7 +84,6 @@ int udl_render_hline(struct udl_device *udl, int log_bpp, struct urb **urb_ptr,
 		     const char *front, char **urb_buf_ptr,
 		     u32 byte_offset, u32 device_byte_offset, u32 byte_width);
 
-int udl_drop_usb(struct udl_device *udl);
 int udl_select_std_channel(struct udl_device *udl);
 
 #endif
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 821725cbebbe..21b85d9c7d69 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2009 Bernie Thompson <bernie@plugable.com>
  */
 
+#include <linux/device.h>
 #include <linux/unaligned.h>
 
 #include <drm/drm.h>
@@ -234,9 +235,18 @@ static void udl_free_urb_list(struct udl_device *udl)
 	wake_up_all(&udl->urbs.sleep);
 }
 
+static void udl_urb_list_release(void *data)
+{
+	struct udl_device *udl = data;
+
+	udl_free_urb_list(udl);
+}
+
 static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
 {
+	struct drm_device *drm = &udl->drm;
 	size_t wanted_size = count * size;
+	int ret;
 
 	spin_lock_init(&udl->urbs.lock);
 	INIT_LIST_HEAD(&udl->urbs.list);
@@ -266,6 +276,13 @@ static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
 		udl->urbs.available++;
 	}
 
+	if (!udl->urbs.count)
+		return -ENOMEM;
+
+	ret = devm_add_action_or_reset(drm->dev, udl_urb_list_release, udl);
+	if (ret < 0)
+		return ret;
+
 	DRM_DEBUG("allocated %d %d byte urbs\n", udl->urbs.count, (int) size);
 
 	return udl->urbs.count;
@@ -389,34 +406,18 @@ int udl_init(struct udl_device *udl)
 
 	ret = udl_parse_vendor_descriptor(udl);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (udl_select_std_channel(udl))
 		DRM_ERROR("Selecting channel failed\n");
 
-	if (!udl_alloc_urb_list(udl, WRITES_IN_FLIGHT, MAX_TRANSFER)) {
-		DRM_ERROR("udl_alloc_urb_list failed\n");
-		ret = -ENOMEM;
-		goto err;
-	}
+	ret = udl_alloc_urb_list(udl, WRITES_IN_FLIGHT, MAX_TRANSFER);
+	if (ret < 0)
+		return ret;
 
-	DRM_DEBUG("\n");
 	ret = udl_modeset_init(udl);
 	if (ret)
-		goto err;
-
-	return 0;
-
-err:
-	if (udl->urbs.count)
-		udl_free_urb_list(udl);
-	DRM_ERROR("%d\n", ret);
-	return ret;
-}
-
-int udl_drop_usb(struct udl_device *udl)
-{
-	udl_free_urb_list(udl);
+		return ret;
 
 	return 0;
 }
-- 
2.56.0

