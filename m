Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F91CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EAB10E5B2;
	Wed, 30 Sep 2026 11:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hYu2CWOE";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A8210E5B2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:10:28 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-34b1743e9c7so853260eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790766627; cv=none;
 d=google.com; s=arc-20260327;
 b=MyP8mxMC/F+sfmShCf6VQJEToCWV4Ncs7mhAHYxDql5SXVcni76KMIsohrAzuC51Zr
 mGgFahjIOMTUd2RLjFFBfVm3EBtsx/tf3cKOuU0Ll9De+4PNR7NvyJy1sfAqZGWcqjxp
 sKK80pKuRVOmEuB3IgE/e2Yz0W2GjL7ZpgUVQIkO+NBTzEQZl1fbMt6OtfqukIsYiFsR
 PR8l9zVwwOOIVa9yZmcN/BPPIDDrplvzR8aH6t52c0/g74MoGRHTVXhfuSVv8a9drWWP
 9qhfzcAw8nxr6Lc039QNf9BMJdDW7miStMlwlZKSE6rrj3F1kpEi4XWElvwMIPzA5jho
 RZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OEhQm76+qWHV8H86aGRhLc+e8lMqxBXJwP8RftuJrxE=;
 fh=t7z7A7eeuVSaT2uaguvRcc2/2EyOuuED9z+okF7qSno=;
 b=BNA6kOwsrGSyQeOqs+aJsI5dKoTK1LH5V6PN8ljEfda/cqSnETTEYFH0TipRjBxvwI
 QPYWJXWyHQx4LD7dUINttnXD6EXp0/FuKBhBj2IYY2ONlta+c0XAb6/R2jx9fR4xeBcq
 4d3o3Uxcs5JtK/+/NI9Bed7RbFXYoq5K6tj0+9G7gPhHLqC5ihqzo+e+L2miGhQR4axm
 Z1AeCJCCFYX66ASHg9GgKDiqSfl5CTSOsHtPocU7VSQ5EsrZ08H1O1JZVE/bIt3W/A6d
 6XOU8fjoLOF7nY5pGtaFghNMCG2iNFdBPbBUPY+tJvtBxwCOj2sR0VbdMPFutVkDt/D4
 ECcw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790766627; x=1791371427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OEhQm76+qWHV8H86aGRhLc+e8lMqxBXJwP8RftuJrxE=;
 b=hYu2CWOEAANRRZfrnqwOc//AMmMfIF1Sg1ljes0eK9JYyWiM2YnNb1V3oGqcQCV3SC
 pcVJgowLTTW4/ZAJqOQkLL+0jvT+egMSK0mLwZ2iFcXt5yE+YAJ+ztMj51EpedcHMYsO
 IGU0AvYZTkbFJVHDyRVhrlEaPBUcYswucPXqATviKPmbY2pmkSxQ+OCH9GGjXnh1Guzb
 ls52vm85mGsudV+sqeHyBalSXuISw3gmE3rDLra2LEdV7YaSnOS4sLa7maRn7f4sgHIl
 40usqVObf9szapHIZyYNaQtl/FRfNvt8RfkYpnaQI8BeeunJW1JjGlSAwbikj3SSseQ+
 K5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790766627; x=1791371427;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OEhQm76+qWHV8H86aGRhLc+e8lMqxBXJwP8RftuJrxE=;
 b=1UjmJ3kvjh0thFYA4zEecAfQ4IXdlPFH2XbTc9dQzG1ofM1EdNC/+UgCXVOsgrlDhe
 7j99zx0FmeR4/VaQ1hoU1zrv9HJAkzGl+gF34iOrMgDcPN0+nJ+bpYMHy/lL3nhfqlhT
 e/EIvPDfLjloOEptvQq/4l2xiT+OyXbrIS+ajFb7FFzFpHfgfy5FdfBS6Z5bUihLQLrg
 Rz/KBruAEwLZSrpW2GscqHNuqFWlq7FWBHjevvvBpNDaudSQ0hLK6eULRsaSF35Zn6co
 XoCfSQBzKwEm9dMl38SWkG8RHtNXgEhLT5HaGl6k7OjQSUVKC7SdYTtIsUoahLA9GetK
 jk1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjhGVKBBq/ZR0/xkTTRXK4n9hHxNH79gHHDll/9rMMx8vbD759aniSizKfo25VLvZ+k+BvcG2gaHI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL3VbOgOQp2HE0ZuWLIJFRx9/xdpQ4Ku9lNkoEL9xsspxfxKkNf
 PIQGy9GyyiKzkI9nlqxrcbQjh1zDnSTJdXKGfP/B1Y2bhvSxUIEa/+RRRqEBx/2lRCmwH8E0fTf
 n5uG8T0BlO1HE6QouvTljVnzCUC/1DH4=
X-Gm-Gg: AYBFou0zLLh+m130o/HuO0jqrENXwatTk+KAht1ZMTsyf3gPDWoO3ZfcN2ew2yl+NOs
 mCsHCLP2TmIzijz8BL5prtdXgXarx0xiIx6RA6V8mIiBYtDH55lwzQWFsBatbtpUwNDNve3JzXQ
 gZIha08Wuw8R2HVJTu2pvoUO9yeSg2FOmRynqOdJbWlkfBQmDuAsE2IjhVksW0Vk1WOJnNNsanJ
 bwMdy7xcCg1G9a+IjFbrHk4qLHX4037cXfpWimUI++7xJ2auAkiX1u8I0N7n06rBYOfcvSSYjEq
 T7Dl/8vfhgUof49QY2YKXVO3QEnY/T0NbH7+KVEPRzDT+QkFnboJyOdMZLOMpRjY3uQ6MXr/jvV
 6xhezPS5A5Bwk
X-Received: by 2002:a05:693c:66ce:10b0:34b:731a:7325 with SMTP id
 5a478bee46e88-34cdcbb4344mr1377981eec.29.1790766627375; Wed, 30 Sep 2026
 04:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <arzMF0wjcF_SVxpE@orome>
 <CAPVz0n3Oc4ocUWrtGgd-MdrdJ3SgDEi8onOkXi92o7hAn3y0Ww@mail.gmail.com>
 <arzlR8mCg9d_z62L@orome>
 <CAPVz0n0jnitNemUyhi9C2SgbRbJA9CinY1DrR-r7gnN=CaYGiQ@mail.gmail.com>
 <arzpluDc-Ib7q-K7@orome>
In-Reply-To: <arzpluDc-Ib7q-K7@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 14:10:15 +0300
X-Gm-Features: AclHuK-5MVKqwWOaWtZXWbiTTg2vtWkQnodr3EENyxfP5JkvZ2csH4Wtodn2Zmg
Message-ID: <CAPVz0n0sQo-6xKOGzd3LsJzzAr7_TficW4KeU320Z-tcRUne9w@mail.gmail.com>
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:54 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 01:42:17PM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:34 =
Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Sep 30, 2026 at 12:00:21PM +0300, Svyatoslav Ryhel wrote:
> > > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 11=
:47 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Wed, Sep 30, 2026 at 10:05:32AM +0300, Svyatoslav Ryhel wrote:
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
> > > > >
> > > > > The description says that this is a feature of the display contro=
ller,
> > > > > so adding a new binding and compatible string for this is not the=
 right
> > > > > move. This is all covered by the "nvidia,tegra{20,30}-dc" already=
, just
> > > > > need to extend that with whatever is new.
> > > > >
> > > >
> > > > How would you model it? I have tried to model 8bit-cpu as a bridge,=
 similar
> > > > to how DSI bridges are modeled. This reflects interface used to lin=
k RGB and
> > > > panel, without inflating existing DC binding. If you have any ideas=
 in modelling
> > > > this, I am open to any suggestions.
> > >
> > > My suggestion is to integrate this into the existing "rgb" node, or, =
if
> >
> > Not an option since it is not clean RGB and there will be no way to
> > distinguish RGB from 8bit-CPU.
> >
> > > that becomes too convoluted, a separate "lcd" node (or "dbi", whateve=
r).
> >
> > This is fine by me but nesting nodes without compatible feels weird. Oh=
 well.
> >
> > dc {
> >   compatible =3D "...";
> >   rgb {
> >     dbi {
> >       ...
> >     };
> >   };
> > };
>
> That's one option, but there's also many other ways you could
> differentiate between RGB and DBI. Could be a simple "nvidia,interface"
> property in the "rgb" node (that defaults to RGB if absent). It could
> also be a node that is a sibling to "rgb" (rather than a child). Or the
> child could work, too.
>
> Ultimately we're still describing aspects of the display controller here
> since this is all registers within the display controller's MMIO region.
> Nested nodes are purely for adding some logical structure for the
> description that makes sense.
>

From my understanding data is sent basically as RGB, at least RGB
configuration is still used in downstream. Panel commands are sent via
DBI

dc {
   compatible =3D "...";

   rgb {
    port...
   };

   dbi {
      ...
   };
};

This would work nicely if DBI is modeled using bridge framework. I
would strongly insist on keeping it as a stand-alone configuration
separated from RGB and DC.

> Thierry
