Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DB8C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E4110F35C;
	Fri, 14 Aug 2026 07:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CBi9L9L2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB2B10F35C;
 Fri, 14 Aug 2026 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786692784; x=1818228784;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VmUYvAUnfYsHHdCGmeLU6f5wM+YKFWNQX4XTxr73kAc=;
 b=CBi9L9L27OqvjsyfoXitUe9ZHqTyWZFI3hhhy8ASCRNcYc+OTzzEp7aO
 jBgyCUzad56b/KkUk6kEAoK3+J4DzfYMPY99JY02OgdBhH6DdF9ezwkCJ
 G6eQuDrfzbFREWMY0vPKRivZ0LEXVvR4TejuTG/nVCt2MTmenDEi6LWAw
 ipdDUqxI/STaWfEmSO/50GmbIYzT6phsB/4PBcwAmZQE0XSl7nCTTpvj9
 I9WxyYH0O7aTEHbP2ckxTvNIYh4kYNdOWRTwWSAR4a1ZeiypZysxuVPw5
 tj9lmkVUxbAy1GM2kzh7vqlUAo0qxJQMAaesNk5F9bzaCOFD8FgXSZy14 A==;
X-CSE-ConnectionGUID: ASTBPIEdSyOGCjd8fqSvvA==
X-CSE-MsgGUID: +csksN5/SHi6ERyyox9ZAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="112814912"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="112814912"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 00:33:03 -0700
X-CSE-ConnectionGUID: qLV2KFq/Sj21u73dqkMIvA==
X-CSE-MsgGUID: +C0wn2+GQ7WhQCN7IvSNqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="262838015"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 00:33:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/3] drm/gpuvm: two pass locking for exec
Date: Fri, 14 Aug 2026 00:32:55 -0700
Message-Id: <20260814073258.893007-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Two processes share a set of buffers, and each has buffers of its own
which the other never sees. Say process A has mapped

  S        the shared buffers, also mapped by B
  P        buffers private to A

and B has mapped S plus private buffers of its own. The overlap is
exactly S, and the work each process wants to do on its own buffers is
independent of the other.

A submits. Its exec locks the dma-resv of everything it has mapped, S
and P both, then finds something in P has been evicted and migrates it
back in. B submits, and blocks on S for as long as that migration takes,
even though the migration is of a buffer belonging to A which B has
never seen.

So the stall does not come from the overlapping set. The buffers in S
are resident, and neither exec has anything to do to them beyond
attaching a fence. They are held only because an exec locks everything
it has mapped in one go, and they stay held until the slowest unrelated
thing in that transaction is done.

Which buffers get evicted is a separate matter, and one which already
has answers: eviction heuristics which leave shared buffers alone, or
one process' allocations outranking another's. This is what is left once
those work.

Where this tends to show up is compositors and presentation, which is
also where userspace has worked hardest to avoid it. Wayland explicit
sync exists so that a compositor is not latched onto its clients'
rendering, waiting on fences it never asked for. The locking above
reintroduces that coupling anyway, in the kernel, and does it under
memory pressure, which is where a missed frame is least welcome and the
cause is hardest to see.

The fix is to stop coupling "lock the VM" to "validate it". Instead of
locking everything and then validating, lock the private buffers and the
evicted external ones, validate those, and only then lock the rest, all
within the same drm_exec transaction.

Patch 1 lets a driver split the locking of an exec that way, patches 2
and 3 use it in Xe and Panthor, whose panthor_vm_bo_validate() swaps
pages back in under those same shared locks. It is opt-in, and drivers
which do not ask for it are unaffected.

Matt

Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Steven Price <steven.price@arm.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: GitHub_Copilot:claude-opus-5

Matthew Brost (3):
  drm/gpuvm: allow locking external objects in two passes
  drm/xe: lock the resident BOs of an exec last
  drm/panthor: lock the resident BOs of a submit last

 Documentation/gpu/drm-mm.rst          |   6 +
 drivers/gpu/drm/drm_gpuvm.c           | 480 +++++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_mmu.c |  53 ++-
 drivers/gpu/drm/xe/xe_exec.c          |  23 +-
 drivers/gpu/drm/xe/xe_vm.c            |  43 ++-
 drivers/gpu/drm/xe/xe_vm.h            |   3 +-
 include/drm/drm_gpuvm.h               | 133 ++++++-
 7 files changed, 709 insertions(+), 32 deletions(-)

-- 
2.34.1

