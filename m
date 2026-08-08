Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D1CC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B4610E660;
	Mon, 10 Aug 2026 06:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYzJmrpd";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A2010E013
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:42:34 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4956869750eso2916135e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786200153; x=1786804953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SjP/0fisv2D7yJeeOFlGdQEogU/eo5V7y2aRYQ0iQAI=;
 b=HYzJmrpdQrfRn9t3AxamFjUrM8p7JlwYlb/mIFhgl5QFILkpz6Q7iH//zSj8JJypNr
 PV4dhya/XWFLJUN0bbGCnYOfFkTZ1QcF3EcbS2t1cVovRc4ygxC59w6LeyElZa+gWupV
 XvMopNG/+oPtoC6vaG9vSPmJLSypNPGrYajQPDUA3ktOCLfiCCEBKZMTxj8zGps+yUVM
 xSWzjsKHC8rpmtVtnahyaDYr7TnGpiI7nIcUSLeqEx1xIdZRkwiOE0a2DA2JzjSuXWnQ
 0UcTeteMMr1iMMrnTIjmGbsYW+6oYMXIQ8LFeL8sYAtmLK8WgEfC5PsTqo7Kg9f4ZcLe
 9X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786200153; x=1786804953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SjP/0fisv2D7yJeeOFlGdQEogU/eo5V7y2aRYQ0iQAI=;
 b=ONnVrN6lqDHXkWjQzr9AmXiaIi76/nwF6jBF1LE5LVPRAxCvH9O0G6+N2t2mSvgQeh
 q/gqofFAkxxcYQw3fsIqQzgrsNHSQmvnfe4mUH9TYTRra08DuPT+PngJMR9E1q4bJ7Gl
 b8gG7s0lm4vlGCI98CPbxV4Fnvtp+/lX3+MlXMUXHeRYu5ehNPi2In0p42e/TKPnpIbd
 AOjjbnI/EDpJcLSauV/zcQrgq8f1kuDls7vq0wbEB3UhrLKMNTxOS5yqv2+Z/hy4K2hk
 4LNUd1MB58EMxwRL9wVYIcAnyA2AeTwd+8Sh98WtQMrJ0jA24hYtIs+kyzBPbb1TuKJe
 1ERA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrC6uyfoB6x3kwiervTrq/OFcSz42rTgOOhJiVw+l1LX+ggzNFNSPmzvRQLDIX3OcoVz64DRJ7LdDs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywGu7Kzzm6fdzUXgRV5Xo/XtD+dEY7QXI6WXmt+bmSf44rjLkf
 uNe3tOG00/zITAp8UkV866yerA+XefYY8ios7WcDX6nsEwjuBQuyikSt
X-Gm-Gg: AR+sD10vgwI4Kt/NuVw/4uLivrpT5osB2tj7zfZuIbU8yFm4UNXIKffzodqIQzVA8My
 1387RliSMp1/y+ihItb/TPd59I6LiBpZtu9OdCXIB+aEP3nDwuMX+ugC5OxuVM/wvFAh/s+0Xx5
 ib0D4/NtuJM4xT9wneqkuvbvmpeT0rHsDGlfxYojkuLQe70qmCXxzpfikcNgy0fDdKnN9Xo2C1Q
 76HNrX4oiplNeQLXa1IJv6yfVATnf/9jW6kfN2SOstJoTbWcoB+mjUUufcXtYL1OeSlSbB73+CZ
 pHc/bw2klyLyAbmwXmo1cZumN5HUnPgo0jnYdac3wNAZXCyaSfgb7KhL0eICAXICSAKi20s0+4/
 2xY1USGhK2VqVykk0OaJrmBCJberAFqkzZhL46eAtOjpk3gptlbQpEJ3Irae2bW4y2CEqJu2WnE
 di1kCkapjInVocpRL3C86fW3Q1jvjhaD5AqKRq1DvgzIzTwTF+UEZXX6gdoAROczcyuWvELtNNj
 PpscF0uxn9eeWHVzIxWLSMelO/GnS6SKdpYGmwKnhoyoIGXl2NzDHrELqQ0SEaFk1CS4T/9r1pW
 sm//Cik81O4tCH364UwJ
X-Received: by 2002:a05:600c:6b4e:b0:496:bbcb:b0bb with SMTP id
 5b1f17b1804b1-4994e7e863amr318623325e9.18.1786200152966; 
 Sat, 08 Aug 2026 07:42:32 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995bdbe02esm97346925e9.1.2026.08.08.07.42.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Aug 2026 07:42:32 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: clps711x-fb: Remove unreachable
 unregister_framebuffer() call
Date: Sat,  8 Aug 2026 16:41:14 +0200
Message-Id: <20260808144114.77505-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

The unregister_framebuffer() call in clps711x_fb_probe() is unreachable.
register_framebuffer() failure jumps to the unwind label, while success
returns immediately.

Remove it.

Found with Clang's -Wunreachable-code.

Fixes: 36462ac193088 ("fbdev: clps711x-fb: Replace check_fb in favor of struct fb_info.lcd_dev")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/video/fbdev/clps711x-fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 7a7db7100499e..6789773b22fbe 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -329,8 +329,6 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 
 	return 0;
 
-	unregister_framebuffer(info);
-
 out_fb_dealloc_cmap:
 	regmap_update_bits(cfb->syscon, SYSCON_OFFSET, SYSCON1_LCDEN, 0);
 	fb_dealloc_cmap(&info->cmap);
-- 
2.53.0

