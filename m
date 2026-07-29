Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B83EC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7A210EB01;
	Wed, 29 Jul 2026 08:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uf/z1uk3";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A89110EB18
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:17:22 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-6611669cd16so867434d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 01:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785313041; cv=none;
 d=google.com; s=arc-20260327;
 b=gDw1iyNrZOVKtPpveuFWO2MzpYmBy6iSCwm92dY09jO7tuRN3r940ShT9CDCXi6Kf0
 yoRtSSQmvKhvj2Itk5dhlbz/omNpuHkux1L5J/CK9+Bn/LAgoxGzl9gUdMXlu/bunHTa
 meMGStaufmB4mKmCTAZdNrGD8niNRVPqdrjTER2QESUxS/pwk9VMV7V82/4xRnOGxkwP
 7GxCUmquNxVGW6NjZ8Eecy40HnydmTkmsDae7arpTYymzyw+yqO2j/sOPZgvlY95jwR4
 E2lhGMjvyASbfkbVL9oI8dgxGiFNMsb2JedcjFbB8Wh2umfeLP7GjtiCU9E3MVw2b53B
 C7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WEqhopWknuqx85ckMTtGRckp0jJiYMoXslq0KHJVS3w=;
 fh=3t8mbYe9oTnqr+MCTY+skwc0QvFhdIZUgO1DoIwu/0U=;
 b=W4xHqjAnnsGYkADpfsjnsWbNt7yW4FrJpp8nef7KVg1byquhNdz72b7PcCwGXO4DNM
 oRP6CHYVMrKqx+RaYg4Q124B+2abi1rgrjgZnlkgp301/jZdnfGrCh0JD0NQNNM/288r
 KOmMwu5csqjRyfEbdTwRECiso3v5CUP7q2W8lXjK44PjvRzM4p4QgyXrrsTU9Sr08BwG
 mim31haKgNWv8y9Qc1zhu6wYuecbSQEHbDyfBcUzznui7cTye1l3Ksq8bu5joBpuTwuI
 VRbTzsxCwtZ9IqnR8mlSdQfDbtkaQACphkizzPpsAmmC8oQ6DiBiFL2qdBUIHe85gsPy
 cPXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785313041; x=1785917841; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WEqhopWknuqx85ckMTtGRckp0jJiYMoXslq0KHJVS3w=;
 b=uf/z1uk32SG0wCh2UTu30Uof3mC++aiGqMP5CIGiLbTTUBnxEiYpwEbXuWxGxVQbY/
 2aZmlstUUtQyn/FjML3q6IdQ9R7YmaauYCRCDiajrv4V1RTsU03SJjavpXRJJIivJcMd
 83BU4/80wXD/XspNdTE4ZBPL5AwBvDNJLB0EmNjRmvOHYynAQ3EOf0cyWum6rhjC3Bpp
 HDPRj7WnQM67py7XnvQ/ODdJCLeQOtjqD1ck5CwV0j4eACBVUi3S6SCkw8z1+qxQuBp7
 zorQRstHQPehJjti0iHWDPtWTNqAjSC6vyX7EqT2U+FbriYEkmw3aLgC8dHHltiALTam
 DfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785313041; x=1785917841;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WEqhopWknuqx85ckMTtGRckp0jJiYMoXslq0KHJVS3w=;
 b=GeIlB3gpm0irJbA1UIwzQtadx+R/yvqWYVEUWkESlVQg4BjVpq5Db4r6Wd+YVA/www
 E19nlSQVaAcQoBCePun2lPQCdVp/KBTceROy62xW79P1364ztP9AmAh5IX9OdVoD0ymF
 zBLvw8RYjbAv56sQjYc6wVGiJd39alFad8cy+4JdGSKD6JycpcdfQ/d6aY0oSMMPhgoS
 pQ2sV/ZvV2Ke3F1JhsAWeRv44DiHmNJhfsap73sjQ+x/fGpZBPVtBtUN0x+O5FjpUwC0
 t/3k3FMEtoou2JGCsLGv1FfTn5c013pGT95ZIi7menVlRSDZfvZKU+4EN2UwMIG22tbB
 1sGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhXk5P3Ssrry5KE8gZ4gNQGpzQqGb2//9unv1QBG77rAjiivZIluc4wqdeFKo7P8JfK5IV6Lr89sM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzl8wz8GrSTQjC0xU91zMzucyiOb3O9bEA2RoeVF/esqnWWwdmu
 hffGbnpGIo1qexs8MWbmlHB0RovubDngKb4RKNQ1lJDDxORihIGqIkyLSqxuL8+ach2KZI0CCkC
 kmiaPMqZkmtzo2prGr6R8uGRY96nWHeKc749+K2vPsg==
X-Gm-Gg: AR+sD10ocywNz3wFq2ZCLg8SkDFXcSBTNgzxuta6V7NmaAx8SnzG4MbyWXGuC7u7PP4
 j1HvW/UvM5ZZnSOv0io32TmYuWE/NE4MUro9KDPzCmil+PNGuugwE7sGpRLHBEilE9NMoCs+MbX
 Y9hB6vOC7XNqKQuXPy1nGqH3i6Q4F75hC+LUyrDkRP4j9YGTe1sIQjjZnOToC3EIMAadvgsDxV+
 qFqHed5D9N95ef9BMhUteF3f0cwTulBk1iQcZmbhMkMyC7iEFeFaJsGSnOGueMS2SKg/FDNlmTo
 9JjivjMwmPaO4XgHyoJ0kqrBzd2TQK5Ea93n8fxQRJMAPQL1
X-Received: by 2002:a53:c750:0:b0:664:f751:4b59 with SMTP id
 956f58d0204a3-669057f6a66mr1929474d50.51.1785313041424; Wed, 29 Jul 2026
 01:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-1-c042266b9eeb@linaro.org>
 <20260727-stirring-miraculous-nautilus-e22bda@quoll>
 <CABymUCNm8_KNgh+6wKH_PO0Y=N6kxfMxOrWsq=wZZQY9vX2kkA@mail.gmail.com>
 <e7767824-33f4-4601-9b85-8bdc64cb4d4e@kernel.org>
In-Reply-To: <e7767824-33f4-4601-9b85-8bdc64cb4d4e@kernel.org>
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 29 Jul 2026 16:17:09 +0800
X-Gm-Features: AUfX_mw9Cu6yAJcPR1V0IIlGNQ-386b7zdVy8vAzfi4FAjHtDNsP_9Xp1j66v-I
Message-ID: <CABymUCOTurnQzSnBHknT_EJ4Hd-BBScebSbA0g2ZhzH0ih7Qnw@mail.gmail.com>
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

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=B8=89 16:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On 29/07/2026 10:01, Jun Nie wrote:
> > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=882=
8=E6=97=A5=E5=91=A8=E4=BA=8C 04:23=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Mon, Jul 27, 2026 at 04:08:40PM +0800, Jun Nie wrote:
> >>> Some panel support 2 reset gpio, such as Synaptics R63455. So modify =
the
> >>
> >> There is no such binding for R63455.
> >>
> >>> number constrain of gpio to 1 to avoid check failure.
> >>
> >> What check failure? Please paste actual warnings (but not fake ones).
> >>
> > It is a review warning from sashiko.
> > - [Low] The `reset-gpios` property's `maxItems: 2` constraint
> > conflicts with the strictly enforced `maxItems: 1` inherited from
> > `panel-common.yaml`.
>
> I don't understand what comment from sashiko has something to do with
> some check failure.
>
> Anyway, we do not create commits because of some review. We write them
> because there is a reason related to code, products etc.
>
> >
> >>>
> >>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/display/panel/panel-common.yaml | =
2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/display/panel/panel-co=
mmon.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.ya=
ml
> >>> index 087415753d606..7c450d2799808 100644
> >>> --- a/Documentation/devicetree/bindings/display/panel/panel-common.ya=
ml
> >>> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.ya=
ml
> >>> @@ -119,7 +119,7 @@ properties:
> >>>        confused with a backlight enable signal.
> >>>
> >>>    reset-gpios:
> >>> -    maxItems: 1
> >>> +    minItems: 1
> >>
> >> I do not get why all bindings now get completely flexible number of
> >> resets. I am pretty sure not all of them constrain that. It's rather
> >> your task to check it and explain in commit msg.
> >>
> >> For example the second random I took to check (ILI7807S) does not
> >> restrict, so you just made that binding accepting 1000 reset lines. Wh=
y?
> >
> > I just want to extend the maxItems from 1 to 2 for my case. Do you have
> > any suggestion? Thanks!
>
> I understand what you wanted, but you did not do that. You changed the
> property for every case.
>
So changing to this is OK?     maxItems: 2

Regards,
Jun
