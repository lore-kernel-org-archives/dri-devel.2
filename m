Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DCCF433C6
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 21:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1A910E73F;
	Wed, 15 Apr 2026 21:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MlqArUIt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 456ED10E73F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 21:50:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BEF3460121;
 Wed, 15 Apr 2026 21:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4488BC19424;
 Wed, 15 Apr 2026 21:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776289835;
 bh=zZv3Mkww8nTphQwh1V0TwOj+YI2ytEb4tFmarZkhVo4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MlqArUIty+a0OApUZ12tW4aq169oko7YF+TVnZdlYgY7AwZ4dfcKl9duUROBwu61l
 4WzqqB8HnPQjCN9ReZNFnZ1ce3KPKWVTM9EovAr1b92lgoWavPxCC00T4+HmRbtR3f
 qLvtovadTHg3hlDtV1+6WHC5gjwZp64/F8NZ/ttWCF6mKt/x/x0Y5jcGG1DH1JKY8G
 ExeRwV75468Rj83sWoqTM2SGs/2MYQbEXXAnl7gmaNSToCD6kAIx7GclWh9teykIG3
 7TPi151l2CpKdqotHNWOaJffCj3lhz/RvLjQu5iCyNfifzgLKZaQGJSwAfbaNZCS76
 cRCrt1/t5X7Rw==
Date: Wed, 15 Apr 2026 16:50:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Ravnborg <sam@ravnborg.org>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Liu Ying <victor.liu@nxp.com>, linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: display: simple: Move Innolux
 G156HCE-L01 panel to dual-link
Message-ID: <177628983155.716321.7276086940642809806.robh@kernel.org>
References: <20260404034321.341210-1-marex@nabladev.com>
 <20260404034321.341210-2-marex@nabladev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404034321.341210-2-marex@nabladev.com>
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


On Sat, 04 Apr 2026 05:42:50 +0200, Marek Vasut wrote:
> The Innolux G156HCE-L01 15.6" 1920x1080 24bpp dual-link LVDS TFT panel
> is exactly that, dual-link LVDS panel. Move it into the correct schema,
> which is panel-simple-lvds-dual-ports.yaml.
> 
> Fixes: 3c5e8aa44dfc ("dt-bindings: display: simple: Add Innolux G156HCE-L01 panel")
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Liu Ying <victor.liu@nxp.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../bindings/display/panel/panel-simple-lvds-dual-ports.yaml    | 2 ++
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!

