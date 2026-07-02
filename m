Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2452DC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 813F310E4F5;
	Thu,  2 Jul 2026 15:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F3x7IFJR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E3B10E4F5
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:03:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C5B541A25;
 Thu,  2 Jul 2026 15:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332C81F000E9;
 Thu,  2 Jul 2026 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783004594;
 bh=zftApm7FiOdtnsjh+Wpou39W/UU5Ntnq8nnRUOya3/A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F3x7IFJRKYVQxYb8CPynifCejHcp54AgjJf3NLxxg2l1ag4X0OZLharzTk3JLB0AR
 C2qMEoChmcozVQgRV1p7jKjO2UCHkgBOAticKnwc+g1e3syARcwqq4/h3uTClnKaOZ
 kVPdeONWBg6bvRtli2UrSZqv9Rj1424Owa7JLmQyMPODiiYNWr+hITWZKv7SgS/cSI
 t1d3QEXYk9OPXd9j0fYCLyRMaUaHk/3KoIq28sxS/W4VaLx4XJtL1RSDCTS7TlPTll
 1oL6Eu6eFOG9+k/0DaQKhp0A/yJHphb9vnjj6w0Ft2Jw0c4hnH9LxqnSatt7YHGbN8
 86ES7jFHGTreg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 20/39] drm/bridge: dw-hdmi-qp: Provide
 dw_hdmi_qp_hpd_notify() helper
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-20-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-20-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:03:13 +0000
Message-Id: <20260702150314.332C81F000E9@smtp.kernel.org>
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
- [High] Unprotected double-read of `hdmi->curr_conn` causes a Time-Of-Chec=
k to Time-Of-Use (TOCTOU) data race, leading to a potential NULL pointer de=
reference.
--

commit 8041d212a61ef15cbf004795e5f7dc2a8f5f69ad
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp_hpd_notify() helper

This commit introduces the dw_hdmi_qp_hpd_notify() helper to allow platform
drivers to report hot-plug detection events directly to the affected
connector. It ensures the detect context is invoked on reconnection events
by using drm_connector_helper_hpd_irq_event() when the display pipeline is
active.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index 07b274f76e53e..4d41ad7319a58 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
[ ... ]
> @@ -1429,6 +1430,36 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform=
_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_qp_bind);
> =20
> +/**
> + * dw_hdmi_qp_hpd_notify() - Notify a hot-plug detection event
[ ... ]
> +void dw_hdmi_qp_hpd_notify(struct dw_hdmi_qp *hdmi)
> +{
> +	enum drm_connector_status status;
> +
> +	status =3D hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> +	dev_dbg(hdmi->dev, "%s status=3D%d\n", __func__, status);
> +
> +	/*
> +	 * When the display pipeline has been already active, switch to
> +	 * drm_connector_helper_hpd_irq_event() to ensure .detect_ctx()
> +	 * gets invoked, i.e. via drm_helper_probe_detect(), because
> +	 * drm_bridge_hpd_notify() defers to a delayed hotplug path in
> +	 * this case.
> +	 */
> +	if (hdmi->curr_conn && status =3D=3D connector_status_connected)
> +		drm_connector_helper_hpd_irq_event(hdmi->curr_conn);

[Severity: High]
Could this double-read of hdmi->curr_conn lead to a NULL pointer dereference
due to a Time-Of-Check to Time-Of-Use race?

If an HPD interrupt or workqueue executes dw_hdmi_qp_hpd_notify()
concurrently with dw_hdmi_qp_bridge_atomic_disable() during a modeset, could
the modeset thread clear hdmi->curr_conn locklessly?=20

Thread 1 (HPD notify):
    if (hdmi->curr_conn && ...) // Evaluates to true

Thread 2 (Modeset disable):
    dw_hdmi_qp_bridge_atomic_disable() {
        ...
        hdmi->curr_conn =3D NULL;
    }

Thread 1 (HPD notify resumes):
    drm_connector_helper_hpd_irq_event(hdmi->curr_conn); // Passes NULL

If the compiler emits a second read of the pointer for the argument, it
would pass NULL to drm_connector_helper_hpd_irq_event(), which
unconditionally dereferences the connector pointer. Would it be safer to use
READ_ONCE() or a local variable to cache the connector pointer before
checking and passing it?

> +	else
> +		drm_bridge_hpd_notify(&hdmi->bridge, status);
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_qp_hpd_notify);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D20
