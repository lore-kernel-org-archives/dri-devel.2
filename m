Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7B606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEqg9Fu0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8480C10E719;
	Mon, 16 Nov 2026 01:55:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C475310E008;
 Mon, 16 Nov 2026 01:54:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 635E441176;
 Mon, 16 Nov 2026 01:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0837A1F000C4;
 Mon, 16 Nov 2026 01:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794794099;
 bh=Gs6WglrfEUV40ZWLl9zGfZQD6GQHzIVaT0gH1XLg80A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FEqg9Fu0tr9UStzN62P41d99FSD4vQzHghztttYt/4xp5gH2zOh9k6fhKdM2oPZ3i
 Fe8fmXM155bRLBtAvvqRq44UeogoSZ1LhduXr/qtGNTnfiUcpBPtj2cUNcsMGM9KeL
 mQB1vrWUxAZ/TSrGZ8zh+abThK3CL6WUVzBV3zWEG3oKWkssstFK+iC/KAPAETVtKV
 vUF4W3DgOvwvY6e85c4TgGSO/6c2fhSuZnU5nvflHHczB41r0l7mwCoPQXMTdXuXTM
 zuYMk8sDpB/JlpLaAWpX5J63uLh1KtqsZbPxkrD+6WgBzdaVKBy+696KqGQIaUKz17
 FtBZX/aLSBd2w==
Message-ID: <sashiko-outbox-216019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/xe/display: Free the KMS objects on DRM device
 release
To: "Baoli Zhang" <baoli.zhang@linux.intel.com>, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116011504.3910139-4-baoli.zhang@linux.intel.com>
References: <20261116011504.3910139-1-baoli.zhang@linux.intel.com>
 <20261116011504.3910139-4-baoli.zhang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:54:58 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/xe/display: double encoder->remove() on
  xe_display_init_early() error
--

commit b715fa7a2b526531416f015bc7f326dd1dd557ca
Author: Baoli Zhang <baoli.zhang@linux.intel.com>

drm/xe/display: Free the KMS objects on DRM device release

This commit removes the calls to intel_display_driver_mode_config_cleanup()
from xe_display_fini_early() and the xe_display_init_early() error path so
that KMS objects are freed by drmm on DRM device release.

> diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe=
/display/xe_display.c
> index 8f02317a62120..639c2f5aeb66f 100644
> --- a/drivers/gpu/drm/xe/display/xe_display.c
> +++ b/drivers/gpu/drm/xe/display/xe_display.c

[ ... ]

> @@ -111,7 +114,6 @@ int xe_display_init_early(struct xe_device *xe)
>  	return devm_add_action_or_reset(xe->drm.dev, xe_display_fini_early, xe);
>  err_noirq:
>  	intel_display_driver_remove_noirq(display);
> -	intel_display_driver_mode_config_cleanup(display);
>  	intel_display_power_cleanup(display);
> =20
>  	return err;

[Severity: Medium]
Can the err_noirq path in xe_display_init_early() invoke encoder->remove()
twice on each encoder when intel_display_driver_probe_nogem() fails?

In intel_display_driver_probe_nogem(), if intel_dp_tunnel_mgr_init() fails
after intel_setup_outputs(), the err_mode_config path calls
intel_mode_config_cleanup() -> intel_encoder_remove_all(). Because
drm_mode_config_cleanup() is now deferred to drmm, the encoders remain
linked on display->drm->mode_config.encoder_list when
intel_display_driver_probe_nogem() returns an error.

The err_noirq path here then calls intel_display_driver_remove_noirq() ->
intel_mode_config_cleanup() -> intel_encoder_remove_all() a second time on
the still-populated encoder_list. On the first pass,
intel_ddi_encoder_remove() frees dig_port->tc and sets it to NULL in
intel_tc_port_cleanup() and frees intel_dp->aux.name in
intel_dp_aux_fini(), so the second pass causes a NULL pointer dereference
in intel_tc_port_suspend() and a double free of intel_dp->aux.name.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116011504.3910=
139-1-baoli.zhang@linux.intel.com?part=3D3
