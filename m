Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D282AC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC44A10E866;
	Mon,  6 Jul 2026 10:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="DmBwcT1K";
	dkim-atps=neutral
X-Greylist: delayed 45433 seconds by postgrey-1.36 at gabe;
 Mon, 06 Jul 2026 10:08:44 UTC
Received: from smtpout3.mo534.mail-out.ovh.net
 (smtpout3.mo534.mail-out.ovh.net [51.210.94.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD51D10E34F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:08:44 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gv0S94377z6JNY;
 Mon,  6 Jul 2026 10:08:41 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Mon,  6 Jul 2026 10:08:41 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.113.54])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gv0S91f73z5vMF; Mon,  6 Jul 2026 10:08:41 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 68F1B8E18F1; 
 Mon,  6 Jul 2026 10:08:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005839ebacf-71a8-4403-bd92-15e344545245,
 F224CF1D020274B13B21E639C91833BCDAC0997A) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
Subject: [PATCH v2 00/10] Use drm_exec to lock TTM buffers, respin
Date: Mon, 06 Jul 2026 12:07:42 +0200
Message-Id: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBQFf4XctTV9ICIr/8OQhrYXqEnBtJXUE
 P5dimuXk8yZs0JAbzFAU6zgcbHBztMO/FSAHrtpQGLNzsApr+iVChKjk1wa7yQm1IQbZRTr1c2
 UAvbRy2Nv0xF8tD8Ob/VEHXMlG6MNcfaf43Fh2fsbXxihpBRVfek043Wl7oNLZ4PQbtv2BQFwZ
 NG7AAAA
X-Change-ID: 20260703-ttm_2_drm_exec-2dbdb1fb9d43
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.15.2
x-ovh-tracer-id: 9126826122039877948
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFgEUEwEqBo3ZrzVucSTtO/cFkWvVsp3c3LMjrE7Lw1DeNsogoT1lbm30aCROrLeEEj8aVLa9IYqYnCp6i97vxuKze+6oHkIOAtFkImsarfenTHfLFMfIwh9XihJGWYxPe8CNTQTJIcfG+7nbbtlvQBBzK5XJlefECP8Z2oujAU7t3Wnm+UYWnTou5EdXX5eKxxPEX4sWN5iZfmo0z78nSNcf+dOtFZ4CuIghqxnLCu060kV7HrpV7TiD0dnchOO0CEOl3qmNQ19dAxtJ2sT6iAx0/9LWnzIpmxMx1/mrEqXxocLxkArzzMrSmLWpuk8777wwv1IhEzcdmvsVNUlyHbJ2vWreEw5ghkmnAZb3iPDq5BWX/Xfc2/6WV/ko1dcG0xEHhPOVXHeW5lXOY8qX+25C1mroB+HlRWNw4FNckbnyYZHbXzh5WTvKpG69xicFOVxlpldlGrXGzvgTI4aWVM9bSDZ8tOKkcLIuWzvsw0J1Nb+THerDTlZdkgJydSuu5WTez6kfo0JQpPkMcYnN4J4EKHc0JoUaDyEnlPdFO7FHK/O0OFkn9lW+ShT/Z6UfS5A6/DbV1upyvUAeR8xfM0y+4eAGRKY8OB/k3Pmp8MVrfK4HqgO/PpXjTaCa4VxDjlMEwe7NS6cKPIBOAN3+tuf6bnoUmb0oVygtqq09x6IQ
DKIM-Signature: a=rsa-sha256; bh=b0aRyvHjrmTrYhQ1eeIvNkwvtpG+ep/zFFPoF8zkvLw=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1783332522; v=1;
 b=DmBwcT1KDCPjcJPXWrRTdv2DzBdrghtuPD8RcPRz0WQGtLxYb2DlQX6ugJYSLMERkdRDnE3z
 xsk1FUHxsFgGMdabvWLNJQsMI+/txAZPMzm+rbg7lwU7dUVyI+ciGT6I9Ui6r40HiqOJNC1N+6D
 k2WRWu3rU4WtfbNFO6SQpBKxN+HbF43+xIZ1RXe9AvViUB461Q/Y3azY0inrt6JqAk6wylfOOMp
 WwQbrDkvzSgqIn2SXN+QRPGM3letBD/QX4KWB7scK1yBB/L/2rSbL3DEwcNlnkro1GaxtkAl9uB
 sEqtbesB5aem1v8LdGwgzEaK1q1OOZl+CG54IsYXE5G6g==
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

Hi all,

this is a respin of Christian's patchset to make TTM use drm_exec for
evicting buffers.

I've been investigating VRAM management for amdgpu quite a bit in recent
times, and under really strong VRAM contention I observed frequent
instabilities/random crashes that I traced back to TTM being unable to
evict buffers properly. The typical failure case was one game squatting
more or less all of VRAM while also being rather spammy with submits.
In that case, trylocking fails because concurrent submits from the game
already hold buffer locks, and since there isn't much else to evict,
allocation just fails.

The original patchset ended up fizzling out in previous attempts to
upstream it, but I think it's worth retrying to upstream this, so I took
over and rebased it on top of current drm-misc-next. Aside from
that, while testing the patchset I found two bugs causing rather random
issues ranging from kernel crashes to random GPU hangs in it, which I fixed
for this respin. The two bugs were:
1. The ttm_buffer_object duplication in ttm_buffer_object_transfer did
   not alter the GEM object's driver function pointers, so the
   transferred object erroneously inherited the free() function of the
   source buffer. When the transferred object was freed, the driver's
   free function was invoked and treated the transferred TTM bo as if it
   was a driver BO. Hilarity ensued.
2. drm_exec LRU walks were missing handling for already-locked objects.
   If the incoming exec object was created without
   DRM_EXEC_IGNORE_DUPLICATES, drm_exec_lock_obj would return -EALREADY
   and the buffer would be skipped even if ctx->allow_res_evict was set
   (funkiness level: moderate).
   If the exec did have DRM_EXEC_IGNORE_DUPLICATES
   set, the buffer would be processed, and then unlocked, silently
   dropping the lock of some random object that the caller expected to
   stay locked (funkiness level: off the charts).

With those two bugs fixed, VRAM overcommit works considerably more
stable - there are no random eviction failures and related fallouts at
all anymore.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
Changes in v2:
- Switched to my new email
- Reworked drm_exec patch for always reporting duplicates (Christian)
- Removed spurious continue; rebase artifact in swapout
- Removed incorrect trylock_only for evict_all
- Link to v1: https://patch.msgid.link/20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de

---
Natalie Vock (10):
      drm/exec: Add helper to bypass IGNORE_DUPLICATES flag
      drm/ttm: replace TTMs refcount with the DRM refcount v4
      drm/ttm: remove ttm_lru_walk_ops
      drm/ttm: grab BO reference before locking it
      drm/ttm: switch to ttm_bo_lru_for_each_reserved_guarded for swapout
      drm/ttm: move zombie handling into ttm_bo_evict
      drm/ttm: use ttm_bo_lru_for_each_reserved_guarded in evict_all
      drm/xe: remove workaround for TTM internals
      drm/ttm: support using drm_exec during eviction v4
      drm/amdgpu: use drm_exec during BO validation

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  80 +++----
 drivers/gpu/drm/drm_exec.c                       |  54 +++--
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c          |  35 ++-
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c |   8 +-
 drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c    |   2 -
 drivers/gpu/drm/ttm/ttm_bo.c                     | 272 +++++++----------------
 drivers/gpu/drm/ttm/ttm_bo_internal.h            |  17 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                |  58 +++--
 drivers/gpu/drm/ttm/ttm_device.c                 |  18 +-
 drivers/gpu/drm/ttm/ttm_resource.c               |  21 +-
 drivers/gpu/drm/xe/xe_bo.c                       |  32 +--
 include/drm/drm_exec.h                           |   2 +
 include/drm/ttm/ttm_bo.h                         |  50 ++---
 13 files changed, 295 insertions(+), 354 deletions(-)
---
base-commit: 44d19b8a7548aa25cbc6ebd5f27e958f7142c36b
change-id: 20260703-ttm_2_drm_exec-2dbdb1fb9d43

Best regards,
--  
Natalie Vock <nat@pixelcluster.dev>

