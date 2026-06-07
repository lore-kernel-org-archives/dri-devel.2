Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A23CD8C90
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D5E10E68B;
	Sun,  7 Jun 2026 21:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dvbsS/3V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FAF10E683
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:49:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0167C60018;
 Sun,  7 Jun 2026 21:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D601F00893;
 Sun,  7 Jun 2026 21:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780868960;
 bh=oH5bCZafM+G4vEBXBEx1ZITPaqUg1BJNd24oKWADpts=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dvbsS/3VuhxLU3xOsqpN6wkxlxrgGh5MqEBG5Z88f6mZn0Cn1k37NnLCCAFpqoSER
 evGxHq26G5X00IVAiipgQPnR/e5gyuGWfcP3B8c+wQxeI/zRKVgOQZvu6WlMYN5xKE
 EISli4Z3xUiJRGK8F5V6GCo/kGgPQVyDDasT7gXeUO3VvWx6qL0kcAztUTqrvvONbp
 iUQWrN4YJ+zn0su1HN0zdqZmKpBUTp34HLiQgHq62GCC9UwiF51DLrXEDlXXC6/C5u
 FafHO5PlQhEHDTo2RXVrmLy5aP5BXPACcjzJAq3dIa9J5NA6macNP/YjsaqOxj6tn2
 KhEtfyZL4BePw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/8] drm/bridge: pass down IRQ_HPD to the drivers
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260608-hpd-irq-events-v4-5-30b62b335487@oss.qualcomm.com>
References: <20260608-hpd-irq-events-v4-5-30b62b335487@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 21:49:20 +0000
Message-Id: <20260607214920.72D601F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Modifying connector EDID properties without holding `mode_config.m=
utex` during asynchronous hotplug notifications.
--

commit 6e60e13be304386d0a94f5ceade83e44677e2a2a
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/bridge: pass down IRQ_HPD to the drivers

The DisplayPort standard defines a special kind of HPD events called IRQ_HP=
D.
These events are used to notify DP Source about the events on the Sink side.
This commit passes down the extra status to the bridge drivers via the
hpd_notify() callback.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm=
/bridge/lontium-lt9611uxc.c
> index 9427cc2358ae1..8cb17bd0e2387 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -429,7 +429,8 @@ static const struct drm_edid *lt9611uxc_bridge_edid_r=
ead(struct drm_bridge *brid
> =20
>  static void lt9611uxc_bridge_hpd_notify(struct drm_bridge *bridge,
>  					struct drm_connector *connector,
> -					enum drm_connector_status status)
> +					enum drm_connector_status status,
> +					enum drm_connector_status_extra extra_status)
>  {
>  	const struct drm_edid *drm_edid;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential locking
issue here in lt9611uxc_bridge_hpd_notify().

This function calls drm_edid_connector_update(), which modifies
connector->edid_blob_ptr. According to DRM documentation, edid_blob_ptr acc=
ess
and modification via drm_property_replace_global_blob must be protected by
mode_config.mutex.

However, when the hpd_notify pipeline is triggered asynchronously via
drm_bridge_connector_handle_hpd() in drm_bridge_connector.c, the caller
intentionally drops the lock prior to executing the callbacks:

drm_bridge_connector_handle_hpd() {
    ...
    mutex_unlock(&dev->mode_config.mutex);
    drm_bridge_connector_hpd_notify(connector, status, extra_status);
    ...
}

Could this lead to a data race on connector->edid_blob_ptr if hotplug events
occur concurrently with userspace queries or modesets, potentially causing a
double-free or use-after-free of the blob data?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-hpd-irq-ev=
ents-v4-0-30b62b335487@oss.qualcomm.com?part=3D5
