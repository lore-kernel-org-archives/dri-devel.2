Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866E2CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5FC10F47A;
	Fri, 12 Jun 2026 12:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SsHVtJYB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA7C10F47A
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 12:04:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9177D43B05;
 Fri, 12 Jun 2026 12:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026D51F000E9;
 Fri, 12 Jun 2026 12:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781265849;
 bh=U/hoWKqrqO5Af0SxH9P+WFR6kvfBz1uNYfF72kTSWEE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SsHVtJYBZzDd7cTYHW2syvS3kQq5UK2GvOVMVroXqTR8m3FH+s2tS6lMUC/+aDMsu
 V9WTR27EmCZBI3eil2XJbXiBbSsQYFjicu9yrw9bOHwjrlY5aucIBxXDH82kffSWyr
 RQeis86qsyVKUAgl7igLXmTM1AHr/WQ4522v+GGVwYAjZjGlFsY7Qz8juC2Y4VJGlQ
 OZHRKp7Y0pWGxAFzZHqKl2hEspTMlIJGLIscZtGWZeo2+GrPLpjoTi0fzwPwLHOo69
 drwXvj4Rwn2l6UQtKSTcwnrNDfNnNyvXTYqn70q1RyqhKvhNEojMIey9PXZkHaHU5B
 cRx9MkpbKgQ9w==
Date: Fri, 12 Jun 2026 14:04:07 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 25/30] drm/vc4: hdmi: Convert to common HDMI 2.0 SCDC
 scrambling helpers
Message-ID: <20260612-primitive-chital-of-tempering-18bc7c@houat>
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-25-445eb54ee1ed@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="dptwuanfutj3vasr"
Content-Disposition: inline
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-25-445eb54ee1ed@collabora.com>
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


--dptwuanfutj3vasr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 25/30] drm/vc4: hdmi: Convert to common HDMI 2.0 SCDC
 scrambling helpers
MIME-Version: 1.0

Hi,

On Tue, Jun 02, 2026 at 01:44:25AM +0300, Cristian Ciocaltea wrote:
> Replace the vc4-local scrambling implementation with the newly
> introduced DRM common SCDC scrambling infrastructure:
>=20
> - Advertise source-side scrambling support by setting
>   connector->hdmi.scrambling_supported based on the variant's
>   max_pixel_clock before drmm_connector_hdmi_init().
>=20
> - Provide minimal .scrambler_{enable|disable} connector callbacks that
>   only toggle the VC5 HDMI_SCRAMBLER_CTL register.  Sink-side SCDC
>   programming and periodic status monitoring are now delegated to
>   drm_scdc_{start|stop}_scrambling().
>=20
> - Replace vc4_hdmi_enable_scrambling() with a conditional call to
>   drm_scdc_start_scrambling() in post_crtc_enable, gated on
>   conn_state->hdmi.scrambler_needed (computed by the HDMI state helper).
>=20
> - Replace vc4_hdmi_disable_scrambling() with drm_scdc_stop_scrambling()
>   in post_crtc_disable.
>=20
> - Drop vc4_hdmi_reset_link() and vc4_hdmi_handle_hotplug(), switching
>   the .detect_ctx() path to
>   drm_atomic_helper_connector_hdmi_hotplug_ctx() which internally calls
>   drm_scdc_sync_status() to trigger a CRTC reset on reconnection.
>=20
> - Drop the local scrambling_work delayed workqueue and scdc_enabled
>   flag, now tracked by the common drm_connector_hdmi layer.
>=20
> - Drop vc4_hdmi_supports_scrambling() and
>   vc4_hdmi_mode_needs_scrambling() helpers, inlining the remaining 4KP60
>   warning with an explicit drm_hdmi_compute_mode_clock() check.
>=20
> - Seed connector->hdmi.scrambler_enabled =3D true in connector_init() to
>   ensure drm_scdc_stop_scrambling() runs at boot and disables any stale
>   scrambling state left by the bootloader.
>=20
> No functional change is expected for the supported modes.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

I'd really like it to be broken down into several patches:

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 265 ++++++-----------------------------=
------
>  drivers/gpu/drm/vc4/vc4_hdmi.h |   8 --
>  2 files changed, 35 insertions(+), 238 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index 046ac4f43ba8..02f6ca6ab52b 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -114,31 +114,6 @@
>  #define HSM_MIN_CLOCK_FREQ	120000000
>  #define CEC_CLOCK_FREQ 40000
> =20
> -static bool vc4_hdmi_supports_scrambling(struct vc4_hdmi *vc4_hdmi)
> -{
> -	struct drm_display_info *display =3D &vc4_hdmi->connector.display_info;
> -
> -	lockdep_assert_held(&vc4_hdmi->mutex);
> -
> -	if (!display->is_hdmi)
> -		return false;
> -
> -	if (!display->hdmi.scdc.supported ||
> -	    !display->hdmi.scdc.scrambling.supported)
> -		return false;
> -
> -	return true;
> -}
> -
> -static bool vc4_hdmi_mode_needs_scrambling(const struct drm_display_mode=
 *mode,
> -					   unsigned int bpc,
> -					   enum drm_output_color_format fmt)
> -{
> -	unsigned long long clock =3D drm_hdmi_compute_mode_clock(mode, bpc, fmt=
);
> -
> -	return clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
> -}
> -
>  static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
>  {
>  	struct drm_debugfs_entry *entry =3D m->private;
> @@ -272,124 +247,6 @@ static void vc4_hdmi_cec_update_clk_div(struct vc4_=
hdmi *vc4_hdmi)
>  static void vc4_hdmi_cec_update_clk_div(struct vc4_hdmi *vc4_hdmi) {}
>  #endif
> =20
> -static int vc4_hdmi_reset_link(struct drm_connector *connector,
> -			       struct drm_modeset_acquire_ctx *ctx)
> -{
> -	struct drm_device *drm;
> -	struct vc4_hdmi *vc4_hdmi;
> -	struct drm_connector_state *conn_state;
> -	struct drm_crtc_state *crtc_state;
> -	struct drm_crtc *crtc;
> -	bool scrambling_needed;
> -	u8 config;
> -	int ret;
> -
> -	if (!connector)
> -		return 0;
> -
> -	drm =3D connector->dev;
> -	ret =3D drm_modeset_lock(&drm->mode_config.connection_mutex, ctx);
> -	if (ret)
> -		return ret;
> -
> -	conn_state =3D connector->state;
> -	crtc =3D conn_state->crtc;
> -	if (!crtc)
> -		return 0;
> -
> -	ret =3D drm_modeset_lock(&crtc->mutex, ctx);
> -	if (ret)
> -		return ret;
> -
> -	crtc_state =3D crtc->state;
> -	if (!crtc_state->active)
> -		return 0;
> -
> -	vc4_hdmi =3D connector_to_vc4_hdmi(connector);
> -	mutex_lock(&vc4_hdmi->mutex);
> -
> -	if (!vc4_hdmi_supports_scrambling(vc4_hdmi)) {
> -		mutex_unlock(&vc4_hdmi->mutex);
> -		return 0;
> -	}
> -
> -	scrambling_needed =3D vc4_hdmi_mode_needs_scrambling(&vc4_hdmi->saved_a=
djusted_mode,
> -							   vc4_hdmi->output_bpc,
> -							   vc4_hdmi->output_format);
> -	if (!scrambling_needed) {
> -		mutex_unlock(&vc4_hdmi->mutex);
> -		return 0;
> -	}
> -
> -	if (conn_state->commit &&
> -	    !try_wait_for_completion(&conn_state->commit->hw_done)) {
> -		mutex_unlock(&vc4_hdmi->mutex);
> -		return 0;
> -	}
> -
> -	ret =3D drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
> -	if (ret < 0) {
> -		drm_err(drm, "Failed to read TMDS config: %d\n", ret);
> -		mutex_unlock(&vc4_hdmi->mutex);
> -		return 0;
> -	}
> -
> -	if (!!(config & SCDC_SCRAMBLING_ENABLE) =3D=3D scrambling_needed) {
> -		mutex_unlock(&vc4_hdmi->mutex);
> -		return 0;
> -	}
> -
> -	mutex_unlock(&vc4_hdmi->mutex);
> -
> -	/*
> -	 * HDMI 2.0 says that one should not send scrambled data
> -	 * prior to configuring the sink scrambling, and that
> -	 * TMDS clock/data transmission should be suspended when
> -	 * changing the TMDS clock rate in the sink. So let's
> -	 * just do a full modeset here, even though some sinks
> -	 * would be perfectly happy if were to just reconfigure
> -	 * the SCDC settings on the fly.
> -	 */
> -	return drm_atomic_helper_reset_crtc(crtc, ctx);
> -}

This one doesn't look functionally equivalent to me to
drm_scdc_reset_crtc: this part was, in part, making sure we would only
reset the scrambler if it was enabled in the first place.
drm_scdc_reset_crtc() doesn't and will always trigger a modeset on
hotplug. That's unnecessary and a significant functional different.

I'd argue that it's drm_scdc_reset_crtc() that needs to align to what
vc4 was doing, not the opposite.

> -static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
> -				    struct drm_modeset_acquire_ctx *ctx,
> -				    enum drm_connector_status status)
> -{
> -	struct drm_connector *connector =3D &vc4_hdmi->connector;
> -	int ret;
> -
> -	/*
> -	 * NOTE: This function should really be called with vc4_hdmi->mutex
> -	 * held, but doing so results in reentrancy issues since
> -	 * cec_s_phys_addr() might call .adap_enable, which leads to that
> -	 * funtion being called with our mutex held.
> -	 *
> -	 * A similar situation occurs with vc4_hdmi_reset_link() that
> -	 * will call into our KMS hooks if the scrambling was enabled.
> -	 *
> -	 * Concurrency isn't an issue at the moment since we don't share
> -	 * any state with any of the other frameworks so we can ignore
> -	 * the lock for now.
> -	 */
> -
> -	drm_atomic_helper_connector_hdmi_hotplug(connector, status);
> -
> -	if (status !=3D connector_status_connected)
> -		return;
> -
> -	for (;;) {
> -		ret =3D vc4_hdmi_reset_link(connector, ctx);
> -		if (ret =3D=3D -EDEADLK) {
> -			drm_modeset_backoff(ctx);
> -			continue;
> -		}
> -
> -		break;
> -	}
> -}
> -
>  static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>  					 struct drm_modeset_acquire_ctx *ctx,
>  					 bool force)
> @@ -401,8 +258,8 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_c=
onnector *connector,
>  	/*
>  	 * NOTE: This function should really take vc4_hdmi->mutex, but
>  	 * doing so results in reentrancy issues since
> -	 * vc4_hdmi_handle_hotplug() can call into other functions that
> -	 * would take the mutex while it's held here.
> +	 * drm_atomic_helper_connector_hdmi_hotplug_ctx() can call into other
> +	 * functions that would take the mutex while it's held here.
>  	 *
>  	 * Concurrency isn't an issue at the moment since we don't share
>  	 * any state with any of the other frameworks so we can ignore
> @@ -425,10 +282,11 @@ static int vc4_hdmi_connector_detect_ctx(struct drm=
_connector *connector,
>  			status =3D connector_status_connected;
>  	}
> =20
> -	vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
> +	ret =3D drm_atomic_helper_connector_hdmi_hotplug_ctx(connector, status,=
 ctx);
> +
>  	pm_runtime_put(&vc4_hdmi->pdev->dev);
> =20
> -	return status;
> +	return ret =3D=3D -EDEADLK ? ret : status;
>  }
> =20
>  static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
> @@ -441,9 +299,12 @@ static int vc4_hdmi_connector_get_modes(struct drm_c=
onnector *connector)
>  	if (!vc4->hvs->vc5_hdmi_enable_hdmi_20) {
>  		struct drm_device *drm =3D connector->dev;
>  		const struct drm_display_mode *mode;
> +		unsigned long long clock;
> =20
>  		list_for_each_entry(mode, &connector->probed_modes, head) {
> -			if (vc4_hdmi_mode_needs_scrambling(mode, 8, DRM_OUTPUT_COLOR_FORMAT_R=
GB444)) {
> +			clock =3D drm_hdmi_compute_mode_clock(mode, 8,
> +							    DRM_OUTPUT_COLOR_FORMAT_RGB444);
> +			if (clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ) {

This should be a patch of its own, but I think we should turn
vc4_hdmi_mode_needs_scrambling() into a helper, instead of checking the
clock rate in every driver that might need it. From a logical standpoint
it's equivalent, but not from a semantic one.

>  				drm_warn_once(drm, "The core clock cannot reach frequencies high eno=
ugh to support 4k @ 60Hz.");
>  				drm_warn_once(drm, "Please change your config.txt file to add hdmi_e=
nable_4kp60.");
>  			}
> @@ -540,6 +401,9 @@ static int vc4_hdmi_connector_init(struct drm_device =
*dev,
>  	if (vc4_hdmi->variant->supports_hdr)
>  		max_bpc =3D 12;
> =20
> +	connector->hdmi.scrambler_supported =3D
> +		vc4_hdmi->variant->max_pixel_clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
> +
>  	ret =3D drmm_connector_hdmi_init(dev, connector,
>  				       "Broadcom", "Videocore",
>  				       &vc4_hdmi_connector_funcs,
> @@ -561,6 +425,14 @@ static int vc4_hdmi_connector_init(struct drm_device=
 *dev,
> =20
>  	drm_connector_helper_add(connector, &vc4_hdmi_connector_helper_funcs);
> =20
> +	/*
> +	 * Since we don't know the state of the controller and its
> +	 * display (if any), let's assume it's always enabled.
> +	 * drm_scdc_stop_scrambling() will thus run at boot, make
> +	 * sure it's disabled, and avoid any inconsistency.
> +	 */
> +	connector->hdmi.scrambler_enabled =3D connector->hdmi.scrambler_support=
ed;
> +
>  	/*
>  	 * Some of the properties below require access to state, like bpc.
>  	 * Allocate some default initial connector state with our reset helper.
> @@ -786,93 +658,30 @@ static int vc4_hdmi_write_spd_infoframe(struct drm_=
connector *connector,
>  					buffer, len);
>  }
> =20
> -#define SCRAMBLING_POLLING_DELAY_MS	1000
> -
> -static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
> +static int vc4_hdmi_scrambler_enable(struct drm_connector *connector)
>  {
> -	struct vc4_hdmi *vc4_hdmi =3D encoder_to_vc4_hdmi(encoder);
> -	struct drm_connector *connector =3D &vc4_hdmi->connector;
> -	struct drm_device *drm =3D connector->dev;
> -	const struct drm_display_mode *mode =3D &vc4_hdmi->saved_adjusted_mode;
> +	struct vc4_hdmi *vc4_hdmi =3D connector_to_vc4_hdmi(connector);
>  	unsigned long flags;
> -	int idx;
> -
> -	lockdep_assert_held(&vc4_hdmi->mutex);
> -
> -	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
> -		return;
> -
> -	if (!vc4_hdmi_mode_needs_scrambling(mode,
> -					    vc4_hdmi->output_bpc,
> -					    vc4_hdmi->output_format))
> -		return;
> -
> -	if (!drm_dev_enter(drm, &idx))
> -		return;

drm_dev_enter should be kept here

> -	drm_scdc_set_high_tmds_clock_ratio(connector, true);
> -	drm_scdc_set_scrambling(connector, true);
> =20
>  	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
>  	HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) |
>  		   VC5_HDMI_SCRAMBLER_CTL_ENABLE);
>  	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
> =20
> -	drm_dev_exit(idx);

And exit here.

> -static void vc4_hdmi_disable_scrambling(struct drm_encoder *encoder)
> +static int vc4_hdmi_scrambler_disable(struct drm_connector *connector)
>  {
> -	struct vc4_hdmi *vc4_hdmi =3D encoder_to_vc4_hdmi(encoder);
> -	struct drm_connector *connector =3D &vc4_hdmi->connector;
> -	struct drm_device *drm =3D connector->dev;
> +	struct vc4_hdmi *vc4_hdmi =3D connector_to_vc4_hdmi(connector);
>  	unsigned long flags;
> -	int idx;
> -
> -	lockdep_assert_held(&vc4_hdmi->mutex);
> -
> -	if (!vc4_hdmi->scdc_enabled)
> -		return;
> -
> -	vc4_hdmi->scdc_enabled =3D false;
> -
> -	if (delayed_work_pending(&vc4_hdmi->scrambling_work))
> -		cancel_delayed_work_sync(&vc4_hdmi->scrambling_work);
> -
> -	if (!drm_dev_enter(drm, &idx))
> -		return;

Ditto

>  	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
>  	HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) &
>  		   ~VC5_HDMI_SCRAMBLER_CTL_ENABLE);
>  	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
> =20
> -	drm_scdc_set_scrambling(connector, false);
> -	drm_scdc_set_high_tmds_clock_ratio(connector, false);
> -
> -	drm_dev_exit(idx);
> -}
> -
> -static void vc4_hdmi_scrambling_wq(struct work_struct *work)
> -{
> -	struct vc4_hdmi *vc4_hdmi =3D container_of(to_delayed_work(work),
> -						 struct vc4_hdmi,
> -						 scrambling_work);
> -	struct drm_connector *connector =3D &vc4_hdmi->connector;
> -
> -	if (drm_scdc_get_scrambling_status(connector))
> -		return;
> -
> -	drm_scdc_set_high_tmds_clock_ratio(connector, true);
> -	drm_scdc_set_scrambling(connector, true);
> -
> -	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
> -			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
> +	return 0;
>  }
> =20
>  static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encod=
er,
> @@ -917,7 +726,7 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct=
 drm_encoder *encoder,
>  		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
>  	}
> =20
> -	vc4_hdmi_disable_scrambling(encoder);
> +	drm_scdc_stop_scrambling(&vc4_hdmi->connector);

I don't think the names here are right. It's not *only* related to scdc
but also to the HDMI controller. I'm fine with using a scdc prefix but
only for the things related to scdc. This is related (in part) to the
HDMI controller, so it should use a drm_connector_hdmi prefix.

>  	drm_dev_exit(idx);
> =20
> @@ -1625,6 +1434,7 @@ static void vc4_hdmi_encoder_post_crtc_enable(struc=
t drm_encoder *encoder,
>  	struct drm_display_info *display =3D &vc4_hdmi->connector.display_info;
>  	bool hsync_pos =3D mode->flags & DRM_MODE_FLAG_PHSYNC;
>  	bool vsync_pos =3D mode->flags & DRM_MODE_FLAG_PVSYNC;
> +	struct drm_connector_state *conn_state;
>  	unsigned long flags;
>  	int ret;
>  	int idx;
> @@ -1693,7 +1503,10 @@ static void vc4_hdmi_encoder_post_crtc_enable(stru=
ct drm_encoder *encoder,
>  	}
> =20
>  	vc4_hdmi_recenter_fifo(vc4_hdmi);
> -	vc4_hdmi_enable_scrambling(encoder);
> +
> +	conn_state =3D drm_atomic_get_new_connector_state(state, connector);
> +	if (conn_state && conn_state->hdmi.scrambler_needed)
> +		drm_scdc_start_scrambling(connector);

And the nice thing with a drm_connector_hdmi_* prefix is that you don't
have to shoehorn it into SCDC support anymore, so you can take a state
as an argument, and do the check in the helper instead of doing it in
every driver and hoping they get it right.

Maxime

--dptwuanfutj3vasr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiv1rgAKCRAnX84Zoj2+
dgjiAYCujTAkPDFNSONvWn1TGWHP1snswHAl+KoW3O2aWnlv5B/ZzqreRdMgzT90
D833M6oBfiW/cN4+iyLO2kQf/cAEO/Twbp+xEqTxtRMlP9GkYRleIJ87HOvXvcQS
9rQh4ecGVw==
=oUC5
-----END PGP SIGNATURE-----

--dptwuanfutj3vasr--
