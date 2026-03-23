Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D598F483E8
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D921E10E2CA;
	Mon, 23 Mar 2026 19:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oWf6Eotg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FEB10E2CA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 19:31:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 11C42600AC;
 Mon, 23 Mar 2026 19:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87749C4CEF7;
 Mon, 23 Mar 2026 19:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774294278;
 bh=G20CxqU1+UGW3jMquGn0Ml5GLP9YQQvV4BfT9lF/heQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oWf6EotghHJ94y6XisVtCSIuaWRU8U5SBKQ+Npd/0KQlToN9cqxLPMA0o2DeGQKTx
 md9aNoSqff3bF6SGoQTvkKqdc7g7tbzMwH2s4+9fFylyjwURmXWgId5Xeq1DbdNtOE
 3MB+rggjxUuKC09Rb52v9AMu8UdxMOBkDSyR4t+myYDxc6jHNMEf1fmQ2R7iCpE4sP
 i4RmpOIBogJkmRHW8ekq+HVgCu8nJLghIkSdwLwkgeDM4fGfBde5NEAL/NL3u0Te3o
 Wo/chRxpvRHaBOGZ6nWKbrtx92AKHIrdXTJZrSObmnU/TMeRI6v1WiBhp2feePJTBE
 Nx81EpcyHdYLA==
Date: Mon, 23 Mar 2026 14:31:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Artur Weber <aweber.kernel@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Simona Vetter <simona@ffwll.ch>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] dt-bindings: display: panel: Align style of "true"
 properties
Message-ID: <177429427708.1201655.1282560740114518028.robh@kernel.org>
References: <20260313-dt-bindings-display-panel-clean-v2-1-d49615218f92@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-dt-bindings-display-panel-clean-v2-1-d49615218f92@oss.qualcomm.com>
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


On Fri, 13 Mar 2026 09:20:54 +0100, Krzysztof Kozlowski wrote:
> For code readability, several bindings which list allowed properties
> with ": true" syntax group them in one place, without line breaks
> between each.  Align a few bindings to match this style.  No functional
> impact.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop applied patches 1-4
> - Rebase (jadard,jd9365da-h3.yaml change is gone)
> - Link to v1: https://patch.msgid.link/20260306-dt-bindings-display-panel-clean-v1-0-3086eda1efaf@oss.qualcomm.com
> 
> BR,
> Krzysztof
> ---
>  .../devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml | 1 -
>  Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml  | 3 ---
>  .../devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml    | 1 +
>  .../devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml    | 1 +
>  .../devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml    | 5 ++---
>  .../devicetree/bindings/display/panel/novatek,nt35510.yaml         | 3 ++-
>  .../devicetree/bindings/display/panel/renesas,r61307.yaml          | 3 +--
>  .../devicetree/bindings/display/panel/renesas,r69328.yaml          | 1 -
>  .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml    | 5 ++---
>  .../bindings/display/panel/sony,tulip-truly-nt35521.yaml           | 2 --
>  .../devicetree/bindings/display/panel/startek,kd070fhfid015.yaml   | 7 ++-----
>  11 files changed, 11 insertions(+), 21 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

