Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBA8CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 01:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5298910E1E5;
	Fri,  2 Oct 2026 01:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="cYUvOeF4";
	dkim-atps=neutral
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B1310E1E5
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 01:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1790905876; x=1791165076;
 bh=Nrqllks35NsDc9tpEslCuU6ilJ7UtIxYT4bEMyjISKE=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=cYUvOeF43g5K6MGy1MrJXnp1ypvw/J+tewRYijqaX+PBf6SE/RLomNaZuJmr6wBrp
 jezQyH1GTnXhBhpjH+8OJgOHNt5vvd8kTIquM+W11kt/+8SGXaWRLtHQjwoEwCmZ2g
 04I1DLyCX4EqMjXDnV+3sbXNGrMmdvYTObZFMohmmwqSqg3izK2sLcPZPwm25DVOBJ
 aq0s7NfHfXv0Gnojde5B3KndMaQkz1sSay2HuoV3QkGe9bgqqRSFKDAnVljN3+fcF8
 leJHoRtEwysJByGedvyhmKmlyiC+7Wio4uGgyZkA8HJrBR2CkYEe42r/HFvEZaX50h
 zB3Utu3AJ08tQ==
Date: Fri, 02 Oct 2026 01:51:11 +0000
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
Subject: [PATCH v4 0/2] Add support for the BOE BF068MWM-TD0
Message-ID: <20261001-asteroids-panel-support-v4-0-635ba9e82618@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 1f2be8aefb59dc8e3301ddecfda57f25a992a302
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
Changes in v4:
- Rebase onto next-20261001
- Drop mod_devicetable.h, switch to device-id/of.h
- Link to v3: https://lore.kernel.org/r/20260704-asteroids-panel-support-v3=
-0-38dc92570579@pm.me

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
base-commit: 9f24d789f03b22941b905ded43cb5ff8eea9ce62
change-id: 20260603-asteroids-panel-support-d55c929a89a8

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


