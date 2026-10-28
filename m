Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9553606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esQ7Oyto
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F47010FCB4;
	Wed, 28 Oct 2026 13:56:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7358710FCA4
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:56:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B754860120;
 Wed, 28 Oct 2026 13:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAE51F01825;
 Wed, 28 Oct 2026 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793195806;
 bh=WK5sk39IWL7HCAndDbLDTrsiR8zV8GUj6O6QAjBlZ4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=esQ7Oyto5mB0VOu0lcCdAArHJ2Dcs9mkwBLhZQONuSOEpbtRNx6+aIWdIzF92J/TN
 YukRaoZhT+qqPxUsJmrdgNvqAWHWoQe58CDceeAn6jMOZ91keFnI/NJMmyKQ+kTpvG
 w0sTMupoccSzq6Y4YP1a6GnXOoLkKCBBuSxkCXC4UtdKXH3f252NMw/gKqe1EWgeyL
 4YC77oqleuOIBGr+z5ACZhK/y3RGC9U8p6QVbUtWqoNCcUYg9urXCaGCZxmT6V2sE/
 F/laMIdw7IJtdNL4LTCHnum2ch7zydOSeVTQVKKwbF4l+YcxYYMYg+sEUHAbY6+/ar
 M4YD29OapLDfg==
Date: Wed, 28 Oct 2026 14:56:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: display: panel: novatek,nt36672e:
 Document the reset GPIO polarity
Message-ID: <20261028-seagull-of-illegal-prestige-6cbbfa@quoll>
References: <20261028095151.1682096-1-vz@kernel.org>
 <20261028095151.1682096-2-vz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028095151.1682096-2-vz@kernel.org>
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

On Wed, Oct 28, 2026 at 11:51:44AM +0200, Vladimir Zapolskiy wrote:
> The reset GPIO of NT36672E panels has been described as active high since
> the binding was added, also see the example and the QCM6490 IDP board
> device tree, however actually it serves as the active low signal, also
> panel-common.yaml expects active low reset GPIOs to be described as such.
> 
> Document the active high description of the reset GPIO explicitly as
> the exceptional deviation from the actual signal polarity, any new devices
> will use it in the same way as the existing ones.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---
>  .../bindings/display/panel/novatek,nt36672e.yaml         | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
> index dc4672f3d01d..45743376995b 100644
> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
> @@ -24,7 +24,14 @@ properties:
>    avdd-supply: true
>    avee-supply: true
>    port: true
> -  reset-gpios: true
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the reset pin of the panel. The GPIO must be described
> +      as active high (GPIO_ACTIVE_HIGH), the asserted state releases the panel

I disagree that it has to be active high, because, since we do not
represent pin inverters in DT, it depends on board layout. Wording would
need to be correct if this stays.

> +      from reset. Note that the RESET_N pin is in fact an active low signal,
> +      the inverted description is kept for compatibility with existing device
> +      trees, while it deviates from the convention of panel-common.yaml.

We might fix it at some point, so not sure if it is worth documenting in
the binding. And what about usage of this binding in other projects
which implement it correctly?

Best regards,
Krzysztof

