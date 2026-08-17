Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9470AC5DF74
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6397F10E0D0;
	Mon, 17 Aug 2026 13:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L1mVJMLU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E13710E0D0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 13:06:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DF44600AE;
 Mon, 17 Aug 2026 13:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF9D1F000E9;
 Mon, 17 Aug 2026 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786972002;
 bh=EvYq/QyGTpVzPNrkzC6ie+ETpqIzv869JUVysI+XkzI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L1mVJMLUVKtvQq4v17BuOaswersI4wq9So5i13wlyd94AlTln1EtZTX+38Kglyvck
 mc9FQfoJzvX9TDc/KajduuUdF/XqvLgEv8bXVactpvt15jP3YmkQVkmGeW7KzGobej
 qc+Zx9ijEvmtDIDU1k5qIRMuPjJFNXyBjc3uD1kjzNejR2D3Qu15JXEK8r3GpT4WsD
 GqmplLqVLBLZ0wcohHMjNHAZZgn2XWLK4YmxWK76/lUPmyp8uPNjx1QSoBs7g4H+zP
 FZtJDmklUOEdDnQ6Gbjyask/P+rOW2M04zNBo5Xw4Ya7MQb9dFUzg4RnZVqa06EMpA
 ZmkRfZ5A42xIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] gpu: nova-core: add NVKV encoder
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260817-b4-nvkv-v1-2-b84db5e84b67@nvidia.com>
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-2-b84db5e84b67@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 13:06:42 +0000
Message-Id: <20260817130642.8BF9D1F000E9@smtp.kernel.org>
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
- [High] NVKV array encoding relies on host memory layout, causing endianne=
ss corruption and unconditional KUnit test failures on big-endian architect=
ures.
--

--- Patch [2]: [PATCH 2/6] gpu: nova-core: add NVKV encoder ---
commit 0223916dc52ad28f6ad72c2fdc7087b7939c7ed3
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: add NVKV encoder

This commit adds an encoder for the NVKV wire format, which encodes calls
as a sequence of 64-bit values. It includes functions to encode single
values and arrays, and adds a test for the encoding.

> diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/encode.rs
> index 0000000000000..6da81a371651a 100644
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
[ ... ]
> +    fn push_bytes_with_padding(&mut self, bytes: &[u8]) -> Result {
[ ... ]
> +        // SAFETY: At least bytes.len() bytes of space are guaranteed si=
nce num_entries
> +        // worth of space was just reserved.
> +        unsafe { core::ptr::copy_nonoverlapping(bytes.as_ptr(), dst, byt=
es.len()) };
> +
> +        let padding =3D num_entries * size_of::<u64>() - bytes.len();
> +        if padding > 0 {
> +            // SAFETY: At least num_entries * size_of::<u64>() bytes of =
space are guaranteed.
> +            unsafe { core::ptr::write_bytes(dst.add(bytes.len()), 0, pad=
ding) };
> +        }
> +
> +        // SAFETY: These bytes were just initialized and every bit patte=
rn is valid for u64.
> +        unsafe { self.backing.inc_len(num_entries) };
> +
> +        Ok(())
> +    }
[ ... ]
> +    pub(crate) fn encode_array32(&mut self, key: KeyId, index: Index, ar=
ray: &[u32]) -> Result {
[ ... ]
> +        self.push_bytes_with_padding(array.as_bytes())?;
> +        Ok(())
> +    }
[ ... ]
> +    pub(crate) fn encode_array64(&mut self, key: KeyId, index: Index, ar=
ray: &[u64]) -> Result {
[ ... ]
> +        self.push_bytes_with_padding(array.as_bytes())?;
> +        Ok(())
> +    }

[Severity: High]
Will this produce an incorrect byte stream on big-endian architectures?

Because push_bytes_with_padding() in drivers/gpu/nova-core/gsp/nvkv/encode.=
rs
copies host memory directly into the u64 backing storage, and encode_array3=
2()
and encode_array64() extract host-endian bytes via array.as_bytes(), the
endianness of the generated stream depends on the host.

[ ... ]
> +        assert_eq!(
> +            encoded[4],
> +            u64::from_le_bytes([0xaa, 0xbb, 0xcc, 0, 0, 0, 0, 0])
> +        );

[Severity: High]
Will this test unconditionally fail on big-endian systems?

The test in drivers/gpu/nova-core/gsp/nvkv/encode.rs explicitly asserts that
the generated u64 must match a little-endian layout, which seems to prove
the host-endian implementation above will produce unexpected results on
big-endian architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-b4-nvkv-v1=
-0-b84db5e84b67@nvidia.com?part=3D2
