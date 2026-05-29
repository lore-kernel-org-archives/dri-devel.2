Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55541CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F6D10FD3F;
	Fri, 29 May 2026 11:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F0d8Iayh";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7809C10FD3F
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:17:12 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-304545f5206so10569586eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780053432; cv=none;
 d=google.com; s=arc-20240605;
 b=lV03tQeSmLew0ZAyTAED6AyKKGeaDlGjESGZBwgN+qFaRUxq6whuGAwCgZvW5RWddT
 CXj7t83ttEsQHf6BlGiZVEWXWpyi4KGcBZmD1spHHV3jdMQVxtPn+PKHbQ1iGQgQFkdu
 jqpYBEB0PaqvK+FmluQSncjSSx7excEiDJ+2Lh3lAaxX7CwCtMQrltvY7cW+84eC05R1
 xx3YnvCBy48pgvgrmmIGZ7H0gVcZR+8bAIg1p71EYnOE0SuWiosIw7s4+NGO9yUcPGl/
 fLh+i88UWdekS6nT/UIqAw1Huh91ubYF7JUu3+ZlxHd3l8xedZMnrjScMdXHi5w5HIE+
 uuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
 fh=IkOm5FystgVG9bglyu8GuAkI32UW8vk/EfwKLq0gpS4=;
 b=hFI6ZeKluy/dMXBuiiKE2WsR+cAAqLNdUyxr7ERUIj8SiMD7HiliwVqKB2WeSCry8W
 LkiuDE3Yd0+Cd3ttxZf0/9l7WnyVwqF2r4W57zPcXrpRnFIbnFFBJ8ITOQbcIZi4MzpG
 otkngkS/xw4G6rJXQ+joUFzw95QzrEYKWGraChu6DeHRFBexXcKV1znmuOU68VbXy9SC
 0TXFNbbxIeYwLktLqVVaNyU5+IbOrDR4x9gTTyh+J/FDMuYK5kqjIp/Uz5QuR2oRGH0N
 +8jQgr5LBKwzmDnYxj9N1oLPLaude4qsE7Fg1N++SeCo8yOUSXNx0W6Lpkbi/Rgmz1+s
 ZVVQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780053432; x=1780658232; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
 b=F0d8IayhZY0/OTmPgOARljs8Kf1Qip9mStZ2TELSC2joww4qzapyjpq+hXutbaL4DI
 S6wz7oLL16v+JE/Z0naT2Vz4wodm/GrREAKT8efKxuk0tcHFSukBOC2UV9qX3tu/LVer
 zxSxDpRfDN85RekyuispeH5jUiL2sV/y3N2qiUfNQ0Bepdy9r+TyfpXhpPKDmw7ilxSR
 dmE8ye2V+Bn9kis7Byh4eV8il4jefU9NzPZRVREdbVwT5aJrMvke+Ecr0zOox0sSRfE5
 QuG1VyAUT/944Lsk6XlIXS9SdR4+8PoWueuS+I/UWA9iMC55S5BuFGYnPWUBwqPjXT+U
 fjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780053432; x=1780658232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
 b=j07SnOWYNzXU2WP8H3W2zhsKsY2WVE6z+STKxANgbpD2t3Hjutxwm3q9EUlvSYeBwI
 Klhpub+zvGq2hBtld+uDnnPphTjEXH5fQ/1d9NIlPA4m+sp1IosdYTWq78mc426OfAbU
 VAtodzdk0D2wFBZg3TAKFtDfqTdGZnkv5aj8EbkWWfHdvSwahS18gAO3ED1eQISfKyFJ
 HQzTH5dVLwRIk+SYND99ICVNW5Xa7ueEkwtDr1rF8lyUuZhd0a2bzWHqbeg9d7y1qlui
 1uJXDf6019J16F2uNm0HHjmUwtDNyn7/7sAhf7+F9plyT2erY1r6dsUfv/zu7RllkJxH
 qi3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dgIXFBqQC3brbovpb2cTepq8yosECQbAIrKwZsGLEaPAyxhurVnYLigICrMB6cAgG18qaD1EjqJw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/WqlZ0chHyBXDJI9OUHaqq64FTX4B2JYCvRvYbhTBi2vZIqZd
 MN85Py19t5TawfmmYso22HHiulM2sg6G502JCiPfXXMPgSK10WAlInPFwD9PsSLyEqc5MrjIU95
 ANdmUUMAjfNFhNDT5hAgVkGVPK1sE/+Q=
X-Gm-Gg: Acq92OHqO747JFYlGS6CR9rFZB1NBsaNtffuViXnbwSLCCm0KpPj4kZBZwGnFIaSgXF
 wuGCaYRfU565HV0QdW9XcMNdKigdsoaprmMlDlikflIl0z9cONfSYTPFPLfAaQiYbWM6DLGZrGC
 c3zjIG7nZOMPAfR1SY39hPLsJBIN6wpSsosYDz57ywSwr1zboYiD3sR7X16Lui4pox3qnyC/gWZ
 Pp+V3e7IzXMcpEOYcMNv5HXgm/XQ7MFWtcyK0DHjoV3+Pr8nDDhrznHwC3nHvsxZSVNOTZpkiN3
 0wcmI8lkgJaPVgEuxRM=
X-Received: by 2002:a05:7300:ac81:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-304eb17ec82mr985940eec.19.1780053431705; Fri, 29 May 2026
 04:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-6-clamor95@gmail.com>
 <ahl0La8OQHXAlV3m@aspen.lan>
In-Reply-To: <ahl0La8OQHXAlV3m@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 14:17:00 +0300
X-Gm-Features: AVHnY4LHdqQWkZI96KeyzyHPIcreHN1kHpCMC5cCziI3ntwRYA4WURCN1WE3agw
Message-ID: <CAPVz0n0kpYBACOo=YyNk31KGwBEoyrf+dii8V6QY4iRCGd2PNQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
To: Daniel Thompson <daniel@riscstar.com>
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:1=
0 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, May 28, 2026 at 04:51:22PM +0300, Svyatoslav Ryhel wrote:
> > Add support to obtain the initial mapping mode from DT instead of leavi=
ng
> > it unconfigured. Additionally, update the linear sysfs code, which uses=
 a
> > similar coding pattern.
>
> Words like "additionally" in a patch description can be a sign the patch
> should actually be two patches. In this case the patch would be a lot
> easier to read if you cleaned up the linear sysfs code (patch N) and then
> added the new DT logic (patch N+1).
>

I looked into this in reverse. My goal was to add DT logic I don't
case how sysfs works. My code matched with what sysfs does I just
included sysfs change as well. I might better drop sysfs changes
entirely since with such pace this patchset will inflate from 6 to 15
and beyond.

>
> Daniel.
