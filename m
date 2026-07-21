Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B4CC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEFA10E2EB;
	Tue, 21 Jul 2026 11:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TX1m9EUq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F9410E2EB
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:07:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AFC3E6001A;
 Tue, 21 Jul 2026 11:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229381F000E9;
 Tue, 21 Jul 2026 11:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784632077;
 bh=q/9xii2TgWiaPuMdPCqhtIUOhaSQYsKsjyKj35l8fzQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TX1m9EUqqCC1u5QBc5xWnsb3TLwxak178iVfKBuxijOKEXEHVoj99VW7E8u9yafDX
 B/NGBrU325K7p9/j6uvDntMmW4m+1AsalS1MolwZBiHqm0YFh/9Cb7ruIEZU2onJ46
 ABUWCIvxx9/iQuX4QO4giV1haDO6bhcD5P73KBHvJnr2smAeFNYAFieAcLOEuWXPM7
 4ap1Xz31tNoF+YXYHMdLHgFpL+KmdWPGbkIhF1tjRacVeuqaTiuYmeV5aH/GbD0wQl
 n7TMs5CRvPbMk8mdeCOsVJEFe7re+lZKI7PKrwmCghLfu1v3s4UiQcmlWSC5ymmLME
 PlsWqhmTMQLvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] rust: io: register: use path fragment for alias
 destination
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260721-registers_fix-v1-3-3711b2317e1f@nvidia.com>
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
 <20260721-registers_fix-v1-3-3711b2317e1f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:07:56 +0000
Message-Id: <20260721110757.229381F000E9@smtp.kernel.org>
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
- [Medium] Incomplete macro parser update preventing the use of qualified p=
aths for fixed and indexed alias destinations.
--

--- Patch [3]: [PATCH 3/8] rust: io: register: use path fragment for alias =
destination ---
commit 2d0652e05a1a9983e77fe52bcfa5cbaeead4c274
Author: Alexandre Courbot <acourbot@nvidia.com>

rust: io: register: use path fragment for alias destination

This commit updates the register! macro to use a path fragment instead of
ident for alias destinations. This aims to allow referencing registers using
a qualified path instead of only identifiers visible from the current modul=
e.

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index 82f674aea45a2..1e0e23e4233fa 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -809,7 +809,7 @@ macro_rules! register {
>              $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
>                  $([ $size:expr $(, stride =3D $stride:expr)? ])?
>                  $(@ $($base:ident +)? $offset:literal)?
> -                $(=3D> $alias:ident $(+ $alias_offset:ident)? $([$alias_=
idx:expr])? )?
> +                $(=3D> $alias:ident $(+ $alias_offset:path)? $([$alias_i=
dx:expr])? )?

[Severity: Medium]
Does this top-level rule unintentionally restrict fixed and indexed aliases?

While the inner @reg rules were updated to use $alias:path, this main parsi=
ng
rule still captures $alias as an ident. Because of this, it appears that
using a qualified path (like =3D> module::ALIAS) for fixed or indexed alias=
es
will fail to match here and result in a compilation error.

Should $alias:ident also be changed to $alias:path in this top-level
match pattern so that fixed and indexed aliases can fully benefit from this
update?

>              { $($fields:tt)* }
>          )*
>      ) =3D> {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-registers_=
fix-v1-0-3711b2317e1f@nvidia.com?part=3D3
