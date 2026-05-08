Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD71FCD37A7
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 00:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8275E10F2FA;
	Fri,  8 May 2026 00:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jYVXySL9";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA09710E047;
 Fri,  8 May 2026 00:53:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 9A2D91A3556;
 Fri,  8 May 2026 00:53:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 65C58605D0;
 Fri,  8 May 2026 00:53:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2F5A610819538; 
 Fri,  8 May 2026 02:53:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1778201630; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=7Wn2Ei5755ve6pC4TBqcfNQDbV3xREaxM21WYHNXDgg=;
 b=jYVXySL97EVR/95wCu0z2w/NWSjXOVJXWNYCJ8AkpVoADhNPok4lu8hMrUkikysCYjwt5z
 JCJdA60ClbjkogWdgGVytTXph+PE8U2pMW6atxNzynPEVdcVVdXR380Xy71yYB5cWYhHwF
 EwT/jlgejShJK6/6iYZ6LKnRnpzMThqYBvIUVXy680q9uxIzwZ5Uww36JAMarQ2NidYlQC
 VjntqOYEfZbDlgS+dj/5EC/lt3cTiqdl8M7k/VneHf965j6MUuVgW3IeNZ7b7nfgxkNGAc
 OBmifv8G5l+QS1QjwubjyXW+XirA7XD/CvuGzs94IHi5jN8Ex22sAHGPOeLx2w==
Message-ID: <faf150ee-4148-45ae-a3f3-a8a703361b30@bootlin.com>
Date: Fri, 8 May 2026 02:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v3 4/8] DRM: Add support for client and driver indicating
 support for luminance
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: harry.wentland@amd.com, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-5-mario.limonciello@amd.com>
Content-Language: en-US
In-Reply-To: <20260424220953.167058-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 4/25/26 00:09, Mario Limonciello wrote:
> The legacy backlight control interface can only be disabled when both
> the client and driver have agreed that the luminance can be set during
> a modeset. Add capability for the client to register and for the driver
> to indicate support.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/drm_atomic_uapi.c | 24 ++++++++++++++++++++++++
>   drivers/gpu/drm/drm_connector.c   |  4 ++--
>   drivers/gpu/drm/drm_ioctl.c       | 10 ++++++++++
>   include/drm/drm_connector.h       |  5 +++++
>   include/drm/drm_drv.h             |  7 +++++++
>   include/drm/drm_file.h            |  8 ++++++++
>   include/uapi/drm/drm.h            | 10 ++++++++++
>   7 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 5bd5bf6661df7..de218206cef7e 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -30,6 +30,7 @@
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_atomic_uapi.h>
> +#include <drm/drm_backlight.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_drv.h>
> @@ -935,6 +936,14 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
>   		state->privacy_screen_sw_state = val;
>   	} else if (property == connector->broadcast_rgb_property) {
>   		state->hdmi.broadcast_rgb = val;
> +	} else if (property == config->luminance_property) {
> +		state->luminance = val;
> +		/* Update hardware backlight only when DPMS is ON.
> +		 * Property value is always updated to remember the user's
> +		 * desired brightness.
> +		 */
> +		if (connector->dpms == DRM_MODE_DPMS_ON)
> +			drm_backlight_set_luminance(connector->backlight, val);
>   	} else if (connector->funcs->atomic_set_property) {
>   		return connector->funcs->atomic_set_property(connector,
>   				state, property, val);
> @@ -1020,6 +1029,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>   		*val = state->privacy_screen_sw_state;
>   	} else if (property == connector->broadcast_rgb_property) {
>   		*val = state->hdmi.broadcast_rgb;
> +	} else if (property == config->luminance_property) {
> +		*val = state->luminance;

I think this is a bad idea to have two "source of truth" for the 
luminance value. Is there a reason to not get the backlight value 
directly from the backlight driver?

>   	} else if (connector->funcs->atomic_get_property) {
>   		return connector->funcs->atomic_get_property(connector,
>   				state, property, val);
> @@ -1126,8 +1137,21 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
>   	if (connector->dpms == mode)
>   		goto out;
>   
> +	/* Handle backlight brightness coordination with DPMS state changes */
> +	if (old_mode != DRM_MODE_DPMS_OFF && mode == DRM_MODE_DPMS_OFF) {
> +		/* DPMS ON -> OFF: dim backlight to 0 to save power */
> +		drm_backlight_set_luminance(connector->backlight, 0);
> +	}
> +
>   	connector->dpms = mode;
>   
> +	/* DPMS OFF -> ON: restore brightness to property value */
> +	if (old_mode == DRM_MODE_DPMS_OFF && mode == DRM_MODE_DPMS_ON &&
> +	    connector->state) {
> +		drm_backlight_set_luminance(connector->backlight,
> +					    connector->state->luminance);
> +	}
> +

According to the documentation, DPMS is a deprecated property and most 
of the work should be handled using the crtc->active property.

I think this will not change the backlight of other connector using the 
same CRTC (CRTC outputs on connector1 and connector2, userspace change 
DPMS only for connector1, for me it makes sense to change connector1 and 
connector2).

After looking a bit more, I think you need to keep this code, but:
- add something to also disable backlight of other connector using the 
same crtc
- handle the backlight when CRTC is disconnected from the connector (i.e 
when you set CRTC=0 on a connector)

>   	crtc = connector->state->crtc;
>   	if (!crtc)
>   		goto out;
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index d76878548728a..5de33fc259b26 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -3268,9 +3268,9 @@ int drm_connector_set_obj_prop(struct drm_mode_object *obj,
>   	/* Do DPMS ourselves */
>   	if (property == connector->dev->mode_config.dpms_property) {
>   		ret = (*connector->funcs->dpms)(connector, (int)value);
> -	} else if (property == config->brightness_property) {
> +	} else if (property == config->luminance_property) {

Can you directly name it luminance in the previous patch?

>   		if (connector->backlight && connector->dpms == DRM_MODE_DPMS_ON)
> -			drm_backlight_set_brightness(connector->backlight,
> +			drm_backlight_set_luminance(connector->backlight,
>   						     value);
>   		ret = 0;
>   	} else if (connector->funcs->set_property)
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index ff193155129e7..b4435c2bd6091 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -28,6 +28,7 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
> +#include "drm/drm.h"
>   #include <linux/export.h>
>   #include <linux/nospec.h>
>   #include <linux/pci.h>
> @@ -380,6 +381,15 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>   			return -EINVAL;
>   		file_priv->plane_color_pipeline = req->value;
>   		break;
> +	case DRM_CLIENT_CAP_LUMINANCE:
> +		if (!drm_core_check_feature(dev, DRIVER_CONNECTOR_LUMINANCE))
> +			return -EOPNOTSUPP;
> +		if (!file_priv->atomic)
> +			return -EINVAL;
> +		if (req->value > 1)
> +			return -EINVAL;
> +		file_priv->supports_luminance_control = req->value;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 10daf088b8f1a..762a9e2ef6e30 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1209,6 +1209,11 @@ struct drm_connector_state {
>   	 * @drm_atomic_helper_connector_hdmi_check().
>   	 */
>   	struct drm_connector_hdmi_state hdmi;
> +
> +	/**
> +	 * @luminance: Luminance for the connector
> +	 */
> +	u16 luminance;
>   };
>   
>   struct drm_connector_hdmi_audio_funcs {
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 42fc085f986de..a6b668cb68c5e 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -123,6 +123,13 @@ enum drm_driver_feature {
>   	 */
>   	DRIVER_CURSOR_HOTSPOT           = BIT(9),
>   
> +	/**
> +	 * @DRIVER_CONNECTOR_LUMINANCE:
> +	 *
> +	 * Driver supports luminance control on a per connector basis.
> +	 */
> +	DRIVER_CONNECTOR_LUMINANCE           = BIT(10),
> +
>   	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
>   
>   	/**
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 6ee70ad65e1fd..0bb1e53f36bec 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -248,6 +248,14 @@ struct drm_file {
>   	 */
>   	bool supports_virtualized_cursor_plane;
>   
> +	/**
> +	 * @supports_luminance_control:
> +	 *
> +	 * This client is capable of setting the luminance for connectors.
> +	 *
> +	 */
> +	bool supports_luminance_control;
> +
>   	/**
>   	 * @master:
>   	 *
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 27cc159c1d275..b5e6d940f2816 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -921,6 +921,16 @@ struct drm_get_cap {
>    */
>   #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
>   
> +/**
> + * DRM_CLIENT_CAP_LUMINANCE
> + *
> + * If set to 1, legacy sysfs interface for controlling backlight brightness will
> + * be disabled.  The client will include luminance values as part of the modeset.
> +
> + * This capability is supported starting in kernel 7.2
> + */
> +#define DRM_CLIENT_CAP_LUMINANCE		8
> +
>   /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
>   struct drm_set_client_cap {
>   	__u64 capability;

