Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621A4CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83E010F9E9;
	Tue, 13 Oct 2026 20:55:55 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843F410F9CD
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:55:46 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48af27fe287so2974083f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791924945; x=1792529745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=;
 b=Ny3kMdgsRr6vHLDZFejcE9YcIzBFPXYx5xmeFgFvF+QB9c6uMDAh6cYtAE0jH9hknN
 /vAruQtloKRa6uEbkSVwmRaR5YeI0D55Y3MFqgVKKTZw2RZ6kIiKuUiqVuKcktQ/gxnp
 j4dsnKXKv2w7kdzgyUnF3MMSYD0WiRyPYeJizJNQ7jf4iAIdB/ZksxktGbcpM85el1xg
 +8AFNuJ7fzsRvJsQI0TTExIhzK9tsQg32Tlc5EN7K6mwBaRFE68tchbg26T4oXVzzYhi
 IkCs0hN5F9+RSzjIA7ZLpk//lM7Tu2xqc2bp25N8h4HdQW32a5cC8ucE5YdNRQ5RHM8a
 L8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791924945; x=1792529745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=;
 b=1ZyhpgRdm7PRpXQ4uJo8aCasyl4zeugo4LObojuCoSQJ8g3Y4FzS8misuJMkFddt0C
 XVsrrAZUBZigNWh3cJU2q/UAK6FPn31Xpqg1Sp41vSFpDPooZOV0wZ++X5deANdJt8ns
 yW89NNulv1ARJ7QyI8GXpJC1fMHhVXVbYf0kAk+tC48zJmpN1JvIzwaIKSFDp8YcO0J2
 mKNRoHFkuhpTFin5l7U8jWsPARdehVS01fTT9B29Ru/l4yDWx50Rej0Dtu9pZcSr1Q2S
 8BLF5PLvvRhDE4Q7WfPsPGADSic2yJTPmIaneT1Vl9Si4wrJUF2vWVHBv/j5HMnffSgs
 i9VA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxE5NBZOBjVT6/Xz9OKUdGLXprGxnfJRAfkxvPk/Ty/QPhm3RpNhFmK1YIvEcTdiCj1QQF/zb2fiDU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJZ3HMjtX9V0zMoZLGfEfWPa6NNzwha40XSNK8hEv2/Fw6vTwpx
 vmqWWipLub3XXEBOTzYR3dOFXbyLlwpiwyyOJUappAEQmr7Gn1r0uqBC
X-Gm-Gg: AYBFou3nDYz6Uezrs3fG1QKKKoz2SSqknVMVqALfRBeO++kcMknuG379jN5FEmLcK6F
 WKpMYG/XIEehrCuH2yDzLNCDh8QmkvjniHBdDxlJh3gd33jRdrVnwBwHGrrt5ZPxRxWsPCYPUKF
 kifQJM2n7+slC0wy0MxgnMhWTR1w//OdZIWA+UhO59sjOt1LTTLB48iUSFyOP8TBIB+KggpbBK+
 ed3cI5b+GXhEjMseApEgLXDN3Ko53burPJbPsfyuMd5U19tL/YxRMJ5uCRXJOTJ4e9yf5meHulY
 Ds07UsN2irA2GqFKp0I/IL6njS4v+Ltt3KvmdW0jQYAXmtBM/9MkVaHakGYBnYyFm/cCSI3fuvQ
 8/HV36R+M1x42u2m4BbfgTRnTIrauOhcMALIKwB2C1/Aegk9FyRdmQJtmdxiKRvTqVU7Ull0sbz
 hkEmetAqY2hqSJBwLH/Qor6nI/GyPzROFwa40P9rgv+U7cWSdeOmuh+OQBN+jBmd1svTQPpwHVK
 o2zLXcLT2AOxuNQfZ2m7qZvC26kc5JBZ4kj4d1C4/jUHKTgPa7+HIq5wr+tFCXYZmTkI0Tpxu57
 +oc3WKgs+M0=
X-Received: by 2002:a05:6000:27c6:b0:487:27f9:82b with SMTP id
 ffacd0b85a97d-48dbaae34e3mr16754768f8f.32.1791924944821; 
 Tue, 13 Oct 2026 13:55:44 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:55:42 -0700 (PDT)
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
Subject: [PATCH v10 12/13] io_uring/rsrc: add regbuf import flags
Date: Tue, 13 Oct 2026 21:54:56 +0100
Message-ID: <4b7c13d9860640499460862c8cd4a13602ca174b.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
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
index 532866a1e9b9..f42d201738cd 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1317,9 +1317,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1733,9 +1733,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
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

