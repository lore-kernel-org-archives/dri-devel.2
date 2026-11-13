Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA62606A882
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYWg4KqP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D72112346;
	Fri, 13 Nov 2026 09:03:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B0E81121F5
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:02:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F20684662E;
 Fri, 13 Nov 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794560576;
 b=mbgNbX/ZVYcNP0cWE5HgILwTUlsYqL/rML4gg1oiumm7gTmH38lS+vKY1+LQLFVi8iTc
 a/kbb7RFvxHb4/RdOSsIo2yqVq7S10ef2OVKAhOiFxWvhrHWqhMDvdGQZITPxA6rRYwwI
 TfqxIF1DytmhrlStlpxwt6YE0FxOiTBYkXuaD+Z5OQVjPbk8fHo+3cclcMDhqu8JzkJi6
 lOldwmT1scqpfsmMQOWLk9Qii+8U3VBUtOoiTHthlcZ5d6kB1JW2dmULuxi/HRYhISp7O
 YwRkQb86GTe/I2nP8riUjGy0T8CkIaermDMdhaYMg9ZeZBBG6nunFDm8DASJUvhfGqg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794560576;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=Eg63+mUsctrwjSm9UGHp8D1k2Q6PkIlElEvNxf3oLtA=;
 b=Wls0vNnu59/f/0yBVeHZdsDLuZQHFWhk/0sQP5P4afFWJYvAMxy6eCXI7dYhV7oAwycz
 5nFU/ubPaAxvJEBB3ecIihlRj08k6YJWsxrGdssl1ErhJnT+Ku5IRLlB/YfBxvXUr6wcE
 4306MNoLTbu8RHtX3nMM1C8dO8d/FOG0M9611DI8fXsiHBRASLKdxjNuGVmPsYEE7ddyb
 sVFxqZr3JaJyoHYm2ECkPcC0o7IvLRYL/azj5VsTNyBr/JNjNBMQ7sJk85o1KZBw7bcum
 pbXejU2054jdr2ssA06ytHZXV6M9fwKDR4T6p92TX0Rbil8xREOhb8U+VFS82DMLn5A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 66C6E1F000C4;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560576;
 bh=Eg63+mUsctrwjSm9UGHp8D1k2Q6PkIlElEvNxf3oLtA=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=jYWg4KqPz+AhLzlz5+IJOaDniCPcjg6LlYxGSeIK1BGqXNMSDxaBWFnjoa+6vZokP
 T46Lp1rrFLfOCMe//VPFNNPqbwLZrl94xt4I7jZiqS82L2cu3sdq5QoWzi+/2hnGIN
 9u+rgTdqhYrYIp1qzcqWb2GoxSnkCMrgoviZGQFMg5e43Oi9v9sG8Zmpm81xfRcvDi
 kvmEF+F6dhKF9SAUqYHoG4LKELhQpc3ZiIJfh3OhcX/VxcCN43mb2AR7r1ytXe4vpH
 FSpJnDsKHJKF1FrZIKAGQOc+jrlMTlYEzQbVhd1eeDKoGVYbYGsFFj3ufmPRcRe3O7
 kiCgaq4rUquQg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BB83E476C9;
 Fri, 13 Nov 2026 09:02:53 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v3 00/14] drm/panfrost: Resume long jobs instead of
 resetting, and mapping error path fixes
Date: Fri, 13 Nov 2026 09:02:52 +0000
Message-Id: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ6CMBgFr0K6tqY/iMWV9zAuPtoCJdiSFhsN4
 e62uGFhXE7y3syCgvZGB3QpFuR1NME4m4AfCiR7sJ3GRiVGjLCKUkrwBLb1Lsx4dLbDg2sCplX
 JmTgDA0lROk5et+a1SW/3L4dnM2g5Z1Ne9CbMzr+3aqR59zcQKSaYlScial6DFuraPcCMR+keK
 Aci2yvYTwVLCiCV4EQBV3W9V6zr+gE5qElMCQEAAA==
X-Change-ID: 20261110-panfrost-long-jobs-1643287a2ac1
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794560572; l=9448;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=IxtBMMvFFuN/KQnCGzJuFHwoPLZqK+o5uI8iM8M4qlY=;
 b=AgGRGJ87CguVE0DmjQPe+Y1aq48lZg9L2sHejwJ+uQ8lHyyAbWmqu/VBmRGzmbxnLIAN7RQKf
 KGQITZRfa98BXJoH3e/RnCxlS3Z/pin/nCiRwfbqSorncVJQOoA2Ecx
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fixes for problems found running the GLES, Vulkan and OpenCL conformance
tests with Mesa on an Orange Pi Zero2 (Allwinner H616, Mali-G31 MP2, one
shader core, 1 GB of RAM), and for problems the Sashiko reviews of v1
and v2 found in the code around them.

Patches 1-3: the reset work touches a runtime or system suspended GPU, a
CPU cache sync of a heap BO walks its sparse page array, and the GPU
fault handler revives a mapping that is being freed.

Patches 4-7, BO mapping error paths under memory pressure: a WARN on an
ordinary allocation failure, pages dropped while the cached sg table
still maps them, PTEs left behind by a partial map_pages(), folios of a
heap chunk kept after a failed fault, and a false WARN for folios larger
than the 2 MB chunk (16K and 64K pages).

Patches 8-11, races around panfrost_reset(): a job cancelled from _NEXT
is taken for done, a job that completes during the reset is reported as
cancelled, a job queued while a reset is pending drops a cycle counter
reference it never took, and such a job is taken for done without having
run. Patch 13 widens these windows.

Patches 12 and 13: a job that runs into the 500 ms timeout no longer
gets the GPU reset. On a small GPU OpenCL kernels and heavy fragment
jobs legitimately run longer: OpenCL CTS Integer Ops long math and
Thread Dimensions, KHR-GLES31 advanced blend mixedSequence and several
dEQP-VK spirv_assembly fragment cases fail that way. As in the Arm
driver, a job whose slot is still active is soft-stopped and resumed
from JS_TAIL, hard-stopped if it has not reached a task boundary after
5 s, and the GPU is reset only if the hard stop fails too. Patch 12
makes panfrost_reset() wait on the live slot status (JOB_INT_JS_STATE is
a snapshot); patch 13 needs it, and it fixes the reset path on its own.

Patch 14 reports the BOs around an unhandled page fault, which told a
texture over-read apart from a kernel problem.

Open points:
- A job that keeps reaching task boundaries is resumed after every
  timeout and never killed. I can add a limit on its total run time.
- While a long job is being stopped (5.5 s at worst), patch 13 keeps the
  job interrupts masked and all schedulers stopped, as panfrost_reset()
  does today around a reset. The other slot starts no job in that time,
  and a job that finishes on it is signalled only afterwards. Over two
  runs of the tests below this took at most 85 ms for a compute job
  (median 0.3 ms, 206 timeouts) and 349 ms for a fragment job (6
  timeouts). Mainline resets the GPU at that point, under the jobs on
  both slots. Stopping only the slot that timed out needs reset.pending,
  the interrupt mask and the scheduler stop made per slot; I can do that
  as a follow-up.
- I can split the independent fixes (1-11, 14) from the soft-stop rework
  (12, 13).

Tested on the Orange Pi Zero2 with Mesa 26.2 and this series backported
to v7.3.3:
- OpenCL CTS Integer Ops quick_long_math/quick_ulong_math, Thread
  Dimensions quick_2d_explicit_local and KHR-GLES31
  blend_equation_advanced test_coherency.mixedSequence pass (failed
  before); dEQP-VK spirv_assembly vec4 i8/u64 bit_field_insert count64
  fragment cases pass in 4-6 s (timed out before). 107 job timeouts, all
  soft-stopped and resumed, no GPU reset.
- A never-ending OpenCL kernel is hard-stopped after 5 s; with the hard
  stop withheld (*), the GPU is reset instead. Both times a devcoredump
  is taken and the GPU keeps working.
- The reset work queued (*) while the GPU is runtime suspended resumes
  it before the reset (patch 1). Queued five times while Integer Ops and
  Thread Dimensions run side by side: both pass. Most of these resets
  found the GPU suspended between two jobs; the trace does not show
  whether a job was on a slot at any of them.
- s2idle entered while the reset work runs (*), and resets requested (*)
  during suspend, idle and under Integer Ops: suspend waits for the
  work, the pending reset runs after resume, Integer Ops passes
  (patch 1).
- With a 200 ms delay before the stop (*) and the cycle counter forced
  on (*): 10 jobs queued while a reset was pending were drained without
  a cycle counter reference (patch 10), one on a slot that had gone idle
  was kept (patch 11), the use count ends at 0, and the tests pass.
- dEQP-GLES31 draw_indirect compute_interop large cases in memory
  cgroups of 450-600 MB: allocation errors or OOM kills, no WARN, and
  the GPU keeps working.
- A forced page fault prints the BO report.
- PANFROST_SYNC_BO fails with -EINVAL on a heap BO and succeeds on a
  plain one.
- No regressions in dEQP-GLES3 draw/occlusion_query/shaders.loops (964
  cases), dEQP-GLES31 compute (195), KHR-GLES31 compute_shader (37, two
  not supported) and 9 OpenCL CTS groups.
(*) test-only module parameter, not part of this series.

The problems patches 1-3 and 8-11 fix were not reproduced. The fixed
paths of patches 1, 2, 10 and 11 ran in the tests above; patches 3, 8
and 9, the larger-folio cases of patches 6 and 7 (4K pages here) and the
races patch 13 handles rest on code review. Each patch builds without
warnings with W=1 for arm64 and arm.

These patches were developed with Claude (Anthropic) as a coding
assistant: it investigated the problems and wrote the code and the
commit messages. I reviewed them, and they were tested as described
above.

---
Changes in v3:
- Patch 1: disable the reset work across system sleep, as
  pm_runtime_force_suspend() ignores the usage count, and queue it again
  on resume if a reset is pending (Sashiko,
  https://lore.kernel.org/all/sashiko-outbox-210830@kernel.org/).
- New patch 7 (Sashiko,
  https://lore.kernel.org/all/sashiko-outbox-210837@kernel.org/).
- New patches 10 and 11 (Sashiko on v2 10/11,
  https://lore.kernel.org/all/sashiko-outbox-210891@kernel.org/).
- Patch 13 (v2 10/11): rebased onto 10.
- All patches: shorter commit messages and comments; no other code
  change.
- Renumbered: v2 7 and 8 are now 8 and 9, v2 9-11 are now 12-14.
- Rebased onto the current drm-misc-next.
- Link to v2: https://patch.msgid.link/20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com

Changes in v2:
- New patches 1-3, 7 and 8, for problems the Sashiko review of v1 found
  in the code around the series (3: by analogy with a finding):
  https://lore.kernel.org/all/sashiko-outbox-206548@kernel.org/
  https://lore.kernel.org/all/sashiko-outbox-206561@kernel.org/
  https://lore.kernel.org/all/sashiko-outbox-206570@kernel.org/
  https://lore.kernel.org/all/sashiko-outbox-206581@kernel.org/
- Patch 6 (v1 3/7): clear the page array range the fault filled, whole
  folios, which can exceed the 2 MB chunk, and leave folios owned by a
  neighbouring chunk alone (Sashiko).
- Patch 10 (v1 6/7), after the Sashiko review: a job that does not stop
  within 5 s gets karma and a devcoredump; a reset asked for while the
  slots are being stopped is done, not dropped; jobs on other slots that
  only had the 10 ms of an ordinary reset are restarted, not failed; a
  job that completes just as its timeout fires no longer triggers a
  reset.
- Patch 11 (v1 7/7): skip mappings whose last reference is gone, and
  drop the "mapped" flag (Sashiko).
- Dropped v1 4/7 ("Don't resume a soft-stopped job after a GPU reset"):
  I have no evidence that a reset loses results of a soft-stopped job,
  and the Arm driver resumes soft-stopped atoms without such a check.
- Cover letter: which paths the tests did not run, what stopping a long
  job costs the other slot, and tests of the GPU reset path.
- Renumbered: v1 1-3 are now 4-6, v1 5-7 are now 9-11.
- Rebased onto the current drm-misc-next.
- Link to v1: https://lore.kernel.org/r/20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com

---
Arun Iyengar (14):
      drm/panfrost: Power the GPU up for a reset queued from the MMU code
      drm/panfrost: Refuse to sync the CPU caches of a heap BO
      drm/panfrost: Don't take a reference on a mapping that is being freed
      drm/panfrost: Don't WARN when a GEM mapping cannot get its pages
      drm/panfrost: Unwind a failed GPU mapping without dropping its pages
      drm/panfrost: Give back the pages of a heap chunk that failed to map
      drm/panfrost: Don't WARN for a heap folio a neighbouring chunk filled
      drm/panfrost: Don't signal a job cancelled from _NEXT at a reset as done
      drm/panfrost: Don't cancel a job that completed during a reset
      drm/panfrost: Drop the cycle counter only for a job that holds it
      drm/panfrost: Don't take a job that was never started for done
      drm/panfrost: Wait for the soft-stopped slots with the live slot status
      drm/panfrost: Soft-stop and resume a job that outlives the timeout
      drm/panfrost: Name the BOs around an unhandled page fault

 drivers/gpu/drm/panfrost/panfrost_device.c |  26 ++-
 drivers/gpu/drm/panfrost/panfrost_gem.c    |   4 +
 drivers/gpu/drm/panfrost/panfrost_job.c    | 272 +++++++++++++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_job.h    |   4 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 159 +++++++++++++++--
 5 files changed, 396 insertions(+), 69 deletions(-)
---
base-commit: c88084027d0e922dd925b96e5a0d184ba04a8f43
change-id: 20261110-panfrost-long-jobs-1643287a2ac1

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


