Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64A60A2622
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zY5HeK2a;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1djRc/xn;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=c6RB1tVg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YkRxJbQV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC79410F632;
	Tue, 10 Nov 2026 12:04:01 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB79210F62B;
 Tue, 10 Nov 2026 12:03:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E59A1F453;
 Tue, 10 Nov 2026 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794312212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=go2ahT4J/OnyocruO+TgN7OM95Vdo2X0uJ3MT6oMFXk=;
 b=zY5HeK2aSkBydJQNfaPAP0/nJeoTiL7t+en/vRlvWB3Z2SoPiVeBMlkDp2viegJLRmZwgj
 hXp3zcQ7FraifsLXS+V6U2xPETe9AtbawBUoJDnIhfGXP67m+TZYImqNUHWf0Jn9cpgpzJ
 UHLzu0n9gBgUaGA/jZzDlXoqcfA3+a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794312212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=go2ahT4J/OnyocruO+TgN7OM95Vdo2X0uJ3MT6oMFXk=;
 b=1djRc/xnP2/CVTqCbRwBhzjgu1jfg0aIN01mFRMHjT2uvLuoXKhcIGVdwiuenPOHKOCaOb
 iwwZA8rcYImL8eAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c6RB1tVg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YkRxJbQV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794312211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=go2ahT4J/OnyocruO+TgN7OM95Vdo2X0uJ3MT6oMFXk=;
 b=c6RB1tVg5PuJdU7J/l6Ib6kzbhgubOCWGSD8Cdg7vLYwa99D/WWiJe+ad0dwQX38dUu66T
 em7ynhHaO8FG6qzPOHcY0e6+E57e2KcMNq5r9b/92psTGytiut6IG5KzKsUTKgmJDUYfx0
 71baDUD0ZAwfLOOW/tGpOgSwwUzRr+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794312211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=go2ahT4J/OnyocruO+TgN7OM95Vdo2X0uJ3MT6oMFXk=;
 b=YkRxJbQVw1VFSKFi/VICpQhySVCwv9YA3iz01lZ/0yAchSwG0JefjaqhHzxLWhGVuirvpi
 dT+juOgw8eDAUBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCB3713479;
 Tue, 10 Nov 2026 12:03:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9RxpJBII82qUDQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 10 Nov 2026 12:03:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/5] drm/amdgpu,radeon: Inline drm_crtc_init()
Date: Tue, 10 Nov 2026 12:53:26 +0100
Message-ID: <20261110120326.538252-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E59A1F453
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -12.01
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The helper drm_crtc_init() sets up a CRTC with a primary plane for
non-atomic mode setting. Only drivers for some AMD hardware still
use it.

Inline drm_crtc_init() into amdgpu and radeon and remove it from
DRM. All new code implements atomic mode setting, which does not
use drm_crtc_init().

DRM support for kernel panic is only implemented in amdgpu. Take
the panic helpers from drm_crtc_init() in amdgpu, but clean it up
in radeon.

With this series in place, DRM's helpers for drawing panic screens
can be further integrated with other drawing helpers, as outlined
in [1].

Tested on radeon with a Radeon HD 6570.

[1] https://lore.kernel.org/dri-devel/20261019154612.777074-1-tzimmermann@suse.de/

Thomas Zimmermann (5):
  drm/amdgpu: dce_v6_0: Inline drm_crtc_init()
  drm/amdgpu: dce_v8_0: Inline drm_crtc_init()
  drm/amdgpu: dce_v10_0: Inline drm_crtc_init()
  drm/radeon: Inline drm_crtc_init()
  drm: Remove drm_crtc_init()

 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c  | 44 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c   | 44 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c   | 44 ++++++++++++++-
 drivers/gpu/drm/drm_crtc.c              | 26 +++------
 drivers/gpu/drm/drm_modeset_helper.c    | 74 -------------------------
 drivers/gpu/drm/radeon/radeon_display.c | 47 +++++++++++++---
 include/drm/drm_modeset_helper.h        |  3 -
 include/drm/drm_plane.h                 |  5 --
 8 files changed, 170 insertions(+), 117 deletions(-)

-- 
2.56.0

