Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DEEC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3B410E977;
	Mon,  6 Jul 2026 13:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EWZ0xSev";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3800210E98C
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:03:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FDE960018;
 Mon,  6 Jul 2026 13:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39F81F000E9;
 Mon,  6 Jul 2026 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783343035;
 bh=T1XaYNNK0CiQFk1JAwIphcm52VlAbKrAR8NvG0QeYy4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EWZ0xSevsuDTbAaEQEK7qliTlNNiRlYy5rhwyEPdvd0lYDHD7KPIsGIRtRpFr/ybM
 pAexvbfeH76C+pSzJk3eT0XAcpkG2aQf+WvCcQxEUMmyt+XWZRwnxdCoQO13k7kY4L
 P7/T/Bmcf0JGLtwYRx6BB/KrkNofGH9dMrkF/2qSVfOmoROjYO5t2rfTva+S2LY+wg
 XnBq4LmbfHZJfo5PmxiLKZDl6w2X2PBC/mZbnjXVVrPevxiqpoJAMjGYvGRdk6q8qA
 XvwhH2hNVE8SypELMlasZHwADGhWk72GZoZoHD8Xwxul0D+THZXWIW/UJP493sMEAi
 0lme7fb3yJ8Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/20] rust: io: restrict untyped IO access and
 `register!` to `Region`
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-io_projection-v6-3-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-3-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:03:54 +0000
Message-Id: <20260706130354.B39F81F000E9@smtp.kernel.org>
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
- [High] Infallible 64-bit I/O accesses (`read64`, `write64`, etc.) will fa=
il to compile on 64-bit systems due to a failing `const_assert!` in `io_vie=
w_assert` (formerly `io_addr_assert`).
--

commit 9e28956aa7e8253fe2ab41dc7ddbf9af5d160ab2
Author: Gary Guo <gary@garyguo.net>

rust: io: restrict untyped IO access and register! to Region

This commit restricts untyped I/O accesses and the register macro to the Re=
gion
type. It adds a generic type to IoLoc to indicate allowed base types, paving
the way for typed register blocks.

Link: https://lore.kernel.org/rust-for-linux/DHLB3RO3OSF5.2R7F27U99BKLN@nvi=
dia.com/

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index d821ee48ed317..87141eb070564 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> @@ -437,6 +449,7 @@ fn read32(&self, offset: usize) -> u32
>      #[inline(always)]
>      fn read64(&self, offset: usize) -> u64
>      where
> +        usize: IoLoc<Self::Target, u64, IoType =3D u64>,
>          Self: IoCapable<u64>,
>      {
>          self.read(offset)

[Severity: High]
Does this regression cause a failure to compile when a driver invokes an
infallible 64-bit access method on 64-bit systems?

By restricting usize offsets to target Region, invoking an infallible 64-bit
access like read64(), write64(), or write_reg() with 64-bit registers
instantiates io_addr_assert() with U =3D u64.

Region has a hardcoded MIN_ALIGN of 4. The compile-time check explicitly
requires:

const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Target::MIN_ALIGN.=
as_usize());

On 64-bit architectures, align_of::<u64>() is 8. Thus, 8 <=3D 4 evaluates to
false, causing an immediate unconditional compilation error for any driver
attempting to perform an infallible 64-bit MMIO access. Fallible variants
like try_read64() use runtime alignment checks and are unaffected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D3
