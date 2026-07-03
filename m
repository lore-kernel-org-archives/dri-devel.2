Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2207C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE1110F5F5;
	Fri,  3 Jul 2026 03:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jX5WFdVR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8C410F5F5
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:11:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A284A60210;
 Fri,  3 Jul 2026 03:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7C51F000E9;
 Fri,  3 Jul 2026 03:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783048279;
 bh=ysOhtfxSrB4kBpATGgP+tYmXk8bJi2ehUyX52sVLKPs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jX5WFdVRE1NZalKQcJEugpWNDx4yY5+DRB/o4K+HhSH7epskZkf7QwMa+9LsHEXPP
 jh43sM+elSwTm//v6wsZEYdWYnb2Rvqy0thTLcuI2LCw8AtwDPmXql7jQiGYvYNigf
 cBwOpEM7DWshm90RZe3QLEaxrx9PnOKc1IDdLiL6uNLYK5kiEfO8qZLDSQ3p61bUHp
 WU5CGp7OnqLyCrSceZM/ru6AaNrhiq1DvGnC63cdi1eo8DjGkHxSwqf3MknMEMC543
 +NTFEVzF5iTtlAXTCEAfvJrR/t/sYCNlzqsNK890xMWobCSq7iQZgqQjz+1Iga97pQ
 vhOF365z2pZDA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/10] drm/vino: wire the hardware cursor plane
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260703030217.2886-8-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
 <20260703030217.2886-8-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 03:11:17 +0000
Message-Id: <20260703031119.1F7C51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The cursor plane's atomic update callback performs operations that=
 can sleep, including framebuffer vmap and GFP_KERNEL allocations, violatin=
g atomic context rules.
- [Medium] The tracking state `cursor_last` is unconditionally updated befo=
re the new cursor image is successfully mapped and transmitted, breaking su=
bsequent updates if an error occurs.
- [Medium] The driver does not send commands to the hardware dock to hide t=
he cursor when it is disabled or moved entirely off-screen.
- [Medium] Manual color channel extraction from a natively read 32-bit word=
 produces reversed colors on big-endian architectures.
--

commit c3d3f61b0980905330252aecb30ece0564fb99bc
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: wire the hardware cursor plane

This commit re-wires the hardware cursor plane for the vino driver by creat=
ing
a Type::Cursor plane. The cursor plane's atomic_update forwards the cursor
bitmap and position to the dock over CP.

> diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_=
sink.rs
> index 450c7c84a0677..fde52336fcd14 100644
> --- a/drivers/gpu/drm/vino/drm_sink.rs
> +++ b/drivers/gpu/drm/vino/drm_sink.rs

[ ... ]

> @@ -429,6 +454,36 @@ fn atomic_update(commit: PlaneAtomicCommit<'_, Self>=
) {
>          let plane =3D commit.plane();
>          let data: &VinoDrmData =3D plane.drm_dev();
>          let new =3D commit.take_new_state();
> +
> +        // Cursor plane: forward the cursor bitmap/position to the dock =
over CP (id=3D0x1b create,
> +        // 0x401c image, 0x1a move -- see `cp::cursor_*`). A no-op until=
 CP engages, like scanout.
> +        if plane.is_cursor {
> +            use core::sync::atomic::Ordering::Relaxed;
> +            const HEAD: u8 =3D 0;
> +            match new.framebuffer::<VinoDrmDriver>() {
> +                Some(fb) =3D> {
> +                    let w =3D fb.width() as u16;
> +                    let h =3D fb.height() as u16;
> +                    // Re-upload the bitmap only when the framebuffer ch=
anges; always update the
> +                    // position (a bare cursor move must not re-send the=
 whole image).
> +                    let key =3D fb as *const _ as usize;
> +                    if plane.cursor_last.swap(key, Relaxed) !=3D key {

[Severity: Medium]
If read_cursor_bgra() fails, doesn't this unconditional update of
cursor_last mean we'll permanently skip uploading this framebuffer on
subsequent updates, falsely assuming it was already uploaded?

> +                        let _ =3D data.send_cp(0x1b, 0, |ctr| super::cp:=
:cursor_create(ctr, HEAD, w, h));
> +                        if let Ok(bgra) =3D read_cursor_bgra(fb, w as us=
ize, h as usize) {

[Severity: High]
Does read_cursor_bgra() sleep in atomic context?

Plane atomic_update callbacks run in atomic context, but read_cursor_bgra()
performs sleepable operations like vmap() and GFP_KERNEL allocations. Will
this trigger lockdep warnings ("scheduling while atomic") or kernel panics?

> +                            let _ =3D data
> +                                .send_cp(0x401c, 0, |ctr| super::cp::cur=
sor_image(ctr, HEAD, w, h, &bgra));
> +                        }
> +                    }
> +                    let x =3D new.crtc_x().max(0) as u16;
> +                    let y =3D new.crtc_y().max(0) as u16;

[Severity: Medium]
Are we leaving a ghost cursor visible when it should be hidden?

By clamping negative coordinates to 0, a cursor moved off-screen to the left
or top will stick to the screen edge instead of moving out of view.

> +                    let _ =3D data.send_cp(0x1a, 0, |ctr| super::cp::cur=
sor_move(ctr, HEAD, x, y));
> +                }
> +                // Cursor disabled: forget the last bitmap so it re-uplo=
ads if it comes back.
> +                None =3D> plane.cursor_last.store(0, Relaxed),

[Severity: Medium]
Similarly, when the cursor is logically disabled (framebuffer is None), this
clears the software state but doesn't send any hardware commands to the dock
to actually hide the cursor. Will the cursor remain visible?

> +            }
> +            return;
> +        }
> +
>          let Some(fb) =3D new.framebuffer::<VinoDrmDriver>() else { retur=
n };

[ ... ]

> @@ -480,6 +535,31 @@ fn prime_video_eps(dev: &super::usb::Interface<kerne=
l::device::Bound>) {
>      }
>  }
> =20
> +/// Map the cursor framebuffer and convert it to the `w*h*4` BGRA bitmap=
 the dock expects
> +/// (`cp::cursor_image`). The source is XRGB/ARGB8888; each pixel is wri=
tten out as B, G, R, A.
> +fn read_cursor_bgra(
> +    fb: &kms::framebuffer::Framebuffer<VinoDrmDriver>,
> +    w: usize,
> +    h: usize,
> +) -> Result<KVec<u8>> {
> +    let vmap =3D fb.vmap()?;
> +    let src =3D vmap.as_ptr();
> +    let pitch =3D fb.pitch(0) as usize;
> +    let mut out =3D KVec::with_capacity(w * h * 4, GFP_KERNEL)?;
> +    for dy in 0..h {
> +        for dx in 0..w {
> +            // SAFETY: `dy*pitch + dx*4 + 3` is within the mapped cursor=
 framebuffer (`pitch*h`
> +            // bytes); `dx < w <=3D pitch/4`, `dy < h`.
> +            let px =3D unsafe { (src.add(dy * pitch + dx * 4) as *const =
u32).read_unaligned() };
> +            out.push((px & 0xff) as u8, GFP_KERNEL)?; // B
> +            out.push(((px >> 8) & 0xff) as u8, GFP_KERNEL)?; // G
> +            out.push(((px >> 16) & 0xff) as u8, GFP_KERNEL)?; // R
> +            out.push(((px >> 24) & 0xff) as u8, GFP_KERNEL)?; // A

[Severity: Medium]
Will this color extraction logic produce distorted or reversed colors on
big-endian architectures?

The little-endian DRM_FORMAT_ARGB8888 buffer is read as a native u32. On a
big-endian system, extracting the bytes with these shifts will grab the
wrong bytes for each color channel.

> +        }
> +    }
> +    Ok(out)
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703030217.2886=
-1-mike@fireburn.co.uk?part=3D7
