Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB53CC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE8610E0E6;
	Wed, 26 Aug 2026 16:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TDvsnrGp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D64F710E0E6
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:56:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2669E60AAA;
 Wed, 26 Aug 2026 16:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ECD1F00A3A;
 Wed, 26 Aug 2026 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787763388;
 bh=zcG/YQoHUsqIL9hb5o0UVTRFK6wnJYV53sR/xBRoOJk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TDvsnrGpU5beOhzDw7PRr0hhFJy/UKlYslJ4Vrw5Veu3B2D77EDv4TvgGg80z38Zj
 zYCHx1k8B3LcWAIE7zlOCRsyfVPj5bg/yPKI2tsQTZhqOhwZ7l4EDrXgiKxp82bClC
 RuWLpdnGp/zBrPpADBMXKbODhG5gUTRf094OI42WdIU2tZBE7a5Hg+0R+Ke8Krxrbu
 dyN73AtbtzXxTEUmpJd6KO9gex1XUkZNgMfIRn2ZGflXbGUvcpA/xb0zOujGUpSvkR
 1fsbQ+gbN3XHs5BRJf85TraqqM9oR1tzWTCYW0SDdQ5bu+GS7zlfDHswkftNC0T5P0
 Y8FzoG4ge/oIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/13] drm/vino: add the video codec
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826163913.7052-7-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
 <20260826163913.7052-7-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:56:28 +0000
Message-Id: <20260826165628.A3ECD1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The Navarro parameter map generation exceeds the maximum record st=
ride cap (4080 bytes) for high-resolution displays like 4K.
- [High] The production entropy VLC encoder `Bits::finish` pads the final b=
yte with zeroes instead of the wire-format-required one-bits.
--

commit 74ff1e1c314d743efc9972c4a877920b6216a374
Author: Mike Lothian <mike@fireburn.co.uk>
Date:   Wed Aug 26 16:37:31 2026 +0000

    drm/vino: add the video codec

This commit adds a proprietary multilevel Haar codec to encode video frames=
=20
for DisplayLink docks. It includes the encoder, transform, strip grammar,=20
record framing, and a software color pipeline.

> diff --git a/drivers/gpu/drm/vino/video/haar/records.rs b/drivers/gpu/drm=
/vino/video/haar/records.rs
> new file mode 100644
> index 0000000000000..422ae7d83ae27
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/video/haar/records.rs

[ ... ]

> +    let mut band =3D 0usize;
> +    let mut record =3D 0usize;
> +    while band < bands {
> +        // The first record takes up to PARAM_TLVS_PER_RECORD sub-record=
s, the second the rest.
> +        let take_tlvs =3D if record =3D=3D 0 {
> +            PARAM_TLVS_PER_RECORD
> +        } else {
> +            bands.div_ceil(PARAM_BANDS_PER_TLV)
> +        };

[Severity: High]
Will this logic exceed the 4080-byte stride cap on high-resolution displays?

When configuring a supported high-resolution mode like 4K (3840x2160), the=
=20
display is split into 270 bands (bands =3D 270). The first parameter map re=
cord=20
consumes 15 TLVs (120 bands). For the second record, navarro_strip_params()=
=20
evaluates take_tlvs as 270.div_ceil(8) =3D 34.=20

The loop then writes the remaining 19 TLVs into the second record. Since 19=
=20
TLVs * 262 bytes equals 4978 bytes, this exceeds the STRIDE_CAP of 4080=20
bytes, which can cause the dock's USB endpoint to halt and the display to=20
fail.

[ ... ]

> diff --git a/drivers/gpu/drm/vino/video/haar/transform.rs b/drivers/gpu/d=
rm/vino/video/haar/transform.rs
> new file mode 100644
> index 0000000000000..b009061ce13bc
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/video/haar/transform.rs

[ ... ]

> +    /// Flush the accumulator and yield the packed bytes, zero-padding t=
he final byte.
> +    pub(crate) fn finish(mut self) -> Result<KVec<u8>> {
> +        let nbytes =3D self.nacc.div_ceil(8) as usize;
> +        for k in 0..nbytes {
> +            self.out.push((self.acc >> (8 * k)) as u8, GFP_KERNEL)?;
> +        }
> +        Ok(self.out)
> +    }

[Severity: High]
Does padding the final byte with zeros instead of ones violate the expected=
=20
wire format and risk image corruption?

In Bits::finish(), the unused high bits of self.acc contain zeros, meaning=
=20
the partial byte at the end of an unaligned strip is padded with zeros.=20
Because zero is a valid symbol in the entropy code, the dock may decode=20
unintended extra coefficients and desynchronize.=20

If the byte is padded with 1-bits instead, it forms a truncated all-ones=20
escape sequence that the decoder safely ignores.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826163913.7052=
-1-mike@fireburn.co.uk?part=3D6
