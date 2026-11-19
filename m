Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32960A2612
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=aJDTIQH3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9006A112413;
	Thu, 19 Nov 2026 13:45:04 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D1A112413
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:44:58 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 476CB4E6;
 Thu, 19 Nov 2026 14:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795095747;
 bh=RYvIe58xJlj7ErolcbbdOSmju00bKoarkrQ+uVLojgs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aJDTIQH3CI55qWEn3ODPlYicMd0IlQHDI5EmkYXfXXjlSb+tkqT5s2yXpD9AgKp85
 K8xDdWyWaaS3elH/hVlxGCTS7mSrnrcS9aGyPrA4cCBoUoii10ULC1oWGKzDrxnzcH
 EVux8675qaNknhnx6Ijld/RzkriT1lwhcwUHonAo=
Date: Thu, 19 Nov 2026 15:44:55 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Robert Foss <rfoss@kernel.org>, dri-devel@lists.freedesktop.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Luca Ceresoli as bridge maintainer
Message-ID: <20261119134455.GB2243298@killaraus.ideasonboard.com>
References: <20261119133533.520180-1-mripard@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119133533.520180-1-mripard@kernel.org>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 02:35:33PM +0100, Maxime Ripard wrote:
> Luca has been one of the most active reviewers of the DRM bridge
> subsystem without having the maintainer status.
> 
> Add him as a maintainer to match the current situation.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thank you Luca.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 58afe23cea51..346111c44951 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8943,14 +8943,14 @@ F:	Documentation/devicetree/bindings/display/atmel/
>  F:	drivers/gpu/drm/atmel-hlcdc/
>  
>  DRM DRIVERS FOR BRIDGE CHIPS
>  M:	Neil Armstrong <neil.armstrong@linaro.org>
>  M:	Dmitry Baryshkov <lumag@kernel.org>
> +M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
>  M:	Robert Foss <rfoss@kernel.org>
>  R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>  R:	Jernej Skrabec <jernej.skrabec@gmail.com>
> -R:	Luca Ceresoli <luca.ceresoli@bootlin.com>
>  S:	Maintained
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:	Documentation/devicetree/bindings/display/bridge/
>  F:	drivers/gpu/drm/bridge/
>  F:	drivers/gpu/drm/display/drm_bridge_connector.c

-- 
Regards,

Laurent Pinchart
