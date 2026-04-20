Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75427F327B5
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2FA10EB6D;
	Tue, 21 Apr 2026 07:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="WTPjHrdi";
	dkim-atps=neutral
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com
 [115.124.28.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D6310E0DC
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1776665811; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=fz8ZCV6KPGHfcgLZir30aImQqrHMaqA6nm9Cs0iqeIw=;
 b=WTPjHrdi8fOcq+TsUy5m4XAwOxZVY4yjQqZ3RzBojVfv2DyETuzcEeMFRM2C4Yi+7XAHool11FWy7NM5dicw9UfX61mnBACZVOuGcz336Xyk5GyvyDs7G+YVYd3sckijSd2SEgRBKp+zCqrtgNe+iwlqZ7xP02TRYkzIVQzGhMNBVzD9h1D5ZMfqAkolZt1CyNh9BvHdMBswymWy1BRd6W+jcR+VerNntnQvtfclR/rw+FkdlrgOXO56437jqGL+T3aOM0TTB7cS2inPEcZomB46xry6QU8YgdZPtIrzJDOrVDDEKVhrvAWNyCNJbKtM2GAyPze1sdncfFMNTLSRBw==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09271921|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0545463-0.00504074-0.940413;
 FP=10089197397812664209|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033045220102; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=19; RT=19; SR=0; TI=SMTPD_---.hFz0LvD_1776665808; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hFz0LvD_1776665808 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 20 Apr 2026 14:16:50 +0800
From: syyang@lontium.com
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com,
 Sunyun Yang <syyang@lontium.com>
Subject: [PATCH v3 1/2] dt-bindings: bridge: This patch adds new content to
 the lontium, lt9611.yaml binding file
Date: Mon, 20 Apr 2026 14:16:43 +0800
Message-Id: <20260420061644.1251070-2-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420061644.1251070-1-syyang@lontium.com>
References: <20260420061644.1251070-1-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

Add lt9611c,lt9611ex,lt9611uxd to the lontium,lt9611.yaml file.
LT9611C(EX/UXD) is a high performance Single/Dual-Port MIPI to
HDMI 1.4/2.0 converter:

-Single/Dual-port MIPI DSI Receiver
 1. Compliantwith D-PHY1.2&DSI-2 1.0
 2. 1/2configurable ports
 3. 1 clock lane and 1/2/3/4 configurable data lanes per port
 4. 80Mbps~2.5Gbps per data lane
 5. Support RGB666, loosely RGB666, RGB888, RGB565,16-bit YCbCr4:2:2

-HDMI 1.4/2.0 Transmitter
 1.Data rate up to 6Gbps
 2.Support HDCP1.4/2.3
 3.Support CEC,HDR10
 4.Support lane swap

-audio
 1.sample rates of 32~192 KHz and sample sizes
   of 16~24 bits
 2.SPDIF interface supports PCM, Dolbydigital, DTS digital audio
   at up to 192KHz frame rate

-Miscellaneous
 1.CSC:RGB<->YUV444<->YUV422

Signed-off-by: Sunyun Yang <syyang@lontium.com>
---
 .../bindings/display/bridge/lontium,lt9611.yaml           | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
index 429a06057ae8..a67e63a5c87e 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
@@ -4,19 +4,23 @@
 $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
+title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI to HDMI Bridge
 
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

