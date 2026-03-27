Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA5B10ED674
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B76C10EE59;
	Fri, 27 Mar 2026 13:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="PpfmArXF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WDUos671";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PpfmArXF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WDUos671";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB79110EE6F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:35:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F6ED5BDD9;
 Fri, 27 Mar 2026 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AgbZjl6mfIae/2SYhMrAoWCixYcR+MCbinSHqu1xKwo=;
 b=PpfmArXFhGwPbSexVaTNZG9Q4MaFvh80OwzuGkYcwJJo0PkHmDbJ0A8vNXdAg4GfAItqat
 x3yUp/SIjt0I1pu4WcXJeRiiFxkMk8oDGm/oQFNT1VZ/qTDAsB+09lypOUYhqJTYzxoK8O
 CDa+9cVKH1a4wc8T+9AYQwFj7fuVvmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AgbZjl6mfIae/2SYhMrAoWCixYcR+MCbinSHqu1xKwo=;
 b=WDUos671/ehLIkvXAF6ouAPqy7uZybMM9bNM/l7j+XHteJ61AStiRc2saBGiAJvgY8Ihr2
 tp135wF8px+xLSDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PpfmArXF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WDUos671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AgbZjl6mfIae/2SYhMrAoWCixYcR+MCbinSHqu1xKwo=;
 b=PpfmArXFhGwPbSexVaTNZG9Q4MaFvh80OwzuGkYcwJJo0PkHmDbJ0A8vNXdAg4GfAItqat
 x3yUp/SIjt0I1pu4WcXJeRiiFxkMk8oDGm/oQFNT1VZ/qTDAsB+09lypOUYhqJTYzxoK8O
 CDa+9cVKH1a4wc8T+9AYQwFj7fuVvmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AgbZjl6mfIae/2SYhMrAoWCixYcR+MCbinSHqu1xKwo=;
 b=WDUos671/ehLIkvXAF6ouAPqy7uZybMM9bNM/l7j+XHteJ61AStiRc2saBGiAJvgY8Ihr2
 tp135wF8px+xLSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD9CB4A0A2;
 Fri, 27 Mar 2026 13:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qO3WLqeHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 00/15] drm/ast: Clean up access to non-MMIO registers
Date: Fri, 27 Mar 2026 14:32:52 +0100
Message-ID: <20260327133532.79696-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1F6ED5BDD9
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

(was: drm/ast: Clean up access to MMIO registers)

Aspeed devices up to Gen6 contain internal memory that is accessible
from the host via the P2A bridge. The helpers ast_moutdwm() and
ast_mindwm() pick a 64-KiB segment of the memory to expose to the
host, which then has the content available. Content is either registers
of the various IP blocks or on-board system memory.

Clean up the driver code involved and provide macro constants for the
registers used by the ast driver. Go through the driver and replace
the magic values with the constants.

The first patch of the series fixes a bug that has been found while
working on these changes. The DP501 writes the content of register
SCU2C to the wrong address. The fix is a separate patch to ease
backporting.

Smoke-tested on AST2100, AST2300, AST2500 and AST2600.

v2:
- fix typo (Jocelyn)
- fix subject of cover letter
- convert more MCR registers on Gen6

Thomas Zimmermann (15):
  drm/ast: dp501: Fix initialization of SCU2C
  drm/ast: Move 32-bit register-access helpers to ast_drv.{c,h}
  drm/ast: Use constants for AHBC registers
  drm/ast: Use constants for MCR registers
  drm/ast: Use constants for SCU registers
  drm/ast: Use constants for A2P registers
  drm/ast: Use constants for WDT registers
  drm/ast: Use constants for SDRAM registers
  drm/ast: Store register addresses in struct ast_dramstruct
  drm/ast: Gen1: Fix open-coded register access
  drm/ast: Gen2: Fix open-coded register access
  drm/ast: Gen4: Fix open-coded register access
  drm/ast: Gen6: Fix open-coded register access
  drm/ast: dp501: Fix open-coded register access
  drm/ast: Fix open-coded scu_rev access

 drivers/gpu/drm/ast/ast_2000.c  |  61 +++--
 drivers/gpu/drm/ast/ast_2100.c  | 292 +++++++++++------------
 drivers/gpu/drm/ast/ast_2300.c  | 398 ++++++++++++++++----------------
 drivers/gpu/drm/ast/ast_2500.c  | 329 +++++++++++++-------------
 drivers/gpu/drm/ast/ast_dp501.c | 146 ++++++------
 drivers/gpu/drm/ast/ast_drv.c   |  84 ++++++-
 drivers/gpu/drm/ast/ast_drv.h   |  60 +++--
 drivers/gpu/drm/ast/ast_post.c  |  48 +---
 drivers/gpu/drm/ast/ast_post.h  |  20 +-
 drivers/gpu/drm/ast/ast_reg.h   | 156 +++++++++++++
 10 files changed, 891 insertions(+), 703 deletions(-)


base-commit: 5cb7d14d9bd2061386a0192a4649626a3e3a5ec3
-- 
2.53.0

