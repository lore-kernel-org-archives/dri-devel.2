Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CAFC44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B247310EF4E;
	Thu, 23 Jul 2026 01:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XDZtGZ4K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11FA010EF4E
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:49:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF24141B0A;
 Thu, 23 Jul 2026 01:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9979C1F000E9;
 Thu, 23 Jul 2026 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771367;
 bh=oflAwhgRqtKE0S7ON5eYSqn7GLVsm6zmiJuQ6Y156x4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XDZtGZ4KbrnpLkQh7kI/vx8jrvUszoJ3hcdrkDNkNQeTNNEkYn51Q79UgzFjpfuPf
 3WmEgFN+UO2URKp7z9wBgLyHSCa4zz9/Lj3CeF0NBJ9Gvo4NENYipFfZYl89lRklcs
 Bvfm2Ts8d/YMargylH8Rzdv2d+8IhqrGruaDDpo/aTyIGKkaQUhm0w6k9B/Mvyy/SI
 fS9o/eh/hq85VxtoFnosOSP1/1ABKuqEEzS+QuZZKO8hRWWnyAf+U3GZ3lq4ETCdf6
 bni+GFZxBMrjKkzA9ItYkrX+FL5NMijARN/907BLXwKu7mZ+vkY1q+R7X3bfFolieq
 xaxZFpAaTiMBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 23/61] drm/bridge: dw-hdmi-qp: Provide
 dw_hdmi_qp_hpd_notify() helper
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-23-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-23-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:49:27 +0000
Message-Id: <20260723014927.9979C1F000E9@smtp.kernel.org>
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
- [Medium] Unprotected lockless access to `hdmi->curr_conn` between atomic =
commit threads and the HPD notification thread, leading to a data race.
--

--- Patch [23]: [PATCH v9 23/61] drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp=
_hpd_notify() helper ---
commit f35dc78b72396dddf94643e1b74b8f00fbaf1275
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp_hpd_notify() helper

This commit exports a helper function for platform drivers to report hot-pl=
ug
detection events. It targets the affected connector and ensures context
detection is invoked on reconnection events for SCDC state recovery.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index ee74266b7aa9c..be1bd765cb033 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c

[ ... ]

> @@ -785,6 +787,8 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct dr=
m_bridge *bridge,
>  	dw_hdmi_qp_mod(hdmi, op_mode, OPMODE_DVI, LINK_CONFIG0);
> =20
>  	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
> +
> +	hdmi->curr_conn =3D connector;

[Severity: Medium]
Is a WRITE_ONCE() needed here? hdmi->curr_conn appears to be read locklessly
by the HPD threaded IRQ or work queue context. Without WRITE_ONCE(), could
the compiler reorder the store before hardware initialization is complete?

>  }
> =20
>  static void dw_hdmi_qp_bridge_atomic_disable(struct drm_bridge *bridge,
> @@ -793,6 +797,7 @@ static void dw_hdmi_qp_bridge_atomic_disable(struct d=
rm_bridge *bridge,
>  	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
>  	struct drm_connector *connector;
> =20
> +	hdmi->curr_conn =3D NULL;

[Severity: Medium]
Does this assignment to hdmi->curr_conn also need a WRITE_ONCE() to ensure
safe concurrent access during concurrent hotplug events and modesets?

[ ... ]

> @@ -1409,6 +1414,37 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform=
_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_qp_bind);
> =20
> +/**
> + * dw_hdmi_qp_hpd_notify() - Notify a hot-plug detection event
> + * @hdmi: pointer to the DW HDMI QP controller
> + *
> + * Platform drivers should call this from their threaded IRQ handler or =
work
> + * function to notify the bridge of a connection status change.
> + * The bridge's .read_hpd() phy_ops callback is used to read the current
> + * connection status.
> + */
> +void dw_hdmi_qp_hpd_notify(struct dw_hdmi_qp *hdmi)
> +{
> +	struct drm_connector *conn =3D hdmi->curr_conn;

[Severity: Medium]
Since this is called from a threaded HPD interrupt handler or work function,
can this lockless read of hdmi->curr_conn race with the KMS modeset thread?

If the writes in the atomic commit paths use WRITE_ONCE(), does this need a
corresponding READ_ONCE() to prevent compiler optimizations like register
caching from causing stale reads?

> +	enum drm_connector_status status;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D23
