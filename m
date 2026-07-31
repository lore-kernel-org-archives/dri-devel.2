Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D15C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1767910F35D;
	Fri, 31 Jul 2026 17:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F1xF+GeK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317FB10F35D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:06:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78B12600BB;
 Fri, 31 Jul 2026 17:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E511F00ADF;
 Fri, 31 Jul 2026 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785517598;
 bh=J7Y/3xcmT2pyRuvQ5CjvYHc9JmZ+GoAN9v9ysZxVW3o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F1xF+GeK+APD6CKi+JTixRwPPHl7BuKrfCm6W/efQdBlbDp0UO30SQqGcYecaaadx
 3BXJ+9JuQXUV66RubywZWHjtKqCxugA8iF6+A5baU9LVior8+Qb5cwVPoPhnx3JaGn
 4VNbRb06g0ANrMh8KDS7NWYO2iS6wjb1jBkHsZMRulUG0snKr3l+UuSrZ+MRoc6obO
 LYzkRBI8nhObCquPHpHi7yRYocsZqluQgjOBy2y/X1YZYmQrCGXJPEwItC+wjrEm31
 bAaAxvsrfFn7ZChfk+Zmb8H14Wa5JbyroaCkkva+Y0nStTT1WObA7zpROvSONx6S+p
 L5O5pstaFwwpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/69] drm/probe-helper: Introduce .force_ctx()
 connector callback
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-6-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-6-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:06:37 +0000
Message-Id: <20260731170638.14E511F00ADF@smtp.kernel.org>
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
- [Medium] Modifying `connector->status` before `force_ctx()` can return `-=
EDEADLK` causes subsequent retries to incorrectly evaluate `old_status =3D=
=3D connector->status`, silently skipping the hotplug event.
--

--- Patch [6]: [PATCH v10 06/69] drm/probe-helper: Introduce .force_ctx() c=
onnector callback ---
commit b08054d3073ea6707b0fe9e517dde416f7e5c8b6
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/probe-helper: Introduce .force_ctx() connector callback

This commit introduces a force_ctx() variant to the connector helper
functions, taking a modeset acquire context and returning an error code
so that -EDEADLK can propagate. It takes precedence over the existing
force() callback when both are implemented.

> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_pro=
be_helper.c
> index e26ead5b5e589..918255bcfa096 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c

[ ... ]

> @@ -592,8 +593,19 @@ int drm_helper_probe_single_connector_modes(struct d=
rm_connector *connector,
>  			connector->status =3D connector_status_connected;
>  		else
>  			connector->status =3D connector_status_disconnected;
> -		if (connector->funcs->force)
> +
> +		if (funcs && funcs->force_ctx) {
> +			ret =3D funcs->force_ctx(connector, &ctx);
> +			if (ret =3D=3D -EDEADLK) {
> +				drm_modeset_backoff(&ctx);
> +				goto retry;

[Severity: Medium]
Does modifying connector->status before force_ctx() cause hotplug events
to be dropped on lock contention?

If funcs->force_ctx() returns -EDEADLK, the code branches to the retry
label. During the retry loop, old_status is assigned the current
connector->status:

drm_helper_probe_single_connector_modes() {
retry:
        ...
        old_status =3D connector->status;

Since connector->status was already updated prior to the failed attempt,
old_status will equal the new status. When the lock is finally acquired
after the retry, the old_status !=3D connector->status check later in the
function evaluates to false, causing the hotplug event detection logic
to be silently skipped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D6
