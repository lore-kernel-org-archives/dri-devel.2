Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AB9C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E78B410E1C6;
	Thu, 20 Aug 2026 11:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lY0/jjKk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F0610E1C6
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:24:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C5184359D;
 Thu, 20 Aug 2026 11:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D441F00A3A;
 Thu, 20 Aug 2026 11:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787225053;
 bh=ekUunvsOOYeNUebLvO8vu95THYbdnWGVWNbNeRS1cn4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lY0/jjKkR6ziHP6EpJEk5mEmoLSuzTZjFkztSCKoUykaiJkhhFXd51GZvUq0cYadg
 6ZPvJqrJiI6gt6sPuBaUPt28EttbWYRcr7EqoITa6x2zn9ipYlnEEmGWr18eN0ouOt
 yYr0zfUMhTljEHn0zKTYxkyoGx95ZbmHRzdMNR9V92CdCNOldJ5oRh0tIjt7vYbTlO
 PizzDou881Y2Hy2fhBb+HURns5JKk59P2XMna6eC4Rbfwe41N8/SXU4F+YEOwo1BMI
 7IAH7iU1cDgeJIMhPC27frH7zm7YF1eRxUGZ0g+WjErjEslHCf1pzWUadTHYPJQ5L9
 l9uacECL1asjA==
Date: Thu, 20 Aug 2026 13:24:11 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>,
 Phong LE <ple@baylibre.com>, 
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v10 45/69] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
Message-ID: <20260820-tan-spoonbill-of-action-82269e@houat>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-45-294364b2cf15@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="p4y34cw4uyjjzeg2"
Content-Disposition: inline
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-45-294364b2cf15@collabora.com>
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


--p4y34cw4uyjjzeg2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 45/69] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
MIME-Version: 1.0

On Fri, Jul 31, 2026 at 07:19:52PM +0300, Cristian Ciocaltea wrote:
> Replace driver local scrambling logic with the newly introduced common
> HDMI 2.0 scrambling support:
>=20
> - Advertise source-side scrambling capability by setting supported HDMI
>   version based on the variant's max_pixel_clock.
>=20
> - Provide minimal .scrambler_{enable,disable} connector callbacks that
>   only toggle the VC5 HDMI_SCRAMBLER_CTL register, while delegating
>   sink-side SCDC programming and periodic status monitoring to
>   drm_connector_hdmi_{enable,disable}_scrambling().
>=20
> - Drop vc4_hdmi_reset_link() and vc4_hdmi_handle_hotplug(), switching
>   the .detect_ctx() path to drm_atomic_helper_connector_hdmi_hotplug()
>   which internally calls drm_connector_hdmi_sync_scdc() to trigger a
>   CRTC reset on reconnection.
>=20
> - Drop the local scrambling_work delayed workqueue and scdc_enabled
>   flag, now tracked by the common drm_connector_hdmi layer, as well as
>   the now unused output_{bpc,color_format} driver data members.
>=20
> No functional change intended.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 230 +++++------------------------------=
------
>  drivers/gpu/drm/vc4/vc4_hdmi.h |  21 ----
>  2 files changed, 28 insertions(+), 223 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index d599957fee3a..ec0c1f4224d7 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -35,7 +35,6 @@
>  #include <drm/display/drm_hdmi_cec_helper.h>
>  #include <drm/display/drm_hdmi_helper.h>
>  #include <drm/display/drm_hdmi_state_helper.h>
> -#include <drm/display/drm_scdc_helper.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_edid.h>
> @@ -114,22 +113,6 @@
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
>  static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
>  {
>  	struct drm_debugfs_entry *entry =3D m->private;
> @@ -263,115 +246,6 @@ static void vc4_hdmi_cec_update_clk_div(struct vc4_=
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
> -	scrambling_needed =3D drm_hdmi_mode_needs_scrambling(&vc4_hdmi->saved_a=
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
> -
> -static int vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
> -				   struct drm_modeset_acquire_ctx *ctx,
> -				   enum drm_connector_status status)
> -{
> -	struct drm_connector *connector =3D &vc4_hdmi->connector;
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
> -	drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status);
> -
> -	if (status !=3D connector_status_connected)
> -		return 0;
> -
> -	return vc4_hdmi_reset_link(connector, ctx);
> -}
> -
>  static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>  					 struct drm_modeset_acquire_ctx *ctx,
>  					 bool force)
> @@ -383,8 +257,8 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_c=
onnector *connector,
>  	/*
>  	 * NOTE: This function should really take vc4_hdmi->mutex, but
>  	 * doing so results in reentrancy issues since
> -	 * vc4_hdmi_handle_hotplug() can call into other functions that
> -	 * would take the mutex while it's held here.
> +	 * drm_atomic_helper_connector_hdmi_hotplug() can call into other
> +	 * functions that would take the mutex while it's held here.
>  	 *
>  	 * Concurrency isn't an issue at the moment since we don't share
>  	 * any state with any of the other frameworks so we can ignore
> @@ -407,7 +281,8 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_c=
onnector *connector,
>  			status =3D connector_status_connected;
>  	}
> =20
> -	ret =3D vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
> +	ret =3D drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status=
);
> +
>  	pm_runtime_put(&vc4_hdmi->pdev->dev);
> =20
>  	return ret =3D=3D -EDEADLK ? ret : status;
> @@ -534,6 +409,14 @@ static int vc4_hdmi_connector_init(struct drm_device=
 *dev,
> =20
>  	drm_connector_helper_add(connector, &vc4_hdmi_connector_helper_funcs);
> =20
> +	/*
> +	 * Since we don't know the state of the controller and its
> +	 * display (if any), let's assume it's always enabled.
> +	 * drm_connector_hdmi_disable_scrambling() will thus run at boot,
> +	 * make sure it's disabled, and avoid any inconsistency.
> +	 */
> +	connector->hdmi.scrambler_enabled =3D drm_connector_hdmi_scrambler_supp=
orted(connector);
> +
>  	/*
>  	 * Some of the properties below require access to state, like bpc.
>  	 * Allocate some default initial connector state with our reset helper.
> @@ -759,32 +642,15 @@ static int vc4_hdmi_write_spd_infoframe(struct drm_=
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
> +	struct vc4_hdmi *vc4_hdmi =3D connector_to_vc4_hdmi(connector);
>  	struct drm_device *drm =3D connector->dev;
> -	const struct drm_display_mode *mode =3D &vc4_hdmi->saved_adjusted_mode;
>  	unsigned long flags;
>  	int idx;
> =20
> -	lockdep_assert_held(&vc4_hdmi->mutex);
> -
> -	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
> -		return;
> -
> -	if (!drm_hdmi_mode_needs_scrambling(mode,
> -					    vc4_hdmi->output_bpc,
> -					    vc4_hdmi->output_format))
> -		return;
> -
>  	if (!drm_dev_enter(drm, &idx))
> -		return;
> -
> -	drm_scdc_set_high_tmds_clock_ratio(connector, true);
> -	drm_scdc_set_scrambling(connector, true);
> +		return -ENODEV;

Not being able to acquire the device isn't an error, it's something we shou=
ld ignore.

> =20
>  	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
>  	HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) |
> @@ -793,59 +659,27 @@ static void vc4_hdmi_enable_scrambling(struct drm_e=
ncoder *encoder)
> =20
>  	drm_dev_exit(idx);
> =20
> -	vc4_hdmi->scdc_enabled =3D true;
> -
> -	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
> -			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
> +	return 0;
>  }
> =20
> -static void vc4_hdmi_disable_scrambling(struct drm_encoder *encoder)
> +static int vc4_hdmi_scrambler_disable(struct drm_connector *connector)
>  {
> -	struct vc4_hdmi *vc4_hdmi =3D encoder_to_vc4_hdmi(encoder);
> -	struct drm_connector *connector =3D &vc4_hdmi->connector;
> +	struct vc4_hdmi *vc4_hdmi =3D connector_to_vc4_hdmi(connector);
>  	struct drm_device *drm =3D connector->dev;
>  	unsigned long flags;
>  	int idx;
> =20
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
>  	if (!drm_dev_enter(drm, &idx))
> -		return;
> +		return -ENODEV;

Ditto

Maxime

--p4y34cw4uyjjzeg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaobj1wAKCRAnX84Zoj2+
dmo7AYC6qAWiFTzzVaM68fskflGcMwmLOcb9y0OYwWOsoasV6dPr3yy6NGu6fTNY
CiCZjB4Bf1PC5Y4/LulW8HtYxYjWkKyysCkpCLKgcRlR05xvvWqJYpopGgcFM6BA
3jG2X32FJw==
=ce98
-----END PGP SIGNATURE-----

--p4y34cw4uyjjzeg2--
