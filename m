Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B092CF506C7
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA2710E509;
	Mon, 16 Mar 2026 12:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wWqrYUpK";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7C010E116
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 12:59:01 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso53735875e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773665940; x=1774270740;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QiV2UgPzDyf2BIxEKlEP0kmveErchJjvWqwkP1nC5aU=;
 b=wWqrYUpKBjDsm4W5GcI9KWBiVeq3qocomSROwMtA6dm8U/rznqqH8J/FjX42/bFEkw
 9szJBhCHshS9maoVBcxXhWfnAGlaeLOUUNuycrxdo8WyMygEUxXCT9bfkOU626i4oYnf
 pfj6NkXelQtkomOuMD+qoPOSIZ5e73mIyuzBKrS0FXLEzmw9hcyUQ5Hh6azq0yfgPZtf
 dDyI5roMSHicWFTGRpapfcuO0F2mL2YE9BU+JaPrubmNnVQ/BvkfUB8BfRPVO4iBNRtT
 hXacWvbQhvSafmquqiQMrJxDpCKmIJAsIMUmzgFEAS2/VKLB126c8Tj2F+lQVPTnA3ob
 Y4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773665940; x=1774270740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiV2UgPzDyf2BIxEKlEP0kmveErchJjvWqwkP1nC5aU=;
 b=mSBHdEXpLZXdTuC7srJgYCx9r0bfS15NI0fkGafktYDTcZMcb6Daa9JNcfSBPOfdAT
 QLkK6x5YnXewDsMTYjX4S3d6DTbSAUJ4+nGbpOs65udPsvAFqvC+gd0QiqCQj1hgWBQH
 R844liTHu8GT14WCENzUEBrW3/tKeKACUHlo78vHOz17+mpSjcM6q1lU5pNMM/1OKrm6
 mGM3d6AF8au8WEJbD2JwomF83GAFMG/sNQjL8RU0qb18l0FVrSFnKcOuCvFBSHCQjdou
 7RNmeeC9DWVV2UxDWXx+kTDowJ0Bi2cb7OdCNadroUilRwA+xJmCLexd5Rtse0J6T+qH
 bV+A==
X-Gm-Message-State: AOJu0YwI6JMzthAMC/ZHyML8Q34u0lN2fV6DxWZYHpQhz3Zd5fZAX//7
 kMxa5WHehWGV73gDowxI3l4swIBz2czJV8Vkp7xL/dvk5EtaHrgfsZnBtWIvsVOMGQwW+oBVcUa
 vGX1ux2k=
X-Gm-Gg: ATEYQzznF8qZZZgwrKrEatRU2Bjtmf3ggLvk6EuENLOhf6LUziDk1FXL8rMOb6NFuy2
 mLlwyMpb5Wl9tAMBINzQ3wGq53H+IMkYTL0HauNoUmR8dZS+SeyJcnXa2TCDoO0bZZgRQ5GlJMk
 IJlymrSGh2D0h50NAfg9btiU0ntNQmHC6j2Wzu/AytornCrTJT3S4pip6+qlL4kndSVahmRwQH3
 i8TMqz5OdGjvHsNe8RzAzWHS2Zlq+aK1sGgWdWx+FeZkNyWIA9dqY8fyadqpBHmkGNN6w6HnKcm
 4rWBLKcEtpfYUxGPVUEnpqblqXZY0pPGPFPM6dKHWguavQslGoVgk5LO226np+JekmVzr9NtWvq
 PhpROWMfoDoiUOjadJ/gDOXa7GaOGIdBn5XDud5fKFYJuqCkJrinj7GwOrLPCbi+0hvdMwoi1CL
 Q9RIU/foQ2IrPKAg==
X-Received: by 2002:a05:6000:18a8:b0:439:ccec:fcd0 with SMTP id
 ffacd0b85a97d-43a04db4fb9mr22368246f8f.29.1773665939476; 
 Mon, 16 Mar 2026 05:58:59 -0700 (PDT)
Received: from localhost ([85.163.81.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b3e9a4fcdsm14591157f8f.8.2026.03.16.05.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 05:58:58 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com,
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Subject: [PATCH v4 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly decrypted memory
Date: Mon, 16 Mar 2026 13:58:55 +0100
Message-ID: <20260316125857.617836-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
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

From: Jiri Pirko <jiri@nvidia.com>

Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
run with encrypted/protected memory which creates a challenge
for devices that do not support DMA to it (no TDISP support).

For kernel-only DMA operations, swiotlb bounce buffering provides a
transparent solution by copying data through decrypted memory.
However, the only way to get this memory into userspace is via the DMA
API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
the use of the memory to a single DMA device, and is incompatible with
pin_user_pages().

These limitations are particularly problematic for the RDMA subsystem
which makes heavy use of pin_user_pages() and expects flexible memory
usage between many different DMA devices.

This patch series enables userspace to explicitly request decrypted
(shared) memory allocations from new dma-buf system_cc_decrypted heap.
Userspace can mmap this memory and pass the dma-buf fd to other
existing importers such as RDMA or DRM devices to access the
memory. The DMA API is improved to allow the dma heap exporter to DMA
map the shared memory to each importing device.

Jiri Pirko (2):
  dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
  dma-buf: heaps: system: add system_cc_decrypted heap for explicitly
    decrypted memory

 drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
 include/linux/dma-mapping.h         |  10 +++
 include/trace/events/dma.h          |   3 +-
 kernel/dma/direct.h                 |  14 +++-
 kernel/dma/mapping.c                |  13 +++-
 5 files changed, 132 insertions(+), 11 deletions(-)

-- 
2.51.1

