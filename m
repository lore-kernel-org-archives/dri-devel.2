Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1B2C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3088110F4B3;
	Fri, 17 Jul 2026 09:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jbYp7DIa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9322A10F4B3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:10:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9EFF60A5E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBDE1F000E9;
 Fri, 17 Jul 2026 09:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784279413;
 bh=yZTaE4Ml28Zkl17CGVxhIiqXlWqO9xRuqUkTnOGC1Dw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jbYp7DIaJnoNfciGtuPLtG4Ds1jBCZa6HSd4e+Jb0UqKvL8BcGtVPgow5TUYYAG7s
 ovYY/zFAAEep6izmoIuo6ZewOsBfDCtzvyb0vWAOeY9JN7opVtSAMqVtEnY8/wZJx8
 rn8rS87apAP7Z2+T9b1yBND8XTVOjfsyOZ1Ydn4rZ933liVG24jAqTHKXTILwRRxU2
 bO/o5tRjkx/clLj/r/r+6lfxQkM8U/swdoHCZpmDqjjZpDZBbGjBiYG2aE3K0TsCZG
 SJaU09VE1cGFfPy6dcEP9rhPbHhrYq3AHHIAxWL5Ir7jRFSDhM+lJvHpphliZldueT
 RAgPl2mnc92GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: display-connector: fix i2c adapter leak on
 probe failure
To: "Johan Hovold" <johan@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717085716.1619275-1-johan@kernel.org>
References: <20260717085716.1619275-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:10:13 +0000
Message-Id: <20260717091013.8BBDE1F000E9@smtp.kernel.org>
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
- [High] Missing cancellation of scheduled work (`conn->hpd_work`) in the d=
river's remove path.
--

--- Patch [1]: [PATCH] drm/bridge: display-connector: fix i2c adapter leak =
on probe failure ---
commit 4febab97b0e18e24c294244f2f96e39bc66cf4b3
Author: Johan Hovold <johan@kernel.org>

drm/bridge: display-connector: fix i2c adapter leak on probe failure

This commit ensures the i2c adapter device and module references are dropped
on failed regulator and enable gpio lookup during probe by adding a devres
action.

> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm=
/bridge/display-connector.c
> index d1e74dd2e0518..8415992fcb106 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
[ ... ]
> @@ -439,9 +452,6 @@ static void display_connector_remove(struct platform_=
device *pdev)
>  		regulator_disable(conn->supply);
> =20
>  	drm_bridge_remove(&conn->bridge);

[Severity: High]
This isn't a bug introduced by this patch, but does display_connector_remov=
e()
need to cancel conn->hpd_work before returning?

If the display-connector module is unbound concurrently with the DRM master
calling display_connector_hpd_enable(), the hpd_work work item is scheduled.
Without an explicit cancel_work_sync(&conn->hpd_work) here in the remove
path, could the work item execute after the devres subsystem has freed the
conn structure? This would result in a use-after-free when the work item
accesses the freed memory and calls drm_bridge_hpd_notify() on a removed
bridge.

> -
> -	if (!IS_ERR(conn->bridge.ddc))
> -		i2c_put_adapter(conn->bridge.ddc);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717085716.1619=
275-1-johan@kernel.org?part=3D1
