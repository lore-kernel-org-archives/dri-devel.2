Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1280BCD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC0B10E5ED;
	Thu, 14 May 2026 18:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQ5F/L4X";
	dkim-atps=neutral
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2364510E5ED
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:27:16 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3937014be0cso77538501fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778783234; cv=none;
 d=google.com; s=arc-20240605;
 b=aWuadDV+BHyafySCpnEwrJU+b/Q67y4dgy+6+wcRRlt0l2GRF6m2h1ildWW4Uqb7no
 TnXnkW9FRDxgLZHhbRWlot+4GJ6Qgw0QGqBPXtrnTtsYIEZP6w1btjpUou49lscTUlgy
 tGHzUSYgsx3QufwOLtoUsPTXTZT4DM8rckf07lXjqFj5sHwDpXC12Nw9Tc0NVG4LDO/I
 1r7toUquK+dKq35guAZjJ5eFpksgvypSdOv//p92oTHXoJ7xPwFO0TYmnBda0ZBBMYQX
 sxZNmnGn05fW0M8eiZynJjCqL0wNnTP+C62U63vaOflO33y7G9bXnlawJgMsJlskkpbH
 uxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2Xh19LyQF10UTWKq1me0fwm+mh43ExASMESLfzu7G68=;
 fh=UpDZZEkmUqmUx9C+rlCbwjY2076RzoZ3/7AnGKgmo7A=;
 b=CdhaUOBM3fmW8MiM1ePJAV4eUS/aok0HeGXPfAIcTdFG3GE5IWrXfWKyCp1T2CFXBC
 dmJb/t8WGednXb4i25eYORyeGx6F/JJ8jUOTQtp+cPMn/lIMnaDtbYxLAaTrPkjP1q1V
 LY8BbGdcR9w/X44FAfIRVvAd5Huh6lOYgeXf+Q0ISowx440+ZRL5gY10NlI39nzml+vH
 boDUJuKYz613cwoSOXVQUvwDlbNdbMjymK9++nyHT4S74bD2hTRQv7sp8hF61LXQM5AB
 nIFeSBovIFpfIxtcTSM/+r9XYh+lZUiIQLcY90OpilQ98nnj869jAyxGaqWH8N360glX
 Q4GA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778783234; x=1779388034; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Xh19LyQF10UTWKq1me0fwm+mh43ExASMESLfzu7G68=;
 b=aQ5F/L4XE4VVBtIfP8N1IjXsVRsixHqsR6tv4Wtb4tsMuV+extGg4mct2r/bO4Rm+n
 xc2sf4Upy77GMBO5gAVdyUGV0ZGaUZFaLAYv/9yDkQKzBQCUkk6Uqn7uOjyHSzgHX/mE
 +oAnLUUkVnBWmRAQYFEgTYXOt1liuRztS6hU/yJpP87yBNoerqL2NxvblM6lNFBzWhn8
 6SPYxAn8gowKXINgFeIYDEKlG2f3Yx8HtpDJVuv9LYwfCXw25EqupMW9mlkbF2l5reSG
 RZ5kYE0b6uW38T9d7iLKleoWJc+/KuOwoAd+zAxr3BaAgXq2uDMkJbitv8hPs8HpVOv7
 0yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778783234; x=1779388034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Xh19LyQF10UTWKq1me0fwm+mh43ExASMESLfzu7G68=;
 b=ag0wdoB80wXd+iNjd+4nItIy5IOfSXbG0rPc+gTf3iuBKLcgbm29b4IYicoxJZOlaE
 bUxlnizydCLQE7Mzkk0mllQfJRU7bMa7Je6c8vTnxqhPC4ZIj61Vnurk0y8o0DsoIRPv
 kQi+7eLT84ievW2woLwaTNSYCDp/G4vrqi2KOULPvhD68kuitzDK2mFE6H7pGezOZhab
 +Vkm8QDBE86f/eX7RFPH69NXxVn1nVieJ9CYh0foHEc/Pnore0o+t62PrdQxrR3TH8vC
 HYrzrRvj0//SQfbshRnJRNhtE+KL+BnaOziwqdzffTUV5/1RPhjJEMRSXcXcA2z+0YTZ
 9aSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DVJQojZKe26SxrSy+CwKoNwY47urGeUIC+1LGIVawABs1iWhAd2tZZbOWo77I89kDDFxS+wDsMME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+0AghzHxPRz7zBBxcmpyNOewdm/syQLc0f+h5C14hAnVhUUnP
 neBxOCy5NkbdcGf2/hqvNRcnGPDTuY+HNKQhGjbD+kVjXoZ0MzlpfOJoUqGxshYC55Ix7oriMYb
 KEfa2/Y4m2Q4DJD5QhhF0w2qiQfgfzgA=
X-Gm-Gg: Acq92OFLDXPNCMDUPcdGdsVDciMw61FoHOzTfYpha8o96qk42HzqL5oHmZghDHA8vH+
 pK2CZyeStGJFh2NkUhFenLoCAKbxHknEFdSrED4D0yXYR3gGilmZVoxdhAZ/dEwEBC1JqQqdVIN
 5JUUelRHCZu/6IYoJQEv1udnJxQ2CpcEt41RhiS6YmThmQ7Mr5b3ww9ap8fVqfIvUPySOd19zoq
 58MYjpSRpHDhkanEuLR10mbjK3ZM+RGb1ogGpCh2/klqaA37ku4yL/n8GKNwKyXe61XLeqwOsyI
 BDL4KYB0e9jXIA4MlK/kTTkFtOHBijCfGJTThI4UJBlA6kNCUEMJ+PNCFMtQ7CSnOT5VmzbrENH
 kdl8=
X-Received: by 2002:a2e:b8d6:0:b0:393:fcd7:5f69 with SMTP id
 38308e7fff4ca-39561fa5c00mr481851fa.17.1778783234209; Thu, 14 May 2026
 11:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260514-icna35xx-v2-0-45acd1dfa566@gmail.com>
 <20260514-icna35xx-v2-1-45acd1dfa566@gmail.com>
 <20260514-ambush-salvation-ce6616190390@spud>
 <CALHNRZ8ukiSM2+uj+Qg6rVbUjjFeo88HQjLZsFHbHBs_GTy_1Q@mail.gmail.com>
 <20260514-accompany-expiring-c90c6af5f7a9@spud>
In-Reply-To: <20260514-accompany-expiring-c90c6af5f7a9@spud>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 14 May 2026 13:27:02 -0500
X-Gm-Features: AVHnY4KadKJWIbrmQIWY9oV52j-lGH3-yJCkf7ITOkZqzHwuTXiKriwXdalEiD0
Message-ID: <CALHNRZ_qBwobaf=nX0i-CwnKexf_PnucEoctFk4Ec913YwDzNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Chipone ICNA 35xx
 OLED driver bindings
To: Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Thu, May 14, 2026 at 1:23=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, May 14, 2026 at 01:20:57PM -0500, Aaron Kling wrote:
> > On Thu, May 14, 2026 at 1:07=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Thu, May 14, 2026 at 12:24:49PM -0500, Aaron Kling via B4 Relay wr=
ote:
> > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > >
> > > > The Chipone ICNA35xx series of DDICs are high refresh, low power
> > > > MIPI-DSI drivers for OLED panels. The icna3512 is used by the Ayn O=
din 2
> > > > Portal and the icna3520 is used by the Ayn Thor top panel and the A=
yn
> > > > Odin 3.
> > > >
> > > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > > ---
> > > >  .../bindings/display/panel/chipone,icna35xx.yaml   | 79 ++++++++++=
++++++++++++
> > > >  1 file changed, 79 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/panel/chipon=
e,icna35xx.yaml b/Documentation/devicetree/bindings/display/panel/chipone,i=
cna35xx.yaml
> > > > new file mode 100644
> > > > index 00000000000000..6464d8d0cf86d5
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/panel/chipone,icna3=
5xx.yaml
> > >
> > > Filename matching a compatible please.
> >
> > Does this require splitting / duplicating the files for each ddic, or
> > can one be arbitrarily picked and the other stay with it?
>
> Pick an arbitrary one. Maybe which one is older?

Alright. I'm going to assume, perhaps unsafely, that the lower number is ol=
der.
>
> > > > @@ -0,0 +1,79 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/display/panel/chipone,icna35xx.=
yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Chipone ICNA35xx display drivers
> > > > +
> > > > +maintainers:
> > > > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > > > +
> > > > +description:
> > > > +  The Chipone ICNA35xx are a series of DDICs connected
> > > > +  using a MIPI-DSI video interface.
> > > > +
> > > > +allOf:
> > > > +  - $ref: panel-common.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - enum:
> > > > +              - ayaneo,pocketds-panel-top
> > > > +              - ayntec,odin2portal-panel
> > > > +          - const: chipone,icna3512
> > > > +
> > > > +      - items:
> > > > +          - enum:
> > > > +              - ayntec,odin3-panel
> > > > +              - ayntec,thor-panel-top
> > > > +          - const: chipone,icna3520
> > >
> > > Commit message should state why these ddics are not compatible with o=
ne
> > > another.
> >
> > Ack. Short version: some of the mipi vendor commands don't match.
> >
> > > Rest of this seems okay.
> > >
> > > pw-bot: changes-requested
> > >
> > > Thanks,
> > > Conor.
> >
> > Aaron
