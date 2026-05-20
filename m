Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1C5CD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D47510E206;
	Wed, 20 May 2026 16:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fmb9cZN4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56BFF10E1F6
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:40:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DBBC44561;
 Wed, 20 May 2026 16:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D65D9C2BCB4;
 Wed, 20 May 2026 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779295241;
 bh=P+0MEBbeeFMbG6eaiUA50b7PTzX8O3CPgXO1+hTm8r4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Fmb9cZN4HR9gC2/23MQ32OCgZ8QYXo4XtY7cnE0FSjGt8bz1UscXJVgoqE9H+5+FE
 Giz5wYEDyUtqx4pjSFeIQnlqa7SAKpjBjYGn9B7a95I2wno0Gf/ontcE7nNAwA9PSX
 NGLHdZNqIHOt0vPGRnwlTKX6CtfFMAOuCHKLaJE0G8OFKgjdf4t+RG9KhBqTAGiCDt
 /aqYPPUPKDxY8g+dh85nLRbazfDq9fhYZnzYRLRRh5QY4UuyXWHIHZsX2l99pI4XeP
 a4lcy1fVhbJPg7rZ8z9+UkpkqN3HjKi+CpHilDUFXDlbkyL35jysHfEuX2Z1cEZW5J
 QzP4Z2RGkE9dA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BE570CD4F3C;
 Wed, 20 May 2026 16:40:41 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?=
 <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Wed, 20 May 2026 18:40:05 +0200
Subject: [PATCH 01/11] drm/panel: edp: Add LG LP129WT232166 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-surface-sp9-5g-for-next-v1-1-9df52552bf87@gmail.com>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779295238; l=1891;
 i=jerome.debretagne@gmail.com; s=20260520; h=from:subject:message-id;
 bh=tHgNfvGMlnmFZXZkNh+6YfvXvVf/DcuqMDaolZYKux8=;
 b=G/9cCj3ftv34zFnJlbaPYRueYnY93DaRgqWvlQmn4g8AN4468H6z5LNKpCulkpXEHlhv/FEYw
 AZCDq7GoWC2AYPBdFB48f2yYeFpzFBCtzxI26eYDx04W7qgBCXU667Z
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=3/JYhgYjGg5V9mlFxc0A0+pFiyjsuDB/TtDlNMId9fk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20260520
 with auth_id=785
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?=
 <jerome.debretagne@gmail.com>
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
Reply-To: jerome.debretagne@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Jérôme de Bretagne <jerome.debretagne@gmail.com>

Add an entry for the eDP LG LP129WT232166 panel used in
the Microsoft Surface Pro 9 5G.

edid-decode (hex):

00 ff ff ff ff ff ff 00 30 e4 b2 06 a1 25 10 00
00 1f 01 04 a5 1b 12 78 01 ef 70 a7 51 4c a8 26
0e 4f 53 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 fd 00 18 78 f1
f1 48 01 0a 20 20 20 20 20 20 00 00 00 fe 00 4c
47 44 5f 4d 50 31 2e 30 5f 0a 20 20 00 00 00 fe
00 4c 50 31 32 39 57 54 32 33 32 31 36 36 01 23

70 13 79 00 00 03 01 14 56 16 01 88 3f 0b 4f 00
07 80 1f 00 7f 07 55 00 47 00 07 00 03 01 14 56
16 01 08 3f 0b 4f 00 07 80 1f 00 7f 07 2b 08 47
00 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 2c 90

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 679f4af5246d8a984387002c3fb0c6283cc21cb2..7eff79e80fa0578755a0b688cf792f58d8abcbe5 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2080,6 +2080,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0567, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x06b2, &delay_200_500_e200_d200, "LP129WT232166"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, "134WT1"),
 
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),

-- 
2.47.3


