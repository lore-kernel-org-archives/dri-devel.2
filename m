Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C45C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920A410F621;
	Fri,  3 Jul 2026 03:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kQHI7Uld";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12A010F621
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:20:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECFD660210;
 Fri,  3 Jul 2026 03:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743E31F000E9;
 Fri,  3 Jul 2026 03:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783048844;
 bh=Jvw3qXOOPuU7iSVFLDhe29o+dKIiIbCS/TrpsyyCqg0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kQHI7UldemI11FaeK7hRvT1rfvJnwNk9WXMQmAPpyesneAgX/mTzpsT36GiTvZFCz
 NkbBuuEY7r5AuVOseT247Wb5LkrhjQhdlYGbFJBhlkM/2imYzrFhNzmZDMeeL68Xvw
 QD6jS5U3pfEwzAvqVbw01rKBj0+ijJgj0hCECJp2yKbgXF1q5KQtjJe9Sm00bSXp26
 mlHPBnNFs80C0thVND/x6yUUo0i9ACRGtrQ1TIeCESiqvzxOk1H4CzMdzX4TDs03Ds
 F4KEcrtxMrFvIOrJjiFx/F+BAKU9K/CuEQ9bsltpTcVnY/kStVSHsxsRICFq6Wt0bq
 YZa/4LcglCdDw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/10] drm/vino: two heads, 90/270 rotation,
 damage clips and connector probe
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260703030217.2886-10-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
 <20260703030217.2886-10-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 03:20:44 +0000
Message-Id: <20260703032044.743E31F000E9@smtp.kernel.org>
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

New issues:
- [High] The frame-damage clips overflow fallback logic permanently drops p=
reviously accumulated damage clips instead of properly merging them.
- [High] The CRTC gamma LUT state is incorrectly shared globally rather tha=
n being per-head, causing independent display heads to overwrite or clear e=
ach other's gamma ramps.

Pre-existing issues:
- [High] Kernel out-of-bounds read occurs when userspace requests plane sca=
ling.
- [High] The plane `atomic_update` and CRTC callbacks run in atomic context=
 but acquire sleepable Mutexes and perform GFP_KERNEL allocations.
- [Medium] The cursor plane update logic uses the raw virtual address of th=
e framebuffer as a cache key, risking an ABA problem where a re-uploaded cu=
rsor is silently ignored.
--

commit 02346681a0e083ee04b818868a94582e0d21e04e
Author: Mike Lothian <mike@fireburn.co.uk>

    drm/vino: two heads, 90/270 rotation, damage clips and connector probe
   =20
    Consume the new connector detect()/mode_valid() and plane damage-clip
    bindings, and finish the KMS feature set the driver previously stubbed:

> diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_=
sink.rs
> index 898cfae8fd4fb..ee04a5af9f7d5 100644
> --- a/drivers/gpu/drm/vino/drm_sink.rs
> +++ b/drivers/gpu/drm/vino/drm_sink.rs
> @@ -435,10 +474,12 @@ fn atomic_enable(commit: CrtcAtomicCommit<'_, Self>=
) {
>      /// against a shadow the dock may have dropped, and blanks the monit=
or via DDC/CI -- a
>      /// no-op until CP engages.
>      fn atomic_disable(commit: CrtcAtomicCommit<'_, Self>) {
> -        let data: &VinoDrmData =3D commit.crtc().drm_dev();
> +        let crtc =3D commit.crtc();
> +        let head =3D crtc.head;
> +        let data: &VinoDrmData =3D crtc.drm_dev();
>          data.update_gamma(None);

[Severity: High]
Since the driver now supports multiple independent display heads, is it saf=
e to
share a single global gamma state?

`data.update_gamma` modifies the shared `gamma` in `VinoDrmData`. This could
inadvertently overwrite or clear the gamma ramps of other connected displays
when one head is updated or disabled.

Should `gamma` be made per-head, similar to the `connectors` array?

Also, this is a pre-existing issue, but doesn't `data.update_gamma` lock a
sleepable Mutex? CRTC callbacks like `atomic_disable` and `atomic_enable` c=
an
run in atomic context during non-blocking atomic commits where sleeping is
forbidden.

[ ... ]

> @@ -498,14 +554,14 @@ fn atomic_update(commit: PlaneAtomicCommit<'_, Self=
>) {
>              return;
>          }
>          let plane =3D commit.plane();
> +        let head =3D plane.head;
>          let data: &VinoDrmData =3D plane.drm_dev();
> -        let new =3D commit.take_new_state();
> =20
>          // Cursor plane: forward the cursor bitmap/position to the dock =
over CP (id=3D0x1b create,
>          // 0x401c image, 0x1a move -- see `cp::cursor_*`). A no-op until=
 CP engages, like scanout.
>          if plane.is_cursor {
>              use core::sync::atomic::Ordering::Relaxed;
> -            const HEAD: u8 =3D 0;
> +            let new =3D commit.take_new_state();
>              match new.framebuffer::<VinoDrmDriver>() {
>                  Some(fb) =3D> {
>                      let w =3D fb.width() as u16;
> @@ -514,15 +570,17 @@ fn atomic_update(commit: PlaneAtomicCommit<'_, Self=
>) {
>                      // position (a bare cursor move must not re-send the=
 whole image).
>                      let key =3D fb as *const _ as usize;
>                      if plane.cursor_last.swap(key, Relaxed) !=3D key {

[Severity: Medium]
This is a pre-existing issue, but does using the raw virtual address of the
framebuffer as a cache key risk an ABA problem?

If userspace frees a cursor framebuffer and immediately allocates a new one,
the memory allocator may place it at the same virtual address. This could
cause the new cursor image to be silently ignored because the cache key
hasn't changed.

[ ... ]

> @@ -537,6 +597,37 @@ fn atomic_update(commit: PlaneAtomicCommit<'_, Self>=
) {
>          let (w, h) =3D (new.crtc_w() as usize, new.crtc_h() as usize);

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds read if
userspace requests plane scaling?

The destination dimensions `crtc_w` and `crtc_h` are used to iterate and
calculate source memory offsets. If a compositor provides a small framebuff=
er
and requests scaling, the offsets could far exceed the bounds of the source
framebuffer.

>          // Plane rotation/reflection (identity unless the compositor set=
 the rotation property).
>          let rotation =3D new.rotation();
> +        // Collect the client's individual frame-damage clips (the recta=
ngles that
> +        // `damage_merged()` would collapse into one bounding box), each=
 clamped to the output, so
> +        // only the genuinely changed rectangles are re-converted from t=
he source rather than their
> +        // whole enclosing box. Only for identity rotation (the clips ar=
e in un-rotated source
> +        // space; mapping them through 90/270 is not worth it for the th=
rottled fallback path), and
> +        // never on the WHT keyframe path -- see `encode_and_send`. A fi=
xed stack array keeps the
> +        // atomic-commit path allocation-free; on overflow the clips col=
lapse into one bounding box.
> +        // An empty list means "convert the whole output" (used for the =
rotated/reflected case).
> +        let mut clips =3D [(0usize, 0usize, 0usize, 0usize); MAX_DAMAGE_=
CLIPS];
> +        let mut nclips =3D 0usize;
> +        if rotation & bindings::DRM_MODE_ROTATE_MASK =3D=3D bindings::DR=
M_MODE_ROTATE_0
> +            && rotation & (bindings::DRM_MODE_REFLECT_X | bindings::DRM_=
MODE_REFLECT_Y) =3D=3D 0
> +        {
> +            new.for_each_damage_clip(old, |r| {
> +                let c =3D (
> +                    (r.x1.max(0) as usize).min(w),
> +                    (r.y1.max(0) as usize).min(h),
> +                    (r.x2.max(0) as usize).min(w),
> +                    (r.y2.max(0) as usize).min(h),
> +                );
> +                if nclips < MAX_DAMAGE_CLIPS {
> +                    clips[nclips] =3D c;
> +                    nclips +=3D 1;
> +                } else {
> +                    // Overflow: collapse everything so far (and `c`) in=
to clips[0]'s bounding box.
> +                    let b =3D clips[0];
> +                    clips[0] =3D (b.0.min(c.0), b.1.min(c.1), b.2.max(c.=
2), b.3.max(c.3));
> +                    nclips =3D 1;

[Severity: High]
Does this overflow fallback logic correctly merge the clips?

When `nclips` reaches `MAX_DAMAGE_CLIPS`, it updates `clips[0]` to be the
bounding box of `clips[0]` and `c`. However, this completely discards the
previously accumulated clips from `clips[1]` through `clips[15]`, dropping
them permanently rather than expanding the bounding box to include them.

> +                }
> +            });
> +        }
> =20
>          use core::sync::atomic::Ordering::Relaxed;

[ ... ]

> @@ -693,6 +803,8 @@ fn encode_and_send(
>          return encode_and_send_wht(data, plane, vaddr, pitch, rotation, =
w, h);
>      }
>      let gamma =3D data.gamma_snapshot();
> +    // Source dimensions (swapped from the output for 90/270 rotation).
> +    let (sw, sh) =3D src_dims(rotation, w, h);
>      let frame =3D {
>          let mut st =3D plane.scanout.lock();

[Severity: High]
This isn't a bug introduced by this patch, but doesn't `atomic_update` run
in atomic context during non-blocking atomic commits?=20

Locking a sleepable Mutex like `plane.scanout.lock()` here can cause kernel
warnings and system instability.

[ ... ]

> @@ -746,7 +868,7 @@ fn encode_and_send(
>      // DRM device, so it is bound for the duration of this push.
>      let dev =3D unsafe { data.intf.as_bound() };
>      prime_video_eps(dev);
> -    dev.bulk_send(VIDEO_EP, &frame, super::timeout(), GFP_KERNEL)?;
> +    dev.bulk_send(VIDEO_EPS[plane.head as usize], &frame, super::timeout=
(), GFP_KERNEL)?;

[Severity: High]
Similarly, this is a pre-existing issue, but does `dev.bulk_send` perform
allocations using the `GFP_KERNEL` flag? Using `GFP_KERNEL` in atomic conte=
xt
is unsafe and can sleep.

>      Ok(())
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703030217.2886=
-1-mike@fireburn.co.uk?part=3D9
