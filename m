Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2335CA5FE2
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A0010E10A;
	Mon,  5 Oct 2026 06:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a/Ph3xCB";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9466E10E10A
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 06:46:48 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso13489535e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 23:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791182807; x=1791787607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UDPEzA003wpyS4AK6a7pECjHcKEnmKef8YGoalZCMc8=;
 b=a/Ph3xCB+8dXfukUg+KsrgqF70pnCkCfs4o2qKimYlb3IiNe8/fr+doYjpcpAQmD7N
 YYgWGf00g58E7kkaUKtMz22sSGKFhKps5QXsFmEqpy1LfCLhinSYqfG/T+OIJZMN3N15
 wLu4qrBahh5yro5xjUsDjqCcL5RAvplWByBIHij4ToTU2PZMV4Xjppz/NY613XeZR2Dh
 1X7PZl72sQ2xmZj2njGzj6SvwKJz8sToxltUapGTRfcCUMuyg6BeBAZoBI34PVsjUGCQ
 wFxrbGx1IpB9v9qAhd+9ipLVbw6XdFwEN6tdCMISXHH7YnXmfzmsFFG5+TEZvSm607LF
 1YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791182807; x=1791787607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UDPEzA003wpyS4AK6a7pECjHcKEnmKef8YGoalZCMc8=;
 b=LXHBjqOB7i3O4OLrhVjcoI32mOTK9053A+1nh3EIu0kpR0BT80YYIyCgv9uV0YxDzJ
 TUwHPCLFDNBNRKznEbiSm2jJwg4dvcV2sFaXz9WLk2s8HhWfO7rqHnrtlw56r/ZbBHJR
 09bCQiRqS5xj9xpt/tfbUjPXdTgEbNlhVTqLc3VCdrG36VW2o18B05aUi1sIu8N5NE3+
 XjuaNfSLJazXNl+1bFIH9OM3lY7bYFSc+RTmLrvDjQkUdfHw+lHM4S2XovDZkOGxUjoc
 cRPw7NDOzf4iDboGDdTGdcBglPNyUvAJvoSYKPHmv1BaRT8Eqd679V0Bf0VayFP9U8zU
 3RZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwD9BDkmW+ElTr9TQbIPmWjItfZB8LeAdbRGEEiN5frCgrAJTOlWMmsuNe5MkKXgKFzU4ygM5CsMM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1pII04DPvxdtrUHa1bOeEglWTF44u00OLTF41PmJYoHPLk60d
 SpXwsInOtCuYtrcbPnGuIcBkeKTRr9Zip+hquuzvUJ39iqvRvMSIWG3X
X-Gm-Gg: AYBFou2+E4VAM5Pm8CvSC/8OUWSGZxv2RgBvvcF5GfM6vfmEDtrA6heF9DY3FOao847
 hM6/tk6D6ozmBSygqY0SdiZDmRLcQRr1L37oOiFF7pySyZUZfyrsd8iceLDVJi/6NWwPaoSRzoe
 5J2Bh6z2l5HZRsJDvBN6prJo4VV/IwLlU2wfKrUi3SbQ/upTGasa49Z16W4bSLC3+FlbLEsHuGD
 1jMrb3X5LCI9ycdlBnDh798/kgNhHw2uuMLhCWcCv21vd+U1FmW9pB6pB24Lw6ngttBqvBYXBtk
 p8DknquuMkSi/w6HHhTvW6hQII0ReKja1LOOBXxnPdFJXLfZnPrPvK/bSVYSX3GdRs+cqawJh3j
 VFfnfcevERNgre0jKZIcva0Nh4vfzvt7w89vczkWVjGIraFFN+40kpvtwdNmccU41vpyuSCdGnv
 mSYYsjwyQp1lX4AJqEb6nOGQPxPZv2xsU8i4WrMHHK/zahDq5qXxWqGMDD52qk8I5BmT7MQKDA2
 ri09c28n6U/8Ou9rjX34ar+a96p7jUs24n6eb9CNUWD+LGHu6yijpl0KrfsgTCzas7OtlUWwUxh
 uqqFlbB08+b09DDOBEylWh6VF+j3fuxJrSYXFM2nrBV3e3M+KQ3GH5omODncGs70jx7f0m5Ad4z
 ZKImEC2Vy0JUS
X-Received: by 2002:a05:600c:6212:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-4a1680e9466mr94460155e9.10.1791182806529; 
 Sun, 04 Oct 2026 23:46:46 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de.
 [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027741586sm315273615e9.14.2026.10.04.23.46.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 04 Oct 2026 23:46:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Russell King <linux@armlinux.org.uk>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] dma-buf: heaps: cma: respect the importer's maximum
 segment size
Date: Mon,  5 Oct 2026 08:46:37 +0200
Message-Id: <20261005064640.7776-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

The CMA heap builds attachment scatterlists without considering the
importing device's maximum DMA segment size. When an entry exceeds
that limit, DMA_API_DEBUG reports "mapping sg segment longer than
device claims to support". Patch 3 uses the importer's limit. A
corresponding udmabuf fix was posted in [1].

With patch 3, an importer that keeps the 64 KiB default gets a larger
buffer in several entries. Two in-tree importers require a single
entry and never set a limit: tegra-vde without an IOMMU domain, and
armada. Patches 1 and 2 set an unlimited segment size there. I found
them by searching the importers for checks on the number of entries
and on the length of the first entry. etnaviv has a fast path for
single-entry buffers but already declares a 2 GiB limit.

Patches 1 and 2 are valid on their own and can go through their own
trees. Patch 3 should only be applied after them, and is marked
stable+noautosel for that reason.

Tested in QEMU only, not on real hardware: patch 3 on a custom model
of the SAM9X75 Curiosity, and all three patches on xilinx-zynq-a9
with tegra-vde and armada probing from stub device tree nodes. The
notes of each patch have the details.

[1] https://lore.kernel.org/r/20260929054835.94118-1-kmehltretter@gmail.com/

Karl Mehltretter (3):
  media: tegra-vde: set an unlimited DMA segment size
  drm/armada: set an unlimited DMA segment size
  dma-buf: heaps: cma: respect the device's maximum segment size

 drivers/dma-buf/heaps/cma_heap.c              | 14 ++++++++++----
 drivers/gpu/drm/armada/armada_drv.c           |  3 +++
 drivers/media/platform/nvidia/tegra-vde/vde.c |  2 ++
 3 files changed, 15 insertions(+), 4 deletions(-)


base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.53.0

