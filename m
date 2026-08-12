Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8E0C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 11:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C51310EF7C;
	Wed, 12 Aug 2026 11:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dW82Ofi6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E5B10EF74
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 11:54:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B54F42B38;
 Wed, 12 Aug 2026 11:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1821F000E9;
 Wed, 12 Aug 2026 11:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786535640;
 bh=szNZHjMk6c9GXPuDEHvtAZVO+/dacLaqi/9t8QBbL74=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dW82Ofi66gRYiN07csGI8+wvag1bwce9TIqUW4HeelkllnPD8lyacfkSfBtA5mf70
 xZWROCyh5GwZYO4tj99VECYv+yUB9kwXj+7tM3d2eFNbKi/FV2FEQVuwHQJlhCQtGI
 UoxBEtGYj+/+UZODvC3p48uLpbkqZUPjiTZQkXVs4IRDoZ3wIPq06wr2PNSlBLWLWD
 Y1qnu1sCYWe2mkCjSVmFHX2Jclzn18MMRKYYGsAQIBsfF30kHtn8QXxsC9xEj/leUT
 SNhG7+jY+Cooj/DCCjdXLVKZVJNEAyi0agnfD04a9rmjSTylUVBucZneaN1k60c5ZA
 bIwQteQQPpaXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260812113752.532537-2-vladazaharova2018@gmail.com>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 11:53:59 +0000
Message-Id: <20260812115359.CE1821F000E9@smtp.kernel.org>
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
- [Medium] Missing dma_rmb() between reading the 'put' pointer and reading =
the log buffer contents.
--

--- Patch [1]: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffe=
rs after unbind ---
commit 4ba5ac610ccf9ff75ece2b976056ff21931acf77
Author: Vladislav Zaharov <vladazaharova2018@gmail.com>

gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind

This commit adds a configuration option to retain GSP-RM log buffers after
the GPU is unbound. It copies the GSP log data into module-owned memory
so it can still be accessed through debugfs to help debug failed probes.

> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index 13f361406a6c3..7e2aa2dfbea3d 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs

[ ... ]

> @@ -133,9 +135,30 @@ fn new(dev: &device::Device<device::Bound>) -> Resul=
t<Self> {
> =20
>          Ok(obj)
>      }
> +
> +    /// Copies the contents of this buffer into memory that does not bel=
ong to the device.
> +    ///
> +    /// A buffer the GSP never wrote to yields an empty vector, as it ho=
lds nothing worth keeping.
> +    #[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +    fn snapshot(&self) -> Result<KVec<u8>> {
> +        // Offset 0 holds the "put" pointer, which the GSP advances as i=
t appends entries. It is
> +        // still zero if nothing was ever logged.
> +        let put =3D io_project!(self.0, [build: ..size_of::<u64>()]).try=
_cast::<u64>()?;
> +        if put.read_val() =3D=3D 0 {
> +            return Ok(KVec::new());
> +        }
> +
> +        let mut snapshot =3D KVec::zeroed(LOG_BUFFER_SIZE, GFP_KERNEL)?;
> +        io_project!(self.0, [build: ..]).copy_to_slice(&mut snapshot);

[Severity: Medium]
Does this code need a memory barrier (such as dma_rmb()) between reading the
'put' pointer and copying the buffer contents?

Because the 'put' status pointer is read from DMA memory using a volatile r=
ead,
a control dependency does not prevent the CPU from speculatively executing
subsequent loads before the status check completes. This could cause the CPU
to read stale or zeroed memory before the GSP's DMA writes are fully visibl=
e,
leading to an empty or corrupted debugfs log dump.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812113752.5325=
37-1-vladazaharova2018@gmail.com?part=3D1
