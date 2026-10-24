Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595C606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ip83ZLBh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 448C110E0B8;
	Sat, 24 Oct 2026 20:47:46 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3367E10E0B8
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 20:47:40 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-8b10d24345dso17524507b3.3
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792874859; cv=none;
 d=google.com; s=arc-20260327;
 b=E6Q6P9DDZvgR4RqKeIu736dV4OFFRCEyYnPv/lURl0ZdMqhrWNDxrc/ZkhNQRjmy7+
 yqA04dZOfiBCUtLVKUu/rRqIyCzN5I8bUTupaJCprQGQUTCItmLDR5mD9AR4YnoakhuB
 w3/E84Koi8FY4VY//mXnFrj9bb11TNkKEtIjzfVU5wfbLLF8HQO8WsF2EC4CHPGAu/MW
 xPpodTxyXL8qWrW9lwkIKInQ3xuK8kePjh4n9hHfiWYbo9LF8xztwibsyc1j9Lqhd6Ge
 ThIa/hZtLDKBRgUjod1vzEZm6W4fiGDOB/BsYJyWp+nMLcZtbIXBmgjovQeOtD+kOr6r
 HwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0MXQ3wNrfVN3/lGa5CWQcHfiuQ/L5theThyhaL5eO4s=;
 fh=iY8BREMjM0d6eg0vdCVMWbd0OIBzqNWv3OkpYLu3kZ0=;
 b=I6DZ+y2161V9ErRT7MjAm+6d8Yf40e+CXNj/Cde7CmdXhouZEvRfuEK5U+0Sl0BPD/
 GVK+tUeRu8HW4yMWfM/4Q45g+A47v5bmxig2EsOxomUfEQRkrSejIk1Ftgf3R+gjvY8C
 MK7Lr3u1WI4tF9j944tdbhZkpbA1LisVMMWzTID64wqjUTf+s79qzgStQUq2orDwZ4Sx
 m/BkcD1ACbqZ7ih9ZR780wT5jTmnqdJaBR0IIdUBXhmHM/g8YVO0EEpPq4lGYmP13zt7
 oRAH5Fi8r0ST6dmaW5m6CtaWhHAV2GubLX9M3pb/2qYC4JRz2Slhw0T2W7nmCA9XkINT
 5gEQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792874859; x=1793479659; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0MXQ3wNrfVN3/lGa5CWQcHfiuQ/L5theThyhaL5eO4s=;
 b=ip83ZLBhJyiEVCC7dLlKMN1UcxAFs4NFikaiv2ANSr8vGK0FyEjf0TjYEvSBdW0JfY
 Aj36QhB8ZC278nBz1q8li08POBpsHlidPqjH1VwyW4ABhdmGJTYW4CRIfqEV777gnoPn
 xIkTgkozxuHCPsFVDSeHTn5By71Rsb3HIffEk0vgBrzvWkLUqGz4aDfqFaAEmLkyRXyx
 8fC8PNjqKR6xGWJ+RlHVDbUShnKEv3xNIXfWxpOYr0/13hzRCSbN6RYAmniI+2q0NMkr
 7srzpoE1AQwRqF777HCVBzaCTxWMC/ZVMJpqtupyBdY7Es7AsTqfwyApsw/N3RAqcKCl
 tE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792874859; x=1793479659;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0MXQ3wNrfVN3/lGa5CWQcHfiuQ/L5theThyhaL5eO4s=;
 b=u/b3Yn0M45SdvNzxA7P9hU6TH54S1Tr/gh+4+3XWT+xG7ccmTAZ6SJM5N8hqD8oZie
 70TL5EOasazqNYO35Pn+jdU1K/DW4ObGnmu2vUebvEpn9gN4YFsb3H30hS8yUFMa+tjM
 zbOWuquuybyIVt+CGBNuCLoEbwXBiaFfHldN4k4pYigDr2eH9eJ+U40stZXAYpqEU/dC
 Me7c0mOa5qVooX/p8qZKtXEFqV9MjTOWrReOh0HCN3e15TuXQg3cLyOF1UzpJ+h3gMN5
 P4bZVbIrkYoAsDh3M1o0ppGYwYE8ADQySBHhQ0H2T1lcGR09JwkeDCToTNe8djnYlb+I
 HCzg==
X-Gm-Message-State: AFq9FYLthSSI4U6PQqqOQG64ht9wsJEbp3YwuC6eA1XpsUa1EX4S9R5v
 avQ+zugOtMIu9c/BWkPC3Jh58O2lwUzPFf+8TOLa4bIcXfmjXIOa1CvzikP33fn58ot6ah4U8iP
 mfKPPsE6Z33TyK1lwuEUKqRcF9oMPbQo=
X-Gm-Gg: AYBFou0FjXe0/JNt1yjj7aHoTJ/gbZwMCljf1TMBob4/U7lmBHj+erGgGqCF10BM1ll
 9IAC286mRmg32mGUzyJabzaKPUMBmTI3RuWphVwCK+OJI3LF4QMmYvTzPLcG+r2NcT0Z5xS+OJ+
 jzr7O2LlAis6rrZFKAm2rvd6yN5PKS35fb1nBCMvmc8CcotrlNsgtfPTvMzszjZsRU8e3N0aD9b
 tEQUHeUUEZkLtm5leQxw4aQdk4eHSzKgGIN0f7OPw7dAnXKQ/K0qFz6AL9RyaS1BGVKGxcP0xF4
 YYaT/ndaCpH2Ft9OAlJaa6/yAxYYQXop2wQip+j94sL3ordUu3oS/+fMrOzK/OaBzqBa4R1T1k3
 b8Lcb8ebdLw3djrPxnENcKEPCFsXC2Q0jo4c=
X-Received: by 2002:a05:690c:a207:20b0:8b0:dc6f:40d0 with SMTP id
 00721157ae682-8b166bd5caamr16786467b3.21.1792874858780; Sat, 24 Oct 2026
 13:47:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261007212051.2574235-1-qwe.aldo@gmail.com>
In-Reply-To: <20261007212051.2574235-1-qwe.aldo@gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:47:27 -0300
X-Gm-Features: AclHuK9kyp94S7ofObNzr9wv7tLKK_BmSxTk5XlqG5i_iyMApct2emMgk1gILv4
Message-ID: <CAP48Hft0uGmm-Akb8UO2QrLmriFtK0ZHonR76seUR3eG5UQXMw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/vmwgfx: fix surface reference ioctl error
 handling and TOCTOU
To: Zack Rusin <zack.rusin@broadcom.com>, maaz.mombasawala@broadcom.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000159cda065e9c3595"
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

--000000000000159cda065e9c3595
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zack, Maaz,

Following up on the v2 series sent October 7.

Is there any additional testing or any change that would help move
the review forward? I'm happy to rerun the VMware/IGT tests or
address any remaining concerns.

Thanks,
Aldo



On Wed, 07 Oct 2026 18:20:47 -0300, Aldo Ariel Panzardo <qwe.aldo@gmail.com=
>
wrote:
> Hi Zack,
>
> Thank you for the detailed review. Here is v2 as a two-patch series
> addressing all your feedback:
>
>   1/2: return an error and drop the surface reference when backup is
>        missing (unchanged from v2 RESEND, included for series base)
>   2/2: close the TOCTOU on guest_memory_bo (v2, description and
>        Fixes tag corrected per your review)
>
> Changes in 2/2 since v1:
>   - Description rewritten: the racing writer is a backup switch via
>     SVGA_3D_CMD_BIND_GB_SURFACE (vmw_resource_unreserve), not eviction
>   - Fixes tag corrected to a97e21923b42
>   - Rebased on top of 1/2 (no longer duplicates ret =3D -EINVAL)
>   - mutex scope kept to the minimum: NULL check, handle creation,
>     buffer_map_handle and buffer_size reads
>
>
> 1. Validation test for patch 1/2
> ---------------------------------
>
> A test program creates a shareable surface WITHOUT a backup buffer
> (drm_surface_flags=3Dshareable, buffer_handle=3DSVGA3D_INVALID_ID, no
> drm_vmw_surface_flag_create_buffer), then calls the surface reference
> ioctl via DRM_VMW_GB_SURFACE_REF_EXT.
>
>   UNFIXED module:  ioctl() returns 0 (success) without filling the
>                    reply structure =E2=80=94 the kernel handler never set=
s ret.
>   FIXED module:    ioctl() returns -1 with errno set to EINVAL. Kernel
>                    dmesg shows:
>                      [drm:vmw_gb_surface_reference_internal [vmwgfx]]
>                      *ERROR* Shared GB surface is missing a backup buffer=
.
>
> The test exercises the missing-backup error path, but does not
> independently verify reference cleanup. The cleanup was verified by
> source inspection =E2=80=94 see section 2 below.
>
> Test program (test_no_backup.c, requires <drm.h> and the kernel UAPI
> vmwgfx_drm.h):
>
>   #include <stdio.h>
>   #include <string.h>
>   #include <fcntl.h>
>   #include <unistd.h>
>   #include <sys/ioctl.h>
>   #include <errno.h>
>   #include <stdint.h>
>   #include <drm.h>
>   #include "vmwgfx_drm.h"
>
>   #define VMW_IOCTL_GB_SURFACE_CREATE_EXT \
>       DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_GB_SURFACE_CREATE_EXT, \
>                union drm_vmw_gb_surface_create_ext_arg)
>   #define VMW_IOCTL_GB_SURFACE_REF_EXT \
>       DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_GB_SURFACE_REF_EXT, \
>                union drm_vmw_gb_surface_reference_ext_arg)
>
>   int main(void) {
>       int fd =3D open("/dev/dri/renderD128", O_RDWR);
>       if (fd < 0) { perror("open"); return 77; }
>
>       union drm_vmw_gb_surface_create_ext_arg create;
>       memset(&create, 0, sizeof(create));
>       create.req.base.format =3D 2;
>       create.req.base.mip_levels =3D 1;
>       create.req.base.array_size =3D 1;
>       create.req.base.drm_surface_flags =3D drm_vmw_surface_flag_shareabl=
e;
>       create.req.base.buffer_handle =3D 0xFFFFFFFF;
>       create.req.base.base_size.width =3D 64;
>       create.req.base.base_size.height =3D 64;
>       create.req.base.base_size.depth =3D 1;
>
>       if (ioctl(fd, VMW_IOCTL_GB_SURFACE_CREATE_EXT, &create) < 0)
>           { printf("create failed: %s\n", strerror(errno)); return 77; }
>       if (create.rep.buffer_handle !=3D 0xFFFFFFFF)
>           { printf("surface has backup, skip\n"); return 77; }
>
>       union drm_vmw_gb_surface_reference_ext_arg ref;
>       memset(&ref, 0, sizeof(ref));
>       ref.req.sid =3D create.rep.handle;
>
>       int ret =3D ioctl(fd, VMW_IOCTL_GB_SURFACE_REF_EXT, &ref);
>       if (ret < 0 && errno =3D=3D EINVAL)
>           { printf("PASS: -EINVAL\n"); return 0; }
>       if (ret =3D=3D 0)
>           { printf("FAIL: success (ret=3D0)\n"); return 1; }
>       printf("OTHER: errno=3D%d\n", errno);
>       return 1;
>   }
>
>   Build:  gcc -I/usr/include/libdrm -I$HOME -o test_no_backup
test_no_backup.c
>   Run as a user with read/write access to the render node:
>           ./test_no_backup
>
>
> 2. Reference cleanup verification (source inspection)
> ------------------------------------------------------
>
> vmw_surface_handle_reference() acquires two refs:
>
>   (a) ttm_base_object_lookup_for_ref() =E2=80=94 kref_get on base->refcou=
nt
>       (the "lookup ref")
>   (b) ttm_ref_object_add() =E2=80=94 acquires a per-file reference in tfi=
le
>       (the "per-file ref")
>
> On the SUCCESS path (ret =3D=3D 0, falls through to out_bad_resource):
>   - ttm_base_object_unref(&base) releases the lookup ref (a).
>   - The per-file ref (b) stays alive; userspace releases it later
>     via DRM_VMW_UNREF_SURFACE =E2=86=92 ttm_ref_object_base_unref().
>
> On ERROR paths (ret !=3D 0, goto out_bad_resource):
>   - if (ret) ttm_ref_object_base_unref() undoes the per-file
>     acquisition (b).
>   - ttm_base_object_unref(&base) releases the lookup ref (a).
>   - No GEM handle needs to be released on these error paths
>     (drm_gem_handle_create either was not reached or failed).
>
> Both paths are balanced.
>
>
> 3. Race analysis (source inspection)
> --------------------------------------
>
> Writers of res->guest_memory_bo in vmwgfx (at commit 6edd14dd67d7):
>
>   vmwgfx_resource.c:473  vmw_resource_unreserve(): =3D vmw_user_bo_ref(ne=
w)
>   vmwgfx_resource.c:483  vmw_resource_unreserve(): =3D NULL
>     Both under cmdbuf_mutex, called from vmw_execbuf_process
>     (vmwgfx_execbuf.c:4242) and vmw_resource_pin
>     (vmwgfx_resource.c:1012).
>
>   vmwgfx_resource.c:229  vmw_resource_init(): =3D NULL (construction)
>   vmwgfx_resource.c:354  vmw_resource_buf_alloc(): =3D gbo (init path)
>   vmwgfx_surface.c:~1618 vmw_gb_surface_define_internal(): via
>     vmw_user_bo_lookup (construction, surface not yet registered)
>   vmwgfx_bo.c:63         vmw_bo_free(): =3D NULL (destroy)
>   vmwgfx_cotable.c:485/496 vmw_cotable_resize(): cotable-only
>   vmwgfx_shader.c:185    vmw_dx_shader_unscrub(): shader init
>
> The construction-time writers run before the surface is registered
> in the per-file object table, so no concurrent reference ioctl can
> reach them. vmw_bo_free runs during destroy. vmw_cotable_resize and
> vmw_dx_shader_unscrub operate on resource types not reachable via
> DRM_VMW_GB_SURFACE_REF_EXT. vmw_resource_unreserve is the remaining
> concurrent writer; both its writes are under cmdbuf_mutex. The patch
> moves the reads of guest_memory_bo inside cmdbuf_mutex, serializing
> them against these writes.
>
> The race was not reproduced with a dedicated test. The fix is based on
> inspection of the locking protocol.
>
>
> 4. IGT regression test
> -----------------------
>
> Environment:
>   Host: VMware Workstation 26.0.0 build 25388281
>   Guest: Debian 12, kernel 7.3.0-rc4+ (commit 6edd14dd67d7)
>   IGT: version 2.6 (commit 5e43e9df3a15, x86_64)
>   Kernel config: CONFIG_KASAN=3Dy (generic, inline),
>     CONFIG_INIT_STACK_ALL_ZERO=3Dy, CONFIG_DRM_VMWGFX=3Dm
>   Module swap: sudo rmmod vmwgfx && sudo insmod <module>.ko
>   Module files on disk:
>     UNFIXED (vmwgfx-UNFIXED.ko): md5 43a0f8caaf651a274d44a3faa51d3929
>     FIXED (vmwgfx-TOCTOU-FIXED.ko): md5 01c6785d713de957fc92478cb213f0b4
>
> Results (18 SUCCESS, 9 FAIL, identical in both runs):
>
>   vmw_execution_buffer:
>     mob-create-map:                            SUCCESS  SUCCESS
>     buffer-create:                             SUCCESS  SUCCESS
>     execution-buffer-submit-sync:              SUCCESS  SUCCESS
>   vmw_mob_stress:
>     max_mob_mem_stress:                        FAIL     FAIL
>   vmw_ref_count:
>     surface_prime_transfer_explicit_mob:        SUCCESS  SUCCESS
>     surface_prime_transfer_implicit_mob:        SUCCESS  SUCCESS
>     surface_prime_transfer_fd_dup:             SUCCESS  SUCCESS
>     surface_prime_transfer_two_surfaces:       SUCCESS  SUCCESS
>     surface_prime_transfer_single_surface_multiple_handle:
>                                                SUCCESS  SUCCESS
>     mob_repeated_unref:                        SUCCESS  SUCCESS
>     surface_repeated_unref:                    SUCCESS  SUCCESS
>     surface_alloc_ref_unref:                   SUCCESS  SUCCESS
>     surface_buffer_ref:                        SUCCESS  SUCCESS
>     surface_prime_refs:                        SUCCESS  SUCCESS
>     surface_buffer_prime_refs:                 SUCCESS  SUCCESS
>   vmw_surface_copy:
>     test_invalid_copies:                       SUCCESS  SUCCESS
>     test_invalid_copies_3d:                    SUCCESS  SUCCESS
>   vmw_tri:
>     tri:                                       FAIL     FAIL
>     tri-no-sync-coherent:                      FAIL     FAIL
>     tri-2d:                                    SUCCESS  SUCCESS
>   vmw_prime:
>     basic-vgem:                                SUCCESS  SUCCESS
>     tri-map-gem:                               FAIL     FAIL
>     tri-map-dmabuf:                            FAIL     FAIL
>     draw-dumb-buffer:                          FAIL     FAIL
>     buffer-surface-fb-sharing-sync-readback:   FAIL     FAIL
>     buffer-surface-fb-sharing-sync:            FAIL     FAIL
>     buffer-surface-fb-sharing:                 FAIL     FAIL
>
> The same nine subtests failed in both runs. No additional failures
> were observed with the two-patch series applied.
>
> Aldo Ariel Panzardo (2):
>   drm/vmwgfx: return an error when a shared GB surface has no backup
>     buffer
>   drm/vmwgfx: close TOCTOU on guest_memory_bo in surface reference
>     ioctl
>
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> --
> 2.43.0

--000000000000159cda065e9c3595
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Zack, Maaz,<br>
<br>
Following up on the v2 series sent October 7.<br>
<br>
Is there any additional testing or any change that would help move<br>
the review forward? I&#39;m happy to rerun the VMware/IGT tests or<br>
address any remaining concerns.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Wed, 07 Oct 2026 18:20:47 -0300, Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt; Hi Zack,<br>
&gt; <br>
&gt; Thank you for the detailed review. Here is v2 as a two-patch series<br=
>
&gt; addressing all your feedback:<br>
&gt; <br>
&gt;=C2=A0 =C2=A01/2: return an error and drop the surface reference when b=
ackup is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 missing (unchanged from v2 RESEND, included=
 for series base)<br>
&gt;=C2=A0 =C2=A02/2: close the TOCTOU on guest_memory_bo (v2, description =
and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Fixes tag corrected per your review)<br>
&gt; <br>
&gt; Changes in 2/2 since v1:<br>
&gt;=C2=A0 =C2=A0- Description rewritten: the racing writer is a backup swi=
tch via<br>
&gt;=C2=A0 =C2=A0 =C2=A0SVGA_3D_CMD_BIND_GB_SURFACE (vmw_resource_unreserve=
), not eviction<br>
&gt;=C2=A0 =C2=A0- Fixes tag corrected to a97e21923b42<br>
&gt;=C2=A0 =C2=A0- Rebased on top of 1/2 (no longer duplicates ret =3D -EIN=
VAL)<br>
&gt;=C2=A0 =C2=A0- mutex scope kept to the minimum: NULL check, handle crea=
tion,<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer_map_handle and buffer_size reads<br>
&gt; <br>
&gt; <br>
&gt; 1. Validation test for patch 1/2<br>
&gt; ---------------------------------<br>
&gt; <br>
&gt; A test program creates a shareable surface WITHOUT a backup buffer<br>
&gt; (drm_surface_flags=3Dshareable, buffer_handle=3DSVGA3D_INVALID_ID, no<=
br>
&gt; drm_vmw_surface_flag_create_buffer), then calls the surface reference<=
br>
&gt; ioctl via DRM_VMW_GB_SURFACE_REF_EXT.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0UNFIXED module:=C2=A0 ioctl() returns 0 (success) without =
filling the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eply structure =E2=80=94 the kernel handler never sets ret.<br>
&gt;=C2=A0 =C2=A0FIXED module:=C2=A0 =C2=A0 ioctl() returns -1 with errno s=
et to EINVAL. Kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
mesg shows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 [drm:vmw_gb_surface_reference_internal [vmwgfx]]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *ERROR* Shared GB surface is missing a backup buffer.<br>
&gt; <br>
&gt; The test exercises the missing-backup error path, but does not<br>
&gt; independently verify reference cleanup. The cleanup was verified by<br=
>
&gt; source inspection =E2=80=94 see section 2 below.<br>
&gt; <br>
&gt; Test program (test_no_backup.c, requires &lt;drm.h&gt; and the kernel =
UAPI<br>
&gt; vmwgfx_drm.h):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0#include &lt;stdio.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;string.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;fcntl.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;unistd.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;sys/ioctl.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;errno.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;stdint.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;drm.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &quot;vmwgfx_drm.h&quot;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0#define VMW_IOCTL_GB_SURFACE_CREATE_EXT \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_GB_SURFA=
CE_CREATE_EXT, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 union drm_vmw_g=
b_surface_create_ext_arg)<br>
&gt;=C2=A0 =C2=A0#define VMW_IOCTL_GB_SURFACE_REF_EXT \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_GB_SURFA=
CE_REF_EXT, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 union drm_vmw_g=
b_surface_reference_ext_arg)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0int main(void) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd =3D open(&quot;/dev/dri/renderD128&qu=
ot;, O_RDWR);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) { perror(&quot;open&quot;); r=
eturn 77; }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0union drm_vmw_gb_surface_create_ext_arg crea=
te;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;create, 0, sizeof(create));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create.req.base.format =3D 2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create.req.base.mip_levels =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create.req.base.array_size =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create.req.base.drm_surface_flags =3D drm_vm=
w_surface_flag_shareable;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create.req.base.buffer_handle =3D 0xFFFFFFFF=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create.req.base.base_size.width =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create.req.base.base_size.height =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create.req.base.base_size.depth =3D 1;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(fd, VMW_IOCTL_GB_SURFACE_CREATE_EX=
T, &amp;create) &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ printf(&quot;create failed: =
%s\n&quot;, strerror(errno)); return 77; }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (create.rep.buffer_handle !=3D 0xFFFFFFFF=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ printf(&quot;surface has bac=
kup, skip\n&quot;); return 77; }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0union drm_vmw_gb_surface_reference_ext_arg r=
ef;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;ref, 0, sizeof(ref));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ref.req.sid =3D create.rep.handle;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D ioctl(fd, VMW_IOCTL_GB_SURFACE_R=
EF_EXT, &amp;ref);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0 &amp;&amp; errno =3D=3D EINVA=
L)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ printf(&quot;PASS: -EINVAL\n=
&quot;); return 0; }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ printf(&quot;FAIL: success (=
ret=3D0)\n&quot;); return 1; }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;OTHER: errno=3D%d\n&quot;, errn=
o);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Build:=C2=A0 gcc -I/usr/include/libdrm -I$HOME -o test_no_=
backup test_no_backup.c<br>
&gt;=C2=A0 =C2=A0Run as a user with read/write access to the render node:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./test_no_backup<br>
&gt; <br>
&gt; <br>
&gt; 2. Reference cleanup verification (source inspection)<br>
&gt; ------------------------------------------------------<br>
&gt; <br>
&gt; vmw_surface_handle_reference() acquires two refs:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0(a) ttm_base_object_lookup_for_ref() =E2=80=94 kref_get on=
 base-&gt;refcount<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(the &quot;lookup ref&quot;)<br>
&gt;=C2=A0 =C2=A0(b) ttm_ref_object_add() =E2=80=94 acquires a per-file ref=
erence in tfile<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(the &quot;per-file ref&quot;)<br>
&gt; <br>
&gt; On the SUCCESS path (ret =3D=3D 0, falls through to out_bad_resource):=
<br>
&gt;=C2=A0 =C2=A0- ttm_base_object_unref(&amp;base) releases the lookup ref=
 (a).<br>
&gt;=C2=A0 =C2=A0- The per-file ref (b) stays alive; userspace releases it =
later<br>
&gt;=C2=A0 =C2=A0 =C2=A0via DRM_VMW_UNREF_SURFACE =E2=86=92 ttm_ref_object_=
base_unref().<br>
&gt; <br>
&gt; On ERROR paths (ret !=3D 0, goto out_bad_resource):<br>
&gt;=C2=A0 =C2=A0- if (ret) ttm_ref_object_base_unref() undoes the per-file=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0acquisition (b).<br>
&gt;=C2=A0 =C2=A0- ttm_base_object_unref(&amp;base) releases the lookup ref=
 (a).<br>
&gt;=C2=A0 =C2=A0- No GEM handle needs to be released on these error paths<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0(drm_gem_handle_create either was not reached or fa=
iled).<br>
&gt; <br>
&gt; Both paths are balanced.<br>
&gt; <br>
&gt; <br>
&gt; 3. Race analysis (source inspection)<br>
&gt; --------------------------------------<br>
&gt; <br>
&gt; Writers of res-&gt;guest_memory_bo in vmwgfx (at commit 6edd14dd67d7):=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0vmwgfx_resource.c:473=C2=A0 vmw_resource_unreserve(): =3D =
vmw_user_bo_ref(new)<br>
&gt;=C2=A0 =C2=A0vmwgfx_resource.c:483=C2=A0 vmw_resource_unreserve(): =3D =
NULL<br>
&gt;=C2=A0 =C2=A0 =C2=A0Both under cmdbuf_mutex, called from vmw_execbuf_pr=
ocess<br>
&gt;=C2=A0 =C2=A0 =C2=A0(vmwgfx_execbuf.c:4242) and vmw_resource_pin<br>
&gt;=C2=A0 =C2=A0 =C2=A0(vmwgfx_resource.c:1012).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0vmwgfx_resource.c:229=C2=A0 vmw_resource_init(): =3D NULL =
(construction)<br>
&gt;=C2=A0 =C2=A0vmwgfx_resource.c:354=C2=A0 vmw_resource_buf_alloc(): =3D =
gbo (init path)<br>
&gt;=C2=A0 =C2=A0vmwgfx_surface.c:~1618 vmw_gb_surface_define_internal(): v=
ia<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmw_user_bo_lookup (construction, surface not yet r=
egistered)<br>
&gt;=C2=A0 =C2=A0vmwgfx_bo.c:63=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmw_bo_fre=
e(): =3D NULL (destroy)<br>
&gt;=C2=A0 =C2=A0vmwgfx_cotable.c:485/496 vmw_cotable_resize(): cotable-onl=
y<br>
&gt;=C2=A0 =C2=A0vmwgfx_shader.c:185=C2=A0 =C2=A0 vmw_dx_shader_unscrub(): =
shader init<br>
&gt; <br>
&gt; The construction-time writers run before the surface is registered<br>
&gt; in the per-file object table, so no concurrent reference ioctl can<br>
&gt; reach them. vmw_bo_free runs during destroy. vmw_cotable_resize and<br=
>
&gt; vmw_dx_shader_unscrub operate on resource types not reachable via<br>
&gt; DRM_VMW_GB_SURFACE_REF_EXT. vmw_resource_unreserve is the remaining<br=
>
&gt; concurrent writer; both its writes are under cmdbuf_mutex. The patch<b=
r>
&gt; moves the reads of guest_memory_bo inside cmdbuf_mutex, serializing<br=
>
&gt; them against these writes.<br>
&gt; <br>
&gt; The race was not reproduced with a dedicated test. The fix is based on=
<br>
&gt; inspection of the locking protocol.<br>
&gt; <br>
&gt; <br>
&gt; 4. IGT regression test<br>
&gt; -----------------------<br>
&gt; <br>
&gt; Environment:<br>
&gt;=C2=A0 =C2=A0Host: VMware Workstation 26.0.0 build 25388281<br>
&gt;=C2=A0 =C2=A0Guest: Debian 12, kernel 7.3.0-rc4+ (commit 6edd14dd67d7)<=
br>
&gt;=C2=A0 =C2=A0IGT: version 2.6 (commit 5e43e9df3a15, x86_64)<br>
&gt;=C2=A0 =C2=A0Kernel config: CONFIG_KASAN=3Dy (generic, inline),<br>
&gt;=C2=A0 =C2=A0 =C2=A0CONFIG_INIT_STACK_ALL_ZERO=3Dy, CONFIG_DRM_VMWGFX=
=3Dm<br>
&gt;=C2=A0 =C2=A0Module swap: sudo rmmod vmwgfx &amp;&amp; sudo insmod &lt;=
module&gt;.ko<br>
&gt;=C2=A0 =C2=A0Module files on disk:<br>
&gt;=C2=A0 =C2=A0 =C2=A0UNFIXED (vmwgfx-UNFIXED.ko): md5 43a0f8caaf651a274d=
44a3faa51d3929<br>
&gt;=C2=A0 =C2=A0 =C2=A0FIXED (vmwgfx-TOCTOU-FIXED.ko): md5 01c6785d713de95=
7fc92478cb213f0b4<br>
&gt; <br>
&gt; Results (18 SUCCESS, 9 FAIL, identical in both runs):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0vmw_execution_buffer:<br>
&gt;=C2=A0 =C2=A0 =C2=A0mob-create-map:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=
=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer-create:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCES=
S=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0execution-buffer-submit-sync:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0vmw_mob_stress:<br>
&gt;=C2=A0 =C2=A0 =C2=A0max_mob_mem_stress:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL=C2=A0 =C2=A0 =C2=
=A0FAIL<br>
&gt;=C2=A0 =C2=A0vmw_ref_count:<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_transfer_explicit_mob:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_transfer_implicit_mob:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_transfer_fd_dup:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_transfer_two_surfaces:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_transfer_single_surface_multiple_hand=
le:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0mob_repeated_unref:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 SUCCESS<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_repeated_unref:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_alloc_ref_unref:=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_buffer_ref:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 SUCCESS<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_prime_refs:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 SUCCESS<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0surface_buffer_prime_refs:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0vmw_surface_copy:<br>
&gt;=C2=A0 =C2=A0 =C2=A0test_invalid_copies:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUCCESS=C2=A0 SUCCESS<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0test_invalid_copies_3d:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0vmw_tri:<br>
&gt;=C2=A0 =C2=A0 =C2=A0tri:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =C2=A0FAIL<br>
&gt;=C2=A0 =C2=A0 =C2=A0tri-no-sync-coherent:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL=C2=A0 =C2=A0 =C2=A0FA=
IL<br>
&gt;=C2=A0 =C2=A0 =C2=A0tri-2d:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SUCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0vmw_prime:<br>
&gt;=C2=A0 =C2=A0 =C2=A0basic-vgem:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 S=
UCCESS=C2=A0 SUCCESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0tri-map-gem:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FA=
IL=C2=A0 =C2=A0 =C2=A0FAIL<br>
&gt;=C2=A0 =C2=A0 =C2=A0tri-map-dmabuf:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL=C2=A0 =
=C2=A0 =C2=A0FAIL<br>
&gt;=C2=A0 =C2=A0 =C2=A0draw-dumb-buffer:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL=C2=A0 =C2=A0 =
=C2=A0FAIL<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer-surface-fb-sharing-sync-readback:=C2=A0 =C2=
=A0FAIL=C2=A0 =C2=A0 =C2=A0FAIL<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer-surface-fb-sharing-sync:=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 FAIL=C2=A0 =C2=A0 =C2=A0FAIL<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer-surface-fb-sharing:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL=C2=A0 =C2=A0 =C2=A0FAIL<br>
&gt; <br>
&gt; The same nine subtests failed in both runs. No additional failures<br>
&gt; were observed with the two-patch series applied.<br>
&gt; <br>
&gt; Aldo Ariel Panzardo (2):<br>
&gt;=C2=A0 =C2=A0drm/vmwgfx: return an error when a shared GB surface has n=
o backup<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer<br>
&gt;=C2=A0 =C2=A0drm/vmwgfx: close TOCTOU on guest_memory_bo in surface ref=
erence<br>
&gt;=C2=A0 =C2=A0 =C2=A0ioctl<br>
&gt; <br>
&gt;=C2=A0 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 22 ++++++++++++++++---=
---<br>
&gt;=C2=A0 1 file changed, 16 insertions(+), 6 deletions(-)<br>
&gt; --<br>
&gt; 2.43.0

--000000000000159cda065e9c3595--
