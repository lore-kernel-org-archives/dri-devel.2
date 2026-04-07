Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B923FFF5134
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 18:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A7110E493;
	Tue,  7 Apr 2026 18:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FP8MtPvd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213FF10E493;
 Tue,  7 Apr 2026 18:55:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 499D2600AC;
 Tue,  7 Apr 2026 18:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE8DC116C6;
 Tue,  7 Apr 2026 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775588135;
 bh=AbcygA1hOmjThs+kbyOAawPX0KVgGRAxsXzWkqu+CkY=;
 h=Date:Subject:Cc:To:From:From;
 b=FP8MtPvdSqCBr1ogWi6BQ+YA+Df1Ie2Y3Q0+hkYEJysJV9CoUfrZPCogvwNEPL2xo
 8mzRD2nqy6ffVpZcIlYLK4+YvwaHV5AzxpXW47Q8hBxVzUbwPJxonshwwyABOOiodl
 8x9GAf6t0aRGd4GcAa3/EKACYwtrU2al7PvzmERzKCPqVPMv5ZFgxDtFbuN5KMQZC1
 kinuLl2Fj7epL16gQsVoWfs2yLkbAfNBn/8KTZ016Q3NQSZBwLwYuVZdOre7QYUist
 JV7CAuzm5CP9xmGUNeQSGmF2iNguvsbZqkj671XvO7pqYYDzdC1TVx6fLrQiMsRDLi
 GIOzfvs4v5cyg==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Apr 2026 20:55:31 +0200
Message-Id: <DHN5GMSIBKO2.2AYOLXDU4X19S@kernel.org>
Subject: [GIT PULL] DRM Rust changes for v7.1-rc1 (2nd)
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona.vetter@ffwll.ch>
From: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
X-Mailer: aerc 0.21.0-0-g5549850facc2
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

Hi Dave and Sima,

Please pull these DRM Rust fixes.

All changes have been in linux-next for two rounds -- no conflicts expected=
.

- Danilo

The following changes since commit 7c50d748b4a635bc39802ea3f6b120e66b1b9067=
:

  gpu: nova-core: firmware: factor out an elf_str() function (2026-03-30 14=
:01:53 +0900)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/rust/kernel.git tags/drm-rust-next-202=
6-04-06

for you to fetch changes up to a7a080bb4236ebe577b6776d940d1717912ff6dd:

  gpu: nova-core: fix missing colon in SEC2 boot debug message (2026-04-06 =
10:06:39 +0900)

----------------------------------------------------------------
DRM Rust changes for v7.1-rc1 (2nd)

Nova (Core):
  - Don't create intermediate (mutable) references to the whole command
    queue buffer, which is potential undefined behavior.

  - Add missing padding to the falcon firmware DMA buffer to prevent DMA
    transfers going out of range of the DMA buffer.

  - Actually set the default values in the bitfield Default
    implementation.

  - Use u32::from_le_bytes() instead of manual bit shifts to parse the
    PCI ROM header.

  - Fix a missing colon in the SEC2 boot debug message.

----------------------------------------------------------------
Alexandre Courbot (2):
      gpu: nova-core: gsp: fix undefined behavior in command queue code
      gpu: nova-core: falcon: pad firmware DMA object size to required bloc=
k alignment

David Carlier (1):
      gpu: nova-core: fix missing colon in SEC2 boot debug message

Eliot Courtney (1):
      gpu: nova-core: bitfield: fix broken Default implementation

John Hubbard (1):
      gpu: nova-core: vbios: use from_le_bytes() for PCI ROM header parsing

 drivers/gpu/nova-core/bitfield.rs |   5 ++---
 drivers/gpu/nova-core/falcon.rs   |  21 +++++++++++++++++++--
 drivers/gpu/nova-core/gsp/boot.rs |   2 +-
 drivers/gpu/nova-core/gsp/cmdq.rs | 114 ++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++-----------------------------------------=
-----
 drivers/gpu/nova-core/vbios.rs    |   7 +------
 5 files changed, 91 insertions(+), 58 deletions(-)
