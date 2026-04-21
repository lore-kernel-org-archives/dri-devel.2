Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9315F327D9
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C9C410E907;
	Tue, 21 Apr 2026 17:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sxWh8HGd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6FA10E902
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:38:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F02B060172;
 Tue, 21 Apr 2026 17:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F480C2BCB0;
 Tue, 21 Apr 2026 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776793120;
 bh=xvVeCMS46Knlj7LbuK2fp5ztldwZGUoNK8tMjveYJA4=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=sxWh8HGdF6Qjc+pUnyGkKUNmnjgvAG86qTiHXVnLFLIQhpG97TncGzX0gW3YOul/7
 xIWgtB5icVrwW0B36jCgedCucjqvSMUb03tIJm3Wz21yVJatw6v7Fazt+Xjp6UmhF5
 6evD6YBo3VV7bjwCu4RkYWwkLeGh/DOctGuLsNJ3jBWP8Czd/phHJi1ncovRTMot4C
 3lyrDp6q8goC7uXT68TPfDrm5eZSwzrosgaCC508HdoyyIMJ4jAjvrLB9t5dhtou32
 dBrJLi1Tys+gFatJlXufvs9ZsdZzZoQcyZ8hSNq8E5gg5luygODpnJU7goPtnnca4+
 MKXgigUwaGsDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 93B18F8FA64;
 Tue, 21 Apr 2026 17:38:40 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v5 0/2] drm/panel: Add panel driver for ChipWealth CH13726A
 based panels
Date: Tue, 21 Apr 2026 12:38:36 -0500
Message-Id: <20260421-ch13726a-v5-0-f7f6f4f30e05@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WPy07DMBBFfyXyGqPxOLbHWfEfiIUfY2qJtjQpE
 VXVf8dNkRLB8o7m3MdVTDxWnsTQXcXIc53q8dCEeepE2oXDO8uamxYIaAERZNop7dAGaXyy1lE
 2OpNo758jl/q9WL2+PfTIp6/meH4cRQwTy3Tc7+t56CKz5aAh9eSIWJHuSYMv5BVnCiUW5wBDE
 tsmQ/fooZwMl4M8pYmMAalsAhetzox2mI24x+/qdD6Ol2XYrJb83w24bpiVBMkGVHatApjw8r4
 P9eO5lVxMZlxB3UJXEBuIFEJvY8o2w19Qb0DUG1DfE5GiLd4Vpn9gv4I90AbsG+hjVMFHKhr9F
 rzdbj93t5ZbygEAAA==
X-Change-ID: 20260220-ch13726a-59c6678d53d8
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776793120; l=2550;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=xvVeCMS46Knlj7LbuK2fp5ztldwZGUoNK8tMjveYJA4=;
 b=3IbrQPi2U0CwfSYEwMtAhjQbaYNgWC7PZoJZGnZrqYC6IuCgVO5NNKjfVaX0WbGFBpyMsZ1FV
 4pm71/fk2rIDb4eD6VQaG1G/ET7TrH3Q22ChApUtzrsIPpauDohi8C5
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

This driver is based on the one by Teguh Sobirin [0], cut down to only
support the AYN Thor bottom panel.

Due to [1], the AYN vendor description patch has been folded into the
AYN QCS8550 dt series. Which means this series now depends on said
series and it must be picked up before this.

[0] https://github.com/AYNTechnologies/linux/commit/d0ff75b09e66023c5f88992706dee4601aa7a437
[1] https://lore.kernel.org/linux-arm-msm/c7fb3f89-6574-4761-9ef2-2fdf6d4801b5@kernel.org

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v5:
- Don't duplicate prepared tracking
- Use devm_regulator_bulk_get_const() instead of setting names in probe
- Use devm_drm_panel_alloc() instead of drm_panel_init()
- Link to v4: https://lore.kernel.org/r/20260408-ch13726a-v4-0-9bb1a9b8f329@gmail.com

Changes in v4:
- Add fallback compatible to bindings doc in patch 1
- Link to v3: https://lore.kernel.org/r/20260323-ch13726a-v3-0-e28b6f97fe80@gmail.com

Changes in v3:
- Reword patch 1 commit message for clarity
- Order properties properly in patch 1
- Track vendor description dependency series change
- Link to v2: https://lore.kernel.org/r/20260317-ch13726a-v2-0-28aa46bcd6d0@gmail.com

Changes in v2:
- Add Neil Armstrong to binding maintainer list
- Add 120hz mode, which required a minor restructure of the driver
- Link to v1: https://lore.kernel.org/r/20260222-ch13726a-v1-0-e501d78e105a@gmail.com

---
Aaron Kling (1):
      dt-bindings: display: panel: Add ChipWealth CH13726A AMOLED driver

Teguh Sobirin (1):
      drm/panel: Add panel driver for ChipWealth CH13726A based panels

 .../display/panel/chipwealth,ch13726a.yaml         |  67 +++++
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c  | 333 +++++++++++++++++++++
 4 files changed, 412 insertions(+)
---
base-commit: bee6ea30c48788e18348309f891ed8afbf7702ac
change-id: 20260220-ch13726a-59c6678d53d8
prerequisite-change-id: 20260217-ayn-qcs8550-16c07b63de26:v5
prerequisite-patch-id: 2b010637c46f5ea0e19a2fa87cc5ccb19bfd9204
prerequisite-patch-id: d0c633dc17f0aba726a8e8d21fee52b944bf67ff
prerequisite-patch-id: 76ac126273870a96f05e1bd87f4f31bdc3746440
prerequisite-patch-id: 76b61799dba520fc7fa3ff39b044e24103337af3
prerequisite-patch-id: 3844bef2eda3cf59031b1d131eb6ba9295629bb4
prerequisite-patch-id: 3331648bc6f4ac3bb156f0525aa1ede92bfc57f1

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


