Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADD5D35172
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF3210EF4B;
	Wed,  1 Apr 2026 10:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="u6ohqOMF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RJSljYFD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u6ohqOMF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RJSljYFD";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD0F10EE75
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:23:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 328334D2CF;
 Wed,  1 Apr 2026 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775039005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ySPi5z90F04ueptRzUEmjxyFoZG2/N3ZgfW0Pems9GQ=;
 b=u6ohqOMF3u71tlzZBnonUym4fIxTJR0S6yDg/HA6xO1Mqebyq/hXnze9BN1IDwfVo+smBM
 guafQqAaC3o/ny71PSZgSyw9T4qZk7GJOckTy9HRu6RY2yu3pPfN1UFYzef9mTnz7rYGiu
 Hhtd9DlKvE88FKVy0Wjuhtv+/36G25E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775039005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ySPi5z90F04ueptRzUEmjxyFoZG2/N3ZgfW0Pems9GQ=;
 b=RJSljYFDUDv5NFpO9wS/KzIyEMizjgy55HEt/ssyu+t/E4rHX3BmLdl3OxCR1ij0ccHqqU
 C1uoFN/0I1Fj3lCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u6ohqOMF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RJSljYFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775039005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ySPi5z90F04ueptRzUEmjxyFoZG2/N3ZgfW0Pems9GQ=;
 b=u6ohqOMF3u71tlzZBnonUym4fIxTJR0S6yDg/HA6xO1Mqebyq/hXnze9BN1IDwfVo+smBM
 guafQqAaC3o/ny71PSZgSyw9T4qZk7GJOckTy9HRu6RY2yu3pPfN1UFYzef9mTnz7rYGiu
 Hhtd9DlKvE88FKVy0Wjuhtv+/36G25E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775039005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ySPi5z90F04ueptRzUEmjxyFoZG2/N3ZgfW0Pems9GQ=;
 b=RJSljYFDUDv5NFpO9wS/KzIyEMizjgy55HEt/ssyu+t/E4rHX3BmLdl3OxCR1ij0ccHqqU
 C1uoFN/0I1Fj3lCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF08D4A0B0;
 Wed,  1 Apr 2026 10:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p4B7NBzyzGk0AQAAD6G6ig
 (envelope-from <jdelvare@suse.de>); Wed, 01 Apr 2026 10:23:24 +0000
Date: Wed, 1 Apr 2026 12:23:23 +0200
From: Jean Delvare <jdelvare@suse.de>
To: dri-devel@lists.freedesktop.org
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Tomeu Vizoso
 <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] accel: ethosu: Add hardware dependency hint
Message-ID: <20260401122323.6127a77c@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; HAS_ORG_HEADER(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 328334D2CF
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

The Ethos-U NPU is only available on ARM systems, so add a hardware
dependency hint to prevent this driver from being needlessly
included in kernels built for other architectures.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/accel/ethosu/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-6.19.orig/drivers/accel/ethosu/Kconfig
+++ linux-6.19/drivers/accel/ethosu/Kconfig
@@ -4,6 +4,7 @@ config DRM_ACCEL_ARM_ETHOSU
 	tristate "Arm Ethos-U65/U85 NPU"
 	depends on HAS_IOMEM
 	depends on DRM_ACCEL
+	depends on ARM || ARM64 || COMPILE_TEST
 	select DRM_GEM_DMA_HELPER
 	select DRM_SCHED
 	select GENERIC_ALLOCATOR


-- 
Jean Delvare
SUSE L3 Support
