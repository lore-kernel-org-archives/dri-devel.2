Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEB5CD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 00:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36DA10E234;
	Thu,  7 May 2026 00:23:13 +0000 (UTC)
Received: from h6.fbrelay.privateemail.com (h6.fbrelay.privateemail.com
 [162.0.218.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 456E110E21A;
 Thu,  7 May 2026 00:23:12 +0000 (UTC)
Received: from MTA-13-4.privateemail.com (mta-13-1.privateemail.com
 [198.54.122.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4g9tJF5n7mz2xBd;
 Thu,  7 May 2026 00:23:09 +0000 (UTC)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
 by mta-13.privateemail.com (Postfix) with ESMTP id 4g9tJB64Szz3hhTD;
 Wed,  6 May 2026 20:23:06 -0400 (EDT)
Received: from hal-station.localdomain (unknown [174.91.51.28])
 by mta-13.privateemail.com (Postfix) with ESMTPA;
 Wed,  6 May 2026 20:22:32 -0400 (EDT)
Date: Wed, 6 May 2026 20:22:26 -0400
From: Hamza Mahfooz <someguy@effective-light.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Takashi Iwai <tiwai@suse.de>, Colin Ian King <colin.i.king@gmail.com>,
 Charlene Liu <charlene.liu@amd.com>, Kees Cook <kees@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] drm/atomic: attempt full modeset on page flip
 timeout
Message-ID: <afvbQkKW3vo-d55q@hal-station.localdomain>
References: <20260505182105.420525-1-someguy@effective-light.com>
 <afuMqXoBt2oIFRm9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afuMqXoBt2oIFRm9@intel.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: 4g9tJF5n7mz2xBd
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

On Wed, May 06, 2026 at 09:47:05PM +0300, Ville Syrjälä wrote:
> On Tue, May 05, 2026 at 02:20:57PM -0400, Hamza Mahfooz wrote:
> > We should try to recover from page flip timeouts. Forcing
> > a full modeset should be generic across all atomic KMS drivers,
> > so try that first.
> > 
> > Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 49 +++++++++++++++++++++++++++--
> >  1 file changed, 46 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index a768398a1884..7ee9d52f63c5 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -1926,6 +1926,43 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_wait_for_vblanks);
> >  
> > +static int force_full_modeset(struct drm_crtc *crtc)
> > +{
> > +	struct drm_modeset_acquire_ctx ctx;
> > +	struct drm_crtc_state *crtc_state;
> > +	struct drm_atomic_state *state;
> > +	int ret;
> > +	int err;
> > +
> > +	if (drm_atomic_crtc_needs_modeset(crtc->state))
> > +		return -EBUSY;
> > +
> > +	DRM_MODESET_LOCK_ALL_BEGIN(crtc->dev, ctx, 0, err);
> > +	state = drm_atomic_state_alloc(crtc->dev);
> > +	if (!state)
> > +		return -ENOMEM;
> > +
> > +	state->acquire_ctx = &ctx;
> > +
> > +	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> > +	if (IS_ERR(crtc_state)) {
> > +		ret = PTR_ERR(crtc_state);
> > +		goto out;
> > +	}
> > +
> > +	crtc_state->mode_changed = true;
> > +
> > +	drm_info(crtc->dev,
> > +		 "[CRTC:%d:%s] Attempting force full modeset...\n",
> > +		 crtc->base.id, crtc->name);
> > +
> > +	ret = drm_atomic_commit(state);
> > +out:
> > +	drm_atomic_state_put(state);
> > +	DRM_MODESET_LOCK_ALL_END(crtc->dev, ctx, err);
> > +	return ret;
> > +}
> > +
> >  /**
> >   * drm_atomic_helper_wait_for_flip_done - wait for all page flips to be done
> >   * @dev: DRM device
> > @@ -1949,17 +1986,23 @@ void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
> >  
> >  	for (i = 0; i < dev->mode_config.num_crtc; i++) {
> >  		struct drm_crtc_commit *commit = state->crtcs[i].commit;
> > -		int ret;
> >  
> >  		crtc = state->crtcs[i].ptr;
> >  
> >  		if (!crtc || !commit)
> >  			continue;
> >  
> > -		ret = wait_for_completion_timeout(&commit->flip_done, 10 * HZ);
> > -		if (ret == 0)
> > +		if (!wait_for_completion_timeout(&commit->flip_done, 10 * HZ)) {
> > +			int ret;
> >  			drm_err(dev, "[CRTC:%d:%s] flip_done timed out\n",
> >  				crtc->base.id, crtc->name);
> > +
> > +			ret = force_full_modeset(crtc);
> 
> This looks like some kind of ugly hack to paper over a driver bug.
> I really don't want this for i915/xe because all it'll end up doing
> is make it harder to debug any real issues.

In that case, would you be okay with having
drm_atomic_helper_wait_for_flip_done() return an error code, or did you
have something else in mind?

> 
> > +			if (ret)
> > +				drm_err(dev,
> > +					"[CRTC:%d:%s] force full modeset failed! ret=%d\n",
> > +					crtc->base.id, crtc->name, ret);
> > +		}
> >  	}
> >  
> >  	if (state->fake_commit)
> > -- 
> > 2.54.0
> 
> -- 
> Ville Syrjälä
> Intel
