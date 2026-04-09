Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3B1F31E27
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD3F310E81C;
	Thu,  9 Apr 2026 15:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="b9Uc8kzk";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF7C10E81C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 15:26:18 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-43d07f0aca0so807432f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1775748377; x=1776353177;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cl4zHEWa3vbNqjNAUqI0XoqCdjJniLlktUteRV6Lwh0=;
 b=b9Uc8kzku8Zn1ottbROq3vUapARA7Ercet2pe20uPTt7WvaW2Dfz1UihT9jzI6h/l+
 ekhChh+YEKTB3ruNweIXIJmOY8LW5DA0buZfrgmgBaYAQCgdshvUyJ9a01PuWjRma+jF
 9KzmcJcbh+66/jSrzJlksV00C30Nwz6OpfpSWqlrJ+fcstqjESkRffD5gkymcoKmfp4m
 3DfGlbnzk7AXmX5S20EbmBWT3Brn1a1PQ90CBznvw32EGU+FsdWUfHzNkZNRx1z261Ob
 WyqwOThDYEx9VOS18Y7D48/SHzJv+CnLGc1CbtKJKOZGxaF642ibvD0ooOXEm2nOlrMb
 z1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775748377; x=1776353177;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cl4zHEWa3vbNqjNAUqI0XoqCdjJniLlktUteRV6Lwh0=;
 b=D0Q+ug3/eVZLGue67wS7MV6qeZnn+WBKY0ByXqSdoXSMG5/9Wf6FJB09iYZtIPn32Z
 G0mgJoH32iVUa80yvmNU2+tM6Te1cMcnUvvkSnrGgjZ0aoytdsYwvrdnHxyvVAmHghq5
 P0VThiplwLSDncZEiJH/pcEof6boPbv0XvrNrjGLgquvtcQfVKhu8lxYVVibwyuUhlzH
 HYqqXE0F+v7iXOTzwQaKevNOANP44oTZMY0EWxT6J+V84on7eSw4d1GJHnkCGHUFH5E2
 CWVSFs7tLRGg88LvYjZozgV+H03QuYHX/Y1zeldGC0VtgEN2EBT1ZwXlkKpBXnUpiGN2
 ID8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqbKR+c5ssEVBqT2fKyf7RJHXDO7lG4C8wrcHa9jHaD8fazGgiBOB5m7Z+HQaJJS+95Co/YuJHpeg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxA1XIkdPxnIKvpOVoS10N4mSnBqD6EBzvMdCWB/NCgkeF/cEPz
 W7QE16go6VMiHN85Rq3/fM5OvyLQg0AG7j74EYzpUIFTaSOn3h6if/5AFkxUtvPAa9QoJ5WoDKy
 jG884KilYKsPXSqIhXg==
X-Received: from wmbgy21.prod.google.com
 ([2002:a05:600c:8815:b0:485:c45a:fcc2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ec7:b0:487:cd8:4c9 with SMTP id
 5b1f17b1804b1-488997ed46dmr357920975e9.27.1775748376544; 
 Thu, 09 Apr 2026 08:26:16 -0700 (PDT)
Date: Thu, 09 Apr 2026 15:26:05 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA3F12kC/23OS2oDMRBF0a0YjaNQpW/bo+wjZKBvWxBbRrJFg
 um9R20IsegMX8G51J3UUFKo5LC7kxJaqimf+1AvO+KO5jwHmnzfhAGTiGyi8+XWTrTc6pVajXt
 nHNPGK9LBpYSYvh6x94++j6lec/l+tBuu138zDSnQYKNSNjIuArzNOc+f4dXlE1k7jf1aBQijZ
 d166wEFgDRgN5Y/WYaD5av1e+lAmOC43FjxZDkMVnQ7cSU8gohRbH+Wf5az0cputYpeiIjaTHq
 wy7L8AF9Z+YeVAQAA
X-Change-Id: 20251128-gpuvm-rust-b719cac27ad6
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4085; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=3hE8CiYDdL6dIJtuPkdDujtMFv8WlE2/F3zEHqm7ymU=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp18USp6b8g89yw68rMzxWuogMUxOhaCvjY1ee7
 ooHzNNMzgSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCadfFEgAKCRAEWL7uWMY5
 RpUKD/9RArAhS1RNQNBOKI+dzKU6bec/e0RRFc+Yu77+EHBMb8iJE8A0EbveMxwvU9wF1IAABFS
 1OEIkKcy0LP4pEg5szdlL3/PQRPPztTMX0iabUkSFtFXDUSYVIP86tVP65Wjd8jYotmz37CALOo
 ygNXHhHSE/6gn84hQIRr+vrRQ9LImROE+i88NpI7Y3LHGRbBUdqq6JbKPkqB0yau74SMT0dNw0p
 I6GsAfIZHjmOzwWnsqEpxBIws0hK58HXorjhnVkA/8HiefQvjcXVW13ePNIm/BeEAo/iNeWi9jx
 Y5gOCfQnEzSpM+SGRk+zfhZndiP7IbCCUOKw1cqt8OARn4QSGaCoS4ZoKmjDwX3xQqYURhVhYX1
 ih2rQec17TGFCjQDdvwCoK2KAuXUHbAZ9hWP6CegghkaBeZ/90VCKp6QFr8HVOEgymFhlNAwgKn
 O5B3fNWTXT3MOV3m0bjf2D2vdOxeNh7S58xc1DRaIuXvzcOtiJxP6mB/CcK1fISr3sXi7qKXmrw
 C0d/96DNC17Mx3MYm3M2R8S6tj0AqchTGjqmEpx/IQKHuJkQmkOif2CIHh8ZYcEYcOspyeeUG3b
 SblsNtpxV1B+J3VjLFphdAw+RLwBYzIZjMZ4grLEK3Kg7t1Q4pVy+DeVjCDIdXVRAy8ebtz2jyA
 wXyA1n8zfk5zZuQ==
X-Mailer: b4 0.14.3
Message-ID: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
Subject: [PATCH v6 0/5] Rust GPUVM immediate mode
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
Changes in v6:
- Rebase on drm-rust-next-2026-04-06. As a result, the dma-resv helpers
  patch is dropped because it was already merged into drm-rust-next.
- Fix Send/Sync impls for GpuVm<T> to take T:Send into account.
- Fix Send/Sync impls and data()/data_ref() methods on UniqueRefGpuVm to
  take T:Send and T:Shync into account.
- Pass __GFP_ZERO to kbox, so that data is zeroed when calling drm_gpuvm_init.
- Call drm_gpuvm_bo_extobj_add() in obtain() even if it returns an
  existing pointer to avoid race condition.
- Check that vm_bo is from the correct GpuVm in sm_map().
- Change sm_map() to take &GpuVmBo instead of ARef<GpuVmBo>.
- Document that sparse VAs are not yet supported.
- Link to v5: https://lore.kernel.org/r/20260320-gpuvm-rust-v5-0-76fd44f17a87@google.com

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

Asahi Lina (1):
      rust: drm: add base GPUVM immediate mode abstraction

 MAINTAINERS                     |   2 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/drm_gpuvm.c        |  26 +++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/drm/gpuvm/mod.rs    | 328 ++++++++++++++++++++++++++++++
 rust/kernel/drm/gpuvm/sm_ops.rs | 429 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/drm/gpuvm/va.rs     | 168 ++++++++++++++++
 rust/kernel/drm/gpuvm/vm_bo.rs  | 249 +++++++++++++++++++++++
 rust/kernel/drm/mod.rs          |   1 +
 9 files changed, 1205 insertions(+)
---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20251128-gpuvm-rust-b719cac27ad6

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

