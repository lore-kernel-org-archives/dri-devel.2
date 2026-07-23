Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57C5C531CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3F110F09B;
	Thu, 23 Jul 2026 11:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tEOQg8ay";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D7910F09F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:26:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9301860A6C;
 Thu, 23 Jul 2026 11:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36634C2BCC7;
 Thu, 23 Jul 2026 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1784805989;
 bh=5sewrzOdRWac/F/uqBnoM/NQOOWvpDIJMYAeTLUEGQc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tEOQg8ayE7enccXBYGNPNj057szmAsVQ88KnqKJjUxhqRpApf4FJ46wm3HnLi/hDe
 JpOGxf4WWbmUiskjzOehrnrqjux4Fb/FvGrAjUaw+olxa/t7uStKZ5D/qxNkYMLD8W
 EfhHMa80oAtCtjTqkez1/gg1ZxkncvMvKukBiHGGeQtthb6DlpKpKZ6rnJ538ktkRY
 Sl5Aph70E5OQwYMEowUrFyWCsXugGQBiIylJJjlhD7eRHW+ZLVEIWwn/vfztdp7RW3
 D6eDs5tPWzKLGBPsZEIIzp4KexMPEH35AvYUzN1rOG6I44YC1svXQczYsRYzk676+n
 q4Vu6rd3LC6Yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 14F9AC531CF;
 Thu, 23 Jul 2026 11:26:29 +0000 (UTC)
From: Alexandre Hamamdjian via B4 Relay
 <devnull+azkali.limited.gmail.com@kernel.org>
Date: Thu, 23 Jul 2026 18:26:28 +0700
Subject: [PATCH 1/2] dt-bindings: display: Add AYANEO Pocket DS lower panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-b4-st7703-pocketds-lower-v1-1-e3db246589f4@gmail.com>
References: <20260723-b4-st7703-pocketds-lower-v1-0-e3db246589f4@gmail.com>
In-Reply-To: <20260723-b4-st7703-pocketds-lower-v1-0-e3db246589f4@gmail.com>
To: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandre Hamamdjian <azkali.limited@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784805987; l=1241;
 i=azkali.limited@gmail.com; s=20260510; h=from:subject:message-id;
 bh=K1fR2kK/+LjIqWnZb42cj5ThTI+3DMxTN3z6sB3tVds=;
 b=cy2lnulZ67N5haOXuifPXUKDuZEmPIv/sPmoyjDawfnUEeURuOCsXpWoa4wsxGb0KgbavAbvw
 I1ebApNgX4lCGJ/xj4T0zvuNdCCglSO8GNxIz8K+kqHq0WgiC2j0Kud
X-Developer-Key: i=azkali.limited@gmail.com; a=ed25519;
 pk=I0Z0IdCdQJqNGX+FQUnXhrHg950u3cM6Xzz3YT6JOyQ=
X-Endpoint-Received: by B4 Relay for azkali.limited@gmail.com/20260510 with
 auth_id=774
X-Original-From: Alexandre Hamamdjian <azkali.limited@gmail.com>
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
Reply-To: azkali.limited@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Alexandre Hamamdjian <azkali.limited@gmail.com>

The lower (secondary) 5.0" 1024x768 IPS LCD panel of the AYANEO Pocket DS
dual-screen handheld is driven by a Sitronix ST7703 DDIC, as identified
by its ST7703 manufacturer command set (SETEXTC 0xB9, SETMIPI 0xBA,
SETGIP1/2 0xE9/0xEA). Document its compatible alongside the other ST7703
panels.

Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
---
 .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
index ebfc825b8346..91e06d6a6819 100644
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
@@ -22,6 +22,8 @@ properties:
     enum:
       # Anberic RG353V-V2 5.0" 640x480 TFT LCD panel
       - anbernic,rg353v-panel-v2
+      # AYANEO Pocket DS lower 5.0" 1024x768 IPS LCD panel
+      - ayaneo,pocket-ds-lower-panel
       # GameForce Chi 3.5" 640x480 TFT LCD panel
       - gameforce,chi-panel
       # Powkiddy RGB10MAX3 5.0" 720x1280 TFT LCD panel

-- 
2.55.0


