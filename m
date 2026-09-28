Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EAECA5FA9
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 683C110EA82;
	Mon, 28 Sep 2026 13:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e2bIBmw4";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FECE10EA71
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:33:04 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485ac898fa4so2550528f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790602383; x=1791207183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vb+nXysx6Pid1tQCSKOtIWL9IN5+XlO/q6rrI+ZzfOE=;
 b=e2bIBmw4OqBqWs3kG1KARJN51jEN6tMU9m2rQ7TR+rlITHF83wfK/oNmXSKvMlUXug
 z89gC6apico90Wg3fDgBDJGKNH5xG51fOD9E/6f3BDxfDrwpDoSRW3coCXWiMx2vkR+0
 v8ObPuUqWMb/XQo2RsF995UJg1h4DvubQeG2pylFvsLMh2iiXLjCHGfikhbpdyCefesJ
 Z2Sbp5pJF8lmszvL9Yda1Sl9WaAbTqE8BWS8LfRXrDcvFfwm759GnoPvxKjC7c0qaBdR
 a1t5dCURK6fbGKYq7U53K0EjIYz+G57ctNgWLcJVFJlVRmiorfDwyqUCxLXTbrNP9JHG
 jffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790602383; x=1791207183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vb+nXysx6Pid1tQCSKOtIWL9IN5+XlO/q6rrI+ZzfOE=;
 b=SgAbnTa6CAEznIXs0EFer/0qQvqaomMBOJ3F+vakk9mIxecL2QUj6eEDeR66W1kp9w
 p/tP3XuF0gyOQBLNcfdpmaUBABvcThJK9PAX6gz2KQyCpbk7daa+pFboCOzLnb0+TEIb
 VYeeRWFSXFc2gc93YjQXDC484XdJpCzt3CgKkkzq9KVmxhHejCtfCxc2dxajkM1PKDi9
 7v4HsU+wUCXPRpxWBx1Y3Gbcl4aRg8NGiTJe342RJxGwA2tqxIUCQwlnRlBYkEv6VeUU
 bQgoPfEIJESoyL2m0ruji/1XnNdtf9AD9JYa7rB+a7SLfZiKbO4o6Ws3WGBt11m3DoNP
 gDBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzG+zvpSadwCXbNPtAPrsQ5xmfuAHpoTeLAHPIuEftyI0URhpazPVexGOg3D/O3s2jEOrFrxjIDC8Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKsowt4OavRYx4M/k3WkpHsjQZY+J6XiDUf4GeNG/Zyz0U0HZv
 2+kFpKqF2mxW9fWcvrPBaiTXG5E6Y0nEP6O1B4DynYJFDpGbJCguSLFt
X-Gm-Gg: AYBFou1EJiTTMJP2Op+86iAM/j0y2kwMZ1pDfHIxMxCya+5fuFPplurqQCd1HYjz33H
 hsTNNOHrk33Ny5IZy0f2FJ8ZRBfirTsXX/VmsTMCP9Z02sDOWz6YtbCxiRqZn3fj0bIBlrsoWjB
 9mkTBiJq9LI6QllVOvErFnrbNFP6VDexYqDKJAg5pUmGMuhlLwhpK0zNwoI5IyDcz6F7lj6Zhny
 IjVHK8V39lWb2B6rVa8y9ioBDHgyhHiJEO6lAmDIXiqENAprokftF6riU5+BOrag4OH9F3lJ3TS
 ngBWsBB8P2m/2J405Z5LqCZtnQHr2D68DwooPBeQKBjvWZzQllc/8MWjMgdEaExaFUWpOEwDNsB
 p+P08yEtcigFMKmUYRwxI2YA83864/fsr+kcKqPR3AEIDy5GOCTRaNoW5ceVW3lxux+7V4auCWN
 EKUKnEYm1nCn2FCNoA7ZJhuZW+40Cg+tKAxR8UPIITnG6D7LzxxsI/qtMjeqwXzoUWWAOaNNGN/
 ZM+ik+/Zrui/u88FgecCDOGbECJYDm0PynrUQi1vhzEb0aR1ycLAzc0vpu+dGRY9olmgvkzT13D
X-Received: by 2002:a05:6000:2893:b0:487:10a9:57cb with SMTP id
 ffacd0b85a97d-488719756c5mr21965332f8f.49.1790602382736; 
 Mon, 28 Sep 2026 06:33:02 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:33:02 -0700 (PDT)
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
Subject: [PATCH v7 12/13] io_uring/rsrc: add regbuf import flags
Date: Mon, 28 Sep 2026 14:32:28 +0100
Message-ID: <692972b0ea345774fda580a53e2b1bbe5f771aa3.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
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
index 65d6cf7201ce..6f6860d6ca03 100644
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

