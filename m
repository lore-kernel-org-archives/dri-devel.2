Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2299C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F1310E0D5;
	Mon, 17 Aug 2026 07:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UrZTg20G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8E910E0D5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:12:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8418743994;
 Mon, 17 Aug 2026 07:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163A41F000E9;
 Mon, 17 Aug 2026 07:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786950755;
 bh=cjYu9YuRsXCOmq3cLxgGt/fXvdJus13yjr7OoWEs+6I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UrZTg20G3pyMET3iur6zuQs/rlcQTSQdg5JesKG160GmDGjiZvwaJys49EzKSOgiu
 6AipAh1Xk/fvi936G2YaQPE+6NjulHHaHmbivGLNcjkQ594BsO5Ezhc9jKG8BdWATq
 5ad1UYuaX9zhx4vYtZTYJvVzemr6YwcxROBPea2k2tLItsQIusYv7ZUK4lBnWdFf4h
 VtvVV8mGsVo4LgiTm/DnfNAYldwGhLGAa5RmuV+7Apm2KA2TgML46+bGXzt1X7zHI+
 L77xdka/wEFpIKyfsIcM+cl/StNZUxZng1cUg5pD80KS3TOCH0PBNxHGm49jyVa9Ha
 cdCz1Mid/8cVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] rust: sizes: implement SizeConstants for
 Alignment
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260817-chid-v7-4-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-4-a5872e64d8f4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 07:12:34 +0000
Message-Id: <20260817071235.163A41F000E9@smtp.kernel.org>
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
- [Medium] Implementing SizeConstants for Alignment logically conflates mem=
ory sizes with alignment constraints, preventing the definition of valid no=
n-power-of-two sizes.
--

--- Patch [4]: [PATCH v7 04/10] rust: sizes: implement SizeConstants for Al=
ignment ---
commit 3249458e082cdf9dedef6947c3ab8e2d8e84bcc1
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: sizes: implement SizeConstants for Alignment

This commit implements the SizeConstants trait for Alignment and adds more
size constants mirroring include/linux/sizes.h. This allows constructing
alignments using size constants like Alignment::SZ_8.

Link: https://lore.kernel.org/an4xDp29VX8Am0uR@yury

> diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
> index 521b2b38bfe77..825d6b5669524 100644
> --- a/rust/kernel/sizes.rs
> +++ b/rust/kernel/sizes.rs
[ ... ]
> @@ -117,6 +152,16 @@ pub trait SizeConstants {
> =20
>      (@impls [] $($(#[$meta:meta])* $name:ident,)*) =3D> {};
> =20
> +    (@impl_alignment $($(#[$meta:meta])* $name:ident,)*) =3D> {
> +        impl SizeConstants for crate::ptr::Alignment {
> +            $(
> +                $(#[$meta])*
> +                // A non-power-of-two constant will fail the build here =
if used.
> +                const $name: Self =3D crate::ptr::Alignment::new_checked=
(self::$name).unwrap();

[Severity: Medium]
Does implementing SizeConstants for Alignment logically conflate memory siz=
es
with alignment constraints?

If a developer later adds a valid non-power-of-two size (like SZ_3M from
include/linux/sizes.h) to the define_sizes! macro, won't it cause a mandato=
ry
compile-time panic here because Alignment::new_checked() requires a power of
two?

This seems like it would prevent developers from adding legitimate=20
non-power-of-two size constants to the macro in the future, limiting the
ability to fully mirror the C header as stated in the commit message.

> +            )*
> +        }
> +    };
> +
>      (@impls [$first:ty $(, $rest:ty)*] $($(#[$meta:meta])* $name:ident,)=
*) =3D> {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-chid-v7-0-=
a5872e64d8f4@nvidia.com?part=3D4
