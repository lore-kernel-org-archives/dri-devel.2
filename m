Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B41C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3797C10F501;
	Fri, 11 Sep 2026 07:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZtClm1jA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188D610F501
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:36:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD1FA4400A;
 Fri, 11 Sep 2026 07:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EF81F000FF;
 Fri, 11 Sep 2026 07:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789112218;
 bh=zZblCM6CI8lZiskvJe0jPJJpks5hfWVV5F/Ynm/SUJs=;
 h=From:Date:Subject:To:Cc;
 b=ZtClm1jAnFkk5Yf1KwEMYrYrfy4aC5aIDZSsSm08TKRuQ75Pme2g7LbYWF9MyWvXS
 Udp4MaDbvdSaqyKOroabJxdknQak2t+Qv1Y4cRws3CzjDxZEEqxY2hV+NU1KW3K+z8
 qf5KTdX8SO+xqKFsVsNWWKyTpYtjd+zvdBxqi2agfGnWqpcke4Cu1x4z0+GMQLf50B
 nY9rVj5P2cZt93rBxEWHCxDejtbKrPEc8KeFwuJMEBuz0Ri5TfNbsVYsKKCSrDqQSM
 I+Cv7D1ZuO1PPxn+9bK1elZ/8OpyflkPNJ88LlFE3Cc/lmaonyPgZdOTiTNUeLJwud
 Sz8yeGz9becKQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 11 Sep 2026 09:36:48 +0200
Subject: [PATCH] Revert "dt-bindings: display: panel: panel-simple: Add
 lg,sw49410 compatible"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-topic-lg_sw49410_revert-v1-1-c9385a9e1926@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMWw6CMBBG4a2QebZJpyCCWyGGYPnFMQZIp14Sw
 t6t8Pg9nLOQIgiUztlCAW9RmcYEPmTk7904wEifTM660tbMJk6zePMcWv0UdcG2TRVCNDkfHfK
 qQ4UTpXoOuMl3OzeX3fq6PuDjf0fr+gNlrVAAewAAAA==
X-Change-ID: 20260911-topic-lg_sw49410_revert-3152e38ae8e7
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Paul Sajna <sajattack@postmarketos.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789112213; l=1816;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=GEeZxi4zHSTIomNLUXDqL2lG4X2l8hBa4plUPW4Gxl4=;
 b=1c4fHNY/bNRV7NAzmMIWPCjVTpldFA9vxt0aZyM0iYvDJqFBM9a5PacnRriVYqMZ3NBUUHvcI
 tOrGftoN2UmDeoWBWAmxZCt/aQOH73qoZxC6C4+Q1pYZ4HtiAivp6IZ
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This patch had been applied before the review has concluded. The panel
needs more specific handling than the one provided by panel-simple and
the intended compatible was supposed to contain both the display panel
name and the driver IC model number.

Moreover, the other compatible that didn't make it in the end landed in
the Qualcomm tree some time ago, instead of the one this revert
removes, so it's not even used.

See the link for reference.

This reverts commit a74c2e55ab66519ffa2069ac9ae83cd937bff4c4.

Link: https://lore.kernel.org/all/20260614-judyln-panel-v3-2-07f4134441bd@postmarketos.org/
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Paul, please resubmit your bindings patch with the proper compatible
and let's get it merged.
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 3d1cc11ba3aa..de722f45f862 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -206,8 +206,6 @@ properties:
       - lemaker,bl035-rgb-002
         # LG 7" (800x480 pixels) TFT LCD panel
       - lg,lb070wv8
-        # LG 6.1" (1440x3120) IPS LCD panel
-      - lg,sw49410
         # Logic Technologies LT161010-2NHC 7" WVGA TFT Cap Touch Module
       - logictechno,lt161010-2nhc
         # Logic Technologies LT161010-2NHR 7" WVGA TFT Resistive Touch Module

---
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: 20260911-topic-lg_sw49410_revert-3152e38ae8e7

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

