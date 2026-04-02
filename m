Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B57CC6B3F
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4A110F1E0;
	Thu,  2 Apr 2026 09:23:19 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6724110F1E0
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 09:23:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5654A4D321;
 Thu,  2 Apr 2026 09:23:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C21D64A0B0;
 Thu,  2 Apr 2026 09:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mNc0LoE1zmlVYAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 02 Apr 2026 09:23:13 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, arnd@arndb.de, ardb@kernel.org,
 ilias.apalodimas@linaro.org, chenhuacai@kernel.org, kernel@xen0n.name,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 deller@gmx.de
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6/8] firmware: sysfb: Avoid forward-declaring
 sysfb_parent_dev()
Date: Thu,  2 Apr 2026 11:09:20 +0200
Message-ID: <20260402092305.208728-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402092305.208728-1-tzimmermann@suse.de>
References: <20260402092305.208728-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5654A4D321
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
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

Move sysfb_parent_dev() to the top of the source file to avoid
the extra declaration. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/sysfb_primary.c | 36 +++++++++++++++-----------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/sysfb_primary.c b/drivers/firmware/sysfb_primary.c
index 298f87a43a7e..a7f8cede60ad 100644
--- a/drivers/firmware/sysfb_primary.c
+++ b/drivers/firmware/sysfb_primary.c
@@ -42,7 +42,23 @@ static struct platform_device *pd;
 static DEFINE_MUTEX(disable_lock);
 static bool disabled;
 
-static struct device *sysfb_parent_dev(const struct screen_info *si);
+static struct device *sysfb_parent_dev(const struct screen_info *si)
+{
+	struct pci_dev *pdev;
+
+	pdev = screen_info_pci_dev(si);
+	if (IS_ERR(pdev)) {
+		return ERR_CAST(pdev);
+	} else if (pdev) {
+		if (!sysfb_pci_dev_is_enabled(pdev)) {
+			pci_dev_put(pdev);
+			return ERR_PTR(-ENODEV);
+		}
+		return &pdev->dev;
+	}
+
+	return NULL;
+}
 
 static bool sysfb_unregister(void)
 {
@@ -101,24 +117,6 @@ bool sysfb_handles_screen_info(void)
 }
 EXPORT_SYMBOL_GPL(sysfb_handles_screen_info);
 
-static struct device *sysfb_parent_dev(const struct screen_info *si)
-{
-	struct pci_dev *pdev;
-
-	pdev = screen_info_pci_dev(si);
-	if (IS_ERR(pdev)) {
-		return ERR_CAST(pdev);
-	} else if (pdev) {
-		if (!sysfb_pci_dev_is_enabled(pdev)) {
-			pci_dev_put(pdev);
-			return ERR_PTR(-ENODEV);
-		}
-		return &pdev->dev;
-	}
-
-	return NULL;
-}
-
 static __init int sysfb_init(void)
 {
 	struct sysfb_display_info *dpy = &sysfb_primary_display;
-- 
2.53.0

