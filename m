Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41925109C059
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D79110E0E4;
	Wed, 25 Mar 2026 19:23:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1qv/k/55";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6933810E0E4
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 19:23:55 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so2091905e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774466634; x=1775071434;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q9oYYl5Ubh4Ping1zst+E8em20zAUpauFfgriVu6hpE=;
 b=1qv/k/55OC6ycQx6ywMZaK8Y72dLQ6QBpYy7yPEbbn8F6vDQQO41KWw1ZTy6pVkdJs
 LSpxQUCv7gVDrd4evFxTU02FP+RQAGtzPlREwrKCtKhLTCQWyXuEcC8ZTe9DtsaEXfzY
 l7xVK22+XN3cz8Hg3fj+0zLyk7LqwewSYxu1uKHthiwTN4odOOjR5HBvVXlgXAk4KFcN
 fRTwyc5ZM6hGV7Xpd/JIpcosdxMjmXRazb0++4ACVfh78BSZpWPlrqfkWoUgWvHjn0zF
 rsidI1MDEFizYbNG2XvWw1m2jvYWi0RqeY6njx6p+RUG2P7Z1Py/eQTLD9hxrFcwwnkD
 e0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774466634; x=1775071434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9oYYl5Ubh4Ping1zst+E8em20zAUpauFfgriVu6hpE=;
 b=owc1oBZoNKDcLD+/HxZGYJ8VdsaBfDUvIF+mMT7MsZqDfloV7KZ24C+3NWsK4Kr6LJ
 Bxd8KJN1J0aiGSVUfIiU8qn7KPUHmg5shGNZGsH1SDmLm+CwloNAOFB9xtiz/xhjFQTW
 iNWqh2ya4Jp6h31bDpESbe20PhDVXeuuZkRQfeDYUMDUbIYvYF8kl/NsiZ0D6mSJB4iV
 ykNYjrsioYItAgUg19pTQzXn/95DTUPIlif9/UF9gGHAmrt49eQ1u0vxFPTS3dCCv8jU
 k5UuruwfsUye0bbo9MlPUQl05RfxsvEfhRLRYL5a2HTVPYYEdVyAvAk0OLptIv2Jxfsg
 d37Q==
X-Gm-Message-State: AOJu0YwVV4/KRIN6/ckeH6HIfvN0KTmLzHP9WOFgfKkMVqmYwZuuPESO
 gvF8wwAhjkTtBdiyCljhKP7zJ6qNwfIwvLzwGZJD5ILH8GPeT7KmAiapNLfaJooSklyvmIQF4Ea
 6oJVeFEjqeA==
X-Gm-Gg: ATEYQzxFMZ7SOGD61+6ksG5gSW3tp7GQfFhOwuDHMFgo8QQaE1QrsjM/HyKT32Aco1q
 l5fpBEY9zzycUtk4JngilXKGmSNaoV2c7NTngski1I15V7O60168Z1bMRoK8rzaG7M2xet+ofTz
 kxUsfetl06z9O2qMVDxdo8gLOlzCrjpYZXA3yOZ7+y2BfPU7xOzJEQuTrd5UkprbqCYIXcRI9zD
 ZSa9Kigv7G18/vTIyCb1LIO49qXPOHpUThPhe+A4CeYngUnYXJrfye7cQP8FeKa+Gz7mIy7avH1
 d3Fg5FdQB37RWtoylEsPq+UmhqhS1oZuQrBz/jIAGFNS3hCAWvuNtP+oKLvNjFOcG5ujUnKsq7H
 UkbMrFJFvWiPsSqPoDTn2RSZLpeA0JPphGrpNq6x/K3+SEO3VGPHlN+l+g9r5f/AZE6kQu+HXBQ
 xXVPwjoVNYIDKX+jjhq07eeIMwlKR7
X-Received: by 2002:a05:600c:1f12:b0:485:41c4:e2e5 with SMTP id
 5b1f17b1804b1-4871605686dmr70437725e9.27.1774466633448; 
 Wed, 25 Mar 2026 12:23:53 -0700 (PDT)
Received: from localhost ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e7111sm1855634f8f.37.2026.03.25.12.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:23:53 -0700 (PDT)
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
Subject: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly shared/decrypted memory
Date: Wed, 25 Mar 2026 20:23:50 +0100
Message-ID: <20260325192352.437608-1-jiri@resnulli.us>
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
run with private/encrypted memory which creates a challenge
for devices that do not support DMA to it (no TDISP support).

For kernel-only DMA operations, swiotlb bounce buffering provides a
transparent solution by copying data through shared memory.
However, the only way to get this memory into userspace is via the DMA
API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
the use of the memory to a single DMA device, and is incompatible with
pin_user_pages().

These limitations are particularly problematic for the RDMA subsystem
which makes heavy use of pin_user_pages() and expects flexible memory
usage between many different DMA devices.

This patch series enables userspace to explicitly request shared
(decrypted) memory allocations from new dma-buf system_cc_shared heap.
Userspace can mmap this memory and pass the dma-buf fd to other
existing importers such as RDMA or DRM devices to access the
memory. The DMA API is improved to allow the dma heap exporter to DMA
map the shared memory to each importing device.

Based on dma-mapping-for-next e7442a68cd1ee797b585f045d348781e9c0dde0d

Jiri Pirko (2):
  dma-mapping: introduce DMA_ATTR_CC_SHARED for shared memory
  dma-buf: heaps: system: add system_cc_shared heap for explicitly
    shared memory

 drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
 include/linux/dma-mapping.h         |  10 +++
 include/trace/events/dma.h          |   3 +-
 kernel/dma/direct.h                 |  14 +++-
 kernel/dma/mapping.c                |  13 +++-
 5 files changed, 132 insertions(+), 11 deletions(-)

-- 
2.51.1

