Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE4606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K63VnDVp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFF6B10E73E;
	Wed,  4 Nov 2026 00:19:34 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D6610E565
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 00:19:27 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so605155e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 16:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793751566; x=1794356366; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GGAHJoXoaHYDS7ZVcS4Ysy1Ws2W94TVdrbuzvKnZ5Q4=;
 b=K63VnDVp810EXT7COgO9KgBXiYvGEBRgDaaEGCKiuUu9EPBUAn92wA9WU+I+4D14lo
 G3y6IBF/j9yokcgSc2cpWwYc38LwS8UYqNJw3H7nZjTdUtF8pRph/C75jcsYWRFNk8nM
 VtAbsXrpctf6/fL+amXFbvYdE3ZmSYtHhF6pxbp+Lls0iuppIuzpiunMcwqDIiUbsd6v
 y22d5Mvkqi69u7Sp1s+vGQ104grg1vyK/LBTxedvi9uDtQVBNRLnKqEijFMpD81BoeKN
 0Yq7A5y4ryszWS2ht02syvprMrHAvWZ5PwvH1IU2SnDWlIIJVgglEVZP/lYRGBTv6t9j
 b9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793751566; x=1794356366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GGAHJoXoaHYDS7ZVcS4Ysy1Ws2W94TVdrbuzvKnZ5Q4=;
 b=yA0LF9qKADHQQADAYfgLM0Te9LnhFPEyMmJJfkrGz3Wr6yOlGTNavlWvGBXMsSa8R9
 DIy+dN9TfA2Qj7Pb5Sv43+uSYWWY5ut8WeraulwdZov9LwBHLgdLCOvpZnfLgJeBgd6E
 Pc/Wr3jJt8vQoG68TuSljTQolPnC2h9FgZMkJnxG+D5amEuuqQahnBndY2ExNtboeyrU
 09SpomZaU7Js/pudrt6qgWR2awag/jIQUkMd84PkhufaNr3DEkIPBQICWd0nxwCwJDsN
 bdz0invYaZinh7MhRiOmqmKclx6tjm5oIGvPOmcXjYsN5YfnZK0//A9gDEXUB+HPeyvK
 ZCJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMzQnVaePkJTKFukkfIgFkVnYMfuQiIdtMgDgAWVG+aQdUQkHcOYJ31GOXbVrZhDhRQ7l++E8x+CY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Y1GaTlWjAIPGkZRkCVo7+UHQMDu9qXVvrRsUjyV0Jkzl1Z4Fq
 wVnPUbwGSHsn5Fq1W4kwSm4zFt3eSXsrTpL/LmkipQjS5EdjlvmlRjQT
X-Gm-Gg: AYBFou1qBj0VAFbOdXwnf23yaa5/mCu7zhPkFPWXdtPIQL8dStCrU6fw9XRftV1SjNT
 m6rBm3UfLHUe/KIL4Rp84gnYosIU6wwIIJM2zpdZDAh95y1pHDfOCAlO8YGB9dUahKphmuZHXM/
 2PC0HW+eW7A8PKghhalyGK0NwlblB2JzInpb9CaerbnnYhgcSNf6txankcqofSjp+Udp/ad8sGH
 eUcgjr38rT2cTiv6sfsMf8jpNQQM0LDSi2cKJHZeTU+dmbzRyTCvMxDxtATsty27LMnaXwnMjrC
 Yce901LIaPHJdpoB+97qPfVvsEH80w3H8gITNGq6gNFFXOsVvkbyPyOJrnGCp9/KmTjcD15CjlG
 zOdyQ6q9Yvs2F/6IRux0XX7tzDpZi2kUlIhs1aWeItrJBCcyGcJDMKNw3Qz5jVuh2qqlJ945DFx
 vLvG0HmGUIvOM8BOmvGuPmjg+qGucTEsanJJatcdf4qLERX3QDtsdJCApT+QWABn71q35BxRvyF
 fZeQOECys9SrezYfGrAl08yx0bxCE2VOAnSt+ZHGzR8nu5VS/ya2zDKIwnKaglEy4K7P6fkeImL
 bAwVcPQyzkr17ID0EaADi3dZ+d0aajBHftJlUvo+ne+6qIgdSFQ+iBX5jtTj1569nl2ER7I42cq
 ggyHsTXb8HckCcpD43hlPAgTosTf8EAE=
X-Received: by 2002:a05:6000:4a13:b0:48b:9d2:1a6a with SMTP id
 ffacd0b85a97d-48e6e2b9ce9mr32274342f8f.1.1793751566267; 
 Tue, 03 Nov 2026 16:19:26 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 16:19:24 -0800 (PST)
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
Subject: [PATCH 4/5] io_uring/dma-buf: switch to tag file filtering
Date: Wed,  4 Nov 2026 00:19:00 +0000
Message-ID: <7165ab453cc680276b88f47f9ae89bc4967543cd.1793751001.git.asml.silence@gmail.com>
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

Instead of enforcing that a dma-buf-io ctx is used only with the
registered file, allow sharing using tags.

Fixes: 62e4bf5b25d44 ("io_uring/rsrc: add dmabuf backed registered buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/dma-buf.c | 3 +--
 io_uring/dma-buf.h | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
index 6f1d21c0f558..f25749f7da22 100644
--- a/io_uring/dma-buf.c
+++ b/io_uring/dma-buf.c
@@ -4,7 +4,6 @@ static inline void io_release_dmabuf(void *priv)
 {
 	struct io_buf_dma *bd = io_priv_to_dmabuf(priv);
 
-	fput(bd->target_file);
 	dma_buf_io_ctx_release(bd->ctx);
 	kfree(bd);
 }
@@ -52,13 +51,13 @@ int __io_register_dmabuf(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
-	bd->target_file = target_file;
 	imu->len = dmabuf->size;
 	imu->release = io_release_dmabuf;
 	imu->priv = bd;
 	imu->flags = IO_REGBUF_F_DMABUF;
 	imu->dir = IO_BUF_DEST | IO_BUF_SOURCE;
 	dma_buf_put(dmabuf);
+	fput(target_file);
 	return 0;
 err:
 	kfree(bd);
diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
index a97412ebbb3f..9bd7c8c64397 100644
--- a/io_uring/dma-buf.h
+++ b/io_uring/dma-buf.h
@@ -9,7 +9,6 @@
 
 struct io_buf_dma {
 	struct dma_buf_io_ctx		*ctx;
-	struct file			*target_file;
 };
 
 static inline struct io_buf_dma *io_priv_to_dmabuf(void *data)
@@ -63,11 +62,10 @@ static inline int io_import_dmabuf_map(struct io_kiocb *req,
 				struct io_mapped_ubuf *imu,
 				size_t len, size_t offset)
 {
-	struct io_buf_dma *bd = io_buf_to_dmabuf(imu);
-
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
-	if (req->file != bd->target_file)
+	if (unlikely(!dma_buf_io_file_compatible(io_buf_to_dmabuf(imu)->ctx,
+						 req->file)))
 		return -EBADF;
 	req->flags |= REQ_F_DMABUF;
 	iov_iter_dmabuf_map(iter, ddir, NULL, offset, len);
-- 
2.54.0

