Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6075CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 22:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233D610E149;
	Wed, 13 May 2026 22:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rBf2ecT/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030DA10E149
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 22:23:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A3C0543BE8;
 Wed, 13 May 2026 22:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1980FC19425;
 Wed, 13 May 2026 22:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778711023;
 bh=t+tir+PRgneAWfWoTC5RK7pzxvSMpABDsyPgzRiVycs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rBf2ecT/Ub9ZjYRcDiQ7NU8Uw3D3NceGGbNVUrDIg8QncThENHBU3aC5KmpwmNIXD
 7wwvfFh1ITwyYhjYhOMV4N9atieblKVULCp6m/SEKFrWH5j9drTV4Ci98B5G/BtJdQ
 fnRn9N3M0BmScwk10XBaRG20G4UlUSa4br7JrVZpTPOjFxIlxLptDSiQizXXu+MhrV
 KIkMUFvoPcLi6W2NwKwDX//OCud0BQCl9eQ3pfi63bAd9+rydQfKQatzqDP7VE0Y+8
 fYxTnlpMWndrh0Upkl7cTe9WMfRKvHAst+DMFg1MzVFVLcOcYnBhKFwXzWhwut/oro
 e0wlTS3NDp4cw==
Date: Wed, 13 May 2026 17:23:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 David Airlie <airlied@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, geert@linux-m68k.org,
 Conor Dooley <conor+dt@kernel.org>, laurent.pinchart@ideasonboard.com,
 Philipp Zabel <p.zabel@pengutronix.de>, tomm.merciai@gmail.com,
 biju.das.jz@bp.renesas.com, dri-devel@lists.freedesktop.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v7 01/13] dt-bindings: display: renesas,rzg2l-du: Refuse
 port@1 for RZ/G2UL
Message-ID: <177871101980.2066607.4695270235260805346.robh@kernel.org>
References: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
 <d1e0d4e0fe74e60345a3d043fb4f9128c1057638.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e0d4e0fe74e60345a3d043fb4f9128c1057638.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
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


On Thu, 07 May 2026 11:21:29 +0200, Tommaso Merciai wrote:
> The RZ/G2UL DU supports only a single port@0 DPI. Explicitly refuse
> port@1 in the ports node.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v6->v7:
>  - Collected LPinchart tag.
>  - Removed wrong fixes tag.
> 
> v5->v6:
>  - New patch.
> 
>  Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

