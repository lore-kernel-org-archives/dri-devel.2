Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CED606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSLYybxi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E23710E61C;
	Fri, 23 Oct 2026 13:49:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3926D10E342;
 Fri, 23 Oct 2026 13:49:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21FD740A7D;
 Fri, 23 Oct 2026 13:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03D11F01828;
 Fri, 23 Oct 2026 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792763357;
 bh=J5jLfRgfnru1f4M7HoIviw9jPxy8kFRXF0YNC8/6MY0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PSLYybxiSnX2XIw1BFiB6WDnlAN5VaCR9EuyW/3jTSvjvew/o7UuLgHMxkxzqaNvx
 nne7wobIlNsoiXs6RC22errueIbEOJCOhO51HLdXHXJ9CooqLXGX5tOCiLR7uSlKal
 w5t7iH4+proFiBY8sVJxJaV9jd6F8xp2OVxG+K/fEku8q7Jom+tFKfrLUAA+Vgakfe
 MnSmIQ0lZCfz1QcCWNrzzcDxGLsdzQvr9fNq4U4r3IMhE2UjIUNbAtREivaQv6ucEk
 b42JRIFmPdNu7CWbG0Iml2dfk1vYiyKbPpfqvT9e79ucw8k7N4kGCiahmwS7Rv9czp
 TNEIHTuDREyuQ==
Message-ID: <sashiko-outbox-182853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] drm/bridge: pass extra events to the HPD callback
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20261023-hpd-irq-events-v7-4-57a3aea3f09e@oss.qualcomm.com>
References: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
 <20261023-hpd-irq-events-v7-4-57a3aea3f09e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:49:16 +0000
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
- [Low] drm/bridge: misplaced hdmi5_bridge_hpd_notify() hunk breaks bisecti=
on
--

commit c49a65530348caef1493cae37ceadb5599e2733e
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/bridge: pass extra events to the HPD callback

This commit introduces drm_bridge_hpd_notify_extra() and updates the HPD
callback signature registered via drm_bridge_hpd_enable() to pass extra
DisplayPort sink events to underlying drivers.

> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdr=
m/dss/hdmi5.c
> index c542ba6ce7d32..a21f9355594cc 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> @@ -427,7 +427,8 @@ static void hdmi5_bridge_disable(struct drm_bridge *b=
ridge,
> =20
>  static void hdmi5_bridge_hpd_notify(struct drm_bridge *bridge,
>  				    struct drm_connector *connector,
> -				    enum drm_connector_status status)
> +				    enum drm_connector_status status,
> +				    enum drm_connector_dp_event event)
>  {
>  	struct omap_hdmi *hdmi =3D drm_bridge_to_hdmi(bridge);
> =20

[Severity: Low]
Should this change to hdmi5_bridge_hpd_notify() in
drivers/gpu/drm/omapdrm/dss/hdmi5.c be squashed into the preceding commit
8fdca4f38003 ("drm/bridge: pass down IRQ_HPD to the drivers") instead?

hdmi5_bridge_hpd_notify() is assigned to struct drm_bridge_funcs.hpd_notify
in hdmi5_bridge_funcs rather than passed to drm_bridge_hpd_enable():

drivers/gpu/drm/omapdrm/dss/hdmi5.c:
static const struct drm_bridge_funcs hdmi5_bridge_funcs =3D {
	...
	.hpd_notify =3D hdmi5_bridge_hpd_notify,
};

Because struct drm_bridge_funcs.hpd_notify in include/drm/drm_bridge.h was
updated to take the enum drm_connector_dp_event parameter in commit
8fdca4f38003 (alongside hdmi4_bridge_hpd_notify()), leaving the
hdmi5_bridge_hpd_notify() update until this commit causes an incompatible
function pointer type build failure at commit 8fdca4f38003 when building
drivers/gpu/drm/omapdrm/dss/hdmi5.c, breaking bisection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-hpd-irq-ev=
ents-v7-0-57a3aea3f09e@oss.qualcomm.com?part=3D4
