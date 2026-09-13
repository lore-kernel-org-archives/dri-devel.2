Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B69C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 18:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E5410E155;
	Sun, 13 Sep 2026 18:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LGs5cwrI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB29410E155
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 18:47:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC39360F86;
 Sun, 13 Sep 2026 18:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E301F000FF;
 Sun, 13 Sep 2026 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789325234;
 bh=7hAqPTPviqrHFBHPsJlHnMDacB8iKvTbRwXQDNkEmDU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LGs5cwrI/9f4XcJpdFCtoCuWT/UdjPs8vIGejXpFwMx2IQN1eYVtyUWBOXdqZiFgt
 EwcWQXXa69wYx3yyoPlm3AaAfKkTP4YPToKr+TkfyGPxXQjEwNOjMyx9uKoqrKnuaD
 JjZrjRCOMc4W54XSw5k698trYCy7vcGmfhvViDqXbcXn+UOsJHA0bsJQbT0qe6kC27
 nmANXnHnNjlz87oycJGrTkvsI7BzmXUlYX3hatAZksZYLZugsocpqS5ZplaYaXA1cy
 WJJzTkh0TQO6nRdMCTkRoSUAUBL/4d1q8A4VjVDLo9sA0e8hYTbSx13zpQJfWkrThw
 tXLpPNI0M37iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] gpu: nova-core: move the debugfs root into the
 module data
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260913183734.134307-2-vladazaharova2018@gmail.com>
References: <20260913183734.134307-1-vladazaharova2018@gmail.com>
 <20260913183734.134307-2-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 18:47:13 +0000
Message-Id: <20260913184714.03E301F000FF@smtp.kernel.org>
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
- [Low] Missing invariant comment for `DebugfsData` construction
--

commit f5ca13df2d92dfa80fcdd81e199934e5ce48a7c2
Author: Vladislav Zaharov <vladazaharova2018@gmail.com>

gpu: nova-core: move the debugfs root into the module data

This commit moves the debugfs root directory into a new DebugfsData
structure owned by the module, instead of using a static mut with a guard
type. This prevents leaks where a failing driver registration would leave
the directory lingering.

> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/n=
ova_core.rs
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs

[ ... ]

> +impl DebugfsData {
> +    /// Creates the shared data and publishes it, so that [`debugfs_data=
()`] can hand it out.
> +    fn new() -> impl PinInit<Self> {
> +        pin_init!(&this in Self {
> +            root: debugfs::Dir::new(c"nova-core"),
> +            _: {
> +                // SAFETY: Module initialization runs once and before th=
e driver is registered, so
> +                // nothing can be reading `DEBUGFS_DATA` while it is wri=
tten here. `this` is where
> +                // the data is being built, and it stays there: the modu=
le data never moves.
> +                unsafe { DEBUGFS_DATA =3D this.as_ptr() };
> +            },
> +        })
> +    }

[Severity: Low]
Is an // INVARIANT: comment missing here? DebugfsData has a documented
invariant, and is being constructed here via pin_init!, but there is no
comment explaining how the invariants are satisfied.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913183734.1343=
07-1-vladazaharova2018@gmail.com?part=3D1
