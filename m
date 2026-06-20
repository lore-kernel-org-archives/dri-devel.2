Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4297FCD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 18:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB9210E254;
	Sat, 20 Jun 2026 18:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="afgmvRHm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80FC10E258
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 18:50:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A9ED44218;
 Sat, 20 Jun 2026 18:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C871F000E9;
 Sat, 20 Jun 2026 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781981412;
 bh=Y1nxmUNmzObjE1ETWe+k9k6wr36179Z11Zh2Wwpy6wA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=afgmvRHmZnuG06kGRpjmvYHW5H0dNneBRjkCPEjB16I12t47Y0IHE5GUicK3Y2gxK
 jiwIDyH1ftMfF4nX3rP410owQtDR6cvNpmi4XeesU4RtKIbtGpbKo3IFTYC6a8acmQ
 ZrXnPxydUVAftPWTc2YHy3tticcsN4fsRAppHTSUCq2ORI+ZDfUIrnbFGNqhquo99i
 L6kOkNeG4F4ggRiUA6BMBCpBNpm8SOhqHyYWkmfMFsuxxtNIQ91hbgYwpNzb89K6fK
 ot6N23ocGa7gp+DVGcANPZnjhxB/OjV4c7jsBfkxp3yII0AC6du0rQTBJpinHTOjg4
 P0osC47Av1b+Q==
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
Subject: [PATCH v4 08/16] rust: drm: pin ioctl Device reference to Normal
 context
Date: Sat, 20 Jun 2026 20:48:01 +0200
Message-ID: <20260620184924.2247517-9-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620184924.2247517-1-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
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

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/ioctl.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 023e6da5c1e4..70cf1aa4d788 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -167,7 +167,8 @@ macro_rules! declare_drm_ioctls {
                             // FIXME: Currently there is nothing enforcing that the types of the
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
-                            let dev = $crate::drm::device::Device::from_raw(raw_dev);
+                            let dev: &$crate::drm::device::Device<_, $crate::drm::Normal> =
+                                $crate::drm::device::Device::from_raw(raw_dev);
                             let __anchor = ();
 
                             // SAFETY:
-- 
2.54.0

