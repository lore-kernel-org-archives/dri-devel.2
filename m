Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA19C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E112610E621;
	Sun, 28 Jun 2026 14:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="azA7poHF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D5110E625
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:54:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B120600AF;
 Sun, 28 Jun 2026 14:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FEC1F00A3D;
 Sun, 28 Jun 2026 14:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782658495;
 bh=IDmUao6/RKMQCcHOq9jquazpidA8ghc1/ZgWZQdWTso=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=azA7poHFNRiUSCeM6LfCZB+zZ9icu6prs+RWrmcAjU6QAXuW2N91JhuI7lD2hstwx
 ml4M2ATZFP6KOJ5QmnRQxlFK84noeLaEgbpBd+0pG1rDVwTW3QC665Fhf18gt+pNwf
 aTv2Rngo9UWIXTVgmIJPAxtuZGM6QB+3KPFNr0f9q1AB0aeDaIjqr1G0VMt4C7ID3X
 JgQ0Pt/71HGzF6UihnWZXbhTxsmMnbvX0e50MUIKsxCsNx4VX5LBwotxjn4L8p2YcG
 xzbevRFFUmK35w3i4f0yaQrOF1DMt3u9rIMdNWwmZPpkQjuMARvd+tN3gha/VyK1dl
 ajs1vdrnmUKBA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com,
 lyude@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 10/19] rust: drm: pin ioctl Device reference to Normal
 context
Date: Sun, 28 Jun 2026 16:53:30 +0200
Message-ID: <20260628145406.2107056-11-dakr@kernel.org>
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

Explicitly annotate the Device reference produced by from_raw() in the
ioctl dispatch macro as Device<_, Normal>. Without this annotation, the
context is inferred from the handler's first parameter type, which would
allow a handler declaring &Device<T, Registered> to obtain a Registered
reference without runtime proof via RegistrationGuard.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/ioctl.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index ccf4150d83b6..6f5a9877bdae 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -134,7 +134,8 @@ macro_rules! declare_drm_ioctls {
                             // FIXME: Currently there is nothing enforcing that the types of the
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
-                            let dev = $crate::drm::device::Device::from_raw(raw_dev);
+                            let dev: &$crate::drm::device::Device<_, $crate::drm::Normal> =
+                                $crate::drm::device::Device::from_raw(raw_dev);
 
                             // Enforce that the handler accepts higher-ranked
                             // lifetimes, preventing it from requiring 'static
-- 
2.54.0

