Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADBFCD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 23:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1680A10EEF7;
	Wed,  6 May 2026 23:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s0ZdA8oc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB1F10EEF7
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 23:33:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A3DE46015B;
 Wed,  6 May 2026 23:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A29C2BCB0;
 Wed,  6 May 2026 23:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778110401;
 bh=glSgko/3lRAUAdpS5Vo5lsW3Gcp/ZQ8rSY8RK15A8E0=;
 h=Date:Subject:Cc:To:From:From;
 b=s0ZdA8oc/SPhN/sedJwH0DfYKAWXNtLEkHlrwcP88DQyYOxtbLW+Dy7rleMaGgJCr
 aHY1CCEHM/g1mzs4izcDfvG58w/QC36uWs39HXuj+3E11xAfm1WBurQh+ZOVjNRLom
 1ICWedKqmF8g8YDGWUPLT0BTREzu/yzAULU58M5IlByOb7vYZxQQwwhwV1/yUvbF7D
 cjxhr+9f/i40q5u1pO1sIWgxypBFqWqVoAs/UxR44KD8zip534iJH7QPFR7e/tyOyS
 5nTljbbPkRxnD/WB7R8Ff3FXYDqhpqpHBA+FK526q+boGe/BS0NaOO3OJWkGkHrtis
 rvVoRA70Xm4vg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 May 2026 01:33:17 +0200
Message-Id: <DIBZJ40ZC4J3.Y1DLA7JTS2PC@kernel.org>
Subject: [GIT PULL] DRM Rust fixes for v7.1-rc3
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
To: "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona.vetter@ffwll.ch>
From: "Danilo Krummrich" <dakr@kernel.org>
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

Not all of them have been in linux-next -- linux-next keeps merging branche=
s
from the drm-rust tree, but without fetching the remote; I reported this in=
 [1].

No conflicts expected.

- Danilo

[1] https://lore.kernel.org/linux-next/DIBZCHAXRBPZ.2AM1ZBR61RA9Z@kernel.or=
g/

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731=
:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/rust/kernel.git tags/drm-rust-fixes-20=
26-05-07

for you to fetch changes up to 0a69ac25bd596d50823d530d0a2004336668c0df:

  rust: drm: fix unsound initialization in drm::Device::new (2026-05-03 14:=
04:57 +0200)

----------------------------------------------------------------
DRM Rust fixes for v7.1-rc3

- Fix unsound initialization in drm::Device::new(); if pinned
  initialization of drm::Device::Data fails, make sure
  drm::Device::release() isn't called, so we don't run the data's
  destructor

- Fix missing GEM state cleanup in the init failure case; call
  drm_gem_private_object_fini() if drm_gem_object_init() fails

- Fix wrong ARef import in the DRM shmem GEM helper abstraction

- Replace the nouveau mailing list with the new nova-gpu mailing list
  for both nova-core and nova-drm, and remove unused patchwork entries

----------------------------------------------------------------
Danilo Krummrich (1):
      MAINTAINERS: nova: update mailing list

Eliot Courtney (2):
      rust: drm: gem: clean up GEM state in init failure case
      rust: drm: fix unsound initialization in drm::Device::new

Mukesh Kumar Chaurasiya (IBM) (1):
      rust/drm: import ARef from sync crate

 MAINTAINERS                  |  6 ++----
 rust/kernel/drm/device.rs    | 22 ++++++++++++++++------
 rust/kernel/drm/gem/mod.rs   | 13 +++++++++++--
 rust/kernel/drm/gem/shmem.rs |  6 ++----
 4 files changed, 31 insertions(+), 16 deletions(-)
