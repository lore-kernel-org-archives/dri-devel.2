Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B36CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647D710E08D;
	Thu,  8 Oct 2026 13:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iF1NsI1q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140D310E08D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:28:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C971643979;
 Thu,  8 Oct 2026 13:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830A31F000FF;
 Thu,  8 Oct 2026 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791466079;
 bh=AnVM2AeDceOLST6xP9oEAM7ItRj+UsiT0lr4QlIrPHU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iF1NsI1qNbHu/8NEyd/iaGmVPx+P6/hdY7JcSmOEf0fmzWw5+bXY3A4vWaVBTGsfQ
 vgv+rrPX1SNZtqfpHQCQKSK3IzgMOOhEqSbOuCI+Ydh7XUY4yBAgGZgWHhznrH50o0
 2vF89+2HJfDNEwEig+I14aRUzSHeloe66F1IlLM7aMjOaR8o3NarSCwqs1X0ECvikY
 RTgLm0TEPl7OxSf3TyWcbzKZZdURTv941jAk4kDUmCojC+ZE18Hf5yiIV5fCRd+rp8
 rQo/+kAhzhrBZzkqWDTh6X3KIDx+WZdLyNyXwyLS2ZL6pUFD+HM2Zc3JPbJ2Kt8r6s
 p0NoxPSVWIw9A==
Message-ID: <sashiko-outbox-164210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 7/9] drm/panel: add atomic variants of the enable
 and disable callbacks
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-panel-atomic-state-v1-7-b157fddb8de1@oss.qualcomm.com>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
 <20261008-panel-atomic-state-v1-7-b157fddb8de1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 13:27:59 +0000
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
- [High] drm: backlight_disable error prevents panel->enabled =3D false upd=
ate
--

commit 00631cfc33b867ee09e15a877b7d601e80307028
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
drm/panel: add atomic variants of the enable and disable callbacks

This commit introduces atomic variants of panel prepare, enable, disable, a=
nd
unprepare callbacks. These new callbacks receive the atomic commit state,
allowing panels tracking configuration via atomic state to program themselv=
es
appropriately.

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index ed0d16e04eaec..a2cd043fe1467 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c

[ ... ]

> +static void drm_panel_atomic_disable(struct drm_panel *panel,
> +				     struct drm_atomic_commit *commit)
> +{
> +	const struct drm_panel_funcs *funcs =3D panel->funcs;
> +	int ret =3D 0;
> +
> +	if (!panel->enabled) {
> +		dev_warn(panel->dev, "Skipping disable of already disabled panel\n");
> +		return;
> +	}
> +
> +	guard(mutex)(&panel->follower_lock);
> +
> +	drm_panel_followers_disabling(panel);
> +
> +	ret =3D backlight_disable(panel->backlight);
> +	if (ret < 0)
> +		DRM_DEV_INFO(panel->dev, "failed to disable backlight: %d\n",
> +			     ret);
> +
> +	if (funcs->atomic_disable)
> +		ret =3D funcs->atomic_disable(panel, commit);
> +	else if (funcs->disable)
> +		ret =3D funcs->disable(panel);
> +	if (ret < 0)
> +		return;

[Severity: High]
Does an error in backlight_disable() prevent the panel from being marked as
disabled when the disable callbacks are missing?

Since both funcs->atomic_disable and funcs->disable are optional callbacks,
many drivers omit them. In that case, the if/else if block is skipped, and
ret retains the negative value returned by backlight_disable().=20

The subsequent if (ret < 0) condition then evaluates to true, triggering an
early return that skips setting panel->enabled =3D false.

Because the state remains panel->enabled =3D true, future calls to
drm_panel_atomic_enable() will immediately return without turning the screen
back on, leaving the display permanently off.

> +	panel->enabled =3D false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-panel-atom=
ic-state-v1-0-b157fddb8de1@oss.qualcomm.com?part=3D7
