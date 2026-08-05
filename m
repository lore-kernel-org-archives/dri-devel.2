Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B15C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEC810EFAF;
	Wed,  5 Aug 2026 19:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="boDI8uG1";
	dkim-atps=neutral
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9C010EFAF
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 19:36:54 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso996071a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 12:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785958614; x=1786563414;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IyCSw+Jrv8gz//RtbJi/lVoBSZYgAxK57aUaVRTnQxY=;
 b=QMfloaMX0qizZAN1vjWAgbpL9FrzE0PTeKz6XQQ57+rjHGRYtn3ZdDz82kY2GHcM0j
 ntu7A4PcmoX2YNMLBJHDocVGcZR/q5Sj97SEIoKV8ExW+xkPe/vS7xVyAHjV41vLB2kX
 hwZxdcYY+iGr3Y7z3z9msye4KPdK/D7aextLwD69XWY70LmzdXkO+n+4H95tvFXJvVgR
 7r9vE+AmICJaRmYYXZcFtJAwiKHSisLz1OrcJ47alQHTOIcc4Sdefk0UknBaM9TfoWc/
 cZPoL8kirJKril86/hLioqRbMCbt3/DSkEUAZ2xtt8GDbSWtCiK/b5eTn9wYKA3cJxJc
 ZLEg==
X-Gm-Message-State: AOJu0YzHOZoV7OsOIJMJsni7nFQjc2zoerrqam7JCDzmvYsaFMesR7cR
 HxPZEB/oa2hOHoTmCgxwsVApI5EYNHlsZNGNF4GJKnEpjZPURddoPdH1YyMKz4pASp/MZ+trFf9
 53NfZb+A3IDBS7Bvu2noyVqdIZC5E+p79gmIADT5Mtq9Aw8T5OGWCI1sVnUOaDESerE7ypRQ6Ac
 +uruRy3vB3P5DDhavQDTvUZaGkYFJEwc3EpYnxqpcWCqRHoY+TPimn/5gHAhTJCSTWlox5aTOiK
 28YNkK2xT0tyPVgSY3o
X-Gm-Gg: AR+sD11IyJXLvkR1SWSeJQlg06Y69TLUoN/pirdT8EqWKR5h6BJ/e2RJA/jl0EtfGZg
 WviDaX8A5dIgXn6edRNwA42Fd4KhflIMCYWpfKDAC0+9M+yJ46wASzTJn6Xp5PT6KuF8MWACag7
 u5Bcz5Vk7ScSqixGsmh9TObAEskaee2esXRKQw35hIsvQnfeUgq+5j4YhxkmQCGoINld+ID6PxB
 cxiQnmW5Az9YkWsyZceVgaUApp8jMj5YSXvC3aX2CH7liLkvOIAg14DQxZsU3tK3sdnkbLCt0lp
 T1P796WVmZfCziuSWAalVZnxyrVqzJDSkmRmVdZ6udzqdXin/6jRj7eJFQkk2qh8zW/rt58qaEX
 33r4NbYLN9XLFAPstgT3aagqfC2tndXVbLFoihKRDAFsf/p8ZgtxgXDF1T/5BA7RZ/scBBkSeYR
 wqb+VOqe2z2i9GmZX1I0ZqKzsqD5vr0C/v
X-Received: by 2002:a17:90b:5823:b0:38e:485c:ebd3 with SMTP id
 98e67ed59e1d1-3903c5b727cmr10397387a91.15.1785958614264; 
 Wed, 05 Aug 2026 12:36:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39085e1bcafsm33119a91.6.2026.08.05.12.36.53
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Aug 2026 12:36:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aeb55ce6adso710139e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1785958612; x=1786563412;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IyCSw+Jrv8gz//RtbJi/lVoBSZYgAxK57aUaVRTnQxY=;
 b=boDI8uG1v1gqy0J7RkN32hYsMPH+LuGrzBwTexTDaBbVoe4Hnr1A9Iid4gWMzEippS
 XNC6P3wZT+5TAn8/dKdx+vIL8sKWo7R0TDbh7Trs/CHV/GNA50TwtPQRWtCb3H3kYlwk
 Pf6wzPnViCJVoJh1AvrT9WaR/izw+KDWCJNdI=
X-Received: by 2002:a05:6512:2342:b0:5b0:1760:fabe with SMTP id
 2adb3069b0e04-5b2f4b8bfe8mr1195448e87.15.1785958612032; 
 Wed, 05 Aug 2026 12:36:52 -0700 (PDT)
X-Received: by 2002:a05:6512:2342:b0:5b0:1760:fabe with SMTP id
 2adb3069b0e04-5b2f4b8bfe8mr1195445e87.15.1785958611512; Wed, 05 Aug 2026
 12:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <CADZLCw7o5wO=+Zv2a7W9uc9AuiQDM-hEqki95eNfk8pv+L=_=A@mail.gmail.com>
In-Reply-To: <CADZLCw7o5wO=+Zv2a7W9uc9AuiQDM-hEqki95eNfk8pv+L=_=A@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 5 Aug 2026 15:36:38 -0400
X-Gm-Features: AUfX_mwsHaRlHHJ-pprlCHyBqBdCA76fUvHBpEWp3XrEkikR-VpdE1mPsA6NDOE
Message-ID: <CABQX2QNHpUbxT=GdHedVq1+Z0Qp82hYC1saHuHuWNX-0VvoRYw@mail.gmail.com>
Subject: Re: [BUG] drm/vmwgfx: vmw_cmdbuf_alloc leaks ~103 MiB/day of
 unreclaimable slab via the fbdev damage worker
To: =?UTF-8?B?0JTQuNC80LAg0JTRjNGP0YfQutC+0LI=?= <das.ogi4i@gmail.com>
Cc: dri-devel@lists.freedesktop.org, ian.forbes@broadcom.com, 
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
 tzimmermann@suse.de
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000add31b065851e424"
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

--000000000000add31b065851e424
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 12:59=E2=80=AFPM =D0=94=D0=B8=D0=BC=D0=B0 =D0=94=D1=
=8C=D1=8F=D1=87=D0=BA=D0=BE=D0=B2 <das.ogi4i@gmail.com> wrote:
>
> Hi,
>
> I have a reproducible, quantified kernel memory leak in vmwgfx on a headl=
ess
> VMware guest. It is attributed to a specific call site with slab_debug, a=
nd I
> have a clean causal test that stops it. I could not find this reported an=
ywhere
> - I searched the dri-devel archives, the mainline and 6.12.y git logs, an=
d the
> distro trackers.
>
> Summary
> =3D=3D=3D=3D=3D=3D=3D
>
> On a headless VMware guest with the text console bound to the vmwgfx
> framebuffer, the fbdev-emulation damage worker issues a full atomic commi=
t for
> every console damage event, and vmwgfx leaks a command buffer on each one=
. The
> result is unreclaimable kernel slab growing linearly at ~103 MiB/day, nev=
er
> reclaimed under memory pressure, released only by reboot.
>
> Environment
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Kernel: 6.12.100+deb13-amd64 (Debian 13 stock, tracks 6.12.y)
> Guest: VMware Virtual Platform, BIOS 6.00; vmwgfx drives the virtual disp=
lay
> Console: headless, administered over SSH; a single agetty on the console
> fb0: vmwgfxdrmfb
> vtcon0: "(M) frame buffer device", bind=3D1
> Config: CONFIG_HZ=3D250, CONFIG_SLUB_DEBUG=3Dy, CONFIG_STACKDEPOT=3Dy
> (CONFIG_DEBUG_KMEMLEAK is not set in Debian's kernel)
>
> i915 is also loaded on this host (a passed-through GPU used for video
> transcoding) but is unrelated - the console framebuffer is vmwgfx.
>
> Symptom
> =3D=3D=3D=3D=3D=3D=3D
>
> SUnreclaim grows linearly at ~103 MiB/day and is never reclaimed under pr=
essure.
> The growth is confined to the plain kmalloc-256 cache - notably *not*
> kmalloc-cg-256, so it is plain GFP_KERNEL from an in-kernel allocator rat=
her
> than anything cgroup-accounted.
>
> Attribution
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Booted with slab_debug=3DU,kmalloc-256, then read
> /sys/kernel/debug/slab/kmalloc-256/alloc_traces, which ranks by live obje=
ct
> count:
>
> 41025 vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx] waste=3D328200/8 age=3D254700/=
1301825/2351179 pid=3D9-208926 cpus=3D0-5
> vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx]
> vmw_cmdbuf_reserve+0x142/0x170 [vmwgfx]
> vmw_cmd_ctx_reserve+0x24/0x60 [vmwgfx]
> vmw_stdu_bind_st+0x6b/0x100 [vmwgfx]
> vmw_stdu_primary_plane_atomic_update+0xa8/0x1d0 [vmwgfx]
> drm_atomic_helper_commit_planes+0x112/0x320 [drm_kms_helper]
> drm_atomic_helper_commit_tail+0x48/0x90 [drm_kms_helper]
> vmw_atomic_commit_tail+0x1b/0x80 [vmwgfx]
> commit_tail+0x91/0x130 [drm_kms_helper]
> drm_atomic_helper_commit+0x11a/0x140 [drm_kms_helper]
> drm_atomic_commit+0xa9/0xe0 [drm]
> drm_atomic_helper_dirtyfb+0x1c6/0x2a0 [drm_kms_helper]
> drm_fbdev_ttm_helper_fb_dirty+0x216/0x310 [drm_ttm_helper]
> drm_fb_helper_damage_work+0x94/0x170 [drm_kms_helper]
> process_one_work+0x174/0x330
> worker_thread+0x191/0x2f0
>
> The next-largest entry in that cache held 1056 objects - this one is ~30x
> everything else combined.
>
> Quantitative confirmation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> With CONFIG_HZ=3D250, from the age=3Dmin/avg/max field above:
>
> - max age 2,351,179 jiffies =3D 9405 s =3D the full uptime at time of rea=
ding
> - avg age is almost exactly half of max, which is the signature of unifor=
m
> allocation with zero frees
> - 41,025 objects over the 8386 s during which allocation was active
> =3D 4.89 objects/sec =3D 4.30 MiB/h =3D ~103 MiB/day
>
> That matches the independently measured SUnreclaim growth rate to within =
noise.
>
> Causal test
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Unbinding the text console from the framebuffer stops it instantly:
>
> # echo 0 > /sys/class/vtconsole/vtcon0/bind
>
> After that, the minimum object age jumped from 26 jiffies to 254,700 and =
kept
> climbing - i.e. no new allocations at all. SUnreclaim also dropped ~93 Mi=
B
> immediately as the fbdev shadow buffer was released, and has been flat-to=
-
> falling since.
>
> Two things I checked so you don't have to
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This is not a recent regression. drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c h=
as had
> no functional change between v6.12 and current mainline - only the comman=
d
> buffer ID addition (922f9de) and the treewide kmalloc -> kmalloc_obj
> conversions. vmwgfx_stdu.c is similarly untouched in the relevant paths, =
and
> nothing in the 6.12.y stable series touches cmdbuf, damage or dirtyfb han=
dling.
> So this looks long-standing rather than newly introduced.
>
> It is also not caused by the fbdev-ttm conversion, which is the obvious s=
uspect
> given the stack. drm_fbdev_ttm was a pure rename of drm_fbdev_generic
> (aae4682e5d66, v6.10), and vmwgfx has used the generic DRM fbdev emulatio=
n since
> v6.2 (df42523c12f8, which deleted vmwgfx_fb.c). What did change at v6.2 i=
s that
> console damage now goes through a full atomic commit, which the old
> vmwgfx_fb.c did not do - but the leak itself is on the vmwgfx side.
>
> Possibly related
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> There is an open, unresolved report of a different vmwgfx leak in the sam=
e
> atomic-commit path - Yuma Kakei, 12 Mar 2026, "[BUG] vmwgfx: Severe Slab =
memory
> leak (radix_tree_node) with Wayland Atomic KMS" (kernels 6.17 / 7.0-rc3, =
KWin
> Wayland with Atomic KMS, stops with KWIN_DRM_NO_AMS=3D1). Ian Forbes prop=
osed a
> patch; the reporter confirmed on 15 Mar 2026 that it did not fix it.
>
> I do *not* claim these are the same bug - different slab caches, differen=
t
> trigger, different kernels. But both are vmwgfx leaking on every atomic c=
ommit
> and stopping dead when the atomic path stops, so they may share a root ca=
use.
>
> Workarounds
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - echo 0 > /sys/class/vtconsole/vtcon0/bind
> runtime, reversible, stops it immediately
>
> - drm_kms_helper.fbdev_emulation=3D0 on the kernel command line
> cleaner for a headless host; disables fbdev emulation outright so no
> damage worker exists. Must be set at boot.
>
> - modprobe.blacklist=3Dvmwgfx
> heavy-handed; loses all console output
>
> All three cost the virtual console, which is fine headless but is not a g=
eneral
> fix.
>
> Happy to test patches, run instrumented kernels, or provide further data =
- the
> system reproduces this continuously and I can rebind the console at will =
to
> toggle it on and off.
>
> Thanks, Dmitry

Could you send us the full system log? (ideally journalctl -b, if not
then, dmesg, or /var/log/kern.lorg). I suspect you have some command
buffer errors in the kernel log that are causing this. Based on your
analysis disabling the cursor_blink is probably a better workaround,
i.e. "echo 0 > /sys/class/graphics/fbcon/cursor_blink" . Besides the
system logs i'd be also intersted in pool info, i.e. cat
/sys/bus/pci/devices/<vmwgfx card id>/pools .

z

--000000000000add31b065851e424
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIOST
ZYOdrxInbvfk9lA0Z/hhizje1gWmlcKGIJpAvLUwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDgwNTE5MzY1MlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAB8iiGGZlh4BHheb4hgtfYF5aGXb/wS+qh9C76Mk
TqOAgoKIn+PmWOm/I3JMLPD563ysAQgrtVBIOzqIXPGzRLQT7/CEdmTjsV9BApw2Avea4jrvtKVk
9PHrSG4jUNFXNfee3oADwkWdgndoPDEGLgSWWVbLf6b4d6coBbc1CysKZ292cWAGadSkgyrsGepc
fs675j4NPdlxRaOtNWHjsYLgBTiI9sParaIGCEU6OaZsyYmfiZQqkY+sMdZs68nObl/Cn70Y/3TD
Jmb4q5X2qn+fIHYtSIEyh8QUlS3GdSMyr99DezJRDeq08flFRoU0A5uTZmhFRvSHeWH/ptp6Y1o=
--000000000000add31b065851e424--
