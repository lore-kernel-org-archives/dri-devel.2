Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59638606D814
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFTqHdpo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE564112E09;
	Fri,  6 Nov 2026 14:11:33 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCB7112E0E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:11:28 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c3f8d72d7ceso106486666b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 06:11:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793974287; cv=none;
 d=google.com; s=arc-20260327;
 b=P3KhDQnYMTWtnLhs4H8V+wVgxZ4tOez+ovK6ONGnbD2HUcv0QzYCjEmbqvW68vedz9
 LqjGj6NJ8lF2oaU+Lf1xt0zH+0ge37Qbf+J5/HJUzeaW2Qe8GgVILQMKvqGqEWlUc3B6
 aj6sCD55WipWEaAvwBUXzuK76TexrQ8Aqv7Bk3IaC1tPKv3lkD7FSPDD6Eu+GdigDUdo
 cbfWGvP7Ogglum7ozuGa5AEkE2kwNWwvapy7a4PqLTyQmAnU032rHx6GK5HJ2QCCz5yd
 8amZJL+bFg5T9wZqn3Xp6inQiOD/OrpyAQeJ4N8hdlNLbjsNXRpNaACOFoPcNVn0r3WL
 nn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rUBgknGD0vcmexz+RXVBFNFmvAB8yyeZ1WyDa2+Y5Qs=;
 fh=Hzy9IfPX94cibGopUNuNH/XJjPaHruZmIKkLlRT0+88=;
 b=n+4ZoKqoojrWOGtlDgh0L3L7C2TJXXAL+9QLgrBznzg6Ayvv5a8p0r8gCSClomBVKe
 xzH0y4rAXK9WYpX6dlh7v+cV/o0X8RzmkKq/iwc0NaVBm7hdeibQPW77OjRtyn6UXxp5
 zXZR4QrFfBxJiCitb/LAodiBh8C+j8EbAlySwFioGxedt5E6cLy3cmskQRBvtMa58HUQ
 rYbhq8Fs6ar/kipsrlVEDVu6v/zJI03ujReIJCOEZKJX1I1TCF/fYpK12QFiZYH1N5e/
 xX79GewyhId0NBvNYITwds5r/fCuQ4vj/6sbv8mJ83SRC5poyO/aX8BpWfsk4kCT4hYb
 7/vg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793974287; x=1794579087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rUBgknGD0vcmexz+RXVBFNFmvAB8yyeZ1WyDa2+Y5Qs=;
 b=GFTqHdpoqImlExxuPrtS5XqzkqtUQQDWqI4+4S4v3z3gK3iaBSu6Smfl0gFpV4UF1F
 RpHJV2o9NULGPKUtddOl0YCgEtXEFHhnXHwWGG92PhkHAFTpUshLXQExrEjth/nD9lHo
 4oTOmVeMpe5YH03p6wr6280Gslkx+KRPPfbtxbUoZ1uSpWMbqDaQzAaM+0brX43jyAZd
 dgJDjeuP1SAl5Vto3qPA9U/hRCVljfXOtPcy2MWm8bASAxQmUdeuNYGRlqOelrJktMrf
 A/pFAqMyVXsWe6ZZ38fnqXPWBigCTkY6MMKBXZ10dLX5JJaSW0HGdp7oAPmEYt1fgNY/
 D/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793974287; x=1794579087;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rUBgknGD0vcmexz+RXVBFNFmvAB8yyeZ1WyDa2+Y5Qs=;
 b=SwekaDvNLTGcwt+j2Jiqk6ht1Zh4UudD8og7WO+6t1bvNCISoXpLfxGrH0UOCigg6O
 LjrA2ADcjYQUuUmNxqpw9rYtR1f4kKHTbNT+L74b7OASHXHokGAHpDa88ntU6gbDQvb5
 wnnK7umDlUDZUb9CfWiYc6jErSODdlWZJboeXwVKfCafawvhEkQpigEawTaiA271PV0n
 Q3pvsTxB6mrJIfu37+dt8f8hG0Wt9bDHL217yLHOJElXJYpjO6XhTksfUq6r8cIrbw3l
 U3p4vN6E8lQFXziFlM9otCqEBBfPNzxPY+DpQSe0UYuIuBfspMWZz4IhQwY+j2juLgbl
 zJKw==
X-Forwarded-Encrypted: i=1;
 AKwUvByLrUceU29nZCqd2Yat0F0FyMbDidqUCDJM8iNIQY8Umj/kRLsWxny/w41Dvr+HIIOICzMgvnaYQdU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ZhXCZF3oXSBFqShkKXGr1/G1BsF7S0DBUJsblbBIKLXVvZ+vk
 4XWwmTY7NfizZXJCAj3qLJG+jlEizyFqtOIPm3LVSNvzpuclgLNc21fh3DdQQvMchuurL/3Q4Fq
 QT3VKNM7Ykr6r97WAHeRkK+ihNcGpylk=
X-Gm-Gg: AYBFou2ACylumMuSW8Ry1ma1PqKH/szvPrbymlvTF26+HBouCfuFoAOM3LTRKFjC+LE
 UkcxRtCJQW5QlYQtf4sIM/RRKJXL7Z5v3QdAn3r0KqmkIbMRH4JFeQSxFPiQh4LgLVa+XjlTjLC
 Jb/pzbPptym/GDF1V+6DitX2G4z+zc6ri1/LkQMGH7xG/V/21z/4lRWuT7GkI9TCXw+2UY9Q9af
 1gf+noPAHkaV0BlDOLHWoDCJiveaJ8wJnG1k+qhUrgG13HG424QnjzJWOPwudZmVa1HtrgY1fTM
 Ws7uWqB1+5E3CwLBn62V4afoHTunFHkzeLxoQ2tg+v4kBD3yE9kuuTsuovFFP8YUooMzckeu6fE
 l+HxrE58O+At+WH/KBxg/uI+gG0o8FWenQI+54yjKDP3DUPyxNqa6abl9VZ0tv61towpWBDJ0mL
 sbhGS+xVDN+yuOaaW/gXec57Syxywmyw==
X-Received: by 2002:a17:907:3e8e:b0:c44:16ad:c31d with SMTP id
 a640c23a62f3a-c4d3526bc65mr237868866b.4.1793974286564; Fri, 06 Nov 2026
 06:11:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-10-clamor95@gmail.com>
 <au3etybQlb5CtjBL@orome>
In-Reply-To: <au3etybQlb5CtjBL@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 6 Nov 2026 16:11:12 +0200
X-Gm-Features: AclHuK8vFqFS9sw3roYv91eoeg5V28eK0ZMbIUEIj7uPY5ywLKX-LdV7NUmea50
Message-ID: <CAPVz0n3o5pc62eF6gv+PYmJh1KN1a5s=qmjxpNGJfxbCC4tqzQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:08=
 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Nov 05, 2026 at 04:05:09PM +0200, Svyatoslav Ryhel wrote:
> > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > Tegra20/30 SoCs display controller.
> >
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../display/tegra/nvidia,tegra20-dbi.yaml     | 113 ++++++++++++++++++
> >  .../display/tegra/nvidia,tegra20-dc.yaml      |  22 ++++
> >  2 files changed, 135 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvi=
dia,tegra20-dbi.yaml
> >
> [...]
> > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,teg=
ra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
20-dc.yaml
> > index 69be95afd5627..ffeb124905dbf 100644
> > --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc=
.yaml
> > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc=
.yaml
> > @@ -79,6 +79,16 @@ properties:
> >    rgb:
> >      type: object
> >
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^dbi@[0-1]$":
> > +    $ref: /schemas/display/tegra/nvidia,tegra20-dbi.yaml#
>
> I think it might be better to group these under a separate dbi node at
> the top-level, making it a sibling to the "rgb" node. If you add
> #address-cells and #size-cells here, I think that means technically the
> "rgb" is now in the same address space as those new dbi nodes and would
> need its own "reg" property and such.
>

Only 1 DBI node per DC is available. Adding address/size cells means
nothing for rgb.

> Thierry
