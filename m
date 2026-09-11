Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE109C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EA110F6A7;
	Fri, 11 Sep 2026 18:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hhm6+Nn3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E31910F6A7
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:05:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B63BB60008;
 Fri, 11 Sep 2026 18:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FDC1F000FF;
 Fri, 11 Sep 2026 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789149940;
 bh=zjNaoSPib6i62jt/HKdCdFuhsr0N1fjthkWPVjtyHQQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hhm6+Nn36hRsX2+NAuplozSj+SB4BSXAy21thYwwYjdeFbwXc12V0GNmDCfET/8j/
 t1Ky0DsTRj4WAOshMgILAnKewhqAy3Ql3faO2/M9hIdGuwfhkpbNSLeCPcJJ5b5fkK
 3dttjDU/07MlNjRFxm23RqV0NVcW5XIKafwl1ZnLxmqpLLcGWXYoEAeXjFBQqyd4Wd
 9LBfzb6mFFag0KhC2lw26LOgtmEhwf6x9U207YHBWoHGx9aScYL0erWFH7UWySVIZ7
 X2crqzGvZAR+RK99rORJK2FD+LZa9Pg/CPFP5Hii15mtHl8SodayU2/g+i0HnvcQwR
 moJd9M+6UqlYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Add blend mode property
To: "Ian Forbes" <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911175607.1127474-1-ian.forbes@broadcom.com>
References: <20260911175607.1127474-1-ian.forbes@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 18:05:39 +0000
Message-Id: <20260911180540.40FDC1F000FF@smtp.kernel.org>
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
- [High] Missing drm_plane_cleanup() on error paths in display unit initial=
ization functions leads to list corruption and use-after-free.
--

commit dea10d2954fcbf7f9f6713f8f44088d76a62295e
Author: Ian Forbes <ian.forbes@broadcom.com>

drm/vmwgfx: Add blend mode property

This commit adds blend mode properties to the primary and cursor planes to=
=20
stop log spamming. It initializes the properties in vmw_du_init() for both
planes if they are present.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
[ ... ]
>  void vmw_du_init(struct vmw_display_unit *du)
>  {
>  	vmw_vkms_crtc_init(&du->crtc);
> +	drm_plane_create_blend_mode_property(&du->primary,
> +					     BIT(DRM_MODE_BLEND_PIXEL_NONE));
> +	// Check that the cursor plane was actually initialized
> +	if (du->crtc.cursor =3D=3D &du->cursor.base)
> +		drm_plane_create_blend_mode_property(&du->cursor.base,
> +						     BIT(DRM_MODE_BLEND_PREMULTI));
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing
issue regarding the cleanup of these planes on error paths during display u=
nit
initialization.

In functions like vmw_ldu_init(), vmw_sou_init(), and vmw_stdu_init(), the
primary and cursor planes are initialized, which links them into the DRM
core plane list. If a subsequent step like drm_connector_init() fails, the
code jumps to an error label and frees the display unit structure without
cleaning up the planes:

drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c:vmw_ldu_init() {
...
	ret =3D drm_connector_init(dev, connector, &vmw_legacy_connector_funcs,
				 DRM_MODE_CONNECTOR_VIRTUAL);
	if (ret) {
		DRM_ERROR("Failed to initialize connector\n");
		goto err_free;
	}
...
err_free:
	kfree(ldu);
	return ret;
}

Similar error paths exist in vmw_sou_init() for the sou structure, and
vmw_stdu_init() for the stdu structure.

Since the display unit structure containing the planes is freed with kfree()
but drm_plane_cleanup() hasn't been called, could this leave dangling
pointers in the DRM core plane list? If the list is later traversed during
driver teardown in drm_mode_config_cleanup(), wouldn't this result in a
use-after-free?=20

Should these error paths be updated to call drm_plane_cleanup() or a similar
teardown helper before freeing the memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911175607.1127=
474-1-ian.forbes@broadcom.com?part=3D1
