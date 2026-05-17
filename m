Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D3BCD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 10:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABF910E171;
	Sun, 17 May 2026 10:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pB+krk+2";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2265310E171
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 10:34:44 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2f7020a928eso1707093eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 03:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779014083; cv=none;
 d=google.com; s=arc-20240605;
 b=adbASYhqz+W0QuyD9rGIolePzi+jZ19V+B08aJEw1YUrvQLVW9GZXz0o1OXwjwDhY+
 uDWRasQqkqs6uAEgcB4EoUn0N50I55e6qYz9cugluzTulBe/45/XR3zrdcJKGj81aAmE
 jJwPdq72sA4uJx1FFVGB2K+bh3CGoC5rMGSfD7v2JAhhJf24SsaJburO4GROM33icEHy
 2eAiNYs8e5gMP8SEuf7KF+zl3blJ/OWJ7OA9P+Wr+e28wUwDwvk9QXdVxMpM2cAVd10f
 zqbPy+MCmxE2TS+U0opbvXjF8eEi6htNKN6IgwrIm/a/t+5xSPggMrEFfU9Ugh+OH6BG
 wzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
 fh=nLtgGcKrw+Xd+foiDHbqWvzAIbY7cmxIm40gb1SR8WI=;
 b=RvZlxCLchukYXscgmv88Fn3j0q1yxpVdiI2iyLb//PA9kbm3hkmzpbDR0FhpFOcJbE
 q1esGEXO6htH8OTDmZXh7jkw4fleKzUk+HLq/+QPyc2mikhvb2OkfHcl9ygMtT9Iq41x
 XmVhh1E4DE/ZdMTBZZ45Csylf2TkGuSBWv+uBRKN+Zka5nyYqj65dKYd8WS3g6viisQA
 CKbE+B+YplF4n3Ou1yIUqx0tpbdOCy/q/TCIpMP6CAqJNTCdWQvfFTcV3IITV2juEFMZ
 5FOYn4g+y1QGyFql2Oy4i9kWcYW2z6BEyoG0pKyjqA+jj202VTl1fJbgKHtL8eH8k9NS
 TOTg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779014083; x=1779618883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
 b=pB+krk+2UkMprFAEG9MRR5GoGWyISAhREKW1xo70FcVTQtVksVyY3O3KulnaWEXu1M
 VArOCtN5Ago3c8jRT2fTKgJ6Qk8amvmTomaUT0Rl2TNT+jWoo9w3boxW9/drxUlAVE3A
 hay5aMLDB/ufpAsabRiE5szELgM0ThRUbaAgstQBPXrL6JYMC/oGGtVz3xx6gY0gS9Jt
 9GMdSo4pAolxxIn0eoIJF/ptsZ4o1cc6cZztidW6GHSx+tgCQPe/6E2pGUO4p9m4Rrma
 wXRQePfC3dQMQS4+n7mqnLJO8CVBl1R1/3drWlSAWp7KmMzLa/wvZukpiiS0eLQWclVI
 fU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779014083; x=1779618883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nTJbFc77QasgjHvHoJgTMqvmWisdPMyl0OLuKjBSzuM=;
 b=p4Tn5TVtPqHtzcvDrg6eO6qjQgDxlSNm+H8zeZh248/BxvK8YTg152+qTlH2HYpwGD
 wnftnjN5edoGM9rrXOrklusRipASNy7NdCeQjiOmaDmnZe6+wHpXEF0yHJu3sh4d4sQC
 2h3QLhXop1pEkaciY6gMPp/2JBPPWiF0qSCxi1lyPOdz9CPJDV4MK4Dc8JYOiDWElsSa
 P4uhxOCTJJv/NE1oaClR1VUCecNPpTwEQY9xz5vcRmbNL7pFJ9Fos1gQyZIq68MR3iev
 /XYcllEMxV2KiR1s4qpeo0VBBoZFhq8WXOmKX8ziz38/zYdidPV5jW3Rra0OiJY1sxED
 U0Zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9U0b06o2SG81itz37JZuei1iYHfEgqXBYGn6lDjttRgyXd7i5KXsmtpCuXDrzIgs5XVUqTe5a3zHM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxleIdBolREr7V8b2GrIYIDvOYL0CthTUe1KeQU0ce0X+GAfoN3
 A8yUBhbeA3Uzq4g72LHtVvD9xbJIfxhKaYQrtwsxkTwNeIfVcN8lRDfQhKf2yzq0oaFM9f7JE6g
 x1bD36WnmMts+aa1PQbf0YB+pQ12CqSU=
X-Gm-Gg: Acq92OFkZ4ChkwxKiWJFtbvcEwM1ayNZtE2wx0i5gpk/uET5eYtD4dgkJxIzCz6Zbts
 n0ZD3hUtKtHwDtEuwx7aDSYQrTjZt/X1SPa6C+614j/A0TCKTT1XGOUkRJA/0/B+SIVWGoz519x
 0svL+qeAp9Olf8CnoopceZ4gACO2AVt8ZV6pPUE0u6xypTOVSYUf+9VSyxlHoGrOzq+fwKssUxg
 KQFC6x7MsU8HRa1VP9gv42oeDgbMmIIM64LQ/iAtJJzkpgYmw+cjoeM/sDP+TIURFdEKyF1XHsG
 TMS99Zw7gGC7L/1/0vY=
X-Received: by 2002:a05:7300:b586:b0:2e1:e5c0:7992 with SMTP id
 5a478bee46e88-303982ac675mr4634265eec.8.1779014083372; Sun, 17 May 2026
 03:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com>
 <agl1T8O6kwP7SFZ1@ashevche-desk.local>
 <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com>
 <agmWVdi3TkBb2cxV@ashevche-desk.local>
In-Reply-To: <agmWVdi3TkBb2cxV@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:34:32 +0300
X-Gm-Features: AVHnY4L5_rkIuV0CHLrjLCbs5l5KmhnavBVglVDy6x95ohpe8OW3F3iZSgNhyEI
Message-ID: <CAPVz0n3Kn5VVxWxCgq2EcRiOaLWnB85hD+-S2Eou=H1PyycJCQ@mail.gmail.com>
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

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:2=
0 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 01:13:22PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
10:59 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > > > Convert LM3533 to OF bindings, add missing VIN supply, add support =
for
> > > > setting mapping mode and LED sources based on device tree.
> > >
> > > How is this being different to
> > > https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gmail.c=
om/
> > > ?
> >
> > I have decided to have a fresh look, this is continuation.
>
> Then it should be something like v4?
>

That was more than a year ago, lets start fresh. Those patches are
gone, though I did add many of suggestions from there.

> > > What about this comment
> > > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> > > ? Have you talked to Bjorn A and Johan?
> >
> > No, but since grep -r "lm3533_platform_data" * gives 0 results there
> > are no platform_data users of lm3533.
>
> Johan was against driver removal (while it sounds logical due to above) a=
nd
> referred to some other patches from somebody else. I think you need to
> synchronise with the people to have a clear roadmap that all stakeholders
> are agree with. With that, the split and other technical issues can be so=
lved
> during the normal process.
>

And this discussion was 2 years ago, and

"This device is used in a bunch of Sony phones and Bjorn A posted a
series adding devicetree bindings a few years ago"

They have had more than enough time, don't you think? You would
definitely know if there were any activity since you are IIO reviewer
and would be included, were there any activity?

> --
> With Best Regards,
> Andy Shevchenko
>
>
