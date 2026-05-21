Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C99CD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351E910E478;
	Thu, 21 May 2026 08:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mlnP2rHd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2B710E478
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:10:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 247144090A;
 Thu, 21 May 2026 08:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F85B1F000E9;
 Thu, 21 May 2026 08:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779351052;
 bh=eysZ0brE9mz3y7rR8Bm3ba3XnNZCC556oDpeNj1X7E8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mlnP2rHdZlypMCrRK+7hSNoTYjSXBuTGXxsQge3wdBqdzo6LSgbgjuynh8LjRUq6M
 1y4DsKad1xt8e3wXgljctmFP7K9dFnfx4GthOmt4iRs7JZtshGWSTPv9v+1TZ9wjMo
 /zZW/aUnP+o8yLyFYnxkcLdD0mLjW6hciKvjvq/FWiHpTQq0zyzhkZJ+irdIwh180E
 SI1B+vpwtI+EP2/2zyH1TLeVxkVnqh2Tv3Gp+FSQBaI9Ke8c61ofLBKJcHHC7WfHxb
 AV3aqFWdaUYKlgHDutF4HtH85dzM4hvLJl4yEZtOfSt5VMsuAYPVlpGj6RGSDLOuPf
 2W3bEMBjVw3mg==
Date: Thu, 21 May 2026 10:10:49 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Daniel Stone <daniels@collabora.com>,
 kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 04/22] drm/display: scdc_helper: Add HDMI 2.0
 scrambling management helpers
Message-ID: <20260521-chestnut-harrier-of-enhancement-2bcfa2@penduick>
References: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
 <20260520-dw-hdmi-qp-scramb-v6-4-24b74603b782@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="aijmi3x6lmhfe6cy"
Content-Disposition: inline
In-Reply-To: <20260520-dw-hdmi-qp-scramb-v6-4-24b74603b782@collabora.com>
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


--aijmi3x6lmhfe6cy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 04/22] drm/display: scdc_helper: Add HDMI 2.0
 scrambling management helpers
MIME-Version: 1.0

On Wed, May 20, 2026 at 09:38:15PM +0300, Cristian Ciocaltea wrote:
> Add drm_scdc_start_scrambling(), drm_scdc_stop_scrambling() and
> drm_scdc_sync_status() helpers to manage the full lifecycle of HDMI 2.0
> SCDC scrambling on both source and sink sides.
>=20
> drm_scdc_start_scrambling() configures SCDC scrambling and high TMDS
> clock ratio and starts a periodic work item that monitors the sink's
> SCDC scrambling status, retrying setup when the sink loses state.
>=20
> drm_scdc_stop_scrambling() tears down scrambling on both sides and
> cancels the monitoring work.
>=20
> drm_scdc_sync_status() triggers a CRTC reset on reconnection to restore
> SCDC state lost during sink disconnects within an active display
> pipeline.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_scdc_helper.c | 235 ++++++++++++++++++++++++=
+++++-
>  include/drm/display/drm_scdc_helper.h     |   6 +-
>  2 files changed, 236 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/=
display/drm_scdc_helper.c
> index cb6632346aad..5bacb886d373 100644
> --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
> @@ -21,16 +21,22 @@
>   * DEALINGS IN THE SOFTWARE.
>   */
> =20
> +#include <linux/delay.h>
>  #include <linux/export.h>
>  #include <linux/i2c.h>
> +#include <linux/minmax.h>
>  #include <linux/slab.h>
> -#include <linux/delay.h>
> =20
> -#include <drm/display/drm_scdc_helper.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge_helper.h>
>  #include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_print.h>
> =20
> +#include <drm/display/drm_scdc_helper.h>
> +
>  /**
>   * DOC: scdc helpers
>   *
> @@ -50,10 +56,14 @@
>   * has to track the connector status changes using interrupts and
>   * restore the SCDC status. The typical solution for this is to trigger =
an
>   * empty modeset in drm_connector_helper_funcs.detect_ctx(), like what v=
c4 does
> - * in vc4_hdmi_reset_link().
> + * in vc4_hdmi_reset_link(). Alternatively, use the HDMI connector frame=
work
> + * which ensures drm_scdc_sync_status() is called in the context of
> + * drm_atomic_helper_connector_hdmi_hotplug_ctx().
>   */
> =20
> -#define SCDC_I2C_SLAVE_ADDRESS 0x54
> +#define SCDC_I2C_SLAVE_ADDRESS		0x54
> +#define SCDC_MAX_SOURCE_VERSION		0x1
> +#define SCDC_STATUS_POLL_DELAY_MS	3000
> =20
>  #define drm_scdc_dbg(connector, fmt, ...)					\
>  	drm_dbg_kms((connector)->dev, "[CONNECTOR:%d:%s] " fmt,			\
> @@ -270,3 +280,220 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_=
connector *connector,
>  	return true;
>  }
>  EXPORT_SYMBOL(drm_scdc_set_high_tmds_clock_ratio);
> +
> +static int drm_scdc_setup_scrambler(struct drm_connector *connector)
> +{
> +	bool done;
> +
> +	done =3D drm_scdc_set_high_tmds_clock_ratio(connector, true);
> +	if (!done)
> +		return -EIO;
> +
> +	done =3D drm_scdc_set_scrambling(connector, true);
> +	if (!done)
> +		return -EIO;
> +
> +	schedule_delayed_work(&connector->hdmi.scdc_work,
> +			      msecs_to_jiffies(SCDC_STATUS_POLL_DELAY_MS));
> +	return 0;
> +}

There's a very tight deadline in the spec to enable the scrambler
relative to the video. Debouncing (I assume?) for three seconds break
it. Drivers might not be able to do better, but it's really not
something we should entertain at the framework level and we should call
the callback straight-away.

> +static void drm_scdc_monitor_scrambler(struct drm_connector *connector)
> +{
> +	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
> +	    !drm_scdc_get_scrambling_status(connector))
> +		drm_scdc_setup_scrambler(connector);
> +}
> +
> +static int drm_scdc_reset_crtc(struct drm_connector *connector,
> +			       struct drm_modeset_acquire_ctx *ctx)
> +{
> +	struct drm_crtc *crtc;
> +	u8 config;
> +	int ret;
> +
> +	if (!ctx || !connector->state)
> +		return 0;
> +
> +	crtc =3D connector->state->crtc;
> +	if (!crtc || !crtc->state || !crtc->state->active)
> +		return 0;
> +
> +	ret =3D drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
> +	if (ret) {
> +		drm_scdc_dbg(connector, "Failed to read TMDS config: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if ((config & SCDC_SCRAMBLING_ENABLE) &&
> +	    (config & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40))
> +		return 0;
> +
> +	/*
> +	 * Reset the CRTC to suspend TMDS transmission, conforming to HDMI 2.0
> +	 * spec which requires scrambled data not to be sent before the sink is
> +	 * configured, and TMDS clock to be suspended while changing the clock
> +	 * ratio.  The disable/re-enable cycle triggered by the reset should
> +	 * call drm_scdc_start_scrambling() during re-enable, properly
> +	 * configuring the sink before data transmission resumes.
> +	 */
> +
> +	drm_scdc_dbg(connector, "Resetting CRTC to restore SCDC status\n");
> +
> +	ret =3D drm_atomic_helper_reset_crtc(crtc, ctx);
> +	if (ret && ret !=3D -EDEADLOCK)
> +		drm_scdc_dbg(connector, "Failed to reset CRTC: %d\n", ret);
> +
> +	return ret;
> +}

locking is a bit more involved than that, I'd suggest to take
vc4_hdmi_reset_link() and turn it into a helper.

> +/**
> + * drm_scdc_start_scrambling - activate scrambling and monitor SCDC stat=
us
> + * @connector: connector
> + *
> + * Enables scrambling and high TMDS clock ratio on both source and sink =
sides.
> + * Additionally, use a delayed work item to monitor the scrambling statu=
s on
> + * the sink side and retry the operation, as some displays refuse to set=
 the
> + * scrambling bit right away.
> + *
> + * Returns:
> + * Zero if scrambling is set successfully, an error code otherwise.
> + */
> +int drm_scdc_start_scrambling(struct drm_connector *connector)
> +{
> +	struct drm_display_info *info =3D &connector->display_info;
> +	struct drm_connector_hdmi *hdmi =3D &connector->hdmi;
> +	int ret;
> +	u8 ver;
> +
> +	if (!hdmi->funcs ||
> +	    !hdmi->funcs->scrambler_src_enable ||
> +	    !hdmi->funcs->scrambler_src_disable) {
> +		drm_scdc_dbg(connector, "Function not implemented, bailing.\n");
> +		return -EINVAL;
> +	}

This case shouldn't be a thing. The driver must not probe if it's not set.

> +	if (!info->is_hdmi ||
> +	    !info->hdmi.scdc.supported ||
> +	    !info->hdmi.scdc.scrambling.supported) {
> +		drm_scdc_dbg(connector, "Sink doesn't support scrambling.\n");
> +		return -EINVAL;
> +	}

You should also compute whether we actually need to enable the scrambler
here, based on the mode, format and bpc.

I'd also like to see what a !bridge user of this would look like. The
vc4 driver has all the infrastructure you need already, so converting it
to it would be great.

Maxime

--aijmi3x6lmhfe6cy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCag6+CAAKCRAnX84Zoj2+
digcAYC6mYTbuFts3kUAKfaX5VEZQlbMpu45A7Gzl+Uakxh7tLKXWhIv0/CEzDTg
6LW9dp4BfjD9VAKlmP3xOHohqH376xkcmXLyIhTtSfuyx0rO1XxWRJNtlqsiK4YC
tuaIPgWpGA==
=IpgX
-----END PGP SIGNATURE-----

--aijmi3x6lmhfe6cy--
