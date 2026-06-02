Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9E5CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 11:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A794310EFFA;
	Tue,  2 Jun 2026 11:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cG2ygevK";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9424D10EFFA
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 11:59:18 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304fb780deaso3574090eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 04:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780401558; cv=none;
 d=google.com; s=arc-20240605;
 b=lErxvsdcRvQCywbxS5VQDJ67Ot8rMTZhVZbY7OaqNsjEEfEQiLYqaFbJjnNNToE4rB
 5WSfZCweITotsdjEXiamDEknC2ecLyMOYigGuMgB2ALRYS/EtvcM+vc66iLWjC9m1qLG
 ALFmv9SB8fD09aPwfrfFtRVwX5S0y5XBArooxSDOsbcPhwJIURXluwHhCCigAMY2Hr+y
 F5g5Z0nZHDyW0YbdmUe3i8ZyxJ6B5HriqoWtKC1CdS/gj4trdwthJVK4enYDPXxyEg8X
 kV24VPG4HSuq23AhtUuvaZd+jwkTQaZmTmuB2D5I8XibXJxIaQhBJTiWvUVwqv99ii+b
 qWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QwoGUg+AbKtXga7fuYSOtkP7mpOfS4rBc+JAo9UwGTw=;
 fh=v04xQUAE/Sn5Wtm/raTL6IXgGteWs0ActhNnzfalWGY=;
 b=Qj9edF6fzDRcGlT+fop/nYU+kaKInPAj7QpgjUzqSAFW048DaexeIxvwYWnFQMB1oa
 eC/DTRU1PGm50Kfy14U+ApdBuDxQxp3x/DolJF2W9UbvsnSTd4NjH7mPDYk9TWDbOaJG
 61MaWiFHnkw2a2xfUaeZWErebFHnCjtDPJkSRbxixBEB79kpN0OXUwF027Ieta8OgBP9
 NfT+NqyO4MaP/hIBCCcBkqTgA1/SrFBE6Dw2py/X/zXGIWeJJ9AUoapMp3DaSeXAgV5a
 aWbt0etIUCFhx/n1C79DdoeMV1Zq3TidPgiLvWNdPX6+YBA2KIbSIRatLf1vSU8Ye9zp
 5gJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780401558; x=1781006358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwoGUg+AbKtXga7fuYSOtkP7mpOfS4rBc+JAo9UwGTw=;
 b=cG2ygevKA3zBrqIgeG0EPf3UuvGBeVZ5fiVYbEx+g0MVp1kOMGYDfzCkcqpyuf5xRW
 /TUGd9v9xlLNZD696Iw3EypLD4CEtJeVE3VVmE/a7UKGha4VEBFzxi6YyCSGLrECalJP
 LoZq6oNLG/RrqbiqhpKj2muHxOz8KdN5zoYEPS70a1NO6cFgARTDM83XEJXX8+WvTEsc
 cO8FREuY2DukzQWtAMPa2alukTGJgNL9WXrWfjrxwxCbD8YNTcHOWB9BYLIZETp1q0R/
 sPLB03h9YAEOtUeIkJX2B7FuwXUOGPEQzBwCyEO5Arw+DqASj4cKTusnFUWeCL3xsXel
 f1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780401558; x=1781006358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QwoGUg+AbKtXga7fuYSOtkP7mpOfS4rBc+JAo9UwGTw=;
 b=aNwVlH8Dr9U7MgZocAAKJGRaXoEc5ayUQTR6yfOVqQlTaDbjgxox0w9xw/WERQc5h0
 M7meN7+VaMD/2xtoUnKcerTKxf/1NkEDdJADw1dJmKuTRCuIp3/o70JvLgNSchSpv6tv
 hjJtUQO99VFgfqPIiAyOtQhpIs2PyGCTHXjBG2ln2PM6llB7kPhVqD2NBUQtVmK3TsCw
 uyeGx6xQYaQZv+AzCq2T6wFp23HyorhjZ+WusBpyXBADhQCDRbsdOJThYPMOw/V8zJzc
 fZOr1xTxusuAzRKZYejVPsk1BlOr8pZFYsdfskpmACn6y9LAIjVJ70O1FOUE345AS244
 3KkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yfH/pCJMTrST/wceImF/j5dCJudgl9QIHtgFB3lv5Dl/FOfS5yl+jDEvacI94FfeL5PbbtUswRMw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTKJvMkkzwlyJLFUCOy9ODCu24Y2iAmB/lEjh1Bi2IqnTrcYmM
 wZYSSsItSXWDnJqx+zeQGdMoJJERJh3BQmoDAFk3p36rxy6JOX43czvJ52gmAXDPnVu+bkbHyli
 BFrBvq/cE1o7odkeypbiLTleJ8O572QI=
X-Gm-Gg: Acq92OH+LhJwRzob4yebcPYAcvjFqMtr+bjzYMq6o6sJPEBDHSmeK14GocIC7RIY/G1
 FHLRF5dR5UunJ1YF3y3pKRo0bjkSi2A1Z+LrQwIFuaROB2G7XUiDqTzF8zgqu6jqsAu233Ns5pT
 0bSb5o7BE0AnPUfGGXFnM/AF8q1UFUyecxqk6GIxjhSS2wZYqhZWykwdqmu3pTOTI0WB0uk22py
 D4zl3afFf5RJX+HWwDlM2S79Q6AIKlbX5saYps9ew3JDYiI5wyk8zwTXcBrjPaNKhTVMSe3onnd
 JWUZd5jtCs6mItagyuY=
X-Received: by 2002:a05:7300:e58b:b0:2ea:edc0:4fbe with SMTP id
 5a478bee46e88-304fa5230d9mr7590808eec.14.1780401557759; Tue, 02 Jun 2026
 04:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-9-clamor95@gmail.com>
 <ah6PxFtoJUWkd79P@ashevche-desk.local>
 <CAPVz0n0P7Jk17cM2M1zuHZfySo2=Uibr5izwKU2tqiBpBcg0FQ@mail.gmail.com>
 <ah65hfgoM67V6-iR@ashevche-desk.local>
In-Reply-To: <ah65hfgoM67V6-iR@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 14:59:06 +0300
X-Gm-Features: AVHnY4K2SWFA6Gct86VkeqymRy-YvpCnhDFWoUYjixtaQro8Ol55fBi-H9259ik
Message-ID: <CAPVz0n2V_a8Qf-yzsOipDRDtpH6h3ECJAXTYuavvMdj5-Fk=aw@mail.gmail.com>
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:07=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Jun 02, 2026 at 01:19:00PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 1=
1:09 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Mon, Jun 01, 2026 at 06:18:28PM +0300, Svyatoslav Ryhel wrote:
>
> ...
>
> > > >       if (kstrtoul(buf, 0, &linear))
> > > >               return -EINVAL;
> > >
> > > Besides _assign_bits() in the below, side note here to unshadow error=
 codes:
> > >
> > >         ret =3D kstrtoul(buf, 0, &linear);
> > >         if (ret)
> > >                 return ret;
> > >
> > > (obviously in a separate change).
> >
> > Won't happen in this patches.
>
> You mean both suggestions or you are talking about kstrotoul() only? If i=
t's
> only about the latter, it's fine with me, but _assign_bits() makes sense =
to do
> in this patch as you already change the parameters enough to make it bett=
er.
>

only kstrotoul()

> ...
>
> > > >       ret =3D regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTR=
LBANK_AB_BCONF,
> > > > -                              mask, val);
> > > > +                              CTRLBANK_AB_BCONF_MODE(id),
> > > > +                              linear ? CTRLBANK_AB_BCONF_MODE(id) =
: 0);
> > > >       if (ret)
> > > >               return ret;
>
> ^^^ left for the context.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
