Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33927CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC24113BC1;
	Wed,  3 Jun 2026 01:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j/Z8eUVs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C950113BC0
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:27:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41B37601E7;
 Wed,  3 Jun 2026 01:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362E71F00893;
 Wed,  3 Jun 2026 01:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780450077;
 bh=mDJGqICcZVxPtHlEwcDyvQr28S8ONtlLg4MREDp243s=;
 h=From:To:Cc:Subject:Date;
 b=j/Z8eUVsPRErshGfU43zK+45aN6/CeddZPC5D9inLoGX4zmR6VlQMgq/TsytMmUQn
 uSkRFZ9gCM3cjnUeulqgxn3IV3Iqz1hrJvscGXMuiZLfOBu0N1bcYZ5rnJQza5v5nN
 w4zW97d/luSl/ZYGli5pmT8vCBykHdv+gqo2VQiH43b9PlUDiiCffjRgCIGt+vOaNA
 GW4EzPNWUb9paCPvsDb9Hx0/nJBfwKqAC/boKMufhC7dthst81UFDVtXd3jQGalSSi
 2zjGKzA1NCbs5FCwiWyhs6/+BxgpXrVWYyOiGGynm9o3WE0KhepauLO6mHceZDFwk+
 12mceVkpCoaDg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v2 0/7] rust: drm: Higher-Ranked Lifetime private data
Date: Wed,  3 Jun 2026 03:15:42 +0200
Message-ID: <20260603011711.2077361-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
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

DRM ioctls run in process context without any guarantee that the parent
bus device is still bound. This series solves the problem by introducing
UnbindGuard -- a guard representing a drm_dev_enter/exit SRCU critical
section that proves the parent bus device is bound for the lifetime of
the guard.

On top of that, add RegistrationData as a ForLt associated type on
drm::Driver, allowing drivers to store data whose lifetime is tied to
the parent bus device binding scope. The data is allocated in
Registration::new(), lifetime-erased to 'static for storage, and made
accessible through UnbindGuard::registration_data_with(). The closure's
HRTB ties the lifetime to the closure scope, and ForLt::cast_ref_unchecked
shortens it from 'static internally. The reference is valid for the
duration of the drm_dev_enter/exit critical section held by UnbindGuard.

Also update the ioctl dispatch macro to wrap every handler in an
UnbindGuard, returning ENODEV if the device has been unplugged, and
pass both the bound parent bus device and the registration data as
arguments to handlers.

This series is based on [1]; a branch with all patches can be found
in [2].

[1] https://lore.kernel.org/driver-core/20260603011020.2073650-1-dakr@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drm-lifetime

Changes in v2:
- Replace unsafe direct registration data access in ioctl dispatch with
  safe UnbindGuard::registration_data_with() closure
- Eliminate unbind_guard() free function; use type-inference anchor to
  enable direct dev.unbind_guard() method call in the ioctl macro
- UnbindGuard::registration_data_with() provides both parent device and
  registration data to the closure
- Add nova-drm conversion patch demonstrating lifetime-aware registration
  data with &'bound auxiliary::Device<Bound>
- Various safety comment and documentation improvements

Danilo Krummrich (7):
  rust: drm: Add Driver::ParentDevice associated type
  rust: drm: Add UnbindGuard for drm_dev_enter/exit critical sections
  rust: drm: Add RegistrationData to drm::Driver
  rust: drm: Wrap ioctl dispatch in UnbindGuard
  rust: drm: Pass bound parent device to ioctl handlers
  rust: drm: Pass registration data to ioctl handlers
  drm: nova: convert to use DRM registration data

 drivers/gpu/drm/nova/driver.rs |  38 +++++----
 drivers/gpu/drm/nova/file.rs   |  21 +++--
 drivers/gpu/drm/tyr/driver.rs  |  22 ++++--
 drivers/gpu/drm/tyr/file.rs    |   4 +
 rust/kernel/drm/device.rs      | 138 ++++++++++++++++++++++++++++++++-
 rust/kernel/drm/driver.rs      | 134 ++++++++++++++++++++++++--------
 rust/kernel/drm/ioctl.rs       |  33 +++++++-
 rust/kernel/drm/mod.rs         |   1 +
 8 files changed, 325 insertions(+), 66 deletions(-)


base-commit: e3b6e4c944a174277729dced5ab4ad5c0e53ff92
-- 
2.54.0

