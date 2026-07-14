Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B233C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0DC10E313;
	Thu, 16 Jul 2026 08:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KeHXwcoH";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5401D10E057
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:11:23 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47defd0c1c5so1042079f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784056282; x=1784661082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8SgW7Vtvc0tFBeUiDAXyhdKRnHwKhXWugDI8a8LDJqs=;
 b=KeHXwcoHfGLXeS9YtSfAG4yS3G3v+QCBtGtADbcbyfJC8MNWzLD1bBiovKq2majpRn
 K/Q/wzAf07w1PHiuQqmNobWIoki2qRCruk6JJIeaHzFujCganysi/Bf47TfYEW5PpL2o
 34LUOakNDhl//5A6T/gfpmHzfkHJgoiknsePkZmEOIPTK84RJY72vMKKv6HdHHalOaIv
 1XkM2b9GBWEvr6CZ3jyRe5aKTfJuKmZDXvIhQ1aS9mJirWGiJUE67zwQv93CAQO17Knx
 yhP7XVUi/VseP2Q/7VHuXOCtjshck9HzuAJU8erJtXKHzEF9lhspnEOarETjXDH9OBSF
 Hg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784056282; x=1784661082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8SgW7Vtvc0tFBeUiDAXyhdKRnHwKhXWugDI8a8LDJqs=;
 b=WZT+PjE2L7U5qF49/6m/VBMqzFBc542JGk3DesexpefKMxJQ1kDzCex5hd9qh4aiiQ
 daQmhgAVc21+PwyJCDfBwhLBEHB3eptLELjRG7NyfGD57HJXHU9k5w4ZIHLewE/NOrdp
 DVoF6bThTKV/Am3n5GvFfBnxtcLkl2+tkKn7511mwiGXKh146NLiMk3ZF2wVl4hzGiWI
 j57zqHgZsJaE0uQuY4+4KOccka0yMevFWhf5N60UR3G+B8W0wfspOkzZ4uhMv86nMPBX
 gY+eESSi4v2tuRDr0D8gY9pJkjPCWst5mB6tex5G7I1AlJYfvWV/jDbysUwI7M1V4Lix
 wL/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZ13PTSCssQJ4JEE6isRAvjNqPZ7EueBcVvDlqUe0Fks+oiC5IAGhjopXOGPHzJdxwEXDkAPsjX/Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD2fm/qJ5Sbe0jFYHB/9SjqsJ5XKSFuHKOC5/lIZJkCi27udqW
 oeXzD/JF6Aog7moQ5uKegEfePoMlYMHWDfYIRFIbiTDkFMLzNf3+044SdCHe1xN1kc8=
X-Gm-Gg: AfdE7cnl67tjnmobqlygICT7KBfbyoqEH8p+IT92M/ODq6b0GuebLaPiT3W5ZCl1Lmq
 Ib+5otvDqJ47x4yJZ3di1rIcdaMC6fMjtoGoQZVGooOmjhnK6xtZlqXA8ryS+/KqnEjiVkKx4z6
 U5N7qdqCpG+FI0deKgwmY7mfZEoxg1nkpDFrT4s040LpyoP9L+4j/BruQLe4EzhZL/uYDwGK6fG
 S8h/RY+KPOD3Y0Y1EPx5jt81TEbBjYkhYJ9RhirDiXY+lOJJWXowQncy85TCMEYGzSOp6lF4jmP
 3YIi+DzpCClpBFMeTmY348hYLsBUzsAsgqFIBNt1vlw/ShAs6tv6ngY4c2fYUQx3n9rlgsxovsL
 MHS+99Wju18feg+9IAB3Z09a4plNQ182UDNj9bZMk7eKoaBoRZKQJtza3xzMkSQR0sioKVQF9Eg
 hRLhtbePTMm6cEZEOT8asg2xLi/JEUgWqsxNdaPwMxHxJ6w0p1Mqe99QnPTAGq+oMaKTuXnuyQ7
 as9Ggmvexc=
X-Received: by 2002:a05:600c:310f:b0:493:ee3a:f05b with SMTP id
 5b1f17b1804b1-493f87d7fcdmr147477765e9.7.1784056281449; 
 Tue, 14 Jul 2026 12:11:21 -0700 (PDT)
Received: from evil-archie.tail5479a9.ts.net
 ([2a02:1388:23c0:16c0:aa41:f4ff:fec6:26e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2f951asm100677815e9.14.2026.07.14.12.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 12:11:21 -0700 (PDT)
From: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: namcao@linutronix.de, tomasz.unger@yahoo.pl,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Subject: [PATCH 1/3] staging/fbtft: Remove prohibited space before close
 parenthesis
Date: Tue, 14 Jul 2026 22:09:40 +0300
Message-ID: <20260714190958.219437-4-graviaspanagiotis1@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

Fix checkpatch error: "space prohibited before that close parenthesis"
in the define_fbtft_write_reg macro.

Signed-off-by: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..38697992f5e1 100644
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

