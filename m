Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACB9CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22BE10E958;
	Mon, 28 Sep 2026 18:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KjiehFGp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6951910E958
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 18:06:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2173740D67;
 Mon, 28 Sep 2026 18:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6C21F000FF;
 Mon, 28 Sep 2026 18:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790618783;
 bh=aYldhp63gqqElGNmRC6PMgfH46jUqNkTFt2ODx1S+eA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KjiehFGpS9E+8ymr4umui3tqvLe8LlfwD7Vy9L0NbBWkfTb3U1S2ryoqfi1K6DJI7
 E8v4Uk29AhNZn/MAIc8BZIPhhYBd3ED1X3bMmTYIhkIYxLaRGOkLDdTpwJ1v/cNxT4
 UZ7Ak/4ucxbdEYfGgciww+Dp/covHUlCaai4wITcBMapv3CQqEx4Fs/wwN+EzCrLib
 qGK8B2qeyFrMYtxnUuURVDlOqcEPRHh3H2QsUDvXLDo4TiiTWx7OxmGEthC/sAIt+j
 lv24REPghJNhs8biXDigMBLSaBjR4sXZmvs+S+4BTSpj6iu1sFTqQt2vp5fnITh23k
 2WxF9RIlpz/Ug==
Date: Mon, 28 Sep 2026 13:06:20 -0500
From: Rob Herring <robh@kernel.org>
To: Alexey Minnekhanov <alexeymin@minlexx.ru>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>,
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] dt-bindings: display: novatek, nt36672a: Add 5 new
 panels
Message-ID: <20260928180620.GA120999-robh@kernel.org>
References: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
 <20260917-nt36672a-panels-v2-3-f8de8be5b86f@minlexx.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-nt36672a-panels-v2-3-f8de8be5b86f@minlexx.ru>
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

On Thu, Sep 17, 2026 at 07:43:05PM +0300, Alexey Minnekhanov wrote:
> Document 5 new panels used in 4 different smartphones produced by
> Xiaomi and ASUS:
> 
>  * Shenchao panel used in Xiaomi Redmi Note 7 (xiaomi-lavender), the
>   exact model string is unknown
>  * Tianma TL063FVMC43-02 for Xiaomi Redmi Note 6 Pro (xiaomi-tulip)
>  * Tianma TL063FVMCA01-00 for Xiaomi Redmi Note 7 (xiaomi-lavender)
>  * Tianma TL060FVXS16-00 for Xiaomi Mi A2 smartphone (xiaomi-jasmine)
>  * TXD TXDI600YANPA-43V3 Asus Zenfone Max Pro M1 (asus-x00td)
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> 
> ---
> v2:
>  * changed description to mention several panels instead of one
>  * fixed alphabetical ordering of compatible strings
>  * changed vendor prefix of TXD: "txd" -> "txdkj"
> ---
>  .../devicetree/bindings/display/panel/novatek,nt36672a.yaml   | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> index 5d16d85117254..62ec3294b9b68 100644
> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> @@ -10,10 +10,8 @@ maintainers:
>    - Sumit Semwal <sumit.semwal@linaro.org>
>  
>  description: |
> -  The nt36672a IC from Novatek is a generic DSI Panel IC used to drive dsi
> -  panels.
> -  Right now, support is added only for a Tianma FHD+ LCD display panel with a
> -  resolution of 1080x2246. It is a video mode DSI panel.
> +  The NT36672A IC from Novatek is a generic DSI Panel IC used to drive dsi
> +  panels. Currently supports 6 panel models for 5 different smartphones.

Drop the last sentence. Not something we want to have to update each 
time. With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
