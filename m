Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C532BC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF8010EE98;
	Wed,  9 Sep 2026 04:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nm1GfNTL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B9A410EE98
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:14:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EF99601FB;
 Wed,  9 Sep 2026 04:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7E51F00A3A;
 Wed,  9 Sep 2026 04:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788927284;
 bh=KvWHQ57lFszbkAQAhWElYlrGrskSJYUsFIuHFBNZ2E8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nm1GfNTLQJWclPEZdsWmMgDOlPTTTLVV6t1kbD/VnCwGxyT1CfxaLO7cB9A9AGgkN
 UBt14fPBqPJ2xKXrX4Y0LPsq0Q8qtnAVdQ7UTFCQOguRJzm5TC4F2NrkzyexRdk3Ek
 usM+xTR0mv9vTsPK3bNKlgmlSTcpUMmSBetpJrC64N2viCd2codNA+OvfSASpddb0z
 YQ1/gQLhZ4nMqDP2doh2rBXjpa8m6uhIQzziNKlzWU9hRXhOKmd+dQnCq9wg2dztmi
 Ve+5hmbw1lLFKIXrye3EpcRF36yHIfyuwb1YHY6L2pKbQjzA9wew5M7r1EYhW3rilb
 96GcAv1yRCdsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/16] gpu: nova-core: Add BAR1 aperture type and size
 constant
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-mmrebase-v1-14-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-14-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:14:43 +0000
Message-Id: <20260909041443.CD7E51F00A3A@smtp.kernel.org>
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
- [Medium] Mismatch between commit message and code: missing BAR1_SIZE cons=
tant.
--

commit db55f37382f142c32f879637ebd2448ef45bd83e
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: Add BAR1 aperture type and size constant

This commit adds the Bar1 type alias and related GSP structures for BAR1
memory access functionality. It also adds parsing for the BAR1 PDE base
address.

>     gpu: nova-core: Add BAR1 aperture type and size constant
>    =20
>     Add BAR1_SIZE constant and Bar1 type alias for the 256MB BAR1 apertur=
e.

[Severity: Medium]
Is the BAR1_SIZE constant missing from this patch?

The commit message explicitly states that a BAR1_SIZE constant is added,
but it appears to be entirely missing from the changes.

Note that this omission does not cause runtime bounds checks to fail, as
pci::Bar gracefully falls back to dynamic runtime bounds checks against the
actual PCI resource length. However, there is a mismatch between the intend=
ed
change described in the commit message and the actual code.

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 8cef4c284277f..5723ff8f71ea4 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -38,6 +38,8 @@ pub(crate) struct NovaCore<'bound> {
> =20
>  pub(crate) type Bar0<'a> =3D &'a pci::Bar<'a, BAR0_SIZE>;
>  pub(crate) type NovaRegisters =3D kernel::io::Region<BAR0_SIZE>;
> +#[expect(dead_code)]
> +pub(crate) type Bar1<'a> =3D pci::Bar<'a>;

[Severity: Medium]
This is where the Bar1 type alias is defined. Should this include the
promised BAR1_SIZE constant as a generic parameter, similar to Bar0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D14
