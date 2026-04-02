Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3FCCC6B32
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E875310E215;
	Thu,  2 Apr 2026 08:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J+BDRZRI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0745910E215
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 08:30:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A13AE4013D;
 Thu,  2 Apr 2026 08:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA851C116C6;
 Thu,  2 Apr 2026 08:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775118605;
 bh=f3OMYe24BIzLwz52vkVkdJZN5UJgKuGaAdMroDPyOgY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J+BDRZRIryzq9W+DJcm5mHrpA/WR3l89tjf0i8xi9ilHDQ2gJDbgEAJLCVmt51T8j
 6ae+lBAlpR0p0jcxKcyoBgrdct8YlybobJJOAxVn+EN9BtBHsnR19/L5qlh84o1hEi
 H7/lf2oykvKnoUr+DZRzRrH3GbDlQg2W3JoNGxxUhsYv5mO2lTZi5Zrueu7LwCD0bi
 XmugWMIILuL8qJdiDp+BH/+xcSk4rmhCfFPRKDfJNEbgnuXql8Ho6UkjQJzo+CQitm
 24vCOFKECMf+AFeic5oLdk94sIgojTLztryjON44urSgbYw928TTEqSSg30qCQGdin
 ksJe88uNvtiLw==
Date: Thu, 2 Apr 2026 10:30:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 01/19] dt-bindings: display/panel: himax,hx83102:
 describe Waveshare panel
Message-ID: <20260402-sticky-wooden-silkworm-5bdff4@quoll>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-1-5e9119b5a014@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401-waveshare-dsi-touch-v1-1-5e9119b5a014@oss.qualcomm.com>
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

On Wed, Apr 01, 2026 at 10:26:20AM +0300, Dmitry Baryshkov wrote:
> Describe Waveshare 12.3-DSI-TOUCH-A panel which allegedly uses HX83102
> as a panel controller.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> index 66404b425af3..7667428bf9a8 100644
> --- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> @@ -30,6 +30,8 @@ properties:
>            - starry,2082109qfh040022-50e
>            # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
>            - starry,himax83102-j02
> +          # Waveshare 12.3-DSI-TOUCH-A panel
> +          - waveshare,12.3-dsi-touch-a

I don't think we use '.' in compatibles, so waveshare,12-3-dsi-touch-a

Best regards,
Krzysztof

