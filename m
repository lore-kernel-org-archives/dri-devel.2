Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1062CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3A210EC83;
	Tue, 23 Jun 2026 20:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ea4jQ9R0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D212410EC83
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:12:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56E60600AB;
 Tue, 23 Jun 2026 20:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36131F000E9;
 Tue, 23 Jun 2026 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782245554;
 bh=RHdfZYuW48T5FPkRpyafR6FY2RlJT595hhjpjZuhP+o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ea4jQ9R0NEoBcXhdbivsTptMDTBZ4pzc+98nz8+iQnb6FdaY9yuhCzdI+6Xm8WV68
 Fjlu64LVluTdkDPCBi5Zf5aqsyue/WLSq0C3uD/Sf5g2a8oZNiVNV+wYkPowSmpSpc
 TybeLMqgpfgll+hewbZjvTZUzKnP5nO4posGPZrRXik1pe6l/mb9O/qPtWGY0AVTdd
 RFzg1cjC+j1O3gBtsBbnzbNPxdvSHkBuoRWskn/rXF/eBUFuFYHAS6HQF6mnkmtNdO
 bmyPz58PT5BfYt7+Y6q/TVmCRfrVU1IrZ3SUKxfZFUf1LZ4v4TzDZVRS7shonlO1ks
 +dvJN5UymNoMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] gpu: nova-core: falcon: Move PFALCON2 register
To: "Antonin Malzieu Ridolfi via B4 Relay" <devnull+dev.nanonej.com@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260617-nova-core-regs-split-v1-3-4c7dc4450ea7@nanonej.com>
References: <20260617-nova-core-regs-split-v1-3-4c7dc4450ea7@nanonej.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:12:33 +0000
Message-Id: <20260623201233.D36131F000E9@smtp.kernel.org>
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
- [Low] Broken intra-doc link for `FalconModSelAlgo` causes rustdoc build f=
ailures.
--

commit 38e6d24ce9170693f7e3057866f61c8d872b90e3
Author: Antonin Malzieu Ridolfi <dev@nanonej.com>

gpu: nova-core: falcon: Move PFALCON2 register

This commit moves the PFALCON2 register definition into the falcon module
and updates register visibility.

> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 94c7696a64935..c2215ddd9e804 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs

[ ... ]

> @@ -99,7 +99,7 @@ pub(crate) enum FalconSecurityModel with TryFrom<Bounde=
d<u32, 2>> {
> =20
>  bounded_enum! {
>      /// Signing algorithm for a given firmware, used in the
> -    /// [`crate::regs::NV_PFALCON2_FALCON_MOD_SEL`] register. It is pass=
ed to the Falcon Boot ROM
> +    /// [`super::regs::NV_PFALCON2_FALCON_MOD_SEL`] register. It is pass=
ed to the Falcon Boot ROM

[Severity: Low]
This isn't a bug, but does this create a broken intra-doc link for rustdoc?

Since this enum is in the falcon module, super::regs would resolve to
crate::regs, but the register definition was just moved into the falcon
module.

Would it be better to use regs::NV_PFALCON2_FALCON_MOD_SEL instead to
prevent rustdoc build warnings or failures?

>      /// (BROM) as a parameter.
>      #[derive(Debug, Copy, Clone)]
>      pub(crate) enum FalconModSelAlgo with TryFrom<Bounded<u32, 8>> {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-nova-core-=
regs-split-v1-0-4c7dc4450ea7@nanonej.com?part=3D3
