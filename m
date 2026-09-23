Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDF3C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 00:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F10810E6DF;
	Wed, 23 Sep 2026 00:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nanonej.com header.i=@nanonej.com header.b="dChKYEiW";
	dkim-atps=neutral
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C927710E6DF
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 00:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nanonej.com;
 s=protonmail3; t=1790124906; x=1790384106;
 bh=Vm2eCA7uL4H0o/dCrIqyrmx7kqfE3F6P5gZC455uyCs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dChKYEiWUVxPgiezCY+AR4Lil0xMk2oFQF5RUQnlda2bE+KJNzvpzTO4JBXMHOsiz
 oBAyDbGlo7PXMxvR18cjWzCxHr/gYx9y2JAAcJZPyYRXfg2orhUokN0RdkLR4nrfYz
 Yo/y4E+MfffSm5gPT+jvNXCg2iVWOfwujVZbaM43RkG/VPwn5gxfe4Vf35+YCv9I/t
 OR8uDdOqbjT3OrdjALT+2TtW3ibdbjE0gQsU/ZPtZqtVHvNahboPfS3qyMkIBI3eu3
 OVkWhEFTdWqWuEYyS5i4YejQeWZaO6F/G+CwlprCEzmBtHs0Cwmf4GLPuP7UY6phix
 DqQmFeSyUw1Uw==
Date: Wed, 23 Sep 2026 00:55:02 +0000
To: sashiko-reviews@lists.linux.dev
From: Nanonej Dev <dev@nanonej.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/4] gpu: nova-core: Extract PFSP register definitions
Message-ID: <m1qp--Csq6KPTgHYSUHPQt9tqXwClrSYXfEvfZDqI1X3pDOa1F2Zpv6yYI_9NjaybKIc8zoaveeEyXbeQ2QT0_i8ZKJzffL2zGKpSwJiG9w=@nanonej.com>
In-Reply-To: <20260923004532.76D871F000FF@smtp.kernel.org>
References: <20260923-b4-extract-pfsp-registers-to-falcon-mod-v2-0-74600fc068c4@nanonej.com>
 <20260923-b4-extract-pfsp-registers-to-falcon-mod-v2-1-74600fc068c4@nanonej.com>
 <20260923004532.76D871F000FF@smtp.kernel.org>
Feedback-ID: 32181229:user:proton
X-Pm-Message-ID: 143ae2ab622c902f6963cfb44426611d5c99b8cb
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------2e7d01e8bc1c8b1d40be69e0904b0412062871eaa2d75d61afbb54aa78dbbf5c";
 charset=utf-8
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------2e7d01e8bc1c8b1d40be69e0904b0412062871eaa2d75d61afbb54aa78dbbf5c
Content-Type: multipart/mixed;boundary=---------------------f743ee1c8d292c01b32dda55d3dbe567

-----------------------f743ee1c8d292c01b32dda55d3dbe567
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Wednesday, September 23rd, 2026 at 02:45, sashiko-bot@kernel.org <sashi=
ko-bot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential iss=
ue(s) to consider:
> - [Medium] nova-core: PFSP registers remain pub(crate) despite commit me=
ssage
> - [Low] nova-core: sentence fragment in commit message
> --
> =


> commit 4db1b123b08a2ccc218c14e49151c182aa9d6c36
> Author: Antonin Malzieu Ridolfi <dev@nanonej.com>
> =


> gpu: nova-core: Extract PFSP register definitions
> =


> This commit moves the Foundation Security Processor (PFSP) register
> definitions from the root regs module into the falcon module. It also
> re-exports PFALCON registers to allow using a single regs:: prefix.
> =


> > Since PFALCON registers are defined in the root regs.rs but are
> > also part of the falcon interface, accessed by the whole falcon
> > module. They are re-exported in falcon/regs.rs so falcon code can use
> > a single regs:: prefix.
> =


> [Severity: Low]
> This isn't a bug, but there is a sentence fragment in the commit message=
 here.
> The first sentence begins with the subordinating conjunction "Since" but
> terminates with a period before reaching a main clause. Should these two
> sentences be combined?
> =


> > diff --git a/drivers/gpu/nova-core/falcon/regs.rs b/drivers/gpu/nova-c=
ore/falcon/regs.rs
> > new file mode 100644
> > index 0000000000000..5ccb10946ec4d
> > --- /dev/null
> > +++ b/drivers/gpu/nova-core/falcon/regs.rs
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +use crate::driver::NovaRegisters;
> > +use kernel::io::register;
> > +
> > +// FSP (Foundation Security Processor) queue registers for Hopper/Bla=
ckwell Chain of Trust.
> > +// These registers manage falcon EMEM communication queues.
> > +
> > +register! {
> > +    base: NovaRegisters;
> > +
> > +    pub(crate) NV_PFSP_QUEUE_HEAD(u32)[8] @ 0x008f2c00 {
> =


> [Severity: Medium]
> The commit message states that visibility for these moved registers chan=
ges
> to pub(super), but the code retains pub(crate) visibility here and for t=
he
> other NV_PFSP_* registers below. Should this be updated to pub(super) as
> intended?
> =


> [ ... ]
> =


> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-b4-extr=
act-pfsp-registers-to-falcon-mod-v2-0-74600fc068c4@nanonej.com?part=3D1
> =



Made a small mistake during my rebase apparently, I'll fix that tommorow a=
nd also correct the commit punctuation issue.
-----------------------f743ee1c8d292c01b32dda55d3dbe567--

--------2e7d01e8bc1c8b1d40be69e0904b0412062871eaa2d75d61afbb54aa78dbbf5c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqzI0sJEFKmzSsu6sDwRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmc9yEM7ZU2n96y0Mc2cUqn/SctLWZNFV0Stsbqt
a7DTphYhBI+99gDJjAW7MoHJ0VKmzSsu6sDwAABI/QEAtxYjKBpZ7fj/D41K
HIRj4qH0jMCOrMKkrbmlsB2yJUgA/0e0EDNZYe9kL8IQNcJT4BJz6/y5Z+hS
mf0uqBYQ9YAC
=HJei
-----END PGP SIGNATURE-----


--------2e7d01e8bc1c8b1d40be69e0904b0412062871eaa2d75d61afbb54aa78dbbf5c--

