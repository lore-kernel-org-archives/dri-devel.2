Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D97F433CD
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 22:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9644310E066;
	Wed, 15 Apr 2026 22:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N/qcc5h4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F8410E066
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 22:04:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D5C760123;
 Wed, 15 Apr 2026 22:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D43C19424;
 Wed, 15 Apr 2026 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776290683;
 bh=G8WHssE25KQ6tcDWOQojWxZnoS+qLkfpgZ3Cu4Pcp60=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N/qcc5h4qraB38xx6wKUQzmmnOlQ37RoMzApdWToa84syPrNXCRxo8BegPmq5DlHS
 c5K5J4ypKfrVQ5pG4cim/rZN2+nb/E/GAAIh2Ml3y4chtj0/BtabVlKNgjMP+gc2gX
 xrzrcxj6+gl5F6vSdVE2dzbnY80auQbUJ25t6usO85rxQ4tP9iBrQlJ5Y+y72MjYrf
 gACc1NMwjt4ptPgN3EaLWfvvi0Bd4MyQkSbibeAPrBI7dKf7uP7ykTPJrA+cMQ0CE9
 v/Cxc8tVSsBBNC0Wm+AFb7oBbs0ceSvW+NSXB+u6lGmID1HXDuIW7dMcPl6xUvv2lq
 NY0MKifhfWLlg==
Date: Wed, 15 Apr 2026 17:04:41 -0500
From: Rob Herring <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: rockchip: dw-hdmi: Allow resets
 for Rockchip HDMI
Message-ID: <20260415220441.GA724186-robh@kernel.org>
References: <20260404200434.1954651-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404200434.1954651-1-festevam@gmail.com>
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

On Sat, Apr 04, 2026 at 05:04:34PM -0300, Fabio Estevam wrote:
> The Rockchip DW HDMI binding sets unevaluatedProperties: false while
> also inheriting from synopsys,dw-hdmi.yaml via allOf.
> 
> The Synopsys binding defines the optional properties resets and
> reset-names, but due to dt-schema rules these are not considered
> allowed once unevaluatedProperties: false is set in the Rockchip
> schema unless they are re-declared locally.

That's not how unevaluatedProperties works. There is no resets nor 
reset-names in synopsys,dw-hdmi.yaml.

> 
> This went unnoticed because most Rockchip SoCs do not wire a reset line
> to the HDMI controller in their DTS. The rk3228, however, does use a
> reset, which causes dtbs_check to emit:
> 
> Unevaluated properties are not allowed ('resets', 'reset-names')
> 
> Re-declare these properties in the Rockchip schema so they are accepted
> when present, matching the capabilities of the underlying Synopsys IP
> and fixing the dtbs_check warning for rk3228.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  .../bindings/display/rockchip/rockchip,dw-hdmi.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> index 29716764413a..59fb084bb4fb 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> @@ -113,6 +113,12 @@ properties:
>        - port@0
>        - port@1
>  
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: hdmi
> +
>    rockchip,grf:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> -- 
> 2.43.0
> 
