Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D08CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFE810ECCA;
	Tue, 29 Sep 2026 04:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GsRTeLFH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D6A10ECC7
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:48:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54DCF438FB;
 Tue, 29 Sep 2026 04:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178FD1F000FF;
 Tue, 29 Sep 2026 04:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657339;
 bh=3h8AwyLHU9qUT/6XyBJMtHahmnczW70hwLe/9Ba71uQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GsRTeLFHIESxE0H45prYpaBmm/H4xKQe43HRsPZcCM2ubGUQX6qf8koYWqGs5Rl9+
 B5JUgKcqQ9Xht2t7EKhomI2SvMbnu6Al2Ih5S11Giyt7fZYI3qP5LcDZTv1TN0veWd
 ZnOxfKGRo5Ef6LZwDKfKdKYrxD3BnHxPpEDv9zdV/+xjrNYy7Z9pzW+d8FiUiXQdZ7
 oA0a66ozBo7AfExbtdPTOmtkbVLlEHp7l8U2Q1MJOnD2RGHvVQPd0RYAqzizSEaL7f
 NEA2yuqwhGWZYDNJ5S45yIWsIykotwejo3PDxlKL2hr63dkmuJ9IwgKTtadYar/F7i
 XHII8+J926J+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/35] drm/msm/dp: add MST connector creation and
 topology callbacks
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-19-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-19-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:48:58 +0000
Message-Id: <20260929044859.178FD1F000FF@smtp.kernel.org>
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
- [High] drm/msm/dp: atomic state corruption in msm_dp_mst_atomic_best_enco=
der()
- [High] drm/msm/dp: pm_runtime misuse on wrong device in msm_dp_mst_connec=
tor_detect()
--

commit af860d77fac53017d8dd8356f2f4d0aafac13cf3
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: add MST connector creation and topology callbacks

This commit registers the add_connector topology callback with the DRM MST
manager to dynamically create DRM connectors for MST ports. It also impleme=
nts
the necessary connector operations and DRM MST callbacks to expose MST sink
ports.

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index 5d22aa34c521c..169b34f985c0e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
[ ... ]
> +static int
> +msm_dp_mst_connector_detect(struct drm_connector *connector,
> +			    struct drm_modeset_acquire_ctx *ctx,
> +			    bool force)
> +{
> +	struct msm_dp_mst_connector *mst_conn =3D to_dp_mst_connector(connector=
);
> +	struct msm_dp_mst *mst =3D mst_conn->dp_mst;
> +	struct msm_dp *dp_display =3D mst->msm_dp;
> +	struct device *dev =3D dp_display->drm_dev->dev;

[Severity: High]
Does this use the correct device for PM runtime?

By using the top-level DRM device (dp_display->drm_dev->dev), it appears the
detect function acquires PM references for the MDSS parent instead of the DP
controller (dp_display->pdev->dev).

> +	enum drm_connector_status status =3D connector_status_disconnected;
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);

[Severity: High]
Can this cause excessive PHY teardowns during detection?

Because the DP controller's PM is not explicitly held open, each underlying
AUX transfer during drm_dp_mst_detect_port() will individually resume and
synchronously suspend the DP controller (via msm_dp_aux_transfer()).

Could this tear down and reinitialize the DP PHY for every single AUX messa=
ge,
causing overhead and risking link training or topology discovery failures?

> +	if (ret < 0)
> +		return status;
> +
> +	if (dp_display->mst_active)
> +		status =3D drm_dp_mst_detect_port(connector,
> +						ctx, &mst->mst_mgr, mst_conn->mst_port);
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return status;
> +}
[ ... ]
> +static struct drm_encoder *
> +msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct d=
rm_atomic_commit *state)
> +{
> +	struct msm_dp_mst_connector *mst_conn =3D to_dp_mst_connector(connector=
);
> +	struct msm_dp_mst *mst =3D mst_conn->dp_mst;
> +	struct drm_connector_state *conn_state;
> +	struct drm_connector *iter;
> +	struct drm_connector_list_iter conn_iter;
> +	u32 stream_mask =3D 0;
> +	u32 i;
> +
> +	conn_state =3D drm_atomic_get_new_connector_state(state, connector);
> +	if (!conn_state)
> +		return NULL;
> +
> +	if (conn_state->best_encoder)
> +		return conn_state->best_encoder;
> +
> +	drm_connector_list_iter_begin(connector->dev, &conn_iter);
> +	drm_for_each_connector_iter(iter, &conn_iter) {
> +		struct drm_connector_state *peer_state;
> +		int stream_id;
> +
> +		if (iter =3D=3D connector ||
> +		    iter->funcs !=3D &msm_dp_drm_mst_connector_funcs ||
> +		    to_dp_mst_connector(iter)->dp_mst !=3D mst)
> +			continue;
> +
> +		peer_state =3D drm_atomic_get_new_connector_state(state, iter) ?: iter=
->state;
> +		if (!peer_state || !peer_state->crtc || !peer_state->best_encoder)
> +			continue;
> +
> +		stream_id =3D msm_dp_mst_encoder_stream_id(mst, peer_state->best_encod=
er);
> +		if (stream_id >=3D 0 && stream_id < mst->max_streams)
> +			stream_mask |=3D BIT(stream_id);
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	for (i =3D 0; i < mst->max_streams; i++) {
> +		if (!(stream_mask & BIT(i))) {
> +			conn_state->best_encoder =3D mst->mst_encoders[i].enc;

[Severity: High]
Does directly modifying the atomic state here hide the routing change from =
the
DRM core?

By overwriting conn_state->best_encoder, the update_connector_routing() che=
ck
if (new_encoder =3D=3D new_connector_state->best_encoder) evaluates to true=
 and
returns early.

This causes steal_encoder() to be skipped, leaving the old CRTC's
encoder_mask with the old encoder, and connectors_changed is never set on
the new CRTC. Could this leave the DRM core's atomic state tracking
corrupted and cause hardware conflicts where multiple connectors claim the
same encoder?

> +			return mst->mst_encoders[i].enc;
> +		}
> +	}
> +
> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D19
