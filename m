Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B768EC55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 15:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D9110E329;
	Sat,  1 Aug 2026 15:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YHYpo9kT";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2056710E329
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 15:46:53 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ceb096e675so24031145ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785599213; x=1786204013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YTrKNi3+MrECxNlqKVpRT5BFV68pBJo2ri08VcWIuD4=;
 b=YHYpo9kTu9FAbGOVcSZ/sfwhsJh7Vd2pYQX3rczTJP8KYprzFDSE3CVXL8E6d1EQOF
 fLHZMI9+hIGVDped5rsEiSyWj1oPJL8L93RvaFAHSH6YBczuuLkADJNgWRh0QLcMztqV
 3MRW2Ri5CM9XBUczg+1LmcDanzkCdtrEyR0pn07s1354BtXAbZSJuu/kcNnA5ptgNkIn
 xU84kHveRBqXbIKZ/QEBjk5CeoQaTx4xzvyKBUTyh8m+eDi/wonIUmhfbVrdeMQbhDhZ
 k4PBVHx+/mV8SZSarILjpg12zuRYq8zT0jMAKcvcl0yvvNBea0gGuoE9uZlD2m0vueQy
 5nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785599213; x=1786204013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YTrKNi3+MrECxNlqKVpRT5BFV68pBJo2ri08VcWIuD4=;
 b=XlEx63TsXqOjeIKqimRvpSkbQstTI3PcYnu9d6BA/YiAGCA8OZqjzYbwXs38B6NnRi
 IMsBvACyyx1ViaOdtoC4Y72/bfurfMzT9zSG8CbvHt+psZQdTfXWwITEkHAqWY34tXhw
 JXd1S8ydgMomLacsqTHGvtN/xmpOKTHrXR79I+1fKoGLmnKQgX0+qVDWUJ04J3EC91dT
 yNztZOcODAcyhRH0Yd/CeNgFEAOau1ngjdXrkruyyvDtQJBuqRqRhiMU59f8e7yodENv
 wi4l+KbbIKto4V1sF/AOczkXQcY382Ecpij/h0y54Bl7ei8Zk5ueKwh2Tw54kpqXi951
 +Uow==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2Dd9Cdslycw0jJx3tx3maUORwT34TPWly1kycPzoeAhmTNdb1UijH17oj3aUYEJ8MNYtBAYYjlew=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvWYmJ5F9LAa/4UwkIbrsrt2QVyGuPtPDbpfnZhsmPsCMtjF4c
 Jbxy0k4QcMcVLMViZBU4u2gE6fKhqs5zJEjAe1n7UX6cqIDX2ZwpZmIE
X-Gm-Gg: AR+sD10ojDaWulcS8v8q7B9b+5HAS4SvBuevUv+Fggy64uTU2aZ6J+io8+IFfuvz4A9
 1PEyecWZStnWxQj7BOviiHoPsIugfQo5f/Hf7ubWakQWdqXK5CVRLHW54HKxAbTvARC+DOGcxAD
 1dIdUpK5hHo2voLE+qs2ziacJKgzAyXf/1dBiEgKclj8X1GBO+piK4+dOx+irQxXa/Ha/ka6DcO
 JxodTfhMrNTa8fnwy5czzu4WAj0aKBmYTGDrguz6osTRcw4hscLdzJYd4m3PstAlUTc9iedeF3+
 qoj7KbXQXdlLYuOmhhqxv9p9RWLVG/b+F3T+7i5ax6QxU+5kuOLkr6vP8WH4xq//5Lni/EX8L+U
 izE0BbvmwxnvFaWmJLoaFUvr+G633bsr1CphmSgan9LBDGibpgTQJEjytbDzAGAeWRSSfb59OLg
 tVnUFQ/+ZQMyVMEA9WQMDoQ0CW4AJpoDyFLUZUpBwz7H+UBEy3671wJP1FNC0LWlroZu+PrsIaJ
 GmmGjgopXB7HA2uGmQAVX/YCmuUSWZeaig7trwMEjlG25c=
X-Received: by 2002:a17:902:e943:b0:2cf:ba0c:aa5a with SMTP id
 d9443c01a7336-2d05241650emr38409935ad.47.1785599212500; 
 Sat, 01 Aug 2026 08:46:52 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:46:50 -0700 (PDT)
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
Subject: [PATCH v5 00/16] Add dmabuf read/write via io_uring
Date: Sat,  1 Aug 2026 16:46:12 +0100
Message-ID: <cover.1785596451.git.asml.silence@gmail.com>
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
in the future. A similar idea was attempted some years ago by Keith [1]
(from where I borrowed a good number of changes). Later it was brough
back up to life by Tushar and Vishal.

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
testing and experimentation on various devices with previous versions of
the patch set (separate thanks for trying it out and investigating
problems). Earlier benchmarks by Anuj for IOMMU optimisations with
udmabuf showed:

STRICT: before = 570 KIOPS, after = 5.01 MIOPS
LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

# Patch set structure:
- Patches 1-2 introduce internal API and infrastructure mediating
  io_uring and target subsystem / devices
- Patches 3-8: block layer support + prep patches
- Patches 9-11 implement NVMe support
- Patches 12-16 add io_uring support and uapi. Patch 14 specifically
  enables dma-buf support, the rest are preparation patches.

There are some liburing tests that can serve as an example:
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v5
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v5

The patches are based on Jens' for-next. Also available as a branch:
git: https://github.com/isilence/linux.git rw-dmabuf-v5
url: https://github.com/isilence/linux/tree/rw-dmabuf-v5

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v5: - Reject dma-buf with buffered IO for raw bdev
    - Add lim->max_segments bio splitting
    - Add bio_iov_iter_set() helper
    - Fix io_uring uapi validation
    - Other minor changes
    NVMe:
    - Rename nvme_pci_sgl_set_data() to nvme_pci_dma_iter_set_sgl(), split 
      into its own prep patch.
    - Convert segment walk loops to do-while.
    - Drop adjacent segment coalescing logic.
    - Drop first_dma/first_len from nvme_pci_dmabuf_sgl_nents()
    - Remove entries > NVME_MAX_SEGS bailout; moving to the block layer.
    - Factor SGL vs PRP decision making into a helper.

v4: - https://lore.kernel.org/all/cover.1785274111.git.asml.silence@gmail.com/
    - Add sgl support from Anuj
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

Anuj Gupta (2):
  nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
  nvme-pci: add SGL support for the dmabuf path

Pavel Begunkov (14):
  dma-buf: introduce initial file I/O infrastructure
  iov_iter: add iterator type for dmabuf maps
  block: rename bi_bvec_done
  block: always adjust bi_offset on bio_advance_iter
  block: move bvec init into __bio_clone
  block: introduce bio_iov_iter_set()
  block: introduce dma map backed bio type
  block: add dma-buf support for raw bdev
  nvme-pci: implement dma-buf backed requests
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add uncloneable regbuf flag
  io_uring/rsrc: add regbuf import flags
  io_uring/rsrc: add dmabuf backed registered buffers

 Documentation/block/biovecs.rst |   8 +-
 block/bio.c                     |  33 ++-
 block/blk-map.c                 |   2 +-
 block/blk-merge.c               |  45 +++-
 block/blk-mq-dma.c              |   2 +-
 block/blk.h                     |   2 +-
 block/fops.c                    |  35 ++-
 drivers/block/loop.c            |   2 +-
 drivers/block/zloop.c           |   2 +-
 drivers/dma-buf/Makefile        |   2 +-
 drivers/dma-buf/dma-buf-io.c    | 278 +++++++++++++++++++++
 drivers/md/dm-io-rewind.c       |  16 +-
 drivers/md/dm-pcache/segment.c  |   4 +-
 drivers/nvdimm/btt.c            |   2 +-
 drivers/nvme/host/core.c        |  12 +
 drivers/nvme/host/nvme.h        |   2 +
 drivers/nvme/host/pci.c         | 424 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp.c         |   2 +-
 fs/btrfs/misc.h                 |   2 +-
 include/linux/bio.h             |  23 +-
 include/linux/blk-mq.h          |   7 +
 include/linux/blk_types.h       |  14 +-
 include/linux/blkdev.h          |   2 +
 include/linux/bvec.h            |  17 +-
 include/linux/dma-buf-io.h      |  92 +++++++
 include/linux/fs.h              |   2 +
 include/linux/io_uring_types.h  |   5 +
 include/linux/uio.h             |  11 +
 include/uapi/linux/io_uring.h   |  31 ++-
 io_uring/io_uring.c             |   3 +-
 io_uring/net.c                  |   4 +-
 io_uring/rsrc.c                 | 280 ++++++++++++++++++---
 io_uring/rsrc.h                 |  45 +++-
 io_uring/rw.c                   |   6 +-
 lib/iov_iter.c                  |  31 ++-
 net/ceph/messenger.c            |   4 +-
 36 files changed, 1321 insertions(+), 131 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 include/linux/dma-buf-io.h

-- 
2.54.0

