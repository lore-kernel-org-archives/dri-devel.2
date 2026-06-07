Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C58ECD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 20:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B68610EB68;
	Sun,  7 Jun 2026 20:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GC+S02un";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAFF10EB68
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 20:11:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7FC4E600BB;
 Sun,  7 Jun 2026 20:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27724C2BCB4;
 Sun,  7 Jun 2026 20:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780863115;
 bh=+oftQmEW5pT/mCCZUYM3/CYSfFCJ98f3GJKlfF1qTuo=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=GC+S02unH3/o/BxXkKDKbqkKUZZUrqIChVMI7E/Av5dOfhbjo1vkZlvIxiCzAYYGJ
 SVgJzfpkr8YMFhIRRuzY8ZEf7FmcYBKvujsbGGy4JneB3FvqcVyDSbtRGY3NBxoNqT
 QUlHD9G4OjTOSvyOx8YwZmdylLA7ILItQ2FUUgdEdezcn30Vh3V4SlOQKHyfnqUF+0
 W/rXB5zkWS2Ap8NBB3FhyckuQmZ79/UfBiwhgbSKzhQJNmIkRyFxdQGsiCRZCsaZGu
 XNGa1bbH58J9oEenR6azflAsPmjt851QgcZ+kv9R24mKo/ulvhWgkXAoSq/MV7zRy+
 ymqwqsQL/KZAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5E1CD8C90;
 Sun,  7 Jun 2026 20:11:55 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v4 0/2] drm/panel: Add panel driver for Chipone ICNA35XX
 based panels
Date: Sun, 07 Jun 2026 15:11:43 -0500
Message-Id: <20260607-icna35xx-v4-0-64de514add34@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPy26DMBBFfwV5XVfjJ4ZV/6Pqwh4PiaUCCaaIK
 OLf68KiqFKXdzTnPp4s05Qos7Z6somWlNM4FKFfKoZXP1yIp1g0kyAtSAk84eCVWVdO2PjOC0X
 Ce1bebxN1ad2t3j8OPdH9qzjOx5EFn4nj2PdpbitLTpuAoXbYGN81ykCjQUOImiIqlMHGWDvNz
 k3a6ughau4fA79jdsYAFxahDlZFkrZdHPuJv6Y8j9NjH7aIPX9nS8zvhkVw4Na5qEqqgK55u/Q
 +fb6WkrvJIk+g0CdQFlAbj1HEzhtr/4LqP1AVEBXoDjQqifoMbtv2DVzpjuaRAQAA
X-Change-ID: 20260220-icna35xx-ec9afa13e1aa
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Teguh Sobirin <teguh@sobir.in>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780863114; l=2471;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=+oftQmEW5pT/mCCZUYM3/CYSfFCJ98f3GJKlfF1qTuo=;
 b=2LPwrUIrbPaRDm/C/IGBOR8zNhgN3s/2+Rq/Xv/EmakMASKN8Ns/pG2AGC06dL7DpisTdRjua
 vKaCEYwCSMqAOPXvQen18ndaJx+jLyRI8r85grK/cRd2oqitvzDcZir
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This driver is based on the one by Teguh Sobirin [0].
    
Due to [1], the AYN vendor description patch has been folded into the
AYN QCS8550 dt series. Which means this series depends on said series
and it must be picked up before this.

[0] https://github.com/AYNTechnologies/linux/commit/4c5e76e974db7cca853619ca138eecd8f004622f
[1] https://lore.kernel.org/linux-arm-msm/c7fb3f89-6574-4761-9ef2-2fdf6d4801b5@kernel.org

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v4:
- Drop all but one mode per variant, to avoid manual lookup of requested
  refresh rate
- Use more devm, eliminating the need for a remove function
- Don't lose lpm mode in brightness handling if an error happens
- Link to v3: https://lore.kernel.org/r/20260514-icna35xx-v3-0-c304f04c32c4@gmail.com

Changes in v3:
- Rename binding in patch 1 to icna3512 to match a compatible being used
- Edit commit messages in both patches 1 and 2 to better clarify the
  supported hardware and differences
- Link to v2: https://lore.kernel.org/r/20260514-icna35xx-v2-0-45acd1dfa566@gmail.com

Changes in v2:
- Fix lint warning in patch 1
- Add ayaneo,pocketds-panel-top compatible to patches 1 and 2, it uses the
  same init sequence as the odin 2 portal panel.
- Link to v1: https://lore.kernel.org/r/20260509-icna35xx-v1-0-688d3d4e10f9@gmail.com

---
Aaron Kling (1):
      dt-bindings: display: panel: Add Chipone ICNA3512 OLED driver bindings

Teguh Sobirin (1):
      drm/panel: Add panel driver for Chipone ICNA35XX based panels

 .../bindings/display/panel/chipone,icna3512.yaml   |  79 ++++
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-chipone-icna35xx.c     | 422 +++++++++++++++++++++
 4 files changed, 513 insertions(+)
---
base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
change-id: 20260220-icna35xx-ec9afa13e1aa
prerequisite-change-id: 20260217-ayn-qcs8550-16c07b63de26:v8
prerequisite-patch-id: 2b010637c46f5ea0e19a2fa87cc5ccb19bfd9204
prerequisite-patch-id: d0c633dc17f0aba726a8e8d21fee52b944bf67ff
prerequisite-patch-id: 11f4208bd788df984cec7404088c7d071ec49dfc
prerequisite-patch-id: 76b61799dba520fc7fa3ff39b044e24103337af3
prerequisite-patch-id: 3844bef2eda3cf59031b1d131eb6ba9295629bb4
prerequisite-patch-id: 3331648bc6f4ac3bb156f0525aa1ede92bfc57f1

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


