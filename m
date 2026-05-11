Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3D5CD37B2
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 15:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7590C10E1C9;
	Mon, 11 May 2026 15:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="k/nqdyIA";
	dkim-atps=neutral
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F41010E1C9
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=default;
 h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
 To:From:Date:subject:date:message-id:reply-to;
 bh=S08ARNK4JyjFSmUJ+5xcB6ex0c/0uNFUV+SgRIJsO5s=; b=k/nqdyIA4uz/7q7lLSmEW3s1Lh
 mpcsX4NwWiCr/zGvf1NN8TyRDt9KBqs/gYg/5h0m9Jshi34R5p19KCtp6w2+dv8f1pxclfwKjm4zR
 iIZIFJDLiPQ8cni40gI+YrmvclJtLmWcE1+6gh46GICm359dhW4KeN80P8nsR81p1cuk=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]
 helo=debian-lenovo) by mail.hugovil.com with esmtpa (Exim 4.98.2)
 (envelope-from <hugo@hugovil.com>) id 1wMSng-000000004IO-1xyo;
 Mon, 11 May 2026 11:44:08 -0400
Date: Mon, 11 May 2026 11:44:06 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: krzk@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, Frank.Li@nxp.com, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org,
 laurent.pinchart+renesas@ideasonboard.com, antonin.godard@bootlin.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 14/15] dt-bindings: display/lvds-codec: add
 ti,sn65lvds93
Message-Id: <20260511114406.24673c770d112b2ca4aba2eb@hugovil.com>
In-Reply-To: <20260305180651.1827087-15-hugo@hugovil.com>
References: <20260305180651.1827087-1-hugo@hugovil.com>
 <20260305180651.1827087-15-hugo@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --
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

Hi,

On Thu,  5 Mar 2026 13:06:29 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add compatible string for TI SN65LVDS93. Similar to
> SN65LVDS83 but with an industrial temperature range.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Now that this series landed in linux-next/master, except for this
patch, we now have an error since it is required:

https://lore.kernel.org/oe-kbuild-all/202605071909.lXKPelNA-lkp@intel.com/

Hugo.


> ---
>  Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> index 4f52e35d02537..f2cb74b86cc05 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> @@ -37,6 +37,7 @@ properties:
>                - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
>                - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
>                - ti,sn75lvds83 # For the TI SN75LVDS83 FlatLink transmitter
> +              - ti,sn75lvds93 # For the TI SN75LVDS93 FlatLink transmitter
>            - const: lvds-encoder # Generic LVDS encoder compatible fallback
>        - items:
>            - enum:
> -- 
> 2.47.3
> 
> 


Hugo Villeneuve <hugo@hugovil.com>
