Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E6CC982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A4D10E6D7;
	Thu, 17 Sep 2026 11:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="eIHpigt7";
	dkim-atps=neutral
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Thu, 17 Sep 2026 11:15:25 UTC
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0EE10E6F1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:15:25 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20260917110520227aa71a4d00020792
 for <dri-devel@lists.freedesktop.org>;
 Thu, 17 Sep 2026 13:05:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xiT4lWg2MBR4AgaxlocEUwBYCfrUrkc9jo45m11Mo+0=;
 b=eIHpigt7iquptxJK5sCzKcFiIx6qDjmMscLAVsGbnBjn8xSX7zYYi7jso2jyu+42XzW0Zq
 1rnXQTXhysHm07ppNaACB8k0ns8NoSK0A3fCKgh0zBqUjr/yGmtHri4kXQ1mnrOYZZxzmhoK
 I3e+zjeggHjkojwaSXJ9KXdD9uB4gcFWygMUgNAEHNJ167Ah3MnN6x9oaWWVN2EKImxnzEh8
 Y2NmIeflfBhnqZKmqKwqMtg3rXcvPiPPCq+QU+0dNDvBpwvMKqhlEi3snPmdquO88a+iZSbc
 Z/3uKpIklLkpNrqv9z0oxdMLWHBW8gsdgC9VdS8mN1v5v6Ddw75p0wTA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: simple: Add Truly TFT320240-229-E
 panel
Date: Thu, 17 Sep 2026 13:05:14 +0200
Message-ID: <20260917110517.1053556-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260917110517.1053556-1-alexander.sverdlin@siemens.com>
References: <20260917110517.1053556-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Document the compatible string for the Truly Semiconductors Limited
TFT320240-229-E 3.5" QVGA (320 x 240) parallel RGB TFT LCD panel, which
is driven by the panel-simple driver.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 3d1cc11ba3aa4..eb49832b26c46 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -338,6 +338,8 @@ properties:
       - tpk,f07a-0102
         # TPK U.S.A. LLC Fusion 10.1" 1024 x 600 (WSVGA) LCD panel with capacitive touch
       - tpk,f10a-0102
+        # Truly Semiconductors Limited 3.5" QVGA (320 x 240) TFT LCD panel
+      - truly,tft320240-229-e
         # United Radiant Technology UMSH-8596MD-xT 7.0" WVGA TFT LCD panel
         # Supported are LVDS versions (-11T, -19T) and parallel ones
         # (-T, -1T, -7T, -20T).
-- 
2.55.0

