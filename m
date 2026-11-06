Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A26606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BgQiznxl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABF0112BBC;
	Fri,  6 Nov 2026 13:25:12 +0000 (UTC)
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Fri, 06 Nov 2026 13:25:06 UTC
Received: from mta1.migadu.com (out-38.mta1.migadu.com [95.215.58.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871A3112D43
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:25:06 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=4zwexF7Wz01Eu+onBHbqwklyRz49GNwu5fYWiMpNDo0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971504; v=1; x=1794576304;
 b=BgQiznxlvqYJcFoxvAU7xSKRS4NBriLkd+RMfku/63qraRDV5qtxHuoEY8BTMble/TorUAkf
 KxhLAlFhF7TZBogavUTKg+aaq5EvHogE8/eX16duH3a/qSx7KyrmD22jjyL15oVId1W+Z1TH9w8
 rhrQhJVqtu2cG03OHIkTrso0=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 26aa00f910ee51dc;
 Fri, 06 Nov 2026 13:19:00 +0000
X-Mizu-Trace-ID: 26aa00f910ee51dc
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
 loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
 vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
 jgg@ziepe.ca, kevin.tian@intel.com, axboe@kernel.dk
Cc: linux-mm@kvack.org, James.Bottomley@HansenPartnership.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 joro@8bytes.org, will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
 mathieu.desnoyers@efficios.com, robin.murphy@arm.com, mason@kernel.org,
 aesteve@redhat.com, tjmercier@google.com, harry@kernel.org, vbabka@suse.cz,
 cui.tao@linux.dev, cuitao@kylinos.cn
Subject: [PATCH 0/7] memcg: account the remaining uncharged kernel allocations
Date: Fri,  6 Nov 2026 21:18:22 +0800
Message-ID: <20261106131829.3228926-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tao Cui <cuitao@kylinos.cn>

Kernel memory that scales with user controlled input is supposed to be
charged to the memcg of the task that induces it, so that memory.max
contains the damage and the accounting is honest.  Sweeping the
interfaces that let unprivileged or delegated users drive kernel
allocations turned up seven more places where the charge is missing.
Every fix is one flag; the interesting part is who can pull the lever
and how much a pull buys.

An open sg fd reserves up to max_sectors worth of buffer, SG_MAX_QUEUE
(16) commands can be in flight per fd, and the fd count is bounded only
by RLIMIT_NOFILE.  udmabuf metadata costs about 4MB of SUnreclaim per
GB of buffer with size_limit_mb defaulting to INT_MAX.  vhost holds
roughly 150KB of resident kernel memory per SET_OWNER, and
/dev/vhost-net is handed to containers by device plugins.  A ftrace
instance allocates two full sets of per-cpu ring buffers the moment it
is created, about 1.375MB per cpu per set, gated by tracefs permissions
alone.  iommufd's hw_queue contiguity check allocates an array sized by
a u64 from userspace, frees it when the check fails, and can be
repeated in a tight loop.  io_uring still leaves the ring context, the
SQPOLL thread data, io-wq, the alloc cache arrays, the kbuf iovecs and
the registered eventfds uncharged.  The rsrc and tctx surfaces are
already charged by commit 075d5837bafc ("io_uring/rsrc: charge buffer
arrays and nodes to memcg") and commit 0b34e7b20a48 ("io_uring: charge
tctx nodes and personalities"); patches 6-7 pick up what those did not.

Verified on next-20261104 under qemu, same config with and without the
series, everything builtin: eight sg fds with 1MB reserved buffers
charge 8MB with the series and nothing without; resizing the global
trace buffer to 16MB per cpu charges 67MB against 0 before; four 512MB
udmabuf buffers charge around 8MB of metadata; sixteen vhost SET_OWNER
calls charge 4MB; 1000 io_uring rings charge 7.6MB on top of what the
in-tree charging already accounts.  All slab allocations in the series
are served by kmalloc caches, so they keep charging under the
SLAB_MAY_ACCOUNT opt-in rule queued in slab/for-next; the tracing patch
accounts page allocations, which are not affected by it.

Two in-flight series overlap but do not collide.  The dma-heap explicit
memcg charging series moves dma-buf data page charging to an explicit
path and removes __GFP_ACCOUNT from the system heap, while patch 2 here
accounts udmabuf metadata only, which that series does not see; if it
lands first, the system heap reference in patch 2 wants dropping.  The
io_uring patches sit on top of the charging Mason and Jens already
merged, and cite those commits as the in-tree predecessors.

I am sending these in one thread so the class is visible in one place.
If any of you would rather take your piece through your own tree, an
ack is all I need and I will split the series.

Tao Cui (7):
  scsi: sg and st: account the command buffer memory to memcg
  dma-buf/udmabuf: account the page array metadata to memcg
  vhost: account the per-device kernel allocations to memcg
  tracing: account ring buffer pages and trace_array metadata to memcg
  iommufd: account the hw_queue page array to memcg
  io_uring: account the ring context and SQPOLL thread data to memcg
  io_uring: account the remaining per-object allocations to memcg

 drivers/dma-buf/udmabuf.c      |  7 ++++---
 drivers/iommu/iommufd/viommu.c |  3 ++-
 drivers/scsi/sg.c              | 23 ++++++++++++++++++++---
 drivers/scsi/st.c              |  7 ++++---
 drivers/vhost/net.c            | 14 ++++++++------
 drivers/vhost/vhost.c          | 16 ++++++++++------
 drivers/vhost/vsock.c          |  5 +++--
 io_uring/alloc_cache.c         |  3 ++-
 io_uring/eventfd.c             |  2 +-
 io_uring/io-wq.c               |  4 ++--
 io_uring/io_uring.c            |  2 +-
 io_uring/kbuf.c                |  2 +-
 io_uring/rsrc.c                |  3 ++-
 io_uring/sqpoll.c              |  2 +-
 io_uring/tctx.c                |  4 ++--
 kernel/trace/ring_buffer.c     |  8 +++++++-
 kernel/trace/trace.c           |  6 +++---
 17 files changed, 73 insertions(+), 38 deletions(-)

-- 
2.43.0

