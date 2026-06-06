Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223D9CD8C88
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 21:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164FA10E8B0;
	Sat,  6 Jun 2026 21:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=runbox.com header.i=@runbox.com header.b="EYyX6Exf";
	dkim-atps=neutral
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com
 [185.226.149.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B095410E8B0
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 21:33:22 +0000 (UTC)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
 by mailtransmit05.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <david.laight.linux_spam@runbox.com>)
 id 1wVxbr-007cFs-MU; Sat, 06 Jun 2026 22:27:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com; 
 s=selector1;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From; bh=Bq1xhh7PjUom9z8+i43NNOjTalhx1SZFLg0nAvj3jLg=; b=EYyX6E
 xf8oq1VVUdQGCcKTuaRuELInd3fkWIuPvhbz/MFHNUClONED4J6xm4P6d1wyaJnbpCv79F/9x1rTY
 F4VpxPlUgz/KR7PTeEVvLQ2fbtj6H0S3MbYKdWruRgXZhm8HKSsTTFW6W0/gT0QeyeQDJ1hZ+K0hT
 Q2+Dlw3tSUv0vWoS+RxCDDKAZFEy5RI7CvjRiS9KnSMnOt5rGqpM5eQZsXzhdQkJl2q2fh/LDlvJi
 w0uvMQ+7NzoZ9AMBlFzsvlh6iOH6iwztrnySiAHp8C/elSyiuaydG2Xw4l2Kv6oALH0qmQGWZ2NSz
 dyWN7xhyHkak9R2KCK/zZgEsL/sg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
 by mailtransmit03.runbox with esmtp (Exim 4.86_2)
 (envelope-from <david.laight.linux_spam@runbox.com>)
 id 1wVxbr-0005CH-6I; Sat, 06 Jun 2026 22:27:11 +0200
Received: by submission01.runbox with esmtpsa [Authenticated ID (1493616)]
 (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.95) id 1wVxbj-006V18-Ch; Sat, 06 Jun 2026 22:27:03 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 Arnd Bergmann <arnd@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Antonino Daplas <adaplas@gmail.com>, Helge Deller <deller@gmx.de>,
 David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/video/fbdev/riva: Use strscpy() to copy device
 name
Date: Sat,  6 Jun 2026 21:26:19 +0100
Message-Id: <20260606202633.5018-25-david.laight.linux@gmail.com>
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

 drivers/video/fbdev/riva/rivafb-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/riva/rivafb-i2c.c b/drivers/video/fbdev/riva/rivafb-i2c.c
index 6a183375ced1..5ee59be01850 100644
--- a/drivers/video/fbdev/riva/rivafb-i2c.c
+++ b/drivers/video/fbdev/riva/rivafb-i2c.c
@@ -91,7 +91,7 @@ static int riva_setup_i2c_bus(struct riva_i2c_chan *chan, const char *name,
 {
 	int rc;
 
-	strcpy(chan->adapter.name, name);
+	strscpy(chan->adapter.name, name);
 	chan->adapter.owner		= THIS_MODULE;
 	chan->adapter.class		= i2c_class;
 	chan->adapter.algo_data		= &chan->algo;
-- 
2.39.5

