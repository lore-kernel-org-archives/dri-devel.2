Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D56ACD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B4710ED11;
	Thu, 11 Jun 2026 07:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="gS+MPuqZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HaGuSzRh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gS+MPuqZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HaGuSzRh";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF5110ED11
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:21:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 691CE6AA66;
 Thu, 11 Jun 2026 07:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781162487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aYEBBbn+Wnkh4gQD2SQQPbQ7+dBTTBc5KTK0yKm/NJg=;
 b=gS+MPuqZGj5cmWvtjtHUkZlOhL4xDVSFgBA77beudS1vDUeoZt7cW9HbfQuKFvLHm8ppYb
 WpsjZMtHH4EcQ1m84XbGS+ZQGdIL8PwwU8azCXV0b2SbNF/HvUmYKKahXD6yLYAkNJdQwt
 +8/5dD+/Hzfd8BkNC+Svp5AKN9OCthM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781162487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aYEBBbn+Wnkh4gQD2SQQPbQ7+dBTTBc5KTK0yKm/NJg=;
 b=HaGuSzRh/1c6klBZ/U1L6LSJTtqLXUzlL7pusf1BlvrgNf15ybB4yWA9NalHeNKn8VDhST
 R2VaD0BvNoK+2sCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781162487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aYEBBbn+Wnkh4gQD2SQQPbQ7+dBTTBc5KTK0yKm/NJg=;
 b=gS+MPuqZGj5cmWvtjtHUkZlOhL4xDVSFgBA77beudS1vDUeoZt7cW9HbfQuKFvLHm8ppYb
 WpsjZMtHH4EcQ1m84XbGS+ZQGdIL8PwwU8azCXV0b2SbNF/HvUmYKKahXD6yLYAkNJdQwt
 +8/5dD+/Hzfd8BkNC+Svp5AKN9OCthM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781162487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aYEBBbn+Wnkh4gQD2SQQPbQ7+dBTTBc5KTK0yKm/NJg=;
 b=HaGuSzRh/1c6klBZ/U1L6LSJTtqLXUzlL7pusf1BlvrgNf15ybB4yWA9NalHeNKn8VDhST
 R2VaD0BvNoK+2sCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D073779A7;
 Thu, 11 Jun 2026 07:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VYGWCfdhKmqKKAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 11 Jun 2026 07:21:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: linux@armlinux.org.uk, airlied@gmail.com, simona@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/3] drm/armada: fbdev: Use client buffers
Date: Thu, 11 Jun 2026 09:20:10 +0200
Message-ID: <20260611072121.71492-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com,ffwll.ch,kernel.org,linux.intel.com];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
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

A client buffer holds the DRM framebuffer for an in-kernel DRM
client. Until now, armada created an internal ad-hoc framebuffer for
its fbdev emulation, while by-passing the regular interfaces used by
user-space compositors.

Convert armada's fbdev emulation to use client buffers. Replacing the
existing code with a client buffer allows for stream-lining armada code
and later also the fbdev helpers. The new framebuffer will be registered
against the client's file and will support handles for GEM objects. It
is then just another framebuffer within the DRM ecosystem.

If all driver's fbdev-emulation helpers can be converted to use client
buffers, the emulation's framebuffer handling as a whole can possibly be
moved into shared helpers.

Patches 1 and 2 convert armada's fbdev emulation to client buffers. It
still allocates a GEM object buffer tailored towards fbdev emulation,
but size calculations now use common DRM helpers.

Patch 3 cleans up symbol visibility in armada's fb code.

v2:
- add more error checks to geometry calculations

Thomas Zimmermann (3):
  drm/armada: fbdev: Calculate buffer geometry with format helpers
  drm/armada: fbdev: Use a DRM client buffer
  drm/armada: Make armada_framebuffer_create() an internal interface

 drivers/gpu/drm/armada/armada_fb.c    |  9 +--
 drivers/gpu/drm/armada/armada_fb.h    |  3 -
 drivers/gpu/drm/armada/armada_fbdev.c | 86 +++++++++++++++++----------
 3 files changed, 58 insertions(+), 40 deletions(-)


base-commit: fc59f76558703febba8056be87d1c97d14f7485e
-- 
2.54.0

