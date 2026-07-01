Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405F8C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7112A10E1CB;
	Wed,  1 Jul 2026 17:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BdnppTwD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CBA10E1CB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:50:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AECFF6001D;
 Wed,  1 Jul 2026 17:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DCB1F000E9;
 Wed,  1 Jul 2026 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782928205;
 bh=L2S7/AsghHCfHtEd28NUgyL6eUi7YLYxSqlmHsNV0v4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BdnppTwDevUS4EpsEITuKJbS8A6ztrPqw5dRTI5Hfet2r/QBP+YtOdSVmpcYjpZ7K
 evktv0YmOGxgJkG6N//sb9p5rUQuqL5cVV4akQqeccFdhSNIQSFwNAqEhhiWcUUNr/
 D7Ny/TCtQAa/PyEcgY7SlgWDW7ZbfzuEUxPpsvlGy3JtupVA2ZRgx4WXA8ln3VpkFu
 SuOWdGA31EEqjs5hbz5phJ9lZNP79DfCcFfix8Bz0tyERilOsDnidJwF4TigPkNQXc
 uvea+CTHH36/Cxnz1VD4gn72UZNY+Sjk4DhtmMeg4qxQ/+HnbIaJRoWWIqERz7fTiS
 p/RXBOqvJsIQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] drm/nova: use `zerocopy` in booter.rs
To: "Pedro Yudi Honda" <niyudi.honda@usp.br>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260701174056.12604-3-niyudi.honda@gmail.com>
References: <20260701174056.12604-1-niyudi.honda@gmail.com>
 <20260701174056.12604-3-niyudi.honda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 17:50:04 +0000
Message-Id: <20260701175005.38DCB1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Kernel panic due to `chunks_exact(0)` when parsing malformed firmw=
are signatures.
--

commit d903748e1752198088438b960539204b5710d605
Author: Pedro Yudi Honda <niyudi.honda@usp.br>

drm/nova: use `zerocopy` in booter.rs
   =20
In firmware/booter.rs, replace the following `transmute` traits with
their `zerocopy` equivalents:
   =20
- `transmute::FromBytes` -> `zerocopy::FromBytes`
   =20
Update call sites accordingly.

> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-=
core/firmware/booter.rs
> index acb7f4d8a5327..fe9389b84b90a 100644
> --- a/drivers/gpu/nova-core/firmware/booter.rs
> +++ b/drivers/gpu/nova-core/firmware/booter.rs
[ ... ]
> @@ -144,6 +140,7 @@ fn signatures_iter(&'a self) -> Result<impl Iterator<=
Item =3D BooterSignature<'a>>

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing iss=
ue
in signatures_iter().

If a malformed firmware file provides a num_sig greater than sig_prod_size
(but not 0), sig_size will evaluate to 0 because integer division truncates
towards zero.

Calling chunks_exact() with a chunk size of 0 triggers a kernel panic:

drivers/gpu/nova-core/firmware/booter.rs:signatures_iter() {
    ...
                self.fw
                    // Get signatures range.
                    .get(signatures_start..signatures_end)
                    .ok_or(EINVAL)?
                    .chunks_exact(sig_size.into_safe_cast())
    ...
}

Could this allow a local user who controls the firmware image or triggers
its loading to crash the kernel?

> =20
>  /// Signature parameters, as defined in the firmware.
>  #[repr(C)]
> +#[derive(FromBytes)]
>  struct HsSignatureParams {
>      /// Fuse version to use.
>      fuse_ver: u32,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701174056.1260=
4-1-niyudi.honda@gmail.com?part=3D2
