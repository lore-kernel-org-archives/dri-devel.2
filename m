Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29FBC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF5C10F61E;
	Fri,  3 Jul 2026 03:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RgGHtoS3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3C110F61E
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:14:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7DC44146E;
 Fri,  3 Jul 2026 03:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722981F000E9;
 Fri,  3 Jul 2026 03:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783048472;
 bh=xYC2xpAagjRGUo5stZwLQ0nGL78uAiykoI7raHMPrmI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RgGHtoS3dLYgI34xjmRrYxCUzgPRED+W8ftyeqVIFTEMx4kB5Z2wY8zmLJf78460U
 MU8Xt7o88FNzvgkfkVmp/MRDezaQDys0oi/Y+p33WF+TTL/3cxXIVBZP2HgETeXe81
 TdtR9+FgLDTmyfQSkXbjM+Ok1JSGux62dMdoTASjHLs900Wip/IFFStadTdVdvCswK
 GGySPckrMg6SVXHvzGPexDav/lEYOX9CHKc+N+1a24bVYlo70F3z3R3doPoZak6rLj
 NrxfscQjYcoU6F0zEm8GQQmWl/KwA7xoZhjcrbcG3u3wu/1H2RgtNED7oXbHScUxl2
 B8gwrfsFRK2Dg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/10] drm/vino: add the clean-room HDCP 2.2
 AKE/LC/SKE handshake
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260703030217.2886-3-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
 <20260703030217.2886-3-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 03:14:32 +0000
Message-Id: <20260703031432.722981F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The HDCP OUT message builder `body()` omits a mandatory 2-byte pad=
ding at the start of the message body, misaligning the header fields and pa=
yload by 2 bytes.
--

commit ff0736a0543094c7762c8587ebbe6bbde5a3fe43
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add the clean-room HDCP 2.2 AKE/LC/SKE handshake

This commit introduces a clean-room implementation of the HDCP 2.2 handshake
(AKE/LC/SKE) for the vino driver. It includes cryptographic adapters, proto=
col
message builders, key derivation routines, and captured plaintext
control-plane skeletons. The implementation builds and parses wire frames
strictly verified against the reference daemon traffic.

> diff --git a/drivers/gpu/drm/vino/ake.rs b/drivers/gpu/drm/vino/ake.rs
> new file mode 100644
> index 0000000000000..38919624cb2f3
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/ake.rs
[ ... ]
> +/// Allocate a body_len-byte zeroed body with the sec 5.1 header filled =
in
> +/// (sub_size, the 0x0010 marker, hdcp_seq, the 0x30 marker and msg_id).
> +/// The caller writes the payload into body[28..].
> +fn body(body_len: usize, sub_size: u16, hdcp_seq: u32, msg_id: u8) -> Re=
sult<KVec<u8>> {
> +    let mut b =3D KVec::from_elem(0u8, body_len, GFP_KERNEL)?;
> +    b[0..2].copy_from_slice(&sub_size.to_le_bytes());
> +    b[2..4].copy_from_slice(&0x0010u16.to_le_bytes());
> +    b[4..8].copy_from_slice(&hdcp_seq.to_le_bytes());
> +    b[22..26].copy_from_slice(&0x0000_0030u32.to_le_bytes());
> +    b[27] =3D msg_id;

[Severity: High]
Does this message builder omit a mandatory 2-byte padding at the start of t=
he
payload?

Comparing this against the golden capture (CAP_PLAIN_1080P) in golden.rs, t=
he
48-byte body starts with a 2-byte zero padding at offsets 16-17 (right after
the 16-byte transport header), placing the sub_size at offsets 18-19 (body
offset 2).

By writing sub_size at b[0..2], hdcp_seq at b[4..8], the marker at b[22..26=
],
and msg_id at b[27], the entire layout appears to be shifted left by 2 bytes
compared to the expected hardware offsets.

Will this misalignment cause the dock to reject the HDCP handshake because
the fields and cryptographic payload are not where the hardware expects the=
m?

> +    Ok(b)
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703030217.2886=
-1-mike@fireburn.co.uk?part=3D2
