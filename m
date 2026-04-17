Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845E1F8E4AE
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B691E10E687;
	Fri, 17 Apr 2026 06:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="sdLPT/2K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wb8MY+Dw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sdLPT/2K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wb8MY+Dw";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2280410E687
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:14:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABEBB5BD5B;
 Fri, 17 Apr 2026 06:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776406472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nAteDtSBABAjwPYln+NRUdcZJNqgs01f4/BUOe0/cg4=;
 b=sdLPT/2K+2UtHi5FpR7WIL8GV6RjTirE5y4/xix0QNLNYCIBhznjryjyehXYJ98a4hluzn
 ZT4Ac5e2idYFEcw5MW+pmVQo3YaFjhxiQxAFw+ccAI0n/aRAb/DZLwf7JMhfs3BuBULwIF
 WPy+zg75wJV6TVH76/amBDHjy47dBk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776406472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nAteDtSBABAjwPYln+NRUdcZJNqgs01f4/BUOe0/cg4=;
 b=Wb8MY+Dw6VzccVsa0LV+R1UqtpU4P/vAVTAMQEZCRvoBEma9aNkeI/0Jdp7vGXBLcc7cLW
 OoS7VjWIDqmvnTCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="sdLPT/2K";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Wb8MY+Dw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776406472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nAteDtSBABAjwPYln+NRUdcZJNqgs01f4/BUOe0/cg4=;
 b=sdLPT/2K+2UtHi5FpR7WIL8GV6RjTirE5y4/xix0QNLNYCIBhznjryjyehXYJ98a4hluzn
 ZT4Ac5e2idYFEcw5MW+pmVQo3YaFjhxiQxAFw+ccAI0n/aRAb/DZLwf7JMhfs3BuBULwIF
 WPy+zg75wJV6TVH76/amBDHjy47dBk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776406472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nAteDtSBABAjwPYln+NRUdcZJNqgs01f4/BUOe0/cg4=;
 b=Wb8MY+Dw6VzccVsa0LV+R1UqtpU4P/vAVTAMQEZCRvoBEma9aNkeI/0Jdp7vGXBLcc7cLW
 OoS7VjWIDqmvnTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4880A593AE;
 Fri, 17 Apr 2026 06:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lyODEMjP4WkrOQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 17 Apr 2026 06:14:32 +0000
Date: Fri, 17 Apr 2026 08:14:30 +0200
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
Subject: [PULL] drm-misc-next-fixes
Message-ID: <20260417061430.GA11880@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[16]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ABEBB5BD5B
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

Hi Dave, Sima,

this is the PR from drm-misc-next-fixes. It's only a very simple fix to the
documentation.

Best regards
Thomas

drm-misc-next-fixes-2026-04-17:
Short summary of fixes pull:

dma-buf:
- fix documentation formatting
The following changes since commit 4aa0deae1070690d08c1f47c489f8b5ce3f6ea6d:

  drm/vram: remove DRM_VRAM_MM_FILE_OPERATIONS from docs (2026-04-09 09:34:28 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-fixes-2026-04-17

for you to fetch changes up to dc6d51959ec0c08366d5aaeb5b8fb02d814d1e4b:

  dma-buf: fix htmldocs error for dma_buf_attach_revocable (2026-04-10 19:22:02 +0530)

----------------------------------------------------------------
Short summary of fixes pull:

dma-buf:
- fix documentation formatting

----------------------------------------------------------------
Sumit Semwal (1):
      dma-buf: fix htmldocs error for dma_buf_attach_revocable

 drivers/dma-buf/dma-buf.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
