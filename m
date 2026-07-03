Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC33C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4731A10F622;
	Fri,  3 Jul 2026 03:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jdp6FrBT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6571D10F621
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:20:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E83724346C;
 Fri,  3 Jul 2026 03:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3D81F000E9;
 Fri,  3 Jul 2026 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783048823;
 bh=SpZMl43CZS/+FKk1WF1srdIx89PUap7lqO3woEBRDaU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jdp6FrBTaV5u6QBShGv6cZKAZuRMc0woP8J4DyKaPVWwShXM62onhCXO73sMVy4y0
 gYrKXJah+4ScH0iJOaGMdajDJGokeqbQuU9KjlYeg4rLD6nfOdnrZvS2zVMegHoIOX
 VpxcXXJZI+6MUvlbnYV5wt1heX4T4YvEG43XXaRKhmQMdlNmHtC0HpJwpVLPxqFGc1
 StuTgAudzVQyo6Ijp+ftzgbgPwCwz1QYhTQkGeHoJgM3EKGoKCqo8ecApSnjPdaZPJ
 7YuDYyu9OOXwUTbCojtUTZgCEyyJrLaTS3e8OGmRsxBrlqSHWgqbADAUTdvmGVA5l0
 3GBXozsFwF8CA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/10] drm/vino: wire CRTC gamma, plane rotation
 and DDC/CI monitor controls
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260703030217.2886-9-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
 <20260703030217.2886-9-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 03:20:23 +0000
Message-Id: <20260703032023.9C3D81F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a `gamma` field protected by a `kernel::sync:=
:Mutex` and locks it from within DRM atomic commit callbacks (`atomic_enabl=
e`, `atomic_disable`, `atomic_update`), which execute in atomic context whe=
re sleeping is forbidden.
- [High] The DDC/CI payload length is silently truncated if it exceeds 255 =
bytes, leading to malformed CP packets.
- [Medium] Dynamic `GAMMA_LUT` property updates are silently ignored while =
the display is active.
- [Medium] The rotation property is missing on the cursor plane and the rot=
ation is completely ignored when reading cursor pixels.
- [Medium] The DDC/CI I2C adapter's `master_xfer` incorrectly skips unsuppo=
rted messages and transmission failures instead of returning an error, brea=
king sequential processing guarantees.
- [Low] The import `i2c` does not follow the kernel vertical import style.

Pre-existing issues:
- [Critical] Missing plane scaling rejection allows userspace to trigger ou=
t-of-bounds kernel memory reads during scanout.
- [High] The `ddc_forward` function allocates memory using `GFP_KERNEL` whe=
n called from the `atomic_disable` DRM callback, violating atomic context r=
ules.
--

commit efd9ec1e849fe00fb25b5f1bc3faedd48ed3e0f5
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: wire CRTC gamma, plane rotation and DDC/CI monitor controls

This commit consumes the new gamma, rotation, and i2c bindings for the vino=
=20
driver. It enables a 256-entry GAMMA_LUT, adds a rotation property on the=20
primary/cursor plane, and registers a virtual I2C adapter for DDC/CI contro=
ls.

> diff --git a/drivers/gpu/drm/vino/cp.rs b/drivers/gpu/drm/vino/cp.rs
> --- a/drivers/gpu/drm/vino/cp.rs
> +++ b/drivers/gpu/drm/vino/cp.rs

[ ... ]

> @@ -151,14 +151,24 @@ pub(super) fn set_mode(counter: u16, t: &Timing) ->=
 Result<KVec<u8>> {
>  /// the CP wall), so re-check against a capture once CP engages. The DDC=
/CI bytes themselves
>  /// ([`ddc_ci_set_vcp`]) are standard and verified.
>  pub(super) fn ddc_set_vcp(counter: u16, vcp: u8, value: u16) -> Result<K=
Vec<u8>> {
> -    let payload =3D ddc_ci_set_vcp(vcp, value);
> -    let mut b =3D KVec::with_capacity(32, GFP_KERNEL)?;
> +    ddc_forward(counter, DDCCI_I2C_ADDR, &ddc_ci_set_vcp(vcp, value))
> +}
> +
> +/// The DDC/CI I2C slave address on the monitor bus.
> +pub(super) const DDCCI_I2C_ADDR: u8 =3D 0x37;
> +
> +/// CP message tunnelling a raw DDC/CI transaction (`payload`, the bytes=
 a host writes after the
> +/// I2C write-address) to the downstream monitor's I2C slave `addr`. Sam=
e `id=3D0x15 sub=3D0x22`
> +/// framing as [`ddc_set_vcp`], with the slave + payload length at off20=
 and the payload at off22.
> +/// This is what the vino I2C adapter forwards for a userspace DDC/CI wr=
ite (e.g. `ddcutil`).
> +pub(super) fn ddc_forward(counter: u16, addr: u8, payload: &[u8]) -> Res=
ult<KVec<u8>> {
> +    let mut b =3D KVec::with_capacity(32 + payload.len(), GFP_KERNEL)?;

[Severity: High]
This is a pre-existing issue, but can this GFP_KERNEL allocation cause a
scheduling while atomic panic?

The CRTC atomic_disable callback runs in atomic context where sleeping is
forbidden. It calls set_vcp(), which delegates to cp::ddc_set_vcp() and=20
subsequently cp::ddc_forward().

Allocating with GFP_KERNEL here can sleep. Could this allocation use
GFP_ATOMIC instead?

>      header(&mut b, 0x15, 0x22, counter)?;
>      pad_to(&mut b, 20)?;
> -    // off20: monitor DDC/CI I2C slave (0x37) + DDC/CI payload length.
> -    b.extend_from_slice(&[0x37, payload.len() as u8], GFP_KERNEL)?;
> -    // off22: the DDC/CI Set-VCP bytes (same off22 convention as the EDI=
D payload).
> -    b.extend_from_slice(&payload, GFP_KERNEL)?;
> +    // off20: monitor DDC/CI I2C slave + DDC/CI payload length.
> +    b.extend_from_slice(&[addr, payload.len() as u8], GFP_KERNEL)?;

[Severity: High]
Can a payload larger than 255 bytes cause malformed CP packets here?

The payload.len() is cast to u8 without bounds checking, meaning the protoc=
ol
packet header receives a truncated length, but the full unbounded payload i=
s=20
appended below.

Could this cause the downstream dock's CP parser to read misaligned framing,
potentially hanging the hardware or corrupting the stream?

> +    // off22: the DDC/CI bytes (same off22 convention as the EDID payloa=
d).
> +    b.extend_from_slice(payload, GFP_KERNEL)?;
>      pad_to(&mut b, 32)?;
>      Ok(b)
>  }

> diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_=
sink.rs
> --- a/drivers/gpu/drm/vino/drm_sink.rs
> +++ b/drivers/gpu/drm/vino/drm_sink.rs

[ ... ]

> @@ -41,6 +42,7 @@
>          plane::{self, PlaneAtomicCommit, RawPlaneState as _},
>          KmsDriver, ModeConfigGuard, ModeConfigInfo, ModeObject as _, New=
KmsDevice, Probing,
>      },
> +    i2c,
> +    error::code::EINVAL,

[Severity: Low]
Does this import follow the kernel vertical import style for Rust?

The i2c import is placed on the same line as other items instead of being
vertically aligned.

[ ... ]

> @@ -125,6 +127,12 @@ pub(super) struct VinoDrmData {
>      /// can reach its cached-EDID slot without needing DRM's mode-object=
 list. Written once,
>      /// during single-threaded probe, before the device is registered; r=
ead-only thereafter.
>      connector: core::sync::atomic::AtomicPtr<VinoConnector>,
> +    /// The CRTC's gamma ramp cached from the atomic hook as three 256-e=
ntry 8-bit LUTs
> +    /// (`[r; 256] ++ [g; 256] ++ [b; 256]`), or `None` for identity. Ca=
ched here (not read from
> +    /// the CRTC state) because scanout runs in the plane path; it is `C=
opy`, so the scanout
> +    /// snapshots it under the lock and applies it without holding the l=
ock in the pixel loop.
> +    #[pin]
> +    gamma: Mutex<Option<[u8; 768]>>,
>  }
> =20
>  impl VinoDrmData {

[Severity: High]
Does the use of a sleeping Mutex here violate atomic context rules?

The update_gamma() and gamma_snapshot() functions lock this Mutex, but they
are invoked synchronously during the CRTC atomic_enable, atomic_disable,
and plane atomic_update callbacks.

According to DRM subsystem guidelines, these callbacks run in atomic context
during non-blocking commits where sleeping is strictly forbidden. Should th=
is
be a spinlock instead to avoid scheduling while atomic panics?

[ ... ]

> @@ -302,6 +333,16 @@ fn probe(dev: &NewKmsDevice<'_, Self, Probing>) -> R=
esult {
>              None,
>              false,
>          )?;
> +        // Advertise the rotations vino's re-encode handles 1:1 (dimensi=
on-preserving): the
> +        // scanout applies them per source pixel via `rot_src`. 90/270 (=
which swap width/height)
> +        // are intentionally omitted.
> +        primary.create_rotation_property(
> +            bindings::DRM_MODE_ROTATE_0,
> +            bindings::DRM_MODE_ROTATE_0
> +                | bindings::DRM_MODE_ROTATE_180
> +                | bindings::DRM_MODE_REFLECT_X
> +                | bindings::DRM_MODE_REFLECT_Y,
> +        )?;
>          let cursor =3D plane::UnregisteredPlane::<VinoPlane>::new(
>              dev,
>              1,
>              &CURSOR_FORMATS,
>              None,
>              plane::Type::Cursor,
>              None,
>              PlaneArgs { head: 0, is_cursor: true },
>          )?;

[Severity: Medium]
Is the cursor plane missing the rotation property?

The commit message mentions wiring rotation for the primary/cursor plane, b=
ut
create_rotation_property() is not called for the cursor plane during probe.

Additionally, read_cursor_bgra() maps and reads the cursor framebuffer
without applying any rotation transformation.

[ ... ]

> @@ -372,6 +415,8 @@ fn new(_device: &drm::Device<Self::Driver, drm::Unini=
t>, _args: &()) -> impl Pin
>      fn atomic_enable(commit: CrtcAtomicCommit<'_, Self>) {
>          let data: &VinoDrmData =3D commit.crtc().drm_dev();
>          let new =3D commit.take_new_state();
> +        // Cache the gamma ramp for the scanout to apply.
> +        data.update_gamma(new.gamma_lut());

[Severity: Medium]
Are dynamic GAMMA_LUT property updates silently ignored while the display
is active?

The driver caches the GAMMA_LUT value only in the atomic_enable and
atomic_disable CRTC hooks.

If a compositor dynamically updates the gamma LUT, it will trigger
atomic_flush or atomic_update, but skip the enable hook when the CRTC is
already active, potentially missing color calibration changes until a full
modeset occurs.

[ ... ]

> @@ -489,6 +535,8 @@ fn atomic_update(commit: PlaneAtomicCommit<'_, Self>)=
 {
>          // primary plane 1:1 with the virtual output), so this drives th=
e dynamic scanout
>          // resolution.
>          let (w, h) =3D (new.crtc_w() as usize, new.crtc_h() as usize);

[Severity: Critical]
This isn't a bug introduced by this patch, but does the lack of plane scali=
ng
rejection allow userspace to trigger out-of-bounds kernel memory reads?

VinoPlane lacks an atomic_check function to reject scaling (e.g., using
drm_atomic_helper_check_plane_state with DRM_PLANE_NO_SCALING).

In atomic_update(), the scanout loop uses the destination CRTC geometry
(new.crtc_w(), new.crtc_h()) as the bounds instead of the source framebuffer
dimensions.

If unprivileged userspace issues an atomic commit with crtc_h greater than
fb.height(), the scanout loop will read past the end of the mapped GEM buff=
er.

[ ... ]

> @@ -748,13 +816,62 @@ fn get_modes<'a>(
>      }
>  }
> =20
> +// ---- DDC/CI I2C adapter ---------------------------------------------=
--------
> +
> +/// vino's DDC/CI virtual I2C bus: a userspace monitor-control tool (`dd=
cutil`, the desktop
> +/// brightness slider via the I2C DDC path) writes a DDC/CI transaction =
to the monitor's I2C slave
> +/// on this adapter, and vino tunnels it to the downstream monitor over =
the dock's CP channel
> +/// (`cp::ddc_forward`, `id=3D0x15 sub=3D0x22`) -- the same monitor-I2C =
bridge vino's DPMS-power VCP
> +/// uses. Writes only for now (Get-VCP reads need the CP reply path); a =
no-op until CP engages.
> +pub(super) struct VinoI2c;
> +
> +impl i2c::BusController for VinoI2c {
> +    type Context =3D ARef<VinoDrmDevice>;
> +
> +    fn master_xfer(dev: &ARef<VinoDrmDevice>, msgs: &mut [i2c::Msg]) -> =
Result<usize> {
> +        let data: &VinoDrmData =3D dev;
> +        let mut transferred =3D 0usize;
> +        for msg in msgs.iter() {
> +            if msg.addr() !=3D super::cp::DDCCI_I2C_ADDR as u16 {
> +                continue;
> +            }
> +            if msg.is_read() {
> +                // DDC/CI reads (Get-VCP) require decoding the dock's CP=
 reply -- not wired yet.
> +                continue;
> +            }

[Severity: Medium]
Should master_xfer() return an error when encountering unsupported messages
rather than skipping them?

If master_xfer() receives an array of messages where an early message is
unsupported (e.g., a read) and a later message succeeds, it uses continue to
skip the error and returns a positive transferred count.

This violates the I2C subsystem API contract and causes userspace tools like
ddcutil to assume operations succeeded when they actually failed.

> +            if data
> +                .send_cp(0x15, 0, |ctr| {
> +                    super::cp::ddc_forward(ctr, super::cp::DDCCI_I2C_ADD=
R, msg.buf())
> +                })
> +                .is_ok()
> +            {
> +                transferred +=3D 1;
> +            }
> +        }
> +        Ok(transferred)
> +    }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703030217.2886=
-1-mike@fireburn.co.uk?part=3D8
