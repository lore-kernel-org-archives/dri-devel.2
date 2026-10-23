Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F63606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=czFeG6/9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4B0112CBF;
	Fri, 23 Oct 2026 18:17:15 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F9411274B
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:56:22 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so275479b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792742182; x=1793346982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d5nwKFsZvE5L1iVkiN9qlakuwuo5b+7GgbmdUMjeiGo=;
 b=czFeG6/9SXTs59Cih/UUH4r/dsO5qEh41/PsCxdRQkxCb/AtSBJpY2oFImj12oXfI6
 koxjqlDoIlBU3fU6cc3EP9LTgm1OWsg6SF5V1NYrxFI51aUj7P4oKV+oLob4Ftqueu/H
 KF2hyX1B3nZIbCQ58ti9JzQcvHHTsxT3scVQbvt/QLZ8oZjkbwjEG1NRbn6yosj/rul8
 13rRKHakJPcITEaQ5VnG9Xf8q8FurFxp1zkOdfbuzm7Z27Kb8Z3fOcnvXX3IKKtdGilv
 nAWsOSauA7tuFhp1Ax+6myuzAgDfkNZafwB3ffKigFfMB519BoKT7Ga3mfuIYla0syxg
 ugNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792742182; x=1793346982;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d5nwKFsZvE5L1iVkiN9qlakuwuo5b+7GgbmdUMjeiGo=;
 b=qY6fJWiZ+RhIO67v7QVj6+Zm2MPUwj72hAU6yhNlMW0ipU9FDuzF/6xWDMmFVhF07U
 82R1gbWIRJVGOUfTv0SAajcjv1uJUBb7Lv5ML7vKT7NygUeCZq+jJEclHyLiSkTbTdWc
 F8q/yu0A5vC9aFpql2CkueE7IXQX3JUGZNq1zSZm1QaasVWxbzUZIJUhjc/TULYlQV6i
 1wRTo7vp2VTopfQgfIUlVd7edB1Wt6pZOni+Xgdiq3tqsffxkxD8daaK6U3aOgj18eUr
 5gT1fW909bIm+jOSvCua9ptm0BPcpNPGtSKiwNp9Lm2q5nmuAZG/DLa9cToC1ov69B0C
 VMAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFcIfHtxjxLRCcjDnNlN5SslrAaLvrigUfaAhIZlur4tF/QpU2n119ovRO62fNomE5VnLvSvcSKSw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJSWvyCoaZ4NCX95HXLLzE6ugjRQuYeVKa69syYnTDcG69tyYmh
 ZFjvORSFLZuITLcT5/FsyNpzsUr1VmvqedJYSA83eTaYzuLFgfdlxJ63
X-Gm-Gg: AYBFou18czTXxzmXuq6r6HVkkw7/wywqGTh3kZJBnLUe6mscnoXNTE+Jsz52lm1Kjp0
 mWrJCTjKLcU28u5Zg2fqkbI7DTSVLeoo2C3Op7Rnn7OrO+LnzLUkJYu+jdv78T0+AHgjHYIWjMq
 h7ot4o/Uwe6pQHxM7TwlNDyljqYfLlgOgCcKkiCZfyExPtUr34PfRD94oZhGYZ3pP1wskaJfihE
 3nEH2/OfOqvH30BK97N6LFN4XDR8N5CPTN0bWkrJDVmdUj15zg4hp1ekHd4O17nh6lh70XszMv2
 a39vLbekNbqNn4GdyXUXDMcfr7UVJAtwerLkmBMeEYIeOjjt7s/AJVFhzLQ8JRStOsE7C6u9Yd6
 dG6U657/UAQjQd+pQ1Py7ONHnsfvsIqS2sLPBIYmzclBvptR2T+Np22SpHFazkPsentPnSlQ48R
 QiKi6QoD221wsm79T1iAerll5dQ+lFlcfTz/VOsgtgYnQ1TLTki5uHamWl4uWeoc3d2vyGnhGlg
 3rOpAV9kzHmcDGXeTUVFb7b7VWd2sHPVwC/arnjgasq9oQICaN/5KUak0twT91XxCa7Ad98keij
 4fAW7uwBQGhYwEBL3gbiV72yPEo=
X-Received: by 2002:a05:6a00:bd88:b0:89e:7bfa:f87b with SMTP id
 d2e1a72fcca58-8a2c472e08dmr1075229b3a.3.1792742182084; 
 Fri, 23 Oct 2026 00:56:22 -0700 (PDT)
Received: from spiderman.taila3fd8c.ts.net ([202.112.47.77])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a2c8ffc99bsm430968b3a.43.2026.10.23.00.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 00:56:21 -0700 (PDT)
From: Li Ximo <lixicaicai@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Helge Deller <deller@gmx.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Wang Haoran <haoranwangsec@gmail.com>, Li Ximo <lixicaicai@gmail.com>
Subject: [PATCH] video: fbdev: atmel_lcdfb: fix list_first_entry() on possibly
 empty modelist in probe
Date: Fri, 23 Oct 2026 15:56:11 +0800
Message-Id: <20261023075611.3559095-1-lixicaicai@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 18:17:02 +0000
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

From: Wang Haoran <haoranwangsec@gmail.com>

list_first_entry() does not return NULL on an empty list; it returns a
bogus pointer computed by container_of() from the list head.
atmel_lcdfb_probe() initializes info->modelist with INIT_LIST_HEAD()
and later takes its first entry with list_first_entry(), assuming
atmel_lcdfb_of_init() populated it. However, atmel_lcdfb_of_init()
drops the return value of fb_add_videomode() — unlike every other
fallible call in the same function — so if fb_add_videomode() fails
(its internal kmalloc can return -ENOMEM under memory pressure or
fault injection), the list stays empty while of_init() reports
success. The probe path then dereferences the bogus pointer in
fb_videomode_to_var(&info->var, &modelist->mode). Because the bogus
pointer lands inside the contiguous fb_info allocation, this may not
fault immediately; instead it silently reads adjacent memory as a
struct fb_videomode and programs garbage timing parameters into the
LCD controller. This was found by code audit; we do not have Atmel
hardware to reproduce it.

Fix this on two levels: check the return value of fb_add_videomode()
in atmel_lcdfb_of_init() so the failure is propagated (root cause),
and use list_first_entry_or_null() in atmel_lcdfb_probe() with a NULL
check that fails probe gracefully with -EINVAL (defense in depth),
consistent with the surrounding error handling which bails out to
stop_clk.

Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Reported-by: Li Ximo <lixicaicai@gmail.com>
Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 53f015699..6820a2400 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1007,7 +1007,9 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	if (ret < 0)
 		goto put_display_node;
 
-	fb_add_videomode(&fb_vm, &info->modelist);
+	ret = fb_add_videomode(&fb_vm, &info->modelist);
+	if (ret < 0)
+		goto put_display_node;
 
 put_display_node:
 	of_node_put(display_np);
@@ -1075,8 +1077,13 @@ static int atmel_lcdfb_probe(struct platform_device *pdev)
 	}
 	atmel_lcdfb_start_clock(sinfo);
 
-	modelist = list_first_entry(&info->modelist,
-			struct fb_modelist, list);
+	modelist = list_first_entry_or_null(&info->modelist,
+					    struct fb_modelist, list);
+	if (!modelist) {
+		dev_err(dev, "no video mode available\n");
+		ret = -EINVAL;
+		goto stop_clk;
+	}
 	fb_videomode_to_var(&info->var, &modelist->mode);
 
 	atmel_lcdfb_check_var(&info->var, info);
-- 
2.30.2

