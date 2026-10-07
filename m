Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42FDCA6004
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D0910E693;
	Wed,  7 Oct 2026 21:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Umo1ahtO";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 773A410E693
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 21:21:11 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5e6b5794d26so56754e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791408070; x=1792012870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GdW5eGMVzOKudslmGlrnPjBYhkw/LoHtHbvGX04ha0M=;
 b=Umo1ahtO/4+0sQaRM9ZzqMPs2YYgxgo4rsKn0geXwzC3ldLc5izxjcs4b8L1xwEry1
 8nCsrVFXx5OiYZcTZWLj6ldPi02iBJvSigKwK0JIAzcmr5+RGcdr17tIgh6hOqEnOy3Q
 yiHGoZ8oz4ymb7qROtFCqFYUh6CF2yrxBdePSV9gjnpI/vERG2jYKTUKw4fxq+I/NN04
 GJKyhyBR+z/nq8nmyj9GBsMDKG08iPrUqJtTrfxJPg0rPfaFkjlRlgCQhWbytlfbku1h
 S2GSlanhXQJEUAFJa4DsJZObLqf77NPVgvy/dWIicy1zPZltzgF5r4Yj+KzL+mL+CvJq
 JSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791408070; x=1792012870;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GdW5eGMVzOKudslmGlrnPjBYhkw/LoHtHbvGX04ha0M=;
 b=n8NsfADLqr+g0Au8+1EKZw7G3tdfl32Hp6dferzLqSe8ul/S6U78VGfb0a3X9wFxyT
 QkcC5wLfqtHyKa4G8sQAMMuzf/DszdQaAAIe/XQO5rCowanU2wWg5LsoUHBj7qPfVBSj
 GmZt1NP2NuMrzQn5kHv4z2PCAZLleoxGEIhdnJTgNXBadzlrJm9NJt469CmZu7MCz+c/
 qzk2D31aZ/tpRfkORxMYrm7YhiUMeLQefXDd7w5QF7Gj4yNOIeTG5/OVrthhMZt5HGAd
 go66Xar3va5jI41UgFWFENvASs1mkPO0MTDAtTL3g2eGwnZJHz31Vb6k6E8RPQBMBOg1
 56mA==
X-Gm-Message-State: AFq9FYK74qiOdco/ot+7tdu4l0zwklOuKPSzSgdez0ZxAvhrwS1wZtYt
 CXsyx4x8X9ZUPZHZiLAPcXqv10BMgkdImU6TgVuvpx0JQuNZ0OCntspc
X-Gm-Gg: AYBFou1Hxw3u9cZ+ezOUuJs0+78t2k7q768H4V/WBX+JDY8bqxBS+w+ofR6h7kH3Bsp
 o2Ky+PaZQZHL9mXyf4a5RlDCaNMgLRAxl1mIFNQRODg6RpnsCdUHRg8t4TDQL7d1/O1pCf69tDk
 vK9+Vh//k+WXdzbJ/4iBd9v2pQ5qyaZDdopp1BbLr14F872eH5ZzJoQIPP+DI4Z+ZHxgpAX+e6l
 vA+Za2i5EJO3is/dfJM39Epu14wbG5J67mfDJTuwvwwCjcUNCd6jUpX+LB1RW5YPIGRyFXrxzM6
 nJQoJ7zFV+F4nStp9hY13ybFgBIs9MViHC4D/qtamgsatjujXOseJeo0QmOHSQi0uce/G53mB0e
 P/5zdEmb+WHReV3v6VXHaCKRxQVwNci3TmcudtclKr6aDrQGzh9m8bD1SWoJ8DKELwUn44JXlc3
 onCdjrMAmslK6MqwVNBREJ0UH6hUShqY4rPvTgyXyhMdfd2SQQMLEa9DqH2xLvIzY=
X-Received: by 2002:ac5:c85b:0:b0:5ce:fc2e:d0e9 with SMTP id
 71dfb90a1353d-5e82a729f64mr93368e0c.13.1791408070022; 
 Wed, 07 Oct 2026 14:21:10 -0700 (PDT)
Received: from beelink.. ([187.13.30.250]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e6c4d62704sm3115891e0c.10.2026.10.07.14.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:21:09 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, maaz.mombasawala@broadcom.com,
 stable@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 0/2] drm/vmwgfx: fix surface reference ioctl error handling
 and TOCTOU
Date: Wed,  7 Oct 2026 18:20:47 -0300
Message-ID: <20261007212051.2574235-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hi Zack,

Thank you for the detailed review. Here is v2 as a two-patch series
addressing all your feedback:

  1/2: return an error and drop the surface reference when backup is
       missing (unchanged from v2 RESEND, included for series base)
  2/2: close the TOCTOU on guest_memory_bo (v2, description and
       Fixes tag corrected per your review)

Changes in 2/2 since v1:
  - Description rewritten: the racing writer is a backup switch via
    SVGA_3D_CMD_BIND_GB_SURFACE (vmw_resource_unreserve), not eviction
  - Fixes tag corrected to a97e21923b42
  - Rebased on top of 1/2 (no longer duplicates ret = -EINVAL)
  - mutex scope kept to the minimum: NULL check, handle creation,
    buffer_map_handle and buffer_size reads


1. Validation test for patch 1/2
---------------------------------

A test program creates a shareable surface WITHOUT a backup buffer
(drm_surface_flags=shareable, buffer_handle=SVGA3D_INVALID_ID, no
drm_vmw_surface_flag_create_buffer), then calls the surface reference
ioctl via DRM_VMW_GB_SURFACE_REF_EXT.

  UNFIXED module:  ioctl() returns 0 (success) without filling the
                   reply structure — the kernel handler never sets ret.
  FIXED module:    ioctl() returns -1 with errno set to EINVAL. Kernel
                   dmesg shows:
                     [drm:vmw_gb_surface_reference_internal [vmwgfx]]
                     *ERROR* Shared GB surface is missing a backup buffer.

The test exercises the missing-backup error path, but does not
independently verify reference cleanup. The cleanup was verified by
source inspection — see section 2 below.

Test program (test_no_backup.c, requires <drm.h> and the kernel UAPI
vmwgfx_drm.h):

  #include <stdio.h>
  #include <string.h>
  #include <fcntl.h>
  #include <unistd.h>
  #include <sys/ioctl.h>
  #include <errno.h>
  #include <stdint.h>
  #include <drm.h>
  #include "vmwgfx_drm.h"

  #define VMW_IOCTL_GB_SURFACE_CREATE_EXT \
      DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_GB_SURFACE_CREATE_EXT, \
               union drm_vmw_gb_surface_create_ext_arg)
  #define VMW_IOCTL_GB_SURFACE_REF_EXT \
      DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_GB_SURFACE_REF_EXT, \
               union drm_vmw_gb_surface_reference_ext_arg)

  int main(void) {
      int fd = open("/dev/dri/renderD128", O_RDWR);
      if (fd < 0) { perror("open"); return 77; }

      union drm_vmw_gb_surface_create_ext_arg create;
      memset(&create, 0, sizeof(create));
      create.req.base.format = 2;
      create.req.base.mip_levels = 1;
      create.req.base.array_size = 1;
      create.req.base.drm_surface_flags = drm_vmw_surface_flag_shareable;
      create.req.base.buffer_handle = 0xFFFFFFFF;
      create.req.base.base_size.width = 64;
      create.req.base.base_size.height = 64;
      create.req.base.base_size.depth = 1;

      if (ioctl(fd, VMW_IOCTL_GB_SURFACE_CREATE_EXT, &create) < 0)
          { printf("create failed: %s\n", strerror(errno)); return 77; }
      if (create.rep.buffer_handle != 0xFFFFFFFF)
          { printf("surface has backup, skip\n"); return 77; }

      union drm_vmw_gb_surface_reference_ext_arg ref;
      memset(&ref, 0, sizeof(ref));
      ref.req.sid = create.rep.handle;

      int ret = ioctl(fd, VMW_IOCTL_GB_SURFACE_REF_EXT, &ref);
      if (ret < 0 && errno == EINVAL)
          { printf("PASS: -EINVAL\n"); return 0; }
      if (ret == 0)
          { printf("FAIL: success (ret=0)\n"); return 1; }
      printf("OTHER: errno=%d\n", errno);
      return 1;
  }

  Build:  gcc -I/usr/include/libdrm -I$HOME -o test_no_backup test_no_backup.c
  Run as a user with read/write access to the render node:
          ./test_no_backup


2. Reference cleanup verification (source inspection)
------------------------------------------------------

vmw_surface_handle_reference() acquires two refs:

  (a) ttm_base_object_lookup_for_ref() — kref_get on base->refcount
      (the "lookup ref")
  (b) ttm_ref_object_add() — acquires a per-file reference in tfile
      (the "per-file ref")

On the SUCCESS path (ret == 0, falls through to out_bad_resource):
  - ttm_base_object_unref(&base) releases the lookup ref (a).
  - The per-file ref (b) stays alive; userspace releases it later
    via DRM_VMW_UNREF_SURFACE → ttm_ref_object_base_unref().

On ERROR paths (ret != 0, goto out_bad_resource):
  - if (ret) ttm_ref_object_base_unref() undoes the per-file
    acquisition (b).
  - ttm_base_object_unref(&base) releases the lookup ref (a).
  - No GEM handle needs to be released on these error paths
    (drm_gem_handle_create either was not reached or failed).

Both paths are balanced.


3. Race analysis (source inspection)
--------------------------------------

Writers of res->guest_memory_bo in vmwgfx (at commit 6edd14dd67d7):

  vmwgfx_resource.c:473  vmw_resource_unreserve(): = vmw_user_bo_ref(new)
  vmwgfx_resource.c:483  vmw_resource_unreserve(): = NULL
    Both under cmdbuf_mutex, called from vmw_execbuf_process
    (vmwgfx_execbuf.c:4242) and vmw_resource_pin
    (vmwgfx_resource.c:1012).

  vmwgfx_resource.c:229  vmw_resource_init(): = NULL (construction)
  vmwgfx_resource.c:354  vmw_resource_buf_alloc(): = gbo (init path)
  vmwgfx_surface.c:~1618 vmw_gb_surface_define_internal(): via
    vmw_user_bo_lookup (construction, surface not yet registered)
  vmwgfx_bo.c:63         vmw_bo_free(): = NULL (destroy)
  vmwgfx_cotable.c:485/496 vmw_cotable_resize(): cotable-only
  vmwgfx_shader.c:185    vmw_dx_shader_unscrub(): shader init

The construction-time writers run before the surface is registered
in the per-file object table, so no concurrent reference ioctl can
reach them. vmw_bo_free runs during destroy. vmw_cotable_resize and
vmw_dx_shader_unscrub operate on resource types not reachable via
DRM_VMW_GB_SURFACE_REF_EXT. vmw_resource_unreserve is the remaining
concurrent writer; both its writes are under cmdbuf_mutex. The patch
moves the reads of guest_memory_bo inside cmdbuf_mutex, serializing
them against these writes.

The race was not reproduced with a dedicated test. The fix is based on
inspection of the locking protocol.


4. IGT regression test
-----------------------

Environment:
  Host: VMware Workstation 26.0.0 build 25388281
  Guest: Debian 12, kernel 7.3.0-rc4+ (commit 6edd14dd67d7)
  IGT: version 2.6 (commit 5e43e9df3a15, x86_64)
  Kernel config: CONFIG_KASAN=y (generic, inline),
    CONFIG_INIT_STACK_ALL_ZERO=y, CONFIG_DRM_VMWGFX=m
  Module swap: sudo rmmod vmwgfx && sudo insmod <module>.ko
  Module files on disk:
    UNFIXED (vmwgfx-UNFIXED.ko): md5 43a0f8caaf651a274d44a3faa51d3929
    FIXED (vmwgfx-TOCTOU-FIXED.ko): md5 01c6785d713de957fc92478cb213f0b4

Results (18 SUCCESS, 9 FAIL, identical in both runs):

  vmw_execution_buffer:
    mob-create-map:                            SUCCESS  SUCCESS
    buffer-create:                             SUCCESS  SUCCESS
    execution-buffer-submit-sync:              SUCCESS  SUCCESS
  vmw_mob_stress:
    max_mob_mem_stress:                        FAIL     FAIL
  vmw_ref_count:
    surface_prime_transfer_explicit_mob:        SUCCESS  SUCCESS
    surface_prime_transfer_implicit_mob:        SUCCESS  SUCCESS
    surface_prime_transfer_fd_dup:             SUCCESS  SUCCESS
    surface_prime_transfer_two_surfaces:       SUCCESS  SUCCESS
    surface_prime_transfer_single_surface_multiple_handle:
                                               SUCCESS  SUCCESS
    mob_repeated_unref:                        SUCCESS  SUCCESS
    surface_repeated_unref:                    SUCCESS  SUCCESS
    surface_alloc_ref_unref:                   SUCCESS  SUCCESS
    surface_buffer_ref:                        SUCCESS  SUCCESS
    surface_prime_refs:                        SUCCESS  SUCCESS
    surface_buffer_prime_refs:                 SUCCESS  SUCCESS
  vmw_surface_copy:
    test_invalid_copies:                       SUCCESS  SUCCESS
    test_invalid_copies_3d:                    SUCCESS  SUCCESS
  vmw_tri:
    tri:                                       FAIL     FAIL
    tri-no-sync-coherent:                      FAIL     FAIL
    tri-2d:                                    SUCCESS  SUCCESS
  vmw_prime:
    basic-vgem:                                SUCCESS  SUCCESS
    tri-map-gem:                               FAIL     FAIL
    tri-map-dmabuf:                            FAIL     FAIL
    draw-dumb-buffer:                          FAIL     FAIL
    buffer-surface-fb-sharing-sync-readback:   FAIL     FAIL
    buffer-surface-fb-sharing-sync:            FAIL     FAIL
    buffer-surface-fb-sharing:                 FAIL     FAIL

The same nine subtests failed in both runs. No additional failures
were observed with the two-patch series applied.

Aldo Ariel Panzardo (2):
  drm/vmwgfx: return an error when a shared GB surface has no backup
    buffer
  drm/vmwgfx: close TOCTOU on guest_memory_bo in surface reference
    ioctl

 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)
--
2.43.0
