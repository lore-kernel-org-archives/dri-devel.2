Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1A606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=cMQuDfCL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3766F11265A;
	Fri, 13 Nov 2026 15:31:30 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22AD410E642
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1794580415; x=1794839615;
 bh=u9IuEf6rp7xFv52Negp9qgPJMgK728e5qtDT6H/5DDw=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=cMQuDfCLMPojTaZmy7BIYBjTNVrEZs6+wy7Fr916opB1SsSuURQc9ATDEfrq1+JUj
 OiUlmn6AqD0hN9NSF82gqR+4MvmvDPh3CC4hrTfDFyymSjBdC2zYONM9GIp91zYX4K
 mrJLL67h2a5aJXQCYcUwTC07qQ4KXoq8O6/UnqwTkBf3+VzJXktds9G/lm9hRWZvZP
 bW5/8l8NtcMmfd77seLtPuRnkNnZijsI3k4Kipe8H69dp80t2VJPfeAzc7KbZUeQDO
 /ZILxsY3JRp7NFwW0gEDq9ATxGAtxavycEB5j6CAzL32COqgnKBzesLSPA4NO6XbgV
 8Vy5N1RCzhOvg==
X-Pm-Submission-Id: 4jR09l0nhMz1DDXX
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
 boris.brezillon@collabora.com
Subject: [PATCH v8 0/3] drm/tyr: GPU reset infrastructure
Date: Fri, 13 Nov 2026 17:32:25 +0300
Message-ID: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260813-tyr-reset-impl-93e951f996b4
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for scheduling GPU resets on a dedicated workqueue. Track
the reset state to avoid queueing another reset while one is already
pending or in progress.

Use an SRCU based gate with mutex-protected reader admission to block
hardware accesses while reset work runs and wait for current users
before resetting.

Stop new reset requests during teardown and drain any queued or running
reset work before releasing the device resources.

This is the initial reset infrastructure only. It is not wired to a reset
source yet as those will follow in separate work.

This version is based on drm-rust-next commit
cc0e99fad239 ("gpu: nova-core: add support for GPU timer block. (v7)"),
with v3 of "workqueue: OwnedQueue and ScopedWork" [1].

Changes since v7:
  - Rebase against drm-rust-next and workqueue v3.
  - Add a TODO to consider embedding HwGate in platform data.

V7: https://lore.kernel.org/all/20260912-tyr-reset-impl-v7-0-077ce72084eb@onurozkan.dev/
Link: https://lore.kernel.org/all/20261020-rust-workqueue-v3-0-ea7c74d02068@google.com/ [1]
Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
Onur Özkan (3):
      drm/tyr: clear stale IRQ state before soft reset
      drm/tyr: add GPU reset infrastructure
      drm/tyr: put iomem behind the hardware gate

 drivers/gpu/drm/tyr/driver.rs            |  63 ++++----
 drivers/gpu/drm/tyr/fw.rs                |  16 +-
 drivers/gpu/drm/tyr/mmu.rs               |   6 +-
 drivers/gpu/drm/tyr/mmu/address_space.rs |  87 ++++++-----
 drivers/gpu/drm/tyr/reset.rs             | 244 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/reset/hw_gate.rs     | 106 ++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs               |   1 +
 7 files changed, 441 insertions(+), 82 deletions(-)
---
base-commit: cc0e99fad2392ac479e2594b88fd947a2f2d9c33
change-id: 20260813-tyr-reset-impl-93e951f996b4
prerequisite-change-id: 20261012-rust-workqueue-658cd0fbe770:v3
prerequisite-patch-id: f5e24f7b3717f2ab0445b5395c7f12b554861d78
prerequisite-patch-id: 0bf6ae4abcef7090d0e48921d6ec627a59dc6a7a
prerequisite-patch-id: e19d2e11fc6c6fc121d65c8502bfa557e1dfc5ec
prerequisite-patch-id: 89eb57a43e71850c447ea7cb7051fb36066ca329
