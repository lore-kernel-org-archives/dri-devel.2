Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D6606BF74
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhFRDHVh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D04E10F7DA;
	Tue, 17 Nov 2026 14:34:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A143810E62C;
 Tue, 17 Nov 2026 14:34:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A937E62A00;
 Tue, 17 Nov 2026 14:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365F31F000CA;
 Tue, 17 Nov 2026 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794926078;
 bh=er0YCvXQ91uh1O3yTCJrufvEHTRwo16d82rE/dQ7Qv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UhFRDHVhDT/1q7qY0Fx3pwXUAn55/vDZ/pZbLutfpIg3qDWKkg3VvqBYQkMCqJzAC
 r0azBF4xqstOPKBg294G0npBuDz6yM225G6CYy0NXXK3TLwKmdlfI0Ozm+VCEj1Ajz
 6PwrLSDS/w7KSGP53gqXEOnh+cU1ACbPiCZH9bf4L8NodfQibMXal/5+3MAxTLQtqJ
 45vkDGm73lRjjdPBw5v3gr5C/9P8PB3jr5pug7xFDSZ+svH2JTdrAm4I8G1x7cO5Y5
 gYnXTB9WUSROSMcs5YV0mEdXrJpXdf4wZNsTDVX62iI3AYQl2V+VfFifDhIt0CYLGs
 BwDh988oSQhvA==
Message-ID: <sashiko-outbox-218968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm: Remove drm_crtc_init()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117140750.541769-3-tzimmermann@suse.de>
References: <20261117140750.541769-1-tzimmermann@suse.de>
 <20261117140750.541769-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:34:37 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm: build failure in amdgpu DCE files after removing
  drm_crtc_init()
--

commit 6d664862f4e8731c606db322340f68e1b8885e4d
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm: Remove drm_crtc_init()

This commit removes the legacy drm_crtc_init() helper and its associated
default primary plane structures.

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

[Severity: High]
As reported by kernel test robot on v2 [1], does removing drm_crtc_init()
break the build when CONFIG_DRM_AMDGPU is enabled?

Three legacy DCE display files in drivers/gpu/drm/amd/amdgpu/ still call
drm_crtc_init() in dce_v10_0_crtc_init(), dce_v8_0_crtc_init(), and
dce_v6_0_crtc_init():

drivers/gpu/drm/amd/amdgpu/dce_v10_0.c:dce_v10_0_crtc_init() {
    ...
	drm_crtc_init(adev_to_drm(adev), &amdgpu_crtc->base, &dce_v10_0_crtc_funcs=
);
    ...
}

[1] https://lore.kernel.org/r/202611130312.g6BELEWG-lkp@intel.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117140750.5417=
69-1-tzimmermann@suse.de?part=3D2
