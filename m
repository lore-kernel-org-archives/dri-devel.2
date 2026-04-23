Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E15F589B0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DA310F0EE;
	Thu, 23 Apr 2026 12:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="flo8CdkR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a1N4Qj19";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="flo8CdkR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a1N4Qj19";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B0210F0E2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:36:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B730E5BCCD;
 Thu, 23 Apr 2026 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776947798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EdmZZzyc2/PVukvOX3CGDx5zyYNkZJdymEtWXVdGPRA=;
 b=flo8CdkRknNxHxQYqYvtYdeoBLHvRYZ/5DaZ3X1zKEi+PQAsVaC7jJTS010rRWB4zX2WiL
 eoGsfofqYwzkPv+m4F6EB8KOh9DZRlRgdRWnMUn0lNT+0KaNtIjww+JJCeUWUTvJo1NDV1
 +Cinh9mtu6fes1L2pmH7V1kgvbw5v2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776947798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EdmZZzyc2/PVukvOX3CGDx5zyYNkZJdymEtWXVdGPRA=;
 b=a1N4Qj19345gJkSlmghbdqLOWjaKahruIJTACofLjPH1C5NOf1f9aBdsCSPz6jNMFmyDNP
 lqcXCm/n9MN77rCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=flo8CdkR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a1N4Qj19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776947798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EdmZZzyc2/PVukvOX3CGDx5zyYNkZJdymEtWXVdGPRA=;
 b=flo8CdkRknNxHxQYqYvtYdeoBLHvRYZ/5DaZ3X1zKEi+PQAsVaC7jJTS010rRWB4zX2WiL
 eoGsfofqYwzkPv+m4F6EB8KOh9DZRlRgdRWnMUn0lNT+0KaNtIjww+JJCeUWUTvJo1NDV1
 +Cinh9mtu6fes1L2pmH7V1kgvbw5v2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776947798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EdmZZzyc2/PVukvOX3CGDx5zyYNkZJdymEtWXVdGPRA=;
 b=a1N4Qj19345gJkSlmghbdqLOWjaKahruIJTACofLjPH1C5NOf1f9aBdsCSPz6jNMFmyDNP
 lqcXCm/n9MN77rCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89518593A3;
 Thu, 23 Apr 2026 12:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MMhOIFYS6mk/cwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 12:36:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: linux@armlinux.org.uk,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/3] drm/armada: fbdev: Use client buffers
Date: Thu, 23 Apr 2026 14:30:03 +0200
Message-ID: <20260423123635.107126-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B730E5BCCD
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

Thomas Zimmermann (3):
  drm/armada: fbdev: Calculate buffer geometry with format helpers
  drm/armada: fbdev: Use a DRM client buffer
  drm/armada: Make armada_framebuffer_create() an internal interface

 drivers/gpu/drm/armada/armada_fb.c    |  9 ++--
 drivers/gpu/drm/armada/armada_fb.h    |  3 --
 drivers/gpu/drm/armada/armada_fbdev.c | 76 +++++++++++++++------------
 3 files changed, 48 insertions(+), 40 deletions(-)

-- 
2.53.0

