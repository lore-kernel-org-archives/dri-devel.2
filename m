Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834D7109879E
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B08810EB1F;
	Fri, 20 Mar 2026 16:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="X8wexDE9";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC37810EB1F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:08:37 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-4852ccff333so20987595e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774022916; x=1774627716;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hILqzC7MD7FbW4XOE96YtVaGbJfLwnag6+QDuuvsh58=;
 b=X8wexDE9IPLpa5myRlBcswPjxIX3DMxDqPnEFmg65p86/zt1B2VvGe4FE1dX8ugmH/
 tgzxVlJnyF0jFoHFw+wL0DMbIkp3g3pfAReFPzzPtkx6TJB7owToBtzRwQhyq3QIlzt1
 GTcpr9us8TCoArOGE/x3Mr9DKiQMLLdXBkIzB74MZb1kzJszvE45xANUOY8cIAOCWuFU
 22yguARQrlNt+AsgQ8lwvGw9+SLfCvggU2Hue+o/byLJ1izHE4On7e5B+sl01+tuK1Fi
 pyl6jFKH00ZHO5fT77o1SgYnfwYawk+sgqfCxXgh+ljikrsq6yoRo76aHFaGRqIADYlU
 fflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022916; x=1774627716;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hILqzC7MD7FbW4XOE96YtVaGbJfLwnag6+QDuuvsh58=;
 b=ZWkmmC8LGd3xJCy+MwNz5yaE4OBGE0EWUILOStMMMh0hOn+afODCuFV4bx9xXPWT41
 JnBlFNb8M3XUWl05ZO7ObhbiExbpH235HWSSp0ctneIAal9Xn6YCeGsR+XGUulgugmzJ
 jTV/5msdC9FkLkHgWsqR6EyDUAc4ytGh4kzv50epxv+3DrZmuE8bUuTcp7h/DDzisyVd
 0lms8aDm8a4FHssoZioGsG2i4uJ8klQRDtMKPkX50/PSbZinEVmLUwviVAVv3ktrB85Y
 zFtnIKhKtlfSGhkYTesG2OLQh7FT1ErjaqpVqhqiVpzHFP7JgtKYg37gQ40/AW7JF51X
 03gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbncLW/KcSpbtCkMwajCAolN5zNh3V3ZUVWVmWBDonVEnxA3zAoyvGp088wLb5uX39P0AicnF+pnk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4kGmiq7+WcjrAIf7unYQ+lqAKaP9j1yW9P+XcMw+x57rUE7bK
 MlD8zT4BQIcvr0i4r6R6XLP5Pr5sZZWBauNhi9yI5MPAiiysR//URjW+MukKMrjNA1bfyBokCqF
 BaQzIq04JcQQf5GPGFQ==
X-Received: from wmoo17.prod.google.com ([2002:a05:600d:111:b0:485:4ce0:d98f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:2d14:b0:487:2b7:18d1 with SMTP id
 5b1f17b1804b1-48702b718demr12384625e9.33.1774022916077; 
 Fri, 20 Mar 2026 09:08:36 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:08:24 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPlwvWkC/23Oy4oCMRCF4VeRrI1U5eZl5XvILHKptAE1kmhwk
 H73SQsDNro8Bd9PPVmlkqiy3eLJCrVUU770oZcL5o/2MhBPoW8mQGhEseHD9d7OvNzrjbs1br3
 1Ym2DYR1cC8X0eMUOP30fU73l8vtqN5yuXzMNOXBy0RgXhVQE+yHn4UQrn89s6jTxbw0gzK3oN
 rgAqAC0Bfdh5ZsVOLNysmGrPShLXuoPq96shJlV3W6kUQFBxajmP4/j+AfajeGXWQEAAA==
X-Change-Id: 20251128-gpuvm-rust-b719cac27ad6
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3392; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=hBlKdMS6RYtRgGMEPDODjPhE5SmwLiL4EI9j5rPli5Y=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpvXD9hBnBy4v/N6Ooh3haSutKrTSCowEuWwZf9
 kZMSiNUnCOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCab1w/QAKCRAEWL7uWMY5
 Rr0QEACZwV9PxTgCruBbLTsHjzQgM11t+YsflqqbdcOgBS/GhczSHGBedviQkKyhzvAMab4HhUl
 mdsRWPVwejLNQigClprES3R4MULyJdPhYfR97xA9QffeRgfjgwzkupOrre6COplPPfZQ0xK8FQl
 THXBKbzpdG49Ew+gup/wCJasXqCdCGtaHQC41z+mk440fvmiP+jxAIKVxtjYV8v9u84QWMSzYec
 k533VjGC2VwMPYJp8k1wVToNSx/Qj1XFq/KdsEq7phQtFoLpUijN6ODhnM5E2d8cxYDpZD3Psz/
 lDDr2AkmbYPoa2ndyrLLFJHp6X6f9c4ikaLmm+akIlqAX06hhqrrqhatGFcvbP9C2EsY5q/QXg1
 Vu9dl6J7eZ+m/LOXI2MoaPfnHT5hxiK4nAzW5HSOQTpD9S+ypJmBPOdSbGT7837CsFTdan2mWy2
 cZdXgLqL7eO7HfuRmsj5FUVaken6OCRCe/RVYJX32Aw49NjesaVsDov+toyluRsmCB0T7E6ZTvq
 L9qfmg4gC4VKE8CKrzOQsWiviHe8sUljWf7BPDNZgSKMaQlTDkzRvxDFPJO2s77/5scbnd2F/1l
 sKMtkVddXR6A7NGJbsah41YY1WAFhxO/R0ZQ0UDzRJKP9m1UQZh3IKM5GafFsatzfCB1zhoCo+D
 C7ex9s8fEM/0HmQ==
X-Mailer: b4 0.14.3
Message-ID: <20260320-gpuvm-rust-v5-0-76fd44f17a87@google.com>
Subject: [PATCH v5 0/6] Rust GPUVM immediate mode
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, Matthew Brost <matthew.brost@intel.com>, 
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Lyude Paul <lyude@redhat.com>, 
 Asahi Lina <lina+kernel@asahilina.net>, Sumit Semwal <sumit.semwal@linaro.org>,
 "=?utf-8?q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
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

This series provides an immediate mode GPUVM implementation.

Only immediate mode is provided for Rust code, as all planned Rust
drivers intend to use GPUVM in immediate mode.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v5:
- Rename GpuVmCore to UniqueRefGpuVm.
- Implement Send/Sync for GpuVm.
- Move helpers/dma-resv.c in MAINTAINERS
- Improve GpuVmBo allocation and free docs
- Add "in GEM list" invariant to GpuVmBo
    - also mention said invariant on GpuVa
- Replace GpuVmBoRegistered with ARef<GpuVmBo>
- Add TODO about dma-resv lock usage
- Add __rust_helper to helpers/drm_gpuvm.c
- Change _invariant type to silence type complexity clippy lint
- Link to v4: https://lore.kernel.org/r/20260130-gpuvm-rust-v4-0-8364d104ff40@google.com

Changes in v4:
- Add trait bound so that DriverGpuVm::Object must be the same type as
  Driver::Object.
- Add rust/helpers/dma-resv.c to MAINTAINERS.
- Add __rust_helper to dma_resv_lock and dma_resv_unlock.
- Rename GpuVm::raw_resv_lock() to GpuVm::raw_resv()
- Reword comment in obtain() for adding to extobj list.
- Fix typo in commit message referring to GpuVm<_> instead of GpuVmBo<_>.
- Changed the PhantomData type used for invariance and add comment. (No
  functional change.)
- Rename offset to gem_offset in args to sm_map().
- Link to v3: https://lore.kernel.org/r/20260121-gpuvm-rust-v3-0-dd95c04aec35@google.com

Changes in v3:
- C prerequisites have landed, so only Rust part is present.
- The logic for drm_exec was removed, and is for a follow-up.
- Split up into patches.
- Add lifetime to SmStepContext.
- Docs filled out.
- Mutex abstractions used for GEM gpuva lock.
- Drop 'shared data' concept for now. (Can be added back later if required.)
- Rename 'core' field to 'data'.
- GpuVmCore<T> now derefs to GpuVm<T> instead of T.
- Renamed GpuVmBoObtain to GpuVmBoResident.
- Probably more changes I forgot.
- Link to v2: https://lore.kernel.org/r/20260108-gpuvm-rust-v2-0-dbd014005a0b@google.com

Changes in v2:
- For this version, only the C prerequisites are included. Rust will be
  sent as follow-up.
- Add comment to drm_gpuvm_bo_destroy_not_in_lists()
- Add Fixes: tag.
- Pick up Reviewed-by tags.
- Link to v1: https://lore.kernel.org/r/20251128-gpuvm-rust-v1-0-ebf66bf234e0@google.com

---
Alice Ryhl (4):
      rust: gpuvm: add GpuVm::obtain()
      rust: gpuvm: add GpuVa struct
      rust: gpuvm: add GpuVmCore::sm_unmap()
      rust: gpuvm: add GpuVmCore::sm_map()

Asahi Lina (2):
      rust: drm: add base GPUVM immediate mode abstraction
      rust: helpers: Add bindings/wrappers for dma_resv_lock

 MAINTAINERS                     |   3 +
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/dma-resv.c         |  14 ++
 rust/helpers/drm_gpuvm.c        |  26 +++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/drm/gpuvm/mod.rs    | 306 +++++++++++++++++++++++++++++
 rust/kernel/drm/gpuvm/sm_ops.rs | 417 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/drm/gpuvm/va.rs     | 150 +++++++++++++++
 rust/kernel/drm/gpuvm/vm_bo.rs  | 234 ++++++++++++++++++++++
 rust/kernel/drm/mod.rs          |   1 +
 10 files changed, 1155 insertions(+)
---
base-commit: a19457958c3018783881c4416f272cd594f13049
change-id: 20251128-gpuvm-rust-b719cac27ad6

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

