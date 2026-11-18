Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF50606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=GvFhe4m1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B722112079;
	Wed, 18 Nov 2026 22:11:24 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4394D112079
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 22:11:18 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D6AF8D0;
 Wed, 18 Nov 2026 23:08:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795039728;
 bh=mL134ZZgaKNlrGxhoD6JBl2EJLsu/XxLvDh2/+CCBk4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GvFhe4m142rWoM1kDm8uUHvQi6QaZfJpsHRquNXkiSjomHWrinsrXNTSaZr6+G437
 nck8bXwb2/CDjz9oDP/iDqrVdcdKTwvT7zVtN4IVbmsldVRHGu2n4bH/Oq9pLd9zHk
 gn2D8X6Ti/DghDBGJpAXwxd52TSc6m6Voj7uD6BI=
Date: Thu, 19 Nov 2026 00:11:14 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 20/20] drm/rcar-du: Allow VSP and writeback build with
 COMPILE_TEST=y
Message-ID: <20261118221114.GI1923307@killaraus.ideasonboard.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-21-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118214518.29317-21-ville.syrjala@linux.intel.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 11:45:17PM +0200, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Make DRM_RCAR_VSP selectable with COMPILE_TEST=y, and enable the hidden
> DRM_RCAR_WRITEBACK option by default, so the VSP and writeback code gets
> built for greater coverage. Builds fine on x86, x86_64, arm and arm64 at
> least.

Let's see what build bots will report on more exotic architectures. I
may volunteer you to send a fix if I'm too busy when the builders start
yelling :-)

> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/renesas/rcar-du/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> index 80bd770ae0f6..5394f131c58f 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> @@ -76,7 +76,7 @@ config DRM_RCAR_MIPI_DSI
>  	select RESET_CONTROLLER
>  
>  config DRM_RCAR_VSP
> -	bool "R-Car DU VSP Compositor Support" if ARM
> +	bool "R-Car DU VSP Compositor Support" if ARM || COMPILE_TEST

This will make it possible to disable the option when ARM64 &&
COMPILE_TEST, which will break operation on Gen3 and up. It would be
best to avoid that.

>  	default y if ARM64
>  	depends on DRM_RCAR_DU
>  	depends on VIDEO_RENESAS_VSP1=y || (VIDEO_RENESAS_VSP1 && DRM_RCAR_DU=m)
> @@ -85,5 +85,5 @@ config DRM_RCAR_VSP
>  
>  config DRM_RCAR_WRITEBACK
>  	bool
> -	default y if ARM64
> +	default y if ARM64 || COMPILE_TEST
>  	depends on DRM_RCAR_DU

-- 
Regards,

Laurent Pinchart
