Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C936CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 08:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7222B10EFD6;
	Thu,  7 May 2026 08:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hv/yPiVn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EF610EFD6;
 Thu,  7 May 2026 08:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778141386;
 bh=QPfTt+pyBlnDFF1TwXqztL0WqBfkEElueSQtmdgH5To=;
 h=From:To:Cc:Subject:Date:From;
 b=hv/yPiVncdmnZ13tD75UzM5X5p5h068RXRGnc7vRhfPMdWvhSPk1aBAp2eyF/HRiP
 yNb6N73Q6LQOyaCwABxEosR4WN1+6MxrLWRr6b/SmjXjUCwvZGfMh0ul8TYzEWPUv0
 2NEwLuGoiBENgl+0Bf/Kp7+KNAr4TYEXT88lM6eRXhGoCx1sVmqd81K+xgXBcGb6JA
 14R9EU22sE8U0Dc3mSCBQxmMWJnj5AM/shI+7eZTeb4BXkAwTONZt7qZ5sdr//TleM
 2cS9ocWUftzEQsf7/kmWc3LtouOymQmsJK5skFLD1Jl6dvYY+R3Q6ZEv12kN/dKlhU
 hEutmloxNvc7w==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D7CF917E04AE;
 Thu,  7 May 2026 10:09:45 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: dakr@kernel.org, aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, boris.brezillon@collabora.com
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v3 0/1] DRM 'feature' support for DRM drivers
Date: Thu,  7 May 2026 10:09:13 +0200
Message-Id: <20260507080914.95478-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
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

This is a follow up to [1], which introduces feature support for DRM
drivers, as will soon be needed by Tyr and rvkms.

Based on feedback and discussion on the first iteration, render node
support has been reworked.

Support for render nodes was initially modeled as an unsafe trait, to
require drivers to comply with any safety requirements tied to enabling
a given feature. For DRIVER_RENDER specifically, the intent was to force
implementors to ensure that any ioctl declared with DRM_RENDER_ALLOW
does not call KMS/modesetting APIs or require DRM_MASTER.

However, the C DRM core already enforces render node access control at
the ioctl dispatch level: if a client opens a render node, any ioctl
without the DRM_RENDER_ALLOW flag will fail. So the C DRM framework
already ensures the rules are respected for core ioctls, and the
unsafe trait doesn't add any meaningful protection beyond this.

For these reasons and since enabling DRIVER_RENDER doesn't require any
particular method to be implemented, there's no real need to model this
as a trait, and a boolean flag is sufficient.

This does not prevent other driver features to be modeled differently
based on their requirements. Features that require additional ops (e.g.
FEAT_MODESET) could instead be modeled as a trait, and some other
constant type that can only be constructed when the relevant trait is
implemented.

Introducing the FEAT_RENDER bool flag here leaves room for
implementing other features differently at a later stage.

Changes since v2[2]:
- Renamed RENDER_CAPABILITY const to FEAT_RENDER
- Expanded documentation for FEAT_RENDER

[1] v1: https://lore.kernel.org/rust-for-linux/20260119-drm-render-v1-0-8326e4d5cb44@collabora.com/
[2] v2: https://lore.kernel.org/rust-for-linux/20260505092304.108262-1-laura.nao@collabora.com/

Laura Nao (1):
  rust: drm: add FEAT_RENDER flag for render node support

 drivers/gpu/drm/tyr/driver.rs |  1 +
 rust/kernel/drm/device.rs     | 12 +++++++++++-
 rust/kernel/drm/driver.rs     | 12 ++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.39.5

