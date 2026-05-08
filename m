Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA15CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 14:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5068E10E4D8;
	Fri,  8 May 2026 14:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="W+jU8Xtr";
	dkim-atps=neutral
Received: from out28-111.mail.aliyun.com (out28-111.mail.aliyun.com
 [115.124.28.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD41410E4D8
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1778250306; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=FkIOV7enKNbkeRupd/YkRnYNKVKO217Lx4gtauvA93M=;
 b=W+jU8XtrhKI2X7wkwltEJJvGHumZhjg5J5zm9KiD8uaJxKh2qOXtq1Uzf3keImdeVkrsu/QGGcXryLS7MNG+7OMy3hdVWI/xzzsypLamceXZfojv1AwDZcRYoRgi90sNIsoRGlmZzYM4beFF5jkZhnnIcNXw4k/vPX7yCndufsdS7ecjyLUdqbnLufQH5sqVE1k3XGu+hg8d9+GxyqCa+hxK4WyEs5MDL6IXFEU3J7Q9PPjjGfHcT0yCzHbRd1AhzB3vox0DX0s+Nc2MLQ2+H9ytB92FMnQU1dG5h+/MOEGIlptV9+rCYMEe8YlTK1krK7r+iGWxrEB4zZom2uyYwg==
X-Alimail-AntiSpam: AC=SUSPECT; BC=0.6169025|-1; BR=01201311R151b1; CH=blue;
 DM=|SUSPECT|false|; DS=CONTINUE|ham_system_inform|0.183518-0.00602126-0.810461;
 FP=9943956383314203584|14|2|17|0|-1|-1|-1;
 HT=maildocker-contentspam033045018182; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=22; RT=22; SR=0; TI=SMTPD_---.hShj9lU_1778250303; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hShj9lU_1778250303 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 08 May 2026 22:25:04 +0800
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
Subject: [PATCH v6 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
Date: Fri,  8 May 2026 22:25:00 +0800
Message-Id: <20260508142500.4922-1-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
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
index 429a06057ae8..e0821a63d9d7 100644
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
+      - lontium,lt9611c
+      - lontium,lt9611ex
       - lontium,lt9611uxc
+      - lontium,lt9611uxd
 
   reg:
     maxItems: 1
-- 
2.34.1

