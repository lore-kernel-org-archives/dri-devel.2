Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1D6CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 20:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5A210E8A1;
	Sat,  6 Jun 2026 20:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=runbox.com header.i=@runbox.com header.b="g8NobXqt";
	dkim-atps=neutral
X-Greylist: delayed 1451 seconds by postgrey-1.36 at gabe;
 Sat, 06 Jun 2026 20:51:25 UTC
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com
 [185.226.149.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5F010E8A1
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 20:51:25 +0000 (UTC)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
 by mailtransmit04.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <david.laight.linux_spam@runbox.com>)
 id 1wVxcb-007NWf-5J; Sat, 06 Jun 2026 22:27:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com; 
 s=selector1;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From; bh=w9rfQJKe+zMqlTtxFH4kG9pticirwoJsZRsMjcLrr3M=; b=g8NobX
 qtYWBBba5XBa9T5+Aw9bQksIMtU6/TN4yIclBY4ZpUdbRddz+FPA41ptxkEnBQ3sTFjeuzjxO68rQ
 LRmlr8y2lXUz3DcOcpNsjGJQCMl+Ew4NcCFGRLVRBmP2qWsc6bQCi462DBU3V6CEyPCRUhboqFRm6
 XlnXYfZAQ60S/ryRYsIwkV33z6TH+47/JusWKBRcWnZrGZ9I58UdjhnS5cwfYMR4Wr90EFRQSKP8F
 SQGzqILzWVesD2SKnS89mAbjl2TKpWhNahTe7+j0XRU/cW6ag7hZM6uhy1ZNeQqr6czEyM8FuOcXW
 gSOuvN8cVHBTesSCV/JLfC+QQvhQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
 by mailtransmit02.runbox with esmtp (Exim 4.86_2)
 (envelope-from <david.laight.linux_spam@runbox.com>)
 id 1wVxca-0000vh-QW; Sat, 06 Jun 2026 22:27:56 +0200
Received: by submission03.runbox with esmtpsa [Authenticated ID (1493616)]
 (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.95) id 1wVxcU-006elj-DT; Sat, 06 Jun 2026 22:27:50 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 Arnd Bergmann <arnd@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>, David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/video/fbdev/sis: Replace strlen() strcpy() pair
 with strscpy()
Date: Sat,  6 Jun 2026 21:27:41 +0100
Message-Id: <20260606202744.5113-2-david.laight.linux@gmail.com>
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

Use the result of strscpy() for the overflow check.

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

 drivers/video/fbdev/sis/sis_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 84567d67f71d..95f976b49143 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -204,8 +204,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 		return;
 	}
 
-	if(strlen(name) <= 19) {
-		strcpy(strbuf1, name);
+	if (strscpy(strbuf1, name) > 0) {
 		for(i = 0; i < strlen(strbuf1); i++) {
 			if(strbuf1[i] < '0' || strbuf1[i] > '9') strbuf1[i] = ' ';
 		}
-- 
2.39.5

