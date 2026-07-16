Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0EAC4450E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 247A710E32B;
	Thu, 16 Jul 2026 11:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bTj/OcXl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA25010E32B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:08:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CEBE36001A;
 Thu, 16 Jul 2026 11:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79F0CC19425;
 Thu, 16 Jul 2026 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1784200115;
 bh=x1ZIyVKdr7A/SeoU6wb+U8BSxH8pNQF4hiJSDCyNV7s=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=bTj/OcXlfSg8X2KjsC7qjq3xzuquWV99Vf7k838VMGZnX2GdEhuYe1F7LXZ1apuAo
 In3mQ/la8gi6ijCfs5Uh6ZMzIr34WEmACOua/HCps8O+7hrHivIVIJb7+W/ViQGrC0
 7rZDqZ36fHqsEs3KVKbSvMwDp5gM13o3J4K7XXCuLnEEUJWQCkZyTcoNx11xhF5VEJ
 h0Cx6mTpwqLMU6Smz//kfFcyj5iAdXHnlfZKKBn8pvBaWazqIo4IA99jbk2jEr+KDh
 uLZwkQxX4iC9gZdWdSaeo+KJ19g7RvScZLQALc7kEhLXsE5h9rfmFld/wDgRQxe6+t
 3yy24k6hbGL2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 69F41C4450E;
 Thu, 16 Jul 2026 11:08:35 +0000 (UTC)
From: Selby Mashiki via B4 Relay <devnull+mashikiselby.gmail.com@kernel.org>
Date: Thu, 16 Jul 2026 13:08:33 +0200
Subject: [PATCH] staging: fbtft: fb_ra8875: replace udelay with
 usleep_range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-staging-testing-v1-1-2ebc0c6bb27a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMzQqCIRCF4VuRWX+CY2DRrUQLfyabFhaORSDee
 9q3OjyL83YQqkwCZ9Wh0oeFn2UCNwXx7ksmzWkarLHOHNFpaT5zybqRtLUBwwmTOySTEObrVen
 G33/xct0t7/Cg2FYGxvgB5ulh2HMAAAA=
X-Change-ID: 20260716-staging-testing-b1b81d63d0d1
To: Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Selby Mashiki <mashikiselby@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784200113; l=1339;
 i=mashikiselby@gmail.com; s=20260716; h=from:subject:message-id;
 bh=Kw+oD1A3+MZuZjRR0K6KD78XW22TnMscyBb1Nk+0T4w=;
 b=+XPtQJi1tekVKGVbfuhRY+B22fbiiusYW8TIqcCqQ4iPZ2931p+OWTAgL0WeT9DfelBFQd/9T
 PeId6DNZnE7BgpJEDPyRCWLDoFaoaVkKJyNgYYFevuEBf03PbzXTZ28
X-Developer-Key: i=mashikiselby@gmail.com; a=ed25519;
 pk=pdu1PfyliHcDzX9YL6q+8PseyTQ5vDHYAsHmrqMp/BQ=
X-Endpoint-Received: by B4 Relay for mashikiselby@gmail.com/20260716 with
 auth_id=875
X-Original-From: Selby Mashiki <mashikiselby@gmail.com>
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
Reply-To: mashikiselby@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Selby Mashiki <mashikiselby@gmail.com>

udelay() busy-waits for the specified duration, consuming CPU cycles
unnecessarily. usleep_range() is preferred for delays that can sleep,
as it allows the scheduler to run other tasks during the wait.

Replace two instances of udelay(100) with usleep_range(100, 200) to
use the preferred sleeping delay function.

Signed-off-by: Selby Mashiki <mashikiselby@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de664..d2400bb44 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 200);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 200);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)

---
base-commit: 64276d9bfe4d1fdd5cf2636f1065f7ea55c2defb
change-id: 20260716-staging-testing-b1b81d63d0d1

Best regards,
--  
Selby Mashiki <mashikiselby@gmail.com>


