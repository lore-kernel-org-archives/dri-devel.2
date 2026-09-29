Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1141CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C78910F021;
	Tue, 29 Sep 2026 19:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BZIBkjeN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161C810F021
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 19:00:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F12504068A;
 Tue, 29 Sep 2026 19:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5E51F00898;
 Tue, 29 Sep 2026 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790708434;
 bh=w7zowPGeHPvn8Z9xWR7ASx6HGHAbr2Uqc9NY1yGOdvs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BZIBkjeNzQQeDcpCrmGtUfci92EzkE48CEaY2adI37cWtDl7AoI6NEfS7GwBkebLX
 6CbGb1fmpiaWklIV3aqrYBhqhzgS/uXZk9Q3fNpPwI7YjBaCyzViGcC1bHoBGVTgC8
 N2ylGQeYDSPK5kpEy/so4U00AiurgMAH5CYPPVPAL925c8WNoRYjZEr0a+K+tV4V3j
 ujCkwFJS2BpbMM+dLK88cfHJ55GBve5gECY4SGBmCL7iiUaWJtaA4Vwd0+8cPToW48
 0qa8upjn6xElSD2r/T71CjBnjA6rlZGjQlPYJBwQcPjYcg25AGznZgTTxcDIkEG+BK
 anUqYJfB607Rg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 2/2] rust: drm: Remove unused flags argument from
 Registration::new()
Date: Tue, 29 Sep 2026 20:59:31 +0200
Message-ID: <20260929190024.2248099-2-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929190024.2248099-1-dakr@kernel.org>
References: <20260929190024.2248099-1-dakr@kernel.org>
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

The flags argument to drm_dev_register() is only passed to the
deprecated .load() callback. Rust DRM drivers always set this callback
to NULL, so the argument has no effect.

Remove the argument from drm::Registration::new(), pass zero to
drm_dev_register(), and update the Nova and Tyr callers.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs | 2 +-
 drivers/gpu/drm/tyr/driver.rs  | 1 -
 rust/kernel/drm/driver.rs      | 3 +--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 50537efe8d94..5fe98f646082 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -79,7 +79,7 @@ fn probe<'bound>(
 
                 // SAFETY: `reg` is stored in `Self::Data` and dropped when the driver is unbound;
                 // it is never forgotten.
-                unsafe { drm::Registration::new(adev.as_ref(), drm, reg_data, 0) }
+                unsafe { drm::Registration::new(adev.as_ref(), drm, reg_data) }
             },
             drm: reg.device().into(),
         })
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 6e1008290b5f..c2b99d67369f 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -183,7 +183,6 @@ fn probe<'bound>(
                         iomem,
                         gpu_info,
                     }),
-                    0,
                 )},
                 _: { dev_dbg!(pdev, "Tyr initialized correctly.") },
             }))
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 13aa609350b1..f6db91e81e79 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -169,7 +169,6 @@ pub unsafe fn new<E>(
         dev: &'a device::Device<device::Bound>,
         drm: drm::UnregisteredDevice<T>,
         data: impl PinInit<T::RegistrationData<'a>, E>,
-        flags: usize,
     ) -> impl PinInit<Self, Error>
     where
         Error: From<E>,
@@ -196,7 +195,7 @@ pub unsafe fn new<E>(
                 unsafe { *drm.registration_data.get() = ptr };
 
                 // SAFETY: `drm` is a valid, initialized but not yet registered DRM device.
-                let ret = unsafe { bindings::drm_dev_register(drm.as_raw(), flags) };
+                let ret = unsafe { bindings::drm_dev_register(drm.as_raw(), 0) };
                 to_result(ret).inspect_err(|_| {
                     // SAFETY: `drm_dev_register()` synchronizes SRCU on failure, so no
                     // concurrent access to `registration_data` is possible at this point.
-- 
2.55.0

