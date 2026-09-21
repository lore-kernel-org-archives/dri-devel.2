Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807B3C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2A110E61C;
	Mon, 21 Sep 2026 13:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VONd5b5H";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B6E10E61C
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:39:19 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso20184535e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789997958; x=1790602758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s6kgf6V3xUR//WctRXY84w9DzTYgF20+bN2plXCsnYg=;
 b=VONd5b5HS2MTNfwYDZ5Gnkvdb2sqkBOdpxjbtDrvk5n2jQY38M43W51nwN/XCfaGJh
 i5xKbLvgQhdzEyMmuM9ltrL6LZD1SUhbhOgSTnGEisMJJXREsLN8fa4Rmr58R+92WGr7
 IpVw+rny2zD6ADXPJtty/9TaVIZlUQkUxUKQmuAlAFDpcyYxiVEctiM797cYsCVNqxrR
 K23w8DmTF3FaLdPymUv3vUN80DlvOW4yPesrGMyJHBj/fGjxdpTQDE9+5g0DxwZ3jB/x
 T4NPOq4uHzhnSYNiXRacEhLnisj5kLtegkZxVuMiSLB4Tudmp9lRmilczwYv9JRzX/7Y
 sIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789997958; x=1790602758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s6kgf6V3xUR//WctRXY84w9DzTYgF20+bN2plXCsnYg=;
 b=mHIPyjtvLIBsH0pJna5owR4LrntrxellGcF2uWYiRVfMMaDuZfgWHC1JJUD8Umh77i
 WYTwiTh5FJetFrAi21uk0zEyjpVZcQ4iGwNJUvvejie84/M+h83rEyBMqPLIqkyVxPAi
 YWWknKx/JThWgBB8bpSnef3Bn2ev7fGeLayJu6hZ1eqbyCAl5jIXf2iKGz2Sf3Pouso+
 oHzN5YL/2qFr3hETi/Y1A5tPXi5Kv8Zs62uzGEUXUepkhMQrOAZT9lIX/Fm42MZffUZZ
 elMz0msaA2v25epPd9VsNK+yxtgMk9GHXxlwgGvypU4ge2S+a+LYSr+5hU2oRBHE5wZR
 5gnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTo66JkyMRm+agJPbobloG7wKGdf9S/95Y0Vn+IpFhWoLES9BRbz+h3h8ppYaayC9ODMPDMrM6XVY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mcoVmap/uKk+9Ya2euRypf4EMIZ8I/sdoGklKo7lbNQq1PeBbM
 JhHqiMtPaTyUgyGRC9G75lUazOlqL4SSUqcimn0nvzGC0SGZDypAR6wY
X-Gm-Gg: AYBFou1g8P7Wflci09Y8Se/yJqNW/x7Ee5gb82FKl2uoD9sNByHOxeRSHsyF20UQvF8
 DUB6ldjTIMkz8tpAbDFNtKNTQ6wHmMd3Ac8BsrXm1KzVhFscZZ0AQ7W0+8DmfLKQtAERo8jpcpt
 iEAI/waZrbhvepNHki6wYL1tes+mtr8YBaQcLu4UUiadiPI4p6n4f+kC7QGXqLvLzOEs8IW9pLY
 dyIDTALvBY7bat3oRuxxINoT6P4RHjHW3TeJXV3RwiYdmnGnyJfCGreSl2VLYG0dPA6sQivPDaB
 HO6Ld2mf4eilgaA+d7RN4pAfSH5Jv/nqOWbDKyCgKSai7CVbobR4QRlDuumyoyD8YJMGgLJ3JUk
 e7F6107XipWbbBOuxtYE5lSSp5+bVz0qkittZnCpSyYiItrthRpu/dIP+XHQVEZ9bT7I9dJZIQg
 PzXgIXi+zEe82oSdRL4aTsTK2xm0pcEDpEz6YycMdzkG+GGWh9L+USPByD1zuYCuHR8Detc+FGO
 UMk5/2O/ZEXx8wffTXgsov/uO5Bn2yEAZqwoWC36bMmEeDuyEVAqV/KLG9PfJXOEM9K5it1WfWm
 bgxN/JXRM5yJFyoEsmGdjj0fUxyWuQ==
X-Received: by 2002:a05:600c:1989:b0:49e:8184:f617 with SMTP id
 5b1f17b1804b1-49fc573610cmr163288645e9.22.1789997957649; 
 Mon, 21 Sep 2026 06:39:17 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:39:16 -0700 (PDT)
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
Subject: [PATCH v6 00/13] Add dmabuf read/write via io_uring
Date: Mon, 21 Sep 2026 14:38:44 +0100
Message-ID: <cover.1789997898.git.asml.silence@gmail.com>
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
from where I borrowed a number of changes. Later it was brough back up
to life by Tushar and Vishal.

It's an opt-in feature for files, and they need to implement a new
file operation to use it. Only NVMe block devices are supported in this
series. The user API is built on top of io_uring's "registered buffers",
where a dmabuf is registered in a special way, but after it can be used
as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
requests. It's created via a new file operation and the resulted map is
then passed through the I/O stack in a new iterator type. There is some
additional infrastructure to glue it together, count requests, manage
lifetime and implement invalidation.

Tushar, William, Phil did a lot of testing and experimentation on various
devices with previous versions of the patch set, and I've received lots
of help from Anuj, Kanchan and Nitesh with investigations, testing, and
patching. Earlier benchmarks by Anuj for IOMMU optimisations with udmabuf
showed:

STRICT: before = 570 KIOPS, after = 5.01 MIOPS
LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

# Patch set structure:
- Patches 1-2 introduce internal API and infrastructure mediating
  io_uring and target subsystem / devices
- Patches 3-5: block layer support + prep patches
- Patches 6-8 implement NVMe support
- Patches 9-13 add io_uring support and uapi.

There are some liburing tests that can serve as an example:
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v5
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v5

The patches are based on Jens' for-next. Also available as a branch:
git: https://github.com/isilence/linux.git rw-dmabuf-v6
url: https://github.com/isilence/linux/tree/rw-dmabuf-v6

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v6: - remove fences and wait on invalidation synchronously
    - report all map requests are detached earlier, outside of wq
    - handle nvme removal
    - gate nvme_free_descriptors() on iod->nr_descriptors 
    - fix error handling in nvme_rq_setup_dmabuf_map() 
    - fix iov_iter_alignment()
    - relax the 1G io_uring registered dma-buf limit
    - fix type overflow issue in bio split
    - allocate struct dma_buf_io_ctx inside the dma-buf-io code
    - harden block checks against dma-buf + buffered io

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

Pavel Begunkov (11):
  dma-buf: introduce initial file I/O infrastructure
  iov_iter: add iterator type for dmabuf maps
  block: always adjust bi_offset on bio_advance_iter
  block: introduce dma map backed bio type
  block: add dma-buf support for raw bdev
  nvme-pci: implement dma-buf backed requests
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add uncloneable regbuf flag
  io_uring/rsrc: add regbuf import flags
  io_uring/rsrc: add dmabuf backed registered buffers

 block/bio.c                    |  15 +-
 block/blk-merge.c              |  45 +++
 block/fops.c                   |  24 +-
 drivers/dma-buf/Makefile       |   2 +-
 drivers/dma-buf/dma-buf-io.c   | 219 +++++++++++++++
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/core.c       |  12 +
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci.c        | 484 ++++++++++++++++++++++++++++++++-
 include/linux/bio.h            |  21 +-
 include/linux/blk-mq.h         |   7 +
 include/linux/blk_types.h      |  14 +-
 include/linux/blkdev.h         |   2 +
 include/linux/bvec.h           |   3 +-
 include/linux/dma-buf-io.h     | 113 ++++++++
 include/linux/fs.h             |   2 +
 include/linux/io_uring_types.h |   5 +
 include/linux/uio.h            |  11 +
 include/uapi/linux/io_uring.h  |  31 ++-
 io_uring/io_uring.c            |   3 +-
 io_uring/rsrc.c                | 274 ++++++++++++++++---
 io_uring/rsrc.h                |  45 ++-
 io_uring/rw.c                  |   6 +-
 lib/iov_iter.c                 |  29 +-
 24 files changed, 1295 insertions(+), 80 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 include/linux/dma-buf-io.h

-- 
2.54.0

