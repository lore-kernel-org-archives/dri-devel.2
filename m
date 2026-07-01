Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33442C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC1710E16D;
	Wed,  1 Jul 2026 12:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="RXqKbrOy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nGwO8T4D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RXqKbrOy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nGwO8T4D";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FAF10E16D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:11:03 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 999067597D;
 Wed,  1 Jul 2026 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782907861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TjoAx2Rq5i/1rxbxDuh0h6RbW4AX6PKRYyQxZYAHBqw=;
 b=RXqKbrOyaDL7TUFos242G1NgBegRJHSDepItzQaHf7dQPYj0p5seTh179hmt0rzAbfPk0k
 pzJ/S8Ev97aEgarDasWQSPhRKrMXLLp0g8hzltrxePHON8GZSJvaTNnaE/Rg+1V2EQvQgj
 eADZM9o5dHDz3NUUkIZsmZB4JJF8HsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782907861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TjoAx2Rq5i/1rxbxDuh0h6RbW4AX6PKRYyQxZYAHBqw=;
 b=nGwO8T4DX8G1UOlEK7h/8/qi9NZPV/3j3ZVcfKTNBQ2OZoe1Z99uV6JTOLmsxM4ADU1lgK
 U3lZ1yAabMnYqKAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RXqKbrOy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nGwO8T4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782907861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TjoAx2Rq5i/1rxbxDuh0h6RbW4AX6PKRYyQxZYAHBqw=;
 b=RXqKbrOyaDL7TUFos242G1NgBegRJHSDepItzQaHf7dQPYj0p5seTh179hmt0rzAbfPk0k
 pzJ/S8Ev97aEgarDasWQSPhRKrMXLLp0g8hzltrxePHON8GZSJvaTNnaE/Rg+1V2EQvQgj
 eADZM9o5dHDz3NUUkIZsmZB4JJF8HsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782907861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TjoAx2Rq5i/1rxbxDuh0h6RbW4AX6PKRYyQxZYAHBqw=;
 b=nGwO8T4DX8G1UOlEK7h/8/qi9NZPV/3j3ZVcfKTNBQ2OZoe1Z99uV6JTOLmsxM4ADU1lgK
 U3lZ1yAabMnYqKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1625A779AA;
 Wed,  1 Jul 2026 12:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tCfSA9UDRWozOQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 01 Jul 2026 12:11:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: treding@nvidia.com, javierm@redhat.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, dianders@chromium.org, megi@xff.cz,
 igor@reznichenko.net, mwalle@kernel.org,
 dario.binacchi@amarulasolutions.com, jagan@edgeble.ai,
 laurent.pinchart@ideasonboard.com, lujianhua000@gmail.com, agx@sigxcpu.org,
 kernel@puri.sm, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 0/3] drm/panel, of,
 sysfb: Use OF panel-orientation helper in simpledrm
Date: Wed,  1 Jul 2026 14:03:17 +0200
Message-ID: <20260701121055.192475-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[21];
 FREEMAIL_TO(0.00)[nvidia.com,redhat.com,linaro.org,gmail.com,chromium.org,xff.cz,reznichenko.net,kernel.org,amarulasolutions.com,edgeble.ai,ideasonboard.com,sigxcpu.org,puri.sm,linux.intel.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 999067597D
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

Improve support for panel orientation in simpledrm. There's a rotation
property in the DT panel node. Read the value and set the connector's
orientation property accordingly.

Patch 1 moves the existing code for parsing the rotation to drm_of.c.
This makes it available to simpledrm without introducing a dependency on
DRM_PANEL.

Patch 2 updates simpledrm and patch 3 updates all DRM panel drivers to
use the new helper function.

These patches have previously been part of another series that improved
simpledrm in general. So we start with v4 instead of v1. Keep existing
R-b tags.

v4:
- integrate Thierry's panel-update patch
- update anbernic, chipone, ili9488 panels that were merged recently
v3:
- see https://lore.kernel.org/dri-devel/20260625094509.157581-1-tzimmermann@suse.de/

Thierry Reding (1):
  drm/panel: Use drm_of_get_panel_orientation()

Thomas Zimmermann (2):
  drm/of: Implement drm_of_get_panel_orientation()
  drm/sysfb: simpledrm: Read panel orientation from DT node

 drivers/gpu/drm/drm_of.c                      | 44 +++++++++++++++++++
 drivers/gpu/drm/drm_panel.c                   | 44 +------------------
 drivers/gpu/drm/panel/panel-anbernic-td4310.c |  3 +-
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  |  3 +-
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  3 +-
 .../gpu/drm/panel/panel-chipone-icna35xx.c    |  3 +-
 .../gpu/drm/panel/panel-chipwealth-ch13726a.c |  3 +-
 drivers/gpu/drm/panel/panel-edp.c             |  3 +-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  |  3 +-
 .../gpu/drm/panel/panel-focaltech-ota7290b.c  |  3 +-
 drivers/gpu/drm/panel/panel-himax-hx83102.c   |  3 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c    |  3 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9488.c  |  3 +-
 .../gpu/drm/panel/panel-ilitek-ili9806e-dsi.c |  3 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |  3 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c |  3 +-
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  |  2 +-
 drivers/gpu/drm/panel/panel-lvds.c            |  2 +-
 drivers/gpu/drm/panel/panel-novatek-nt36523.c |  3 +-
 drivers/gpu/drm/panel/panel-simple.c          |  2 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c |  3 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c |  3 +-
 .../gpu/drm/panel/panel-sitronix-st7789v.c    |  3 +-
 drivers/gpu/drm/sysfb/simpledrm.c             | 11 ++++-
 include/drm/drm_of.h                          | 11 +++++
 include/drm/drm_panel.h                       |  8 ----
 26 files changed, 104 insertions(+), 74 deletions(-)


base-commit: a2d82f27ac35c691c1c65b40c72b13d8b2a7f91f
-- 
2.54.0

