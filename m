Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF04606A32D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BEFwdL7Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA8110E661;
	Wed,  4 Nov 2026 00:19:31 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0121010E55A
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 00:19:24 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so66352f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 16:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793751563; x=1794356363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XVYAkQiJxcRVRCy/m307F8zyGYSwmQhGdJmr4iFyUcg=;
 b=BEFwdL7ZgYipZa+Lso/79hP/RyI6SgIZEeA6QohfiK8s4HcxWXDtj3DbmQ/HSpibh4
 q+zQSFeLepxseVRk+xXYWPv0pjB48/wP2MfZAqacIip3CwAAtlPL288D67RrLr4TAG/A
 wyTZSGZU6Bm49oYWMA8MW5ePIXDFfDmayjgEdZl8Q6gLqfq0JUMAzNnUL3rdH6GBsgTB
 OmLYCR+EK3c2MIWaguCRQnb4KqNVmmEfnleKrwskR8tTsQO3w7W87KjPe3rtF0lUhAvd
 ysZFYG//1EtiYE4kI7MX+QLfqQrmf6TH+0TrGjnUDU84tg4iiQS1muGGc3sUTTiM6eqL
 ZqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793751563; x=1794356363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XVYAkQiJxcRVRCy/m307F8zyGYSwmQhGdJmr4iFyUcg=;
 b=uWIoKm0472UZl+zMC4wTk+Ialo0NnpSp2RPeMCysbVWaeMBnw+6bUTxDKV9T60+P8v
 5xcsj0AXZ+oX7uFlvRkGv5x0DvI9CyW2DBGR5e6h2cKciS83m74OwWd0oWoCgOOx9XxJ
 yaAd9k4KLvXMRcGtnvl97KDVUrRnmaobMWTF98JSxS9sNz/vZgul8YEaFnlrzKX94Ki9
 Bg1T9DXwcMafG6wcUyhAAwnrzizIo5X22uhlpv8nft7vkarcgbx1sR7823sA4IHN2B5G
 1ndWMLtsp/B2/5svQYd37vD9l2rJ32dSpMp/4WNSSZ43rTAJaBIW/JP8SidVGlDTSB6u
 fa6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx87qUhCFSi7yfk+kaE5O+7miDsH4tUtYdqzaKlYmvZHa2IMfPsqL5tzkS1Z6JULaXPXO7HjVJo7VA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+YMHE/2mkM9+lyrIG+v4OtQ4/4otpESgdWwpCblmOUw1rtxqCU
 h36vDl5mu5h5GW/y7QK6Ak86R3y75cy9SN+8ixt/mEUW2mj8n5xh4FcYsgMQKA==
X-Gm-Gg: AYBFou32/QTXS0NpRWe6aAhUlvmwtkjm1uhcrb+5YEueDRLb7zbqXSabelnJXh8mMJf
 lErwv0jorD9tk29QRPw0MCX/kQpTrdkwM97wZ7fhLRr1CBIg2TNCP1kcH2BZUFzmQX973a4E16Z
 e+p45+Mg44uipzqgo1DLwgoTbSXAKm/GB1CcRTqPeg5FJ238s1ksKX68G0zMHFnT3kXrXh8RQQt
 LcADbRBzOXEPTzqQdHlp5JaZzazT4f+3mSg+h1RQPW7qJRXVDE3jgUHIuEnlqfeIuLcJoWbM7vL
 XE3y4bUf49rqs8VHmm72cAa482EYj1nuHw4jGAMOlgf9sC4Tk5A6tGzGqMVvT3QJWQghRNfJ/97
 ndT47IDuVgoqWvzx5y+sEf1/gxadaab7tDwdqW9JPLFeP87veOpl/cyUFQKHHecGFQ0Nw1xzT+P
 As2+kj32e9JRB9T0u8WYVGzNMS8hkhxOoiivf8jqOQpuLcpe473ffr1iDh1ghE7fcJHwTCaKJK7
 81kyES2VI/ArCWj7lhiYOFIbpu0xIpUMS3tXmyleYS9N0IbFUJwQVnfoOS4a7NiLsPI69j1XY+/
 AgFj25z5LqrJbPLjd5QOuVMogcCw3YG8ItPt38XXIFTWH9IXKEGMMqhDIrORDjOEvXUuM266S2c
 Il/MzaMTiI5auR5lVYN8c0X2cB57wKJY=
X-Received: by 2002:a5d:59c4:0:b0:48e:3085:425f with SMTP id
 ffacd0b85a97d-48e6e2dbbdamr34641010f8f.2.1793751563267; 
 Tue, 03 Nov 2026 16:19:23 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 16:19:21 -0800 (PST)
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
Subject: [PATCH 3/5] io_uring: add data to dma-buf convertion helpers
Date: Wed,  4 Nov 2026 00:18:59 +0000
Message-ID: <e9e74cb1d6e46f62e29b0934fa9c1e7f2d2c1e3b.1793751001.git.asml.silence@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

struct io_buf_dma is stored as void * in registered buffers, and it's
casted in multiple places. It's inconvenient as void* casts can't be
type checked, so wrap all of them into helpers and keep casting
centralised. No functional changes.

Fixes: 62e4bf5b25d44 ("io_uring/rsrc: add dmabuf backed registered buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/dma-buf.c |  2 +-
 io_uring/dma-buf.h | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
index 132e3d0d7023..6f1d21c0f558 100644
--- a/io_uring/dma-buf.c
+++ b/io_uring/dma-buf.c
@@ -2,7 +2,7 @@
 
 static inline void io_release_dmabuf(void *priv)
 {
-	struct io_buf_dma *bd = priv;
+	struct io_buf_dma *bd = io_priv_to_dmabuf(priv);
 
 	fput(bd->target_file);
 	dma_buf_io_ctx_release(bd->ctx);
diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
index 534c06b6879f..a97412ebbb3f 100644
--- a/io_uring/dma-buf.h
+++ b/io_uring/dma-buf.h
@@ -12,6 +12,16 @@ struct io_buf_dma {
 	struct file			*target_file;
 };
 
+static inline struct io_buf_dma *io_priv_to_dmabuf(void *data)
+{
+	return data;
+}
+
+static inline struct io_buf_dma *io_buf_to_dmabuf(struct io_mapped_ubuf *imu)
+{
+	return io_priv_to_dmabuf(imu->priv);
+}
+
 int __io_register_dmabuf(struct io_ring_ctx *ctx,
 			struct io_uring_regbuf_desc *desc,
 			struct io_mapped_ubuf *imu);
@@ -39,7 +49,7 @@ static inline int io_attach_dmabuf_map(struct io_kiocb *req,
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
 
-	bd = req->buf_node->buf->priv;
+	bd = io_buf_to_dmabuf(req->buf_node->buf);
 	map = dma_buf_io_get_map(bd->ctx, nowait);
 	if (unlikely(IS_ERR(map)))
 		return PTR_ERR(map);
@@ -53,7 +63,7 @@ static inline int io_import_dmabuf_map(struct io_kiocb *req,
 				struct io_mapped_ubuf *imu,
 				size_t len, size_t offset)
 {
-	struct io_buf_dma *bd = imu->priv;
+	struct io_buf_dma *bd = io_buf_to_dmabuf(imu);
 
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
-- 
2.54.0

