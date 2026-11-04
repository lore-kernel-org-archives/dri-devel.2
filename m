Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A58606A331
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pNH9yBLX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA8010E472;
	Wed,  4 Nov 2026 00:19:19 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6898410E472
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 00:19:13 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so7564985e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 16:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793751552; x=1794356352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xkQ2a4rr4OfVHQ6kuJzVvVdC31NeQtZjjZjX0zJeTWI=;
 b=pNH9yBLXWUs6FUQosBi/r9imjMu6zu/tUXyo1RXwChwdwza8hloiU3gbW24prX3ZNL
 XKsRp86rKY/mV1bpdfRecOLHaDybFqIgkJomBJOcckt2lVI+3+D69XnKm1JcSw/5Lpea
 b+BILRNrO5GUTfESZDMHgBOU/ywrerAkleV0dMA3c2EMcg7c6ac6s59QvYmY55IGzz2t
 4PD3htx1htdrTlZXxO8X+piCaV0LWQ4WsVfoh0jctU297YBPGVwtL3qm6j3xXAQ2gXSA
 FXh1Az4OWsPvXgTL/V9K9B68AIPOi7AxQ3fi1FYp5pagdv2QF7vH0guYR545vMNhXuCS
 U38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793751552; x=1794356352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xkQ2a4rr4OfVHQ6kuJzVvVdC31NeQtZjjZjX0zJeTWI=;
 b=O7clAbx/rn3NIUiJ9pcDEn2j6QQxkxwahQMEHCuojsB1HqRteY2WQ4Pkr4fHby5wLZ
 LXmSHk4cxOGjw48Nc1sRHTM5SpW+JGoWQfFVFg8Fun0T97bM8ug/iXZvoy4qSJAAfJTy
 HtEvTHCJZSV4bGUJ68MoEjtzA/62G243H1ab7LVDo9KsJdTw0y0VMnHB4RYP0DKv4EXO
 NYSggjGu7xtqZ4bkuIdqSQmGjx0HqTph9iQbFjwDZE97mKOBZv1iUYVXIcrfRzalUmdz
 LKorcaD1RWg11z719bqWUYZjMNLTaUeODXFQDTpzqCSUwpwDIHCt7k6YXprHZT85WCXi
 PyXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQRgz2uCQvvx4gltHE1YB2iSujiBVtOm1y2VnBV5LE2pvLuoYbc6uy9mzERc9BSVFI3S3Fi3c8UJw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Pw3viZlhOSaSRdm7v563ZduGF+1q1oTGaUcFZGaTqjwJj92ox
 ObwplpwTbRE2bmM9VXCcBL2781nP5SQ+eqnAyUD/sLF93QVxzQ1IEliR
X-Gm-Gg: AYBFou3BNDNanIR3Qe4eAC0yu3yhk04M4ipoXgKu1hl3d8GfoJuhXd7jRuJvZUmpk3j
 iX87jcQ5QDXYrngViR/V5HJ7GpsiZlS0hQbdKg+KJchsHThqkjQsMrOndPqeCC2B8dW3p+Ruy+F
 Ype0eOZJLNcQ07EfWXO/oOwLWxx5AKYf9mDpS+fbUtsZaRRqZ+v9tXMjqx2k6sptR8hmX/Tv3FQ
 h4N9XIp3YNB4W6VtxTqbhEReSJVw9UUNYxz/y7OPMeVizJ3/z5C6L1S7vQSvC0llA69J1emwNUX
 Kh8wpUVWHRzi9Hlbmbca+eyNGsANAZOueifzZFFK9Lg49R8r5cMylWcM/VFp0fCbI16XABISAKe
 g0O7bFe8j8sHvK+TuYNVFaiAhcB8tXafHhc9kWJKT8G6EN9p9EXFt1PfouRbatIa3eD4V6VZkEe
 +sQFejkSUV6ncjukoRQfUMrPGCsExWUZU1n8Qu++SBP58eqt5p2qLRNmTAgaBbMec4ohzAbVMeR
 hzWEW0L2u8ec+F3OdLMmxEQCVxg7zWzIPiqfn0KXCPOGA1bSi14J74rhZLt99Q3fduWC81+nkX8
 7O236hyPkCjH4g629symCUJ8gvS4OgadSKGJU8D82qAYrkos52jCOq8cZDVN1g4oH8tXfD1O1oZ
 Lx6zs2PBy+37dVwvzXuxqRieeI4NgTPG1
X-Received: by 2002:a05:6000:3101:b0:48f:bbb5:61c2 with SMTP id
 ffacd0b85a97d-48fbbb563a3mr6701949f8f.4.1793751551597; 
 Tue, 03 Nov 2026 16:19:11 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 16:19:09 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 0/5] allow dma-buf-io ctx reuse across files
Date: Wed,  4 Nov 2026 00:18:56 +0000
Message-ID: <cover.1793751001.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, dma-buf maps can only be used by the file they were
registered with. This means that we can't open a new file, even if it
comes from the same subsystem and point to the same block device and
use it with an old dma-buf registration. That would be too restrictive
for upcoming filsystem support, so lift it now and allow reusing
contexts between files pointing to the same NVMe, even if they refer
to different partitions.

To do that, we add a tag representing for each file, save it from
the file passed during registration and use it to reject files
which tags don't match it. Tags are set by subsystems creating
files, should be unique and represent the instance of the
subsystem.

Pavel Begunkov (5):
  dma-buf-io: add tags for sharing ctx b/w files
  block: set dma-buf-io tag to block files
  io_uring: add data to dma-buf convertion helpers
  io_uring/dma-buf: switch to tag file filtering
  io_uring/dma-buf: get rid of struct io_buf_dma

 block/fops.c                 |  1 +
 drivers/dma-buf/dma-buf-io.c |  3 +++
 include/linux/dma-buf-io.h   | 22 ++++++++++++++++++++++
 include/linux/fs.h           |  6 ++++++
 io_uring/dma-buf.c           | 19 +++++--------------
 io_uring/dma-buf.h           | 24 ++++++++++++++----------
 6 files changed, 51 insertions(+), 24 deletions(-)

-- 
2.54.0

