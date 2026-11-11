Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8596070043
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jC9UAXGA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C7210EF65;
	Wed, 11 Nov 2026 19:24:22 +0000 (UTC)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B550D10E32D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:24:16 +0000 (UTC)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4c55ba309c2so4313930b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794425056; x=1795029856;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J+uUyLbFsNGSkOGPD0jT6rigmy2Vf3Zbwe9gzT+xN/I=;
 b=jC9UAXGA+G2zc8QNOP+jPPresWzyDCJo5oWwwK00JVouR7JAJYb/rftXVgw448Da1e
 ORaHLuCXjH53zqFD9Mx8bjvyLGsEzmk84sp/Rcc2gpe4ideA57AMNthTY97K51ZUwuKT
 d01nOdbsfcbPLdEObAp//mQHAXuW+InpaJidJViWQCZDfHDd/t8/eAjWAb/f02t6PwFn
 yB0a3n5YhjkGFXFEzN0YofqE/fLwvbHzMzhNO+/lvSJB0jK1H2UDqrE379fJ9b2SFUOc
 xZMUimybqTgQng9EXNNdpjxZ63YwXSwkqvhI6XodVb/scQHbO1WcYzhEAclqmNYY01Wu
 weZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794425056; x=1795029856;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J+uUyLbFsNGSkOGPD0jT6rigmy2Vf3Zbwe9gzT+xN/I=;
 b=sR7TiuCd6qYwj/GD7Yah9G/8mdwWmcdfGjxpaWLegoHHc/6rWh9RQ8CbpMVqNMQUw2
 6E3UEx1Cu3mGnUpJey++zs2b6vLM9M5H2Zm4lhTRsQm4qwgNmEr0kjHoJRhtDgk/RQDe
 hfiEdYFQ330UbUtn6T4WlxnSu7P2hJPE8cqou85qGGfsZd+zruFFWvuepNy/42qB01Mg
 nVgolJmQVNVMOeApshCKJgOKBAPbMMZuRCueq7dpAzbbC24E7WGSfishtyRaSwGQZV56
 hjJMMe8iLS8KZF/qfUqJ7PT+uEmz9IC76gZcpWf3815jovgRc/SWd3SsvOnP0uC9z/rh
 coww==
X-Gm-Message-State: APuU4Z9u9PGwu2FekstlInmx7IsFalam8DzmX+aiQeBJh8E+8J5sv+f/
 Ax3zrwPD/tUdZEmMjqyR/ZQGA2zZ7R5+JjuT4BvuKxqucQRZrw2tCOkzD4Uz71SMppvWBdKFWB5
 qVqFFq0+meWO4qlzY6IY8fxoM/GuFIm8XkYgCJGX7Cuaccs7hy/0Mlyk5w671n6IT1zobjkK8H2
 EEKJfgfk1W3o5QmGtOrLMNvPyo391Cdsqe0SUVbzZfuAUMo/Dg45/vwWBBoLI=
X-Received: from iouw14.prod.google.com ([2002:a05:6602:34e:b0:9e0:ee3f:c3a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c1b2:b0:4d6:90f4:48ab with SMTP id
 5614622812f47-56b97c18413mr3157501b6e.45.1794425055330; 
 Wed, 11 Nov 2026 11:24:15 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:04 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-1-dmatlack@google.com>
Subject: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 David Matlack <dmatlack@google.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Matt Evans <mattev@meta.com>, 
 Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/vfio/selftests/p2pdma/rfc/v1

This series adds a peer-to-peer (P2P) DMA selftest to the VFIO
selftests. The test pairs an initiator device supported by the VFIO
selftests driver framework (dsa, igb, ioat, mlx5, or nv_falcon) with a
target device that exposes a memory BAR, maps the target's BAR into the
IOMMU, and uses the initiator to perform DMA reads and writes targeting
the BAR.

No changes to struct vfio_pci_driver_ops are needed. Because
vfio_pci_driver_memcpy() already takes source and destination IOVAs, any
existing selftests driver can drive P2P DMA once a peer's BAR is mapped
into its IOMMU address space.

There are two motivations for adding P2P DMA support to VFIO selftests:

  1. Exercise the P2P DMA paths in VFIO and iommufd end-to-end,
     including mapping BAR mmaps via VFIO_IOMMU_MAP_DMA in legacy
     type1/type1v2 modes and exporting BARs via
     VFIO_DEVICE_FEATURE_DMA_BUF + IOMMU_IOAS_MAP_FILE (and dma-buf
     revocation) in native iommufd.

  2. Lay the groundwork for testing uninterrupted P2P DMA across a Live
     Update in the future, building on VFIO PCI Live Update support [1]
     and the PCI core changes to keep preserved devices accessible
     across kexec [2].

Patch 1 comes from v3 of Mina's huge_fault series [3] and is included
here for convenience. It adds vfio_pci_find_mem_bar() to locate a BAR
range that behaves like ordinary memory, starting with QEMU's
pci-testdev.

This series applies on top of vfio/next (vfio-v7.4-rc1).

[1] https://lore.kernel.org/kvm/20261102153656.1431701-1-vipinsh@google.com/
[2] https://lore.kernel.org/linux-pci/20261019213054.3157159-1-dmatlack@google.com/
[3] https://lore.kernel.org/kvm/20261102230445.3993629-3-almasrymina@google.com/

Series Overview
---------------

This series implements the following:

  1. Add vfio_pci_find_mem_bar() to locate a BAR range that can be
     safely read and written like memory, starting with QEMU's
     pci-testdev, and verify that writes stick before returning it so
     that unbacked pci-testdev BARs are skipped (patches 1-2).

  2. Allow VFIO_SELFTESTS_BDF to contain multiple whitespace-separated
     BDFs so multi-device tests can run via run_kselftest.sh while
     single-device tests continue to use the first BDF (patch 3).

  3. Add vfio_pci_dmabuf_create() and iommu_map_file() helpers to export
     a VFIO PCI region range via VFIO_DEVICE_FEATURE_DMA_BUF and map it
     into an iommufd IOAS via IOMMU_IOAS_MAP_FILE (patches 4-5).

  4. Add vfio_pci_find_p2p_pair() to find a compatible (initiator,
     target) pair from an array of VFIO PCI devices, providing a central
     place to check P2P topology reachability in the future (patch 6).

  5. Add vfio_pci_p2pdma_test, covering RAM-to-BAR, BAR-to-RAM,
     BAR-to-BAR, and RAM-BAR-RAM roundtrip copies across all supported
     IOMMU modes, plus iommufd dma-buf revocation when
     PCI_COMMAND_MEMORY is cleared on the target (patch 7).

Open Questions
--------------

  - Re-mapping after dma-buf revocation: Clearing PCI_COMMAND_MEMORY on
    the target device calls vfio_pci_dma_buf_move(vdev, true), which
    notifies iommufd via iopt_revoke_notify() and unmaps the BAR from
    the IOMMU domain. Re-enabling PCI_COMMAND_MEMORY calls
    vfio_pci_dma_buf_move(vdev, false), allowing the dma-buf to be
    mapped again, but dma-buf has no callback to re-populate iommufd, so
    the existing IOAS mapping stays unmapped until userspace calls
    IOMMU_IOAS_UNMAP and IOMMU_IOAS_MAP_FILE again.

    Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
    uAPI behavior? VFIO_DEVICE_RESET (and runtime PM transitions) on the
    target device also bracket the reset with
    vfio_pci_dma_buf_move(vdev, true) and vfio_pci_dma_buf_move(vdev,
    false), tearing down any active IOMMU_IOAS_MAP_FILE mapping of that
    device's BAR even though PCI_COMMAND_MEMORY remains enabled when
    VFIO_DEVICE_RESET returns.

  - Physical target devices and P2P topology checks: mem_bar_descs[]
    currently only matches QEMU's pci-testdev, and
    vfio_pci_has_p2p_path() does not yet check PCI topology or ACS to
    verify that P2P traffic can flow between two physical endpoints.

    Suggestions on physical target BARs to add to mem_bar_descs[] and on
    checking P2P reachability from userspace are welcome.

Testing
-------

All patches were build-tested individually. The series was tested on
x86_64 in QEMU 11.1 (membar-backed=on requires QEMU 10.1+) using an
emulated Intel 82576 NIC (igb) and a pci-testdev with a 1G RAM-backed
BAR2 behind an emulated Intel IOMMU:

  qemu-system-x86_64 \
    -M q35,accel=kvm,kernel-irqchip=split \
    -device intel-iommu,intremap=on,caching-mode=on,device-iotlb=on \
    -netdev user,id=net0 \
    -device pcie-root-port,id=rp0,slot=2 \
    -device igb,bus=rp0,addr=0.0,netdev=net0 \
    -device pci-testdev,membar=1G,membar-backed=on \
    ...

Inside the guest, bind both devices to vfio-pci and run the test (BDF
order does not matter):

  # tools/testing/selftests/vfio/scripts/setup.sh 0000:01:00.0 0000:00:0d.0
  # tools/testing/selftests/vfio/scripts/run.sh \
      tools/testing/selftests/vfio/vfio_pci_p2pdma_test

Or via run_kselftest.sh:

  # VFIO_SELFTESTS_BDF="0000:01:00.0 0000:00:0d.0" \
      ./run_kselftest.sh -t vfio:vfio_pci_p2pdma_test


David Matlack (6):
  vfio: selftests: Verify memory behavior in vfio_pci_find_mem_bar()
  vfio: selftests: Allow multiple BDFs in VFIO_SELFTESTS_BDF
  vfio: selftests: Add vfio_pci_dmabuf_create() helper
  vfio: selftests: Add iommu_map_file() helper
  vfio: selftests: Add vfio_pci_find_p2p_pair() helper
  vfio: selftests: Add P2P DMA selftest

Mina Almasry (1):
  vfio: selftests: Add vfio_pci_find_mem_bar() helper

 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/lib/include/libvfio/iommu.h          |   9 +
 .../lib/include/libvfio/vfio_pci_device.h     |  23 +
 tools/testing/selftests/vfio/lib/iommu.c      |  29 ++
 tools/testing/selftests/vfio/lib/libvfio.c    |  53 ++-
 .../selftests/vfio/lib/vfio_pci_device.c      | 181 ++++++++
 .../selftests/vfio/vfio_pci_p2pdma_test.c     | 435 ++++++++++++++++++
 7 files changed, 717 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_p2pdma_test.c


base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b
-- 
2.56.0.567.gdb80ae8cd5-goog

