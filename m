Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E08ACD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0172B10F99F;
	Mon,  8 Jun 2026 20:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="niLk0ONf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BAA10F99F
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:11:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3C544432A;
 Mon,  8 Jun 2026 20:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E111F00893;
 Mon,  8 Jun 2026 20:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780949506;
 bh=aGoSGf4/3Co8QabBU5DlHxcT0QrDmh3zpzQ19Bd3JXI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=niLk0ONfSzyta4Qzw+zT9AZKXvSQTwxQ0gb7bENOUPlv3CdicPhRSwzSqDk4Ok68b
 9Qfoh3z1U6MfRwU/C4aqPOjjKx/z4d7Ib3xR588Pf4WsXdEeHLT/WbXjOqL0K4YeqN
 QDLk8siNFItAV2c18mr+glkzxIBGd0pJNEb8DeM2zCjb8boqbx3wnES4BL8rqnLm8U
 teJR2NHv89n6nyeIygmdYvG3lUBMejBCB8N9rQidOzdjrPWoVQC66zlXCaWfMVELOw
 8z7pqkzEY4ohqqgUoShibHruVrsrAoz47JqXdIM1VVkHLfpPYgaG/ndHRPehx0l5fY
 M9/CZKG+mHPOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/19] rust: pci: io: make `ConfigSpace` a view
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260608-io_projection-v3-8-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-8-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:11:46 +0000
Message-Id: <20260608201146.70E111F00893@smtp.kernel.org>
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
- [High] The `ConfigSpace` struct silently lost its auto-derived `Send` and=
 `Sync` implementations due to the introduction of a raw pointer (`*mut T`)=
, breaking concurrent and async usage.
--

commit be5814bc2aca3acaf94cbcc863fd786a8ccdd291
Author: Gary Guo <gary@garyguo.net>

rust: pci: io: make ConfigSpace a view

This commit splits I/O types into owned objects and views to support I/O
projection. It updates ConfigSpace to be a generic view that represents a
subregion by encoding the offset and size directly via pointers.

> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index e0acb62f58a23..a4cfa1ec6e62f 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs

[ ... ]

> -pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind =3D Extended> {
> +pub struct ConfigSpace<'a, T: ?Sized =3D Extended> {
>      pub(crate) pdev: &'a Device<device::Bound>,
> -    _marker: PhantomData<S>,
> +    ptr: *mut T,
> +}

[Severity: High]
Does the introduction of the raw pointer ptr: *mut T silently drop the Send
and Sync auto-trait implementations for ConfigSpace?

Previously, with PhantomData, ConfigSpace safely inherited Send and Sync
from its Device reference. Because raw pointers do not implement these
traits, ConfigSpace might now be restricted to single-threaded use. This
could prevent it from being passed to workqueues or held across await
points in async driver code.

Are explicit unsafe impl Send and unsafe impl Sync blocks needed here to
restore concurrent usage capabilities?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D8
