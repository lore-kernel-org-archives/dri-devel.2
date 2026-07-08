Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E632EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA4410F0E4;
	Wed,  8 Jul 2026 11:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="L7CsT0o0";
	dkim-atps=neutral
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1AF10F0E4
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1783511046; x=1783770246;
 bh=98BuDxfPN3ycydYh5YeFIerx+ZVFF9AZgH6hOQcVjdo=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=L7CsT0o0Y53yVoFSIfMCKLGfGaR+REZF1Mm4w+PsVFNu4Z3HFld0Z+l+kJYgCsigs
 bsCJOYfxAdjSem5UAuZFKAEQCSR5wq0LhOuTlAnT6PVyaFUts5TTstDiRg0nDhzCBT
 eJ+Jhs3+23bNkApTf0IpyHk9+4mzVsc7EOkR4WZxdPjybXIyc1RVCHOcC9LUcesvvs
 IeKGacDawQRsESBGuBfFz83iyEwzChT8Kj//FANRLCt8j+1XhBDmL8qSBZEHp6U4xP
 MJJmy00BR42cvO+wF8khWo6oHji3hfyptauiH762zaO4YEaMKdRQz9ieYuUlB0lqFT
 Nnb94ckqPxU+g==
X-Pm-Submission-Id: 4gwGTF5LHhz1DDLC
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v3 0/3] implement GPU reset API
Date: Wed,  8 Jul 2026 14:43:15 +0300
Message-ID: <20260708114358.957305-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add support for scheduling GPU resets on a dedicated workqueue. Track
the reset state to avoid queueing another reset while one is already
pending or in progress.

Use an SRCU based gate to block new hardware access once a reset is
scheduled and wait for current users before starting it. Run the
pre_reset() and post_reset() hooks around the reset sequence so driver
components can prepare for a reset and restore their state afterwards.

Model the reset stages with a typestate pattern where each operation
consumes the current state and returns the next one. This keeps the
pre_reset(), GPU reset and post_reset() calls in order and prevents
a stage from being called twice accidentally.

Stop new reset requests during teardown and drain any queued or running
reset work before releasing the device resources.

Also move the existing synchronous reset sequence into the reset module
and use it for both the initial reset and scheduled resets.

This implementation is WIP and will be followed with more work later. It
should be safe to land this series as there's no hardware using this API
yet.

Based on 'commit 53441a9cae3c ("drm/tyr: program CSF global interface")'
from tyr-for-upstream with the following patch series on the ML:
	- rust: workqueue: add cancel_sync support [1]
	- rust: add SRCU abstraction [2]
	- rust: workqueue: add ScopedQueue for lifetime bound items [3]
	- Creation of workqueues in Rust [4]

TODOs:
  - On post_reset() failure, we don't do anything for now. We should
	unplug the GPU (that's what Panthor does) but we don't have the
	infrastructure for that yet [5].
  - In schedule(), similar to panthor_device_schedule_reset(), we should
  	have a PM check but similar to the note above, we don't have the
	infrastructure for that yet.

Changes since v2:
	- Replaced Work::disable_sync with Work::cancel_sync.
	- Used type state pattern for reset stages.
	- Using ScopedQueue with device lifetime instead of a static workqueue.
	- Removed SRCU patch from this series.

Changes since v1:
  - Removed OrderedQueue and using Alice's workqueue implementation [1] instead.
  - Added Resettable trait with pre_reset and post_reset hooks to be implemented by
    reset-managed hardwares.
  - Added SRCU abstraction and used it to synchronize the reset work and hardware access.

v1: https://lore.kernel.org/rust-for-linux/20260313091646.16938-1-work@onurozkan.dev
v2: https://lore.kernel.org/rust-for-linux/20260416171728.205141-1-work@onurozkan.dev

Link: https://lore.kernel.org/all/20260617131731.145337-1-work@onurozkan.dev [1]
Link: https://lore.kernel.org/all/20260613065348.96750-1-work@onurozkan.dev [2]
Link: https://lore.kernel.org/all/20260617144645.253444-1-work@onurozkan.dev [3]
Link: https://lore.kernel.org/all/20260312-create-workqueue-v4-0-ea39c351c38f@google.com [4]
Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/29#note_3391826 [5]
Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28

Onur Özkan (3):
  rust: workqueue: impl Send and Sync for OwnedQueue
  drm/tyr: clear stale IRQ state before soft reset
  drm/tyr: add GPU reset infrastructure

 drivers/gpu/drm/tyr/driver.rs        |  39 ++--
 drivers/gpu/drm/tyr/reset.rs         | 323 +++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/reset/hw_gate.rs | 298 ++++++++++++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs           |   1 +
 rust/kernel/workqueue/mod.rs         |   8 +
 5 files changed, 644 insertions(+), 25 deletions(-)
 create mode 100644 drivers/gpu/drm/tyr/reset.rs
 create mode 100644 drivers/gpu/drm/tyr/reset/hw_gate.rs

-- 
2.51.2

