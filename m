Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60598CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C336510EE78;
	Tue,  2 Jun 2026 10:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fpo9dE6g";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10DE10EE78
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:19:12 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso7134552eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 03:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780395552; cv=none;
 d=google.com; s=arc-20240605;
 b=JTXSwGJBTWdHAKc1iv6Y6jjMsh6PaKLcbArPFmtmbC2IKH+WlNURtzYbq4dPF/fD7O
 l0J34cR7ZH5hlTIkRdYgN+3HdV8lQw8Xd6iFtY03pGIAJ8CG3nrZMkUacxTR646C7sb8
 yiQTgYkqdiQ7JU1z4ex2TqSsh6OHNy3hIJes5B4NxxtAribpNE2urz3TswlJjv04mXDT
 MizIldQapfD/Ke3mu4Dnzm2n2sgn3Rz6tAWz0wlTUo1juZZA6zsl5Y459UfU8CigXWsD
 fD9xY573plxAeY+YUj9mZGheH8QebVAgY5gCgeWHnM9dbV+FDLz4SdeWzOJsrLP4CVD+
 zwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+Rz2DgaRr0tqOwLOIkcbJ3/5tQrroNwxRI/2HG/tAbU=;
 fh=aQ9pANb4G617WaRd76lza2N9VC/9VO7BxdyJj1L234k=;
 b=J3EWEeUF7fp+k0ZXF4gQDg0lBhcOz7kB0rGjEqIPAV4QkuDgpQ+TSFRjF/Sa5gzH4w
 mmaZYIn/SHBx24s/l+sE+Uj33+zmZE3KHT1lisbVZncoflO+PoddLboPUs2lH0PEcZty
 1wsbA8PL5ZLY4xSf9Diztp6i6pjpLXCscJOXZxAoMars1DzXdcQQSBq9tXY7rR9PwPtt
 rPYbW28ABJmEiDNrCat3USGJsUJZGJnuaM+lA7Qn98tLC8Yh72I3Rj7athTeLof0oNY3
 kqdVA/jwF/beGgyojNJQvVgF27T6I8RWJygKS057TKw2CHJenjMqsWaori9nw19m6UcX
 efdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780395552; x=1781000352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Rz2DgaRr0tqOwLOIkcbJ3/5tQrroNwxRI/2HG/tAbU=;
 b=Fpo9dE6glFB85ph4OJu8VC+YnVCBBWTVbYn2lbkGSviiQpdYyWrHWKP5HL/+u2e3XY
 n05Eluvef2BYRqX9B/cNbwGASxvYDbyeMRJRf8fo8z6h37RwQfyIXFgioxyCJgh2SwVZ
 cql3/H9UiKAekQgyoRVeEkEooxqaoA/TK5hG3zBM3KcTySYdOKWXm4D6B9lzSVWzDTVY
 uE+orMqaAfZGHYiCmvs8ua7Mv6LM1JHFy4+cbrYL0q/mZkKfEuQmsD0XiW/25h41u1dc
 cg6MHmMh/rooW9gsudUewszFNlz2sAp7iDQafhOPBmfj5ngyd7682KRLhF5zcqv92oFY
 cR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780395552; x=1781000352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Rz2DgaRr0tqOwLOIkcbJ3/5tQrroNwxRI/2HG/tAbU=;
 b=Jn0TIme9ZAkz2AtswrWLfRfuHtwGzlfL+PChH1Zdaej7+qgZDWSIbYlJ220vv/RQCQ
 AZ1HwxpvXlpFRpFARBJWF9kmvcfW4QvkNs0EJKxa63IG+Fb5Zm0hPTAMBsBKal0yJxkj
 2+mL58OkoyANAcYOazndtdbZq8BjduzjSa4M4mtqjrnWDtA+Ei/f6R+l+9zE4kY+eW2h
 4Nznd/qX8gxMl/1dyOgUYzxYea02fywFfr4FIjgyBdmwJg/5XAM6SJBlkWsaAqGUAnej
 6axaoUyDQN+Czt86aL62R+TIwJNv2D+Cy4bshc7bIdvf+QuZHnQqKO2Iiba7vtUfAzy+
 /10g==
X-Forwarded-Encrypted: i=1;
 AFNElJ//wJstE2oxAQGJW7GYeqS9NWIFfBK8VWJg0Eg7HzWQ/qt2fYlAFadlhz7EYzb4BkOTxbNBcA0a8B0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzhs0+RcrOyrC7MhbljX/OKauPwztoDTi6qhTYMii0sipnzVPTR
 4u6/2uJIhRSLJQbu1r3YAVLhe4F0zB6l70BygC/dDfp05obYBmBwKtLR/Kbka7BnKjvkpzerekW
 S1SeunCQVNTfLovGtSqqEVLLgaPUzxmY=
X-Gm-Gg: Acq92OFMU1ElK18WxFiJ3CI9FQX2Gd925QWGT8DJcFkClwHuILARLkPJrUtfCOzlnM5
 4snD9MfST6eVmnF2QEl8EtPaZ4zeYhnZKEv2tdiSc1VIhfuW235sC+ucdwZQnJT88goqpNxgBGR
 Umqcx33M/uZ66UwGJUtZxytSS1pQpR0whrxEBjYtuGeq5TaaurCWhlgrvNebVjiiFF18lUlqUUV
 otUI4CR+tPGa3YfwXtGWN/gmcMZJA2xo+xfRcBdqOeaxylgVTXeo87K84JzFVhsyIWtZTRv7NlD
 4TKg0jhT7yNwD+DXFMg=
X-Received: by 2002:a05:7300:6427:b0:2df:919f:ce59 with SMTP id
 5a478bee46e88-304fa67ee46mr6895369eec.19.1780395552116; Tue, 02 Jun 2026
 03:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-9-clamor95@gmail.com>
 <ah6PxFtoJUWkd79P@ashevche-desk.local>
In-Reply-To: <ah6PxFtoJUWkd79P@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 13:19:00 +0300
X-Gm-Features: AVHnY4KArfWMr0jnHoh9vtR5UqW4K7jQ3330Z8FTAYXvtwkDG99A7ncLjymdKC8
Message-ID: <CAPVz0n0P7Jk17cM2M1zuHZfySo2=Uibr5izwKU2tqiBpBcg0FQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] video: backlight: lm3533_bl: Improve linear
 sysfs logic
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:09=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Jun 01, 2026 at 06:18:28PM +0300, Svyatoslav Ryhel wrote:
> > Simplify the sysfs logic of the linear property by switching to a macro
> > and a ternary operator.
>
> ...
>
> >       if (kstrtoul(buf, 0, &linear))
> >               return -EINVAL;
>
> Besides _assign_bits() in the below, side note here to unshadow error cod=
es:
>
>         ret =3D kstrtoul(buf, 0, &linear);
>         if (ret)
>                 return ret;
>
> (obviously in a separate change).

Won't happen in this patches.

>
> ...
>
> >       ret =3D regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBAN=
K_AB_BCONF,
> > -                              mask, val);
> > +                              CTRLBANK_AB_BCONF_MODE(id),
> > +                              linear ? CTRLBANK_AB_BCONF_MODE(id) : 0)=
;
> >       if (ret)
> >               return ret;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
