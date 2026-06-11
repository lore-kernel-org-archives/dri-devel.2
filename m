Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C44CD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F5B10E769;
	Thu, 11 Jun 2026 12:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qvRoN0jU";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8D410EED3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:31:54 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-304e83724bfso10055549eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781181113; cv=none;
 d=google.com; s=arc-20240605;
 b=KBYZlbkHlGul/jcJC+Rlw4lcsrtXJJSPImBmx391Vu0zEjBsEFG1LSBL2szl85Wnvw
 DNB/JeRVENuuFcILICZKlxWoH9UwihWBBXZf1zYdqe3a6h1M84hVa7/ac6uKzgb+GM+I
 nGlZBmKjyeq6+B1pOcy4n3VMq8BJfJ0kwko8UYtTDiuwnUa3/PI9x/tL4Q/DwQx1xrGl
 uTpId/BzoUAtWnN5n0vYIkNrKtfO1Novqcx/iYAlqHaD1gvHslDZt7YQbVCTnqmg172D
 FIZlPsMaT+ESb2uLXG1GU9NTxcaKDpd8mo9BtnF9a/KDHyRqRaB8sFJhKdoj/n+Q7prR
 AlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w4CyzohY6NxCIsHAPrysIwJ2ZeDEULVaTSdexi5v2m4=;
 fh=Sdre2/mWGM3ZL2w6tATGUNGox2iGirRe3e23T8ujskM=;
 b=ZlX1rWFChfPomRjfVnnfUlz1nQ3PaK9bnN/sucQXOyykLb8X/TzEBKItnOTX0u9t7p
 GbkOZUZKcKrscsLvx1Dfpkjo4Gg0ZqiFxs0opaAHXGKKq9lQgaS7yJiU9aQeQiY+8A0l
 2EjA9aqCFF+4JEE+CkX/RfL2O2uFywQ6rSZb7N0/bmL1pcKf6l3P2byiZbGtm0VJoCAW
 3hWC2yQrm3i18eLTbx2t5BAqPF5YaDfuELcUCzqCLXgTbTB9/f8boLWVMjt9sajzxT8w
 pLaDnApY//vUv0MpYNciIpH2p82Gc8PEyNpWQ5t5Nx0uauHuqGWDlx5GjXzEnCUI2Xq2
 rkYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781181113; x=1781785913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4CyzohY6NxCIsHAPrysIwJ2ZeDEULVaTSdexi5v2m4=;
 b=qvRoN0jUVhAbg4H2yvIrFYBiqd1sw090/9Xs8FAJlDSNEzAQN2PKd4DuCvu6uu0lzO
 3rsftoe6HpXAG9fu2BOuLq5cgEIhqDqtnYbU4C8kRj2c/49LdbCH2WXUPWOHhrJqnwJu
 RLfGBZkSZDLIzAzahzFvCQnAH3I+vEicSJMWbAKTK8BmTsN8Qcn9lSdwY2XcDwRWLLWE
 KgKOdw0e0Gym9brxdyavOx8sU33Hi2LA3nMoflG+Eh1PPqBCrStP/fpOYoGALwCFNn33
 Mrbnfhh2KehfOa6eFq28OdFGrsfxG30oeMXHPDERR7/L1a7a2BNtUhxZ2jmKieUTgxVC
 /nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181113; x=1781785913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w4CyzohY6NxCIsHAPrysIwJ2ZeDEULVaTSdexi5v2m4=;
 b=BF4n/lyKfP41gRtJB7VtRqv+zogjorbIPVggcoAafTDoY3jyhvIfcskUkhaNgBQ9n/
 MiupKqExmlc4EjxFgZUBw6tFdTGDHmnNdhOqksGjZFzDxNmKF1hJYut/Mf/4fE46AHul
 wMO/HapUsANiCt86+u8eC5UUBG5Zd8rfptY0yIizXxgIsJR1OXkm6+82tcTvaLJquwBe
 1l24bFlVfPEoejeJIivD3mPRos6sV/VM0TrGUgGBaWQjA1PeMWFUFdPptBBMRJMtqBQ9
 U3gRZNRf7tCGn+HPqnfqaYtwjw3RQvGcmSf9TB1iuEpgEBW5KcCsKQqqbkyzOWahLb9A
 AZ3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vXoanmUbnE1Eg1xgdKTKNoohlI49oHAVaaO2jRIBmobKr116aC4QDAUmIXjUeAOa0jiOi2I4jSQ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4g2mZVT/wo22yjchxsW7XsJYv99ZcDP7J9suAyc/2EGRBCInP
 WMKqrfiZbdtpolkvr75Vkqrh7Zz5GcBIgL5kSbJeOcHYb6Y7N+i3rFZNEehGPy553lbku7S9A4O
 Gj5jJyZYn3j/KI2v6FidLOaSlOeN58Ms=
X-Gm-Gg: Acq92OHqTsH5mVz4H6QEZE8XyICaaeBtsvGnP4ba/ub+hnCvyTd8wI12OI3ocWEa1QD
 tcXeKDbswmF86dz4WnUd6yXKQ1lLTtvn1R2+YZ3sH2jLUVgO4jfwJWBGQPGCNQOXb3lce/lZyMG
 4G7Q0f6TEuRe1ncJReA7+pxOweB43Fix8qm/fTuuQTXMWM5Z/JX6y37n2wIHF671/XzMjREKg8z
 ozE3GSQK4qnq852ECh+2WKnkMnz7PGcUmXRRCpT5llRfBydBymv8WCnL7yqJGANdihLqi99haPT
 1Ajixn0Pw4oP9CQihDY=
X-Received: by 2002:a05:7300:2205:b0:304:13f3:e461 with SMTP id
 5a478bee46e88-308047892c8mr1778310eec.3.1781181113170; Thu, 11 Jun 2026
 05:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-8-clamor95@gmail.com>
 <aihl9yIqN3adKWLr@ashevche-desk.local>
 <CAPVz0n2+27QVeWNgPm3PH6V2Ceuym6sbMtUrh7hSHe9PcRmfMA@mail.gmail.com>
 <aimxK3asZjebYrNt@ashevche-desk.local>
In-Reply-To: <aimxK3asZjebYrNt@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 11 Jun 2026 15:31:41 +0300
X-Gm-Features: AVVi8CfaCeDkKO_UpXhT478yTj8VjHK953EzmbL2Rc52Hp0WrpWg7gTbUSSSXw4
Message-ID: <CAPVz0n0z_6fuoxBzLcN0VdUBUWZB1c0VGsAkDW3xXnPuwZj-3w@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to
 device_add_group()
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

=D1=81=D1=80, 10 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 21:4=
7 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 10, 2026 at 05:38:38PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 2=
2:14 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Sat, Jun 06, 2026 at 07:57:31AM +0300, Svyatoslav Ryhel wrote:
> > > > Switch from sysfs_create_group() to device_add_group() including de=
vice
> > > > managed where appropriate.
> > >
> > > This should use .dev_groups member of struct device_driver.
> >
> > Specify pls, device_add_group literally uses dev_groups, I don't
> > understand what is wrong.
>
> dev_groups of the struct device_driver. It means that the data should be
> static and be available before driver probe is called.
>
> ...
>
> > > > +     ret =3D devm_device_add_group(&bd->dev, &lm3533_bl_attribute_=
group);
> > >
> > > This will make Greg KH very grumpy. (For the record, original code as=
 well
> > > but it already is in upstream. So, thanks for trying to address this,=
 just
> > > needs a bit more of work.)
> >
> > In the prev iteration YOU asked to me to adjust this. I have adjusted
> > and now you say that this is not appropriate. I will just drop this
> > commit altogether.
>
> Yes, and I still tell that this is the way to fix that issue.
>
> You can even do it yourself in a few clicks (hint: `git log --grep` is th=
e tool
> of the day): 93afe8ba9b01 ("ACPI: TAD: Use dev_groups in struct device_dr=
iver").
> This is an example of what I meant.
>

Oh, very nice, thanks!

> > > > +     if (ret < 0)
> > > > +             return dev_err_probe(&pdev->dev, ret,
> > > > +                                  "failed to create sysfs attribut=
es\n");
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
