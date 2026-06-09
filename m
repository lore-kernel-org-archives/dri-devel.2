Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D27CD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B5010E440;
	Tue,  9 Jun 2026 13:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCYIG9Go";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E71610E454
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 13:59:43 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b915ded5so48289645e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781013582; x=1781618382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lCCMGdSYRe1FraxjZBzJ24lH0mO4Ml3X3ulO1yg3ewI=;
 b=TCYIG9GoSqOQgsM5elpR5mDd8W33G9+nmgAQ0+rOzclo463GXzm81waBqNbw+5UMTN
 SZBu58NaunIDRJsVYdSOcmWwqIm3L3lJ08CGq+ZGVNU9vyyiq1/XO12v6tawGmw0dMUO
 bhrDZ0kAgrPv1GiTouDSgYMEqcisfb/rsFHvwdKMG4+TVwDlzqedY8Q/8dRvhftMYm3X
 s2Nd9b0zvQ5+eOyd3JM1n2s9ePKOtiTeSoOcKQlq2um5PoZiINpXDMPbftznNnOItv7I
 A3jzNiD/xHT6iESipn9U7a6eRANtql4s+wHzQ6KS7JFcKczN5QcFY+QnA0mk/SBhWkxQ
 MNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781013582; x=1781618382;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lCCMGdSYRe1FraxjZBzJ24lH0mO4Ml3X3ulO1yg3ewI=;
 b=PTVqf9k8Wir8eZ5QWRIk6Z8h1VGvP7H81OHkxxQBROagCw0myKmqW2cActJTkJpjyi
 gU/J9X9ffXIQuQxmUnk3v5JHM8czb8PndR0m7x48ERT4vFdBjry1MfupQb4T/sOP9jEK
 a8wMxq2RObktzPlg0A1dvt9WU8YAXKbLGpesHwbBCp69LSkuh7ggj6gh5GDsX+6iQx88
 q4S0Ro4uo0y3yVLrR7iLT4GeNjLpYJ/xDvlJZkPCxiw6nGnu7LgvJ4ytxkRlZxO8UR1S
 b6otTk3Uiv/eWJ4ju5p8zToIOCDAzA/Myq/dq2Qf3fb1rRLtcqLPNzSaiHJRoQ5rd6kA
 erDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CAIa9z86+PwVH4jywFd6MPO/4FiK1c61pPlQ/uU9Gn6Qf8c9KPxNT+J+C2ZHGAfprXoAXq3LuSIE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhU0cptca+uP4rTexkng0d7ObgqPS8fcjw6z/IZxc6cpuQWUGC
 2/ppzEZLHf5KIVG/jt2rG9lGoIheObrXhtwjco2IgHof1h2TCbmdL1Z/
X-Gm-Gg: Acq92OGSicpgQlJw2BdVGo1XXg1uBzy2sGhQzFFI+3ExHNCSE/yQB9kuUTPgBKBHNAa
 oRimc1hKUWk3wXmq67GGZIL3NBipyToFPlW202BmltQeMt3bq9Mc4eO9HsWJOFU4Rqe3SnJNka/
 UB+3aRAD3NP3YAE/WnyriZoC7Nu8JE0w4NW0z+05OKkfpglgEvEyJnmofDE8bjAiMukgaI7FHkI
 AtGqklgwPJ0YbNVRsu7bCe1z+LsJF5MKd1vOJabEqTPZESNLmA6EkwSiOi14HQBoGtupBCMIEbX
 +jsZH46lTk2W8CJO77qpvNnWqgxKlvNtqBmr2zVVJHmAkwGDGWt8YR0YZUSOXbCBGodTX6yW9Qn
 S01lgM548mm2ULW9BoTTPWPgqBJjkJtvdpv5bNkmUUugyherMaE9OIi/y/gCh2ioQ/aEtUMuASM
 GIwwWSHBlCas6KxcS26n+7WsDwXLzHBu6QOkAgkpQ+6Z5+gvI=
X-Received: by 2002:a05:600c:34c9:b0:490:688b:f10d with SMTP id
 5b1f17b1804b1-490c25b3549mr347976035e9.7.1781013581993; 
 Tue, 09 Jun 2026 06:59:41 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1548:4e00:defa:44a8:8592:150b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3d663csm537658365e9.11.2026.06.09.06.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:59:41 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	sumit.semwal@linaro.org
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH] dma-buf: enable sg_table wrapping on CONFIG_DEBUG
Date: Tue,  9 Jun 2026 15:59:39 +0200
Message-ID: <20260609135939.2606-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Importers notoriously abused the struct page pointers from the sg_table the
DMA-buf exporter provides. This has created numerous problems ranging from
crashes over random memory corruption to security issues.

To find such bad importers DMA-buf already has a functionality to wrap the
sg_table and set the page pointers to NULL enabled under CONFIG_DMABUF_DEBUG.

Change that to just CONFIG_DEBUG to catch even more importers doing something
nasty.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 71f37544a5c6..d5dfa82ed2dd 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -857,7 +857,7 @@ static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
 	struct dma_buf_sg_table_wrapper *to;
 	int i, ret;
 
-	if (!IS_ENABLED(CONFIG_DMABUF_DEBUG))
+	if (!IS_ENABLED(CONFIG_DEBUG))
 		return 0;
 
 	/*
@@ -896,7 +896,7 @@ static void dma_buf_unwrap_sg_table(struct sg_table **sg_table)
 {
 	struct dma_buf_sg_table_wrapper *copy;
 
-	if (!IS_ENABLED(CONFIG_DMABUF_DEBUG))
+	if (!IS_ENABLED(CONFIG_DEBUG))
 		return;
 
 	copy = container_of(*sg_table, typeof(*copy), wrapper);
-- 
2.43.0

