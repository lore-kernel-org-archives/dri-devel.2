Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E126C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 17:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F4A10EFF5;
	Thu, 30 Jul 2026 17:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="j9fHb9Rl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6713C10EFF5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:05:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 08F8F429D6;
 Thu, 30 Jul 2026 17:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3EC9C19425;
 Thu, 30 Jul 2026 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1785431150; bh=WJNElWu592lk+DfJprCvpZbrcam1TYEaJCYoPn+lj7Q=;
 h=From:Subject:Date:To:Cc:From;
 b=j9fHb9Rl5d9NERcGB2Zo1Jolp6mP1QENUZAMC8PIPwk0DCdIDFrnzgEshkakI8dZf
 mm7PxC6os2+T3b4mjr/Y+Khr+eINlRLhEeSI6neGf8BTg3Tk9uqk3aN4azGnJbK45C
 16SlkczNhDhPn6k5Dg7YouLBO2gkXkeO/m8p/u9o=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9F323C55164;
 Thu, 30 Jul 2026 17:05:50 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Subject: [PATCH v2 0/9] drm/tyr: add debugfs support
Date: Fri, 31 Jul 2026 01:05:38 +0800
Message-Id: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKEa2oC/1XMQQqDMBCF4avIrDsliZLYrnqP4sKYiQ4ULYkGR
 bx7U7vq8n/wvh0iBaYI92KHQIkjT2MOdSmgG9qxJ2SXG5RQWphS4LwFdGSX3kdMCrWoO/LGOE0
 3yKd3IM/rCT6b3APHeQrb6Sf5XX9UqTTa6l+TKFCYyrbOydpI/XjxuKxXRwma4zg+qlmAN6wAA
 AA=
X-Change-ID: 20260730-tyr-debugfs-v2-608cef77d6e9
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, Wambui Karuga <wambui.karugax@gmail.com>, 
 Eric Anholt <eric@anholt.net>, Ben Gamari <bgamari@gmail.com>, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785431148; l=2996;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=WJNElWu592lk+DfJprCvpZbrcam1TYEaJCYoPn+lj7Q=;
 b=5uoDnSU8u5kq7EhDMiaBRuQHiGpZrD11Ztv+I5OqhiaghHW9Wpa0JFufAsAC3Mz0phtpateqv
 0WljLYcj1fAB/As9nX153I0hY4FuXbUXJcxYSbLv6+Np1EliuGd08Wz
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

Add debugfs support for the Tyr DRM driver.

The series adds a SeqShow trait for seq_file-backed debugfs files with
lifecycle hooks, a DrmSeqShow adapter with DRM device lifecycle
management, and a gpuvas debugfs file in Tyr exposing GPU VA space
information.

Additionally, fix a use-after-free in the DRM debugfs open/release
paths where a device could be unregistered while a debugfs file remains
open.

This is based on drm-rust-next and depends on:

[PATCH v10 0/7] drm/tyr: firmware loading and MCU boot support
  https://lore.kernel.org/r/20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com

See the full dependency and commit history at [1].

Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/11
Link: https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/59 [1]
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
Changes in v2:
- Reworked the debugfs implementation per feedback from Danilo on v1:
  dropped the hazptr/revocable-based approach in favor of the DRM
  debugfs_init callback and generic seq_file abstractions.
- Fixed a UAF in drm_debugfs where a device could be unregistered while
  a debugfs file remains open (drm_dev_get/put across file lifetime).
- Link to v1: https://lore.kernel.org/r/20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev

---
Alvin Sun (9):
      rust: seq_file: add as_raw() method
      rust: debugfs: add SeqShow trait and seq_file file operations
      rust: debugfs: add Entry::from_raw and ScopedDir::from_dentry
      drm: move debugfs_init after dev->registered is set
      rust: drm: add debugfs_init callback to Driver trait
      rust: drm: add DrmSeqShow seq_file adapter
      rust: drm: gpuvm: add dump_gpuva_info to UniqueRefGpuVm
      drm/tyr: add gpuvas debugfs file
      drm/debugfs: hold device reference for the lifetime of open files

 drivers/gpu/drm/drm_debugfs.c   | 45 ++++++++++++++++---
 drivers/gpu/drm/drm_drv.c       |  5 +++
 drivers/gpu/drm/tyr/debugfs.rs  | 65 +++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/driver.rs   | 16 +++++++
 drivers/gpu/drm/tyr/fw.rs       |  8 ++++
 drivers/gpu/drm/tyr/tyr.rs      |  1 +
 drivers/gpu/drm/tyr/vm.rs       |  5 +++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/debugfs.rs          | 35 ++++++++++++++-
 rust/kernel/debugfs/entry.rs    | 15 ++++++-
 rust/kernel/debugfs/file_ops.rs | 97 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/debugfs/traits.rs   | 30 ++++++++++++-
 rust/kernel/drm/debugfs.rs      | 49 +++++++++++++++++++++
 rust/kernel/drm/device.rs       | 36 ++++++++++++++-
 rust/kernel/drm/driver.rs       | 11 +++++
 rust/kernel/drm/gpuvm/mod.rs    |  8 ++++
 rust/kernel/drm/mod.rs          |  1 +
 rust/kernel/seq_file.rs         |  6 +++
 18 files changed, 422 insertions(+), 12 deletions(-)
---
base-commit: 0ffc014cb2abfc79d161662b125e085b3e7107e7
change-id: 20260730-tyr-debugfs-v2-608cef77d6e9

Best regards,
-- 
Alvin Sun <alvin.sun@linux.dev>


