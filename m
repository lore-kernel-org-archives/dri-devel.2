Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2607DC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873F810E06E;
	Mon, 28 Sep 2026 08:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iI69pSsC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117B810E06E
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:52:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6E634145A;
 Mon, 28 Sep 2026 08:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625421F000FF;
 Mon, 28 Sep 2026 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790585532;
 bh=/Sq1noXbXBnB2GWfMFvmKf4awt7ORpfIpNJEoXkggBI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iI69pSsCL93SSBRphJ7+fdf9KaxxSRK/vt10HTxs3zobr8BF5KriZUt37itRzhdoM
 WwIPX6xA4IuLue7w/j5pQMvxVpNuglVf15pypy7PkN/ydYQ27nuT8Ba/5hrqsaggv/
 brrrAszQP5PBONGEwrux3wN3KstfZsttEuhoacy11aZlRk9mnz/QXVCQVTjUa9PsiD
 zKIXY8ymN8UChKm2bLwus5FTgnd3v8GCSOvNoL+WOKtMeA52xIg4kuqIfRt0cmwGbs
 ElHWWMfb7dK7rXSXFTc4c3Ajdtw3j4GAyoDeG9tJ40rSYUHAhmrFzY6qy75V6th07E
 7a0fk6Rs7Zqfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] gpu: nova-core: add NVKV decoder
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260928-b4-nvkv-v3-5-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-5-f04504c262c2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:52:11 +0000
Message-Id: <20260928085212.625421F000FF@smtp.kernel.org>
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
- [High] nova-core: NVKV decode corrupts array layouts on big-endian hosts
--

commit 561207bfbca10da1af8ade9ea863d375b4883ed5
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: add NVKV decoder

Add a decoder for NVKV. This is for receiving messages from GSP for
GMCAPI calls. The NVKV format essentially encodes a sequence of function
calls f(key, index, value).

> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/decode.rs
> new file mode 100644
> index 0000000000000..c4c24fe1108e9
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
[ ... ]
> +    /// Takes `count` bytes. If `count` is not a multiple of 8 (`u64` si=
ze), bytes are discarded up
> +    /// to the next multiple.
> +    fn take_u8s(&mut self, count: usize) -> Result<&'a [u8]> {
> +        let values =3D self.take_u64s(count.div_ceil(8))?;
> +        values.as_bytes().get(..count).ok_or(EINVAL)

[Severity: High]
Does Cursor::take_u8s() in drivers/gpu/nova-core/gsp/nvkv/decode.rs handle
big-endian architectures correctly?

Directly casting native u64 memory to u8 slices yields the bytes in reverse
order within each 64-bit word on big-endian systems.

This could cause the NVKV protocol to fail to correctly decode (and encode)
`Array8` arrays, causing GPU initialization (GSP RPC) to fail completely or
receive corrupted data.

> +    }
> +
> +    /// Takes `count` 32-bit values. If `count` is not a multiple of 2 (=
`u64` size), bytes are
> +    /// discarded up to the next multiple.
> +    fn take_u32s(&mut self, count: usize) -> Result<&'a [u32]> {
> +        let values =3D self.take_u64s(count.div_ceil(2))?;
> +        <[u32]>::ref_from_prefix_with_elems(values.as_bytes(), count)

[Severity: High]
Can Cursor::take_u32s() corrupt array layouts on big-endian hosts?

Directly mapping native-endian u64 memory to u32 slices swaps the order of
packed elements on big-endian systems (e.g., swapping the first and second
32-bit values within the 64-bit word).

This defect prevents correctly decoding `Array32` and `Seq32` arrays on the=
se
platforms.

> +            .map(|(elems, _)| elems)
> +            .map_err(|_| EINVAL)
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-b4-nvkv-v3=
-0-f04504c262c2@nvidia.com?part=3D5
