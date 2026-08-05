Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77C4C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE7E10EF50;
	Wed,  5 Aug 2026 16:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nqs/3ApA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6631210EF50
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:47:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97CDB60A5A;
 Wed,  5 Aug 2026 16:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD741F000E9;
 Wed,  5 Aug 2026 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948461;
 bh=OnPGKR/J4KGycTQcjXUUyXyreKYv2S6DrlkClx14ODQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nqs/3ApAdR0cMFYRi1zOG5/9bcJElrm+qAGxSMBhsBwUjG31wsR7TuN3hT6UahsvR
 d1SOgO7ti63EIiY/NMAOZcAquQQVTjbIUBSOXCpSHAqLIt7m+c454pGNqvGtkse2dS
 VNkgW7y5wrQuCUdJZsr1S/FXSmiCbr+iPyPi9A6kY3HJDiB8WdDKFylKj6JoTW8fAg
 JX+HTeve9wyN38gtOxIM9ITyF/m6lo8dk/ZJR0e4gcS2bo87AqqvUHy3HQzeq8YvrU
 cYOrqXoJ2Z+kqIKPhEgk8Vt43k0POw5r89nbaq4x55DS1cp/qNuFj3P6JSji+5373b
 nf+HF5kIfWlUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/16] drm/tyr: specify base type for registers
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260805-typed_register-v2-8-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-8-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:47:39 +0000
Message-Id: <20260805164740.EAD741F000E9@smtp.kernel.org>
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
- [Medium] Incomplete application of base parameter in register! macro invo=
cations.
--

--- Patch [8]: [PATCH v2 08/16] drm/tyr: specify base type for registers ---
commit 53a6ffbf27038a15b41db145d107fac75047c4d1
Author: Gary Guo <gary@garyguo.net>

drm/tyr: specify base type for registers

This commit updates all register definitions to explicitly use the TyrRegis=
ters
base type in the register! macro invocations.

> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index a62724378ced2..3e6edae6e27f7 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs

[ ... ]

> @@ -1353,6 +1384,8 @@ fn from(cmd: MmuCommand) -> Self {
>          }
> =20
>          register! {
> +            base: TyrRegisters;
> +
>              /// MMU command register for each address space. Write only.
>              pub(crate) COMMAND(u32)[MAX_AS, stride =3D STRIDE] @ 0x2418 {
>                  7:0     command ?=3D> MmuCommand;

[Severity: Medium]
The commit message states that all registers are updated to use the new base
type, but it looks like a few register! invocations were missed during the
conversion.

For instance, earlier in this same file (drivers/gpu/drm/tyr/regs.rs), the
LOCKADDR register block doesn't have the new base parameter:

        register! {
            /// Lock region address for each address space.
            pub(crate) LOCKADDR(u64)[MAX_AS, stride =3D STRIDE] @ 0x2410 {
                /// Lock region size.
                5:0     size;

Additionally, the SectionFlags register in drivers/gpu/drm/tyr/fw.rs was al=
so
missed by this patch:

    register! {
         #[allow(non_upper_case_globals)]
        pub(super) SectionFlags(u32) @ 0x0 {
            0:0 read =3D> bool;

Were these intentionally left with the default base type, or were they=20
overlooked during the refactoring?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D8
