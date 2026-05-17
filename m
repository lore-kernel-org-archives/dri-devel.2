Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAB9CD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 10:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6775610E1EF;
	Sun, 17 May 2026 10:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JucIkwBh";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75ACE10E1EF
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 10:44:54 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-303dbfbec77so21237eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 03:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779014694; cv=none;
 d=google.com; s=arc-20240605;
 b=GjZ4RoF0cYseD54+5h6fON4UHiQbR2sMXVP+xRmoGmXWO9BY6C4RQzIJFXlBnkuwy1
 Ru+Bpnu/W14UOwaRQxGBhfG8iJZWwJl5vCix5VVFZIafj8OJ8CtOBCtTn+bXJ1ozESjf
 F9bUuetAweXXY3ScHImBYSNdr2UNMDL6E4H72m99ycr+Pawy5dm0/H0dH2yPoH126QDK
 vHfp/cG8kzlU7nM64qAlIygsPx+UkiKByHQNfD4W3Pon3wJhS2d8v/xE74TD3AKH5jT8
 muSDl7aCf4PboU64FOCAsyaQ8kYbtlVZI/hAqMVJbMvVKSpOULKzVuQrqpqmQfHX+pBo
 vwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
 fh=qY23fWydF8s32A2QmP0eQ1uYBaMmDfNeOPoeWak6nhc=;
 b=I6AdS9f0Jf+cTW50aHJvFo27Ni/kdxjVctWstUq9Ghi0DMvyS3KSqZEPUjWKRk8ARD
 asa2CpMcAmC2woNcWn2OlF4JRSIOnaSSLjKjxtLvKA9FcRhZwbmX79pmsU8o4B+Cht8N
 dAxpdM47ILHXzKw/RzjI7CAhNgdqeE0eezPED4D6a3uaOqLwJbsu1j37rP7FlGzeujXd
 2dlXX3UrueoqX/gEp46ElMjnLwuFDUj1fU+dewrVzEWYeihkYLLeImpuqGy60AA6n3dT
 wWvALh4vrBnBWatqlTlJacNUoP22xjONjTF9I0wGT+E0FP2jo/8JloN7QVJw2GO9Ok9m
 H2Cw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779014694; x=1779619494; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
 b=JucIkwBhlJ0C2RPGrKfaO8+AaKyxVzVtIxxr77anhIFX0dZ5WTFyDXh2Sle3APE5QC
 hHC/2nGijDXum/b5/bPYuZCZsfUry4vgDEiUaJ03m1Tg/W5QjTceJv3LG6teUpzk2O3e
 i5m20Pe1h6pPT6dx21TQWQzKo08VchEGd+iUucDnvMbGrQTD2VtgmSGje7/2oT9bqStX
 1HA76Dqz4tv3nDAbgHJKfSdmF4xgWT2UseGBhijLxwfMrlfRtnFXN6Snt7LivZF2VZEy
 T5VDlcmuI4iq4mg3RxoTHzfaV4vIpA6QHe+74c091BAJm4DPYR/6SSJMJqS+sdzPxrQL
 dDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779014694; x=1779619494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
 b=pVXFhS50gBqVDJqS8HSZoB9hpcYpb6TfqaBmL+J2DQ7hN88aworA52HjRGP552s7PS
 5EVD5Xh1X+uZUu/hVpTvGNQMqsgeixsqEr82qA9V7TTb12ZxD9YFaxZ7M16DrmuzE6xa
 v78hMYePRqdW46M34U2M2BtAfA/tTZtaGrT7ehbO7/iYklGxUrKjYjsad9tU157g6j8U
 NEqZ5f5rUW2x8js3vhsU233C6H8q6EV9EhGRRGgVoNF41Gmk+No50SHCWSE/GWBXammX
 rChMonGh6Ap4mTyst7m2IlI4HtUodmjfv+w+uBtPBeoHY/oSUeNrh65w1b/EUCfbCs6+
 XhMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8elNn0UsrjqTwNB8vtdJZCixLfDaTxKPsbybK+W2RhofOpUVgAdr81lXwA5atPodIG93Gi5H2w2d4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3UYZYIOTzvch3h9Husv2lfkyyhnMnmZLGP+KrFw7dDjCHhzy6
 xfVzwxIvrpd1Md6Dr/krAGd7EwtJZyjIkMiVjmoyBO6CbHmlFRG7Mv0x9hzEG343xleYs5Q33xt
 8eQx9IsRdd40Q0WDGEMYjUNkX6RoUEmI=
X-Gm-Gg: Acq92OErn9kh4WN/KA4FqTKzg1uQ6EZLyQ/rj2nLPVn497SnTfc8wgrTWRK/lBICcmR
 65jhHeGCcnbCX9xDPjag5xL5cFAIeDB2HIDcY7HqVY5eOZ0xFFEOQDbFGevmOPPbSzTsW7wF3xX
 ft7xus0ZE99RUSQ3yvU14tfpYYZvH65e2iOD5PlyWtN7gjtRXiZpQzjka7B8NW+j9k/uJsHppBW
 CbhvMSC9pdSDWf1B7u3eKvtY31iwXPWxiHGAV3JQRJUKu0vU1HXqu7dM4idzfsEV5bTcSShac2t
 EIhQWEQ6Gm8T8+zSq0U=
X-Received: by 2002:a05:7300:641b:b0:2ef:83d4:647f with SMTP id
 5a478bee46e88-3039865213amr4762888eec.25.1779014693685; Sun, 17 May 2026
 03:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com>
 <agl1T8O6kwP7SFZ1@ashevche-desk.local>
 <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com>
 <agmWVdi3TkBb2cxV@ashevche-desk.local>
 <CAPVz0n3Kn5VVxWxCgq2EcRiOaLWnB85hD+-S2Eou=H1PyycJCQ@mail.gmail.com>
 <agmbFQHezUl5Nydn@ashevche-desk.local>
In-Reply-To: <agmbFQHezUl5Nydn@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:44:42 +0300
X-Gm-Features: AVHnY4JnKOSw1H09HcRgWGFJYaj6RZPBdJ63zUWme_H-q0TpGJTcjfCXnVmnBUA
Message-ID: <CAPVz0n2VAUBNJOLXiGEaRn-x1esd6qeheXa=Br69cZnqmZ1QGg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings,
 improve support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
 linux-fbdev@vger.kernel.org, johan@kernel.org
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

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:4=
0 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 01:34:32PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
13:20 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > On Sun, May 17, 2026 at 01:13:22PM +0300, Svyatoslav Ryhel wrote:
> > > > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 10:59 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > > > > On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > > > > > Convert LM3533 to OF bindings, add missing VIN supply, add supp=
ort for
> > > > > > setting mapping mode and LED sources based on device tree.
> > > > >
> > > > > How is this being different to
> > > > > https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gma=
il.com/
> > > > > ?
> > > >
> > > > I have decided to have a fresh look, this is continuation.
> > >
> > > Then it should be something like v4?
> >
> > That was more than a year ago, lets start fresh. Those patches are
> > gone, though I did add many of suggestions from there.
> >
> > > > > What about this comment
> > > > > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.co=
m/
> > > > > ? Have you talked to Bjorn A and Johan?
> > > >
> > > > No, but since grep -r "lm3533_platform_data" * gives 0 results ther=
e
> > > > are no platform_data users of lm3533.
> > >
> > > Johan was against driver removal (while it sounds logical due to abov=
e) and
> > > referred to some other patches from somebody else. I think you need t=
o
> > > synchronise with the people to have a clear roadmap that all stakehol=
ders
> > > are agree with. With that, the split and other technical issues can b=
e solved
> > > during the normal process.
> >
> > And this discussion was 2 years ago, and
> >
> > "This device is used in a bunch of Sony phones and Bjorn A posted a
> > series adding devicetree bindings a few years ago"
> >
> > They have had more than enough time, don't you think? You would
> > definitely know if there were any activity since you are IIO reviewer
> > and would be included, were there any activity?
>
> At least it's polite to Cc them your version.
>

I assume yes, I have added Johan but there is no email for Bjorn A.

> --
> With Best Regards,
> Andy Shevchenko
>
>
