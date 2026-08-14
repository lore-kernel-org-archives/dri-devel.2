Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979CAC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA31910E04B;
	Fri, 14 Aug 2026 23:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mzVP4ENR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967CA10E04B
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:09:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A708860008;
 Fri, 14 Aug 2026 23:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60411F000E9;
 Fri, 14 Aug 2026 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786748970;
 bh=/ksmWFzE3+1D/lj8FUHgKXUdUwgSEGlUmZL+BQTB+wk=;
 h=From:To:Cc:Subject:Date;
 b=mzVP4ENRxVh1bgbY+RFLr/4feKh3+UJMFm9x2yOmrOt8uBF7f06gY9xPSJZxjd5et
 A93k+MIFBctRXcN/iIMmQNa7gEETcHxnqkEPuXe6ausmReYit+6brGd/Ld0kmODPzz
 sGFNDOnrY5o6IfBw9jHq8Wh8r0KV+P8BDXpxbZmRkW5ysaUGOX9yxsh0zabV+9q9GQ
 oqNgF9ibb8ySJRQ5fR+QIfjqVxbfxubFy97pY46t8iv/SMq3mdPL92ywtRPW0/1iKd
 n6RQC4xUqTFcHXOYcvAYE+vj/ey2Tzxd76LLSNIg0/jEIvB0MfHe2tiNfXmMH3XFMn
 b+mH8BQqieu/g==
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
Subject: [PATCH 0/7] lifetime-parameterized DRM File private data
Date: Sat, 15 Aug 2026 01:08:58 +0200
Message-ID: <20260814230923.1292966-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
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

DRM file private data is currently 'static, preventing drivers from
borrowing registration-scoped resources in their per-file state. This
series makes Driver::File lifetime-parameterized through ForLt, so file
data can borrow from RegistrationData.

File data is guaranteed to be dropped before registration data, either
when the file is closed normally or when the device is unregistered,
whichever comes first. To enforce this during unbind, Registration::drop()
revokes all open file data and waits for in-flight closes before dropping
registration data.

fops.open is wrapped in a RegistrationGuard (drm_dev_enter/exit) so that
after drm_dev_unplug() all successfully opened files are accounted for.
GEM open/close callbacks are similarly gated to prevent access to stale
file data after unbind.

The series is based on drm-rust-next with [1] applied and [2] merged, a branch
with the patches is available in [3].

[1] https://lore.kernel.org/all/20260726223613.1242940-1-dakr@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/tag/?h=dd-lifetimes-7.3-rc1
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drm/file

Danilo Krummrich (7):
  rust: drm: rename Ioctl device context to Userspace
  rust: drm: gem: gate open/close callbacks with RegistrationGuard
  rust: drm: move file_operations from gem to device
  rust: fs: add iminor() helper
  rust: drm: wrap fops open with RegistrationGuard
  rust: drm: make Driver::File lifetime-parameterized
  rust: drm: return impl PinInit from DriverFile::open()

 drivers/gpu/drm/nova/driver.rs |   5 +-
 drivers/gpu/drm/nova/file.rs   |  13 ++-
 drivers/gpu/drm/nova/gem.rs    |   8 +-
 drivers/gpu/drm/tyr/driver.rs  |   5 +-
 drivers/gpu/drm/tyr/file.rs    |  13 +--
 rust/helpers/fs.c              |   5 ++
 rust/kernel/drm/device.rs      | 139 ++++++++++++++++++++++++++----
 rust/kernel/drm/driver.rs      |  69 ++++++++++++++-
 rust/kernel/drm/file.rs        | 151 ++++++++++++++++++++++-----------
 rust/kernel/drm/gem/mod.rs     |  48 +++++------
 rust/kernel/drm/gem/shmem.rs   |  14 +--
 rust/kernel/drm/ioctl.rs       |  14 +--
 rust/kernel/drm/mod.rs         |   2 +-
 13 files changed, 356 insertions(+), 130 deletions(-)

-- 
2.55.0

