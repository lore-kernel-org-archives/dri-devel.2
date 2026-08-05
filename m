Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A820C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 03:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D685510E111;
	Wed,  5 Aug 2026 03:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AX8qavCf";
	dkim-atps=neutral
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852DB10E111
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 03:48:34 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-81ed000b507so5630947b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 20:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785901713; cv=none;
 d=google.com; s=arc-20260327;
 b=kPvZcXO0Qxngs9q4DMqxXVu3Errm7h8AHtou+Veqz/1Y7mvYU9BqZnIbVAOxmGxKAW
 z/CmhwDKAmgMr4AUEAs3kgW8JoyMKoSBmTCdd8LJHttYq+SIB5XHGOXjpvuciQZw5kuU
 OWV2I/UGE0wCeexgHnN5+jBKzUFtCnSBdmSHrO5y1mCxNiRCqtqkWjiNzT1n+rvkoZZP
 Y38uZlxKHDHZ3n3FECABJhDVaw5wU1oDDjFg4AZSgERpgg1b8WjFyfQQIXNtgSVBpLy9
 XOa48y+eF4mT57BpRX7y8nekL4xBWy1cuomdTxKFHFfzTPBNdo+kwTJt+a10I4ioQJ3w
 KXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j/NmALyDnaea82VN1dJT9y4h9uKdhWB1U02N76kyw3U=;
 fh=yU71NybHd+qBnSYHzPO/gGAQv5CX2S7YRXPxPPVRskE=;
 b=esWAt4GSXKeRf7TQd7NgVglBLHWFGR5qwtfxylG7ExuHbGfReJP3lvPPwnPwS5EBCy
 BLWXI3axO/kyppA6BIKQl5zCUq57fbrOQ7fP1kTG4p1YWxY+tDUZ2/ZZlLn9JTa1Xunz
 2MwVk3/SKiZiBYpfIh3zpYuM3jykRlwsAffs/LoqNfa6eWlZTf2DAMjssvFOzrTKFNOk
 yBtKZOFRjMLqku3svCCkp9g+zCupG3Q0CvCw5IwhDpM2JuHQnCldJ8EWQk65SWj+uwSm
 hW5/MC94voFXp2JkRtujM+h9SjB8cvMdO2MZQTmymCYteNOZZXOXG0GS8SCQ5pCOTkt/
 j6bw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785901713; x=1786506513;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j/NmALyDnaea82VN1dJT9y4h9uKdhWB1U02N76kyw3U=;
 b=AX8qavCfS/hoVi9kTc/fAPCLxZ1oaTLsUDdbYq8xbONAbsqbsSlRl7J/IAgKbJqIDE
 njUm4A1Hx3Qlrt4JGvG7iZWkr6zk7UrV2iTZYVetamZx5J8sd6o4DOcT4o4WJ+VE7yTV
 Xq/rrWLp8Q7h8OU9HWO61nd5q7bcNO5+zInA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785901713; x=1786506513;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j/NmALyDnaea82VN1dJT9y4h9uKdhWB1U02N76kyw3U=;
 b=bllybh5t+ZKtIw0i0iz7VetvOk8K+sq4ctaFSdNYck+n7gIoVe45gQ4hx8ihUkkTpp
 sKfttERqoUjfg2/Hc6D7YKdU/3U/mIM57zn2vzwdRlRQd6foe0QXoac7uxUolHxbTvAR
 YGQB4Yuy5TLL35oV5yDXFUBROgn7imTAFQ2x6cbGS9fI+iOzHlIX6xfLTgZWPgL1cVSC
 yMRmNEBCtzpCn69cgexePYsXyRC7MEjnMWNf5+J7Mn7vja6CqMTZqxE8ABID/XhITD3j
 QV8ijDdHKqerd0/bXm2ElYLcCjghY7/74tu7QH/uFbMhBribi0rCrCqe1bvJtcrmSMPz
 66sQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVL/7kdN0defS/dOH8/ft6y90Yyk1MXCaoKIvVHYQuqHePdOEmXntQVcwK3CHILHup4Ku+wAS5RR4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTYED0ggKRf2cYNdwaUviOYk3GIsBxXKD0NhY2V0K7Zz/A4NzB
 xxlNc007TQLJUgnvbcW/H+OV5KxF1DIdkzSjsA2J2Q9JZ9Sbmbsu2QF7dNquBLqz3qxXgsugMjL
 ygCAukOEy1U15oIy4X+e5iC4FJNB19Ddl+f5bBVnq
X-Gm-Gg: AR+sD10p2Ow/vMvQtittOProYoK38uC73RnY9rdjZ/SZVAUby1AYs+5HEuhBWXUV8kl
 gkJOOD5F7Vh5S4v+44/Ojot9yfypnl5grESJhAsSE0Tc63QsDraSBLcFlsInv2+7SkQDi3ugj9F
 AU8SYmT9+rvKBuOTvYEq38B53TfnxNqO7J1yLIGaFgD1GAvnt79ocHWn/RD37uHMEv/EHpG+91S
 G06gWXTlkhtazrG1zv9nqNaX/pyfSnK0+OMMBAOXjfLRkyHC4jjRxIhgVoJmGTt9BNzag2/L8vE
 pUmjWSiP4j2GKV/rE1wv6bd0f7CiQKCxUXppUYIs6gf26eYLuYL75qr5CddM3+b5WMBRUoicVUE
 =
X-Received: by 2002:a05:690c:9a88:b0:81e:4e5d:484a with SMTP id
 00721157ae682-82022294eb4mr22113487b3.2.1785901713089; Tue, 04 Aug 2026
 20:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-43-angelogioacchino.delregno@collabora.com>
 <CAL_JsqJXpY8jHEgSHcHz4QZTFEZe8PLbO6vbpxWH4qobs0MPyA@mail.gmail.com>
 <f3837531-2949-4741-a23e-387317485c02@collabora.com>
 <CAL_JsqLVAQ6uhU0fGK_qnOn1x559ErWSJTKkSjr0z791thwD3w@mail.gmail.com>
In-Reply-To: <CAL_JsqLVAQ6uhU0fGK_qnOn1x559ErWSJTKkSjr0z791thwD3w@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 5 Aug 2026 11:48:22 +0800
X-Gm-Features: AUfX_mymFrVaiYOLaCO3AlvD0Um00IkfLaFRQ7IWTs7XOa8ZsYdcyTa8_6zr7HM
Message-ID: <CAGXv+5GeYZ_et3bH9Udf=C3f30-zuM1=Z1meU47RnofG0NL+dQ@mail.gmail.com>
Subject: Re: [PATCH v2 42/46] dt-bindings: display: mediatek: Introduce MT8196
 2D Sharpness Processor
To: Rob Herring <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org, 
 p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com, 
 jason-jh.lin@mediatek.com, kernel@collabora.com
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

On Wed, Aug 5, 2026 at 2:19=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 28, 2026 at 8:49=E2=80=AFAM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > On 7/28/26 15:40, Rob Herring wrote:
> > > On Tue, Jul 14, 2026 at 6:45=E2=80=AFAM AngeloGioacchino Del Regno
> > > <angelogioacchino.delregno@collabora.com> wrote:
> > >>
> > >> Add documentation for the Two-Dimension Sharpness Processor, or
> > >> "TDSHP", found in many MediaTek SoCs including MT8196 and its
> > >> variants.
> > >>
> > >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno=
@collabora.com>
> > >> ---
> > >>   .../mediatek/mediatek,mt8196-tdshp.yaml       | 98 +++++++++++++++=
++++
> > >>   1 file changed, 98 insertions(+)
> > >>   create mode 100644 Documentation/devicetree/bindings/display/media=
tek/mediatek,mt8196-tdshp.yaml
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/display/mediatek/medi=
atek,mt8196-tdshp.yaml b/Documentation/devicetree/bindings/display/mediatek=
/mediatek,mt8196-tdshp.yaml
> > >> new file mode 100644
> > >> index 000000000000..ccd6a8443443
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt=
8196-tdshp.yaml
> > >> @@ -0,0 +1,98 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8196=
-tdshp.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: MediaTek Display Two-Dimension Sharpness Processor (TDSHP)
> > >> +
> > >> +maintainers:
> > >> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora=
.com>
> > >> +
> > >> +description:
> > >> +  The MediaTek 2D Sharpness Processor (TDSHP) is responsible for pe=
rforming
> > >> +  image sharpness adjustments/enhancements in a display pipeline.
> > >> +  This hardware block supports adjusting the luma and contour 2d hi=
stograms,
> > >> +  frequency weighting, luma-chroma gain and others, with adaptive w=
eights.
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    const: mediatek,mt8196-disp-tdshp
> > >> +
> > >> +  reg:
> > >> +    maxItems: 1
> > >> +
> > >> +  clocks:
> > >> +    maxItems: 1
> > >> +
> > >> +  power-domains:
> > >> +    maxItems: 1
> > >> +
> > >> +  ports:
> > >> +    $ref: /schemas/graph.yaml#/properties/ports
> > >> +
> > >> +    properties:
> > >> +      port@0:
> > >> +        $ref: /schemas/graph.yaml#/properties/port
> > >> +
> > >> +      port@1:
> > >> +        $ref: /schemas/graph.yaml#/properties/port
> > >> +
> > >> +    required:
> > >> +      - port@0
> > >> +      - port@1
> > >> +
> > >> +  trigger-sources:
> > >> +    maxItems: 1
> > >> +
> > >> +required:
> > >> +  - compatible
> > >> +  - reg
> > >> +  - clocks
> > >> +  - clock-names
> > >
> > > This causes a warning.
> > >
> > > Seems this is in linux-next already, but no reviews?
> > >
> > > Rob
> >
> > Wow. No idea how clock-names got into the list of required properties: =
there is
> > only one possible clock, and this doesn't need any clock-names at all.
> >
> > Same for the resizer binding.
> > Sorry for the mistake.
>
> Why is this still in linux-next?

This is in your dt/next branch, applied 13 days ago. Maybe you applied it
by mistake?


ChenYu
