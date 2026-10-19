Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5460B3992
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=PuczZczY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9F410E122;
	Mon, 19 Oct 2026 15:26:39 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D9410EE4A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:26:33 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D26A756D;
 Mon, 19 Oct 2026 17:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792423466;
 bh=HOXUOqZNqxk+jJbTz2s4LyBRoCduEwrzq/BPXWMRxt8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PuczZczYz+T9/BbPDCCi4JOO84l3i/3NTo7RPeafAtxARl4Ny6KAyFV92+Pfl6qZT
 1Y2pGQgTUKKR+r7O+hDazcRRvLp6wOKG0bmuWtAoHscOMs1ie8lkmNdedP0ep07lsr
 ulueqfOE1r6fUNV4dfzru8Yy8Kx0bc7WPkH2dy5A=
Date: Mon, 19 Oct 2026 18:26:30 +0300
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
Subject: Re: [PATCH 71/75] drm/rcar-du: Convert to atomic_create_state
Message-ID: <20261019152630.GB5830@killaraus.ideasonboard.com>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-71-586c9c026823@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-71-586c9c026823@kernel.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

Thank you for the patch.

On Wed, Oct 14, 2026 at 07:27:34PM +0200, Maxime Ripard wrote:
> The rcar-du writeback connector reset implementation creates a custom
> state subclass, but only initializes a pristine state without resetting
> any hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index e5e6e6a156aa..9cb1af182fa0 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -113,28 +113,25 @@ static void rcar_du_wb_conn_destroy_state(struct drm_connector *connector,
>  {
>  	__drm_atomic_helper_connector_destroy_state(state);
>  	kfree(to_rcar_wb_conn_state(state));
>  }
>  
> -static void rcar_du_wb_conn_reset(struct drm_connector *connector)
> +static struct drm_connector_state *rcar_du_wb_conn_create_state(struct drm_connector *connector)

static struct drm_connector_state *
rcar_du_wb_conn_create_state(struct drm_connector *connector)

With that,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

No need to send a new version, you can address this when applying.

>  {
>  	struct rcar_du_wb_conn_state *state;
>  
> -	if (connector->state) {
> -		rcar_du_wb_conn_destroy_state(connector, connector->state);
> -		connector->state = NULL;
> -	}
> -
>  	state = kzalloc_obj(*state);
>  	if (state == NULL)
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  
> -	__drm_atomic_helper_connector_reset(connector, &state->state);
> +	__drm_atomic_helper_connector_state_init(&state->state, connector);
> +
> +	return &state->state;
>  }
>  
>  static const struct drm_connector_funcs rcar_du_wb_conn_funcs = {
> -	.reset = rcar_du_wb_conn_reset,
> +	.atomic_create_state = rcar_du_wb_conn_create_state,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
>  	.atomic_duplicate_state = rcar_du_wb_conn_duplicate_state,
>  	.atomic_destroy_state = rcar_du_wb_conn_destroy_state,
>  };

-- 
Regards,

Laurent Pinchart
