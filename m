Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C41C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F1A10EDEC;
	Wed, 19 Aug 2026 11:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K6CsfDLx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EA810EDEC
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:17:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC65860A58;
 Wed, 19 Aug 2026 11:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649891F000E9;
 Wed, 19 Aug 2026 11:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138276;
 bh=/1DVeGOAORf/B4ZlJUx+ck4B059IWGSCTv2B91sHdLY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K6CsfDLxDcc1cY18MdRvwuc3sn6sJ2eeuZJYF+AT+3xuSAw9QvYkm1KMpgUGB8lex
 ohRf8rU4ZP0Po4ClY6FMWbvU9lV0n/M8iAfyDNFQBOvdP3wfjE3J9mHSYzNx5yW7Pw
 lBKWzelbsLvoRarfEuFqWvUUA7enQ9W1A74g1IefrH3u9QweOGAiLAq37tnHZN02d7
 KdDwN0nt7OYZ7c3Evx4P/IqNxjw6FDn/QsxDI7iCCOxhB4EHQwBAhlucQb4E4SxxZN
 VuBof9B9KPppXXep3HmTR9xCF7QONa5JmiEQNgtDnHFK8lKAhuycBChNfds3nwXLJE
 7f+PB4l3JQEZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/16] rust: io: register: reimplement as proc macro
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260819-typed_register-v3-1-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-1-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:17:56 +0000
Message-Id: <20260819111756.649891F000E9@smtp.kernel.org>
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
- [High] Missing parentheses around `#idx` in the generated register offset=
 expression causes operator precedence inversion.
--

--- Patch [1]: [PATCH v3 01/16] rust: io: register: reimplement as proc mac=
ro ---
commit e2035dd40ab99d9c728dbbe1a208159d8a85be92
Author: Gary Guo <gary@garyguo.net>
rust: io: register: reimplement as proc macro

This commit reimplements the existing declarative macro for register alloca=
tion
as a proc macro. This change provides more helpful diagnostics for syntax
errors and allows more flexible syntax without follow-set restrictions.

> diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
> new file mode 100644
> index 0000000000000..61d076ab570a0
> --- /dev/null
> +++ b/rust/macros/io/register.rs

[ ... ]

> +        let offset =3D match offset {
> +            RegOffset::Fixed { offset } =3D> quote!(#offset),
> +            RegOffset::Alias { alias } =3D> {
> +                quote_spanned!(alias.span().resolved_at(span) =3D>
> +                    <#alias as ::kernel::io::register::Register>::OFFSET
> +                )
> +            }
> +            RegOffset::ElementAlias { alias, idx } =3D> {
> +                outputs.extend(quote_spanned!(idx.span().resolved_at(spa=
n) =3D>
> +                    ::kernel::build_assert::static_assert!(
> +                        #idx < <#alias as ::kernel::io::register::Regist=
erArray>::SIZE
> +                    );
> +                ));
> +                quote_spanned!(alias.span().resolved_at(span) =3D>
> +                    <#alias as ::kernel::io::register::Register>::OFFSET
> +                        + #idx * <#alias as ::kernel::io::register::Regi=
sterArray>::STRIDE

[Severity: High]
Will this cause operator precedence issues if the parsed index expression
contains addition or subtraction?

Because idx is parsed as an Expr and inserted directly into the quote block
without parentheses, complex expressions will be emitted verbatim. If a
developer uses an expression like A + B for the array index, the generated
code would expand to:

OFFSET + A + B * STRIDE

Because multiplication has higher precedence, this calculates
OFFSET + A + (B * STRIDE) instead of the intended OFFSET + ((A + B) * STRID=
E).
This could result in calculating incorrect I/O memory offsets and writing to
the wrong device registers.

Could idx be wrapped in parentheses here?

> +                )
> +            }
> +        };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D1
