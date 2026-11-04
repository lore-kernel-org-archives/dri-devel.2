Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88987606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ciMKGcsv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B9F10E55A;
	Wed,  4 Nov 2026 00:19:37 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C79110E55A
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 00:19:31 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso49149f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 16:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793751569; x=1794356369; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dhpcS3Pos6bUyhlWGcG9OokPKtscuwoJw0ESCtzmpvM=;
 b=ciMKGcsvcQgFP/OPVYKL8LA71dZH1tSukuLs56zGFO+4Z82X13cr9Zqk+HmDgMDHlX
 vVhkrA8WNj7t2Gt/oFvfr5co4dU8gOi/uuderPXEIbj3ElBWPeSbq7GwPop4+djFEPBU
 PURsLWAgg+eDjlgjKtwKAwz3t1zFWKxQrwPDQy/WWv+LAkc1XUsfbrTNU55aSSM4HZW6
 7/sJUqlIZkh2wLzs/sTV6wn+t2XABQ6Q1wZNT6gtJ8CjUBx37RWRMa//VNw65mqLzda3
 EWSjlJhH84qk162PzOlnOHKVceSxVrlYV4GpRjheRKIeUd5Tr6cGc0nTz92Aq+JeDbQa
 Cm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793751569; x=1794356369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dhpcS3Pos6bUyhlWGcG9OokPKtscuwoJw0ESCtzmpvM=;
 b=eXanwi4YfdyZavUIDg+Y50lTKhlbnyX8BVWAur1e2SZkh+Lg2XjoMy1bj5Rsdg9L8q
 N+bPtshirSN1P53fHnkBj1NuXMNAK4Escfty+17k459Aog6Q3weslwHjOGFf2nX2Vmj7
 9bxz0FXtXzdsuBTRUxZ3XbV6fYnC/uXzePt8/nkufpbSBtdAz5fF+jhaVwttnIXccKeC
 eS0889U8sJX4QJEHsWhwEoZ8p8/THV+JajBb5cxDm0Hy4M4cOyaf/BTLZ9vzEFn1f3El
 LjzElwEQE4DHOobfnwJAti+ov7+HHJwlOofmkfRyDuUf+Job8pRkVfhZ4G9XDNJB+N6a
 z/sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGP8U2nIYXiDSGYTcX7uQp361iliLO8gH4LTJKkAJWkBmyrzWQkT9nieIKVuyN4aJZnug6ziqkGGY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8P1jZtWqDrJ3J+4vjDMR1Y2Dvw2NsNRhBM6BC4oSMU3TjajJtV
 tDKm4m/o1CjoYQxns1xK9P8Ur06gxFw3OWtCBTFp30Hucbjt8S54YyRe
X-Gm-Gg: AYBFou2G3Sj7FCaj0X8nSylpiVa3zLQwHPH8zLe3sT8X/gpw6sOmQ/vSI+5rrtl6NJK
 uTG4y/oE8iGbQmZBP/YhDKDInaHP4KpaGhsUu3hH5A19pbRq2WOAwaqgVdJ5/p5OE0jVP9sucOf
 2gu9lVNtqENY7fn8mmcupl9eKooumvxISp42CzcTWcC27T56dk63VVUS7W0l/oGuVinRKCYbw2v
 yv2bgUMaLz7eZaH9ZBNIs6Oz8Iy9hwcqCwDMNLgS9edh3cMkJWq2mLrMtUVNGtOt5VQjWhTSQiI
 A2UuN+G/nw9sSV3K8kFoX2mGsrUcvnmbTZ67CvbTMmbCNyjGjwMxyUnSRyd0sMjuNN0SdCBqDX/
 te5M4EttcxwdJVl2lU/3RHyC/HXmeHiBlg9abxg9FFj4k/MTWM8zKhSIIELerW70cmjbrD6QYrA
 G1Jh+zQIxszfAy+JgNxm515kulsp1sBBoldgJm2ks7osHG72pJ24rn6l2QsLDj/Ewyq2jooqU+Z
 vnABd9XcdABGh/wZmsLDvQ0UizglpxZg1IDxqlBsrPIUmyFsl/wyYxQemvY54UNI6oqruYvT2Ro
 Ib6umnEdPdWDHAGK0FTWXdejmc9fWiAUKPhwekHYeSVdD0BsWnKRhXCLmbBAghMDwGX62JVQ26D
 ARXF/RrZS3kO0VrtCFzfiyPH4Ql4ZTu2V
X-Received: by 2002:a05:6000:616:b0:48f:bdb6:ca0 with SMTP id
 ffacd0b85a97d-48fbdb60d3dmr3036265f8f.23.1793751569507; 
 Tue, 03 Nov 2026 16:19:29 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 16:19:27 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 5/5] io_uring/dma-buf: get rid of struct io_buf_dma
Date: Wed,  4 Nov 2026 00:19:01 +0000
Message-ID: <883cf9fcd8e46569ec237e9e36baf6e2f26db8de.1793751001.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793751001.git.asml.silence@gmail.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now struct io_buf_dma only stores dma_buf_io_ctx, and we can use the
latter directly.

Fixes: 62e4bf5b25d44 ("io_uring/rsrc: add dmabuf backed registered buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/dma-buf.c | 16 ++++------------
 io_uring/dma-buf.h | 16 ++++++----------
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
index f25749f7da22..a1fc34c0c044 100644
--- a/io_uring/dma-buf.c
+++ b/io_uring/dma-buf.c
@@ -2,17 +2,14 @@
 
 static inline void io_release_dmabuf(void *priv)
 {
-	struct io_buf_dma *bd = io_priv_to_dmabuf(priv);
-
-	dma_buf_io_ctx_release(bd->ctx);
-	kfree(bd);
+	dma_buf_io_ctx_release(io_priv_to_dmabuf(priv));
 }
 
 int __io_register_dmabuf(struct io_ring_ctx *ctx,
 			struct io_uring_regbuf_desc *desc,
 			struct io_mapped_ubuf *imu)
 {
-	struct io_buf_dma *bd = NULL;
+	struct dma_buf_io_ctx *dmabuf_ctx;
 	struct file *target_file = NULL;
 	struct dma_buf *dmabuf = NULL;
 	int ret;
@@ -27,10 +24,6 @@ int __io_register_dmabuf(struct io_ring_ctx *ctx,
 	if (desc->uaddr || desc->size)
 		return -EINVAL;
 
-	bd = kzalloc(sizeof(*bd), GFP_KERNEL);
-	if (!bd)
-		return -ENOMEM;
-
 	target_file = fget(desc->target_fd);
 	if (!target_file) {
 		ret = -EBADF;
@@ -47,20 +40,19 @@ int __io_register_dmabuf(struct io_ring_ctx *ctx,
 		goto err;
 
 	ret = dma_buf_io_ctx_create(target_file, dmabuf, DMA_BIDIRECTIONAL,
-				    &bd->ctx);
+				    &dmabuf_ctx);
 	if (ret)
 		goto err;
 
 	imu->len = dmabuf->size;
 	imu->release = io_release_dmabuf;
-	imu->priv = bd;
+	imu->priv = dmabuf_ctx;
 	imu->flags = IO_REGBUF_F_DMABUF;
 	imu->dir = IO_BUF_DEST | IO_BUF_SOURCE;
 	dma_buf_put(dmabuf);
 	fput(target_file);
 	return 0;
 err:
-	kfree(bd);
 	if (target_file)
 		fput(target_file);
 	if (dmabuf)
diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
index 9bd7c8c64397..c622347fbd76 100644
--- a/io_uring/dma-buf.h
+++ b/io_uring/dma-buf.h
@@ -7,16 +7,12 @@
 
 #include "rsrc.h"
 
-struct io_buf_dma {
-	struct dma_buf_io_ctx		*ctx;
-};
-
-static inline struct io_buf_dma *io_priv_to_dmabuf(void *data)
+static inline struct dma_buf_io_ctx *io_priv_to_dmabuf(void *data)
 {
 	return data;
 }
 
-static inline struct io_buf_dma *io_buf_to_dmabuf(struct io_mapped_ubuf *imu)
+static inline struct dma_buf_io_ctx *io_buf_to_dmabuf(struct io_mapped_ubuf *imu)
 {
 	return io_priv_to_dmabuf(imu->priv);
 }
@@ -40,16 +36,16 @@ static inline int io_attach_dmabuf_map(struct io_kiocb *req,
 					unsigned issue_flags)
 {
 	bool nowait = issue_flags & IO_URING_F_NONBLOCK;
+	struct io_mapped_ubuf *imu;
 	struct dma_buf_io_map *map;
-	struct io_buf_dma *bd;
 
 	if (!(req->flags & REQ_F_DMABUF))
 		return 0;
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
 
-	bd = io_buf_to_dmabuf(req->buf_node->buf);
-	map = dma_buf_io_get_map(bd->ctx, nowait);
+	imu = req->buf_node->buf;
+	map = dma_buf_io_get_map(io_buf_to_dmabuf(imu), nowait);
 	if (unlikely(IS_ERR(map)))
 		return PTR_ERR(map);
 	req->dmabuf_map = map;
@@ -64,7 +60,7 @@ static inline int io_import_dmabuf_map(struct io_kiocb *req,
 {
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
-	if (unlikely(!dma_buf_io_file_compatible(io_buf_to_dmabuf(imu)->ctx,
+	if (unlikely(!dma_buf_io_file_compatible(io_buf_to_dmabuf(imu),
 						 req->file)))
 		return -EBADF;
 	req->flags |= REQ_F_DMABUF;
-- 
2.54.0

