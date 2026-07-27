Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC9FC53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F9710E707;
	Mon, 27 Jul 2026 20:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CDRs+v50";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F228410E4E4;
 Mon, 27 Jul 2026 20:23:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7248143E00;
 Mon, 27 Jul 2026 20:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC071F00A3A;
 Mon, 27 Jul 2026 20:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785183813;
 bh=roIbNH/RduX4j/JAGLRnJpvgmdn9O369ogKB6aRiAbA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CDRs+v50gJiFQDn8BW+YbATTt/AIpD63bauQmAStdsrLfy2QIN6fnywlDzmam58Wn
 YM4ljdK273tUDAPX1zMrlnJiH+YQ0jYBv7tSF0PYQuG4PdbL7iSLHoo8S0JK3QCY0e
 iVmap1Sy838Bi8RvrOD4VBTWphxjEdI98NWdHNkEgDI1tlUEkWExtk3HsSghvMd91i
 094q6zBGZzI9lIcwSIBJkAW0wwOccoxKMuGxcnWvjJiNKBVjrO2kEFiOXgAQbKej/D
 jNq08qw+nsiCMUFPAKnHES79aLYrms671mig3AZT8xKn5iFJPpPlbShlcE3HeUOH2b
 LtAw3rP/OagAg==
Date: Mon, 27 Jul 2026 22:23:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: display: panel: Modify reset gpio
 number constrain
Message-ID: <20260727-stirring-miraculous-nautilus-e22bda@quoll>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-1-c042266b9eeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-sm8650-7-1-bonded-dsi-v5-1-c042266b9eeb@linaro.org>
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

On Mon, Jul 27, 2026 at 04:08:40PM +0800, Jun Nie wrote:
> Some panel support 2 reset gpio, such as Synaptics R63455. So modify the

There is no such binding for R63455.

> number constrain of gpio to 1 to avoid check failure.

What check failure? Please paste actual warnings (but not fake ones).

> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-common.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> index 087415753d606..7c450d2799808 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> @@ -119,7 +119,7 @@ properties:
>        confused with a backlight enable signal.
>  
>    reset-gpios:
> -    maxItems: 1
> +    minItems: 1

I do not get why all bindings now get completely flexible number of
resets. I am pretty sure not all of them constrain that. It's rather
your task to check it and explain in commit msg.

For example the second random I took to check (ILI7807S) does not
restrict, so you just made that binding accepting 1000 reset lines. Why?

Best regards,
Krzysztof

