Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5754AC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7609810F421;
	Tue, 15 Sep 2026 10:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h9WnHEXm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E1210F418
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:44:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9E2F602BA;
 Tue, 15 Sep 2026 10:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455771F00893;
 Tue, 15 Sep 2026 10:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789469069;
 bh=Zp1/72hWgP54z3/O486TR4gBm4y8lXpOSzasoyoPc/k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h9WnHEXmeUVicRqE4sZ/skuCzEbLoWfNdvPqIWxTcwwaLiJTH23AVuQQNV7J4dYJq
 YOVSAwn/iByllTG7N/sUQkPtIfG+cnHJFFUnFigRAu95sn/zvd/GTUCAea+qMIBlDk
 Y+DU/UpDdIQgZvTAMD2YVVMDXTvF0A2DIUWlP6o84cX7Yq/99mL5G3OGGa0jOrF7GT
 aUFCpASJkHz+6pYGi9ztdr1mdPELgJSf4WBK4yKEi7Czsn4SGNKQ/+RsOeH/e/4/8f
 FezX9PyyfZSxMHl6Tao//dgjZpmGUJonSfIpJ5B3eCwlvqfJ5VceC1YSIj+bE80eca
 NiYUreVwvFL7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/bridge: dw-hdmi-qp: serialize HDMI audio
 callbacks with PHY enable/disable
To: "Frank Zhang" <rmxpzlb@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260915103433.13163-1-rmxpzlb@gmail.com>
References: <20260915103433.13163-1-rmxpzlb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 10:44:28 +0000
Message-Id: <20260915104429.455771F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/bridge: dw-hdmi-qp: sleeping in atomic context via mutex in at=
omic callbacks
--

commit 1e5aaa063a714d3e9e667b95f0e3087ce7b8924d
Author: Frank Zhang <rmxpzlb@gmail.com>

drm/bridge: dw-hdmi-qp: serialize HDMI audio callbacks with PHY enable/disa=
ble

This commit introduces a mutex lock and PHY enabled state to serialize PHY
state transitions and HDMI audio callbacks, aiming to fix a kernel panic=20
observed during system reboot when ALSA races with the DRM atomic framework.

Link: https://lore.kernel.org/all/20260908070220.41574-1-rmxpzlb@gmail.com/

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index c9568aea98dc8..1ffe159e5a099 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c

[ ... ]

> @@ -547,6 +571,7 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct dr=
m_bridge *bridge,
>  	struct drm_connector_state *conn_state;
>  	struct drm_connector *connector;
>  	unsigned int op_mode;
> +	int ret;
> =20
>  	connector =3D drm_atomic_get_new_connector_for_encoder(state, bridge->e=
ncoder);
>  	if (WARN_ON(!connector))
> @@ -556,6 +581,7 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct dr=
m_bridge *bridge,
>  	if (WARN_ON(!conn_state))
>  		return;
> =20
> +	mutex_lock(&hdmi->phy.lock);

[Severity: High]
Does this code acquire a sleeping lock in an atomic context?

According to the DRM subsystem rules, bridge atomic enable/disable callbacks
execute in atomic context during non-blocking commits where sleeping is
strictly forbidden. Acquiring a mutex here will cause a might_sleep()
warning, scheduler errors, and possible system deadlocks when a userspace
application or compositor issues a non-blocking atomic modeset.

>  	if (connector->display_info.is_hdmi) {
>  		dev_dbg(hdmi->dev, "%s mode=3DHDMI %s rate=3D%llu bpc=3D%u\n", __func_=
_,
>  			drm_hdmi_connector_get_output_format_name(conn_state->hdmi.output_for=
mat),

[ ... ]

> @@ -580,9 +615,10 @@ static void dw_hdmi_qp_bridge_atomic_disable(struct =
drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> =20
> +	guard(mutex)(&hdmi->phy.lock);

[Severity: High]
Can this sequence cause a panic during atomic commits?

Similar to the enable path, dw_hdmi_qp_bridge_atomic_disable() executes in
atomic context. Using guard(mutex) acquires a sleeping lock while atomic,
which violates the DRM atomic context requirements.

>  	hdmi->tmds_char_rate =3D 0;
> -
>  	hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
> +	hdmi->phy.enabled =3D false;
>  }

[ ... ]

> @@ -780,7 +825,11 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(s=
truct drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> =20
> -	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
> +	guard(mutex)(&hdmi->phy.lock);

[Severity: High]
Is this lock safe to acquire here?

dw_hdmi_qp_bridge_write_audio_infoframe() is called downstream from the
atomic enable path via drm_atomic_helper_connector_hdmi_update_infoframes().
Since it is reachable from the non-blocking atomic commit chain, acquiring a
sleeping mutex here can also lead to system deadlocks.

> +	if (!hdmi->phy.enabled)
> +		return -EOPNOTSUPP;
> +
> +	dw_hdmi_qp_clear_audio_infoframe_regs(hdmi);
> =20
>  	/*
>  	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915103433.1316=
3-1-rmxpzlb@gmail.com?part=3D1
