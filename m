Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A575FCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A28610E268;
	Wed, 30 Sep 2026 10:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hoxc/iEN";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0DF10E268
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:56:53 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34ca54bfc48so690778eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790765813; cv=none;
 d=google.com; s=arc-20260327;
 b=OKSzdLZ1lfNmmAoNl67MVi0WQ/o/E6nH+Xghyu/kbuyW0SLplbK/a96R4jz7eezOVK
 VDhu53uAfGkpJALpzie6kLjdifAFTupxqgliTfqmvAA6/WvPq5D5iMMOsdgxKhsybTQk
 BzifxYcpN9Li9hkeQ4CgmTfIdXPMS1zAQKOn3TQPkblhYPWGvlZZBuss4KneogmVEsDk
 64m4bJbXEvJTIk4UvVHPl8BdP4JL1efx0J6RpVqPj9ja5XavIcyBsm0V1EU4CHsVNUQA
 dKgP3zjQA/WmRCJMKOKTQ3/EayJEPzL2zyULQ8gXfBjySEOsMbhPFliCddekJjJeDEZQ
 kzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9e1cJ5TO1cnYCQwoGNWZgRp51pppadHuJRrjli9Xnp0=;
 fh=nkUVBi0UF9+IJC7iocNyE3QYdWnoO2H1YC36375/l9w=;
 b=G4nZgsCS1s+o67VnwGlWcmpU9anLZtBwTjr06joKmlNzeUY7zSoay5VFDpDiBoBUOn
 lQx2bpCPoaPy1DJSTxWMLsS/0NS7tl4eOzJxtYUUttyPU3OH5NfHfSD8f32NaKknlTIe
 FC8G2M03Dg5/Oi8BoV8XLqiamLHiLUFZ5rQ/ZdPhfRoy4h90TkXpfSISVtmMmx8cMN+2
 5Ul/LozDwhmXRYll3pVEfeONqAKM6sbkXcW5ga7tVz2Z1Ux84HhL8Ws3ChbfomKRxqSg
 ZY2OCzsuM2clW/PlJP2CiXmM/uQz1S5VsBGSF+Ii/drFN5Q9EyKr+h36vX3CqxltR/6d
 K+jQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790765813; x=1791370613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9e1cJ5TO1cnYCQwoGNWZgRp51pppadHuJRrjli9Xnp0=;
 b=hoxc/iENYBGeMpRztAgA22FALYUrhBBaROFWZabPjYweEAf9D8N2QS0meUGcthWaB+
 vnOF2r5gS3VTGC83z2Wr4edp7vwmwV77HYfMIrFgoK6Iwy17uhIiobG+lGl/lKCC4r/1
 0P7/0rfonpR3OyxpMCQgBg7jdUWPb9mZcNzT7v40wrE7s9RefZn3ipSv2pR1Q/ODf4h/
 k1CWXuXpLaDnP39XDOdODSixsIqZ0h41H4IKFWwbi6+EyHoEuV1/Jad8HWYMkYBu7cqn
 UsdGap/IcQVyo6fkkijPOmXUlBsATE/ETWqMuUiGSneNPh0+xixucEMAih2hUGvnxhIH
 F70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790765813; x=1791370613;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9e1cJ5TO1cnYCQwoGNWZgRp51pppadHuJRrjli9Xnp0=;
 b=p/aAsWHBUj0md+iyBomc3hsZJ4NCEEx5XwWiItvxdSI0CUC5hTLZBIa33OG7lXXVhZ
 isc99gg0Sgd693fFOB79VfLU25BEjb+XEgvu/ryJ/bQyCNCXF3I3MMcSBME3dTumSdLh
 DEHcI35wDjfQgI4U3b0EuDibGZahBvHWK2YzllvWc1Om2luEQcasJsM1rWfuuPTisCii
 k0SSjQjeAUl8j5gta1iVaEfk4o0wIKrSz46Fd1aunBR6BN2MAAx8aubwX2+GcBJgQVZN
 TE8K8+SUAcz3NhfJdN87lrUtLLNY4JY2dt9Jzl5Tiex4KlenAWOz4u6h9AVb6we/uYfQ
 kTTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQuphwOV8nzSXqf/BHigsd4AiwycnjgDazHBfj5kGeQB4FUKSuLtLZrMUldFJC5Bd87vmQL7OSp+8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLOVF4u1in+avFiUTf8D+wyuaX2pbeIVDamD4aStlFecin6q2ja
 pM4vQUeY0kHPdd6as80SleZg3uowZyzZK58wgT3uSo/hEJQZro0Ob+7J0Xrc/p5A1pOoJiqQ40S
 GVvd1WMr9ubgQtSbf6/u3DrQOH6FB+B4=
X-Gm-Gg: AYBFou25C3mP5xvrTEOkBMtdxoLIFNFwVyukOHcgGgm6kSUPScd04RT6gIJCRm3gl8o
 xTyZGUuA5wKY71v0+nUgI3fiubg0nQJJ5/8WhaMAqy1uxRwhOOzNYcIck3JfKGndZ07TtJECZ+Z
 S4IXLr6enwzuAKCxuK2D2V9BpQZYMY2OM1SDLAQxKcp/ivs5/zq9uYlxdHn/Mm8qPiy0TpmgQ2E
 b42CgQzM8oFo18s8FfiXWW2hvOkkHCtZOyhcxGngV06ZhoBIbolR4q+MT4dS4uwi99LtNeooUpk
 bkm2JGoT0WIVqL1zncwH37XBMZOj913S8Jqz9FZcf5lkJcspLADOiP1wVqbXIOzCA6HVzmyVqSQ
 ETcATUbrWHlT7uE7kY+ibnO0=
X-Received: by 2002:a05:693c:42c8:b0:33e:a0c3:4163 with SMTP id
 5a478bee46e88-34cdcca9e48mr1323411eec.24.1790765812417; Wed, 30 Sep 2026
 03:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
 <CAPVz0n2F8LBqFs2bJERmgvdNYgtt1OEVtK3++CP9y0gxW7gCGA@mail.gmail.com>
 <arzn-TNbOlqXqQgd@orome>
In-Reply-To: <arzn-TNbOlqXqQgd@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 13:56:40 +0300
X-Gm-Features: AclHuK9oLMebZiHh4azYE1DFmusVvYbZfHXPOcFGt1h-TD62cN-nNm6dZ6ICVfc
Message-ID: <CAPVz0n33c_uwfhsSguEfFfJ3FV=26SPtNTEpHes9f5RjnPDA_w@mail.gmail.com>
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:50 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 12:52:18PM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:19 =
Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wednesday, September 30, 2026 4:05=E2=80=AFPM Svyatoslav Ryhel wro=
te:
> > > > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > > > Tegra20/30 SoCs display controller.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++=
++++
> > > >  1 file changed, 138 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/tegra=
/nvidia,tegra-8bit-cpu.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia=
,tegra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvid=
ia,tegra-8bit-cpu.yaml
> > > > new file mode 100644
> > > > index 0000000000000..f0dab608b2936
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-=
8bit-cpu.yaml
> > > > @@ -0,0 +1,138 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit=
-cpu.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > > > +
> > > > +maintainers:
> > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > +
> > > > +description: The display controller in Tegra20/30 SoCs features an
> > > > +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> > > > +  protocol and is referred to as '8-bit CPU'. Each display control=
ler
> > > > +  provides two such interfaces, which can be used to send MIPI DCS
> > > > +  commands to initialize and control the panel while image data is
> > > > +  transmitted via 16/18/24-line RGB.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: nvidia,tegra-8bit-cpu
> > > > +
> > > > +  dc-gpios:
> > > > +    description: Data/command selection pin.
> > > > +    maxItems: 1
> > > > +
> > > > +  rw-gpios:
> > > > +    description: Read/write pin.
> > > > +    maxItems: 1
> > > > +
> > > > +  cs-gpios:
> > > > +    description: Chip select pin.
> > > > +    maxItems: 1
> > > > +
> > > > +  data-gpios:
> > > > +    description: Specifies a set of 8 gpio pins used to transfer d=
ata.
> > > > +    minItems: 8
> > > > +    maxItems: 8
> > >
> > > Based on my admittedly brief research, according to the TRM the displ=
ay
> > > controller can drive all of these pins - of which there are two fixed
> > > sets as you mention - directly. So we'd need to describe which interf=
ace
> > > the display is connected to in DT, but not any GPIOs (which they real=
ly
> > > aren't).
> > >
> >
> > I am perfectly fine to not expose any gpios in the binding, if this is
> > preferred. Only question, which method of interface checking would be
> > preferred. I assume if primary then nothing, if secondary - boolean
> > prop "nvidia,secondary"? Feel free to share your vision.
>
> The driver currently uses the GPIOs to program DBI commands, so I
> suspect we do need some way of controlling those pins. Or is there a way
> to have the display controller program the pins and send commands? That
> would be much preferred because it would more accurately reflect the HW
> design and possibly also simplify the driver because it doesn't need to
> parse the GPIOs and then also not use the GPIO API to set the values.
>

From what I know, GPIOs must be used and freed after use. Sets of
GPIOs are defined and remain fixed for primary and secondary
interface.

> As for selecting the interface to use, it could probably be just a
> simple, single-cell value with two valid values. That's a bit clearer
> than a boolean, because with a boolean you need to explicitly document
> what happens when it is absent.
>

I can describe boolean too, but if you want set it like "nvidia,head".
Fine by me.

> > > > +
> > > > +  nvidia,init-sequence:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +    description: Device specific set of values used in DC DISP_SPI=
_INIT_SEQ
> > > > +      registers.
> > > > +    minItems: 4
> > > > +    maxItems: 4
> > >
> > > And AIUI this is panel-specific DBI commands the display controller w=
ill
> > > transmit. So ideally the display driver should receive this data from
> > > the panel driver.
> > >
> >
> > This is not panel driver data, but it is panel or maybe even more
> > interface itself specific. TRM has no clear method of generation of
> > this seq I am aware of. Maybe I have missed smth. These 4 entries
> > co-respond to DC_DISP_SPI_INIT_SEQ_DATA_A_0,
> > DC_DISP_SPI_INIT_SEQ_DATA_B_0, DC_DISP_SPI_INIT_SEQ_DATA_C_0 and
> > DC_DISP_SPI_INIT_SEQ_DATA_D_0 registers of DC. Maybe you have some
> > info to shed some light onto method of generation of this seq. Then it
> > could be simply removed from binding and calculated internally. Thank
> > you!
>
> Even if this is interface-specific data, it is still defined by the
> panel that's being used, right?
>
> As such it'd make sense to integrate it into the panel driver and have
> some side-channel to feed it to the display controller. If there's no
> good standard way of doing so, having the display controller read it
> from the panel node and programming it at the appropriate time could
> work, too.
>
> Thierry
