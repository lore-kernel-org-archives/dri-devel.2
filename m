Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF76CC6B15
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4180710F9DF;
	Tue, 13 Oct 2026 20:55:51 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA0110F9E6
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:55:43 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso3185262f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791924941; x=1792529741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
 b=g+1qBRCZvZRR6aTeB7+BcvB+vL7lKha4Tt+5tOw9zV6lZeTWgRVYkamA5o+LovYzEN
 ZejvT/YBmqwc80tbfBy41SkLLTXZs3vTxpi0MKEJjDjwsMyVC7k836HqfVLOqr6tO18w
 Xh7pgP0sXEuNty0zJbVLRAONe8QsVr+HiSpBG3znIKlAp2CkP1Wf6n8b990HXSyFQY3w
 AXU2hG2AqBWueY8u723OIg+q2ewiP0Ljnt+Az/B7fTxY5sO7PSNzO4xJD4ViC4fQv/kj
 Y0XTAwb4OP9pL16ZddeL8DxhfmacfMLZsDOWlLVmtUpxOpiixWe5HgOjTawaitOQWwSH
 3tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791924941; x=1792529741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
 b=Df3SHgDL5YSczQZNGR9pO7PuZc7OYQpAmkI4unM386ecsd2a5p7b0o8vW2peHHDeIy
 sAFPkGewWvdzP5Wj5uecDVcLFSVKJ2JZt9Wq/RHt2PUfwBvXSmVbtN89tOObez+DNiuH
 MAJOvPLdhA4Dee7lrhOQsxB/lsb3nkh/je3uY0nkNnxieKG1qKMKB6wmgA5dmsbd0MvA
 C/uTBbwssbe2A4LwS+TSga3Xi1N4w4YZT34CyFLphTn2SrH79cVLv+KlOCazv5lHBKqK
 NIrJ6AO/WE3ovEBpSEOQ8BinOIJQD5tSKMwPtgJItviuffMaZz54PkNPBAgE5p4bRatr
 m4Tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsnoCYU6YWiIJRrQLIotiReQ6iUoQPEjlzUwPy2m65Ity+51ReoHbzX0s8Ekb3qv+7vMiiJPMAGHs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLSyvjo5APFTjy5eucoOJwjNyQUQbFK6Gp+fOt0sk2ufuI7S4XO
 /LvGN3wJUdvWODfLb2ovwzO3y6AW0iwQUu1NazDS6mtU/hPh0Ox+YaOh
X-Gm-Gg: AYBFou1T7ay4i20eA3zYF77o77mTQSP13VEestH1gCdgn+O41IlYTCWQF0thpd/nnRz
 G0hZPQM4jJ2uI0FIQhstF6+QJ6mBTNOnJZKuJE2I56TvN6bZGClFqruWmNjydYQtV+hHuWOHCrP
 /siA3iTdhRB9B7lVL0MjNukAhNHhsPOQWu9GPTGebvf9EPF+PwzTO2emcL1ylYdi/InJN5rH7ZG
 nx5l6X3lGjf7fK/niiKrKzS//ht8dExCvvCdbRUTr3m/83otj7Snpcn5EdYhl4A9yQBDlBFtK0j
 OBuJcGZL9TvVVw7QUNgPyoOxGbvrRsWeuii8+RA+qRXsB6hrhDjo/cEnfmeUqL711wCALhyvmea
 9sOkx4jIF1DUUlxnN/tA2WD09iucWq8TFCIi7JfPLT3qK7ix9djq2ClLeKoBA7MZKWPxKGj04eG
 ggkxlPJA65g05XgdY+LXp53XN4iCFZhL7Au3ZlRhXwcC1OVsD3ifYx1vro6tNkbL+Yk7nz2c9O/
 llipjLt9GerJrm40wVHVROWni9+pV1bF9efPrr+wrRpmQBotZXmFf8Wxd43hZ39z+NzIUUhqfat
 C2mBJLf+ftE=
X-Received: by 2002:a05:6000:2407:b0:487:1ddc:aaff with SMTP id
 ffacd0b85a97d-48dbace40cfmr24537298f8f.44.1791924941527; 
 Tue, 13 Oct 2026 13:55:41 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:55:39 -0700 (PDT)
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
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: [PATCH v10 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Tue, 13 Oct 2026 21:54:55 +0100
Message-ID: <b013774568929cbc3e6fb9ed29079088a1006431.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
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
index 54774729ee67..532866a1e9b9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1458,6 +1458,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -EOPNOTSUPP;
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

