Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0895C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B62510E93C;
	Mon, 29 Jun 2026 14:22:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T1O+oyN/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0119C10E93C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:22:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 638C7600AA;
 Mon, 29 Jun 2026 14:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D602D1F000E9;
 Mon, 29 Jun 2026 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782742942;
 bh=7yuaIjDnUK0SP2/msmaxoWHMVBwkopzffdWbq6uhxnE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T1O+oyN/rDGd05Gx1YVm14nglnKfAWJDyfHZ/O6oy9C3vXzRp7Ky2ZqI2j77RJpsS
 sqU7/o1g5vOETDuIjCrNKpzxpHYIuJvUTo17adVxho2RMEiBhCwHQOoR9oUELZpmig
 zR1YQIIX6fFltkbRcutOiT4QbF3Zix7ruDhzw+b7EdzYpkcAni66r6EkOy9RC3QLhc
 WkRW/BIvW6qqEjlle2nK46X+zOpJZd+AaSR5kvGQtCh8T1R9rw2nDDBpWZa93sWPAE
 AAJXLxRMS80HoQzs0QvdE8FCHH75cMu09tEuH6oo28MjNpMsrQ3DlkIRy44fGC4p7q
 B8iUOsCuaV6Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/13] gpu: nova-core: gsp: separate context and GPU
 lifetimes in GspBootContext
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260629-nova-bootcontext-v4-12-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-12-5539d8469590@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:22:21 +0000
Message-Id: <20260629142221.D602D1F000E9@smtp.kernel.org>
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
- [Low] Incomplete lifetime separation in `GspSequencer` defeats the prepar=
atory purpose of the commit.
--

commit e32fe8760a6faf814fee0f0f066cd958f9319386
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: separate context and GPU lifetimes in GspBootContext

This commit separates the lifetimes of GPU-bound resources and the context
borrowing them in GspBootContext. This distinction is necessary because the
context will eventually carry mutable references, making the lifetimes
invariant.

[ ... ]

> diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-co=
re/gsp/sequencer.rs
> index ddce32cc4e308..422a74f9ecbd5 100644
> --- a/drivers/gpu/nova-core/gsp/sequencer.rs
> +++ b/drivers/gpu/nova-core/gsp/sequencer.rs
> @@ -335,7 +335,7 @@ fn next(&mut self) -> Option<Self::Item> {
>  impl<'a> GspSequencer<'a> {
>      pub(crate) fn run(
>          cmdq: &Cmdq,
> -        ctx: &'a GspBootContext<'_>,
> +        ctx: &'a GspBootContext<'_, '_>,

[Severity: Low]
Does GspSequencer also need to be updated to use separated lifetimes?

Looking at the struct definition for GspSequencer in this file, it still
stores the Falcon references using a single 'a lifetime, such as:
sec2_falcon: &'a Falcon<'a, Sec2>.

While this currently compiles because immutable references are covariant, it
recouples the context and GPU lifetimes that were separated in GspBootConte=
xt.

When the Falcon references are later made mutable as the commit message
indicates, they will become invariant. At that point, this conflated lifeti=
me
in GspSequencer will cause a compilation error.

Should GspSequencer be updated to use 'ctx and 'gpu as well?

>          libos_dma_handle: u64,
>          bootloader_app_version: u32,
>      ) -> Result {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-nova-bootc=
ontext-v4-0-5539d8469590@nvidia.com?part=3D12
