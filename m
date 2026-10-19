Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBADCCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF5110E7E3;
	Mon, 19 Oct 2026 07:04:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A20710E7F4
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:04:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 474D660233;
 Mon, 19 Oct 2026 07:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F85B1F000C5;
 Mon, 19 Oct 2026 07:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792393453;
 bh=FO84yZZTAadnzRkVXXU8zL0DjWJGnhbCVAk0Bn0id5g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YCtU02DAiOEiVqzNYDGNlgKxAqEetKRqua/aQg2tRSA1tLPJd9clDYSjkQXdCm1qe
 i1kDK6uZZT0hV+oiXQn7l9J/u3lk784AkgTQvxCVpVBbK7JK7rmxHefC/9gAtpksQx
 ZXqEqMRCo8CoYSkDsrhOwSXLtnsJ7temI2ISExBwzMYQ9bTJu82JC4SubOkNCMu4Mg
 cP5uv1+7MUY6dvzpd37vZbxTbfnTuYsYsCm1YkMWKR7QuJ0clhMJ4GJJhrczbuD5Up
 TSzoDOItjqbXYm5Ev0E6bSTp7vaIoyeYuoQvHC2VWHwpdSeoP3CKH6NEiL+djsM4RD
 AhC53HJ5A0uMA==
Date: Mon, 19 Oct 2026 09:04:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, 
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dt-bindings: display: sgd,gktw70sdae4se: use
 unevaluatedProperties
Message-ID: <20261019-vigilant-international-gorilla-cb0eb6@quoll>
References: <20261016190447.752297-1-Frank.Li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016190447.752297-1-Frank.Li@oss.nxp.com>
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

On Fri, Oct 16, 2026 at 03:04:47PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use unevaluatedProperties replace additionalProperties because it ref
> other yaml file to allow backlight and label property.
> 
> Fix below CHECK_DTBS warning:
>   arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dtb: lvds-panel (sgd,gktw70sdae4se): 'backlight', 'label' do not match any of the regexes: '^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/display/panel/sgd,gktw70sdae4se.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
> index 1beb4ba92248b..4c70576fe8a8f 100644
> --- a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
> @@ -49,7 +49,7 @@ required:
>    - height-mm
>    - panel-timing

Then drop the duplicated properties copied from panel-common.

Best regards,
Krzysztof

