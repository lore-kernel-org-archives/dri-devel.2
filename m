Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78328C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2681510E395;
	Sat,  4 Jul 2026 08:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="YqTnYboj";
	dkim-atps=neutral
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch
 [185.70.43.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA5B10E68B
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1783153453; x=1783412653;
 bh=Vfly9BhoMoxPtNDV8ENnNxHUTH5x5gOcIHfDtAnf5A8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=YqTnYbojhozr7ufKqb32+QaX/6RBiNmYrdx852HVWRm2wCo/dtYdEV0+OmgVL8s3S
 EGnu+kXtVRlXrtPpAt42TzZWxQ0FtD+wrGRAiM7XVLACyPzr4Pyf7i3/g31edSpPEk
 VXYmM2jy8H/iN66TPNnFYk+hJ982pta0kb4QckOS/5GeUnmB0iLpFgbsvGXhzxpmuF
 oAV69uPpkZMY423MMLULJS83rT7ZQXeWZ/iQWvnNihbwY/zX5M+9cr/25HIw43aApy
 cMu5pPGaOcOGKY72YshsUWtNztwg04rAsGqEI+ThSNfUehKXYzBmnj63shEfiZD/Ih
 puzvOhUc3UueA==
Date: Sat, 04 Jul 2026 08:24:05 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add support for the BOE BF068MWM-TD0
Message-ID: <20260704-asteroids-panel-support-v3-0-38dc92570579@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 1fb07fc1485a7d52098ac3203db8fda76e6124cd
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Add the bindings and driver for the BOE BF068MWM-TD0 panel used in the Noth=
ing
Phone (3a).

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
Changes in v3:
- Rebase onto next-20260701
- Keep 'required:' list in same order as properties (Krzysztof)
- Switch to devm_drm_panel_add, devm_mipi_dsi_attach and drop remove callba=
ck (Neil)
- Link to v2: https://lore.kernel.org/r/20260605-asteroids-panel-support-v2=
-0-44b96c6eca91@pm.me

Changes in v2:
- Rename binding & driver to DDIC instead of panel assembly (Neil)
- Clean up hardware resources in prepare() on errors (Sashiko AI review)
- Link to v1: https://lore.kernel.org/r/20260603-asteroids-panel-support-v1=
-0-109c6ac81c8f@pm.me

---
Alexander Koskovich (2):
      dt-bindings: display: panel: Document Raydium RM69220 DDIC
      drm/panel: Add driver for Raydium RM69220 DDIC

 .../bindings/display/panel/raydium,rm69220.yaml    |  74 ++++
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |  15 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm69220.c      | 417 +++++++++++++++++=
++++
 5 files changed, 513 insertions(+)
---
base-commit: 4f441960e691d37c880d2cc004de06bb5b6bd5e4
change-id: 20260603-asteroids-panel-support-d55c929a89a8

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


