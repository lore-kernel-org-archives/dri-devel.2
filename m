Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19690CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C2810E466;
	Thu, 30 Apr 2026 17:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T72TlFsv";
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF20E10F2A3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:55:35 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-682fce74c06so582753eaf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 01:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777539335; cv=none;
 d=google.com; s=arc-20240605;
 b=YWJNVHqqV95/gIwIR6P/el8J/VoYLDXqdbMnDPoKoBn+8kyH3ATi8cWMXR1I883boX
 7e340JbLnyTMZrEkyNsRwLFXe3ZKxxp78UD7qyOVq7xw8+GaHRczIF4crB6QIX1R9glL
 2t8XRKLBWgBqW5w9WYF48Wt6OzMwLt5wa8OQjFly/mtg7hPiUJ3qTpEpILRK6IUNbGq8
 vno1S3LCJGarWLG+h4S7BZ952p1qV0q+cQMxBqLyZ5ZOsf1YQ7e4fSMbOaDT5fPokXWC
 ng6Tp8YmARwDe1btHWZ9ZdFPVL+6vZ6uPkjt+Eyuq8V7oiByQ/6UQAqgEUInoB14RAwD
 KOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6F3SW0LEcxR5KNp5mL/u22r1H9M5kFSrUg1f1ie4v4U=;
 fh=CSjDVWZWld15LPuBScaM2+qZLL6VgaPDS1HisXSf8II=;
 b=bf5WdNU265spm8vPTzxpyUywZMe8Sv+SVTfMG+mel6/f2qerD3aGhV0ID6+S2VKVBr
 OgDwGbSJ2YyaEQmPZx729yQOIOWerfaJGfZ/dN5lcXPBbwnRXZKaPMhpQr6UjLwGgFtS
 zp+tHEjDlqTMUqH/xPhzYVI7swegBuzoFrjuOKwlSdot/gYpYQU41sMZM16Fh1OBmOe9
 Z6YgXDrg7y6ZV6J32HlvuhWIEVOvHPizUw+J6gNY4WdmCqq4YQPbJP4RAvFXRS+Q2nMs
 AP9Nhd7fbddSF2daym3gjklCxtk+QGx8OUUrKrb7GDRhtnH5MsIDyDBVMGQ3kfjTYdok
 dtsQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777539335; x=1778144135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6F3SW0LEcxR5KNp5mL/u22r1H9M5kFSrUg1f1ie4v4U=;
 b=T72TlFsvI8y6v7Eb7eXGyE4gDDHVqxulGpkcg5yhmbvsQ6aug3VtDTRhyGy/LXubxD
 VO6DKnFf62jWhLOK4ip/JeN3q1b4vxMKO2X7FEhzPfvxndtl9aCuhf8mwKt/CnyReXpM
 m1XyaHXhKsN1dBDePgSCn5mn7Z1hlajFHkZwEaQ5grLyB8vPC6x9YpQUfY1i8WJJ8vFT
 60InzwdQBevMq81g2iq2AfrzrkCDdme6vUU5RPeRJnOhsz7j2kU+siiBJa2zLK7Tvs0a
 FGJyLqAMvW4qSz3KrVb0xQmfXlkQj8kjPhqcRhAMg8m95zL8gwM7Nc6dYcHkCdfcwxKa
 RThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539335; x=1778144135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6F3SW0LEcxR5KNp5mL/u22r1H9M5kFSrUg1f1ie4v4U=;
 b=DxiJGgpSV8HLs1ajLSl3L8nza1BZ55z0tk8VbAOkTiRxGnTkui2S8P2wGzcMind+pi
 LoNcOEYdW/sCs0d+jTkVzE0Wg6xEdzQIVuhNIpvsQimp2+YXFQxUBoITeGGM1LWKDrbO
 80xhS1jhu5LkxmI3ygGJHMoZ0OHPhx/Avbpsr5uSKn7Z/SmsX8iQn7OZrFRgmwbnJguX
 1Dx+4Kon1V6ftBRES2Cg59TorL52tTv3DZBHzB3TOBFO/jiBFX0dJqwrOdQHDYxgD0/A
 au5zLEFYU6dgWRRw4l7Wge+uXc2h7edBAv+Vs9LHKm6yt18OwTDvNuSc8HksQOiZu7PM
 DqkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aDTO4NDE5JzZuleYZvLpX4ZCk4icTGxcFL3CcCawP+2aN0bA8g2oED0sVsmfdGuS97WCP25FrDk8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLftdHnf9AgHGRm3Rd10pSJaMXQz1QMfOb9BMOjIxc2tMuFGNC
 n7KFQD0SVD47PyDyaiAI1teclFNmzziGSorPN3eEVgqeqKTCub2jDY+lyDGk7miEed5nW6hqQKz
 yrnMIWZu927oUqsVkC7sbNk5/d7/YW4U=
X-Gm-Gg: AeBDieu3lc+JziQTkVkcB36qnprOywc9+DPthhNjgBBY9bx+6ArGj5BXJoYJXTdXdOQ
 DUbpwkwYE9eXj5Ilj72tpKHs734xpsMA7YFE+Njdzn6nJE8DsLAF13yrU8EomLzvT/ylePfK/4X
 AuXPApW76bdPyT4O4cTgR8mQIBLqXU7XRwEddCrNBb42XhTK4QHCX60cRoiKILm5r9uTcORrKGu
 DlE6O4jDZVkzPUbrIlNbQrvs0yb5gptdYIBCmsgFqqGAFigHkAPyUUhe1ryLcBsJjTHFWSSVTRh
 /PPZ2WsGDXF56D4DhQ==
X-Received: by 2002:a05:6820:1690:b0:696:70f0:7ada with SMTP id
 006d021491bc7-6967a4b77b9mr848411eaf.11.1777539334862; Thu, 30 Apr 2026
 01:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260429040541.3404116-1-syyang@lontium.com>
 <20260429040541.3404116-2-syyang@lontium.com>
 <20260430-gainful-hopping-quokka-da7e7b@quoll>
 <CAFQXuNZ-+0dKFrViisWG4NK=yk2zJ5tn21RZZ3ze7ctsV6Ruew@mail.gmail.com>
In-Reply-To: <CAFQXuNZ-+0dKFrViisWG4NK=yk2zJ5tn21RZZ3ze7ctsV6Ruew@mail.gmail.com>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Thu, 30 Apr 2026 16:55:23 +0800
X-Gm-Features: AVHnY4JVp6wvmjhYEcmx2St3LTne9Y_ZRg2uwyrEugHA3vkFEyI9m4Aurz6GNe8
Message-ID: <CAFQXuNbAxdfy=9bBWAsy1Gx3Chgq+d3YpzaP+EBneEEsKok5tw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings:bridge: Add Lontiun LT7911EXC eDP to
 MIPI DSI bridge
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org, Laurent.pinchart@ideasonboard.com, 
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 30 Apr 2026 17:06:40 +0000
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

=E6=9D=A8=E5=AD=99=E8=BF=90 <yangsunyun1993@gmail.com> =E4=BA=8E2026=E5=B9=
=B44=E6=9C=8830=E6=97=A5=E5=91=A8=E5=9B=9B 16:43=E5=86=99=E9=81=93=EF=BC=9A
>
> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8830=
=E6=97=A5=E5=91=A8=E5=9B=9B 15:56=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Apr 29, 2026 at 12:05:40PM +0800, syyang@lontium.com wrote:
> > > From: Sunyun Yang <syyang@lontium.com>
> > >
> > > The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> > > and output signal/dual port mipi.
> > >
> > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> >
> > Missing space after ':' in subject.
> >

> it will be fixed in next version.

sorry, Where is the missing space? I didn't find it.

is:
Subject: [PATCH v3 1/2] dt-bindings:bridge: Add Lontiun LT7911EXC eDP
to MIPI DSI
?

> > ...
> >
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Video port for MIPI DSI output.
> >
> > Wrong description, first is input. Look at your DTS.
> >
> yes, you are right, I didn't notice this place.
>
> it will be fixed in next version.
> thanks Krzysztof Kozlowski
>
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Video port for eDP input.
> > > +
> > > +    required:
> > > +      - port@0
> > > +      - port@1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reset-gpios
> > > +  - vdd-supply
> > > +  - vcc-supply
> > > +  - ports
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    i2c {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        mipi-bridge@41 {
> > > +            compatible =3D "lontium,lt7911exc";
> > > +            reg =3D <0x41>;
> > > +            reset-gpios =3D <&gpy8 8 GPIO_ACTIVE_LOW>;
> > > +            vdd-supply =3D <&lt7911exc_1v2>;
> > > +            vcc-supply =3D <&lt7911exc_3v3>;
> > > +
> > > +            ports {
> > > +                #address-cells =3D <1>;
> > > +                #size-cells =3D <0>;
> > > +
> > > +                port@0 {
> > > +                    reg =3D <0>;
> > > +                    bridge_in: endpoint {
> > > +                        remote-endpoint =3D <&edp_out>;
> > > +                    };
> > > +                };
> >
> > Best regards,
> > Krzysztof
> >
