Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8AB606A337
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeUC84D7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672AC10E7DB;
	Sun,  8 Nov 2026 12:32:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8823110E7DB
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:32:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 596BA44D2C;
 Sun,  8 Nov 2026 12:32:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794141156;
 b=C40Vy58AVVuY6FQRH9OB97LUrO4Vbul+i6WOTM7erQI1VMP60X4nK8SDZnJVR7ipU7CX
 JRvMD6YDWILM47W6gVeF5kBMb1o2lMTomVgmz1E+4I9yvFRomlPOIXRIZ/jPSekAVjikJ
 QnIZYZD/ct+QRgo9K9X+9pztIkMzYFS7WdhHOMU01T+ur1UzK+A/vTYd/wrCJz+KOldao
 soqs0QgcidI74RMYfi66Es24POZm166DLD2VjO7zMLILWpGOIpfApf329D7kZ5Slmr4Z8
 SyBrbmemubBJ8Yo9AkiDMZ4nsNgjlvK/lCa/5w3f0ycWsfQ8jkygpZWUZWsXKmMfjbg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794141156;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=ZhAFgXtLTILBunJRERJ4GYfsQ5zP9NaqDvH7DIGzEms=;
 b=b3kaLPYRgzI7ps9W5V7defULzrDCeE6tcexzHUbnKtdEzO8YbaG7iE9aYWoYnf7xAkIi
 yK4fsHY/jwg9rNm2/xyZUyxIid9A1fc0huDWt04Y8hN1S+gJl5gE3bHtC5YZlnQZ+pSgK
 NkSzOHqzmqYScBqSpAKq/OQ5GdCfK0u8cZjeInUnwiZUtMGUWkd+WLDsvFUkH9HHfPAUU
 aXv5t+HEAikV8i0qnd1qgNG59YKJJo0YRq8p46hEpLjBpQaWes5qoT6D2ZvHKzaAltMmM
 dtKwdfOtA82wkdUTOgph2X0yxi+j+MGJuT5s+0tTdZF9wnspTPdjjMuPhtOcxvOq2EA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id AB1121F008BF;
 Sun,  8 Nov 2026 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794141156;
 bh=ZhAFgXtLTILBunJRERJ4GYfsQ5zP9NaqDvH7DIGzEms=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=jeUC84D7FI6c2FJro3xyf05UhWI7AMyoHR+jhovSWqd9Dse6fo2PZdYjo8v4ArYNo
 7MKOY7hMNuvB5nOuCJy70Jm4dHNwsAUOhzVlLtDm95rjevinV2rX0EMEvI1CFc4Ry/
 1tBdDewMRYEf2lsdrj8tDrcA2rqqQo8k5yOL3051ct3Tjpw5cvx1DVTqV5C7nhgwtx
 2yWdvgcoWuK43vZTLPZl4E+E7rSDID0cmAqj3LjS11782qV9VH/w2lj6kpfOQnT7hE
 B+R47T+l7sJivxrBZEI93oIHzd0DAZchjL1ioPpY0EdQUOG40ZCAmDeOYa9aXSf0uQ
 4IkARc4vzLP1w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A128847F81;
 Sun,  8 Nov 2026 12:32:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 08 Nov 2026 12:32:29 +0000
Subject: [PATCH v3 08/10] arm64: dts: qcom: sdm845-samsung-starqltechn:
 Update panel compatible
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-crosshatch-panel-v3-8-87dd4ec4f7cc@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=x6P5UdtWDbDVtREtjJhW7uE5AV7f8NAB6Gz3Qx7Wn2k=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq8GvfpE76WxZbbuHgYNw7/amRn5Y4xNwub3ONk
 18lfENrVPeJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCavBr3wAKCRBgAj/E00kg
 cnBDD/9ifPfx37wSDxdubEvukkufVdYXyzuaauRzzvEcZv1yQFKHdRZrQqGuF1X09cWyPHtsWUO
 u41NdafRPKWDSLTELibxJsxCWFe/Lejeue5VYYI2csrSz9Q5S3Dnr78Uu0RAviIk/1JZI9z6CEe
 iY6YkNTJuOYBK9QlshsJGBGwIJOVcWeotdxQd1rSMRhULuRVmsIcboe5o8iMKYSACaut8YyNu+m
 o674qI7xOG4QSNOlyp7+Mg0NBxeYAmontqBmifPYXBS+TP6yG5tsBBlr45ylEY2/mh2eWVP+Ywx
 QFXNmXTEUIcsxp5lPe1NZCMF7OskbTIMmpIweiZOVE5bBfh5VIqAIlgc7HME0gqFCoNaViYt5Bf
 oycUHwi1lCQ77vvhf9efczm0jrKvb+expyq6iPG//CuL6XWijIYlWW+GiufhziYW37gbmMOT0Nn
 qtL/2qWdYGRXBO1IBuERF8ANUvRrdPCDcsOeF9/9JMlnYK7tcHIdT3zsk2eqtM6YjmEbJI/iGXt
 Vri5VI3x34oETQBUMAy7ZiJ1buORYs5whZgZjueb1L+Qfkps88yUc2GH3JkrjMt4Ze/OCPcl9jT
 fsY20DNS715onNXcILRolqHixhluUA1iI4C7A7TjqRzUve6Ul11d3PxmKkWAg0US81AgQ9Y1F22
 8e2lTCeRXkxK62w==
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

Original compatible describing only the DDIC used, but omit describing
the panel used (Samsung AMB577PX01), which we have no way to detect.

New compatible allows without breaking ABI fixing the inverted reset.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index bd59f1dcd96dc..c156ed3733b4e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -262,23 +262,23 @@ &mdss {
 	status = "okay";
 };
 
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l26a_1p2>;
 	status = "okay";
 
 	panel@0 {
-		compatible = "samsung,s6e3ha8";
+		compatible = "samsung,s6e3ha8-amb577px01";
 		reg = <0>;
 		vci-supply = <&s2dos05_ldo4>;
 		vddr-supply = <&s2dos05_buck>;
 		vdd3-supply = <&s2dos05_ldo1>;
 		te-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&dsi_default &dsi_te>;
 		pinctrl-1 = <&dsi_suspend &dsi_te>;
 		pinctrl-names = "default", "suspend";
 
 		port {
 			panel_in: endpoint {
 				remote-endpoint = <&mdss_dsi0_out>;
 			};

-- 
2.55.0


