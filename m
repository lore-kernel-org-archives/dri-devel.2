Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEC2C44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C7D10F44F;
	Thu,  9 Jul 2026 07:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W+bkMLap";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B8B410E29A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 19:46:50 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cac59f8b64so54777995ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 12:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783453610; x=1784058410; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mr3RDiBFqeIYTx2r/qE+kwdslKLjgblCNaiBX5VWqtY=;
 b=W+bkMLapfUqJY7oo9l3eX24A7Bal+MZ308CbxL01y6laxJoB4zLi9JVk+Dee8uXZAx
 sJB+EJT5bdUqZ/aXMcfr2Q/IrebYK/hgps7BvVIV7Gq0/oNFHp9GdSXYg0yODgjsxTiP
 pulBivtFW2RJcnY124Loc3MXMutqRdIS1C4Qo6A0UwxRBrMgQEBrjhx5I/e1YGf4Hmbb
 goWjAtWYUq3yWDKQXu0KaQ5qW5kVBMQbAd3PFwXGNyLwt+HnEi2MosxaApavPO41UlAl
 Uhez/MBhMTgU4k+6ROuGagJMkZHE+FQ0j36OdPx/+frQ3g5YjXO3tq26HTtmcc5KIes+
 bnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783453610; x=1784058410;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mr3RDiBFqeIYTx2r/qE+kwdslKLjgblCNaiBX5VWqtY=;
 b=ZFXCkDDbrmamnhrn3qtkEvIVbx7UErepwZ6M1n19ZazOs2/qwqLFxyw+c/vB6wNNhn
 oxULnO3HzKx1kYkf1RLxzjvOzZ8zpEmSJ2DZ1TBfUt1yvboYIu9HHmtGkOwAJFtwoiMm
 +05vgpP5r/jEmrjZdOWnKt56y2E5PJk32pPrMiIPRmQCSgOTCQUEytQTdsO2oOBDTLf4
 hCr7Rakc64tlgUZ9OqaaXxPFXq3pOLxJQZt6SLmAl/wVyE1RrKdzSzPhkkcdEN9vJPLv
 EMMBA7j/9wDWV2FEegEU0O8ii5f58B/I4HO443gMjgCfIR8BANwi19LwoaEgDK8jZFlF
 WLoQ==
X-Gm-Message-State: AOJu0Yza7eX9D8RZusgXHM8Jf1G2UZ2ROqbV6QaUKgdtR0FCUwQFt3u5
 +zkU01kNfF2fbWTbLgwAf919i7Qg37aivVqj5nzQ+mrG08evA32O1Q/R
X-Gm-Gg: AfdE7cnrOvdxrXCzaUn8x30of38TJn3oeOHymuIaPsfXRG+w4OmLAWJl4W6WQdOKwL3
 2QH7Y9QrPcmHnO3FWP6F3CitM2UasvBMw9rRTMKxoIpzcx2nn/Dld91fds8pTEydPBRen60oi8X
 9ODD60FN9Riki0TfjQK+X+57qFMEzRJ9PwUsI5vKeaQTozRUXstMhjhWuj8PiXtxiZyI6wqhREM
 isZiD2hiQemXtYNhqr387wnWaKUUE6a84666Dm+qSbHKdgnyZBOZ+hQUCxUtaGyqvdFw42xA/WS
 FInGlYNjNcfEmp0MH0pP4TTrbEku1n2jraHljyP0aqXP5NERoyGg6eez/tbt+ntkAX8flSdz/V6
 cOgQRdEl4tRd59BGh3LAx6zXHUlQ59cktUI0Go+bGqyggCCKzMq2unHqizZfYuFKlXhsukFjBHC
 khF+q75V8UZI+QQM5+7nFZH3BXx84PHFD287X+MiqP6VQ4/DP+c8PCkSBOFXg=
X-Received: by 2002:a17:902:d490:b0:2ca:ef4c:e553 with SMTP id
 d9443c01a7336-2ccbe40b1d7mr62952355ad.3.1783453609639; 
 Tue, 07 Jul 2026 12:46:49 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb86bsm17316425ad.11.2026.07.07.12.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:46:49 -0700 (PDT)
Subject: [PATCH v7 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Tue, 07 Jul 2026 12:46:46 -0700
Message-ID: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

This series extends the HMM framework to support userfaultfd-backed memory
by allowing the mmap read lock to be dropped during hmm_range_fault().

Some page fault handlers — most notably userfaultfd — require the mmap lock
to be released so that userspace can resolve the fault. The current HMM
interface never sets FAULT_FLAG_ALLOW_RETRY, making it impossible to fault
in pages from userfaultfd-registered regions.

This series follows the established int *locked pattern from
get_user_pages_remote() in mm/gup.c. A new helper function,
hmm_range_fault_locked(), accepts an int *locked parameter. When the
mmap lock is dropped during fault resolution (VM_FAULT_RETRY or
VM_FAULT_COMPLETED), the function returns 0 with *locked = 0, signalling
the caller to restart its walk. The existing hmm_range_fault() is
refactored into a thin wrapper that passes NULL, preserving current
behavior for all existing callers.

Possible approaches to lift this limitation are documented in
Documentation/mm/hmm.rst.

Changes in v7:
  - Replaced the unlocked HMM API with
    hmm_range_fault_unlocked_timeout(). The helper now takes a timeout in
    jiffies, with 0 meaning retry indefinitely.
  - Moved -EBUSY retry handling into the HMM helper for the unlocked path.
    The helper refreshes range->notifier_seq internally before each retry.
  - Switched the unlocked path to mmap_read_lock_killable() and return
    -EINTR if mmap lock acquisition is interrupted or a fatal signal is
    pending during retry handling.
  - Removed the redundant non-timeout hmm_range_fault_unlocked() interface.
  - Updated Documentation/mm/hmm.rst and kernel-doc to describe the timeout API
    and the intended caller pattern.
  - Updated the HMM selftests to use hmm_range_fault_unlocked_timeout()
    only, including coverage for the finite-timeout path.
  - Added in-tree users of the new helper:
      - mshv
      - nouveau
      - RDMA/umem
      - amdxdna
      - drm/gpusvm
  - Preserved each converted driver’s existing timeout convention:
      - unbounded retry where the old code retried indefinitely,
      - HMM_RANGE_DEFAULT_TIMEOUT where the old code used that budget,
      - existing driver-specific timeout return values such as -ETIME.
  - Used max_t(long, timeout - jiffies, 1) when passing remaining time from
    absolute jiffies deadlines to avoid unsigned underflow while keeping a
    minimum one-jiffy retry window.
  - Left callers on hmm_range_fault() when they already need to hold
    mmap_lock across surrounding work, such as drm_gpusvm_check_pages().

Changes in v6:
  - Reworked the new API from the external int *locked pattern to
    hmm_range_fault_unlocked(), which owns mmap_read_lock() internally.
  - Changed the dropped-lock contract: hmm_range_fault_unlocked() now returns
    -EBUSY when the mmap lock is dropped, and callers restart with a fresh
    mmu_interval_read_begin() sequence.
  - Kept hmm_range_fault() as the locked variant for existing users, preserving
    its caller-held mmap lock contract.
  - Added an in-tree user by converting the MSHV region fault path to
    hmm_range_fault_unlocked().
  - Updated Documentation/mm/hmm.rst and kernel-doc to describe the unlocked
    helper and retry pattern.
  - Updated commit messages to match the new API and return semantics.
  - Kept the userfaultfd HMM selftest using the test_hmm unlocked read ioctl
    path.

Changes in v5:
 - Rework hmm_range_fault_unlockable() retry handling to retry
   VM_FAULT_RETRY internally with FAULT_FLAG_TRIED set, matching the
   fixup_user_fault() pattern and avoiding repeated first-retry lock drops.
 - Distinguish VM_FAULT_RETRY from VM_FAULT_COMPLETED: retry faults now
   reacquire the mmap lock internally, while completed faults return to the
   caller with *locked = 0 so the caller can restart with a fresh notifier
   sequence.
 - Document the two *locked return states, including the -EINTR case when a
   fatal signal is pending after the mmap lock has already been dropped.
 - Update comments around HMM_FAULT_UNLOCKED and the HMM fault loop to match
   the current hmm_range_fault_unlockable() implementation.

Changes in v4:
 - Rebased on 7.2-rc1

Changes in v3:
 - Return -EFAULT from dmirror_fault_unlockable() when the mirrored mm can
   no longer be pinned.
 - Add an eventfd stop signal for the userfaultfd handler thread to avoid
   waiting for the poll timeout on successful test completion.


Changes in v2:

 - Split into a preparatory refactor (new patch 1) that moves
   handle_mm_fault() out of the walk callbacks, plus a smaller feature
   patch on top.  Suggested by David Hildenbrand.
 - Hugetlb regions are now supported on the unlockable path; the v1
   -EFAULT short-circuit and the hugetlb_vma_lock_read drop/retake
   dance are gone.
 - Distinct internal sentinels for "needs fault" (HMM_FAULT_PENDING)
   and "lock dropped" (HMM_FAULT_UNLOCKED).
 - Outer loop now re-walks after a successful internal fault so the
   faulted pfns end up in range->hmm_pfns.
 - Kernel-doc on hmm_range_fault_unlockable() and the
   Documentation/mm/hmm.rst example match the implementation.
 - Dropped the mshv driver conversion (v1 patch 2); will post
   separately.
 - Selftest converted to drive the path through test_hmm with a
   userfaultfd handler (new HMM_DMIRROR_READ_UNLOCKABLE ioctl).

---

Stanislav Kinsburskii (8):
      mm/hmm: move page fault handling out of walk callbacks
      mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
      selftests/mm: add HMM tests for mmap lock-dropping faults
      mshv: Use hmm_range_fault_unlocked_timeout() for region faults
      drm/nouveau: Use hmm_range_fault_unlocked_timeout() for SVM faults
      RDMA/umem: Use hmm_range_fault_unlocked_timeout() for ODP faults
      accel/amdxdna: Use hmm_range_fault_unlocked_timeout() for range population
      drm/gpusvm: Use hmm_range_fault_unlocked_timeout() for range faults


 Documentation/mm/hmm.rst               |   63 ++++++++
 drivers/accel/amdxdna/aie2_ctx.c       |   17 --
 drivers/gpu/drm/drm_gpusvm.c           |   52 +------
 drivers/gpu/drm/nouveau/nouveau_svm.c  |   11 -
 drivers/hv/mshv_regions.c              |   54 +------
 drivers/infiniband/core/umem_odp.c     |   18 +-
 include/linux/hmm.h                    |    2 
 lib/test_hmm.c                         |  111 ++++++++++++++
 lib/test_hmm_uapi.h                    |    3 
 mm/hmm.c                               |  246 ++++++++++++++++++++++++--------
 tools/testing/selftests/mm/hmm-tests.c |  220 +++++++++++++++++++++++++++++
 11 files changed, 613 insertions(+), 184 deletions(-)

--
Signature

