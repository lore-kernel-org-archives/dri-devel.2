Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67819CCF2D4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E70A10E6A8;
	Sun, 18 Oct 2026 14:54:38 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2898710E5B0
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Nj
 KpD5KvXo0yuFxJRRUc1mEoEJbSGpQ+k/5uhHX1AuI=; b=oYTzbovYBFYcWzZ67S
 QmLJMwz1lfqLQ3ir4N0ExjEG4waLlb6cFpXWcJq9EOgLzvFA7zNX0KLZrWx7a9Hd
 B3pPYBxwUG6ShpyRgeSi3602QBHkA3ncAfO+Ely33aDrgb36tcEEfKme8Z+MEgk2
 cHIvR+esO+zxRYBu8+qPldYEU=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3_74eidRqUCqWAg--.42280S2; 
 Sun, 18 Oct 2026 16:54:05 +0800 (CST)
From: wrmfwv@163.com
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 gtl-m <admin@micronull.cn>
Subject: [PATCH] staging: fbtft: fix syntax errors in macros
Date: Sun, 18 Oct 2026 16:53:45 +0800
Message-Id: <20261018085345.17619-1-wrmfwv@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_74eidRqUCqWAg--.42280S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4rGF1UCry3JF4kCr1kuFg_yoWkXrgEvr
 n7W34kZFW8Gr1xtw1fCr1ayFySq3yUZF4qqFWUtFWFqa4fCw48X398u34kKws5Xa1UKFWr
 Cw47XFyjvr18KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8KLvtUUUUU==
X-Originating-IP: [2409:8a0c:6632:a60:c4cc:4691:c4eb:6224]
X-CM-SenderInfo: xzupw4ry6rljoofrz/xtbC5g09KWrUiS0ueAAA3z
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

From: gtl-m <admin@micronull.cn>

checkpatch.pl reported errors regarding unnecessary commas and spaces
before closing parentheses in the fbtft_write_reg macro definitions.
Remove them to strictly comply with the kernel coding style guidelines.

Signed-off-by: gtl-m <admin@micronull.cn>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.25.1

