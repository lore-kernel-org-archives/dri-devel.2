Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2673C44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C735510E4FC;
	Thu, 23 Jul 2026 01:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hf+zBgzU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1911C10E4FC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:48:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C91E600AD;
 Thu, 23 Jul 2026 01:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC961F00A3A;
 Thu, 23 Jul 2026 01:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771280;
 bh=hI0i7efmL2lkyS6wC7kGyPgxPrJS9rT7B578hvJBxTk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hf+zBgzUqkmrusuJiUA2U3YzJyTK3Go4MylS6X1L1TxkO4BV6FByT7x0EtkntOQct
 KAmSGu1VQh32G4qAZBFK6iZ0ulwS0O5hYozET3ucWm4uiOl9w6RamzMYpTDII+ehO5
 285RU7gMe276iQBXSncyvLuIovFt4rFRpKUTTuvoC6sWUjkGnPMa8OZxrMIMmGlxuS
 qr2KG8eIdE+QH4VQkF0AnTLpHxwmUCYOjkdk8ZyBFNdunCUfuzynFVnGHTeoUutUYx
 ZgGZDDYHv0RC26loWZtU7TglLTY2Uas8uwHrTbk9FhRaGnthCygETz5MiQHkDo3NWq
 7AaoPO+mn2KRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/61] drm/bridge: Remove redundant error check in
 drm_bridge_helper_reset_crtc()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-10-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-10-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:47:59 +0000
Message-Id: <20260723014800.0FC961F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional unlocking of a context-managed lock causes lock stri=
pping and double unlocks.
- [High] drm_atomic_get_connector_for_encoder() returns a connector without=
 holding a reference, leading to a Use-After-Free.
--

--- Patch [10]: [PATCH v9 10/61] drm/bridge: Remove redundant error check i=
n drm_bridge_helper_reset_crtc() ---
commit 9b5cf69b4268daeb09910d2aa6efb179fd6ada06
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: Remove redundant error check in drm_bridge_helper_reset_crtc()

This commit removes the no-op error check after
drm_atomic_helper_reset_crtc() since the goto target is the immediately
following label. The return value is already propagated correctly
without it.

> diff --git a/drivers/gpu/drm/drm_bridge_helper.c b/drivers/gpu/drm/drm_br=
idge_helper.c
> index 420f29cf3e543..0a3c8fee66b32 100644
> --- a/drivers/gpu/drm/drm_bridge_helper.c
> +++ b/drivers/gpu/drm/drm_bridge_helper.c
> @@ -50,8 +50,6 @@ int drm_bridge_helper_reset_crtc(struct drm_bridge *bri=
dge,
> =20
>  	crtc =3D connector->state->crtc;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but can this dereference cause a Use-After-Fr=
ee?

Looking at drm_atomic_get_connector_for_encoder() called earlier in this
function, it finds a matching connector and breaks out of the
drm_for_each_connector_iter() loop. It then calls
drm_connector_list_iter_end(), which drops the reference on the found
connector.

The function then returns this connector without acquiring a new reference
via drm_connector_get().

If a concurrent hotplug event (like an MST display unplug) unregisters and
frees the connector before we dereference connector->state here, would it
result in a Use-After-Free?

>  	ret =3D drm_atomic_helper_reset_crtc(crtc, ctx);
> -	if (ret)
> -		goto out;
> =20
>  out:
>  	drm_modeset_unlock(&dev->mode_config.connection_mutex);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but can this unconditional unlock
lead to a double-unlock?

Earlier in this function, drm_atomic_get_connector_for_encoder() is called
and passed the acquire context ctx. Since connection_mutex was already lock=
ed
in ctx, the inner function's lock attempt returns -EALREADY (which is
treated as success).

However, at the end of drm_atomic_get_connector_for_encoder(), it
unconditionally calls drm_modeset_unlock(). This unlinks the lock from the
context and fully unlocks the WW mutex, stripping the lock from
drm_bridge_helper_reset_crtc().

When we reach this out label, does calling drm_modeset_unlock() again on the
already unlocked mutex trigger a double-unlock warning or crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D10
