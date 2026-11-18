Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF9606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtKxG7XQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF60C112050;
	Wed, 18 Nov 2026 21:46:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA58112050
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D522D411E1;
 Wed, 18 Nov 2026 21:46:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795038373;
 b=xpR+nkbt8CO251WZpr3In+Zdmd0akzAF55lbOau2ccBBbAFrmIo1JOoxLBczBXrP6H0N
 f9ra42B+LjyoRVhGCZIRltAjG271vRyGW4V3cJITlC5A7dvuBTZm50iGah6dNkrFeCXCc
 kO54zb4Za31dE/q700w1wJaLH7SHMnqvbUlLgxpGJsN59gEzwwUfFyMrXb5WJrNG3RqQX
 gv0HwXz+d6QF6D37+U2+BUyfLLCLL6v06q7x4tbjCBJJy5vY4pHvwAB2Muh60GWgKJWPD
 q+5wZ7wLTyHyReENKKJqmhbSdco4GVPYZ+2q2J7+ej25suzE9ZIO0JzszIS8eTZyplw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795038373;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=UYCzXL6/0dZ8X2NJb8r8x4jhecKOjPKN/Z3O1wEqXoE=;
 b=2FKf9ff1fGD/raTZ7c1eZf9ILKpDMzXlWn13EidUsj1CsbJp7Nb6Ls4x6FGAqs06wp8r
 MshtoCfbeiVlvnHtOarinCTPOxMZDiYsrnDN5JG26Jl0xKQkU6HoIdXCOpbAkA08lbNbF
 Z0JrIiSy0ND5xB2OasqJq8OMASiJC5ca6+VdpfzJaN5rxAHeJFo8x1C/xA5iswPC/jIvw
 k+1nMgdLVD35sRcge+C2v4wIEpckedoqVXj42OLQR3C53Tp3OxQ4ra/Kethir71AbvAO7
 sLY9HrMYs92LN2/s8jIMTiLi4IO5VJgf9MM9xVhnmhkvzSNePjKiEMAa2LH9mpmyh8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 32B131F000C8;
 Wed, 18 Nov 2026 21:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795038373;
 bh=UYCzXL6/0dZ8X2NJb8r8x4jhecKOjPKN/Z3O1wEqXoE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=NtKxG7XQkvwn5unUUAqUMFIZbag8Nm/Qo1NW6RETai45wTTcEOneyZkVMLxnl1Dt/
 Z9US/8D/t+O3lJorxJTilg8N41LvOiJxeGprQ2O9udTEd8k1l9h0ZJ0aAkjNJV7rfk
 K/7keCUsVyM7gHla7KHhbKQW2dIoF499YeLNWANEvI9YzyYjvjTdjeOHzNiW2sE75z
 q2u/axNVC18cdCBe6XBkVUHkmJBmn/bqe2qcJjfAfdufTFNWT7tL55nEEF41nYsvWH
 dJ2Iv4bSin9u1Jv2EBZEyJ5PXje/l8if5MzmWgJO2Lll6qV/ryIccS3eR01kziI5oZ
 QdsupgDA7SdGw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B90724AFD9;
 Wed, 18 Nov 2026 21:46:11 +0000 (UTC)
From: Joachim Eastwood via B4 Relay
 <devnull+joachim.eastwood.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 22:45:31 +0100
Subject: [PATCH 4/4] arm64: dts: rockchip: enable hdmi sound on
 rk3588-h96-max-v58
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-dw-hdmi-qp-bridge_attach-v1-4-e370920bc7f3@gmail.com>
References: <20261118-dw-hdmi-qp-bridge_attach-v1-0-e370920bc7f3@gmail.com>
In-Reply-To: <20261118-dw-hdmi-qp-bridge_attach-v1-0-e370920bc7f3@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexey Charkov <alchark@gmail.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Joachim Eastwood <joachim.eastwood@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795038370; l=838;
 i=joachim.eastwood@gmail.com; s=20260701; h=from:subject:message-id;
 bh=Olvh2LZXh8fwddYqdBGYqLRZSxdXzrxttsogQiNz044=;
 b=+rBsl+l7IxeVv/QH09lai1TD/u5HoNCnxlTLKxgYu1V3vc3HHrgm7mebshsZbQVpZmgFuMJtE
 bOzsqqGuVLXBxOpqr3SQ/NERCfJSzRqjNasrbGxdvb4yJFOU/7PH+ZL
X-Developer-Key: i=joachim.eastwood@gmail.com; a=ed25519;
 pk=ZN/8xWtdYaSd5oEfloYSZ1a+/ri0n0VZqjlEeHlbXFU=
X-Endpoint-Received: by B4 Relay for joachim.eastwood@gmail.com/20260701
 with auth_id=846
X-Original-From: Joachim Eastwood <joachim.eastwood@gmail.com>
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
Reply-To: joachim.eastwood@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joachim Eastwood <joachim.eastwood@gmail.com>

Enable hdmi0_sound and i2s5_8ch to get sound over HDMI.

Signed-off-by: Joachim Eastwood <joachim.eastwood@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts b/arch/arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts
index da6282c105255..5dd3f71932ec1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts
@@ -239,6 +239,10 @@ hdmi0_out_con: endpoint {
 	};
 };
 
+&hdmi0_sound {
+	status = "okay";
+};
+
 &hdptxphy0 {
 	status = "okay";
 };
@@ -299,6 +303,10 @@ hym8563: rtc@51 {
 	};
 };
 
+&i2s5_8ch {
+	status = "okay";
+};
+
 &gmac1 {
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy1>;

-- 
2.56.0


