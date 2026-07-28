Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4B7C54F5C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3A710EA1F;
	Tue, 28 Jul 2026 21:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eGvhtvl7";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A8F10E5FD
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 21:30:09 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47f9ab7ee38so232737f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785274208; x=1785879008; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=;
 b=eGvhtvl7NbuKpg/loKrzy56NDVH58q3Goz2EZjYQGQVCGq45GldC4p8Wg5R3DVkftp
 bUj28e7r6B5P6TLs9CbjUl5NLtPDlZK0hQFgEdz/mzPPzBOSOZzXgyBO1B/x2T2O6Ac/
 U6Drtj7NGSedSnvcR6aZdBKOCcRjM1w60LCD56dNXJmFP4amTrVOOmId2lfRk5YthKRV
 h67DW0zajsHKNXN11EGAwFpjYTHcVu2wro9lMh7e11yQffWWvu5bcPtLq0mMgUu7ryfc
 LnD9n/6hyiFnMWYGcpWEtZ9FeWWbFet5hjAutfF72wjFFC+sTf0bx+WQlAbY9604479p
 ZmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785274208; x=1785879008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=;
 b=HOb79WeLlIwKPci/BhYcnye3Q/kIev+tkQcK9BEzhyApdfSw1fQzAL9JO6fAWKQX6h
 9qti5jOLZAgG1m3/HIz3yecHtcvvW6B2kg3IuJIVkPSfkWB4y/Y8IajAAnpB8/TpyOaV
 cdMEaNd+Qnquz5rPD9yDn53INl90HobyWlDQUjknbrlVciYd8N93bAV8ryrmjAogfCxC
 sntNBjslh3qCnrR6xQsgsFmYMd9V21FmlLuiBpppgZHs6OPvufnOu7UCFmlk4kcv5hPf
 9cjA9ZsCUH4dXVoF1KbN9sYq8uS/MANwfapZLCbbQmTwTFW39rSTjHPMaMLZNuPFA0n3
 JFQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpM6JwFuaxR3HbmO6gNQjDaKDqWurhjBKEnhRprr4gYA90Aj9ItGYk5dVhCieQNOXpkiZIcz/SKcPs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxvwxPTgAP0WgQNeGIG4IWApxSTy95k/HxIY7askxyk8CNdlRC
 5bdA12dzuK14RXTHdrZhew3U+yLL869W4zPHOacdL/kTZSLXEBjUQLxF
X-Gm-Gg: AR+sD11saiy59JRzEyioavp+jJWQvVepqURQXr7rz+EvTI6nn1ZC+Th9iS1z+A7UhmY
 iw/oMIKGqJWrW+D9axetgxJQDN2ykpGrp8p/7LxL64SrY+vhKd9gRXFhrSG6l/49rjggJBipthp
 nvsSVylKl8huPHTHKp/jOyC/rYgHZ+JrXgg1qBqE0TPxu5Xvegz6rhGPCujBUZAihSWh8G1n6Rt
 VNC+lMrU7r3Ym0kkqGTKGsx1ier8iRpNktT00umoNtDH1hZE56F04xbeqJP6hdEg4K7sDKbuP7r
 vW1Ezkhf+8U1DeHFHZoNyxIjaXZopufxVjD19sAoQLsDQiBTfHnLKoMacgTLG4jkZZn1+VV1jrG
 yuw5hdO/UkLDOy1MR4ZDI1TkRp1uZ4+6mOVUbBL+9HlzBkN/gue4nHKEVhPrsXKOnYYSP/4QEZv
 gY6xU90U539tYdjijeyeL1xRa+N2OyUZpl7VfyXaAUWEFZZO9GMAdY56YKbsrUp1n2SLE+Y4xhp
 lhwTDhQGHA5iIeJQlQ=
X-Received: by 2002:a05:6000:2f81:b0:47f:97a4:f121 with SMTP id
 ffacd0b85a97d-47fb1f108a5mr5045703f8f.30.1785274208062; 
 Tue, 28 Jul 2026 14:30:08 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:30:05 -0700 (PDT)
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
Subject: [PATCH v4 12/14] io_uring/rsrc: add uncloneable regbuf flag
Date: Tue, 28 Jul 2026 22:29:24 +0100
Message-ID: <a138961611aadf950ce6ab9215f00ae888b8ce72.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
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
index 24fc3232a66a..d57e8a0380b5 100644
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

