Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCD606D81D
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5G6CuIB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFBE10E759;
	Sun,  8 Nov 2026 12:32:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8185D10E7BE
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:32:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F03EB60D6A;
 Sun,  8 Nov 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794141154;
 b=R4ePuv23TbygEJ2z8pVqp5wllq9bfyGvO3Ep9IBjQA9RxDyc7TDG+aPoohlkyNbmlnMm
 v9/ODcd8fBawpUiycQ6/7UyB/H3s3iPIrClC3Q3K4cwHM9qCeX+mR6y5uE0HIoWjEq5zn
 5PZjIxrzYSoivhiIFs3nlDK7ar1dBjGs6EUUFxUiORx7FOWnVYGJPKWD9h4uXJQC1dMDs
 UOFKonoeoku+StaoL5HiuGHSxWsylekFogafGixmWtt6Ylqh3w1aT41sBah7oJvwqysGq
 GJmttS4TpAwPl9ucxfKmmrGfvkUkVvQKQH5Pdc0N6ovNTmC4PX4I2kwMXpgPSPDrygQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794141154;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=1tb1rlv5upXEuUm1cKuFA83fMwXrR6g7cRh9cWFDULI=;
 b=QoyJUvtMKEANAnHb07Jv2j6njN8rcWw+SsuvstzB9VBXOmSxa7NVdLt04XjKjufEcEgg
 /O9fDAvojws2TA0NX5z7m74ppXNNVz4APkjYGcfCjol+5VPdGQ9e6zWhEjffhA2invakT
 2F6GzxAMru8OCViL87QX4gypTLGrzUfjps8Cbb5pNcHpYXjh/VzYTlx2kw0QUoBUwdIHz
 bDf+1+ZIWUUGxUKXQ3Sc/56tN4BIGOfgJa15KwW3/s0X2/5Fi4kensgUHvuMZOpFwJS9V
 CfJnLIrNz8+QjtHcMEkLknGlKkZa/bviVG1iy5vGu75sirDF6JwliQnWMlRQcS0eQvw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 144CD1F008A3;
 Sun,  8 Nov 2026 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794141154;
 bh=1tb1rlv5upXEuUm1cKuFA83fMwXrR6g7cRh9cWFDULI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=T5G6CuIBT6+ntKqlup4W1kXvlpF+U407taLldskgYYMcA8okVVCYhCjNEnVkZrEyJ
 WM+GZF8eX57ESdpx03brZezXKaN1DsTSmYfUfX1nCH8qIe6YN3aEpXl9jNP9bAT7vN
 qkp7Frhp5gObhPvtHra+iGz+sQyYeqoUio/J3qUf0gpUG+y6sWA2hWrhrknNhzuja/
 5DsJG2dT5pa6Zp0BuxRUZhVIoPJYFxM9EHf2DRIeOjG8ieyNe7mxY+gZPtpR/HmUkC
 ++i3sTHFSZm4C9E4anQmKIEXcN5EBbqSkVnR8liUG3/89r7NjHSlEdS8sQl4oPLck5
 iAfQlLH2lY7kA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8170747F79;
 Sun,  8 Nov 2026 12:32:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 08 Nov 2026 12:32:27 +0000
Subject: [PATCH v3 06/10] drm/panel: s6e3ha8: Assert reset GPIO in
 unprepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-crosshatch-panel-v3-6-87dd4ec4f7cc@ixit.cz>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
In-Reply-To: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=YoR8O/9CziH74UhYPjrFBAlu0YEV4HfID7khfmE7WHM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq8GvfEC5NRlkhJL4+HcK7VBEhx7z6sDuyw0I76
 DppDT7mhqGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCavBr3wAKCRBgAj/E00kg
 cjoDD/9J5mFkylqCbm65T/GFGtuzKg7d4xB5v+2mc+08FOvjJu5iwKFz9xcbIE+z/lOPY9UVXr+
 3fQPgIQsbNRr2AlfAKzdurdzikQrqYMWNKFD0nwYr5mfUPTcxH+6wwNP+2OHNgT66Gv0+yn9IVv
 uZVxm1wU8/1Nnuj+apUbt+1ujM1d01by8IQ0Ml7Gui4W1+x6FESeKMEFwVZE7z8nrVV/Df7UTin
 sX6khTTWJyAUEi0zf+aT9cgGt/Meqg+hPBoCqFdtkU4RQaWxKlj/usrTQKgKHlq8EATeKvL2z+1
 J2UpRG59L5KOq+9RmTiZLoxvPYgVbGMcUkjrPOClhX47Lsms+tBhCuagu2I8sF0RVqXfqHnt8Z3
 a+duinbh++ZG43mJVKK/TfJx3I4xKJ/Wc9a0ZzR0nlG4GL+GSpnCI3aCmXN+fQg1diqhmewf0E1
 pTi4JPpZvkg4W/OI0CjHrXzvKYbtYih0CyPm59bx5rdMls6ulJUl7Mud04s4cKRgvYsSeLgWjgf
 sWXZMl5N5aI90hQngHzFPYwBKewB+1xC8bahBrxYC7Q8G+UhvjBx3KmsatsIvR6AfVuc5FxmyPo
 zg5/4s3M/k2+7SwPDJVQcqeNOBm7EKpjpKS8G75mGkNFWg4SBWuQGkbCq8zly5UxOehgE6FW/Nx
 N5U5J0n8iTfGRdw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

For correct shutdown, the reset should be asserted.

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


