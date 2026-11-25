Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10AC606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=sp3XbSIG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A621120A1;
	Thu, 26 Nov 2026 08:09:01 +0000 (UTC)
X-Greylist: delayed 300 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 17:08:42 UTC
Received: from forwardcorp1e.mail.yandex.net (forwardcorp1e.mail.yandex.net
 [93.77.172.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDBA10FDCD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:08:42 +0000 (UTC)
Received: from mail-nwsmtp-smtp-corp-main-80
 (mail-nwsmtp-smtp-corp-main-80.yp-c.yandex.net)
 by forwardcorp1e.mail.yandex.net (postfix) with ESMTPS id E617B10031F;
 Wed, 25 Nov 2026 20:03:40 +0300 (MSK)
Received: from [127.0.1.1]
 by mail-nwsmtp-smtp-corp-main-80 with ESMTPSA id a3lrP22Zo8c0-skm5dOxa;
 Wed, 25 Nov 2026 20:03:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1795626220;
 bh=hQzOlpIe7Macc6jkr29wJlXF7KJ+0xfNYtPVrAFrPjI=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=sp3XbSIGnCe95K7Azy4+apRXQGPldONKo8EZZtcR4MkhxVqr3LriDbkYR32FY7j4Y
 +71vB4RUEowKwoKeP4+Zk5h1OaiOwBbgn0E8m8xHsRRINjGS2gGpI168gP5Fvcdgsg
 MSGOLn/dML7TTkDQFYBiV2qytGraDEhHl3GY7BaE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80;
 dkim=pass header.i=@yandex-team.ru
From: Mikhail Rudenko <xyzzy@yandex-team.ru>
Date: Wed, 25 Nov 2026 20:03:25 +0300
Subject: [PATCH 1/3] efi: earlycon: unmap framebuffer when the console is
 unregistered
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-efi-earlycon-v1-1-49ac2c0a430b@yandex-team.ru>
References: <20261125-efi-earlycon-v1-0-49ac2c0a430b@yandex-team.ru>
In-Reply-To: <20261125-efi-earlycon-v1-0-49ac2c0a430b@yandex-team.ru>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Peter Jones <pjones@redhat.com>, 
 Helge Deller <deller@gmx.de>, Hans de Goede <hansg@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Mikhail Rudenko <xyzzy@yandex-team.ru>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

EFI earlycon currently unmaps its framebuffer at a late initcall only if
the boot console has already been unregistered. With keep_bootcon, the
console is still registered at that point, so the mapping is retained.

Move the unmap to the console exit callback. This ties the mapping's
lifetime to the console's lifetime and releases it after console writers
have stopped. Clear the saved console pointer on exit.

Signed-off-by: Mikhail Rudenko <xyzzy@yandex-team.ru>
---
 drivers/firmware/efi/earlycon.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index 3d060d59968cf..3a6eaf5481f40 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -14,7 +14,7 @@
 
 #include <asm/early_ioremap.h>
 
-static const struct console *earlycon_console __initdata;
+static struct console *earlycon_console;
 static const struct font_desc *font;
 static u16 cur_line_y, max_line_y;
 static u32 efi_x_array[1024];
@@ -44,14 +44,15 @@ static int __init efi_earlycon_remap_fb(void)
 }
 early_initcall(efi_earlycon_remap_fb);
 
-static int __init efi_earlycon_unmap_fb(void)
+static int efi_earlycon_exit(struct console *con)
 {
-	/* unmap the bootconsole fb unless keep_bootcon left it registered */
-	if (efi_fb && !console_is_registered(earlycon_console))
+	if (efi_fb) {
 		memunmap(efi_fb);
+		efi_fb = NULL;
+	}
+	WRITE_ONCE(earlycon_console, NULL);
 	return 0;
 }
-late_initcall(efi_earlycon_unmap_fb);
 
 static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
 {
@@ -269,6 +270,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 		efi_earlycon_scroll_up(si);
 
 	device->con->write = efi_earlycon_write;
+	device->con->exit = efi_earlycon_exit;
 	earlycon_console = device->con;
 	return 0;
 }

-- 
2.56.1

