Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E05C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593C910E268;
	Sun,  5 Jul 2026 21:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UUC3O1qk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DEA10E268
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 21:44:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0975460018;
 Sun,  5 Jul 2026 21:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5195C1F000E9;
 Sun,  5 Jul 2026 21:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783287893;
 bh=dh3N2oIogZcdyO5Fv7nBsba8L/DMUWLRgHZHLd7VQrE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UUC3O1qkcUPl2vv/EtLof1kts8ZC0ZbpMZ4o4cWCF09WUq9R7juw6IhhzKgxnGm7r
 DO0FmAXqFsn/g7qPFFYznMlN5eAyeAApyq23Il+KTW0U85vuAQbWtUSPBxotAw0ohY
 oS77uOiTW6d8u53MoywY0f2F9tirZc0gazKoZFjnjhVwXVBfnuPirdrsIcyUoPPWaP
 YADg1zgC5dSDvtH6miXxc/PV/lsSMnyzL0P9miQPLm1RUXSQ/fOe/pBkSMbiHTRAlB
 uN0aJtFaPGsn0Cointp5al2auvCzYz2nOj8x1gZrB8M3wC29iKfUEYe0faiJwDI/GY
 BytRXXCLPh3Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/bridge: display-connector: Support hardcoded
 EDID for VGA connectors
To: "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 wsa+renesas@sang-engineering.com
In-Reply-To: <20260705213542.28987-4-laurent.pinchart+renesas@ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-4-laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:44:52 +0000
Message-Id: <20260705214453.5195C1F000E9@smtp.kernel.org>
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
- [High] Use-After-Free of devm-managed resources and missing asynchronous =
cleanup during device removal when the driver is unbound.
--

commit 48f63e147d7554f73cd9df360e29fd0b0ddb5d8d
Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

drm/bridge: display-connector: Support hardcoded EDID for VGA connectors

This commit adds support for parsing a hardcoded EDID blob from the device =
tree
for VGA connectors when DDC signals are not connected. It also ensures that
specifying both a DDC bus and a hardcoded EDID returns an error during prob=
e.

> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm=
/bridge/display-connector.c
> index eb3412ec30a07..225a8e987d086 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c

[ ... ]

> @@ -64,6 +67,9 @@ static enum drm_connector_status display_connector_dete=
ct(struct drm_bridge *bri
>  	if (conn->bridge.ddc && drm_probe_ddc(conn->bridge.ddc))
>  		return connector_status_connected;
> =20
> +	if (conn->edid)
> +		return connector_status_connected;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does device removal have a
use-after-free vulnerability when the driver is unbound via sysfs?

Looking at display_connector_detect() in=20
drivers/gpu/drm/bridge/display-connector.c, if the driver is bound and atta=
ched
to a DRM encoder, and then unbound via sysfs:

1. display_connector_remove() calls drm_bridge_remove() but does not call
   disable_irq() or cancel_work_sync(&conn->hpd_work).
2. The bridge structure is kept alive because the DRM core still holds a
   reference count.
3. The driver core's devres_release_all() runs and frees conn->hpd_gpio and
   the IRQ.

If the DRM core then polls detect, it will execute display_connector_detect=
():

	if (conn->hpd_gpio) {
		if (gpiod_get_value_cansleep(conn->hpd_gpio))
			...

Will this dereference the devres-freed conn->hpd_gpio?

Additionally, if the concurrent hpd_work executes, will it attempt to lock
bridge->hpd_mutex which was already destroyed by drm_bridge_remove()?

>  	switch (conn->bridge.type) {
>  	case DRM_MODE_CONNECTOR_DVIA:

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705213542.2898=
7-1-laurent.pinchart+renesas@ideasonboard.com?part=3D3
