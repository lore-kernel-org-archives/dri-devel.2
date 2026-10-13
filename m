Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE3FCC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 605B610F0B8;
	Tue, 13 Oct 2026 17:15:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80AA410E917
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:15:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AC5742E8A;
 Tue, 13 Oct 2026 17:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DE21F00893;
 Tue, 13 Oct 2026 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791911737;
 bh=gFiG3pmlyYWOgpLysalFV7ZZWWqMTlC+ECsXtYMCvK0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XvL+kTimNWD2bxa2cG2Y+u3APh8/vf4sxWnaG6LKfgYkjnjsVb44mtM8Gr/SOFKHC
 W6LZr9jF5TkpT26RDEgR4wbKXun07iHU9YCNud3XkS7iR4bqIQw0q/iFv+QN/aUCDO
 05jrrSpHi1oxFefxxZ2hPqq7dIQMmf1dSUiAalQNevzLv+hu8LEgdxr7cJr3AIAlai
 1kaF0T9YUYanbvz7hOwDLaxVev0JgQL3b8yZt1nnpAKarc3V+G8EZ+8k1c1eKQKt0z
 Is7+/BUbOcFNweHFV+4cH4atM8+55R30oPxYx4Usk086OtsxPM6l6tyOpFINV3XiVB
 2QPjwhbeovwsA==
Message-ID: <sashiko-outbox-170199@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/7] rust: clk: use 'kernel vertical style' for imports
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
 ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261013-clk-type-state-v6-1-a5e9977b3509@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-1-a5e9977b3509@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:15:36 +0000
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
- [Low] rust: clk: missing trailing // in vertical imports in doctests
--

commit d1e8fb84f14ee05c8bc2b0c2603a25f2c8d23a0f
Author: Daniel Almeida <daniel.almeida@collabora.com>

rust: clk: use 'kernel vertical style' for imports

This commit converts all imports in the clk module to use the kernel=20
vertical style. It also drops the Result import since it is provided=20
by the prelude.

Link: https://docs.kernel.org/rust/coding-guidelines.html#imports

> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> index f04f5c4a03d64..c73fe7c572511 100644
> --- a/rust/kernel/clk.rs
> +++ b/rust/kernel/clk.rs

[ ... ]

> @@ -119,9 +125,11 @@ mod common_clk {
>      /// The following example demonstrates how to obtain and configure a=
 clock for a device.
>      ///
>      /// ```
> -    /// use kernel::clk::{Clk, Hertz};
> +    /// use kernel::clk::{
> +    ///     Clk,
> +    ///     Hertz,
> +    /// };

[Severity: Low]
This isn't a bug, but should this vertical import have a trailing // empty
comment? According to Documentation/rust/coding-guidelines.rst, vertical
imports require a trailing // to prevent rustfmt from collapsing the lines.
It looks like the doc test for Clk::get is missing it here.

>      /// use kernel::device::Device;
> -    /// use kernel::error::Result;
>      ///
>      /// fn configure_clk(dev: &Device) -> Result {
>      ///     let clk =3D Clk::get(dev, Some(c"apb_clk"))?;

[ ... ]

> @@ -293,9 +301,11 @@ fn drop(&mut self) {
>      /// device. The code functions correctly whether or not the clock is=
 available.
>      ///
>      /// ```
> -    /// use kernel::clk::{OptionalClk, Hertz};
> +    /// use kernel::clk::{
> +    ///     Hertz,
> +    ///     OptionalClk,
> +    /// };

[Severity: Low]
Similarly, should the vertical import in the OptionalClk::get doc test also
include a trailing // comment to match the kernel vertical style guidelines?

>      /// use kernel::device::Device;
> -    /// use kernel::error::Result;
>      ///
>      /// fn configure_clk(dev: &Device) -> Result {
>      ///     let clk =3D OptionalClk::get(dev, Some(c"apb_clk"))?;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-clk-type-s=
tate-v6-0-a5e9977b3509@collabora.com?part=3D1
