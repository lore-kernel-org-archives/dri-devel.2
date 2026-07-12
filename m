Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7473C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 13:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F3E10E45A;
	Sun, 12 Jul 2026 13:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VB3aDO17";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD4010E45A
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 13:40:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 705D640261;
 Sun, 12 Jul 2026 13:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D784C2BCB9;
 Sun, 12 Jul 2026 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783863605;
 bh=VF4oES448GeKOYooFFIccE4cclg+MSX91v4GScUJ3jk=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=VB3aDO17PDh6OHUWcr4qNaKci/4zvYJdyFfCEJCrPTS6Qq98tuKwF529edw2SJBhk
 ejHYT43cJ9+wl4RAf9+nIHWk9oypwgKQPr4ONfcXGPlKxvHQRpV/tRoMVJ9otm6XXF
 4GAun65yMsT7ZwzawdLzfrBcK+Yk8v2Z5hZqlwpYXxd8edKyK0wW+NngW7gaU6IDVI
 WKKbdt1BSkJrzql/RRQhVO7Ip7c70+qzcROYQCaOyziCDlGwWlTvgOJR7YNSUQPDP+
 jzzpaEWB9kbojTsnDf9OrJZ4bc82CrhWeVUcNB2U7N6bGhaYmxdUDtgnYS1eTFUw1g
 rxfwIKoxPKEcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3A66BC43458;
 Sun, 12 Jul 2026 13:40:05 +0000 (UTC)
From: Younes Akhouayri via B4 Relay <devnull+git.younes.io@kernel.org>
Date: Sun, 12 Jul 2026 15:39:46 +0200
Subject: [PATCH] rust: drm: Fix typo in FEAT_RENDER documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-docs-drm-feat-render-rustdoc-typo-v1-1-c9df1cbbce4b@younes.io>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN2wrCMBBEf6XsswttqQb8FfEhl6mNYFp2U6mU/
 ruJPi1nZji7k0IilK7NToJ31DinAt2pIT/Z9ADHUJj6tr+0pus5zF45yItH2MyCFCAsq+ZScP4
 sM8OYwdnhPJZLxbMIxrj9ftzuf9bVPeFzFdeFswp2YpOfalRtnLBlOo4vWD1XTaEAAAA=
X-Change-ID: 20260712-docs-drm-feat-render-rustdoc-typo-e774ba45f774
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783863604; l=1163;
 i=git@younes.io; s=20260712; h=from:subject:message-id;
 bh=nFTIjsRD4bAT2kAKAWEo3ns3uC/V61sCbGPMbgYLnGE=;
 b=mJDT9j37Cs4ako4ZtN9x7e2ECNdlWeueLgwKLlhevca2zuiuJ861CYUDa37FTGv3U8yA3AtLM
 +tGJLO4D6O/AQOqrADyKe9FAKoYweLjol7FDYAkRMMUR1nfF0iAS3vy
X-Developer-Key: i=git@younes.io; a=ed25519;
 pk=1DRfzPrQ04RQHHgGK28t+vjIAPv5oISPiAdLMU6J5dE=
X-Endpoint-Received: by B4 Relay for git@younes.io/20260712 with
 auth_id=866
X-Original-From: Younes Akhouayri <git@younes.io>
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
Reply-To: git@younes.io
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Younes Akhouayri <git@younes.io>

Correct the spelling of "privilege" in the DRIVER_RENDER Rustdoc.

Signed-off-by: Younes Akhouayri <git@younes.io>
---
 rust/kernel/drm/driver.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 25f7e233884d..1dff81442b61 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -125,7 +125,7 @@ pub trait Driver {
     /// Sets the `DRIVER_RENDER` feature for this driver.
     ///
     /// When enabled, the driver exposes `/dev/dri/renderDXX` render nodes to
-    /// userspace. The render node is an alternate low-priviledge way to access
+    /// userspace. The render node is an alternate low-privilege way to access
     /// the driver, which is enforced on a per-ioctl level. Userspace processes
     /// that open the render node can only invoke ioctls explicitly listed as
     /// usable from the render node (i.e. marked DRM_RENDER_ALLOW), whereas

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260712-docs-drm-feat-render-rustdoc-typo-e774ba45f774

Best regards,
--  
Younes Akhouayri <git@younes.io>


