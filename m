Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15851606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jww/7i7S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B3510E1C6;
	Sat, 24 Oct 2026 20:48:37 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F32C10E156
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 20:48:31 +0000 (UTC)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-679a2b540f3so1691614d50.2
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792874910; cv=none;
 d=google.com; s=arc-20260327;
 b=gieRWPkFjMOwyT6vndKUvBgCerYsiDgwpr3NJ1bSRVWCgWZr2QG5CoA+qct/yZN4BR
 QNtc/Dtu3mRfhk/zlTVMdJZV/ysJeujlvgZPBw7T7Dazk+E2b6NuqldmS9lsTv0ItV0m
 1/9+nEybc3VXdcwQ+QZBDyGoRA6cTHqlU33nubk4zmQR5MviN/eXvHJKiSFmXopLuoV5
 K32TUpQo/tKFBPCe6fRUrztQt3/lWac7voC8lCNBZvzCu2BENjlQPi0mXxlapQecZl8m
 CG/807kC7Ygd5ry3KsLueWv6a8+dd6IpD3GmWe90wCluvQAMwRvXsBaxn+bJZ4C+Ygqa
 btPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dH3SY8P2txBj09MPnvJaopcgVgMn3Z0sO8eNdJz/y4E=;
 fh=5HExmSXfiMbq7hcUkeVY9X8fU7i3PgLH+9YMBMu5iDQ=;
 b=cu0e2OmKfhxP18wcCRXA8QTGeSCCtdIuQlwSqRLFtdPk/TN1XLx0GxmCFu7ArFLTvj
 4gIm+le5hb1ppLIAy/PeLdCIGPZy3Ud4IcHLCZt+1q7sOAgGIEUNcgv7DpwdPUzpktlI
 0LMyfNW5YHXQwoFNCF88wXqJ6LdZYRjhVThlB3sbkV+fiTFHNmOoEpsQni2M6WVoYs0N
 Ft032xeBadUwR69CUdI1lTJfCd2MW1+rODlVCx/5Q53iRofhiAFSy7Dvb/IQyme/Ey2V
 DuzyveJjQIDGFxtAMj3xQwd12xI0PzCSFPYXNwcSuh9LoiM0evIWgXGG41aKBrlqXBUb
 qn7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792874910; x=1793479710; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dH3SY8P2txBj09MPnvJaopcgVgMn3Z0sO8eNdJz/y4E=;
 b=jww/7i7SvEA7Y3McQOUVF62o0k0LL8uDEUPZKwiWRRr5Rx5DbUW0nEva0183OOT4sA
 oSZ7EcpDt4glYSIsiU+NTbFtJfVdmqwNwe+K5/r4qHEk69EHQHuhuCnHxeF2t+VJBPM9
 aBluPCGM/jHbN/8VqcdznnKKnCPStDhnIi941g1zZe2NCMKU0VXvbhOSQsET2NHMiIOd
 Parn5vv/yT6BB88BeCyxhly5HJOzR77K+Ob99iAvbJVcxvjF/U8LrLO9sDnAwRgGQdwt
 5KfU7N2jxRpF6W+ZHi7Y8yld7vIKZ8c8uxPOnUveTU2jdCqwnHPLdwEc4EmaRLt//Jvm
 dm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792874910; x=1793479710;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dH3SY8P2txBj09MPnvJaopcgVgMn3Z0sO8eNdJz/y4E=;
 b=e8+Tzkh/qBdTNq4Z+wRaSNG9Hba7hvxgjy7tNvo2q4r0wjDw/A20NTQSYAkaCFn1+S
 8OlVwLL0vE5opwuHD41c+p0ywbtCuUh6b8qfO1DsN057IxqCCUuFlSJ7yjTe7dN+Po8r
 k+9jNm20d/obbQX2BvqhH1i5Y6Kv/KyrPuHs80wsSQpTn84SVyzYVaDldWHdCoLCq08O
 CUoHjtgwhdklxz4j3V8uWf31T7ZZaUsXWXrnaPTUrfR620dAUbADgY1BpqX+v3mW0O5s
 CEzAu7F4G3yUCE10PwA+pfTD741Yn3maOdksZf+z/irG6SXPXgmrFULXdhvSaWYFEtOP
 FWGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBySN2X0/aZivtc8R1ez3fYJQBMju3jmpErqOx1o/tmEGO3h1Pu4i1V8MfTuvDxKOK3K6UVGUiQ+h4A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ1AFbtQyQVKpRJWFn9PiPfA1l4jCU/2GC4R5gQuuE9WNtbQeYp
 3gjVyXAXdtj3kOVoNvVmJQXCtv5j3mHu9OEqThcWDIiECTf14zfrfwkuJlIyjXscqDXf2c0lDKt
 IZ3/+jZ+TW5i+qf/R8/v2gIOoztYtaSA=
X-Gm-Gg: AYBFou2Guy7ow+VmFLmmapQjcH6Zc1BA7+ppNJ5MGQgvOWT8ryH4SjwXGvhSjXL6jZi
 A3Q2BSCr66kXMmd3bT+VMgbnzOSqsZJ/RkAQ0OWcuzTyMfdpzRlElktSfg5pKhtlM2JLVjdUT5Y
 Nh8jMytZK4eQaVK4Zymi3QhDnGG2A5XezI4D9XfZRlIDCy5VGVAKDvhZneSwyoHRe/p+Ch5W2N4
 G3YPACZnbV56644yZ9NY5qF4Cv//YHUk1RmQfT2mEHW/NY0Q223lcmSm4+aOHojLqNvCDfcYk3Z
 b83MYhBTcuWGe4hEYN8oChsvV5fVAylqArvf7408Nyd8U2xc6vBG23s+95Uu4tSbMPJX2zm4hLB
 jN3qbOih8FBwmT1rElnQ9GIzZKoTcDoZH1mtBkRAHyCJv/kR5ajm5uP6J
X-Received: by 2002:a05:690c:e0d4:10b0:8aa:357d:e491 with SMTP id
 00721157ae682-8b166c6f994mr13121687b3.89.1792874909641; Sat, 24 Oct 2026
 13:48:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <DLX6J39ZERYJ.377I7R20BGISX@broadcom.com>
 <20261007044312.2152404-1-qwe.aldo@gmail.com>
In-Reply-To: <20261007044312.2152404-1-qwe.aldo@gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:48:18 -0300
X-Gm-Features: AclHuK-zayhJFBCa1eHOeoiea8qj64OnhjaeBebCjp6rER9LPSZGryQ3Y9saziw
Message-ID: <CAP48Hftt7LcYvMAaTqwx3Yk5GANaieSrbYg4Uoxfx=H4dB_nvw@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the
 PRIME core
To: maaz.mombasawala@broadcom.com, Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dri-devel@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000001daf00065e9c38f8"
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000001daf00065e9c38f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zack, Maaz,

Following up on this patch and the before/after IGT logs I sent
October 7.

Would any additional validation help with the review? I'm happy
to investigate further or revise the patch if needed.

Thanks,
Aldo



On Wed, 07 Oct 2026 01:43:10 -0300, Aldo Ariel Panzardo <qwe.aldo@gmail.com=
>
wrote:
> Hi Maaz,
>
> I reproduced the bug on VMware Workstation with a kernel based on
> mainline (commit 6edd14dd67d7, v7.3-rc4), with the vgem test
> modification described below. Below is the setup, the KASAN splat,
> and notes on reproducing.
>
> Regarding your October 3 question about drm-misc-fixes: as of
> 2026-10-06, I searched for "vmw_gem_object_get_sg_table drm-misc-fixes"
> and found no indexed commit fixing this function's embedded sg_table
> ownership issue. The published drm-misc-fixes-2026-10-01 pull request
> lists vmwgfx input validation and blend-mode changes, not this fix [1].
> I could not access the branch's live file history, so I cannot confirm
> that no commit touching vmw_gem_object_get_sg_table exists at its current
> tip. The vgem import-path change described below can prevent the test
> from reaching the affected callback without fixing that callback.
>
> [1]
https://www.mail-archive.com/dri-devel%40lists.freedesktop.org/msg641567.ht=
ml
>
> Setup:
>   - VMware Workstation 26.0.0 (build 25388281) on Ubuntu 24.04 host
>   - Guest: Debian 12 (bookworm), CONFIG_KASAN=3Dy
>   - Kernel: commit 6edd14dd67d76d39a518ad3bf1a98363690a5a62 (v7.3-rc4)
>   - vmwgfx loaded as module (out-of-tree rebuild from same tree)
>   - Second DRM device: vgem (with gem_prime_import_sg_table enabled,
>     see note below)
>   - PoC runs as UID 65534 (nobody), no capabilities
>
> KASAN splat (the v7.3-rc4 commit above, VMware Workstation):
>
> The runtime release string in the unedited trace below is 7.3.0-rc4+.
>
>   BUG: KASAN: invalid-free in dma_buf_unmap_attachment+0xaa/0x1d0
>   Free of addr ffff888104489960 by task poc_sgtable/354
>
>   CPU: 0 UID: 65534 PID: 354 Comm: poc_sgtable Tainted: G  OE  7.3.0-rc4+
#16
>   Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
Reference Platform, BIOS 6.00 02/17/2026
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x60/0x80
>    print_report+0xd0/0x630
>    kasan_report_invalid_free+0x9e/0xc0
>    check_slab_allocation+0xf5/0x100
>    kfree+0x166/0x420
>    dma_buf_unmap_attachment+0xaa/0x1d0
>    dma_buf_unmap_attachment_unlocked+0x80/0x100
>    drm_prime_gem_destroy+0x42/0x90 [drm]
>    drm_gem_shmem_release+0x71/0x800 [drm_shmem_helper]
>    drm_gem_shmem_object_free+0x9/0x20 [drm_shmem_helper]
>    drm_gem_object_release_handle+0xaf/0x220 [drm]
>    drm_gem_handle_delete+0x59/0xa0 [drm]
>    drm_ioctl_kernel+0x163/0x2d0 [drm]
>    drm_ioctl+0x4ce/0xb10 [drm]
>    __x64_sys_ioctl+0x135/0x1c0
>    do_syscall_64+0xc1/0x560
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Steps to reproduce:
>   1. DRM_VMW_ALLOC_DMABUF(262144) on vmwgfx renderD128
>   2. DRM_IOCTL_PRIME_HANDLE_TO_FD
>   3. DRM_VMW_GB_SURFACE_CREATE_EXT 64x64 (BO size 262144 bytes)
>   4. EXECBUF BIND_GB_SURFACE(sid, mobid=3Dhandle)
>      -> vmw_ttm_bind -> vmw_ttm_map_dma
>      -> caches vsgt.sgt =3D &vmw_tt->sgt (embedded member)
>   5. DRM_IOCTL_PRIME_FD_TO_HANDLE on a second DRM device (vgem)
>      -> dma_buf_map_attachment -> drm_gem_map_dma_buf
>      -> vmw_gem_object_get_sg_table returns &vmw_tt->sgt
>   6. Close the importing GEM handle (DRM_IOCTL_GEM_CLOSE or fd close)
>      -> drm_prime_gem_destroy -> dma_buf_unmap_attachment
>      -> drm_gem_unmap_dma_buf: sg_free_table + kfree(&vmw_tt->sgt)
>      (drm_gem_unmap_dma_buf elided in trace by tail-call optimization)
>      =3D> KASAN: invalid-free (interior pointer of vmw_ttm_tt object)
>
> Note on the importing device:
>
> The bug is in vmwgfx's vmw_gem_object_get_sg_table() which returns
> an interior pointer (&vmw_tt->sgt) that the DRM core later kfree()s.
> Any importing driver that calls dma_buf_map_attachment() triggers it,
> provided the BO has been DMA-mapped (vsgt.sgt cached by a prior
> surface bind), as demonstrated with vgem configured with
> gem_prime_import_sg_table. This was tested with vgem; the statement
> about other importing drivers is an inference from the shared PRIME
> map/unmap path.
>
> On mainline, vgem recently switched to drm_gem_shmem_prime_import_no_map
> (commit 660cd44659a0, "drm/shmem-helper: Import dmabuf without mapping
> its sg_table") which skips the map/unmap cycle entirely. This means
> vgem no longer exercises the buggy path by default. For this reproduction=
,
> I set .gem_prime_import_sg_table =3D drm_gem_shmem_prime_import_sg_table
> in vgem_drv.c to use the mapping import path (one-line change, no
> modification to vmwgfx).
>
> The vgem change avoids the affected path for vgem specifically, but
> the underlying vmwgfx defect is unresolved: vmw_gem_object_get_sg_table()
> still returns an interior pointer when vsgt.sgt is cached on the
> tested kernel. The invalid kfree was demonstrated with vgem configured
> with gem_prime_import_sg_table; other importing drivers were not tested.
>
> I also confirmed the invalid-free on kernel 6.12.0 running on
> VMware Workstation, where vgem still uses the mapping import path
> and no vgem modification is needed:
>
>   BUG: KASAN: invalid-free in dma_buf_detach+0x147/0x4e0
>   Free of addr ffff88811813e250 by task poc_sgtable/521
>
>   CPU: 3 UID: 65534 PID: 521 Comm: poc_sgtable Tainted: G  OE  6.12.0 #3
>   Hardware name: VMware, Inc. VMware Virtual Platform
>   Call Trace:
>    kasan_report_invalid_free+0x90/0xb0
>    check_slab_allocation+0xf5/0x100
>    kfree+0xd3/0x400
>    dma_buf_detach+0x147/0x4e0
>    drm_prime_gem_destroy+0x67/0x90 [drm]
>    drm_gem_shmem_free+0x71/0x520 [drm_shmem_helper]
>    drm_gem_handle_delete+0xd9/0x140 [drm]
>
> Patch used for the comparison:
>
> UNFIXED means vmwgfx built from commit
> 6edd14dd67d76d39a518ad3bf1a98363690a5a62 (v7.3-rc4). FIXED means the
> same commit with the change below applied to
vmw_gem_object_get_sg_table().
>
> This patch contains two changes:
>   (a) Add a NULL-check for bo->ttm before dereferencing it via
>       container_of, returning -ENODEV if the TTM backend is absent.
>   (b) Always return a freshly allocated sg_table via
>       drm_prime_pages_to_sg() instead of returning the cached
>       vsgt.sgt interior pointer, which is the root cause of the
>       invalid kfree.
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> index 39f8c46550c2..98c5e42cc762 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> @@ -70,13 +70,15 @@ static void vmw_gem_object_unpin(struct
drm_gem_object *obj)
>  static struct sg_table *vmw_gem_object_get_sg_table(struct
drm_gem_object *obj)
>  {
>       struct ttm_buffer_object *bo =3D drm_gem_ttm_of_gem(obj);
> -     struct vmw_ttm_tt *vmw_tt =3D
> -             container_of(bo->ttm, struct vmw_ttm_tt, dma_ttm);
> +     struct vmw_ttm_tt *vmw_tt;
>
> -     if (vmw_tt->vsgt.sgt)
> -             return vmw_tt->vsgt.sgt;
> +     if (!bo->ttm)
> +             return ERR_PTR(-ENODEV);
>
> -     return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages,
vmw_tt->dma_ttm.num_pages);
> +     vmw_tt =3D container_of(bo->ttm, struct vmw_ttm_tt, dma_ttm);
> +
> +     return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages,
> +                                  vmw_tt->dma_ttm.num_pages);
>  }
>
>  static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys_map
*map)
>
> IGT regression test (existing suite):
>
> I ran the igt-gpu-tools vmwgfx test suite on the same kernel
> (6edd14dd67d76d39a518ad3bf1a98363690a5a62, v7.3-rc4,
> VMware Workstation, Debian 12), swapping vmwgfx.ko built without and
> with the fix described above at runtime via rmmod/insmod. Results
> are identical -- no additional failures:
>
>   IGT version: 2.6-NO-GIT (source from commit 5e43e9d, built from tarball=
)
>   Invocations:
>     sudo /usr/local/igt/vmwgfx/vmw_execution_buffer
>     sudo /usr/local/igt/vmwgfx/vmw_mob_stress
>     sudo /usr/local/igt/vmwgfx/vmw_ref_count
>     sudo /usr/local/igt/vmwgfx/vmw_surface_copy
>     sudo /usr/local/igt/vmwgfx/vmw_tri
>     sudo /usr/local/igt/vmwgfx/vmw_prime
>
>                                                             UNFIXED
FIXED
>   vmw_execution_buffer:
>     mob-create-map:                                         SUCCESS
SUCCESS
>     buffer-create:                                          SUCCESS
SUCCESS
>     execution-buffer-submit-sync:                           SUCCESS
SUCCESS
>   vmw_mob_stress:
>     max_mob_mem_stress:                                     FAIL
 FAIL       (pre-existing)
>   vmw_ref_count:
>     surface_prime_transfer_explicit_mob:                    SUCCESS
SUCCESS
>     surface_prime_transfer_implicit_mob:                    SUCCESS
SUCCESS
>     surface_prime_transfer_fd_dup:                          SUCCESS
SUCCESS
>     surface_prime_transfer_two_surfaces:                    SUCCESS
SUCCESS
>     surface_prime_transfer_single_surface_multiple_handle:  SUCCESS
SUCCESS
>     mob_repeated_unref:                                     SUCCESS
SUCCESS
>     surface_repeated_unref:                                 SUCCESS
SUCCESS
>     surface_alloc_ref_unref:                                SUCCESS
SUCCESS
>     surface_buffer_ref:                                     SUCCESS
SUCCESS
>     surface_prime_refs:                                     SUCCESS
SUCCESS
>     surface_buffer_prime_refs:                              SUCCESS
SUCCESS
>   vmw_surface_copy:
>     test_invalid_copies:                                    SUCCESS
SUCCESS
>     test_invalid_copies_3d:                                 SUCCESS
SUCCESS
>   vmw_tri:
>     tri:                                                    FAIL
 FAIL       (pre-existing)
>     tri-no-sync-coherent:                                   FAIL
 FAIL       (pre-existing)
>     tri-2d:                                                 SUCCESS
SUCCESS
>   vmw_prime:
>     basic-vgem:                                             SUCCESS
SUCCESS
>     tri-map-gem:                                            FAIL
 FAIL       (pre-existing)
>     tri-map-dmabuf:                                         FAIL
 FAIL       (pre-existing)
>     draw-dumb-buffer:                                       FAIL
 FAIL       (pre-existing)
>     buffer-surface-fb-sharing-sync-readback:                      FAIL
   FAIL       (pre-existing)
>     buffer-surface-fb-sharing-sync:                         FAIL
 FAIL       (pre-existing)
>     buffer-surface-fb-sharing:                              FAIL
 FAIL       (pre-existing)
> 18 SUCCESS, 9 FAIL (all pre-existing, identical in both runs).
> Every subtest listed individually. No additional failures from
> the fix.
>
> IGT regression test (new sgtable-invalid-free subtest):
>
> I also wrote and compiled a dedicated IGT subtest
> (vmw_prime_sgtable) that exercises the same PRIME
> export/import/close flow from the standalone reproducer. It was
> compiled against the igt-gpu-tools tree and executed on the same
> kernel (v7.3-rc4, VMware Workstation, CONFIG_KASAN=3Dy), with the
> same vgem mapping-import configuration described above. Results:
>
>   - UNFIXED vmwgfx: subtest sgtable-invalid-free SUCCESS.
>     Immediately afterward, a TTM cleanup worker Oopsed in
>     dma_direct_unmap_sg, with vmw_ttm_unmap_dma in the call
>     trace. This is consistent with corruption of the sg_table
>     used during cleanup.
>   - FIXED vmwgfx: subtest sgtable-invalid-free SUCCESS.
>     dmesg after the test shows no Oops, no KASAN reports,
>     no BUG. A separate WARNING from vmw_cmdbuf_ctx_process
>     (command buffer error during EXECBUF) appears in dmesg;
>     it is distinct from the sg_table invalid-free reported
>     here.
>
> Full IGT logs follow in two replies to this message (unfixed and
> fixed runs).
>
> Standalone reproducer results:
>
> The standalone reproducer (vmw_sgtable_test.c) was compiled and
> executed on VMware Workstation 26.0.0, kernel commit
> 6edd14dd67d76d39a518ad3bf1a98363690a5a62 (v7.3-rc4), without and
> with the fix described above:
>   - UNFIXED vmwgfx: BUG: KASAN: invalid-free in dma_buf_unmap_attachment
>   - FIXED vmwgfx:   clean (no KASAN)
>
> Both the standalone reproducer and the IGT testcase were compiled and
> executed as described above. The standalone reproducer
> (vmw_sgtable_test.c) and IGT testcase source
> (vmw_prime_sgtable.c) are included below.
> Full IGT logs follow in two replies to this message (unfixed
> and fixed runs).
>
> Requires vgem with gem_prime_import_sg_table (one-line override in
> vgem_drv.c, see note above) to exercise the mapping import path.
>
> Let me know if you can reproduce with this setup, or if you need
> anything else from my side. I am happy to send v2 patches whenever
> you are ready.
>
> thanks,
> Aldo
>
> ---8<--- vmw_sgtable_test.c ---8<---
>
> /*
>  * vmw_prime_sgtable_test: Reproduce embedded sg_table invalid-free in
vmwgfx.
>  * Without fix: KASAN reports invalid-free. With fix: clean.
>  */
> #include <stdio.h>
> #include <string.h>
> #include <stdlib.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <errno.h>
> #include <stdint.h>
>
> /* DRM core */
> #define DRM_COMMAND_BASE 0x40
> #define DRM_IOCTL_BASE 'd'
> #define DRM_IOWR(nr, type) _IOWR(DRM_IOCTL_BASE, nr, type)
> #define DRM_IOW(nr, type)  _IOW(DRM_IOCTL_BASE, nr, type)
>
> struct drm_prime_handle { uint32_t handle; uint32_t flags; int32_t fd; };
> struct drm_gem_close { uint32_t handle; uint32_t pad; };
> #define DRM_IOCTL_PRIME_HANDLE_TO_FD _IOWR(DRM_IOCTL_BASE, 0x2d, struct
drm_prime_handle)
> #define DRM_IOCTL_PRIME_FD_TO_HANDLE _IOWR(DRM_IOCTL_BASE, 0x2e, struct
drm_prime_handle)
> #define DRM_IOCTL_GEM_CLOSE _IOW(DRM_IOCTL_BASE, 0x09, struct
drm_gem_close)
>
> /* vmwgfx */
> #define DRM_VMW_ALLOC_DMABUF 1
> #define DRM_VMW_GB_SURFACE_CREATE 23
> #define DRM_VMW_GB_SURFACE_CREATE_EXT 27
> #define DRM_VMW_EXECBUF 12
> #define DRM_VMW_EXECBUF_VERSION 2
> #define SVGA_3D_CMD_BIND_GB_SURFACE 1099
>
> struct drm_vmw_alloc_bo_req { uint32_t size, pad64; };
> struct drm_vmw_bo_rep { uint64_t map_handle; uint32_t handle, cur_gmr_id,
cur_gmr_offset, pad64; };
> union drm_vmw_alloc_bo_arg { struct drm_vmw_alloc_bo_req req; struct
drm_vmw_bo_rep rep; };
>
> struct drm_vmw_size { uint32_t width, height, depth, pad64; };
> struct drm_vmw_gb_surface_create_req {
>     uint32_t svga3d_flags; uint32_t format; uint32_t mip_levels;
>     uint32_t drm_surface_flags; uint32_t multisample_count;
>     uint32_t autogen_filter; uint32_t array_size;
>     uint32_t buffer_handle; struct drm_vmw_size base_size;
> };
> struct drm_vmw_gb_surface_create_rep {
>     uint32_t handle; uint32_t backup_size; uint32_t buffer_handle;
>     uint32_t buffer_size; uint64_t buffer_map_handle;
> };
> union drm_vmw_gb_surface_create_arg {
>     struct drm_vmw_gb_surface_create_rep rep;
>     struct drm_vmw_gb_surface_create_req req;
> };
> struct drm_vmw_gb_surface_create_ext_req {
>     struct drm_vmw_gb_surface_create_req base;
>     uint32_t version;
>     uint32_t svga3d_flags_upper_32_bits;
>     uint32_t multisample_pattern;
>     uint32_t quality_level;
>     uint32_t buffer_byte_stride;
>     uint32_t must_be_zero;
> };
> union drm_vmw_gb_surface_create_ext_arg {
>     struct drm_vmw_gb_surface_create_ext_req req;
>     struct drm_vmw_gb_surface_create_rep rep;
> };
>
> struct drm_vmw_execbuf_arg {
>     uint64_t commands; uint32_t command_size; uint32_t throttle_us;
>     uint64_t fence_rep; uint32_t version; uint32_t flags;
>     uint32_t context_handle; int32_t imported_fence_fd;
> };
>
> #pragma pack(push, 1)
> typedef struct { uint32_t id; uint32_t size; } SVGA3dCmdHeader;
> typedef struct { uint32_t sid; uint32_t mobid; } SVGA3dCmdBindGBSurface;
> #pragma pack(pop)
>
> #define IOCTL_ALLOC DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_ALLOC_DMABUF,
union drm_vmw_alloc_bo_arg)
> #define IOCTL_SURFACE_EXT DRM_IOWR(DRM_COMMAND_BASE +
DRM_VMW_GB_SURFACE_CREATE_EXT, union drm_vmw_gb_surface_create_ext_arg)
> #define IOCTL_EXECBUF DRM_IOW(DRM_COMMAND_BASE + DRM_VMW_EXECBUF, struct
drm_vmw_execbuf_arg)
>
> int main(void) {
>     int vmw_fd, vgem_fd, prime_fd, ret;
>     union drm_vmw_alloc_bo_arg alloc;
>     union drm_vmw_gb_surface_create_ext_arg surf;
>     struct drm_vmw_execbuf_arg exec;
>     struct { SVGA3dCmdHeader hdr; SVGA3dCmdBindGBSurface body; } cmd;
>     struct drm_prime_handle ph, ph2;
>     struct drm_gem_close cl;
>     void *map;
>
>     vmw_fd =3D open("/dev/dri/renderD128", O_RDWR);
>     vgem_fd =3D open("/dev/dri/renderD129", O_RDWR);
>     if (vmw_fd < 0 || vgem_fd < 0) { perror("open"); return 77; }
>
>     /* 1. Alloc BO */
>     memset(&alloc, 0, sizeof(alloc));
>     alloc.req.size =3D 256 * 256 * 4;
>     ret =3D ioctl(vmw_fd, IOCTL_ALLOC, &alloc);
>     if (ret < 0) { perror("alloc"); return 1; }
>     printf("[+] BO handle=3D%u\n", alloc.rep.handle);
>
>     /* 2. Populate */
>     map =3D mmap(NULL, 256*256*4, PROT_READ|PROT_WRITE, MAP_SHARED, vmw_f=
d,
alloc.rep.map_handle);
>     if (map !=3D MAP_FAILED) { memset(map, 0x41, 256*256*4); munmap(map,
256*256*4); }
>
>     /* 3. PRIME export the MOB handle */
>     memset(&ph, 0, sizeof(ph));
>     ph.handle =3D alloc.rep.handle;
>     ph.flags =3D O_CLOEXEC | O_RDWR;
>     ret =3D ioctl(vmw_fd, DRM_IOCTL_PRIME_HANDLE_TO_FD, &ph);
>     if (ret < 0) { perror("export"); return 1; }
>     prime_fd =3D ph.fd;
>     printf("[+] PRIME exported fd=3D%d\n", prime_fd);
>
>     /* 4. Create GB surface + bind (triggers vmw_ttm_map_dma -> vsgt.sgt
cache) */
>     memset(&surf, 0, sizeof(surf));
>     surf.req.base.svga3d_flags =3D (1 << 6); /*
SVGA3D_SURFACE_HINT_RENDERTARGET */
>     surf.req.base.format =3D 37;             /* SVGA3D_BUFFER */
>     surf.req.base.mip_levels =3D 1;
>     surf.req.base.autogen_filter =3D 1;
>     surf.req.base.array_size =3D 1;
>     surf.req.base.drm_surface_flags =3D 1; /*
drm_vmw_surface_flag_shareable */
>     surf.req.base.buffer_handle =3D alloc.rep.handle; /* backup =3D our M=
OB */
>     surf.req.base.base_size.width =3D 64;
>     surf.req.base.base_size.height =3D 64;
>     surf.req.base.base_size.depth =3D 1;
>     surf.req.version =3D 1; /* drm_vmw_surface_version_v1 */
>     ret =3D ioctl(vmw_fd, IOCTL_SURFACE_EXT, &surf);
>     if (ret < 0) { printf("[-] surface create: %s (non-fatal)\n",
strerror(errno)); }
>     else {
>         printf("[+] surface sid=3D%u backup_size=3D%u\n", surf.rep.handle=
,
surf.rep.backup_size);
>         /* EXECBUF bind */
>         cmd.hdr.id =3D SVGA_3D_CMD_BIND_GB_SURFACE;
>         cmd.hdr.size =3D sizeof(cmd.body);
>         cmd.body.sid =3D surf.rep.handle;
>         cmd.body.mobid =3D alloc.rep.handle;
>         memset(&exec, 0, sizeof(exec));
>         exec.commands =3D (uint64_t)(uintptr_t)&cmd;
>         exec.command_size =3D sizeof(cmd);
>         exec.version =3D DRM_VMW_EXECBUF_VERSION;
>         exec.context_handle =3D 0xFFFFFFFF; /* SVGA3D_INVALID_ID =3D no D=
X
context */
>         ret =3D ioctl(vmw_fd, IOCTL_EXECBUF, &exec);
>         if (ret < 0) printf("[-] execbuf bind: %s\n", strerror(errno));
>         else printf("[+] BIND_GB_SURFACE OK\n");
>     }
>
>     /* 5. Cross-device PRIME import */
>     memset(&ph2, 0, sizeof(ph2));
>     ph2.fd =3D prime_fd;
>     ret =3D ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &ph2);
>     if (ret < 0) {
>         printf("[-] PRIME import failed: errno=3D%d\n", errno);
>         close(prime_fd); close(vmw_fd); close(vgem_fd);
>         return 1;
>     }
>     printf("[+] PRIME imported handle=3D%u\n", ph2.handle);
>
>     /* 6. Close import -> kfree(sgt) */
>     memset(&cl, 0, sizeof(cl));
>     cl.handle =3D ph2.handle;
>     ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &cl);
>     close(prime_fd);
>
>     printf("[+] DONE. Check: sudo dmesg | grep KASAN\n");
>     close(vmw_fd); close(vgem_fd);
>     return 0;
> }
>
> ---8<--- vmw_prime_sgtable.c (IGT testcase) ---8<---
>
> // SPDX-License-Identifier: GPL-2.0 OR MIT
> /*
>  * Test: vmw_prime_sgtable
>  *
>  * Validates that vmwgfx correctly handles embedded sg_table lifetime
>  * during cross-device PRIME import/close sequences.  On unfixed kernels,
>  * closing the imported GEM handle triggers kfree() on the embedded
>  * (non-heap-allocated) sg_table inside struct vmw_ttm_tt, producing a
>  * KASAN invalid-free splat.
>  */
>
> #include "igt_kms.h"
> #include "igt_vmwgfx.h"
>
> #include <fcntl.h>
> #include <string.h>
> #include <sys/ioctl.h>
>
> IGT_TEST_DESCRIPTION("Test sg_table lifetime in vmwgfx PRIME
export/import paths.");
>
> /*
>  * Full ioctl number for DRM_VMW_EXECBUF =E2=80=94 vmwgfx_drm.h provides =
the
>  * command offset but not the composed ioctl macro.
>  */
> #define IOCTL_VMW_EXECBUF \
>       DRM_IOW(DRM_COMMAND_BASE + DRM_VMW_EXECBUF, struct
drm_vmw_execbuf_arg)
>
> static void test_sgtable_invalid_free(int vmw_fd, int import_fd)
> {
>       struct vmw_mob *mob;
>       struct vmw_surface *surf;
>       int prime_fd, ret;
>       void *map;
>       const uint32_t bo_size =3D 64 * 64 * 4;
>       SVGA3dSize surf_size =3D { .width =3D 64, .height =3D 64, .depth =
=3D 1 };
>
>       /* 1. Create and populate a MOB */
>       mob =3D vmw_ioctl_mob_create(vmw_fd, bo_size);
>       igt_require(mob);
>       igt_require(mob->handle !=3D 0);
>
>       map =3D vmw_ioctl_mob_map(vmw_fd, mob);
>       igt_require(map);
>       memset(map, 0x41, bo_size);
>       vmw_ioctl_mob_unmap(mob);
>
>       /* 2. PRIME export the MOB handle */
>       prime_fd =3D prime_handle_to_fd(vmw_fd, mob->handle);
>       igt_assert(prime_fd >=3D 0);
>
>       /* 3. Create a GB surface backed by this MOB */
>       surf =3D vmw_ioctl_create_surface_full(vmw_fd,
>               SVGA3D_SURFACE_HINT_RENDERTARGET,   /* flags */
>               SVGA3D_BUFFER,                       /* format */
>               0,                                   /* multisample_count *=
/
>               SVGA3D_MS_PATTERN_NONE,
>               SVGA3D_MS_QUALITY_NONE,
>               SVGA3D_TEX_FILTER_NEAREST,           /* autogen_filter */
>               1,                                   /* num_mip_levels */
>               1,                                   /* array_size */
>               surf_size,
>               mob->handle,                         /* buffer_handle
(backup) */
>               drm_vmw_surface_flag_shareable);
>       /* Surface creation + bind trigger DMA mapping of the BO. */
>       if (surf) {
>               /* 4. Bind surface to MOB via raw EXECBUF */
>               struct {
>                       SVGA3dCmdHeader hdr;
>                       SVGA3dCmdBindGBSurface body;
>               } cmd;
>               struct drm_vmw_execbuf_arg exec;
>
>               cmd.hdr.id =3D SVGA_3D_CMD_BIND_GB_SURFACE;
>               cmd.hdr.size =3D sizeof(cmd.body);
>               cmd.body.sid =3D surf->base.handle;
>               cmd.body.mobid =3D mob->handle;
>
>               memset(&exec, 0, sizeof(exec));
>               exec.commands =3D (uint64_t)(uintptr_t)&cmd;
>               exec.command_size =3D sizeof(cmd);
>               exec.version =3D DRM_VMW_EXECBUF_VERSION;
>               exec.context_handle =3D 0xFFFFFFFF;
>
>               ret =3D ioctl(vmw_fd, IOCTL_VMW_EXECBUF, &exec);
>               if (ret < 0)
>                       igt_debug("execbuf bind: %s (non-fatal)\n",
>                                 strerror(errno));
>               else
>                       igt_debug("BIND_GB_SURFACE OK (sid=3D%u, mobid=3D%u=
)\n",
>                                 surf->base.handle, mob->handle);
>       }
>
>       /*
>        * 5. Cross-device PRIME import using raw ioctl.
>        *
>        * Do NOT use prime_fd_to_handle() =E2=80=94 it returns ENOSYS on
>        * some vmwgfx setups.  Raw DRM_IOCTL_PRIME_FD_TO_HANDLE works.
>        */
>       {
>               struct drm_prime_handle import_args;
>               struct drm_gem_close close_args;
>
>               memset(&import_args, 0, sizeof(import_args));
>               import_args.fd =3D prime_fd;
>               ret =3D ioctl(import_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE,
>                           &import_args);
>               igt_assert_eq(ret, 0);
>               igt_assert(import_args.handle !=3D 0);
>               igt_debug("PRIME imported handle=3D%u\n", import_args.handl=
e);
>
>               /*
>                * 6. Close the imported handle.
>                *
>                * On unfixed kernels this triggers kfree() on the
>                * embedded sg_table that was never separately allocated,
>                * causing KASAN invalid-free.  On fixed kernels this
>                * completes cleanly.
>                */
>               memset(&close_args, 0, sizeof(close_args));
>               close_args.handle =3D import_args.handle;
>               ret =3D ioctl(import_fd, DRM_IOCTL_GEM_CLOSE, &close_args);
>               igt_assert_eq(ret, 0);
>       }
>
>       /* 7. Cleanup */
>       close(prime_fd);
>       if (surf)
>               vmw_ioctl_surface_unref(vmw_fd, surf);
>       vmw_ioctl_mob_close_handle(vmw_fd, mob);
> }
>
> int igt_main()
> {
>       int vmw_fd =3D -1;
>       int import_fd =3D -1;
>
>       igt_fixture() {
>               vmw_fd =3D open("/dev/dri/renderD128", O_RDWR);
>               igt_require(vmw_fd >=3D 0);
>
>               /*
>                * Need a second DRM device for cross-device PRIME import.
>                * Try renderD129 (typically VGEM or another GPU node).
>                */
>               import_fd =3D open("/dev/dri/renderD129", O_RDWR);
>               if (import_fd < 0)
>                       import_fd =3D open("/dev/dri/card1", O_RDWR);
>               igt_require_f(import_fd >=3D 0,
>                             "Need a second DRM device for PRIME
import\n");
>       }
>
>       igt_describe("Validates sg_table lifetime during PRIME"
>                    " export/import/close.  On unfixed kernels, closing
the"
>                    " imported handle triggers an invalid kfree of the"
>                    " embedded sg_table.");
>       igt_subtest("sgtable-invalid-free") {
>               test_sgtable_invalid_free(vmw_fd, import_fd);
>       }
>
>       igt_fixture() {
>               if (import_fd >=3D 0)
>                       close(import_fd);
>               if (vmw_fd >=3D 0)
>                       close(vmw_fd);
>       }
> }

--0000000000001daf00065e9c38f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Zack, Maaz,<br>
<br>
Following up on this patch and the before/after IGT logs I sent<br>
October 7.<br>
<br>
Would any additional validation help with the review? I&#39;m happy<br>
to investigate further or revise the patch if needed.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Wed, 07 Oct 2026 01:43:10 -0300, Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt; Hi Maaz,<br>
&gt; <br>
&gt; I reproduced the bug on VMware Workstation with a kernel based on<br>
&gt; mainline (commit 6edd14dd67d7, v7.3-rc4), with the vgem test<br>
&gt; modification described below. Below is the setup, the KASAN splat,<br>
&gt; and notes on reproducing.<br>
&gt; <br>
&gt; Regarding your October 3 question about drm-misc-fixes: as of<br>
&gt; 2026-10-06, I searched for &quot;vmw_gem_object_get_sg_table drm-misc-=
fixes&quot;<br>
&gt; and found no indexed commit fixing this function&#39;s embedded sg_tab=
le<br>
&gt; ownership issue. The published drm-misc-fixes-2026-10-01 pull request<=
br>
&gt; lists vmwgfx input validation and blend-mode changes, not this fix [1]=
.<br>
&gt; I could not access the branch&#39;s live file history, so I cannot con=
firm<br>
&gt; that no commit touching vmw_gem_object_get_sg_table exists at its curr=
ent<br>
&gt; tip. The vgem import-path change described below can prevent the test<=
br>
&gt; from reaching the affected callback without fixing that callback.<br>
&gt; <br>
&gt; [1] <a href=3D"https://www.mail-archive.com/dri-devel%40lists.freedesk=
top.org/msg641567.html" rel=3D"noreferrer noreferrer" target=3D"_blank">htt=
ps://www.mail-archive.com/dri-devel%40lists.freedesktop.org/msg641567.html<=
/a><br>
&gt; <br>
&gt; Setup:<br>
&gt;=C2=A0 =C2=A0- VMware Workstation 26.0.0 (build 25388281) on Ubuntu 24.=
04 host<br>
&gt;=C2=A0 =C2=A0- Guest: Debian 12 (bookworm), CONFIG_KASAN=3Dy<br>
&gt;=C2=A0 =C2=A0- Kernel: commit 6edd14dd67d76d39a518ad3bf1a98363690a5a62 =
(v7.3-rc4)<br>
&gt;=C2=A0 =C2=A0- vmwgfx loaded as module (out-of-tree rebuild from same t=
ree)<br>
&gt;=C2=A0 =C2=A0- Second DRM device: vgem (with gem_prime_import_sg_table =
enabled,<br>
&gt;=C2=A0 =C2=A0 =C2=A0see note below)<br>
&gt;=C2=A0 =C2=A0- PoC runs as UID 65534 (nobody), no capabilities<br>
&gt; <br>
&gt; KASAN splat (the v7.3-rc4 commit above, VMware Workstation):<br>
&gt; <br>
&gt; The runtime release string in the unedited trace below is 7.3.0-rc4+.<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0BUG: KASAN: invalid-free in dma_buf_unmap_attachment+0xaa/=
0x1d0<br>
&gt;=C2=A0 =C2=A0Free of addr ffff888104489960 by task poc_sgtable/354<br>
&gt; <br>
&gt;=C2=A0 =C2=A0CPU: 0 UID: 65534 PID: 354 Comm: poc_sgtable Tainted: G=C2=
=A0 OE=C2=A0 7.3.0-rc4+ #16<br>
&gt;=C2=A0 =C2=A0Hardware name: VMware, Inc. VMware Virtual Platform/440BX =
Desktop Reference Platform, BIOS 6.00 02/17/2026<br>
&gt;=C2=A0 =C2=A0Call Trace:<br>
&gt;=C2=A0 =C2=A0 &lt;TASK&gt;<br>
&gt;=C2=A0 =C2=A0 dump_stack_lvl+0x60/0x80<br>
&gt;=C2=A0 =C2=A0 print_report+0xd0/0x630<br>
&gt;=C2=A0 =C2=A0 kasan_report_invalid_free+0x9e/0xc0<br>
&gt;=C2=A0 =C2=A0 check_slab_allocation+0xf5/0x100<br>
&gt;=C2=A0 =C2=A0 kfree+0x166/0x420<br>
&gt;=C2=A0 =C2=A0 dma_buf_unmap_attachment+0xaa/0x1d0<br>
&gt;=C2=A0 =C2=A0 dma_buf_unmap_attachment_unlocked+0x80/0x100<br>
&gt;=C2=A0 =C2=A0 drm_prime_gem_destroy+0x42/0x90 [drm]<br>
&gt;=C2=A0 =C2=A0 drm_gem_shmem_release+0x71/0x800 [drm_shmem_helper]<br>
&gt;=C2=A0 =C2=A0 drm_gem_shmem_object_free+0x9/0x20 [drm_shmem_helper]<br>
&gt;=C2=A0 =C2=A0 drm_gem_object_release_handle+0xaf/0x220 [drm]<br>
&gt;=C2=A0 =C2=A0 drm_gem_handle_delete+0x59/0xa0 [drm]<br>
&gt;=C2=A0 =C2=A0 drm_ioctl_kernel+0x163/0x2d0 [drm]<br>
&gt;=C2=A0 =C2=A0 drm_ioctl+0x4ce/0xb10 [drm]<br>
&gt;=C2=A0 =C2=A0 __x64_sys_ioctl+0x135/0x1c0<br>
&gt;=C2=A0 =C2=A0 do_syscall_64+0xc1/0x560<br>
&gt;=C2=A0 =C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e<br>
&gt; <br>
&gt; Steps to reproduce:<br>
&gt;=C2=A0 =C2=A01. DRM_VMW_ALLOC_DMABUF(262144) on vmwgfx renderD128<br>
&gt;=C2=A0 =C2=A02. DRM_IOCTL_PRIME_HANDLE_TO_FD<br>
&gt;=C2=A0 =C2=A03. DRM_VMW_GB_SURFACE_CREATE_EXT 64x64 (BO size 262144 byt=
es)<br>
&gt;=C2=A0 =C2=A04. EXECBUF BIND_GB_SURFACE(sid, mobid=3Dhandle)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -&gt; vmw_ttm_bind -&gt; vmw_ttm_map_dma<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -&gt; caches vsgt.sgt =3D &amp;vmw_tt-&gt;sgt (emb=
edded member)<br>
&gt;=C2=A0 =C2=A05. DRM_IOCTL_PRIME_FD_TO_HANDLE on a second DRM device (vg=
em)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -&gt; dma_buf_map_attachment -&gt; drm_gem_map_dma=
_buf<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -&gt; vmw_gem_object_get_sg_table returns &amp;vmw=
_tt-&gt;sgt<br>
&gt;=C2=A0 =C2=A06. Close the importing GEM handle (DRM_IOCTL_GEM_CLOSE or =
fd close)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -&gt; drm_prime_gem_destroy -&gt; dma_buf_unmap_at=
tachment<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -&gt; drm_gem_unmap_dma_buf: sg_free_table + kfree=
(&amp;vmw_tt-&gt;sgt)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 (drm_gem_unmap_dma_buf elided in trace by tail-cal=
l optimization)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =3D&gt; KASAN: invalid-free (interior pointer of v=
mw_ttm_tt object)<br>
&gt; <br>
&gt; Note on the importing device:<br>
&gt; <br>
&gt; The bug is in vmwgfx&#39;s vmw_gem_object_get_sg_table() which returns=
<br>
&gt; an interior pointer (&amp;vmw_tt-&gt;sgt) that the DRM core later kfre=
e()s.<br>
&gt; Any importing driver that calls dma_buf_map_attachment() triggers it,<=
br>
&gt; provided the BO has been DMA-mapped (vsgt.sgt cached by a prior<br>
&gt; surface bind), as demonstrated with vgem configured with<br>
&gt; gem_prime_import_sg_table. This was tested with vgem; the statement<br=
>
&gt; about other importing drivers is an inference from the shared PRIME<br=
>
&gt; map/unmap path.<br>
&gt; <br>
&gt; On mainline, vgem recently switched to drm_gem_shmem_prime_import_no_m=
ap<br>
&gt; (commit 660cd44659a0, &quot;drm/shmem-helper: Import dmabuf without ma=
pping<br>
&gt; its sg_table&quot;) which skips the map/unmap cycle entirely. This mea=
ns<br>
&gt; vgem no longer exercises the buggy path by default. For this reproduct=
ion,<br>
&gt; I set .gem_prime_import_sg_table =3D drm_gem_shmem_prime_import_sg_tab=
le<br>
&gt; in vgem_drv.c to use the mapping import path (one-line change, no<br>
&gt; modification to vmwgfx).<br>
&gt; <br>
&gt; The vgem change avoids the affected path for vgem specifically, but<br=
>
&gt; the underlying vmwgfx defect is unresolved: vmw_gem_object_get_sg_tabl=
e()<br>
&gt; still returns an interior pointer when vsgt.sgt is cached on the<br>
&gt; tested kernel. The invalid kfree was demonstrated with vgem configured=
<br>
&gt; with gem_prime_import_sg_table; other importing drivers were not teste=
d.<br>
&gt; <br>
&gt; I also confirmed the invalid-free on kernel 6.12.0 running on<br>
&gt; VMware Workstation, where vgem still uses the mapping import path<br>
&gt; and no vgem modification is needed:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0BUG: KASAN: invalid-free in dma_buf_detach+0x147/0x4e0<br>
&gt;=C2=A0 =C2=A0Free of addr ffff88811813e250 by task poc_sgtable/521<br>
&gt; <br>
&gt;=C2=A0 =C2=A0CPU: 3 UID: 65534 PID: 521 Comm: poc_sgtable Tainted: G=C2=
=A0 OE=C2=A0 6.12.0 #3<br>
&gt;=C2=A0 =C2=A0Hardware name: VMware, Inc. VMware Virtual Platform<br>
&gt;=C2=A0 =C2=A0Call Trace:<br>
&gt;=C2=A0 =C2=A0 kasan_report_invalid_free+0x90/0xb0<br>
&gt;=C2=A0 =C2=A0 check_slab_allocation+0xf5/0x100<br>
&gt;=C2=A0 =C2=A0 kfree+0xd3/0x400<br>
&gt;=C2=A0 =C2=A0 dma_buf_detach+0x147/0x4e0<br>
&gt;=C2=A0 =C2=A0 drm_prime_gem_destroy+0x67/0x90 [drm]<br>
&gt;=C2=A0 =C2=A0 drm_gem_shmem_free+0x71/0x520 [drm_shmem_helper]<br>
&gt;=C2=A0 =C2=A0 drm_gem_handle_delete+0xd9/0x140 [drm]<br>
&gt; <br>
&gt; Patch used for the comparison:<br>
&gt; <br>
&gt; UNFIXED means vmwgfx built from commit<br>
&gt; 6edd14dd67d76d39a518ad3bf1a98363690a5a62 (v7.3-rc4). FIXED means the<b=
r>
&gt; same commit with the change below applied to vmw_gem_object_get_sg_tab=
le().<br>
&gt; <br>
&gt; This patch contains two changes:<br>
&gt;=C2=A0 =C2=A0(a) Add a NULL-check for bo-&gt;ttm before dereferencing i=
t via<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0container_of, returning -ENODEV if the TTM b=
ackend is absent.<br>
&gt;=C2=A0 =C2=A0(b) Always return a freshly allocated sg_table via<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_prime_pages_to_sg() instead of returning=
 the cached<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vsgt.sgt interior pointer, which is the root=
 cause of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0invalid kfree.<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmw=
gfx/vmwgfx_gem.c<br>
&gt; index 39f8c46550c2..98c5e42cc762 100644<br>
&gt; --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c<br>
&gt; +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c<br>
&gt; @@ -70,13 +70,15 @@ static void vmw_gem_object_unpin(struct drm_gem_ob=
ject *obj)<br>
&gt;=C2=A0 static struct sg_table *vmw_gem_object_get_sg_table(struct drm_g=
em_object *obj)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ttm_buffer_object *bo =3D drm_gem_ttm=
_of_gem(obj);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct vmw_ttm_tt *vmw_tt =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0container_of(bo-&gt;t=
tm, struct vmw_ttm_tt, dma_ttm);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct vmw_ttm_tt *vmw_tt;<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (vmw_tt-&gt;vsgt.sgt)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return vmw_tt-&gt;vsg=
t.sgt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!bo-&gt;ttm)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-ENODE=
V);<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 =C2=A0return drm_prime_pages_to_sg(obj-&gt;dev, vmw_tt-=
&gt;dma_ttm.pages, vmw_tt-&gt;dma_ttm.num_pages);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vmw_tt =3D container_of(bo-&gt;ttm, struct vmw_tt=
m_tt, dma_ttm);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return drm_prime_pages_to_sg(obj-&gt;dev, vmw_tt-=
&gt;dma_ttm.pages,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmw_tt-&gt;dma_ttm.num_pa=
ges);<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys=
_map *map)<br>
&gt; <br>
&gt; IGT regression test (existing suite):<br>
&gt; <br>
&gt; I ran the igt-gpu-tools vmwgfx test suite on the same kernel<br>
&gt; (6edd14dd67d76d39a518ad3bf1a98363690a5a62, v7.3-rc4,<br>
&gt; VMware Workstation, Debian 12), swapping vmwgfx.ko built without and<b=
r>
&gt; with the fix described above at runtime via rmmod/insmod. Results<br>
&gt; are identical -- no additional failures:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0IGT version: 2.6-NO-GIT (source from commit 5e43e9d, built=
 from tarball)<br>
&gt;=C2=A0 =C2=A0Invocations:<br>
&gt;=C2=A0 =C2=A0 =C2=A0sudo /usr/local/igt/vmwgfx/vmw_execution_buffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0sudo /usr/local/igt/vmwgfx/vmw_mob_stress<br>
&gt;=C2=A0 =C2=A0 =C2=A0sudo /usr/local/igt/vmwgfx/vmw_ref_count<br>
&gt;=C2=A0 =C2=A0 =C2=A0sudo /usr/local/igt/vmwgfx/vmw_surface_copy<br>
&gt;=C2=A0 =C2=A0 =C2=A0sudo /usr/local/igt/vmwgfx/vmw_tri<br>
&gt;=C2=A0 =C2=A0 =C2=A0sudo /usr/local/igt/vmwgfx/vmw_prime<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UN=
FIXED=C2=A0 =C2=A0 FIXED<br>
&gt;=C2=A0 =C2=A0vmw_execution_buffer:<br>
&gt;=C2=A0 =C2=A0 =C2=A0mob-create-map:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer-create:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0execution-buffer-submit-sync:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0vmw_mob_stress:<br>
&gt;=C2=A0 =C2=A0 =C2=A0max_mob_mem_stress:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0=
 =C2=A0 =C2=A0(pre-existing)<br>
&gt;=C2=A0 =C2=A0vmw_ref_count:<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_transfer_explicit_mob:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 =C2=
=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_transfer_implicit_mob:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 =C2=
=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_transfer_fd_dup:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCE=
SS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_transfer_two_surfaces:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 =C2=
=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_transfer_single_surface_multiple_hand=
le:=C2=A0 SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0mob_repeated_unref:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_repeated_unref:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_alloc_ref_unref:=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_buffer_ref:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_refs:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_buffer_prime_refs:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0vmw_surface_copy:<br>
&gt;=C2=A0 =C2=A0 =C2=A0test_invalid_copies:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0test_invalid_copies_3d:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 =C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0vmw_tri:<br>
&gt;=C2=A0 =C2=A0 =C2=A0tri:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL=C2=A0 =
=C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0(pre-existing)<br>
&gt;=C2=A0 =C2=A0 =C2=A0tri-no-sync-coherent:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =
=C2=A0 =C2=A0(pre-existing)<br>
&gt;=C2=A0 =C2=A0 =C2=A0tri-2d:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 =
=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0vmw_prime:<br>
&gt;=C2=A0 =C2=A0 =C2=A0basic-vgem:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 =C2=A0 SUCCES=
S<br>
&gt;=C2=A0 =C2=A0 =C2=A0tri-map-gem:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0FA=
IL=C2=A0 =C2=A0 =C2=A0 =C2=A0(pre-existing)<br>
&gt;=C2=A0 =C2=A0 =C2=A0tri-map-dmabuf:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=
=C2=A0 =C2=A0 =C2=A0 =C2=A0(pre-existing)<br>
&gt;=C2=A0 =C2=A0 =C2=A0draw-dumb-buffer:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =
=C2=A0 =C2=A0 =C2=A0(pre-existing)<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer-surface-fb-sharing-sync-readback:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL=C2=
=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0(pre-existing)<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer-surface-fb-sharing-sync:=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=
=C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0(pre-existing)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0buffer-surface-fb-sharing:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 FAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0(pre-e=
xisting)<br>
&gt; 18 SUCCESS, 9 FAIL (all pre-existing, identical in both runs).<br>
&gt; Every subtest listed individually. No additional failures from<br>
&gt; the fix.<br>
&gt; <br>
&gt; IGT regression test (new sgtable-invalid-free subtest):<br>
&gt; <br>
&gt; I also wrote and compiled a dedicated IGT subtest<br>
&gt; (vmw_prime_sgtable) that exercises the same PRIME<br>
&gt; export/import/close flow from the standalone reproducer. It was<br>
&gt; compiled against the igt-gpu-tools tree and executed on the same<br>
&gt; kernel (v7.3-rc4, VMware Workstation, CONFIG_KASAN=3Dy), with the<br>
&gt; same vgem mapping-import configuration described above. Results:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- UNFIXED vmwgfx: subtest sgtable-invalid-free SUCCESS.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0Immediately afterward, a TTM cleanup worker Oopsed =
in<br>
&gt;=C2=A0 =C2=A0 =C2=A0dma_direct_unmap_sg, with vmw_ttm_unmap_dma in the =
call<br>
&gt;=C2=A0 =C2=A0 =C2=A0trace. This is consistent with corruption of the sg=
_table<br>
&gt;=C2=A0 =C2=A0 =C2=A0used during cleanup.<br>
&gt;=C2=A0 =C2=A0- FIXED vmwgfx: subtest sgtable-invalid-free SUCCESS.<br>
&gt;=C2=A0 =C2=A0 =C2=A0dmesg after the test shows no Oops, no KASAN report=
s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0no BUG. A separate WARNING from vmw_cmdbuf_ctx_proc=
ess<br>
&gt;=C2=A0 =C2=A0 =C2=A0(command buffer error during EXECBUF) appears in dm=
esg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0it is distinct from the sg_table invalid-free repor=
ted<br>
&gt;=C2=A0 =C2=A0 =C2=A0here.<br>
&gt; <br>
&gt; Full IGT logs follow in two replies to this message (unfixed and<br>
&gt; fixed runs).<br>
&gt; <br>
&gt; Standalone reproducer results:<br>
&gt; <br>
&gt; The standalone reproducer (vmw_sgtable_test.c) was compiled and<br>
&gt; executed on VMware Workstation 26.0.0, kernel commit<br>
&gt; 6edd14dd67d76d39a518ad3bf1a98363690a5a62 (v7.3-rc4), without and<br>
&gt; with the fix described above:<br>
&gt;=C2=A0 =C2=A0- UNFIXED vmwgfx: BUG: KASAN: invalid-free in dma_buf_unma=
p_attachment<br>
&gt;=C2=A0 =C2=A0- FIXED vmwgfx:=C2=A0 =C2=A0clean (no KASAN)<br>
&gt; <br>
&gt; Both the standalone reproducer and the IGT testcase were compiled and<=
br>
&gt; executed as described above. The standalone reproducer<br>
&gt; (vmw_sgtable_test.c) and IGT testcase source<br>
&gt; (vmw_prime_sgtable.c) are included below.<br>
&gt; Full IGT logs follow in two replies to this message (unfixed<br>
&gt; and fixed runs).<br>
&gt; <br>
&gt; Requires vgem with gem_prime_import_sg_table (one-line override in<br>
&gt; vgem_drv.c, see note above) to exercise the mapping import path.<br>
&gt; <br>
&gt; Let me know if you can reproduce with this setup, or if you need<br>
&gt; anything else from my side. I am happy to send v2 patches whenever<br>
&gt; you are ready.<br>
&gt; <br>
&gt; thanks,<br>
&gt; Aldo<br>
&gt; <br>
&gt; ---8&lt;--- vmw_sgtable_test.c ---8&lt;---<br>
&gt; <br>
&gt; /*<br>
&gt;=C2=A0 * vmw_prime_sgtable_test: Reproduce embedded sg_table invalid-fr=
ee in vmwgfx.<br>
&gt;=C2=A0 * Without fix: KASAN reports invalid-free. With fix: clean.<br>
&gt;=C2=A0 */<br>
&gt; #include &lt;stdio.h&gt;<br>
&gt; #include &lt;string.h&gt;<br>
&gt; #include &lt;stdlib.h&gt;<br>
&gt; #include &lt;fcntl.h&gt;<br>
&gt; #include &lt;unistd.h&gt;<br>
&gt; #include &lt;sys/ioctl.h&gt;<br>
&gt; #include &lt;sys/mman.h&gt;<br>
&gt; #include &lt;errno.h&gt;<br>
&gt; #include &lt;stdint.h&gt;<br>
&gt; <br>
&gt; /* DRM core */<br>
&gt; #define DRM_COMMAND_BASE 0x40<br>
&gt; #define DRM_IOCTL_BASE &#39;d&#39;<br>
&gt; #define DRM_IOWR(nr, type) _IOWR(DRM_IOCTL_BASE, nr, type)<br>
&gt; #define DRM_IOW(nr, type)=C2=A0 _IOW(DRM_IOCTL_BASE, nr, type)<br>
&gt; <br>
&gt; struct drm_prime_handle { uint32_t handle; uint32_t flags; int32_t fd;=
 };<br>
&gt; struct drm_gem_close { uint32_t handle; uint32_t pad; };<br>
&gt; #define DRM_IOCTL_PRIME_HANDLE_TO_FD _IOWR(DRM_IOCTL_BASE, 0x2d, struc=
t drm_prime_handle)<br>
&gt; #define DRM_IOCTL_PRIME_FD_TO_HANDLE _IOWR(DRM_IOCTL_BASE, 0x2e, struc=
t drm_prime_handle)<br>
&gt; #define DRM_IOCTL_GEM_CLOSE _IOW(DRM_IOCTL_BASE, 0x09, struct drm_gem_=
close)<br>
&gt; <br>
&gt; /* vmwgfx */<br>
&gt; #define DRM_VMW_ALLOC_DMABUF 1<br>
&gt; #define DRM_VMW_GB_SURFACE_CREATE 23<br>
&gt; #define DRM_VMW_GB_SURFACE_CREATE_EXT 27<br>
&gt; #define DRM_VMW_EXECBUF 12<br>
&gt; #define DRM_VMW_EXECBUF_VERSION 2<br>
&gt; #define SVGA_3D_CMD_BIND_GB_SURFACE 1099<br>
&gt; <br>
&gt; struct drm_vmw_alloc_bo_req { uint32_t size, pad64; };<br>
&gt; struct drm_vmw_bo_rep { uint64_t map_handle; uint32_t handle, cur_gmr_=
id, cur_gmr_offset, pad64; };<br>
&gt; union drm_vmw_alloc_bo_arg { struct drm_vmw_alloc_bo_req req; struct d=
rm_vmw_bo_rep rep; };<br>
&gt; <br>
&gt; struct drm_vmw_size { uint32_t width, height, depth, pad64; };<br>
&gt; struct drm_vmw_gb_surface_create_req {<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t svga3d_flags; uint32_t format; uint32_t mi=
p_levels;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t drm_surface_flags; uint32_t multisample_co=
unt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t autogen_filter; uint32_t array_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t buffer_handle; struct drm_vmw_size base_si=
ze;<br>
&gt; };<br>
&gt; struct drm_vmw_gb_surface_create_rep {<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t handle; uint32_t backup_size; uint32_t buf=
fer_handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t buffer_size; uint64_t buffer_map_handle;<b=
r>
&gt; };<br>
&gt; union drm_vmw_gb_surface_create_arg {<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct drm_vmw_gb_surface_create_rep rep;<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct drm_vmw_gb_surface_create_req req;<br>
&gt; };<br>
&gt; struct drm_vmw_gb_surface_create_ext_req {<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct drm_vmw_gb_surface_create_req base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t version;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t svga3d_flags_upper_32_bits;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t multisample_pattern;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t quality_level;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t buffer_byte_stride;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t must_be_zero;<br>
&gt; };<br>
&gt; union drm_vmw_gb_surface_create_ext_arg {<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct drm_vmw_gb_surface_create_ext_req req;<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct drm_vmw_gb_surface_create_rep rep;<br>
&gt; };<br>
&gt; <br>
&gt; struct drm_vmw_execbuf_arg {<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint64_t commands; uint32_t command_size; uint32_t =
throttle_us;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint64_t fence_rep; uint32_t version; uint32_t flag=
s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t context_handle; int32_t imported_fence_fd;=
<br>
&gt; };<br>
&gt; <br>
&gt; #pragma pack(push, 1)<br>
&gt; typedef struct { uint32_t id; uint32_t size; } SVGA3dCmdHeader;<br>
&gt; typedef struct { uint32_t sid; uint32_t mobid; } SVGA3dCmdBindGBSurfac=
e;<br>
&gt; #pragma pack(pop)<br>
&gt; <br>
&gt; #define IOCTL_ALLOC DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_ALLOC_DMABUF, =
union drm_vmw_alloc_bo_arg)<br>
&gt; #define IOCTL_SURFACE_EXT DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_GB_SURFA=
CE_CREATE_EXT, union drm_vmw_gb_surface_create_ext_arg)<br>
&gt; #define IOCTL_EXECBUF DRM_IOW(DRM_COMMAND_BASE + DRM_VMW_EXECBUF, stru=
ct drm_vmw_execbuf_arg)<br>
&gt; <br>
&gt; int main(void) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0int vmw_fd, vgem_fd, prime_fd, ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0union drm_vmw_alloc_bo_arg alloc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0union drm_vmw_gb_surface_create_ext_arg surf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct drm_vmw_execbuf_arg exec;<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct { SVGA3dCmdHeader hdr; SVGA3dCmdBindGBSurfac=
e body; } cmd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct drm_prime_handle ph, ph2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct drm_gem_close cl;<br>
&gt;=C2=A0 =C2=A0 =C2=A0void *map;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0vmw_fd =3D open(&quot;/dev/dri/renderD128&quot;, O_=
RDWR);<br>
&gt;=C2=A0 =C2=A0 =C2=A0vgem_fd =3D open(&quot;/dev/dri/renderD129&quot;, O=
_RDWR);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (vmw_fd &lt; 0 || vgem_fd &lt; 0) { perror(&quot=
;open&quot;); return 77; }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0/* 1. Alloc BO */<br>
&gt;=C2=A0 =C2=A0 =C2=A0memset(&amp;alloc, 0, sizeof(alloc));<br>
&gt;=C2=A0 =C2=A0 =C2=A0alloc.req.size =3D 256 * 256 * 4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0ret =3D ioctl(vmw_fd, IOCTL_ALLOC, &amp;alloc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) { perror(&quot;alloc&quot;); return=
 1; }<br>
&gt;=C2=A0 =C2=A0 =C2=A0printf(&quot;[+] BO handle=3D%u\n&quot;, alloc.rep.=
handle);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0/* 2. Populate */<br>
&gt;=C2=A0 =C2=A0 =C2=A0map =3D mmap(NULL, 256*256*4, PROT_READ|PROT_WRITE,=
 MAP_SHARED, vmw_fd, alloc.rep.map_handle);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (map !=3D MAP_FAILED) { memset(map, 0x41, 256*25=
6*4); munmap(map, 256*256*4); }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0/* 3. PRIME export the MOB handle */<br>
&gt;=C2=A0 =C2=A0 =C2=A0memset(&amp;ph, 0, sizeof(ph));<br>
&gt;=C2=A0 =C2=A0 =C2=A0ph.handle =3D alloc.rep.handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0ph.flags =3D O_CLOEXEC | O_RDWR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0ret =3D ioctl(vmw_fd, DRM_IOCTL_PRIME_HANDLE_TO_FD,=
 &amp;ph);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) { perror(&quot;export&quot;); retur=
n 1; }<br>
&gt;=C2=A0 =C2=A0 =C2=A0prime_fd =3D ph.fd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0printf(&quot;[+] PRIME exported fd=3D%d\n&quot;, pr=
ime_fd);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0/* 4. Create GB surface + bind (triggers vmw_ttm_ma=
p_dma -&gt; vsgt.sgt cache) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0memset(&amp;surf, 0, sizeof(surf));<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.base.svga3d_flags =3D (1 &lt;&lt; 6); /* S=
VGA3D_SURFACE_HINT_RENDERTARGET */<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.base.format =3D 37;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* SVGA3D_BUFFER */<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.base.mip_levels =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.base.autogen_filter =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.base.array_size =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.base.drm_surface_flags =3D 1; /* drm_vmw_s=
urface_flag_shareable */<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.base.buffer_handle =3D alloc.rep.handle; /=
* backup =3D our MOB */<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.base.base_size.width =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.base.base_size.height =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.base.base_size.depth =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0surf.req.version =3D 1; /* drm_vmw_surface_version_=
v1 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0ret =3D ioctl(vmw_fd, IOCTL_SURFACE_EXT, &amp;surf)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) { printf(&quot;[-] surface create: =
%s (non-fatal)\n&quot;, strerror(errno)); }<br>
&gt;=C2=A0 =C2=A0 =C2=A0else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;[+] surface sid=3D%u bac=
kup_size=3D%u\n&quot;, surf.rep.handle, surf.rep.backup_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* EXECBUF bind */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://cmd.hdr.id" rel=3D"=
noreferrer noreferrer" target=3D"_blank">cmd.hdr.id</a> =3D SVGA_3D_CMD_BIN=
D_GB_SURFACE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.hdr.size =3D sizeof(cmd.body);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.body.sid =3D surf.rep.handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.body.mobid =3D alloc.rep.handle;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;exec, 0, sizeof(exec));<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec.commands =3D (uint64_t)(uintptr_=
t)&amp;cmd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec.command_size =3D sizeof(cmd);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec.version =3D DRM_VMW_EXECBUF_VERS=
ION;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec.context_handle =3D 0xFFFFFFFF; /=
* SVGA3D_INVALID_ID =3D no DX context */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ioctl(vmw_fd, IOCTL_EXECBUF, =
&amp;exec);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) printf(&quot;[-] exec=
buf bind: %s\n&quot;, strerror(errno));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else printf(&quot;[+] BIND_GB_SURFACE=
 OK\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0/* 5. Cross-device PRIME import */<br>
&gt;=C2=A0 =C2=A0 =C2=A0memset(&amp;ph2, 0, sizeof(ph2));<br>
&gt;=C2=A0 =C2=A0 =C2=A0ph2.fd =3D prime_fd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0ret =3D ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE=
, &amp;ph2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;[-] PRIME import failed:=
 errno=3D%d\n&quot;, errno);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(prime_fd); close(vmw_fd); close=
(vgem_fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0printf(&quot;[+] PRIME imported handle=3D%u\n&quot;=
, ph2.handle);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0/* 6. Close import -&gt; kfree(sgt) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0memset(&amp;cl, 0, sizeof(cl));<br>
&gt;=C2=A0 =C2=A0 =C2=A0cl.handle =3D ph2.handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &amp;cl);<br>
&gt;=C2=A0 =C2=A0 =C2=A0close(prime_fd);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0printf(&quot;[+] DONE. Check: sudo dmesg | grep KAS=
AN\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0close(vmw_fd); close(vgem_fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; }<br>
&gt; <br>
&gt; ---8&lt;--- vmw_prime_sgtable.c (IGT testcase) ---8&lt;---<br>
&gt; <br>
&gt; // SPDX-License-Identifier: GPL-2.0 OR MIT<br>
&gt; /*<br>
&gt;=C2=A0 * Test: vmw_prime_sgtable<br>
&gt;=C2=A0 *<br>
&gt;=C2=A0 * Validates that vmwgfx correctly handles embedded sg_table life=
time<br>
&gt;=C2=A0 * during cross-device PRIME import/close sequences.=C2=A0 On unf=
ixed kernels,<br>
&gt;=C2=A0 * closing the imported GEM handle triggers kfree() on the embedd=
ed<br>
&gt;=C2=A0 * (non-heap-allocated) sg_table inside struct vmw_ttm_tt, produc=
ing a<br>
&gt;=C2=A0 * KASAN invalid-free splat.<br>
&gt;=C2=A0 */<br>
&gt; <br>
&gt; #include &quot;igt_kms.h&quot;<br>
&gt; #include &quot;igt_vmwgfx.h&quot;<br>
&gt; <br>
&gt; #include &lt;fcntl.h&gt;<br>
&gt; #include &lt;string.h&gt;<br>
&gt; #include &lt;sys/ioctl.h&gt;<br>
&gt; <br>
&gt; IGT_TEST_DESCRIPTION(&quot;Test sg_table lifetime in vmwgfx PRIME expo=
rt/import paths.&quot;);<br>
&gt; <br>
&gt; /*<br>
&gt;=C2=A0 * Full ioctl number for DRM_VMW_EXECBUF =E2=80=94 vmwgfx_drm.h p=
rovides the<br>
&gt;=C2=A0 * command offset but not the composed ioctl macro.<br>
&gt;=C2=A0 */<br>
&gt; #define IOCTL_VMW_EXECBUF \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOW(DRM_COMMAND_BASE + DRM_VMW_EXECBUF, =
struct drm_vmw_execbuf_arg)<br>
&gt; <br>
&gt; static void test_sgtable_invalid_free(int vmw_fd, int import_fd)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vmw_mob *mob;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vmw_surface *surf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int prime_fd, ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void *map;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t bo_size =3D 64 * 64 * 4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SVGA3dSize surf_size =3D { .width =3D 64, .h=
eight =3D 64, .depth =3D 1 };<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 1. Create and populate a MOB */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mob =3D vmw_ioctl_mob_create(vmw_fd, bo_size=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0igt_require(mob);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0igt_require(mob-&gt;handle !=3D 0);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0map =3D vmw_ioctl_mob_map(vmw_fd, mob);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0igt_require(map);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(map, 0x41, bo_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vmw_ioctl_mob_unmap(mob);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 2. PRIME export the MOB handle */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0prime_fd =3D prime_handle_to_fd(vmw_fd, mob-=
&gt;handle);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0igt_assert(prime_fd &gt;=3D 0);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 3. Create a GB surface backed by this MOB=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0surf =3D vmw_ioctl_create_surface_full(vmw_f=
d,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SVGA3D_SURFACE_H=
INT_RENDERTARGET,=C2=A0 =C2=A0/* flags */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SVGA3D_BUFFER,=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* format */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00,=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* multisample_count */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SVGA3D_MS_PATTER=
N_NONE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SVGA3D_MS_QUALIT=
Y_NONE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SVGA3D_TEX_FILTE=
R_NEAREST,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* autogen_filter */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01,=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* num_mip_levels */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01,=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* array_size */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0surf_size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mob-&gt;handle,=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* buffer_handle (backup) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_vmw_surface_=
flag_shareable);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Surface creation + bind trigger DMA mappi=
ng of the BO. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (surf) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 4. Bind surfa=
ce to MOB via raw EXECBUF */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0SVGA3dCmdHeader hdr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0SVGA3dCmdBindGBSurface body;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} cmd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_vmw_e=
xecbuf_arg exec;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http:=
//cmd.hdr.id" rel=3D"noreferrer noreferrer" target=3D"_blank">cmd.hdr.id</a=
> =3D SVGA_3D_CMD_BIND_GB_SURFACE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.hdr.size =3D=
 sizeof(cmd.body);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.body.sid =3D=
 surf-&gt;base.handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.body.mobid =
=3D mob-&gt;handle;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;exec=
, 0, sizeof(exec));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec.commands =
=3D (uint64_t)(uintptr_t)&amp;cmd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec.command_siz=
e =3D sizeof(cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec.version =3D=
 DRM_VMW_EXECBUF_VERSION;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exec.context_han=
dle =3D 0xFFFFFFFF;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ioctl(vm=
w_fd, IOCTL_VMW_EXECBUF, &amp;exec);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0igt_debug(&quot;execbuf bind: %s (non-fatal)\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror(errno));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0igt_debug(&quot;BIND_GB_SURFACE OK (sid=3D%u, mobid=3D%u)\n&qu=
ot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0surf-&gt;base.handle, mob-&=
gt;handle);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * 5. Cross-device PRIME import using raw io=
ctl.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Do NOT use prime_fd_to_handle() =E2=80=94=
 it returns ENOSYS on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * some vmwgfx setups.=C2=A0 Raw DRM_IOCTL_P=
RIME_FD_TO_HANDLE works.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_prime=
_handle import_args;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_gem_c=
lose close_args;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;impo=
rt_args, 0, sizeof(import_args));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0import_args.fd =
=3D prime_fd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ioctl(im=
port_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;import_args);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igt_assert_eq(re=
t, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igt_assert(impor=
t_args.handle !=3D 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igt_debug(&quot;=
PRIME imported handle=3D%u\n&quot;, import_args.handle);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 6. Close the =
imported handle.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * On unfixed ke=
rnels this triggers kfree() on the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * embedded sg_t=
able that was never separately allocated,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * causing KASAN=
 invalid-free.=C2=A0 On fixed kernels this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * completes cle=
anly.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;clos=
e_args, 0, sizeof(close_args));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close_args.handl=
e =3D import_args.handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ioctl(im=
port_fd, DRM_IOCTL_GEM_CLOSE, &amp;close_args);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igt_assert_eq(re=
t, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 7. Cleanup */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0close(prime_fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (surf)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmw_ioctl_surfac=
e_unref(vmw_fd, surf);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vmw_ioctl_mob_close_handle(vmw_fd, mob);<br>
&gt; }<br>
&gt; <br>
&gt; int igt_main()<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int vmw_fd =3D -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int import_fd =3D -1;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0igt_fixture() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmw_fd =3D open(=
&quot;/dev/dri/renderD128&quot;, O_RDWR);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igt_require(vmw_=
fd &gt;=3D 0);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Need a second=
 DRM device for cross-device PRIME import.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Try renderD12=
9 (typically VGEM or another GPU node).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0import_fd =3D op=
en(&quot;/dev/dri/renderD129&quot;, O_RDWR);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (import_fd &l=
t; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0import_fd =3D open(&quot;/dev/dri/card1&quot;, O_RDWR);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igt_require_f(im=
port_fd &gt;=3D 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Need a second DRM device for PRIME =
import\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0igt_describe(&quot;Validates sg_table lifeti=
me during PRIME&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot; export/import/close.=C2=A0 On unfixed kernels, closing the&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot; imported handle triggers an invalid kfree of the&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot; embedded sg_table.&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0igt_subtest(&quot;sgtable-invalid-free&quot;=
) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_sgtable_inv=
alid_free(vmw_fd, import_fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0igt_fixture() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (import_fd &g=
t;=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0close(import_fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vmw_fd &gt;=
=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0close(vmw_fd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; }

--0000000000001daf00065e9c38f8--
