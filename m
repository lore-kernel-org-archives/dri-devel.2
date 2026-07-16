Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759F4C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A0B810F33A;
	Thu, 16 Jul 2026 14:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PCJhQFE/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41A310F32D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:26:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80CD142DBA;
 Thu, 16 Jul 2026 14:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE3A1F00A3D;
 Thu, 16 Jul 2026 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784211971;
 bh=dmMpkIr0sbIJVy9wvQ7Wf9oRTb2hJTI9MXcBUx5k8Tg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
 b=PCJhQFE/DV7ADE1bcScyLgjJwZxfJG3ka0INRryAWNnkVsuTxNuAqvNB+AUxUUKJv
 S05XNoZuc0j6suam3Jb/vU6WKPIZMXZNbYdDXpSe/ZDezpsep6QU5WFyMDc5YMdU9+
 UpJA8+JxSXjt7tJ9lyq5Lq+4Vi3CqvB64fXXyj/p0cKcQFAuBqRibIOKOEi9hDk9zY
 VZTKCZChX7Ntu+KyPdrXeLrYBolKQQ16iHKLeINr9cwa7C6ZS6tzM6J3/HHSl/Vy6L
 zefNWDxZ3M6o38J3NYqqfU2Bt7ZXlogNvdW+ujb4Xu2Ay5CmXZTJOhNs2VgbIzKQKe
 kUdwkLv1PZ2kg==
From: Gary Guo <gary@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] rust: drm: fix non-const `read8` in unit test
Date: Thu, 16 Jul 2026 15:25:44 +0100
Message-ID: <20260716142545.3622278-2-gary@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716142545.3622278-1-gary@kernel.org>
References: <20260716142545.3622278-1-gary@kernel.org>
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
Reply-To: Gary Guo <gary@garyguo.net>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Gary Guo <gary@garyguo.net>

With CONFIG_CC_OPTIMIZE_FOR_SIZE, the address validity check in non-const
`read8` invocaction is not optimized away, leading to build failure.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/drm/gem/shmem.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 580e0808d6c0..a687d46d170d 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -688,7 +688,7 @@ fn vmap_io() -> Result {
         // Ensure the ordering in memory is correct
         let expected = 0xFEDCBA98_u32.to_ne_bytes().into_iter();
         for (offset, expected) in (0x20..=0x23).zip(expected) {
-            assert_eq!(vmap.read8(offset), expected);
+            assert_eq!(vmap.try_read8(offset).unwrap(), expected);
         }
 
         Ok(())
-- 
2.54.0

