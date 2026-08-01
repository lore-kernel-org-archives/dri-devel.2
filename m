Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51227C55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 19:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D7210E093;
	Sat,  1 Aug 2026 19:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=inria.fr header.i=@inria.fr header.b="PvW93Bdv";
	dkim-atps=neutral
X-Greylist: delayed 427 seconds by postgrey-1.36 at gabe;
 Sat, 01 Aug 2026 19:17:18 UTC
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB5910E093
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Obf+OAwdCbGTMg5s8OMIUCRXXMLFg7TjgwLzcmwd1Hk=;
 b=PvW93Bdv2aVz7I9Ur0XKzFex8YvgHW7R30T5j8keacmHsr5vdbh5Y00W
 bVET7D0PbHpLZCN1h5CsOsrnACHouyovfMsQOZJIfWM6tn+LLowD1nyL7
 5LC+NofowRfjUCE+BwKn9SQmAJSNGz9tAt7jv6D5L/si4k6h+f3yXLyHW U=;
X-CSE-ConnectionGUID: 8JUcfgo3QPuyUUTvvQfNYA==
X-CSE-MsgGUID: OlJOKjkRQ/exrGUcgFwTEg==
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,198,1779141600"; d="scan'208";a="288769004"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 21:10:08 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Helge Deller <deller@gmx.de>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: au1100fb: drop unneeded semicolon
Date: Sat,  1 Aug 2026 21:09:49 +0200
Message-Id: <20260801191002.1383835-3-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When a function-like macro expands to an expression, that expression
doesn't need a semicolon after it.  All uses have been verified to
have their own semicolons.

This was found using the following Coccinelle semantic patch:

@r@
identifier i : script:ocaml() { String.lowercase_ascii i = i };
expression e;
@@

*#define i(...) e;

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/video/fbdev/au1100fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index c54cfcd83..39f86ffb1 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -393,7 +393,7 @@ static struct au1100fb_panel known_lcd_panels[] =
 #define DRIVER_DESC "LCD controller driver for AU1100 processors"
 
 #define to_au1100fb_device(_info) \
-	  (_info ? container_of(_info, struct au1100fb_device, info) : NULL);
+	  (_info ? container_of(_info, struct au1100fb_device, info) : NULL)
 
 /* Bitfields format supported by the controller. Note that the order of formats
  * SHOULD be the same as in the LCD_CONTROL_SBPPF field, so we can retrieve the

