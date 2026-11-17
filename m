Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E831606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=pJTY8rIr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA18710FA03;
	Tue, 17 Nov 2026 23:53:55 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B8910E70E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:53:49 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id E91F8270;
 Wed, 18 Nov 2026 00:51:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794959480;
 bh=D9pHEAaEM16jOPMDP7nMOOaeLdVh58OFjjJ0wjOM0IE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pJTY8rIr6/Nu8dZisvD58CIxy2ErFfgwqp67fq996BSr909W0gCnCWFP6HLxOVXIl
 yq5L/hZijX5ckrHclUyg4MFxfb3QrE8NgBcqmIB0NUJ33c+ux/ozXT2Df6FqYFXCHL
 gL+iqfN6HP9s4jEbFl8DLpZKfb/aeF77v41aLdNk=
Date: Wed, 18 Nov 2026 01:53:46 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 25/64] drm/rcar-du: Switch to
 drm_mode_config_create_initial_state
Message-ID: <20261117235346.GC1923307@killaraus.ideasonboard.com>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-25-0bb471f4d1e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116-drm-no-more-config-reset-v2-25-0bb471f4d1e0@kernel.org>
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

Hi Maxime,

Thank you for the patch.

On Mon, Nov 16, 2026 at 11:30:41AM +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
> 
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
> 
> Switch to drm_mode_config_create_initial_state().
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> index 9228a7ad0dfa..7fddde804dc6 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> @@ -1000,11 +1000,13 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
>  	 * DPAD0.
>  	 */
>  	dpad0_sources = rcdu->info->routes[RCAR_DU_OUTPUT_DPAD0].possible_crtcs;
>  	rcdu->dpad0_source = ffs(dpad0_sources) - 1;
>  
> -	drm_mode_config_reset(dev);
> +	ret = drm_mode_config_create_initial_state(dev);
> +	if (ret)
> +		return ret;
>  
>  	drm_kms_helper_poll_init(dev);
>  
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart
