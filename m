Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD62C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D64210E7B0;
	Mon, 21 Sep 2026 13:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EFfYTK69";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8EEE10E79A
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:40:03 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so14795755e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789998002; x=1790602802; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/FMRvm1BaZ6kTlzIVu1IAGTERBBcZPL0byDe3SvrYcY=;
 b=EFfYTK690ZOnxvE0++MfJDdkj3vqnlivcq3+jFqrzFfEgTACSpZgCqPoZi2E3QckUz
 PS81yl5lhJAjntUKelq36oIvd0DR6/aUq3dUhoJS5AiH4M4AjJuXuxRxDtwvqKtPmG+4
 pRlV+1eviOQAv15q8GBAzZneOHDGXxhPrkS7NiSqrpoc4h9zUhfMXDS5ms0HyBRpWn8v
 R78GI2PG9cZCrsyRM4ZbFtk55GqUpZLJFR1+DNJvyb7evYLZEXViRO3o7+IBbs7gf7pm
 rOwvTWKPMs3MD5WNFpew/LrLOz+WOWuN7vKPRVXMvGC0tl0M0WQiaF4EmJOsX73tNy04
 Am9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789998002; x=1790602802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/FMRvm1BaZ6kTlzIVu1IAGTERBBcZPL0byDe3SvrYcY=;
 b=iOI8yXgfH8YBK6IOPYVFhwG1USV1golKrSAYSLv2pWVYdcMY0VLMQijfh311EjlL7D
 cStVSllCSOa2ZiNsywXAZVe1TDeC02UZpnX+4M613Vm/rZreQSSdZU5NacwtWt3mlkBg
 RgmtoDK6aal/n5/htg/pY2wEFiGzpuAuBpR56oWZX+cQWUB51Mhbp9M9oK4Gje7CLY2p
 0RowZ2nP5s3xYiveMm+nXrcKSVp8O/jPNR42/CXhcsIee5ePTroPOFXvey+8qbgQDbr2
 GoHc82EVcbCrc61HTfDsPt6pWRwSyw3u05zq50xr1LddTbW2FbS7ob+ysHaaTFdPYpgm
 TP1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0LJrbtzGsp79IWP6C7AUmi8zlvCOboFsxpxLd24EUMg6havjEHVmOLIdBfmDjGcjxmRuQYnPPEOw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nwp5+Ai/yNNtBx7pTI2kSWMlt9bJ6pQpYk6z2cDUx2W4klyM+1
 BPfgkQhv4BoB6iEyn0xdOuwcne+lX2uw95FqjHJp8Jsy4ubhM/nkrM59
X-Gm-Gg: AYBFou2I1PLMkPR6BBybxwU7eWZqxWivQGSsoVvusrRddfzjZC/aa7RNxNV6AIQd18T
 uTHSGUBRfglQHJyqyncTtG3QL0kNalOO6QrbLrGlyIW/Y5sr3JciN1ZULyGph/yu5/A5Ydvm69G
 jtQ1JrLZQ7eRLS9yURW1/ZxEKBHu0MHKGbuQ7VtRVaBhOilpcKULlH7cpvaavFAQu7L4oMXyaeJ
 WNnxeaoc6ZLJpwASwIhpSRuoPQ2gBcUqcqDeK6GXoQcuISpqkw6S0uHDnY7oXfz//qSOZPP1CMc
 2zDDBOCsm7W9RHlxwmC0b8gToXJIzPoyc572wbH53j0G2XrbDDE/pp78YDIv2cg26YEHI7AY6FZ
 u3Bysn+Hlk0AEEUIko2ZZ89y+I1X5DYL/xrQhj2nMXdaqJNZ4xvwxvR/NXsWu5ZrY+G3oXgWRBw
 95p0mmJYakMZIM+rH77/MYQkPOinFMRD5HFzPnMoq/ORCoGoShbPpqGest0aolsVuqasAhdfKTd
 5CE8F0J+MVBrzD8zrTihO2vAurgAnfzXcMbJXrSx0zDwzQC8O3a23153XO6t0P4P+whPSHghM6u
 M1tctGDqYWqSKsv3bNt1h0jX4f+13A==
X-Received: by 2002:a05:600c:3107:b0:49c:ff9f:f6b6 with SMTP id
 5b1f17b1804b1-49fc5669346mr153997265e9.6.1789998002057; 
 Mon, 21 Sep 2026 06:40:02 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:40:01 -0700 (PDT)
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
Subject: [PATCH v6 12/13] io_uring/rsrc: add regbuf import flags
Date: Mon, 21 Sep 2026 14:38:56 +0100
Message-ID: <a7b154185897c7cd23de143f5bd834ef73cd7723.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
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
index 0b526b094dc9..79e3c686ecc1 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1298,9 +1298,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1709,9 +1709,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
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

