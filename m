Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CB606A32E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nmLlUblR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C19910EC12;
	Mon, 23 Nov 2026 10:47:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEE810E96F;
 Mon, 23 Nov 2026 10:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795430864; x=1826966864;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ImN/GcJEZnpjBIbOaXks5rnPdwOLOe58JckU5ziVAPo=;
 b=nmLlUblRkDxflZTVf8AtOEXsX6aDX8vPPOVESEnFhPAFrE/lf+FFlS+O
 8ef78gJC5CrGtIocPcZ+BvudqU0bsuZuSLcmnFo7D/NMyTX5so6gU/vYT
 TURJJDU+yJgFPXJQ+stA8UgDGs+TjHWQMZ5lnPCD5Mam11/6gujtW3tWb
 S0ZXHiq6+ON/hkdat5fD2onT+XY5K4McicoHLvWGJIjjPxnm+rfuaQ/NG
 wbjKW7tv2zW5mSqEJ1Jgz3YwOSl+NVGIsVBrZ3mGMeLP5ZmQpPz1nrmXV
 Um5JeJlPpvffGQ6/Fyf2FwIQQuBtbSPNK+pQTRw6RD/PZzj1NhX/9GWYl A==;
X-CSE-ConnectionGUID: 1FcObKwVR8+/dL1I3tpU+w==
X-CSE-MsgGUID: Zaqq5aEoSBmECbnUZqujfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4208571"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4208571"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 02:47:44 -0800
X-CSE-ConnectionGUID: OBsJNl9JTVSeA0zRvidkcA==
X-CSE-MsgGUID: Ds4eSRghS86Bb2OCFw1Apg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11417010"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.170])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 02:47:41 -0800
Date: Mon, 23 Nov 2026 12:47:38 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/atomic: Prefer drm_WARN_ON() over WARN_ON() in
 drm_atomic_get_*_state()
Message-ID: <awQZyrEnEB7bi9rW@intel.com>
References: <20261119234423.11666-1-ville.syrjala@linux.intel.com>
 <20261119234423.11666-2-ville.syrjala@linux.intel.com>
 <fb37a5cf-83a3-4d91-9086-804c0913755d@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb37a5cf-83a3-4d91-9086-804c0913755d@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 01:20:03PM +0530, Borah, Chaitanya Kumar wrote:
> 
> 
> On 11/20/2026 5:14 AM, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > Change all the get_state() acquire_ctx WARNs to use drm_WARN_ON()
> > instead of WARN_ON() so we get to know which device triggered it.
> > 
> 
> LGTM
> Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

Thanks. Series pushed to drm-misc-next.

> 
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >   drivers/gpu/drm/drm_atomic.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index b0843e5a9e4d..324e79152e17 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -473,7 +473,7 @@ drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
> >   	int ret;
> >   	struct drm_crtc_state *crtc_state;
> >   
> > -	WARN_ON(!state->acquire_ctx);
> > +	drm_WARN_ON(state->dev, !state->acquire_ctx);
> >   	drm_WARN_ON(state->dev, state->checked);
> >   
> >   	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> > @@ -666,7 +666,7 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
> >   	int ret;
> >   	struct drm_plane_state *plane_state;
> >   
> > -	WARN_ON(!state->acquire_ctx);
> > +	drm_WARN_ON(state->dev, !state->acquire_ctx);
> >   	drm_WARN_ON(state->dev, state->checked);
> >   
> >   	/* the legacy pointers should never be set */
> > @@ -741,7 +741,7 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
> >   	int ret;
> >   	struct drm_colorop_state *colorop_state;
> >   
> > -	WARN_ON(!state->acquire_ctx);
> > +	drm_WARN_ON(state->dev, !state->acquire_ctx);
> >   	drm_WARN_ON(state->dev, state->checked);
> >   
> >   	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
> > @@ -1144,7 +1144,7 @@ drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
> >   	int ret;
> >   	struct drm_private_state *obj_state;
> >   
> > -	WARN_ON(!state->acquire_ctx);
> > +	drm_WARN_ON(state->dev, !state->acquire_ctx);
> >   	drm_WARN_ON(state->dev, state->checked);
> >   
> >   	obj_state = drm_atomic_get_new_private_obj_state(state, obj);
> > @@ -1459,7 +1459,7 @@ drm_atomic_get_connector_state(struct drm_atomic_commit *state,
> >   	struct drm_mode_config *config = &connector->dev->mode_config;
> >   	struct drm_connector_state *connector_state;
> >   
> > -	WARN_ON(!state->acquire_ctx);
> > +	drm_WARN_ON(state->dev, !state->acquire_ctx);
> >   	drm_WARN_ON(state->dev, state->checked);
> >   
> >   	ret = drm_modeset_lock(&config->connection_mutex, state->acquire_ctx);

-- 
Ville Syrjälä
Intel
