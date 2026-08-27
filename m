Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4A2C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375C310E414;
	Thu, 27 Aug 2026 14:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jZ4jP0Zr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E1410E414
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:36:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFB6F40564;
 Thu, 27 Aug 2026 14:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BEE1F000E9;
 Thu, 27 Aug 2026 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787841389;
 bh=Xa53WmEGK5io5lQXnZfTTHUBmuVWaLZAInpuy8Ncw+4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jZ4jP0ZrgTvjI2vCBgfSG43MRSzKlXnoCLXemN7aBvoEdFNLCNdeb0QZVKF4c1XEV
 2zkSodh9wOol8XwU7SfdeZ2nUmdR/qwcEPfqr8QF9UfPB/PyT4uoEOKVjDVGGsBf1g
 ZJRrwi5ZdafvzI212MxrgNT7MMd1gvAQgmEvBv22ZxmV69jjiyIcowQx0I/onktyTz
 TWDbpz2UIR9oX2cmECl1u/2RndeelYsPU3YUjhw/Ic1pD7v4szez2KwV+z03RKglhI
 wX9tKv8y7EZHDghQEfyVNA+BEfOnNUn6FrLRx3wODvHNIrOmRZu6t33vrdJHqTmuCK
 Rnx01CqfQe2fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] gpu: nova-core: add NVKV decoder
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:36:28 +0000
Message-Id: <20260827143629.61BEE1F000E9@smtp.kernel.org>
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
- [High] Host-endianness dependency in NVKV decoder corrupts GSP messages o=
n Big-Endian systems.
--

commit 5b94f2ac2ef1beaefecc7f609e789baca4eb7809
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: add NVKV decoder
   =20
This commit adds a decoder for NVKV to receive messages from GSP for GMCAPI
calls. The decoder reads an encoded stream and invokes a type implementing
the Schema visitor trait.

> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/decode.rs
> new file mode 100644
> index 0000000000000..ceb97e73e1004
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
[ ... ]
> +    fn take_u32s(&mut self, count: usize) -> Result<&[u32]> {
> +        let values =3D self.take_u64s(count.div_ceil(2))?;
> +        <[u32]>::ref_from_prefix_with_elems(values.as_bytes(), count)

[Severity: High]
Does this code correctly handle endianness on Big-Endian architectures?

This views a byte slice derived from Little-Endian DMA memory as an array of
native 32-bit elements. On Big-Endian architectures, this will reverse the
byte order of each integer, leading to corrupted parsing of message arrays.

> +            .map(|(elems, _)| elems)
> +            .map_err(|_| EINVAL)
> +    }
[ ... ]
> +    pub(crate) fn decode<'s, S: Schema>(
> +        &self,
> +        schema: &'s mut S,
> +    ) -> Result<impl Init<S::Target, Error> + 's> {
> +        let mut cursor =3D Cursor::new(self.data);
> +        while !cursor.is_empty() {
> +            let op: Op =3D cursor.take_u64()?.into();

[Severity: High]
Can this native 64-bit read corrupt GSP message parsing on Big-Endian syste=
ms?

This reads a 64-bit word natively and parses it as a bitfield. Since the
underlying GSP memory is Little-Endian, the native bitfield extraction reads
the wrong bits entirely on Big-Endian systems, which could lead to device
initialization failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-b4-nvkv-v2=
-0-0de9d5c8658c@nvidia.com?part=3D5
