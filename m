Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B11ACCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FED10E3FB;
	Wed, 29 Apr 2026 15:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YQJhuC6W";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6EC10E3FB
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:26:19 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488b0046078so114871945e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476378; x=1778081178; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G9kqbgnidQC23bEvrBAVDYa4e7L0vOouqvUY0ysfe8Y=;
 b=YQJhuC6WO4DCECoPgWYklhrt53tome96fPUjPq0BN4iBTAfICM3gn55fqjZs3HOsdK
 2lwJkhIFfJyRpwAFb1mzRrZmjT9makrbgOfW7E8/VU5fI0/zDj63ljB6XhcnkXsa0/RO
 y0ATGXDRrEjtCQNAvO24cCn6O23FThVGv+Vxh9KlZ21qmsGVnOKlwWzyAlC6octEzg76
 rLTjkIWNY6JqYFUDutrD+YJH1sgfqzu9GFT5gnp80Aw7ksP1TWMMoJrwJWmjPAtlLCoT
 YOHKlN3Igd1hHJPgJXjxny+KJ1IiolrCtXKaCUdbmjXoo4UdzeFk8J72ZzG8jODD89u6
 GNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476378; x=1778081178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9kqbgnidQC23bEvrBAVDYa4e7L0vOouqvUY0ysfe8Y=;
 b=kYD1lZcrNx4vGME9F8kHhMp2nWXavq0UicdOUCsDP4H1EmHj/tMRHCWit0jCfAFdI1
 ++Bn84wry7NvGqs73Qmf7Wbl0X1GlWKgUqdrncMh0mjKNWnJmZQLQGRdoZOdp/lxmEMy
 VoNFDVghT3tH7QyYrFDxnSfs2oRFWBDzlhdMAPc+krEWURH5+fCJ5rdWgIGoF20juLFg
 ycNUcrqX7mxCcvk37JL7YtDvsAXNOA24arMfFNMBNpoQa0EWNsiEZSH7gnhhjFoZNJRi
 p0ehqs4atpQHIJEZ/fOTxCSL4q+t9VLAW/gfuknvJ0hRhiyP9nI6Jpbo3S0OkOy6ZqJb
 nqdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kzyYxYJ9ZkFlR/mJUuV3kJTfW4HQMSiEvdVQAXLazuMUgoh29yIh6KIHBw7IcuFfjlv/Y1ilAfs0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzdep31lOZ+icgepQOFaiqE60yzQvcMrs4HXKqAKBRjz+2EXtTi
 FiJ2C1NRJrH4PehtBNGa/ZwZ/9s70nNgPVNOHPewQLwy+dPoO1tH8TtT
X-Gm-Gg: AeBDietvGMdT9TYV4JPXrY9fnBuQjAbpK3QyAHJd6d7WY1nlKI1GgmS5PwL/KKHX/rI
 a3ltGicrztaDEZycOvx96NQb4MV9qvRhaUjM9nzrbRN27XhZdwr99JBUSQy1yeKaprDMbaANExD
 9J2L2xUel0I8eCKKUdktWwihFzk6lM+U+Jn4PoJP3viSwnWZK1rycL/xvV5uWDgOhdyV6M4oiRr
 4IHsQ3sPxml2cQ8EBRQFwa2Lqe0jIh8MxWwLPEVSq6xKtXoJoOQHaajOuX+pYTh7PYVh3PMQ0nS
 dFgugJw6tdQ3ea+zniwTD4XUL4/2d7h6NJew9hZNPn4Z2oovNWr/BYPdJfEIeKkfc9KiJZYAU3R
 AOD4sC8U/pP6SxpaTUdAob+fixogAvpRerT4pHrHC6ACzfHdi1VBx0N29P1/OKINJY4GyfsKb9J
 whacgliM8ZAmI58IrqO2S22FFhfZcds/MBICSadHVLG7+iuvNpmWKgy0NT51+A1UdbP5i26Vy4f
 FWhV+TCq3WYET9wQYcwRL2KaQuEX5JGWLDB9ypmj/JJ
X-Received: by 2002:a05:600c:4f92:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-48a77ae5430mr125646225e9.1.1777476377153; 
 Wed, 29 Apr 2026 08:26:17 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:26:16 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Phil Cayton <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 00/10] Add dmabuf read/write via io_uring
Date: Wed, 29 Apr 2026 16:25:46 +0100
Message-ID: <cover.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The patch set allows to register a dmabuf to an io_uring instance for
a specified file and use it with io_uring read / write requests. The
infrastructure is not tied to io_uring and there could be more users
in the future. A similar idea was attempted some years ago by Keith [1],
from where I borrowed a good number of changes, and later was brough up
by Tushar and Vishal from Intel.

It's an opt-in feature for files, and they need to implement a new
file operation to use it. Only NVMe block devices are supported in this
series. The user API is built on top of io_uring's "registered buffers",
where a dmabuf is registered in a special way, but after it can be used
as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
requests. It's created via a new file operation and the resulted map is
then passed through the I/O stack in a new iterator type. There is some
additional infrastructure to bind it all, which also counts requests
using a dmabuf map and managing lifetimes, which is used to implement
map invalidation.

It was tested for GPU <-> NVMe transfers. Also, as it maintains a
long-term dma mapping, it helps with the IOMMU cost. The numbers
below are for udmabuf reads previously run by Anuj for different
IOMMU modes:

- STRICT: before = 570 KIOPS, after = 5.01 MIOPS
- LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
- PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

There are some liburing tests that can serve as an example:
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v3
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v3

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v3: - Rework io_uring registration
    - Move token/map infrastructure code out of blk-mq
    - Simplify callbacks: remove a separate blk-mq table, which was
      mostly just forwarding calls (to nvme).
    - Don't skip dma sync depending on request direction
    - Fix a couple of hangs
    - Rename s/dma/dmabuf/
    - Other small changes

v2: - Don't pass raw dma addresses, wrap it into a driver specific object
    - Split into two objects: token and map
    - Implement move_notify

Pavel Begunkov (10):
  file: add callback for creating long-term dmabuf maps
  iov_iter: add iterator type for dmabuf maps
  block: move bvec init into __bio_clone
  block: introduce dma map backed bio type
  lib: add dmabuf token infrastructure
  block: forward create_dmabuf_token to drivers
  nvme-pci: implement dma_token backed requests
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add dmabuf backed registered buffers

 block/bio.c                     |  28 +++-
 block/blk-merge.c               |  14 ++
 block/blk.h                     |   3 +-
 block/fops.c                    |  16 ++
 drivers/nvme/host/pci.c         | 282 ++++++++++++++++++++++++++++++++
 include/linux/bio.h             |  19 ++-
 include/linux/blk-mq.h          |   9 +
 include/linux/blk_types.h       |   8 +-
 include/linux/fs.h              |   2 +
 include/linux/io_dmabuf_token.h |  92 +++++++++++
 include/linux/io_uring_types.h  |   5 +
 include/linux/uio.h             |  11 ++
 include/uapi/linux/io_uring.h   |  31 +++-
 io_uring/io_uring.c             |   3 +-
 io_uring/rsrc.c                 | 266 +++++++++++++++++++++++++-----
 io_uring/rsrc.h                 |  30 +++-
 io_uring/rw.c                   |   4 +-
 lib/Kconfig                     |   4 +
 lib/Makefile                    |   2 +
 lib/io_dmabuf_token.c           | 272 ++++++++++++++++++++++++++++++
 lib/iov_iter.c                  |  29 +++-
 21 files changed, 1071 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/io_dmabuf_token.h
 create mode 100644 lib/io_dmabuf_token.c

-- 
2.53.0

