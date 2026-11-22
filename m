Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD12606A339
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 05:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=mfpJO7Zo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE4E10E0A0;
	Sun, 22 Nov 2026 05:41:12 +0000 (UTC)
X-Greylist: delayed 62151 seconds by postgrey-1.36 at gabe;
 Sun, 22 Nov 2026 05:41:06 UTC
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB6210E0A0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 05:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1795326060; x=1795585260;
 bh=KpKNpsKBCC7ODeWhRxzgnBysPsuws4qbswjAYJm1i2c=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=mfpJO7ZoDz6WRiZ3XhQe60vMd3Fz3mdWkY+rBOga6jhKoD29SMZab77R7ypqhkufn
 X9JtY2nD+xR3kqDaTy9Ml+SqHv00b9fiowSgO9f1u69seSMvrv7mw2+dKPzLxacvRK
 wQu9uwqJQcqyccbq2aFaXMpnOi5fJLvIbx1YaEDJ8Vwp7OtGjE0JYbJxA+LC5+HcF6
 e9YrS7CARZDV/x14Po3JGVJqAO0zy73sCEobI6lkqaw/QpfAZkt9LgcG2IU4DcZXLv
 aC1gyu3Hs/+ZtXF74uWolzqybjtpJ4lkQ8y/DGHpIHYeMvVC2aSSruX9aDnmltIu25
 IlGeFob9Sivng==
X-Pm-Submission-Id: 4jXHx34gQCz1DDLH
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, boris.brezillon@collabora.com,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v9 0/2] drm/tyr: GPU reset infrastructure
Date: Sun, 22 Nov 2026 08:40:31 +0300
Message-ID: <20261122-tyr-reset-impl-v9-0-ed42d8f513ec@onurozkan.dev>
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

Based on drm-rust-next commit 0694e2390c5b ("rust: drm: remove DRM
device private data").

Changes since v8:
- Use workqueue v4 [1].
- Drop "drm/tyr: clear stale IRQ state before soft reset" (applied on
  drm-rust-next already).
- Minor fixes (Alice's notes on v8).

V8: https://lore.kernel.org/all/20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev/

Link: https://lore.kernel.org/all/20261119-rust-workqueue-v4-0-707c68994940@google.com/ [1]
Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
Onur Özkan (2):
      drm/tyr: add GPU reset infrastructure
      drm/tyr: put iomem behind the hardware gate

 drivers/gpu/drm/tyr/driver.rs            |  67 ++++-----
 drivers/gpu/drm/tyr/fw.rs                |  16 +-
 drivers/gpu/drm/tyr/mmu.rs               |   6 +-
 drivers/gpu/drm/tyr/mmu/address_space.rs |  87 ++++++-----
 drivers/gpu/drm/tyr/reset.rs             | 243 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/reset/hw_gate.rs     | 106 ++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs               |   1 +
 7 files changed, 440 insertions(+), 86 deletions(-)
---
base-commit: 0694e2390c5be63aae9d713a173df18d82d3b94b
change-id: 20260813-tyr-reset-impl-93e951f996b4
prerequisite-change-id: 20261118-ordered-wq-cancel-63b02e0feac4:v1
prerequisite-patch-id: 7a1020bc70ad38e61214d85202e04b1db3c95443
prerequisite-patch-id: dbf1c8ccc147075be256faf6a547d9723c347a93
prerequisite-change-id: 20261012-rust-workqueue-658cd0fbe770:v4
prerequisite-patch-id: 2423b22dfde216dce30af3deb7eb7177505f5b96
prerequisite-patch-id: f5e24f7b3717f2ab0445b5395c7f12b554861d78
prerequisite-patch-id: 0bf6ae4abcef7090d0e48921d6ec627a59dc6a7a
prerequisite-patch-id: cba4cd096a4df20f4597e9ea639881213c18a41b
prerequisite-patch-id: 97b26feddfa5b675204c9e8e75f3ad2958ec268a
