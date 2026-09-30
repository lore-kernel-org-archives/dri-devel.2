Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A46DCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F088910F281;
	Wed, 30 Sep 2026 09:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f75wmyWZ";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1D110F281
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:00:34 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34cde269e1bso247975eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790758834; cv=none;
 d=google.com; s=arc-20260327;
 b=eB+fQemrV5x24Dac+RojvHGe1nG/cSpNrb2JSEBnuKVvx9Y1hsNsleIN4IWKkcQvd8
 5K/uLqnoyfl+cuSFZaXHu2/VgclBek/QkPIVshFVJ/M0/EouyvxkDBcmV8u2cDc19nsW
 oLwS0YzkMefUydyYVG0n/vRrWzVH0rdjoUhgL/1iCQwMSn65bNG0eqUCJAxWput3Ktpk
 R5p5od4zFfimMt3DRjy2BTveAtum5IzySTPYnP8O4HsEgOX8vy6e/cNEmc2wlKkRoAAT
 hz1P4MO0U2gWielnLigCMvZLo8fMYqc4urBC8IkXaIAuvHgj8NGoQwAPkc98rgOZk48Y
 ikgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jmnQsQ2nLUzstSMrsKXf5By3v5J3tmrAtywKsYCssgg=;
 fh=yBg82hWCMwicUCALXQIeiBtDZb47Pd/XZTv98fuiiCg=;
 b=qWD3IvQRDaBNUUEA/r/WVxuZ9HHFkl6NlTKcrrgpUqNwDMuEz2I0WdGMWsy8oITDuk
 4objNoFPJ3eqj4RpqdXe2rleJfX0U/h6uWcJCZ/UfzYygP7niB1MLQpFk83xmwmLiy3B
 SBydb3m9K2Uu6kkzx4aAp67dn8DHuhoh67BDtEBLLBRGIEsQadH4cUumHZq/SbbpHvVi
 hBL1emxnKy8aFND4qTdKZip7q7TqyP7nWWQfKsOUbzeia3jX8JPewjWnBk01los+XVvG
 v9eZnTUtpqTvlgDj5f+KCVLXiUJxBzfMKge+5AwiVHCZpeNOIKdHJY+FiyeYrTcEZk+s
 nPTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790758834; x=1791363634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jmnQsQ2nLUzstSMrsKXf5By3v5J3tmrAtywKsYCssgg=;
 b=f75wmyWZtScgTmrwqGSyvuMiyLw4u2juBt6lxVK51BfSAFc8PTMof7JoO6iOwDaPYX
 5BOP1AH9XdDmvSp/F2IEWPJBixq1xtGY+Q76FIWndtA7uSQFe8a6ucEYcdusqMJkEo0h
 FmwQZu79D/QO0giQFDug3q+AVTWHNUOpXW9+olq5V6ZurM94WG2BjbMQKaFyJsczIcbe
 oPENnODpauhbuivTdynbMBX5dtg7P69L2/6AqmBuVP7Xy7+O8YWBEoiK2x8LUg+ZJHWX
 CjAs1q4+c+ewaXQV31Uul/kJHv0a9qY+Qc9GsOWGoiVLlGCjTjugsX0C8V3NEXMbqT55
 a9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790758834; x=1791363634;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jmnQsQ2nLUzstSMrsKXf5By3v5J3tmrAtywKsYCssgg=;
 b=Mlmm7Hwp+Wu78PnPNLLMQB9ktdlddRhsosbhDED9VCCLL5k4wwWu90NRCLLp643oMl
 ByADGxGjodfx9vLENJds91boAMCYmMYENAVORcT5uFt8vePkxLwYQi3l4u0ePTWbr4xr
 iYQqMsdyivYgeDr6bRwYVMZ0EGhkPeLbais0rB7P7IU9ynyfCxoWfpCcoxFBDIeSXf0w
 aV22e98SL/RhK3GM48KMw8ztuBNqPmAQ2jA02D3Dl5wTWkxfOsusg0SeISn477bHKvuz
 Zqzl0zy4we5IYYF2M5mGELv06zIxkj1lDQiErbZkuBOc8ZzAf2yOUa4gkr+TQ60OFDf8
 NK0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaIZ/C8Jhqh0vBBYim8J9dEhgA0CZ8JJDNwrbaNVGiqS4NPPUEF+5wQiT9IsfL+JKGi0UsvhMuigY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYICsws1zUuX2c7wGJeagai9+v3sGvgNAXzTkyPazpVQm81CXUK3
 jEnt9q1iQTx2fku5Yxv+u7NITwTadFsJwPPk0HONrF2PJzBT8vUow84GQ6gmBSWUjOKR+zyhwI+
 PLvMVpkpC9cIgSufdsWS/iF3wQhwHeDM=
X-Gm-Gg: AYBFou2PXTwVjwo+i6wnxCcOXdu+Qf8wKJYXI0A30TcgnAQJpGTH8eM+zMCg9OEUEsJ
 xeobw2a0kkxKE7gyt7SpRaupbxyJp1/YPreu/rj3zTj/YxTB80ZA95OmNj1g/Lj8/fa/bsIbpZ+
 cmPmEtF6tDBzER23GTX0R6W0Kek8tbgSDt/iqlg7617s32GkLtL6tPeyUsU9B3S3NTRUsB9I4Ex
 /2FPn+gHe9Qw2SImDyPzVaIzeZyU6gPlz+FtXBmCDWxr+QYwUXT5F1iMilncGD+9uDnnLNyZxt1
 9hFIlKDEm6Ahe6UFq+k0DVU8ziRz8LHiR66wEAn6CZmUUrMQnUUTR5du44ejWrOxHNh1Oi6/Rmb
 siiUrZa3YWHtb
X-Received: by 2002:a05:693c:6392:10b0:332:8b9b:bdc4 with SMTP id
 5a478bee46e88-34cdc3caaaamr1126682eec.20.1790758833695; Wed, 30 Sep 2026
 02:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <arzMF0wjcF_SVxpE@orome>
In-Reply-To: <arzMF0wjcF_SVxpE@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 12:00:21 +0300
X-Gm-Features: AclHuK-TlqGnIU7ukp8yYWTozjs2IS2nCNkcdYeOW3HWE0VGgW8HyLwmVml-FCw
Message-ID: <CAPVz0n3Oc4ocUWrtGgd-MdrdJ3SgDEi8onOkXi92o7hAn3y0Ww@mail.gmail.com>
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 11:47 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 10:05:32AM +0300, Svyatoslav Ryhel wrote:
> > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > Tegra20/30 SoCs display controller.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvi=
dia,tegra-8bit-cpu.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,teg=
ra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,t=
egra-8bit-cpu.yaml
> > new file mode 100644
> > index 0000000000000..f0dab608b2936
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit=
-cpu.yaml
> > @@ -0,0 +1,138 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit-cpu=
.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description: The display controller in Tegra20/30 SoCs features an
> > +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> > +  protocol and is referred to as '8-bit CPU'. Each display controller
> > +  provides two such interfaces, which can be used to send MIPI DCS
> > +  commands to initialize and control the panel while image data is
> > +  transmitted via 16/18/24-line RGB.
> > +
> > +properties:
> > +  compatible:
> > +    const: nvidia,tegra-8bit-cpu
>
> The description says that this is a feature of the display controller,
> so adding a new binding and compatible string for this is not the right
> move. This is all covered by the "nvidia,tegra{20,30}-dc" already, just
> need to extend that with whatever is new.
>

How would you model it? I have tried to model 8bit-cpu as a bridge, similar
to how DSI bridges are modeled. This reflects interface used to link RGB an=
d
panel, without inflating existing DC binding. If you have any ideas in mode=
lling
this, I am open to any suggestions.

> Thierry
