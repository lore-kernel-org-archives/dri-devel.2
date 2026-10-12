Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0237CA9EDD
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0628410F1DE;
	Mon, 12 Oct 2026 15:26:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B14410F1E9;
 Mon, 12 Oct 2026 15:26:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 56891402A6;
 Mon, 12 Oct 2026 15:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0410B1F0089B;
 Mon, 12 Oct 2026 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791818810;
 bh=LpIxAIfRBHZV5Z00wloQbSHx/z7+8jFl3pLrya4Ve9Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X5PCRVTYlgwmVE1ru7VadSiTDCra3oNJrw+HXimVgiPWNyUPNK4LqGuCgKo9wrtQe
 wS/6D5z43mpENsp5enqVCOXfFG3FcpTqYVZT/40bs9ScH6BLL+jI9gydrBn6x02jch
 4rGfW2EKMc3Pu87Ma1nyDdWn633zExCAXF2eXKHmH9QXCLHgFBSiVZuaspsUqLNuml
 aEhN0Hif24j9JSj41NYxY8bTTaybeqb7J4015JtbquOCzC2xNxB1Umk+ajIQqxJWPf
 czUOotzf3DgYu8WeOyraSr6l17VT6ylgz46xu/zJCnwUO0oZTou67Oc89TnrljFmCQ
 HjshxdgbYZS7w==
Message-ID: <sashiko-outbox-168333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 8/8] drm/mediatek: Use dp_connector helpers to
 expose link training state
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012-feat_link_cap-v3-8-7517f4aba0f3@bootlin.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
 <20261012-feat_link_cap-v3-8-7517f4aba0f3@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:26:49 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm: connection_mutex not held during atomic_enable/disable DP sin=
k helpers
- [Medium] drm: missed DP link parameter reporting on initial hotplug
--

commit db3d1199eb9fddde4ac0ef014ef0885a214a3723
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/mediatek: Use dp_connector helpers to expose link training state

Adopt the DRM core DisplayPort helpers by setting DRM_BRIDGE_OP_DP and
populating the bridge dp_link_caps at probe time. Report the sink
capabilities on hotplug, reset them on disconnect, and report the link
parameters once link training succeeds.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index f656b85b84212..2e2596eaa342e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c

[ ... ]

> @@ -1812,6 +1812,35 @@ static void mtk_dp_train_change_mode(struct mtk_dp=
 *mtk_dp)
>  	mtk_dp_reset_swing_pre_emphasis(mtk_dp);
>  }
> =20
> +static void _mtk_dp_report_link_train(struct mtk_dp *mtk_dp)
> +{
> +	u32 rate, nlanes;
> +	bool dsc =3D false;
> +
> +	rate =3D drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_rate);
> +	nlanes =3D mtk_dp->train_info.lane_count;
> +
> +	drm_dp_set_cur_link_params(mtk_dp->conn, rate, nlanes, dsc);
> +}
> +
> +static void mtk_dp_report_link_train(struct mtk_dp *mtk_dp)
> +{
> +	struct drm_modeset_lock *lock;
> +	int ret;
> +
> +	if (!mtk_dp->conn)
> +		return;

[Severity: Medium]
Will this silently discard the link training parameters on the initial
hotplug?

Because the initial HPD interrupt fires before any atomic modeset has
occurred, mtk_dp->conn is only initialized later in
mtk_dp_bridge_atomic_enable(). At this point, it will be NULL, causing
mtk_dp_report_link_train() to return immediately.

Furthermore, while mtk_dp_bridge_atomic_enable() does report link training,
it restricts it to eDP. Will standard DP connections ever report their
current link parameters to the DRM core for the initial connection?

[ ... ]

> @@ -2390,12 +2433,20 @@ static void mtk_dp_bridge_atomic_enable(struct dr=
m_bridge *bridge,
>  	if (mtk_dp->data->bridge_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
>  		mtk_dp_aux_panel_poweron(mtk_dp, true);
> =20
> +		ret =3D drm_dp_sink_sync_caps(mtk_dp->conn, &mtk_dp->aux, NULL);

[Severity: High]
Does this code call drm_dp_sink_sync_caps() while the modeset locks are
dropped?

During a non-blocking atomic commit, the atomic_enable and atomic_disable
callbacks are executed in a worker thread asynchronously, and all modeset
locks (including connection_mutex) are intentionally dropped by the
submitter thread beforehand.

Since drm_dp_sink_sync_caps() explicitly enforces that the connector's
connection_mutex is held by asserting
drm_modeset_lock_assert_held(&connector->dev->mode_config.connection_mutex),
will this trigger a lockdep splat?

> +		if (ret)
> +			drm_dbg_kms(mtk_dp->aux.drm_dev,
> +				    "%s: error sink caps synchronisation (%d)\n",
> +				    mtk_dp->aux.name, ret);
> +
>  		/* Training */
>  		ret =3D mtk_dp_training(mtk_dp);
>  		if (ret) {
>  			drm_err(mtk_dp->drm_dev, "Training failed, %d\n", ret);
>  			goto power_off_aux;
>  		}
> +
> +		_mtk_dp_report_link_train(mtk_dp);

[Severity: High]
Does calling _mtk_dp_report_link_train() here bypass the locking that is
normally handled by the mtk_dp_report_link_train() wrapper?

_mtk_dp_report_link_train() eventually calls drm_dp_set_cur_link_params(),
which also asserts that connection_mutex is held. Since the lock is dropped
in atomic_enable, is it safe to expose the connector's properties to
concurrent data races without the lock?

>  	}
> =20
>  	ret =3D mtk_dp_video_config(mtk_dp);

[ ... ]

> @@ -2435,6 +2486,7 @@ static void mtk_dp_bridge_atomic_disable(struct drm=
_bridge *bridge,
>  	if (mtk_dp->data->bridge_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
>  		mtk_dp->enabled =3D false;
>  		mtk_dp_aux_panel_poweron(mtk_dp, false);
> +		drm_dp_sink_reset_caps(mtk_dp->conn);

[Severity: High]
Similar to the issue above, does this call drm_dp_sink_reset_caps() in an
unlocked context?

This function also asserts that connection_mutex is held, which would lead
to a lockdep splat during an asynchronous atomic commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-feat_link_=
cap-v3-0-7517f4aba0f3@bootlin.com?part=3D8
