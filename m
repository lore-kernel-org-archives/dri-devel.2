Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCD9CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6396F10F23D;
	Thu, 25 Jun 2026 10:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mV366HWi";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A685910F23D
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:31:05 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30c6836fea9so593643eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782383465; x=1782988265; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TKJsVWDIVCaWALiuCSmxIi+GmrzYP0RWrh9s3UMN5KM=;
 b=mV366HWi2+ee2Gww8TarnarbNW7skn775zIiby3d5Gf4rkIyxB7AMT+FRvjdsdwzIG
 mRvdGN5XK3SwzXnpF+ig3rgdMK5rJydv/dQbUjv3E9I7GrVnalxTGq+8Pj16Bk036gdl
 nudYCRUd5WpY7YtJ3BuY17XzVTTr1oTd6T7rVXP8gcPG9fw5ZyuHUrdbxXTBouTrv2s+
 J8wAmEBLsBpfTXA9CQTORtD9eeoQNWIDKjmyBRVESbY5E7/YSfZOz8HWReLCg6QmpeA8
 fijQo9uihMmH4tTZ061bCZKjBP6NEjbmx5xW88O4DXpF98EiSFMewVRkH1dcxmy3eCG6
 +Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782383465; x=1782988265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKJsVWDIVCaWALiuCSmxIi+GmrzYP0RWrh9s3UMN5KM=;
 b=aoXAgKdRYWur78CAddoiaTtWPpAkoI2/tt0cDksFdo15sV6TA0MVpxis+r9k5yQYlx
 kZcF312OgZg9vSLFbceIcYHs2OFoDn1fEd58Jus2kgsmwSEiv9U0r8q6nyc7EL5jQtw6
 pbNZA76B3MAQ/oyA+G3Q/CtXIxxPJdwuQRlyQk75aeDvb+9zjPVG9SxnMepNmcGfv6DI
 JRKQgruyFBRLkj3PpNORf11lxF/8zGp0kHJ3LEN5ATEC96avVcoDBEydvijmFFDlsOj+
 niQB5u7rk88iXYziIqoSF8QU6tzdHC1Ejkyp/tNUXsnklb2L3Tq0RHsTmLHckfJ0QmIM
 7zbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrE3WohdK3FDJc1HN3rpDtws/2no/msJIVTRvXgeqPw7fXrszY0BX9C6aPUxW8lC7x2oX9bI/laFkE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxB3gkhKdO6IKG8tY0iIzUYrYnMiwuPqMuVs5hMRdnSHPwexrdi
 9So3D3yHXu73B7xcGQNX6dTtEyIf41e+RLqf9fqfG54fQ7yQ8JVPel0b
X-Gm-Gg: AfdE7cnErUdk/r23wTUTFBAZZGCQuZk7LoYce11wXJhqXPbQ/cmPn7o04u1RWXRrxBq
 wlFnIuf3f0e0hAbqSDqUG4NPI1KAstQNE1zSXrar5/mzr6Di97Kb6gFdIkmmS7aNJCKK9qwbmAg
 oyyav5iB6bHEyZacYBoSPIOg4gkBXcNd5RgtA3W27nanzdTa5AZpEHjLJ96TeGH4VUK9gpy6uyG
 9bGG/ML1kWrxMjNQiFKZS/3btxG0KPrpti8WNYTXjO/+INk6ePGc8Z0Obq8E5hf+gy5a1/44qYV
 za5i25HcCRT9pAzfkdX05TRX+A2318kCzMhRYxtkE+mb7rRBipxQkWFeZDzZzs1TCCYd1WpivD6
 KWWqK7DsTLHd0H9o4z+53fdSP3svmLzXNs5TUFXvOWFqyIs5pG8KZ1ikzS6ZZsKk2g5ig4Of7gf
 Gtu5TRdl1qMRhfl1+gerLJn55KouRyRFWTgQ==
X-Received: by 2002:a05:7300:a485:b0:30b:8878:9c8e with SMTP id
 5a478bee46e88-30c85468412mr1914301eec.2.1782383464754; 
 Thu, 25 Jun 2026 03:31:04 -0700 (PDT)
Received: from 10-86-27-11.ban-spse ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca5e601sm7458658eec.25.2026.06.25.03.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 03:31:04 -0700 (PDT)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] staging: fbtft: fix unaligned access and buffer size when
 startbyte is used
Date: Thu, 25 Jun 2026 18:30:41 +0800
Message-ID: <20260625103041.281190-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
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

When par->startbyte is non-zero, buf is advanced by one byte creating
an unaligned pointer for 16-bit types (u16, __be16). Dereferencing this
unaligned pointer can cause a kernel panic on strict-alignment
architectures.

Fix by using put_unaligned() instead of direct pointer dereference.

Also fix incorrect buffer size calculation in fbtft_write_buf_dc() call:
  len * (sizeof(data_type) + offset)  /* wrong: multiplies offset by len */
  len * sizeof(data_type) + offset    /* correct: one startbyte +
                                         len items */

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 2169f8d1d..cfcf4d7e7 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -4,6 +4,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include "fbtft.h"
+#include <linux/unaligned.h>
 
 /*****************************************************************************
  *
@@ -40,7 +41,7 @@ void func(struct fbtft_par *par, int len, ...)                                \
 		offset = 1;                                                   \
 	}                                                                     \
 									      \
-	*buf = modifier((data_type)va_arg(args, unsigned int));               \
+	put_unaligned(modifier((data_type)va_arg(args, unsigned int)), buf);  \
 	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
 				 0);                                          \
 	if (ret < 0)							      \
@@ -52,11 +53,13 @@ void func(struct fbtft_par *par, int len, ...)                                \
 									      \
 	if (len) {                                                            \
 		i = len;                                                      \
-		while (i--)						      \
-			*buf++ = modifier((data_type)va_arg(args,             \
-							    unsigned int));   \
+		while (i--) {                                                 \
+			put_unaligned(modifier((data_type)va_arg(args,        \
+					       unsigned int)), buf);          \
+			buf++;                                                \
+		}                                                             \
 		fbtft_write_buf_dc(par, par->buf,			      \
-				   len * (sizeof(data_type) + offset), 1);    \
+				   len * sizeof(data_type) + offset, 1);      \
 	}                                                                     \
 out:									      \
 	va_end(args);                                                         \
-- 
2.47.3

