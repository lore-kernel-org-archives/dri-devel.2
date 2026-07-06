Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBACC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093B310E7D6;
	Mon,  6 Jul 2026 07:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="qedg4/Yn";
	dkim-atps=neutral
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [91.218.175.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18DD810E7D1
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 07:33:26 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783323203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gB6sYSLbvHVUh7F5r4zsG9au/6lTVdK57G8fJgTB8VE=;
 b=qedg4/YnW//2bnk6PtAIsEFlNcA0wmSYaahp8ZsYWmAc3dJpdPKRMmIjKvC7orEbsHKf3+
 oVBHhVU5c7u03tgt82KbzN1QrtGVzIi4MIpCu3Wvs9bNfaZjezWB65Kr/Z+fPwnHeBEXuO
 kCt1PsQXejU/AnuxxFlxRu8Gi5SfOfI=
From: Junjie Cao <junjie.cao@linux.dev>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, pavel@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@oss.qualcomm.com, junjie.cao@linux.dev
Subject: [PATCH v2] MAINTAINERS: update my email address for the AW99706
 backlight driver
Date: Mon,  6 Jul 2026 15:33:07 +0800
Message-ID: <20260706073307.1038430-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Switch my maintainer entry for the Awinic AW99706 WLED backlight
driver from my personal Gmail address to junjie.cao@linux.dev.

Update both MAINTAINERS and the device-tree binding maintainers field.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v2:
 - Rebase onto the current for-leds-next / linux-next (Lee Jones).
 - Pick up Krzysztof's Ack.

v1: https://lore.kernel.org/all/20260701133533.32585-1-junjie.cao@linux.dev/

 .../devicetree/bindings/leds/backlight/awinic,aw99706.yaml      | 2 +-
 MAINTAINERS                                                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
index f48ce7a3434d..60eae50ff742 100644
--- a/Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Awinic AW99706 6-channel WLED Backlight Driver
 
 maintainers:
-  - Junjie Cao <caojunjie650@gmail.com>
+  - Junjie Cao <junjie.cao@linux.dev>
 
 allOf:
   - $ref: common.yaml#
diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..780f80766780 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4388,7 +4388,7 @@ S:	Maintained
 F:	drivers/media/pci/hws/
 
 AWINIC AW99706 WLED BACKLIGHT DRIVER
-M:	Junjie Cao <caojunjie650@gmail.com>
+M:	Junjie Cao <junjie.cao@linux.dev>
 S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
 F:	drivers/video/backlight/aw99706.c

base-commit: 7ddc04d1bd08f80ffc1e2fb97f3fc6cacab0ffc0
-- 
2.43.0

