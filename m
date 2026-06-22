Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA27DCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD7D10E6D4;
	Mon, 22 Jun 2026 13:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="YG3yIB88";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W739RmJA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YG3yIB88";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W739RmJA";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8369810E6D4
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:24:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A6996CBD9;
 Mon, 22 Jun 2026 13:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782134680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ziPyQI5a+wXw1IKNck8mmri9sPYWuco/MemOvhs8VMU=;
 b=YG3yIB88sErZhzdNELVlNSw7RCI6kPOPLu6kWJaTGD8nl4g1+A56UcggkOgre70HVVAJFL
 Yr38noOnsq4qTTioZUnHmB7NgFxD2XPHr0pdQ/lhg/ICD1B5BPCVbtFhwUfrAY1KhL8x1m
 kSsh7s0XItv6f8OL4PrUNC6mbAEbqk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782134680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ziPyQI5a+wXw1IKNck8mmri9sPYWuco/MemOvhs8VMU=;
 b=W739RmJAwqUJ+fjiRJKX6TeV5VzscNn2jfpHLxT0OUYtltVHBkVpbzyvTyDBs2Dbaf9saD
 I3aTifigT1TtAuAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782134680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ziPyQI5a+wXw1IKNck8mmri9sPYWuco/MemOvhs8VMU=;
 b=YG3yIB88sErZhzdNELVlNSw7RCI6kPOPLu6kWJaTGD8nl4g1+A56UcggkOgre70HVVAJFL
 Yr38noOnsq4qTTioZUnHmB7NgFxD2XPHr0pdQ/lhg/ICD1B5BPCVbtFhwUfrAY1KhL8x1m
 kSsh7s0XItv6f8OL4PrUNC6mbAEbqk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782134680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ziPyQI5a+wXw1IKNck8mmri9sPYWuco/MemOvhs8VMU=;
 b=W739RmJAwqUJ+fjiRJKX6TeV5VzscNn2jfpHLxT0OUYtltVHBkVpbzyvTyDBs2Dbaf9saD
 I3aTifigT1TtAuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE729779A8;
 Mon, 22 Jun 2026 13:24:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4KzhNJc3OWpYIQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 22 Jun 2026 13:24:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, treding@nvidia.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/6] drm/sysfb: simpledrm: Various improvements
Date: Mon, 22 Jun 2026 15:19:34 +0200
Message-ID: <20260622132433.722823-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[redhat.com,nvidia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

Patches 1 to 5 improve validation of the values provided by the
device firmware.

Patch 6 improves support for panel rotation. There's a rotation
property in the DT panel node. Read the value and set the connector's
orientation property accordingly.

v2:
- further improve input validation (Sashiko)

Thomas Zimmermann (6):
  drm/sysfb: simpledrm: Improve framebuffer-size validation
  drm/sysfb: simpledrm: Improve panel-size validation
  drm/sysfb: simpledrm: Inline simplefb_get_validated_int()
  drm/sysfb: simpledrm: Improve stride validation
  drm/sysfb: simpledrm: Validate mmap size against framebuffer size
  drm/sysfb: simpledrm: Read panel orientation from DT node

 drivers/gpu/drm/sysfb/simpledrm.c | 133 ++++++++++++++++++++++++------
 1 file changed, 106 insertions(+), 27 deletions(-)


base-commit: fc59f76558703febba8056be87d1c97d14f7485e
-- 
2.54.0

