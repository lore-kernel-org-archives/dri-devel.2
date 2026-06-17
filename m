Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036F7CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E20A10F0FD;
	Wed, 17 Jun 2026 20:22:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A3G+AcWA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9145F10F0FD
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:22:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E122442ED;
 Wed, 17 Jun 2026 20:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CBB1F000E9;
 Wed, 17 Jun 2026 20:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781727726;
 bh=4kkl/1gJ43uaU2bMQwU5IZZudhFWcWM5UdE5DSi+BwQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A3G+AcWAQA238m+nNkywK7lMLi6WwRxAafWjCqEYGn1VMbquyL1+g2Xtn0mDal4iG
 YMQJhY8/Tv+li/7+XGVhMU9e7+02tcYaPld49MTk9dYC83uOcCuUp3T5s7+a5/YXLL
 kZH7vYsBQ+a6pq9/Dj3JdQmZbMVYg3wsubJ/CzZGKXx/FVo09ALB7hTFkS49mpidO8
 cK6Ap/XdAFEt6FjJ2Inukys8NevTxgSDPVRyuhlMPC7sycoNBJqA4pk+H0apFrZzpw
 Owjq43AUrHlZ4CHSzau8xrWxb3UyB5J8dJha1hzQhqDlkfYtxr5A0BBs2typErj04O
 EonC7/9wpKC0w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/7] drm/vino: register a DRM/KMS device and scan
 out to EP08
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260617151249.2937-6-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260617151249.2937-6-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:22:05 +0000
Message-Id: <20260617202206.29CBB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Out-of-Bounds Read due to missing plane `atomic_check`
- [High] Sleeping in Atomic Context
- [High] API Contract Violation / Memory Corruption for pitch
- [High] Data Race / Locking Violation in atomic_check
- [High] Workqueue Leak / UAF on Module Unload
- [High] Global Statics for Device State
- [Medium] Endianness Bug in Pixel Conversion
- [Medium] Initialization Ordering Bug causing kernel warnings
- [Medium] Hardware Desync on Cursor Resizing
- [Medium] Cursor Clipping Logic Error
--

commit 8fb2c0d2dd1d854ba4571103d0392a06d8d1e01a
Author: Mike Lothian <mike@fireburn.co.uk>
Add the drm_sink module: register a real struct drm_device with a

This commit adds a DRM/KMS device registration to the vino driver.
It implements a hand-rolled atomic mode-setting pipeline with CRTC,
primary and cursor planes. It handles EDID caching and EP08 video
scanout.

> diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
> index e9e6324b717b..1091dcc992c7 100644
> --- a/drivers/gpu/drm/vino/vino.rs
> +++ b/drivers/gpu/drm/vino/vino.rs
> @@ -79,6 +80,24 @@ fn timeout() -> Delta {
>  /// hardware -- the dock runs the whole plaintext handshake but never en=
gages the encrypted CP.
>  static CP_ENGAGED: core::sync::atomic::AtomicBool =3D core::sync::atomic=
::AtomicBool::new(false);
> =20
> +/// One-shot: clear-halt + prime the video endpoints before the first li=
ve-scanout EP08 write.
> +static EP08_SCANOUT_PRIMED: core::sync::atomic::AtomicBool =3D
> +    core::sync::atomic::AtomicBool::new(false);

[Severity: High]
Will this cause races when multiple docks are connected?

These variables are declared as global statics rather than per-device
state. If one dock successfully finishes bring-up, CP_ENGAGED becomes
globally true. The driver will then incorrectly assume all other
connected docks are ready and push EP08 video frames to them before
their CP is engaged, causing those docks to fault and enter a USB
reset loop.

[ ... ]

> @@ -1608,12 +1713,12 @@ fn probe<'bound>(
>          // exactly like any other failed bring-up step.
> -        match BringUp::new(intf_ref.clone()) {
> +        match BringUp::new(intf_ref.clone(), ddev.clone()) {
>              Ok(work) =3D> {
>                  let _ =3D workqueue::system().enqueue(work);
>                  dev_info!(cdev, "vino: bring-up queued on system workque=
ue\n");

[Severity: High]
Does this leak the workqueue task on module unload?

The BringUp work item is enqueued but the handle is discarded. As a
result, VinoDriver::disconnect cannot explicitly cancel the background
task before the driver is unbound.

If the USB device is unplugged and the module is subsequently unloaded
while the work is pending or executing, the system workqueue will
attempt to execute the run function which resides in the freed text
section, causing a kernel oops.

> diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_=
sink.rs
> new file mode 100644
> index 000000000000..afbf883fba36
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink.rs
> @@ -0,0 +1,1333 @@

[ ... ]

> +unsafe extern "C" fn vino_atomic_check(
> +    dev: *mut bindings::drm_device,
> +    state: *mut bindings::drm_atomic_commit,
> +) -> i32 {
[ ... ]
> +        let mut cs =3D unsafe { bindings::drm_atomic_get_new_crtc_state(=
state, crtc) };
> +        if cs.is_null() {
> +            // SAFETY: `crtc` is initialised; `.state` is its current co=
mmitted state (or NULL).
> +            cs =3D unsafe { (*crtc).state };
> +        }

[Severity: High]
Can this cause a data race or use-after-free?

In vino_atomic_check, the driver iterates over all heads and sums the clock
frequencies. Accessing a CRTC's state without acquiring its commit lock
(which drm_atomic_get_crtc_state handles safely) allows a concurrent
non-blocking commit on that other CRTC to modify or free its state while
it is being read here.

[ ... ]

> +unsafe extern "C" fn primary_atomic_update(
> +    plane: *mut bindings::drm_plane,
> +    _state: *mut bindings::drm_atomic_commit,
> +) {
[ ... ]
> +    let (dev_raw, fb, w, h, damage, rotation) =3D unsafe {
> +        let st =3D (*plane).state;
> +        if st.is_null() {
> +            return;
> +        }
> +        // Plane destination geometry =3D=3D the negotiated mode (the co=
mpositor sizes the primary
> +        // plane 1:1 with a virtual output), so this drives the dynamic =
scanout resolution.
> +        let (w, h) =3D ((*st).crtc_w as usize, (*st).crtc_h as usize);
> +        ((*plane).dev, (*st).fb, w, h, damage_bbox(st), (*st).rotation)
> +    };

[Severity: Critical]
Could this read out-of-bounds memory?

The plane lacks an atomic_check to validate scaling constraints. In
primary_atomic_update, the driver uses the destination dimensions
(crtc_w, crtc_h) to determine the bounds for reading the mapped source
framebuffer.

If userspace attaches a small GEM buffer but requests a large destination
size, encode_and_send will perform pointer arithmetic far beyond the mapped
buffer into unmapped or unrelated kernel memory.

[ ... ]

> +    let gamma =3D read_gamma_lut(head);
> +    match scanout_one(data, head, fb, w, h, damage, rotation, gamma.as_r=
ef()) {

[Severity: High]
Does this code sleep in atomic context?

The DRM subsystem requires that atomic update callbacks execute in atomic
context during non-blocking commits, where sleeping is strictly forbidden.
Here, scanout_one and encode_and_send perform multiple sleeping operations:
they lock sleeping Mutexes, allocate memory using GFP_KERNEL, map memory
using drm_gem_fb_vmap (which takes blocking dma_resv locks), and invoke
synchronous USB bulk transfers. Executing these will cause scheduling
while atomic panics and system instability.

[ ... ]

> +fn encode_and_send(
[ ... ]
> +        let (sw, sh) =3D if rotation_swaps_dims(rotation) { (h, w) } els=
e { (w, h) };
> +        let pitch =3D sw * 4;

[Severity: High]
Does this calculation ignore the framebuffer pitch?

Userspace can allocate dumb buffers or import DMA-BUFs with padded row
pitches. By assuming a tightly packed buffer and ignoring fb->pitches[0],
the driver will read from incorrect memory offsets for all rows after the
first.

[ ... ]

> +                let px =3D
> +                    unsafe { (vaddr.add(sy * pitch + sx * 4) as *const u=
32).read_unaligned() };
> +                let (mut r, mut g, mut b) =3D
> +                    (((px >> 16) & 0xff) as usize, ((px >> 8) & 0xff) as=
 usize, (px & 0xff) as usize);

[Severity: Medium]
Does this handle pixel extraction correctly on big-endian hosts?

The XRGB8888 DRM format specifies a little-endian byte order. When reading
as a native u32 on a big-endian host, the bytes are interpreted in reverse
semantic order. The subsequent hardcoded bitwise shifts will extract the
wrong color channels. The driver must explicitly perform little-endian
reads.

[ ... ]

> +fn cursor_send(
[ ... ]
> +    let (mx, my) =3D (
> +        cx.clamp(0, u16::MAX as i32) as u16,
> +        cy.clamp(0, u16::MAX as i32) as u16,
> +    );

[Severity: Medium]
Does this clamping prevent the cursor from smoothly transitioning off the
screen edges?

Negative coordinates are clamped to 0 instead of cropping the source sprite,
which forces the cursor to visually stick to the screen edges in its
entirety, creating a user-visible glitch.

[ ... ]

> +    if !head.cursor_primed.swap(true, core::sync::atomic::Ordering::SeqC=
st) {
> +        data.send_cp(hid, 0x1b, 0, |ctr| super::cp::cursor_create(ctr, w=
 as u16, h as u16))?;
> +    }

[Severity: Medium]
Could this cause a hardware state mismatch if the cursor is resized?

The one-shot flag prevents cursor_create from being sent again even if
the dimensions change later. If userspace dynamically changes the cursor
framebuffer dimensions across atomic updates, the driver will push a
cursor_image with the new size without informing the dock via
cursor_create.

[ ... ]

> +    let pitch =3D w * 4;

[Severity: High]
Does this stride calculation ignore the cursor framebuffer pitch?

Just as in the primary plane, calculating the stride from the width
ignores fb->pitches[0] and will read from incorrect memory offsets
if the buffer has padding.

[ ... ]

> +        let primary =3D head.primary.get();
> +        to_result(bindings::drm_universal_plane_init(
> +            raw,
> +            primary,
> +            0,
> +            data.plane_funcs.get(),

[Severity: Medium]
Will this trigger kernel warnings during probe?

Passing 0 for possible_crtcs when initializing the planes right before
attaching them to the CRTC causes the DRM core to emit a warning
that the primary plane is not configured for the CRTC. The mask is patched
later, but the warning has already fired.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617151249.2937=
-1-mike@fireburn.co.uk?part=3D5
