Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8F606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lhrZgtD+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Aml1w1Ng;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lhrZgtD+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Aml1w1Ng
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9834710E5E9;
	Tue, 17 Nov 2026 14:08:08 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D5510E5E9;
 Tue, 17 Nov 2026 14:07:57 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F321B22267;
 Tue, 17 Nov 2026 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794924476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z4/WKAT19Vpjrf1TybasxxG535T8z2t/1qjktjH0hrQ=;
 b=lhrZgtD+pyTojk/MCcSrXMx6TFxZn6YuCvOpTLRkcf4LvBemxaqD4KKCSIXciijpooSMGq
 +Ho0Fk8iJ1roxR4MWASw4Cy1bfReAOgNKLRxv0ZjjqUYZ0P4XsDL+GYnobIELQtkPPrW3b
 3sWH2BFDC6fm2ij3Sz97kSNCC+utqXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794924476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z4/WKAT19Vpjrf1TybasxxG535T8z2t/1qjktjH0hrQ=;
 b=Aml1w1NgkEBs3bsS2jtjyid/5Z/HsXC40wtevaKJFd62greKM+BF11lb36oeMYWKuwK/Vz
 yMv2QuZOjaHEamAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lhrZgtD+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Aml1w1Ng
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794924476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z4/WKAT19Vpjrf1TybasxxG535T8z2t/1qjktjH0hrQ=;
 b=lhrZgtD+pyTojk/MCcSrXMx6TFxZn6YuCvOpTLRkcf4LvBemxaqD4KKCSIXciijpooSMGq
 +Ho0Fk8iJ1roxR4MWASw4Cy1bfReAOgNKLRxv0ZjjqUYZ0P4XsDL+GYnobIELQtkPPrW3b
 3sWH2BFDC6fm2ij3Sz97kSNCC+utqXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794924476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z4/WKAT19Vpjrf1TybasxxG535T8z2t/1qjktjH0hrQ=;
 b=Aml1w1NgkEBs3bsS2jtjyid/5Z/HsXC40wtevaKJFd62greKM+BF11lb36oeMYWKuwK/Vz
 yMv2QuZOjaHEamAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 884F113302;
 Tue, 17 Nov 2026 14:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lIVaDrtf/GpTJgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 17 Nov 2026 14:07:55 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 0/2] drm/radeon: Inline drm_crtc_init()
Date: Tue, 17 Nov 2026 15:04:28 +0100
Message-ID: <20261117140750.541769-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[10]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: F321B22267
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
non-atomic mode setting. Only radeon still uses it.

Inline drm_crtc_init() into radeon and remove it from DRM. All new
code implements atomic mode setting, which does not use drm_crtc_init().
DRM support for kernel panic is not implemented by radeon. Clean it up.

With this series in place, DRM's helpers for drawing panic screens
can be further integrated with other drawing helpers, as outlined
in [1].

Tested on radeon with a Radeon HD 6570.

Requires the patch series at [2].

v3:
- keep plane->format_default for now
- remove some obsolete include statements
v2:
- add missing formats for primary plane
- drop amdgpu patches

[1] https://lore.kernel.org/dri-devel/20261019154612.777074-1-tzimmermann@suse.de/
[2] https://lore.kernel.org/amd-gfx/20261111151546.3105062-1-alexander.deucher@amd.com/

Thomas Zimmermann (2):
  drm/radeon: Inline drm_crtc_init()
  drm: Remove drm_crtc_init()

 drivers/gpu/drm/drm_crtc.c              | 19 +++----
 drivers/gpu/drm/drm_modeset_helper.c    | 76 -------------------------
 drivers/gpu/drm/radeon/radeon_display.c | 53 ++++++++++++++---
 include/drm/drm_modeset_helper.h        |  3 -
 4 files changed, 53 insertions(+), 98 deletions(-)


base-commit: 7d502136b31169f6b5575f7f89c3da60cdf7891d
prerequisite-patch-id: 29d74d364880d75af999879ea5eec1e61f99eee4
prerequisite-patch-id: c4aac512c186a1189b7e7d81e3a118b3e487f955
prerequisite-patch-id: 2e6a87a46e3157194ea11a2a4821ffbe38e7748e
-- 
2.56.0

