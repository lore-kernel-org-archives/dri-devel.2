Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00769C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC3E10E63D;
	Mon, 10 Aug 2026 06:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sHgiYzVq";
	dkim-atps=neutral
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07BB210E24A
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 20:00:00 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-39fa95f0e0dso4154951fa.2
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 12:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786132798; cv=none;
 d=google.com; s=arc-20260327;
 b=JeqVqJqdj18dtix5c1iaWypC/CT9EscFayqEPPS7LEth+Z6hG/XcM3RaYVGRNnkROR
 XH4oQPQ4cTbrHdBt5lLazwAA1iYlQPb9k/d1So6AAJC64smPMH8Nn+7C1TLQzgFKMt2Y
 yUXYbEQtKdqhiLDaYklFAgtU6T3tG7bUNvnavgOjnTyPeZmR2FSBUn0LmTdFD0Lz/Xah
 q8+OMb87ZsppyasPV+npmEiNyZ6xvsqhJmE5eoTW5xBJtJFbhXAZ5VfuGSWom/rktrp6
 gQQI3c3mjNBSUmqMaqUaFSNqa/7LopUxcVSGSwmOm/A1HFh1+sQefQZYby0tZ+8sg6He
 D7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=anhVWwI4Evtozwln9wW9pFgTfGu5gNgdOO5xhZACshY=;
 fh=wmoQm9zKJWKDpBvr5jsi37VYXDXNH04uLgPkHl/cf6g=;
 b=Qv4lMOiaeRCXn7kSo7WX8QNOJHoG8x9yRiTVvVh+ocGSh8JDm22FHKeomv4x5Ww6r0
 qqkr3kpngYnUVh6RKcotNs7I3TET9gJpF0ELIHwRDPfxvah2E6+TaVxfhAC/Sj8ri/V9
 Oj2K+S0Mi8FGPrUTE35MJFZtqU9y8MUazlfzd36Zcc5imQ7BtHduxORIxMFfPTeqx3XA
 Xcqi/7ujj6lxq7Rq126pArQYWf5K/nfvUzn5QcbYZsK8Csrd0iFvSaJ5vH/+g0uqAdMo
 3ljDcVYnzvFXanldgTf3DdASGgzOg+0eTRYCm+q+3Lbr1+TBB1wRWhfyBWKT3beQ7C1x
 UguQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786132798; x=1786737598; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=anhVWwI4Evtozwln9wW9pFgTfGu5gNgdOO5xhZACshY=;
 b=sHgiYzVqt2t1noA4JUroAov1PqDCJFoObjx5HfEDa3FwvTythWPohhTNWcd9RMF3WN
 0mvKhzlCRkQp/IvyJEVxesd5LjvY6PBh1lnL9qMWm8pdBL0jZL34FXL6ufTUl4aEH4b6
 KiBHKkVN6L+QMzh7yqw7gQ8Re9HClX8B6rrXizygxW728WSx4lVSB0rhxkZKMcFDUuGV
 fbDuQmB+auXlj5w7yvyDhn8ekthgwbbDMyDxgei+mbjInKDINvZfCSEEqdPFCY5ptJp6
 uEwg8dzoki+TAysB25RwaxIcbctmQxdU/ghzXCHtKH5TEABVQAyJcAll060atu1Mh8/+
 KKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786132798; x=1786737598;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=anhVWwI4Evtozwln9wW9pFgTfGu5gNgdOO5xhZACshY=;
 b=rVBa4P74Eh/3eZcQ05uerC/2fN1zSuyy5tTrluHs/AgisjLa5QOfg+1dfbPFb8vcBA
 s62DkQHTXcVlJfJ5UNC6yOQ3sWl28YVHKXNVcyyAqBkrsqvCZg1i5xjSltuzJot035D9
 yrvHVt+RDmanCzZPcFglhBv1lNX3gmXg13NAXXXIPN75vJnwHGHp46z97xNq2d2WhBBJ
 ky0GNdEd3YwAvtxfYWk8HZVUNUj+BQvOZ1AiBImx0R7jugScSHijikpKubMNyhGodcCf
 4QgNLVx0TXUqPcgw+Mkf+/33raa9zquHYT7fUwdEgAjTILBu/5UhpjAtlOkuIiiErUtt
 bJhQ==
X-Gm-Message-State: AOJu0YwEDsjBaA6kZjde3DCK36Nn7YWJEoREFH+vweRP4z8tdqZ2rpMV
 Mfz4iT1YKRsA4GkJoK5N/Tm+VsBQiVnJpU3kmONnhTqb2h/M8gR9JFvPESQQqAfs2dek/jQPGJq
 H6rN6EtjnpTfmAu6NnFLey8X8/oX/VKw=
X-Gm-Gg: AR+sD10z9zqkt2To+DcdST4e8rHXWTzTfmcLf7UVzow4CLAVbMwjOeAAL4uTY6HgYZH
 tfN/IN7xXfjEky6uM0FseGlnHn6NuoYi2xsM3pPN16GMqye4DDqRXFIWwu//7YHaufDLWFDwbx4
 LCifaZ9kiyJScwYGzLR090drCfjr1j4u5VCxZYF5c4aLnTC6XtJ6/yR2TR5dBJbhx6YjI47i5p2
 9u8MauVHHIFanmwV/uWjMRvnB/zovr+bwWMAaExfbwiVjdlmdl7I7DnLHq0m4nybNjWrdL+4vXv
 eMFvadloo2tIid0qQio+IAIMBdT7XXGhWrbYKmpw3tUqIiJF7iSd
X-Received: by 2002:a05:6512:1381:b0:5ae:b6cf:2864 with SMTP id
 2adb3069b0e04-5b2f4ae071amr2951461e87.0.1786132797635; Fri, 07 Aug 2026
 12:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <CADZLCw7o5wO=+Zv2a7W9uc9AuiQDM-hEqki95eNfk8pv+L=_=A@mail.gmail.com>
 <CABQX2QNHpUbxT=GdHedVq1+Z0Qp82hYC1saHuHuWNX-0VvoRYw@mail.gmail.com>
 <CADZLCw5Z0ZStQN6HRfk3dZZ3abBVh0A_Ukt-jM4hPGe6NrtUcg@mail.gmail.com>
 <CABQX2QPndJ4xqTuEmDyykVkCPqtWNvRM2EupZvN2gU68j=NfLg@mail.gmail.com>
 <CABQX2QPDgdMtpvV6BQH1cQFsh3rT65G7ty_FB=+2FzqcMy117Q@mail.gmail.com>
In-Reply-To: <CABQX2QPDgdMtpvV6BQH1cQFsh3rT65G7ty_FB=+2FzqcMy117Q@mail.gmail.com>
From: =?UTF-8?B?0JTQuNC80LAg0JTRjNGP0YfQutC+0LI=?= <das.ogi4i@gmail.com>
Date: Fri, 7 Aug 2026 22:59:46 +0300
X-Gm-Features: AUfX_mwSPw-szZJhyc9iRflpYHLdw5aHlOavCO2L3MYzG-s0pEwj9T469QmxXEc
Message-ID: <CADZLCw7gop8XNQxRnrJYP+vFjDnivoXrNfNikr-2u=JNcHYCEg@mail.gmail.com>
Subject: Re: [BUG] drm/vmwgfx: vmw_cmdbuf_alloc leaks ~103 MiB/day via fbdev
 damage worker
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, ian.forbes@broadcom.com, 
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
 tzimmermann@suse.de,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: multipart/alternative; boundary="000000000000ecc2ff06587a720b"
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

--000000000000ecc2ff06587a720b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Confirmed - i915 is the cause.

Booted with modprobe.blacklist=3Di915, everything else identical
(cursor_blink=3D1, vtcon0 bound, same guest):

vmwgfx COMMAND stays 0007 (I/O+ Mem+), no "VGA decodes changed" in dmesg
0 blocks / 600 s
inline cmdbuf pool: 1 in use, 4 capacity, 1 page

Normal boot, for comparison:

vmwgfx COMMAND 0004 (I/O- Mem-, all three BARs [disabled])
2931 blocks / 600 s =3D 4.885/sec
inline cmdbuf pool: 66041 in use, 66044 capacity, 16511 pages

Four measurements, same 600 s window and method, cursor_blink=3D1 throughou=
t:

i915 loaded, COMMAND 0004 (as i915 leaves it) : 4.885/sec
i915 rmmod'd after boot, COMMAND 0004 : 4.882/sec
i915 loaded, COMMAND forced to 0007 via setpci : 4.882/sec
i915 blacklisted from boot, COMMAND 0007 : 0.000/sec

The third line is the one I did not expect: restoring the decode bits at
runtime does not stop the leak, and neither does unloading i915. So the
damage is not simply "decode is off right now" - once vmwgfx has been
through the arbiter interaction it stays broken even after I/O+Mem come
back. Only never clearing them works.

That rules out setpci as a workaround, and is consistent with
cc6ed470caa2 being the right fix since it prevents the clearing rather
than repairing it.

Full logs, both boots:
https://www.google.com/url?q=3Dhttps://gist.github.com/oGi4i/c7c4ffcb9726df=
7bba4bca5835fbfd66&source=3Dgmail&ust=3D1786219041539000&sa=3DE

Guest: Debian 13, kernel 6.12.101+deb13-amd64, ESXi 8.0.3 build-25205.
i915 is a passed-through CoffeeLake UHD 630 (8086:3e92).

cc6ed470caa2 is not in 6.12.y - by my reading it first appears in v7.1.
Ville, would you consider a backport to 6.12.y? Happy to test a patch
here; the reproducer is continuous and I can toggle it with cursor_blink.

On Fri, Aug 07, 2026 07:16 AM, Zack Rusin <zack.rusin@broadcom.com> wrote:

> On Thu, Aug 6, 2026 at 12:08=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.c=
om>
> wrote:
> >
> > Sorry, are you using llm for replies? The email starts with multiple
> > paragraphs just to say, "Oh, yeah,", which, as a human, makes it
> > difficult to communicate :) If you could provide the data/logs and let
> > us do the analysis then it's just going to go a lot smoother. Can you
> > upload your logs somewhere? They haven't gone through. If you could
> > upload your vmware.log and the guest system log somewhere (some
> > pastebin is fine) that would be great.
> >
> > z
> >
> > On Wed, Aug 5, 2026 at 5:29=E2=80=AFPM =D0=94=D0=B8=D0=BC=D0=B0 =D0=94=
=D1=8C=D1=8F=D1=87=D0=BA=D0=BE=D0=B2 <das.ogi4i@gmail.com> wrote:
> > >
> > > On Wed, Aug 5, 2026 at 10:36 PM Zack Rusin <zack.rusin@broadcom.com>
> wrote:
> > >
> > > Thanks both. Answers inline, but one thing up front:
> > >
> > > **The pools request revised the severity. The leak is ~5x larger than
> > > I reported.** Each leaked command buffer holds a 1024-byte DMA pool
> > > block in addition to the 256-byte kmalloc header, and DMA pool memory
> > > is not accounted in SUnreclaim - so every measurement in my original
> > > report was blind to 80% of it. Corrected figure is ~516 MiB/day, not
> > > ~103 MiB/day. Detail below.
> > >
> > > > Could you send us the full system log? (ideally journalctl -b, if n=
ot
> > > > then, dmesg, or /var/log/kern.lorg). I suspect you have some comman=
d
> > > > buffer errors in the kernel log that are causing this.
> > >
> > > No command buffer errors - the log is clean. Full journalctl -b and
> > > dmesg are attached/available on request, but the summary is:
> > >
> > > - 19 vmwgfx lines total, all at boot (t=3D3.84-3.91s), all
> > > informational. Nothing from vmwgfx after that at all.
> > > - Zero vmwgfx errors, warnings, or *ERROR* lines.
> > > - The only DRM error anywhere is "i915 *ERROR* PPS state mismatch",
> > > from a passed-through Intel GPU used for video transcoding. Not
> > > vmwgfx, and present from boot regardless of the leak.
> > > - 5 call traces in dmesg, all of them cgroup OOM kills of a
> > > kube-state-metrics pod hitting its own memory limit. Unrelated
> > > (and since fixed).
> > >
> > > One boot line is relevant though, since it confirms the allocator:
> > >
> > > [drm] Using command buffers with DMA pool.
> > >
> > > So the pool is being used as intended - it is only the release side
> > > that never happens, silently.
> > >
> > > > Based on your analysis disabling the cursor_blink is probably a
> > > > better workaround, i.e. "echo 0 >
> /sys/class/graphics/fbcon/cursor_blink"
> > >
> > > Confirmed, and it identifies the exact driver. Measured over 600s
> > > windows by watching the vmw_cmdbuf_alloc live-object count in
> > > /sys/kernel/debug/slab/kmalloc-256/alloc_traces:
> > >
> > > cursor_blink=3D1 : 4.887 obj/sec (2932 objects / 600 s)
> > > cursor_blink=3D0 : 0.003 obj/sec (2 objects / 600 s)
> > >
> > > A ~1600x reduction; effectively zero.
> > >
> > > The rate pins the mechanism precisely. fbcon's cursor timer runs at
> > > HZ/5, and this kernel is CONFIG_HZ=3D250, so 50 jiffies =3D 200 ms =
=3D 5.0
> > > Hz. Measured 4.887 Hz. That is **one leaked command buffer per cursor
> > > blink tick**, with the small shortfall being scheduler jitter. It als=
o
> > > agrees with the 4.89 obj/sec I derived independently from the age=3D
> > > field in my first mail.
> > >
> > > So on a completely idle headless guest, the blinking cursor alone
> > > leaks ~516 MiB/day.
> > >
> > > This is a much better workaround than the ones I listed originally -
> > > it keeps the console fully usable rather than blanking it. Thank you.
> > >
> > > One caveat for anyone else applying it: after an unbind/rebind cycle
> > > of vtcon0 I observed cursor_blink read back 0 while the leak was stil=
l
> > > running at the full 4.887 obj/sec. The attribute appears to
> > > under-report in that state, so it is worth confirming the leak
> > > actually stopped rather than trusting the read-back.
> > >
> > > > Besides the system logs i'd be also intersted in pool info, i.e. ca=
t
> > > > /sys/bus/pci/devices/<vmwgfx card id>/pools .
> > >
> > > This is the interesting one.
> > >
> > > $ cat /sys/bus/pci/devices/0000:00:0f.0/pools
> > > poolinfo - 0.1
> > > vmwgfx inline cmdbuf 53875 53876 1024 13469
> > > vmwgfx cmdbuf 0 0 64 0
> > >
> > > Read as name / blocks-in-use / capacity / block-size / pages:
> > >
> > > - 53,875 of 53,876 blocks in use - the pool has grown to exactly
> > > accommodate every allocation and sits pinned at ~100% utilisation.
> > > - 13,469 pages =3D 52.6 MiB held. (13469 * 4096/1024 =3D 53876, which
> > > matches the stated capacity, so the reading is self-consistent.)
> > > - The non-inline "vmwgfx cmdbuf" pool is completely empty, so this
> > > is specific to the inline command buffer path.
> > >
> > > Taken at the same moment:
> > >
> > > $ sudo awk '/vmw_cmdbuf_alloc/{print $1; exit}' \
> > > /sys/kernel/debug/slab/kmalloc-256/alloc_traces
> > > 53872
> > >
> > > 53,872 kmalloc-256 headers against 53,875 pool blocks - a difference
> > > of 3, which is just allocations in flight between the two reads. So i=
t
> > > is 1:1: every leaked command buffer pins both a 256-byte header and a
> > > 1024-byte DMA pool block, 1280 bytes total.
> > >
> > > Sanity check: 53,875 blocks / 4.887 per sec =3D 11,024 s =3D 3.06 hou=
rs of
> > > active leaking, which matches the accumulated time the console was
> > > bound on this boot.
> > >
> > > Since dma_pool memory comes from dma_alloc_coherent rather than the
> > > slab allocator, none of it appears in SUnreclaim. That is why my
> > > original 103 MiB/day figure was low by 5x - it only ever counted the
> > > kmalloc headers.
> > >
> > > On Wed, Aug 5, 2026 at 8:30 PM Ian Forbes <ian.forbes@broadcom.com>
> wrote:
> > > >
> > > > Please recompile with KMEMLEAK and/or KASAN and share any output.
> > >
> > > If the additional info provided is not enough, then I will recompile.
> > > Two notes on how I plan to do it:
> > >
> > > Debian ships neither CONFIG_DEBUG_KMEMLEAK nor CONFIG_KASAN, so this
> > > needs a custom build. I will do it in a clean throwaway Debian VM
> > > rather than on the host I reported from, for two reasons:
> > >
> > > 1. That host runs ZFS via DKMS, so its kernel is tainted
> > > (P/O/E). A report from an untainted kernel with nothing but
> > > Debian base installed is worth more, and removes any question
> > > about whether ZFS, Kubernetes or the passed-through i915 are
> > > involved.
> > > 2. KASAN's memory overhead is not viable on that host, but is fine
> > > on a bare VM.
> > >
> > > I will send kmemleak output, and KASAN separately if it turns up
> > > anything - though since kmemleak reports unreferenced allocations and
> > > KASAN reports memory errors, I expect kmemleak is the relevant one
> > > here unless you suspect corruption in the release path.
> > >
> > > Happy to test patches in the meantime; the reproducer is a stock
> > > Debian VMware guest with a text console, and I can toggle the leak on
> > > and off with cursor_blink.
> > >
> > > Thanks, Dmitry
> > >
> > >
> > > =D1=81=D1=80, 5 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 22:36=
, Zack Rusin <zack.rusin@broadcom.com>:
> > > >
> > > > On Wed, Aug 5, 2026 at 12:59=E2=80=AFPM =D0=94=D0=B8=D0=BC=D0=B0 =
=D0=94=D1=8C=D1=8F=D1=87=D0=BA=D0=BE=D0=B2 <das.ogi4i@gmail.com>
> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I have a reproducible, quantified kernel memory leak in vmwgfx on
> a headless
> > > > > VMware guest. It is attributed to a specific call site with
> slab_debug, and I
> > > > > have a clean causal test that stops it. I could not find this
> reported anywhere
> > > > > - I searched the dri-devel archives, the mainline and 6.12.y git
> logs, and the
> > > > > distro trackers.
> > > > >
> > > > > Summary
> > > > > =3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > On a headless VMware guest with the text console bound to the
> vmwgfx
> > > > > framebuffer, the fbdev-emulation damage worker issues a full
> atomic commit for
> > > > > every console damage event, and vmwgfx leaks a command buffer on
> each one. The
> > > > > result is unreclaimable kernel slab growing linearly at ~103
> MiB/day, never
> > > > > reclaimed under memory pressure, released only by reboot.
> > > > >
> > > > > Environment
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > Kernel: 6.12.100+deb13-amd64 (Debian 13 stock, tracks 6.12.y)
> > > > > Guest: VMware Virtual Platform, BIOS 6.00; vmwgfx drives the
> virtual display
> > > > > Console: headless, administered over SSH; a single agetty on the
> console
> > > > > fb0: vmwgfxdrmfb
> > > > > vtcon0: "(M) frame buffer device", bind=3D1
> > > > > Config: CONFIG_HZ=3D250, CONFIG_SLUB_DEBUG=3Dy, CONFIG_STACKDEPOT=
=3Dy
> > > > > (CONFIG_DEBUG_KMEMLEAK is not set in Debian's kernel)
> > > > >
> > > > > i915 is also loaded on this host (a passed-through GPU used for
> video
> > > > > transcoding) but is unrelated - the console framebuffer is vmwgfx=
.
> > > > >
> > > > > Symptom
> > > > > =3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > SUnreclaim grows linearly at ~103 MiB/day and is never reclaimed
> under pressure.
> > > > > The growth is confined to the plain kmalloc-256 cache - notably
> *not*
> > > > > kmalloc-cg-256, so it is plain GFP_KERNEL from an in-kernel
> allocator rather
> > > > > than anything cgroup-accounted.
> > > > >
> > > > > Attribution
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > Booted with slab_debug=3DU,kmalloc-256, then read
> > > > > /sys/kernel/debug/slab/kmalloc-256/alloc_traces, which ranks by
> live object
> > > > > count:
> > > > >
> > > > > 41025 vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx] waste=3D328200/8
> age=3D254700/1301825/2351179 pid=3D9-208926 cpus=3D0-5
> > > > > vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx]
> > > > > vmw_cmdbuf_reserve+0x142/0x170 [vmwgfx]
> > > > > vmw_cmd_ctx_reserve+0x24/0x60 [vmwgfx]
> > > > > vmw_stdu_bind_st+0x6b/0x100 [vmwgfx]
> > > > > vmw_stdu_primary_plane_atomic_update+0xa8/0x1d0 [vmwgfx]
> > > > > drm_atomic_helper_commit_planes+0x112/0x320 [drm_kms_helper]
> > > > > drm_atomic_helper_commit_tail+0x48/0x90 [drm_kms_helper]
> > > > > vmw_atomic_commit_tail+0x1b/0x80 [vmwgfx]
> > > > > commit_tail+0x91/0x130 [drm_kms_helper]
> > > > > drm_atomic_helper_commit+0x11a/0x140 [drm_kms_helper]
> > > > > drm_atomic_commit+0xa9/0xe0 [drm]
> > > > > drm_atomic_helper_dirtyfb+0x1c6/0x2a0 [drm_kms_helper]
> > > > > drm_fbdev_ttm_helper_fb_dirty+0x216/0x310 [drm_ttm_helper]
> > > > > drm_fb_helper_damage_work+0x94/0x170 [drm_kms_helper]
> > > > > process_one_work+0x174/0x330
> > > > > worker_thread+0x191/0x2f0
> > > > >
> > > > > The next-largest entry in that cache held 1056 objects - this one
> is ~30x
> > > > > everything else combined.
> > > > >
> > > > > Quantitative confirmation
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > >
> > > > > With CONFIG_HZ=3D250, from the age=3Dmin/avg/max field above:
> > > > >
> > > > > - max age 2,351,179 jiffies =3D 9405 s =3D the full uptime at tim=
e of
> reading
> > > > > - avg age is almost exactly half of max, which is the signature o=
f
> uniform
> > > > > allocation with zero frees
> > > > > - 41,025 objects over the 8386 s during which allocation was acti=
ve
> > > > > =3D 4.89 objects/sec =3D 4.30 MiB/h =3D ~103 MiB/day
> > > > >
> > > > > That matches the independently measured SUnreclaim growth rate to
> within noise.
> > > > >
> > > > > Causal test
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > Unbinding the text console from the framebuffer stops it instantl=
y:
> > > > >
> > > > > # echo 0 > /sys/class/vtconsole/vtcon0/bind
> > > > >
> > > > > After that, the minimum object age jumped from 26 jiffies to
> 254,700 and kept
> > > > > climbing - i.e. no new allocations at all. SUnreclaim also droppe=
d
> ~93 MiB
> > > > > immediately as the fbdev shadow buffer was released, and has been
> flat-to-
> > > > > falling since.
> > > > >
> > > > > Two things I checked so you don't have to
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > This is not a recent regression.
> drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c has had
> > > > > no functional change between v6.12 and current mainline - only th=
e
> command
> > > > > buffer ID addition (922f9de) and the treewide kmalloc ->
> kmalloc_obj
> > > > > conversions. vmwgfx_stdu.c is similarly untouched in the relevant
> paths, and
> > > > > nothing in the 6.12.y stable series touches cmdbuf, damage or
> dirtyfb handling.
> > > > > So this looks long-standing rather than newly introduced.
> > > > >
> > > > > It is also not caused by the fbdev-ttm conversion, which is the
> obvious suspect
> > > > > given the stack. drm_fbdev_ttm was a pure rename of
> drm_fbdev_generic
> > > > > (aae4682e5d66, v6.10), and vmwgfx has used the generic DRM fbdev
> emulation since
> > > > > v6.2 (df42523c12f8, which deleted vmwgfx_fb.c). What did change a=
t
> v6.2 is that
> > > > > console damage now goes through a full atomic commit, which the o=
ld
> > > > > vmwgfx_fb.c did not do - but the leak itself is on the vmwgfx sid=
e.
> > > > >
> > > > > Possibly related
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > There is an open, unresolved report of a different vmwgfx leak in
> the same
> > > > > atomic-commit path - Yuma Kakei, 12 Mar 2026, "[BUG] vmwgfx:
> Severe Slab memory
> > > > > leak (radix_tree_node) with Wayland Atomic KMS" (kernels 6.17 /
> 7.0-rc3, KWin
> > > > > Wayland with Atomic KMS, stops with KWIN_DRM_NO_AMS=3D1). Ian For=
bes
> proposed a
> > > > > patch; the reporter confirmed on 15 Mar 2026 that it did not fix
> it.
> > > > >
> > > > > I do *not* claim these are the same bug - different slab caches,
> different
> > > > > trigger, different kernels. But both are vmwgfx leaking on every
> atomic commit
> > > > > and stopping dead when the atomic path stops, so they may share a
> root cause.
> > > > >
> > > > > Workarounds
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > - echo 0 > /sys/class/vtconsole/vtcon0/bind
> > > > > runtime, reversible, stops it immediately
> > > > >
> > > > > - drm_kms_helper.fbdev_emulation=3D0 on the kernel command line
> > > > > cleaner for a headless host; disables fbdev emulation outright so
> no
> > > > > damage worker exists. Must be set at boot.
> > > > >
> > > > > - modprobe.blacklist=3Dvmwgfx
> > > > > heavy-handed; loses all console output
> > > > >
> > > > > All three cost the virtual console, which is fine headless but is
> not a general
> > > > > fix.
> > > > >
> > > > > Happy to test patches, run instrumented kernels, or provide
> further data - the
> > > > > system reproduces this continuously and I can rebind the console
> at will to
> > > > > toggle it on and off.
> > > > >
> > > > > Thanks, Dmitry
> > > >
> > > > Could you send us the full system log? (ideally journalctl -b, if n=
ot
> > > > then, dmesg, or /var/log/kern.lorg). I suspect you have some comman=
d
> > > > buffer errors in the kernel log that are causing this. Based on you=
r
> > > > analysis disabling the cursor_blink is probably a better workaround=
,
> > > > i.e. "echo 0 > /sys/class/graphics/fbcon/cursor_blink" . Besides th=
e
> > > > system logs i'd be also intersted in pool info, i.e. cat
> > > > /sys/bus/pci/devices/<vmwgfx card id>/pools .
>
> From the vmware.log that I was sent in private what is happening is
> that when the i915 driver that you passthrough to the vm loads, it
> takes the VGA arbiter, the abiter clears the io mem on vmwgfx and
> never restores it. So vmwgfx is broken by the loaded i915 driver
> because our communication channel to the device is wiped from
> underneath us. We keep queueing cb's and can't free them because we're
> waiting for some kind of notification from the device that it
> processed them but that will never happen.
>
> I think upstream commit cc6ed470caa2 (=E2=80=9Cdrm/i915/vga: Avoid VGA ar=
biter
> during intel_vga_disable() for iGPUs=E2=80=9D)
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dcc6ed470caa2
> will fix this. You can give it a try and if it fixes it for you, you
> can ask Ville for a backport.
>
> z
>

--000000000000ecc2ff06587a720b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"auto">Confirmed - i915 is the cause.<br><=
br>Booted with modprobe.blacklist=3Di915, everything else identical<br>(cur=
sor_blink=3D1, vtcon0 bound, same guest):<br><br>  vmwgfx COMMAND stays 000=
7 (I/O+ Mem+), no &quot;VGA decodes changed&quot; in dmesg<br>  0 blocks / =
600 s<br>  inline cmdbuf pool: 1 in use, 4 capacity, 1 page<br><br>Normal b=
oot, for comparison:<br><br>  vmwgfx COMMAND 0004 (I/O- Mem-, all three BAR=
s [disabled])<br>  2931 blocks / 600 s =3D 4.885/sec<br>  inline cmdbuf poo=
l: 66041 in use, 66044 capacity, 16511 pages<br><br>Four measurements, same=
 600 s window and method, cursor_blink=3D1 throughout:<br><br>  i915 loaded=
, COMMAND 0004 (as i915 leaves it)   : 4.885/sec<br>  i915 rmmod&#39;d afte=
r boot, COMMAND 0004           : 4.882/sec<br>  i915 loaded, COMMAND forced=
 to 0007 via setpci  : 4.882/sec<br>  i915 blacklisted from boot, COMMAND 0=
007        : 0.000/sec<br><br>The third line is the one I did not expect: r=
estoring the decode bits at<br>runtime does not stop the leak, and neither =
does unloading i915. So the<br>damage is not simply &quot;decode is off rig=
ht now&quot; - once vmwgfx has been<br>through the arbiter interaction it s=
tays broken even after I/O+Mem come<br>back. Only never clearing them works=
.<br><br>That rules out setpci as a workaround, and is consistent with<br>c=
c6ed470caa2 being the right fix since it prevents the clearing rather<br>th=
an repairing it.<br><br>Full logs, both boots: <a href=3D"https://www.googl=
e.com/url?q=3Dhttps://gist.github.com/oGi4i/c7c4ffcb9726df7bba4bca5835fbfd6=
6&amp;source=3Dgmail&amp;ust=3D1786219041539000&amp;sa=3DE" target=3D"_blan=
k">https://www.google.com/url?q=3Dhttps://gist.github.com/oGi4i/c7c4ffcb972=
6df7bba4bca5835fbfd66&amp;source=3Dgmail&amp;ust=3D1786219041539000&amp;sa=
=3DE</a><br><br>Guest: Debian 13, kernel 6.12.101+deb13-amd64, ESXi 8.0.3 b=
uild-25205.<br>i915 is a passed-through CoffeeLake UHD 630 (8086:3e92).<br>=
<br>cc6ed470caa2 is not in 6.12.y - by my reading it first appears in v7.1.=
<br>Ville, would you consider a backport to 6.12.y? Happy to test a patch<b=
r>here; the reproducer is continuous and I can toggle it with cursor_blink.=
<br></div></div></div><br><div class=3D"gmail_extra"><div>On Fri, Aug 07, 2=
026 07:16 AM, Zack Rusin &lt;<a href=3D"mailto:zack.rusin@broadcom.com" tar=
get=3D"_blank">zack.rusin@broadcom.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Thu, Aug 6, 2026 at 12:08=E2=80=AFAM Za=
ck Rusin &lt;<a href=3D"mailto:zack.rusin@broadcom.com" target=3D"_blank">z=
ack.rusin@broadcom.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Sorry, are you using llm for replies? The email starts with multiple<b=
r>
&gt; paragraphs just to say, &quot;Oh, yeah,&quot;, which, as a human, make=
s it<br>
&gt; difficult to communicate :) If you could provide the data/logs and let=
<br>
&gt; us do the analysis then it&#39;s just going to go a lot smoother. Can =
you<br>
&gt; upload your logs somewhere? They haven&#39;t gone through. If you coul=
d<br>
&gt; upload your vmware.log and the guest system log somewhere (some<br>
&gt; pastebin is fine) that would be great.<br>
&gt;<br>
&gt; z<br>
&gt;<br>
&gt; On Wed, Aug 5, 2026 at 5:29=E2=80=AFPM =D0=94=D0=B8=D0=BC=D0=B0 =D0=94=
=D1=8C=D1=8F=D1=87=D0=BA=D0=BE=D0=B2 &lt;<a href=3D"mailto:das.ogi4i@gmail.=
com" target=3D"_blank">das.ogi4i@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Aug 5, 2026 at 10:36 PM Zack Rusin &lt;<a href=3D"mailto:=
zack.rusin@broadcom.com" target=3D"_blank">zack.rusin@broadcom.com</a>&gt; =
wrote:<br>
&gt; &gt;<br>
&gt; &gt; Thanks both. Answers inline, but one thing up front:<br>
&gt; &gt;<br>
&gt; &gt; **The pools request revised the severity. The leak is ~5x larger =
than<br>
&gt; &gt; I reported.** Each leaked command buffer holds a 1024-byte DMA po=
ol<br>
&gt; &gt; block in addition to the 256-byte kmalloc header, and DMA pool me=
mory<br>
&gt; &gt; is not accounted in SUnreclaim - so every measurement in my origi=
nal<br>
&gt; &gt; report was blind to 80% of it. Corrected figure is ~516 MiB/day, =
not<br>
&gt; &gt; ~103 MiB/day. Detail below.<br>
&gt; &gt;<br>
&gt; &gt; &gt; Could you send us the full system log? (ideally journalctl -=
b, if not<br>
&gt; &gt; &gt; then, dmesg, or /var/log/kern.lorg). I suspect you have some=
 command<br>
&gt; &gt; &gt; buffer errors in the kernel log that are causing this.<br>
&gt; &gt;<br>
&gt; &gt; No command buffer errors - the log is clean. Full journalctl -b a=
nd<br>
&gt; &gt; dmesg are attached/available on request, but the summary is:<br>
&gt; &gt;<br>
&gt; &gt; - 19 vmwgfx lines total, all at boot (t=3D3.84-3.91s), all<br>
&gt; &gt; informational. Nothing from vmwgfx after that at all.<br>
&gt; &gt; - Zero vmwgfx errors, warnings, or *ERROR* lines.<br>
&gt; &gt; - The only DRM error anywhere is &quot;i915 *ERROR* PPS state mis=
match&quot;,<br>
&gt; &gt; from a passed-through Intel GPU used for video transcoding. Not<b=
r>
&gt; &gt; vmwgfx, and present from boot regardless of the leak.<br>
&gt; &gt; - 5 call traces in dmesg, all of them cgroup OOM kills of a<br>
&gt; &gt; kube-state-metrics pod hitting its own memory limit. Unrelated<br=
>
&gt; &gt; (and since fixed).<br>
&gt; &gt;<br>
&gt; &gt; One boot line is relevant though, since it confirms the allocator=
:<br>
&gt; &gt;<br>
&gt; &gt; [drm] Using command buffers with DMA pool.<br>
&gt; &gt;<br>
&gt; &gt; So the pool is being used as intended - it is only the release si=
de<br>
&gt; &gt; that never happens, silently.<br>
&gt; &gt;<br>
&gt; &gt; &gt; Based on your analysis disabling the cursor_blink is probabl=
y a<br>
&gt; &gt; &gt; better workaround, i.e. &quot;echo 0 &gt; /sys/class/graphic=
s/fbcon/cursor_blink&quot;<br>
&gt; &gt;<br>
&gt; &gt; Confirmed, and it identifies the exact driver. Measured over 600s=
<br>
&gt; &gt; windows by watching the vmw_cmdbuf_alloc live-object count in<br>
&gt; &gt; /sys/kernel/debug/slab/kmalloc-256/alloc_traces:<br>
&gt; &gt;<br>
&gt; &gt; cursor_blink=3D1 : 4.887 obj/sec (2932 objects / 600 s)<br>
&gt; &gt; cursor_blink=3D0 : 0.003 obj/sec (2 objects / 600 s)<br>
&gt; &gt;<br>
&gt; &gt; A ~1600x reduction; effectively zero.<br>
&gt; &gt;<br>
&gt; &gt; The rate pins the mechanism precisely. fbcon&#39;s cursor timer r=
uns at<br>
&gt; &gt; HZ/5, and this kernel is CONFIG_HZ=3D250, so 50 jiffies =3D 200 m=
s =3D 5.0<br>
&gt; &gt; Hz. Measured 4.887 Hz. That is **one leaked command buffer per cu=
rsor<br>
&gt; &gt; blink tick**, with the small shortfall being scheduler jitter. It=
 also<br>
&gt; &gt; agrees with the 4.89 obj/sec I derived independently from the age=
=3D<br>
&gt; &gt; field in my first mail.<br>
&gt; &gt;<br>
&gt; &gt; So on a completely idle headless guest, the blinking cursor alone=
<br>
&gt; &gt; leaks ~516 MiB/day.<br>
&gt; &gt;<br>
&gt; &gt; This is a much better workaround than the ones I listed originall=
y -<br>
&gt; &gt; it keeps the console fully usable rather than blanking it. Thank =
you.<br>
&gt; &gt;<br>
&gt; &gt; One caveat for anyone else applying it: after an unbind/rebind cy=
cle<br>
&gt; &gt; of vtcon0 I observed cursor_blink read back 0 while the leak was =
still<br>
&gt; &gt; running at the full 4.887 obj/sec. The attribute appears to<br>
&gt; &gt; under-report in that state, so it is worth confirming the leak<br=
>
&gt; &gt; actually stopped rather than trusting the read-back.<br>
&gt; &gt;<br>
&gt; &gt; &gt; Besides the system logs i&#39;d be also intersted in pool in=
fo, i.e. cat<br>
&gt; &gt; &gt; /sys/bus/pci/devices/&lt;vmwgfx card id&gt;/pools .<br>
&gt; &gt;<br>
&gt; &gt; This is the interesting one.<br>
&gt; &gt;<br>
&gt; &gt; $ cat /sys/bus/pci/devices/0000:00:0f.0/pools<br>
&gt; &gt; poolinfo - 0.1<br>
&gt; &gt; vmwgfx inline cmdbuf 53875 53876 1024 13469<br>
&gt; &gt; vmwgfx cmdbuf 0 0 64 0<br>
&gt; &gt;<br>
&gt; &gt; Read as name / blocks-in-use / capacity / block-size / pages:<br>
&gt; &gt;<br>
&gt; &gt; - 53,875 of 53,876 blocks in use - the pool has grown to exactly<=
br>
&gt; &gt; accommodate every allocation and sits pinned at ~100% utilisation=
.<br>
&gt; &gt; - 13,469 pages =3D 52.6 MiB held. (13469 * 4096/1024 =3D 53876, w=
hich<br>
&gt; &gt; matches the stated capacity, so the reading is self-consistent.)<=
br>
&gt; &gt; - The non-inline &quot;vmwgfx cmdbuf&quot; pool is completely emp=
ty, so this<br>
&gt; &gt; is specific to the inline command buffer path.<br>
&gt; &gt;<br>
&gt; &gt; Taken at the same moment:<br>
&gt; &gt;<br>
&gt; &gt; $ sudo awk &#39;/vmw_cmdbuf_alloc/{print $1; exit}&#39; \<br>
&gt; &gt; /sys/kernel/debug/slab/kmalloc-256/alloc_traces<br>
&gt; &gt; 53872<br>
&gt; &gt;<br>
&gt; &gt; 53,872 kmalloc-256 headers against 53,875 pool blocks - a differe=
nce<br>
&gt; &gt; of 3, which is just allocations in flight between the two reads. =
So it<br>
&gt; &gt; is 1:1: every leaked command buffer pins both a 256-byte header a=
nd a<br>
&gt; &gt; 1024-byte DMA pool block, 1280 bytes total.<br>
&gt; &gt;<br>
&gt; &gt; Sanity check: 53,875 blocks / 4.887 per sec =3D 11,024 s =3D 3.06=
 hours of<br>
&gt; &gt; active leaking, which matches the accumulated time the console wa=
s<br>
&gt; &gt; bound on this boot.<br>
&gt; &gt;<br>
&gt; &gt; Since dma_pool memory comes from dma_alloc_coherent rather than t=
he<br>
&gt; &gt; slab allocator, none of it appears in SUnreclaim. That is why my<=
br>
&gt; &gt; original 103 MiB/day figure was low by 5x - it only ever counted =
the<br>
&gt; &gt; kmalloc headers.<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Aug 5, 2026 at 8:30 PM Ian Forbes &lt;<a href=3D"mailto:i=
an.forbes@broadcom.com" target=3D"_blank">ian.forbes@broadcom.com</a>&gt; w=
rote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please recompile with KMEMLEAK and/or KASAN and share any ou=
tput.<br>
&gt; &gt;<br>
&gt; &gt; If the additional info provided is not enough, then I will recomp=
ile.<br>
&gt; &gt; Two notes on how I plan to do it:<br>
&gt; &gt;<br>
&gt; &gt; Debian ships neither CONFIG_DEBUG_KMEMLEAK nor CONFIG_KASAN, so t=
his<br>
&gt; &gt; needs a custom build. I will do it in a clean throwaway Debian VM=
<br>
&gt; &gt; rather than on the host I reported from, for two reasons:<br>
&gt; &gt;<br>
&gt; &gt; 1. That host runs ZFS via DKMS, so its kernel is tainted<br>
&gt; &gt; (P/O/E). A report from an untainted kernel with nothing but<br>
&gt; &gt; Debian base installed is worth more, and removes any question<br>
&gt; &gt; about whether ZFS, Kubernetes or the passed-through i915 are<br>
&gt; &gt; involved.<br>
&gt; &gt; 2. KASAN&#39;s memory overhead is not viable on that host, but is=
 fine<br>
&gt; &gt; on a bare VM.<br>
&gt; &gt;<br>
&gt; &gt; I will send kmemleak output, and KASAN separately if it turns up<=
br>
&gt; &gt; anything - though since kmemleak reports unreferenced allocations=
 and<br>
&gt; &gt; KASAN reports memory errors, I expect kmemleak is the relevant on=
e<br>
&gt; &gt; here unless you suspect corruption in the release path.<br>
&gt; &gt;<br>
&gt; &gt; Happy to test patches in the meantime; the reproducer is a stock<=
br>
&gt; &gt; Debian VMware guest with a text console, and I can toggle the lea=
k on<br>
&gt; &gt; and off with cursor_blink.<br>
&gt; &gt;<br>
&gt; &gt; Thanks, Dmitry<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; =D1=81=D1=80, 5 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 2=
2:36, Zack Rusin &lt;<a href=3D"mailto:zack.rusin@broadcom.com" target=3D"_=
blank">zack.rusin@broadcom.com</a>&gt;:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Aug 5, 2026 at 12:59=E2=80=AFPM =D0=94=D0=B8=D0=BC=
=D0=B0 =D0=94=D1=8C=D1=8F=D1=87=D0=BA=D0=BE=D0=B2 &lt;<a href=3D"mailto:das=
.ogi4i@gmail.com" target=3D"_blank">das.ogi4i@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I have a reproducible, quantified kernel memory leak in=
 vmwgfx on a headless<br>
&gt; &gt; &gt; &gt; VMware guest. It is attributed to a specific call site =
with slab_debug, and I<br>
&gt; &gt; &gt; &gt; have a clean causal test that stops it. I could not fin=
d this reported anywhere<br>
&gt; &gt; &gt; &gt; - I searched the dri-devel archives, the mainline and 6=
.12.y git logs, and the<br>
&gt; &gt; &gt; &gt; distro trackers.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Summary<br>
&gt; &gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On a headless VMware guest with the text console bound =
to the vmwgfx<br>
&gt; &gt; &gt; &gt; framebuffer, the fbdev-emulation damage worker issues a=
 full atomic commit for<br>
&gt; &gt; &gt; &gt; every console damage event, and vmwgfx leaks a command =
buffer on each one. The<br>
&gt; &gt; &gt; &gt; result is unreclaimable kernel slab growing linearly at=
 ~103 MiB/day, never<br>
&gt; &gt; &gt; &gt; reclaimed under memory pressure, released only by reboo=
t.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Environment<br>
&gt; &gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Kernel: 6.12.100+deb13-amd64 (Debian 13 stock, tracks 6=
.12.y)<br>
&gt; &gt; &gt; &gt; Guest: VMware Virtual Platform, BIOS 6.00; vmwgfx drive=
s the virtual display<br>
&gt; &gt; &gt; &gt; Console: headless, administered over SSH; a single aget=
ty on the console<br>
&gt; &gt; &gt; &gt; fb0: vmwgfxdrmfb<br>
&gt; &gt; &gt; &gt; vtcon0: &quot;(M) frame buffer device&quot;, bind=3D1<b=
r>
&gt; &gt; &gt; &gt; Config: CONFIG_HZ=3D250, CONFIG_SLUB_DEBUG=3Dy, CONFIG_=
STACKDEPOT=3Dy<br>
&gt; &gt; &gt; &gt; (CONFIG_DEBUG_KMEMLEAK is not set in Debian&#39;s kerne=
l)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; i915 is also loaded on this host (a passed-through GPU =
used for video<br>
&gt; &gt; &gt; &gt; transcoding) but is unrelated - the console framebuffer=
 is vmwgfx.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Symptom<br>
&gt; &gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; SUnreclaim grows linearly at ~103 MiB/day and is never =
reclaimed under pressure.<br>
&gt; &gt; &gt; &gt; The growth is confined to the plain kmalloc-256 cache -=
 notably *not*<br>
&gt; &gt; &gt; &gt; kmalloc-cg-256, so it is plain GFP_KERNEL from an in-ke=
rnel allocator rather<br>
&gt; &gt; &gt; &gt; than anything cgroup-accounted.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Attribution<br>
&gt; &gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Booted with slab_debug=3DU,kmalloc-256, then read<br>
&gt; &gt; &gt; &gt; /sys/kernel/debug/slab/kmalloc-256/alloc_traces, which =
ranks by live object<br>
&gt; &gt; &gt; &gt; count:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; 41025 vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx] waste=3D3282=
00/8 age=3D254700/1301825/2351179 pid=3D9-208926 cpus=3D0-5<br>
&gt; &gt; &gt; &gt; vmw_cmdbuf_alloc+0x40/0x200 [vmwgfx]<br>
&gt; &gt; &gt; &gt; vmw_cmdbuf_reserve+0x142/0x170 [vmwgfx]<br>
&gt; &gt; &gt; &gt; vmw_cmd_ctx_reserve+0x24/0x60 [vmwgfx]<br>
&gt; &gt; &gt; &gt; vmw_stdu_bind_st+0x6b/0x100 [vmwgfx]<br>
&gt; &gt; &gt; &gt; vmw_stdu_primary_plane_atomic_update+0xa8/0x1d0 [vmwgfx=
]<br>
&gt; &gt; &gt; &gt; drm_atomic_helper_commit_planes+0x112/0x320 [drm_kms_he=
lper]<br>
&gt; &gt; &gt; &gt; drm_atomic_helper_commit_tail+0x48/0x90 [drm_kms_helper=
]<br>
&gt; &gt; &gt; &gt; vmw_atomic_commit_tail+0x1b/0x80 [vmwgfx]<br>
&gt; &gt; &gt; &gt; commit_tail+0x91/0x130 [drm_kms_helper]<br>
&gt; &gt; &gt; &gt; drm_atomic_helper_commit+0x11a/0x140 [drm_kms_helper]<b=
r>
&gt; &gt; &gt; &gt; drm_atomic_commit+0xa9/0xe0 [drm]<br>
&gt; &gt; &gt; &gt; drm_atomic_helper_dirtyfb+0x1c6/0x2a0 [drm_kms_helper]<=
br>
&gt; &gt; &gt; &gt; drm_fbdev_ttm_helper_fb_dirty+0x216/0x310 [drm_ttm_help=
er]<br>
&gt; &gt; &gt; &gt; drm_fb_helper_damage_work+0x94/0x170 [drm_kms_helper]<b=
r>
&gt; &gt; &gt; &gt; process_one_work+0x174/0x330<br>
&gt; &gt; &gt; &gt; worker_thread+0x191/0x2f0<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The next-largest entry in that cache held 1056 objects =
- this one is ~30x<br>
&gt; &gt; &gt; &gt; everything else combined.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Quantitative confirmation<br>
&gt; &gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; With CONFIG_HZ=3D250, from the age=3Dmin/avg/max field =
above:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; - max age 2,351,179 jiffies =3D 9405 s =3D the full upt=
ime at time of reading<br>
&gt; &gt; &gt; &gt; - avg age is almost exactly half of max, which is the s=
ignature of uniform<br>
&gt; &gt; &gt; &gt; allocation with zero frees<br>
&gt; &gt; &gt; &gt; - 41,025 objects over the 8386 s during which allocatio=
n was active<br>
&gt; &gt; &gt; &gt; =3D 4.89 objects/sec =3D 4.30 MiB/h =3D ~103 MiB/day<br=
>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; That matches the independently measured SUnreclaim grow=
th rate to within noise.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Causal test<br>
&gt; &gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Unbinding the text console from the framebuffer stops i=
t instantly:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; # echo 0 &gt; /sys/class/vtconsole/vtcon0/bind<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; After that, the minimum object age jumped from 26 jiffi=
es to 254,700 and kept<br>
&gt; &gt; &gt; &gt; climbing - i.e. no new allocations at all. SUnreclaim a=
lso dropped ~93 MiB<br>
&gt; &gt; &gt; &gt; immediately as the fbdev shadow buffer was released, an=
d has been flat-to-<br>
&gt; &gt; &gt; &gt; falling since.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Two things I checked so you don&#39;t have to<br>
&gt; &gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; This is not a recent regression. drivers/gpu/drm/vmwgfx=
/vmwgfx_cmdbuf.c has had<br>
&gt; &gt; &gt; &gt; no functional change between v6.12 and current mainline=
 - only the command<br>
&gt; &gt; &gt; &gt; buffer ID addition (922f9de) and the treewide kmalloc -=
&gt; kmalloc_obj<br>
&gt; &gt; &gt; &gt; conversions. vmwgfx_stdu.c is similarly untouched in th=
e relevant paths, and<br>
&gt; &gt; &gt; &gt; nothing in the 6.12.y stable series touches cmdbuf, dam=
age or dirtyfb handling.<br>
&gt; &gt; &gt; &gt; So this looks long-standing rather than newly introduce=
d.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; It is also not caused by the fbdev-ttm conversion, whic=
h is the obvious suspect<br>
&gt; &gt; &gt; &gt; given the stack. drm_fbdev_ttm was a pure rename of drm=
_fbdev_generic<br>
&gt; &gt; &gt; &gt; (aae4682e5d66, v6.10), and vmwgfx has used the generic =
DRM fbdev emulation since<br>
&gt; &gt; &gt; &gt; v6.2 (df42523c12f8, which deleted vmwgfx_fb.c). What di=
d change at v6.2 is that<br>
&gt; &gt; &gt; &gt; console damage now goes through a full atomic commit, w=
hich the old<br>
&gt; &gt; &gt; &gt; vmwgfx_fb.c did not do - but the leak itself is on the =
vmwgfx side.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Possibly related<br>
&gt; &gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; There is an open, unresolved report of a different vmwg=
fx leak in the same<br>
&gt; &gt; &gt; &gt; atomic-commit path - Yuma Kakei, 12 Mar 2026, &quot;[BU=
G] vmwgfx: Severe Slab memory<br>
&gt; &gt; &gt; &gt; leak (radix_tree_node) with Wayland Atomic KMS&quot; (k=
ernels 6.17 / 7.0-rc3, KWin<br>
&gt; &gt; &gt; &gt; Wayland with Atomic KMS, stops with KWIN_DRM_NO_AMS=3D1=
). Ian Forbes proposed a<br>
&gt; &gt; &gt; &gt; patch; the reporter confirmed on 15 Mar 2026 that it di=
d not fix it.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I do *not* claim these are the same bug - different sla=
b caches, different<br>
&gt; &gt; &gt; &gt; trigger, different kernels. But both are vmwgfx leaking=
 on every atomic commit<br>
&gt; &gt; &gt; &gt; and stopping dead when the atomic path stops, so they m=
ay share a root cause.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Workarounds<br>
&gt; &gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; - echo 0 &gt; /sys/class/vtconsole/vtcon0/bind<br>
&gt; &gt; &gt; &gt; runtime, reversible, stops it immediately<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; - drm_kms_helper.fbdev_emulation=3D0 on the kernel comm=
and line<br>
&gt; &gt; &gt; &gt; cleaner for a headless host; disables fbdev emulation o=
utright so no<br>
&gt; &gt; &gt; &gt; damage worker exists. Must be set at boot.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; - modprobe.blacklist=3Dvmwgfx<br>
&gt; &gt; &gt; &gt; heavy-handed; loses all console output<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; All three cost the virtual console, which is fine headl=
ess but is not a general<br>
&gt; &gt; &gt; &gt; fix.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Happy to test patches, run instrumented kernels, or pro=
vide further data - the<br>
&gt; &gt; &gt; &gt; system reproduces this continuously and I can rebind th=
e console at will to<br>
&gt; &gt; &gt; &gt; toggle it on and off.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Thanks, Dmitry<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Could you send us the full system log? (ideally journalctl -=
b, if not<br>
&gt; &gt; &gt; then, dmesg, or /var/log/kern.lorg). I suspect you have some=
 command<br>
&gt; &gt; &gt; buffer errors in the kernel log that are causing this. Based=
 on your<br>
&gt; &gt; &gt; analysis disabling the cursor_blink is probably a better wor=
karound,<br>
&gt; &gt; &gt; i.e. &quot;echo 0 &gt; /sys/class/graphics/fbcon/cursor_blin=
k&quot; . Besides the<br>
&gt; &gt; &gt; system logs i&#39;d be also intersted in pool info, i.e. cat=
<br>
&gt; &gt; &gt; /sys/bus/pci/devices/&lt;vmwgfx card id&gt;/pools .<br>
<br>
From the vmware.log that I was sent in private what is happening is<br>
that when the i915 driver that you passthrough to the vm loads, it<br>
takes the VGA arbiter, the abiter clears the io mem on vmwgfx and<br>
never restores it. So vmwgfx is broken by the loaded i915 driver<br>
because our communication channel to the device is wiped from<br>
underneath us. We keep queueing cb&#39;s and can&#39;t free them because we=
&#39;re<br>
waiting for some kind of notification from the device that it<br>
processed them but that will never happen.<br>
<br>
I think upstream commit cc6ed470caa2 (=E2=80=9Cdrm/i915/vga: Avoid VGA arbi=
ter<br>
during intel_vga_disable() for iGPUs=E2=80=9D)<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/commit/?id=3Dcc6ed470caa2" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3Dcc6=
ed470caa2</a><br>
will fix this. You can give it a try and if it fixes it for you, you<br>
can ask Ville for a backport.<br>
<br>
z<br>
</blockquote></div></div>

--000000000000ecc2ff06587a720b--
