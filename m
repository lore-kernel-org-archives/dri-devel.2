Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE675F589D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407D610F102;
	Thu, 23 Apr 2026 13:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="cVkOzGZ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zDxP/cwC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TJmCozsT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FIXxp8xP";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5032D10F102
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:09:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9222F5BCE5;
 Thu, 23 Apr 2026 13:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776949735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5+mRiSsGrZW2locIf7YnjaLmgBkUlr3gFdtKko52+nM=;
 b=cVkOzGZ8uKeSk7yFADwqEFXzGEkHylPriNAydyXWo10bVDDZBUeHF6a/CV67spqOKs2xVh
 QvRVSnhanogpcAiKhas5G5TVZzNnRnSX+i8/fSpvtXmZdZPZAvTFsuMp7GEMKfSkXPIapg
 UCnzLNrEQZvjtyV+L6j7pbpj7SSN7fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776949735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5+mRiSsGrZW2locIf7YnjaLmgBkUlr3gFdtKko52+nM=;
 b=zDxP/cwCXO/eDjmoylIH+FLW8sTxa63U4uv14F3t0AHC9P0uMqfxZmbMlKKoHHnRHVyrOg
 uw8A6k93BdUjgWCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TJmCozsT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FIXxp8xP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776949734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5+mRiSsGrZW2locIf7YnjaLmgBkUlr3gFdtKko52+nM=;
 b=TJmCozsT9DWT4KSkzEx07a/wTPrKJOjwCdKGtWZxRNJ16ffueN38+XiAfRW/8ubMBof9D0
 XZ/kVmuB1V+tNemr+s7EUjzJoqyZ2UpdnliWx5+mXx649Rof1dUbujW7ggVS6JaA1PxNIX
 EpWkOSD4SugtR6UYm+r/kHetv89SA/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776949734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5+mRiSsGrZW2locIf7YnjaLmgBkUlr3gFdtKko52+nM=;
 b=FIXxp8xPoboeIDs1/VDry9aTmHpaQaHFPluEE0omk2xwV4uV9YHxR7Ltrrz/rxqicQ9CyI
 f6jyUpRyU5bA8DAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23229593B0;
 Thu, 23 Apr 2026 13:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y2EjB+YZ6mlAGwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 13:08:54 +0000
Date: Thu, 23 Apr 2026 15:08:52 +0200
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
Message-ID: <20260423130852.GA114622@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MAILSPIKE_FAIL(0.00)[2a07:de40:b281:104:10:150:64:97:query timed out];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.fritz.box:mid,suse.com:url,gitlab.freedesktop.org:url,suse.de:dkim];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9222F5BCE5
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

here's one final fix from drm-misc-next-fixes that is needed in the
current merge window.

Best regards
Thomas

drm-misc-next-fixes-2026-04-23:
Short summary of fixes pull:

rcar-du:
- fix NULL-ptr crash
The following changes since commit dc6d51959ec0c08366d5aaeb5b8fb02d814d1e4b:

  dma-buf: fix htmldocs error for dma_buf_attach_revocable (2026-04-10 19:22:02 +0530)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-fixes-2026-04-23

for you to fetch changes up to f6c73e7156b54d8b9ddf1a27f4e93d3a1e49a73e:

  drm: rcar-du: Fix crash when no CMM is available (2026-04-23 15:53:46 +0300)

----------------------------------------------------------------
Short summary of fixes pull:

rcar-du:
- fix NULL-ptr crash

----------------------------------------------------------------
Laurent Pinchart (1):
      drm: rcar-du: Fix crash when no CMM is available

 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
