Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16485C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CA410E8A7;
	Tue,  4 Aug 2026 07:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZBYNkduL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F77B10E8A7
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:19:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2652060A78;
 Tue,  4 Aug 2026 07:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795F21F000E9;
 Tue,  4 Aug 2026 07:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785827943;
 bh=cMGZhRgSvECecfQZ/g+tjyg9CTjQ2nh2a3Fnz0mMRk8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZBYNkduL12AkbPnZxqkZRaoD6A9nXbA0Sum7+Imnh/5Vuyuc4w2WjJELrSAZHRd9A
 qqoRXix1RHXhXeN9O+W4nlEhE27fu3k8AzOr0YMdFkme8SOUn/C5F14nrEjlAXZcdx
 Xf1atLsesEOO5NvpKD9DYSRt8v3Zg6HbVogixYELUg3J1vMXKWKwfxopAZehfcITVs
 CB55HmfrqpobsS6afJxRTM54TLeN+qWAxgzxrywGKj5tceJJipQvCzNMgkD24Md7Tk
 K0H4MDjU80jouaBgxZDoKhFGf7VZFlE66IPr0dl73Q3Z42U68g1HyRVKw+gm5sk4dh
 tqNpdciUfEtPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/7] drm/display: Add soft depend for
 aux-hpd-typec-dp-bridge module
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: neil.armstrong@linaro.org, olteanv@gmail.com, linux-phy@lists.infradead.org,
 vkoul@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260804070730.68-4-kernel@airkyi.com>
References: <20260804070730.68-1-kernel@airkyi.com>
 <20260804070730.68-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:19:02 +0000
Message-Id: <20260804071903.795F21F000E9@smtp.kernel.org>
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
- [High] The `MODULE_SOFTDEP` approach fails to load the `aux-hpd-typec-dp-=
bridge` module if `CONFIG_DRM_DISPLAY_HELPER` is built into the kernel (`=
=3Dy`) and `CONFIG_DRM_AUX_HPD_TYPEC_BRIDGE` is built as a module (`=3Dm`).
- [Medium] Adding a soft dependency on `aux-hpd-typec-dp-bridge` to a core =
DRM helper unconditionally forces the loading of the USB Type-C subsystem o=
n almost any system with a display, causing significant module bloat.
--

--- Patch [3]: [PATCH v6 3/7] drm/display: Add soft depend for aux-hpd-type=
c-dp-bridge module ---
commit f6b97c0e7a5ceab0d443dbadd5246c5cc93f2ec7
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/display: Add soft depend for aux-hpd-typec-dp-bridge module

This patch adds a soft dependency on the aux-hpd-typec-dp-bridge module to
the core drm_display_helper module. It attempts to ensure the bridge module
is auto-loaded before the display helper.

> diff --git a/drivers/gpu/drm/display/drm_display_helper_mod.c b/drivers/g=
pu/drm/display/drm_display_helper_mod.c
> index d8a6e62287736..f0152d6b0b2d7 100644
> --- a/drivers/gpu/drm/display/drm_display_helper_mod.c
> +++ b/drivers/gpu/drm/display/drm_display_helper_mod.c
[ ... ]
> @@ -18,5 +18,6 @@ static void __exit drm_display_helper_module_exit(void)
>  	drm_dp_aux_dev_exit();
>  }
> =20
> +MODULE_SOFTDEP("pre: aux-hpd-typec-dp-bridge");

[Severity: Medium]
Does this soft dependency unconditionally pull the entire USB Type-C subsys=
tem
into memory on almost every system that loads a standard DRM driver?

Since aux-hpd-typec-dp-bridge depends on typec.ko, it seems this will cause
unnecessary memory bloat on systems without Type-C displays, simply because
their DRM driver (like amdgpu, i915, or nouveau) uses drm_display_helper.

[Severity: High]
Will this approach fail to auto-load the bridge if CONFIG_DRM_DISPLAY_HELPER
is built into the kernel (=3Dy) and CONFIG_DRM_AUX_HPD_TYPEC_BRIDGE is built
as a module (=3Dm)?

If drm_display_helper is built-in, modprobe is never invoked for it during
boot, which means the MODULE_SOFTDEP directive is ignored. Because the
aux-hpd-typec-dp-bridge lacks a MODULE_DEVICE_TABLE or udev loading
mechanism, wouldn't it fail to load entirely in this configuration, silently
breaking Type-C DisplayPort hotplug detection?

>  module_init(drm_display_helper_module_init);
>  module_exit(drm_display_helper_module_exit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804070730.68-1=
-kernel@airkyi.com?part=3D3
