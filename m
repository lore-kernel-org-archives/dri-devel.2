Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6815CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BD810E582;
	Tue, 29 Sep 2026 06:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Zc83Xd8i";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4DE10E582
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 06:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790662345; x=1791267145; i=deller@gmx.de;
 bh=WN2wcsoLDOGY/sfLHbxYR3nGKcjrwhloVxKkM82pLgw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Zc83Xd8i2XxeH18Bewjh0hdgG9Z4XMregDGe6TP03sUium6gsE2wTH7nfcZFlU2G
 8wNmQ4tB+GNLV5SiQAi6q/hRGX07EhZUwuQn+lzDTw1NBtNn0PZY3sDYlgE/LJpzG
 VxL/j3dmy4BhgQj48JobWV0MnrH5t0u34SEfLLdbDm+ThP8uQ01bNsXL532J/bKCS
 CZZVODrK5aqs9UGQhUxGZlxmY/+xAfYgG03AB0CX8mwm6eIe15GFkBI8LILuhgET7
 wJmU3Cuw10nLDMdY71MhjAR7oBODZpwNViT++QJakOQbzgurRVNZ27wiglYV3LeCt
 9fDPs/6WVWSo6lNarg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1xGbbZ3v2j-00PSWZ; Tue, 29
 Sep 2026 08:12:25 +0200
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: kernel test robot <lkp@intel.com>,
 =?UTF-8?q?Miro=20Krop=C3=A1=C4=8Dek?= <miro.kropacek@gmail.com>
Subject: [PATCH] atafb: avoid cast when assigning buffer address pointer
Date: Tue, 29 Sep 2026 08:12:23 +0200
Message-ID: <20260929061223.55435-1-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9gAy4UGIXznppLNH34dI7Rvkahxjgck+ST04HvcJdThU2eeYXQY
 YYV3+umXjzfgP7p+5uM7SV+8NUmgNxfHMzLZFsjDHXroQyirM0p3TfojsZagIzXiMSrj7lL
 0iOVyLVU7/KCbVs0hE9iZZ2zXufeuu2jDtr+bZp8jiF78SqY0t+ZZH3LcLJe+/JvlmY016Q
 YWEfelnG54EJVaLMogUnw==
UI-OutboundReport: notjunk:1;M01:P0:8L6q+tMGQxg=;55J/dC7Gnfm5+LppYnZuPWrS8qt
 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
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

The sparse tool complains that the "cast removes the address space
'__iomem' of expression".
Avoid the cast by using the screen_buffer pointer instead of the
screen_base pointer from the union.

Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlit=
ter")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609261313.kgFtkz2t-lkp@in=
tel.com/
Cc: Miro Krop=C3=A1=C4=8Dek <miro.kropacek@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 drivers/video/fbdev/atafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index 5c3e5861543a..c32576cb1720 100644
=2D-- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2454,7 +2454,7 @@ static void svblit_fillrect(struct fb_info *info,
 		((u32 *)info->pseudo_palette)[rect->color] : rect->color;
=20
 	/* draw the first line with the CPU ... */
-	line =3D (u8 *)info->screen_base + rect->dy * pitch +
+	line =3D info->screen_buffer + rect->dy * pitch +
 	       rect->dx * bytespp;
 	switch (bytespp) {
 	case 1:
=2D-=20
2.55.0

