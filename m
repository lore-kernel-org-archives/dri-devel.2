Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F94ECA5FED
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94EE10E4C1;
	Wed,  7 Oct 2026 01:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O56mm6//";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1860B10E7F2
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:32:33 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so33211295e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791336751; x=1791941551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
 b=O56mm6//xkF8qv2g6nq9M0DkWKwA2dgIHwLqJQGNDmqWmG1ainT3E2Gxis1dghi5ez
 Zb3At/dy+FX7MvzeGYxgtDIyB/pyy90oZpLtlTPro2pZac8rX6VD3HdSCSer/XEluvOP
 O6pxowvxP4uvupxAvNoNMblt0BOhtdj7iUcRC+N22bEG90h1cHEmb3MEvs06NXqj+G9s
 VSXWxsUEg7xQbR/NIvVmfCPGvPl4YDNgeLL9Nm684zF1+7pApvECEXP4JGDDAjOn1rh/
 hC+Babj4u98wQR3c1NqtfwKRnNzhJoEWtugli9AEUxY26iC0WHkjddyJbiLn0z6HRHDd
 U/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791336751; x=1791941551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
 b=z+Z8ZOhErTGE5BgSYp90l/b1sIzQXKYKUHSOhrLrRDRcCMGBTiO2ZskAF6kJvZCCLA
 ISEvFrgX3kC71EblfPv5gzhUIkNP0rHiWX0gmWxLefzcc/ib94q5yPnGfVQXEISq1jyS
 RAHUBuEdZcM+4z2IgCCaFP4Su+eMnO6j6l/XWwINte9SS2U8ce8bDtuqk1zt2WEDmuwB
 P7XXZXfGk1MAqM5Ym5XxTG8sFr1xH80K6pNQTb7rVNg4ZPssDx+nnPSpqbvfa4AVdaz0
 CAzFxqSeDpBsVOXIPfYvwoHceGyWwdcwV1xFiP+InsQdPms2AlIsTJkRwhWgjKjWUnwo
 cf7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByFksvixGlkNfm4xYpnbbtbxQ0/yQm+4MaxBGttTCziHYLywVshFsi17/thgQ7oeipGCI/GmN8Fvfk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k/m5KAQYyZxq0uzU3i2IVKlQUY39a36EY1sZdZsg6zHMc1phyI
 /4gtWdaR0Y+bkWbKb6S0j/aD8xRTV4xAYFgvRtec9Owny6qsBXjblE6r
X-Gm-Gg: AYBFou35CKTLKeq/sy4GtqyFBdcN0H25T2rz3BXLRCB9W/FRITDd076Ov0kVMTyaKN1
 eDWVfhztz0KfC6kd2hPxjPg3s5/vynM25dFLkgKanlShtZaw1416kdA/D2cnCpIcu+ueeVUHVZr
 UErJGE3x6WJZ6lY2leyQN1xhM5lpOcNIzwybKdkZ7HjMh/avTF7kEqPUZT4fzCBU6nAsWHPLgk8
 FS9kuJ6TXmqNA3BNWoF7H576pyWRfRQGgOrbgaOA5ZTy/nQdgagu8NlO/8mJUgbVAiG96DGysPQ
 o8RNMF2ERvhsC/smpGC6Cm+LqhmOy+ZGSjNJwpLtO8Xm39KJXvULO6HIhBrPiXdYQOPRUb0bVLh
 SKb/3awGmhxiABXtVEvJNHK+Mt147myvdKiR4+eWGJY2zL1IFEOczv7ihF3FGiLWzObYppBLLdT
 7pkqmmHV+OEQ8GMZ3Q0vLl2os84nASzz8OcgnakFJEgw0p+uUv11kSlFZr9tAQ+0cGPT1u/Sr07
 jfpqEgF/loFSPkzcIzLtKVzfnxfIMC3qqzceyZjo3GmtCcjxJafxJ4AlZSM5aslZ4p7cgdjEFcB
X-Received: by 2002:a05:600c:3155:b0:4a1:7ecc:b23c with SMTP id
 5b1f17b1804b1-4a18041ad89mr5983065e9.6.1791336751486; 
 Tue, 06 Oct 2026 18:32:31 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:32:30 -0700 (PDT)
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
Subject: [PATCH v8 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Wed,  7 Oct 2026 02:31:54 +0100
Message-ID: <5ccde8461121af903a18cd6085ccac98656aba4b.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
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
index 77e6929f665d..6930a6897b41 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1456,6 +1456,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
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

