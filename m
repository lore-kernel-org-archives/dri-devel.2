Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3751FCD4F39
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 01:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618CF10E3EF;
	Fri, 15 May 2026 01:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baidu.com header.i=@baidu.com header.b="TnzMFVbr";
	dkim-atps=neutral
X-Greylist: delayed 484 seconds by postgrey-1.36 at gabe;
 Fri, 15 May 2026 01:10:18 UTC
Received: from outbound.baidu.com (mx20.baidu.com [111.202.115.85])
 by gabe.freedesktop.org (Postfix) with SMTP id 298A610E1B4
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:10:17 +0000 (UTC)
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang
 <teddy.wang@siliconmotion.com>, Helge Deller <deller@gmx.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, <linux-fbdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] video: fbdev: sm712: Fix operator precedence in big_swap macro
Date: Thu, 14 May 2026 21:02:02 -0400
Message-ID: <20260515010202.2506-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1778806932;
 bh=O6Y4gE06UetHw8c2Elza5KyEZBIyhBBNgcSOAK46jGk=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=TnzMFVbrBxQeJ65sWCgxyv7BmiuZ5wVhoanZWy/FPoDCAKkhbWgAT5ZAi7Qnsrz5A
 z0WToXnBw06ReQfG15S9IolPAw/6RKaGq77AyPtimVhl851LqMQAzRNULBQUqt/9Bv
 MF5LP2Pu0L2o5mjgFvh3sN8P1DcUcJgaaPNTXgPjVhxwnxz60pkW7z3o4lMS6XijXx
 InSvQsawVfl0vBXVwx9WGa/QTy6rM4xTtUr5zc5N8szPmYV8mo0sJMwB9YDQeGIoq4
 gb3LRaFazal1FsdnJpgza0mjyTpB0l+UK9fyGdJQ+9Bm5RuizFh+X2KV8zJj6NCUMF
 8w+j7RyQiOKGw==
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

From: Li RongQing <lirongqing@baidu.com>

The big_swap(p) macro was intended to swap bytes within 16-bit halves
of a 32-bit value. However, because the bitwise shift operators (<<, >>)
have higher precedence than the bitwise AND operator (&), the original
code failed to perform any shifting on the masked bits.

For example, 'p & 0xff00ff00 >> 8' was evaluated as 'p &
(0xff00ff00 >> 8)', effectively neutralizing the intended swap.

Fix this by adding parentheses to ensure the bitwise AND is performed
before the shift, correctly implementing the byte swap logic.

Fixes: 1461d66728648 ("staging: sm7xxfb: merge sm712fb with fbdev")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/video/fbdev/sm712.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index c7ebf03..83fe25f 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -101,7 +101,7 @@ struct modeinit {
 #define mmio_addr		0x00800000
 #define seqw17()		smtc_seqw(0x17, 0x30)
 #define big_pixel_depth(p, d)	{if (p == 24) {p = 32; d = 32; } }
-#define big_swap(p)		((p & 0xff00ff00 >> 8) | (p & 0x00ff00ff << 8))
+#define big_swap(p)		(((p & 0xff00ff00) >> 8) | ((p & 0x00ff00ff) << 8))
 #else
 #define pal_rgb(r, g, b, val)	val
 #define big_addr		0
-- 
2.9.4

