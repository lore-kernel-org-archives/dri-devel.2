Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A6CC55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 15:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD1A10E34D;
	Sat,  1 Aug 2026 15:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CQzidQmA";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDA010E34D
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 15:51:48 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cea3004256so22570205ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785599508; x=1786204308; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ijUzk6DmoV2KfP6NttCifTbOeJnZ78uDbymc6z2HdV8=;
 b=CQzidQmAjAc90fiv1a0Uq2SM9r5l/D7/SEMlcK3cXuSJIdYTvuqA8V0/EABrNblYFh
 2e/RFF0Afa7ylvLWHcVJSIYxx9Z2NhTg59GV+CUTqYzZjFLKlHVGNvazh3Pv4ki93S3J
 zTVOou/K320t83Y4XNYHhOhvcmmlN+tlsyF7mG6/gMw4uyWeVnxzje9mVwVXBBNXo/ZB
 oPevXdMrd66Bpf9/VOgvoY7/4DIbsKfBYSVU4VhFG3J36XrjU/tPoODSoDHWwQJ3ICl9
 dAZhGGsKMib0Dgk7mZyv0xsMrSZt3/j//aTAtDnHu1LeDMZaBhoRL6Z9gIilNUOsr6Bw
 l6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785599508; x=1786204308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ijUzk6DmoV2KfP6NttCifTbOeJnZ78uDbymc6z2HdV8=;
 b=OMLQ/pkB71jMdQsZdEeQhF4ZGm6t39HJj727mYmhnVPBrpeoaaIUGEDfv473vNARGf
 UFnudzeULSIOSYryGLQi89t0B4OBZ/loV8oSTHUI167vamrY5fFtT4e8lJshYUVIeSpW
 UCy2JdtK9OiXG89I9KEpyJdE705MwBtbj7WTCBuoRNq/5/6ATtX5OWrcRyyVT03HlT5j
 GFBLWZivre9Wu/77M7ZMNgTesum6PGXPQwb+1spxywJPEubIaUm3rxMbqWPRErqPu+b5
 /FpoPCiAtT+o3Nw0wvP+f+2P9dtM6w3ruEfrsNDMZSrwgIoHBH+1L+SSZ9tTNyNt+qeK
 rOiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqfgw9xveO162ko8y0rZ+JST2+ecG6Zu8toTLpjkQpHZ/yRdwIn6GF63E5KdQZZFWCdJiwGYD23Uvs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8kQi3viozfYjU1hEDWKPFiongxrwch1eJYmkzxDLHaiDs6r6w
 lutD2DUMlZEZkyXSANoAQ86mGsyppZiOGGNhOSl8h23V87IOT/I1VKrq
X-Gm-Gg: AR+sD13RuuX0sRvIKnMkho6ibD8eJcgK3AMSygjVftdvsY9THYnzkh1NiHIXTMsSKKM
 GTffkcukMiUEOSXH9QeKQko5Wn3FjFhZypX9HxhS8UYlTffOsEVVm1zQAuAJeyjkdBKfL7vjlPa
 Va9i9xf5WbshiTU+00asSRDIJdu/XRPO6PtxdXBlZ5xYRDzfOKlBOGgzNv/IZfItmYiahQVA+cY
 sBO+2eHNKyfpzXuVwgb3bCAcpdAE8kw7v+Drn1Xu3gUBD7VPuViJps/Vh2m9IXyMp7+9GKLLDEB
 dqtt1lXdLK2yn5cZCSBGcOglz6OU/SR3N3vMtlFnknczHdkJnyAm4b42vAM402LpEoKMNEAHgCP
 rjImSpBrKP9Hqqh6nohxbvOPIJXsn/C2p/DTzLQIup7UFE2hVV67uldWxbPFQAiTG0/GMv9X9qg
 eD0urCinbDbhYM2gfFfWCedv/0gNIAdJ1BpzlW2HG6IdxXt5mdMHhb43p/idGmg0VfUlht4bZkM
 ChG5hRe+YpblU9EUDSmfQOnvLpw19PeKIGhEOKXBOAI2LoYQThkGWSlUxw=
X-Received: by 2002:a17:902:e945:b0:2cc:9179:335 with SMTP id
 d9443c01a7336-2d0521e87a4mr39523185ad.8.1785599508438; 
 Sat, 01 Aug 2026 08:51:48 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:51:47 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Phil Cayton <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
Subject: [PATCH v5 14/16] io_uring/rsrc: add uncloneable regbuf flag
Date: Sat,  1 Aug 2026 16:46:26 +0100
Message-ID: <65be6058af60c33328f9ccd8133d24e2bbbd0f84.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
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
index 406619158fbb..f041b0db77af 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1381,6 +1381,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
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
index 98ae8ef51009..83aa86e6f320 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -29,7 +29,8 @@ enum {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0

