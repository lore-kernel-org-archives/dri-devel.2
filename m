Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF401C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D8E10F89E;
	Fri, 25 Sep 2026 07:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EjgJtzMU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C21D10F88F
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:08:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 848AC6022E;
 Fri, 25 Sep 2026 07:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BC7BC2BCB8;
 Fri, 25 Sep 2026 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790320101;
 bh=ZsKpam8KLtPpmS+Ar91k9r3ouuN+Nzl8+6PUy68plf4=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=EjgJtzMUt0ovu6Z1PBKiPQvjfUg2h2W2fW9gb3QJd8LMo2NAtGwUn8UWrXoxM8/9u
 73HQumeHBf+H6snU1S6aN+sYyGaawxsReKhbpAGHxRdApX53lfz02DjpmYHbCpFWFz
 DTEexJnTsmQf8oZ1kyyMG/I3U/8og7LMTP4az3QeYPJhTl/M1kS0HTwMpZj9gzAo86
 6mRRi2O4lH3zOMPFF89gN37R0KfMRC3mpy1kJ/enKvNlIam3EmsfVFpRIQ64+yf6i4
 YfQmsCBlapq+DVB84DRSmW5plrrOr6Ugizm2iyZqKhg6xUdQNLuxgCS5uKIxCrUdfS
 j/fthz9oTNdEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 07ED0C98321;
 Fri, 25 Sep 2026 07:08:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v2 0/4] drm/panel: Support Retroid Pocket 6 panel
Date: Fri, 25 Sep 2026 02:08:18 -0500
Message-Id: <20260925-rp6-panel-v2-0-19c425e523de@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22QzY6DMAyEXwXlvFnlDxM49T1WPQTjtJHKTxMWt
 ap49waQVj3scSzP+Bu/WKIYKLGmeLFIS0hhHLJQXwXDqxsuxEOXNVNCgdDS8jgBn9xAN25BWiN
 KI0ACy/tTJB8ee9bP+dCR7r85cj6GrHWJOI59H+amMKhK7dC0qm4tAiL4jrz1teqMd9gRKALd1
 uwTJZNtIEpW3D0Hfsdky1JwCSiqFnRHCprlX4sVG/ufw5ZoTQXCg9fNotkGfA1pHuNz/8Uid+L
 DKs1H7UXyfFBKlI4QvfCnS+/C7Tv3Yud1Xd+ovq1vUwEAAA==
X-Change-ID: 20260318-rp6-panel-861840540616
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790320100; l=2722;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=ZsKpam8KLtPpmS+Ar91k9r3ouuN+Nzl8+6PUy68plf4=;
 b=7pb5Lha82dm5y2lRwcuZPI1ZtEVwqZLB79LeQPRJT/DI0OJqFEhBoxqxmYNUxwbvq0J+lLzeb
 w9OW7lHlSgxDWGyR86bdLUQ4TBuciIa0rtfuJuSJViaIm/3pumxEbGT
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

This panel uses a Visionox VTDR6130 DDIC. There is an existing driver
for this ddic, however it is currently hardcoded for a panel used on
several Qualcomm devkits. This series sets up the driver to support
multiple panels, then adds the RP6 panel. It also adds support for
rotation as the RP6 panel is mounted sideways.

This depends on the Retroid Pocket dt series [0] for the vendor prefix
patch. That series depends on the AYN dt series [1] to apply cleanly.
    
[0] https://lore.kernel.org/linux-arm-msm/20260808-rp-qcs8550-v1-0-a5a365ba3dc5@gmail.com/
[1] https://lore.kernel.org/linux-arm-msm/20260727-ayn-qcs8550-v9-0-e3db456e10e5@gmail.com/

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v2:
- Drop unused struct member in patch 3
- Undo width/height changes in patch 3
- Link to v1: https://lore.kernel.org/r/20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com

---
Aaron Kling (4):
      dt-bindings: display: visionox,vtdr6130: Add Retroid Pocket 6 panel
      drm/panel: visionox-vtdr6130: Add panel orientation support
      drm/panel: visionox-vtdr6130: Modularize panel config
      drm/panel: visionox-vtdr6130: Add Retroid Pocket 6 panel

 .../bindings/display/panel/visionox,vtdr6130.yaml  |   8 +-
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c    | 221 ++++++++++++++++++---
 2 files changed, 197 insertions(+), 32 deletions(-)
---
base-commit: 4c253ac4b29b8c6cc6fdef8f92d4facde62e63b9
change-id: 20260318-rp6-panel-861840540616
prerequisite-change-id: 20260217-ayn-qcs8550-16c07b63de26:v9
prerequisite-patch-id: 17ba304f7a8a08cc78f98e198db9c51f4786a22c
prerequisite-patch-id: 21873631f5dcdb9bbbdb5c20c3f5e9816cc405f9
prerequisite-patch-id: bf7b5dea0097cbbdf04929a4246d1fc65c607ea8
prerequisite-patch-id: d7f546eddc96a4f31a1e681abddbc96bd68abb32
prerequisite-patch-id: d40d784ad8efbb1204c024408be2067725a06cf2
prerequisite-patch-id: 25bbd55199a8250a912ef542b31f43dd5ccdbc90
prerequisite-change-id: 20260808-rp-qcs8550-85c84760f6f3:v3
prerequisite-patch-id: 17ba304f7a8a08cc78f98e198db9c51f4786a22c
prerequisite-patch-id: 21873631f5dcdb9bbbdb5c20c3f5e9816cc405f9
prerequisite-patch-id: bf7b5dea0097cbbdf04929a4246d1fc65c607ea8
prerequisite-patch-id: d7f546eddc96a4f31a1e681abddbc96bd68abb32
prerequisite-patch-id: d40d784ad8efbb1204c024408be2067725a06cf2
prerequisite-patch-id: 25bbd55199a8250a912ef542b31f43dd5ccdbc90
prerequisite-patch-id: c79dacb2a8ca1298387bc9bc4a543de97c670a50
prerequisite-patch-id: 471c39ef6ce532e349e1f787b67ef1286b51f683
prerequisite-patch-id: 08107f621a4feffc1e5d644f714159a2d4b1f794
prerequisite-patch-id: 7e40351a859141256b0aa30afe259be3c03ec487

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


