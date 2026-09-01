Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A6FC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C9C10E64E;
	Tue,  1 Sep 2026 16:09:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gyPkn1JE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DAEB10E16A
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:09:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 757E6408C3;
 Tue,  1 Sep 2026 16:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48A8BC2BCF4;
 Tue,  1 Sep 2026 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788278956;
 bh=lhvqr0YNmYNoIT3ggMS891E1w+CGEgfi2rFuaQKH4aU=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=gyPkn1JEXJo3QyH8+uUaNRC6R6dXTKXcIUspzLl0VHEW7YygleQ6UX0DGAB/bx61B
 JLyzMV8V9w8dKES37a4+yxaasZLkzYFzbUvSou8aayMhGBqmKTKGRBnjyhjP+UAVdu
 2dxy/2FYEBi7DPaP7oEVVkjRp3AFZxLI7A1Bw+Nh2D9jnNOuWZ0OTDfoJrxJe7hKme
 ciL56OWimbUF3s+71pz/JIECOn5DXAeudMofPf6FMhldVPNZ02ySufe6G5OB2KWP7u
 bsXEqlgYwtBCbkG9ud9q12ZqM/ytT5AfLJfQ8Tgfo+LSt6n3cze3uL9xztnY4xJ6JV
 oerAI9G3/mvDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2281CC61DD3;
 Tue,  1 Sep 2026 16:09:16 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Subject: [PATCH 0/9] drm/tyr: add VM and BO ioctl support
Date: Wed, 02 Sep 2026 00:08:59 +0800
Message-Id: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJv4lmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwND3ZLKIt3M/OSSnGLdNEOD1DSDlOSktEQzJaCGgqLUtMwKsGHRsbW
 1AO+8sJJcAAAA
X-Change-ID: 20260901-tyr-ioctls-f10ef0dcbfa6
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788278954; l=1522;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=lhvqr0YNmYNoIT3ggMS891E1w+CGEgfi2rFuaQKH4aU=;
 b=GbkfXIDW39GboxU034l9GzN9Tiqr6XulAfvPJh7sfrXyDINKCLMkm70knCQ9US4+CJvXzLMtP
 0dBNuorJ9UVDYn9ZADuaLj9cY/ophtfF2gmKfXQBW1qNlmPyVMCSMp/
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
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
Reply-To: sunke@kylinos.cn
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Add the VM and BO ioctls to the Tyr driver, aligning its userspace
interface with panthor. The series is based on Danilo's `drm-file`
series on `drm-rust-next`, and uses the existing IdPool and xarray
abstractions for per-file VM management.

The panthor IGT tests pass on an RK3588S device.

Signed-off-by: Ke Sun <sunke@kylinos.cn>
---
Alvin Sun (9):
      rust: sizes: add SZ_4G constant
      rust: mm: add `task_size` helper
      rust: sync: arc: relax `ForeignOwnable` for `Arc<T>`
      drm/tyr: add per-file VM pool
      drm/tyr: add user and MCU VM specifications
      drm/tyr: add BO creation and lookup helpers
      drm/tyr: refactor new_dummy_object to use new_object
      drm/tyr: add VM-related ioctls
      drm/tyr: add BO-related ioctls

 drivers/gpu/drm/tyr/driver.rs   |  14 +-
 drivers/gpu/drm/tyr/file.rs     | 394 ++++++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/tyr/fw.rs       |   8 +-
 drivers/gpu/drm/tyr/gem.rs      |  41 ++++-
 drivers/gpu/drm/tyr/pool.rs     | 102 +++++++++++
 drivers/gpu/drm/tyr/tyr.rs      |   1 +
 drivers/gpu/drm/tyr/vm.rs       | 158 +++++++++++++++-
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/mm.rs               |   7 +
 rust/kernel/sizes.rs            |  12 ++
 rust/kernel/sync/arc.rs         |  12 +-
 11 files changed, 714 insertions(+), 36 deletions(-)
---
base-commit: 0b0aa9dcf17b6cffa9e325ff641e843b20d40c31
change-id: 20260901-tyr-ioctls-f10ef0dcbfa6

Best regards,
-- 
Ke Sun <sunke@kylinos.cn>


