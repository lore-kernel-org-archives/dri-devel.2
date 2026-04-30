Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2722CCD13D2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 22:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68ED010E492;
	Thu, 30 Apr 2026 22:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="a5XkAt5x";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0769C10E492
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 22:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777587637;
 bh=RMAcDBTD4pL+Sz+328OnnJuYFaoFY/ioz2Tc1RWLkus=;
 h=From:Subject:Date:To:Cc:From;
 b=a5XkAt5x5eJlTo8opIKu7PphWLd7NFuhsjt+xwK223saXy1FaOolEdGCU04Sn81rv
 xe6Akt4ww+wcL0gRD3nvGp6zI+hItxo9FJF/3ZwjTUBWtdLMRRbEGxJrORM5ER2XRB
 nXgtjWsuF7+E9ygL+X5zkE/mIGbgWcCj5g+co1mggX7clDiM8wJrNiaSnORpkFk+cs
 Ga4psBgmUqO+ZnoTcqAGdF3Z/Ms7CjDhWjDr4XUJz/W8ZTx/C4skSz257RzqaTCyOc
 lyedHz5RiXjBl1ESteppzEa2mF1XfDfK3bt7DsMPSdEfvCBp9YBYBGIjbjsy/6CGjL
 Vozf5YbDgJgdw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D10D17E0EBB;
 Fri,  1 May 2026 00:20:37 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0E99248002C; Fri, 01 May 2026 00:20:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 00/12] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
Date: Fri, 01 May 2026 00:20:27 +0200
Message-Id: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKvV82kC/33NQQ6CMBCF4auQrh3TjoLgynsYFpUO0gTapkOqh
 HB3K4lbl/9bfG8VTNESi2uxikjJsvUuBx4K0Q3aPQmsyS1QYiVPWAIvzgdeGMwLTAA7hegTTeR
 mhovRSE1temWMyEKI1Nv3rt/b3IPl2cdlP0vqu/7c6q+bFEgoparPjaoQG3nr/Djqh4/62PlJt
 Nu2fQBYNZtDygAAAA==
X-Change-ID: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3437;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=RMAcDBTD4pL+Sz+328OnnJuYFaoFY/ioz2Tc1RWLkus=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnz1bTExw/RH7wo+skMiRP5dy41WhNJUMs2c
 McJVXYpx8xYZIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJp89W0AAoJENju1/PI
 O/qaHSsQAJj9M5LjzgNCoqCWXVTYee5wSrWKw4stStcVzQH0YowrtFlaDws4gN/hRb9F//EF6Nt
 GUb583PYiLuwAcaZSeVDajrNtrjgNkR0P9itrO6AqonDKPbzVRB2CJgUjOtAAY9DFiCMvypWLbO
 0SstrQ7CVeoHCnu/hSzGv2KkkCqv5ChAbzFVKTZy3wSNNis4GRPYCyIfeEaP0vGEYlVDkvv6RfQ
 PML4qwtqrOM3+Y8+osOrx93QM49NJuqMVy9RfAv5L/wUMmhnVj27lBGTzXHzHFaDhoWmlL/j6n4
 h7e+J9UgZ2ATiSNXa6EKLgEVJxgxElgddG1BqonC/ZVQhMH7Ah4Ni+Op1vFqvzwq8s7aM0ggMrN
 sO5HDL60NKbdxQW8ZnNWWY5b7QQCVxPvfveNr++Jx5uQHz84GPQauWpXi1Ewbt+iDsFkLvLiM4n
 NLyuxT8yX0xH1movZ4jxZAAS0hMf/zbfy3puPWkWRMvbDdOroLKHOZEbD2FKFTPExip08X6oPAa
 Fpiqq3ecn1vdBBa6Y9ozkOITdCt7afE99U3G3vGZMdHZUYYNGuyEK9To2ZQhrJo6ZYI9vclawte
 6oGfnznHji4zFLg1agiWpkHFB4ZhGHsr/qrRV8DyrG3u2Ky3mHuDc2keXeuFY5CoEkxAVpB9hbt
 FJKX+myL+7MRNqhtfvLIt3w==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

This patch series updates the Synopsys Designware DisplayPort bridge
together with the only existing user: The Rockchip RK3576/RK3588:

 1. follow-up bridges (PHY, USB-C connector)
    this is needed to get USB-C DP AltMode working; I've followed the
    Qualcomm driver as reference

 2. runtime PM
    the initial driver has been upstreamed without RPM; add it to
    avoid wasting power when nothing is plugged

 3. audio
    the initial driver has been upstreamed without audio support;
    this adds all missing bits for audio with single stream transport

To properly make use of the bridge code the following USBDP PHY series
is also needed:

https://lore.kernel.org/linux-phy/20260428-rockchip-usbdp-cleanup-v4-0-7775671ece22@collabora.com/

There are two parts, which possibly need some discussion:

 1. I added a dedicated bridge callback for out-of-band hotplug events,
    which is separate from the hotplug_notify. I have a feeling, that
    there might be a better solution, but haven't found it.

 2. The DT binding for audio support - explicitly marked as RFC - works
    perfectly fine, but is not ready for MST. I don't intend to
    implement that right now, but the binding should obviously take it
    into consideration to avoid breaking it in the future. I've put
    some points for discussion into the relevant patch.

P.S.: I will be out of office in May, so please do not expect speedy
      response from me :)

Changes since PATCHv1:
 * https://lore.kernel.org/r/20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com
 * rebased to latest drm-misc-next
 * prepended the Patches from Cristian's cleanup series, as they also
   needed a rebase and should be merged first
   https://lore.kernel.org/dri-devel/20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com/
 * fix issue with the audio stream (un)prepare handling in last patch

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Cristian Ciocaltea (2):
      drm/bridge: synopsys: dw-dp: Support unregistering the AUX channel
      drm/rockchip: dw_dp: Release core resources

Sebastian Reichel (10):
      drm/bridge: synopsys: dw-dp: Simplify driver data setting
      drm/bridge: synopsys: dw-dp: Support MEDIA_BUS_FMT_FIXED
      drm/bridge: synopsys: dw-dp: Add follow-up bridge support
      drm/bridge: Add out-of-band HPD notify handler
      drm/rockchip: dw_dp: Implement out-of-band HPD handling
      drm/bridge: synopsys: dw-dp: Support software triggered OOB HPD
      drm/bridge: synopsys: dw-dp: Add Runtime PM support
      drm/rockchip: dw_dp: Add runtime PM support
      [RFC] dt-bindings: display: rockchip: dw-dp: fix sound DAI cells
      drm/bridge: synopsys: dw-dp: Add audio support

 .../bindings/display/rockchip/rockchip,dw-dp.yaml  |   5 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            | 314 ++++++++++++++++++++-
 drivers/gpu/drm/display/drm_bridge_connector.c     |   6 +
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          | 180 +++++++++++-
 include/drm/bridge/dw_dp.h                         |   7 +
 include/drm/drm_bridge.h                           |  14 +
 6 files changed, 512 insertions(+), 14 deletions(-)
---
base-commit: 3221890f4e14f17ab46224798e89fbe099904edc
change-id: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

