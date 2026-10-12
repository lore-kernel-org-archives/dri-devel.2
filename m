Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE147CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC2610E409;
	Mon, 12 Oct 2026 09:22:23 +0000 (UTC)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4116310E409
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 09:22:17 +0000 (UTC)
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c2e77b7742dso215361866b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 02:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791796935; x=1792401735;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pr1oOrP9lLyuo1XWNgakeB/AtMIvjuEaKOp04OdVG9s=;
 b=X9CZcvjKYXuHyDRci7CKcd1nPi5+oS01S9wwsWGlI3NXy+PHAWNzTKjv1mDdma57TS
 DvdPdYNsOOpjTVRkmAtagyu4Uu9RCfIE3FEccVn0A7hPCWOf5PsGKyg1lD78qy0CVIDj
 2llhRqJRznw57epI5yqbWxAG5PSJ64bfCz2Xq1buYyk8iQe2nEBhvnpnXURS8LHW8WQI
 cAoTtcG/1zcDI1JQpL0KR86ZbIrEtYYhWbbXyh1IkBd4OyAI+2L13jb9UxfxvcjeXDoV
 B+gwC7p8JryaVfOZ8mPNjXXHe3wy54jHA4fLV8tRtwuVsyGL9vmXIz66DW9eDxlizsqn
 5mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791796935; x=1792401735;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pr1oOrP9lLyuo1XWNgakeB/AtMIvjuEaKOp04OdVG9s=;
 b=c7eSaEN+67nlti6r5MZaSSdkUNy27L0qwcRiqI1DW2SMzrprEt1FZ/UNSfU5mLTydp
 5EufEU7xx1S8ZDaOttpmnuvHiWI10imfUcw7NI33FBv5+wLJf0aahCTA+gqNoEmNYIc3
 pwqyaVuW/JQvtkQ/oStWbaQPBP1MoSpPJzjQwAJIvkio7L/5bB8npoQogXrLF4cY+AGV
 70BFEjOB0QWUYa2Zuza4MAlfpW8Y9T2or7gFDQsur6dbkes/89PQI8poJwM9TB3jvf1v
 9YlzODXE4HkpgZgcnsJA0c6dgjP1SRKzXdeI9dPnzSvLO153Ifvpa4B748i+gMWRh6kT
 Nj5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVApRZJGuVeugkjrfN24YoryV7Zk/7tlTPUAIlPW9kuqncyFiwh9m+OcueYFnhq0qQkz/GRftaoCo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLUwYfG5A2Mf/UxXhEHJjUY7cTQHQc30SasiaHQ+IzkPaLk6fFZ
 Qzw1zvJ0aHvPrdHExu07lXMzvayr+At44d9bb39RSrDrni8qoRqgAWP+9cLeB9fJH3iDe8MI25j
 XK6Ddsm2tGT8zVhizuw==
X-Received: from edgi18-n2.prod.google.com
 ([2002:a05:6402:a592:20b0:6b1:d06e:c41d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4007:b0:6b1:bc9f:8ff9 with SMTP id
 4fb4d7f45d1cf-6b1bc9fbad6mr2241822a12.19.1791796934924; 
 Mon, 12 Oct 2026 02:22:14 -0700 (PDT)
Date: Mon, 12 Oct 2026 09:22:05 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALymzGoC/4WNTQ6CMBBGr0Jm7Zi2yp8r72FYSDuUJsCQVquG9
 O5WLuDyfcl73waBvKMAl2IDT9EFx0sGdShAj/fFEjqTGZRQlRRSol2fcUZP2YuEHMkPE7+w7Es
 lTF01TUuQ5dXT4N57+NZlHl14sP/sP1H+1r/JKFFiq4Xu1cnUZ9FeLbOd6Kh5hi6l9AWvxMlIv
 QAAAA==
X-Change-Id: 20261011-gpuvm-reserve-overflow-5b520d76889e
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=qZdH4O7AYhrATR5UPQCOt1R0Dm2794679njvxbHtNZs=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqzKbAZCxgbuvZpmzhGqCkC+sxMkw/LXH8lC89s
 sFjPoV/2hCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCasymwAAKCRAEWL7uWMY5
 RgoGD/9etRZnhqzgz4+aTvIsG5m4qctxSa/0Jc0d4vNdp+pVJVCoB7mzqZKsEx4FcdqcBH1yibL
 xDx/r4o9rS2J5/fs1iRdK5hlHbmRwgSeSJQ7tjroVofepWKRvffMc8OPptts9JPZuARG/tHBOjO
 sLqoKfdhs0IfMZ24Vk+h22l9+K2vNrlL8GWKlbhj2morTQUohh2bjhY0VsWIqwTQ9jdNb5+/VsP
 RvP4sP0kbFmczBwp2iCue3WHMppqaPrzIep+8+xnINKJZd7vxhQEtdjQqdGmN3obDbEQNuYI8Up
 b2X0F6dLw9iHZ2Qq9Uxb0VlwNkgqIe/+gMVSxHHZwkBSo8Qe5oZBcsQ7qgy7zHO8qJqmBv2FDO5
 4XevzMinvfWp7xNV0SGOp2mkuJ3tNJV1FZBoos/YFUDfbF/0C68y5PMpWbKBfn6X3EYVAw6Een/
 k8+IFUvx92Ct1FubBoPL0rIW08/+I1tU+ku9At+BUoSdSPxAfU+syYvWu8HBC9e42RU0aOKfmy1
 5HUaakBQjOmFtDYzknjjEr8VVZzkoBIXacN1Z20Vrk20dqvVMAcahmWt/yYUPF3hiZhoOPhWwlt
 ew/BoLBNIXjMCx3/19vUL2Ov+C+cmQCwjd393SaECGXLfMd9paXYbRuRShn8+XztT7EcSmXYQOT
 BFfZxCBC1bPwdbw==
X-Mailer: b4 0.14.3
Message-ID: <20261012-gpuvm-reserve-overflow-v2-1-519ef15e2172@google.com>
Subject: [PATCH v2] drm/gpuvm: skip setting kernel_alloc_node range on overflow
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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

When the reserved VA range overflows in drm_gpuvm_init(), insertion of
kernel_alloc_node is skipped, leaving its vm pointer NULL. However,
va.range is still set to a non-zero value, which causes drm_gpuvm_fini()
to dereference the NULL vm pointer when removing the node. Thus, only
initialize kernel_alloc_node's address and range when the overflow check
succeeds.

Note that this fixes unsoundness in the Rust GpuVm::new() abstraction:
passing a backwards reserve_range (start > end) when overflow checks are
disabled causes `end - start` to wrap around, triggering the overflow in
drm_gpuvm_init() and dereferencing NULL when the GpuVm is dropped.

Cc: stable@vger.kernel.org
Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Collapse the two if statements into one.
- Add Cc: stable.
- Link to v1: https://lore.kernel.org/r/20261011-gpuvm-reserve-overflow-v1-1-9c0cb23d7409@google.com
---
 drivers/gpu/drm/drm_gpuvm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index d1c80ad3dead..8e74d171125b 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1126,13 +1126,12 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 	gpuvm->mm_range = range;
 
 	memset(&gpuvm->kernel_alloc_node, 0, sizeof(struct drm_gpuva));
-	if (reserve_range) {
+	if (reserve_range &&
+	    likely(!drm_gpuvm_warn_check_overflow(gpuvm, reserve_offset,
+						  reserve_range))) {
 		gpuvm->kernel_alloc_node.va.addr = reserve_offset;
 		gpuvm->kernel_alloc_node.va.range = reserve_range;
-
-		if (likely(!drm_gpuvm_warn_check_overflow(gpuvm, reserve_offset,
-							  reserve_range)))
-			__drm_gpuva_insert(gpuvm, &gpuvm->kernel_alloc_node);
+		__drm_gpuva_insert(gpuvm, &gpuvm->kernel_alloc_node);
 	}
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_init);

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261011-gpuvm-reserve-overflow-5b520d76889e

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

