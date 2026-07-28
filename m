Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDB4C54F51
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB20810E5EC;
	Tue, 28 Jul 2026 21:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gzcKT+KK";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8644110E5EC
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 21:29:43 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47640541585so243304f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785274182; x=1785878982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d4R1Ta7J5o9QlsZRJQtTe6q81OAsfZ4+yoYoEv/KCR0=;
 b=gzcKT+KKCccwY5OYmIZsKOobCUmxcp0+S0eslR4hSCde6ww3yRzzH5X73slWK1fSjU
 ur3JKghRrwHPbqhyMV8AwHKvvhqQvftCdo+77QdpK3eIWJ1KX6fRSWC3/zC0yvXIBYd0
 yG9/rVs/GbtuD4nqXzUWUk3nNdmvEBjsJn94zRpUF1WX4EKFakRXGzdKeRq2jVa/fEOs
 NqhOaRlrRbsDfO1zHM+AG9eWaG+UCMFa1XzloPbPjQ5IDoYEc6Zsy+V6xak+4hh0QDX3
 LPQSwvQJ9dU04RUYCqsT0dsktuinyWtzzkS/l6Vq7/U9+KxMzTZMPiWkNHOLCXWoUN1X
 yEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785274182; x=1785878982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d4R1Ta7J5o9QlsZRJQtTe6q81OAsfZ4+yoYoEv/KCR0=;
 b=JIJOvvuSg3HZBcup/rOGsZcDVp2OH01CyVC9rx6Iaj0DVttoqVQhuoKvBiYHYbWZEQ
 L1yZa64RS6JzB0dLJHRdVnMV4arWg2wvUQThY2SEqv9SEfiyuk9e64RMnuDbZ1OSiIHO
 Ntzvlm5sKjKb+WCEK1oS7d8eGH+XXCXRDMdohHjAG5JgLQwKQFiU6WqAWzUFYRmhBNyh
 l6yT8PzdYL+5K6pBT/C/MCPzs7zea3I2ToMdjsHHNHc4Q9Tm4SgRAuSHg3AEn29brzXO
 nNpRaKFWFhiVFFh4CRD/7Aj20QrhbdGfgHj339T/mY+eoJsmxfEoeWh3+n96HleJK/P7
 ew/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqABdNpgxZEasc5AJA8uxAgGdlZ2BED2ROOnBx6STQatWCfIJOUuE8cfl89HTcxmaTgObGCjfXg3ak=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkFT78KEaAHPyIb6M4HaoMi4PlJFVJH5kvvSWC0hczf1cUQNxQ
 SNnksNwkRpuOTaidYvA7wKOaOpz9nhPjTWHRshfUQImtj2g3q+kdHC5p
X-Gm-Gg: AR+sD1387i80g4RwvwdXH+K+mQRG8xZKRdO6oJ346uQ77j59YhyBDUPp2YvQPQiT2LM
 ZTdHsv3is51Gan7nTmjz5f8/YWC6i/4Fvg604qiAbXjFKGLYfd1NMApHJvVtqe5Mwrpq7WHhBLU
 dBbJMS9CGX1mh+akkX6MC08Ddh6KzxknaZcZL2SVA/drSPezYNfd7UpDdupL22mZCkBhtq186Q1
 FDfuIGpIDyVR5Vp/wDNG8CWrMs4JErKKoVR9sr18FM9fgaooHiGhrAU8RJk0gGKzrtbBO+laZmK
 uneub5xb6tujCB6XH+sbgF3rgYDg5uejT8gaifObE6tGzQq5SWE44DUAd3RxexCHYLZK7B1JIch
 d1bUvdJdBh/UUSjcLGJSSDZmwbyKsqsbCNbAKqe24Fm7FQ8BmgUjo4v29VNW2EFxXEnCyY3u4e0
 Kta1t81NOTxWUeoJs6QQHIU/BGAG2fhGlOPmiIHAiLcp1mOtchEZ/kIQL9d00knJq3Jqf0t5YYa
 x7HaumqrTDdORz9qQY=
X-Received: by 2002:a5d:64e9:0:b0:47f:93be:dabd with SMTP id
 ffacd0b85a97d-47fb1f1013bmr4399028f8f.28.1785274181752; 
 Tue, 28 Jul 2026 14:29:41 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:29:40 -0700 (PDT)
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
Subject: [PATCH v4 00/14] Add dmabuf read/write via io_uring
Date: Tue, 28 Jul 2026 22:29:12 +0100
Message-ID: <cover.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
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
by Tushar and Vishal.

It's an opt-in feature for files, and they need to implement a new
file operation to use it. Only NVMe block devices are supported in this
series. The user API is built on top of io_uring's "registered buffers",
where a dmabuf is registered in a special way, but after it can be used
as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
requests. It's created via a new file operation and the resulted map is
then passed through the I/O stack in a new iterator type. There is some
additional infrastructure to glue it together, count requests, manage
lifetime and implement invalidation.

Tushar, William, Phil as well as Kanchan, Anuj and Nitesh did a lot of
testing and experimentation with different devices. Some earlier
benchmarks by Anuj for IOMMU optimisations with udmabuf showed: 

STRICT: before = 570 KIOPS, after = 5.01 MIOPS
LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

# Patch set structure:
- Patches 1-2 introduce internal API and infrastructure mediating
  io_uring and target subsystem / devices
- Patches 3-7: block layer support + prep patches
- Patches 8-9 implement NVMe support
- Patches 10-14 add io_uring support and uapi. Patch 14 specifically
  enables dma-buf support, the rest are preparation patches.

There are some liburing tests that can serve as an example:
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v4
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v4

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v4: - Add sgl support from Anuj
    - Move it under drivers/dma-buf/ and rename
    - Fix mis-sized allocations
    - Fix io_uring re-import mishandling
    - Drop map before io_uring "task work"
    - Move blk-mq callback to block_device_operations
    - Convert bio flag to REQ_OP*
    - Other small changes

v3: https://lore.kernel.org/io-uring/cover.1777475843.git.asml.silence@gmail.com/
    - Rework io_uring registration
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

Anuj Gupta (1):
  nvme-pci: add SGL support for the dmabuf path

Pavel Begunkov (13):
  dma-buf: introduce initial file I/O infrastructure
  iov_iter: add iterator type for dmabuf maps
  block: rename bi_bvec_done
  block: always adjust bi_offset on bio_advance_iter
  block: move bvec init into __bio_clone
  block: introduce dma map backed bio type
  block: forward init_dma_buf_io_ctx to drivers
  nvme-pci: implement dma_token backed requests
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add uncloneable regbuf flag
  io_uring/rsrc: add regbuf import flags
  io_uring/rsrc: add dmabuf backed registered buffers

 Documentation/block/biovecs.rst |   8 +-
 block/bio.c                     |  30 ++-
 block/blk-merge.c               |  23 +-
 block/blk-mq-dma.c              |   2 +-
 block/blk.h                     |   2 +-
 block/fops.c                    |  16 ++
 drivers/block/loop.c            |   2 +-
 drivers/block/zloop.c           |   2 +-
 drivers/dma-buf/Makefile        |   2 +-
 drivers/dma-buf/dma-buf-io.c    | 275 ++++++++++++++++++++
 drivers/md/dm-io-rewind.c       |  16 +-
 drivers/md/dm-pcache/segment.c  |   4 +-
 drivers/nvdimm/btt.c            |   2 +-
 drivers/nvme/host/core.c        |  12 +
 drivers/nvme/host/nvme.h        |   2 +
 drivers/nvme/host/pci.c         | 448 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp.c         |   2 +-
 fs/btrfs/misc.h                 |   2 +-
 include/linux/bio.h             |  22 +-
 include/linux/blk-mq.h          |   7 +
 include/linux/blk_types.h       |  14 +-
 include/linux/blkdev.h          |   2 +
 include/linux/bvec.h            |  17 +-
 include/linux/dma-buf-io.h      |  91 +++++++
 include/linux/fs.h              |   2 +
 include/linux/io_uring_types.h  |   5 +
 include/linux/uio.h             |  11 +
 include/uapi/linux/io_uring.h   |  31 ++-
 io_uring/io_uring.c             |   3 +-
 io_uring/net.c                  |   4 +-
 io_uring/rsrc.c                 | 281 +++++++++++++++++---
 io_uring/rsrc.h                 |  45 +++-
 io_uring/rw.c                   |   6 +-
 lib/iov_iter.c                  |  31 ++-
 net/ceph/messenger.c            |   4 +-
 35 files changed, 1315 insertions(+), 111 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 include/linux/dma-buf-io.h

-- 
2.54.0

