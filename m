Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DBA606C8F2
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BeiKpE4Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D55E10E161;
	Tue, 10 Nov 2026 20:28:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DBC10E99E
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:28:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90AF140F82
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7447D1F008A1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794342525;
 bh=YzPcy3JDxWaTCSh9vLfad6QICLHYP98JbuXO7wfCEmw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=BeiKpE4YTA4Xml9UOLVQ78n98hVI2Nd8SzzNUKRbWZdwetwGQroztbvp0bClrYMWH
 HaFfC2wwbeExv1CUNfWB60HOaPBOyqrsyabnsgnNYjIwz20+wo3ahCl+etUXav3hTQ
 zX60y0hoForwLTLvIcVbZnJreQrHagazjAKIJiLubb/NcYCvduOsVYKe9Pl0SKGLvl
 N4AwuJQdruCWNtpcS/bnzUYwoGQ63F5f5sc89ZSHqdKt51Cchg2QKsPavNmFKn2f/+
 jDhK6h0/XVCOSgZ69sE4Vyp+At7tOw9AysXDVMRKAOYjCXkiZaChV2XLa6HWE8blth
 K69CCe/BXmqlA==
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso3723784a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:28:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGQHdoddKl3dUgC7u8yXQqG7QSb1hx8VoGtcz/LXBPcqg3rGz730rwhtvRYt8kgC5rFxD8w5Ad4JrQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/v/8gF2j+muXo52rJlnlGAPoaqa306pcaT5gT2v7zHVY39cWxS
 rndl1PUdLnR/JHYTeXQYRyoOt6ReBzMsMhzL+btkveoRfjceoJDDo+6c7S8kQdFAoYWbDRM07Tp
 3qPh05UyFY1DqgFBwo8fVD6q3OEGQEA==
X-Received: by 2002:a05:6402:e05:b0:6b5:4f5c:cb8 with SMTP id
 4fb4d7f45d1cf-6b77781c362mr293488a12.44.1794342523958; Tue, 10 Nov 2026
 12:28:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110023400.319579-1-festevam@gmail.com>
In-Reply-To: <20261110023400.319579-1-festevam@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 10 Nov 2026 14:28:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJO6rB8o_PD4vPn-Rh9VA3OcforAO7pf2S5pV4vBUYHSg@mail.gmail.com>
X-Gm-Features: AclHuK-NZ6fOyjM4oBJ5iMdBqCUpXBznkor5D6_ATIkN28BuQbdRonv8PJTgNjg
Message-ID: <CAL_JsqJO6rB8o_PD4vPn-Rh9VA3OcforAO7pf2S5pV4vBUYHSg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: imx: Document fsl,pcr
To: Fabio Estevam <festevam@gmail.com>
Cc: p.zabel@pengutronix.de, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 8:34=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Some i.MX25 and i.MX27 devicetree display nodes contain fsl,pcr, but
> the property has no schema type. As a result, dt-core.yaml reports
> its raw bytes as an invalid property:
>
>   imx27-phytec-phycard-s-rdk.dtb: display: fsl,pcr:
>   b'\xf0\xc8\x80\x80' is not of type
>   'object', 'integer', 'array', 'boolean', 'null'
>
> Document fsl,pcr as a uint32. The property belongs to the display node
> referenced by the display phandle and is not valid on the LCD controller
> node.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v1:
> - Explicitly forbid fsl,pcr on the controller through allOf, addressing
>   the Sashiko review, while retaining its uint32 type for decoding the
>   property in legacy display nodes.
>
>  .../devicetree/bindings/display/imx/fsl,imx-lcdc.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.y=
aml b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
> index 84610b5690c4..450f95098c99 100644
> --- a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
> @@ -65,7 +65,17 @@ properties:
>      description:
>        LCDC Sharp Configuration Register value.
>
> +  fsl,pcr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      LCDC Panel Configuration Register value used in the display node
> +      referenced by the display property.
> +
>  allOf:
> +  # Define the type above for decoding, but forbid it on the controller.
> +  - properties:
> +      fsl,pcr: false

That does fix the warning, but still leaves display nodes unvalidated.
This needs to go in a new schema. Since there's no compatible on these
nodes, we need something like this to apply the schema:

select:
  required:
    - fsl,pcr

Then the schema is this property, model, bits-per-pixel and a $ref to
panel-common.yaml.

Rob
