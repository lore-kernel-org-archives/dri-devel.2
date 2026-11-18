Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BBF606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwieJpVX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09B110E551;
	Wed, 18 Nov 2026 21:02:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E3310E551
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:02:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0861D63CAF;
 Wed, 18 Nov 2026 21:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969121F000C5;
 Wed, 18 Nov 2026 21:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795035739;
 bh=U5HknE1giXz0G6i9tNhOVUCkV2gO46kgNWsYccg/n7M=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ZwieJpVXeYCSoyDuMmVd7qO6M8gS/F6LOLVP0Rib/dmek7KpSxwRvvokiuWVcJntM
 VtGyFtdFwS5vc1Js75mnAEKD7Jxo60lHiBokOL5mjVRcEbzz9eeAJtXcbND8TaoLHD
 opcLKu8izTdYbr/OaM6VkHByKeC/s4RFIVLWhkszb/057VItk/RS9ocX7y/+l6jdNv
 O5/uARCYlU4xT1fcfMlUZkspVLY9eDS0sCOm7cQdiZfNGthPrP7AaEcn+U+IDx1eni
 b6BvWypeMdIGOaBkm1TmHG1sId44K9NpAdT5HZYcRuswH/8a9JFF9sfL4Wgan3zO0J
 9lPAU/txDO8Lw==
Message-ID: <sashiko-outbox-221965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sysfb: corebootdrm: Fix Kconfig dependency
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261118205503.18924-1-ville.syrjala@linux.intel.com>
References: <20261118205503.18924-1-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:02:19 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/sysfb: corebootdrm: Fixes trailer cites wrong introducing
  commit
--

commit bff902d09954dd5579fb286ff3723415928aa52a
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

> drm/sysfb: corebootdrm: Fix Kconfig dependency
>
> DRM_COREBOOTDRM depends on GOOGLE_FRAMEBUFFER_COREBOOT, which is a
> transitional stub symbol that can never be enabled. This makes the
> driver impossible to select. Depend on the real symbol,
> COREBOOT_FRAMEBUFFER, instead.
>
> Fixes: a29a1f0ec8d6 ("drm/sysfb: corebootdrm: Add DRM driver for coreboot=
 framebuffers")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

[Severity: Low]
Should the Fixes: tag point to 44e33a5aaa2d ("firmware: Rename google
firmware directory to coreboot") instead?

When a29a1f0ec8d6 ("drm/sysfb: corebootdrm: Add DRM driver for coreboot
framebuffers") was added, GOOGLE_FRAMEBUFFER_COREBOOT was the active
symbol and COREBOOT_FRAMEBUFFER did not exist yet.  44e33a5aaa2d
("firmware: Rename google firmware directory to coreboot") renamed it to
COREBOOT_FRAMEBUFFER and turned GOOGLE_FRAMEBUFFER_COREBOOT into a
promptless transitional stub without updating DRM_COREBOOTDRM, so citing
a29a1f0ec8d6 ("drm/sysfb: corebootdrm: Add DRM driver for coreboot
framebuffers") could cause stable backports onto kernels that do not yet
have COREBOOT_FRAMEBUFFER.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118205503.1892=
4-1-ville.syrjala@linux.intel.com?part=3D1
