Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D86C624D6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B94D10E0BD;
	Tue,  1 Sep 2026 17:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jXz0jgta";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E43210E0BD
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:01:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4989A437CB;
 Tue,  1 Sep 2026 17:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0341F000E9;
 Tue,  1 Sep 2026 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788282085;
 bh=B406paQnLSN/UkJ82hmyzBgrzyxY/MPOyV1D/v02jt0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jXz0jgtaWnhthPg2cvOdZOkMcA/3k7DBkqpKlPLnxYzUd/+LzpxidGo8JyMwN2xFI
 Dz7VwbbjBpLjOhj1QdrXsXFkv9wR2K5gB1BgJQSdaS06xKU6uP2JPSnxa9dEiszmTa
 gDCap73Kf0EUQfpOqwRPxa72UKuBnUB6DKbd9ILpPChoKUhFsJkLI4xatVwlE7mvI6
 U+I1zRuno+6m+XC6lcAoier2nnCkOyQdOQj3SJXBzna6lSDArdeGOJK3jwOyBhG4Ez
 WCEb9KmndECFqM0axKUKfYBDa6kfq/0goeefKLLVAgxQWuOlEiAhjk3SgI3/dbDWA2
 bap9WaeOC/FgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901-typed_register-v4-13-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-13-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:01:24 +0000
Message-Id: <20260901170124.CD0341F000E9@smtp.kernel.org>
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
- [Low] Nested imports are not formatted using the kernel vertical import s=
tyle.
--

commit 5f257dd4b3d5392812ee98a7773fef681ee000af
Author: Gary Guo <gary@garyguo.net>

gpu: nova-core: convert hshub0 from relative register to projection

This commit converts the hshub0 relative access to use a projection and a
new base register. This brings it in line with the earlier PFALCON and
PFALCON2 conversions.

[ ... ]

> diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/=
regs.rs
> index c27582e376e29..abb48b0955a9e 100644
> --- a/drivers/gpu/nova-core/fb/regs.rs
> +++ b/drivers/gpu/nova-core/fb/regs.rs
> @@ -2,7 +2,8 @@
> =20
>  use kernel::{
>      io::register,
> -    sizes::SizeConstants, //
> +    prelude::*,
> +    sizes::{SizeConstants, SZ_4K}, //

[Severity: Low]
This isn't a bug, but should these nested imports be formatted using the
kernel vertical import style?=20

The Rust coding guidelines generally require breaking nested imports
vertically into multiple lines rather than keeping them grouped on a single
line like sizes::{SizeConstants, SZ_4K} in the imports block of regs.rs.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D13
