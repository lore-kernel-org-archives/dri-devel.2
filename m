Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5B4C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5F910E217;
	Fri, 17 Jul 2026 19:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SsQgn2qu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D47410E217
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 19:01:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 695B0600DA;
 Fri, 17 Jul 2026 19:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED10E1F00A3D;
 Fri, 17 Jul 2026 19:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784314889;
 bh=mKHBz7JrPQVLlFzVG0bmCx1FGOzKCvTz126kGZUBj64=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SsQgn2quF8FLyp5eZ9Ufy7rLLnQUwC4J6+Iz2dlQI33AXELzKZyTsqPwXNRfNg3Bi
 dcsTERg7U/j6/ysk5++2N0bK5Kz4GlUX1oK9niK4jdSRc+gqDPfvpK5kUC42O2txrs
 xsbmPTRCRt7fBD2Ol31ICy9UweWKvAlupt8Ku99ps8U6MfVLk3KRDLNHH64/J2bUaM
 MmJw8xsw4JzW8MF7m8dnbyE6KPUz0sF1CgbtNEiSrNcb9vGav3Jix8PFnim/dZyLK6
 RtDRAT/4yFN7iPMlVRyETnKei1glT+L9dNcfYiEI3i7ocEcNBIBXu3dyeyrDcquPlT
 GApYQCtbZ+Tgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/bridge: display-connector: Fix I2C adapter
 resource leak
To: "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260717184836.2017386-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20260717184836.2017386-1-laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 19:01:28 +0000
Message-Id: <20260717190128.ED10E1F00A3D@smtp.kernel.org>
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
- [High] Use-After-Free of devm-managed resources (hpd_gpio, hpd_irq) and l=
ocking of destroyed mutexes during driver unbind.
--

--- Patch [1]: [PATCH v2] drm/bridge: display-connector: Fix I2C adapter re=
source leak ---
commit 2b26eaff927cdb68a6ad11049169cdda7d66a1f8
Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

drm/bridge: display-connector: Fix I2C adapter resource leak

This commit moves the release of the I2C adapter to the bridge .destroy()
handler to fix a reference leak when probe fails after getting the DDC
adapter.

> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm=
/bridge/display-connector.c
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c

[ ... ]

> @@ -439,9 +447,6 @@ static void display_connector_remove(struct platform_=
device *pdev)
>  		regulator_disable(conn->supply);
> =20
>  	drm_bridge_remove(&conn->bridge);

[Severity: High]
This is a pre-existing issue, but does the bridge removal sequence leave
devm-managed resources vulnerable to a use-after-free?

If the driver is unbound while the bridge is still attached to a DRM encode=
r,
drm_bridge_remove() destroys bridge->hpd_mutex and moves the bridge to a
lingering list. Because hpd_gpio and hpd_irq are devm-managed, devres will
free them as soon as display_connector_remove() returns.

Could an incoming HPD interrupt fire right after drm_bridge_remove() and try
to lock the destroyed bridge->hpd_mutex via drm_bridge_hpd_notify()?

Additionally, if the DRM core later calls display_connector_detect() or
display_connector_hpd_disable() on the lingering bridge, would it result in=
 a
use-after-free when accessing the freed conn->hpd_gpio or conn->hpd_irq?

> -
> -	if (!IS_ERR(conn->bridge.ddc))
> -		i2c_put_adapter(conn->bridge.ddc);
>  }
> =20
>  static const struct of_device_id display_connector_match[] =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717184836.2017=
386-1-laurent.pinchart+renesas@ideasonboard.com?part=3D1
