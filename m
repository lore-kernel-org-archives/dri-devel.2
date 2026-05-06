Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F2ACD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 09:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BEFF10EA7D;
	Wed,  6 May 2026 09:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="TSnKt6oG";
	dkim-atps=neutral
Received: from out28-127.mail.aliyun.com (out28-127.mail.aliyun.com
 [115.124.28.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0982110EA7D
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1778061068; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=8hlh69TLukXNhYn2CsDByyP7GpON+gsj+HvV8295yUE=;
 b=TSnKt6oGBWsFig6SjcPsvj879cwHvGO7x998Hpf++biS/R/RtGjGZTCu6XtfHMd30NDJulqlS5MERrpBq74K22ZA4v8KWDeX4ZCj2TnoqYp8t3Ol7wjovJa1T9PCI0Aztbh25sZjigwUjf5GWLymTvl7Hfc7eJA/2OtquqvuoNmaacKfTjMKYKD77ueYoEL/cABl3sWuAN+ZQ0NENxWETTlNEoNZkK0cb+9YMcXgDkbnvrXTqD1W/zmRB81HMotry7qPN8JF9LnVcbJG78Z+fPN2iFtkaycOPrqvZgfD4jz2w4cM7YY+yEA+cFjjR9qCLAVBJUQg452hHp+vai5z0w==
X-Alimail-AntiSpam: AC=SUSPECT; BC=0.6149114|-1; BR=01201311R901b1; CH=blue;
 DM=|SUSPECT|false|; DS=CONTINUE|ham_system_inform|0.183518-0.00602126-0.810461;
 FP=11096877887652623328|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037022039; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=22; RT=22; SR=0; TI=SMTPD_---.hQlP4Z0_1778061064; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hQlP4Z0_1778061064 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 06 May 2026 17:51:06 +0800
From: syyang@lontium.com
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com,
 Sunyun Yang <syyang@lontium.com>
Subject: [PATCH v4 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
Date: Wed,  6 May 2026 17:50:59 +0800
Message-Id: <20260506095100.78998-2-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506095100.78998-1-syyang@lontium.com>
References: <20260506095100.78998-1-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Sunyun Yang <syyang@lontium.com>

LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
mipi dsi and output hdmi, differences in hardware features:
- LT9611C: supports 1-port mipi dsi to hdmi 1.4
- LT9611EX: supports 2-port mipi dsi to hdmi 1.4
- LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0

Signed-off-by: Sunyun Yang <syyang@lontium.com>
---
 .../bindings/display/bridge/lontium,lt9611.yaml           | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
index 429a06057ae8..b20a43456b01 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
@@ -4,19 +4,23 @@
 $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
+title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
 description: |
-  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDMI
+  The LT9611、LT9611UXC、LT9611C、LT9611EX and LT9611UXD
+  are bridge devices which convert DSI to HDMI
 
 properties:
   compatible:
     enum:
       - lontium,lt9611
       - lontium,lt9611uxc
+      - lontium,lt9611c
+      - lontium,lt9611ex
+      - lontium,lt9611uxd
 
   reg:
     maxItems: 1
-- 
2.34.1

