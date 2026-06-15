Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6FBCD98F1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22B010ECF1;
	Tue, 16 Jun 2026 18:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sibHB6Dy";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22D710E563
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 23:49:54 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-9159da9bba5so292954085a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781567394; x=1782172194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gprRcECG7ocsbu5PmU47wu6Nm9wZMyLlyWu40sXkxu0=;
 b=sibHB6Dyo7oZq95aWcBuFfbHrreBrJihzVUzflbCOYKmuT1oodJH1cAnGslWCo/3fh
 b1haXC1WrDWtq6radlzI8ynxLgr6mEJAiXYK/qMrcakVE5+uF9aQTkSeqrMuawfbS9+/
 k/4sYYX10ICSPFH9LfwpYMT/UNJMkuXgwu8NCzCUPDc7FZlCOMPN2GaQFOKcHFW8SICy
 2l2Sd6AcliK+kIohRxs2muL764mFKmST9pGRjV5g8743f52C23ajg2bkcQP3EnES/pLZ
 CpV2ZIu4DaWPaARW0CVgI4fbO/+3Kp1wWMlY+nzGBvL7L3hUrkm1tMNElIgL/FplWzMG
 jkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781567394; x=1782172194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gprRcECG7ocsbu5PmU47wu6Nm9wZMyLlyWu40sXkxu0=;
 b=VYZ2Zhgd61+eDPODQ9SH459K6TLfTv8xZeQ7F5Ksnqt5i/PEOGz89PeGCXOWOT3XLL
 OEI5KAibCY+d8EF5P+AUFU2PXtVLjVANNuKXeUSd3r0LFb+vzrIKE1Xf4D7RebQTgeS/
 kDDQkijk31G+DwHR2jaUe5/vC8oMqBO6TdjT652uOHZr4EIxgp0cG3u8PRH7jCOi3x24
 8qpi1wxL6ejKNQpOmFgCrISCoR+9y/Nj9xaQwxdausz1yyzMT65ZLoYUTw7eSZ/nULq3
 jXYo+s3aYmBK+f045OVhBVAG4rVMi2LjHcjbb/m9DOXIeSTp6SPkmlJR+zHcwIBx6QHO
 IqLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YJvbIlEtydQajlmVkpQ9crW1AESwasRrETeSf02k7RMfXMOCwKmiqEXifAPnjabCiwBHgFJMOsj0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDGPmKwujBM2QM1eMjtZGpaC+OuI2ii/evn0UYE2SzvMAwiriZ
 xhbUB+0bybYTBQCJ5p6oC2NJ3RZMQ0jc44RMIlfLeBFUJHSHQHZzFnIu
X-Gm-Gg: Acq92OHE+sjDCB5mEYN382dR2TuLn8jhU3VYredkgohpWoOih0h2DguaD84v2t07Yh5
 tDKiVU/ERprQdvquruVqoX3HOTHzVpyTXJUIu5TNbamQtbC5gJCmzeegv5omxCVx6+uxyuOIOP8
 QlZQyN+wQugdVQlo3FNOUWGXZBQ0gWTXhnXOszgaYjm3CVPYXQvl+ioO9Z4R6Ht3YE0ZHRSR7my
 QOCim84hOyCBMEI5CFtV6OqMk5C6JPUH5mb5xQASLoQoFdAY2yov3YSh6WJHJe5b4w/UekAjWzU
 Azp2ocQU31pcSZ05owqkTSt+lumO21TclnQhNuVQuejCJF3+DrjvR7GSmwM1PpPtln/yPt2lArk
 wfpPy62AeAHoOc0o1L6IlHN3rT93Sfbuer5THCJKZDh5WXVD1EOcFbKOAX1v3CQVE16aVT0WI9+
 R2z38vInkGnFeNiWQ2fhE+5CoEASnVZpYaV5pGrarJat9bclxp7JBmQv3fiFRe+r87Kq5ofmb9M
 7JA2//EQbor
X-Received: by 2002:a05:620a:4408:b0:915:f664:2568 with SMTP id
 af79cd13be357-91c487460c6mr218466785a.50.1781567393694; 
 Mon, 15 Jun 2026 16:49:53 -0700 (PDT)
Received: from tropical-turnip.tail32462.ts.net ([216.132.43.94])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a00af50sm1387942285a.30.2026.06.15.16.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 16:49:53 -0700 (PDT)
From: Samuel Ainsworth <skainsworth@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Samuel Ainsworth <skainsworth@gmail.com>
Subject: [PATCH v1 0/2] drm/ttm: fix bulk_move cursor use-after-free for
 unevictable resources
Date: Mon, 15 Jun 2026 19:49:20 -0400
Message-ID: <20260615234922.151263-1-skainsworth@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:18:52 +0000
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

A resource added to a bo's bulk_move LRU cursor can become unevictable
(pinned or swapped) after it has been added. ttm_resource_del_bulk_move()
then skips removing it -- both on free and on ttm_bo_set_bulk_move() during
bo teardown -- because the resource is unevictable, leaving the cursor's
pos->first/pos->last pointing at it. Once freed, the next allocation on that
bulk_move dereferences the dangling cursor (use-after-free) and corrupts the
LRU list, which CONFIG_DEBUG_LIST turns into a fatal BUG.

In the field this is a hibernation-triggered panic on a Framework 13 (AMD
Ryzen 7040): a buffer swapped out during hibernate is closed after resume
(amdgpu_gem_object_close -> amdgpu_vm_bo_del -> ttm_bo_set_bulk_move()),
which leaves its unevictable resource on the VM's bulk_move cursor; a later
GEM allocation on that cursor then faults (drm/amd issue #5387).

Patch 1 tracks cursor membership explicitly so the del always undoes the
add, regardless of any pin/swap transition. Patch 2 adds kunit regression
coverage.

Validating the bug (no GPU required, patch 2):

 - ttm_bo_bulk_move_swapped_free_dangles allocates a resource on a
   bulk_move cursor, swaps out its bo's ttm so the resource becomes
   unevictable, frees it, and asserts the cursor no longer references the
   freed resource. Without the fix this fails: pos->first/pos->last still
   equal the freed pointer.

 - ttm_bo_bulk_move_dangling_corrupts then allocates on the same
   bulk_move; without the fix, KASAN reports a slab-use-after-free in
   ttm_resource_add_bulk_move().

On the affected machine, a throwaway debug kernel that WARN_ONCE()s when
ttm_resource_del_bulk_move() skips an unevictable resource still on the
cursor was used to test. It fired during a normal hibernate/resume cycle, via
amdgpu_gem_object_close() -> amdgpu_vm_bo_del() -> ttm_bo_set_bulk_move().
That confirmed the production trigger and that the planted state matches
the field crash (the ttm_resource.c WARN_ON, then list_del corruption).

With the patch 1 fix, both kunit tests pass and the full TTM kunit suite is
green (no KASAN report, no CONFIG_DEBUG_LIST splat). Furthermore, I set up a
kernel with the fix, built with KASAN + CONFIG_DEBUG_LIST + lockdep, and ran 10
hibernate/resume/GEM-close cycles under GPU load with no use-after-free nor LRU
list corruption.

I am new to this area, so review of the approach is very welcome -- in
particular whether tracking membership on the resource is preferrable vs
removing it from the cursor at the point it becomes unevictable.

Samuel Ainsworth (2):
  drm/ttm: don't leave bulk_move cursor dangling for unevictable
    resources
  drm/ttm/tests: add bulk_move cursor regression tests

 drivers/gpu/drm/ttm/tests/ttm_bo_test.c | 163 ++++++++++++++++++++++++
 drivers/gpu/drm/ttm/ttm_resource.c      |  18 ++-
 include/drm/ttm/ttm_resource.h          |   9 ++
 3 files changed, 187 insertions(+), 3 deletions(-)


base-commit: 2c7d5b0a5ec0fc713a7f350806553643e87e6f43
--
2.54.0
