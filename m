Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ED2CD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 10:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F204510E1D9;
	Sun, 17 May 2026 10:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fDDGHWKg";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1ED010E1D9
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 10:13:34 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-303dbfbec77so8891eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 03:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779012814; cv=none;
 d=google.com; s=arc-20240605;
 b=hHjO1EIAyYL+CJpoi5vlNZc58Ge/CKy52pqsTNcY4K9gAVrZtCyuuB9N2NdGBpnQMF
 lnGJHj4IIStB2q/CrqTof+aV14XkLuwZCPgxBtH3oJezC4tG1uLOovbrMUbXHFvNe+Pv
 iiNiDtmVZ6o0p4UEX7oP3roMxbbPoCO3pJJ5aoHZVsOKJkIzJMB/ClIQQmHwiStLUFiI
 3o5XDjpo/XQw+AqTwR6Zi4Q5TUfdqySi4M1PY7Ot5uul3BsHGgZ/oC/wDspol/Kl1qW2
 yhXfvFukrBCHHzIblIC7q4GmBxWBnBiD+SNXgxzNgu6sGwb7c4nXWEBXyuWvpCYIHJHG
 xR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
 fh=2GO0N09d2GIHdtCzdXUBm3BpabR4gL9rkWy7SRRjh6Y=;
 b=cm1HDT3E53Adbg5dCBsZdClDLzvozXszr7+zpPF16/HLwVLIbHpSWpZyTQoDwFe4G0
 5gDOedkwwDA0Jw3lspv4pLLbirM775dgsVzTpdX0fREEbvPgiqJmdqkF18x4rmYiphXv
 Ik6IT+TNLavpNCyAwjvR3KplUnGaLRhLRBfdiZm+BuLOW19Q+BMsl18EIZoacKnf5uWD
 2fxUxDMuTTa2Q3cHvEMiUc2L5WlEpOIc7SbjUQN07xQhcZbpVjBIUdxLgqhoJyDWsU4c
 onXan73mowurzSKLZhjCN2p2nyYIE5Nb6ZMLgkZtQDt3ADXjudXnQk7CRIb7aSM1zf49
 LChQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779012814; x=1779617614; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
 b=fDDGHWKguMvqERXeTt6JnMk1Xmv+3OuzboNclqYgQTbja4EMKl3WzO70lkOhAKWBgs
 k6FzLe45yF1uwhiGhLHiRFqV0SuEPnUBgmMeUMMu0OjenX5jwpqoxs4oEXEE5L1GwTJ2
 Cg46YxeVF3kiEdDyHGlXKGj0ur5QGfAN6W2fa/xI90vt85lBQnHtr08XOpzYqRylcgh9
 2zlW/uZ6vkuUkyvw/V7bBHYapnfG1c7V0r632uGQBIu2gCAEElvqIrIwGqdUdooDBj4L
 EZYqHiwIBLv9On8OFnXywml3eCBYURi/YtDafbhqR/vTl1T6vn8yhYW2pKjCu5IovgNX
 wpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779012814; x=1779617614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
 b=Vgs/PrqsBLtxn2DT+mEgwQoNw5mhUBJFOUtWwRw4RcHo0bqvqW5WYkQLstLESwsXJ7
 PgVoaIbD2cLFqzLEC9eSR8gD2jOIttBvD75buXYArjTNMLfa7U4Kb63aON8Pcy2ytKKv
 52Uo6zLHHiVySB1No9kMVdlD3ujw11A6C1FnrYuSC02nnfq9U+AB+pJF6Bi6UegKBdjT
 9dOnGKtu9EbnCjK9TwPC3WXK/g+5er5aRewMSDoYIbWpLUWQbnr5ZAz48Xb0d8ksoKzN
 pEYXQBpCfjXTXpcDQnGFgO5QO1daOSlW9MEfg0VHNPsYn7eXJPpQi5tdQyJnidTHWxmM
 JVwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/vTSxnWPVTYbCv7KqZCoJDI6/GQfmwCtvP/3bFnFLcN70MN7rEaN9Vcn5dIb/F0J/MvvBbPjsAEI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQt5LIupK0ZM+kxu118nJ7trsUF8+pzXKVsGf0e2ycM/zHstBo
 ZL4NWGR+Nq3l7MCb2FgA0mbvn+G2xxwm6dWMNBnklAPpw+XblwgzTFMwOIuG1dDDEHtCINPngRz
 hWUZG/f6uREXXwzr109YjfmaMwpLiYaM=
X-Gm-Gg: Acq92OFIsh8EJG0MoLsmHW9J7gVXXWqjS0wPf1Byil+BMvWygLi0wOdJDVDaguNOF49
 LYe8qr/KvwqeTRmiaBEElfDmo8kknUKUYNmgN7qUwgORu4tRD+Xjt9Q0CaHMrulEk+6XsJrBux5
 yIYtESaImrN9TZ+Kt22cnLeNZS1Kdn9PikDDABeo5/ILvqcSVdzjrmgzmoIwg+5ix9Z/5+8W+rZ
 6qrgmyIV3TfoBrLbxJUau80ivMU9Q31p5ZWuj5IgYreU+UllLit6QSgy3/S0ap8nNrtQIOdpckQ
 FoMb1FNtNhrThqwzqIw=
X-Received: by 2002:a05:7300:8b95:b0:2e0:1f09:d924 with SMTP id
 5a478bee46e88-3039813cab5mr5237843eec.5.1779012813884; Sun, 17 May 2026
 03:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com>
 <agl1T8O6kwP7SFZ1@ashevche-desk.local>
In-Reply-To: <agl1T8O6kwP7SFZ1@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:13:22 +0300
X-Gm-Features: AVHnY4IqE6FsGFbbFI5FSmJMlyOUEK62QOSOEKabbR3m07ZeyolRt90bM2zxkWg
Message-ID: <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com>
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

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 10:5=
9 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > setting mapping mode and LED sources based on device tree.
>
> How is this being different to
> https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gmail.com/
> ?
>

I have decided to have a fresh look, this is continuation.

> What about this comment
> https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> ? Have you talked to Bjorn A and Johan?
>

No, but since grep -r "lm3533_platform_data" * gives 0 results there
are no platform_data users of lm3533.

> --
> With Best Regards,
> Andy Shevchenko
>
>
