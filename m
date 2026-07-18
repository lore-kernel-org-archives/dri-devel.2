Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A255C44530
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D43110E7AE;
	Mon, 20 Jul 2026 07:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F39uY6FL";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DB010E5E2
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:23:36 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38cfcb507a3so925264a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784399016; x=1785003816; darn=lists.freedesktop.org;
 h=subject:cc:to:from:mime-version:content-type:date:message-id:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5bmlimQrWEZJP9wXnBlZyV/J+SO0CL4FeYe6T+B47Hc=;
 b=F39uY6FLgMin1umDP1SPYuduP+H0a0y0lEs6QwZiImqLZmwdZ5tSKdbeRHPBonq5ce
 O+t3BSSlTq6O8bMgOiP0T5yb46mWKYTp9CAa1eHt4lVT5tYpf7e0/8X3fbJpy3BV82q3
 yuOgB0DnXu1AKa0AS3eZ5oK49ZAgVNyagp5UT4Ol2ayTC+dboskLGSRX7ci/8X+k0qGP
 ccKOkv7BKj3j6jbuFvPxld9b60EtHR5sjiXHZ6pbQznT4nIOEwSU514AeozH1eQfhfbJ
 6zq90zkoo8tR5MVG0mm4DIkmT9ksF2fis0/1PlO4Pr8x6KczwLxYgLO2TGs0K3nBZkxb
 cNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784399016; x=1785003816;
 h=subject:cc:to:from:mime-version:content-type:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5bmlimQrWEZJP9wXnBlZyV/J+SO0CL4FeYe6T+B47Hc=;
 b=LqUnJcmZYAAgV00tJuBahMdKHjrIIASdFkcvdFSrpf3gn91YADE4F4gVWtzfZiZQb0
 uTgCXX3cGOwBpn7ZgXS9S5MMo5eQKG6poik1tZ9FZxjgN0lHB273aPoSVSZlpErHRHI5
 tUaV1BhNChYaspDUy4XXCRhG/7LHs/j+wG5G3s9Udn0szJMA2KrHIHWcNtKOJKPd2xY/
 yA75eZjy2W017dfKoUDSosjzn2bTdqW1whVU0zq9YdclI+6n6vtIclr3WoupTwLlKcdy
 3TaByX1MDltsdV89/7sTmJ1eFZmYFGyVA3KnM0NC8rDtI3dbMsLfByRvL9NEoYVuX4km
 LBhA==
X-Gm-Message-State: AOJu0YzttrMEZc+xTPT+QVBYop+EPHBr7kyI1RxBrQnqhK8UR0ItMLuO
 JNtIXGSThFWu/4QbO80YEHtFD6jvoVyUlX8BnPR3AX8g8x24aAHQN5FF
X-Gm-Gg: AfdE7cm8uUvWZwjOkwelsHfzDLYpcyAgOnQZBmtOLnKLM9mBQKxvdtpGX428Ht0pF8j
 QwfgitcyHGOfyODEmHo8S8aILmLowlacLA5mGd808KpxirwIPSZLXyzYUQoHDgHTliK7sgt7KVT
 fpouUhBXICN+DaZQKxkpGzQ4d8lcavH7HFSSnhebDjTqj0x1kZqm7G71vmofm7WLYYUuYqwcrvf
 qykbmkNRF9k+34wCZ73hJZ0tR1Is/kV18kvgDF+RfJ+uyoYyrQlPPA+op3UmKrVoDclfjBh5zXt
 uhGbunCYCQqj+l4WPatH+Ph+OL0+cb6sg2Wgl9vfdthltI7fI5mHQvzBsFwaRFrt8OkCcBorZ5T
 jthfthx13wBaytr9kJ4EtZaPdZtaSSX4Z+kzUvLd4zHPoRQwapu5AlUP4VK8mmuTbI0m2OBxzIx
 qrJwexuCiGvMbxqwkg1iby9oeo
X-Received: by 2002:a17:90b:53c3:b0:38d:90c1:2485 with SMTP id
 98e67ed59e1d1-38e4b5d6aebmr6068293a91.5.1784399015906; 
 Sat, 18 Jul 2026 11:23:35 -0700 (PDT)
Received: from Potato.localdomain ([171.76.83.76])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bbda9sm19113650eec.19.2026.07.18.11.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 11:23:35 -0700 (PDT)
Message-ID: <6a5bc4a7.f1c1923d.2d2b59.05d9@mx.google.com>
Date: Sat, 18 Jul 2026 11:23:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5043740731053490976=="
MIME-Version: 1.0
From: Shivesh <chanelshivesh@gmail.com>
To: andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fix checkpatch errors in fbtft-bus.c
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

--===============5043740731053490976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From 7e9684b26176644bc92c2285acc7444f3f7ddb4d Mon Sep 17 00:00:00 2001
From: Shivesh <chanelshivesh@gmail.com>
Date: Sat, 18 Jul 2026 18:08:04 +0000
Subject: [PATCH] staging: fbtft: fix checkpatch errors in fbtft-bus.c

Fix space-related checkpatch errors in macro invocations. When the
modifier argument is empty, remove the trailing comma to avoid
'space required after comma' and 'space prohibited before close
parenthesis' conflicting errors.

Signed-off-by: Shivesh <chanelshivesh@gmail.com>
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
2.53.0


--===============5043740731053490976==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-staging-fbtft-fix-checkpatch-errors-in-fbtft-bus.c.patch"

RnJvbSA3ZTk2ODRiMjYxNzY2NDRiYzkyYzIyODVhY2M3NDQ0ZjNmN2RkYjRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGl2ZXNoIDxjaGFuZWxzaGl2ZXNoQGdtYWlsLmNvbT4KRGF0
ZTogU2F0LCAxOCBKdWwgMjAyNiAxODowODowNCArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIHN0YWdp
bmc6IGZidGZ0OiBmaXggY2hlY2twYXRjaCBlcnJvcnMgaW4gZmJ0ZnQtYnVzLmMKCkZpeCBzcGFj
ZS1yZWxhdGVkIGNoZWNrcGF0Y2ggZXJyb3JzIGluIG1hY3JvIGludm9jYXRpb25zLiBXaGVuIHRo
ZQptb2RpZmllciBhcmd1bWVudCBpcyBlbXB0eSwgcmVtb3ZlIHRoZSB0cmFpbGluZyBjb21tYSB0
byBhdm9pZAonc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgY29tbWEnIGFuZCAnc3BhY2UgcHJvaGliaXRl
ZCBiZWZvcmUgY2xvc2UKcGFyZW50aGVzaXMnIGNvbmZsaWN0aW5nIGVycm9ycy4KClNpZ25lZC1v
ZmYtYnk6IFNoaXZlc2ggPGNoYW5lbHNoaXZlc2hAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvc3Rh
Z2luZy9mYnRmdC9mYnRmdC1idXMuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvZmJ0
ZnQvZmJ0ZnQtYnVzLmMgYi9kcml2ZXJzL3N0YWdpbmcvZmJ0ZnQvZmJ0ZnQtYnVzLmMKaW5kZXgg
MzBlNDM2ZmYxOWU0Li40MDk3NzA4OTFjNTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy9m
YnRmdC9mYnRmdC1idXMuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvZmJ0ZnQvZmJ0ZnQtYnVzLmMK
QEAgLTYyLDkgKzYyLDkgQEAgb3V0OgkJCQkJCQkJCSAgICAgIFwKIH0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwKIEVYUE9SVF9TWU1CT0woZnVuYyk7CiAKLWRlZmluZV9mYnRmdF93cml0ZV9yZWcoZmJ0
ZnRfd3JpdGVfcmVnOF9idXM4LCB1OCwgdTgsICkKK2RlZmluZV9mYnRmdF93cml0ZV9yZWcoZmJ0
ZnRfd3JpdGVfcmVnOF9idXM4LCB1OCwgdTgpCiBkZWZpbmVfZmJ0ZnRfd3JpdGVfcmVnKGZidGZ0
X3dyaXRlX3JlZzE2X2J1czgsIF9fYmUxNiwgdTE2LCBjcHVfdG9fYmUxNikKLWRlZmluZV9mYnRm
dF93cml0ZV9yZWcoZmJ0ZnRfd3JpdGVfcmVnMTZfYnVzMTYsIHUxNiwgdTE2LCApCitkZWZpbmVf
ZmJ0ZnRfd3JpdGVfcmVnKGZidGZ0X3dyaXRlX3JlZzE2X2J1czE2LCB1MTYsIHUxNikKIAogdm9p
ZCBmYnRmdF93cml0ZV9yZWc4X2J1czkoc3RydWN0IGZidGZ0X3BhciAqcGFyLCBpbnQgbGVuLCAu
Li4pCiB7Ci0tIAoyLjUzLjAKCg==

--===============5043740731053490976==--
