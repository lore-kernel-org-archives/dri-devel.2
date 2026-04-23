Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B65F589D9
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1DE10F14C;
	Thu, 23 Apr 2026 14:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="wwUtoqXH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hDyLEh2C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MvrFTTHw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hYBAHQUt";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A4F10F146
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:00:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9D476A860;
 Thu, 23 Apr 2026 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776952835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=r7u7TyjdVm/WiPqVpu1Zm4ABytLiQO8ZN2iAdR0zhnE=;
 b=wwUtoqXHhp4eb0uh+2/cHL7Wje3bMZVbtglmGhRIuqOzN5Ck7DaeFF3qqAWJ8TF7yGCLyk
 M3Zm9vRjE4UPA/zGmbNJ7mctSb78sk9IIodesi+6te17CzzUC/CW1yDGF8KlbcVmG/nEAI
 /qopRZqzEDTW3BM1/c/SdBMFYjp9suo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776952835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=r7u7TyjdVm/WiPqVpu1Zm4ABytLiQO8ZN2iAdR0zhnE=;
 b=hDyLEh2CoprEPJldTT33cwYYr5B+KKAif5u7bS5Gts5jdL9Z2dbH/zdVcW5qEqTQvhaQmd
 GGqcBJ8OXegEqqDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776952834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=r7u7TyjdVm/WiPqVpu1Zm4ABytLiQO8ZN2iAdR0zhnE=;
 b=MvrFTTHwtbboqpNXFja4rncDPHvjOq7+4D/jAWVQMWiNLt5IV0SEtL4jQBIMbjWTY+cH6L
 4lVuoMbXoxiVUJDv8UdUO18enRZ9wwMEQhgGqKO8bKVm4E7gbKOGr3csnjirN4th8CMtUG
 K6s8mTTItJq+cDPlr8J8ZI7hEZOHyIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776952834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=r7u7TyjdVm/WiPqVpu1Zm4ABytLiQO8ZN2iAdR0zhnE=;
 b=hYBAHQUtM+FVkdr0ltZASZncCN+X2dhV+tu/vZ7ZtWutpHd2aFpS9LgMW5SmBiH7kKMlXW
 P4VTfbfCWSBO+3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B54BE593A3;
 Thu, 23 Apr 2026 14:00:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VocQKwIm6mlCTwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 14:00:34 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/3] drm/omapdrm: fbdev: Use client buffers
Date: Thu, 23 Apr 2026 15:58:06 +0200
Message-ID: <20260423140031.126072-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[ideasonboard.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
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
client. Until now, omapdrm created an internal ad-hoc framebuffer for
its fbdev emulation, while by-passing the regular interfaces used by
user-space compositors.

Convert omapdrm's fbdev emulation to use client buffers. Replacing the
existing code with a client buffer allows for stream-lining omapdrm code
and later also the fbdev helpers. The new framebuffer will be registered
against the client's file and will support handles for GEM objects. It
is then just another framebuffer within the DRM ecosystem.

If all driver's fbdev-emulation helpers can be converted to use client
buffers, the emulation's framebuffer handling as a whole can possibly be
moved into shared helpers.

Patches 1 and 2 convert omapdrm's fbdev emulation to client buffers. It
still allocates a GEM object buffer tailored towards fbdev emulation,
but size calculations now use common DRM helpers.

Patch 3 cleans up symbol visibility in omapdrm's fb code.

Thomas Zimmermann (3):
  drm/omapdrm: fbdev: Calculate buffer geometry with format helpers
  drm/omapdrm: fbdev: Use a DRM client buffer
  drm/omapdrm: Make omap_framebuffer_init() an internal interface

 drivers/gpu/drm/omapdrm/omap_fb.c    | 68 +++++++++----------
 drivers/gpu/drm/omapdrm/omap_fb.h    |  3 -
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 98 +++++++++++++++-------------
 3 files changed, 88 insertions(+), 81 deletions(-)

-- 
2.53.0

