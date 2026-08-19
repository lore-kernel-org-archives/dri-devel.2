Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F5BC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16B610E554;
	Wed, 19 Aug 2026 09:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="erHBY1fS";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2C310E554
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:15:06 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so79367166b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 02:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787130905; cv=none;
 d=google.com; s=arc-20260327;
 b=dd9dT/ewRY+UXEVIcsy36U795DOwf81//dqdLnyj+Cn0aicv9MErg6GSMA4wJ/Ph2z
 PYmE6g0zaBSJygjrFpZGJ/wZdyaDLMC6+Od6jrRoc2u63E5avigHgYQrZTDBt1gt+ff/
 DRXOQllcZyjXClqfWIfRHx+bnDxAqOTdkzqaBtWEkJXH2p6b7D0a6CHczsxpK83zGRiT
 9kTqdd9bY57LMblmvXJHLJiQ+axiuuUVqEZT0L69uygbByhWCUL48SKRpze/ly3qEdPQ
 In8xZPeKMMXIOxHdAcprt7ALFp6Pd8BKYYbHskeEOvOQiEo4B7Geayh58OgyN1CLBWxr
 1gWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lzuDSojrT0WlSiuLx+jC6YW8XFu+Z/1D1t/4kP+3HDU=;
 fh=q5eGRbnWJeOtB+HbUKcMut+s6SejrlHUiuXj5bVL1go=;
 b=VCl96h+z/PNbfmRw1oFB8CZ0mLOYrsy8/xOBk35UOWdEPefVHvhtRj7IET+/6kSvmr
 0T4PH4L62lnuoVf6Hd4mtuVfd6lfXyjF7FjZuLeRBKMCxaNPZKPdQ47b7kViOT+uhX8D
 gD6YpzqB8qSSsdGEkPCEELJXsMBOXwJ6GuukiKul+UqU0lfyjTho7fVxcXsBnXT2M3lj
 +8rWJQL7JC7++KzAv1xZ+aykasxmf9bXSkf1MwoDazRkJ/RVICDrgHsFbPC3ZPmMLvmj
 bAaJlaGqDMnY+PrxXGKfrfQVAT5kG2kXAFI/Y/3wW8ISCRJ9Lto3Q3EnUE7iRNEB2mov
 TYbQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787130905; x=1787735705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lzuDSojrT0WlSiuLx+jC6YW8XFu+Z/1D1t/4kP+3HDU=;
 b=erHBY1fS4nZzVQjEXelOj4XFq0HK4m2sSs995G2qBL4Swl+gVpz730dZVxpeTjQfXK
 EBH5SdaQkBso1aou/pelXb3qCOt1shslc+PLljx4uMC+sO0JbNiKEGfy5VzClh0YiHvj
 5NfnN/OPNSVbOeXGHNAhx4URlp+2XBq6iWPpbrukzlQe7BLty+4XyrmBDELX3QruNzPe
 qSnTx2CMZd/aeiqcYhZzgshMsHgfP66YGBUxvzt7zehw1NrMurLmF0nEW02fj3WePkMo
 0kQfnEpkcr5mg+G/laaP8wrwG3bmyXyFrdQni/Vf94eotj9rYyGBMkiKyvwvJtuQgNL/
 SfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787130905; x=1787735705;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lzuDSojrT0WlSiuLx+jC6YW8XFu+Z/1D1t/4kP+3HDU=;
 b=UlnLsQl0IKpODPQgGQsLY3Vpe6nIJNQmj0EIWb8391ZS53fml3p9uqQxZuEjyyyESD
 bAQauit+np7PMHPsJy3enbeFyzEUepK7bjhL5B96GwLB16E3s+TqGdMrwfCK1slxzlET
 gxERIdKBhOMODKZ2AYSpuJv+LctsDhHME0WXmiMjirqeO3IhHkZoiChMEIFoFnzWEBZy
 sZ/IA+WZCMFJWtyG33b9zGJFXAHVgYUVachlqxMoQZoi/qn3isG1P5rAt8A7JCuSmzEZ
 G9L2aaEsXPAmD/soRGzKdhC8pxfXGANXVwcO/xP4oGTfP9GVU4R73rauTs3voNa76hx2
 VaaA==
X-Gm-Message-State: AOJu0YxcRc40imdqVrIVeW2n4aBuD8bk5bq6cwv53FOuVBPPzBa7y3Uh
 LBcH6TXEb5ldyiQ82SFiBBk1EJv0EF9NlZrx1b+++EbFoctNwfDGlb8NBkz+P6O0xbh4J2ZOjO6
 pEZoVEfjFP0WQn8B9B+nqC+TF/+UOE+U=
X-Gm-Gg: AR+sD12SVhZDzECdosjaYz76d0SAjeGYQO2pPJJlLsA/CIERi48N9Klwr64tQ2oacrk
 UhRcf6Pa1CkWcq8sDLQOerr4LSkr77wtP6GlRhK5EfAotJuTgE0c23ebmmAKcLY579kE0vHKVX7
 /LBXDOFhGFY4qO9rElWYldWWZEhWnI/rwvxLge9CUn2u/+K54DQ/pEb3n3W8atWZEwYKEzuuqAT
 fm3ce3TJC9Xz15xz67/5li8hMqQPzJDNQvvAmpjory15T++QEXhoc25iZSax5q1EqE2JR7IgwrI
 k031ZUm3AAzRlfAeW4L+QZ3QPPkLvsxPgTYd1pGTPgl9LNrUlLqjlgh8kBcSHGk50BZEt2qI+cK
 pnw==
X-Received: by 2002:a17:907:d26:b0:c21:960c:ec23 with SMTP id
 a640c23a62f3a-c2420debab9mr171453466b.1.1787130904534; Wed, 19 Aug 2026
 02:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260625082507.57703-1-clamor95@gmail.com>
In-Reply-To: <20260625082507.57703-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 19 Aug 2026 12:14:49 +0300
X-Gm-Features: AcwNN1V3ydYrIaA80LMuaJLxmhbbUUpk1AiJwjumZydbuxRniRx67BiUSFMd5gU
Message-ID: <CAPVz0n3QcYNfd8OZtcfR-mDF+bh1sb+fE6OUVDoR_LzN2uz_CA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] gpu/drm: bridge: tc358768: Add delay after PLL
 setup
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

=D1=87=D1=82, 25 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:2=
5 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> After tc358768_setup_pll() enables PLL_CKEN and the lock indicator comes
> up, the DSI register sequence runs near immediately. On TF700T this
> results in the bridge claiming PLL lock but producing no DSI video output=
:
> the panel powers up, the backlight comes on, but the framebuffer is never
> scanned out.
>
> Insert a small settling delay between PLL setup and the rest of the
> attach.
>
> ---
> - switched sleep() > delay() since *_pre_enable() is atomic
> ---
>
> Svyatoslav Ryhel (1):
>   gpu/drm: bridge: tc358768: Add delay after PLL setup
>
>  drivers/gpu/drm/bridge/tc358768.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> --
> 2.53.0
>

Hello there! If no one objects, may this patch be applied? It is quite
important for ASUS TF700T to work properly. Thank you!
