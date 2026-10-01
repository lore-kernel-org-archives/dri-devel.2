Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48A4CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5176D10E1E1;
	Thu,  1 Oct 2026 07:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XJ2wVMP6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325FF10E1E1
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:22:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41BF66022B;
 Thu,  1 Oct 2026 07:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1281F000FF;
 Thu,  1 Oct 2026 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790839372;
 bh=vYPo30L+yzg4zdvP/9QG8tpdh1hu1GaLdI0m5fTJPic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XJ2wVMP6oeCv2GMjeOm0YD3l3EXN0xvYQRaArKhqbXcJi/lNWtYs7qDSfg4TNpFHp
 tcHiVxH+QjxL8CjN1f+z89ZIvf1Hou6pJ+j3Gi4E0x7pkQH9tWnm9d/UEcIoEotgFM
 jEramHJxTxiy5ABlYpKM8jY/3lCZctNaM4HAj0ioXvpnzhunNw8rs1zD+Y1lvpO0ah
 zySagzh5ov5stXJ4/RdnmgKqzpmBViqdr2Aw/xyL+lqBNt0GxrcBa8WKGCkeNfiEa0
 KgL8Iw7YwmuN/1nwxruU2fGL9KgLKqXzIBVRIXaif+Z96HE8O2YrtJvwiBfYJm0ITH
 1rxAUcnnoRAVQ==
Date: Thu, 1 Oct 2026 09:22:48 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
Message-ID: <ar4HOuO-vox9VIKZ@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
 <20260928204059.GA515872-robh@kernel.org> <artyl8fD3zzng8Uh@houat>
 <20260929222822.GA2933878-robh@kernel.org> <ary8IdL9zVXfS2fA@houat>
 <CAL_JsqJCoWQmdBKEbekXb5LeLn1KcMiP2iG30r+npssJSZB5LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="eh5wavyv7nnca5rg"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJCoWQmdBKEbekXb5LeLn1KcMiP2iG30r+npssJSZB5LA@mail.gmail.com>
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


--eh5wavyv7nnca5rg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 02:07:39PM -0500, Rob Herring wrote:
> On Wed, Sep 30, 2026 at 3:04=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> >
> > On Tue, Sep 29, 2026 at 05:28:22PM -0500, Rob Herring wrote:
> > > On Tue, Sep 29, 2026 at 10:39:24AM +0200, Maxime Ripard wrote:
> > > > On Mon, Sep 28, 2026 at 03:40:59PM -0500, Rob Herring wrote:
> > > > > On Mon, Sep 28, 2026 at 06:22:01PM +0200, Maxime Ripard wrote:
> > > > > > Most MIPI-DSI panel drivers follow an identical pattern: acquire
> > > > > > regulators and GPIOs, perform a reset pulse with specific timin=
g,
> > > > > > send a vendor-supplied sequence of DSI commands, then enable the
> > > > > > display. The only truly panel-specific part is the init sequence
> > > > > > and power-on/off timing.
>=20
> [snip a bunch of irrelevant shit]
>=20
> > > > So, let's phrase this differently: what's different about the
> > > > description than panel-mipi-dsi-spi, or any other binding already in
> > > > tree?
> > >
> > > There's all of 3 panels supported. Compared to all the other panels we
> > > have, hardly the rule over the exception. You can always fine "bad"
> > > examples or exceptions.
> > >
> > > That one defines a single supply. Any other MIPI SPI panel with
> > > different supplies or GPIO controls probably has its own binding. Try=
ing
> > > to parameterize that in DT doesn't work. We've rejected trying to do
> > > that in DT over and over. What's your story here for that?
> >
> > Sigh... Look, I really don't care about an argument DT maintainers use
> > at their discretion for this. We both know full well that it's been and
> > still is inconsistenly applied, and you also know that it's not like
> > I've been playing the DT game since pretty much the beginning (on ARM
> > anyway). So it's not like I don't want to make it work, I do. But what I
> > care about is enabling that driver to work.
> >
> > I reused exactly the same binding than the last major binding that was
> > merged for panels, and support about the same number of panels. I guess
> > that was a mistake, so sorry for that.
> >
> > I'm fine with reworking the binding any way you want as long as it still
> > allows for the same use-case, but I would have hoped for a better
> > feedback on how to do so than "oh what a huge pile of shit this is".
>=20
> When you can answer my question above rather than make up shit I
> didn't say, maybe I'll reply again on this thread. Otherwise I'm done
> here. I don't need this abuse for the thankless job of DT
> maintainership.

It's been the whole tone of the reviews, so I'm sorry if you were caught
in the crossfire and you didn't mean that. And I'm sorry it made your DT
maintainership work harder than it already is.

I do mean what I said before though. I have no problem changing the
binding the way you want, but I need to know what to change in the first
place, otherwise it's really no better than a NAK, or we're bound to
have the same exchange for the v2, and I'd rather not.

I indeed missed your question, but now I'm not sure I understand what
you mean by "paremeterize that in DT"? The supplies in the binding are
an aggregate of all the possible supplies a panel can take. They are not
a wildcard, but they all have their own semantics that are used by
panels right now.

I don't expect any new supply to be introduced, unless there's a major
panel technology change such as the one we had with the introduction of
OLED.

Would you prefer to reduce the number of supplies to the minimum we need
right now, and extend it as needed?

Maxime

--eh5wavyv7nnca5rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar4KSAAKCRAnX84Zoj2+
drKVAYDR/ZDwDXBZxoJ1vN0aVjc4QVJvpsXjDFhzm6g8ERdGmINbKbE3z4HYkf8L
rASKMl0BfRPGtCXfDtr+Ev35B1QViTxFnNv9Js2+WdypHe0kKGcY7E/8p6hiGNzS
J8y0tgD50Q==
=lNbO
-----END PGP SIGNATURE-----

--eh5wavyv7nnca5rg--
