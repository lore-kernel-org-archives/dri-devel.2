Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60BD606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FU9DS4vJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163D2112D53;
	Sat, 24 Oct 2026 00:54:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF3110E6EE;
 Sat, 24 Oct 2026 00:54:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5528B4156E;
 Sat, 24 Oct 2026 00:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAA51F01825;
 Sat, 24 Oct 2026 00:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792803286;
 bh=8rTFWG/u8g3zFtmWZhV06zKt+YsOU4geLx3qnx8KCJg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FU9DS4vJ4/dAm7XzkIMUAW5vsubdpRax8xjtgox3i6IOnjY0wF/b0/JiJWkhnze98
 WZYBqTMr0FwmbsJ+xcl1MkRrDNamufd133Ux6UoPorwJWK6QUzj4qUU0r20wo20O1N
 fz9aXBJAqZVWbnqahLzjtf99nP+mkpv4yNwWTJOB+YfY35/Ens18PAKDuWrG3sy2Lz
 5tfTHmaiYFjYZrPomX9mfeXFHMrUIAYHPpZWMVb88/jVamw4xNeN3yj3IfmzmFyQ5h
 fxXWEZaOgZAeDjvlAGrVBndASlRI3/vR0K8Dz1sWhcnhvc3u74LLlrU02HqOSm0Dx2
 LSRI744njnS4w==
Message-ID: <sashiko-outbox-183472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/9] drm/msm/dp: don't take extra references on
 multiple plug events
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20261024-hpd-irq-events-v8-6-6ee949e7a384@oss.qualcomm.com>
References: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
 <20261024-hpd-irq-events-v8-6-6ee949e7a384@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 00:54:45 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/dp: msm_dp_hpd_plug_handle() skips HPD init when dp->plugg=
ed is set
--

commit 4113312f878c771b378b82c05f3076f2ed79cfc7
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dp: don't take extra references on multiple plug events

This commit skips subsequent HPD plug events in msm_dp_hpd_plug_handle()
when dp->plugged is already set, avoiding extra runtime PM references.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index fa8942922b533..ce919a26fba28 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -412,6 +412,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_displ=
ay_private *dp)
> =20
>  	guard(mutex)(&dp->plugged_lock);
> =20
> +	if (dp->plugged)
> +		return 0;

[Severity: High]
Could this early return cause msm_dp_hpd_plug_handle() to skip
msm_dp_display_process_hpd_high() completely when detection runs before HPD
plug handling?

When connector detection runs while dp->plugged is false and a DisplayPort
sink is connected (for example at boot via
drm_helper_probe_single_connector_modes() -> drm_bridge_connector_detect_ct=
x(),
on system resume, or via DRM_IOCTL_MODE_GETCONNECTOR),
drm_bridge_connector_detect_ctx() calls detect->funcs->detect() immediately
before drm_bridge_connector_hpd_notify():

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_detect_=
ctx() {
	if (detect) {
		status =3D detect->funcs->detect(detect, connector);
		...
		drm_bridge_connector_hpd_notify(connector, status, DRM_CONNECTOR_NO_EXTRA=
_STATUS);
	}
}

In msm_dp_bridge_detect(), priv->plugged is set to true after reading DPCD
into local stack buffers, without calling msm_dp_display_process_hpd_high():

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_detect() {
	...
	status =3D connector_status_connected;
	priv->plugged =3D true;
}

When drm_bridge_connector_hpd_notify() then invokes msm_dp_bridge_hpd_notif=
y()
-> msm_dp_hpd_plug_handle(), dp->plugged is already true, so
msm_dp_hpd_plug_handle() returns 0 without calling
msm_dp_display_process_hpd_high().

Similarly, if msm_dp_hpd_plug_handle() runs first and
msm_dp_display_process_hpd_high() fails (for example returning -ENOTCONN in
msm_dp_panel_read_link_caps() when a branch device is connected with
sink_count =3D=3D 0, or on a transient AUX timeout), msm_dp_hpd_plug_handle=
()
still sets dp->plugged =3D true unconditionally:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_hpd_plug_handle() {
	...
	ret =3D msm_dp_display_process_hpd_high(dp);
	...
	dp->plugged =3D true;

	return ret;
}

Wouldn't both paths leave dp->panel->link_info, the connector EDID, LTTPR,
and dp->link->sink_count uninitialized, causing msm_dp_display_get_modes()
to return 0 modes, msm_dp_display_mode_valid() to reject modes with
MODE_BAD, and msm_dp_display_prepare_link() to fail with -ENOTCONN?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-hpd-irq-ev=
ents-v8-0-6ee949e7a384@oss.qualcomm.com?part=3D6
