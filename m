Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BCECD5BAF
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4EAA10F0DE;
	Wed, 20 May 2026 16:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bM2vWTiB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E627B10E1F6
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:40:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AB5760120;
 Wed, 20 May 2026 16:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3C15C2BCB0;
 Wed, 20 May 2026 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779295241;
 bh=C+bAsxrO7Hwqd7h3A17Hh+Wk9te7bvjVSu4G652FOSE=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=bM2vWTiB3uWVR0vB6KYNd9Ft82YThNYWg+mwz5z6zUdP6SltRenR20T2V/wUx9APL
 DdTSYki+5OMp46KbFrx6w06L2eMbD7hZQmOWk5omXPnoej+wLtGfTSCoYbWjmC2e77
 iGkd6gL7g+tcSS+lloy8ckbvdOSqj1V9fVyjmhoIQWUOyv0NK0PIjFqT0j1jadHuGa
 z1H4k17qaQTKvi4HIte71E/JID6isEidTVy/pMcchBMRVFIqCiQKhO1KArKkwRbDjo
 9GcIoykYJsSDIoR7Rg8OnOcbt8EgseFMfG36QMq9S09niQX3HSvI2isVrMZshdfuAz
 r91eRTjqQermg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A5F73CD5BA4;
 Wed, 20 May 2026 16:40:41 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?=
 <devnull+jerome.debretagne.gmail.com@kernel.org>
Subject: [PATCH 00/11] Microsoft Surface Pro 9 5G update
Date: Wed, 20 May 2026 18:40:04 +0200
Message-Id: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOTjDWoC/x3MwQ6CMAyA4VchPVtTF2HiqxgP2+igl0FaJCSEd
 3d6/A7/f4CxChs8mwOUNzGZS8Xt0kCaQhkZZagGR66j1hHaR3NIjLb02I6YZ8XC+4r+0fsUI+W
 7S1DrRTnL/j+/3tUxGGPUUNL0+23+SnCeX4YdOrKAAAAA
X-Change-ID: 20260520-surface-sp9-5g-for-next-7897cbb0f42c
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Bartosz Golaszewski <brgl@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779295238; l=1578;
 i=jerome.debretagne@gmail.com; s=20260520; h=from:subject:message-id;
 bh=C+bAsxrO7Hwqd7h3A17Hh+Wk9te7bvjVSu4G652FOSE=;
 b=TxYunP+RMjqX6ztukqcbFSA9ok7XwP4bO3nlR9H9+xVWj1Xay+n9Ee8UnjAKgLVtfFf5+ndDL
 lfsAqQJ15CeBEwbFacPNIhbr5cf+0/QkZR0U+O/1CQ1wqrd3TNeUcLZ
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=3/JYhgYjGg5V9mlFxc0A0+pFiyjsuDB/TtDlNMId9fk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20260520
 with auth_id=785
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?=
 <jerome.debretagne@gmail.com>
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
Reply-To: jerome.debretagne@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This series updates the support for the Microsoft Surface 9 5G
(Arcata), bringing it more up-to-date and aligned with the other
sc8280xp models such as the Lenovo ThinkPad X13s.

As highlights, it finally enables the built-in screen, it fixes
Display Port alt mode on the top left-side USB-C port, it enables
the volume up/down keys and the lid switch.

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
Jérôme de Bretagne (11):
      drm/panel: edp: Add LG LP129WT232166 panel
      arm64: dts: qcom: sc8280xp-arcata: Enable backlight
      arm64: dts: qcom: sc8280xp-arcata: Enable the eDP display
      arm64: dts: qcom: sc8280xp-arcata: add USB-C orientation GPIOs
      arm64: dts: qcom: sc8280xp-arcata: Fix top USB-C DP alt mode
      arm64: dts: qcom: sc8280xp-arcata: Enable 4-lane DP support
      arm64: dts: qcom: sc8280xp-arcata: Add volume up/down GPIO keys
      arm64: dts: qcom: sc8280xp-arcata: Add lid switch
      arm64: dts: qcom: sc8280xp-arcata: model the PMU of the on-board wcn6855
      arm64: dts: qcom: sc8280xp-arcata: Switch to uefi rtc offset
      arm64: dts: qcom: sc8280xp-arcata: Drop duplicate DMIC supplies

 .../boot/dts/qcom/sc8280xp-microsoft-arcata.dts    | 301 ++++++++++++++++++---
 drivers/gpu/drm/panel/panel-edp.c                  |   1 +
 2 files changed, 266 insertions(+), 36 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260520-surface-sp9-5g-for-next-7897cbb0f42c

Best regards,
-- 
Jérôme de Bretagne <jerome.debretagne@gmail.com>


