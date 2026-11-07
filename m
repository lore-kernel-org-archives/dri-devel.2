Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E4606A33A
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWXDJEhk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364EE10E4FD;
	Sat,  7 Nov 2026 02:20:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB7610E4DA
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 02:20:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B398F43A42;
 Sat,  7 Nov 2026 02:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43361F008A3;
 Sat,  7 Nov 2026 02:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794018018;
 bh=tDRNTiewiQVhH6ezSiY3pHSvP82vVUEEInKr2hmCowE=;
 h=From:To:Cc:Subject:Date;
 b=XWXDJEhkayTcFSfsWAOQO1bHTomnmHjj4GJkCY7F2b62tyhGf6BbZiGL/++/xD/84
 aW+zpwW7i8FfZTu+YjQBuyhVA/l4vcdw+bHebUCGHb5x/8Pp2OnwiEE7Uo7BRa6Hav
 96jLqJqLbhNLCzEprO4/peVywMp3tyv/luRRADLM5JoI26LiLQZsHUInXk+RYLsgwu
 QvietdolKetbODGE7/6yjjqgcakS5fCkv0yHWrzQK0bXgERrRZQGiRjF5UYaIKv5LY
 YrSI3Y+/6b7aTfoazJZetHP7tOXdusLLQoR8qbguQ9Q0EZ83oKM0d/mgW3Qks+Q5cs
 WN+yqbP0PooXg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev, brauner@kernel.org, lyude@redhat.com, j@jananu.net,
 alvin.sun@linux.dev, deborah.brouwer@collabora.com,
 laura.nao@collabora.com, beata.michalska@arm.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] lifetime-parameterized DRM File private data
Date: Sat,  7 Nov 2026 03:03:18 +0100
Message-ID: <20261107021427.2105374-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DRM file private data is currently 'static, preventing drivers from
borrowing registration-scoped resources in their per-file state. This
series makes Driver::File lifetime-parameterized, so file data can borrow
from RegistrationData.

File data is guaranteed to be dropped before registration data, either
when the file is closed normally or when the device is unregistered,
whichever comes first. To enforce this during unbind, Registration::drop()
revokes all open file data and waits for its destruction before dropping
registration data.

fops.open is wrapped in a RegistrationGuard (drm_dev_enter/exit) so that
after drm_dev_unplug() all successfully opened files are accounted for.
GEM open/close callbacks are similarly gated to prevent access to stale
file data after unbind.

The series is based on drm-rust-next with [1] applied; a branch with the
patches is available in [2].

[1] https://lore.kernel.org/all/20261105005951.756157-1-dakr@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drm/file

Changes in v2:
- Replace ForLt with Driver::File<'a>; use inner_with() for file-data access
  and allow returning borrowed fields.
- Use Opaque<bindings::drm_file> during teardown.
- Drop file data outside filelist_mutex; also clean up file data on
  registration failure.
- Reject cross-device GEM handles.
- Clarify safety documentation and add inline annotations.

Danilo Krummrich (7):
  rust: drm: rename Ioctl device context to Userspace
  rust: drm: gem: gate open/close callbacks with RegistrationGuard
  rust: drm: move file_operations from gem to device
  rust: fs: add iminor() helper
  rust: drm: wrap fops open with RegistrationGuard
  rust: drm: return impl PinInit from DriverFile::open()
  rust: drm: make Driver::File lifetime-parameterized

 drivers/gpu/drm/nova/driver.rs |   2 +-
 drivers/gpu/drm/nova/file.rs   |  16 +--
 drivers/gpu/drm/nova/gem.rs    |   8 +-
 drivers/gpu/drm/tyr/driver.rs  |   2 +-
 drivers/gpu/drm/tyr/file.rs    |  13 ++-
 rust/helpers/fs.c              |   5 +
 rust/kernel/drm/device.rs      | 141 ++++++++++++++++++++++----
 rust/kernel/drm/driver.rs      | 113 +++++++++++++++++++--
 rust/kernel/drm/file.rs        | 179 ++++++++++++++++++++++++---------
 rust/kernel/drm/gem/mod.rs     |  80 +++++++++------
 rust/kernel/drm/gem/shmem.rs   |  11 +-
 rust/kernel/drm/ioctl.rs       |  18 ++--
 rust/kernel/drm/mod.rs         |   2 +-
 13 files changed, 454 insertions(+), 136 deletions(-)


base-commit: cef0cd809e564cca9ac824a369c995ab7e0d16f3
-- 
2.56.0

