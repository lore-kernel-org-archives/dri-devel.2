Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF81C9831F
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F333F10F5CE;
	Thu, 24 Sep 2026 14:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D0dbgQv2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D3F10F5CD
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 206B644779;
 Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1F4FC4AF11;
 Thu, 24 Sep 2026 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790258496;
 bh=rGsboR1NAldd5bx6/+4ouc+QR6HkIvOETiMf7nk5qeg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=D0dbgQv2fmdSYOIJ5W0C7DKoOWvEYLHMFuNmhQcuTkHCD+1+kmyRYdSJsvTyoy1dR
 cEFRhbrvi/fVhpesV6I65YDVA3HDsZ9n9hxgZfTY9AqNVL7RIwX5z/o3Tefkqx1HBc
 MUxHt6u6cJOPwEO0kW6w4DYfjJbTOPFOb8a+Em7W9yJcyxl0B/r8WFgWV1JiVDvXtx
 oapGpsyoeBbUw/D5XuYdhx88PAAfVfpuzIidJnJiGHSuR3I11Wsekr//Cpdpkc+7pm
 M9QDkRHWVMPpR1xzb9HCOjeK5eN9Va8PR5rXHbB/7zUL/G2xbnwyoqx2uhSU/q34vu
 VvgRsK6cYzQaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BEC26C98322;
 Thu, 24 Sep 2026 14:01:35 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 24 Sep 2026 16:01:32 +0200
Subject: [PATCH v2 04/11] drm/panel: s6e3ha8: Introduce AMB577PX01 panel
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-crosshatch-panel-v2-4-08d5c7bf72fc@ixit.cz>
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
In-Reply-To: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=I8au9RHlXJp0sQXsphkjbyxxUnhlBLGtjFxIrmaazt0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqtS09Aj+5xy06Bf/ZdEsKwwYMBKVtqAAr7raY4
 nhNkZ++z5aJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarUtPQAKCRBgAj/E00kg
 ck99D/9e5+IE8uB8z3x+xQs5FrYOzurX9IZsv1qZOtlKE4cVukeXZ0rjtTsGLaUPgAjTfTj9802
 4f8RwZevpFtnZ4emf5+G6YJAGuSSMb7yqnzI/PtMoQ1fi98ppDp05CEtEE5v4fS5mpHxbhV7R0z
 +idByYtgNXSGxS7vl5JZNZvEmdvl1MzfAsPkt1BriLFryGHn0Cv1j5x+xTWibTsxc02sNlipa74
 FnhD07JXH6cSomAXxHHr0YlNTLNgXTCSL2sfaE+RszyekaV4fuX2crU7vpB44cOQURSkqnMh3F+
 te23YneQoeA/8ZqPoga38qAmkRztFdwcdwjQ9aPz0bcX0AGt5hIhlDBz6uYOxRI/C1Xd8glRZOI
 lpuouukszROvnGHNP2CJ1stuLyFlw/67I2SYIqYLSUrT5g9tdn2F+cf3FEnJYLbAKVYXUiACgBV
 sGW4NYVjwsp//GqDVTZZEqNl46lCECLOGq0rRQvgx68wqQPAau+nOMOOLryc3nY5GVkOKIJhODT
 t5USd5XlqvvVZG+wwpj0p10dBmxKkjKN5HQSq4//mhXS/hQkKQxcJqJo1Z34S1hSgnbvew7jWbA
 DiSSEPCexL37VPKq18niYFPpUBQKcDZDtfaiOl0VNd0GRPhVjxWVzhclvs9tg4IGvAmI1AWi9nV
 bj7ABNci0h14xww==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

S6E3HA8 is the DDIC, while the panel used on the Samsung Galaxy S9 is
the Samsung AMB577PX01. Match on the new panel compatible, and keep
the deprecated DDIC-only one working for existing devicetrees.

Assisted-by: LLM
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
index 835121b322f4a..a0015ac0e2782 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -296,17 +296,18 @@ static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		return ret;
 	}
 
 	return 0;
 }
 
 static const struct of_device_id s6e3ha8_amb577px01_wqhd_of_match[] = {
-	{ .compatible = "samsung,s6e3ha8" },
+	{ .compatible = "samsung,s6e3ha8" }, /* deprecated */
+	{ .compatible = "samsung,s6e3ha8-amb577px01" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, s6e3ha8_amb577px01_wqhd_of_match);
 
 static struct mipi_dsi_driver s6e3ha8_amb577px01_wqhd_driver = {
 	.probe = s6e3ha8_amb577px01_wqhd_probe,
 	.driver = {
 		.name = "panel-s6e3ha8",

-- 
2.55.0


