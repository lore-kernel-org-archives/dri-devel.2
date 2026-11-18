Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085C606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeWxroLD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A9F10E064;
	Wed, 18 Nov 2026 16:32:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6583C89B12
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:32:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CF9840660;
 Wed, 18 Nov 2026 16:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2221C1F000C5;
 Wed, 18 Nov 2026 16:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795019531;
 bh=nLkHGjzkpLWqDn5A0Bf7/KvxqlXzbGH5zYTHM3bADyI=;
 h=From:To:Cc:Subject:Date;
 b=oeWxroLDGx1J0ayXKqh4fcy5WrCR3T1eRpCOokeFfeIeRlZMCcRmDAxjmU/Db+Zc4
 v77BJasECFdMV39KTtDaCF0q2g5GJPhNeT0ZHXgTqQetTonNH6C2tk6JP6k85jDyqK
 qm5ogj2rMR7VfbhYqEgVDmh1FKJkHVwzxR4VREjFlkSsRIjr9glRp9yAnBVYMgNiBo
 ZRleQpJnszbw7hkwWRPbm3Fnay4bbqmn9e8sHcP1LYlEa5dzX54lkKzkb+R0qEgvv2
 QjeKBO4J42HFpNVWXD4qkBeVayzeadSjPDGE9sTtF7AA6a6AFhLQHc+GSeDqb5fk0n
 HFA6kIB+g+DpA==
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
Subject: [PATCH v3 0/7] lifetime-parameterized DRM File private data
Date: Wed, 18 Nov 2026 17:29:41 +0100
Message-ID: <20261118163203.2483856-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

[1] https://lore.kernel.org/all/20261117001507.1611984-1-dakr@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drm/file

Changes in v3:
- Move the DriverFile bound to Driver::File<'a>.
- Require Send + Sync for DriverFile.
- Use Atomic<u64> for open_count.
- Explain driver_priv synchronization in postclose_callback().

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
 rust/kernel/drm/device.rs      | 136 ++++++++++++++++++++++----
 rust/kernel/drm/driver.rs      | 113 ++++++++++++++++++++--
 rust/kernel/drm/file.rs        | 172 ++++++++++++++++++++++++---------
 rust/kernel/drm/gem/mod.rs     |  80 +++++++++------
 rust/kernel/drm/gem/shmem.rs   |  11 ++-
 rust/kernel/drm/ioctl.rs       |  18 ++--
 rust/kernel/drm/mod.rs         |   2 +-
 13 files changed, 446 insertions(+), 132 deletions(-)


base-commit: 23eb2cfcf15209d149f407e462704c21b9ce9cc4
-- 
2.56.1

