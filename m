Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A30606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJf0DZWe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6365410E612;
	Thu, 12 Nov 2026 13:02:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC3810E605;
 Thu, 12 Nov 2026 13:01:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59E4E61188;
 Thu, 12 Nov 2026 13:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56241F00A05;
 Thu, 12 Nov 2026 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794488518;
 bh=Up911n4u0nDULtE6sczBmbZ/VtKQy1efEHyqBtqM6hw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VJf0DZWeVMeBG6RTEop/v2W0yBTK/onkK+/ph9w0pkD5ZOVmGAY6aKBeh6kRqiglg
 pc28LO9MB60PRfgDJQsgET79w6qbk7wCNnauuydncN6u17K6VcAK8KebxKHLJ1KKBP
 V7p9FSIHzLimh8qp3Xo2aSmuTvDxrzgaD6vhyPiwnNFVa/xYi2G1ftcVD1dp+Arp9V
 QSw57G9NLX42PNNCch42pIvp4xIWTFd+BNGmdk3Cc05eiw6TXR1mO0pv4KIslT9ky1
 Oj/l3IgaiDHpaRwszfQ0l0iCTR9EGCrK80QKQW2ZTEvlpRbnCOvZZ7+N3L48TEuGRr
 s3VICFt2LSY3g==
Message-ID: <sashiko-outbox-211131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm: Remove drm_crtc_init()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112125039.66082-3-tzimmermann@suse.de>
References: <20261112125039.66082-1-tzimmermann@suse.de>
 <20261112125039.66082-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:01:57 +0000
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
- [High] drm: build failure in amdgpu DCE files after removing
  drm_crtc_init()
--

commit aafe7374dc79cd31dda721134581ac1246ab8089
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm: Remove drm_crtc_init()

This commit removes the legacy drm_crtc_init() helper, its default primary
plane structures, and the format_default flag from struct drm_plane.

> diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_h=
elper.h
> index 7e3d4c5a7f66d..6b9421aee5360 100644
> --- a/include/drm/drm_modeset_helper.h
> +++ b/include/drm/drm_modeset_helper.h
> @@ -37,9 +37,6 @@ void drm_helper_mode_fill_fb_struct(struct drm_device *=
dev,
>  				    const struct drm_format_info *info,
>  				    const struct drm_mode_fb_cmd2 *mode_cmd);
> =20
> -int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> -		  const struct drm_crtc_funcs *funcs);
> -
>  int drm_mode_config_helper_suspend(struct drm_device *dev);
>  int drm_mode_config_helper_resume(struct drm_device *dev);
> =20

[Severity: High]
Does removing drm_crtc_init() break the build when CONFIG_DRM_AMDGPU is
enabled?

dce_v10_0_crtc_init() in drivers/gpu/drm/amd/amdgpu/dce_v10_0.c (as well
as dce_v8_0_crtc_init() and dce_v6_0_crtc_init()) still calls
drm_crtc_init():

drivers/gpu/drm/amd/amdgpu/dce_v10_0.c:dce_v10_0_crtc_init() {
	...
	drm_crtc_init(adev_to_drm(adev), &amdgpu_crtc->base, &dce_v10_0_crtc_funcs=
);
	drm_mode_crtc_set_gamma_size(&amdgpu_crtc->base, 256);
	...
}

Building amdgpu therefore fails with an implicit declaration of
drm_crtc_init().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112125039.6608=
2-1-tzimmermann@suse.de?part=3D2
