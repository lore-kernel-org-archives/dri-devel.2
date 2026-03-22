Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E077FC72AD
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 13:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6E110E050;
	Sun, 22 Mar 2026 13:30:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t7IpZlnR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F82710E050
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 13:30:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D88A4429C
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 13:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D65C2BCB8
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774186218;
 bh=+r4DJixed9qR03jrcBvB9qDQ5jUMnFCb5a5xczMslvQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=t7IpZlnROV0e1DCl+84kGg5osfHKgXcocBKtSBG7gA6yyaPgWxIonLs1CChM+T5YG
 tiqlfp1agbFL2+oR3k2F80AMmDAdVAn5HaFHIDjXi2MiIiVuIdmjA23HsVNfqPSZQM
 Q9xjlXAIbg7I9lbti2tQPbHw8e/tOPlNN4vc1/SMiJsAVMus3W4t+n3FpHr9mP6kEo
 YAL+B4mX+GW684f9nRhUiqYai2XqbdPY1+MIzmHlzBlHOg0yXlawOjh3gF6QJ41fUc
 4OpzOE1E0CO+EPOcduFEoxeyiH4YNLPXLMUDWa/Luiq5Z9l3R6wMO51Yk2rM/Gj0+u
 ISYjXp5xZcMsQ==
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso4411651c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 06:30:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVBqHmKEaoMW1V/OcELrGOmcDzvEo840fIU4nYCPoA5LUzfq6BiLS0DI69lfptvJNGof9VIaTsqxkw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKskO+SgPhOdkJvKaseAi0c3LtyqW8bkJPyDnMBwVh3mm2874g
 U6L6uNud9w2L8vyQNPBrgkpOZYM3F/tpwO5HxD4Owz7hjYtbgoK9iF+8b20GMWi4ltNvLrdzXg4
 dwwmIV8YV/lKcwHG8S+Gf7w3iAaFUMg==
X-Received: by 2002:a05:7022:10f:b0:11e:f6ef:4988 with SMTP id
 a92af1059eb24-12a726e7fb3mr3981540c88.36.1774186218230; Sun, 22 Mar 2026
 06:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1771863641.git.l.scorcia@gmail.com>
 <92530e0a31eca1feb822f5c5fd4ac894937dd6c7.1771863641.git.l.scorcia@gmail.com>
In-Reply-To: <92530e0a31eca1feb822f5c5fd4ac894937dd6c7.1771863641.git.l.scorcia@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 22 Mar 2026 13:30:06 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8JiyK0jbRsKfFkSguMNBgLXrMF07fZZ=7iNZWCb3p7Qg@mail.gmail.com>
X-Gm-Features: AaiRm51_S1J__pLk1a4D71_Q_McB7o8n-vG8FQQ5qEkWpejUVhVFdJ1R0hMpTzo
Message-ID: <CAAOTY_8JiyK0jbRsKfFkSguMNBgLXrMF07fZZ=7iNZWCb3p7Qg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: phy: mediatek,dsi-phy: Add support
 for mt8167
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org
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

Hi, Luca:

Luca Leonardo Scorcia <l.scorcia@gmail.com> =E6=96=BC 2026=E5=B9=B42=E6=9C=
=8823=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:26=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Add support for the MediaTek mt8167 SoC: the DSI PHY found
> in this chip is fully compatible with the one found in the mt2701 SoC.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml =
b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> index acdbce937b0a..c6d0bbdbe0e2 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> @@ -23,6 +23,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt7623-mipi-tx
> +              - mediatek,mt8167-mipi-tx
>            - const: mediatek,mt2701-mipi-tx
>        - items:
>            - enum:
> --
> 2.43.0
>
