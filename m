Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E16C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B0010F0D8;
	Thu,  6 Aug 2026 06:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BMHf1KxQ";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFEA210E246
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 17:35:15 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5aeb72b0af1so115914e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 10:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785951314; cv=none;
 d=google.com; s=arc-20260327;
 b=cPfB5fl94xvY/+amd3n1XEz9/Dcu2PH1ctpWyBbtl/ovizs1GW95Wwz/24C2xHln7C
 gH0HDa+0E5F1Yeymi8PAg8lvXU27uw7TVFEqqHHHFTQ9ecHMLui1fbidD/FAjWUndDkd
 yV8IBZOhObWILwFlgxrrLGAnt5p8xk129DDBpcj9kawnQam+32aK0Ep9ljkHDdl2H3dG
 n+zb2NKFQz79uqufdBYMK5hrtWWzD08BywiKd+QNqNOPjLEGj5Gnfj7jZDDvLwtPBOyc
 tInxNMsQ195JROj+tnTXVb6JdWFeesLoPujCuX6j+cbeLY6qJkwirdmns7ec8Gb8Kv5b
 a5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=b9NKKji8Q02kNidmn/BaWEnO/LXYzARggS50UF3fDhw=;
 fh=vvt0x6mJWyGLM+Y1SXDWN6ACA8s74WLwmdWXoRpVMnI=;
 b=UOzXHgupVzR1hHh547kXsl+wZgh+BfxUNfuenfR3xbabbmDVcIeqBXGeFFZr4JhW+a
 1lu1asdSzlK42bUAxX3ogYRNamSI/YJp9FO/Uzv9f6lN/eS0xa5pvsGyXe8O2RhLVxhP
 wSj/1gOer9wDCp8R1yTSTh0NX3amAgv/AolOe9TqRGh9zfQcWHZDYKmmpA+bHIH9Gvpz
 DS2956jhI2sKS1OclnrenaT9RXlp+iqMK4liyVaKUKwM59jgF2SniEtCJ1M1hcbmK3gh
 jHNL4ZD/KzV/APvv4Oa44J4ZqKyB6sYF4hkvMqFtE4WkpRtGzo9GdxaeAQnMvuvKAeON
 7hTA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785951314; x=1786556114; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b9NKKji8Q02kNidmn/BaWEnO/LXYzARggS50UF3fDhw=;
 b=BMHf1KxQ+s/xuyeKC/EddNmlZp6wK8IibSs9Om3BD2yWsayDHOgbQ12FxT0Btz5jlw
 6HbkVNPO0qB/0LDOGO0+CKYPJcEI+3NUbDIVeQ+cdUFlRa5nduMaM5qtSMEYyuseA/2U
 zj64Yb7gWDnIPz8Vv5WQeF3CxdewZSp6kLdE43g0CpCzZ3PL3F5z0yRFshwJROZjlNQo
 IgYyorOGK/WNp2syG6fUFhemP3/aKHYhy5AO4n70jICliuVORqyrWk4aJZ+UK9FhINBR
 DSORvzUlQc8S5VqAqQTqQA/jJ4sh2dt+W0D6UaDZbItvaJdGsE3Sbgz4h8m7FPVIezKk
 8bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785951314; x=1786556114;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b9NKKji8Q02kNidmn/BaWEnO/LXYzARggS50UF3fDhw=;
 b=U/e6QZKPglZApELixskE49InfKHZ4covunmLgMIQruIhG4S4jnGwKGpuhrMgdKjRb9
 BNh1V4hOWEhrk0epe4f4/IovIG7AuxASnTQPy6S2R80uG8ZBRBaddZTddVu2iohDEYTg
 WyVvuzdmTv1z3se1tyoW3R/yT9JFUVAXgULhIjdfCXDZBStbEBdbEV/VvDcPDWRM7uxU
 2iqqZJniMZxccBpQySDitb15cy+EeftWZOE+dQ0LAsovoulnxI11s90CoSQhiU5J+UVe
 h91dz00qFXXJKLXZb99MAQiFXH199peZB1/UabQzkeaALf1+mQQSoHvbG6m4RoYRYyhb
 Ftlw==
X-Gm-Message-State: AOJu0YxwzVhR+OqIjX7/VH9lRyNH9gKoKdVFvj7Fxe1XL9bDcH0sPa+r
 XgOnspCKesg3byxxwwAU5CjJCCGhlddfjINTHzhIyyO6N00CDWfhwPP7Hvy5eBpBAxaxBYnwAz/
 ImIJkJ8b3ZB7Xub7w25o/WACz4xs5f+lHKsVFrMI=
X-Gm-Gg: AR+sD10K00pKjkWPrCM8c943UJLe1c9bDL2V81YEa0YwaugaTC95hf91uvhWCJ5P54J
 g7W+K8oCqTkBAv49VeRzBxrtAlkqDlDD3rKMPI36L7S5W97s45kAaq3ONTeiV+UG+MomPgRDJOv
 BewDSmwK76YWSm1weLukeiys5TaxwO7t27djrQQEFxTQ3EYTR3P0oQDthM2QhRC01SqwLP8tz9w
 VIU8BMIM990FXqzYoFJEn8co7a6oQxWQou6SuSOPbTENhPEYYFCzJprECGko2Rtiqy9wf5CUKPd
 /VDh96rdEKYQ4qBXNAtixJvTR1G3P27eub7em5jTKYlm
X-Received: by 2002:a05:6512:2399:b0:5b1:5486:ea23 with SMTP id
 2adb3069b0e04-5b2f4cd22cbmr1234150e87.4.1785951313838; Wed, 05 Aug 2026
 10:35:13 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0JTQuNC80LAg0JTRjNGP0YfQutC+0LI=?= <das.ogi4i@gmail.com>
Date: Wed, 5 Aug 2026 20:35:02 +0300
X-Gm-Features: AUfX_mx9NKRHDlv3K-Elh3UeWrcW8SaPf63Q5eccFpiPdgL7qq4_ki63B-ZCOQY
Message-ID: <CADZLCw7S=G-NBqxdRikotQVDxyZ4omcxvnmQaXszC1ORQpgTLA@mail.gmail.com>
Subject: [BUG] drm/vmwgfx: vmw_cmdbuf_alloc leaks ~103 MiB/day via fbdev
 damage worker
To: dri-devel@lists.freedesktop.org
Cc: zack.rusin@broadcom.com, ian.forbes@broadcom.com, 
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
 tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I have a reproducible, quantified kernel memory leak in vmwgfx on a
headless VMware guest. It is attributed to a specific call site with
slab_debug, and I have a clean causal test that stops it. I could not
find this reported anywhere - I searched the dri-devel archives, the
mainline and 6.12.y git logs, and the distro trackers.

Summary
=======

On a headless VMware guest with the text console bound to the vmwgfx
framebuffer, the fbdev-emulation damage worker issues a full atomic
commit for every console damage event, and vmwgfx leaks a command
buffer on each one. The result is unreclaimable kernel slab growing
linearly at ~103 MiB/day, never reclaimed under memory pressure,
released only by reboot.

Environment
===========

Kernel: 6.12.100+deb13-amd64 (Debian 13 stock, tracks 6.12.y)
Guest: VMware Virtual Platform, BIOS 6.00
Console: headless, over SSH; a single agetty on the console
fb0: vmwgfxdrmfb
vtcon0: "(M) frame buffer device", bind=1
Config: CONFIG_HZ=250, CONFIG_SLUB_DEBUG=y, CONFIG_STACKDEPOT=y
(CONFIG_DEBUG_KMEMLEAK is not set in Debian's kernel)

i915 is also loaded on this host (a passed-through GPU used for video
transcoding) but is unrelated - the console framebuffer is vmwgfx.

Symptom
=======

SUnreclaim grows linearly at ~103 MiB/day and is never reclaimed under
pressure. The growth is confined to the plain kmalloc-256 cache -
notably *not* kmalloc-cg-256, so it is plain GFP_KERNEL from an
in-kernel allocator rather than anything cgroup-accounted.

Attribution
===========

Booted with slab_debug=U,kmalloc-256, then read
/sys/kernel/debug/slab/kmalloc-256/alloc_traces, which ranks by live
object count. Top entry (header line wrapped by hand for width):

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

The next-largest entry in that cache held 1056 objects - this one is
~30x everything else combined.

Quantitative confirmation
=========================

With CONFIG_HZ=250, from the age=min/avg/max field above:

- max age 2,351,179 jiffies = 9405 s = full uptime at time of read
- avg age is almost exactly half of max, which is the signature of
uniform allocation with zero frees
- 41,025 objects over the 8386 s in which allocation was active
= 4.89 objects/sec = 4.30 MiB/h = ~103 MiB/day

That matches the independently measured SUnreclaim growth to within
noise.

Causal test
===========

Unbinding the text console from the framebuffer stops it instantly:

# echo 0 > /sys/class/vtconsole/vtcon0/bind

After that the minimum object age jumped from 26 jiffies to 254,700
and kept climbing - i.e. no new allocations at all. SUnreclaim also
dropped ~93 MiB immediately as the fbdev shadow buffer was released,
and has fallen steadily since.

Two things I checked so you don't have to
=========================================

This is not a recent regression. vmwgfx_cmdbuf.c has had no functional
change between v6.12 and current mainline - only the command buffer ID
addition (922f9de) and the treewide kmalloc -> kmalloc_obj conversions.
vmwgfx_stdu.c is similarly untouched in the relevant paths, and nothing
in the 6.12.y stable series touches cmdbuf, damage or dirtyfb handling.
So this looks long-standing rather than newly introduced.

It is also not caused by the fbdev-ttm conversion, which is the obvious
suspect given the stack. drm_fbdev_ttm was a pure rename of
drm_fbdev_generic (aae4682e5d66, v6.10), and vmwgfx has used the
generic DRM fbdev emulation since v6.2 (df42523c12f8, which deleted
vmwgfx_fb.c). What did change at v6.2 is that console damage now goes
through a full atomic commit, which the old vmwgfx_fb.c did not do -
but the leak itself is on the vmwgfx side.

Possibly related
================

There is an open, unresolved report of a different vmwgfx leak in the
same atomic-commit path - Yuma Kakei, 12 Mar 2026, "[BUG] vmwgfx:
Severe Slab memory leak (radix_tree_node) with Wayland Atomic KMS"
(kernels 6.17 / 7.0-rc3, KWin Wayland with Atomic KMS, stops with
KWIN_DRM_NO_AMS=1). Ian Forbes proposed a patch; the reporter confirmed
on 15 Mar 2026 that it did not fix it.

I do *not* claim these are the same bug - different slab caches,
different trigger, different kernels. But both are vmwgfx leaking on
every atomic commit and stopping dead when the atomic path stops, so
they may share a root cause.

Workarounds
===========

- echo 0 > /sys/class/vtconsole/vtcon0/bind
runtime, reversible, stops it immediately

- drm_kms_helper.fbdev_emulation=0 on the kernel command line
cleaner for a headless host; disables fbdev emulation outright so
no damage worker exists. Must be set at boot.

- modprobe.blacklist=vmwgfx
heavy-handed; loses all console output

All three cost the virtual console, which is fine headless but is not
a general fix.

Happy to test patches, run instrumented kernels, or provide further
data - the system reproduces this continuously and I can rebind the
console at will to toggle it on and off.

Thanks,
