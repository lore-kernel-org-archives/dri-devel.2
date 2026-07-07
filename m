Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27993C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A01610EC15;
	Tue,  7 Jul 2026 09:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GibIAMed";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DD810EC15
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 09:02:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC76641846;
 Tue,  7 Jul 2026 09:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B361F000E9;
 Tue,  7 Jul 2026 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783414947;
 bh=NJvxqKYafkXBHKH8SDWnGj8RVMo/CkpjCqCX/kHbXog=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GibIAMedC6QcRlRAT2sxlPcu+LUsMII+lRz6doQgBByKZyG52Z0yNHdmA4PBy7zf5
 3C9RuJi0VNbetRf+ae1f3vgiRHixOK/f2CR7Jd+h/Re4ZLLmJ+g2eL8PyoaprBJBg2
 JvIaDY1ftDPL+c+G1iVlLQcKPiM4PWVmOIfq6B9D54K4+eFz07DZhNBZT103Inqd9Z
 T2eqI6tYIEGlp2V+LR3zYpJ+bdnP80w6xx2c8pPDulKovQWmEDBzX7r2LEL88+cHEk
 xo3iUaNunyVMpiDwHDKUdH7yCG11mGiRbMJGbsXuEFCV3666A1680kYbay4EIDjSWD
 vlKsTiNC565zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/13] gpu: nova-core: gsp: separate context and GPU
 lifetimes in GspBootContext
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260707-nova-bootcontext-v5-12-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
 <20260707-nova-bootcontext-v5-12-ecad9346387f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:02:26 +0000
Message-Id: <20260707090227.61B361F000E9@smtp.kernel.org>
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
- [Low] The GspSequencer struct was not updated with separate context and G=
PU lifetimes, leaving it vulnerable to the exact covariance issue this comm=
it aims to fix.
--

--- Patch [12]: [PATCH v5 12/13] gpu: nova-core: gsp: separate context and =
GPU lifetimes in GspBootContext ---
commit 25c80f140498d9178aab39d3a011facb7416a203
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: separate context and GPU lifetimes in GspBootContext

This commit splits the lifetimes in GspBootContext into separate context and
GPU lifetimes to allow mutable references to GPU subdevices. This distincti=
on
prepares the context for holding mutable borrows of Falcon instances.

> diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-co=
re/gsp/sequencer.rs
> index ddce32cc4e308..422a74f9ecbd5 100644
> --- a/drivers/gpu/nova-core/gsp/sequencer.rs
> +++ b/drivers/gpu/nova-core/gsp/sequencer.rs
[ ... ]
> @@ -335,7 +335,7 @@ fn next(&mut self) -> Option<Self::Item> {
>  impl<'a> GspSequencer<'a> {

[Severity: Low]
Should GspSequencer also be updated to use separate 'ctx and 'gpu lifetimes?

The commit splits lifetimes in GspBootContext because holding mutable
references to GPU subdevices requires invariant lifetimes. However, the
GspSequencer struct definition still uses a single lifetime for its Falcon
references:

pub(crate) struct GspSequencer<'a> {
    bar: Bar0<'a>,
    sec2_falcon: &'a Falcon<'a, Sec2>,
    gsp_falcon: &'a Falcon<'a, Gsp>,
    ...

Will this cause similar compilation errors for GspSequencer when the Falcon
references are eventually made mutable?

>      pub(crate) fn run(
>          cmdq: &Cmdq,
> -        ctx: &'a GspBootContext<'_>,
> +        ctx: &'a GspBootContext<'_, '_>,
>          libos_dma_handle: u64,
>          bootloader_app_version: u32,
>      ) -> Result {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-nova-bootc=
ontext-v5-0-ecad9346387f@nvidia.com?part=3D12
