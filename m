Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979D4C79F91
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51DBE10E5EC;
	Sat,  5 Sep 2026 15:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XPOorHN2";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475C410E26A;
 Sat,  5 Sep 2026 09:31:50 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hcSlQ5BPYz8sfB;
 Sat, 05 Sep 2026 11:31:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788600706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgZynRmD9vHs8fVwu+0Q3CDriaBiUT7qGyVPwjPPEjQ=;
 b=XPOorHN2XqqDgVVKdA9iO8ExLdixgWeWmELPuWTKFu8uDs7B8aH8sADsc2xeullHDszWPB
 36vV03mphrZUTObIPvm4eWpaVsf6N7dIKx9crjcFZTFkbXxm1ePW01zsOLS6M8zNmoukqH
 TJmGBMEogljX33HIgNwmjJ43WeV06ZXZi6OIQXFGf29YMxICLqm9JWQpfsrLvvEyRLyrNB
 pTfr2Bzoqo2aHvnmeDqbWcejlt4R7vlSdz9XD6hYdU2C8dg2i4NZ6lUeek+tTWsov9qYvu
 U3P9QBqrPSS/VBa3PsmmQO5TzqM97caIefz6wgw2Lts8ytcl6yNcBXkV3WSNyQ==
Message-ID: <e8a53eb241b2cc912e9cfad5f6a0120aa9683481.camel@mailbox.org>
Subject: Re: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
From: Manuel Ebner <manuelebner@mailbox.org>
To: Thorsten Leemhuis <linux@leemhuis.info>, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Felix.Kuehling@amd.com
Cc: Mukul Joshi <mukul.joshi@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Mark Brown <broonie@kernel.org>, Miguel Ojeda	
 <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Date: Sat, 05 Sep 2026 11:31:41 +0200
In-Reply-To: <aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info>
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
 <20260831183311.1090131-2-alexander.deucher@amd.com>
 <aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 9d5iowodpfcuperubek5wusbfdpqohho
X-MBO-RS-ID: 780ec277d222eeaae0e
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

On Sat, 2026-09-05 at 07:36 +0200, Thorsten Leemhuis wrote:
> On 8/31/26 20:33, Alex Deucher wrote:
> > From: Mukul Joshi <mukul.joshi@amd.com>
> > ...
> ...
>=20
> > > error[E0063]: missing field `handle_free` in initializer of `drm_gem_=
object_funcs`
> > > =C2=A0=C2=A0 --> rust/kernel/drm/gem/mod.rs:265:58
> > > =C2=A0=C2=A0=C2=A0 |
> > > 265 |=C2=A0=C2=A0=C2=A0=C2=A0 const OBJECT_FUNCS: bindings::drm_gem_o=
bject_funcs =3D bindings::drm_gem_object_funcs {
> > > =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`
> > >=20
> > > error: aborting due to 1 previous error
> > >=20
> > > For more information about this error, try `rustc --explain E0063`.
> > > make[2]: *** [rust/Makefile:799: rust/kernel.o] Error 1
> > > make[1]: *** [/builddir/build/BUILD/kernel-7.3.0-build/kernel-next-20=
260904/linux-7.3.0-0.0.next.20260904.221.vanilla.fc43.aarch64/Makefile:1442=
: prepare] Error 2
> > > make: *** [Makefile:256: __sub-make] Error 2
> """
> Full log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/f=
edora-43-aarch64/10951622-next-next-all/builder-live.log.gz
>=20
> Reverting this change and 2/3 from this set fixed the problem for me.

Verified.

Thanks
 Manuel
>=20
> Ciao, Thorsten
> > ...
