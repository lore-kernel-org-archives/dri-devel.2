Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5747FCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B099C1126E8;
	Fri, 16 Oct 2026 09:34:55 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6A21126C2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:34:45 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso44815695e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792143284; x=1792748084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SpFhCIr9XErf0TQgN9GVHVagrPdev/HktwQkCtq1cFs=;
 b=Lw+3tGyf5Mufp/W+m2VrQ6esiJAjyAGNOFnFVyxYmh4Jze9UcdXizILu1LQ8dGweMy
 Pluft3wNMFqw9bdIs2GtAi5KkKrSZF4y1Joq4XjWnNnLG8HbusZ8DI/uSjv8cJuGbL2I
 qAX/I6NBSt2mke6g5jeJHuX1ga/ZJOy5wAYFaZMnMZxpWbPD/CC+wBoQ9D/ra7Vkpvs+
 TsUMz9Tp8RhOqiPgmuxjJBARsk0GcA6HDa4Pfbm9AORuqS+EXIuaUt4kdKeK6O59hoyv
 XUHTEDMveHcUhE1akJ7nK75T9HViBLIybTTpRj2qZO0xmrS1BwLvw+TbYJ/TwzjLNErN
 HeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792143284; x=1792748084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SpFhCIr9XErf0TQgN9GVHVagrPdev/HktwQkCtq1cFs=;
 b=vhAKP3ERuko+rAzXwiYtyIZ5vYsG9ZKWef3Nx0EZe7N7aPW/OSQeG0e/2b9mR2pMQN
 xQ0g6fSCgAgNxfVeyCRrQDTtr1WX7ag+4foeOwdEfgI2vxdfmL1XyVKpix/kASKY0OzM
 Dkl4C1EdRlx7GbOSXZyXJ+XEuC3Qj6WTX09yg+gilie7NXuROR1QbQRQ4VLL9O1cDk+x
 V1fXieGvMGTp3X4H5oeluvWcMHiQTxCH9BEIr6IEgM939EmnsbaiOEMwlwJ9DQ3tdnLO
 zYMhFue4TwVaOsRF/Vm+rppswdHGMQfqQU8lBrsV3P/J/6lU/YWcL5wgNtqjdKuyl6YF
 8dRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+ytt3NyhthF04Hk84NP61jMzUfgZ2pWkDoY2Kbdq6iJfrIqWbFRNHdgbKq912CjpwuY6QAPpiYIk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI/VtinVn6IW+2/WbcDfNl4a1B9t1LTxtonzVGPQC/WNRy/IeiV
 9QkaqO1PLnCZNUJPFcuk0DlvWKfU6bSfkd+YQGTV4VisCx0/T6XsN43l
X-Gm-Gg: AYBFou30GIzUxkcV9bUKlbpCu8cBH7l+j06jsr+x7Ht+Fo4JAWTy9c4xYGFaOIWfxBy
 6PKJg4YbIpGWwSdmni4dJdbbEfEAotUY1cPcpMSL9gsUIg4AHPtKILSlhft26g5YHW/pnu7HJ6V
 dKrwEXavKsLNQYSPV3mir6dup9e8MVeWfgqpZLuwEiCVBppnm6ZOSYsS+vmQwoKXkFEl+be+hgD
 g1a6s1etFiRJuMqRAt/f0IzYzoaRZ2yVXhIEAQI16oThEZCQH9QJMHjVHTPSeC6JRVNFKgEQovC
 B4OeZomTXd+sdpOebOrD5DP+jbDmKMGhkRGRWwIwk0H+sef4QB+pSa1qPs2Hk9xBtyqsQlSaEXO
 65xuseqpQ4lsgmJOa37wByH/4L5bYVjI4K1s99oaUcwVvySI19RxT5jAvNFCGhk47sMnG9uA4zO
 POZxIWz4f9DXPg9w0biF/QqC6zdI9YMHicJCLFXICleIHzEZiDFWgTriTZbQ1kj22rjOIlD2FgZ
 hpJq3FDABG20GuXIdipJuXMcmmyhabsO6cL6ZBTsAhFwcvumoVXTqiVcsumc+xkC9Zt5uwJrGof
X-Received: by 2002:a05:600c:1553:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4a18e443ea6mr421070445e9.4.1792143283846; 
 Fri, 16 Oct 2026 02:34:43 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ad6252sm63570615e9.5.2026.10.16.02.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:34:43 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 2/2] dma-buf-io: document dma_buf_io_init_map
Date: Fri, 16 Oct 2026 10:34:37 +0100
Message-ID: <79e1cc681326365d2105203b318d8a27ed7e90d7.1792142927.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1792142927.git.asml.silence@gmail.com>
References: <cover.1792142927.git.asml.silence@gmail.com>
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

Add a kerneldoc for dma_buf_io_init_map().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/dma-buf/dma-buf-io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
index e432194a5dfc..f724936e223b 100644
--- a/drivers/dma-buf/dma-buf-io.c
+++ b/drivers/dma-buf/dma-buf-io.c
@@ -43,6 +43,18 @@ static void dma_buf_io_kill_map(struct dma_buf_io_ctx *ctx)
 	dma_buf_io_map_release(map);
 }
 
+/**
+ * dma_buf_io_init_map - Initialise the map.
+ * @ctx:	[in]	dma-buf I/O context the map is created for
+ * @map:	[in]	dma-buf I/O map
+ * @sgt:	[in]	the backing scatter-gather table
+ *
+ * Importer's helper that initialises @map for the provided I/O context
+ * and scatter-gather table. The importer should call it once for each map
+ * on creation.
+ *
+ * Returns a map on success, or a negative errno code otherwise.
+ */
 int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
 			struct sg_table *sgt)
 {
-- 
2.54.0

