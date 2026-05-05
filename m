Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA408CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374F210E41F;
	Tue,  5 May 2026 13:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="B6lx5gIK";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E25D10E41F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:29:52 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-48a7994e8ddso52078615e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777987791; x=1778592591;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wwcyT+EW8u9QfzYxBkySmaOJuohl1RTtLe0zE2pkhOs=;
 b=B6lx5gIKqaV53FuzmqbeQUJmnUX6/m46ua4S+aN5lc1teCW75uso+LMa/fjpkg3rsU
 7UqOOKWqwU39pEMPot8iaxVbyGatlO02YudMIlx85bQ81MyRdMcN5TD0AtdN04ZJ3Qy0
 Uhn+yRKMPqCqXsnmbx/zugRd65MsXqd8gtlN4vNbVSx/NG6gIHYDH9FnEymfUbYu6kDV
 dgPSf9gf2RP+rJH14/64btbZxouRqJAyxP4XKuqyPikhMvKJ6Zs5n7dJF+ZEV6EJ//1j
 SqOZMXTUiYzclN8yE8QbyAE8zxRcMKNAQ2gsvqGfYx5X+5s7g9OqoTY27L81aIGP2uLh
 VMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777987791; x=1778592591;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wwcyT+EW8u9QfzYxBkySmaOJuohl1RTtLe0zE2pkhOs=;
 b=ZKZbmqayx2zADBCN9GWi+EaPV/AAk/w9ytl4o6FVxnhkaBeNcYzHbtIsM0jifYC3mE
 7A0RpoeFrBzXUurheuybSW7h9rwUZHD5z90/ahoYPXHEZFhTnIhAAxffjZmCK7z0Lxxi
 WXJGG/J5pK2Qe6gdB+7RcbxBhpnkL+E7Kv2me4E/M8OrAKveH4QUjkxjgoSMToYH7kQd
 ubtvCt7DNTNv2cNDNger389NAP9J8UmbKhj2023OqZDn4k2Z5rEiS35/kWTH8A+/ibZE
 +slFb6CWWHUDxNfwCg5aJ3yBJEjpzPn163CEG7FGUd2QSlcW0hDJZ76ipJYdMkwJbcHj
 EfMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/sJ67kERLlDd620Hc3l0cI2yB9qsEpowu4Y9+m8J1aa/LYS2kZdrKSCgR/cdeg10IWUzMVCtUTBs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtG0EYja1PyZranMsx5bF9ZmPHx08goFy9keVJ5Zfg01TIyB6H
 cUnWKGa8bZ9iXIznzE7Z5mmJuz8kDnaxaUnMjP9Z+2OVs64C1ijnk1ntPDFs9d4CBbI3D5ZexQo
 JM5URjPJz3UGlqH7uKQ==
X-Received: from wmph37.prod.google.com ([2002:a05:600c:49a5:b0:47f:941a:613d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6097:b0:489:1c2d:211e with SMTP id
 5b1f17b1804b1-48a9852f571mr227000005e9.5.1777987790931; 
 Tue, 05 May 2026 06:29:50 -0700 (PDT)
Date: Tue, 05 May 2026 13:29:35 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMDw+WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3fSC0rJc3ZSiXN3UitRkXUuzRDNDU8MkgxRTYyWgpoKi1LTMCrC
 B0bG1tQCySGA7YAAAAA==
X-Change-Id: 20260416-gpuvm-drm-exec-96a6151b0d53
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=qmFMX+YKgFbsNTYBK8WQzT05aCnSTScT0mEy3LvunMY=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp+fDEBD7mdPrMI0t4BmUT90gb46RcCxfaW+jBl
 IAGWVJpp3GJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafnwxAAKCRAEWL7uWMY5
 RmAaD/sFtC36JNPba5y+NVwW0TVb9EIv2OuG+GaK1WkuPe51bcYuRgLZoHPBOsDT9TDclPdlZNJ
 1lGA8nO/0y4qh9tx5dlqfbBmNhqmoP91Qit5Wm5jhD8pZyGNxHSxcj7CKAghFrJNfaW7e9HFaTv
 0Yn1BlxsBJkrbZO1Ly256BGVBM5d8ZCwYo5GDLLC9xa1GYmb5UHMVsFSm+To7iL5zmS+x1KOorN
 oz69T575w7sRd65FGT0aOysikLputKHTv0jdeqhkXGM0RZuKQ79vpAfeLR3JVPZSV93iHQ9+0zx
 XxpicqyNmQ0b4Jqlk0l/9857AmY6o13SQebSQD5JAcjVp6YCOE6q2zf7xEFOUpgRQskYWW8GwC9
 HIMsyUZin/vwX/Mmz7cOVeVmDnCgfdIj0Zr/q0kLSz5jCYc0d7H7cCHb+1D8sJeCf0mbSFyvFiO
 e/veLgxPFXApfVZE7YniZwYLg9gVY38+w+C8U3cuQ5rRmfnDGvwRyQUed2Os96jr0VdvUYzEWhm
 A3Uqvb6vbYoO0igw47heCZUiL+hE/usphsfeMnS9CA89tGbUXECa/pGb8jjnFUJF4iKdJN//TO0
 gYAQ0J5XwXGiTTDi+NOFXe2WI/ANZ8zkOWqErI+vPfl9/7Nev0dgSZ0ml5jbPF/YgzGWxIaPodn
 E+w8I99vs+Eo52w==
X-Mailer: b4 0.14.3
Message-ID: <20260505-gpuvm-drm-exec-v1-0-958306ded36e@google.com>
Subject: [PATCH 0/2] Rust support for drm_gpuvm_exec
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>,
 Philipp Stanner <pstanner@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?utf-8?q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
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

Now that the core GPUVM support for Rust has been merged, I'm sending
this follow-up series that adds a super simple way of locking the dma
reservations and registering fences.

This logic was included in v1 of the original Rust GPUVM series, but was
dropped in v2 for inclusion in a follow-up. This series is that
follow-up.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (1):
      drm/gpuvm: rust: add drm_gpuvm_exec support

Philipp Stanner (1):
      rust: dma_buf: add stub dma_fence abstraction

 rust/bindings/bindings_helper.h  |  2 ++
 rust/helpers/drm_gpuvm.c         |  6 ++++
 rust/kernel/dma_buf/dma_fence.rs | 32 ++++++++++++++++++
 rust/kernel/dma_buf/mod.rs       | 24 ++++++++++++++
 rust/kernel/drm/gpuvm/mod.rs     | 71 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs               |  1 +
 6 files changed, 136 insertions(+)
---
base-commit: 37f748ed0c19e007e7c5677f5d605d6b93841792
change-id: 20260416-gpuvm-drm-exec-96a6151b0d53

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

