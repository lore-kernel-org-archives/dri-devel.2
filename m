Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB66CC6B32
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897E110EFA7;
	Thu,  2 Apr 2026 08:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zt6ZhL/z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6098510EFA7
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 08:30:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6ECFD61868;
 Thu,  2 Apr 2026 08:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9530DC116C6;
 Thu,  2 Apr 2026 08:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775118633;
 bh=HCgPWV6T3P60SAtKnvwq/8iR6b6yFifI5uLic24bmj4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Zt6ZhL/zQ6kNez7OX5q5nWKdOA1t/UBDJDPtfvbl+84/DgflIjTm25t5LckIWEU8m
 rY7R2LPNiJ+rg1XDvPG6jsq2uvPEm9II7BgRpSfFwp71ArQKepkelwc+eB4L6kCAR1
 qyXlkhxjWLkwfXhvIM3orvDrhQrKh11vWUxfViF+grEfNiAoooOHmTVzi29XPgfXi8
 ewhdTsMpXLVym5SlhF0qtuoyDbjsQQVFMMnQZhB6ptrY1GNHrMSzWc8Ce/dyrmguKY
 sZwWYaoegkWUEmjYz48VB4oDRAQilZlxXKpwYezibEzGrSgc/7UboK7p4KrzJN/HA0
 FJDDlP2EPzyfA==
Date: Thu, 2 Apr 2026 10:30:30 +0200
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
Subject: Re: [PATCH 02/19] dt-bindings: display/panel: himax, hx8394: describe
 Waveshare panel
Message-ID: <20260402-masked-vulture-of-improvement-8ae3af@quoll>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-2-5e9119b5a014@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401-waveshare-dsi-touch-v1-2-5e9119b5a014@oss.qualcomm.com>
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

On Wed, Apr 01, 2026 at 10:26:21AM +0300, Dmitry Baryshkov wrote:
> Describe Waveshare 5" and 5" DSI panels which use HX9365-E as a panel
> controller.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> index 84e840e0224f..83c343b02835 100644
> --- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> @@ -23,6 +23,8 @@ properties:
>                - hannstar,hsd060bhw4
>                - microchip,ac40t08a-mipi-panel
>                - powkiddy,x55-panel
> +              - waveshare,5.0-dsi-touch-a
> +              - waveshare,5.5-dsi-touch-a

Same comment about style.

Best regards,
Krzysztof

