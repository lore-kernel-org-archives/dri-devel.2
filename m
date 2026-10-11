Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9FFCA9EC9
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 07:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27B810E030;
	Sun, 11 Oct 2026 07:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="mwH5mLBv";
	dkim-atps=neutral
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A1810E030
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 07:22:33 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e6b5c5f44so16754635e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 00:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791703352; x=1792308152;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hvbrsW1mo/6FXW+04W7eG9GRRwc1pm+Fzyrx7oUOUKY=;
 b=mwH5mLBvAM8mKEegh2NwUXHKeO6yVtNHO2hexkVbzRYnUTnO9W/cPK7sxzoSazJW1u
 lf39vsr2L57vzvvQpcV1ZA3eOrx6QWe7goIFIAaqobhiycxWIMNQsJ2JLc2ibkUnVTJR
 XxnJ+p5AMotfsQzCUwj44kbaSYgRoTCmCNzxaHjUQmivDG/9yzTuiCcvFUVyxE46Mbwn
 +p/Qz0n3s6Z4LwKVI23YHQYUS2B1quwVFHi2fRDkxA9WUouga7kpu+R1O/pCCAwvUEH3
 +kmEkh8rLg/kUBKqYCdiRtq4+9sFIHjwlrYiOu8yXhgk5kOe4q21b1/oYt4WKB3/99Lj
 lLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791703352; x=1792308152;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hvbrsW1mo/6FXW+04W7eG9GRRwc1pm+Fzyrx7oUOUKY=;
 b=y+AuPUxaRA3qHyYe8ogylCCnNxLWOhAwP+kkMFxbaMGNQi4JMyl7AK8H9TE9oxMG0s
 kmGeDmzEtgBl2xjz7MW1O6jZL4Mk8rJLSBtyzNZwMnbrpibj/8zd9AhuI2pv2KZxzj0m
 Zf/hWj5DUfd9MKJgSK18kjkm2w3EZWtP5TMjjmM0KVeMEC28ag+EpYkBczu7f+ilMsrO
 prTgbZzSsMS1aDuJYQlOL37I92v1/WFdaPzhJL+0L2OGAVEcY/HgKm2pzwQFpX/h39na
 F34mauSJ9dAohItbz3wOxBh5EZW7TAIGFKjjCuc2R8oobFOfRYrpEI0AV6eCvv5tKeRc
 5Dpg==
X-Forwarded-Encrypted: i=1;
 AKwUvByeebTwKYqjix3iFihEEdu6Te1vWZDY4PwK48uznMudGdpp79lGWNwXibVwOyiP19/38CWvmRH5f8w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIsZeZDs5EP+15Ne4t9SJ4kbJJ3Qn/48CO39RNbeKavcwpo3hpx
 2zXxt9KeIdHRR/OV9bMJTe42yaAKWbpZ9ibEzwRccKJ171Lr51sYJdO4syRauSzByrRIo/jTobC
 umYabaD1aBjavIE+B6g==
X-Received: from wrvo9.prod.google.com ([2002:a5d:62c9:0:b0:48b:b2:a375])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154c:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4a18e4a9b88mr129872505e9.13.1791703351428; 
 Sun, 11 Oct 2026 00:22:31 -0700 (PDT)
Date: Sun, 11 Oct 2026 07:22:22 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC05y2oC/x3MQQqEMBAF0atIr21IAjrqVcSFo19tUCMdjAPi3
 Q2zrMWrmwJUEKjJblJECeL3FDbPaFj6fQbLmJqccaU11vJ8nHFjRXIR7CN0Wv3FxbdwZvyUVVW
 DEj4Uk/z+47Z7nhf1Ku0NaAAAAA==
X-Change-Id: 20261011-gpuvm-reserve-overflow-5b520d76889e
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=ziT/zq8KkzNVIsF0WWx+lXTJdR2Ix6V6zIRJw4f+Xsg=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqyzkyOJ70AQD13qV9X0DzlJkRrhzWP3pQIVWBZ
 cQOWHFsopKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCass5MgAKCRAEWL7uWMY5
 RihfD/9agbFtirssrsDUXcyn9UYZDRBpdwjYrwBBnCDaKKxWc/EDMmuVPTolahMPyyev4ryitR7
 TlhCOpZ92X5HOj656cEaQfEQJE0yqRqQPh0aYZCBuQXt5daDucF/hSFIBSsnuuT25s1Fjlw+oLw
 J3vuaUzurS1lC9AZjrV6HcSpRkGH/lMC4KExhiI7ibmTOi5erlqAB/JoZhUReMUjGEzCNIntuVn
 +TbdF1c6+6kJZAWY2bQiWsjwR+fw2EvOJhtBtR2JXKEDSmegM2y7G+FUk0iZDHnvFIf7UAf0XqC
 h2oRAPZEozMUpbgLYzRNDIjxZ81ZjsfmEMRAPKGh6WjWrAh9Cq5s43R3SZSxGbcvD0zJQQM+Njz
 x429P4lQH7CagQ8LQ/PYXUgWuxBHY4xR1t1p85OG697TmjOtC1F4ZfS5WAMTK18j+88Kv2E/3/W
 4GS09ILc9NKQVtOBCiazMVYaWVg96teChsQCIryV3VXL4o+YbQmZaiUlu6SoYTII86oNO+5VCJ7
 8hD4G6vAOq6OZrGuIykTyECpv2xiqEHaiwQuyl8m4br/T6c15p7+rwH1ArmWlbx/YPxPGMhyWfi
 ikJVsqJRfHq0lCDCIhyNhNZU+ewzHhdXPRb1UR8H8cNtWecLTQRPWR/Wq7zFwLl2ObwAEDceB64
 U3I09HoDW086s7w==
X-Mailer: b4 0.14.3
Message-ID: <20261011-gpuvm-reserve-overflow-v1-1-9c0cb23d7409@google.com>
Subject: [PATCH] drm/gpuvm: skip setting kernel_alloc_node range on overflow
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
 Alice Ryhl <aliceryhl@google.com>
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

Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index d1c80ad3dead..626985743943 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1127,12 +1127,12 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 
 	memset(&gpuvm->kernel_alloc_node, 0, sizeof(struct drm_gpuva));
 	if (reserve_range) {
-		gpuvm->kernel_alloc_node.va.addr = reserve_offset;
-		gpuvm->kernel_alloc_node.va.range = reserve_range;
-
 		if (likely(!drm_gpuvm_warn_check_overflow(gpuvm, reserve_offset,
-							  reserve_range)))
+							  reserve_range))) {
+			gpuvm->kernel_alloc_node.va.addr = reserve_offset;
+			gpuvm->kernel_alloc_node.va.range = reserve_range;
 			__drm_gpuva_insert(gpuvm, &gpuvm->kernel_alloc_node);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_init);

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261011-gpuvm-reserve-overflow-5b520d76889e

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

