Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4317CC79FA7
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D8110E2FF;
	Mon,  7 Sep 2026 16:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mCXN2QAe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90C510E2FF
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 16:48:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 821E440367;
 Mon,  7 Sep 2026 16:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EB02C2BCC7;
 Mon,  7 Sep 2026 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788799695;
 bh=ugf+3s9PSyGAiuRrMcsfXDjILNpU++jjwzu5JJ9giJ8=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=mCXN2QAeH0qjPksLPGX5Sd8iHxXfjvSJRxd1ISUNWifwnPguwXvkXl6QbDKdDRZ7F
 FycIffpGIFKcxr00LwyM2KZtNUZZybn+DiXP0zzFAKoOs7coYSuyV3u7LwdsaxbUPu
 bVVhLTk218fT+pKP4vYlwdtWMUMSo71ByYRmPmIUGiT/8a8iSKEiSSx+i5qPM//IVh
 m8LyvKUkjhkjOHthoJ6YtomjxgbLOFRyy7EivO77F3/t/NUHB9EHrXdjtVISUA5twH
 wn8EE06bFkDLXCgZb2yVt02GsxyBcgEQ2i3j3HWjxqksvICbBmvfIeE80s/zs+15GC
 T5fSJDDUo4uCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB26C79F99;
 Mon,  7 Sep 2026 16:48:15 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Subject: [PATCH v2 0/9] drm/tyr: add VM and BO ioctl support
Date: Tue, 08 Sep 2026 00:47:47 +0800
Message-Id: <20260908-tyr-ioctls-v2-0-88bea777df67@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPqnmoC/03MQQrDIBCF4auEWdcyughpV71HySLq2AwNWlSkE
 rx7baDQ5f/gfTskikwJrsMOkQonDr6HOg1g1sU/SLDtDQrViBeUItcoOJi8JeEkkkNrtFtG6Id
 XJMfvA7vPvVdOOcR62EV+1x+j/pkiBQpCZ7WbtJU43Z51Yx/S2XiYW2sfnoRSEqUAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799692; l=2330;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=ugf+3s9PSyGAiuRrMcsfXDjILNpU++jjwzu5JJ9giJ8=;
 b=ZORc0oMwW5l3N9ppq/jrr9PENAwfIkL5qA+VfygKJi+UlDdBIzYqYtuMxE/JT6moDx0PZvFco
 ld1n0m+H8x2Ckk3gfwq9rUCzc5HpBK9X+Slchoo7nftAcQTpie/H7z0
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

A branch with the full series and all prerequisites applied is
available at:
https://gitlab.freedesktop.org/alvinsun039/linux.git tyr-ioctls

Signed-off-by: Ke Sun <sunke@kylinos.cn>
Link: https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/64
---
Changes in v2:
- Fold the VM pool into vm.rs and cap it at 32 VMs per file (Deborah).
- Add VmOwner so a VM is killed exactly once on drop, regardless of
  remaining references (Daniel).
- Replace the VmSpec enum with new_for_fw()/new_for_user()
  constructors (Daniel).
- Parse VM_BIND op types via VmBindOpType and use the kernel
  Atomic<bool> for the unusable flag (Daniel).
- Use PAGE_SIZE for the dummy object size (Daniel).
- Rename BoData::create_flags() to flags() (Daniel).
- Report VA-split failures with dev_err! at the caller (Deborah).
- Link to v1: https://lore.kernel.org/r/20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn

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
 drivers/gpu/drm/tyr/file.rs     | 378 ++++++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/tyr/fw.rs       |  37 ++--
 drivers/gpu/drm/tyr/gem.rs      |  41 ++++-
 drivers/gpu/drm/tyr/vm.rs       | 378 ++++++++++++++++++++++++++++++++++++++--
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/mm.rs               |   7 +
 rust/kernel/sizes.rs            |  12 ++
 rust/kernel/sync/arc.rs         |  12 +-
 9 files changed, 819 insertions(+), 61 deletions(-)
---
base-commit: 3ac51829f95368876dcfbfbb42823ca0cd6e6f56
change-id: 20260901-tyr-ioctls-f10ef0dcbfa6

Best regards,
-- 
Ke Sun <sunke@kylinos.cn>


