Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAC606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EveH983A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D3F10E2C0;
	Mon,  9 Nov 2026 00:37:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227E810E1E3
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 00:37:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 007B343C17;
 Mon,  9 Nov 2026 00:37:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794184624;
 b=j67VkOEk4f3U/PWI0iz59IZA9pr6Ijk6uz9Z7j7kuMPItkXFbeK+RbUs0JuB7l8XOEV3
 GxLDrWwHAd9CCCqrqk5dy9LlxgooHN7gYL5RiPbU4lDFL1SedoaOBSfoMsYsDfci+FymL
 jminWFV7E8VajQZx9aiK6Qu+PEy+hbt6voavIhUDHkQ1NsfQ6wHFI9laxJ2FZhq1kcOBp
 AzgE5wTeqKokovT+BLuM9S9FxyJfsf/f7Cv3lzJlgfH3vP5ZXLZ6bQ8bbLaeHOKFlMyl8
 hGp0fZ8iGRB9K1HuWhAQywGwJ3WDdIQ3PlDcoEEKR+oEmb4J2S7N9T08pyA65mYxUOQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794184624;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=9mhc6/Wh+icVyQadKHDl7NOuRUEYQpTaSVOjSJf9BhQ=;
 b=CQrml4Pn8TKZqSE4rvnS42io1lViR401HQmWXnX+uBWi68+b8z8q10U2gmlX9Zlb6XqF
 g1AavaEBigH8/v4tm2cQxms5JQJlVXbRpdYda0NsmwaQ4EBZZFTH8e8LuMib4yFYhWwi2
 SkHE7LdJ2UsUB6Vt5ItZtnXJyRNOU69d+HdLKpp3n/Atq9pgiy6f98h7Rj6dvqfkwqVqd
 Ac4yUTmQbQW2AW0sf4dc8j0jggBwGCdkpO0a2mwekuDxMXbuUOLeZ6+FN+/m4E6c7heOt
 WWR5msjh9p30Z5Psa711tnGhzTkPw3mKmP9v6X6CgP2G5VG2/yRm+5sbf67PdgCHf5w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9F5991F008A2;
 Mon,  9 Nov 2026 00:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794184624;
 bh=9mhc6/Wh+icVyQadKHDl7NOuRUEYQpTaSVOjSJf9BhQ=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=EveH983AeqzLMR34pucaRkXxJsLNoIJ3eTT1HPouCqyJ2calJBKPR2NLiG4PcuVnl
 PdIlBjPwtEGD5lBaCIYnPY33ZfzNIlrhGiRqCr/Pm9kRw+7QXsZ1wYgc9tVPyr8iGB
 CMg/M+R58yP2upmihu3mk1flc5URKYkLJ/co6A+BSw7LXAHzfom7C5XO2MP4kONw4E
 o2sd0R8W4MkjQnyHrS/tzR1dJW3x7j4whPXiSKIQbedDw6qSN9IMkkdb/OdhX2jdVB
 gjWoIzxob8RMPfdB9axSZuXPaIMAY+I03htEYxMzdJbT9/vRBA3NZvZtjMXvOEJ0/E
 lsJ9ho77kBNcQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F273B481A2;
 Mon,  9 Nov 2026 00:37:01 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Subject: [PATCH v6 00/10] drm/tyr: add VM and BO ioctl support
Date: Mon, 09 Nov 2026 08:36:43 +0800
Message-Id: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwV8WoC/2WQzW7CMBCEXyXyuUZrxz8YVRXvUfXg2GuwIE5rh
 wiEePc6oUKgHmdX387OXEnBHLGQTXMlGadY4pCqUG8NcXubdkijr5pw4AoMMDpeMo2DG4+FBgY
 YwLsuWEUq0NmCtMs2uf2M+NzTfCojTXge5/13xhDPi9nnV9X7WMYhXxbvqZ2nfzbcPNtMLQXKl
 ZEydIwxL7eHyzGmoaxcIvOdSTxYBhxeWFFZDcKj1t5y3v5j5TOrX1hZWWl8QLN2HcAre7sHyvh
 zqqWN91Skx1LsUtqmeV+OMtDAmeB6xRnIVgvKqLeHvD1gTnhcDXn38SjPDX0fx03jaq/Or8GgV
 MI5a6xbc2FbZZwx0nYawTMV2vrG7RfsvIVxwwEAAA==
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
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184620; l=6331;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=oGqTiUtORqt7n4EG0Z3MQXdgq8LN86uO3RFcLiKSUTQ=;
 b=D20rai7ipiOrUaAh7pEnAyLO6C4APPpErqt2r4hevEwbnSFlX5WF2owYIQA4WoNROZJgmc5Vm
 A06zMI3l3NpA5SeC3vx4DEekQ48W0cXRJtsxcuR987jdak1C6NiiNyF
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the VM and BO ioctls to the Tyr driver, aligning its userspace
interface with panthor.

The series is based on v2 of Danilo's lifetime-parameterized DRM File
private data series:
https://lore.kernel.org/all/20261107021427.2105374-1-dakr@kernel.org/

It also carries Sami Tolvanen's buffer cache-management patches from
https://gitlab.freedesktop.org/panfrost/linux sami/tyr/7.3/dev.

The panthor GEM and VM IGT tests pass on an RK3588S device. The group
and dev_query tests are not supported yet.

A branch with the full series and all prerequisites applied is
available at:
https://gitlab.freedesktop.org/alvinsun039/linux.git tyr-ioctls

Link: https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/64
Signed-off-by: Ke Sun <sunke@kylinos.cn>
---
Changes in v6:
- Rebase onto v2 of Danilo's lifetime-parameterized DRM File private
  data series and use the Driver::File<'a> associated type instead of
  ForLt.
- Drop the unrelated Firmware::new closure rework from the VM
  specifications patch (Deborah).
- Merge the write-combine and WB_MMAP patches into one, with the full
  should_map_wc() helper in a single place (Deborah).
- Accept DRM_PANTHOR_BO_WB_MMAP directly in the BO_CREATE patch,
  reject NO_MMAP combined with WB_MMAP, and return EOPNOTSUPP for
  unsupported requests such as an exclusive VM (Deborah).
- Pass the bound device from file.inner_with() to new_object() and
  drop the unsafe as_bound() access (Deborah).
- Expose all three DmaAttr values as constants instead of providing
  is_coherent() (Deborah).
- Validate the VM id before the empty-ops early return in VM_BIND and
  reject sync objects before the size check, as in Panthor (Deborah).
- Require an exact ops stride for now, use from_safe_cast for the id
  and size conversions, and add TODO notes for variable strides and
  zerocopy FromBytes (Deborah).
- Link to v5: https://patch.msgid.link/20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn

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

Sami Tolvanen (3):
      rust: task: add task_size()
      rust: device: expose the device DMA attribute
      drm/tyr: support write-combine BO mappings

 drivers/gpu/drm/tyr/driver.rs   |  25 ++-
 drivers/gpu/drm/tyr/file.rs     | 390 +++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tyr/fw.rs       |   5 +-
 drivers/gpu/drm/tyr/gem.rs      |  79 +++++++-
 drivers/gpu/drm/tyr/vm.rs       | 355 ++++++++++++++++++++++++++++++++++--
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/task.c             |   6 +
 rust/kernel/device.rs           |  27 +++
 rust/kernel/sizes.rs            |  12 ++
 rust/kernel/sync/arc.rs         |  12 +-
 rust/kernel/task.rs             |  12 ++
 11 files changed, 883 insertions(+), 41 deletions(-)
---
base-commit: cef0cd809e564cca9ac824a369c995ab7e0d16f3
change-id: 20260901-tyr-ioctls-f10ef0dcbfa6
prerequisite-message-id: <20261107021427.2105374-1-dakr@kernel.org>
prerequisite-patch-id: e17775a2fb002d71edd479f6002dc3380b9b6bb4
prerequisite-patch-id: 388c5b871c09dbb6bad46c68be04813bcbdaadb6
prerequisite-patch-id: f31098f7dcd1b2d7843767f9ef778788f8773477
prerequisite-patch-id: b0ea30b4c39e5a43e53ceaf28bd8b39db5b26a76
prerequisite-patch-id: e0735b7cd0f226e702c0edc4ed889340f93d24cf
prerequisite-patch-id: 086eb00ec9c9c445c99bbb8d1a052b3fad56b5bd
prerequisite-patch-id: d186dd1af2f3ce256afd8c7b6ff749d74def5d1a

Best regards,
--  
Ke Sun <sunke@kylinos.cn>


