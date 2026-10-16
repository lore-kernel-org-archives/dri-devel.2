Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16473CCA46B
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF7C1126C2;
	Fri, 16 Oct 2026 09:34:53 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE3810E29E
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:34:44 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso9502155e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792143283; x=1792748083; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WnamvmIuzRF0GlRelCYU72kM6iXFvvQVbcyQHF1dM/M=;
 b=R0kxIEttmsUVOGmbfhe65O/hfwsA6HkamYCYi5TKpsUGzeK4AK1XWw7hD+GHY3mzNv
 Cz4C5oiW2YSQJS1HqMMQEDbOtHlx3FJp1B73zIbDaJebtLg9TufkcIhikq57uLRoL1fP
 P1LjJNvXJiwnSA/oOYVyFDj50qURaHCQZqODrJvzh5neiCHJNGHXh5sZFVmdyxJ/dK3S
 XokdizrOuO6MNwveGWcLZZIMwzdVxOXfBdyf9nMY43iM2e3YVEahopFxZG/CC6kwerCH
 2FtCIRPqrfZuy6G2uhWU63S5YTsVf3qUJxBIxEpo0rCLfFj8HKuVwfVVumZk7fkwwXo/
 lmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792143283; x=1792748083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WnamvmIuzRF0GlRelCYU72kM6iXFvvQVbcyQHF1dM/M=;
 b=CipDDuSbzQ5B0khiwN+CTHnLDBLMmyF4cT11iBvaMshScxKRJzGknPanEujtfG2veN
 fp5RBu4rxtpbHYGVRV35d+cDB7frNxewkfmcNf6xiU2BQ2H6usiUmmUrlqpm4fRFEV6A
 bkJPyICsLARxbMIhm3H+icrWdxqYWEyZQqKZwOAlQw/+DkwZnjEGPwmJk+73wML+oAK0
 CPShQtGdtwhENBDQc3H6HTOFxoODlrUT/DfIAR9RByLyUyin2t0psDFOxD4WkmMj90FP
 pmOk0QRWMx0+O+OWz3FdNM9H2/kTUzMtrHYhvtqARXvqkteTtmiNWbvd6Z6ZAkbfF2f3
 HIDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBydwlBGoT1acwiVcveeM7OexgQinqXpAUUivKdRusYkNxKTxQtuDtbEQAxtCwXqqQaZi/eZQ+uWBao=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJwNGJPD2OXm9yNKO5o0MgwmNE3biri79xpz5xg5kfb/URBF5I6
 X/iAeWOMHuFs2MY7rEIezDncvJOhRM5ITV3Pp+jVrU+FtEj88qOhA5v2
X-Gm-Gg: AYBFou0szE5lcx2HAyPZ7JGwh73h3r+mBpPYocAvDP+EWUwfV6D4PEkI42j8Voe2bgx
 6sBDmittzctHK6H2EPIMff7Ln/Tr02O7wUwBsEoYE47RcK9CqYQQsmH7Efmo16liMmg4b5n+TGg
 RtGV7x+xVawF4Ni6MOPk3QPn3jqRH6xtLOcv4SUxoIhFv88cZ1h9ik1NnV6rA27OwHc4B5MGgm0
 dfAxqeSp0V54NW8vEmkTcJ/NywKQ0b/96wlQ3YwwkATy2bs3XKS6jRVKyffmmOVKue+fJRop/t1
 ZuL0nH9yAZVvWtkGT+8ODvIcFqwEzERlDvCQx4Z+GNOrDuGIPe6k6ekZeGfqWgKKFbsr5RgRoTj
 haXrn7bX+v5QeuMuEjigtmyK+K8hzIp4Eb8OEQIeh1Po2pUByXxx4zkniUM83MC7y5/h04PJbY6
 +JQTv1HrPwOBPPDYtImgHDQx4ZDA1CyFUYpV3eLL/RvtCxs2d6AHkXDJhAuIONROnxKnSRcJBac
 1pS4Z7N83A9V9yN+r+EbrgujcTToaFmNL4kWiGkOnnG3jUG+PZJ8CyApiEIr0KU6sHsrHL0xI24
 8Q==
X-Received: by 2002:a05:600c:840d:b0:4a1:6d2d:d8bb with SMTP id
 5b1f17b1804b1-4a1c6675030mr59959525e9.12.1792143282959; 
 Fri, 16 Oct 2026 02:34:42 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ad6252sm63570615e9.5.2026.10.16.02.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:34:42 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 1/2] dma-buf-io: fix typos in kernel docs
Date: Fri, 16 Oct 2026 10:34:36 +0100
Message-ID: <f328e279c3995cd36458ba2684c91d1bf24f057d.1792142927.git.asml.silence@gmail.com>
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

