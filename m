Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19429CD98CE
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC6210E9D7;
	Wed, 10 Jun 2026 14:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bx/ro/ST";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE99B10E9D7
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:34:37 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304c520fe9aso2192231eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102077; cv=none;
 d=google.com; s=arc-20240605;
 b=dXjXT7ukvWnxV5bXNEsfU6Wc5oFdkM4CACTfPNKbCWR63YKpJwUXIu4Td3rPmHmcoB
 PFvIMR2q/oCOYQFoZacqK3R6ks1vlnqRjYcwV7GZsJPjVFYqv+M5fcnyejsDfFAc6YRD
 7q1g/w1E6s6M5gmjyyHcyLQ9JQJ8w6V7M8T5CiXfe++XxorO4EotZC4rjnfSTK1y8J/i
 mAAyIbLJXmw5/FyHo0tPM7j/kxUmnPxzQ9JR32F48GgaI4R8e9U8/b3lGRGj+WM1K7Gi
 GZ8vab0eHzjTWYLl4X3IHhNCraPwGzqTOXqERymsFxuRMYN5A7yUBS6yh1V/cZMXQZek
 jBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y4QsNr9+C2sksb8f9hiRst13xYKm9uscJWoJD0+yoDM=;
 fh=qRXm2un79Kcgwg21tp+pEglfA0gLrC1nY6dhBk5xf1U=;
 b=d/5rxHffu/4CQ7BjkyNqmq/8NxdKIuOjCsRilwJld7m9B7BM0oFUg0F8hb/zJjDyl2
 CkdaS8xnZE1xGHiHUmtxfE8eAa5Qp+RWX59EGXDOJWKlmSvukcbM/u8YRzn0Yk/uPr9j
 CInkg9yT7eIaoCYyhXIDsc/4l50nrtQjpD8GSNEcbsO6HCvn3I1Fn52iyUbt+chAoO3H
 cQSTtcVHpKA+LEyC0HAAG4dvzYMQJVsGgTPCaOhLpCVa+bbXSnL8dFQMCIBdlAx49Zzo
 BY5D2PgEybBczc6ZukTDKyx7VfbUJ8XvRplWPoJL4VAgPjaGyfJbPDkTI7F1G/QbAhrs
 nmEQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102077; x=1781706877; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4QsNr9+C2sksb8f9hiRst13xYKm9uscJWoJD0+yoDM=;
 b=bx/ro/STt/ANfsTgphNtwnSVe/Mz6HpLlnkruHvOuvgODRwnPOwbvx4JDseY3Do19y
 IF2cZTd4FJ+nWOXezVDsW3Uud/sQFQks/Meq6w1lfjL/lqOWUDIcoM7eTFdWPLTOwhwy
 2GO9HML+u2l+IFlo7U1RcbmYogClyr0aL6/7Z9wOaFgb3LKXeJvHiFKE1vvXVIxyCVvX
 cPViWyMZ3o1vkEv4e2ZZtPOTme9kpguzChAnv/QaCJsUIFnOZKjn4TNjlJBpNZiJdyYW
 tSGYprcuJiogw3KDYuLB0/k1guZJFoZSWh5HA5ejur40vzol53u3e1KjwFLAaC0o513M
 mv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102077; x=1781706877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y4QsNr9+C2sksb8f9hiRst13xYKm9uscJWoJD0+yoDM=;
 b=rt/Wk2hWwNCwDqCpyd0P0LyjL0y0pK1DkXhGNQfy0CIP/6CiQ/vvomAfW24dxCedzB
 oJAGv36WU5hwx8HGp1oHIuc77wCJf99P3OE8uIbxZsjfdE2XkYMz7vwKzo/0q++FAXNW
 7rFVHQ+uL4PAHO/mByIchX4UK7sht5u/Cvv6e1PpI+Rm/JjmcUziedKZVCVYNXr2yZsT
 RvfTzH8meeevAAo/delmdbEjdGumMWVg8YKGUasECsTWjptIllpvBuH5aJhPT8h91Awe
 1LZp1swO4/6nCZCH49CdQin6pkGvJlUgZ9soUGJfqsq/8Pw3lTv5kCKRtau1KttYJatw
 iB4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BBhzVWEXaHaBNFRWUkT150gR1BPRTs/SGOSMd+Y0wl4LJNFhu+ok6Nnqx5uObxxcPOT7RQn2XClE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNrIGhdIsVwwgY1p5wZFNJkPtLxtIMGoLWdMf8aUlt4t2BTD44
 kli415KEs1hPQgHxkT3TRfHLJzJ8nwMmYirkzPmd7qPgFVXOHC8W1J3PPn5Pgb5S/m2+dDel7m7
 LLvR51IRBHN2iVHps6LAczVIJdpHx3jg=
X-Gm-Gg: Acq92OGzAmYKxLAnxrHiDDg00uZQ3MPAXDntOxDu0WLz5LPXZ3Fj/s0vVlng4+vutJ3
 UhGs6PsXoK1a0bQijUfdjd3s7vLANwIiPhxtr3bLiG+1A8//DV1rcL4rlZL0D21cUEFXSjW2IpB
 2LzUo52ZOZTzQyvDL+CTS2aD+/7cSZshCdtJ4hnwc3lQokGr4ksmnSuTDI5dTCI058Ws+hD903Y
 z3AC3f6IPt+j5B/fr5c5zQXq9dve9U8K1J9BqKfHH89rqydZ60BGgUpOuyUb6KTmH60E5llsmBL
 bEMTd+wz2GhaNK3rGus=
X-Received: by 2002:a05:7300:4311:b0:304:d32e:65f5 with SMTP id
 5a478bee46e88-3077b7d84c8mr15465647eec.26.1781102076873; Wed, 10 Jun 2026
 07:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-5-clamor95@gmail.com>
 <aihkNekrgfu6-6Q_@ashevche-desk.local>
In-Reply-To: <aihkNekrgfu6-6Q_@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:34:25 +0300
X-Gm-Features: AVVi8CdXjWV2Xn6oo1ydHrhUl2T2tO1QvChE8BglKpS9ooBB10CdbUEM-do5fqk
Message-ID: <CAPVz0n2WG=35W7Z8USDck+xQ4sQSxkfhJR9oeYGe_vBkkXGKFg@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
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

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:06=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:28AM +0300, Svyatoslav Ryhel wrote:
> > Instead of passing the entire lm3533 core data structure, only pass the
> > regmap and the light sensor presence flag to child devices.
>
> ...
>
> >  struct lm3533_als {
> > -     struct lm3533 *lm3533;
> > +     struct regmap *regmap;
> >       struct platform_device *pdev;
>
> And this pdev is probably not needed. But I haven't checked the whole lot=
 of
> the patches yet.
>

It is needed since it holds childs pdev (dev would be better, but not
in this patchset), you cannot get childs dev from regmap since regmap
holds cores dev.

> >       unsigned long flags;
>
> ...
>
> >  struct lm3533_ctrlbank {
> > -     struct lm3533 *lm3533;
> > +     struct regmap *regmap;
> >       struct device *dev;
>
> Ditto.
>

Same here, dev holds either LEDs dev or backlight dev.

> >       int id;
> >  };
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
