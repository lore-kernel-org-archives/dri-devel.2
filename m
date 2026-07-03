Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50A2C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F4DD10F5FC;
	Fri,  3 Jul 2026 03:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QU3TKtwB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B1910F5FC
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:13:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85C6760210;
 Fri,  3 Jul 2026 03:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8B01F000E9;
 Fri,  3 Jul 2026 03:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783048394;
 bh=V7ISzH98sB9lH80TwDROUTvcjZQFwvF38bYXaYcKPWA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QU3TKtwBxmGK/acMyCRyCFvjI5lQhZWDN/gSA9DIVRWTBps17YHBaSX5r2ex7OYob
 mDBXgiMRf+PJMDVgAM4Vq/L7dS33Q3id4HGItLTgERVwWJBljDYfg2PJQEfuTZ1wye
 10Fprb3JOtgy/H/a0AiteYDfHyLfGl4kMz+MfdvdvXhnWNHf/L8aByMCjnZAKveLT1
 5qRxW6g/zvSkO6OErUJgUFAyAd7VhVm7ujJUIWhKxzcqfAK3fXKtdycAdcprJ2oYvs
 /KHv569MQze/uSI7spBZJMXKBJZdVywP80X4LrZIhMmjIHSrHzaBj3KxVimzzbRcym
 /rEYWRigb77ag==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 03/10] drm/vino: add the AES-CTR/AES-CMAC
 control-plane seal and arm sequence
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260703030217.2886-4-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
 <20260703030217.2886-4-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 03:13:13 +0000
Message-Id: <20260703031314.1B8B01F000E9@smtp.kernel.org>
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
- [High] Use of sleeping `GFP_KERNEL` memory allocations and blocking USB o=
perations in atomic KMS callbacks.
- [High] Constant mismatch in `aux_for_id` causes fallback misparsing for `=
cursor_image` messages.
- [Medium] The `seal` function fails to strip the stale MAC tag and append =
a fresh one, contradicting its explicit documentation.
--

commit 399a257fc41428dee57be4f93ca9bcdacd1d9785
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add the AES-CTR/AES-CMAC control-plane seal and arm sequence

This commit implements the post-AKE control-plane wire format for the vino
driver. It includes the AES-CTR seal, the Dl3Cmac trailer, the stream-open
arm marker, and message builders for mode-set, cursor, and DDC/CI.

> diff --git a/drivers/gpu/drm/vino/cp.rs b/drivers/gpu/drm/vino/cp.rs
> new file mode 100644
> index 0000000000000..4d55b96999b02
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/cp.rs
[ ... ]
> +pub(super) fn cursor_image(
> +    counter: u16,
> +    head: u8,
> +    w: u16,
> +    h: u16,
> +    bgra: &[u8],
> +) -> Result<KVec<u8>> {
> +    // w*h*4 can wrap a 32-bit usize (max ~1.7e10 > u32::MAX), which wou=
ld let an
> +    // undersized bgra pass the check; compute it with checked arithmeti=
c so an
> +    // overflow is rejected as a mismatch rather than silently bypassing=
 validation.
> +    let expected =3D (w as usize)
> +        .checked_mul(h as usize)
> +        .and_then(|n| n.checked_mul(4));
> +    if expected !=3D Some(bgra.len()) {
> +        return Err(EINVAL);
> +    }
> +    let mut b =3D KVec::with_capacity(32 + bgra.len(), GFP_KERNEL)?;

[Severity: High]
Does this allocate memory using a sleeping flag (GFP_KERNEL) while in an
atomic context?

When the compositor requests a frame flip or a cursor update, the DRM core
invokes the VinoPlane::atomic_update callback (which runs in an atomic
context). This atomic callback executes cp::cursor_image, which allocates
memory dynamically using GFP_KERNEL.

> +    cursor_header(&mut b, 0x401c, 0x41, counter, head)?;

[Severity: High]
Will the 0x40 high-byte flag on this cursor image ID cause a mismatch in
aux_for_id()?

In aux_for_id(), we check for 0x1c for the cursor image:

    0x1a =3D> 0x04, // cursor move
    0x1b =3D> 0x03, // cursor create
    0x1c =3D> 0x02, // cursor image
    0x1f =3D> 0x0f,

Because aux_for_id() strictly checks for 0x1c instead of 0x401c, it will fa=
ll
through to the default arm and incorrectly return (body_len / 4) as u16,
rather than the expected 0x02 length marker.

> +    pad_to(&mut b, 32)?; // off24..31 zero (no w/h here)
> +    b.extend_from_slice(bgra, GFP_KERNEL)?; // bitmap @ off32
> +    Ok(b)
> +}
[ ... ]
> +pub(super) fn seal(
> +    ks: &[u8; 16],
> +    riv: &[u8; 8],
> +    seq: u32,
> +    inner: &[u8],
> +) -> Result<KVec<u8>> {
> +    // The interactive CP stream: session ks, wire sub 0x24.
> +    seal_stream(ks, riv, 0x24, seq, inner)

[Severity: Medium]
Is the stale MAC tag properly stripped here?

The documentation for seal() explicitly mentions that we should encrypt only
content =3D inner[..len-16] and append a fresh tag. However, the implementa=
tion
delegates to a generic stream encrypter (seal_stream) on the entire inner
buffer, which ignores the requirement to slice off the stale tag and append=
 a
live MAC.

> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703030217.2886=
-1-mike@fireburn.co.uk?part=3D3
