Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF5606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yQ6ER1Lo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF9F10EA0B;
	Sun,  1 Nov 2026 12:00:45 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7A710E079
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 04:23:55 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so570230a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793420635; x=1794025435; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oyMiLoLSdUtmLwvkMWGKLcY+WxNb77Nh3Idx5n8lKi0=;
 b=yQ6ER1LouvJgcP+833e5QD8tlVb5b7PYGhNo26WEQZ9/Z2oJBEbgCaOowejQ9uEEg0
 iwiXYTGqPpyMoczR1A2aIh4NEMMsVeIVjH4AnsHhngUBBCBdUhC75xObQ7HeMCD+Kgwf
 24r4tcTjgB5VLtdhyvi0lB61sKQsnRX9DMNlRyVcmn4sGUypBp0Oj4Z4LdfMWShSrJPe
 qod/3fTesOV75A0heZ6bU9XQyhUstmxDeftsrO+H7t6RMA3BZCvprs3l1pGIOEFm5Fqr
 RrA3Tl5esoNHBDxETqhHEDrBUXEpHatjZeicl0hTmjSsrHcc7hvE1uja17WCl6gbRWSW
 9vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793420635; x=1794025435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oyMiLoLSdUtmLwvkMWGKLcY+WxNb77Nh3Idx5n8lKi0=;
 b=ZcnGkOVBRWd9fTPf2Yo7dc2QmYS6q9bl0rlyGr10dbTGhBygOGdIg9jgVFy4Cr7f7X
 K8A2wXk7IiOU6iJsiVJQ4Gp9RwBH7Pfk/HdBYX5Hrk7o7CLeUv1RNthNi5LTwpzX4Dge
 RCdbReeTAhkagy/ZN281UcPBvRmYVvlULe4oa93NNaTQum4+4uwKd+dmqAkh0hw57MLG
 POrmY1yJ0DDKaiYuGJCgDrmxF1PxruJ3eXZd+9g86lDDc2wjIZrgCT9yaw9aebvkm1PP
 ruoFaztMu0U6STEg0jX0hdnqzNGoiih1V7Mu2hjmxTiTMRlUw9pyA3hKdaeg7wRvwjpW
 +K8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1P70AD5/Pn9zfSGN65wgEicsEjyuMgIwoiGOUPcdjNIoaeUxqrD5kJAwgKWx7Fz0LaySBRVOlTNg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKReSvTklakMRZ+N1eUQUbYrqm0UQ8bX0YguuhtNY/L2QjFS4Mu
 WrMcMT4bsEoUiSJGso5AbAtYnXPXc3YfwvViV7dCy2fPCYcp1JhRGQ/4
X-Gm-Gg: AYBFou0dVuVodrTNAVVjGpMD7AyE+W8Gdy8O4gv9mMrrMhuNcaEPAEl7XIliOB2vo7K
 dVo369vPx0pe1GS8HD8rpy5Nu7nkHKVAJgp+xflQBr2tjS2ark4lPSsa0/BE7L+lDt6Clcg4cVO
 CcibiGAEUyaZ6jhCMMCykKUU3D/8ibuvxsS0sYWlyB5UW4avfV6tYejJNnHPJdm0AYGRwOw5lR4
 PqSf/d76IYTgirbnQVgSIfR8dmGqXt6IbO1yOvu9Qa1mOrYV+dFqQobgVCFrw1fhaaF3yXtMxsH
 8dr0DJvKbiyUqXe+mraaV5UDd58j5+tFD0rJ0Q9VlWxeGJaq75/O5e/X8RKnE3MD1inmv6QTtCq
 OZ3/PsAdabNMD0iRTt1pz3tJ1kxpG2lrUlMsx/WIEHEb/Osa9rMKR/xgzriT7ifEMK9bTqtyu5S
 XUqpN/YBV5/QQOicbtf0RydOoMpqSWMbpvK40GIaSnCzIQf0rFDeK7eEeTbaR4VVhY2qrP7uama
 DAzshts4czTTB+y9w6UO9kepHFwqvnOknsBkbo1B9Py9VZKnWwa4y50adFQeqCDZF+W+9Ivenyz
 ZYsOIQ80mfMLCgyZIMv1UUOdwdc+OzDBSy3hGYHjBiRTcnAMhwqWt7qEB7h4us7MnFE=
X-Received: by 2002:a17:90b:3f84:b0:3ab:b39f:41da with SMTP id
 98e67ed59e1d1-3ae89776af6mr3372365a91.11.1793420634944; 
 Fri, 30 Oct 2026 21:23:54 -0700 (PDT)
Received: from localhost.localdomain ([223.167.219.91])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae84596e3bsm6344526a91.9.2026.10.30.21.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 21:23:54 -0700 (PDT)
From: Eric LI <eric.lee0305@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric LI <eric.lee0305@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fix space prohibited before that close
 parenthesis
Date: Sat, 31 Oct 2026 12:23:15 +0800
Message-Id: <20261031042315.1122699-1-eric.lee0305@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clean up the following checkpatch error and warning in fbtft-bus.c.
drivers/staging/fbtft/fbtft-bus.c:14: WARNING: macros should not use a trailing semicolon
drivers/staging/fbtft/fbtft-bus.c:65: ERROR: space prohibited before that close parenthesis ')'
drivers/staging/fbtft/fbtft-bus.c:67: ERROR: space prohibited before that close parenthesis ')'

The reason of that error is the modifier argument is optional to the
macro define_fbtft_write_reg. So, even if removing the space before close
parenthesis, another error "space required after that ','" occurs.

In this fix, I change that modifier argument as optional, so that
it is both ok to use that macro with or without modifier argument.

Signed-off-by: Eric LI <eric.lee0305@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..e483ecb10938 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -11,7 +11,7 @@
  *
  *****************************************************************************/
 
-#define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
+#define define_fbtft_write_reg(func, buffer_type, data_type, modifier...)        \
 void func(struct fbtft_par *par, int len, ...)                                \
 {                                                                             \
 	va_list args;                                                         \
@@ -60,11 +60,11 @@ void func(struct fbtft_par *par, int len, ...)                                \
 out:									      \
 	va_end(args);                                                         \
 }                                                                             \
-EXPORT_SYMBOL(func);
+EXPORT_SYMBOL(func)
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
-define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8);
+define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16);
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16);
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.34.1

