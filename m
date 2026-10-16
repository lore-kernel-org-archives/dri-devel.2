Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC159CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB3111272F;
	Fri, 16 Oct 2026 09:58:58 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E8311271C
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:58:47 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-486e8faff03so2716490f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792144726; x=1792749526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LD2knUg3bwI53NAkb4XKjLA3TEnvxqdDcA9IYxZn/Mo=;
 b=IYzpxsxRX+5wI7UVxejvU09tMECqubnqKaP9f2+9O4Lm/MCwGCByZ8TjEsH6bkNWO8
 QQBCdIsAc4829ri9n/Cn2TjGItNCdSDkSd1vR0c3UW8FcIssSQUDMHlNFapBGogWjjF/
 dVTR/VhORZcNUhH93bu6F9to2vpZhN90UQ7BZsSsquXoDiZ+GbmQAW5IOhrWOl2w5Myl
 4QtypK+ZwRuEb9EmAwuP3T1VQdi4GBJFbZvYwrwZ3ePQewf/AU41U/E6PkZBOWeM+xsw
 RM/i27jKaZ2AQnK59EMRA9QzxY2jgsbvSa1EdS6TX6LjwzjHiBCsH825pleaSongbPlB
 MF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792144726; x=1792749526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LD2knUg3bwI53NAkb4XKjLA3TEnvxqdDcA9IYxZn/Mo=;
 b=HzwR4uqd3TazXAb9lTYwngyFTsk/2horP7Erb3NCcySrwHDzKFsAPRZVIJ36KwnJ1w
 k/9bOuRzbQTwHI+hbyt7VH302D2SOiVECGsa7zqf7A6WaUZHnoxYf25RLpVedtZvndo/
 7SS7fmHsYdiCZWhsZEVti/48V1BrGSXe+aWLuxYu9HwihTE/jDByFubkioz12ZFZvbno
 nvcUfaiXeo0QG5ZVBZckokGvX0DEIQ1rn3qxKNMt5+tAl/tG+TW9Wq5vpB9CXqhjrBxk
 U3/pB5wtYPRxCz9uOGFkNtsCh1Bx1SeTpDrXaKvQBbEP53PGh0XcuTYyl3RxpvshtYiL
 BHTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYsUZsVP0cc1jV3RkfX03uHn2lQecSbNxYQ2cIZQQwolmwzdGIv+oIl5NOfu6W1JfEMitadIc0Hn8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ2+LulvVI8c4SzH0G1b9IzkxYTgf3XX2qLQ/q+iBDlHIK4l1Sy
 zZe566idWkLe7gNlapDDYLGAPswuUgliXAWAxNHNbmo86qwJZtuMNL9g
X-Gm-Gg: AYBFou353+ro/qmvxM8ian+RaZzvfsCViWzmacuYtQZO5FlKTWyz3w1CuB/lKIIcRY3
 J8XT1AR1+mEXYJtenys/vgCrf9noAlKgN7DLd0moFyPinEGu7+Z+ZbInA7DZCJXuHUP9hnKoe3e
 VL1BYIhvUEfWHW/P0u9MqELQ1MEzzDJmLJ0Wau/c1jO23GMLd05dI9M+e62JM69LDpqbOW6hlIg
 i03WuC3lUOcBG/NM47gwE5X1X+8Gh+Ly1xy/TP8UVLPXJG4knmIayNMsyB3xslQ3vBVoXUdWuRl
 4JxlL4tKpXHzR1lRTFPdypiRklhZK7nMLS1FIQ8HemZeeXkTngJLGmf2b5NllK85qzpCWs3yYhQ
 9mjB9FTSk2Cc81gxVwQnhM0l+i1HeRvUZlgWNGoaOOX0VPkQYgl+7GomT5ANENvCrT0dxmETyVA
 myb2/CY6EcNuW/e6uoMSplsjDtfmmJSlBNJVphzfGgUjN7vHmMUXDlruu0hlGCXXWrqShjQEtuP
 +WglGV5nr+iUJL68k3oqmK+Ove/uh0n/cw0Y0Y2qW4DfUkf7Jj4bOeJ3Hlc2MloVmJQRRM8fKS6
X-Received: by 2002:a05:6000:29c3:b0:48d:c15c:94a5 with SMTP id
 ffacd0b85a97d-48dc15c964amr29582852f8f.14.1792144726031; 
 Fri, 16 Oct 2026 02:58:46 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd5033a2sm4133033f8f.45.2026.10.16.02.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:58:45 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v2 2/2] dma-buf-io: document dma_buf_io_init_map
Date: Fri, 16 Oct 2026 10:58:31 +0100
Message-ID: <a9fdfbe6e447ac583f4d3a3f981b203141a624c4.1792144609.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1792144609.git.asml.silence@gmail.com>
References: <cover.1792144609.git.asml.silence@gmail.com>
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
index e432194a5dfc..8440151de860 100644
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
+ * Return: 0 on success, or a negative errno code otherwise.
+ */
 int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
 			struct sg_table *sgt)
 {
-- 
2.54.0

