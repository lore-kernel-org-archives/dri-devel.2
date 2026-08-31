Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9F9C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847ED10E281;
	Mon, 31 Aug 2026 09:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="lovZuJC9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Th6ckvbG";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A7710E281
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:31:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B90D21FCEA;
 Mon, 31 Aug 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788168626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SgRUgPbAMCuHAWuNUnbndaP4EBH1cb1nM83yRK+lNQc=;
 b=lovZuJC9z9Xu6IgTmhJz6+pW+nv+Wzs7TXBn/qqUBT6+iyzdWkD1TUIf16a1w3LDIZ/FNh
 9CWWia4BS21iBkmtqUOBDObAxkbQS6nSZHsmQWs7/qBR45wlTHiu16b8LI58CSad1C5f94
 EKlyhn1pLXesh95cgUDWNj/nCXjNxW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788168626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SgRUgPbAMCuHAWuNUnbndaP4EBH1cb1nM83yRK+lNQc=;
 b=Th6ckvbGUf500zNbxQTvefpDrq8Bslmh86Bmxo9iVTFbarYQI0qvJuzCsYFy7dA7rVC+sK
 i+wzE+fUgl8IufBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5384213682;
 Mon, 31 Aug 2026 09:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uF/9ErJJlWoFUwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 31 Aug 2026 09:30:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, ardb@kernel.org, ilias.apalodimas@linaro.org,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 1/3] firmware/sysfb: Remove rotation quirk for Lenovo D330
Date: Mon, 31 Aug 2026 11:27:48 +0200
Message-ID: <20260831093020.494701-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831093020.494701-1-tzimmermann@suse.de>
References: <20260831093020.494701-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B90D21FCEA
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
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

The Lenovo D330 is a notebook with unmountable display. The display
is installed in landscape orientation, but the display mode is in
portrait orientation. By default, the display output is rotated to
the left by 90°.

The sysfb quirk breaks the display by swapping display width and
height; and thus mixing up the display geometry. Fix this by keeping
the display as-is. The sysfb DRM drivers, usually efidrm, will pick
the correct panel orientation for the display.

Tested on a Lenovo D330-10IGM IdeaPad.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/sysfb_efi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 685283bb7327..2338de73c62c 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -301,15 +301,6 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 		},
 		.callback = efifb_swap_width_height,
 	},
-	{
-		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
-		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
-					"Lenovo ideapad D330-10IGM"),
-		},
-		.callback = efifb_swap_width_height,
-	},
 	{
 		/*
 		 * Lenovo IdeaPad Duet 3 10IGL5 and 10IGL5-LTE with
-- 
2.55.0

