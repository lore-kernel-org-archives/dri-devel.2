Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F1606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvRhz4sx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D7610E090;
	Wed, 25 Nov 2026 03:58:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC57B10E090
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:58:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E75C43656;
 Wed, 25 Nov 2026 03:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D761F000C4;
 Wed, 25 Nov 2026 03:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795579108;
 bh=oyt3Or9ioQayeV4oDUCEucCF/NZc6tmUWhuJa4gV1GM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gvRhz4sxWij1PNsApFWb7iD7I9nQRDiGh7j7p7A/YUvrWUeCFBQYxZ/aSY3MzueAa
 PR33/Dk4t3/kVibyhuFbL5N+hUYqD74woVw+7rf45QJYQuv9Y6jXdEdvEpVZ0ywKh+
 NqM7y4lT9rDlg2/CuIvlGKqQe2OcQdH0KzqccuVn2D+3y9ddAsz+FtIMm4M704+zKt
 vOs6WtSnYQ7J1tm+GKAhx3S11CCWHeJZxIA9qMm/D+f4bFuLehrPQxbQqSiAvrptea
 3rH/kkR4/bB3aELu9JbEKlDZ4hNHad7XdL5ow7i4tjCvJ7lUIac45C30/JShsz2SeJ
 UadwDPto9ti4g==
Message-ID: <sashiko-outbox-232538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] drm/bridge: trilinear: add the DPTX DRM bridge
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125033238.3436046-4-Luo.Liu@cixtech.com>
References: <20261125033238.3436046-1-Luo.Liu@cixtech.com>
 <20261125033238.3436046-4-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 03:58:27 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/bridge: trilinear: force_hpd corruption in
  dptx_hpd_notify()
- [Low] drm/bridge: trilinear: dptx_bridge_mode_valid() ignores
  info->bpc < 8 for YCbCr
--

commit fc27a9663705ea0c07bb63dcb67db3ac74bea16f
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: trilinear: add the DPTX DRM bridge

This commit adds the DRM bridge callbacks and helper functions for the
Trilinear DisplayPort transmitter, covering connector detection, EDID
mode enumeration, mode validation, and atomic modeset operations.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_drm.c b/drivers/gpu/dr=
m/bridge/trilinear/dptx_drm.c
> new file mode 100644
> index 0000000000000..099dd53eb2d4d
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c
[ ... ]
> +static enum drm_connector_status dptx_bridge_detect(struct drm_bridge *b=
ridge,
> +						    struct drm_connector *connector)
> +{
> +	struct dptx_dev *dp =3D bridge_to_dp(bridge);
> +
> +	return dp->ops->detect_status(dp);
> +}
> +
> +static void dptx_hpd_notify(struct dptx_dev *dp,
> +			    enum drm_connector_status hpd_state)
> +{
> +	dp->ops->lock(dp);
> +	if (READ_ONCE(dp->hpd_stopped)) {
> +		dp->ops->unlock(dp);
> +		return;
> +	}
> +
> +	if (dp->state & DPTX_STATE_SUSPENDED) {
> +		dp->force_hpd =3D hpd_state;
> +		dp->ops->unlock(dp);
> +		return;
> +	}
> +
> +	if (hpd_state !=3D dp->status) {
> +		dp->force_hpd =3D hpd_state;
> +		queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
> +
> +		if (hpd_state =3D=3D connector_status_connected)
> +			schedule_delayed_work(&dp->sw_hpd_irq_work, 1);
> +	}
> +	dp->ops->unlock(dp);
> +}
> +
> +static void dptx_bridge_hpd_notify(struct drm_bridge *bridge,
> +				   struct drm_connector *connector,
> +				   enum drm_connector_status status)
> +{
> +	dptx_hpd_notify(bridge_to_dp(bridge), status);
> +}

[Severity: High]
Can dptx_bridge_hpd_notify() corrupt dp->force_hpd during normal connector
detection?

drm_bridge_connector_detect_ctx() invokes dptx_bridge_hpd_notify() right
after every dptx_bridge_detect() call:

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_detect_=
ctx() {
	if (detect) {
		status =3D detect->funcs->detect(detect, connector);
		...
		drm_bridge_connector_hpd_notify(connector, status);
	}
}

Because dp->ops->detect_status() does not update dp->status (which starts
at connector_status_unknown at boot and after suspend until hpd_event_work
runs), probing a connected native DisplayPort sink enters dptx_hpd_notify()
with hpd_state !=3D dp->status and latches dp->force_hpd to
connector_status_connected.  Once dp->force_hpd is set, physical HPD state
checks evaluate true even after the cable is unplugged, wedging the native
port in a connected state.

On USB-C Alt-Mode ports, if KMS probes the connector while hpd_event_work
is still waiting for the PHY to enter DP mode, dptx_bridge_detect() fails
AUX reads and returns connector_status_disconnected; the follow-up
dptx_bridge_hpd_notify() call then overwrites dp->force_hpd with
connector_status_disconnected and aborts the PHY wait.  Similarly, probing
while DPTX_STATE_SUSPENDED is set causes dptx_bridge_detect() to return
connector_status_unknown and dptx_hpd_notify() to overwrite dp->force_hpd
with connector_status_unknown.

Also, gating the dp->force_hpd update on hpd_state !=3D dp->status while
dp->status is updated asynchronously by hpd_event_work drops rapid
plug/unplug transitions that arrive before hpd_event_work finishes (or
after the PHY wait times out without updating dp->status), leaving
dp->force_hpd stuck at the stale state.

[ ... ]
> +static enum drm_mode_status
> +dptx_bridge_mode_valid(struct drm_bridge *bridge,
> +		       const struct drm_display_info *info,
> +		       const struct drm_display_mode *mode)
> +{
[ ... ]
> +	can_420 =3D drm_mode_is_420(info, mode) && bridge->ycbcr_420_allowed &&
> +		  vsc_supported;
> +
> +	if (drm_mode_is_420_only(info, mode)) {
> +		if (!can_420)
> +			return MODE_NO_420;
> +
> +		minbpp =3D 8 * 3 / 2;
> +		pixel_per_cycle =3D 1;
> +	} else if (can_420 && adjusted.clock <=3D DPTX_MAX_FREQ) {
> +		minbpp =3D 8 * 3 / 2;
> +	} else if (info->color_formats &
> +		   BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422)) {
> +		minbpp =3D 8 * 2;
> +	}
[ ... ]
> +}
[ ... ]
> +static int dptx_cal_bpc(struct drm_connector_state *connector_state,
> +			int format, int bpc)
> +{
> +	struct drm_display_info *info =3D
> +		&connector_state->connector->display_info;
> +
> +	if (dptx_bt2020_colorspace(connector_state))
> +		bpc =3D min(bpc, 10);
> +
> +	if (info->bpc)
> +		bpc =3D min_t(int, bpc, info->bpc);
> +
> +	if (connector_state->max_requested_bpc)
> +		bpc =3D min(bpc, connector_state->max_requested_bpc);
> +
> +	if (bpc < 8 && format !=3D DRM_OUTPUT_COLOR_FORMAT_RGB444)
> +		return -EINVAL;
> +
> +	return bpc;
> +}

[Severity: Low]
Can dptx_bridge_mode_valid() accept YCbCr modes that
dptx_bridge_atomic_check() will reject when 0 < info->bpc < 8?

dptx_cal_bpc() clamps bpc to info->bpc and rejects any format other than
DRM_OUTPUT_COLOR_FORMAT_RGB444 when bpc < 8.  However,
dptx_bridge_mode_valid() allows 4:2:0-only modes and lowers minbpp to 12
(YCbCr 4:2:0) or 16 (YCbCr 4:2:2) without checking that info->bpc is 0 or
at least 8, so modes that rely on YCbCr on a 6-bpc sink pass validation
and then fail in dptx_bridge_atomic_check() with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125033238.3436=
046-1-Luo.Liu@cixtech.com?part=3D3
