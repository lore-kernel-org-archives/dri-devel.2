Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F674CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB1010F344;
	Wed, 30 Sep 2026 11:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OSdLhyx9";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B760910F344
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:56:38 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-328664c2da6so4471594eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790769398; cv=none;
 d=google.com; s=arc-20260327;
 b=G+lowVCAyCLrWVi0qjgYVBskHLAZ+Cl7WwBaIdAuCVfGFIJCsVTORr5e78oDZPiCCT
 cskNLm47dsNElzhFvFhhQfSevpIkBFpr7qMvANKbHpmMU1fUKESzvnmMF41AvvGEc3Hy
 /alICmpyKs8vqoO5CO9OycEUujY7MecMhUfiauOqRBvEhxSrIONKLsG2ji96Oxp4kOaO
 W/bM0OSY3PiDBzXxjDEqwZ7Umfb0ISz45iAt3rO9RT2pVOQ207JYSYnFk3icKB4t0Jl+
 uR/nyIXLYDJWu6OO6SlQwIqbrpKN6qDDP2gEEnHFANY7KbFDbRLVjWfor7/Yut0d8RRz
 NKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yOi1xGJqgS9LzwvMIA8Rqod0f0w6LITZ2YMI6SsIEdk=;
 fh=ysxFXG500HlWqbZZIrHFzePwiZlXhOklQrvhgYaAmLE=;
 b=T/WyvFF/XXV/qC2fUsPsHD9KpUqwJyLjfwOwI9c1YisuQQDDVD6zet/0op1nG+9OIN
 9WdekQ7KnUHoiMlyjfWUvjYfR801S2v0cbyLpMWUaaXH6pIed2xYMuPqOH35cbkwHvs7
 mYlafv2PfV97MYg0pNoL+b0t4y3CKA97811UPbyqLnpaqpKm/HeGQ8+g8py6FnmfaSm2
 Aa4UDSbEwXzlBwbP0s5ilE6V859S/20TiWX8hVLvrS1HjY44xD37Kuvyk1weAltUqbbG
 5spcNo8eRIZYWmfZTDI3hAgXjEXepH+7hgTTGV05qnSx0gq8QeHxFWHQtC8VtinF4fVq
 8Ziw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790769398; x=1791374198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yOi1xGJqgS9LzwvMIA8Rqod0f0w6LITZ2YMI6SsIEdk=;
 b=OSdLhyx9yagGjdkbL5n1a+1Srf4s3d+0McWtkhh2VXfsM/8GkxF4rWJLUEOylUg8Tw
 Mu1zSP5a/i8oEYZG7UtxDYQaZb3TmnuUd3/+kDbsG7EtIiFiDMcDO+qcATvqDB8842jj
 bS7JgS8b+07aiZpxo4sk8S0Zrk/CP8RfRF8PAAzXKTACGuiJQGd37qFyIXF51HPNG3oO
 HBxS/VPpMvFxKi4tv3+NY8fvPHch1jUP0mdiOGzDUz/AlWU98qPNQ1M5Fb513Qdo/Fzs
 2cY9FXHBDIrvWMZvwfLJ+OL33hloZd4UD8K9pcGNCJTTaoftUoQ/1uvxLsnFH41Rd9K1
 982w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790769398; x=1791374198;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yOi1xGJqgS9LzwvMIA8Rqod0f0w6LITZ2YMI6SsIEdk=;
 b=Zr2M5IZjKiXsQoRGZRGh1zXhWiX4j1c0jkFIAwrhsxG72pdZKnc4VqyCBu1laSxSQ8
 LtPtGoRLSt+GG2UebtsXtECbhy7Oy+UK2vXeKpF1xSjVVM361FXj2iw8frK93qdyEWxR
 wTYEv1dauWqyr7QG6+MCWcqgmkKASvjDJJlT2lyXkZ2uoJoREMKP0pMKdPYlv6VirBeO
 7xWCKZEWYlvzdaHQneysFa9g/djbegyWgPocWmeOuOfv+vxCbvfzbWFswcDQYN20TMLr
 ha6kahMT1zimC2z0M+WP00o98wSyH0InJhuphHXPiRf9FI+kDJz1dl3RTTtOiul/AuTk
 9LVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLc9bTzF30Z8KKzOQfMqL6O97LlvZOArIF7OLo0o1wXIy/qPMLEi4mIIJwu05ApzkftgKKclIgDWA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPLGzGAGub+1mnqas8vr3Tm/JQxw8R+3KWw3BIK6b4SPy1PhHK
 RmN2cvwJxdDWozbkUudxwBnJ15cO0kmypDj9+gqLT5BJfbTa90N8BQELZv/EB3yHupGDeOYCHTS
 FONNppaNupdOADdUZFYlKcBlU0aToGBc=
X-Gm-Gg: AYBFou2+LzIbHCn1M5sD5/MGkQIUEDxgV16LXpxXSSvS2Z1+wOZhVjwLuyl/GDtKvRV
 yHGZuFeuNb3cDBCdWunfOIEYoMGSNWJ4IjFrGF2XISrLI/2jiIMDgqEOhIVts2ucricqLe2vgiB
 it3tuBSQ2Rh8LIAHjdm31sOnHvgB9tf8gt8JF4mY84ogN9s5XvKUUhf3RiF92RbAOEI3LOz9p9x
 0C0kYLi76t7zd80sOO0gbSj9D4ji6WRs7Cwz+Mxjum7odKsvN+UgXLhTYPMDRATZy0Fc9NdnAw5
 AE8woF5ySCdxTx2+qcnXyPJNl97KgeJU8JWqSVvujfC1mTlUGiG1zXyz8pygrYqhmcft0Hk8MJy
 JJDiT/nzbEQyb
X-Received: by 2002:a05:701b:2611:b0:144:d792:8be5 with SMTP id
 a92af1059eb24-14d33680cc3mr1029225c88.42.1790769397896; Wed, 30 Sep 2026
 04:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
 <CAPVz0n2F8LBqFs2bJERmgvdNYgtt1OEVtK3++CP9y0gxW7gCGA@mail.gmail.com>
 <arzn-TNbOlqXqQgd@orome>
 <CAPVz0n33c_uwfhsSguEfFfJ3FV=26SPtNTEpHes9f5RjnPDA_w@mail.gmail.com>
 <arz1wzEI_7e7ruKi@orome>
In-Reply-To: <arz1wzEI_7e7ruKi@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 14:56:26 +0300
X-Gm-Features: AclHuK-jagRAWDSvA026O_Jnox8tuvSOQdVM_QI0nIj8TPkLU1ik19zpdv3Pldc
Message-ID: <CAPVz0n12oiuc=5wjeNCuNtJpe-M7Ys=rHn0TOExc0qkweVQnuA@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 14:46 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 01:56:40PM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:50 =
Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Sep 30, 2026 at 12:52:18PM +0300, Svyatoslav Ryhel wrote:
> > > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12=
:19 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Wednesday, September 30, 2026 4:05=E2=80=AFPM Svyatoslav Ryhel=
 wrote:
> > > > > > Document 8-bit CPU parallel MIPI DBI Type B interface provided =
by
> > > > > > Tegra20/30 SoCs display controller.
> > > > > >
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > ---
> > > > > >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++=
++++++++
> > > > > >  1 file changed, 138 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/display/t=
egra/nvidia,tegra-8bit-cpu.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/display/tegra/nv=
idia,tegra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/=
nvidia,tegra-8bit-cpu.yaml
> > > > > > new file mode 100644
> > > > > > index 0000000000000..f0dab608b2936
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,te=
gra-8bit-cpu.yaml
> > > > > > @@ -0,0 +1,138 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-=
8bit-cpu.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > +
> > > > > > +description: The display controller in Tegra20/30 SoCs feature=
s an
> > > > > > +  8-bit SPI interface that closely resembles the MIPI DBI Type=
 B
> > > > > > +  protocol and is referred to as '8-bit CPU'. Each display con=
troller
> > > > > > +  provides two such interfaces, which can be used to send MIPI=
 DCS
> > > > > > +  commands to initialize and control the panel while image dat=
a is
> > > > > > +  transmitted via 16/18/24-line RGB.
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    const: nvidia,tegra-8bit-cpu
> > > > > > +
> > > > > > +  dc-gpios:
> > > > > > +    description: Data/command selection pin.
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  rw-gpios:
> > > > > > +    description: Read/write pin.
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  cs-gpios:
> > > > > > +    description: Chip select pin.
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  data-gpios:
> > > > > > +    description: Specifies a set of 8 gpio pins used to transf=
er data.
> > > > > > +    minItems: 8
> > > > > > +    maxItems: 8
> > > > >
> > > > > Based on my admittedly brief research, according to the TRM the d=
isplay
> > > > > controller can drive all of these pins - of which there are two f=
ixed
> > > > > sets as you mention - directly. So we'd need to describe which in=
terface
> > > > > the display is connected to in DT, but not any GPIOs (which they =
really
> > > > > aren't).
> > > > >
> > > >
> > > > I am perfectly fine to not expose any gpios in the binding, if this=
 is
> > > > preferred. Only question, which method of interface checking would =
be
> > > > preferred. I assume if primary then nothing, if secondary - boolean
> > > > prop "nvidia,secondary"? Feel free to share your vision.
> > >
> > > The driver currently uses the GPIOs to program DBI commands, so I
> > > suspect we do need some way of controlling those pins. Or is there a =
way
> > > to have the display controller program the pins and send commands? Th=
at
> > > would be much preferred because it would more accurately reflect the =
HW
> > > design and possibly also simplify the driver because it doesn't need =
to
> > > parse the GPIOs and then also not use the GPIO API to set the values.
> > >
> >
> > From what I know, GPIOs must be used and freed after use. Sets of
> > GPIOs are defined and remain fixed for primary and secondary
> > interface.
>
> So you're saying that we need the GPIO handling in the RGB/DBI driver to
> prevent anyone else from using these GPIOs and potentially messing with
> the DBI communication?
>

No, gpios are used for dbi communcation while their sfio versions are
used to transfer RGB data. So there is no risk in external
intereference.

> It feels like there should be a better mechanism for that than requiring
> the DC driver to request all the GPIOs. Maybe these should be excluded
> from the range of valid GPIOs?
>

NO! These gpios can be used for random purposes on devices with non-RGB set=
ups.

> We can make sure that device tree isn't going to use these on a given
> platform, but there's still the risk of users grabbing them via sysfs or
> the chardev API.
>

Well, defining them in the schema as it is now and adding a note that
gpios specified in the binding cannot be re-used/shared may be a
solution. But overall it is impossible to reuse gpios dedicated for
dbi by hw design. They cannot be shared or used for other purposes if
dbi is used.

> > > As for selecting the interface to use, it could probably be just a
> > > simple, single-cell value with two valid values. That's a bit clearer
> > > than a boolean, because with a boolean you need to explicitly documen=
t
> > > what happens when it is absent.
> > >
> >
> > I can describe boolean too, but if you want set it like "nvidia,head".
> > Fine by me.
>
> Yeah, I'd prefer it to be explicit which mode of operation is selected.
>
> Thierry
