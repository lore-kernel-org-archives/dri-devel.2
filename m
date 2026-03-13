Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516AD105F7AA
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F0110E029;
	Fri, 13 Mar 2026 13:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fx1+d798";
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5620C10EBEC
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:21:52 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-463a0e14abfso1411073b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408111; x=1774012911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XRLQWxJhHqHVS7K6EL8usUEWl/HQzB1pLAe2/Ofal2A=;
 b=Fx1+d798pTfVvMuI7nH01opST3TTEWgjDew1qjVFbjmPfe4jn9B6/evreb1rZL7HIs
 zzv+sxXd4yAJuBD5yU6aj+PpblbZ3Q7xq/KW8uqLY1keQQ5Y8EJ1YE7enkEJxTK2vSkm
 nS5VyTI1Zr3Sz/DJwhpBpfz6v4KvbNAx2jgQHPsxoRhRZchT76XkvgcZwDAio5Sn8dQ+
 ExGSOL+BCAl5GHXWWQmFkLOTZ4L3raI3UPcfQ/L81sexfZI/J85U58nU+gtJMklbwC4n
 BCA48cTVnLwSwZATW5uPJH1EzQOwgpiIuGO44BN3HP8gGOSplWEyjpY0hsKNOmXxxGjV
 Lytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408111; x=1774012911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRLQWxJhHqHVS7K6EL8usUEWl/HQzB1pLAe2/Ofal2A=;
 b=lWBnTeZ7oJdngc/cDzNflI1lprEAHB0ax7cs22Kb81qi398hV6Ysuj3cOhHerMXVyr
 qn8NfzBMAVPRfWoHIsUJBn+39Qv9CXbXVhnJbpX/RUG+YYa0DccVvMUbUOv7uQdZeI9p
 B1gNEbFq+HodjI/GD5X2Qw4xNcJjaJ5FofC5sBpk2F70vkAe+xzM2GYRyHSquW/iNqs/
 z/9Qp7emJ4tJ1zMW0EZDYogxykL2q+vTfUjOgSf+FaO/Znb5AcFj6sUXgaYUvuwrCVB2
 rRj8kcQobTuwESKmwvD3tDBGz2iKPFwobwGRARlX8eyZKbTa96D1GVApml82btuOwJms
 db9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7JxGEivB/wJ3y8oc7cbqFuiF5YvEabP4+m+ORTH0Hp9n1ez75/ZcxnmfLlk6DVDBVjq0C7ngXkfc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxG5ASGNczoFafe6AaHEx1BMY1rsrqBlZdImazNtZRtPMxwSKnm
 ukiGzIYfLewtKeOcbrN07GzTCyFbtvxqsa9V0Z+q9fNErXnomYLcer58
X-Gm-Gg: ATEYQzx3LQD/3bRY4bcIel8jfkm0mdA/wvh0VA4PqDbot6EsOVenB3fISyuYdAPovMu
 zX/5XD4E0Gtn2th2cE/7/b99AU0zwS2Vl2Uy17TguLspOAixX57GrsMq49Yxh9dzULglX16wnLS
 yNsjLadjDcmLeSTUGoq5D98KOVg4VP5inPi+fpNqrRhHzLzy84M/gM3Kj1Wy7Y8Eqa6SZp4n6+f
 hlJy9e5Y29lsu1oTqyCHQswQ+g/FU3PKPUZnrvnqdm00ZQR5W2wNw7DoQkP6uQfEWt8R49soZET
 zCLvZUNg4cJQTh4fHMLC833pDtzhmsiC5Bifz/NAnRM8xParDqgy28qDuILV373hS0QL8vIWRU6
 ZZWALJmpC36dUjJJgDc7A1cQX/Skj6XqQfFnj/G+s+M+KRG0kKpvp35BHzvMQOpP+xaEgvfgz4i
 SYPhMIx1QcBOMZQZv7kY7gUK8Gpn2QDUTnPpg9564UrQ2+rAL+s/a49Sk4aAU=
X-Received: by 2002:a05:6808:22ab:b0:467:272e:87d with SMTP id
 5614622812f47-467570ecc9dmr1594229b6e.14.1773408111280; 
 Fri, 13 Mar 2026 06:21:51 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:21:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 00/65] Fix DRM_USE_DYNAMIC_DEBUG=y
Date: Fri, 13 Mar 2026 07:19:25 -0600
Message-ID: <20260313132103.2529746-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
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

resend - apologies, faf'g with --cc-cover & to: lists

The drm subsystem has *lots* of debug statements, in 11 categories

 $> ack '\w*_dbg' drivers/gpu/drm/ | wc
    5532   29318  553806
 $> ack 'DRM_DEBUG\w*' drivers/gpu/drm/ | wc
    2208   12856  212035

All of these are bit-tests on __drm_debug, exposed to users as
/sys/module/drm/parameters/debug.  Many of these are done often,
vblank is done ~100/sec for some displays.  Over the uptime of many
boxes, this is a lot of cpu cycles, on bits that are almost always
off.

Dynamic-debug excels at replacing such tests with NOOPS.  Classmaps
was devised to bring that 0-off-cost to drm's categories.

Classmaps-v1 went into the kernel in Sept 2022, in 2 chunks:
  b7b4eebdba7b..6ea3bf466ac6    # core dyndbg changes
  0406faf25fb1..ee7d633f2dfb    # drm adoption

Sadly DRM-CI found a regression during init with drm.debug=<initval>;
the static-keys underneath the drm-dbgs in drm.ko got enabled, but
those in drivers & helpers did not.

Root Problem:

DECLARE_DYNDBG_CLASSMAP defined the classmap, but it repeated use in
both core and drivers violated a K&R rule "define once, refer
afterwards".  This flaw resulted in a regression; with drm.debug=0xFF
boot arg, drm-core got enabled, but drivers,etc did not.

So in feb 2023, this resulted in:
commit bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")

This patchset replaces it with DYNDBG_CLASSMAP_DEFINE (invoked once in
drm-core) and DYNDBG_CLASSMAP_USE (invoked repeatedly, in drivers &
helpers).

_DEFINE exports the classmap it creates (in drm.ko), other modules
_USE the classmap.  The _USE adds a record ref'g the _DEFINEd (&
exported) classmap, in a 2nd __dyndbg_class_users section.

So now at modprobe, dyndbg scans the new section after the 1st
__dyndbg_class_maps section, follows the linkage to the _DEFINEr
module, finds the (optional) kernel-param controlling the classmap,
examines its drm.debug=<initval>, and applies it to the module being
initialized.

Savings effect:

No real effort was made to quantify the savings; bit-tests are almost
unmeasurable individually, and [1] DRM_USE_DYNAMIC_DEBUG=y purposely
depends upon JUMP_LABEL to avoid its use where it cannot help.

That said, Ive booted one box with drm.debug=0x1ff on the boot-line,
with a script run by systemd to turn it off once boot completes. It
issued ~25k messages in that time.

Status-v11:

Now rebased on drm-misc-next, to allow grinding on DRM-CI.
https://gitlab.freedesktop.org/jim.cromie/kernel-drm-next-dd/-/pipelines/1622778

DRM-CI revealed 2 bugs, fixes now included:
1. drm_buddy had 32bit truncation error, causing unexpected pass
2. drm_printer_debug_fn disregarded drm.debug, spewing msgs, causing timeout.

Also tuned vblank* to avoid drm_debug_enabled() bit-test.
Probably should defer this until [1]=y is default. It isnt yet.

Up to this point, classmaps-v2 has been stuck, straddled on the fence
between drm and dynamic-debug; it needs a little help towards one side
or the other.  ISTM that drm is the actual user, and the acid-test of
its proper function; the dyndbg selftest recaps the 2-module scenario,
but this cannot finally prove anything absent drm.

Verification: DRM-CI Pipeline #1622778
  - KUnit (arm32, arm64, x86_64): All 621 tests PASSED.
    Specifically confirms the 64-bit truncation fixes in drm_buddy.
  - i915-CML: 370 tests PASSED, 0 FAIL.
    Confirms the quelling of the UART storm in shared print callbacks.
  - Overall: No regressions found in dyndbg or buddy allocator logic.

Future:

Lukas Bartosik has been patiently waiting for classmaps to land, so he
can add dyndbg-to-ftrace functionality.  This new feature will allow
steering any/all drm.debug messages to a private ftrace buffer, and
also to mix in other pr_debug messages.  Other ftrace streams could
also be sent there (possibly w/o code changes, tbd).  It could be a
big step towards a featureful crash-buffer.

Ive also cobbled together a maple-tree based replacement for the
__dyndbg_descriptors linker section; it copies the section contents
into 3 maple trees, then drops the section in __init.  By eliminating
the redundant columns (module, file, function) it reduces the storage
needed by 40%.  Early measurements show no net runtime costs, maple
trees make good furniture.

Given that progress, I also hacked up a maple-tree based dynamic
prefix cache.  Currently the dynamic-prefix is re-written for every
prefixed callsite; this can get expensive.  By careful keying (flags
on top, descriptor address underneath), a single prefix string can
span an entire range (smallest of enabled module, file, function).

That last one doesn't help DRM, cuz it doesnt use dynamic-prefixes,
but with this optimization in place, it could be adapted to do so.

Lastly, I have an RFC jump-label patchset that dramatically cuts IPIs,
currently 1 per pr_debug (to ~1/140), by sorting the (existing) queue,
rather than flushing it when a non-increasing patch-addr is queued.

I'd like to move forward with all these, but I anticipate a "fix
classmaps 1st" response.

Jim Cromie (65):
  dyndbg: fix NULL ptr on i386 due to section alignment
  dyndbg: factor ddebug_match_desc out from ddebug_change
  dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
  docs/dyndbg: update examples \012 to \n
  docs/dyndbg: explain flags parse 1st
  test-dyndbg: fixup CLASSMAP usage error
  dyndbg: reword "class unknown," to "class:_UNKNOWN_"
  dyndbg: make ddebug_class_param union members same size
  dyndbg: drop NUM_TYPE_ARRAY
  dyndbg: tweak pr_fmt to avoid expansion conflicts
  dyndbg: reduce verbose/debug clutter
  dyndbg: refactor param_set_dyndbg_classes and below
  dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
  dyndbg: replace classmap list with a vector
  dyndbg: macrofy a 2-index for-loop pattern
  dyndbg,module: make proper substructs in _ddebug_info
  dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
  dyndbg: move mod_name down from struct ddebug_table to _ddebug_info
  dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
  selftests-dyndbg: add a dynamic_debug run_tests target
  dyndbg: change __dynamic_func_call_cls* macros into expressions
  dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
  dyndbg: detect class_id reservation conflicts
  dyndbg: check DYNAMIC_DEBUG_CLASSMAP_DEFINE args at compile-time
  dyndbg-test: change do_prints testpoint to accept a loopct
  dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM to API
  dyndbg: treat comma as a token separator
  dyndbg: split multi-query strings with %
  selftests-dyndbg: add test_mod_submod
  dyndbg: resolve "protection" of class'd pr_debug
  dyndbg: add DYNAMIC_DEBUG_CLASSMAP_USE_(dd_class_name, offset)
  dyndbg: Harden classmap and callsite validation
  docs/dyndbg: add classmap info to howto
  drm: use correct ccflags-y spelling
  drm-dyndbg: adapt drm core to use dyndbg classmaps-v2
  drm-dyndbg: adapt DRM to invoke DYNAMIC_DEBUG_CLASSMAP_PARAM
  drm-print: modernize an archaic comment
  drm-print: fix config-dependent unused variable
  drm-dyndbg: DRM_CLASSMAP_USE in amdgpu driver
  drm-dyndbg: DRM_CLASSMAP_USE in i915 driver
  drm-dyndbg: DRM_CLASSMAP_USE in drm_crtc_helper
  drm-dyndbg: DRM_CLASSMAP_USE in drm_dp_helper
  drm-dyndbg: DRM_CLASSMAP_USE in nouveau
  drm-dyndbg: add DRM_CLASSMAP_USE to Xe driver
  drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
  drm-dyndbg: add DRM_CLASSMAP_USE to simpledrm
  drm-dyndbg: add DRM_CLASSMAP_USE to bochs
  drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
  drm-dyndbg: add DRM_CLASSMAP_USE to gma500 driver
  drm-dyndbg: add DRM_CLASSMAP_USE to radeon
  drm-dyndbg: add DRM_CLASSMAP_USE to vmwgfx driver
  drm-dyndbg: add DRM_CLASSMAP_USE to vkms driver
  drm-dyndbg: add DRM_CLASSMAP_USE to udl driver
  drm-dyndbg: add DRM_CLASSMAP_USE to mgag200 driver
  drm-dyndbg: add DRM_CLASSMAP_USE to the gud driver
  drm-dyndbg: add DRM_CLASSMAP_USE to the qxl driver
  drm-dyndbg: add DRM_CLASSMAP_USE to the drm_gem_shmem_helper driver
  accel: add -DDYNAMIC_DEBUG_MODULE to subdir-ccflags
  accel/ivpu: implement IVPU_DBG_* as a dyndbg classmap
  drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
  accel/ethosu: enable drm.debug control
  accel/rocket: enable drm.debug control
  drm_buddy: fix 64-bit truncation in power-of-2 rounding
  drm_print: fix drm_printer dynamic debug bypass
  drm_vblank: use dyndbg's static-key to avoid flag-check

 .../admin-guide/dynamic-debug-howto.rst       | 184 +++-
 MAINTAINERS                                   |   3 +-
 drivers/accel/Makefile                        |   7 +-
 drivers/accel/ethosu/ethosu_drv.c             |   3 +
 drivers/accel/ivpu/ivpu_drv.c                 |  27 +-
 drivers/accel/ivpu/ivpu_drv.h                 |  45 +-
 drivers/accel/rocket/rocket_gem.c             |   2 +
 drivers/gpu/buddy.c                           |   4 +-
 drivers/gpu/drm/Kconfig.debug                 |   1 -
 drivers/gpu/drm/Makefile                      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +-
 drivers/gpu/drm/display/drm_dp_helper.c       |  12 +-
 drivers/gpu/drm/drm_crtc_helper.c             |  12 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |   1 +
 drivers/gpu/drm/drm_print.c                   |  38 +-
 drivers/gpu/drm/drm_vblank.c                  |  10 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         |   2 +
 drivers/gpu/drm/gma500/psb_drv.c              |   2 +
 drivers/gpu/drm/gud/gud_drv.c                 |   2 +
 drivers/gpu/drm/i915/i915_params.c            |  12 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c         |   2 +
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  12 +-
 drivers/gpu/drm/qxl/qxl_drv.c                 |   2 +
 drivers/gpu/drm/radeon/radeon_drv.c           |   2 +
 drivers/gpu/drm/sysfb/simpledrm.c             |   2 +
 drivers/gpu/drm/tiny/bochs.c                  |   2 +
 drivers/gpu/drm/udl/udl_main.c                |   2 +
 drivers/gpu/drm/virtio/virtgpu_drv.c          |   2 +
 drivers/gpu/drm/vkms/vkms_drv.c               |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   2 +
 drivers/gpu/drm/xe/xe_drm_client.c            |   2 +
 include/asm-generic/vmlinux.lds.h             |  19 +-
 include/drm/drm_print.h                       |  22 +-
 include/linux/dynamic_debug.h                 | 304 +++++--
 kernel/module/main.c                          |  15 +-
 lib/Kconfig.debug                             |  24 +-
 lib/Makefile                                  |   5 +
 lib/dynamic_debug.c                           | 814 ++++++++++++------
 lib/test_dynamic_debug.c                      | 198 +++--
 lib/test_dynamic_debug_submod.c               |  21 +
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   7 +
 .../dynamic_debug/dyndbg_selftest.sh          | 373 ++++++++
 44 files changed, 1665 insertions(+), 561 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

-- 
2.53.0

