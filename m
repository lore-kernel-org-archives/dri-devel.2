Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDDAC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F8AD10E48D;
	Wed, 22 Jul 2026 15:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FBs7qFUs";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169E510E48D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 15:19:00 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c15f47e6297so942139366b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784733538; cv=none;
 d=google.com; s=arc-20260327;
 b=lpDiAXoGWLdBqDL+78+UcxMYYMajxSvQnSncACRo4Q9M5OYwRVcn4pGExakeLyXIga
 cuYM8eIJnqYHRafFK7lu+njrsZnWGQbvgMaT+GxvrG/kwpA6txYUhdCdeZvGOIbuf5zS
 W5+vErOSJdtRU1SPZc4HBE5nVD2Ju+PacUo/ShRA1ep3YAJZ6qGvkSv2gxEJqokYYzqE
 110z+vBOIFGd34OVpdIu/9PYSSZqEeOgQZCLuUPLSw+lKzXMrW4/S3GekLZlGvihfNWG
 ftqr1IlwoK+5tvy/IA8NPZ1k/0ckuK/RWv6luV1770JHruqs4bkmWyh00HphdxhWGLyH
 X64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i1afpsh2OIvkZaaChULugvD8FxciERHSKG0pHwByaWw=;
 fh=RnhukKZHq8wcpb4r8t7/YO7XJoGXZkhmtIURsQyotsw=;
 b=r1vWEta70mcEflqYcls9Gvbe1GCnJOccytkEb8ZNdGZrKV6RbnyjoRQfIlDuwAsBTD
 zYjeJbqUxeWp7RDCPMX5QPMK6tkNVysSqR2aVqJ2DonCD2imOzw4zK95/kfXXHT0MFlU
 EF2XKdv4fjdXyV2BzUp8qPa4P0ylVYaXutKH2HKwR61o/6GP+cqluh+YtRqqp9owWwf1
 Pgm4SoFETnIhUXjN1NzivxY8ThAoWjjh7dcxbnIttDu818i4c7UqSWdYG1aDsa+3eMQ6
 UR29uw3ORPLU3g+EBQZ/f8F3F9nW9x3ljr/REBErrKSgldAmYlxSHjC9aJM5rrHTDbZT
 UfZQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784733538; x=1785338338; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i1afpsh2OIvkZaaChULugvD8FxciERHSKG0pHwByaWw=;
 b=FBs7qFUsesLC1JCC+UOeSQ6C04KdzUPxUKv4s/kt2xeyvlhvdVXEfaYzi+cMBlKVkV
 6Mgz35sc+35n/EQ9Dq0n3+ctJ0L+zOPls6pI3CTi0IziJPLzYrHMe5TbCh3RJcXTlwD4
 2ab6uAALKnwrIWIVMILUmdA5R2H8TxWGGCqqlbmClaAZCSATHXU7mge3k6ZP4EQ9QqIa
 OIU607Pg9JfFo1d5UEogkuhHgFRFnMmZDGIrk+ROppKh6GOOZcKL8swziDRuIF3EMEVx
 fG9ueoRAI5rL0gvWVpr3UE7O6pfKT5A33IRZ8q9XREjmb6igKVAXPz8pnH5t4vmp/cBh
 ZS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784733538; x=1785338338;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i1afpsh2OIvkZaaChULugvD8FxciERHSKG0pHwByaWw=;
 b=EYb7AYUh0QwUEowI5LsRvmmnF1VPzS4v4892IFgoCezmqMjW8o4NZrMjJXEM94sXLz
 4ZyZbtPqp+l09ABYPrYyCNbqFUrmj5PoV7mh9NrkjiWjMoEuFR5e3T+TAwDGrSLeMaNy
 3vUSS9ukRhMi+X42qEhEe2KvmJIO267qEvJ/HuIWtuorK0pNG7GNIOVo1d3Qvm5tcJXd
 DPqBPnsSRtaPL8o75zzjtbNBfIf/OMA33QovjSq85V1dCbynjtKnRhvCOooSaWwkW26u
 gAQQmrcJhWPdR9QaAMXSjcxoKS2C8qNgGL9n7NO/o3ey24zfWJfOFJCxZJmw29Iar4oB
 ceig==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJBj0BjGHbXW6UZjJ8gqrikgbDCjK2uZDyqdQgjXtJQlEcsaDhhF6CDyTCv+AjhCfrEaWDq6Sc2tI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywb3r8EhPC6Jx4UkePPxccFaITemwD4hhp5/tXaknowtsKEPrAO
 ZpnZr+oQedavoA+pJxgWdvTsmfMOGsXHE4EkUwlxfipvzWm3nmzmu015rMDYmtseFIfBsodAusI
 gW+6i9YZeNQPn5035RiSkyTBakYLNr/U=
X-Gm-Gg: AR+sD10qb82nTaG+Xk5Wt/TDO/SpLBrgd9uUi1MbKmLvKVfP/Eer3cn157X3Q9Medyw
 ssNU+NeS3OaoWNrjm3D6vKzkosd5u51zCO/f05WNShpvkrXY5eple6IwjbN5bSmVlmO53uRXy06
 pTl0BrU1V8R3HrWaWYkuSmjiXDdsCwrQardw9vFtuCfByzkxIDXLZkIdcqfkKuQRmHMQWCP12Y1
 RMBLe359XSEFWymXBb+81irRjmMBMVoGcWZ+O5+qVA1gqYdrGZUFyXItIe5Z5/PC6GovHo3qbNM
 7KR4E+0vHgcdkTe/GuHG7JJqkdl25zNXhScHcBl0lGCvWj29J1nV
X-Received: by 2002:a17:907:388c:b0:c16:945:97f0 with SMTP id
 a640c23a62f3a-c16b48533femr836839366b.39.1784733538115; Wed, 22 Jul 2026
 08:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260721112133.70382-1-egbostina@gmail.com>
 <20260721112133.70382-5-egbostina@gmail.com>
 <20260722-ochre-alpaca-of-tact-ef17e3@quoll>
In-Reply-To: <20260722-ochre-alpaca-of-tact-ef17e3@quoll>
From: Eduard Bostina <egbostina@gmail.com>
Date: Wed, 22 Jul 2026 18:18:46 +0300
X-Gm-Features: AUfX_mxRkciUP9PmKB_Sf5WpXXnp_jwGYivbso-yHbHHBjEP1jiN3c0a8MRq-10
Message-ID: <CAEFOc610_15k2z-kCtuKkH3M3_ugE6uotvh+=oiYe560UOW=Ow@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: leds: backlight: Convert TPS65217 to
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
 linux-omap@vger.kernel.org, Mark Jackson <mpfj@newflow.co.uk>, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
 goledhruva@gmail.com, m-chawdhry@ti.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jul 22, 2026 at 10:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Jul 21, 2026 at 11:21:28AM +0000, Eduard Bostina wrote:
> > Convert the Texas Instruments TPS65217 bindings to DT schema.
> >
> > During the conversion, the following updates were made:
> > - Documented the 'regulators', 'charger' and 'pwrbutton' child nodes,
> >   which are used by the boards but were missing from the old txt
> >   binding.
> > - Documented the 'interrupts', 'interrupt-controller', '#interrupt-cells'
> >   and 'ti,pmic-shutdown-controller' properties, which are used by the
> >   am335x boards and read by the driver.
> >
> > Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> > ---
> >  .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
> >  .../leds/backlight/tps65217-backlight.txt     |  27 ---
>
> Biinding looks fine to me, but as pointed out you missed to remove old
> TXT binding.
>
> Best regards,
> Krzysztof
>

Thanks. Will send v4 that removes regulator/tps65217.txt as well.
Should I move the binding to another place (mfd/ or regulator/ as
suggested)? leds/backlight/ is arguably wrong now that the schema
describes the whole pmic.

Eduard
