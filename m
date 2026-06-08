Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CE4CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC5610F08D;
	Mon,  8 Jun 2026 09:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=runbox.com header.i=@runbox.com header.b="ss2jFuUo";
	dkim-atps=neutral
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com
 [185.226.149.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D428410F08D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:55:41 +0000 (UTC)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
 by mailtransmit05.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <david.laight.linux_spam@runbox.com>)
 id 1wWWhn-00Br8N-7P; Mon, 08 Jun 2026 11:55:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com; 
 s=selector1;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From; bh=xVqIb0lvImaOng2149ntOf4c24J0oVttsRUjwn998OA=; b=ss2jFu
 UoSPCSfsvNjOtKrKuBsaSmNNXpZzPLZ1OPg3SSZn90OQzIZHR1k6Ho5AYn895gXTd37Wvao53SUTT
 1eSo+QKS8hk1QzJs6ZfLPrudDBjavGd8aiRLyYOe23MtifvfbiV0IMXimPno8HsfSIq93c9Y4+bJ/
 lnjaudWvPqENSfYuMShPZxJ6WdW5xV4bbhIuDq0StU0O8bLnEDlT6DYyjRJNoF9NhnMVUA6UDKApe
 ym6cQige3cy9e1tMqlUO3aYRv29xx2YG7iPCqaOrE0CuxuLpsZb/HCcYp8Nfid18FDMthzqRliaR2
 QBdKueAJOD4HfFOZvuRePAzxWDJA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
 by mailtransmit02.runbox with esmtp (Exim 4.86_2)
 (envelope-from <david.laight.linux_spam@runbox.com>)
 id 1wWWhm-0000Cn-HZ; Mon, 08 Jun 2026 11:55:38 +0200
Received: by submission02.runbox with esmtpsa [Authenticated ID (1493616)]
 (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.95) id 1wWWhd-00Ag6G-RJ; Mon, 08 Jun 2026 11:55:29 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, Helge Deller <deller@gmx.de>,
 David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/video/fbdev/s3fb: Use strscpy() to copy strings
 into arrays
Date: Mon,  8 Jun 2026 10:54:55 +0100
Message-Id: <20260608095523.2606-11-david.laight.linux@gmail.com>
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

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/video/fbdev/s3fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index ba30e5568cab..b679ccdb38e2 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1333,7 +1333,7 @@ static int s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	vga_wcrt(par->state.vgabase, 0x38, cr38);
 	vga_wcrt(par->state.vgabase, 0x39, cr39);
 
-	strcpy(info->fix.id, s3_names [par->chip]);
+	strscpy(info->fix.id, s3_names[par->chip]);
 	info->fix.mmio_start = 0;
 	info->fix.mmio_len = 0;
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
-- 
2.39.5

