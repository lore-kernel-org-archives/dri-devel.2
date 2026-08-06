Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA81C55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 669B810E27C;
	Thu,  6 Aug 2026 04:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="APbUjKcU";
	dkim-atps=neutral
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com
 [209.85.221.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B2610E27C
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 04:09:00 +0000 (UTC)
Received: by mail-vk1-f226.google.com with SMTP id
 71dfb90a1353d-5bfa99f8ef8so415887e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 21:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785989339; x=1786594139;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PglxwYioIcR5YpLM/3AfuFzuLfOMHs7JV0piqlAiqE4=;
 b=N6hIUM7Pk0qyYn+vJ5ltalOkiqse7Rn+mWX5UhxGXZx8Xot6VQRn0nbVlUorYPZnOo
 zGmFgWFRB3MhOZHUisJyNYtYgKGrPWQIf7a6NtlCegk8aA6ypBZJBndsiU5Be3aNj3PS
 1N6euI4LZ5oZ7JqouxsmSINCnbabjjh7aLrBUGk2ipXf9iBXuTOtazVoGI4LTDykc5RI
 T/f1qBCAOw5/dEgBYlMI8LZoECV1gMx0Rdkw9g6FyeJnL4yyrWpbdoMgeDBJO7gdOr/b
 GgSOOKnKflTGjRkHh6+mivJDQBTBDiSpuvMu/isOs8KsoULP7LbgTnF/Ey87b4phH+PK
 0qIA==
X-Gm-Message-State: AOJu0YzFJCfMwHzb9XZxoAVIssOqeou2RRWugwDzmy+dCk6kGp+rJXvQ
 qfrcXG4WT66XOqmjXrkRYn47lJzjHdOrWHGv9rrwf7wQahDbSNSiDKAyFKCvpw/bw+gBMPt0uG8
 pihCtDLDjIpQTBQi9nWBRqcdkntfaLNzuJ17BbKKw8wKU3cyTIIeiprUV0bC9hxFa+EBoJwp/Bt
 GmgGbq+oeDO9QII0sVAwjCnRNA6KAKgQoFKJGJsoOGKW/bwY9lv+LjXPtfSW1nJRm4u/1UTxrO+
 xXUYWnyjKa23QWjMRz0
X-Gm-Gg: AR+sD11GoTGaUGXezF2rvEVXAZLb2C3O743Keq4iqGoVERMWTQHAJ8ArPSnC11SS9Hb
 EBENPt+MMDf8axCs+IPBDsSj1APtndBRNSjuli7WDm6K78gP1iKObIxwHixvUkqjCDuqQi6HJEs
 LmqIyvZjMjnKR86hm2DB5wC+/qBm9pTVhoctpckNIT2l5dcuMgCSsMXCElMBCm0quofEwrwqXXy
 Hoj4OXCncuE2q0ZbjHXSsZFkOEWGqIpf9d1kTNKZmIWPhUn2+kGtu6j2NZlYuf3cr/OfDa+b+1q
 QkKUxDzr7fCtGkXTZZ3hv2QjGRL4dmm0illPEYZnH/pickOHf6vfS2q/XrB8mhdbMk4VdE2MAiK
 0p1rHiXMe2RTOYRTIlE6pZL9ra4CKD5i1YND3HgOhHrHVzKLcsRQtwT8XkIr9TMSJe6yVGXg2+Z
 A0yWYHMvXKgWev/etMZ1bGHBdSWyG0mzIB
X-Received: by 2002:a05:6122:490b:b0:5bd:8dd8:146e with SMTP id
 71dfb90a1353d-5c3f3556d2fmr187143e0c.4.1785989338745; 
 Wed, 05 Aug 2026 21:08:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c3d0720641sm1092944e0c.6.2026.08.05.21.08.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Aug 2026 21:08:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b14d51dae1so798391e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 21:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1785989337; x=1786594137;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PglxwYioIcR5YpLM/3AfuFzuLfOMHs7JV0piqlAiqE4=;
 b=APbUjKcUjD+R0jOj2mks54SC1IRIPpRIJ94fslauiuIDiwSmebY2qcWRW7Lm2ZoeuG
 ryySw0+/O7eEI52M4ER5fHHzp6UMrFY3b+vSy0NiJl2Fu8UFn0Kb4VKqynk4mSPA8TEF
 VCBJZOsTQduvoyicvRNI5/qltYgo6zx9alRcM=
X-Received: by 2002:a05:6512:12d6:b0:5ae:b130:1e1 with SMTP id
 2adb3069b0e04-5b2f4cb322fmr1916712e87.28.1785989336841; 
 Wed, 05 Aug 2026 21:08:56 -0700 (PDT)
X-Received: by 2002:a05:6512:12d6:b0:5ae:b130:1e1 with SMTP id
 2adb3069b0e04-5b2f4cb322fmr1916699e87.28.1785989336237; Wed, 05 Aug 2026
 21:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <CADZLCw7o5wO=+Zv2a7W9uc9AuiQDM-hEqki95eNfk8pv+L=_=A@mail.gmail.com>
 <CABQX2QNHpUbxT=GdHedVq1+Z0Qp82hYC1saHuHuWNX-0VvoRYw@mail.gmail.com>
 <CADZLCw5Z0ZStQN6HRfk3dZZ3abBVh0A_Ukt-jM4hPGe6NrtUcg@mail.gmail.com>
In-Reply-To: <CADZLCw5Z0ZStQN6HRfk3dZZ3abBVh0A_Ukt-jM4hPGe6NrtUcg@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 6 Aug 2026 00:08:41 -0400
X-Gm-Features: AUfX_mwcoZm5cyxuFTuFD5DbXpWd4mn93NWWKtp2PTfKwSG7x-B9IQjqikuN4rI
Message-ID: <CABQX2QPndJ4xqTuEmDyykVkCPqtWNvRM2EupZvN2gU68j=NfLg@mail.gmail.com>
Subject: Re: [BUG] drm/vmwgfx: vmw_cmdbuf_alloc leaks ~103 MiB/day via fbdev
 damage worker
To: =?UTF-8?B?0JTQuNC80LAg0JTRjNGP0YfQutC+0LI=?= <das.ogi4i@gmail.com>
Cc: dri-devel@lists.freedesktop.org, ian.forbes@broadcom.com, 
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
 tzimmermann@suse.de
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000000584ca0658590ceb"
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

--0000000000000584ca0658590ceb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, are you using llm for replies? The email starts with multiple
paragraphs just to say, "Oh, yeah,", which, as a human, makes it
difficult to communicate :) If you could provide the data/logs and let
us do the analysis then it's just going to go a lot smoother. Can you
upload your logs somewhere? They haven't gone through. If you could
upload your vmware.log and the guest system log somewhere (some
pastebin is fine) that would be great.

z

On Wed, Aug 5, 2026 at 5:29=E2=80=AFPM =D0=94=D0=B8=D0=BC=D0=B0 =D0=94=D1=
=8C=D1=8F=D1=87=D0=BA=D0=BE=D0=B2 <das.ogi4i@gmail.com> wrote:
>
> On Wed, Aug 5, 2026 at 10:36 PM Zack Rusin <zack.rusin@broadcom.com> wrot=
e:
>
> Thanks both. Answers inline, but one thing up front:
>
> **The pools request revised the severity. The leak is ~5x larger than
> I reported.** Each leaked command buffer holds a 1024-byte DMA pool
> block in addition to the 256-byte kmalloc header, and DMA pool memory
> is not accounted in SUnreclaim - so every measurement in my original
> report was blind to 80% of it. Corrected figure is ~516 MiB/day, not
> ~103 MiB/day. Detail below.
>
> > Could you send us the full system log? (ideally journalctl -b, if not
> > then, dmesg, or /var/log/kern.lorg). I suspect you have some command
> > buffer errors in the kernel log that are causing this.
>
> No command buffer errors - the log is clean. Full journalctl -b and
> dmesg are attached/available on request, but the summary is:
>
> - 19 vmwgfx lines total, all at boot (t=3D3.84-3.91s), all
> informational. Nothing from vmwgfx after that at all.
> - Zero vmwgfx errors, warnings, or *ERROR* lines.
> - The only DRM error anywhere is "i915 *ERROR* PPS state mismatch",
> from a passed-through Intel GPU used for video transcoding. Not
> vmwgfx, and present from boot regardless of the leak.
> - 5 call traces in dmesg, all of them cgroup OOM kills of a
> kube-state-metrics pod hitting its own memory limit. Unrelated
> (and since fixed).
>
> One boot line is relevant though, since it confirms the allocator:
>
> [drm] Using command buffers with DMA pool.
>
> So the pool is being used as intended - it is only the release side
> that never happens, silently.
>
> > Based on your analysis disabling the cursor_blink is probably a
> > better workaround, i.e. "echo 0 > /sys/class/graphics/fbcon/cursor_blin=
k"
>
> Confirmed, and it identifies the exact driver. Measured over 600s
> windows by watching the vmw_cmdbuf_alloc live-object count in
> /sys/kernel/debug/slab/kmalloc-256/alloc_traces:
>
> cursor_blink=3D1 : 4.887 obj/sec (2932 objects / 600 s)
> cursor_blink=3D0 : 0.003 obj/sec (2 objects / 600 s)
>
> A ~1600x reduction; effectively zero.
>
> The rate pins the mechanism precisely. fbcon's cursor timer runs at
> HZ/5, and this kernel is CONFIG_HZ=3D250, so 50 jiffies =3D 200 ms =3D 5.=
0
> Hz. Measured 4.887 Hz. That is **one leaked command buffer per cursor
> blink tick**, with the small shortfall being scheduler jitter. It also
> agrees with the 4.89 obj/sec I derived independently from the age=3D
> field in my first mail.
>
> So on a completely idle headless guest, the blinking cursor alone
> leaks ~516 MiB/day.
>
> This is a much better workaround than the ones I listed originally -
> it keeps the console fully usable rather than blanking it. Thank you.
>
> One caveat for anyone else applying it: after an unbind/rebind cycle
> of vtcon0 I observed cursor_blink read back 0 while the leak was still
> running at the full 4.887 obj/sec. The attribute appears to
> under-report in that state, so it is worth confirming the leak
> actually stopped rather than trusting the read-back.
>
> > Besides the system logs i'd be also intersted in pool info, i.e. cat
> > /sys/bus/pci/devices/<vmwgfx card id>/pools .
>
> This is the interesting one.
>
> $ cat /sys/bus/pci/devices/0000:00:0f.0/pools
> poolinfo - 0.1
> vmwgfx inline cmdbuf 53875 53876 1024 13469
> vmwgfx cmdbuf 0 0 64 0
>
> Read as name / blocks-in-use / capacity / block-size / pages:
>
> - 53,875 of 53,876 blocks in use - the pool has grown to exactly
> accommodate every allocation and sits pinned at ~100% utilisation.
> - 13,469 pages =3D 52.6 MiB held. (13469 * 4096/1024 =3D 53876, which
> matches the stated capacity, so the reading is self-consistent.)
> - The non-inline "vmwgfx cmdbuf" pool is completely empty, so this
> is specific to the inline command buffer path.
>
> Taken at the same moment:
>
> $ sudo awk '/vmw_cmdbuf_alloc/{print $1; exit}' \
> /sys/kernel/debug/slab/kmalloc-256/alloc_traces
> 53872
>
> 53,872 kmalloc-256 headers against 53,875 pool blocks - a difference
> of 3, which is just allocations in flight between the two reads. So it
> is 1:1: every leaked command buffer pins both a 256-byte header and a
> 1024-byte DMA pool block, 1280 bytes total.
>
> Sanity check: 53,875 blocks / 4.887 per sec =3D 11,024 s =3D 3.06 hours o=
f
> active leaking, which matches the accumulated time the console was
> bound on this boot.
>
> Since dma_pool memory comes from dma_alloc_coherent rather than the
> slab allocator, none of it appears in SUnreclaim. That is why my
> original 103 MiB/day figure was low by 5x - it only ever counted the
> kmalloc headers.
>
> On Wed, Aug 5, 2026 at 8:30 PM Ian Forbes <ian.forbes@broadcom.com> wrote=
:
> >
> > Please recompile with KMEMLEAK and/or KASAN and share any output.
>
> If the additional info provided is not enough, then I will recompile.
> Two notes on how I plan to do it:
>
> Debian ships neither CONFIG_DEBUG_KMEMLEAK nor CONFIG_KASAN, so this
> needs a custom build. I will do it in a clean throwaway Debian VM
> rather than on the host I reported from, for two reasons:
>
> 1. That host runs ZFS via DKMS, so its kernel is tainted
> (P/O/E). A report from an untainted kernel with nothing but
> Debian base installed is worth more, and removes any question
> about whether ZFS, Kubernetes or the passed-through i915 are
> involved.
> 2. KASAN's memory overhead is not viable on that host, but is fine
> on a bare VM.
>
> I will send kmemleak output, and KASAN separately if it turns up
> anything - though since kmemleak reports unreferenced allocations and
> KASAN reports memory errors, I expect kmemleak is the relevant one
> here unless you suspect corruption in the release path.
>
> Happy to test patches in the meantime; the reproducer is a stock
> Debian VMware guest with a text console, and I can toggle the leak on
> and off with cursor_blink.
>
> Thanks, Dmitry
>
>
> =D1=81=D1=80, 5 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 22:36, Za=
ck Rusin <zack.rusin@broadcom.com>:
> >
> > On Wed, Aug 5, 2026 at 12:59=E2=80=AFPM =D0=94=D0=B8=D0=BC=D0=B0 =D0=94=
=D1=8C=D1=8F=D1=87=D0=BA=D0=BE=D0=B2 <das.ogi4i@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I have a reproducible, quantified kernel memory leak in vmwgfx on a h=
eadless
> > > VMware guest. It is attributed to a specific call site with slab_debu=
g, and I
> > > have a clean causal test that stops it. I could not find this reporte=
d anywhere
> > > - I searched the dri-devel archives, the mainline and 6.12.y git logs=
, and the
> > > distro trackers.
> > >
> > > Summary
> > > =3D=3D=3D=3D=3D=3D=3D
> > >
> > > On a headless VMware guest with the text console bound to the vmwgfx
> > > framebuffer, the fbdev-emulation damage worker issues a full atomic c=
ommit for
> > > every console damage event, and vmwgfx leaks a command buffer on each=
 one. The
> > > result is unreclaimable kernel slab growing linearly at ~103 MiB/day,=
 never
> > > reclaimed under memory pressure, released only by reboot.
> > >
> > > Environment
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Kernel: 6.12.100+deb13-amd64 (Debian 13 stock, tracks 6.12.y)
> > > Guest: VMware Virtual Platform, BIOS 6.00; vmwgfx drives the virtual =
display
> > > Console: headless, administered over SSH; a single agetty on the cons=
ole
> > > fb0: vmwgfxdrmfb
> > > vtcon0: "(M) frame buffer device", bind=3D1
> > > Config: CONFIG_HZ=3D250, CONFIG_SLUB_DEBUG=3Dy, CONFIG_STACKDEPOT=3Dy
> > > (CONFIG_DEBUG_KMEMLEAK is not set in Debian's kernel)
> > >
> > > i915 is also loaded on this host (a passed-through GPU used for video
> > > transcoding) but is unrelated - the console framebuffer is vmwgfx.
> > >
> > > Symptom
> > > =3D=3D=3D=3D=3D=3D=3D
> > >
> > > SUnreclaim grows linearly at ~103 MiB/day and is never reclaimed unde=
r pressure.
> > > The growth is confined to the plain kmalloc-256 cache - notably *not*
> > > kmalloc-cg-256, so it is plain GFP_KERNEL from an in-kernel allocator=
 rather
> > > than anything cgroup-accounted.
> > >
> > > Attribution
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Booted with slab_debug=3DU,kmalloc-256, then read
> > > /sys/kernel/debug/slab/kmalloc-256/alloc_traces, which ranks by live =
object
> > > count:
> > >
> > > 41025 vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx] waste=3D328200/8 age=3D254=
700/1301825/2351179 pid=3D9-208926 cpus=3D0-5
> > > vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx]
> > > vmw_cmdbuf_reserve+0x142/0x170 [vmwgfx]
> > > vmw_cmd_ctx_reserve+0x24/0x60 [vmwgfx]
> > > vmw_stdu_bind_st+0x6b/0x100 [vmwgfx]
> > > vmw_stdu_primary_plane_atomic_update+0xa8/0x1d0 [vmwgfx]
> > > drm_atomic_helper_commit_planes+0x112/0x320 [drm_kms_helper]
> > > drm_atomic_helper_commit_tail+0x48/0x90 [drm_kms_helper]
> > > vmw_atomic_commit_tail+0x1b/0x80 [vmwgfx]
> > > commit_tail+0x91/0x130 [drm_kms_helper]
> > > drm_atomic_helper_commit+0x11a/0x140 [drm_kms_helper]
> > > drm_atomic_commit+0xa9/0xe0 [drm]
> > > drm_atomic_helper_dirtyfb+0x1c6/0x2a0 [drm_kms_helper]
> > > drm_fbdev_ttm_helper_fb_dirty+0x216/0x310 [drm_ttm_helper]
> > > drm_fb_helper_damage_work+0x94/0x170 [drm_kms_helper]
> > > process_one_work+0x174/0x330
> > > worker_thread+0x191/0x2f0
> > >
> > > The next-largest entry in that cache held 1056 objects - this one is =
~30x
> > > everything else combined.
> > >
> > > Quantitative confirmation
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >
> > > With CONFIG_HZ=3D250, from the age=3Dmin/avg/max field above:
> > >
> > > - max age 2,351,179 jiffies =3D 9405 s =3D the full uptime at time of=
 reading
> > > - avg age is almost exactly half of max, which is the signature of un=
iform
> > > allocation with zero frees
> > > - 41,025 objects over the 8386 s during which allocation was active
> > > =3D 4.89 objects/sec =3D 4.30 MiB/h =3D ~103 MiB/day
> > >
> > > That matches the independently measured SUnreclaim growth rate to wit=
hin noise.
> > >
> > > Causal test
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Unbinding the text console from the framebuffer stops it instantly:
> > >
> > > # echo 0 > /sys/class/vtconsole/vtcon0/bind
> > >
> > > After that, the minimum object age jumped from 26 jiffies to 254,700 =
and kept
> > > climbing - i.e. no new allocations at all. SUnreclaim also dropped ~9=
3 MiB
> > > immediately as the fbdev shadow buffer was released, and has been fla=
t-to-
> > > falling since.
> > >
> > > Two things I checked so you don't have to
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > This is not a recent regression. drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf=
.c has had
> > > no functional change between v6.12 and current mainline - only the co=
mmand
> > > buffer ID addition (922f9de) and the treewide kmalloc -> kmalloc_obj
> > > conversions. vmwgfx_stdu.c is similarly untouched in the relevant pat=
hs, and
> > > nothing in the 6.12.y stable series touches cmdbuf, damage or dirtyfb=
 handling.
> > > So this looks long-standing rather than newly introduced.
> > >
> > > It is also not caused by the fbdev-ttm conversion, which is the obvio=
us suspect
> > > given the stack. drm_fbdev_ttm was a pure rename of drm_fbdev_generic
> > > (aae4682e5d66, v6.10), and vmwgfx has used the generic DRM fbdev emul=
ation since
> > > v6.2 (df42523c12f8, which deleted vmwgfx_fb.c). What did change at v6=
.2 is that
> > > console damage now goes through a full atomic commit, which the old
> > > vmwgfx_fb.c did not do - but the leak itself is on the vmwgfx side.
> > >
> > > Possibly related
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > There is an open, unresolved report of a different vmwgfx leak in the=
 same
> > > atomic-commit path - Yuma Kakei, 12 Mar 2026, "[BUG] vmwgfx: Severe S=
lab memory
> > > leak (radix_tree_node) with Wayland Atomic KMS" (kernels 6.17 / 7.0-r=
c3, KWin
> > > Wayland with Atomic KMS, stops with KWIN_DRM_NO_AMS=3D1). Ian Forbes =
proposed a
> > > patch; the reporter confirmed on 15 Mar 2026 that it did not fix it.
> > >
> > > I do *not* claim these are the same bug - different slab caches, diff=
erent
> > > trigger, different kernels. But both are vmwgfx leaking on every atom=
ic commit
> > > and stopping dead when the atomic path stops, so they may share a roo=
t cause.
> > >
> > > Workarounds
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > - echo 0 > /sys/class/vtconsole/vtcon0/bind
> > > runtime, reversible, stops it immediately
> > >
> > > - drm_kms_helper.fbdev_emulation=3D0 on the kernel command line
> > > cleaner for a headless host; disables fbdev emulation outright so no
> > > damage worker exists. Must be set at boot.
> > >
> > > - modprobe.blacklist=3Dvmwgfx
> > > heavy-handed; loses all console output
> > >
> > > All three cost the virtual console, which is fine headless but is not=
 a general
> > > fix.
> > >
> > > Happy to test patches, run instrumented kernels, or provide further d=
ata - the
> > > system reproduces this continuously and I can rebind the console at w=
ill to
> > > toggle it on and off.
> > >
> > > Thanks, Dmitry
> >
> > Could you send us the full system log? (ideally journalctl -b, if not
> > then, dmesg, or /var/log/kern.lorg). I suspect you have some command
> > buffer errors in the kernel log that are causing this. Based on your
> > analysis disabling the cursor_blink is probably a better workaround,
> > i.e. "echo 0 > /sys/class/graphics/fbcon/cursor_blink" . Besides the
> > system logs i'd be also intersted in pool info, i.e. cat
> > /sys/bus/pci/devices/<vmwgfx card id>/pools .
> >
> > z

--0000000000000584ca0658590ceb
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFii
2vsQ+5vr2J0Vlf+8YjZstTknxeQkXWvNaExVfrK1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDgwNjA0MDg1N1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAD5x/svDAMKV+I94i2z4LZfX/ID3z7UOIyEGz7de
yo/KsuvZO6NuJnnuSv/81D40O59/uTs3MNb+QFsFuN1+sX9BASqnCF8phAPs9UrYZH7WcArJFmI2
TOCG6os7hxAQsiCm87xh3kGij/uWXSKTNl/DSZbWcHH8ErPy9hTbkqWLvG+uSWaX1o84mRPJJ7+a
pGG/sAbytJmvaFEAAUNDzTQcSaqKbE/5cCfZImcN+ncy+ox5yepIu7cofvQ/wThGvp+uqouhU7DY
e3vflSNkrdg5onplnSgPqc3EZGnchnUaQUlW3CtB4DwiOAiHYee18KmxlrGqAxnFl6ytLKvlEBM=
--0000000000000584ca0658590ceb--
