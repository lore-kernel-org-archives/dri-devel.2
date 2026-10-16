Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDFECCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 485EF10E26E;
	Fri, 16 Oct 2026 09:58:54 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CBE1126F7
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:58:46 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so1281616f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792144725; x=1792749525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WnamvmIuzRF0GlRelCYU72kM6iXFvvQVbcyQHF1dM/M=;
 b=gr1vHQaqBegTHQm/PtCb2yEXr2Hwqq8WIgVJ2QCvHGYa2HP+dT1DAD+cdAT8VR2wVC
 fGAHyTdidmHA0s0c6GIBzI3S5whfUYOwl6uQW9hW9PEB02khy26dlwmImVbyl4b4tL48
 wo871OGBalBM9Jca/HQtLObaDMNXKNsSTcwXZXFl5W/QQYCnVQPZAukVsiml0SD90Zuu
 zkuvhHP3qDsWBtggvpV0jAy1X7LfurKfpprpBVwTwjouMfFbQvYX4ev8SdnTrAMo8gSH
 BqWI+0bO/Yw6Qs4mV9u4u1P6CxdbNTw5VvFi7lYNJxRQ6jz9G9ysZJQACc8UR1zQJlj/
 jM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792144725; x=1792749525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WnamvmIuzRF0GlRelCYU72kM6iXFvvQVbcyQHF1dM/M=;
 b=NbdMzFL0ikfeBaSNIxLB2Jh1OcwldUQfZ3pfmIOHC4ISX1LodPWVIMnemDh5k+Rt/q
 0mslmgBMq1X55+49+jgGPT8m+iF007uizj0AQCqYHhfPg6CTj7eB4T7bQzh0yKjjNqkZ
 fcvq6RDUiqp1r41h/EsalNBgcVSwxFAoEwFspkMgPho87tZCWRdj/5Su/5KPbPpAbxYg
 YVWxPc+vhvdzXae74N9ddRcspC7mSBeUID8wMTGDGqiLaET+cFOLHLKheK0jdUSK3wuI
 MlT2SjrBwUgiNtxKqWYMnysvbs1jqa6AL4IuUL2tW5RwIH9ZqCkovs7IFzFYQUmtNXV5
 dNtw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhU5ULsLkQRk9sTlv4VDFW3Squnsfbik/fpIs3HUvebT3CZnIwYdQza6cxGcZpvdMmigflY47ZTww=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ4AOKcvA8A4RGyqPHdvOHLBSzqotb8oR3Eq2+aNybLjWyiqcOm
 FBKjhjFUzo+GZtXQSqAjBE1256Go/t7MqhFBW54BDJDcohIB6OZocchu
X-Gm-Gg: AYBFou1PPyPWJXGpOAYdko9egv0KQBZvqCjXpkV5S1M/+1PnHS9zSB31G1gQ3igObTa
 pTmUWjUXprEtnXL2Hyah6LPiWeHltzCbgS3gVhgcsNiVT3WzMNRk47AIWzABU92HTxF91dQ8l8z
 Xt5dPvP4Y9Z6lhfvOiiXiMSUiG5RqqvubpKOmiog3Rw6Xtp04Ua6PSxl6g0tJzGxgnd3haJulHt
 VrPhLKceyvDU/EzX5OP7JQOHAl4dmHf98uuDKk9zTFtc0DpDyK2gGFlmH3+05xhE3lIxIGqSpKM
 OR6okCb+mrC64X9QEW5m9qUT9LxMIbUsHcEMowNfRFgZ+VygAbIRehZwwF7o9w7sZX/J3l9u6SA
 TTR5VhWN2j7WD3wzkQnr8KY6MbhTfHt/pHZK1G6+sjDTZEJ05OaXE2YiXKBf9rZy/GZ+8wPqwCu
 e76Kdww98g7Z6WzCNI/R3eVRRH2dz/dSo/ilStyLmVfgoT6A76AIrbAIqmQFlrSFRNnZ5vZ/j20
 QKT+Uut1nRsbRl3NHTCeJbmCzJ5bIKsbeNIXZ3zgC6EfV+tOqSGASykF6kPu21jGXevTQMEv6TV
X-Received: by 2002:a05:6000:3108:b0:486:f856:1975 with SMTP id
 ffacd0b85a97d-48dbaae5c02mr41334703f8f.22.1792144724678; 
 Fri, 16 Oct 2026 02:58:44 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd5033a2sm4133033f8f.45.2026.10.16.02.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:58:43 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v2 1/2] dma-buf-io: fix typos in kernel docs
Date: Fri, 16 Oct 2026 10:58:30 +0100
Message-ID: <f328e279c3995cd36458ba2684c91d1bf24f057d.1792144609.git.asml.silence@gmail.com>
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

Fix some typos and inconsistencies in dma-buf-io kernel docs.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/dma-buf/dma-buf-io.c | 20 ++++++++++----------
 include/linux/dma-buf-io.h   |  7 ++++---
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
index 21296bd3dde1..e432194a5dfc 100644
--- a/drivers/dma-buf/dma-buf-io.c
+++ b/drivers/dma-buf/dma-buf-io.c
@@ -106,7 +106,7 @@ static struct dma_buf_io_map *__dma_buf_io_create_map(struct dma_buf_io_ctx *ctx
  * @ctx:	[in]	dma-buf I/O context
  *
  * A slow path part of dma_buf_io_get_map() and shouldn't be used directly.
- * Behaves in the same way but allowed to block.
+ * Behaves in the same way but is allowed to block.
  *
  * Returns a map on success, or ERR_PTR encoded errno otherwise.
  */
@@ -133,16 +133,16 @@ static void dma_buf_io_ctx_shutdown(struct dma_buf_io_ctx *ctx)
 }
 
 /*
- * dma_buf_io_ctx_create - create a new dma-buf I/O context for the given file.
+ * dma_buf_io_ctx_create - Create a new dma-buf I/O context for the given file.
  * @file: 	[in]	file for which the context is created
  * @dmabuf:	[in]	buffer to create a context from
  * @dir:	[in]	direction of DMA transfers
- * @out_ctx	[out]	resulting ctx
+ * @out_ctx:	[out]	resulting ctx
  *
  * Create a new I/O context from the given DMA buffer for the given file.
  * It only works with files implementing ->init_dma_buf_io_ctx and fails
  * with -EOPNOTSUPP otherwise. Once created, the user can create a map
- * and use it to issue I/O like read / write requests to @file.
+ * and use it to issue I/O, such as read/write requests, to @file.
  */
 int dma_buf_io_ctx_create(struct file *file,
 			   struct dma_buf *dmabuf,
@@ -180,7 +180,7 @@ int dma_buf_io_ctx_create(struct file *file,
 }
 
 /**
- * dma_buf_io_ctx_release - destroy the I/O context
+ * dma_buf_io_ctx_release - Destroy the I/O context
  * @ctx:	[in]	dma-buf I/O context
  *
  * Destroy the context. It makes sure all maps are waited on and destroyed,
@@ -201,11 +201,11 @@ void dma_buf_io_ctx_release(struct dma_buf_io_ctx *ctx)
 }
 
 /**
- * dma_buf_io_invalidate_mappings - invalidate the current map
+ * dma_buf_io_invalidate_mappings - Invalidate the current map
  * @ctx: 	[in]	dma-buf I/O context
  *
  * Importer's helper for invalidating the current map. Waits for all I/O
- * using the map to complete and destroyes the map. Called with the
+ * using the map to complete and destroys the map. Called with the
  * dma-buf reservation lock held.
  */
 void dma_buf_io_invalidate_mappings(struct dma_buf_io_ctx *ctx)
@@ -215,11 +215,11 @@ void dma_buf_io_invalidate_mappings(struct dma_buf_io_ctx *ctx)
 EXPORT_SYMBOL_NS_GPL(dma_buf_io_invalidate_mappings, "DMA_BUF");
 
 /**
- * dma_buf_io_detach - detach the @ctx from the importer.
+ * dma_buf_io_detach - Detach the @ctx from the importer.
  * @ctx:	[in]	dma-buf I/O context
  *
- * Importer's helper for removing the I/O ctx. It kills all maps and
- * prevents creation of new ones. Upon return it's safe for the importer
+ * Importer's helper for removing the I/O context. It kills all maps and
+ * prevents creation of new ones. Upon return, it's safe for the importer
  * to release all its resources such as dma-buf attachments.
  */
 void dma_buf_io_detach(struct dma_buf_io_ctx *ctx)
diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
index b9bbeca1744f..d9f27650a851 100644
--- a/include/linux/dma-buf-io.h
+++ b/include/linux/dma-buf-io.h
@@ -60,6 +60,7 @@ void dma_buf_io_ctx_release(struct dma_buf_io_ctx *ctx);
 
 struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx);
 
+/* Internal helper, see dma_buf_io_get_map() */
 static inline struct dma_buf_io_map *
 __dma_buf_io_get_map(struct dma_buf_io_ctx *ctx)
 {
@@ -79,10 +80,10 @@ __dma_buf_io_get_map(struct dma_buf_io_ctx *ctx)
  * @ctx:	[in]	dma-buf I/O context
  * @nowait:	[in]	specifies whether it's allowed to block
  *
- * Create a new or acquire an existing map. When succeeds, it returns
+ * Create a new or acquire an existing map. On success, it returns
  * a referenced map, which should eventually be put down with
  * dma_buf_io_map_drop(). If @nowait is set and the function would block,
- * it return -EAGAIN, and the caller is expected to retry from a context
+ * it returns -EAGAIN, and the caller is expected to retry from a context
  * where blocking is allowed.
  *
  * Returns a map on success, or ERR_PTR encoded errno otherwise.
@@ -105,7 +106,7 @@ dma_buf_io_get_map(struct dma_buf_io_ctx *ctx, bool nowait)
  * dma_buf_io_map_drop - Drop the map.
  * @map:	[in]	dma-buf I/O map
  *
- * Put down a reference for the @map acquired via dma_buf_io_get_map().
+ * Put down a reference to the @map acquired via dma_buf_io_get_map().
  * Should be called as soon as I/O is completed.
  */
 static inline void dma_buf_io_map_drop(struct dma_buf_io_map *map)
-- 
2.54.0

