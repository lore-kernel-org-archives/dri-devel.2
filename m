Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90789FD874D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F297710E615;
	Tue, 17 Mar 2026 12:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="gCjiYj/c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B492F10E615
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:05:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 098D443905;
 Tue, 17 Mar 2026 12:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D82A7C19425;
 Tue, 17 Mar 2026 12:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1773749103; bh=aS0AQ+DX9KeA6AMbU2CAybn1XXydzrY13XlyF6pIjOw=;
 h=From:Subject:Date:To:Cc:From;
 b=gCjiYj/cv6CgJO0Bf+xbgXmDPXO9mRO80snRfHUCMyx0f898ybUVo55jHfKLjfVkM
 9L/6TRWh5PChSE0JbaeuA4IVbR9AUz/EP6jniekRmUWH5ABU8830umIRqOKQRvUbCv
 I2brS/Mq5D8TBV45JWBLVSXvp7sKwwpKY0EixPLE=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CB8B2FD874E;
 Tue, 17 Mar 2026 12:05:03 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Subject: [PATCH 0/2] drm/gpuvm: add debugfs utilities for GPU VA state dumping
Date: Tue, 17 Mar 2026 20:03:39 +0800
Message-Id: <20260317-gpuvm-helpers-v1-0-00198fc6eeea@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACFDuWkC/02OywrCMBBFf6XM2il5tGktIv6HuEjSsUb6MmmDI
 P67wbpweQbOPfOCQN5RgCZ7gafogpvGBHyXgb3psSN0bWIQTCgmeYXdvMYBb9TP5AOKujUkjGT
 SCEjO7Onqnt+982VjT481zS7bEYwOhHYaBrc0Waxyht4W8J9rshQrORf1L+bXsKCp+N5qKyrdq
 iZ+jYFC0D/lcNg+ZEowqYo651yqsiyQ432iXncj9dfTGF3rdJ7yxyNc3u8P4uenSf8AAAA=
X-Change-ID: 20260317-gpuvm-helpers-28dbe2b303b2
To: Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773749102; l=1764;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=aS0AQ+DX9KeA6AMbU2CAybn1XXydzrY13XlyF6pIjOw=;
 b=Fqxw7Hamhyb2RexD2o4WMZ4spA4S1bQc2Z7iI/S/FQk9eIyMejQYQT+S4cMB365ongnsABhh+
 Coje7864LlJAxMy7hYBCuACCxxLr0azNcI2odnc+Yow1+AT4oXILCku
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

This patch series adds helper APIs to enable GPU drivers to implement
debugfs interfaces [1] [2] that expose GPU VA mapping state for
inspection and debugging purposes.

Dependencies:
- [PATCH v12 0/1] rust: interop: Add list module for C linked list interface
https://lore.kernel.org/rust-for-linux/20260306203648.1136554-1-joelagnelf@nvidia.com/
- [PATCH v4 0/6] Rust GPUVM immediate mode
https://lore.kernel.org/rust-for-linux/20260130-gpuvm-rust-v4-0-8364d104ff40@google.com/

Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/11 [1]
Link: https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/59 [2]
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
Alvin Sun (2):
      drm/gpuvm: add name(), RawGpuVa and kernel_alloc_va() for debugfs
      drm/gpuvm: add GpuVaIter and va_mappings() for debugfs

 rust/kernel/drm/gpuvm/mod.rs | 20 ++++++++++
 rust/kernel/drm/gpuvm/va.rs  | 90 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
---
base-commit: 34cb4f916af10153c87fabaf6c34e4cafa170427
change-id: 20260317-gpuvm-helpers-28dbe2b303b2
prerequisite-change-id: 20251128-gpuvm-rust-b719cac27ad6:v4
prerequisite-patch-id: 94679c36e594a7d6fc9279dad5419f5558f2302b
prerequisite-patch-id: 03b672e1e2c07d677326d64de7fccc6092ea6812
prerequisite-patch-id: 3c1a4c6eec5faaa1a70de53581bd7ae5ab7bc324
prerequisite-patch-id: 3712380c7bfdf784b6aca146864576cd76bc9a72
prerequisite-patch-id: 3149e1016beefce815c860d4b64e7c1bb7589f15
prerequisite-patch-id: 23467ae9a31746a6c44678e0054f1442c6a5ac06
prerequisite-message-id: <<20260306203648.1136554-1-joelagnelf@nvidia.com>>
prerequisite-patch-id: 9bc17713af35e5f2744ac55157e2b5078eae77cc

Best regards,
-- 
Alvin Sun <alvin.sun@linux.dev>


