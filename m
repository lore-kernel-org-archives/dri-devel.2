Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5C0C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DDD10E6C3;
	Tue, 14 Jul 2026 13:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="glVZqIAO";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E4F10E6C3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:27:22 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so988278a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035641; cv=none;
 d=google.com; s=arc-20260327;
 b=ZiEASOPQHyeLGXvtrJf1Uk7JzOsf/Fq/rUovEsU1gff8dMJmR9ATUxtD3UyP2Le7RQ
 0ieciecOabAaqIxB+hlsQTQXWh1LTFWIC8rJjeHlDBcEGAIUJC0cF8hGUUQyis2AsoJe
 Fz6bK0SHIjyB6E2C6rK22c3lBFP/R8JUPQTraySzXKGYO8+fZL8jSDgSWrRztaMZrEF0
 Q8NXDy2FngPdP5t94Guw4eneXL0huppLa8nQ6VOuaWJzcypIHg2T8WseHey0DL1A0iz+
 HBNL2OicMHR9o9thDV76lHF/CybIV5hQ0JtlMJxP8ADp3hJPFRBT16hWsICXJlZVcnsy
 wOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PSq/mUWM2YvpW32XDTn1fQtxRJbdlACjQCMNg3wpfiM=;
 fh=Uvrf9Pqe282bGWwaiv7oc6IscFeixwusC9SXYjyPXJM=;
 b=giubvr6S0+FFMcbOEoOVr0X8m4ckQEjenxEYFa/l4Hjig518WGRx5tgOE0p4SdSEuw
 FfiQYhqyNFkyUPoB0OUWNwP+GmBy8hNerjAsUATR4Qxi0vU6R2lm7e/u315e2//Er1yn
 mM0fxp4yG9I1ci8uWfIkhCAw/JcO805DRbwLnFIlWkD99Cr8du6ViLjLYwdscYHO9FsT
 x+c9ZprXcg6hIQzcrnv1w+4UoHSkrbR3HbkOX9fJduwwmoNC0iMciX/eq/3y5KfOEKSW
 l4aI5rz+5+1Oc3ABZHphCmMtFtKiDW6MZaasPLHgD7R5T4T+WF/k0bo573lx5PRjyi0n
 KvoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784035641; x=1784640441; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PSq/mUWM2YvpW32XDTn1fQtxRJbdlACjQCMNg3wpfiM=;
 b=glVZqIAOBeoRYt9SNWvGCHnRdBHaKcHaoh1s22cxKlRjiF3TDPOHvftAeTSsaX3SQe
 wphhz2u0h7UBtXZaZjvLDHbT3GlpkozrKARUKZTd2pRXbud0EC3QYyQybQYBgt1W3CAl
 zfWNgfJh47MxfuOQePOx/moQKnMcB0QXTR+HsdTvSNM1xKClx4K49M/6AbYR+ou9EWgt
 tgBC7JsEYlWSVcg9MetN+/MxkAscu4j5rPSN8FRlnJFSlOLQopdo5HLksVUWtjTXy0b4
 /GU1Ca3jsgcYg/JGc4iqSLAPmr+78oxObHf16k+oxM3cX4k5NR2ycC51Fa/sFL97yBkK
 p++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784035641; x=1784640441;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PSq/mUWM2YvpW32XDTn1fQtxRJbdlACjQCMNg3wpfiM=;
 b=kwPGYeA0ixgwKPJ2YUFOiK8D3HpM5kUzdW226fMIFmhrKQe5Jwra9V9xsZc6gaHQQj
 R84/jQTod3F1sFSJu3WyhVz7TU6YAvkQd+lCv+8c/ZlQ0V0xDXiDD7FKdED6H5WjShlt
 fY6QYdIW5snZ6+jSiwWk8/GInsd+Hs+T36XGk6pWoOjm+ir2AsoOUKxRfVVPaQF5kPZ1
 QZO3YHDyzJwkExpIfjgxy8W0qA1aERhsOck8xV2n01i55T1ymOySr1mivGRzQbOb3+yA
 3SyHjApupJ2dl/eUgNNWYJGD8C/JaZTAdpQ5XOkq41JKAy3wb0etTam1Mrcr2LAZsDyw
 MZQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJtowW2wXeQfYrrufj+/GRCOLTvJvW3wR/jWuaMxh0hsZ8kVoMeaGTZ48RHw49mvPsl+P/YrVFnlU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEObREzozQvkIFYhvAOgB7tTF4pwePqVz02OWB+hJNZc2ecDFf
 KCxmfUZaxw2dlu+GaHzmPpGRk4YqYZk1iCYjTp0LGul/7FmUTb1InfV5YkShSK2f/3KFrwa+P/U
 qEOv/5hzQpumV1YhL/gtIUuYrT0ukmNg=
X-Gm-Gg: AfdE7cmwbBa+kRGmIrMLo4l6X+dSYMjfmRNwXvKigtZFJHi8LHl+Nng2TX2dYh/SfcT
 DEp+JRv+rrRuhyu4RKYNSNIaWWrNex/UXhHA1at9JvID+lxYuoAERudwDnOrNf6Df22vmJ04Ti2
 JcUr3+a7hjIpuO8PiE1WTBzzijJ2gpeawKfFEvi4wEFfZVH+RxHUvH3RvX9sjBHlerp5A35MLaJ
 4hxwjw8LelCBZlHf94A52XBLNKMQWRJZgCwq1xPIIrxweUAfpnn98j1BKkDljwzUaSH0iSZT0Di
 lWYkT8yc7czhtJPEkq1eKynBXA2hvQ==
X-Received: by 2002:a05:6a20:d70a:b0:3c0:b55a:80ff with SMTP id
 adf61e73a8af0-3c11063d595mr14450342637.24.1784035641387; Tue, 14 Jul 2026
 06:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-2-clamor95@gmail.com>
 <akeFmMQ_S1Y18hlu@hovoldconsulting.com>
In-Reply-To: <akeFmMQ_S1Y18hlu@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:27:08 +0300
X-Gm-Features: AUfX_myw9KUnmAWsWcXDIJL61TlrVu8UIEI1kefy-2iSBs3h-OI28TD8pRQoND4
Message-ID: <CAPVz0n23=F2Q2fSJJx1E_mST2zhomKcvhKtOy-Af3aoq-pZ-Zw@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] dt-bindings: leds: Document TI LM3533 LED
 controller
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
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

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:49 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:18AM +0300, Svyatoslav Ryhel wrote:
> > Document the LM3533 - a complete power source for backlight, keypad and
> > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > converter provides the power for two series LED strings display backlig=
ht
> > and keypad functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backl=
ight
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        led-controller@36 {
> > +            compatible =3D "ti,lm3533";
> > +            reg =3D <0x36>;
> > +
> > +            enable-gpios =3D <&gpio 110 GPIO_ACTIVE_HIGH>;
> > +            vin-supply =3D <&vdd_3v3_bat>;
> > +
> > +            ti,boost-ovp-microvolt =3D <24000000>;
> > +            ti,boost-freq-hz =3D <500000>;
> > +
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            backlight@0 {
> > +                compatible =3D "ti,lm3533-backlight";
> > +                reg =3D <0>;
> > +
> > +                default-brightness =3D <113>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <0 1>;
> > +            };
> > +
> > +            led@2 {
> > +                compatible =3D "ti,lm3533-leds";
> > +                reg =3D <2>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <0 1>;
> > +            };
> > +
> > +            led@4 {
> > +                compatible =3D "ti,lm3533-leds";
> > +                reg =3D <4>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <2>;
> > +            };
> > +
> > +            led@5 {
> > +                compatible =3D "ti,lm3533-leds";
> > +                reg =3D <5>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <3 4>;
> > +            };
> > +
> > +            light-sensor {
>
> Doesn't the binding (or dts) checker complain about this node not having
> an address?
>

No it does not

> > +                compatible =3D "ti,lm3533-als";
> > +
> > +                interrupt-parent =3D <&gpio>;
> > +                interrupts =3D <80 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                ti,pwm-mode;
> > +            };
> > +        };
> > +    };
> > +...
>
> Johan
