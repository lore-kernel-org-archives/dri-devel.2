Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ABA1099B39
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CFDA10EB8C;
	Fri, 20 Mar 2026 19:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qeog/oha";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C27A10EB8C;
 Fri, 20 Mar 2026 19:46:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C400643B86;
 Fri, 20 Mar 2026 19:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E52C4CEF7;
 Fri, 20 Mar 2026 19:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774036000;
 bh=hKFaHx/rV9ES8Nrcg8VcMJye1TEo/NvG2boQBSRvjm0=;
 h=From:To:Cc:Subject:Date:From;
 b=qeog/ohazEx+Dd6S4RUapklBDv/7RBg/CObkZCOa7DvX2HK5o4YxymKWDjY473e2r
 PgG0zChFLXqQsAyYOFV9LDS1cqguwr4x0CiD2o3BTh1ilYQN33tqxJ5GXLzxGqdcYb
 thEMuRkbT/uInb6qAghWBOtS6rUyES4PEvnj2qUJy/KqciaeMBSkkUj7Ob/o4iH/yj
 xthqoU/mynEsgZSBkgEcicR0mMabdtA8PIsXzJF/2I65io08vsiQeEB+HlYhro+bih
 PgHNHUtt7eVhPuzPMCi14/y2P9H7I95byXeh2PSc7MUyt2w8rMgnjXiYhrYve1xYtD
 ppME0dSPRHmZg==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com, acourbot@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com
Cc: driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/8] dma::Coherent & dma::CoherentBox API
Date: Fri, 20 Mar 2026 20:45:35 +0100
Message-ID: <20260320194626.36263-1-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
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

This patch series introduces the dma::Coherent API Gary worked out in the
context of his I/O projection work.

Additionally, introduce dma::CoherentBox, a type that encapsulates a
dma::Coherent object before its DMA address is exposed to the device.
dma::CoherentBox can guarantee exclusive access to the inner dma::Coherent
object and implement Deref and DerefMut.

Also add Coherent::init() and Coherent::init_with_attrs() so we can directly
initialize a new dma::Coherent object through an impl Init<T, E>.

Changes in v2:
  - Rebase onto the DMA and nova-core fixes that went into -rc4.
  - Rename CoherentInit to CoherentBox.
  - Add a bunch of #[inline] attributes.
  - Remove a few unnecessary trait bounds in "rust: dma: add generalized
    container for types other than slices".
  - Fix a typo and convert core::ptr::from_mut(&mut self[i]) into
    &raw mut self[i].

Danilo Krummrich (5):
  rust: dma: use "kernel vertical" style for imports
  rust: dma: introduce dma::CoherentBox for memory initialization
  rust: dma: add Coherent:init() and Coherent::init_with_attrs()
  gpu: nova-core: use Coherent::init to initialize GspFwWprMeta
  gpu: nova-core: convert Gsp::new() to use CoherentBox

Gary Guo (3):
  rust: dma: add generalized container for types other than slices
  rust: dma: add zeroed constructor to `Coherent`
  gpu: nova-core: convert to new dma::Coherent API

 drivers/gpu/nova-core/dma.rs      |  19 +-
 drivers/gpu/nova-core/falcon.rs   |   5 +-
 drivers/gpu/nova-core/gsp.rs      |  68 ++--
 drivers/gpu/nova-core/gsp/boot.rs |   7 +-
 drivers/gpu/nova-core/gsp/cmdq.rs |  21 +-
 drivers/gpu/nova-core/gsp/fw.rs   | 128 +++---
 rust/kernel/device.rs             |   4 +-
 rust/kernel/dma.rs                | 632 +++++++++++++++++++++++-------
 samples/rust/rust_dma.rs          |   8 +-
 9 files changed, 626 insertions(+), 266 deletions(-)


base-commit: a19457958c3018783881c4416f272cd594f13049
-- 
2.53.0

