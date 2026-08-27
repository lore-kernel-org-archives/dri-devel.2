Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C087C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A88110F074;
	Thu, 27 Aug 2026 14:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="UDMN1KzY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ISwxje6k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DVdiCFkx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hhkPzYFL";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCE910F074
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:09:57 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB3C61FB13;
 Thu, 27 Aug 2026 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787839657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9fF3OjXFyEyDS9yYzoDAeLw8OXERCdMjVgsaLVzWZE=;
 b=UDMN1KzYVYL7dy4MkAAs5/kMffLuzDMNVHhwMCKrN8ed/2IjAMWiIh+PupBfDsRblAaQ94
 ja3kOim07SQ30O0cxqiKhSjAS1cLeynqTE0BVvMZvp89e9e8CpKSdwmZDXdi1JVLfelLjL
 JSnIupcY5za+ZkP15WZCSjl0ieVbbZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787839657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9fF3OjXFyEyDS9yYzoDAeLw8OXERCdMjVgsaLVzWZE=;
 b=ISwxje6kwO6EODFCampZZ2GMjuIJU2NgOxySaw++nDdsFHWpSgSkXRb9EPAe9sXU9ZOEzo
 j0hJfwvkICQs3dDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787839653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9fF3OjXFyEyDS9yYzoDAeLw8OXERCdMjVgsaLVzWZE=;
 b=DVdiCFkxkYsq8YEInDYHzr0bN4lLHBSOGvG9/mmq1bR548QJyN+jTe/BCWWXVDrWvZW868
 w9qP00sKeQvHG6UmYSh1MK+qWgCXONp2DgiMPfCieH9/J414LHt20s5iPnY6oTTWB/1TEQ
 MAXcUmEDpGKRPGoEJGrIS8UOzevrFbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787839653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9fF3OjXFyEyDS9yYzoDAeLw8OXERCdMjVgsaLVzWZE=;
 b=hhkPzYFLBzOlYWkAkpHOC7K1b7ptBFewwO4inoSfUmtupjDvMkHg3u+AP30ycPr5c3mUYb
 9ajHWzySTANHo8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58E6C1361C;
 Thu, 27 Aug 2026 14:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2Il6FKVEkGp0FQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 27 Aug 2026 14:07:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, ardb@kernel.org, ilias.apalodimas@linaro.org,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/3] firmware/sysfb: Remove rotation quirk for Lenovo D330
Date: Thu, 27 Aug 2026 16:01:39 +0200
Message-ID: <20260827140726.420734-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827140726.420734-1-tzimmermann@suse.de>
References: <20260827140726.420734-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[redhat.com,kernel.org,linaro.org,linux.intel.com,ffwll.ch,gmail.com];
 RCPT_COUNT_TWELVE(0.00)[12]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

