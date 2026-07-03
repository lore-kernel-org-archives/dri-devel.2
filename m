Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17792C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D74D10E547;
	Fri,  3 Jul 2026 03:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jkfgm6nt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1814C10E547
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:21:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6A3E43673;
 Fri,  3 Jul 2026 03:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1641F000E9;
 Fri,  3 Jul 2026 03:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783048882;
 bh=mjNVMxoQJlaI311PhaATD5FCUOMMN1atKhHGatlDHlI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jkfgm6ntZ3f27J12XIIXZm6KW2sZ/d5Fy7DDALg2f3dtQMTO4/GE1IUllTEWqhTsA
 BduC58rtef1bVouwgMjMQDq+tcYdATdSWDDD4PAdrqMfP8ypKb9srS9zHWqDgl648I
 SQqR+Gae6o6KybFb4RpsX+7DTGwDFAlJybUT/rS4KlhOoXsxjAC76PrSTc2RAbjZdi
 cu0gUns+4AuyW+lvtABxDVuAiZ09RSeOxdhgUfVas358oIycnZa4yMfQ+hXHCMaBR6
 o4611p9+Tw/7nNaZA+AeZe3SNChv1kkuuUFzQw0qWnrrwKJsLxuXKOZfIjDXJUbc+T
 WWm51lwo9uZDQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/10] drm/vino: add the Vino framebuffer codec
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260703030217.2886-5-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
 <20260703030217.2886-5-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 03:21:22 +0000
Message-Id: <20260703032122.8B1641F000E9@smtp.kernel.org>
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
- [High] Sleeping functions called from atomic context in the hot scanout p=
ath.
- [High] Large contiguous memory allocations via `KVec` cause page allocato=
r WARNs and fail under load.
- [Medium] `Bits::esc` silently emits malformed unary prefix codes for magn=
itude categories >=3D 10, corrupting the bitstream.
- [Medium] Contradictory mathematical rounding for negative values between =
`quantize_dc` and `quantize_dc_round`.
- [Medium] Documentation for `colour_frame_ep08` contradicts its implementa=
tion and the hardware wire format.
--

commit e12de38777f2b0ee034bdb7b4eb4f91d2f8055e5
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add the Vino framebuffer codec

This commit adds the Vino framebuffer codec to the DRM subsystem, including
an RLE fallback encoder and a Walsh-Hadamard transform codec. It also
implements the EP08 wire framing for the display dock.

> diff --git a/drivers/gpu/drm/vino/video.rs b/drivers/gpu/drm/vino/video.rs
> new file mode 100644
> index 0000000000000..c520af19a4fbb
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/video.rs
> @@ -0,0 +1,1229 @@
[ ... ]
> +    pub(crate) fn encode_into(&mut self, cur: &[u16], s: &mut KVec<u8>) =
-> Result {
> +        s.extend_from_slice(&FRAME_INIT, GFP_KERNEL)?;

[Severity: High]
Is it safe to use GFP_KERNEL allocations here?

Plane atomic update callbacks are atomic context where sleeping functions a=
re
strictly forbidden. However, this encoder path is called during scanout
(VinoPlane::atomic_update() -> scanout_one() -> encode_and_send() ->
encode_into()), leading to repeated allocations with GFP_KERNEL.

Additionally, the outer encode_and_send() and encode_and_send_wht()
functions in drm_sink.rs allocate the outgoing frame buffer using
GFP_KERNEL and perform a blocking USB bulk transfer with GFP_KERNEL.

Does this regression trigger kernel warnings, system instability or deadloc=
ks
when called from atomic context?

> +        for y in 0..self.height {
> +            let row =3D y * self.width;
> +            let mut x =3D 0;
> +            while x < self.width {
[ ... ]
> +                let mut p =3D run_start;
> +                while p < run_end {
> +                    let n =3D (run_end - p).min(MAX_BLOCK_PIXELS);
> +                    let coord =3D (((row + p) * 2) & 0xff_ffff) as u32;
> +                    encode_run_into(s, self.mode, coord, &cur[row + p..r=
ow + p + n])?;

[Severity: High]
Could this KVec allocation grow too large and cause page allocator failures?

While the shadow buffer correctly uses a vmalloc-backed VVec to avoid kmall=
oc
limits, the encoded output buffer appended to via encode_run_into() can also
scale linearly with resolution and frame differences. If an uncompressible
frame is encountered (e.g. random noise at 4K resolution), the generated
stream could exceed the kmalloc contiguous memory limit before reaching the
outer 65 KB EOVERFLOW check.

Will this regression cause the page allocator to trigger WARNs and return
-ENOMEM under load, allowing userspace compositors to flood the kernel log
and stall display updates?

> +                    p +=3D n;
> +                }
> +            }
> +        }
[ ... ]
> +    fn quantize_dc(plane: usize, v: i32) -> i32 {
> +        let step =3D if plane =3D=3D 0 { 16 } else { 64 };
> +        let q =3D (((v.unsigned_abs() + 8) * (65536 / step)) >> 16) as i=
32;

[Severity: Medium]
Does this quantization apply the correct bias for chroma steps?

This function implements magnitude rounding with a hardcoded bias of 8. For
chroma values where step =3D 64, a negative value like v =3D -232 will resu=
lt
in -3 instead of -4.

A newer implementation, quantize_dc_round(), implements Euclidean rounding
using the correct step bias:

    fn quantize_dc_round(plane: usize, v: i32) -> i32 {
        let step =3D if plane =3D=3D 0 { 16 } else { 64 };
        (v + step / 2).div_euclid(step)
    }

However, the older quantize_dc() is still used for encoding solid strip DC
planes:

    pub(crate) fn solid_strip(x: u16, y: u16, ydc: i32, cbdc: i32, crdc: i3=
2) -> Result<KVec<u8>> {
        let esc =3D esc_len(quantize_dc(2, crdc), SOLID_DC_CMAX)

Could this contradictory mathematical rounding act as a regression that cau=
ses
decoding errors for negative chroma DCs?

> +        if v < 0 {
> +            -q
> +        } else {
> +            q
> +        }
> +    }
[ ... ]
> +        fn esc(&mut self, v: i32, cmax: u32) -> Result {
> +            if v =3D=3D 0 {
> +                return self.bit(0);
> +            }
> +            let c =3D mag_category(v);
> +            let off =3D v.unsigned_abs() - (1 << (c - 1));
> +            for _ in 0..c {
> +                self.bit(1)?;
> +            }

[Severity: Medium]
Should the number of unary 1 bits emitted be clamped to cmax?

The code limits the unary prefix to cmax by omitting the 0-terminator if
c >=3D cmax, but the loop unconditionally emits c ones. If a high frequency=
 edge
produces a magnitude category of 10 or higher (while cmax is 9 for AC
coefficients), this will emit 10 or more ones.

A hardware decoder expecting a maximum prefix length of 9 will stop after
reading 9 ones and interpret the 10th one as the magnitude offset, corrupti=
ng
the bitstream for the rest of the strip. Can this logic be adjusted to prev=
ent
emitting malformed unary prefix codes?

> +            if c < cmax {
> +                self.bit(0)?;
> +            }
[ ... ]
> +    /// Encode a full width x height 8-bit-RGB frame into the Vino WHT c=
olour EP08 frame(s) --
> +    /// the colour counterpart of the luma encode_frame, and the assembl=
er the live scanout path
> +    /// drives once the CP wall falls. px(x, y) yields the source pixel'=
s (R, G, B); the caller
> +    /// applies any rotation / gamma / format conversion (so this stays =
a pure codec). The surface is
> +    /// tiled into 64x16 strips in raster order, each built from colour_=
block + colour_strip.
> +    /// The forward length-hint tail is then chained across the WHOLE fr=
ame -- strip k's 2-byte
> +    /// tail is patched to strip k+1's L - 2 (the last strip keeps its o=
wn), even across EP08-frame
> +    /// boundaries. Finally the strip stream is split at strip boundarie=
s into <=3D u16::MAX - 12-byte
> +    /// EP08 frames, each prefixed with a write_ep08_header carrying an =
incrementing seq from
> +    /// seq0. Returns the ready-to-send frames and the next seq.
> +    ///
> +    /// width/height must be multiples of 64 and 16 (EINVAL otherwise) -=
- the codec's strip
> +    /// geometry; the live scanout path falls back to RLE for non-aligne=
d modes (see
> +    /// docs/VIDEO-TODO.md). Byte-exact for the recovered colour grammar=
 (chroma sync/DC/AC); the
> +    /// anti-fabrication boundary is the synthetic steepest-chroma edge =
cases (VIDEO-TODO.md 8/9).
> +    pub(crate) fn colour_frame_ep08(

[Severity: Medium]
Is the documentation for colour_frame_ep08() out of date with its current
implementation?

The docstring claims it chains a forward length-hint tail across the frame =
and
splits the stream into EP08 frames prefixed with write_ep08_header().

However, the function delegates to frame_records(), which uses a different =
TLV
record format. The comments in frame_records() explicitly state that the
legacy write_ep08_header() behavior was wrong and caused hardware faults:

    // There is no per-transfer header (the old write_ep08_header sub=3D0x30
    // over concatenated strips was wrong and made the dock fault).

Could the API documentation be updated to correctly describe the new TLV
record format instead of the obsolete layout?

> +        width: usize,
> +        height: usize,
> +        seq0: u32,
> +        mut px: impl FnMut(usize, usize) -> (u8, u8, u8),
> +    ) -> Result<(KVec<KVec<u8>>, u32)> {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703030217.2886=
-1-mike@fireburn.co.uk?part=3D4
