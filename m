Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE5606A33E
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9gIf4z9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DD810E4EA;
	Wed,  4 Nov 2026 00:19:23 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0227310E4EA
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 00:19:16 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so66318f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 16:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793751555; x=1794356355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hxI6oNEf2EvFWjGeDFQYrrcpmAnzoeBTieQsEmlXNt0=;
 b=k9gIf4z97CrbLyZzjk7WkReJxb8yeHBBg22Ibg9mpTqxw5qw9ja2zFtBDnxd53mrtZ
 kmgESteS9iFHL/W3oW8pm66lwyBye8UY4Hs3pH/ftPwp9EuUjTYB63LC0QwovFtHtTVP
 9r9DMeV3naBKpKzmZaL6yf6n1CzoeamcJSacUnzrLgvVKsvpFyF0K1JYs6+dZ8Q1FM7f
 icH/zNIWYqzGICd0CgT7qWEdFX3e7W5xAlfy6eyiN84f/ON1NWpi1jQdBrPUkaV3yYmD
 q4T/otyAdETmXhCFNAiGoWR5xwQ6MIilAq+1iiYZv0SBmzLC37+gYMV3WkdpHcH/JLeG
 kfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793751555; x=1794356355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hxI6oNEf2EvFWjGeDFQYrrcpmAnzoeBTieQsEmlXNt0=;
 b=tCkdCX+gd0SvOEK8FMEefUV2cAnXnXlKlNUNmoXN4VXZxAKtqcoQh4I3d1RQL844iN
 P02UAvdjjoVjWF+Dbx55X73e3ljTTrVJBr+N8JUvXXSMcrnw24s47GVrDK7s9xyQafW+
 fcEwPVEP66HsQptgZc7itha8P//VA6IjmhIJH8k/fleCtFU+wzdThy7F8hxxWuVWbO1A
 OKDulgxdsxmOTn7+w3LlpuSiJzk0FxFiuCPYrWAb7W+XLWCJTLodv1S6sOhtHx02dLy+
 tE4W8+xbUxUg0VX5Cga72MopbdJyPozJE+iyeKqWkWM8KNcSPFv+ljChMaS2aN5Cravr
 qqOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCsxG7288HQxtSceLIs/eBTd6gKwc1GZPdGw0qRQX6ETI6JiXKldeqBOrIlxluHi1bo0+dlbetcXM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z85JwLlgvxRRd67lne0C8Co4DgRb+jOe90q+PHDpxBCy7l91qjR
 pCoGSPniJrVeaWfEXE5pfuKWvAJoyxZ1mHAuNwLvoU9GpJM1+2GTCB9y
X-Gm-Gg: AYBFou3/UBwU32v7qZwSrRBpjO27r49cdu2vujqaJiu7SJuvyjxox32TY2JbsQd03H0
 79Ww2KOjedVnurIXM7JB5ItP9ZTQCyN/ndpivs46BxbhuIj6IK5IhIBmP71xneVhbgfpuMQHJ8X
 oMvnp3tXIk9lI8yvu0LUDT0v1HmGdoYm2zQLhJFAlJhk2FF7VM8Kzk0iED2ujgR7B8X8pdbRSki
 sK3dtkz7K/sAA4sapMN4RrmL52bqda1zrlc5P7EldCpahCISCFNYrFxXCo8f2WNSFccruYeDNnC
 x2+/ce5qIg2PL5Occ6ipcXfTOmMcOYFmQ57b+nVUqKI8AaH7TnA0KrRF8xjZLRqsK5HP/leM2Pj
 tWfQWDMAKEJWT8c8jHw5BBL3xjh4FITHKdQQ1ooUWXvHfTBhTAlPB5UyftpPvjSjzXbiIsXMN+j
 opRHLDHe3bwC/x9phfWpjqUA7kPTthLQ8kqpltHfQmKkEjSlmk9VGDwTwGY446yxnIPEHOOkvGR
 LKXTxocn1lXz/aNYRfbWgut1Rnq+TAMt92HyN4+mKutFuzyBXzk1tUJVb/umAELfCoApweVu8m/
 EcyczbEo/q+xsZ5bGynYosnTFU2SMQCuIIwGO0PqHF5WwCfu1F4HZgAV1UnCIbbzutSZ+rPWttq
 LU/RzTFqWy10GYtcKxd5NCyPDU7C67cA=
X-Received: by 2002:a05:6000:4027:b0:48d:fbdd:4132 with SMTP id
 ffacd0b85a97d-48e6e4f540bmr31194343f8f.18.1793751555202; 
 Tue, 03 Nov 2026 16:19:15 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 16:19:13 -0800 (PST)
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
Subject: [PATCH 1/5] dma-buf-io: add tags for sharing ctx b/w files
Date: Wed,  4 Nov 2026 00:18:57 +0000
Message-ID: <9fc301319428c6c47fa183ff90d60abcca8ea63b.1793751001.git.asml.silence@gmail.com>
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

Currently, it's only allowed to pass a ctx to the file it was registered
with, which is enforced on the io_uring side. Going forward we want to
support filesystems and not just block device files, and it'd be too
limiting.

Add a dma-buf-io tag to all files. We're going to save a tag of the file
passed during registration and later use to reject files which tags
don't match. A tag should be set for a file by the importer subsystem
implementing ->init_dma_buf_io_ctx on creation and should be unique for
this instance of the subsystem. For simplicity, we're going to use
pointers for which we're going to use pointers, e.g. gendisk for block
files and superblock for filesystems.

This patch adds a new field in struct file to keep a tag, but it can be
then be switched to a new f_op method.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/dma-buf/dma-buf-io.c |  3 +++
 include/linux/dma-buf-io.h   | 22 ++++++++++++++++++++++
 include/linux/fs.h           |  6 ++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
index 8440151de860..60dc58fc0c23 100644
--- a/drivers/dma-buf/dma-buf-io.c
+++ b/drivers/dma-buf/dma-buf-io.c
@@ -166,12 +166,15 @@ int dma_buf_io_ctx_create(struct file *file,
 
 	if (!file->f_op->init_dma_buf_io_ctx)
 		return -EOPNOTSUPP;
+	if (WARN_ON(!file->f_dma_io_tag))
+		return -EFAULT;
 
 	ctx = kzalloc_obj(*ctx);
 	if (!ctx)
 		return -ENOMEM;
 	ctx->dir = dir;
 	ctx->dmabuf = dmabuf;
+	ctx->importer_tag = file->f_dma_io_tag;
 	get_dma_buf(dmabuf);
 
 	ret = file->f_op->init_dma_buf_io_ctx(file, ctx);
diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
index d9f27650a851..299edf0baaf3 100644
--- a/include/linux/dma-buf-io.h
+++ b/include/linux/dma-buf-io.h
@@ -48,10 +48,32 @@ struct dma_buf_io_ctx {
 	enum dma_data_direction			dir;
 	bool					is_dead;
 
+	/*
+	 * Tags represent an instance of the subsystem the dma-buf I/O
+	 * context is bound to, the set of underlying devices and subsystem
+	 * specific map / context structure representations. Remember the
+	 * registration file's tag (see struct file::f_dma_io_tag) and use
+	 * it to filter out files that don't share it.
+	 */
+	unsigned long				importer_tag;
+
 	void					*dev_priv;
 	const struct dma_buf_io_ops		*dev_ops;
 };
 
+/**
+ * dma_buf_io_file_compatible - Check compatibility b/w context and file.
+ * @ctx:	[in]	dma-buf I/O context
+ * @file:	[in]	file
+ *
+ * Returns true if the context can be used to issue I/O to the given file.
+ */
+static inline bool dma_buf_io_file_compatible(const struct dma_buf_io_ctx *ctx,
+					      const struct file *file)
+{
+	return file->f_dma_io_tag == ctx->importer_tag;
+}
+
 int dma_buf_io_ctx_create(struct file *file,
 			   struct dma_buf *dmabuf,
 			   enum dma_data_direction dir,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c..a9bb63cf6f9d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1293,6 +1293,12 @@ struct file {
 		freeptr_t		f_freeptr;
 	};
 	file_ref_t			f_ref;
+
+	/*
+	 * A tag representing the underlying subsystem for dma-buf I/O.
+	 * See struct dma_buf_io_ctx::importer_tag.
+	 */
+	unsigned long			f_dma_io_tag;
 	/* --- cacheline 3 boundary (192 bytes) --- */
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
-- 
2.54.0

