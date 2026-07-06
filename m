Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83266C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E9189A86;
	Mon,  6 Jul 2026 08:09:17 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F4610E7FC
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:09:16 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-5bd742ef278so381419e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783325355; x=1783930155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qf9yz7bHOmjN0sKgSDCZJBffOCMRQyGOU+wzNPd/KAs=;
 b=D4sZ5ZNVnZwvy12jKe5nCLZB7mvkedrP3ILvvetEIBszTjFa/sgPtglFeJ6t5QV6Qw
 zJjlTdj1WqmDy6+oucM3iaf/z+3wsvo2O9bphJQ0Ifi9v9tf3eAHOK0TjzIo4vEFjoXs
 VoPjdHMS49rOMetluFwiWgYkx5FDn9vXIxYTpJ9ogVQfA6JSJyTqDc9pCWN1WMFXR/mg
 YzWJp8KM9E442wU6q/WCB4gjFJ9oUlsM+iAtlt+aHgtWdFOiQqSFLvogwCZs6MnnSTU6
 +7pYMk67FLeFqI/8SmuNPHxKY803fuq7Hd/mNKL6QG+cJAXlSAE61XiUlqjmxpUZOiyU
 yuAQ==
X-Gm-Message-State: AOJu0YxNz6tj2efd7I3fDZG3fgUEZXA2nI2m/8+2MXVWmPb31rMjGDz5
 a86SkCP0zRyrkSTG/PuQM/XEnj/5O4G3+ig/SrBweV42PXyjOfR7zLJBXudJutcB
X-Gm-Gg: AfdE7cm1Qwli+Y87IyZpwTeZptp+K9DYBEg3wAC+I/L2SIL2mrp9xiMe2flnwo65lDW
 nVRpDKcV7eYSzes56XuC15ML6K4adE9D8wEWs6M6zC3UNDKCYKJAzhZCqbiYpii9lFz65URiOSK
 fPi8thQ6eiGZDeX2i/9nvOgBUzGU8+ugbGsoA3hBO6sao8KjWJk8JAxYC0QAHEOpi166Z+OGfAr
 X2mFT52mTmERgbfdfOBZlwtBGvDpfPi4+c8rA1GlJVYnPDb+aWFQeMKVQQEohPlLaK+evBMJrB4
 2c7ded/SdCfQGOeeO3CErNl4N5xQBZSm5dp5MNCylZwlt16Mc09+XRE1Rfl2eOB2gq/950+jPtN
 EHVFg0/T6NTsy9LuYzAmNWCecLZoQc+OHK19WokbNmf0xJwPjY0WXAB3z8Xjek/vmHQ+AQ4Nelq
 4vKvJPApbprsk2LlU/sYjx/sNRUzDFXHg+vHcHCs6Zv/f60paWGw==
X-Received: by 2002:a05:6122:6610:b0:5bd:cb34:1b65 with SMTP id
 71dfb90a1353d-5be100e57dbmr3129770e0c.2.1783325355182; 
 Mon, 06 Jul 2026 01:09:15 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com.
 [209.85.217.47]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5be02c74ca8sm4414022e0c.15.2026.07.06.01.09.15
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:09:15 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-738bcf9a573so728922137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:09:15 -0700 (PDT)
X-Received: by 2002:a05:6102:32cd:b0:73a:2195:4386 with SMTP id
 ada2fe7eead31-7427f05af6fmr3257389137.24.1783325349869; Mon, 06 Jul 2026
 01:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-2-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20260705213542.28987-2-laurent.pinchart+renesas@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Jul 2026 10:08:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCqTQ0fWDyHJkU=0gzFe88r0hsSk9tsgfQUZq4TRcAoQ@mail.gmail.com>
X-Gm-Features: AVVi8CeGulURzBLLfkjFzqZ7MqehawY40QKBoJDeR4KrDLoVwstpoZpBrt3N2ag
Message-ID: <CAMuHMdUCqTQ0fWDyHJkU=0gzFe88r0hsSk9tsgfQUZq4TRcAoQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: vga-connector: Allow hardcoding
 EDID
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 linux-renesas-soc@vger.kernel.org
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

Hi Laurent,

On Sun, 5 Jul 2026 at 23:35, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Since DDC version 2, introduced in 1996, VGA monitors have exposed EDID
> data over an I2C bus. The bus is also used to detect the presence of a
> connected monitor by trying to read the EDID data.
>
> Some devices where the VGA display is integrated in the device and
> always connected do not connect the DDC pins. Some development boards,
> such as the Renesas M3N Salvator-XS, also do not connect the DDC pins.
>
> To support those, add the ability to provide hardcoded EDID data in the
> device tree. This is mutually exclusive with specifying a DDC bus, and
> can only be done when the VGA display is guaranteed to be always
> connected.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/display/connector/vga-connector.yaml
> +++ b/Documentation/devicetree/bindings/display/connector/vga-connector.yaml
> @@ -19,10 +19,25 @@ properties:
>      description: phandle link to the I2C controller used for DDC EDID probing
>      $ref: /schemas/types.yaml#/definitions/phandle
>
> +  edid:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description:
> +      When the DDC signals are not wired to the connector, and the connected
> +      display is not removable, this property is used to supply a binary EDID
> +      blob for the display.
> +
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
>      description: Connection to controller providing VGA signals
>
> +allOf:
> +  - if:
> +      required:
> +        - ddc-i2c-bus
> +    then:
> +      properties:
> +        edid: false
> +

What if the DDC signals are wired to the connector on the provider side,
but not on the consumer side?
A DT overlay describing the consumer device can add an edid property,
but it cannot delete the ddc-i2c-bus property in the base DTB.

>  required:
>    - compatible
>    - port

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
