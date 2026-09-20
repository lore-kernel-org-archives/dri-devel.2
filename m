Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2466CC982DA
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC8A10E590;
	Sun, 20 Sep 2026 11:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fZ08/1ZG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 700A610E573
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 11:05:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DD59E447BD;
 Sun, 20 Sep 2026 11:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA745C4AF0F;
 Sun, 20 Sep 2026 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789902347;
 bh=Y4ctGVmyz0DB+2j5W0yJqcPPlgSZT24HH1A9R2z2pl8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=fZ08/1ZGmcNSEgRFIWxdNIMNPZS1EOGkp/RbTVSeISB7NVyhmQtTSI75+Gg+gPtsv
 9yCHlQJdl8f4JWX6/u2A7T6+KxEVjmi3C7yo8nz+sD4uw2mb3fmM4jenAR5idMj9Lq
 e2Ic9CA6l6fJRXmHDB/gHmK+IAz6S/ZLAS4pVzUO6Kll1ncndCvokajFysSYRYCBgJ
 wKx/A52X8enAT3Tk+v5pf9XORNaSaArcHHk5/WZi5IcYumlBTwiI3hTAdNJmWN00Ny
 I1ltKh3NXQAI93zsh7AX4zZXAStcKgO954zh8jlPGjfi0Z2srj9U0aTAWYMBO8dMQk
 HK89rztYx1dqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9064CC982EE;
 Sun, 20 Sep 2026 11:05:47 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 20 Sep 2026 13:05:47 +0200
Subject: [PATCH 04/11] drm/panel: s6e3ha8: Introduce AMB577PX01 panel
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-crosshatch-panel-v1-4-de6e9512da96@ixit.cz>
References: <20260920-crosshatch-panel-v1-0-de6e9512da96@ixit.cz>
In-Reply-To: <20260920-crosshatch-panel-v1-0-de6e9512da96@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=vNLA8ljeR4J/HqPCfoTtAaLLmwPmUGSGqujdb8X7JAM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqr74ILPghpGdFk2JPKioQ/CBEKEUlRYPW8YCxR
 OabUG9VYbiJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaq++CAAKCRBgAj/E00kg
 criHEACyex0p+sdn2RW0coN+uPAHjIF1Nex/5Ut0SRCiQak8JtdRY2rPccdKuV+Fx2vMf/hxwW3
 vtNdETHNiKARn0KMVEAUltCQIZ4SI/e/8T8c94t/oeiGFzwOej8AaQ7O2s4RbRh4QbV4qme/qB2
 5W+YK0Nk9/HC0jziYJUREDXmChSvtN5QBMJKOoLA9cXiy/C0zF8enBd9m/MBtN7uFLZDrM2CupR
 2vzAL4SQ5TahFxyZNWmQISXJx3wFLhdcuL6L0wGkl0wO36dhV7Xybfp+zRoINtkooiWMoj8NVnX
 ayu3trGiLtsNqkMGhgn8Rr96OB4ez56UWrP79tCl84N5Z3TxuemfALA3EGDajqljptneSofmIDU
 cZ01utFMfAvy82fqWNx+efBLt1YXNREdPJhNFYnGzFLMFbDJvYkezEXuEAzZbCa61/PkAKo3gDX
 aRjeTETO5ZwIvciGFSP53cW5TMvx6sh2uKxYAeRsdIuLDx7vJ+v7vmWWcTc1MFfF2vF7TgL+QL3
 r+E7P/d/vReuV0fmb/FbL+TnYw6Qd4UT1c1jvnw2U/BO9HyXWuE5wS4+ZZ3qDR1JH4XEoFL+x1S
 ls2TiR2tKsgK8wORCRePpomYwYGvIRP+UmDNCN0qqgUQbe5p+IHOcUSdBcf1CIQgsVhyobKjUMo
 vMH3Cv9xY6ecJPQ==
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


