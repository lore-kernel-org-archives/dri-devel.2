Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECA4C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BFBB10E618;
	Sun, 28 Jun 2026 14:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OKlTsP2M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673CD10E618
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:54:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 506F443ADF;
 Sun, 28 Jun 2026 14:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBAE1F00A3D;
 Sun, 28 Jun 2026 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782658457;
 bh=oS07YqSWpkiVT3UqKLEIP2G04oMvZVTuO+imk72U8qw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OKlTsP2M+GePAJzRPp9MNlwExxg7Bh8fd+BU/6dr2yOnoe17g3dAoafib/8ZLNQxf
 nDWF4qzAKdzQTYlkobehF949VzKjsk128blh7gS7kZTDLuxZtlJKC4BrTarDGFpQGm
 7jcuFauygF0LulldgN0A2ck4cmBROqXsBIBl6NkN+24F5WStFRQHgFCLe1Agv9f1pP
 JV5Y3NJuNQDeYNSfDIX4pNkghwuuRxCFsLce1KkQKuC5F42QJLaVoQiwgcTnYpEpjk
 XEaJ8mHrApeViytv2HaZJBJ8Wijc+bq1ypC9vV4NStP7mwvmAVzmPYXkPkb7uKFhdU
 73Yp+JyNppAaA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com,
 lyude@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: [PATCH v5 01/19] rust: drm: ioctl: fix unbounded lifetimes in ioctl
 handler arguments
Date: Sun, 28 Jun 2026 16:53:21 +0200
Message-ID: <20260628145406.2107056-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628145406.2107056-1-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
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

References to dev, data, and file in the declare_drm_ioctls! macro are
created via unsafe pointer dereferences, producing unbounded lifetimes.
If an ioctl handler explicitly annotates its parameters with 'static,
the compiler accepts this, allowing the handler to stash references that
outlive the ioctl call.

Fix this by adding a higher-ranked function pointer coercion that
enforces the handler accepts universally quantified lifetimes:

  let _: for<'a> fn(&'a _, &'a mut _, &'a _) -> _ = $func;

Since the handler must be coercible to a function pointer accepting any
lifetime 'a, it can no longer demand 'static on any parameter.

Cc: stable@vger.kernel.org
Fixes: 9a69570682b1 ("rust: drm: ioctl: Add DRM ioctl abstraction")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260620011346.A47D01F000E9@smtp.kernel.org/
Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/ioctl.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index cf328101dde4..ccf4150d83b6 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -135,6 +135,12 @@ macro_rules! declare_drm_ioctls {
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
                             let dev = $crate::drm::device::Device::from_raw(raw_dev);
+
+                            // Enforce that the handler accepts higher-ranked
+                            // lifetimes, preventing it from requiring 'static
+                            // references that could escape this scope.
+                            let _: for<'a> fn(&'a _, &'a mut _, &'a _) -> _ = $func;
+
                             // SAFETY: The ioctl argument has size `_IOC_SIZE(cmd)`, which we
                             // asserted above matches the size of this type, and all bit patterns of
                             // UAPI structs must be valid.
-- 
2.54.0

