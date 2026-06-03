Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE164CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFDC10FDB7;
	Wed,  3 Jun 2026 13:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="ajtZWuca";
	dkim-atps=neutral
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch
 [79.135.106.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE0F10FDAF
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 13:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780491791; x=1780750991;
 bh=ozjq0z6xun0KKQNe4TBrfS/xRvkX1S9573CAfKsaYgM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ajtZWucabQ3/6F76/L5cGADu+qNYhPSzgJ6r2oXLN5U1xLhPzWNmRPG//SaGxpt6J
 DDuMn5VhTZqeQ06b0aMHqozbqfnuFJvp8bcSgiZvbHnh9ctOIl8gXgvoLFq2HkbKLw
 8QwxfnZZKNFQp4G3AMCX6wBEXOYixLzXiGvwrUo81rH0h0U7IUoPVbrelZX6VaPyLf
 HzPnrXoetgjWwzRDcEPXxz3Z1uuodn2jFc5GaUfn6iyE5ASKJmJXwLIlzE8++BI6QG
 aRC7cRoHssxb7ZoifxKHCOHk7PA/E3heuDGzU4oSMcvjl5PKdAEfTKsQ5Pneh1ka1O
 jvUokaTZkXZ5Q==
Date: Wed, 03 Jun 2026 13:03:03 +0000
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
Subject: [PATCH 0/2] Add support for the BOE BF068MWM-TD0
Message-ID: <20260603-asteroids-panel-support-v1-0-109c6ac81c8f@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 79248a0368e3d671c92455c05a409bb24fe6e20b
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
Alexander Koskovich (2):
      dt-bindings: display: panel: Document BOE BF068MWM-TD0
      drm/panel: Add BOE BF068MWM-TD0 panel driver

 .../bindings/display/panel/boe,bf068mwm-td0.yaml   |  77 ++++
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-boe-bf068mwm-td0.c     | 432 +++++++++++++++++=
++++
 5 files changed, 527 insertions(+)
---
base-commit: 15a038bc8d93f92c80d9ba6844d4f16333234f39
change-id: 20260603-asteroids-panel-support-d55c929a89a8

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


