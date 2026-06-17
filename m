Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5886ECD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B337210F0FB;
	Wed, 17 Jun 2026 20:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n1cXs2Di";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C8110F0FB
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:13:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4525842B64;
 Wed, 17 Jun 2026 20:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1831F000E9;
 Wed, 17 Jun 2026 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781727210;
 bh=mMcMHkcsYFqJoM0tWz/5aUuTE8FhTTShtVlBKlss/7g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n1cXs2DiMgzfJLhkPsaElrwAs9HS0eEEakkHp67Q0O2BZwM6GHkVx6bp4+6y5meET
 9D6YshkWsD78WgOAkBlKKC+5iyf2WS9NSYQ2n0AckWbrDHMPGwHvprwOwPlk9Gb+Zc
 RM4rlMTdJA6WDNF3ehk5Rg46+4lKR99lf2CZgeXsbR6HI16zKdXPbipkLg61twvoqY
 8V/WrLsAMZGxikg+zeuyICCcSrYt64C2whdmGOq3K9ZzL4BgFQD99LWl3BZ1sMtGLQ
 oITHVqm9F7Ad78k0Iof9CKK7hcd+la5Fr7VyP6qqWVqj4Dg3ISJAtiHXTRRGO8abXL
 BuX2SwoXB76vw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/7] drm/vino: add the Vino (RawRl mode-2)
 framebuffer codec
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260617151249.2937-5-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260617151249.2937-5-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:13:29 +0000
Message-Id: <20260617201329.ED1831F000E9@smtp.kernel.org>
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
- [High] The EP08 transport header truncates the payload length to 16 bits,=
 corrupting frames larger than 64KB.
- [High] Incorrect indexing of the `SECTION_CODE` array causes `Mode::Rle` =
and `Mode::Adaptive` to emit the wrong frame-end section codes.
- [High] The encoded stream uses `KVec<u8>`, which relies on contiguous kma=
lloc and will fail for large frame updates.
- [High] The encoder partially updates its shadow buffer before an error oc=
curs, causing permanent corruption of the differential stream.
--

commit f949babe97f31ea182f0de355c24ec2f2844883f
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add the Vino (RawRl mode-2) framebuffer codec

Add the video module: the RawRl ("Raw/RLX" mode-2) encoder, clean-room
from the AArch64 reference-driver decompile, which emits packed-RGB565
frames the dock decodes without the impractical Vino Walsh-Hadamard
entropy codec.

> diff --git a/drivers/gpu/drm/vino/video.rs b/drivers/gpu/drm/vino/video.rs
> new file mode 100644
> index 0000000000000..bb5ea893575fc
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/video.rs

[ ... ]

> +    pub(super) fn encode(&mut self, cur: &[u16]) -> Result<KVec<u8>> {
> +        let mut s =3D KVec::new();
> +        self.encode_into(cur, &mut s)?;
> +        Ok(s)
> +    }
> +
> +    /// Like [`encode`](Self::encode) but appends the marker stream to a=
 caller-owned
> +    /// `out` instead of allocating a fresh `KVec`. The hot scanout path
> +    /// ([`encode_and_send`](super::drm_sink::encode_and_send)) uses thi=
s to encode
> +    /// straight into a buffer that already reserves the EP08 transport =
header, so a
> +    /// frame costs one allocation with no separate framing copy.
> +    pub(super) fn encode_into(&mut self, cur: &[u16], s: &mut KVec<u8>) =
-> Result {

[Severity: High]
Does KVec allocation risk causing kmalloc failures for large frame updates?

The encode function allocates a KVec to hold the encoded frame. Since the
encoded output for a full Raw frame or an incompressible Adaptive frame can
approach or exceed 4 MiB, this vector might grow beyond the page allocator's
maximum contiguous kmalloc order. Could this lead to page allocator warnings
and failures during heavy frame updates?

> +        s.extend_from_slice(&FRAME_INIT, GFP_KERNEL)?;
> +        for y in 0..self.height {
> +            let row =3D y * self.width;
> +            let mut x =3D 0;
> +            while x < self.width {
> +                while x < self.width && cur[row + x] =3D=3D self.shadow[=
row + x] {
> +                    x +=3D 1;
> +                }
> +                if x >=3D self.width {
> +                    break;
> +                }
> +                let run_start =3D x;
> +                while x < self.width && cur[row + x] !=3D self.shadow[ro=
w + x] {
> +                    x +=3D 1;
> +                }
> +                let run_end =3D x;
> +                let mut p =3D run_start;
> +                while p < run_end {
> +                    let n =3D (run_end - p).min(MAX_BLOCK_PIXELS);
> +                    let coord =3D (((row + p) * 2) & 0xff_ffff) as u32;
> +                    encode_run_into(s, self.mode, coord, &cur[row + p..r=
ow + p + n])?;
> +                    p +=3D n;
> +                }
> +                for k in run_start..run_end {
> +                    self.shadow[row + k] =3D cur[row + k];
> +                }

[Severity: High]
Does this error handling permanently corrupt the differential stream if an
allocation fails?

The shadow buffer is mutated iteratively inside the processing loop after
encode_run_into(), which can return an error via ?. If it fails, the frame
processing is aborted and not sent. However, the shadow buffer has already
been updated with the pixels from successfully processed runs. Because the
dock never receives the aborted frame, its internal state no longer matches
the host's self.shadow, which will cause visual artifacts on subsequent
frames since the encoder will assume the dock already has those pixels.

> +            }
> +        }
> +        let code =3D SECTION_CODE[(self.mode as usize).saturating_sub(1)=
.min(6)];

[Severity: High]
Does saturating_sub(1) map the 0-based enum values incorrectly for Mode::Rle
and Mode::Adaptive?

The Mode enum is 0-based (Raw =3D 0, Rle =3D 1, Adaptive =3D 2). Applying
saturating_sub(1) evaluates to 0 for both Raw and Rle, making Mode::Rle emit
SECTION_CODE[0] (0x01). Similarly, Mode::Adaptive evaluates to index 1 and
emits SECTION_CODE[1] (0x00). This causes the encoder to emit the wrong
framing codes for RLE and Adaptive modes, breaking hardware decoding.

> +        s.extend_from_slice(&SYNC, GFP_KERNEL)?;
> +        s.extend_from_slice(&[0xaf, 0x20, 0x1f, code], GFP_KERNEL)?;

[ ... ]

> +pub(super) fn write_ep08_header(hdr: &mut [u8], payload_len: usize, seq:=
 u32) {
> +    hdr[0] =3D 0;
> +    hdr[1] =3D 0;
> +    hdr[2..4].copy_from_slice(&((payload_len + 12) as u16).to_le_bytes()=
);

[Severity: High]
Can casting the payload length to u16 truncate it and break the transport
header for large frames?

A full 1080p frame encoded in Raw or Adaptive mode produces a payload of
several megabytes (up to ~4 MiB). Casting this usize payload length to u16
will silently drop the upper bits. Could this be the reason for the USB res=
ets
noted in the module documentation, as the dock would receive a malformed
header with an incorrect size and lose framing synchronization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617151249.2937=
-1-mike@fireburn.co.uk?part=3D4
