Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39AFC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EFB10E6C2;
	Tue, 14 Jul 2026 13:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g8y2K1HL";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A2D10E65E
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:27:01 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8485b358552so4731548b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035621; cv=none;
 d=google.com; s=arc-20260327;
 b=ju25xUGYO3M6bjWz8LpHAmW8jXZeZPWVp27WJir1Ay0lEABAZSRszAjd46ez+M/oAI
 KcFjUNKb6wqCMBHL+8XmG4kuYEgAEbSHPkCVVwHrW5gslvJQYJlOdsykq/93ys4OaQPp
 jJIt0OaMLuLDT4KoPqEf4Lhm60OlG/zk8EyE3cDC7w/x4znKT/lxtGy4ux0Zqw1afIe9
 G+i7I7wdkkHzLdFvq278z3FJpddDfujD3fkZeWbj0cXppXuJlj4RwvRRkKG3Uu7jnDN/
 CbvAYL5OJuG9eqLKT4T5Dkpj7nQGXwXCaqOibb6HGLicSOFOEH2HGfFDZztWckHBzmQ+
 htzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nO1TZgVYGZMERjIgcqsTAqDB/ZWtf6AUfRwRoLJPVvc=;
 fh=YMrqJd0ZnjY1AdNNVIvjYPkE2a25ya626VXkf4XufdM=;
 b=ZegZq3vmvODjJr/nfPUDnKsMz5SvJe6KKPbVUqXUtMweM2kypazFHKntbReTamU36i
 wOQTJ09nEIQPzPIR7yMb62fOUzHV4yc37R9N8/Tr5SQZQyLmQfoyoAxOFNW709560VwB
 lCDlJ/ZkBE9vFi4TCmR2HEjfPvKIPTPLfbvAFrIap8KlC6/9kmqyK9bn4kn2Y7IVYEBm
 lJ2SeG32DxXb9dWUfmhzU5YZ7L8fayyaXjvCDLpIxjMta3ph0jB+rJ7cka/dOOm2TwKS
 isY7/VKOfvV/b69x9qEDBR0KsnznUJBBIOZjFlWaEhzEax/9OnWQ4K3qhsWuqmcaZ3Op
 UkPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784035621; x=1784640421; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nO1TZgVYGZMERjIgcqsTAqDB/ZWtf6AUfRwRoLJPVvc=;
 b=g8y2K1HLEy0YXUlTmQIe2f3rueZeGyz2pIPcAHjjH8tJBPl43Xdc18OXDHuxpTW1Bz
 webifqVBulkTRRmCnmGnMI1kfqCtVqpH9zanOEsmrhPDPwKD4KznYCfpVcjO5UnrYe9P
 f4pKERGFH1x6UXLoRPx/VLmIELDETPtCk7MriB7w4Nz5yfIwhqY477Mte18EhF8z6k3n
 BBxyKcgPPsoO0p945jiKKnZrCzFxPX0eZgZOtJX9Gztuzs5A5IcvWyFb2Gw5hrOaY52b
 9y1u0lVNrdjPRFdwT30jdOhSY1T6yhd9t9GQRYtfsTYGw0EJIkNQ7qLUeWwqHsRz72Vn
 uXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784035621; x=1784640421;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nO1TZgVYGZMERjIgcqsTAqDB/ZWtf6AUfRwRoLJPVvc=;
 b=UjEAypqS4zhKygSOHZGvbYOYyecSu1DtVjC+yEM0qgT/bxQv8d+4svFc/7i092FGvJ
 LV5/TqIDCWKy/LEQBTwVBsJgp51+ZkelhE5R29Htvq8P7My/u9070bcDPAsfY4dAoqsd
 fj/LLtfaGzhqDEIWC1SpWJwaT7IuZsvvxlTi42dcnbmfEPCas3iVIA4CEgIu6MxJx4U6
 2oI0t6w0uXRCfpwe0VXLEE4uw4FV3YD49z7p+slPDTW+LOiSRj1dt3TZ5I2lwumrTeWt
 SIOMpVgfgqh/GtiGBNFGNc1HAmaoDN9muquBvZrid0DsN7mKPbVVCNgrzoaRArfyX2sz
 VF/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxfMW2hRN8hc9QSKj87PxaSElZzWY2UB+s5V8nWy07U17qxUw/WHGZTi1ZA9rcPdqpcpgP8WmiY3E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhzwbLdsuB0fp52IeVZdQ3Tbl1bBl0liABOjcWKHic6PFCblyf
 x6UrBuE1boPwMzGI7XGz8v1Ma1qnx9TEcOfw4Yd5/N3RRy6yvb8iZ+zkgS5WBtvUaZxz+GgQadS
 DVS9dY5q7x3yCoLxboPtwgyPDSB6O0VE=
X-Gm-Gg: AfdE7cnhtNJbQmXrsG9/juXxRN7Vx5TLO0qIVxMGrJQ9AZd69xdX/iqSHqCw0U1RAp2
 HliRzNZnx2BWwulA43vDB6R2aOzPmnDSk9GXSY1jXoOW2Xrj76VmrubCGwOY0FQywEGiz9b6rYo
 n4/eV0GRD3ik1JfTShXNHx3Ct5OFdl6SGbBMDtyn0spPA4Fpj0HcQw/Hfmu60/DiXcRQvmvHy92
 WLUHF40QN4f0+ztXxHLxG1A7033Pbopj7vwUiro7ieUHO3nEYMrCaTs40O7qNWgbvwt7srzvnWC
 dUhjkvV19DUVrrG8BhW99baxA3hFxA==
X-Received: by 2002:a05:6a21:730e:b0:3c1:279c:526c with SMTP id
 adf61e73a8af0-3c3576426d3mr2584439637.63.1784035620851; Tue, 14 Jul 2026
 06:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-3-clamor95@gmail.com>
 <akeEd0GcHSqScGIl@hovoldconsulting.com>
In-Reply-To: <akeEd0GcHSqScGIl@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:26:49 +0300
X-Gm-Features: AUfX_mylEu9Yyzm1iZHwnL_3qQ4wX-qy21nMalz6S1BYQvhN4kmLF8d5IT5che8
Message-ID: <CAPVz0n1aYREgo9Mqb2fioQKTKa478rhMYPJJjcUagjCGNTzMgw@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
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

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:44 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:19AM +0300, Svyatoslav Ryhel wrote:
> > Remove driver-specific regmap wrappers in favor of using regmap helpers
> > directly.
>
> The commit message should explain why you think this is a good idea.
>

Removing custom wrappers over standard regmap helpers is always a good
idea, that is self explanatory.

> Based on a quick look you lose the errnos that were logged on errors and
> also the register debugging provided by those helpers.
>

That is not true, regmap helpers will provide logging and you should
not include debug stuff into the final submitted driver unless you
have a extremely valid justification for this, debug logs should have
been removed once the driver development was completed.

> Johan
