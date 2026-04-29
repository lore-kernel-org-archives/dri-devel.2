Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C29FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143D410EEFD;
	Wed, 29 Apr 2026 09:57:57 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F74010EEFD
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:57:55 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-56f70865797so6648909e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 02:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777456674; x=1778061474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=727TQd0c+qHkAEInnHUXDqUTv77oNJr8Ljf4nlxgtUQ=;
 b=qpNo4oINJox1ylLHwpAyGyJr+LtIuam7KeU08TnoRw4P+mxnrAPQ1vdp7EOTnLkoni
 LTA+/BqAiAljHM3RJ1iRE7Au/lMlZd+COT7M6RGhUWfcByzZI8skyHU2KpHR9bBBODcx
 kJVEhBv/TZJnjbKDMQmswEaSCJJlwEN+ny/4ruA2H5dXzneCuu87e2nIGXEo0Jq6kOzQ
 NX7H6Zhzavi064rkZJ1xmCcQ3kie2hlMZuYNN6hpTHciofz/uuhPw57hMwKOF85YOwuv
 9WOn2wgDFd93r3vH1DNQJPVGv6uYCOaBc+p/WAGnfEfZHUm2tRy/HWAF7tvktwrE/lzP
 bWcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bHPL1JsY1IO0gJNtgk+R6fsU+I0fTj2A0hdjBH5DFCihaHa0l44Yez9vVFXpLF70JCMIBKH+gTYI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJoctlXje0Zdw3vCEPPBlCMVBSzjeJ+piaoVzYHpYSC+28d7zK
 O0mPbOSee6wEYS7eBPJtWKy2JapwSY7ywMd8XOHXrKGPXOE8frepAWRVCqQiWKa8Pm4=
X-Gm-Gg: AeBDiet9byzKm86fxC4zQeimUeHZUUKTAgkLyvgvV1tm13pzwx0MuZ42riKYTNUhb2c
 vjtYR2Vf3xljYfDHgautya3A/2blC1De8GwP231mwJtIqu5yDji6Zl3y3YqG/7FRu4WL4U/VvfA
 33SfuBEiXfcBtPMKl19QuSujLeQbpEs2SFOad/VxBoElyxSFGXOPPFr2+zRrkmZYdGRuAyKafLx
 Ay0PCo5RJgDRqCHyN992E2gDWFzMyWlNFqBnqcqG6A0OQ9lYaTOvTo4AI9fLv/ZPmkuLWtKil2u
 teH7kL8CUWJnJIr0o1SpDAgTtLjufE4/SgRMn+kTp9s/ogooSvr/0B1WfU9WtKupTfdHlPcBdBq
 sjyDHeBaQe01WSsxuv6331T1Plks07kI3hwqrCSnD9P+WnPHC94+LdwD2+MWS8tpFsMvOVf2ih9
 3OFW6qJL2aX+B9/SvHYO/iFIujP4keYp6oFG5ECQ6CGhLTvnN1aZV7gJe+Xn/BIzOy9m6uiUUK1
 zPnLZeUiw==
X-Received: by 2002:a05:6122:8ce:b0:55b:d85:5073 with SMTP id
 71dfb90a1353d-573b34fdb93mr1493516e0c.4.1777456674202; 
 Wed, 29 Apr 2026 02:57:54 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com.
 [209.85.217.47]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-573b6bf162esm812514e0c.7.2026.04.29.02.57.51
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 02:57:51 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-60fa13bde2dso7772672137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 02:57:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9R3rxBn7jhxOZ60biYjwvRx8AKuCKFxcJsd+11LdU6+JQakvBprYl9SYnUDTPi+FadIkaIWrNqlro=@lists.freedesktop.org
X-Received: by 2002:a05:6102:598e:b0:61a:c2e2:932e with SMTP id
 ada2fe7eead31-629272e37fbmr1942655137.22.1777456671431; Wed, 29 Apr 2026
 02:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260419193718.133174-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Apr 2026 11:57:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUzRoELGedrM3ELUjZr-N6DnF4TXtdQR_k74Xmfppu9fA@mail.gmail.com>
X-Gm-Features: AVHnY4IlsJzOGR_PMCF4iS-Uk9l-2ljuIGS7ZCYV7JbOA-5TFuOsoyAbIfAM7Nc
Message-ID: <CAMuHMdUzRoELGedrM3ELUjZr-N6DnF4TXtdQR_k74Xmfppu9fA@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: display: renesas,du: Document Renesas
 R-Car R8A779MD M3Le
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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

Hi Marek,

Thanks for your patch!

On Sun, 19 Apr 2026 at 21:37, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Extend the Renesas DU display bindings to support the Renesas R-Car
> R8A779MD M3Le SoC. This SoC is similar to R-Car R8A77965 M3-N SoC,
> except the HDMI port@1 is not present.

"and DU1 is unused." (whatever that may mean...)

>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> --- a/Documentation/devicetree/bindings/display/renesas,du.yaml
> +++ b/Documentation/devicetree/bindings/display/renesas,du.yaml
> @@ -42,6 +42,7 @@ properties:
>        - renesas,du-r8a779a0 # for R-Car V3U compatible DU
>        - renesas,du-r8a779g0 # for R-Car V4H compatible DU
>        - renesas,du-r8a779h0 # for R-Car V4M compatible DU
> +      - renesas,du-r8a779md # for R-Car M3Le compatible DU

I am not sure you need a new compatible value: is the DU really
different than on R-Car M3-N, or does it just lack some wiring? ...

>
>    reg:
>      maxItems: 1
> @@ -890,6 +891,75 @@ allOf:
>          - reset-names
>          - renesas,vsps
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,du-r8a779md
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          items:
> +            - description: Functional clock for DU0
> +            - description: Functional clock for DU1

... E.g. you still have a module clock for DU1 (the documentation
for R-Car M3Le does not mention any changes in clocks).

> +            - description: Functional clock for DU3
> +            - description: DU_DOTCLKIN0 input clock
> +            - description: DU_DOTCLKIN1 input clock

... E.g. the package is documented to have pin DU_DOTCLKIN1.

> +            - description: DU_DOTCLKIN3 input clock
> +
> +        clock-names:
> +          minItems: 3
> +          items:
> +            - const: du.0
> +            - const: du.1
> +            - const: du.3
> +            - pattern: '^dclkin\.[013]$'
> +            - pattern: '^dclkin\.[013]$'
> +            - pattern: '^dclkin\.[013]$'
> +
> +        interrupts:
> +          minItems: 3
> +          maxItems: 3

... E.g. you still have an interrupt for DU1 (the documentation
for R-Car M3Le does not mention any changes in interrupts).

> +
> +        resets:
> +          minItems: 2
> +          maxItems: 2
> +
> +        reset-names:
> +          items:
> +            - const: du.0
> +            - const: du.3
> +
> +        ports:
> +          properties:
> +            port@0:
> +              description: DPAD 0
> +            port@1: false

Perhaps port@1 can be present (and thus required), but left unconnected
instead?

> +            port@2:
> +              description: LVDS 0
> +            port@3: false
> +
> +          required:
> +            - port@0
> +            - port@2
> +
> +        renesas,cmms:
> +          minItems: 3
> +          maxItems: 3
> +
> +        renesas,vsps:
> +          minItems: 3
> +          maxItems: 3

Your arch/arm64/boot/dts/renesas/r8a779md.dtsi only has two entries
in renesas,cmms and renesas,vsps?

> +
> +      required:
> +        - clock-names
> +        - interrupts
> +        - resets
> +        - reset-names
> +        - renesas,vsps
> +
>  additionalProperties: false
>
>  examples:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
