Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F35C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D4310F61A;
	Fri,  3 Jul 2026 03:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ox0v56pE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8720710F61A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:13:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DBCA40729;
 Fri,  3 Jul 2026 03:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A2F1F000E9;
 Fri,  3 Jul 2026 03:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783048421;
 bh=IDcpCcxm9O6uHptnqRK3tBCiXzzEItNzUxGy826WN6g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ox0v56pEaRwpQWQvmeqCOvyrmY7qmjlgFPzSEB2jNS+Ug3ConKHdt7uId11D7Z4HG
 AmYQmZaqK88KEmpK5JZ2WKjkGbcM7oP1MatgImE1LAuToDmg7ri7Slb80Gqkn+3d3U
 O3WoEG/C9LH5fXN9/p9m6fwnhlc4QUJO3bMv3QkTU773KisOseQPP+SqwO+YcbPPsw
 6gYBIR2T3NEEaubrFDAMCiQwrE0+kSDR8lI/oc41OVl+hO0z/pqHIh8B46MaQ4whQ8
 WMpb5/pjedE+19VCniie+JQo74j+qFWMftAxnl71l5e4ODIYXKpJEaqTm6Lgs3Ogjg
 vGVkm4WayNOUA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/10] drm/vino: add the DRM/KMS sink, built on
 the safe KMS mode-object layer
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260703030217.2886-6-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
 <20260703030217.2886-6-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 03:13:40 +0000
Message-Id: <20260703031341.01A2F1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Sleeping in atomic context within KMS atomic callbacks (Subsystem =
Guide Violation).
- [High] Out-of-bounds kernel memory read in framebuffer scanout due to unv=
alidated destination dimensions.
- [High] Integer overflow in scanout buffer size calculation on 32-bit arch=
itectures leads to out-of-bounds writes.
- [High] Device-specific initialization and recovery states are tracked in =
global variables, breaking multi-device support.
- [Medium] Incorrect pixel color extraction on big-endian architectures due=
 to native-endian memory reads.
--

commit 717e075a35f786d4dc6a24d62c35ac5c6ff9090a
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add the DRM/KMS sink, built on the safe KMS mode-object layer

This commit introduces the DRM/KMS sink for the vino driver using the safe
KMS mode-object layer. It wires up a CRTC, a primary plane, a virtual
encoder, and a connector to support mode-setting and scanning out
framebuffers to the dock.

> diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_=
sink.rs
> new file mode 100644
> index 0000000000000..450c7c84a0677
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink.rs

[ ... ]

> +    fn atomic_enable(commit: CrtcAtomicCommit<'_, Self>) {
> +        let data: &VinoDrmData =3D commit.crtc().drm_dev();
> +        let new =3D commit.take_new_state();
> +        let timing =3D super::cp::timing_from_drm_mode(new.mode());
> +        pr_info!(
> +            "vino: KMS CRTC enable -- display ON, mode {}x{}@{} (scanout=
 begins)\n",
> +            timing.hactive,
> +            timing.vactive,
> +            timing.refresh_hz
> +        );
> +        if let Err(e) =3D data.send_cp(0x48, 16, |ctr| super::cp::set_mo=
de(ctr, &timing)) {

[Severity: High]
Does send_cp() perform sleeping operations?

According to DRM subsystem guidelines, CRTC atomic callbacks execute in an
atomic context where sleeping is strictly forbidden.

Since send_cp() acquires a Mutex and performs a blocking USB transfer with
GFP_KERNEL, could this cause a "scheduling while atomic" issue during
display enable?

> +            pr_warn!("vino: runtime mode-set send failed ({e:?})\n");
> +        }
> +        let _ =3D data.set_vcp(super::cp::VCP_POWER_MODE, super::cp::POW=
ER_ON);
> +    }

[ ... ]

> +    fn atomic_update(commit: PlaneAtomicCommit<'_, Self>) {

[Severity: High]
Are we performing sleeping operations in an atomic context here?

The Plane atomic update callback synchronously invokes the frame conversion
and USB scanout pipeline.

This function eventually calls encode_and_send(), which locks a Mutex,
allocates memory with GFP_KERNEL, and blocks on USB bulk transfers. Will
this lead to system instability during mode-sets or page-flips?

> +        if !super::CP_ENGAGED.load(core::sync::atomic::Ordering::SeqCst)=
 {
> +            return;
> +        }
> +        let plane =3D commit.plane();
> +        let data: &VinoDrmData =3D plane.drm_dev();
> +        let new =3D commit.take_new_state();
> +        let Some(fb) =3D new.framebuffer::<VinoDrmDriver>() else { retur=
n };
> +        // The plane's destination geometry mirrors the negotiated mode =
(the compositor sizes the
> +        // primary plane 1:1 with the virtual output), so this drives th=
e dynamic scanout
> +        // resolution.
> +        let (w, h) =3D (new.crtc_w() as usize, new.crtc_h() as usize);

[Severity: High]
Could these destination dimensions exceed the bounds of the underlying
source framebuffer?

These values come from the userspace-controlled plane destination size.
Because there is no atomic_check to validate them against the attached
framebuffer size, could the pixel extraction loops further down read out of
bounds memory?

> +
> +        use core::sync::atomic::Ordering::Relaxed;
> +        // Throttle: while scanout is failing (dock NAKing because CP is=
n't engaged), skip the
> +        // upcoming pageflips set by the backoff below instead of conver=
ting+encoding+sending a
> +        // frame the dock will just drop.
> +        let skip =3D super::SCANOUT_SKIP.load(Relaxed);

[Severity: High]
Can tracking frame backoffs in a global static cause interference between
multiple connected devices?

If multiple docks are in use, they would share these error recovery states
and potentially affect each other's scanout rate.

[ ... ]

> +fn prime_video_eps(dev: &super::usb::Interface<kernel::device::Bound>) {
> +    if !super::EP08_SCANOUT_PRIMED.swap(true, core::sync::atomic::Orderi=
ng::SeqCst) {

[Severity: High]
Does using a global static here prevent multiple connected docks from
initializing properly?

If a second dock is connected, it appears it would see this global flag as
true and skip clearing the halts on its video endpoints. Could this state
be tracked per-device instead?

> +        for ep in [0x08u8, 0x0a, 0x0b, 0x0c] {
> +            let _ =3D dev.clear_halt(ep);
> +        }

[ ... ]

> +fn encode_and_send(
> +    data: &VinoDrmData,
> +    plane: &plane::Plane<VinoPlane>,
> +    vaddr: *const u8,
> +    pitch: usize,
> +    w: usize,
> +    h: usize,
> +) -> Result {

[ ... ]

> +        let first =3D st.enc.is_none() || st.dims !=3D (w, h);
> +        if first {
> +            st.enc =3D Some(super::video::Encoder::new(w, h, super::vide=
o::Mode::Rle)?);
> +            st.cur =3D VVec::from_elem(0u16, w * h, GFP_KERNEL)?;

[Severity: High]
Can this size calculation silently overflow on 32-bit architectures?

If userspace passes large values for crtc_w and crtc_h, w * h could wrap
around the 32-bit usize limit.

This would result in an undersized allocation, causing the nested loops
below to write out-of-bounds to the heap.

> +            st.dims =3D (w, h);
> +            st.hint =3D 0;
> +        }
> +        let ScanoutState { enc, cur, seq, hint, dims: _ } =3D &mut *st;
> +        for dy in 0..h {
> +            for dx in 0..w {
> +                // SAFETY: `dy*pitch + dx*4 + 3` is within the mapped so=
urce framebuffer
> +                // (`pitch*h` bytes); `dx < w <=3D pitch/4`, `dy < h`.
> +                let px =3D unsafe { (vaddr.add(dy * pitch + dx * 4) as *=
const u32).read_unaligned() };
> +                let (r, g, b) =3D ((px >> 16) & 0xff, (px >> 8) & 0xff, =
px & 0xff);

[Severity: Medium]
Will this color channel extraction work correctly on big-endian
architectures?

XRGB8888 has a fixed byte order in memory. By reading it as a native u32
and applying bitwise shifts, the bytes will be loaded in reverse order on a=
=20
big-endian system, which might cause the wrong color channels to be
extracted.

> +                cur[dy * w + dx] =3D (((r >> 3) << 11) | ((g >> 2) << 5)=
 | (b >> 3)) as u16;
> +            }
> +        }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703030217.2886=
-1-mike@fireburn.co.uk?part=3D5
