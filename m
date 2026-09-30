Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36A9CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4852C10F334;
	Wed, 30 Sep 2026 11:47:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bNCiPl9e";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C940B10F333
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:47:34 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-328664c2da6so4465159eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790768854; cv=none;
 d=google.com; s=arc-20260327;
 b=lSXUv6E13HnIJHNI3/0rhw9MWZyszxmKp6a9yZuky7nCj3b4RFHprv4Nh2y19yzib1
 DGNtZZLmHtiU35o7CmJGnjhgO3bJccM+KA7vbocvHvrzldqaRqM+lUuey/r4nXez3KIc
 FQkgGA2P3pcfeZXb3s+4NkYPo9EhHrb7hTGVzL8lbDCXZVYxZRZB7+n9jVhOPCfNzlN/
 rwACL5TcppSZMkb8mkLxKDqOfXcB45NHlv/YYLSjc5EwQGbIqOv8m+JdpA5khUWpGT3X
 s5Q3Lfl+QcvsqKJewRl49ubbz9izHFSWZ/K4LrEL/A6/VKSIGwHqM6am1uQmlDwIUeI0
 sGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CU1MX58mqxg2gi+eZkq0TdZ36IM664l7Pic4XLSnu5s=;
 fh=RgiP2Txi/qnwvRPfSKpt4u1oJRNs67HGWu8gsaSwdJc=;
 b=BEnQRbyE04VSdxM9gmfxLYQRdGZYYES8JNDEMP8JnjpIDGmZRiDwfNOQPo/CHbo6Eq
 IwMNjbFpGeOUI7nV96oSxHrOh5+pfL7DWVI5l98EdOp7TFSVEyprZsJxzx3Eu0w26QmI
 WB5bcmFoDwEhux1AlemRDEBnLMKYRuGiM1qHW9GRWiMFrGMmMqsh4Rho71kOC3HD1Xi2
 xnF5sRrRsQBOPY2yl0HYOURrsSXMNrow5AVr4AaAnua51PRYlBLmhA8nwqXiKWkmkBSU
 o9qAPE/PVhSg/iXYX4SkAZXylBm6X73qeAyXPN1Prr136nW9WhSKuEhZterOpKKZKwVZ
 z3Rw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790768854; x=1791373654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CU1MX58mqxg2gi+eZkq0TdZ36IM664l7Pic4XLSnu5s=;
 b=bNCiPl9eg2S1XLCZLPZ2heEFR+cBzdBVzr4oSs3D3hEsU10SJdb16nQvkUS7y5byUd
 Q67JEMNIi3MEi3urZTVZt1n5ew5tVVKsSXOUuF3chYIAFdc04WaSK57HO5VkUlyuw0yT
 5ycZaex+fJM79vi26Kb1dkyx7KFkIfsStRB1rL9SrHZT3xYgbb/PKT6454Tyd0FppXc0
 mCp6H5w6Sxy87s1dvBw0wIY1z3Hv0FDL6XNfBLByaVR9YV4K59AfQ2lP/8DbVX77mJq4
 fhmcfQVvwL+ez6ezJNbkGKmZcjhraiGnEi4FxJlMhtJzGrxal/AMeEJcZLEUw8cf0IIQ
 pPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790768854; x=1791373654;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CU1MX58mqxg2gi+eZkq0TdZ36IM664l7Pic4XLSnu5s=;
 b=WN6nZtDPKnUZMRF320zmU/4H/DNJUaPgTT1P2InkhbJLg345OYPCN9K9ELbFYICW8z
 MRQHdRpKwGWdQjoSvL40+Gxw/aB5p8SxZy9DzJxtHp07U1QZoZEaYsX6SXL8oUj6PjPZ
 t7EGS2raSj3Wxy1WOvs9lFtRPadW9TeP/ftjaJc8YDR+rxeXMMNior3ajN6jJGuHkCFn
 8Nv+kCe5Yt0O4JuNjXvhtkaT8/u9j0bI0n0yorIElUw9wg3OoYiUovktTOjBtC+a9r5a
 /8eMmO/vLlMQyugaS4q7rNKdXGmP/0mt3R3Aj+x/LyqxGUPZrQ6zya4zrzKwc6hV7SSR
 myqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwieV02icgff3azZR1sO3raLXgmSMmjJ9Zup9LcsioEVZKJ+/G2I7hrmh3nwaHLIfCg4c3rlAO55Z0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kpksy0NCz0V6DO+x/4Z27wMVUVm2k/wd7jc92lwWwi6+rrhCnW
 96TzkdSiVGlxTsJ+R8TGvwdhRgtYx6rA14qOKEQUSb4uUsR2PNjnvCByweEBjMOc5vMKGlIn6+W
 EfD1uxQRl66hRuMwrZS1E3nj5xuCoVGk=
X-Gm-Gg: AYBFou3JYjVlWGggu48OmwcI4geVpnLqHn0FWrSpffri3aKMyCVeOQPB7gnPi8fRYvg
 Zi3taIUqBLfEcQIBDLbQ7orXgt0xsLc5wkxMQoyRXv/k+yiyCkbb2xPffBEF6eNgXRSq3V6K7YL
 X6+aDHYSqqvGVa4Nk8jh3N5yaHDFzQSU0oZvvTB/JnT9czxHvTG7utSeh8Zg68g6sxLW5Gd2bgG
 +sXBOlj6IGniRam9GpZCbz5t6+Al3tQqxtFfqjWjMIP3OK8euJCgn3UUw8FXdX53OvEAr0WuD/l
 KHpeQmPMJuIWdRWAKCvyyJTiuvaZ8gGy4QscJ/N0s0yhHvkfviKGFxDuIb7sZFjUI4cEwVooqsP
 6jpRkMXO95qu9KbEQWWiZYt8=
X-Received: by 2002:a05:7301:9e08:b0:34b:6d45:de57 with SMTP id
 5a478bee46e88-34cdb5f5697mr1375712eec.9.1790768853829; Wed, 30 Sep 2026
 04:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <arzMF0wjcF_SVxpE@orome>
 <CAPVz0n3Oc4ocUWrtGgd-MdrdJ3SgDEi8onOkXi92o7hAn3y0Ww@mail.gmail.com>
 <arzlR8mCg9d_z62L@orome>
 <CAPVz0n0jnitNemUyhi9C2SgbRbJA9CinY1DrR-r7gnN=CaYGiQ@mail.gmail.com>
 <arzpluDc-Ib7q-K7@orome>
 <CAPVz0n0sQo-6xKOGzd3LsJzzAr7_TficW4KeU320Z-tcRUne9w@mail.gmail.com>
 <arz1BYJT30VTosYj@orome>
In-Reply-To: <arz1BYJT30VTosYj@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 14:47:21 +0300
X-Gm-Features: AclHuK9Y2nKRAcoyGWBo0XedUHUJ0UGBHVCSLavApiAyymEH-DqiDv0t1HCafQI
Message-ID: <CAPVz0n18Y0oAREzJvm3utM3XohQXyoRWGBm=7uRvzVRTSK9CDw@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 14:41 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 02:10:15PM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:54 =
Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Sep 30, 2026 at 01:42:17PM +0300, Svyatoslav Ryhel wrote:
> > > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13=
:34 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Wed, Sep 30, 2026 at 12:00:21PM +0300, Svyatoslav Ryhel wrote:
> > > > > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=
=BE 11:47 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > > > > >
> > > > > > > On Wed, Sep 30, 2026 at 10:05:32AM +0300, Svyatoslav Ryhel wr=
ote:
> > > > > > > > Document 8-bit CPU parallel MIPI DBI Type B interface provi=
ded by
> > > > > > > > Tegra20/30 SoCs display controller.
> > > > > > > >
> > > > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > > ---
> > > > > > > >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++=
++++++++++++
> > > > > > > >  1 file changed, 138 insertions(+)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/displ=
ay/tegra/nvidia,tegra-8bit-cpu.yaml
> > > > > > > >
> > > > > > > > diff --git a/Documentation/devicetree/bindings/display/tegr=
a/nvidia,tegra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/te=
gra/nvidia,tegra-8bit-cpu.yaml
> > > > > > > > new file mode 100644
> > > > > > > > index 0000000000000..f0dab608b2936
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidi=
a,tegra-8bit-cpu.yaml
> > > > > > > > @@ -0,0 +1,138 @@
> > > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > > +%YAML 1.2
> > > > > > > > +---
> > > > > > > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,te=
gra-8bit-cpu.yaml#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > > +
> > > > > > > > +description: The display controller in Tegra20/30 SoCs fea=
tures an
> > > > > > > > +  8-bit SPI interface that closely resembles the MIPI DBI =
Type B
> > > > > > > > +  protocol and is referred to as '8-bit CPU'. Each display=
 controller
> > > > > > > > +  provides two such interfaces, which can be used to send =
MIPI DCS
> > > > > > > > +  commands to initialize and control the panel while image=
 data is
> > > > > > > > +  transmitted via 16/18/24-line RGB.
> > > > > > > > +
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    const: nvidia,tegra-8bit-cpu
> > > > > > >
> > > > > > > The description says that this is a feature of the display co=
ntroller,
> > > > > > > so adding a new binding and compatible string for this is not=
 the right
> > > > > > > move. This is all covered by the "nvidia,tegra{20,30}-dc" alr=
eady, just
> > > > > > > need to extend that with whatever is new.
> > > > > > >
> > > > > >
> > > > > > How would you model it? I have tried to model 8bit-cpu as a bri=
dge, similar
> > > > > > to how DSI bridges are modeled. This reflects interface used to=
 link RGB and
> > > > > > panel, without inflating existing DC binding. If you have any i=
deas in modelling
> > > > > > this, I am open to any suggestions.
> > > > >
> > > > > My suggestion is to integrate this into the existing "rgb" node, =
or, if
> > > >
> > > > Not an option since it is not clean RGB and there will be no way to
> > > > distinguish RGB from 8bit-CPU.
> > > >
> > > > > that becomes too convoluted, a separate "lcd" node (or "dbi", wha=
tever).
> > > >
> > > > This is fine by me but nesting nodes without compatible feels weird=
. Oh well.
> > > >
> > > > dc {
> > > >   compatible =3D "...";
> > > >   rgb {
> > > >     dbi {
> > > >       ...
> > > >     };
> > > >   };
> > > > };
> > >
> > > That's one option, but there's also many other ways you could
> > > differentiate between RGB and DBI. Could be a simple "nvidia,interfac=
e"
> > > property in the "rgb" node (that defaults to RGB if absent). It could
> > > also be a node that is a sibling to "rgb" (rather than a child). Or t=
he
> > > child could work, too.
> > >
> > > Ultimately we're still describing aspects of the display controller h=
ere
> > > since this is all registers within the display controller's MMIO regi=
on.
> > > Nested nodes are purely for adding some logical structure for the
> > > description that makes sense.
> > >
> >
> > From my understanding data is sent basically as RGB, at least RGB
> > configuration is still used in downstream. Panel commands are sent via
> > DBI
> >
> > dc {
> >    compatible =3D "...";
> >
> >    rgb {
> >     port...
> >    };
> >
> >    dbi {
> >       ...
> >    };
> > };
> >
> > This would work nicely if DBI is modeled using bridge framework. I
> > would strongly insist on keeping it as a stand-alone configuration
> > separated from RGB and DC.
>
> Okay, maybe give that a try then. But to clarify: this should all be
> part of the Tegra DC driver and not need an extra compatible string or
> separate driver. The DC itself should be able to function as a bridge.

Noted, I will not add compatible string to the dbi node.

>
> Thierry
