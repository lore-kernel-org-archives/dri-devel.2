Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6B606A329
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gw5ckH7N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE06111271A;
	Thu, 26 Nov 2026 21:37:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D202110E3FA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:36:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C93A45473;
 Thu, 26 Nov 2026 21:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AE21F00896;
 Thu, 26 Nov 2026 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795729017;
 bh=dbFmwOOggqgywGda0GOnv17MMRswEWXf1DAQ18NUT04=;
 h=From:To:Cc:Subject:Date;
 b=Gw5ckH7NZScJDyiIevcgmMYwHI4KgcnP7syx98rjl6VCXlZZwHtWKeSbarG0XhExy
 3jpUE6/q9erxNklp0vn2R80Zj7tatkF5RPkZM++wW+nQXn8MVIvHLY4uIDWPgMvryK
 GR4mpJnkXoCzwOqwthuxtygL9biI9AMcbR+ElhMntH1h+EwGqhkWQfk0gFipxtS/fX
 uFohrUE3H1HBHbqbjWhAimEBdj/2ORfddzt8AHSZOs1/9PJKZIHLfMxtGF/Sp6H8YU
 3gCqtaRZ+1jXySqotg86WWR6fDIJH5vYVvO2mm5Lp2rs15+uy9LOYNoniL0Kbw4gIk
 9NIMKop3rvgvg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ecourtney@nvidia.com, jhubbard@nvidia.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] gpu: nova-core: prepare GpuMm for shared access
Date: Thu, 26 Nov 2026 22:36:01 +0100
Message-ID: <20261126213652.3716162-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Give PRAMIN independent locking so GpuMm can be accessed through shared
references. Initialize GpuMm in place so PRAMIN and TLB can be embedded
directly, eliminating their separate heap allocations.

Danilo Krummrich (4):
  gpu: nova-core: mm: serialize PRAMIN access
  gpu: nova-core: mm: use shared references to GpuMm
  gpu: nova-core: mm: initialize GpuMm in place
  gpu: nova-core: mm: remove SharedPramin

 drivers/gpu/nova-core/gpu.rs               | 18 ++++----
 drivers/gpu/nova-core/mm.rs                | 42 ++++++++++++------
 drivers/gpu/nova-core/mm/bar_user.rs       | 45 +++++++++++--------
 drivers/gpu/nova-core/mm/pagetable/map.rs  | 50 +++++++++++-----------
 drivers/gpu/nova-core/mm/pagetable/walk.rs |  6 +--
 drivers/gpu/nova-core/mm/vmm.rs            | 10 ++---
 6 files changed, 98 insertions(+), 73 deletions(-)


base-commit: 94c9ad2fd7a15f58782c50e471397d1efe6b6363
-- 
2.56.1

