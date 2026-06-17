Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA065CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547A410EB29;
	Wed, 17 Jun 2026 20:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RtmXsN7f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED1C10EB29
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:12:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 67681407C6;
 Wed, 17 Jun 2026 20:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219801F000E9;
 Wed, 17 Jun 2026 20:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781727142;
 bh=2g+vKR6TE7Cu6VCwLuATNVYwi625yjIZq8JKBVHIUV8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RtmXsN7fOlxXWYc5JvQp8p9fDFIhKUHKVjGxwCMyupxv5mmrA8G1XVyCcGiC16ZWn
 YR8ewD6obSHXKLGU/YS4rgraK7XA3Pz0elJ9VcFpYMegHVL7KVzSdai28fAfI1rto7
 rrrLaX6LrBXCgItAekca9Cc9pTXBAPczPA+XP7yF68geHbJoqfgDJ8bmnuqVgHoQiV
 0EGBNUqVZy2QFRaImnWwkrr9FCngPhWRQ/DK3fjohWfpLZ9XkZAsLyI/9D8tVxM2Xu
 K68BWxIgJiHxGkyB07HIvcTnOvNTGPx/Ir3Sr4m6ME++NW8XNPkt7yz08BZ8KOaSff
 VsvCGcNT4ZcNA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/7] drm/vino: add the clean-room HDCP 2.2 AKE/LC/SKE
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260617151249.2937-3-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260617151249.2937-3-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:12:21 +0000
Message-Id: <20260617201222.219801F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Buffer truncation and USB Babble errors due to undersized buffer a=
llocation in `recv_hdcp` and `pace_cap_ack`.
- [High] Premature pacing abort on short frames in `pace_cap_ack`.
- [Low] Mismatch between `crypto_selftest` docstring and actual implemented=
 test coverage.
--

commit 102ea10e819242d5dcf97bac1a8fb013c88b76f5
Author: Mike Lothian <mike@fireburn.co.uk>
Subject: drm/vino: add the clean-room HDCP 2.2 AKE/LC/SKE

After the plaintext session init, the DL3 dock requires an HDCP 2.2
session before it will accept any control-plane traffic. Add a clean-room
implementation of the HDCP 2.2 authentication.

> diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
> index 79f446041b648..db4c38b6dc92f 100644
> --- a/drivers/gpu/drm/vino/vino.rs
> +++ b/drivers/gpu/drm/vino/vino.rs
[ ... ]
> @@ -150,6 +150,44 @@ impl WorkItem for BringUp {
>  /// On-device crypto known-answer self-test. Confirms the IN-KERNEL cryp=
to path (which the CP seal
>  /// depends on) is byte-correct -- something only ever checked offline (=
Python `verify-kdf.py`)
>  /// before.
>  /// Runs three checks and logs PASS/FAIL:
>  ///   1. AES-128-ECB vs the FIPS-197 test vector.
>  ///   2. AES-CMAC vs the RFC 4493 test vector (subkey + full-block path).
>  ///   3. The full `cp::seal_livemac` vs cold-ref's REAL msg0: known plai=
ntext + known `ks`/`riv`

[Severity: Low]
This isn't a bug, but the docstring mentions a third test for cp::seal_live=
mac
that doesn't seem to be implemented in the function body. Could the comment=
 be
updated to reflect the actual tests?

[ ... ]
> +    fn recv_hdcp(dev: &usb::Device) -> Result<(u8, KVec<u8>)> {
> +        const SUB_HDCP_RESP: u16 =3D 0x25;
> +        let mut buf =3D KVec::from_elem(0u8, 4096, GFP_KERNEL)?;

[Severity: High]
Does this buffer allocation correctly size the read for the endpoint?

The dock's interleaved capability blocks can reach ~5.8 KiB. Because this
buffer is only 4096 bytes, if the dock pushes a large capability block duri=
ng
the AKE sequence, it looks like it will result in a USB truncation error
(-EOVERFLOW).

Using the EP84_BUF constant (16384 bytes) here, similar to wait_cap_complet=
e(),
might prevent this.

[ ... ]
> +    fn pace_cap_ack(dev: &usb::Device, want_ctr: u16) {
> +        let Ok(mut buf) =3D KVec::from_elem(0u8, 4096, GFP_KERNEL) else {
> +            return;
> +        };

[Severity: High]
Can this buffer suffer from the same truncation issue as recv_hdcp()?

If the capability block exceeds 4096 bytes, this looks like it could also
trigger an -EOVERFLOW error.

[ ... ]
> +        for _ in 0..8 {
> +            match dev.bulk_recv(EP_CTRL_IN, &mut buf, Delta::from_millis=
(30)) {
> +                Ok(len) if len >=3D 22 =3D> {
> +                    let wsub =3D u16::from_le_bytes([buf[8], buf[9]]);
> +                    let iid =3D u16::from_le_bytes([buf[16], buf[17]]);
> +                    let ictr =3D u16::from_le_bytes([buf[20], buf[21]]);
> +                    // The per-frame cap-ack: wsub=3D0x25, inner id=3D0x=
14 sub=3D0x10 ctr=3Dwant.
> +                    // An interleaved cap push (sub=3D0x84) or earlier a=
ck -- keep reading.
> +                    if wsub =3D=3D 0x25 && iid =3D=3D 0x14 && ictr =3D=
=3D want_ctr {
> +                        return;
> +                    }
> +                }
> +                // Nothing queued within the short window -- the dock is=
 idle, don't block.
> +                _ =3D> return,

[Severity: High]
Will this catch-all arm prematurely abort the loop on short frames?

If the dock sends short interleaved status or ACK frames (where len is less
than 22), the match falls through to the catch-all arm instead of continuing
to wait for the target ACK.

This seems like it would cause the driver to transmit the next message while
the dock is mid-NAK, which could trigger a NAK storm and prevent control-pl=
ane
engagement.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617151249.2937=
-1-mike@fireburn.co.uk?part=3D2
