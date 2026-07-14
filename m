Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB71C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B580C10ED88;
	Tue, 14 Jul 2026 14:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ggJVnZEB";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5922710ED83
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:00:27 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so1939192a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 07:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784037627; cv=none;
 d=google.com; s=arc-20260327;
 b=jX4q0OvHCIMKzv92F4CiupH/z0ciIcKlaOo3962No+J1xYMPb9L+N2Dw584hnfb/SC
 VfZy1tZ++HZIcoEBoX5uy3yYLrX31fKTEqil0r8zyq8kZhG+UY7893xqBbM8qBzoYfhv
 jKrINcQ/SfQKOjkfsu7q2qg71a+jYoD53UN6BWzPFWz2eFByXUAx4j5yG/kpQk2tPG9w
 VlRjMkkj1g24Tqt7bXtj1uKLe19OHCVkETws1XZSE0vVmmgv3uRE+MIJbEF7j7HEZBi9
 TrnWrUPteXXeqC6AJ0kP1wLuLCnC1b8V3rzoIZvYoPaEH1ulgq55OXcGoYTZhZPjCVDa
 xSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V2/KhXQ427CL5ieErbt2/8G6KNeA30GSlOdbiwIQ4Jc=;
 fh=ZA6Yf5xSu/YZkcEXH+HiKhgZksYrz8FSiPiZQphoSHY=;
 b=TksU2e32IQpd7wYMSjxEbVR0xcigqYLKCaabWzSAZwR289JCZ3nJ6LwayRrMpN7+b4
 wZRLSHVjoDHCsI0QUdjeqv4KDgQK18HrN8enX+Ubgi86+EcYx9Su3pYxdQGc0htZsmeK
 21k/DzcAB70fDwXT2fQht9beRDteNiwFwcQ7BdwVRzRWpEaWS7rOfjwwhddMuNflDiUp
 I1YS1QZ9xMRNeyqIE4wmMMk2IWMdk/c6YAnBxa8khfcyu/Wcq27A7GV3eYUujtmwRWJL
 1oeZJp5Efi8am/XnCD851HeX/3FZAs0nFWGKYVauwrBvnNO0hoh2v5XPnjdWLbcN8bxr
 t+gA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784037627; x=1784642427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V2/KhXQ427CL5ieErbt2/8G6KNeA30GSlOdbiwIQ4Jc=;
 b=ggJVnZEB3eX+SznDLdh4wa/6lXKiFhh80mqgfsrdyUzoeeI5Ygdb2Xb122Eev+NNaf
 O43OuzsK4nSUPdvdg3Gu/X6sZV7hYWYWzuznMo2yFGltIol1qO1DHD7okQLyATeOXiGX
 Kt5GIU/kaIDobDc2Zr+pcpLDMmEXGZY9ypI7wyN7KnxZk7zbnJlaQEAWEJ+5JMAkyWJG
 8U0IHJesz70w82/IeDzVUMYguHG4RqfraetOnYuib016aBYqgkzQwEDtNJBCLpkKIseL
 u/KJYHV8GLu8MQCdolN7tG0D025vXpDXVOQhDZZ5B8SAsE9Xw24uil46peUtYvkar/di
 3biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784037627; x=1784642427;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V2/KhXQ427CL5ieErbt2/8G6KNeA30GSlOdbiwIQ4Jc=;
 b=Nlbb66eYL9sPObfReEIL83f/gJG0weA0RRlzkSYWIqjX2CrtUx9zAfut53Mlr7VDV7
 X/ztF24AyrZgE5V5o1lJXLg/tgh6LfFFhKWzgBwJH3RS78UyuuqIzk6mxZs0RMy1ytgF
 /uRn45OwjwWFVwUEhX4pvHkbHjGhcdEV6CuBnBe2eUrE0s/wwrqlq8mMPSD6mqpjCku7
 2J8jDlib86w7nEm5/wBPpUHGd0JNDYlFFEKwiKOHR/qhRpprydh1fhB2aDcW3wXXhQbK
 qVuxK2pKq5E2VlRG4O1j030LvnNcgTvgT7md2euNL2udTZmre6qDFLCe/CO6k0BzG1cv
 sCog==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/cVhu7JTUQdjFpfFeWPN/uunQNzJjKotLqwD5Yz3cc79S5TD43NXWHNCiOnW/DiJIeMgtFJv350M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6DO6YZ6lT4lAahA+Xw/EeulFYC5foG8owqhAj7jetTVOyFp1v
 z1vk+wSXFYXqNXf6mKGLG/LoBbhctWY2VrXim1IEtOfks6phm7XaD8CPR388eioBz0hJ8Qq25oo
 NrW6zCyym2MHH/ekcKRYV0hrxlNqHmN8=
X-Gm-Gg: AfdE7cnzPQlCzb7edDLxTtPNND4QxRpNj1Sc/fhz3hCwpXsTLBkNLcw2013ha7f9aJF
 cRiAjYKUFVhViY5fk9FDURMHVXLKEbEGxFUhkkkCK1DS0eGonGOzenZhXNeIH5UFq4pFgNfX3PN
 +JkgI8iSqRoNx0gYYDEyFNPyyHoFEkzf+mOwBkRFH2piy4poTOylOSD7ltWdofl9rdca4FzdGvK
 nEik1IDCv+qdCSOc9lWmqBjA8mddCRcOJdhYG8yhqKRsCQTXrSqYT16UoEVJxDLECkmGA9sD9+J
 iI3UmtoLNVaAs0MSfs6MPRL3ITEF+08YyS5QUvq0
X-Received: by 2002:a05:6a20:72a8:b0:3c0:9c18:d5ad with SMTP id
 adf61e73a8af0-3c3572b5794mr2798444637.74.1784037626720; Tue, 14 Jul 2026
 07:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-10-clamor95@gmail.com>
 <akeYWRF-wIlrHTF5@hovoldconsulting.com>
In-Reply-To: <akeYWRF-wIlrHTF5@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 17:00:15 +0300
X-Gm-Features: AUfX_mwnssZkuxVf2843X6HTYGv-SRm_VXHXZEuLPu7vTjXTmj8SvtNozHDr9W4
Message-ID: <CAPVz0n2EGy3uWwUfumvRxr2M_Z9ZMZ5f9=RO=S5vUsGk=ejcJQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] mfd: lm3533: Add support for VIN power supply
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

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 14:09 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:26AM +0300, Svyatoslav Ryhel wrote:
> > Add support for 2.7V-5.5V VIN power supply.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> > -static void lm3533_enable(struct lm3533 *lm3533)
> > +static int lm3533_enable(struct lm3533 *lm3533)
> >  {
> > +     int ret;
> > +
> > +     ret =3D regulator_enable(lm3533->vin_supply);
> > +     if (ret) {
> > +             dev_err(lm3533->dev, "failed to enable vin power supply\n=
");
> > +             return ret;
> > +     }
> > +
>
> No delay needed?
>

I have not found any in the datasheet, if you are aware of the delay
duration needed please elaborate.

> >       gpiod_set_value(lm3533->hwen, 1);
> > +
> > +     return 0;
> >  }
>
> Johan
