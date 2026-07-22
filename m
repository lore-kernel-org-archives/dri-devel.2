Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC13C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0517410EC90;
	Wed, 22 Jul 2026 07:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WGSt0slU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A9CF10EC90
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:06:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC0A460A64;
 Wed, 22 Jul 2026 07:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610F61F000E9;
 Wed, 22 Jul 2026 07:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703984;
 bh=yI3C12YwprhGLNkUesAzGvbliAKydFe850qghJBh1Zk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WGSt0slU5cY6eFRxQhmPob891onO+pipm3GAjZMSy9f2xEJCQbwanU8k0hG9lrme7
 0pt+YaXyRDD0HaLSHxE3iYqND9CjBAs+Yb6+YmrNGXfo9FR951+L8AL8c3sfCo6+bV
 Yrh/2kKwkhwioJ2uNE8/3onCps6jK3NVOWcvjo3c1ZaeNxhOpV/eGxMOwz1mw7F4yP
 i6ZSmCRhg8K77YheCmuNBo9+qD7B37DMKiPTd4bP7gNa69Pb326MmEzYL7Zx6dckMV
 fnITNaXrxAtauP63FyIndyuZg0zsRrHGpPVgHR3LY2ccBq8kQSNJxU4SKKvocSUtRW
 m8MhDRVHhJMkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/24] drm/msm/hdmi: cache is_hdmi instead of storing
 the connector
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-18-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-18-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:06:23 +0000
Message-Id: <20260722070624.610F61F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing State Synchronization when connector state is forced via s=
ysfs.
- [Medium] Data Race on `hdmi->is_hdmi` boolean.

Pre-existing issues:
- [High] NULL Pointer Dereference on drmm-managed connector destroy hook.
--

--- Patch [18]: [PATCH 18/24] drm/msm/hdmi: cache is_hdmi instead of storin=
g the connector ---
commit c8e64d4ebbe7d3c6a0a2cb94dd5d7a4af528ed77
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/hdmi: cache is_hdmi instead of storing the connector

This commit updates the HDMI driver to cache the is_hdmi boolean from the
EDID rather than retaining a driver-side pointer to the drm_connector. The
cached value is refreshed via a new hpd_notify bridge callback.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/h=
dmi.c
> index 1d5a4b63f3c8f..62961dddd8f5e 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c

[ ... ]

> @@ -204,10 +205,8 @@ static int msm_hdmi_modeset_init(struct msm_display =
*display,
>  	return 0;
> =20
>  fail:
> -	if (hdmi->connector) {
> -		hdmi->connector->funcs->destroy(hdmi->connector);
> -		hdmi->connector =3D NULL;
> -	}
> +	if (connector)
> +		connector->funcs->destroy(connector);

[Severity: High]
This is a pre-existing issue, but does calling the destroy hook here cause a
NULL pointer dereference?=20
   =20
The connector is created earlier in msm_hdmi_modeset_init() via
drm_bridge_connector_init(), which uses the drmm-managed API
drmm_connector_init(). The DRM-managed API explicitly requires funcs->destr=
oy
to be NULL, otherwise it returns -EINVAL.=20
   =20
This means connector->funcs->destroy is guaranteed to be NULL when this err=
or
path is taken, which would cause a panic when dereferenced.

> =20
>  	return ret;
>  }

[ ... ]

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm=
/hdmi/hdmi_bridge.c
> index 7abb9243dba57..84a423af73e93 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c

[ ... ]

> @@ -452,6 +452,17 @@ static enum drm_mode_status msm_hdmi_bridge_tmds_cha=
r_rate_valid(const struct dr
>  	return 0;
>  }
> =20
> +static void msm_hdmi_bridge_hpd_notify(struct drm_bridge *bridge,
> +				       struct drm_connector *connector,
> +				       enum drm_connector_status status)
> +{
> +	struct hdmi_bridge *hdmi_bridge =3D to_hdmi_bridge(bridge);
> +	struct hdmi *hdmi =3D hdmi_bridge->hdmi;
> +
> +	/* called after the EDID update, so display_info is up to date */
> +	hdmi->is_hdmi =3D connector->display_info.is_hdmi;

[Severity: High]
Can the cached hdmi->is_hdmi state become stale if the connector is forced
via sysfs?=20

When userspace forces the connector state (for example, by echoing on to the
status file), the DRM core sets the status and invokes=20
connector->funcs->force(), which maps to drm_bridge_connector_force().=20

This force operation successfully updates the EDID and display_info.is_hdmi,
but it bypasses the standard detect hook and does not invoke the hpd_notify
callback. Will this missing state synchronization cause HDMI-specific hardw=
are
programming to incorrectly fall back to DVI mode and drop audio?

[Severity: Medium]
Could there be a data race when accessing hdmi->is_hdmi?=20

This variable is updated here in msm_hdmi_bridge_hpd_notify() from the
asynchronous hotplug workqueue thread. Concurrently, it is read in
msm_hdmi_set_mode() under the reg_lock spinlock, and in msm_hdmi_audio_upda=
te()
from audio subsystem paths.=20

Since there is no common lock protecting this cross-thread state access, and
neither READ_ONCE() nor WRITE_ONCE() is used, will this trigger KCSAN
warnings?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D18
