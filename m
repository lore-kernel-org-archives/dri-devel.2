Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3501BCA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B34710E4B2;
	Wed,  7 Oct 2026 01:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ILryark9";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E2810E4B2
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:32:35 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so13206225e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791336754; x=1791941554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=;
 b=ILryark9zKtSfID89TrbJzxY8OaN60PM2Ed7wfbtGvn/YgxEJ/EmK/6CuTY6VaalZE
 xR2ZXRbZMyM49So6TxPl2RZVh0xn1s4ewne2A//lJFO1EYMqiJvufJs3JakvZlR97FR8
 FhM8q/L1pcPruQAB0lJaDBVnJeP/Z/inuoX+dINCU9lhg/JebR9KTaL8zc6wwoRmyaeL
 UnJY058zU9BezQUwdoYB+i1JOb+9gAXfHg3i+6w8Wh8+KHmnUAhUxPYpEoKyLBiJulJe
 njAOQymes21X/h9uiKzxWcKYIiQDZH68c7Vt0PQSk/XQGqnH/Iy1FdlEoOzF9fwy7uoD
 BD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791336754; x=1791941554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=;
 b=i32Up+UgQO+NkGlpR2WYnY4EbOY/1bNw7smw8x9ssbyZLy4gW1X1Xz2EAlhldPVDjc
 2eDiXUkHw+yH8PC1kJ0+dLYFmKPFOLG7Tk4eEIqTg7yilWoOuOqIxgpeu5+FlVGChY4Y
 LNhdLQXpnJAYwmt+FEv1P19qKvROSeJuKpp4rDu3tn1Awe2Wk5LfTAizpkGwhtM6rwfi
 aR+zCfbkvav7p5xyLSCBa8nmZfo4KrCfMUz6OSARGGH0/FtcVXHXELynhCtNpzcOX9V+
 kwk/p0ypS8cv+VaQbFU0QEIzuqH35dCMCFDy4Sw5JutZ7rsKSwB/4xjYXPJ+k48xspgJ
 eWWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtyxCXzxbwmW6lNkhOKq1AgVOJVYBS+JtkN3pUacHHB9T0xmscM87HeqZrGv2FPEIk0vGwbqEeP1k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkMTTXisZRIqAqjJcjAU5Y/0hFXuniU4jUrwp97LhsUFyRR46y
 IpelfZH2ywnRv6fDe8W6u+JT164TIulRkKQzD5f72S8+1LHiY1eXCqHy
X-Gm-Gg: AYBFou1s4TbCc6NTUcqI7muQJek33BCssPnJIhvUaBtVLyKCESnK5HWjjSZNR+QyW6N
 TaLL4GeKJ9v4T3h1EZ7G22dkwwFhMHbZCpPpcYXNO5I3Cpvisb9Ovfp56nNdGpj2sFHUOsPDXN8
 MMWEri1pwmSKSEJz/q4H8SUEzsFd3VGejwGHPh7rzT6ckVc7bF2RGp6erjbN5lthUmictistrjc
 ZpQ4P9OZkDOrsowHctI4DKPbQtIZPxEfl6mb3XTXGryjNBWC6OATMFU+xYYlOTsh5njlbbXZhRo
 ZP6OSyPjFXX03nDSI+ZlLnU1E/2qMFmVqCY0YEZCLntWZjJNuldRbrbqLHv4QCF+pz1yVpEEA8k
 zHDFT9tnVx9IReffd59EFbbMhyWZAvTTaPs6sKS/a+3brHVkTwtTKQHrUXIxhAm2heL0CDL48rj
 D9BYlfB6/vNSdxy3m1+qtEzhKdM8TPt73WV8QNoxreRGyWbAWWWCHb2b4zJJSeWpGBbfMnXkUGM
 V1iIOUh8ibZOhWAl1DYDHLx9Kcop9Tu3212gtXbI4DFyWbGWnaqQrV+TREQ/QpDvhaMcn4M1ne9
X-Received: by 2002:a05:600c:3b99:b0:4a0:1c10:1372 with SMTP id
 5b1f17b1804b1-4a1806501eamr8969125e9.27.1791336754109; 
 Tue, 06 Oct 2026 18:32:34 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:32:33 -0700 (PDT)
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
Subject: [PATCH v8 12/13] io_uring/rsrc: add regbuf import flags
Date: Wed,  7 Oct 2026 02:31:55 +0100
Message-ID: <4a4bfd9b4e444ecf9025e85b5cf0f864aa45c139.1791336002.git.asml.silence@gmail.com>
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

