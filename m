Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F987C5CFEB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA3510EE7A;
	Wed, 12 Aug 2026 07:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R4rodCwW";
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2EE210E2DB
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 22:51:21 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-6acbf97e9a1so235418eaf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786488681; x=1787093481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ULj5VW1UWlM8YYUcQzLWByRAMMT/RaKzn22tl/DU+7o=;
 b=R4rodCwW8WIUoZ/WFhVj7BQ4Ms7XNJSBSmt0DF9vygJIQElZVHTFzC9+4WycKeQI+9
 c+SgkMjrFZpfwRUklhQOWAa4XA8Q5foat/40mbRv13iyGEi9P4bB2IkfSHSIdIwap9qP
 Kqsm+3pbCijBDyQh/Gyw5fhFD+95Xy7A5jeuvCXmQfI+7B6uyPjwlo5zt4g4KOL0qgIF
 897FAxZUg7CbXhowwTzFOUREk7/3TNf3mlzEq/jSVPqABYkd0MWGggs7YvMhEZ7+hOvr
 U9SIedJD1q1Vckr3fVIy06ROx+XiSu+G/vua3PYWdKX349MZLFSTasA2VXsegJgulP4x
 UT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786488681; x=1787093481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ULj5VW1UWlM8YYUcQzLWByRAMMT/RaKzn22tl/DU+7o=;
 b=nbOMtJTo9mfCLKB0I6D/mE039y3+refdmlAj3ThI6ySBYWzm8oHOWjz3AbSMPnzBE2
 JjHtx7t2H02nVJzI2kzYFGp4OhqJnvGgwLSkTrZH9EG4tkcawyh9LmQfIWpH5Dz3IH+I
 Qk6Nbymp0TTl1mpaEl1NzfJYl5oWmO5Ahc/xrrTq18bfkbS4K0OsCffotxY5LYNmNEql
 0xAqpLrcvDXl3BQG/BKmZCBNiLY0ch2uMZi1EqH/jKpg6F1dIRo0HlYjN4LEV9CwPmo7
 wC3CS7bGrWtsmGy2Lr6pgDQFtGyJztCqA+ZUFdcaPbHRJeoxNcObdGhCu4/lvStGqgvN
 7azw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrB0na7SHU8AlICb5461WhH/uAFZy4demrmefJnW0TgFkiZUXOLJF707870CwOBDdFgKDg5BPzSbU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzy7znumWelsUjlwPE2KLfsmsnroQ3tXNbdFYvs34jlFo2LHTq6
 89axyiWosbonPy1OD7xuAtFQPo37csFiJwTvdiIZbPFTfUOQcSCA96Qz4K93bKcS
X-Gm-Gg: AR+sD11doe1pXnQEwD6ErjUNQRfVeNR0DIcZiFpRk02mmMig8yifHrqQgv76l6PaJf+
 ikUcGHgXQon7pV4r+BsGiDZX2UAbxDF9v+eODdu+Qvb3Pf6jM3dvWrpzj6TdpLBIEaDBZ3CghF7
 maXIq+5rosApN5ok6nBw/0XikhEUKZwYHpHdIHfZdiIuYRxrbVwcpI3IjUDMpEppV/2dJMVStXC
 DMNTJDQtmdsqlM50n6YBlZQtVQZ/qrdoEq6UISeb33ax3w/79u1mQw+YtrGiVnAC1603h7lwEKx
 i9Vb38nLaML/flfmXSgYPP/oifKfXx+04NrYQjsWw1PAm8kY1xxkpqy8RGlbem7GfCyuB9eezrF
 0wIpTFqZn7S3CHAPX860b2fw71mxlTU4F5QnxqEjz5FoMzgk4NWp+mqiTKA8Q3H9JxybinGiKEy
 pAIHNfa+RLnAJ83IZLbU45r4wYKD/lAetMijKXm3YMJR91ENgx8T4ThzmVGzX8DSrTpVLlstwhj
 QzAYS6f71VuSU4uf1uMD9RprGvg64VDUt22ZTDZyhU=
X-Received: by 2002:a05:6820:3088:b0:6ac:a8ef:9a86 with SMTP id
 006d021491bc7-6b0b2673790mr405371eaf.15.1786488680805; 
 Tue, 11 Aug 2026 15:51:20 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu.
 [128.210.106.74]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3b3475bf1sm1019766a34.26.2026.08.11.15.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 15:51:20 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Yifei Gao <gyf161023@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2] misc: fastrpc: fix double-free in fastrpc_map_attach()
 error path
Date: Tue, 11 Aug 2026 22:51:01 +0000
Message-ID: <20260811225102.1077841-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806235056.456341-1-gyf161023@gmail.com>
References: <20260806235056.456341-1-gyf161023@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

map->table is assigned right after dma_buf_map_attachment_unlocked()
succeeds. The two failure checks that follow, the len > map->size test
and, where subsystem VMIDs are configured, a failed qcom_scm_assign_mem(),
jump to map_err with map->table already set.

map_err manually calls dma_buf_detach() and dma_buf_put() and then falls
through to fastrpc_map_put(). Since that change the error path tail is
fastrpc_map_put() -> fastrpc_free_map(), and fastrpc_free_map() already
unmaps, detaches and puts the dma-buf whenever map->table is set.
The two operations therefore run twice: the second dma_buf_put() drops an
extra reference on map->buf, and dma_buf_unmap_attachment_unlocked()
dereferences the map->attach already freed by the manual dma_buf_detach().
kref_init() sets the refcount to 1 with no intervening get, so the final
fastrpc_map_put() frees the map synchronously and the redundant cleanup is
deterministic.

The len > map->size branch is reachable by an unprivileged process via
FASTRPC_IOCTL_MEM_MAP with an fd whose dma-buf is smaller than the
requested length, before any DSP invocation.

Route both map->table-is-set failure branches to get_err instead of
map_err, so fastrpc_free_map() is the single owner of the
unmap/detach/put sequence. map_err is retained for the
dma_buf_map_attachment_unlocked() failure, which is reached with
map->table still NULL and an attachment that fastrpc_free_map() will not
clean up, so its dma_buf_detach()/dma_buf_put() must still run manually.

Fixes: 334f1a1cbe03 ("misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
v2:
 - Instead of clearing map->table, route the map->table-is-set failure
   paths (len > map->size and the qcom_scm_assign_mem() failure) to
   get_err so fastrpc_free_map() is the single owner of the
   unmap/detach/put sequence. The map_err label is kept for the
   dma_buf_map_attachment_unlocked() failure, where map->table is still
   NULL. Suggested by Dmitry Baryshkov.

 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index eb6c2a78d3c7..d480a87752a7 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -881,7 +881,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
 				len, map->size);
 		err = -EINVAL;
-		goto map_err;
+		goto get_err;
 	}
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
@@ -904,7 +904,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 			dev_err(sess->dev,
 				"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
 				&map->dma_addr, map->len, err);
-			goto map_err;
+			goto get_err;
 		}
 	}
 	spin_lock(&fl->lock);
-- 
2.43.0

