Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497DEC43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 17:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D536410E64D;
	Sun, 28 Jun 2026 17:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UWDkqv2p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81F110E645
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D67B40DC5;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48069C2BCB4;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782666616;
 bh=PwlNzx3K3F56o2BD0ftoa1LBSTs0jszR297NCpWnCn8=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=UWDkqv2pfKYhQ4OAJLf1Px7BtXnAhlsLVWEeUOYxudUciqRglvmwrxy5nCr7DRHE0
 HRMNZsZfY+qVcsvUQu7v0r3xnunewXweUY1pshQt6/LmANQEMj8GC4qjmDlLyl5APA
 WspOV+Id3986XpwC2FSYjF0XpPYoTGzbi9CeSrN4A3zAXHcKJcIUf5oK2rk8P/cx0p
 qwVwtP+JcftOhoqN3FclMhspZpIZq2YGPiRyqSmbqCGER74wdNbkcl94i9Cyok0QX6
 03dWNOV5GL2tdwXQ8Td3OVAZtIevnrD1eFJiMS1XI3AGWXqrArkrqEPnlUjQLNLXF7
 tRj1tMVOZYjCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE75C43458;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
From: SeungJong Ha via B4 Relay <devnull+engineer.jjhama.gmail.com@kernel.org>
Subject: [PATCH RFC 0/4] rust: dma: bridge zerocopy-derived types into the
 transmute byte-safety bound
Date: Sun, 28 Jun 2026 17:10:13 +0000
Message-Id: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVVQWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyML3ZTcRN2q1KL85PyCSt2koswUoJKUZMNkS7MkM0OD5DQloM6CotS
 0zAqwqdFKQW7OSrEQweLSpKzU5BKQeUq1tQCn5ynvfAAAAA==
X-Change-ID: 20260628-dma-zerocopy-bridge-dc1c96b610cf
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 SeungJong Ha <engineer.jjhama@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782666615; l=2202;
 i=engineer.jjhama@gmail.com; s=20260103; h=from:subject:message-id;
 bh=PwlNzx3K3F56o2BD0ftoa1LBSTs0jszR297NCpWnCn8=;
 b=q7/VLPO9r7B4lnh9Bj4NW2kqXARN2Q6xgsnTBNKtxvVcYdLqm34c8NDzA9nV/lZBN23maujdg
 xt7Eb5HhZbqB8cxIrCIRuanFyZSLI/OySSfbWlBPbWgOB3L4sD+opGK
X-Developer-Key: i=engineer.jjhama@gmail.com; a=ed25519;
 pk=G5nmjm+RTiWBpyCvc5xjR1b3li/2zipLSMyz+T4fj5E=
X-Endpoint-Received: by B4 Relay for engineer.jjhama@gmail.com/20260103
 with auth_id=590
X-Original-From: SeungJong Ha <engineer.jjhama@gmail.com>
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
Reply-To: engineer.jjhama@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

DMA-coherent allocations (CoherentAllocation/Coherent/dma::Pool) bound
their element type on kernel::transmute::{AsBytes, FromBytes}. This RFC
lets a type satisfy that bound by deriving zerocopy's byte-safety traits
instead of a hand-written unsafe impl.

The bound cannot be switched to zerocopy wholesale (some DMA structs are
unions that IntoBytes cannot derive), and a blanket bridge impl is
rejected by coherence. So the series bridges the two per type:

  1. add the bridge macro impl_transmute_via_zerocopy!, which emits the
     transmute impls only for a zerocopy-derived type.
  2. re-export zerocopy::Immutable from the prelude.
  3-4. worked example: convert nova-core's GspMem and msgq POD types.

This series was prepared with the Claude Code AI assistant (model
claude-opus-4-8): it drafted the macro, the nova-core conversion and the
changelogs, which the submitter reviewed and takes responsibility for. It
was verified by building nova-core on rust-next and a negative test
confirming IntoBytes rejects mis-sized padding. See
Documentation/process/coding-assistants.rst.

Assisted-by: Claude-Code:claude-opus-4-8
Signed-off-by: SeungJong Ha <engineer.jjhama@gmail.com>
---
SeungJong Ha (4):
      rust: transmute: add `impl_transmute_via_zerocopy!` macro
      rust: prelude: re-export `zerocopy::Immutable`
      gpu: nova-core: gsp: derive zerocopy traits for the msgq POD types
      gpu: nova-core: gsp: convert GspMem to zerocopy via the transmute bridge

 drivers/gpu/nova-core/gsp.rs                      | 13 ++-------
 drivers/gpu/nova-core/gsp/cmdq.rs                 | 15 +++++-----
 drivers/gpu/nova-core/gsp/fw.rs                   |  8 +++---
 drivers/gpu/nova-core/gsp/fw/r570_144.rs          |  2 ++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  4 +--
 rust/kernel/prelude.rs                            |  2 ++
 rust/kernel/transmute.rs                          | 35 +++++++++++++++++++++++
 7 files changed, 54 insertions(+), 25 deletions(-)
---
base-commit: 780d569e6c4b422290f5cba319eb904b355d64be
change-id: 20260628-dma-zerocopy-bridge-dc1c96b610cf

Best regards,
--  
SeungJong Ha <engineer.jjhama@gmail.com>


