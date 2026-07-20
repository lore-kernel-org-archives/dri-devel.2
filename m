Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC46C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C80C10E04B;
	Mon, 20 Jul 2026 19:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XU3S5mms";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C46B10E1D8
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:07:32 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c12614b81c9so1824339566b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784556451; cv=none;
 d=google.com; s=arc-20260327;
 b=SH+nai/yNvenFVodSGBUC/SWBSZEX1Gi5RARGAYvD0ZaIS16+EmloWHgi26Ly1t5oD
 7OJJTfP2mytfkgKcG2QAwdWFVrIUiKTuWH8MlDgf5WRiW39v8udDcWSQUPnHI4hbIm8K
 1aMJVg0EBMq938oeAq8ZOgsiAxl3MVMT0FtM8TjTqJqQnH6bTTgV+nnb3/axcXS0BuM8
 iGY6U2K9ACeRu2asdc4zvw6SmbR9fuuPGz5mNDi/CfDWN/0DCmjYiS5WXZasCp7UTja6
 /joOC/P2+G9jWEqMXJk/iuZPJLh+WvxEpPoxrdaUhR44kMSSWGosy/e0XwucazBPCgC3
 nbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t6aKvIAiL2N7RKSpb432cnl3pylXzPZaT0UMOHNdrnY=;
 fh=KDqa1axQWc68R1OpdOkQIDhX8Ube5F1puU+v8IzZR54=;
 b=Ay17luobvfs84uOV/xdKa3s2cx+PEhkzytIEvaMS56126xNC7MHWLyKa9/YqGqPiff
 g8jl8f/3619IeXN0iUhMiUI0Yn7fa1g0G4vj65Z3CeSWkdA7spBXWgYHFShvGEhzjWmc
 MGezcxWH6RcLzNPT2NInLPW26hxUkvCnTyDVa6qG3B/sN0YiaYa+sA2oUouA6mzk9jls
 UQmq2LM8SJ9ZaFuZLMMyByZiYOzQqUFQ07WiOLMBTyH58H0NNvIeKNj47mCgmUx7bqHg
 u8VjjjdKnZGTYBw4/c6ohbqzW7QwN5bLX3mK9HBHF6aNheUQC6WrdUE1oArWftZAWUjA
 SVtg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784556451; x=1785161251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t6aKvIAiL2N7RKSpb432cnl3pylXzPZaT0UMOHNdrnY=;
 b=XU3S5mmsQwe0JcQ6vxFA173ev9kXdoQL5slgAF8jiteil6/dS7uh9SSxoWoTI4bVuo
 8DjvGzhnBVz1k33NRlyrRedAS2Z8TFjLtz4w44loA0b08s1EJuy5N5H22yG79Y/3rb6I
 EgNA3gvl4w6tARDzH+Xxqkpp/jV8YVLLudIcNfPfci5cjmv1xJPzZtZzGCqoDyQ9qYRu
 I36uS5n5UnwAPINeDvrNFCYM11y06bQvoFfant6sI8bNIL3dCnK35WoSZ/VELJOukgfp
 1PrrAhDIHIezHp0HvUFKpEGOfRTw1VJ6N1RFLTlW9hzXRWgveXELJUfmevEZmWk5FAxs
 BUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784556451; x=1785161251;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t6aKvIAiL2N7RKSpb432cnl3pylXzPZaT0UMOHNdrnY=;
 b=IF7jEJitPTXqEeuR4MLctFAX6yZjvmB00OGWBu8wVx58Yy3xKv8GpLR4sftARV7z7B
 ztudw4/CgMZSDahgUh/tzO9QVofcMeZ1/DyWE5vSF761DSeVb2VsW248faz043fS84Qu
 UFNJriHheDAfxvfnvQ2TVOTpnJ965AZZjqzZkC+Mq5meZey9kXAZazjEr4Oapp4LchyY
 2OsQiQTlEDGI1mSSZ6ZqC7s3tzwr6rxmnneIg1dwDnFOTm+hfaCnCWhAGUqElUoMdQVj
 1tC81zOsw6CJ24x76O5emPblN8/NNEfFoLJSsfH9IVDf83ZPBMjqa3DMhk5jJy3u9Bpo
 OoFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZ0YEBbGhkKkTOWamFTpynhcm5aA8C/ceaXhlIW223s7371kzJyJWHPPEVq08/TRwlCxmM1J2X6VA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIHNKxyZLwYeA8/j0D3EyxNnkN4JiHerine4udJXz8umMS//h0
 xjJy+YiQ+ochds9GAH3HBvcMj2SeJ6wIMdrFK7RV9w8XTfr3EsHEHGkkbN+Pgz2SDVN9S8gxP4L
 jhMbdQqaAFtwaCWykkKakeiWUYZxbf3w=
X-Gm-Gg: AfdE7clSisosiiZ+Xv0tt+6o/VOda9VM2jRNDDVG40mzI5NyritBRIgMBNMBZuOEHJh
 i6+9Uvgz25uz0c9tmLh5MCMnN30c/LycWDF3U87qxk7GO5hqYG3JwXvS/qyEC0xTW86V++i1Mt9
 VFcL7dwcdxc6DoXjtrJSfvTnlqm9p684LoI0ESWDkyIZhpApQJRsjSLaGcv84f0XU6CKi2ONjkl
 5prXwXZED+25/xnRPIGeOb6PhYfzh2UcU9mfS/a5hVEOWAnEUZbhS3j7cRaY4CF8MnqxNbbKNxC
 kHYuwPWSrfPP3VGmCm4uIN2tbx23oMwcE+CwHOEjg+HcR/KVP/OZ
X-Received: by 2002:a17:907:c012:b0:c15:c3bb:c90a with SMTP id
 a640c23a62f3a-c16b47c7292mr550030766b.35.1784556450739; Mon, 20 Jul 2026
 07:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-4-egbostina@gmail.com>
 <20260720-huge-sturgeon-from-shambhala-a1bdcf@quoll>
In-Reply-To: <20260720-huge-sturgeon-from-shambhala-a1bdcf@quoll>
From: Eddie <egbostina@gmail.com>
Date: Mon, 20 Jul 2026 17:07:19 +0300
X-Gm-Features: AUfX_mweWNBqk7caXjK50S4Mh9MQkC1xza8VdHGojIe6ULgydOnDi9gkyNgr6GE
Message-ID: <CAEFOc61Tan85xQhz33BuGSnJHyACvjRc+6YMFYav85CzxMwiwA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: backlight: Convert TPS65217 to
 DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, 
 Conor Dooley <conor+dt@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 devicetree@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-omap@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, 
 daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, 
 m-chawdhry@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 20 Jul 2026 19:03:49 +0000
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

On Mon, Jul 20, 2026 at 09:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sat, Jul 18, 2026 at 09:56:32PM +0000, Eduard Bostina wrote:
>  +
> > +          regulator-compatible:
> > +            $ref: /schemas/types.yaml#/definitions/string
>
> You should not need this property, it is already in regulator.yaml.

I did not find it in regulator.yaml, or in any other schema, but I
found out that it has been deprecated in 2012 by commit 13511def87b9
("regulator: deprecate regulator-compatible DT property") and was
never carried over during the conversion.

I agree it should not be in a new binding, so I will drop it.

It needs a dts change too, tps65217.dtsi names the children
regulator@0..regulator@6, while the driver matches dcdc1, dcdc2,
dcdc3, ldo1=E2=80=A6ldo4. of_regulator_match() looks at regulator-compatibl=
e
first and falls back to the node name, so without the property nothing
matches and the regulators stop probing.

So I will rename the nodes to dcdc1..ldo4 and drop
regulator-compatible, reg and the address cells.
I will send that as a separate patch in v3 along with the other fixes.

Thanks,
Eduard
