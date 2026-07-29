Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A3EC54F57
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C773310EAF4;
	Wed, 29 Jul 2026 08:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cZWaik4v";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1FD10EAF2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:02:07 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-6688acd1a51so812694d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 01:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785312127; cv=none;
 d=google.com; s=arc-20260327;
 b=jKYyM7Y+N6ivZSXTodVSFnvObve7TIbI0IOaAt8b9TzYwIHGC3o44mIKI22+ovitkr
 8WalPha75MoPqjPr5lC2Y6uWWQYC6+12T3sEtjhq9FSHNAWdv7MZvJIOF3eJqqHbOO9Y
 5F5IfPOB0bbJvP2uDwjnfXALeEXiN9EkRmWVQRtNf7TweW9wx7JnDzwPDijRZf0X8rY+
 p5qMBh7J1tIdttsnyp2cO3Eduf0Jcvm6NhFwp+QmPFm+uwJYYymYdd1q439GBWLlQYXT
 n7wxKTB7lBLps5b8CBYLMDyujrumepxSi3K8hm4vlH1sPpOT9TmXzMOetza6fe8vVO21
 JxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nWTQqQwG3YVHAteC50PeEEuDDKjaYcAXX2qekTmA0yI=;
 fh=neQERRL65QdgdOQkkmBU3MOp76SkQ8J7xQxRFbSrLF0=;
 b=fweBibHAeIx8gdysgs4fX1S8ajHebkH1I0+H+6kSaKBJAJuJQCnAQ0gBeJ71eBFOWv
 GLhG58aLh0oIo6t6PgF4X+Qvj8mxKzZKf1tKMJiU8myBm0lW7tj8R01Mnq6WvIfhhXUH
 75qoxB5p2zo7CF1p1OBKM2Xq6vQLWUfnA8mO8NGU95pXP1o3qCSTLTQqCC7BkP+o0pWP
 SFbv5zDLIK5zoOqcAzGCLhUcuflZw2QeT/1noy8ltag2G+V3UGfdgZ+5pqQaWGwKMpWB
 5+FKLlVUFfXjdrPXtM9SFEHqbCHq+EYLTDoAjJis7+0W3HhAOx5T5kT/MytQhs6YXoCS
 UOxw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785312127; x=1785916927; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nWTQqQwG3YVHAteC50PeEEuDDKjaYcAXX2qekTmA0yI=;
 b=cZWaik4vJQQ/TJVrSLdqBjp26LgYq5hLTrrYXEEMZC9FM3K6rhXknmcE6WzS6t7ceQ
 QJZ29rbXUf0KSEhYJIvv065YqFZ2ubDx91wwj4dUSgJECXX2PeUg3DDg9iC3/UcbVs/0
 uIMk+GBmNpALAMzeDsxCUzbslEw8cAtL03NrSZKlCcMT+NqyDq+8DsKfsjW+p79wpo7+
 6OC6luLipSQ6kBoKJJPq/+2hlVDUDVbeOjFlCH9rYoXJjXcaIrFx8TA3JsyC6BFeO2cP
 0u/HyrlKJmRlwLs+6JWSgTAGIIBi1kFHY0QC790G87lWCHPB56EkaOQm5UZ6a2y9ZVVQ
 Kzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785312127; x=1785916927;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nWTQqQwG3YVHAteC50PeEEuDDKjaYcAXX2qekTmA0yI=;
 b=gSZAxDIqEC8QedAlmTEfH7ugwj0lQu/cNZ4o2UfWO08ehcu82Q+rsAPYr2rATyIASq
 ZpBT2AS5psC/X3XwMHh+4wv4hCn4OQBvrTN/HKSp4v8CzwHWiVn/V5FR++HMUmzls8O7
 iDPAhrlEoyigLrzWr2WGtssQZtSImlxsobJQSLj2wooXSB/79gjJeDzpvSehrc1qMlJ5
 hVRtlLRmIgiLshxxDXS7216Tvt62sd5pKKUNc4938jdDugiibl1JnpvOLQZERUAg/eBE
 F6J43kzgLlQbQL/rw7ozQAaOyPiHLSK/nXwHetIk9JAcHXO2OYbFPcDkaC2JHFZof1PM
 tQXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpB5ihE6OMW+TZdil8OsnUb2pBUWs14QmXKx67NzWDtUIgqms2AOdbZ8ZZlR14e2gKm2InTCBnwNq4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzdop5ud43FZQNSa4v0s5jagV9KXAqP8VrKF7h1jraEQUZE30cy
 nXD9lmso4Qh4KpaPHZPc84/DmxjRAdVIa69knmYbRWq6jKwBC0Byh3FOIZCWpQkN5ALQt2JZ/IE
 W3HorUMc6/VRoqH/myrBYPC3jTk9eeGrlZ+xJf7ybbQ==
X-Gm-Gg: AR+sD12aV+EWC07qe56Ce7r1PgtJjVl9enfNyWedTMm5NZuVpZfPsybbxVB6jRL0YL3
 7XTNSaPTmLz2OQ+lbNa+grFS1QHNaAlL/fs0jbKuuNYJ/edLKlRA8wMWYqWFB0RbDZkSs/6zdJo
 0o/LYBjwcfzzshbp/S8h3n5Blj6hy+taKhSHnm8FzPJq39u1DlFJMSTKfN0LSjpDwLp273Jy3Rk
 cJec+vufiAsbjpXRvBHM/jLmQmrq1qgvigfTjZSOqxQoEJACKH0Og17FykZVzMgLhB6GnDIe17A
 nIeR3IWQXNw65oi4m9DFa8ZCisreVEu4GlHXnKeh1FpfleWp
X-Received: by 2002:a05:690e:4507:10b0:668:9a53:c392 with SMTP id
 956f58d0204a3-66905822945mr1566093d50.75.1785312126656; Wed, 29 Jul 2026
 01:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-1-c042266b9eeb@linaro.org>
 <20260727-stirring-miraculous-nautilus-e22bda@quoll>
In-Reply-To: <20260727-stirring-miraculous-nautilus-e22bda@quoll>
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 29 Jul 2026 16:01:55 +0800
X-Gm-Features: AUfX_mwa3Ibvs_xhtU9_glYoRrnOJI9mbG-XhW0xN7OZQOuaCyqfso8Gz7qCh3g
Message-ID: <CABymUCNm8_KNgh+6wKH_PO0Y=N6kxfMxOrWsq=wZZQY9vX2kkA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: display: panel: Modify reset gpio
 number constrain
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=8C 04:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 27, 2026 at 04:08:40PM +0800, Jun Nie wrote:
> > Some panel support 2 reset gpio, such as Synaptics R63455. So modify th=
e
>
> There is no such binding for R63455.
>
> > number constrain of gpio to 1 to avoid check failure.
>
> What check failure? Please paste actual warnings (but not fake ones).
>
It is a review warning from sashiko.
- [Low] The `reset-gpios` property's `maxItems: 2` constraint
conflicts with the strictly enforced `maxItems: 1` inherited from
`panel-common.yaml`.

> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/display/panel/panel-common.yaml | 2 =
+-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-comm=
on.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> > index 087415753d606..7c450d2799808 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> > @@ -119,7 +119,7 @@ properties:
> >        confused with a backlight enable signal.
> >
> >    reset-gpios:
> > -    maxItems: 1
> > +    minItems: 1
>
> I do not get why all bindings now get completely flexible number of
> resets. I am pretty sure not all of them constrain that. It's rather
> your task to check it and explain in commit msg.
>
> For example the second random I took to check (ILI7807S) does not
> restrict, so you just made that binding accepting 1000 reset lines. Why?

I just want to extend the maxItems from 1 to 2 for my case. Do you have
any suggestion? Thanks!

Regards,
Jun

>
> Best regards,
> Krzysztof
>
