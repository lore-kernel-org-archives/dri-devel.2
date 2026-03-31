Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951F310F92E9
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F8310EBA6;
	Tue, 31 Mar 2026 18:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k7UwwFQj";
	dkim-atps=neutral
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0912010EBA6
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 18:41:57 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-38c26612508so49808741fa.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 11:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774982515; cv=none;
 d=google.com; s=arc-20240605;
 b=dqa+Fb0h0I/Fuohnbjd5ec6bpIVcROS2H47X/IM+vA6VTPAgZjbWp7nLVyZ02AnrSc
 OHCV5AjDst8/ACS/GwkastpCi9wmYryDenfFBSYwbPmSzfSlDT53cgntCY40rWzGHeuN
 5/4K7vkDzzB7KGL8p1Pl2CR6RmIo2/mJkSM/0ApfGJ9Ce7u4VKC3jRY09RgI+0dXAPn0
 Pub+RjvPLKozkqqSY4yBFlptGp28orUpdtMxTzW6wq1+2aAK/+5zSfgivD3zh/MgfCU7
 8G0lx423mDJEjbsXjPiVyz5Vg+gl5PoCcVz8hwIZ9ga5qLq5a9C+ztB2yatjyruCprle
 7NEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LueIi/8LFIpJS2kk2nmHhYDXoRTlURY5kQyqGLWB0V8=;
 fh=PbaKprFhWAqg2W+LcCSbDvlE1AW0ToshOvgzXuIMM94=;
 b=dfFS6do4A+8VpZ/fNpE+EnDyF0m5vIJseZS8XBW5YI2ptAsnJhonwVMZ3VINdBKcxg
 HmwkIfEcOzYrka6v+SMgompCZ13T+NJrmw0mE8w2feh5NqW2/Pta6fXfbU9iccayFKXN
 s1lxqHrAJwkJYJ5Zxp4wwT209bU21/fbIoriW95cpkBUt8R0veo78fvcYWUG3FU7vqOs
 Dn6lWEV46Hb51GmfzJnwt4I1CVDa3MODOhOc1vTmHZF5VZf9BffCg4RariRecFI9axEg
 2iYDA9uzOgs0CariffTLNanXWO+XomvKn7mSrInuXN7DdaxdCbLAcH88xZfYW5eBMswQ
 ruhw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774982515; x=1775587315; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LueIi/8LFIpJS2kk2nmHhYDXoRTlURY5kQyqGLWB0V8=;
 b=k7UwwFQjFlH53YT9ylO5NspxX2q4ZnzNSo0hyVc4pm5yQtbA4jQDB4hCAz3r2rD61b
 k2/c7dUL4TyeMIJvZXr4PJqwg8x6mXYjeBWDAyLkzLF9frqTEiYHomzgfcvUUAcm30Z5
 KX9jam4TD0coGQ7xb9YMG+Q5DTph4l9BruFwk2k6CTXnpPCBkhj0FXISMACB4HLDYK6y
 cVhj+Qiil6RNTQeySCV1APOQgMSpg4TgnR/ipm7Hc0Wb7AKzgl0t91zaAi1H8jd6yJkA
 TOs77AyNnOryCrELRwXw7o2u93tMNwQyAUf0ZdXsUQXnLXBOQM1v1Zyl7o/2XEGu4h+l
 PEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774982515; x=1775587315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LueIi/8LFIpJS2kk2nmHhYDXoRTlURY5kQyqGLWB0V8=;
 b=lUmY71njJfC+PDjHZMGOIYfBmw3FzF/w5htNJYQf6PrsTaUa+3HYLkMtSbUpCqMj1Y
 Qsfk8OhtEhJ/SVf5sKgnPvnwOe+uJkqNUE3p+mLp1snCgmpxIZ4wp8l7992JnuEHcX/j
 KGDdpSYqL9LUk8lSu7hth4umxUH3j0F+QaeXKwqKZ8cuSry83e1do9G9PN20CIoPbsNw
 UqpH0gF+tKR5I8bfL5yu8PXcAF87W9GyYwrSEAIDdFZ1DE33FqZ5uF/2yWUyjOUtSUMD
 8r6Ed7VQWbP+MqZHRzIwqfz8Mqrtr4063GFCBdxo5LA2NIfPmJs9UWlbQckQfSPwivxC
 oCBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEGqi2/xPJzOTQmPeLZfxqD1kFs3Ejq2mdlFVEbkPNE6J+KJzbm4TR43UxYn4aDePTO8uybDD64Uo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxzn1biWduirWxl5HOF/uMj7cCdy3wOpkK13w6WIqgbLCo+C0Ky
 XdgtlLY3GdJUGi0z966SQO1oq4lyWwHvwOMNkkQiJ8LZ314VOiIbFtV/IVId4FSxMB2vrgwruHv
 9f6+2/euyWBSAtC2EWuHLUD4at47xZHE=
X-Gm-Gg: ATEYQzxtf6TPFxeyrhPRvZOZBOcWF92UKJsYSFMErsLeBWXjKVvkyDYEv4Rsm1CXwVB
 f/hW83no8OVJUThuHOhLKTe5KrHdk2C1QcQspAaYJC3D9AMefVcna0EFD1FLHbR5ingJwNJqTf2
 h8nuLOYMU+0a+OJ9sTU9+1rzTipxYQ7dZDpEVFjKt4BpEWYLHagmFIFQBraetikcIouLsCEoJ9U
 U8GqE1/am++cbOr6RA1jRgp6IlBe9lRUcdrkpyJM1Yq31DGCHyVvrX11CmgcBeYZzKGa56UD4EQ
 W+aRIUdkMWUzpSzew9+EwPx38ra6wK7KexFKwEbAyZCto14DyQoR6MEsdaC/h6HVTQ5o3ZeIpZT
 v38M=
X-Received: by 2002:a05:6512:3f0e:b0:5a2:b304:e95 with SMTP id
 2adb3069b0e04-5a2c1f3600fmr200775e87.45.1774982514815; Tue, 31 Mar 2026
 11:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260323-ch13726a-v3-0-e28b6f97fe80@gmail.com>
 <20260323-ch13726a-v3-1-e28b6f97fe80@gmail.com>
 <20260324-dexterous-snake-of-progress-ea8783@quoll>
 <CALHNRZ-TAQmcwYr9iW+j+S5Egh11C0LpPeY1SO=hgDdvG8otqQ@mail.gmail.com>
In-Reply-To: <CALHNRZ-TAQmcwYr9iW+j+S5Egh11C0LpPeY1SO=hgDdvG8otqQ@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 31 Mar 2026 13:41:43 -0500
X-Gm-Features: AQROBzDmsVsXdGNm4Y8F0yD_afgM04AELEWNE4PydSbgn0g84rsHOPHgyxrQXfc
Message-ID: <CALHNRZ_SnMmqLU-Sk7hVJOukPtVxdg1bQ0FncesXUJcxQwPV4A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add ChipWealth
 CH13726A AMOLED driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
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

On Tue, Mar 24, 2026 at 11:01=E2=80=AFAM Aaron Kling <webgeek1234@gmail.com=
> wrote:
>
> On Tue, Mar 24, 2026 at 4:08=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On Mon, Mar 23, 2026 at 12:08:32PM -0500, Aaron Kling wrote:
> > > The Chip Wealth Technology CH13726A AMOLED driver is a single chip
> > > solution for MIPI-DSI. This is used for the AYN Thor bottom panel.
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  .../display/panel/chipwealth,ch13726a.yaml         | 65 ++++++++++++=
++++++++++
> > >  1 file changed, 65 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/chipweal=
th,ch13726a.yaml b/Documentation/devicetree/bindings/display/panel/chipweal=
th,ch13726a.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..5d964900795653401a871=
994bcf6403cdeaad64f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/chipwealth,ch13=
726a.yaml
> > > @@ -0,0 +1,65 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/panel/chipwealth,ch13726a=
.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Chip Wealth Technology CH13726A AMOLED driver
> > > +
> > > +maintainers:
> > > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > > +
> > > +description:
> > > +  Chip Wealth Technology CH13726A is a single-chip solution
> > > +  for AMOLED connected using a MIPI-DSI video interface.
> >
> > Here you describe the hardware, including what I asked last time -
> > explain why this is ayntec thor panel, but not chipwealth,ch13726a.
> >
> > Then also name the file as the compatible. If you do not know the part
> > (model?) number, then why do you think filename should be called
> > ch13726a?
>
> The vendor source release for the AYN Thor calls the 'panel' ch13726a,
> but per the data sheet for said part, it's a chip used in various
> panels, not a panel itself. The handling for various panels using this
> chip will share a lot of similarities since the chip is what the
> kernel driver will talk to. The alternative would be having separate
> drivers and bindings for every panel that will be mostly duplicated.
> This is the case for multiple things supported in the kernel already,
> such as the vtdr6130 which is currently described as a unique panel
> but is in fact the part number for a ddic. And I will need to refactor
> that for another device I have in the pipeline. In fact, all the
> device panels I need to submit in this context reference ddic's and
> not unique panel models. I'm waiting to see what gets approved for
> this series before sending the rest of those in.
>
> If I add something to the description like 'This chip is not a panel
> itself, but is used to control various panels', would that be
> sufficient? Or does the kernel need a new way to describe ddic's
> separately from panels, since this seems to be common now?

Krzysztof,

Any response to this? Or do I take another guess at what you want when
sending a new revision?

Aaron
