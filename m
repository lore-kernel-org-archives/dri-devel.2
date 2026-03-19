Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C609D1090247
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047E410E968;
	Thu, 19 Mar 2026 16:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="uBP0peD/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="30TzAgfF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YX1Yj8gQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3il4xpAU";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3029810E90A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:01:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FC514D291;
 Thu, 19 Mar 2026 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jEwm6rtCtR3eIeF15NC7runqliZ+l7GBh/NY0X8KRkI=;
 b=uBP0peD/BvMCGQBx32JwYv9GcCvbQqffKfvc5dIos8obXDUkCmZXVpR5y1PPvtG0aYjrmV
 xSgHFNncez6cQeX53lW9p3kOz6NlAqMfO5t8pwRBXPwsfA+P6+G+GhocRT/tpjaPavS44Y
 6tqovckutToLAFrU5kzhtou+5skPC4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jEwm6rtCtR3eIeF15NC7runqliZ+l7GBh/NY0X8KRkI=;
 b=30TzAgfFAcMc+0+CE2hRtOdYy4yP8Q6SidkME+XhJUaW3iVvN6Sa/qcqGBiuUGJc0wZD0l
 3DP40iuL1YkvScAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YX1Yj8gQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3il4xpAU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jEwm6rtCtR3eIeF15NC7runqliZ+l7GBh/NY0X8KRkI=;
 b=YX1Yj8gQngH/CNKfGwTXSYeZs46kADl2zNfNakYWk4gCUoN9QL+AK0LoykUrG6GwtAJJyB
 MLsF0EKMhT2svSQgVGhyN6oN2YXtZQOW6+HGFvPPXQu3+O2yXURFNuGB3ElORlxcowU6XL
 y3J3GZ39xVAfteRnbiowKF8fLqGfVYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jEwm6rtCtR3eIeF15NC7runqliZ+l7GBh/NY0X8KRkI=;
 b=3il4xpAUxxHSSjM90qzLSownUki0x9GirnlovVwSe5i0r8ZZVKDLOO2G3NpetxbChimQ9S
 AkHeEXTjdU7BWpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A9954273B;
 Thu, 19 Mar 2026 16:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0FrEEModvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:14 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 00/16] drm/mipi-dbi: Replace simple-display helpers with
 regular atomic helpers
Date: Thu, 19 Mar 2026 16:59:36 +0100
Message-ID: <20260319160110.109610-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWELVE(0.00)[12];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9FC514D291
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

We keep getting new drivers based on the obsolete simple-display pipeline,
such as the recent driver for st7789v panels. [1] But submitters cannot
know, as the simple-display helpers are fully documented and still used
in several places.

Hence, convert all the mipi-dbi drivers over to regular atomic helpers
and remove simple-display support from mipi-dbi in this series. Then
undocument the helpers and add TODO items for final their removal.

Patch 1 changes the mode-setting logic to get CRTC and panel updates into
the correct order. This patch is probably the most fragile change in the
series.

Patches 2 and 3 prepare mipi-dbi to allow for atomic helpers to be used.

Patches 5 to 14 update mipi-dbi drivers one by one. The st7735r driver
requires some additional minor preparation. Overall, the refactoring is
always the same.

Patches 15 and 16 clean up mipi-dbi and the simple-display helpers.

These patches need some testing, as I can only compile them. At least
one of the drivers should be tried on hardware. Regressions should be
easy to fix, as these changes are mostly refactoring jobs.

[1] https://lore.kernel.org/dri-devel/20260221071351.22772-1-architanant5@gmail.com/

v3:
- fix uninitialized variables (David)
- improve documentation (David)
- clean up
v2:
- fix connector initialization (David)
- remove unused variables (David)
- clean up

Thomas Zimmermann (16):
  drm/mipi-dbi: Only modify planes on enabled CRTCs
  drm/mipi-dbi: Support custom pipelines with drm_mipi_dbi_dev_init()
  drm/mipi-dbi: Provide callbacks for atomic interfaces
  drm/hx8357d: Use regular atomic helpers; drop simple-display helpers
  drm/ili9163: Use regular atomic helpers; drop simple-display helpers
  drm/ili9225: Use regular atomic helpers; drop simple-display helpers
  drm/ili9341: Use regular atomic helpers; drop simple-display helpers
  drm/ili9486: Use regular atomic helpers; drop simple-display helpers
  drm/mi0283qt: Use regular atomic helpers; drop simple-display helpers
  drm/panel-mipi-dbi: Use regular atomic helpers; drop simple-display
    helpers
  drm/st7586: Use regular atomic helpers; drop simple-display helpers
  drm/st7735r: Rename struct st7735r_priv to struct st7735r_device
  drm/st7735r: Rename priv variable to st7735r
  drm/st7735r: Use regular atomic helpers; drop simple-display helpers
  drm/mipi-dbi: Remove simple-display helpers from mipi-dbi
  drm/simple-kms: Deprecate simple-kms helpers

 Documentation/gpu/drm-kms-helpers.rst   |  12 -
 Documentation/gpu/introduction.rst      |   6 -
 Documentation/gpu/todo.rst              |  32 ++
 drivers/gpu/drm/drm_crtc.c              |   6 +-
 drivers/gpu/drm/drm_gem_atomic_helper.c |  22 --
 drivers/gpu/drm/drm_mipi_dbi.c          | 376 ++++++++----------------
 drivers/gpu/drm/drm_modeset_helper.c    |   3 -
 drivers/gpu/drm/drm_simple_kms_helper.c |  83 ------
 drivers/gpu/drm/sitronix/st7586.c       | 185 +++++++++---
 drivers/gpu/drm/sitronix/st7735r.c      | 142 +++++++--
 drivers/gpu/drm/tiny/hx8357d.c          | 138 ++++++++-
 drivers/gpu/drm/tiny/ili9163.c          | 138 ++++++++-
 drivers/gpu/drm/tiny/ili9225.c          | 192 +++++++++---
 drivers/gpu/drm/tiny/ili9341.c          | 138 ++++++++-
 drivers/gpu/drm/tiny/ili9486.c          | 139 ++++++++-
 drivers/gpu/drm/tiny/mi0283qt.c         | 138 ++++++++-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c   | 141 +++++++--
 include/drm/drm_mipi_dbi.h              | 145 +++++----
 include/drm/drm_simple_kms_helper.h     | 216 +-------------
 19 files changed, 1397 insertions(+), 855 deletions(-)


base-commit: 0009f17b2480f65a0f569c87c8a99f95d7aefd0e
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
prerequisite-patch-id: 719d09751d38f5da743beed6266585ee063e1e29
prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
prerequisite-patch-id: f7831e8fe81681bbe7fcd7b8455753f5ab4ada2d
-- 
2.53.0

