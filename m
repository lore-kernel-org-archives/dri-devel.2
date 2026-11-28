Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E40606A332
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=PjblRERd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58CF10E05B;
	Sat, 28 Nov 2026 06:39:08 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD3C10E05B
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 06:39:03 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so5577706a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 22:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1795847943; x=1796452743; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nUqNSCpFAuXqhx4v1WEMdxqMn1uV2jBGy3KoprDM6Os=;
 b=PjblRERd61TtvIYv+QMv+WUSXQJ6xTSi0pgxbG+ccN5FB7bFAnTTIg5LA5D/yzm2yk
 5XbLFWzciNwbgF8xQPXMucjm0EUN2l0FlyANWOvs0Yf2T9MQuayew7PiXmU1uYFyb+Cq
 LuRHWVu06EbKdjT18NQhTiVHKxwrmW1YlHmr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795847943; x=1796452743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nUqNSCpFAuXqhx4v1WEMdxqMn1uV2jBGy3KoprDM6Os=;
 b=eyzGvCwv9dsG64bxwRtWwpdQkc8gtrtkXmyUQYbk6Txorg7tKRGOuQ7qjPbHPoe1if
 pvjdA2yoIJXZpK49S/Fii5NlgQM+2R+3b0NnBGZMYle4IiBmD+96bMiLR4XfY7SjvMN7
 2ZLZUoNzWyyb7mjMb1p4qViT75yzEmGZEU2VBwjxVYa0eShFv3e4qhvde2QDvMMRu8Pc
 GOeCkFnHpcL4Bk3yRl8+Ig0vKSpB6B6IIgnCoaL5o8LHMlY+o6yFO2um5PVVayXx1dRK
 Z6Sir/BUhkSIwVHo7hSV0Cq/K27/3oQG11YuS/rGQPVeKsFesDv3HCCkKx0TBuVl7oUp
 urBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEwLv9fAKHxVkKmRuXNEGbo2v7Ec6bme4uVn7xCTRuNAPb+RGMzkTExGP9ujhHcaGFnZxsAB6Ui84k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9qg8ameEKgumE2hJ9bxqzwvvJEI+wmZ99IsUQBdQupBGvqtmXT
 nZu4NV7FWIh2KjfUP00heYV62q06O+tzRBA2wr0YQU1gPNQJ/e7r9SvLDGPlcCh5GWM=
X-Gm-Gg: AZFdTZdoRyDtytrjAnQO448v40vn1qFxqshrpyfgcjxGEDsh7uQRq+EbmCBs/ll6Ysa
 QwROFQmMQ65QulTZd0318qMNJkLg/Y+rvmI7azTDelNZ/7IKoYkBFvXRDvBYtYIZZ+fmeJ0OZkE
 uPJPQT4foDk8fIMdpdNHz07EnjrpTEX+X1yG/bty2vCjFArnY7ZtNTd8QXL32/RxcBzF4fBln67
 tqZ6oDQfjpiLgWS3wnSx9IJTZMtn5uDL5x6tOpSvwlbIxgA71Vfj0ljs7KR3z2t5Q0nzvXK08to
 TLYMDmucJoEmAT05caOuFXsiFNU9D2O6oim7BaS5NWnjNrku6niOjU9bmBWqPoYsfvDyjZRGDx0
 zspAVoNc1clxdYCzHtjdJGHWLvYXNyKFEMoFhrdjDt1sHXL0+ZmA/IiZnkFlOnaEwpJ0pEKT1Zt
 iqN1IuP8s6PAdsY4R20kX+9PVwQ2UXVUW2sek4FfFRBbV9WEnOcfXjIaeldxaZewOpyV2o/GPjH
 7Rd3P9A9F31hba7JPc1xdMDowxdEKQYxfzXiA6u5zPuT5e1L/EF+eaXAaK16B+gZJgASAN9xMyd
 qxhTLvfg+vwpj2W/J1hmuaEZ+E+Uh2W4Bsu1+7eLT0vHdwgLFXtwFprvXTVN3yR2GXvvMhSo4w+
 5KH8Sgww0ovX+
X-Received: by 2002:a05:6a20:4314:b0:3e0:b1b2:2af9 with SMTP id
 adf61e73a8af0-4014c2573a7mr29687518637.60.1795847942770; 
 Fri, 27 Nov 2026 22:39:02 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077944bsm13939838b3a.2.2026.11.27.22.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 22:39:02 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Haoming Gao <Naixumogu@whut.edu.cn>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 0/4] accel/rocket: Fix BO creation and prep_bo handling
Date: Sat, 28 Nov 2026 15:38:40 +0900
Message-ID: <20261128063844.1537615-1-sidong.yang@furiosa.ai>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes four bugs in drivers/accel/rocket/rocket_gem.c, based
on drm-misc-fixes:

1. Reject zero (post-PAGE_ALIGN) BO sizes in rocket_ioctl_create_bo() to
   prevent a ZERO_SIZE_PTR dereference in sg_alloc_append_table_from_pages().
2. Store iommu_map_sgtable() return values in ssize_t (avoiding int
   truncation and leaked IOMMU mappings on >= 2 GiB allocations), size
   the drm_mm node from gem_obj->size, and unmap short mappings on error.
3. Skip dma_sync_sgtable_for_cpu() in rocket_ioctl_prep_bo() when the
   fence wait fails.
4. Wait on DMA_RESV_USAGE_READ in rocket_ioctl_prep_bo() so PREP_BO also
   waits for in-flight jobs that published read fences on input BOs.

Sidong Yang (4):
  accel/rocket: Reject zero-sized BO creation
  accel/rocket: Fix iommu_map_sgtable() return handling in create_bo
  accel/rocket: Skip CPU cache sync when prep_bo wait fails
  accel/rocket: Wait for read fences in rocket_ioctl_prep_bo()

 drivers/accel/rocket/rocket_gem.c | 43 +++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)


base-commit: e950f467b8adbfb2f460d9b9454280cdbf597885
-- 
2.53.0

