Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3349606A327
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mz+siG7D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B9010E24F;
	Sun, 15 Nov 2026 14:06:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA79210E24F
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:06:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B93645A88
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A0D1F000CF
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794751588;
 bh=Yjh8Gm7XLBcgfYiYP3LTQh3dAygMMLi9uTvlwpldUyI=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=mz+siG7D/yfCsaQUtmvyh2TtPp6RSL+xZHuVfQQpgQhiqnFA2hy66sFqJDYv/zhNN
 PZdl2f5jnz2cqc1ntx0TIL/cO1Z0Kh+VIfLZI8tPEkRNIx2NwRPylPxwO04vLWiK/C
 S/tzsizO2aQtz305oM/Q/OG/w+H4MHYJduUfF7hKbiu9ouFFLGxed4MMPRDyLH/eDG
 hMtlbugIRv5AqQQEF5MAIKv7X7WhfHNaoVQIgvD4XmINyiuNwknyiWuDimQGiag2xB
 vmscKeRolp3ztysYOwCMZUOKT9oN5lIzDVQYCH3SP/dTdMtB1CQAPEP/qgiHKxh2iZ
 XHTmXMjR20iDA==
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-3adf87fc0c6so22408661fa.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:06:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErFpfxE9Je3GkqIEtTweAboBTfgKR7gz2QRUhyPA7+i4Ypnc2lOcOmXeq032JYA7T0qLeyz+eVVpcBo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9DVU7M7my7B28qf3eKjPE0F5FVzowc0YdXtlxgJZO7vzbFdwzl
 KAuxTu6arYSgsvlAKA+GxFX1gfSTxrbqzJRYxgdOM/KIhVCIhsU7uniWzS56gELznnZez960biG
 0oB1bEW3R6YEcCf5loSVZUhEZ4nhjd7M=
X-Received: by 2002:a05:651c:41d1:b0:3ab:1207:bd2f with SMTP id
 38308e7fff4ca-3ae2b4bad8cmr29149331fa.11.1794751586867; Sun, 15 Nov 2026
 06:06:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
 <20261115061102.229680-8-jernej.skrabec@gmail.com>
In-Reply-To: <20261115061102.229680-8-jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 15 Nov 2026 22:06:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Kkiz=ns+DGS-nGeX7c_nT61B-CkXggqq0K2uxXGQ1UQ@mail.gmail.com>
X-Gm-Features: AclHuK-7yda1JGDc_9OgA1yiAcJwBx1hvDReZ63bJlhLUfk9UlCfGoWhOH0aQLI
Message-ID: <CAGb2v67Kkiz=ns+DGS-nGeX7c_nT61B-CkXggqq0K2uxXGQ1UQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] dt-bindings: display: allwinner: Split H616 DE33
 layer reg space
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, mripard@kernel.org, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 bmasney+clk@redhat.com, jbrunet+clk@baylibre.com, sboyd@kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: wens@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 2:11=E2=80=AFPM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> As it turns out, current H616 DE33 binding was written based on
> incomplete understanding of DE33 design. Namely, planes are shared
> resource and not tied to specific mixer, which was the case for previous
> generations of Display Engine (DE3 and earlier).
>
> This means that current DE33 binding doesn't properly reflect HW and
> using it would mean that second mixer (used for second display output)
> can't be supported.
>
> Remove layer register space, which will be represented with additional
> node, and replace it with phandle, which will point to that new, shared
> node. That way, all mixers can share same layers.
>
> This change is intentionally not backward compatible and the old binding
> will not be supported by the driver, for the following reasons:
>
> - It can't describe the hardware. Plane register space is shared
>   between all mixers, but the old binding puts it in the mixer node, so
>   only one mixer can ever claim it. The second mixer can't be supported
>   with the old binding at all. It also has no way to reference plane to
>   mixer mapping registers, which live in display clocks register space.
>
> - Supporting it would mean keeping a second, mixer-local plane
>   management path in the driver, with hardcoded plane mapping, which
>   doesn't match the hardware and which can't be tested, since nothing
>   uses it.
>
> - It was never used. Upstream H616 DT has no Display Engine nodes and
>   the rest of H616 display pipeline (TCON, HDMI, PHY) is not supported
>   upstream yet, so the old binding never produced a working display.
>   Vendor BSP kernels use a completely different DT structure and no
>   other known DT consumer (U-Boot, *BSD, Zephyr, TF-A, ...) implements
>   H616 display support. Only out of tree WIP patches used it and those
>   are updated together with the kernel.
>
> The driver will print an error, asking to update the device tree, when
> the old binding is detected.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  .../display/allwinner,sun8i-a83t-de2-mixer.yaml  | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun8i-a8=
3t-de2-mixer.yaml b/Documentation/devicetree/bindings/display/allwinner,sun=
8i-a83t-de2-mixer.yaml
> index cbd18fd83e52..064e4ca7e419 100644
> --- a/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-=
mixer.yaml
> +++ b/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-=
mixer.yaml
> @@ -46,6 +46,10 @@ properties:
>    resets:
>      maxItems: 1
>
> +  allwinner,planes:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle of Display Engine 3.3 planes node
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>
> @@ -74,22 +78,22 @@ allOf:
>        properties:
>          reg:
>            description: |
> -            Registers for controlling individual layers of the display
> -            engine (layers), global control (top), and display blending
> -            control (display). Names are from Allwinner BSP kernel.
> -          maxItems: 3
> +            Registers for display blending control (display) and global
> +            control (top). Names are from Allwinner BSP kernel.
> +          maxItems: 2
>          reg-names:
>            items:
> -            - const: layers
> -            - const: top
>              - const: display
> +            - const: top
>        required:
>          - reg-names
> +        - allwinner,planes
>
>      else:
>        properties:
>          reg:
>            maxItems: 1
> +        allwinner,planes: false
>
>  required:
>    - compatible
> --
> 2.43.0
>
>
