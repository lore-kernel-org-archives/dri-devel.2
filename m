Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341E6CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8726F10E92E;
	Tue, 29 Sep 2026 13:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="neDElrUx";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9F710E92E
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:55:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 09AB31A1048;
 Tue, 29 Sep 2026 13:55:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C5CB8601BD;
 Tue, 29 Sep 2026 13:55:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E57B310328C55; 
 Tue, 29 Sep 2026 15:55:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790690127; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=pad1YA7/p08a+nzZNTwHGqME67fHB2DyZyGefFtLlR4=;
 b=neDElrUxzMHbbEzD7tEuaCDirSjmoOtdmCczz5vmTFvG88A0E41rKHKI0cveH/QbIZv/UF
 81KWExR7SFPZZOHsEeaJu+syGvZ/s2JwBzIQYbxey6MGfwHKTaUEyrMI4d1ilCZ/iayekh
 def+IiKt0VPhOdSo9FNhBSvSfAv4aCrS7VJmSzyOOZhht8PUWlRec0ED6JgBrHgWq5mYRG
 uH1w5a5knCqKGWj+tMGAcUR7f7hiS0TS4oyn+xm/FazGZm9h20LfqnNceuyPpF2b1u0PGX
 Dl78CfRcCB7vZ/L9vuQh0E0Khx80g4ph78VacWcArQce5Dv4p69ej8boQx1h7w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 15:55:23 +0200
Message-Id: <DLRUO5ZUTZ80.3VF1TPIAWTQM9@bootlin.com>
Subject: Re: [PATCH] drm/panel: select DRM_KMS_HELPER
Cc: "kernelci.org bot" <bot@kernelci.org>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Sasha Levin" <sashal@kernel.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260929114828.3260345-1-sashal@kernel.org>
In-Reply-To: <20260929114828.3260345-1-sashal@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue Sep 29, 2026 at 1:48 PM CEST, Sasha Levin wrote:
> Since the panel_bridge code moved into drm_panel.c, any config with
> DRM built in but without the KMS helpers fails to link, for example
> arc haps_hs_smp_defconfig with allnoconfig and the kselftest fragment:
>
>   arc-elf32-ld: drivers/gpu/drm/drm_panel.o:(.rodata+0x28): undefined
>   reference to `drm_atomic_helper_bridge_duplicate_state'
>   arc-elf32-ld: drivers/gpu/drm/drm_panel.o:(.rodata+0x2c): undefined
>   reference to `drm_atomic_helper_bridge_destroy_state'
>   ...
>
> With DRM=3Dm, modpost fails the same way:
>
>   ERROR: modpost: drivers/gpu/drm/drm_panel.ko: symbol
>   'drm_atomic_helper_bridge_duplicate_state' undefined!
>
> The panel_bridge used to live in bridge/panel.c, which was part of
> drm_kms_helper and was therefore only built when DRM_KMS_HELPER was
> enabled. drm_panel.c is built for DRM_PANEL instead, which
> DRM_PANEL_BRIDGE selects whenever DRM_BRIDGE is set, and DRM_BRIDGE
> is enabled for every DRM config. Nothing on that path selects
> DRM_KMS_HELPER, so the bridge and connector helpers used by the moved
> code can be missing.
>
> The panel_bridge code in drm_panel.c is built unconditionally, so
> make DRM_PANEL select DRM_KMS_HELPER.
>
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Closes: https://d.kernelci.org/i/maestro:9ed7f4b210fa7c1d3bb109b0fcd62285=
e98c5b81
> Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to drm_panel.c")
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
