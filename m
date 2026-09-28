Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305F9CA5FA5
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D1510EA50;
	Mon, 28 Sep 2026 13:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d+nXrdn0";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480C310EA6B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:33:03 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so18556665e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790602381; x=1791207181; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=raEDt673oWsC7HjzDuokLb4yrdGb5LOQuk6WNjaexbY=;
 b=d+nXrdn0kBsvAFS7i70s3cTmSD6WawQqy8IXgH1QXDC3wjme4zi9KsVxagG+dxhSLp
 +jMbbx20ZLZmZCh3CANAWJ7+dl7tqfg7ZritEAizU6O41DWEKeYJh1fyaUp2XICHKxwb
 +uLMRM04nR/fNdbl+VrIdezhWjyuCKS8klJg9gxyYp1SmhRfmiG56FGhM3EonWQKVYVp
 16pJ8/sVxD8wWCgcvVd2NYKGL2l1zKz+RubLISC9Sx/pN1jLSXPeW9nFzX5rzB/APIsO
 mI7h9FxOGCKfl4flZehB9MOxrarsEzDxNjvwaVh5uB/oNa20XikKJ03EX+TcY7g1IoQY
 K3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790602381; x=1791207181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=raEDt673oWsC7HjzDuokLb4yrdGb5LOQuk6WNjaexbY=;
 b=MkXVgjDtd0ofCwb045iO4huOTCsbVx7sHl87kF6iNhO0pUUOylfIRyo1EJUfUfvxKw
 wPsEIUZ71DxBIQKxF4toiua6QV/qgrdsE39mz3taW3B4yuWgWSw7UHoL9KJ+lDyMj2Ja
 rLUHeHX+ld1INwLHjn9iw7/iwvO8Ja1VvIIJbREg3CubKAX16XL10QNak9+/MoUE3x32
 Ex2CxWyy8Ijz8vJ9VBzXnMTobHIH0CWgBqrZRqnBxnGowdRBpmXcrlFhsri7C7I/VoMd
 d6ooMumnIiYL6j9DodViSWe3BNZn93giG7bkQbfNeOOHudWiulurhxYbGuGxfALOwmq9
 MjJw==
X-Forwarded-Encrypted: i=1;
 AKwUvByebSmZ1RciUElyeCMZLWdyc2aiLo9S64tW6a3XPBdwc263sm4nIPbvDmPGBZxMfzFgD/SLri2HwFU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lJvlbU2tuc9io2WOcIrCOEgcMw/m8TjqQMq5OsB75BXbSOMeZp
 J8bmo/VhZ5PsjN+4QJuCC54hmMm60UcTvjHCsK5ZQjiF2iBoaZniWU0D
X-Gm-Gg: AYBFou3Pdabkh/3ONE/Cequ/ywGSvFYYrWtZG5Uvnq9PHDNziWR/Xg4vb4lyI+tAkJp
 EMAmZc5lo1HGRBVypXdu+yeK4SUGT3+owRNzYLn2cJtOWm2TZ/udjL6APRZgqd+MCkGR/zZ8Ji0
 QqryT1Zz2yHKtX2z1pNFVzdUZdYsHyo5nJtK+hIzfBNYs1C+wDSY57oyQPEoZ3XOKyt38e5bl4k
 EXPPcbOAaeZUr0yygmZPz2GBXY9wSTtQ+t2UcOJR0RhDVw53EwatoNIY/Cz9B54hbE0IXRqR364
 TVVtwo6qRzkbaeA9dK2QLjqDEZnZhhlCkHQ1McwIyxScynLel2G2trroFiNfVt5+Nm4ou6cjs0F
 xjcLJYOAMH2tcnREfs9oHoJmZQiQcKgC6K+HP6UnpwRPvSHZjGqhn+8OR75A33wmPKSCrgeSkH8
 d7YLeaozmgJUYWZA0+ty6NXi9Wwwb5ErsAzVXXXQZuxGK6mSZxKv+Wwtc44lvstKWVHyMUdSBi/
 igTTOfMcBGXwdt3xEfIkG5K7UEB8PTxRc4ktELLTa/RP8pEBknuOM4yJKE06Lo2EXUGH7W6hMrw
X-Received: by 2002:a05:600c:c3cb:20b0:49f:fc13:189d with SMTP id
 5b1f17b1804b1-49ffc131a3bmr73381205e9.1.1790602381298; 
 Mon, 28 Sep 2026 06:33:01 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:33:00 -0700 (PDT)
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
Subject: [PATCH v7 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Mon, 28 Sep 2026 14:32:27 +0100
Message-ID: <6bb81fd0941222a30477dc849684d47333d1e4ce.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
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
index 83a7ad9f5bc7..65d6cf7201ce 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1434,6 +1434,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
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

