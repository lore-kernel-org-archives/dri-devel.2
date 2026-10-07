Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54656CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9072310F442;
	Wed,  7 Oct 2026 01:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Toe3ZsrU";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01A410F450
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:43:29 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c411d6615so883107f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791337408; x=1791942208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
 b=Toe3ZsrUtO28Ty7XM4JBoE7K2dAtWyOo5ScJlcgjUvPYRk1sZ3b3TPTY48Ce998NIj
 7CkmaA5V6D+byAuztls4uEpMCKSZeGhtVJZ9E+CGduzuqL/AcO3UhcLs+JZVd2fIpDga
 aI8+CRrZ04lUoqDzuDwmKaWONC2UzThwflAojNEna1OvJ++WrmhHx3y6VI2RIRvZvjzP
 5hsFi+iYv8E1nEgURkq+Jp+q2G5mG5qH1JDJovGSjLDtWdDx1EQmyj77ExztRPQLPZVK
 4cK8ife4Z0JM/IPw6qZ+qC42lleCl+1olI5LYU17nV02NpYiwvIzKX34af/uX9kxSnPJ
 22Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337408; x=1791942208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
 b=oDwj+qFqvdlgXFslH7joscS6c2H9q2NnB3t24DmTmCxBp9/nIYpUCW5iJ9ZUedi/6z
 oOmo639mQcEuFwSc3YapwdCjvRESTHs3AhU0kjFPqLWvN7PlMAIFRGnwaVQ2lzpmwmK5
 d2rtWnZh+9UlrVmA+pDlKlVPzp21qibXJpKKpO7wgfa3HxXs2AvrFf/dxzn9IOGl2+4f
 DdyDSuIZIt7dv1aKeZq+amPFzFNS8gCk/+e0W4KN4UbjMBW0BnP8grWc8wVxMRVidA9z
 choPTSBrrHO5B6Qa0IBxd9y02b+B6pLyS25T36vWEZnuuJdlC+jldrK/ToZsRU2AaBrd
 85Tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpWEohbFxyrVIdkUWOLRr8f7NqpC6zbsMnDqPzeEx8SL1HujIRFPo6DPkaUOe2fswtcstEUX7J1DE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++maFehVDvE95oKyHfzTnNMIQD6eXGOH6X23YDntgb+GOZZldXDP
 PWq9ldUKH9br+jQcMti0irvh6COuAeAMYogacpChjQCdDiCvZPh8IXFr
X-Gm-Gg: AYBFou1+uqG+/4J7XgQ33cIhrXSzRY5cjj4MlOCqVpNuePuVtt9GAcSR3MgBEGsOpql
 egHN9Oo+su9DxuxJWTtaf7r0HoukPt4nFtjB+d1bvZNT+Lv45MV/QLzQJwjYBRxHtNjMNsE8V5t
 lzwWlIhwrVEKvfM7vhfel+QG6pR3k5v5aL6TCFyDLl7jBzDPPuYz8U925hqqOEEgqJEJLfAd2/4
 jXyz6b6ZviCs8owlDVJJhtRIe17TgQC2Pk0X1OaQdcVNpp/tqh5vqu1znams3nwYwrkfGC4FL/Y
 ZpEvQ6ThrMT6r6mT//+sw5her9hhyl6FUs/8SgZyegrlHuT3mVDcyI8oedV89kGSMkq983wrHz5
 Rr5EWX+L/CuNfwGFr8BtBNgkwGf0bBq11nbFPPbpYTGk5oramu8yDkcD3f7CgjIM+d6bu4+EAXB
 +w4id+hsFJQRUYi/ccwte5KwCl4Ft2S8FjFEvjH5EOSvBExaPxj1SvYnREFA5bZIlhN0VHC+24p
 2RXhAaTjcEwNmT07iDuX9B1J23oVY7RYCWOE47QLu5XMM5zjUfIufYtLRpI12391VHAs9yTGruI
X-Received: by 2002:a05:600c:1911:b0:4a1:78c5:79f5 with SMTP id
 5b1f17b1804b1-4a180455696mr7216955e9.33.1791337408104; 
 Tue, 06 Oct 2026 18:43:28 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:43:27 -0700 (PDT)
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
Subject: [PATCH v9 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Wed,  7 Oct 2026 02:42:54 +0100
Message-ID: <e46bb4ba345595eb920f2e14077f7f3d3b044d0f.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
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

