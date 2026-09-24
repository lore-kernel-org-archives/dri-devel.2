Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8075C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A3410F5D7;
	Thu, 24 Sep 2026 14:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OoE828Mc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C4C10F5CE
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B138447AB;
 Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 125D3C4AF09;
 Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790258496;
 bh=ZNijc5MOKUhzAFx9b3sabAhG9y17oQclhc/PpQz74Pg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=OoE828McXFL0/V6pcsgYqJxMBPGC/GjR2neOx8orTlfBJqMHxkxYclz5YuIQQfdg/
 VMdp57x01sDlV/77b00XNIR3nP4LrM2BB50PprdWS050hqEGiNeQdwcsNmCdEyOdbP
 Q1IAVITboTr3JeCu/A6z158wF5RF0NDFVuH5CIKCL8o3fDeNVedu/icGxkIWQDpXGr
 v9RMVqFzJdy8hre6q1k2BK+TC0PxarnuKfqQMX0ATTn3/akzGUlXD0YAIQIiS1LM3T
 qBcsOreeBMQv9/4v0OENbth5Gsb7MtVDpXYHmzQWsrrtbF5ddS/2z8qHN0gZmjX3Vm
 bnZ0Y/fn8Imwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 003FEC9831F;
 Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 24 Sep 2026 16:01:35 +0200
Subject: [PATCH v2 07/11] drm/panel: s6e3ha8: Assert reset GPIO in
 unprepare
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-crosshatch-panel-v2-7-08d5c7bf72fc@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=+wJwzxl6R6kFsAw/IP8INT9PZdDDVelgZpdEfbOYejM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqtS09+kmOyC3qmmduvr07jHQ5sps+RXxREaQTh
 TqcBIdNFPOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarUtPQAKCRBgAj/E00kg
 ctzqD/4vq65LGGkUX0Ykq7LT8/pNIFwf2tY0PmuVkWhAPlyAfbx2oofy4IwyvvBH5Ch+45SiLuO
 ikgycsyvBwM7P+tF+JfpoUuzTpJ+AaSGxtqQ5okGW9t8DQWQlpuuwl300jKBMO8sH2FfO8UaSbK
 fyTF8sWh5u7M1nXo88TTOR9gGPpeBzTUNDI2eEKPqk09mpAojj34+WjNehvImSYDNRUrRDlkrNq
 twr4EIv3nEkcJleLAC1wHiGbR/rwvm6bb2EZLRNr6i7jLc7qtORBEaK+KgGYtH/vgTyydDEJztR
 DsvtdiLLIGsDbV3IoAWTZS6BP6zT5ToDE1+zokt1X2DzCRonY3sQxJ3F2zs48dOOIA40MOlHeOg
 bDgFXyONE0vMZ9qwgq9DKM9/pJHViDl3cSgzKIRPNMT9Lh3bzFOTTKJ1H3QNjU65Tsl1ADZFHSA
 LisOhkepB+s93s1jj4pPlgG+mk3wJQJgOpq9QGBc+RweW5rbIBPN+njmi0jg9nq8WGcac9KYuJh
 FOt8rSn1XXoXg41NCC3k7bONDN9ovLnk40AFqoisqOODZVLL0RP6n2VH1lYU9F8kN/UXqQF3AVM
 1G9vCw/I9HVCI+2n/H6O70PwBqb7J+u/yoakVJFCBavZAYiBvO9of/JPF/0IAGSxdrW70yhPekR
 X7aSXeaY2/j4ieg==
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

For correct shutdown, the reset should be asserted.

Assisted-by: LLM
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
index 99290913de69a..2591b8c1a7753 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -58,16 +58,17 @@ static int s6e3ha8_get_modes(struct drm_panel *panel,
 
 	return drm_connector_helper_get_modes_fixed(connector, priv->desc->mode);
 }
 
 static int s6e3ha8_unprepare(struct drm_panel *panel)
 {
 	struct s6e3ha8 *priv = to_s6e3ha8(panel);
 
+	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	return regulator_bulk_disable(priv->desc->num_supplies, priv->supplies);
 }
 
 static void s6e3ha8_amb577px01_wqhd_reset(struct s6e3ha8 *priv)
 {
 	gpiod_set_value_cansleep(priv->reset_gpio, 0);
 	usleep_range(5000, 6000);
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);

-- 
2.55.0


