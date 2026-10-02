Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B70CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F7310E593;
	Fri,  2 Oct 2026 12:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="XzI7bU8s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3PTLVkfH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pQMD1LWW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xhcBLyX1";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E0010E593
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:45:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEC901FE37;
 Fri,  2 Oct 2026 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790945105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNyxilhTy807MOb+ojJH4dyLLYCEkNXw7AF1+e+MpJs=;
 b=XzI7bU8sdq8fxEFwWFI9lmsDvjXXthHMPQVF0h4CfyX0p3QQwU9X+RoRuls3F5xut4Cve1
 eSk67gH7w78DGH+wyb+ow+UHT5OalbdZpXxxouVLSiW1pyzC0g3LmoEaHNH8CaYYnZSaUo
 tT8EFJgMw6j568ze9S1KP84crQUdfI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790945105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNyxilhTy807MOb+ojJH4dyLLYCEkNXw7AF1+e+MpJs=;
 b=3PTLVkfHU09sR7/xeK2AdSCQ8VRg11FIXC41nrajFp0MK5SA48r4ZYT2TJAorzprK067en
 mMKkq8NfhtK/OPCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pQMD1LWW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xhcBLyX1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790945101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNyxilhTy807MOb+ojJH4dyLLYCEkNXw7AF1+e+MpJs=;
 b=pQMD1LWWbADpihYvfhRG1v/TC6jk7abu5kgPdYgHAADDD7afACsSnhYaFjJM049KVz7FgJ
 rADTPS/OZCZc5ljPGdJ4AFpb17qNs4RgJcoHjqV7JBWKsNDo09i07pPHHILX2+4sOmnhO/
 MWev6nWyfIZvHaXH3etRyj0GYpJ24D4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790945101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNyxilhTy807MOb+ojJH4dyLLYCEkNXw7AF1+e+MpJs=;
 b=xhcBLyX1DX73wgG05T83fsTcdTMhC6ZXQCdeyVqng9N9pEaN5z3jRwyaolTJ/JVee5V8vV
 PZyL5dj5c7WCWjDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30AD313C92;
 Fri,  2 Oct 2026 12:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V/hJI0ynv2rNTwAAD6G6ig:T2
 (envelope-from <tzimmermann@suse.de>); Fri, 02 Oct 2026 12:45:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 1/7] drm/hyperv: Add missing include statements
Date: Fri,  2 Oct 2026 14:41:51 +0200
Message-ID: <20261002124456.741011-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124456.741011-1-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWELVE(0.00)[14];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,linuxfoundation.org];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CEC901FE37
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Hyperv-drm gets a number of headers via <drm/drm_simple_kms_helper.h>.
Include the files directly so that the simple-kms header doesn't have
to.

v2:
- remove simple-kms include statements (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/gpu/drm/hyperv/hyperv_drm.h       | 5 +++++
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c   | 1 -
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 1 -
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
index 29e6f54af15f..f4262a37af36 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm.h
+++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
@@ -6,6 +6,11 @@
 #ifndef _HYPERV_DRM_H_
 #define _HYPERV_DRM_H_
 
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_plane.h>
+
 #define VMBUS_MAX_PACKET_SIZE 0x4000
 
 struct hv_drm_device {
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 0efd0593d031..031206a5b3d7 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -15,7 +15,6 @@
 #include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "hyperv_drm.h"
 
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 1d09bba1efdd..8ddd34833941 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -6,7 +6,6 @@
 #include <linux/hyperv.h>
 
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "hyperv_drm.h"
 
-- 
2.55.0

