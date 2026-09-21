Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9240BC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C15510EBE2;
	Tue, 22 Sep 2026 08:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EXzUnAFe";
	dkim-atps=neutral
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com
 [74.125.225.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 821F010E3C7
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:33:36 +0000 (UTC)
Received: by mail-wr2-f11.google.com with SMTP id
 ffacd0b85a97d-486e4e15deaso1203765f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790015615; x=1790620415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8qwDua38LIyW1TawgxN9o1m0hOow5CaSBoRxma0znMA=;
 b=EXzUnAFePWiL0c0CYPcPYx/w3ML7RiKfT3ULyHykr/HvAzVfrwVYaCqqbG9ZFePps2
 mNCBj4pGjJ1/PEKYXXBYYLF1C+IZQ6BXiji4NSoBmDgZVtHtuwkQ+641seUQQtX9zxD2
 wgi0GIBU72/3/JvTEpKOv+wK42wk+CJos0bgHUZBju6nZMDImX9XoFbWRy+nD5sHxTJp
 KbdzACc5kp00RqCPxGnYhVfTv2qZj2rJrNnbaOsySJzzNj6a2BihX5jUshe+k26w9VC3
 AGCMW99L3F3p1DX3cTK3aYJ2EjbxLRdRAipJrBhquUY/C4C+jJiHuxm9dboLzvO7+OGo
 q2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790015615; x=1790620415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8qwDua38LIyW1TawgxN9o1m0hOow5CaSBoRxma0znMA=;
 b=zhqQjt6A9HT05cf6DhnjxZ9KigMYj6yR9/d6tsfiYhrRx7MyuK5GB1L0m5Ld4S8wVN
 vo7M+4MqevsZTwTWmQ2656javyVd7FxZcXodM8GPT/CzbuOTERfwuCJIty3SGZzrS0HF
 KOzmeT3oi2uN6qrY0jmtBLrsam+/ScNs/Tto6NlPrnch1sksfL3BwbWQstuIsj2XBdHl
 zU2XuxPutwElrBx0UZw2JACam8gyjIOb04n920+ejgd04bMT5NqCk7e7c3jDN2NcylEr
 mL+ez8qzGKponNs/+406C7XoD9FldZC5ta9gn5nvMsbhkSTDp4/pKqUfl9yVyOLwnRzO
 trag==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4HhojQSk9Sshvv6YPpJvHGWNFZkUJTlg3159vVXtVXpyVShHOIo9z4McgyRkGhfV/jfqVu1elZIU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ntWB1sNOZqaYeQY1vHOqDAUrKr26OeH/iKQVhP2dzIMDZ+roB6
 LUokNm1HvwCsiqLspMbj8XW9NUPp7QPVPPj0ftVXma/irmdYZaAHA/cC
X-Gm-Gg: AYBFou3NlZkYAE4sR0LZ2r/uyKgYxey272taX74evmOqpa3Gm6V4j24Cuo2PFmWHhwI
 JnWrJSF09hQql4VADh7FvVtwe6VKdMGHFjgrnbg55N7BL0xERYfijJBbP7NkHUCI6NhBPVJN7aW
 Xzk9cOXbxFh79nbrNPZu3cmjcqySttEGdixRB/OFtb4ZOKbtiLW7hWXBkZxXbitT/XzjM99/I9N
 J6CM3TUyKAh9RwO0MVJliuL2jIcEjhJsuvRd2TAuf5G6YvdGMj9cb50ys6/yeHfs873z+5tN/t2
 7GhQ/FWiP8K1bFpXQvEDQvoS0EtMAyPAARU8r7q4R0jqAXhq4WD5FRMzyH3Ob8aefLDu9LxYLlh
 c6XcSYq/5BwqnVzBYiksz/3nZCnVrwA3NnGCLXmGDueZv9jxtMszE1lfneVltOt/PDwqXHV0qyr
 rQM3zTweIos+mOr954hMoqB1hzBqnOkkn0mU00udcflgyfQOERzNZ+wDhFxJ9B+niN/kuHG2Hh3
 gnVOI9Zk2si1hvK
X-Received: by 2002:a05:6000:2584:b0:487:27f6:a4d5 with SMTP id
 ffacd0b85a97d-48727f6a645mr11933217f8f.37.1790015614392; 
 Mon, 21 Sep 2026 11:33:34 -0700 (PDT)
Received: from gbox.chicasongroup.com ([197.210.105.26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872456ee4esm23679114f8f.21.2026.09.21.11.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 11:33:32 -0700 (PDT)
From: UgwuRhema <hikarialiyev@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Andy Shevchenko <andy@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: fbtft: fbtft-bus: remove space before close
 parenthesis
Date: Mon, 21 Sep 2026 18:33:12 +0000
Message-ID: <20260921183313.92795-1-hikarialiyev@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

Fix checkpatch.pl errors regarding prohibited spaces before closing
parentheses in fbtft-bus.c while retaining trailing commas required
by macro definitions.

Signed-off-by: UgwuRhema <hikarialiyev@gmail.com>
---
v2: Keep trailing commas in define_fbtft_write_reg invocations to prevent
    preprocessor build errors from missing macro arguments.
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..38697992f 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8,)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16,)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.55.0

