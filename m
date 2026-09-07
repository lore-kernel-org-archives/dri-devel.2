Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B31C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B3210E833;
	Mon,  7 Sep 2026 13:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cdvob+iq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26C110E833
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:50:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 851AC415B7;
 Mon,  7 Sep 2026 13:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515A01F00A3A;
 Mon,  7 Sep 2026 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788789003;
 bh=Aj0BJYTM3mrIFFI49F36duspoV+KXQoS8z3Mx+R+nkw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cdvob+iqgZBI0kcYpdZfXOp7Y7tMhr8P+Yhyyl8za0XD7FWoo45FGHx1v5H0KYgc1
 E/xBM0uaPOM3JhYqa49d7Nvr3GZo5Ro+QTtTlJHp5wOI87lCw6ig1BMcZYTCOCeCyl
 vx51Uw5Bh65xAVqmgRhREbytRpdVN5GEtFd1HBD9qf6NeUKZCkBnY11Bb2tmSpvSwl
 JSDEST23qNh3QR8ssNt+MfiCEKy5jcgWoTgtymepeUw8RMp0HicJE8OPnH8brpmAh/
 ehwh5YZRTsECeLS/zGgvcxkex+U/XX4wdEhliiScTjLMTGOuIiPQWZLwOib7raCBmo
 AZ8PEWOKR0nOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/amd/display: replace STATIC_IFN_KUNIT with
 VISIBLE_IF_KUNIT
To: "Albert Esteve" <aesteve@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-visibility-unification-v1-1-6a962e5b3351@redhat.com>
References: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
 <20260907-visibility-unification-v1-1-6a962e5b3351@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 13:50:02 +0000
Message-Id: <20260907135003.515A01F00A3A@smtp.kernel.org>
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
- [Low] Missing prototypes and global namespace pollution for generic funct=
ion names when CONFIG_KUNIT is enabled but CONFIG_DRM_AMD_DC_KUNIT_TEST is =
disabled.
--

commit 559b79e4c5aa67bc448a3cebcac53b59d32d0f66
Author: Albert Esteve <aesteve@redhat.com>

drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
   =20
This commit switches amdgpu_dm test helpers from the local STATIC_IFN_KUNIT
macro to the generic VISIBLE_IF_KUNIT macro. The helpers become non-static
whenever KUnit is enabled, not just when AMD DC tests are built.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ec483276d7538..5b3bebde0b083 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -167,7 +168,7 @@ static inline void amdgpu_dm_exit_ips_for_hw_access(s=
truct dc *dc)
>   * @return
>   * Counter for vertical blanks
>   */
> -STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, i=
nt crtc)
> +VISIBLE_IF_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, i=
nt crtc)

[Severity: Low]
If CONFIG_KUNIT is enabled but CONFIG_DRM_AMD_DC_KUNIT_TEST is disabled,=20
VISIBLE_IF_KUNIT will make this function globally visible. However, if its=
=20
prototype in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h is still=20
guarded by #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST), won't this cause a=
=20
-Wmissing-prototypes build warning?

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index c8a1ab8c3b169..fe310b6d9f603 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -724,7 +724,7 @@ amdgpu_dm_convert_color_depth_from_display_info(const=
 struct drm_connector *conn
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_convert_color_depth_from_display_info);
> =20
> -STATIC_IFN_KUNIT enum dc_aspect_ratio
> +VISIBLE_IF_KUNIT enum dc_aspect_ratio
>  get_aspect_ratio(const struct drm_display_mode *mode_in)

[Severity: Low]
Since VISIBLE_IF_KUNIT makes this function globally visible when CONFIG_KUN=
IT=20
is enabled, does the generic name get_aspect_ratio risk namespace collision=
s=20
with other display or media drivers?

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 47cbc826ed451..20c1ce8cda446 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -187,7 +190,7 @@ int psp_set_srm(struct psp_context *psp,
>  }
>  EXPORT_IF_KUNIT(psp_set_srm);
> =20
> -STATIC_IFN_KUNIT
> +VISIBLE_IF_KUNIT
>  void process_output(struct hdcp_workqueue *hdcp_work)

[Severity: Low]
With VISIBLE_IF_KUNIT, this generic name process_output becomes a global=20
symbol in vmlinux. Is there a risk of link-time collisions with other=20
drivers?

Also, similar to the missing prototype issue mentioned earlier, could this=
=20
lead to a build warning if the prototype in amdgpu_dm_hdcp.h is still=20
guarded by CONFIG_DRM_AMD_DC_KUNIT_TEST?

[ ... ]

> @@ -386,7 +389,7 @@ void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_wo=
rk, unsigned int link_index
>  }
>  EXPORT_IF_KUNIT(hdcp_handle_cpirq);
> =20
> -STATIC_IFN_KUNIT
> +VISIBLE_IF_KUNIT
>  void event_callback(struct work_struct *work)

[Severity: Low]
Similar to the above, does exposing the generic name event_callback to the=
=20
global namespace risk collisions when CONFIG_KUNIT is enabled?

[ ... ]

> @@ -608,7 +611,7 @@ bool enable_assr(void *handle, struct dc_link *link)
>  }
>  EXPORT_IF_KUNIT(enable_assr);
> =20
> -STATIC_IFN_KUNIT
> +VISIBLE_IF_KUNIT
>  void update_config(void *handle, struct cp_psp_stream_config *config)

[Severity: Low]
Could making update_config globally visible cause namespace collisions, as =
it=20
lacks a subsystem prefix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-visibility=
-unification-v1-0-6a962e5b3351@redhat.com?part=3D1
