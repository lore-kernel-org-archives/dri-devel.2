Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D5CCA6014
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD2210E104;
	Thu,  8 Oct 2026 17:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QfpLiDo+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5238510E104
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:41:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF065447C7
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968F11F008A3
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791481294;
 bh=5i+jUBNJvJIFB5HiIYZuQDmQj7HbLmugYNNn4gZkj88=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=QfpLiDo+ScFtGJGP/5JODLI0pv8v5KZVTe3aJRCgmwNneXmkgfhJBnTBTYaSE+lTT
 +nZwnnkZq3F682cP6EqkDvLOAmz6rEvskLWzPF+Qz6cUZHR0oqmArJVkOL8+ypYJBJ
 tEksKTJ7nr5OGgwE6kEJKpEbyJsSfseOrtKGq+gqPa9EanBqd8g0deddbYDuBD2Vpw
 2B2piO9VomrzAyAoubg5+a+CsmEO/iy++UgxqNVbbWCyoDlpbRyUxxgi0pepT48rF0
 ve7ESnP+YoqLfYBd8ZdS7lxCAlp4v+SEG48ztNI+pTxA0/FHwnqlItwIJ3uXrn452X
 pcIwYkuYyQ83w==
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c2afa22e1dcso470790166b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 10:41:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxxuHa7h/e3p6e85ou7UarcSRjM4HOkxA2cGQKZ7jjHx4P+kVlyze8DXExr52XilCiWASBr+Qp0k44=@lists.freedesktop.org
X-Gm-Message-State: AFuF++klgMlwCGgLP9wPNWAe1mmCQI/y8IOaFfWbbJnj2B1PVv1kc7jG
 pWJ8ER3+AQCsj92Vz1zQIOPveJy1n9yhRDhOo+xmBw26Aq/+MMQiQg4/0FNc+9GNc9HU8lwKS+W
 N5xMspjAtpe5SK4+32lcZgTLARVStIg==
X-Received: by 2002:a17:907:961e:b0:c2a:34fe:ea4d with SMTP id
 a640c23a62f3a-c317c0b85e3mr582174866b.25.1791481292967; Thu, 08 Oct 2026
 10:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Oct 2026 12:41:21 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
X-Gm-Features: AclHuK9f1ZliBZPCj2LPLQU47t9EaM2IftpsDD1GQ_Z1aWMRTo5dRurMLb5PWy0
Message-ID: <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] dt-bindings: display: ste,
 mcde: Allow power domains
To: Linus Walleij <linusw@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Lee Jones <lee@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

On Sun, Sep 20, 2026 at 5:48=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Document the MCDE power domain.
>
> Keep the legacy EPOD regulator binding unchanged for now.
>
> Assisted-by: LLM
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/ste,mcde.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/ste,mcde.yaml b/Do=
cumentation/devicetree/bindings/display/ste,mcde.yaml
> index 7a12d0b817e6..05e7e4ebc882 100644
> --- a/Documentation/devicetree/bindings/display/ste,mcde.yaml
> +++ b/Documentation/devicetree/bindings/display/ste,mcde.yaml
> @@ -35,6 +35,9 @@ properties:
>    resets:
>      maxItems: 1
>
> +  power-domains:
> +    maxItems: 1
> +
>    epod-supply:
>      description: a phandle to the EPOD regulator
>
> @@ -109,6 +112,7 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/arm/ux500_pm_domains.h>
>      #include <dt-bindings/mfd/dbx500-prcmu.h>
>      #include <dt-bindings/gpio/gpio.h>
>
> @@ -116,6 +120,7 @@ examples:
>        compatible =3D "ste,mcde";
>        reg =3D <0xa0350000 0x1000>;
>        interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +      power-domains =3D <&pm_domains DOMAIN_B2R2_MCDE>;

This patch is in next, but the define is not breaking dt_binding_check.

Rob
