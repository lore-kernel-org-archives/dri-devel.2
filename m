Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082461073CA4
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7018A10E61F;
	Wed,  8 Apr 2026 12:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="vsGGjsKL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ljj2Zw04";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vsGGjsKL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ljj2Zw04";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86BA710E61F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:07:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C9325BCD7;
 Wed,  8 Apr 2026 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775650047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jASeO5XV+LlUMhFuZJ9gFlWeF7A6u/Xj3fH0hY3UYg8=;
 b=vsGGjsKLt7f9UE7S61Wf/8amw2f6y/VIDVXQ8WhSCrHIgSrKe02ICL/Nml2fHpLvagW2Hw
 NCf0dEWFbqx98beyCgA43If8ilX9nYxA4Kj+WGyqVZkhKFu/t5ASe2J0RVjj4PUBhz4goG
 fUAltN+pgAtVTyVjPfeXh3fAhLBzhSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775650047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jASeO5XV+LlUMhFuZJ9gFlWeF7A6u/Xj3fH0hY3UYg8=;
 b=ljj2Zw04spbzy6TtWbNsfNqE3yuAcQKK4QjiEfbdwTntwBMGVga2X6h2mmDgn7Lcu7oE0q
 qBPdso9uY+xlXRDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vsGGjsKL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ljj2Zw04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775650047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jASeO5XV+LlUMhFuZJ9gFlWeF7A6u/Xj3fH0hY3UYg8=;
 b=vsGGjsKLt7f9UE7S61Wf/8amw2f6y/VIDVXQ8WhSCrHIgSrKe02ICL/Nml2fHpLvagW2Hw
 NCf0dEWFbqx98beyCgA43If8ilX9nYxA4Kj+WGyqVZkhKFu/t5ASe2J0RVjj4PUBhz4goG
 fUAltN+pgAtVTyVjPfeXh3fAhLBzhSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775650047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jASeO5XV+LlUMhFuZJ9gFlWeF7A6u/Xj3fH0hY3UYg8=;
 b=ljj2Zw04spbzy6TtWbNsfNqE3yuAcQKK4QjiEfbdwTntwBMGVga2X6h2mmDgn7Lcu7oE0q
 qBPdso9uY+xlXRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBC3D4A0B3;
 Wed,  8 Apr 2026 12:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r9cjOP5E1mlkUgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Apr 2026 12:07:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/5] drm/sysfb: Support basic power management
Date: Wed,  8 Apr 2026 14:03:13 +0200
Message-ID: <20260408120722.328769-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_SEVEN(0.00)[7];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 2C9325BCD7
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

Add callbacks for suspending and resuming to the sysfb drivers. The
helpers store and restore DRM state across the suspend/resume cycle.

While most hardware loses the system framebuffer setup on suspends,
some systems do retain the configuration; notable emulators. Adding
PM support makes it work with DRM.

Tested with vesadrm on qemu's bochs device.

Thomas Zimmermann (5):
  drm/sysfb: corebootdrm: Support power management
  drm/sysfb: efidrm: Support power management
  drm/sysfb: ofdrm: Support power management
  drm/sysfb: simpledrm: Support power management
  drm/sysfb: vesadrm: Support power management

 drivers/gpu/drm/sysfb/corebootdrm.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/sysfb/efidrm.c      | 19 +++++++++++++++++++
 drivers/gpu/drm/sysfb/ofdrm.c       | 19 +++++++++++++++++++
 drivers/gpu/drm/sysfb/simpledrm.c   | 21 +++++++++++++++++++++
 drivers/gpu/drm/sysfb/vesadrm.c     | 19 +++++++++++++++++++
 5 files changed, 99 insertions(+)

-- 
2.53.0

