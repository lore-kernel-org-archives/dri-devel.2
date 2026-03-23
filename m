Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F520F483D5
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1311310E52A;
	Mon, 23 Mar 2026 17:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TERubTVO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C2010E5BE
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:08:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 51B7C600CB;
 Mon, 23 Mar 2026 17:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEBD5C4CEF7;
 Mon, 23 Mar 2026 17:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774285718;
 bh=dPmDSxkVnarJ68kZsni6DorU2/7rZzSUc1e9Nw0R/e8=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=TERubTVOquOh9RtVj2AYAWQjz24ue1gwdlNJFJsstaVo6X0QXvRAV75XEweUtL3TE
 jKT2nUxp3mewLu1SqyiIY5c890pZ9IilWcCK/ZZ+2ClZ27IBSNjUwJYAGvI/8NHGKB
 wJ5Ms02/LsJIdziCgg8CFzREWD3lvW3wpwduz5yTQ4qKK9X5zMxGPI1LJq8AxsjCT1
 1ml7CxkvbOM/pEIXxlghWLnv4g8YuGJzkykIbQKZJ8qpK3425rVLgsfATgHU7Ca2Yi
 zUA1rOdhHisQQdF6J7BJ2AefT7L9PyXDfv8X8ePKs7prMgUjJvVFM2uEfMDX1Go/xi
 MbAeb1M5ngfPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB6F483D5;
 Mon, 23 Mar 2026 17:08:38 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] drm/panel: Add panel driver for ChipWealth CH13726A
 based panels
Date: Mon, 23 Mar 2026 12:08:31 -0500
Message-Id: <20260323-ch13726a-v3-0-e28b6f97fe80@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02Py26DMBBFfwV5XVfjMX7Aqv9RZWHscbBUoMEUJ
 Yr497pQiSzvaM59PFmmOVFmbfVkM60pp2ksQr5VzPduvBJPoWiGgBoQgfteSIPacdV4rY0NSgb
 Lyvv3TDHdd6vPy6Fnuv0Ux+U4ss5l4n4ahrS0lbEqAnUYrQrkOzJeUGwcNYiNFBFEU8fokdhrk
 7Y6egjD3WPkN5+tUsCF9mA6LQOhbtea/cX3KS/T/NiHrWLP/9+A54ZVcOCkQARjSYByH9fBpa/
 3UnI3WfEEZQk9QSwgWudq3fmgA7yC27b9Aqa0rxNYAQAA
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774285718; l=2117;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=dPmDSxkVnarJ68kZsni6DorU2/7rZzSUc1e9Nw0R/e8=;
 b=jqAv7KMVuVgfPPR3QtSR2+udFYVwvNa+Tlci/MAv13jRE4tuiboaeD7hwdiTr3s4s/1gzgagU
 rLBFSn+LWUiBmAHoKUwEzHy+lp1D9x/CKGh0sOLeQ0EnkZRkWOSTGo0
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

 .../display/panel/chipwealth,ch13726a.yaml         |  65 ++++
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c  | 339 +++++++++++++++++++++
 4 files changed, 416 insertions(+)
---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260220-ch13726a-59c6678d53d8
prerequisite-change-id: 20260217-ayn-qcs8550-16c07b63de26:v4
prerequisite-patch-id: 042cab8f04748207ba5395dd0f23c445955aaa2b
prerequisite-patch-id: 4e13275bfaa4f838a627fe8dfa3d4cb8972fc5b4
prerequisite-patch-id: 16c130bcfd7c787b91e828b8e600bd0d740f937e
prerequisite-patch-id: 4b7e6b017349c386f54e221790da4392fe066ff3
prerequisite-patch-id: 3844bef2eda3cf59031b1d131eb6ba9295629bb4
prerequisite-patch-id: bcb261e40f0386b91a09eb4080cbdf74d21f3df2

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


