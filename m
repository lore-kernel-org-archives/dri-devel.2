Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62872FF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7279010E3A5;
	Thu, 30 Apr 2026 17:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oVmeKysL";
	dkim-atps=neutral
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F81310F2A3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:43:55 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7dbd23bc684so454109a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 01:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777538634; cv=none;
 d=google.com; s=arc-20240605;
 b=NoE7HKJxvkHUotOWNU7aTJVsMOQk2d9zn3D7T9qMAPOiN8gw5D5AoWunOjSmqHaklK
 /vBHHVOmmWW5Cigpwt1bcusl1i8T9KF5JSHqB5cQKmz1mSid8/Z8+o3Xf+DIhmK03d4b
 aSPaUN1LNA2uF/Dk8a7onM8kF80VPefLtOGr8mrH3y8NMBthAGMEwhNJyEgHDBfpdyTT
 FjvxPmvzb0rtBnbudG2u/bvgBiDsySTEFTPcEN6O1VBL2GMoHLI0hnj87hWMlSOZ5M3S
 g0Cu5NhUKgnHva9Z1Eua+lgG+boS/mqW+AJU1G2m2BB2YKoOozhsMuEpE8I6243GeCeQ
 p5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=teejJxdHGs87pRJ1scnACJwACTu7quoERKWQueEhPsQ=;
 fh=9qwwfMPf6grKsns+8Sc0w5mu7K5pmoQKDZE8veO0tic=;
 b=kkiWNui/2UdY+jYr7uhg+kaBR3r/YiykKYdTfRahzMlLUtBBoJX6LUuQVUgcSfBDnK
 pNEiIKcfjpdQGKfy7iwIHQbwvN6FSvlqvGGPwM/FX2uKYNNIvROOS/F79Wnq3hLUDevA
 qXFix7or2Rq3K+hKm4kptIpnXNZ40t4/PONHNPpWCxtVktBA3pkqXbWQgWg5g9Obd+gy
 zK0+vOVuFKXucZ8aq4ynhbjQPUDnVcEVP3nBxdH9IALmi7yMQQ2LIP8rdpam4RHFovb4
 hvYaoLk5xvLhwz2epURQjBWmWEI0qumgvuYfFqE7IFv0NpgQmU5+DyVvNYjEgDAkSQu2
 3HAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777538634; x=1778143434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teejJxdHGs87pRJ1scnACJwACTu7quoERKWQueEhPsQ=;
 b=oVmeKysLj3zEhSxwTJZQ6gcos0ur8oXS8JJ2fq78CSr6n4b+smNnLCOS4PYjA7RKeq
 zuUKPCyq7QuLFG2hb6xGiB5V/J2yHznZszB6KlPrJ8XUS4hTquXTJyItc5vrm5+yPOYR
 gwrJFJLE9eCETddvzxECznu+QISbopMslFIW1ys0po9OMkDopPUjYO3YiwOHr1chJ/qt
 f1dbk/mEdtaj2e9+sfon7q4EtiZR8tkIIbsjiTPRYXt9c+3E6kqlIcMAwN6vsJU69x9U
 FKc6zLsAHPT8XdH3mGKgQfzKB9r7LrrfuYiui00rrtsHreNt25xcwaHP07thaf4IY8iV
 FHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777538634; x=1778143434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=teejJxdHGs87pRJ1scnACJwACTu7quoERKWQueEhPsQ=;
 b=G/ns49ruOB7/8efi0FySmVChjfoiTBnzO41AA36iVLZSQ5fbap+582NlBL9aTP0+Rr
 IKUC9+/aayRgdWu8SVPC5DSx7x9pCFzYzL6wvtrUYHQmRutgQxvo2jgG0oTXTXeQUFt8
 THay9BjbgNyJuqpfBmHifywSB97WEs19r6k5RlKkTa7/jeqZBW06bP3ZyDEeFwE1t0Pl
 ywRYHl4+JPApEr1BFlmgQrKUBcjAsS+XFGviTr+KhRYm7XErrUYkzvIe1uPCHGRB9NzU
 JBkZNN/kYqhmWUBOkqy79Oy6fACI5gie2pZZPbPwhgtJIDZMn/M78QKQ+Nd+N8WoUZS/
 MgBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9P/uhGS3ibX6OpWM14MYVLxoTxbVyneJbViwD0PGZxNLqbDSgPHxDLAV17Abd3zlto8NU2HGD9rbY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymqlZoOIuREMznBCKhwT8HEwz8zawl8BsAx0mtVujz1srO8dMO
 S4iV5SrNWCFwyRtj/pkEGoyQob0CcuEdn0tno0XaZAnfTQiuMI5yCj+Zued6IA2B1MDJPiORUBY
 XRc6GRS74236QlxqU/3WwDG+WGdkUEGc=
X-Gm-Gg: AeBDietr4qGiEbeqfXnZIv8fkBaUA9yJiyGvs3/NsBJCu+FdCno2MZTSPblExyVtuKE
 2PVmDWFHvg2FzAwU1BOMZFC78PwrPzMsMjdSaZXYvLQaKJ5Oq09/kebGZzMXAMqnA9x6q2nxjL7
 LngyY1ZK7Zfyhs/gnxGWCYU/++/Lk5hTrOVo/juFTWVLswGHzu9wv3Au66PoUb0khTwE6HHvp9+
 bHtG9PGYj1UaTmlNqsPdBKWxuKSrQNrMYUT+Y4qp9gD19SAPjiJiq5shyZGDO5yLqCoipZxWvIq
 kwFmvCOIfV03FviFXA==
X-Received: by 2002:a05:6820:16a3:b0:692:61:b486 with SMTP id
 006d021491bc7-6967a4ad53emr826876eaf.11.1777538634095; Thu, 30 Apr 2026
 01:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260429040541.3404116-1-syyang@lontium.com>
 <20260429040541.3404116-2-syyang@lontium.com>
 <20260430-gainful-hopping-quokka-da7e7b@quoll>
In-Reply-To: <20260430-gainful-hopping-quokka-da7e7b@quoll>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Thu, 30 Apr 2026 16:43:41 +0800
X-Gm-Features: AVHnY4Kxt8XNmGTYKSZA8jkq92TzjHK0M8QbzkPs5wku5fPgONc019FE_ckolQ8
Message-ID: <CAFQXuNZ-+0dKFrViisWG4NK=yk2zJ5tn21RZZ3ze7ctsV6Ruew@mail.gmail.com>
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

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8830=E6=
=97=A5=E5=91=A8=E5=9B=9B 15:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Apr 29, 2026 at 12:05:40PM +0800, syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> > and output signal/dual port mipi.
> >
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
>
> Missing space after ':' in subject.
>
it will be fixed in next version.
> ...
>
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Video port for MIPI DSI output.
>
> Wrong description, first is input. Look at your DTS.
>
yes, you are right, I didn't notice this place.

it will be fixed in next version.
thanks Krzysztof Kozlowski

> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Video port for eDP input.
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reset-gpios
> > +  - vdd-supply
> > +  - vcc-supply
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        mipi-bridge@41 {
> > +            compatible =3D "lontium,lt7911exc";
> > +            reg =3D <0x41>;
> > +            reset-gpios =3D <&gpy8 8 GPIO_ACTIVE_LOW>;
> > +            vdd-supply =3D <&lt7911exc_1v2>;
> > +            vcc-supply =3D <&lt7911exc_3v3>;
> > +
> > +            ports {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                port@0 {
> > +                    reg =3D <0>;
> > +                    bridge_in: endpoint {
> > +                        remote-endpoint =3D <&edp_out>;
> > +                    };
> > +                };
>
> Best regards,
> Krzysztof
>
