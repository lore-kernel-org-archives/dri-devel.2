Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6F4CA5FED
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE90410F43A;
	Wed,  7 Oct 2026 01:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T20r9tmL";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A0610F13C
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:43:15 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so33268805e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791337394; x=1791942194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
 b=T20r9tmLEFGKshgdZ573bkq95hkRPX6p0b6MDfcCeTYWeuox65Yxlwq6wgjSFGd0H7
 wEuCUlnw7ajGjUx5tKUiXpPJSenmgs4i50Vpeu5zEb3CxAaIB5UbqLwHCbPYKFF6ZKrQ
 xRg2kiKbe2gk9V0CUHT5cdwO+QkIQ7GHAqpabWuLVw4YEUy1gUnPuiqi4c1NeHqdmc5Y
 hBHT8CUZSM/s2lnbXbCPqxbHUyVvxG45recVoYLWPYA15xeUpqA1qkQ+LxGIx4ejltZl
 XFEg5DgkwhUeuU1qzbDtTExmSouX+Il8uurl+hc/Q4dZSa1TTK7c6zjjG+DFTM7/NZVO
 IZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337394; x=1791942194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
 b=WXXI2AiGRDSkrSKqlPbsiXTDXRMmciESfOWDSdwyULyhxokmcxoUTZvQU7smsh9Uch
 kMzQ8YDHCkRdxEkqQmECRR1HoPhWd5z+I7VzQxwISupROK+ZBt+sAZdXyCO8tbsbsT2n
 ucfBxPgi2i/uG+aH8bKsEBdHqAKW4RWjSwnudqNxPNrFi4lzH17bG7M1EiK0SYEHo2Jk
 4Mg3hNefO/wFmlUVGL1PcjXMBuVfo2U5l9AJ+mZ1n56Q0JWUWIZzcqQhv3QKtbv6NtRG
 zPasm3jMYQE7AahG4Z+6tRLirb7DIB51qBXuDNdAO92fBru+xHrOgJSqRBwqcidOG2EE
 sBeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnuS345aOuqnNDTNmxPRMtdLFw5XEo5MipE3zoiEgVMPbSvamd5/ATpnTxVtk564DhvGiLCAgZI7A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lpyFQBGj5xFeN1p6NDHVyf3t2Dv90CAwigYMnRRdZ4jcMyZvZO
 9Zsq48BlV16pAJ6dAreKD1zXKzVzKZ5vOuUGGXqHOm+mfASjaZxoeCUK
X-Gm-Gg: AYBFou0lwFCrHktrLtxIaoC7iaZiAzMm4ucbkZoS5bOx5QmBmx7zYz8l/vm4Tlz0Hjc
 F80lnOSup5Rqz7bl1toslm7kSVJCuIp4sQjpKd83aLiKw6j3gcKSMRhpqhUQWBQEADPU4aOex3Y
 IuBFGVrax92mfRGdPd0HCzUwhWN2gDsPZUuPXZiRD/8iTUpsjfmf/6/3RTzGDJDm5GTnZGgiFmr
 aFm1B0MxPvGqnhacIdjDKSrh/aPn5mXnR8XzZPrGAA5qJLDpaytBk4C9oFxdbb3IbXeRFiU+Azm
 SvucYmYUmavSXCXKx8Ov+4X87cSstkhcRkAnkFskNtz4MQt28riCLKlCSRXbv71FLYD5iQzo0wy
 F2Wuj+hHfz3NFaHZNRSSEkgq8UOvpKI68asIkgRKYnuIdlBgFhj+FNPAe58/sHonTh+EoEUHJ3c
 rF7Xr892ojMzuiSnbmz8911b+lruGo5ybyv5tISF3YTA0AlfbRoU9JSE3dIRxQbPcfoLE9DE1cn
 I/xMgd1lQEBnESTALPPkODnsIqH2Qa+qlioYDnxEprOGSpb6Kv6J6oMP+3PH81SHTAbpgosdgWe
 CWIfFbmkf7g=
X-Received: by 2002:a05:600c:6097:b0:4a0:1f90:594b with SMTP id
 5b1f17b1804b1-4a18064cf5bmr6446075e9.22.1791337393761; 
 Tue, 06 Oct 2026 18:43:13 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:43:13 -0700 (PDT)
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
Subject: [PATCH v9 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Wed,  7 Oct 2026 02:42:46 +0100
Message-ID: <beec7303891dac21cd620d2a47842f843b391192.1791336930.git.asml.silence@gmail.com>
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

Extend bio_no_advance_iter() iteration to also increment the offset.
It's not currently needed because the currently listed request types
don't have a buffer, but will be useful once we add bios backed by
dma-buf, which don't have a bvec but work with a single range.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/md/dm-io-rewind.c |  6 ++++--
 include/linux/bio.h       | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-io-rewind.c b/drivers/md/dm-io-rewind.c
index 04f3fc8aeb6f..b22719c6411c 100644
--- a/drivers/md/dm-io-rewind.c
+++ b/drivers/md/dm-io-rewind.c
@@ -113,10 +113,12 @@ static inline void dm_bio_rewind_iter(const struct bio *bio,
 	iter->bi_sector -= bytes >> 9;
 
 	/* No advance means no rewind */
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size += bytes;
-	else
+		iter->bi_offset -= bytes;
+	} else {
 		dm_bvec_iter_rewind(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 /**
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 17944e44b584..892ca469c570 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -113,11 +113,13 @@ static inline void bio_advance_iter(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
+	}
 }
 
 /* @bytes should be less or equal to bvec[i->bi_idx].bv_len */
@@ -127,10 +129,12 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 void __bio_advance(struct bio *, unsigned bytes);
-- 
2.54.0

