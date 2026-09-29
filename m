Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9795ECA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00A510EF1E;
	Tue, 29 Sep 2026 14:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EoU4g9r+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44BAD10EF1F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:07:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED65543FEB;
 Tue, 29 Sep 2026 14:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812561F000FF;
 Tue, 29 Sep 2026 14:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790690822;
 bh=lkgaCVaf/aBgHrgjUiGDobf6xgdI2mcLFs3gHnGK0HI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EoU4g9r+RXTIfIkAmSvkC4Ne5q77l/L0V56cJpqkcRTuDZ1e+4f1L2aCWRzyyGxe4
 bhRFjvrG7k/dCU7wXzvJmgFra3sftDSK570qEcDWCCXZbc0+EKFFyo03gciOGb6/94
 oC8PD/mj/lrsHRMKjQZG255iESw0iXPLzCQECtGewSoEqBimg1NZx8jBdaDLwf4V5x
 mzHh3JTTQeRShPNbOrvgFn/j2XfZwNQEHr3/tpQ/TsXdeAUbJbSbFc18z0MKG33O7p
 LSC/BraTnie1wHTRPeyXiVkamJbBQGM+HnubJXD8AME++LCkDAtHsL0kvUueZgueXl
 2B3UAfBGPVa0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] rust: macros: test exhaustive conversion derives
To: "Kaiqi Guo" <chaoji_xinren@163.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, gary@garyguo.net,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260929135855.36775-9-chaoji_xinren@163.com>
References: <20260929135855.36775-1-chaoji_xinren@163.com>
 <20260929135855.36775-9-chaoji_xinren@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 14:07:02 +0000
Message-Id: <20260929140702.812561F000FF@smtp.kernel.org>
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
- [Low] rust: macros: non-vertical import formatting in doc tests
--

commit b361cafb4eb66d1f226f7d0ead63f4a791967d6c
Author: Kaiqi Guo <chaoji_xinren@163.com>

rust: macros: test exhaustive conversion derives

This commit adds extensive tests for From, Into, and TryFrom exhaustive
conversion derives. It covers bounded ranges, boolean, full-width primitive=
s,
and verifies various compile-time error cases for incomplete domains and
invalid layouts.

> diff --git a/rust/macros/convert.rs b/rust/macros/convert.rs
> index 7fa8a22dc9133..c23b8819572e3 100644
> --- a/rust/macros/convert.rs
> +++ b/rust/macros/convert.rs
> @@ -1671,3 +1671,375 @@ mod overflow_assert_works_on_unsigned_int {}
>      /// ```
>      mod any_try_from_target_overflow_is_rejected {}
>  }
> +
> +mod derive_from_tests {
> +    /// ```
> +    /// use kernel::{macros::{From, Into}, num::Bounded};

[Severity: Low]
Does this import (and others in the added doc tests) violate the kernel's
vertical import style guidelines? The Rust subsystem guidelines require
vertical trailing-comma syntax for imports, but this uses horizontal groupi=
ng.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929135855.3677=
5-1-chaoji_xinren@163.com?part=3D8
