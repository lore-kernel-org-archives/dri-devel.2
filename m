Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B8AC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C5B10E61C;
	Thu, 27 Aug 2026 08:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="i/Zncim7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8g0fQU7T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NS6gN/zd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xuIlBzX4";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C6A510E61C
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:29:31 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A75A52127E;
 Thu, 27 Aug 2026 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787819365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rXOmXKp/1J474MYw+V7sV5qANb/85RqDar1V20PUIAA=;
 b=i/Zncim7jElIuSDEc6Wy0uh++2drQgYJbBDa7qdqINMS5bwnoc3hSxsqH2RT29UHIzhbyA
 Ox1iA7WLXzkCijLLwsR6aJms82KF159/eFxDGIphMDKFu6kd0tkWHoq3T3zsaw8bwwi0os
 DXSiTgS1hI2/FeQ/Jl4K+wcMNoMKZRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787819365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rXOmXKp/1J474MYw+V7sV5qANb/85RqDar1V20PUIAA=;
 b=8g0fQU7TAj0HaURIvm2cpbolU1Wi/ofYFWPoGr6OOTuvclpLih9OdXng+eWl+Kszq/pffn
 xZakWd8xnBhaiSDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787819361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rXOmXKp/1J474MYw+V7sV5qANb/85RqDar1V20PUIAA=;
 b=NS6gN/zd31Im4q41tPhtQjqFRF2Fg8nv8xgwxILyKNHOcsk0z3FB7TpzK1bprpCRmjXZR3
 P0/heODQs6GHNC1wIt3zwJTwAwkRzuiDJtHsMj7xuxT+G9jZQP/w2ogKOMwTbr0LtjkSgX
 qP0fV5TUQLX/xVe63hfUCPOHqt6FLX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787819361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rXOmXKp/1J474MYw+V7sV5qANb/85RqDar1V20PUIAA=;
 b=xuIlBzX4gEfO9bD/q/mPFNwO336u082Pr4tkmXkTe3kcQ6C/AKL0321IZxSHACl7xRdUVh
 n7in6kkBtfuM81Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E0F61352C;
 Thu, 27 Aug 2026 08:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NtnJFWH1j2p4PAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 27 Aug 2026 08:29:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: shiyongbang@huawei.com, kong.kongxinwei@hisilicon.com,
 tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] hibmc: Improve vblank handling
Date: Thu, 27 Aug 2026 10:23:43 +0200
Message-ID: <20260827082915.61176-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[huawei.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCPT_COUNT_SEVEN(0.00)[9]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Vblank event handling in hibmc is currently somewhat disconnected
from what the hardware does. Patch 1 updates IRQ handlers to signal
whether the driver handled an IRQ or not. Patch 2 connects hibmc's
vblank events to the hardware's vblank interrupts.

Tested on an RH1288 v3 system.

Thomas Zimmermann (2):
  drm/hibmc: Return IRQ_NONE for unhandled interrupts
  drm/hibmc: Set up vblank event to be send on the next vblank

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 16 ++--------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c |  5 +++--
 2 files changed, 5 insertions(+), 16 deletions(-)


base-commit: dc462ab791b686c48545c160ecc81be64f77a846
-- 
2.55.0

