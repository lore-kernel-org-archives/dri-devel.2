Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B3FCA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EFC10E5AF;
	Fri,  2 Oct 2026 12:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="0VAtm1ok";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/0WdpOGW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YWadqPbf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K+VJeQ8q";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693C710E5AF
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:45:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BE03421A11;
 Fri,  2 Oct 2026 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790945113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EoNoc7tWsUIHwVx/TH3XPuU6rWbn3QtJ79wsmjhriU=;
 b=0VAtm1okbgz5jzuoRsfzT69Y/XKSc0LTX25eYbBpId8RovP8Ez2W4HNc45fyVaEJzGCM1r
 jGtAcCx4BoCEPmlKZjr+nlWxTndk75sS7zO+Edks2cr/7PvfXFB8lI+cBEgl7seD6LXtYd
 +IVn3Lt2MJy7oeEgTJ7BmmuocoyGBhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790945113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EoNoc7tWsUIHwVx/TH3XPuU6rWbn3QtJ79wsmjhriU=;
 b=/0WdpOGWUmQcKyNVEEcrhE9hGTxG/ri/IIKdSwT/lCXNhxxV7eRYuWfBysIeZkrbl8BTN4
 AphoHx4bJsqASOCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YWadqPbf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K+VJeQ8q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790945109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EoNoc7tWsUIHwVx/TH3XPuU6rWbn3QtJ79wsmjhriU=;
 b=YWadqPbfZH0ePDQ8JYeoE1P8LiT3LS8oZ+P+rnw2AHGoeTeiJgk6ggUGP64urgCMWkpmUt
 YDslIkSXYcr+zh7kHnXwvgWyD55ebOeAQtxVy8LC4lQ1mIPenCxkr0gWfZohIJ7FCEYMr3
 W8pk2/bz9ODbadcO2xiV2fsv6Mq2C38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790945109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EoNoc7tWsUIHwVx/TH3XPuU6rWbn3QtJ79wsmjhriU=;
 b=K+VJeQ8qvl9p71DUEThv2kY1N27YQYsYhVDGv7g2ZLRH1x3Y4CkA4hT5f0Y01sMJifkx/O
 +8KvOv8CtwID0iAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E939A13C98;
 Fri,  2 Oct 2026 12:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V/hJI0ynv2rNTwAAD6G6ig:T6
 (envelope-from <tzimmermann@suse.de>); Fri, 02 Oct 2026 12:45:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 5/7] drm/tegra: Do not include <drm/drm_simple_kms_helper.h>
Date: Fri,  2 Oct 2026 14:41:55 +0200
Message-ID: <20261002124456.741011-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124456.741011-1-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BE03421A11
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[15]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,linuxfoundation.org];
 ARC_NA(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

The tegra driver does not require anything from the simple-kms
header. Do not include it.

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tegra/output.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index d0ba3bd0aab8..eebf0ec0eea0 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -11,7 +11,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "drm.h"
 #include "dc.h"
-- 
2.55.0

