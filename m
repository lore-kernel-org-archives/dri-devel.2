Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C899CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 07:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5F310F9B8;
	Fri, 29 May 2026 07:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Pbw5qjbh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2WtQQmzb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DKi3DUJM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c5ZrqV52";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634DF10F9BA
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:00:12 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE43E66F6B;
 Fri, 29 May 2026 07:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780038011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sx9uZgU6Uf5r1hE2m5Qd8QDIOswHFAw99qCVgtc8iOg=;
 b=Pbw5qjbhZLsOyurQeGfy6zSuE1SXyryJ3sDKq6Hv99W3OK3g18YYE1JpvzAWkFIYzOF4o3
 4RA0ut1ZsnGXCUMe2i00WuWp/2jCgSwaPXeesvfwdiry25TKkYAP27DR7P++tN4WJfJann
 1P80dxyasSBo1F7j7J2lp+byqn5Ty4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780038011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sx9uZgU6Uf5r1hE2m5Qd8QDIOswHFAw99qCVgtc8iOg=;
 b=2WtQQmzbD1kpH1nyFsBY9Ya+6whC8HoUYbFjOHbKFMwIPvrNIIfJfqiISkPL6v3tTUtEJG
 rk/MI73iTTbdYgBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780038010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sx9uZgU6Uf5r1hE2m5Qd8QDIOswHFAw99qCVgtc8iOg=;
 b=DKi3DUJMfMnYYHqcrklnHcBuT2on5KiA3EPygTMgg0dZYUDq+agB8GgQPPqIsPi2wli9xw
 /60aH86tP4ftm0Y2ZpR70G6tDQyZMuCS+fMkUqcw1NLh/WgNoANtMyXMQEmTMvK5UVaQSe
 tTdtWvYEan6K1wW4/tmIVSNzUxIrcRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780038010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sx9uZgU6Uf5r1hE2m5Qd8QDIOswHFAw99qCVgtc8iOg=;
 b=c5ZrqV52gn7zdAgtlYBcKJ7OSoFDWXh2aCzb4a239EZveAiisGU08P2hfmBrGGmsi9mEf+
 nxYMnAOXplz8nzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73F1F5B1EF;
 Fri, 29 May 2026 07:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gjHaGno5GWoEPgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 29 May 2026 07:00:10 +0000
Date: Fri, 29 May 2026 09:00:09 +0200
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
Subject: [PULL] drm-misc-fixes
Message-ID: <20260529070009.GA313534@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[16];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 linux.fritz.box:mid, gitlab.freedesktop.org:url]
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

here is this week's PR from drm-misc-fixes. There's one cross-subsys
commit to the dma-buf code. Commit 5ab62dd3687b ("drm: prevent integer
overflows in dumb buffer creation helpers") has not Link tag because
it went through the security list.

Best regards
Thomas

drm-misc-fixes-2026-05-29:
Short summary of fixes pull:

amdxdna:
- require IOMMU on AIE2

dumb-buffer:
- prevent overflows in dumb-buffer creation

dma-buf:
- fix UAF in dma_buf_fd() tracepoint

hyperv:
- improve protocol validation

ivpu:
- test write offset in debugfs

rocket:
- fix UAF in bo creation
The following changes since commit 9af1b6e175c82daf4b423da339a722d8e67a735a:

  drm/virtio: use uninterruptible resv lock for plane updates (2026-05-20 18:12:11 +0300)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-05-29

for you to fetch changes up to 5ab62dd3687bcc2cc542b99385aabac5c996db6f:

  drm: prevent integer overflows in dumb buffer creation helpers (2026-05-29 08:30:47 +0200)

----------------------------------------------------------------
Short summary of fixes pull:

amdxdna:
- require IOMMU on AIE2

dumb-buffer:
- prevent overflows in dumb-buffer creation

dma-buf:
- fix UAF in dma_buf_fd() tracepoint

hyperv:
- improve protocol validation

ivpu:
- test write offset in debugfs

rocket:
- fix UAF in bo creation

----------------------------------------------------------------
Berkant Koc (2):
      drm/hyperv: validate resolution_count and fix WIN8 fallback
      drm/hyperv: validate VMBus packet size in receive callback

Dan Carpenter (1):
      accel/ivpu: prevent uninitialized data bug in debugfs

David Carlier (1):
      dma-buf: fix UAF in dma_buf_fd() tracepoint

Dhabaleshwar Das (1):
      accel/rocket: fix UAF via dangling GEM handle in create_bo

Lizhi Hou (1):
      accel/amdxdna: Block running when IOMMU is off

Rajat Gupta (1):
      drm: prevent integer overflows in dumb buffer creation helpers

 drivers/accel/amdxdna/aie2_pci.c          |   5 ++
 drivers/accel/ivpu/ivpu_debugfs.c         |   2 +-
 drivers/accel/rocket/rocket_gem.c         |  17 +++--
 drivers/dma-buf/dma-buf.c                 |   6 +-
 drivers/gpu/drm/drm_dumb_buffers.c        |  14 +++-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 113 +++++++++++++++++++++++++-----
 6 files changed, 132 insertions(+), 25 deletions(-)

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
