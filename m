Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01ACCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4C910F634;
	Fri, 19 Jun 2026 14:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A2lu1onF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A08110F634
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 14:20:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D7AE417B1;
 Fri, 19 Jun 2026 14:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1821F000E9;
 Fri, 19 Jun 2026 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781878802;
 bh=RchNNNAiNDPuhed6fVNOkH3+frly+Jxa5218rHUXgk4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A2lu1onFZBgwwWReD9iQnTWrtqydioskJO/5oALFQBugHLKbDruA1wR1MR1b2VPNY
 MTOpJi/5yZQ2MwwslR1tNt3mGoSMhh+T9dyZu9tH4NqH3AeJsQuPea1yMZj35cxeDD
 bGasfZpYACN2Pk5WI31QCbxLfQstUAi26LEuNCZvp/9GnPLqB6eDVgu+mdEjgT4tX+
 iMJIVqAmLSRH8oAOIBGVm7XVAyFmWK6w3iVAF23KqZqG++N+Ps7CBf8bLi3eS+LOZb
 mtzK2ObpbQE7QYmh67iYRxZ/O2A+NOEfnRzH0a845aXvMHY0ZmwEUrc/7hZChZMZJX
 FY6Bqjj3M9vGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 4/4] drm/mediatek: Use dp_connector helpers to
 report link training state
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260619-feat_link_cap-v2-4-a3dec4c02ad9@bootlin.com>
References: <20260619-feat_link_cap-v2-0-a3dec4c02ad9@bootlin.com>
 <20260619-feat_link_cap-v2-4-a3dec4c02ad9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 14:20:01 +0000
Message-Id: <20260619142002.2A1821F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The DRM_BRIDGE_OP_DP flag is unintentionally overwritten and lost =
for external DP configurations, breaking the patch's main goal.
- [High] Calling DRM DP connector state update helpers from the HPD event t=
hread and atomic_enable without holding the connection mutex triggers kerne=
l WARN_ON traces.
- [High] DP link capabilities and parameters are silently dropped because m=
tk_dp->conn is NULL during the first hotplug event and during probe for eDP.
- [Medium] The patch fails to implement the voltage swing and pre-emphasis =
link training properties claimed in the commit message.
--

commit 329f586786239579aef1351b83fdceecb28dd1e1
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/mediatek: Use dp_connector helpers to report link training state

Set DRM_BRIDGE_OP_DP and populate dp_link_train_caps with the supported
link rates, lane counts, voltage swing and pre-emphasis levels so the
bridge connector uses drmm_connector_dp_init() and exposes the link
training state properties to userspace.

Store per-lane voltage swing and pre-emphasis values in
mtk_dp_train_info and report the negotiated link parameters via
drm_connector_dp_set_link_train_properties() on training completion.
Clear them via drm_connector_dp_reset_link_train_properties() when a
disconnect is detected in the HPD event thread.

> Set DRM_BRIDGE_OP_DP and populate dp_link_train_caps with the supported
> link rates, lane counts, voltage swing and pre-emphasis levels so the
> bridge connector uses drmm_connector_dp_init() and exposes the link
> training state properties to userspace.
>=20
> Store per-lane voltage swing and pre-emphasis values in
> mtk_dp_train_info and report the negotiated link parameters via
> drm_connector_dp_set_link_train_properties() on training completion.

[Severity: Medium]
The commit message mentions populating voltage swing and pre-emphasis levels
and using drm_connector_dp_set_link_train_properties(). Is this description
accurate?

The actual patch only sets up lanes and link rates in dp_link_caps, and the=
re
are no calls to drm_connector_dp_set_link_train_properties() in the diff.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index c52cc7c2e2006..439b9496632fe 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1789,6 +1789,8 @@ static int mtk_dp_parse_capabilities(struct mtk_dp =
*mtk_dp)
>  		}
>  	}
> =20
> +	drm_dp_sink_set_link_caps(mtk_dp->conn, &mtk_dp->aux);
> +
>  	return 0;
>  }

[Severity: High]
Will mtk_dp->conn be NULL when this is called during eDP probe or the first
hotplug event?

The connector appears to only be initialized later during
mtk_dp_bridge_atomic_enable(). If mtk_dp->conn is NULL,
drm_dp_sink_set_link_caps() will silently return early and discard the
parsed capabilities.

[Severity: High]
Also, drm_dp_sink_set_link_caps() expects the caller to hold the connection
mutex, enforcing it with:

WARN_ON(!drm_modeset_is_locked(&connector->dev->mode_config.connection_mute=
x));

Are we guaranteed to hold the modeset lock when reaching this from the
HPD event thread or eDP probe path?

[ ... ]

> @@ -1812,6 +1814,17 @@ static void mtk_dp_train_change_mode(struct mtk_dp=
 *mtk_dp)
>  	mtk_dp_reset_swing_pre_emphasis(mtk_dp);
>  }
> =20
> +static void mtk_dp_report_link_train(struct mtk_dp *mtk_dp)
> +{
> +	u32 rate, nlanes;
> +
> +	rate =3D drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_rate);
> +	nlanes =3D mtk_dp->train_info.lane_count;
> +
> +	drm_dp_set_cur_link_params(mtk_dp->conn, rate, nlanes, false);
> +	drm_dp_set_max_link_params(mtk_dp->conn, rate, nlanes);
> +}

[Severity: High]
Similar to the capability parsing above, can mtk_dp->conn be NULL here if
called from the HPD thread before the first modeset?

Additionally, these helper functions also require the connection mutex. Sin=
ce
mtk_dp_report_link_train() is called from mtk_dp_training() which can be
reached from the lockless non-blocking atomic_enable path, could this
trigger a WARN_ON?

[ ... ]

> @@ -2004,6 +2018,7 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd,=
 void *dev)
>  			mtk_dp->need_debounce =3D false;
>  			mod_timer(&mtk_dp->debounce_timer,
>  				  jiffies + msecs_to_jiffies(100) - 1);
> +			drm_dp_sink_reset_link_caps(mtk_dp->conn);
>  		} else {
>  			mtk_dp_aux_panel_poweron(mtk_dp, true);

[Severity: High]
Calling drm_dp_sink_reset_link_caps() directly from the asynchronous HPD IRQ
thread will trigger a kernel warning because the connection mutex is not
held. Is there a way to defer this update to a workqueue or safely grab the
required modeset locks?

[ ... ]

> @@ -2809,6 +2830,8 @@ static int mtk_dp_probe(struct platform_device *pde=
v)
> =20
>  	mtk_dp->bridge.of_node =3D dev->of_node;
>  	mtk_dp->bridge.type =3D mtk_dp->data->bridge_type;
> +	mtk_dp->bridge.dp_link_caps =3D &dp_link_caps;
> +	mtk_dp->bridge.ops =3D DRM_BRIDGE_OP_DP;
> =20
>  	if (mtk_dp->bridge.type =3D=3D DRM_MODE_CONNECTOR_eDP) {
>  		/*

[Severity: High]
Does this assignment get lost for external DP configurations?

Further down in mtk_dp_probe(), the non-eDP branch assigns the ops directly
using an equals sign instead of a bitwise OR:

	} else {
		mtk_dp->bridge.ops =3D DRM_BRIDGE_OP_DETECT |
				     DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
		...
	}

This appears to completely overwrite the DRM_BRIDGE_OP_DP flag added above,
which would prevent the bridge connector from exposing link training
properties to userspace for external DP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-feat_link_=
cap-v2-0-a3dec4c02ad9@bootlin.com?part=3D4
