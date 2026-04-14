Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F359F531F8
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 07:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19FD10E577;
	Tue, 14 Apr 2026 07:05:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="biKgmg/q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o7fgph2H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="biKgmg/q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o7fgph2H";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44C210E577
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:05:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A17315BD2B;
 Tue, 14 Apr 2026 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776150326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=okxTiwDMUEzFCUHxjzDk7H2bF838YXZ1/qYc+plhJfA=;
 b=biKgmg/qGPf/+Rp+JVavaqT0xYGI8MBnjd3QL0K/kub3b3uUtLMiTs5Iq4hdhQy7XHwkd4
 1YewsTm3uC8p1geuIZfxh5cfVAsmzPDkdBTXApyecZmSdt87qAjl4bpkw9/M5vbF1U/nZw
 oHujTy86uFENGKDAy3CGcxwemo2PTZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776150326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=okxTiwDMUEzFCUHxjzDk7H2bF838YXZ1/qYc+plhJfA=;
 b=o7fgph2HDUOKp7UTuEpi2rMFrZLJgKTJiwsOba8vwHmpRR85T/wu4l9DK/gnNH65gnAGjE
 FIWsM0T+IG1/9YBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776150326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=okxTiwDMUEzFCUHxjzDk7H2bF838YXZ1/qYc+plhJfA=;
 b=biKgmg/qGPf/+Rp+JVavaqT0xYGI8MBnjd3QL0K/kub3b3uUtLMiTs5Iq4hdhQy7XHwkd4
 1YewsTm3uC8p1geuIZfxh5cfVAsmzPDkdBTXApyecZmSdt87qAjl4bpkw9/M5vbF1U/nZw
 oHujTy86uFENGKDAy3CGcxwemo2PTZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776150326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=okxTiwDMUEzFCUHxjzDk7H2bF838YXZ1/qYc+plhJfA=;
 b=o7fgph2HDUOKp7UTuEpi2rMFrZLJgKTJiwsOba8vwHmpRR85T/wu4l9DK/gnNH65gnAGjE
 FIWsM0T+IG1/9YBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D1854B2FF;
 Tue, 14 Apr 2026 07:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U+VEFTbn3WmIOgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 14 Apr 2026 07:05:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/4] drm/ast: Fix color formats
Date: Tue, 14 Apr 2026 09:02:26 +0200
Message-ID: <20260414070522.33943-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
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

Fix various issues with ast's handling of color formats. Remove the
deprecated cpp field form the code and add support for XRGB1555.

Tested on AST26000 hardware by running fbcon and Xorg with the supported
color formats.

Thomas Zimmermann (4):
  drm/ast: Add constant for VGACR91
  drm/ast: Remove traces of DRM_FORMAT_RGB888 handling
  drm/ast: Replace references to struct drm_format_info.cpp
  drm/ast: Support DRM_FORMAT_XRGB1555 on the primary plane

 drivers/gpu/drm/ast/ast_mode.c | 86 ++++++++++++++++++++--------------
 drivers/gpu/drm/ast/ast_reg.h  | 55 +++++++++++++++++-----
 2 files changed, 93 insertions(+), 48 deletions(-)

-- 
2.53.0

