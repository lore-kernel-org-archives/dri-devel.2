Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1EAFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD40710EF4F;
	Wed, 29 Apr 2026 11:45:10 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A1E610EF4F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:45:10 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-56f3e6bbecdso4198910e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 04:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777463109; x=1778067909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07iUR/sIOeK9OY28Ao/jBJ40ezKJgRa8Xi1S5qNmXhs=;
 b=pMaAk1JZUWXaTxBDd0bY0KpDamKsUAZfbizWg7+OUmHr0B4pMu+9d32ucROABOT+tp
 MGKAi57THjl2y+USoq6zNtpJNT3ItyDxn25wPmA12msd/lLoyxKFSsW1pbVM4v7TVfah
 oDIV0VUKEacsynOAh1aDLHo3rSqHZsBggfxLwJUGis/vqqrJQ85snihlf+Dhlv0P8/kZ
 3Y0wsl686VBXK5WcjDDFb75/KgRhVchkpXNklHSLyFjDHQ6K4kN2121dD1wxfdwLOTcJ
 FSQVYN6ehIWSMdzm4rL9TEklmWT5IcXOs5+pbnkxHXE1p10YCN80rzGlhdqHZrm25Dzk
 rMdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FtgeK4QLVUVAtsd4PRTDYIm3qaKLsCNhV2ocnIGq7FUPOLicVK7vbRm/bpFqHFKTnqHq+UWxXVUU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPPwtVsmp+JCxCdIAqQVk3/5JiMlR1HhYW9eC7W699cyoNhQsM
 7EELu6/geSb+92zUkT4X57ojpBqdoNYyvTCNRw1KZWpzZqBcLGG7LJPc0R2ERRNN0dY=
X-Gm-Gg: AeBDiet5xPX+k3R57YtEXqzLrpq2YrZeHAe9T5LjxgD0f4huuYbZLCSlFKMgNwywrHN
 0Rei8ipqK/9aALhsEE4iOfIM4qN8xfqlFdP6mY+myVlvvNn+Td0HGfyMQLqbfnWtUT1lPeilosG
 K8undXcjCPXUnZxVM8wSpyJT5X+U9ajzEVAIN1SOs8zOe36SZL/DzkFecqQo6ypFIqzGogfCo67
 MQtsRDjklK2dWCl/y6Q7oOicjdFUsNdjti7oHZeYCT1MOuZVArqa+i3rZJIs0AGg+l22KdQFcZk
 zSnpooHqgJuRr8NyneqpJ/fPPa8Ru9Oxxzahq4K+j+WTa/WPGAx2uTCnmsYNa59VuPsIUsJl1S0
 bcDhZCg+lr015+vje4fLfj0krLATyVBV0d52LXK+GA1AKkHz8RqyRjVNdInqee7Kwvk+P8KdZj2
 oHHGKau7xBVitbwdljXOu9AsBHMBIRkVtsA3UR1j5HYweGWtfQawg6Gs0Q8Xy0MyWUcenxHaMf0
 f0Q4tCHe2fQKg==
X-Received: by 2002:a05:6122:3d06:b0:56a:f979:a9d1 with SMTP id
 71dfb90a1353d-573b34d89b4mr1403406e0c.1.1777463109208; 
 Wed, 29 Apr 2026 04:45:09 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com.
 [209.85.221.169]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-573b6d8b84bsm893372e0c.10.2026.04.29.04.45.07
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 04:45:08 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-56f3e6bbecdso4198893e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 04:45:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9dOhgWoLIwc60rrXSY6MHr80bVFRj9yBY4FoJWu3VE+r0uq2eMTWoBkuMzZHUGmZEYWp2B54NBreo=@lists.freedesktop.org
X-Received: by 2002:a05:6122:8b0c:b0:56f:7300:37c9 with SMTP id
 71dfb90a1353d-573b368cf79mr1448638e0c.10.1777463106983; Wed, 29 Apr 2026
 04:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260419193718.133174-5-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Apr 2026 13:44:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLUFZzwUjvMuZOOTJk9jn-pTM4-rYHE8OZzp9RpQd2tw@mail.gmail.com>
X-Gm-Features: AVHnY4LhTK0YHEkXOgViPxtDX3drSx5eXMIsHWPwRkcxiJzGfAV6beExDjAOpFs
Message-ID: <CAMuHMdVLUFZzwUjvMuZOOTJk9jn-pTM4-rYHE8OZzp9RpQd2tw@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: soc: renesas: Document Renesas R-Car
 R8A779MD Geist
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
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

On Sun, 19 Apr 2026 at 21:38, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Document the compatible value for the Renesas R-Car M3Le (R8A779MD)
> SoC and the Renesas Geist development board. The Renesas M3Le SoC is
> a register-compatible variant of the R8A77965 (M3-N) with reduced set
> of peripherals. The Geist board is derived from Renesas Salvator-X/XS
> boards, with adjustment for the R8A779MD SoC.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> @@ -473,6 +473,12 @@ properties:
>            - const: renesas,r8a779mb
>            - const: renesas,r8a7795
>
> +      - description: R-Car M3Le (R8A779MD)
> +        items:
> +          - const: renesas,geist    # M3Le Geist

"Geist (RTP8A779MDASKB0F10S)"

> +          - const: renesas,r8a779md
> +          - const: renesas,r8a77965
> +
>        - description: R-Car X5H (R8A78000)
>          items:
>            - enum:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
