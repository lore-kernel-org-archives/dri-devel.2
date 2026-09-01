Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F8EC624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A1210E8A7;
	Tue,  1 Sep 2026 16:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uskcNA54";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412B110E64E
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:09:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CF2C5435D8;
 Tue,  1 Sep 2026 16:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9130C2BCFD;
 Tue,  1 Sep 2026 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788278956;
 bh=tGulbdEu3dRFWulYij37FRo+LIbl4tpCnnrPz5XH21w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=uskcNA54RBdpVd3VvbmnwJbbOtPvcMgEFDpY+U8yPaqk6VL9D35lb95YcI7duvTl1
 XrLvSmxZ4znTOKl85rwaB7ZCu766PJvjMm/2iUpUZzgZk4lE0cL6HVVSoOWlfyuIwH
 8ox6RK4+ktlE+2el2EjE8p6SoauF+nh1V29Hg4QWE/qecJdf7IW+slxHFOKCrGOF/g
 mNTzW7UNmTGOQLejvZoZ8VzUiD6lJhomXgBFdX44df4JJ1OOgk6lI55017I4Rnca03
 sWCgTmVGtNSWZUl2Vl1Vehgsi/RqyyCU1B/9YjBPUGLJbuUmXkF6GtHX8fHiF0Wayi
 o34vIcilV2igg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 962C2C61DD3;
 Tue,  1 Sep 2026 16:09:16 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Wed, 02 Sep 2026 00:09:06 +0800
Subject: [PATCH 7/9] drm/tyr: refactor new_dummy_object to use new_object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-tyr-ioctls-v1-7-e0fdbf8bd108@kylinos.cn>
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
In-Reply-To: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788278954; l=1139;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=Ej92qQwFTpPtrIg4SAbvIlKuALoNm6gS9q8GLNp1YDQ=;
 b=+rvDr8eIgCszYK0KN0VFmkfXWahqtsVwtgx8CXqR+iJjCYkPEJsiRv5hYWJIDWEiIAxxnCCeq
 Wc/8K2eTe6EDzkVKNm6yRvYo252RjG/JDEoeTp/q173HXGhHdq/SF6K
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
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
Reply-To: sunke@kylinos.cn
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Alvin Sun <alvin.sun@linux.dev>

new_dummy_object() duplicated the BO creation code that new_object()
now provides; call new_object() instead.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/gem.rs | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index be1affe80db1a..d9ddcb287f52b 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -82,17 +82,8 @@ pub(crate) fn lookup_handle(file: &TyrDrmFile, handle: u32) -> Result<ARef<Bo>>
 
 /// Creates a dummy GEM object to serve as the root of a GPUVM.
 pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) -> Result<ARef<Bo>> {
-    let bo = Bo::new(
-        ddev,
-        4096,
-        shmem::ObjectConfig {
-            map_wc: true,
-            parent_resv_obj: None,
-        },
-        BoCreateArgs { flags: 0 },
-    )?;
-
-    Ok(bo)
+    // FIXME: use a Rust resv-object abstraction once available, rather than a real BO.
+    new_object(ddev, 4096, 0)
 }
 
 /// Specifies how to choose a GPU virtual address for a [`KernelBo`].

-- 
2.43.0


