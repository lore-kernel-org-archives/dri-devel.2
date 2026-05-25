Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5ACCD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 22:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5E210E0FE;
	Mon, 25 May 2026 22:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P2drL2l0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9A610E0FE
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 22:58:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4164260018;
 Mon, 25 May 2026 22:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F941F000E9;
 Mon, 25 May 2026 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779749931;
 bh=Uwkgzu2N4xenCnW9gJInwt4SxGu6xMEQMyOyZKqOvjg=;
 h=From:To:Cc:Subject:Date;
 b=P2drL2l0XThkVIE9tM0hASBWBJB+SlEGH4x0F5ymqriT+yLyhYObHIMj5NT2MIEGI
 bE83LHngRUFOvM5cZrYckyFeqkTZov96LI3ZTAgruCvmbr2NvzLVPqbI7uVghlrip0
 A9nEAx4TcWdeGavvbKU54ZEcI9iO5BTQIvbw0ZjtCEx62RfCSMXBN5TX37bcnLn4j8
 i4Pi5O4piyLk4Xy1D9vrpBqYEywT6TCXZK8B7NBWGlzDzMSbsDdCOpVTf35alXFeRk
 IIxrbj+XCBxgYnkQC4CE8YMzYwbe/NZuesqRiphFiN4Ji7fwf0SG7FKX8BP+ZNIUAL
 VgesDYFxMZzVw==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 jhubbard@nvidia.com, ecourtney@nvidia.com, ttabi@nvidia.com,
 joelagnelf@nvidia.com, gary@garyguo.net
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 0/5] gpu: nova: adopt driver lifetime infrastructure
Date: Tue, 26 May 2026 00:58:28 +0200
Message-ID: <20260525225838.276108-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
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

Adopt the driver core lifetime infrastructure for nova.

Use the lifetime-bound pci::Bar directly in NovaCore, eliminating the
Arc<Devres<Bar0>> indirection. This lets SysmemFlush borrow the Bar and
implement Drop for automatic cleanup.

Replace ARef<Device> with plain borrows in SysmemFlush and the GSP sequencer,
where the structs are already lifetime-parameterized.

Separate the driver type from the driver data to allow the private data
to be lifetime-parameterized via the Data GAT.

This patch series is based on [1] and drm-rust-next.

[1] https://lore.kernel.org/driver-core/20260525202921.124698-1-dakr@kernel.org/

Danilo Krummrich (5):
  gpu: nova-core: use lifetime for Bar
  gpu: nova-core: unregister sysmem flush page from Drop
  gpu: nova-core: replace ARef<Device> with &'bound Device in
    SysmemFlush
  gpu: nova-core: gsp: replace ARef<Device> with &'a Device in sequencer
  gpu: nova: separate driver type from driver data

 drivers/gpu/drm/nova/driver.rs         | 12 ++++----
 drivers/gpu/nova-core/driver.rs        | 32 +++++++++-------------
 drivers/gpu/nova-core/fb.rs            | 31 ++++++++++-----------
 drivers/gpu/nova-core/gpu.rs           | 38 ++++++++------------------
 drivers/gpu/nova-core/gsp/boot.rs      |  2 +-
 drivers/gpu/nova-core/gsp/sequencer.rs | 11 ++++----
 6 files changed, 52 insertions(+), 74 deletions(-)

-- 
2.54.0

