Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6155C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D54410E030;
	Fri, 31 Jul 2026 18:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UKJ/sCev";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD29610E030
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 18:01:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 719FF42B80;
 Fri, 31 Jul 2026 18:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDF61F00AC4;
 Fri, 31 Jul 2026 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785520877;
 bh=KAqD0yPsTaRgj4uV/hiNxUzYDnryZJwq4NKvceFi1WE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UKJ/sCevOijtduInBdSUaxJj31lCYWEraY8MsRw+0fJG+cGDEZki4m9MjQ+NO2NUA
 YLzJkS1WYR8sbBlW8tUuxtcgpAfWVrg3fNlknEcXn15H3eePJGf+a1uCgoeR51ZYfI
 AthYgUIg65vnNrjqEOT26YTXhg+uZO7EQ9aQAVpo3cyINJEsuFg3ZLlfZfj1tCRrGV
 QGgL4mYGJ++qozwMRMe1qdJmxSdue5RbjOClCJR3eNemafDHgw0ZsXaIkqUELJ9Pwc
 MORVChm+DTfuQG2xbfWyLC/gTa/A4BwOLJhVW6jLV3O02GfToMmfK2NWTAHER4TEjs
 LgHsGz+cHHbDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/69] drm/bridge: Remove redundant error check in
 drm_bridge_helper_reset_crtc()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-14-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-14-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:01:16 +0000
Message-Id: <20260731180117.1FDF61F00AC4@smtp.kernel.org>
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
- [High] Double unlock of connection_mutex and unprotected state access due=
 to nested lock handling flaw in drm_atomic_get_connector_for_encoder.
--

--- Patch [14]: [PATCH v10 14/69] drm/bridge: Remove redundant error check =
in drm_bridge_helper_reset_crtc() ---
commit 3469d1c48eb06940af7b278f9266400f3b5ea3dc
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: Remove redundant error check in drm_bridge_helper_reset_crtc()

This commit removes a no-op error check after drm_atomic_helper_reset_crtc(=
),
as the return value is already propagated correctly by the fall-through to
the out label.

> diff --git a/drivers/gpu/drm/drm_bridge_helper.c b/drivers/gpu/drm/drm_br=
idge_helper.c
> index 420f29cf3e543..0a3c8fee66b32 100644
> --- a/drivers/gpu/drm/drm_bridge_helper.c
> +++ b/drivers/gpu/drm/drm_bridge_helper.c
> @@ -50,8 +50,6 @@ int drm_bridge_helper_reset_crtc(struct drm_bridge *bri=
dge,
> =20
>  	crtc =3D connector->state->crtc;
>  	ret =3D drm_atomic_helper_reset_crtc(crtc, ctx);
> -	if (ret)
> -		goto out;
> =20
>  out:
>  	drm_modeset_unlock(&dev->mode_config.connection_mutex);

[Severity: High]
This is a pre-existing issue, but does this result in a double-unlock of
connection_mutex?

Earlier in this function, the lock is acquired before calling
drm_atomic_get_connector_for_encoder():

drm_bridge_helper_reset_crtc() {
    ...
    ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
    if (ret)
        return ret;

    connector =3D drm_atomic_get_connector_for_encoder(encoder, ctx);
    ...
}

However, drm_atomic_get_connector_for_encoder() unconditionally unlocks
the mutex on exit. Because drm_modeset_unlock() lacks a nesting counter, it
fully drops the ww_mutex.

Consequently, connector->state is accessed locklessly, and reaching this out
label calls drm_modeset_unlock() a second time, which could corrupt the
kernel lock state.

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D14
