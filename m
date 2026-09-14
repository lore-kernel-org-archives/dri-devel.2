Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D45C88E67
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E60A10E07F;
	Mon, 14 Sep 2026 04:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qPGKT4iK";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB09210E07F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 04:57:06 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc4d64bcea5so1466284a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789361826; x=1789966626; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VtcnUDAtlxwsk8tm+WoFz/dsUhvDBL4dml2X633QlxA=;
 b=qPGKT4iKTUucRLibt82Ag9V8cJ9Wvlf7E2D7JfxtQb+Iq8i2npE7SwG5imsddr1Mnt
 wd0FGnmxGIN2X6Sy7f+gh9I2HvrAs1XRoKbPk+YY2Nb/WDLZn4EMJkGryIVBWMkKotmZ
 5t6NzwB6il1xRjfezAz1Xke5JwZUbsyhumltSvdrhciPVkG4l0xOi/Hy1a6Tv0x8UT25
 ZoS1PJ4EjUu8yN93GHyl1z4rpjZeYvgQTAZxcK+XQSXsxs0Z2LY1bs1c+e+DxuljzwaQ
 tD5nFpplG249ayp4EFMmHkFSXRRO2rgiHuqbVlVIYHHXeqmrIB92zZMchXIKr7uQvP81
 2hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789361826; x=1789966626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VtcnUDAtlxwsk8tm+WoFz/dsUhvDBL4dml2X633QlxA=;
 b=gKCkYOPbQ30p74UJCIzYUSs1Gb7MHQkEXYPmcV9YOsvTuXx5YNloXU/zD7Fd3NO/hH
 E3+OMF3oQxWJcIh/r72HVu015/6rXW3ZQ+XYgUTHDfHJ4UiBcAoZOMJbJtQdQhd16fqU
 myoHf/5IXjOTe3oSuO+S42plrHriP6UVh5Ih1AFN6ZbmwUxDgC563rULcDki9j4QERIi
 P7c1fJS2nRjlHhd+QOZVKl+0fUmrFq3YibhxfKFRjz1FWnJkoHGUV7p71dnLzMojGiFX
 FwS8EAo+36Kzjo6HkSlk5F2/ly/lgLarHJA+dwqqE69hwnsseVwdXpr6oNH6nMcNo43Y
 PsQQ==
X-Gm-Message-State: AFuF++lfE6J4xzT2v+J9rWyVdabAoFirU+1Xkf6gmczv62J0xmDoJQUl
 0wPONZ1SEUK+uLdC6uSvgzt6hiPRbMhslCit9cCNGFNKyaxiNG0Cau4=
X-Gm-Gg: AYBFou2Fe+ABHFa9Npby3SNKBgLEIjQlFhVwnXRyUPJZq3Rg3KgFOANCs3l8XEfQz1T
 Gc+XOfSPy2wOI1qx/4TnpBNUAySFtAK1Jl78m9u5SRGsAe5VspnCPBj2HezeyLzsuXzHiSmSIe2
 AMiBDiWS0+cGN9ehWigSTVp4cglTb920qojw9Coj0L1aVInZmzbAh3BYkLIwqUsSyVxS72KpbNN
 +H1Cxss096YIg5ZT7q1TDqSNSrPmr6UkTrtklVL7HobT+pPo7sUkLAs9NeejbGgyHsk5jKVFhmF
 WYwK7V4/Jc8WX2iPiiumhdJ1Z3SEE3Gj1dtJbM29yI7rEm0mei/DOjkt8wEeNt67B5QME6qUNNV
 mYEiaR86Y7YUVuHzIdXFp2wRt63Nhmav+QJO+uDFXspDIOYhAwVwssAJc7h5rDXiczd+mFZw8SA
 84VYdJfPzyHJqhFshvWAO2GDiZlXEs0/s8C9UETdn6sUZ4bLXh+l8qBLEmjp9tdL8L9YscLt+Oc
 FtAECfEjr49
X-Received: by 2002:a17:90b:164f:b0:39d:b1bd:b384 with SMTP id
 98e67ed59e1d1-39dec0b6344mr2278378a91.17.1789361826240; 
 Sun, 13 Sep 2026 21:57:06 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d994872e0sm18824792a91.8.2026.09.13.21.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 21:57:05 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: sidong.yang@furiosa.ai,
	royalnet026@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, triet.hoang.dev@gmail.com
Subject: [PATCH v6 0/2] accel/rocket: Fix allocation handling and scheduler
 array leak
Date: Mon, 14 Sep 2026 11:56:03 +0700
Message-ID: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This small series addresses allocation and memory management issues in 
the accel/rocket driver:

1. Patch 1 ensures proper allocation checks before using pointers 
   in rocket_job_open()
2. Patch 2 fixes an unreachable memory leak of the scheduler array when 
   running on single-core setups (e.g., num_cores == 1), where 
   drm_sched_entity_init() drops the array pointer.

Link to v5: https://lore.kernel.org/all/20260818041505.1579320-1-triet.hoang.dev@gmail.com/

Changes in v6:
- Rebase on top of drm-misc-next (base commit 5052ea2e6bfc43c64b851c596d3675d17e05e631)
- Addressed review feedback from previous iterations.
- Added Fixes and Tested-by tags where applicable.

Triet Hoang (2):
  drm/rocket: Check allocations before use
  drm/rocket: Keep scheduler allocation in rocket_file_priv

 drivers/accel/rocket/rocket_drv.h |  1 +
 drivers/accel/rocket/rocket_job.c | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.53.0

