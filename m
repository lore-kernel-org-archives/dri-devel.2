Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E80606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCqm30mp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80EA10F1E6;
	Mon, 23 Nov 2026 20:52:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2554C10ECC5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:52:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2439459AD
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB861F000E6
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795467131;
 bh=R+PB97YJaXYfuT9JzZ2XMPTT0GrXfB9fgjWWji/d7NI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=fCqm30mp1MS8epLG7pZm9k9TPUM7K9ux1pcgdRFHyiKnAcPeuudwlPS61VSVhGb+a
 /6j5IbZx3PiXs9wpFVl8PI9nc3xfXQZ+c9Qki8bngfnFIidrLHBj4uC5TaRVWMUf+t
 +pdxZz/9FXHqWYB9sZFQLBp9/2vwXDKQZj6WK2b69/81UBI2k1Cb3XflxBzFTmT+qh
 a3/73TqmSqLV6pEMwNOUTICdF6uCOclNPNbmu+G4qw44o+hIBVt/Nc66ENgUsmZTq/
 RqMDb2GXjesBR4INW2DX/xD0AR3w0bAXnh8QnAE1nmwNciGR8liW3PMxKNJwfm7C8b
 4rrSNVeQqjzTg==
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c515369b627so350592966b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:52:11 -0800 (PST)
X-Gm-Message-State: APuU4Z/dGV7xlVhSAkQhQNuMxDdt1976oYJmJnHZdY4j2d/TPr9bh89T
 BswgqAcA9eVt6Hs0KbBSLyn78MED1+tZB7kQWYg4WBRsMu9bgMo46f9our/0fXjl4s6/X+pB+qS
 6tZIPfB8QzPwldw8eiDAJ98U7qxExjQ==
X-Received: by 2002:a05:6402:90d:b0:6ba:6654:6a6f with SMTP id
 4fb4d7f45d1cf-6ba66546ba7mr4869059a12.10.1795467129997; Mon, 23 Nov 2026
 12:52:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122093426.72677-1-gerard@teslabs.com>
 <179546531526.1777962.3727881292046293374.robh@kernel.org>
In-Reply-To: <179546531526.1777962.3727881292046293374.robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 23 Nov 2026 14:51:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJc6=3oUHWTP8owtKYfhv0aqQSr0X-NEoH294YYfKc1=A@mail.gmail.com>
X-Gm-Features: Aa3M54odu4jh8uvs4WSzy8v4k6cg8FCebB3cex27gj5FuZInNEVhAbnxHBbNCBE
Message-ID: <CAL_JsqJc6=3oUHWTP8owtKYfhv0aqQSr0X-NEoH294YYfKc1=A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: sharp,ls010b7dh04: Add LS013B7DH01
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 devicetree@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 2:22=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Sun, 22 Nov 2026 10:34:26 +0100, Gerard Marull-Paretas wrote:
> > The LS013B7DH01 is the 144x168 Sharp Memory LCD of which the LS013B7DH0=
5
> > is a thinner revision. It is obsolete, but still used in products.
> >
> > Both are electrically the same, taking the same SPI commands and VCOM
> > signal at the same resolution, so the LS013B7DH05 compatible can serve
> > as a fallback and the sharp-memory driver drives it unchanged.
> >
> > Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
> > ---
> >
> > Notes:
> >     Checked with dtschema 2026.9: the steps of dt_binding_check run by =
hand (host make too old), yamllint and dt-check-style --mode=3Dstrict.
> >
> >  .../bindings/display/sharp,ls010b7dh04.yaml   | 26 +++++++++++--------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> >
>
> Applied, thanks!

Or not. dim tool won't let me. Needs an ack from Sharp or DRM maintainers.

Rob
