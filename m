Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75892606A33B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TWBJi2sn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB8BB10F25C;
	Tue, 20 Oct 2026 06:38:15 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0CF10F25C
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:38:08 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso2296725e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792478287; x=1793083087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UzAZEenc0KxEq0x6RyPzYufxdEkxW9SFi1K+hoFFagM=;
 b=TWBJi2snGWqK/rEBpkFf6PXb1uf5kCN17dvixm0VdrUWnwkROejA2+GjMpspFYlWm4
 3P2OCo/r3Njv4LfpGRMaLStil8GxJkiOJP6FRL4ta/8sIMYkZpt1Y/sO7h+t1xfWfAH2
 uW6VBX6FC6YEeT9SFxUHq5kGyOXqIal7ACLVZaQqHC/V+sXPSvpuji3tLWJeoZMMCZKH
 yJ4W0nftgnWQEHDAOrn05YsNa732wwdgxEMHosnUCyOx5vfiXOJ4FFXAdRPXyA10UdZj
 54yfL72Y2sOx5R9TblxGX+zxtvSgnvyXqvReG4arMFsq/x5FAhyesBnl9rVl6P1YgpdV
 GBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792478287; x=1793083087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UzAZEenc0KxEq0x6RyPzYufxdEkxW9SFi1K+hoFFagM=;
 b=qxpxDWlZyfxKK+/i/zXTmv7qjSzl0wv1M2hjt3bFiit2Pzoy57vYZ3izmElssVIB06
 lDFSEl0HxLrUwkB5CqIOxg9FPBdX9lx8FwHJaEkmS0GgAkj1k8I7g8ESSgEwq1rRTNzD
 QSjB9rgJxl2KBYr48DYO/bgvzt+o0ncNfuljC7A8RBzCTY2esZzjdskcx4p9kUHRA+HE
 vZKzzpgB8dU379g+o4zbXLAUJ/Bc+EN66DsH1wO1fWc4mxm9XP32jGsgNByYo2h9AizN
 rHFnC1yW/uzyRPD4eDgtOPKdhk+Cj3PsbMPomm6MoYkdzKw/gTXfjxEXZo7GM1uKEkkQ
 NI0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIZToFFzn0tuHu5D7NyJtzlvnokS2TXi8Niq0Xa23PuOWA4nkRCKJEK0J7pVJ0j7/cfWjTneBPfAE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIU+Ls386yTh2FRzz+cH3Czu6uVi3f9PqCTJQ7KoIQzlnwiDfKn
 uo+5s4ZBpsmVhzliLYi+DdMLgdMJ1UMwnEcR/T2Vk6LHhWkDeyAP1uP6
X-Gm-Gg: AYBFou2Fu42LtBQtgIWTNB62An3FfXumhP2FA4s52lXFmI5OiUN+UFvEMeULXqDXw/H
 OEHZSL2xmLNvm7iPeexFr8/0Cp94cuPeVd9ZJ1xBmsWPzd4fA+Fr0Aag2AxKT4De9H0G7VYbSYL
 chFU4SbRkENpKDtxyCvYJ4qpm3aOJJ9DiWQcoIkrtGJxdAoi3Rgk6A4bnWePz1q4DVgcGtQ5CHu
 X3t/2a6hfJgDBKQDc64fDNJhVRzGwMZc7xAhfbApEG6YSJuDCXmoF0DaK0RLIerbe6F3f71k31k
 59IWOSL68NN7XaVTV/MsckaLfPdpaYI0C4mvc4gaZXheBxsq64ZsHxhsqvaAsBwVKHs8uZtUI49
 doOvKl1F1edGuiCVDUGfpMgZb1gb9zUwM4Ya6bq4Mvd9OU1aEQtu5tjRHlV1buuSzScfO/hbf0u
 cbsAkxykB97Lu3pAUZlRwahGaXrFEGSSXJhstHL51sggp6auQ2hi5K1Xn/g9g6WQR5boQ1dgGLL
 P9CpfhoOAdf0Pjgcjpz7w3sQPNzCNt5sRF4SnZf5HhHq1T8sXBQkoPhyGaCIqFFYiPgScrnvUNt
 PiRRj3O5R2EbE+AH1vBWv2hdR+Ff4QIVVGkspTdEt7QMKgQWvDU/FbwfLV/LeUgQU2vrXwXbvDm
 2m9cHt3feOGm0
X-Received: by 2002:a05:600c:3114:b0:4a1:ac66:604b with SMTP id
 5b1f17b1804b1-4a1f4c70117mr24583145e9.1.1792478286893; 
 Mon, 19 Oct 2026 23:38:06 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de.
 [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 23:38:06 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH 0/6] iommufd: harden DMA-BUF PAL setup and release
Date: Tue, 20 Oct 2026 08:37:39 +0200
Message-Id: <cover.1792477872.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a narrow companion to Jason's unmerged DMA-BUF mapping-type RFC. It
fixes setup and release problems in the IOMMUFD PAL consumer and adds fault-
injection selftests. It is not standalone and requires this exact base:

  c37cf2824740d ("cover-letter: Add DMA-buf mapping types and convert
                  vfio/iommufd to use them")

I used LLM assistance while inspecting, testing and drafting this series.

I also tested DMA-BUF paths on a Raspberry Pi 400 and Pi 500+, using their
stock Raspberry Pi kernels (6.18.39+rpt-rpi-v8 and 6.18.34+rpt-rpi-2712).
Both passed offscreen CPU/V3D byte checks. The Pi 400 also passed five raw-MJPG
payload-prefix comparisons through V3D; this was not direct or zero-copy camera
DMA. Neither board ran this RFC or IOMMUFD PAL. The Pi 500+ connector state and
mode remained unchanged; the tested buffers were not scanned out.

RFC:
https://lore.kernel.org/r/0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com/

Jason's branch:
https://github.com/jgunthorpe/linux/commits/dmabuf_map_type

This series:
https://github.com/kmehltretter82/linux/commits/dmabuf-pal-lifecycle-rfc-v1

Diederik's RK3588 testing produced a useful trace through
rockchip_gem_iommu_map() and iommu_map_sg():

https://lore.kernel.org/r/DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com/

Jason noted that this showed the same private-IOMMU-domain mapping need as
IOMMUFD:

https://lore.kernel.org/r/20261009125338.GB13920@nvidia.com/

That trace is motivation only. This series neither revives my warn-only
mechanism nor converts Rockchip. Jason's feedback on that mechanism is here:

https://lore.kernel.org/r/20261009124259.GA13920@nvidia.com/

Compared with Jason's branch, this series:

  - preserves dma_buf_pin() errors;
  - publishes the attachment and successful PAL list together under resv;
  - unmaps and clears the published PAL pointer under resv before unlocking;
  - keeps callback state alive until dma_buf_detach() returns;
  - calls dma_buf_unpin() while holding resv; and
  - tests pin/map failures, cleanup counters and retry on the same DMA-BUF.

Patch 3 follows an earlier forced-window arm64 QEMU/KASAN double-free report:

https://lore.kernel.org/r/20261016194022.62065-1-kmehltretter@gmail.com/

The proposed release order is:

  resv lock -> unmap and clear PAL -> unpin -> unlock -> detach -> put ->
  destroy the pages mutex

Questions:

1. Is that publication and lifetime rule correct?

2. Is c37cf2824740d still the right base for this companion series? If not,
   which tree should I use?

3. Can these lifecycle fixes stand independently of moving final mapping
   selection closer to map time?

   https://lore.kernel.org/r/20261016202653.97339-1-kmehltretter@gmail.com/
   https://lore.kernel.org/r/20261019184123.GR13920@nvidia.com/

4. Is the per-buffer selftest control acceptable, or would deterministic
   setup/release race hooks be more useful?

Testing:

  - arm64 QEMU virt: two boots, 24 selected cases per boot, zero skips;
  - x86-64 KVM q35: two 24-case candidate boots plus one focused four-case
    pin-failure boot;
  - a one-defect x86 control failed all four pin-failure variants on the
    expected erroneous successful ioctl return;
  - x86-64 GCC 13.3 built the exact head, headers and IOMMUFD selftests; this
    build was not booted; and
  - KASAN and lockdep initialized with no diagnostics in candidate runs.

The QEMU/KVM campaigns use mock IOMMU domains and the selftest exporter. They
do not cover a non-selftest PAL exporter, physical DMA/IOMMU, forced
invalidation races, or the complete IOMMUFD selftest suite. The x86 negative
control validates patch 1 only; the earlier patch-3 report is separate.

Testing with a non-selftest PAL exporter would be welcome, especially failure
followed by retry, invalidation during setup/release, repeated revoke, and
multi-range buffers. Please include the base, config, architecture,
exporter/device and full dmesg. A full IOMMUFD selftest run on another
configuration would also help.

Thanks,
Karl

Karl Mehltretter (6):
  iommufd: Preserve DMA-buf pin errors
  iommufd: Publish successful PAL mappings under resv
  iommufd: Clear the PAL list before dropping resv
  iommufd: Keep the pages mutex alive until DMA-buf detach
  iommufd: Unpin the DMA-buf while holding resv
  iommufd/selftest: Check DMA-buf pin and map failure cleanup

 drivers/iommu/iommufd/iommufd_test.h          |  24 ++++
 drivers/iommu/iommufd/pages.c                 |  24 ++--
 drivers/iommu/iommufd/selftest.c              | 111 ++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 121 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  30 +++++
 5 files changed, 298 insertions(+), 12 deletions(-)


base-commit: c37cf2824740d833b21eb816e21f94836100291f
-- 
2.39.5 (Apple Git-154)

