Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DA7CD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45AD10E73E;
	Fri,  5 Jun 2026 18:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="SdTVyal2";
	dkim-atps=neutral
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch
 [185.70.43.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21F110E73E
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 18:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780684045; x=1780943245;
 bh=8ED5nZjiqpEXlT1Wh2oVhR3GG1x+dmxiujPClGruK8k=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=SdTVyal2IxQXmfd5GV6vNZmBffgQgiMEbMuruyIEeyNmhDx4KUg3n16377b7lnaSH
 mg4dLvz3eCqSmKztBnvS1RMZ1M0OTwjP3IS2ogtaP+y7QG0AJCiQpYco7hlU1JWzVT
 DIpZaMQE1Crz/+f+9FUl7WL4BsLWDkdWCQhz3uBGJPR0ndDM727ZlCNBFf/7uYk6ZQ
 onQfluUBMOLkbJRhCP5UcOu59OaB0gAArwIy6Vp+IXOjPwz5U6qBl+wzSSX2fEZOPr
 3gHQv7YDDwuRBMRm2tBqpnqVn3vk6qeILUXirnyPA65h7tR4XRBi+KdYdzTVDccIXa
 YW2RlKEJWvwMw==
Date: Fri, 05 Jun 2026 18:27:20 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH v2 0/2] Add support for the BOE BF068MWM-TD0
Message-ID: <20260605-asteroids-panel-support-v2-0-44b96c6eca91@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: c7d77c00daf62b41a36e4d4449b050842f89f006
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

This series depends on support for DSC configurations with slice_per_pkt > =
1,
technically it boots up and displays stuff without it but you see artifacti=
ng
without it:
https://lore.kernel.org/linux-arm-msm/20260318-dsi-dsc-slice-per-pkt-v2-0-0=
a1b316f8250@pm.me

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
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
 drivers/gpu/drm/panel/panel-raydium-rm69220.c      | 435 +++++++++++++++++=
++++
 5 files changed, 531 insertions(+)
---
base-commit: 15a038bc8d93f92c80d9ba6844d4f16333234f39
change-id: 20260603-asteroids-panel-support-d55c929a89a8

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


