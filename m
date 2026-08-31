Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A984FC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A7710E335;
	Mon, 31 Aug 2026 19:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J7dpCfsj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34DDF10E335
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:51:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F12BE40092;
 Mon, 31 Aug 2026 19:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3EB1F000E9;
 Mon, 31 Aug 2026 19:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788205904;
 bh=2QDoFRig95mN7D8YIqFFbYg3cWP3JhPIxfOl693vh/w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J7dpCfsj4oz/RqgYdv5eaFAY6NErYBMLceAfD0KiroKznaYnlrX4liG2BYl1nkk11
 ROXUGH8rLz04x4fl1IUHg9XuF+yUlo1tpN/SiHtsfkZfgbp4CVrjAXDFciywCdJpks
 eUzZ57clhoTcAk3UBmhMPWwsIl+X/ttlw+3H5qRPun5RnhB7F1iRIoG/bu6KgCprwE
 7Kj1h675odXjpdXjOR2cgDF97dyg8o0hQGLGJGXL4cYOjeYipiW0yeTlLFbQlVe2s4
 ZpgGlExaWlPWyr4wna0a2iZLHtZP0w8Rx7tDkIPm1bM90VcIHPQVZF5PnwaMmi9T7s
 eP8jPOdtpCEwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] drm/bridge: tc358767: select DRM_PANEL_BRIDGE
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-bridge-drm_panel-cleanup-v3-10-50efd8168b3e@bootlin.com>
References: <20260831-drm-bridge-drm_panel-cleanup-v3-0-50efd8168b3e@bootlin.com>
 <20260831-drm-bridge-drm_panel-cleanup-v3-10-50efd8168b3e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:51:44 +0000
Message-Id: <20260831195144.BF3EB1F000E9@smtp.kernel.org>
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
- [Medium] The commit message inaccurately claims the driver uses `devm_drm=
_of_get_bridge()`, but it actually uses `devm_drm_panel_bridge_add()`.
--

commit fba43756aa0937775cb42a2908c1424721d95003
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: tc358767: select DRM_PANEL_BRIDGE

This commit adds the DRM_PANEL_BRIDGE select to the DRM_TOSHIBA_TC358767
Kconfig entry. The commit message justifies this by stating the driver uses
a specific bridge function.

> This driver uses devm_drm_of_get_bridge(), which is enabled by
> DRM_PANEL_BRIDGE.

[Severity: Medium]
Is the function name in the commit message accurate?

Looking at drivers/gpu/drm/bridge/tc358767.c, the driver doesn't seem to
call devm_drm_of_get_bridge(). Instead, it calls devm_drm_panel_bridge_add()
in tc_probe_dpi_bridge_endpoint():

    bridge =3D devm_drm_panel_bridge_add(dev, panel);

And similarly in tc_probe_edp_bridge_endpoint():

    panel_bridge =3D devm_drm_panel_bridge_add(dev, panel);

Since devm_drm_panel_bridge_add() is also provided by CONFIG_DRM_PANEL_BRID=
GE
(as defined in include/drm/drm_bridge.h), the Kconfig change itself appears
correct, but the commit message reasoning might be slightly off.

Could the commit message be updated to mention devm_drm_panel_bridge_add()
instead of devm_drm_of_get_bridge()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-bridge=
-drm_panel-cleanup-v3-0-50efd8168b3e@bootlin.com?part=3D10
