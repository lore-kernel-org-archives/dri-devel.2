Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B560C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC4310E85E;
	Tue, 14 Jul 2026 13:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p8cARWYq";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74AF10E85E
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:28:37 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cc891373e0so51219815ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035717; cv=none;
 d=google.com; s=arc-20260327;
 b=cYE8FFrmYZ3ghwa3VZF9EinEgMCqZ+QsAvTQVTekUu2xGAFePKIsz/L9WKqrVh4Bw1
 C7MEJchOm3Fz8oOIdnVroT4MSzyz5BIzjHpb+tlteQhU9Zne/t0OuurvxkPzLXwkfWzd
 uFS4lXyBd17TKuyfFB4MaF/xo0dqg/0rV++A6A+FoFAj0TLnO2pqbYVY40zz2Q8opkBg
 Vmx4KDzOsuuykd1ZSU4bCcHJTbivE9KMSpee2FlTX8QpyDJBIscDEvDtrWnSuO7z3oHQ
 KJfI008nf2lQ+fTAQkIE66G/Y/Nwu5sSAZGvJCpxl/FxBaKl2l/cECBYgLqViNRZ4cLp
 XsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
 fh=ED/G3VF0t06Q7LNNNTYAh91cmJ4xjH7bfdXMdrcZU8s=;
 b=TvQcmpP4nSESJyrI2L6UCNdUwnNQ8xNyUniTa0LrjsJsqwm8MRzdVOdFup+2cVjGrH
 MjwTJYpcEebzptYIuaRZXnSmFakODqMxFqDdDo/C65KSUGR9xEaIRxB+JnvV9JxO3lMf
 Hd49espgGTm+nUKcR4xiXdqCF+3GxIFaxoNedqAs+pBCScrA9QSkQGC4o3fIbDAPf+q3
 /zZetWhK4eMMbuf5vMFdgswmRLE1s4tZkILHqClVwtqlpWu3l523MYLQYGl84+pzZa4s
 Bo+bAv2sOx+KQtOYcE6QGYT/K2Fx5eOflheue4ZpCBPF3GqrQ18B0WDfyLX+5+9sTsxa
 EMig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784035717; x=1784640517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
 b=p8cARWYqfEF4TdYrKxImLF2waH/gK7Q7Bn88aimwFHtmoKtdW5VHrqOBsoF5cU4Wld
 6FzMTwUPc6Tho6b/yel0+or2wZ+YEQZ84FuoPNpIBvTVwuG0gbtalWHoAoX+tN7X92Fu
 8cQxfLDVrMKJs7kIAZYJ6bs0bmIPTY9Dcc1y8BEpOO1BXccIkZFhNP0IrAEvaYOiK2Wk
 RuhcNq2Q8u1/AXhdrTCNFBRbtoL/Zsgea4KlsQpsnRB85wtEUmJjrxlDS1xxQkGrKxEv
 a0ZXErZyFZXEWNUYE/5pThrrwpJL+SsnEoCAAOHdO8ki3Xw4P4oDz4om9t/DviOs4xly
 HjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784035717; x=1784640517;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
 b=NYwxVKQG8HWci4n4I6xpWKjCNo7DRT2/J2TT+1OMWZWKqiLyWcBCbWnuZXOZbYW4Yj
 apthsgaN8y5PQPX/PTyhZwYc2IHSP3hYuSwMZqSUsW52kfilrZjUuVXvGnCIwx9F0qDA
 b00U4tJdkkSPxm530kxG28WyWiCNZENaqv8jN6OnWJWARxTphvd5h2L78+uVWSncJGwQ
 W4hdSoV41B0lrhwSOH+fFbms89Ejf16fpxBxq2PufBTFmvFidHICIGzEC9+B8yQWNhix
 1QM65zORTmLzcVbuHhUBhUtZtYNveQAIlYmcB+J4PQqiz+JetQyf7tsTNBy5msBsY5qS
 sVgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNNg09Zp5tCQama53yS3X79Q6bIG3XQwAENrlQBDDiDpJHPdJpvhLipvyjrWGCgu04ucXavKm6Ekw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSyJ7Su3e84wFcdBLsqL3WAwBlWbnFq/zP2UPD77bD0d2eL3vY
 LNHNL+cM40hGg46XZgYVk/VYULIY8A52Rc6sOLN8u9tAADde68AeQgZLg2OXCewl8rCuJ3eBRcc
 SDIpNwzs0wuS4ztJpLbWjeRBHr4WpkuuO4w==
X-Gm-Gg: AfdE7cnHZrjPPG7DKBQ9QzuBWFwmiXFix8seb9qtkWcNVjV6K2VrGB1rHTlhF4qY0AZ
 eGEIUfWjhHHEvuEUgLDffVg1a/qhVSz4uOq/Sj4E/D5uvDinBBcpnF01faxRKxfyW0uT4d2FFnb
 nJwxlwDuv6opncApO/zmcg+VEU2zg1cPC3P9aLecF6dS22MsGq1qcEo4PHwoswbagGNRz27m5bu
 uILtLpoErnOyqdXp3Y7+wzwQaCAQNXEF8BHpJREvQ3OTGqr/cKDBYPAQXSOyS0Hu8ojxOygLSGZ
 qeZG2wOdjpknVFEXkkZtvlh+vRZDgA==
X-Received: by 2002:a05:6a21:7486:b0:3b4:b6d7:a992 with SMTP id
 adf61e73a8af0-3c11062f70cmr15032381637.8.1784035717203; Tue, 14 Jul 2026
 06:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-5-clamor95@gmail.com>
 <akeF_VrijPbebz3I@hovoldconsulting.com>
In-Reply-To: <akeF_VrijPbebz3I@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:28:24 +0300
X-Gm-Features: AUfX_mzREZozvqJIpCZw-bv1kiFlmVezGQdepbPdfuQMwUIt-LOogON_yq372Iw
Message-ID: <CAPVz0n1+wrq+g3p3UTc3hzHcsz8k02=QsvmseBD45d+SoSFsBw@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
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

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:50 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:21AM +0300, Svyatoslav Ryhel wrote:
> > Instead of passing the entire lm3533 core data structure, only pass the
> > regmap and the light sensor presence flag to child devices.
>
> Again, why?
>

Because none of the child cells needs entire parents private
structure, regmap is all that is used.

> Johan
