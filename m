Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E8606A322
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kT8iBI1x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE93510F03B;
	Mon, 26 Oct 2026 16:41:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E5E10F03B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:41:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A86543875;
 Mon, 26 Oct 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793032875;
 b=aa4ePNeN2I/BukVnUc/+lYhitDGVtUpqcCXPz9ehNcBn5dI29ptApSDMGqIV0/ygj90h
 0eZ1DtN5UosGj5H1/AiTXcgeRDtduose/MR45WFYHA6AMlg82osp/QchqVsqpjtDluovD
 a+vO7FlcibUcc0T2fdE+b77TcLmtCWbukqi2aopynxBekfSaBooJIAtMwJRYNi4t6UrO4
 jisKTEU102pPi5p0dhC6MTIHpINTLjsMbGx0of7Bcj41U5A7yo1LhOiKVyLpB0gcQqROR
 5pKzgr82G1MCFkTSQcpLIpiWv/Oy5uj7G/yZdyrWBwFSdPzwKPJLt/CRz1VWBp+i8MA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032875;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=gztH9BpgmL/L02GYe9EFLepQqn23j0pk11maH6aMPrw=;
 b=CYDOH7nAbk/Gb5KZbN0TgIM4I8g8I8j5CS7WSeHF9tAiRLCRpyMOYa0UwCl+O5P8Wgwt
 9biLSEHqbQCftVGdizTQPUOBQG2SY+psCqba8CrAfWa0cNwzXYSC4+spfyTHWRG5Nd91N
 wFlvypEG/Qee69RwShNWyWhZYI+f6TtjT04Gju98xpZQWig2P2Nu+GMpoqsfJx9kO+bcI
 XdZ4nsFd9BEP3AGpFP4LZtF9mMAPPe9Gu5Qe4hw0qCMSnwbSg8MIA98ResFjZ6V7aD+80
 u/v/sabM7/REozv9oLNe2V0PTQ22OOEchj4oLkHflSLoYznfGhJsJDGn7SapagIxKXg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C1B651F01825;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793032875;
 bh=gztH9BpgmL/L02GYe9EFLepQqn23j0pk11maH6aMPrw=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=kT8iBI1xOsKmSLmOhsRTRm/M1doF2JCMuhIh6tnSrjvXYH7YsJRZ7NwWLBoMN96pk
 DV8h3qGqBqArsI/Ok+8S35XbO3pq9H+fRovS80ND/I6DXG1w6Q4qf8OP5nl6vnJ41M
 pcoykT/NqKPLUjK13r7pxZCXnAXcv39lGlwkgBCzeWB5/HANn5+f0FfpZvCwI5H24B
 Pm/bY+a6PVO37Ae1bcsfS4szxR7ESiXKSFIRwGK8DryKlrCH2iGIA2UZ3/vZ3LFB54
 3HrNfSEpCSjz0ZquGaM1a2Q/oDBlM6hkpJ8EhtdxTzDYtjWKLAxuVe0mWjlwwQrQrT
 SvjmIM35Tn95A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 400C144DBE;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Subject: [PATCH v5 00/11] drm/tyr: add VM and BO ioctl support
Date: Tue, 27 Oct 2026 00:40:53 +0800
Message-Id: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJaC32oC/1WNzQ6CMBAGX8X07Jpt+QuefA/jobRbacRi2kogh
 He3EGPkOLuZb2YWyFsK7HyYmafBBtu7BMXxwFQr3Z3A6sRMoCixRg5x8mB7FbsAhiMZ1KoxsmR
 JaGQgaLx0ql0V7Z/g3yGCozGu/5cnY8ctdr0lbm2IvZ+29pCt129G1P+ZIQMEUdZFYRrOuS4uj
 6mzrg8n5di6M+Q/l6PAnZsnt8JcU1VpKUS2c5dl+QBMNEAyAQEAAA==
X-Change-ID: 20260901-tyr-ioctls-f10ef0dcbfa6
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
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793032870; l=4531;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=bBAFke2fJNrZEEGOOQEc7TX5IdMqHI9K3Ku4aJdqwK4=;
 b=nCwTUaF+5xXHNkykuInJkW3epGCTNQqM0QAwLO4uTbgJOFCY8AtlgQi++hWoCzHuFaT6uRtSI
 i1s7CmZyYbiDveCKqPxwj0jdjAv7A8KHl5K0K9Rw/9xGQ01qf0m9xSD
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
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
Reply-To: sunke@kylinos.cn
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the VM and BO ioctls to the Tyr driver, aligning its userspace
interface with panthor.

The series is based on Danilo's `drm-file` series on
`drm-rust-next`. It also carries Sami Tolvanen's buffer
cache-management patches from
https://gitlab.freedesktop.org/panfrost/linux sami/tyr/7.3/dev.

The panthor IGT tests pass on an RK3588S device.

A branch with the full series and all prerequisites applied is
available at:
https://gitlab.freedesktop.org/alvinsun039/linux.git tyr-ioctls

Link: https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/64
Signed-off-by: Ke Sun <sunke@kylinos.cn>
---
Changes in v5:
- Replace the mm-based task_size() (always returned 0) with Sami's
  CurrentTask::task_size() implementation (Deborah, Alice).
- Use from_safe_cast() for the id conversions and annotate the AddError
  fields so the VM pool patch compiles on its own (Deborah).
- Store a clone on pool conflicts and return the caller's VM instead of
  expect()-ing (Deborah).
- Drop the redundant project() in PinnedDrop (Deborah).
- Fix the rustfmt issues found in the series (Deborah).
- Link to v4: https://patch.msgid.link/20261020-tyr-ioctls-v4-0-704de77da223@kylinos.cn

Changes in v4:
- Rework VmPool teardown: add() returns an AddError the caller owns,
  a conflicting stored VM is killed with EBUSY, and remove() kills
  before the ID is reused (Daniel, Deborah).
- Wrap dev_dma_attr in a DmaAttr type with dma_attr()/is_coherent()
  and rename the patch accordingly (Danilo).
- Fetch the sg_table unconditionally in new_object() and drop the
  conditional flush call (Daniel).
- Use dev_dbg!() instead of dev_err!() for user-input validation and
  EOPNOTSUPP for the async VM_BIND path (Daniel).
- Drop the pr_err!() calls from the VM specification patch (Daniel).
- Link to v3: https://patch.msgid.link/20260929-tyr-ioctls-v3-0-26955fb111d5@kylinos.cn

Changes in v3:
- Drop the VmOwner wrapper and kill VMs explicitly on destroy and
  file close (Deborah).
- Add Sami Tolvanen's buffer cache-management patches: coherent
  devices map buffers cached, write-combine buffers flush at
  creation, and BO_CREATE accepts WB_MMAP.
- Drop the new_dummy_object refactor; the dummy object stays a direct
  Bo::new since new_object now fetches the sgtable for write-combine
  buffers.
- Document the LargeSizeConstants trait in the sizes patch (Miguel).
- Misc commit message and comment cleanups.
- Link to v2: https://lore.kernel.org/r/20260908-tyr-ioctls-v2-0-88bea777df67@kylinos.cn

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
- Report VA-split failures with dev_err! at the caller.
- Link to v1: https://lore.kernel.org/r/20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn

---
Alvin Sun (7):
      rust: sizes: add SZ_4G constant
      rust: sync: arc: relax `ForeignOwnable` for `Arc<T>`
      drm/tyr: add per-file VM pool
      drm/tyr: add user and MCU VM specifications
      drm/tyr: add BO creation and lookup helpers
      drm/tyr: add VM-related ioctls
      drm/tyr: add BO-related ioctls

Sami Tolvanen (4):
      rust: task: add task_size()
      rust: device: expose the device DMA attribute
      drm/tyr: gem: flush write-combine BOs from probe-time coherence
      drm/tyr: gem: map cached BOs for DRM_PANTHOR_BO_WB_MMAP

 drivers/gpu/drm/tyr/driver.rs   |  24 ++-
 drivers/gpu/drm/tyr/file.rs     | 407 +++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tyr/fw.rs       |  21 ++-
 drivers/gpu/drm/tyr/gem.rs      |  76 +++++++-
 drivers/gpu/drm/tyr/vm.rs       | 355 +++++++++++++++++++++++++++++++++--
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/task.c             |   6 +
 rust/kernel/device.rs           |  24 +++
 rust/kernel/sizes.rs            |  12 ++
 rust/kernel/sync/arc.rs         |  12 +-
 rust/kernel/task.rs             |  12 ++
 11 files changed, 900 insertions(+), 50 deletions(-)
---
base-commit: 0315936d31de6de2668d14294486aebaaeece4b3
change-id: 20260901-tyr-ioctls-f10ef0dcbfa6

Best regards,
--  
Ke Sun <sunke@kylinos.cn>


