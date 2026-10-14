Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD2FCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A297110FCF9;
	Wed, 14 Oct 2026 11:02:53 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84FA10FCF5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:02:40 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so5096265e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791975759; x=1792580559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
 b=FqnZeQXqGJjo0oM0VGJeik9n11tQZ7Oc7I5BzgOscC/4PqieoSQY8baf5um4C9N/8L
 /TNYT6WMId+fs480JJI9CwQ2ySrvSKa/0oUG5s5T/Z2N2EswpCHQdeHn0VcclBJdtsb8
 miIsBl4cgihf+R70bvnNtytySJrEqDvsrVSW/XPJgsz/IPkEN62QStKcNcRsbjC6tJ9J
 QrhPmKS6xbvgfwQxTbh0DsH01hon180BniCxFX9VJqCySahx2D+HftXNWNjpi6cG0o8Y
 tEuUtPhLsXckdKwqDc1ZjWas8gOwqinzQMrS4KesY4AGo+WBrJ3oKpg11pPgsbdVzL7b
 t4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975759; x=1792580559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
 b=d8qb5r+HP46MDa2raA+eN9qHogEBHKK8cmS7LjgaDigbwdtMsWVFlUJH2FeH8Y7ehu
 2j8HtM4Zm+1HgP5IktO1zagOV0HtsXa62M4wWc+hP6AChnNc3ZBRFRpF+UkqdlFeH6Ux
 /jbKmv90fCYPDpSWx3I+dT4LsFDLdKt32vGb2lAtyfzNlNQYZlqjkahR+uw0gfns2OEL
 Dt5VVxlby3ytdlWcBJl3RNEj7+IAz6y5MvqZ68Yd4DDEJvqsivNOmGVu7qKEHnCXZGyv
 zMgbnTDJqPFzDpo0xl21isztZXd3zOOWKLk+LLGCNje1Dz7FdtcKGiYFT2uR1GAMYeUP
 qv7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUpoVxkUnlqnJpG75ToLrPAc6DqkIdoWvIE/vrhf24YEUGZ1cmbz44hsUSTJ6qbrxeeDZahy6wXEo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKQUjHJX4PY+KCkflRsXf5e/0g2gBQZ/dDhdZWmZRcuCKhY0b1p
 GOK9cU8fsGU/tKwMETyHvyEQ3EQY1YvmDI0N9Q0fCVL74X8vs4mhfpde
X-Gm-Gg: AYBFou1vDSUTN1qibdw/tOyNe928c5PnAtNhS5oYCT5tId450yRdVwzPyhgAuDRalWw
 O6FOZGY/SQoU/2WPPrYJaCP63qbe5RuD6E+/pbiF23kSuKg7RxClL0UhJeJ3Djc5O3cBSS6Ew8e
 4lofKy+a/WRFoy7y7nNUq9WKfGu0qn0bNG3oA7eqijhEjrU4oyxZQSqY/CKcWXPmdEk1caUVDUI
 trduo/j2O5XBoITr4XEfu9J8Ky42hcGDDm9cXMwe6wGQoPriVZIQoMV8nO1xkJe6Pu3Ns+1DTg1
 YzyV7+1rZWGI3e1u6AXf5QYx/LymkHIJ9anDQ4MKJ77O7UvdEoD9AfHUq306m5sb+YPtogZQB1Y
 tGHSTY/zCLVpD81EtZdmm6rwf11q6yg0gMw96QKsWuw691gUWP5lpGx0CtUJlxIRE8+3Te43iuA
 NkvHgcvUHn7ziPsEYhqFyNP8N9Apu3b8lMnRtfkTeMRkhD322mGBWC+y0mD/PuiXQool7hdcajz
 ix2MU82qvG+ikoMJdFyj0ygcneqmF+8B6oxGw2+YXgsTEN+CfDYFOEkT/19Xa9P64rYGqm8Jrsi
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id
 5b1f17b1804b1-4a18e47aa9amr321452385e9.6.1791975758979; 
 Wed, 14 Oct 2026 04:02:38 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:02:38 -0700 (PDT)
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
Subject: [PATCH v11 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Wed, 14 Oct 2026 12:02:09 +0100
Message-ID: <c73c459578981e64a352e46c0db39ad46621c63a.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
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
index 54774729ee67..532866a1e9b9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1458,6 +1458,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -EOPNOTSUPP;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 9ef88383b363..73d7b1ebf0b6 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -26,7 +26,8 @@ struct io_rsrc_node {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0

