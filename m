Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB5ACD98D8
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BDA10EE6A;
	Thu, 11 Jun 2026 10:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nanonej.com header.i=@nanonej.com header.b="Elvr4coA";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1CCD10E9FD
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nanonej.com;
 s=protonmail2; t=1781103434; x=1781362634;
 bh=CYM/9yIKBVNxTxn6rupbHx/wVh5qkEewMV2Q/xxSdaM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Elvr4coA8Tn9Fe36RR2j+/h9X/Tht9xtuqRCIl1fL+N87VhYNrMkaXZbzLgGgxxMz
 naI6gY1nW2fghufHczxsVay3kEsb6P86lH88onaSR8vW8LjhepVTgEdOYZxRkDWdO5
 /h8QVAk0M13+13rPNGMDItPB6mGLmBUx9YIKc7tqKLEDd5aVTd+Pgyqx2nPvxKEfXo
 iBdYY8ERRk9IoU4+0t9tFZYlQ7zQbHc99wQaE8W1QqUKFzT5CA9qnU8atBN+IWIz/j
 p6ZjPGgjbKYBwAchjOdypU66kEEPWGlZ+xZyV1sXLa8i7vv85+iHCffw+b2HVce4gL
 0qFldWIYo9zOA==
Date: Wed, 10 Jun 2026 14:57:09 +0000
To: Alexandre Courbot <acourbot@nvidia.com>
From: Nanonej Dev <dev@nanonej.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: Move gsp register definition into
 gsp module
Message-ID: <9B2MG9ICH2MOGGwTsi0aCGBlEyEO3p-VTk7iR0wgDgBkAYKEu9GC2mc7eAODT5nilASpnSaPdZZjliM9HcvEY96LscSKHF2iDXDXCESptAA=@nanonej.com>
In-Reply-To: <DJ5EN9YOZOVF.RZ2WJGSB0L6G@nvidia.com>
References: <20260607140949.152575-1-dev@nanonej.com>
 <DJ5EN9YOZOVF.RZ2WJGSB0L6G@nvidia.com>
Feedback-ID: 32181229:user:proton
X-Pm-Message-ID: 296c75c6f05a1c5bad7c9d09aba6658f8816d35a
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------bfca68cb955be91c902c6aca2f3f65aefd2883d5667ad55d53ba90b10f70acae";
 charset=utf-8
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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
--------bfca68cb955be91c902c6aca2f3f65aefd2883d5667ad55d53ba90b10f70acae
Content-Type: multipart/mixed;boundary=---------------------91294a86a2c4c6a7bf592b5b9524db95

-----------------------91294a86a2c4c6a7bf592b5b9524db95
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Oh! Didn't think to add this extra tag since your review, sorry! =


Can we add it now? Should I do a V3 to add it? Or not that much of a big d=
eal this time, but should think about it for the next time? =


Anyway let me know and thanks for the feedback!

Also, I check for Proton Mail, as I understand they don't support `format=3D=
flowed` so except using there "uservoice" service to ask them to impleme=
nt  it, I had probably nothing else to do. But I found a git-protonmail se=
rvice dedicated to use proton mail with git send-email, so maybe it will w=
ork? I have to try as I don't know the email protocol well enough to under=
stand on which layer the patch get mangled and if this tool can proxy arou=
nd the Proton implementation.

Antonin.

-------- Original Message --------
On Wednesday, 06/10/26 at 15:31 Alexandre Courbot <acourbot@nvidia.com> wr=
ote:
On Sun Jun 7, 2026 at 11:10 PM JST, Antonin Malzieu Ridolfi wrote:
> Split the gsp register definitions grouped in nova root
> register file to the gsp module which actually use them.
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

-----------------------91294a86a2c4c6a7bf592b5b9524db95--

--------bfca68cb955be91c902c6aca2f3f65aefd2883d5667ad55d53ba90b10f70acae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmopeywJEFKmzSsu6sDwRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdoGz9SJO9jIAAk5e3fijLm5NChLQbGiwDFSblI
+TN25xYhBI+99gDJjAW7MoHJ0VKmzSsu6sDwAAC4uwD9Hj5+Ay5n6IMEGbCj
4gYCW/0xe4gw6tnrFNsXjAx95PwBAKsw/9hyVzo5Ahlm3p0Y5THU0tU6dggD
tNHLJMpYYMYJ
=i/eO
-----END PGP SIGNATURE-----


--------bfca68cb955be91c902c6aca2f3f65aefd2883d5667ad55d53ba90b10f70acae--

