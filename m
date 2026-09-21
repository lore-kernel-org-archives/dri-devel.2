Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FEDC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6145910E786;
	Mon, 21 Sep 2026 13:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VHLqp1qd";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB0A10E791
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:39:59 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so22259955e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789997998; x=1790602798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0usqXOyq3o4rQ+AIVUUfsp1gP3m25NdfBnNXnNuf6eU=;
 b=VHLqp1qd3xGgmU418y4SJN2r0tUSnSgHPu8tuXXc52pV0E16nrkM1UvhGm3suqJpuK
 XjScEveILj7dTouFvK7PWvgqIo4xudvQdnFd7wCtf7A57iaXf73jU19PJBa1UeJAqK6P
 t3eaUMP+sWqBFNHWjbF2mZ775G8jugnWFlf0eDuJUCqoffdYaNmXOhmzEWMUwPqzxkDJ
 Lnu5Y4OjSgRvz5uCwej2JW8MNieZ3Tw8fBQSATAN+VAHNNJ5zmuyk5SvJvFsRaHXHv93
 8ly/MrveCHVg50WyNQNNafM9unu/5fDRHO+R32ypYBbc/ovCw4kW5XjMSzDtur1gAYhS
 smxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789997998; x=1790602798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0usqXOyq3o4rQ+AIVUUfsp1gP3m25NdfBnNXnNuf6eU=;
 b=EJtYjjLRUUGc+UD+DWethYVD3ctQyUZjUnLRDaT0/wd1MvajW4AAYNbGwdsrm/KLbO
 UfVyYWsha1cqlDGo35hVBpJDTHMFkO7wuykWo7Hf419HCtcEFEAj3W/LIMrgrwSvRuQI
 vP0dANATZ3l5uNAQJgrZcy+gmSVyKxs3HdNBLJYUUMPwUB9cYr4kM4O4xU/dRBTEFDCa
 2MnHtx/ThnUip+6rW+o1ETl21hbcmMZZH4NL0feBnYlbCJ5v+pa9LkvCA6ccous3D8RH
 pC4s4+vIiSpR8+04sN6umiSfxhGOAQKi2YDRO1K0IkiFzIottdU7pSH8BeT1CL6Sey+4
 Xgag==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7GWDMla/xCxXHYUtvg/aVjsIgX736+0wROe8kl+LWblaFUg91BcQoxTvzfPnZbwMiaLtUebJnLRE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l3iV2P3ynHRbn7951v6OUymRznjXYW/nmf09bWfS4iXhbQNudy
 0sMU2zDbXWE+Nq2n6CFIUOxsBYk3TPJoXiMeX3e2cIJpf3WDQJUed/0n
X-Gm-Gg: AYBFou0fgUH3CAVHo1zjpb6RaH2rhxo746TGeuJO78rUrD/h91GBkpU8HwbtOmV5YJ+
 IiaTfGzNA0l1PAR4OHjAWSJy476Mz6BGrlCOz38LKiWQhaWoxBu3jHkxud/Zcsizlp4yz7NnJT/
 0JmEezHh9CX95WZrX7xxr5bXgb1qKb//xjWPbo+OfZHyD30UGt1+eY+IJrwEalbWVjMcgRDY0BV
 rZD1x9550n6f8joI0HR9vcvRSmHiIpVJwxj0Lxxe5zOI2gpicKLVPsp6vE2uJCB5hXpc2R2A1+k
 D5wJaM9mFssTzNspLFahgmjMLF+G6BqgzqkanyQPT8Yei8fF0r79dBkRdZo3pp0fdpnzr516U4v
 N2sgprdN3TRZVEhIgL6Z2rrZEwSGSswfulJYjJ1qsXGBa+ElIpWwhFLrX0NwEQwE+8i8MV6loTY
 fBAEkOK3BOUh2qWXkXE3T2/RA8B7kW+rt6Awg/LCu9ysjUYCDq9Ohpxx/Y4ro47BcZf0UVVMFzs
 ZHl++9V2UF7ZEe+O3XKh2tYHKyiDDR1v73wIMnDvnuWXYRLv8J/miXDbjUTrzFOd2iceKXmmp8e
 jGXkH4DfZxQkV/CQJop9PMy/V8B3Fp0Cb0v1thAS
X-Received: by 2002:a05:600c:34c8:b0:49e:732e:6b79 with SMTP id
 5b1f17b1804b1-49fc574eff6mr149861745e9.32.1789997998153; 
 Mon, 21 Sep 2026 06:39:58 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:39:57 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Phil Cayton <phil.cayton@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: [PATCH v6 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Mon, 21 Sep 2026 14:38:55 +0100
Message-ID: <9b71636a03f2345bcc09127d77eb6b294a1d0938.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
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

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned. It
might be possible to add cloning in the future for them, but that would
likely need reallocating the structure and reacquiring resources in case
by case manner.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 5 +++++
 io_uring/rsrc.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 83a7ad9f5bc7..0b526b094dc9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1434,6 +1434,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -ENOMEM;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 9ef88383b363..73d7b1ebf0b6 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -26,7 +26,8 @@ struct io_rsrc_node {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0

