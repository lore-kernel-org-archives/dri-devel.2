Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDC1CA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6979010F450;
	Wed,  7 Oct 2026 01:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="onvrFmlO";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A5010F450
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:43:30 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49e73611928so8953285e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791337409; x=1791942209; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=;
 b=onvrFmlOuEYFQ03ef4lfstZmOt6Rb3hc3B07+k9eVbtv4iZWLR07q2BhRsAPl9ck8v
 FQFy73uoCZRIR+fiYuEkrnNVBUyYAN50E4v3HX3rGExs/V56bYN5PjvIjW0cGQOyi63K
 9XUOQ9yNZraTKf1sHEbXO8F58lnKhwiioVQkBVfw8/EiXKlmzRRwMGfEjwageEgNhwxz
 NUglTYKVwMKaw6lez1/kHKPGuZZTcYPXUhDkKd2AkN/vVK8XkfuF3UGcZrko+IGqBONY
 biGt/2KNsLpo1wcsKmOvbbGbTlRlWDJK8LjY2q5xNbgtgV0KfzgyNJzDtNREgGZzVsoW
 ghsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337409; x=1791942209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=;
 b=YaCbidbD4nIwJvfEd3Ptd9PBhczqFm2CoUjRA2ugH++FNH8S4YBlFrDRvIBTzIBzTQ
 geQ5PUhoJg7rCgqmNWc3UJ9/1PTCsc2yQYxKde7efeYD5bXyaY9yS6yauBQ8zFM++cH1
 oCl+RfhXhWRCjtJ5MXusNKXZxftyZ5iIZBpo1Z/nR+VzlOBbT+b2VM8QgZN9+yBpili5
 sm41ZapmnP4stjMIEFauItecWosV2/PQzioibMK225ZQidIucwgO1H+vGYUt+P3y0z44
 tQq38oYcD90KecR0teEaGFdWuvWc8l+WHsazYSvmIWlO/xWNUeTyXdK/cjg7nTUS6lV4
 uWww==
X-Forwarded-Encrypted: i=1;
 AKwUvByim9dFCF7FKdGmTYyzRJtyhgVc3Imc44onflFz52LqtyDFLza9PatCqHSGzbEUP+Wvm3Sb0atMFbk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mDjXTELaQRq6SlZvq+zO90ltDQOvo20xmhZ8Sq/9wffDrLXTHZ
 J5aE6uOKC4Is1ojMy0QZW+X/xJ1slcVVB25zV9BemvJdr48S8YciGjpn
X-Gm-Gg: AYBFou2oFMx42u2RhJJVOpbORelvNo9iR3hKV9Tr4sNWVaOcBsXbicdNOkPFWrDLX6Q
 tWaVZfdFvixrLANoFNW69fAcx22/cewgOZttvZ+Vej6k7UPTN5/eRhNKl9mnQ+7e356aEBMDiFt
 sLmCjcvb8J/Bz0kLXGE5+NGj/ZjUb7t7AbB09dXzYYVrc5rkFLOTqfJ9zqtL697g5O0baFJcko7
 pXj+pvazTz/A4/uw/FELKtgYaJNvwXmr/4vk8vPqISoBeKPB3/CbryoO1JCJxTgim9Sqi8CvxC2
 TFubqGbfYVOYwPjF0IuJEpdZ4QZD8kz9+oM9T5dk/JvWd91Zgwtv+3wjAKs6osMAiczuv139BiU
 mABOkHsDCLQWhVlIbkxZwFstOVmEAPKObKDSiP5xX9/bIAZeyLzElgGaUsl4xDxMX0cr6Ksreub
 TgpfVBc1cRZnuLC2Its7IuZACpSIZIX5/ZTlQx7KTZSMZyQrLf0QqFEaD9whnsNkn3xQRJoDc1j
 S/EOq22F4O6TTj1e+viBMO6NsbqhegKtIB5UYzgTcK879VDMKCcFfbhpK2T5/xUTLpe5nsxY6TG
 ZLQRScP+BLo=
X-Received: by 2002:a05:600c:810c:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4a180422b6fmr8853055e9.8.1791337409336; 
 Tue, 06 Oct 2026 18:43:29 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:43:28 -0700 (PDT)
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
Subject: [PATCH v9 12/13] io_uring/rsrc: add regbuf import flags
Date: Wed,  7 Oct 2026 02:42:55 +0100
Message-ID: <97d5632343330131e3de5874e482ce5dfa341f99.1791336930.git.asml.silence@gmail.com>
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

We'll have special registered buffer types that can't be used with all
opcodes and need special handling. Add separate flags to control
registered buffer import, which will be used to specify what kind of
buffers the caller can handle.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c |  8 ++++----
 io_uring/rsrc.h | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 6930a6897b41..6e4fe70b316f 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1315,9 +1315,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1731,9 +1731,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
 	return 0;
 }
 
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags)
+			unsigned nr_iovs, unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 	struct io_mapped_ubuf *imu;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 73d7b1ebf0b6..351995b61e68 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -62,12 +62,28 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags);
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+			unsigned issue_flags, unsigned import_flags);
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags);
+			unsigned nr_iovs, unsigned issue_flags,
+			unsigned import_flags);
+
+static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+				    u64 buf_addr, size_t len, int ddir,
+				    unsigned issue_flags)
+{
+	return __io_import_reg_buf(req, iter, buf_addr, len, ddir, issue_flags, 0);
+}
+
+static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
+				    struct io_kiocb *req, struct iou_vec *vec,
+				    unsigned nr_iovs, unsigned issue_flags)
+{
+	return __io_import_reg_vec(ddir, iter, req, vec, nr_iovs, issue_flags, 0);
+}
+
 int io_prep_reg_iovec(struct io_kiocb *req, struct iou_vec *iv,
 			const struct iovec __user *uvec, size_t uvec_segs);
 
-- 
2.54.0

