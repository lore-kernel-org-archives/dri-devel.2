Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09221606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB25610EC60;
	Mon, 16 Nov 2026 08:58:47 +0000 (UTC)
Received: from sraa.de (sraa.de [85.214.240.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB9B10E043
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 19:00:48 +0000 (UTC)
Received: from [161.142.148.162] (helo=ryzen)
 by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <basti@sraa.de>)
 id 1xSfSt-00Fxrp-Mz; Sun, 15 Nov 2026 20:00:36 +0100
Date: Mon, 16 Nov 2026 03:00:28 +0800
From: Sebastian Raase <basti@sraa.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sebastian Raase <linux@sraa.de>, Hans de Goede <hansg@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH 2/2] dt-bindings: display: simple-framebuffer: Document
 mono format
Message-ID: <20261116030028.32753ba3@ryzen>
In-Reply-To: <8a697d14-18c3-454c-979b-7042f16c66ba@suse.de>
References: <cover.1793758480.git.linux@sraa.de>
 <258a1228601ab9b5dbb8f077dacf61121b641f15.1793758480.git.linux@sraa.de>
 <8a697d14-18c3-454c-979b-7042f16c66ba@suse.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 12 Nov 2026 08:35:59 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi
>=20
> Am 04.11.26 um 03:34 schrieb Sebastian Raase:
> > This is a 1 bit-per-pixel monochrome format, with 8 pixels/byte.
> >
> > Signed-off-by: Sebastian Raase <linux@sraa.de>
> > ---
> >   .../devicetree/bindings/display/simple-framebuffer.yaml         |
> > 2 ++ 1 file changed, 2 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> > b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> > index 45ffdebc9d86..c627ec088434 100644 ---
> > a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> > +++
> > b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> > @@ -94,6 +94,7 @@ properties: format: description: > Format of the
> > framebuffer:
> > +        * `mono` - 1-bit packed pixels, 8 pixels/byte =20
>=20
> I don't object the change, but I really object the naming.

I fully agree, but could not think of a better name at the time.

As Sashiko pointed out, "mono" neither describes the endianness nor the
polarity.

> Mono is not a good name because it doesn't describe the format's
> pixel layout. For example, RGB with only 2 colors is also mono in
> some sense.

A two-color RGB format sounds like a contradiction, although bi-color
LEDs are very common.

> The common names used in the Linux kernel for this type of color
> format are C1 and R1. More generally speaking,
>=20
>  =C2=A0- Cn describes an n-bit format with a palette. The pixel bits inde=
x=20
> into the palette.=C2=A0 Pixels are packed.
>  =C2=A0- Rn describes an n-bit format with a single color channel. The=20
> channel has linear color gradient. Pixels are packed.
>=20
> In your case, you'd define 'r1'. While at it, we can also define r2,
> r4, and r8.=C2=A0 The terminal supports up to 16 colors, so implementing
> r4 might be of interest to some simple hardware.

Sounds like a good idea; I can test those for simplefb (not simpledrm).
Do you have a suggestion on endianness and polarity in the name?

Today, we have grayscale/color in mind, so the obvious polarity is
0=3Ddark and 1=3Dbright. But the other approach uses 0=3Dpaper (white) and
1=3Dink (black), which leads to reverse video hardware. It's uncommon, so
we can probably ignore this.

Endianness is basically the same difference as RGBA vs. ABGR in 32-bit
color formats.

So far, I have only tried stride values which were multiples of 8, to
align them with byte boundaries. Any restriction would apply to r1, r2
and r4 formats.

If I send a v2 patch, should that be a follow-up of this email thread,
or a completely new thread?

> Best regards
> Thomas
>=20
>=20
> >           * `a1r5g5b5` - 16-bit pixels, d[15]=3Da, d[14:10]=3Dr,
> > d[9:5]=3Dg, d[4:0]=3Db
> >           * `a2r10g10b10` - 32-bit pixels, d[31:30]=3Da, d[29:20]=3Dr,
> > d[19:10]=3Dg, d[9:0]=3Db
> >           * `a8b8g8r8` - 32-bit pixels, d[31:24]=3Da, d[23:16]=3Db,
> > d[15:8]=3Dg, d[7:0]=3Dr @@ -106,6 +107,7 @@ properties:
> >           * `x8r8g8b8` - 32-bit pixels, d[23:16]=3Dr, d[15:8]=3Dg,
> > d[7:0]=3Db
> >           * `x8b8g8r8` - 32-bit pixels, d[23:16]=3Db, d[15:8]=3Dg,
> > d[7:0]=3Dr enum:
> > +      - mono
> >         - a1r5g5b5
> >         - a2r10g10b10
> >         - a8b8g8r8 =20

Best Regards,
Sebastian
