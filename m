Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED521C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 18:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A9310E109;
	Sun,  9 Aug 2026 18:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.com header.i=@amazon.com header.b="jiilkPDL";
	dkim-atps=neutral
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.162.73.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3C310E109
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1786299619; x=1817835619;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=np8xnS7sS1FdXM6aVqe0nnnEDhdIlmtRw58MDPrm9L4=;
 b=jiilkPDLgq3zOxP9/QTcGLjmie75rzbO83shEgEgRD3MtjpUihBURpbB
 77/zcooCwpPjo1k7AL5HJbeQ91asbdI5GmK1gxdlIl1BvVQ0wdwnHvey6
 tJrYCOp/qZhMTATIU/41tgise9N4MJPJgNHWjM7QIkd3aGKc38cAfVFha
 xH+1pH5zKbOmffo1pXRs/HQ4zhjwpsvAufbSdpKI1+KEcfYBpPHUjjF7X
 FlpF73o3cARX/K5OP6GYmcp57dJmOi9E1fQkveyWNOyqRybNB6IKUyTNN
 F4F/D+/ZpNBB5zM0T5+fPbp0zEjy3zoLbYS5GOmau3rIoqhsyXfZUb1Da g==;
X-CSE-ConnectionGUID: ME0H33klSu+09uE+ht1k6w==
X-CSE-MsgGUID: w9tths7NSliwt9tbagACmg==
X-IronPort-AV: E=Sophos;i="6.25,214,1779148800"; d="scan'208";a="25318976"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:20:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:6171]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.32:2525] with
 esmtp (Farcaster)
 id cdf4fcda-b791-4f20-afcb-4b86013918bf; Sun, 9 Aug 2026 18:20:16 +0000 (UTC)
X-Farcaster-Flow-ID: cdf4fcda-b791-4f20-afcb-4b86013918bf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:15 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:11 +0000
From: Alexander Graf <graf@amazon.com>
To: Jason Wang <jasowangio@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Alex Williamson <alex@shazbot.org>, David Airlie <airlied@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 <dri-devel@lists.freedesktop.org>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
 <eperezma@redhat.com>, Feng Liu <feliu@nvidia.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Jens Axboe
 <axboe@kernel.dk>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>, 
 <linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
 <nvdimm@lists.linux.dev>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Parav Pandit <parav@nvidia.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 <virtualization@lists.linux.dev>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Yishai Hadas <yishaih@nvidia.com>
Subject: [RFC PATCH 00/12] virtio: support devices that own their virtqueue
 memory
Date: Sun, 9 Aug 2026 18:19:58 +0000
Message-ID: <20260809182010.32931-1-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

Virtio drivers use guest memory to back virtqueues and their buffers.
That means a VMM needs to be able to map guest memory. That is ok in the
normal virt case. It gets icky with confidential computing (where we use
swiotlb as workaround) and it defeats the purpose of isolated vhost-user
backing devices, because they end up with full RAM access to the guest.

So instead, I'm proposing an extension to virtio which allows it to give
each virtio device its own dedicated memory region to communicate with the
host, called DMB (Device Memory Buffer). A trusted hypervisor can force
DMB to be present, which then enables safer, more isolated and resilient
communication between guest and host.

With DMB, the device provides a shared memory region that both parties
agree is the full memory map both have access to. All memory offsets
that previously would have been into guest RAM, are then offsets into
this shared memory buffer region. One nice property of this is that it
is a generic mechanism in the virtio transport layer, so higher level
drivers work unmodified.

I was exploring to use swiotlb instead to create individual pools. But
that approach has multiple downsides:

1. Swiotlb is an OS primitive which is not available in all Operating
Systems. DMB however lives in the virtio transport layer, which means we
can add support for it in any OS independent of generic layers. This
helps with Windows support.

2. We munge DMA space together. DMB provides a separate DMA space per
virtio device. This means we can for example implement a device in
vhost-user and give the implementing process only visibility to the DMB
region, not all of guest memory. That reduces the exposure the
vhost-user provider has, improving security.

3. Devices can opt-in. A hypervisor can choose to use standard virtio
semantics for self-implemented devices (e.g. NSM), while requiring DMB
for devices implemented by less trustworthy providers. The
non-trustworthy devices do not get any visibility into the trustworthy
ones, even with DMB in place for both.

== Limitations ==

  - Only PCI is wired up.
  - Feature bit 44 and the shared memory id register at offset 0x40 of the
    PCI common configuration are provisional: the OASIS technical
    committee has the specification and has allocated neither.

  https://lore.kernel.org/virtio-comment/20260804161202.38619-1-graf@amazon.com/

  - The device I ran this against is not public, so you cannot reproduce
    the numbers below. The KUnit test you can.

== Testing ==

Without patches 10 and 12 a receive refill livelocks and queues starve
each other: 29,319,791 receive softirqs in five seconds with not one
packet received, against 4 with them, and 2 of 7 receive queues that never
see a buffer, against none. Earlier revisions moved 512 MiB of O_DIRECT
block I/O and 2.7 GB of verified vsock through a region with no error.

The KUnit test for patch 12's guarantee you can run yourself, and two of
its five cases fail if I take the fix out:

  tools/testing/kunit/kunit.py run --arch=x86_64 \
      --kconfig_add CONFIG_VIRTIO_MMIO=y \
      --kconfig_add CONFIG_VIRTIO_DMB=y virtio_dmb

Patch 1 can be taken on its own: a stale worked example in a vdpa
comment. Patch 10 fixes something older than this series too, a failed
mapping arriving as -EIO from a packed ring, failing an I/O that on a
split ring is only back-pressure, but it does not apply alone: it wants
patch 2, and patch 9 for the file its documentation hunk edits. Both
carry Fixes:. Patch 12 wants 10 first.

I wrote this series with an AI coding assistant, which drafted the code,
the changelogs and this cover letter. I reviewed and reworked all of it,
and every commit carries an Assisted-by: trailer.

Alex

Alexander Graf (12):
  vdpa: correct the VIRTIO_DEVICE_F_MASK example value
  virtio_ring: validate premapped addresses through the device's map
  virtio: add the VIRTIO_F_DMB feature bit
  virtio_pci: read the device memory buffer shared memory id
  virtio_pci: create virtqueues with the device's mapping token
  virtio: add a device memory buffer region allocator
  virtio: locate the device memory buffer after feature negotiation
  virtio_pci: support VIRTIO_F_DMB
  Documentation: virtio: describe the device memory buffer
  virtio_ring: report a bounded pool's exhaustion as -ENOSPC
  virtio: expose device memory buffer occupancy over debugfs
  virtio: guarantee a virtqueue can publish its first descriptor chain

 Documentation/driver-api/virtio/index.rst     |    1 +
 .../driver-api/virtio/virtio-dmb.rst          |  803 ++++++++
 drivers/vdpa/vdpa.c                           |    2 +-
 drivers/virtio/Kconfig                        |   29 +
 drivers/virtio/Makefile                       |    3 +-
 drivers/virtio/virtio.c                       |   15 +-
 drivers/virtio/virtio_dmb.c                   | 1719 +++++++++++++++++
 drivers/virtio/virtio_dmb.h                   |   34 +
 drivers/virtio/virtio_dmb_test.c              |  279 +++
 drivers/virtio/virtio_pci_modern.c            |  100 +-
 drivers/virtio/virtio_pci_modern_dev.c        |   23 +-
 drivers/virtio/virtio_ring.c                  |  216 ++-
 include/linux/virtio.h                        |    3 +
 include/linux/virtio_config.h                 |   41 +
 include/linux/virtio_pci_modern.h             |    1 +
 include/uapi/linux/virtio_config.h            |   17 +-
 include/uapi/linux/virtio_pci.h               |   10 +
 17 files changed, 3254 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/driver-api/virtio/virtio-dmb.rst
 create mode 100644 drivers/virtio/virtio_dmb.c
 create mode 100644 drivers/virtio/virtio_dmb.h
 create mode 100644 drivers/virtio/virtio_dmb_test.c


base-commit: fc02acf6ac0ccde0c805c2daa9148683cdd01ba8
