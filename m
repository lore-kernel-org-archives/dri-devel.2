Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2590ECD98F0
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 23:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ADB510EF05;
	Thu, 18 Jun 2026 23:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oyh3PmdB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E88310EF05
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 23:15:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 35F8240057;
 Thu, 18 Jun 2026 23:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62C41F00A3A;
 Thu, 18 Jun 2026 23:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781824536;
 bh=K1HMKo5uPdMFsav/GRPB+8cQk7/dmgn5hySW+5uX/J8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oyh3PmdBkRrmZyZXKux8XRLbFn7y5c4zF/GRisiQynrAOPdJ/bKgAW2VPUKkmqMrj
 A+FGXIQ6ZhTZ8XK+8jdlT2bJ75FV8hUZeiyXO5HpVQ9QOOTxag/0C+hImsbKsf9Y3O
 divr73lKBz/sZ7SPqxwoi10Hp4ofY02Qc2QajsBVGsHB8otWG3O6a4O1GhFjy7AASX
 Uou1ks9l791OnnHK9UxeLG4lYNE4J9Q5ipnr3Mu+Q9M+c2YvBPeicvl1xCOxAo0x5m
 BfM0dDiGWUJPtIz2Jwxh4rSYvSikJHfrnybjP208puGeE2E90d1vmBnclcp2va4jIq
 zShV2RyM6fzuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] rust: types: rename ForLt to CovariantForLt
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260618230834.812007-2-dakr@kernel.org>
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-2-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 23:15:35 +0000
Message-Id: <20260618231535.D62C41F00A3A@smtp.kernel.org>
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
- [Low] A comment in the macro implementation still refers to the old macro=
 name `ForLt!`.
--

commit c45f7e371456a82ca15ef60543a42d6b7346219f
Author: Danilo Krummrich <dakr@kernel.org>

rust: types: rename ForLt to CovariantForLt

Rename ForLt to CovariantForLt to prepare for the introduction of a new
ForLt base trait that does not require covariance.

[ ... ]

> diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
> index 364d4113cd107..e1233701d6ccf 100644
> --- a/rust/macros/for_lt.rs
> +++ b/rust/macros/for_lt.rs
> @@ -176,7 +176,7 @@ fn prove(&mut self, ty: &'a Type) {
>      }
>  }
> =20
> -pub(crate) fn for_lt(input: HigherRankedType) -> TokenStream {
> +pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {

[Severity: Low]
Does the inline comment in Prover::prove() earlier in this file also need
to be updated?

It currently explains why certain reference lifetimes are deferred to the
compiler by citing the old macro name:

    // This is to block cases like ForLt!(for<'a> &'static &'a u32), as the
    // presence of the type implies 'a: 'static but this is unsound.

Could this comment be updated to refer to CovariantForLt! instead, to match
the macro rename introduced here?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618230834.8120=
07-1-dakr@kernel.org?part=3D1
