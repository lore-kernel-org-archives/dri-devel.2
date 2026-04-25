Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26681FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 09:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5450E10E112;
	Sat, 25 Apr 2026 09:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XFm/6Ir0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B75710E112
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 09:54:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B4A3A41866;
 Sat, 25 Apr 2026 09:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3858C2BCB5;
 Sat, 25 Apr 2026 09:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777110875;
 bh=RTKJFkZOhPvSkw4w1T5IdZXZkOeETqyobx085qFKyh0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XFm/6Ir0UoLq2kqL/P6LiY88zut5JBR0WxqAguLcedSe9xjim+tjjko8QnNSavNvB
 6XHYz+D2CRO6BO+Gx3lI30y0pu8sO8sOX6CpxHRglsvlm9Rw6z1f7+GdjxgyDy5O0R
 yND4prjQDM0XaTC4XmbUhf1v1XOnxHwEHBcOgOw8vsEu0Cd2YY5L8d18KuRccNSflz
 nTaxduh7rAAWfXdPbK/fNFb3toSgSgXuhr/ZsWWt+TDesHI//MM7Htd8pdphJYKfFy
 sjYg0qnCmpeSTHSeY8IhZEl0jVvcAC/q7OwOcD7RAx03RDyeJt0n9I7i8r9JyOTiNw
 oH4+7vR90xH3Q==
Date: Sat, 25 Apr 2026 11:54:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lukas Timmermann <linux@timmermann.space>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Douglas Anderson <dianders@chromium.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Alexandre Marquet <tb@a-marquet.fr>
Subject: Re: [PATCH 1/5] dt-bindings: display: panel: Document Samsung
 LTL101DL02-002 panel
Message-ID: <20260425-subtle-silent-dolphin-0a7ae3@quoll>
References: <20260423-manta-display-v1-0-196f80c5673a@timmermann.space>
 <20260423-manta-display-v1-1-196f80c5673a@timmermann.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423-manta-display-v1-1-196f80c5673a@timmermann.space>
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

On Thu, Apr 23, 2026 at 11:14:37PM +0200, Lukas Timmermann wrote:
> From: Alexandre Marquet <tb@a-marquet.fr>
> 
> Add the dt-bindings for the LTL101DL02-002 panel.
> 
> Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
> Signed-off-by: Lukas Timmermann	<linux@timmermann.space>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 24e277b19094..2de0a3a6d1fe 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -283,6 +283,8 @@ properties:
>          # Samsung Electronics 10.6" FWXGA (1366x768) TFT LCD panel
>        - samsung,ltl106al01
>          # Samsung Electronics 10.1" WSVGA TFT LCD panel
> +      - samsung,ltl101dl02-002

This looks like incorrectly placed (101 < 106) and comment should be
above the compatible, at least judging by context.

> +        # Samsung Electronics 10.1" WQXGA (2560x1600) TFT LCD panel
>        - samsung,ltn101nt05

Best regards,
Krzysztof

