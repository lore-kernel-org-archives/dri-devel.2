Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C95C44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722E010E24D;
	Tue,  7 Jul 2026 16:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dFc1G9zw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7CC10EE60
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:11:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A6BE600BB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C651F00A3A;
 Tue,  7 Jul 2026 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440660;
 bh=0WCDPy3PFTQ7HMWRX2Mnlad6lL8GxOaeNGTbYQRcR6A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dFc1G9zwi8N2IpXhLHT7t+0yaVMAyneexl5KlgZwBM/Ztpq5cuDHkwlES5ygpTNz0
 pOOjr/CvahbHAieZco+gFzSynUMlpNjo2XzONc3SYaCkV5JLca1nm7BptmaIifhdsi
 FnSKYtzVa9PMO6UdxnBUtJfdEmONyNDkAUpGQMi8XVgTW/6758hZwI7jDMzcTF0nM2
 cYgzPKNVOkqFGydyG9aUCIjFRaBfD5FTynHMm6e90SUzAvocFDCetmWD5Yr74V0m5c
 qg+QqT9ekfiRncoOJfYGMoH2bHjvkGZ5lD7ZkPK9xqahyy4XxCuAPfM1zzhZ2nXhWS
 FIzXVZ9mzHinA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 36/37] drm/sti: hdmi: Switch to atomic bridge callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-36-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-36-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:11:00 +0000
Message-Id: <20260707161100.C6C651F00A3A@smtp.kernel.org>
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
- [High] Memory leak and global list corruption (dangling pointer) if compo=
nent_add() fails in sti_hdmi_probe().
- [High] Resource leak of the audio platform device and potential NULL poin=
ter dereference if sti_hdmi_bind() fails.
--

--- Patch [36]: [PATCH v2 36/37] drm/sti: hdmi: Switch to atomic bridge cal=
lbacks ---
commit fe4cd2364e238c4d447b17cda3c258ebb7c65628
Author: Maxime Ripard <mripard@kernel.org>

drm/sti: hdmi: Switch to atomic bridge callbacks

The hdmi bridge uses the legacy non-atomic pre_enable, enable, disable
and post_disable bridge callbacks.

In order to remove the legacy bridge callback support from the DRM
bridge core, switch to their atomic counterparts and add the bridge
atomic state handlers.

> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdm=
i.c
> index f8222e60b1e01..7ba9e0b7ba6c0 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c

[ ... ]

> @@ -964,16 +966,20 @@ static void sti_hdmi_set_mode(struct drm_bridge *br=
idge,
>  	}
>  }
> =20
> -static void sti_hdmi_bridge_nope(struct drm_bridge *bridge)
> +static void sti_hdmi_bridge_nope(struct drm_bridge *bridge,
> +				 struct drm_atomic_commit *commit)
>  {
>  	/* do nothing */
>  }
> =20
>  static const struct drm_bridge_funcs sti_hdmi_bridge_funcs =3D {
> -	.pre_enable =3D sti_hdmi_pre_enable,
> -	.enable =3D sti_hdmi_bridge_nope,
> -	.disable =3D sti_hdmi_disable,
> -	.post_disable =3D sti_hdmi_bridge_nope,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_pre_enable =3D sti_hdmi_pre_enable,
> +	.atomic_enable =3D sti_hdmi_bridge_nope,
> +	.atomic_disable =3D sti_hdmi_disable,
> +	.atomic_post_disable =3D sti_hdmi_bridge_nope,
>  	.mode_set =3D sti_hdmi_set_mode,
>  };

[Severity: High]
This is a pre-existing issue, but does sti_hdmi_probe() leak memory and
leave a dangling pointer if component_add() fails?

drivers/gpu/drm/sti/sti_hdmi.c:sti_hdmi_probe() {
	...
	drm_bridge_add(&hdmi->bridge);
	return component_add(&pdev->dev, &sti_hdmi_ops);
}

If component_add() fails, the function returns an error without calling
drm_bridge_remove().

Because the bridge is never removed, the reference count does not drop to
zero during devres cleanup. Could another driver try to access the corrupted
bridge in the global bridge_list, leading to a use-after-free panic when it
accesses the freed devres-managed resources?

[Severity: High]
This isn't a bug introduced by this patch, but does the error handling in
sti_hdmi_bind() leave the audio platform device registered while setting the
connector to NULL?

drivers/gpu/drm/sti/sti_hdmi.c:sti_hdmi_bind() {
	...
err_sysfs:
	hdmi->drm_connector =3D NULL;
	return -EINVAL;
}

If sti_hdmi_register_audio_driver() succeeds but a subsequent initialization
step fails, we jump to the err_sysfs label, which clears hdmi->drm_connector
without unregistering the active audio device.

Since the ALSA framework may still invoke operations on the registered code=
c,
can this trigger a NULL pointer dereference when hdmi_audio_get_eld() is
called?

drivers/gpu/drm/sti/sti_hdmi.c:hdmi_audio_get_eld() {
	...
	struct drm_connector *connector =3D hdmi->drm_connector;

	DRM_DEBUG_DRIVER("\n");
	mutex_lock(&connector->eld_mutex);
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D36
