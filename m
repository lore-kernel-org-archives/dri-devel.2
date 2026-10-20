Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C2606A320
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FupvrTXL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5597110F3B7;
	Tue, 20 Oct 2026 08:26:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3E610F39F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:25:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B19AF4482F;
 Tue, 20 Oct 2026 08:25:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792484750;
 b=zWaNAvCmp5xdHjoFVqp/S2tloPsgzZO/3AUQQLGH6vRbHIQAIitTaf3p5sKbxWq0DoKF
 WN56UFKdp4tNTSiRwtSIhoAv1JHDirBq1fP8FvCeL6AJyP27G0BYuzegVmPUq/zdGJvK7
 1qHJVF6G72GF4Kt8HiBuqFsspsMW/ZiCjI7EbSkeHRxPLvMqSzFMtv+s1GBiBYhzJuSBK
 ydQjDARS9RJG5IfgNEC7fdXqF+Trem4hejZvCt3WXf2bNIZNaVeq5V7wctm6TGUCykVxg
 lNVgtRQzQwX91/xclFRFNYddKRv0QK9CRzKo97U5PcAHSOFGA/oHJGspLngg9V9kg2Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792484750;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=e+6nVyZLjebD5QCGUBHeGP+gzXckIy/LBOsLfc7yS0k=;
 b=pqlQPlQ7VIlPFmsp1K1e8pkIf3iIOOBtoagTpqL90lfUy5BsjEz3dGEsrY2UnJaduBwP
 gJm/RBH/jpzrHiPsUPrRlsZoQYSsFYDYd96KlORE3saqTfHgquCl0YSIBAUe/rTgU1/lO
 46mTxToN2A7FUqrPLhmr0iulRztQvRP8Rmqcolbi5kRHszVSF+Myp7XZ0AJbq4Xerrevn
 Td/bdlUrIjEtyIZD50pyFsbAi6UsXr/5LiTclocerpBN2Y43TRIpsIbq3gUwc7XZLzkUD
 1egnirFHAu7hRHraX6zdLvij9x9GVGml1Q4qpeiq4MPamaS/WL8QOQslOJtOZJgR54A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 44FC21F000C5;
 Tue, 20 Oct 2026 08:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792484750;
 bh=e+6nVyZLjebD5QCGUBHeGP+gzXckIy/LBOsLfc7yS0k=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=FupvrTXLH0LyxcAiC5Xh4k52MGgHqL2LniyJyWZ3PTCjp8d3Rv9FXaQ+1BpKr2mwM
 kQcOFNxiqR7+OMcHRCW8JXZvIcIEd0DQIdq3SVvFepgYZcJ06gREA9H4Y6frdJvra3
 dBZN7IlJOLNY8Rqj6lLZbTRf2nBiD64foNGx20h02Ldl8q+MNiDd7SmpRTP3xvxL7s
 cCt5lX/dnp4GzNJITqXbrRehsFezw5U1YVLruqNu5le80gesEpUUTwjqwqdXYdE4WI
 fR/sb16vDxlokb+/uRFztXbJxX9yiRrmuVfWhjfH1zJsoowLXhYNsFadmxhckCSTxR
 cXbPrNogiANuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9371A430CE;
 Tue, 20 Oct 2026 08:25:45 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Subject: [PATCH v4 00/11] drm/tyr: add VM and BO ioctl support
Date: Tue, 20 Oct 2026 16:25:17 +0800
Message-Id: <20261020-tyr-ioctls-v4-0-704de77da223@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG0l12oC/02Nyw6CMBBFf4V07Zi2CAmu/A/Doo+pNGJrppVAC
 P9uIS5cnntzclaWkDwmdq1WRjj55GMocDlVzAwqPBC8Lcwkly3vuIC8EPho8pjACY6OW6Odalk
 RtEoImlQww65YegF9UoaAc97/N6Hz8xG794UHn3Kk5WhP9b7+MrL7z0w1cJBt1zROCyFsc3suo
 w8xnU1g/bZtX1s/RDLFAAAA
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
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org, 
 driver-core@lists.linux.dev, Ke Sun <sunke@kylinos.cn>, 
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792484721; l=4895;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=0W/Zzd3YJxNeZ/dKwlzvsYXdPOz5NCl/hBwAO8KxQJc=;
 b=ZCt+HemY9ZaAgV5qL4JXMw4PoShS3j9pE/9zTZikxUtm+7rqPO/xfi9uboxExmsU0kTCg74MU
 gOX+ht0Cji7BgDZkLM5fZzFZylhpPfO6T9gA38oJuHNgYfFVa4c2MgP
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

To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: Tamir Duberstein <tamird@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
To: Onur Özkan <work@onurozkan.dev>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Lyude Paul <lyude@redhat.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org
Cc: driver-core@lists.linux.dev

---
Alvin Sun (8):
      rust: sizes: add SZ_4G constant
      rust: mm: add `task_size` helper
      rust: sync: arc: relax `ForeignOwnable` for `Arc<T>`
      drm/tyr: add per-file VM pool
      drm/tyr: add user and MCU VM specifications
      drm/tyr: add BO creation and lookup helpers
      drm/tyr: add VM-related ioctls
      drm/tyr: add BO-related ioctls

Sami Tolvanen (3):
      rust: device: expose the device DMA attribute
      drm/tyr: gem: flush write-combine BOs from probe-time coherence
      drm/tyr: gem: map cached BOs for DRM_PANTHOR_BO_WB_MMAP

 drivers/gpu/drm/tyr/driver.rs   |  24 ++-
 drivers/gpu/drm/tyr/file.rs     | 407 +++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tyr/fw.rs       |  21 ++-
 drivers/gpu/drm/tyr/gem.rs      |  76 +++++++-
 drivers/gpu/drm/tyr/vm.rs       | 357 +++++++++++++++++++++++++++++++++--
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/device.rs           |  24 +++
 rust/kernel/mm.rs               |   7 +
 rust/kernel/sizes.rs            |  12 ++
 rust/kernel/sync/arc.rs         |  12 +-
 10 files changed, 891 insertions(+), 50 deletions(-)
---
base-commit: 015bdd5eb1e4a1a35673727f294a88fb0969c77c
change-id: 20260901-tyr-ioctls-f10ef0dcbfa6

Best regards,
--  
Ke Sun <sunke@kylinos.cn>


