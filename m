Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F316BC561E6
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C90F10F0D5;
	Thu,  6 Aug 2026 06:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JDx1guHd";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2646610EF5D
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:59:17 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5aebd7da975so89389e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 09:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785949155; cv=none;
 d=google.com; s=arc-20260327;
 b=ffp5Uk4RJrps6u1RC1UWZQro6zUa5Q2j+2/HprBpEq4rHTBjWPQ344BfSTfJsScl5S
 TcUwCVk/xjCgJO2sdULs6oLE0hgzW/O90MJ8N4M6mhSBWr6P0/tFJ4csAYWldf6/Cs8o
 r00Ut5ltix3HoHlyT6pI2QT9s+sd4B8fap2exSA/Ux4Q412zNv8otmQCHKgQjUOcaK9V
 sTlaCt0aEzJBoXWO2Lg5exZKmua4UdSe5sS+cQ62P0xB5CYdvXoL9LAgojJfRQfdzc+M
 Tp/jybGuF/R8sU4fv8+32p+t13S2/QXn/06AdJ+mR7wJagKL0B5c6j5Yg8cBsfbvGzJm
 ncHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=QtcXnLutkdWRv7vMNoNpvA7E0+iZL04jy3EUvakDvwA=;
 fh=vvt0x6mJWyGLM+Y1SXDWN6ACA8s74WLwmdWXoRpVMnI=;
 b=BfTk9k85Ro26NaJTSnXg5RvxMSJ9fhwPRBsjcHe5c4oZYFtLyk9hyP+EXXDwWi0Okt
 8SbHea8pjHcDNqpwfPvtkGBmn9P1OUisKOhgN3PxzJLs62SQeOIz9ANMGEkUqjgclM2u
 qwTJe6uRxsM2k3EDlh2si12rogwBI3uPKip1Mu1kAMJ5TY8iTwoWddJ/2sRTh4puh+A9
 jaQz8BPguVkl7k8Fi6LaMTXXvgrN9gVHrDbsvyxIVpNCcvnvS0z6m9jyfL8qVUH6C4rR
 gdLrpV2s0F9V2Z0nuU0DlImlL9uxFxTBhucDtyyhXII8MMZS0oyaFMy3ODXmstMKACtU
 Jr9w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785949155; x=1786553955; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QtcXnLutkdWRv7vMNoNpvA7E0+iZL04jy3EUvakDvwA=;
 b=JDx1guHdfbB4QuV8yMOlUSSWDwOZfHKsPzA417LCPvVOQTj63cCewpf65oG7iYZsCT
 v5epcXjYx+BOT3jn3zCQEudhvPRq+ZZesrH5ho98LhXFL3V+7t6HFt6H8mMEvtQOeOK9
 LruCuPWGYtz3SO2drrt7es9MmTIi+s6oxMKcj5ySbEtThbGos+a/oE1HnEps+o8FJUoU
 hoCl+Inzt78NcS4fFYzGssBRSYnH5w6knAUdE+sLRdFkxMAURNo9xPNBk08orQmAZ1KX
 7xHBwlPp3ttGtmBJxutyvUvqXVdQjEHAiSkUhxyHHiH8+hVFE2hx3/cC3K/cGKW+IGHR
 AK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785949155; x=1786553955;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QtcXnLutkdWRv7vMNoNpvA7E0+iZL04jy3EUvakDvwA=;
 b=ph/+0X6ax7Du02eo7Aqsjdv0z+n8N564oSMlwYxRkL+kKmJQzf9ltR7VvnjwsuzuUD
 AKHUDhLckmyfcuT+SiweIHwUp4sL18FZAik6xxuRNx7493cyfwOJtE41kcSR2rp+3q3Z
 DiMvjrqDvPmwhmKuNHG7UOa7w59KCSOclzDdjIBZDRVvCdM5VqIEcrQKRREkaIQVYrlc
 /HcxETPjF4b6j4EtMkhaMV/jiedVsDlmmB1t9rcx4iB5NOw38HNlvLQkEOwSCpS0RekL
 +i516uVKxIZyod+7HnIhWOMv7jbgy6iOwT8WbVB+S2Mt0RTqk4L7/8VkbO0AIvveYSCl
 a2SA==
X-Gm-Message-State: AOJu0YzW7ivXT4er9DiTRc8kl8T7bU0oLvZyypntdDeefW8yLvlaT6nz
 un532790zBiANnBVkVZwcjnkT93OGGyrD3AcwHaL7/Cg1Q2fpXybpWwCvwkbFm70aJn6iLdKtA3
 sP8Wm1FkMYcQ27Lp+CcHRZTiXtOQhvwFaS0bxT3o=
X-Gm-Gg: AR+sD121eOX99g98TjpipCGroR/Z5XJmm1Rh1qlHFXEzj/tWWjyylnLHH0enomwGIbq
 29pHw0fy/p6wx/YxdRVUl2tKZCAh/P+sSuyEfEHSvyORAwZbACVXRAmuhcIdDyq4t+JxsDQKT6S
 eU6wJ6iIQTLk2N8XplX3gRLyMR2uDZzYmkF5nc2rLFt3gmIdkHqWWOPIKNTDvv3c7DUFr56eonh
 MZl7QgjOftgXTqJedXm/EsAjmJZuewJ1nnlmBLsP/oI3qJl8qzY7X8k8cRNxEnCJaNuoTIv2neA
 XFcxET5keueSWuQpVSE+4K/rmcDPErOs5SoHN5wMqQ==
X-Received: by 2002:a05:6512:3d01:b0:5b1:5b9e:8de7 with SMTP id
 2adb3069b0e04-5b2f4cc3b8amr1338499e87.2.1785949154671; Wed, 05 Aug 2026
 09:59:14 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0JTQuNC80LAg0JTRjNGP0YfQutC+0LI=?= <das.ogi4i@gmail.com>
Date: Wed, 5 Aug 2026 19:59:02 +0300
X-Gm-Features: AUfX_my_V5qpv6affynR8HxULt1g0n8nik1FYcNtCGOK76e-bFr0f3CZSF0lSFw
Message-ID: <CADZLCw7o5wO=+Zv2a7W9uc9AuiQDM-hEqki95eNfk8pv+L=_=A@mail.gmail.com>
Subject: [BUG] drm/vmwgfx: vmw_cmdbuf_alloc leaks ~103 MiB/day of
 unreclaimable slab via the fbdev damage worker
To: dri-devel@lists.freedesktop.org
Cc: zack.rusin@broadcom.com, ian.forbes@broadcom.com, 
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
 tzimmermann@suse.de
Content-Type: multipart/alternative; boundary="000000000000f3803706584fb0f0"
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:52:41 +0000
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

--000000000000f3803706584fb0f0
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a reproducible, quantified kernel memory leak in vmwgfx on a headless
VMware guest. It is attributed to a specific call site with slab_debug, and
I
have a clean causal test that stops it. I could not find this reported
anywhere
- I searched the dri-devel archives, the mainline and 6.12.y git logs, and
the
distro trackers.

Summary
=======

On a headless VMware guest with the text console bound to the vmwgfx
framebuffer, the fbdev-emulation damage worker issues a full atomic commit
for
every console damage event, and vmwgfx leaks a command buffer on each one.
The
result is unreclaimable kernel slab growing linearly at ~103 MiB/day, never
reclaimed under memory pressure, released only by reboot.

Environment
===========

Kernel: 6.12.100+deb13-amd64 (Debian 13 stock, tracks 6.12.y)
Guest: VMware Virtual Platform, BIOS 6.00; vmwgfx drives the virtual display
Console: headless, administered over SSH; a single agetty on the console
fb0: vmwgfxdrmfb
vtcon0: "(M) frame buffer device", bind=1
Config: CONFIG_HZ=250, CONFIG_SLUB_DEBUG=y, CONFIG_STACKDEPOT=y
(CONFIG_DEBUG_KMEMLEAK is not set in Debian's kernel)

i915 is also loaded on this host (a passed-through GPU used for video
transcoding) but is unrelated - the console framebuffer is vmwgfx.

Symptom
=======

SUnreclaim grows linearly at ~103 MiB/day and is never reclaimed under
pressure.
The growth is confined to the plain kmalloc-256 cache - notably *not*
kmalloc-cg-256, so it is plain GFP_KERNEL from an in-kernel allocator rather
than anything cgroup-accounted.

Attribution
===========

Booted with slab_debug=U,kmalloc-256, then read
/sys/kernel/debug/slab/kmalloc-256/alloc_traces, which ranks by live object
count:

41025 vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx] waste=328200/8
age=254700/1301825/2351179 pid=9-208926 cpus=0-5
vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx]
vmw_cmdbuf_reserve+0x142/0x170 [vmwgfx]
vmw_cmd_ctx_reserve+0x24/0x60 [vmwgfx]
vmw_stdu_bind_st+0x6b/0x100 [vmwgfx]
vmw_stdu_primary_plane_atomic_update+0xa8/0x1d0 [vmwgfx]
drm_atomic_helper_commit_planes+0x112/0x320 [drm_kms_helper]
drm_atomic_helper_commit_tail+0x48/0x90 [drm_kms_helper]
vmw_atomic_commit_tail+0x1b/0x80 [vmwgfx]
commit_tail+0x91/0x130 [drm_kms_helper]
drm_atomic_helper_commit+0x11a/0x140 [drm_kms_helper]
drm_atomic_commit+0xa9/0xe0 [drm]
drm_atomic_helper_dirtyfb+0x1c6/0x2a0 [drm_kms_helper]
drm_fbdev_ttm_helper_fb_dirty+0x216/0x310 [drm_ttm_helper]
drm_fb_helper_damage_work+0x94/0x170 [drm_kms_helper]
process_one_work+0x174/0x330
worker_thread+0x191/0x2f0

The next-largest entry in that cache held 1056 objects - this one is ~30x
everything else combined.

Quantitative confirmation
=========================

With CONFIG_HZ=250, from the age=min/avg/max field above:

- max age 2,351,179 jiffies = 9405 s = the full uptime at time of reading
- avg age is almost exactly half of max, which is the signature of uniform
allocation with zero frees
- 41,025 objects over the 8386 s during which allocation was active
= 4.89 objects/sec = 4.30 MiB/h = ~103 MiB/day

That matches the independently measured SUnreclaim growth rate to within
noise.

Causal test
===========

Unbinding the text console from the framebuffer stops it instantly:

# echo 0 > /sys/class/vtconsole/vtcon0/bind

After that, the minimum object age jumped from 26 jiffies to 254,700 and
kept
climbing - i.e. no new allocations at all. SUnreclaim also dropped ~93 MiB
immediately as the fbdev shadow buffer was released, and has been flat-to-
falling since.

Two things I checked so you don't have to
=========================================

This is not a recent regression. drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c has
had
no functional change between v6.12 and current mainline - only the command
buffer ID addition (922f9de) and the treewide kmalloc -> kmalloc_obj
conversions. vmwgfx_stdu.c is similarly untouched in the relevant paths, and
nothing in the 6.12.y stable series touches cmdbuf, damage or dirtyfb
handling.
So this looks long-standing rather than newly introduced.

It is also not caused by the fbdev-ttm conversion, which is the obvious
suspect
given the stack. drm_fbdev_ttm was a pure rename of drm_fbdev_generic
(aae4682e5d66, v6.10), and vmwgfx has used the generic DRM fbdev emulation
since
v6.2 (df42523c12f8, which deleted vmwgfx_fb.c). What did change at v6.2 is
that
console damage now goes through a full atomic commit, which the old
vmwgfx_fb.c did not do - but the leak itself is on the vmwgfx side.

Possibly related
================

There is an open, unresolved report of a different vmwgfx leak in the same
atomic-commit path - Yuma Kakei, 12 Mar 2026, "[BUG] vmwgfx: Severe Slab
memory
leak (radix_tree_node) with Wayland Atomic KMS" (kernels 6.17 / 7.0-rc3,
KWin
Wayland with Atomic KMS, stops with KWIN_DRM_NO_AMS=1). Ian Forbes proposed
a
patch; the reporter confirmed on 15 Mar 2026 that it did not fix it.

I do *not* claim these are the same bug - different slab caches, different
trigger, different kernels. But both are vmwgfx leaking on every atomic
commit
and stopping dead when the atomic path stops, so they may share a root
cause.

Workarounds
===========

- echo 0 > /sys/class/vtconsole/vtcon0/bind
runtime, reversible, stops it immediately

- drm_kms_helper.fbdev_emulation=0 on the kernel command line
cleaner for a headless host; disables fbdev emulation outright so no
damage worker exists. Must be set at boot.

- modprobe.blacklist=vmwgfx
heavy-handed; loses all console output

All three cost the virtual console, which is fine headless but is not a
general
fix.

Happy to test patches, run instrumented kernels, or provide further data -
the
system reproduces this continuously and I can rebind the console at will to
toggle it on and off.

Thanks, Dmitry

--000000000000f3803706584fb0f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div dir=3D"auto">Hi,<br><br>I have a reproducible, =
quantified kernel memory leak in vmwgfx on a headless<br>VMware guest. It i=
s attributed to a specific call site with slab_debug, and I<br>have a clean=
 causal test that stops it. I could not find this reported anywhere<br>- I =
searched the dri-devel archives, the mainline and 6.12.y git logs, and the<=
br>distro trackers.<br><br>Summary<br>=3D=3D=3D=3D=3D=3D=3D<br><br>On a hea=
dless VMware guest with the text console bound to the vmwgfx<br>framebuffer=
, the fbdev-emulation damage worker issues a full atomic commit for<br>ever=
y console damage event, and vmwgfx leaks a command buffer on each one. The<=
br>result is unreclaimable kernel slab growing linearly at ~103 MiB/day, ne=
ver<br>reclaimed under memory pressure, released only by reboot.<br><br>Env=
ironment<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>  Kernel:   6.12.100+d=
eb13-amd64 (Debian 13 stock, tracks 6.12.y)<br>  Guest:    VMware Virtual P=
latform, BIOS 6.00; vmwgfx drives the virtual display<br>  Console:  headle=
ss, administered over SSH; a single agetty on the console<br>  fb0:      vm=
wgfxdrmfb<br>  vtcon0:   &quot;(M) frame buffer device&quot;, bind=3D1<br> =
 Config:   CONFIG_HZ=3D250, CONFIG_SLUB_DEBUG=3Dy, CONFIG_STACKDEPOT=3Dy<br=
>            (CONFIG_DEBUG_KMEMLEAK is not set in Debian&#39;s kernel)<br><=
br>i915 is also loaded on this host (a passed-through GPU used for video<br=
>transcoding) but is unrelated - the console framebuffer is vmwgfx.<br><br>=
Symptom<br>=3D=3D=3D=3D=3D=3D=3D<br><br>SUnreclaim grows linearly at ~103 M=
iB/day and is never reclaimed under pressure.<br>The growth is confined to =
the plain kmalloc-256 cache - notably *not*<br>kmalloc-cg-256, so it is pla=
in GFP_KERNEL from an in-kernel allocator rather<br>than anything cgroup-ac=
counted.<br><br>Attribution<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>Boo=
ted with slab_debug=3DU,kmalloc-256, then read<br>/sys/kernel/debug/slab/km=
alloc-256/alloc_traces, which ranks by live object<br>count:<br><br>41025 v=
mw_cmdbuf_alloc+0x40/0x200 [vmwgfx] waste=3D328200/8 age=3D254700/1301825/2=
351179 pid=3D9-208926 cpus=3D0-5<br>        vmw_cmdbuf_alloc+0x40/0x200 [vm=
wgfx]<br>        vmw_cmdbuf_reserve+0x142/0x170 [vmwgfx]<br>        vmw_cmd=
_ctx_reserve+0x24/0x60 [vmwgfx]<br>        vmw_stdu_bind_st+0x6b/0x100 [vmw=
gfx]<br>        vmw_stdu_primary_plane_atomic_update+0xa8/0x1d0 [vmwgfx]<br=
>        drm_atomic_helper_commit_planes+0x112/0x320 [drm_kms_helper]<br>  =
      drm_atomic_helper_commit_tail+0x48/0x90 [drm_kms_helper]<br>        v=
mw_atomic_commit_tail+0x1b/0x80 [vmwgfx]<br>        commit_tail+0x91/0x130 =
[drm_kms_helper]<br>        drm_atomic_helper_commit+0x11a/0x140 [drm_kms_h=
elper]<br>        drm_atomic_commit+0xa9/0xe0 [drm]<br>        drm_atomic_h=
elper_dirtyfb+0x1c6/0x2a0 [drm_kms_helper]<br>        drm_fbdev_ttm_helper_=
fb_dirty+0x216/0x310 [drm_ttm_helper]<br>        drm_fb_helper_damage_work+=
0x94/0x170 [drm_kms_helper]<br>        process_one_work+0x174/0x330<br>    =
    worker_thread+0x191/0x2f0<br><br>The next-largest entry in that cache h=
eld 1056 objects - this one is ~30x<br>everything else combined.<br><br>Qua=
ntitative confirmation<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>With CONFIG_HZ=3D250, from the age=3Dmin=
/avg/max field above:<br><br>  - max age 2,351,179 jiffies =3D 9405 s =3D t=
he full uptime at time of reading<br>  - avg age is almost exactly half of =
max, which is the signature of uniform<br>    allocation with zero frees<br=
>  - 41,025 objects over the 8386 s during which allocation was active<br> =
   =3D 4.89 objects/sec =3D 4.30 MiB/h =3D ~103 MiB/day<br><br>That matches=
 the independently measured SUnreclaim growth rate to within noise.<br><br>=
Causal test<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>Unbinding the text =
console from the framebuffer stops it instantly:<br><br>  # echo 0 &gt; /sy=
s/class/vtconsole/vtcon0/bind<br><br>After that, the minimum object age jum=
ped from 26 jiffies to 254,700 and kept<br>climbing - i.e. no new allocatio=
ns at all. SUnreclaim also dropped ~93 MiB<br>immediately as the fbdev shad=
ow buffer was released, and has been flat-to-<br>falling since.<br><br>Two =
things I checked so you don&#39;t have to<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br><br>This is not a recent regression. drivers/gpu/drm/=
vmwgfx/vmwgfx_cmdbuf.c has had<br>no functional change between v6.12 and cu=
rrent mainline - only the command<br>buffer ID addition (922f9de) and the t=
reewide kmalloc -&gt; kmalloc_obj<br>conversions. vmwgfx_stdu.c is similarl=
y untouched in the relevant paths, and<br>nothing in the 6.12.y stable seri=
es touches cmdbuf, damage or dirtyfb handling.<br>So this looks long-standi=
ng rather than newly introduced.<br><br>It is also not caused by the fbdev-=
ttm conversion, which is the obvious suspect<br>given the stack. drm_fbdev_=
ttm was a pure rename of drm_fbdev_generic<br>(aae4682e5d66, v6.10), and vm=
wgfx has used the generic DRM fbdev emulation since<br>v6.2 (df42523c12f8, =
which deleted vmwgfx_fb.c). What did change at v6.2 is that<br>console dama=
ge now goes through a full atomic commit, which the old<br>vmwgfx_fb.c did =
not do - but the leak itself is on the vmwgfx side.<br><br>Possibly related=
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>There is an ope=
n, unresolved report of a different vmwgfx leak in the same<br>atomic-commi=
t path - Yuma Kakei, 12 Mar 2026, &quot;[BUG] vmwgfx: Severe Slab memory<br=
>leak (radix_tree_node) with Wayland Atomic KMS&quot; (kernels 6.17 / 7.0-r=
c3, KWin<br>Wayland with Atomic KMS, stops with KWIN_DRM_NO_AMS=3D1). Ian F=
orbes proposed a<br>patch; the reporter confirmed on 15 Mar 2026 that it di=
d not fix it.<br><br>I do *not* claim these are the same bug - different sl=
ab caches, different<br>trigger, different kernels. But both are vmwgfx lea=
king on every atomic commit<br>and stopping dead when the atomic path stops=
, so they may share a root cause.<br><br>Workarounds<br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br><br>  - echo 0 &gt; /sys/class/vtconsole/vtcon0/bind<br>=
    runtime, reversible, stops it immediately<br><br>  - drm_kms_helper.fbd=
ev_emulation=3D0 on the kernel command line<br>    cleaner for a headless h=
ost; disables fbdev emulation outright so no<br>    damage worker exists. M=
ust be set at boot.<br><br>  - modprobe.blacklist=3Dvmwgfx<br>    heavy-han=
ded; loses all console output<br><br>All three cost the virtual console, wh=
ich is fine headless but is not a general<br>fix.<br><br>Happy to test patc=
hes, run instrumented kernels, or provide further data - the<br>system repr=
oduces this continuously and I can rebind the console at will to<br>toggle =
it on and off.<br><br>Thanks, Dmitry<br></div></div></div>

--000000000000f3803706584fb0f0--
