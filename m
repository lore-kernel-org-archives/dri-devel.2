Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2387BC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8172910E7CD;
	Mon, 17 Aug 2026 13:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CVjIvn60";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40AF110E7CD
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 13:06:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B843E601DE;
 Mon, 17 Aug 2026 13:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9C51F00A3A;
 Mon, 17 Aug 2026 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786972014;
 bh=qEfqV/7ihVUMLu6uNDu1ihb8wAj13tvscnwwClh2mc4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CVjIvn606++0L9AssBzOMUeDdsPjaIbiU52pylDILr/BYy7uFDM0E8jbdS8iKnV7O
 pn+swfTkvNDc5pqC4soa7qHa1B/g9y0kcsXN17sMy9JQEwCQBiHmYRlv1lg3aar2ea
 EFLT6L5R7XLU/Q7J79fawOU0Vsf5Oq4mGBYeSonwHJ6B/tFlFC9JtEOkfvIsKJlz4T
 8ByeY370Edv2foOaM2ReuwopXRXq8naoKlqSoLOND5FgsJntKMKFVp3yvWZyjNNySj
 FmIYa0/JobBnQ42uKJR5vyW3vm1Kwf/WLJ7XuOh2bI3O512vRIrt2d6rnUdb11U+93
 Dr0rWcEPw15xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] gpu: nova-core: add NVKV decoder
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-b4-nvkv-v1-3-b84db5e84b67@nvidia.com>
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-3-b84db5e84b67@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 13:06:53 +0000
Message-Id: <20260817130654.2B9C51F00A3A@smtp.kernel.org>
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
- [High] NVKV decoder uses host-endian memory pointer casts and byte castin=
g, breaking big-endian compatibility.
--

--- Patch [3]: [PATCH 3/6] gpu: nova-core: add NVKV decoder ---
commit 462ea319dececf0891b941e125a3a7cd586a70f8
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: add NVKV decoder

This commit adds a decoder for NVKV to process GMCAPI call messages from
the GSP. It introduces a Schema visitor trait to process the (key, index,
value) sequences from the encoded stream.

> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/decode.rs
> new file mode 100644
> index 0000000000000..ee8b6ab5a3a43
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
[ ... ]
> +    fn take_u8s(&mut self, count: usize) -> Result<&[u8]> {
> +        let values =3D self.take_u64s(count.div_ceil(8))?;
> +        values.as_bytes().get(..count).ok_or(EINVAL)

[Severity: High]
Does casting a native [u64] to [u8] using as_bytes() expose the native
byte order of the host? If the GSP sends data in little-endian format, won't
this yield reversed 8-byte chunks on big-endian architectures?

> +    }
> +
> +    fn take_u32s(&mut self, count: usize) -> Result<&[u32]> {
> +        let values =3D self.take_u64s(count.div_ceil(2))?;
> +        // SAFETY: `values` is 8 byte aligned and only 4 byte alignment =
is required. All bit
> +        // patterns are valid for `u32`.
> +        Ok(unsafe { core::slice::from_raw_parts(values.as_ptr().cast::<u=
32>(), count) })

[Severity: High]
Could this raw pointer cast from u64 to u32 cause issues on big-endian
systems? This appears to change the order of the 32-bit words compared to
the original little-endian GSP message layout.

> +    }
> +
> +    fn take_u64s(&mut self, count: usize) -> Result<&[u64]> {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-b4-nvkv-v1=
-0-b84db5e84b67@nvidia.com?part=3D3
