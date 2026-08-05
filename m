Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF4EC55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8C710F0CF;
	Thu,  6 Aug 2026 06:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QfMTJRgd";
	dkim-atps=neutral
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6DC10E1A1
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:30:00 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-39c805fec2cso395661fa.2
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 14:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785965398; cv=none;
 d=google.com; s=arc-20260327;
 b=him6fp/Bd4fEN32tlc2GQKH0OL0FKgvshqH+I8IXpaq1qBgxkC4BRpy2kJSwYgfLd3
 7FaYL3+ZB002aVZm6uK1akJO8k5S4pv/L2C0Cf9MyE+CbI0IiwF/rBfxHFbWlyGGQykb
 ROIkCnQsXN6/qxQMn+TcKrHNZdknPlVPZEfkJzkTqc28tP4qHsBKuIjykqwWgg/z23Uc
 0KRL+CJAHOYn+S9wA8xyKMNO2meODf0ufI7v4oCuUacivCPIUACgMO9LiM46wQujsRt5
 dVoIewgfIdz3zZME4EzddmdCPB5FMkLKRfkY+KA6byGjcoyayP4sh8bdXBExjufZzByQ
 5dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uMpRzySfglgzbzMX615Oxdc3mKZylX30+p0h6khXAKQ=;
 fh=MrqnAb8n+3+E8NFtL36ZNE30xB7v2IuuECQ0gBccyDw=;
 b=Xj/9iMgGQrgXPRQ//ow3AnQYbRpzxnnb65m2d3dNQE0ZLK5ASBAsIh2j3tcWJJrt5R
 VvhbPTEqlUOJQBHSpo7SOlSmhWayHV0B9KigPaWNOtIAYJMvwDBWdergSzJJYQkPVTmu
 hS8IjL85jvb8tFnXNFkLaE7sV1CnAU5DQbiramelyob5sUEyCDoJbuwdG6u4Cq8PEAfx
 CmVMuyYr+S7V79YOar8OdMidOPkYXaxkaUwryxwHkXOnojjkj5YC58Ep3kuvwhFoZNQ2
 wH0BCBgnlJ20IUNNEglIaty0QUgG2bfE2H8qFIShTZUGtw95mkTLGenpV71jCkwh5/Fq
 qZMw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785965398; x=1786570198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uMpRzySfglgzbzMX615Oxdc3mKZylX30+p0h6khXAKQ=;
 b=QfMTJRgdPdwATD5fbu0SGqCj30DROc1iuhsjrKiCBh2YzLiPOg4CbD2FIjTCQaVxp5
 YvImov3gatd078J83iJeH4IdxXTtQcaSOZGX214GdDpopPbIH4bVEyvSOv5JcJ94a3Jk
 0O7I8Uu0g2HYO5D78E6qmK6lMh6yMoDpMG+G5SWVT8xv2diIntQtFH/S2UFgXz/mw8Yv
 pDdkNJy2iwZMWSVa0AzrQA2L5Ivr1EJnINWmRUFDDQcHyt8slMFYJ1oKkJa7912tckKa
 m8GKUFgGztDz4fznDON9WFFmRCz/Jhx/jgNh0NgffCorYj3rh158A4dWqzBg5UDEKMij
 lU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785965398; x=1786570198;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uMpRzySfglgzbzMX615Oxdc3mKZylX30+p0h6khXAKQ=;
 b=tV3f3e4REiYJleWEsPVQoIQArhtZXUW2XCX6SQmfrUjVqGpeGswYBPpke7ZEMFjoYn
 RI2iYKoMW+L55dcQKD7gqyY76SluetVYqT5N0W6n45r+VP3sJPvs6PhI2F47IfwVb4iq
 QTd+Y0X3IfaSGf3ACrYa9IpqiVtxeUCtmdjpa+PmQB/iw0eAJaPqtHQnGYV8V0Fkffeq
 hkyYqYf36DLU/wpaDqOpMFKRN6cIgVRssQF/xvaR4qHKieELOcB0V60xROLeQPaBoGtZ
 zAL4328zh+nYlP7NJNEvIMjT7dJjPUvbAFA3Sq9AzLAZnmnLzItOCZyGLv8oC6bj+p1G
 fRXQ==
X-Gm-Message-State: AOJu0YysmrE8CzMFfqaf8/6VxvMX4Et5ffEEKFw2+ejQNIKBShIPh6R6
 NtnttK7lnlNSjBVCKCcgTdvSZEq5hHMaU9GXVlmEhOObYO7hSakem7hDoQoFqKaV18+yOEvSJSb
 K5K/+5bhIVL6yUZSbqxIxf9e3tNesKXM=
X-Gm-Gg: AR+sD132W02GGSYUao3UVk3Ecj4mPpQDgjWqh8XoGH73HVms471W2ujkT4/LaQmabY3
 Rna0O/LC777BxNgnxEnL4ML1gPksfc8NU16b5rWb8WwNiY/Z9F56tTft7tTTGblWE1g1dqiTngd
 DZ0IR37a2E2eirPj3VA8Z2p84X9vglf7t+mGeqX8nyxCu13IRnlsCl4ZwbUSVGNQtPR+wfKsIT9
 7AcjIaFKSS2VMFJEIkKp8mdWukyxR94TOHAlFaxa++opt6FDNurK7bdXnMyYjfw0vy+3Hb/xIsR
 FBFaXNwsi3AeDkdK6V3NvGUzHWFLIN+Fv3mpzGHr2w==
X-Received: by 2002:a2e:bc0a:0:b0:397:e391:c0bc with SMTP id
 38308e7fff4ca-39fbb2f8960mr10411651fa.4.1785965398048; Wed, 05 Aug 2026
 14:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <CADZLCw7o5wO=+Zv2a7W9uc9AuiQDM-hEqki95eNfk8pv+L=_=A@mail.gmail.com>
 <CABQX2QNHpUbxT=GdHedVq1+Z0Qp82hYC1saHuHuWNX-0VvoRYw@mail.gmail.com>
In-Reply-To: <CABQX2QNHpUbxT=GdHedVq1+Z0Qp82hYC1saHuHuWNX-0VvoRYw@mail.gmail.com>
From: =?UTF-8?B?0JTQuNC80LAg0JTRjNGP0YfQutC+0LI=?= <das.ogi4i@gmail.com>
Date: Thu, 6 Aug 2026 00:29:47 +0300
X-Gm-Features: AUfX_mzA1rw1-pWXNzT6hKY2DhVuOro4pPWjTCu93yopuNG52R-ryD7SHtgXu44
Message-ID: <CADZLCw5Z0ZStQN6HRfk3dZZ3abBVh0A_Ukt-jM4hPGe6NrtUcg@mail.gmail.com>
Subject: Re: [BUG] drm/vmwgfx: vmw_cmdbuf_alloc leaks ~103 MiB/day via fbdev
 damage worker
To: zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, ian.forbes@broadcom.com, 
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
 tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 5, 2026 at 10:36 PM Zack Rusin <zack.rusin@broadcom.com> wrote:

Thanks both. Answers inline, but one thing up front:

**The pools request revised the severity. The leak is ~5x larger than
I reported.** Each leaked command buffer holds a 1024-byte DMA pool
block in addition to the 256-byte kmalloc header, and DMA pool memory
is not accounted in SUnreclaim - so every measurement in my original
report was blind to 80% of it. Corrected figure is ~516 MiB/day, not
~103 MiB/day. Detail below.

> Could you send us the full system log? (ideally journalctl -b, if not
> then, dmesg, or /var/log/kern.lorg). I suspect you have some command
> buffer errors in the kernel log that are causing this.

No command buffer errors - the log is clean. Full journalctl -b and
dmesg are attached/available on request, but the summary is:

- 19 vmwgfx lines total, all at boot (t=3D3.84-3.91s), all
informational. Nothing from vmwgfx after that at all.
- Zero vmwgfx errors, warnings, or *ERROR* lines.
- The only DRM error anywhere is "i915 *ERROR* PPS state mismatch",
from a passed-through Intel GPU used for video transcoding. Not
vmwgfx, and present from boot regardless of the leak.
- 5 call traces in dmesg, all of them cgroup OOM kills of a
kube-state-metrics pod hitting its own memory limit. Unrelated
(and since fixed).

One boot line is relevant though, since it confirms the allocator:

[drm] Using command buffers with DMA pool.

So the pool is being used as intended - it is only the release side
that never happens, silently.

> Based on your analysis disabling the cursor_blink is probably a
> better workaround, i.e. "echo 0 > /sys/class/graphics/fbcon/cursor_blink"

Confirmed, and it identifies the exact driver. Measured over 600s
windows by watching the vmw_cmdbuf_alloc live-object count in
/sys/kernel/debug/slab/kmalloc-256/alloc_traces:

cursor_blink=3D1 : 4.887 obj/sec (2932 objects / 600 s)
cursor_blink=3D0 : 0.003 obj/sec (2 objects / 600 s)

A ~1600x reduction; effectively zero.

The rate pins the mechanism precisely. fbcon's cursor timer runs at
HZ/5, and this kernel is CONFIG_HZ=3D250, so 50 jiffies =3D 200 ms =3D 5.0
Hz. Measured 4.887 Hz. That is **one leaked command buffer per cursor
blink tick**, with the small shortfall being scheduler jitter. It also
agrees with the 4.89 obj/sec I derived independently from the age=3D
field in my first mail.

So on a completely idle headless guest, the blinking cursor alone
leaks ~516 MiB/day.

This is a much better workaround than the ones I listed originally -
it keeps the console fully usable rather than blanking it. Thank you.

One caveat for anyone else applying it: after an unbind/rebind cycle
of vtcon0 I observed cursor_blink read back 0 while the leak was still
running at the full 4.887 obj/sec. The attribute appears to
under-report in that state, so it is worth confirming the leak
actually stopped rather than trusting the read-back.

> Besides the system logs i'd be also intersted in pool info, i.e. cat
> /sys/bus/pci/devices/<vmwgfx card id>/pools .

This is the interesting one.

$ cat /sys/bus/pci/devices/0000:00:0f.0/pools
poolinfo - 0.1
vmwgfx inline cmdbuf 53875 53876 1024 13469
vmwgfx cmdbuf 0 0 64 0

Read as name / blocks-in-use / capacity / block-size / pages:

- 53,875 of 53,876 blocks in use - the pool has grown to exactly
accommodate every allocation and sits pinned at ~100% utilisation.
- 13,469 pages =3D 52.6 MiB held. (13469 * 4096/1024 =3D 53876, which
matches the stated capacity, so the reading is self-consistent.)
- The non-inline "vmwgfx cmdbuf" pool is completely empty, so this
is specific to the inline command buffer path.

Taken at the same moment:

$ sudo awk '/vmw_cmdbuf_alloc/{print $1; exit}' \
/sys/kernel/debug/slab/kmalloc-256/alloc_traces
53872

53,872 kmalloc-256 headers against 53,875 pool blocks - a difference
of 3, which is just allocations in flight between the two reads. So it
is 1:1: every leaked command buffer pins both a 256-byte header and a
1024-byte DMA pool block, 1280 bytes total.

Sanity check: 53,875 blocks / 4.887 per sec =3D 11,024 s =3D 3.06 hours of
active leaking, which matches the accumulated time the console was
bound on this boot.

Since dma_pool memory comes from dma_alloc_coherent rather than the
slab allocator, none of it appears in SUnreclaim. That is why my
original 103 MiB/day figure was low by 5x - it only ever counted the
kmalloc headers.

On Wed, Aug 5, 2026 at 8:30 PM Ian Forbes <ian.forbes@broadcom.com> wrote:
>
> Please recompile with KMEMLEAK and/or KASAN and share any output.

If the additional info provided is not enough, then I will recompile.
Two notes on how I plan to do it:

Debian ships neither CONFIG_DEBUG_KMEMLEAK nor CONFIG_KASAN, so this
needs a custom build. I will do it in a clean throwaway Debian VM
rather than on the host I reported from, for two reasons:

1. That host runs ZFS via DKMS, so its kernel is tainted
(P/O/E). A report from an untainted kernel with nothing but
Debian base installed is worth more, and removes any question
about whether ZFS, Kubernetes or the passed-through i915 are
involved.
2. KASAN's memory overhead is not viable on that host, but is fine
on a bare VM.

I will send kmemleak output, and KASAN separately if it turns up
anything - though since kmemleak reports unreferenced allocations and
KASAN reports memory errors, I expect kmemleak is the relevant one
here unless you suspect corruption in the release path.

Happy to test patches in the meantime; the reproducer is a stock
Debian VMware guest with a text console, and I can toggle the leak on
and off with cursor_blink.

Thanks, Dmitry


=D1=81=D1=80, 5 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 22:36, Zack=
 Rusin <zack.rusin@broadcom.com>:
>
> On Wed, Aug 5, 2026 at 12:59=E2=80=AFPM =D0=94=D0=B8=D0=BC=D0=B0 =D0=94=
=D1=8C=D1=8F=D1=87=D0=BA=D0=BE=D0=B2 <das.ogi4i@gmail.com> wrote:
> >
> > Hi,
> >
> > I have a reproducible, quantified kernel memory leak in vmwgfx on a hea=
dless
> > VMware guest. It is attributed to a specific call site with slab_debug,=
 and I
> > have a clean causal test that stops it. I could not find this reported =
anywhere
> > - I searched the dri-devel archives, the mainline and 6.12.y git logs, =
and the
> > distro trackers.
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > On a headless VMware guest with the text console bound to the vmwgfx
> > framebuffer, the fbdev-emulation damage worker issues a full atomic com=
mit for
> > every console damage event, and vmwgfx leaks a command buffer on each o=
ne. The
> > result is unreclaimable kernel slab growing linearly at ~103 MiB/day, n=
ever
> > reclaimed under memory pressure, released only by reboot.
> >
> > Environment
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Kernel: 6.12.100+deb13-amd64 (Debian 13 stock, tracks 6.12.y)
> > Guest: VMware Virtual Platform, BIOS 6.00; vmwgfx drives the virtual di=
splay
> > Console: headless, administered over SSH; a single agetty on the consol=
e
> > fb0: vmwgfxdrmfb
> > vtcon0: "(M) frame buffer device", bind=3D1
> > Config: CONFIG_HZ=3D250, CONFIG_SLUB_DEBUG=3Dy, CONFIG_STACKDEPOT=3Dy
> > (CONFIG_DEBUG_KMEMLEAK is not set in Debian's kernel)
> >
> > i915 is also loaded on this host (a passed-through GPU used for video
> > transcoding) but is unrelated - the console framebuffer is vmwgfx.
> >
> > Symptom
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > SUnreclaim grows linearly at ~103 MiB/day and is never reclaimed under =
pressure.
> > The growth is confined to the plain kmalloc-256 cache - notably *not*
> > kmalloc-cg-256, so it is plain GFP_KERNEL from an in-kernel allocator r=
ather
> > than anything cgroup-accounted.
> >
> > Attribution
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Booted with slab_debug=3DU,kmalloc-256, then read
> > /sys/kernel/debug/slab/kmalloc-256/alloc_traces, which ranks by live ob=
ject
> > count:
> >
> > 41025 vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx] waste=3D328200/8 age=3D25470=
0/1301825/2351179 pid=3D9-208926 cpus=3D0-5
> > vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx]
> > vmw_cmdbuf_reserve+0x142/0x170 [vmwgfx]
> > vmw_cmd_ctx_reserve+0x24/0x60 [vmwgfx]
> > vmw_stdu_bind_st+0x6b/0x100 [vmwgfx]
> > vmw_stdu_primary_plane_atomic_update+0xa8/0x1d0 [vmwgfx]
> > drm_atomic_helper_commit_planes+0x112/0x320 [drm_kms_helper]
> > drm_atomic_helper_commit_tail+0x48/0x90 [drm_kms_helper]
> > vmw_atomic_commit_tail+0x1b/0x80 [vmwgfx]
> > commit_tail+0x91/0x130 [drm_kms_helper]
> > drm_atomic_helper_commit+0x11a/0x140 [drm_kms_helper]
> > drm_atomic_commit+0xa9/0xe0 [drm]
> > drm_atomic_helper_dirtyfb+0x1c6/0x2a0 [drm_kms_helper]
> > drm_fbdev_ttm_helper_fb_dirty+0x216/0x310 [drm_ttm_helper]
> > drm_fb_helper_damage_work+0x94/0x170 [drm_kms_helper]
> > process_one_work+0x174/0x330
> > worker_thread+0x191/0x2f0
> >
> > The next-largest entry in that cache held 1056 objects - this one is ~3=
0x
> > everything else combined.
> >
> > Quantitative confirmation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > With CONFIG_HZ=3D250, from the age=3Dmin/avg/max field above:
> >
> > - max age 2,351,179 jiffies =3D 9405 s =3D the full uptime at time of r=
eading
> > - avg age is almost exactly half of max, which is the signature of unif=
orm
> > allocation with zero frees
> > - 41,025 objects over the 8386 s during which allocation was active
> > =3D 4.89 objects/sec =3D 4.30 MiB/h =3D ~103 MiB/day
> >
> > That matches the independently measured SUnreclaim growth rate to withi=
n noise.
> >
> > Causal test
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Unbinding the text console from the framebuffer stops it instantly:
> >
> > # echo 0 > /sys/class/vtconsole/vtcon0/bind
> >
> > After that, the minimum object age jumped from 26 jiffies to 254,700 an=
d kept
> > climbing - i.e. no new allocations at all. SUnreclaim also dropped ~93 =
MiB
> > immediately as the fbdev shadow buffer was released, and has been flat-=
to-
> > falling since.
> >
> > Two things I checked so you don't have to
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This is not a recent regression. drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c=
 has had
> > no functional change between v6.12 and current mainline - only the comm=
and
> > buffer ID addition (922f9de) and the treewide kmalloc -> kmalloc_obj
> > conversions. vmwgfx_stdu.c is similarly untouched in the relevant paths=
, and
> > nothing in the 6.12.y stable series touches cmdbuf, damage or dirtyfb h=
andling.
> > So this looks long-standing rather than newly introduced.
> >
> > It is also not caused by the fbdev-ttm conversion, which is the obvious=
 suspect
> > given the stack. drm_fbdev_ttm was a pure rename of drm_fbdev_generic
> > (aae4682e5d66, v6.10), and vmwgfx has used the generic DRM fbdev emulat=
ion since
> > v6.2 (df42523c12f8, which deleted vmwgfx_fb.c). What did change at v6.2=
 is that
> > console damage now goes through a full atomic commit, which the old
> > vmwgfx_fb.c did not do - but the leak itself is on the vmwgfx side.
> >
> > Possibly related
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > There is an open, unresolved report of a different vmwgfx leak in the s=
ame
> > atomic-commit path - Yuma Kakei, 12 Mar 2026, "[BUG] vmwgfx: Severe Sla=
b memory
> > leak (radix_tree_node) with Wayland Atomic KMS" (kernels 6.17 / 7.0-rc3=
, KWin
> > Wayland with Atomic KMS, stops with KWIN_DRM_NO_AMS=3D1). Ian Forbes pr=
oposed a
> > patch; the reporter confirmed on 15 Mar 2026 that it did not fix it.
> >
> > I do *not* claim these are the same bug - different slab caches, differ=
ent
> > trigger, different kernels. But both are vmwgfx leaking on every atomic=
 commit
> > and stopping dead when the atomic path stops, so they may share a root =
cause.
> >
> > Workarounds
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - echo 0 > /sys/class/vtconsole/vtcon0/bind
> > runtime, reversible, stops it immediately
> >
> > - drm_kms_helper.fbdev_emulation=3D0 on the kernel command line
> > cleaner for a headless host; disables fbdev emulation outright so no
> > damage worker exists. Must be set at boot.
> >
> > - modprobe.blacklist=3Dvmwgfx
> > heavy-handed; loses all console output
> >
> > All three cost the virtual console, which is fine headless but is not a=
 general
> > fix.
> >
> > Happy to test patches, run instrumented kernels, or provide further dat=
a - the
> > system reproduces this continuously and I can rebind the console at wil=
l to
> > toggle it on and off.
> >
> > Thanks, Dmitry
>
> Could you send us the full system log? (ideally journalctl -b, if not
> then, dmesg, or /var/log/kern.lorg). I suspect you have some command
> buffer errors in the kernel log that are causing this. Based on your
> analysis disabling the cursor_blink is probably a better workaround,
> i.e. "echo 0 > /sys/class/graphics/fbcon/cursor_blink" . Besides the
> system logs i'd be also intersted in pool info, i.e. cat
> /sys/bus/pci/devices/<vmwgfx card id>/pools .
>
> z
