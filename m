Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E744C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C7510E5FB;
	Tue, 28 Jul 2026 21:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ks6OFp2O";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2A210E5F7
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 21:29:53 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so205016f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785274192; x=1785878992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3L2paztWhQuVkOkPSkB4LVS1c8WWkooOhtLcip+4H4Q=;
 b=ks6OFp2OapJMp9pLwaKkAvDCzR3Q1UrRuw0ZaP8KEHySIwaYuUmnwXQKOeOOtmSVqx
 aQkHIS17PRdajkMdqnaQrPPvVnBiRXXwPHvUSK3eeK3cfbFmhQDha1zLTIgKb1NkX2mm
 vNQ6KKqZ0vT9J+VOu3FcKrNq3LD4BKbedTuPJ1ZFwDXTg5/nDUPb6yQcPQOm+eWMzUxM
 51hit/HWQyvZLvcZumauouhvmNT8YdaSC+oyheoq+1dS8HTjxsGEzCgD6d6Z9z/GmrGY
 Yl8RMIlM0O7bd5z2EAyHA3zs35jECWpLy3fMePpHPyvz0/dWnYbnDc2RJWxLfMK0h52e
 0MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785274192; x=1785878992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3L2paztWhQuVkOkPSkB4LVS1c8WWkooOhtLcip+4H4Q=;
 b=NokE3xgHTVHl4Ltmex2CLFlNgg1nOUHRo50omq98iE4BvwpH2+fwLj5ztM8g4k6ST3
 A3lph5xp8gFSn3yjW3/bD4a5uKyUy02RJeTJaCkFmqYkAKcjJaFMF6NJQJEsmeCRai/J
 gJK55t5kCs8DRA82SkbBHa+CZE1hQE6HImlPH3Ia+W4o2BJvf1e5yZ7oIu+bSWfh9ULA
 kuksalL/6UxcJl6U0BlplmXEgmwlgm8MT4kQUL3UjYJLOj4czv4ahK1IoQE5twZ56nVa
 p7EMyAh8zeeYguDnGcd5hVLF6JAm7GdITrlfwjPlQoWQLm0V6ipzoDfW/8lA+G3JO6kO
 Wl2g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2QvREKAoTiErG7uwPo/7FkD2tu6Jy4Xypxh6dyaYXoqPtuQ+Kqxtz/asyxNR7hddd2d4lRzf13CA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5+ELiAAMuUQ4LIwiRonuqURXrdzmkSDJ9I4WIT2O70FO8whiS
 j91Uv01doVqJXt5RttegaYYfxRlAj4hClRgI/Bt2Vf0pMx8fetWJ+uGs
X-Gm-Gg: AR+sD12mlT7O3HFs0/62O2jXph++BvPUW7bB60B62tiGx8eIieWzQM3NERydyTJvd1l
 YnGFnclB6TUtskJ/KrKR+yspmV15+ixoyp+qWrS+EPwmr7m4vHXkdI/ToX0rRMsCx4ZE2pNG1Vj
 1fCin82/xy234xAs5whAh3klt2D0VPgua0tTuMR9Z6PdFmapWWg6v9BXtG0WvJVb3/2yJu95Pms
 PDM2SngG1tNzVsyvM0yCAYEqkiyg+cuZShTNb8jFmm68NJbql9ZpoA6ET/wZyXAO4VdJEIoVoSV
 KGwNodaCX9hcDO+WfFm9XdMKWV5jWqLOuqOyc4UL7ZxRGFvMMx0lm2OLRVwLpZXVfXDWbuxBXU7
 TxOEMRM3fFIdWJKeUBOoBc4Tsj302yC5d9d+iy5FGDQc8eJp6pZAYauaD2ookpIzkF31uyPNhb0
 F0TC/2LQzWo9dIkLOX7l6hiYgs2TKpilQQB2cOxV0ZBGqmdyRFqRDxr/T/zIPAey4kBMBPpmtgX
 zDoWBBR
X-Received: by 2002:a5d:5d06:0:b0:47f:947a:9dba with SMTP id
 ffacd0b85a97d-47fb1e5ce09mr5390953f8f.6.1785274191852; 
 Tue, 28 Jul 2026 14:29:51 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:29:50 -0700 (PDT)
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
Subject: [PATCH v4 05/14] block: move bvec init into __bio_clone
Date: Tue, 28 Jul 2026 22:29:17 +0100
Message-ID: <7423d294c6184c683d7b2ccddf060b4a308e0316.1785274111.git.asml.silence@gmail.com>
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

Consolidate bi_io_vec assignment for cloning in __bio_clone to keep any
further changes in one place.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index bfaede30a54f..57c127aee116 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -860,6 +860,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -902,8 +903,6 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		bio_put(bio);
 		return NULL;
 	}
-	bio->bi_io_vec = bio_src->bi_io_vec;
-
 	return bio;
 }
 EXPORT_SYMBOL(bio_alloc_clone);
@@ -923,7 +922,7 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 {
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	bio_init(bio, bdev, NULL, 0, bio_src->bi_opf);
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.54.0

